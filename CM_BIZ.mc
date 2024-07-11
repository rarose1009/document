/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card CM_BIZ
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
//	#define USE_ON_SELECT
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_WRITE )
		DEF_BUTTON_ID ( BID_WRITE2 )
		DEF_BUTTON_ID ( BID_WRITE3 )
		DEF_BUTTON_ID ( BID_PHOTO )
		DEF_BUTTON_ID ( BID_VIEW )
		DEF_BUTTON_ID ( BID_PHOTOVIEW )		//JPEG �� ȭ�鿡 ����
		DEF_BUTTON_ID ( BID_SND )
		DEF_BUTTON_ID ( BID_CLOSE )		
//��������
		DEF_BUTTON_ID ( BID_LARGEPHOTO )	
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_OK2 )

		//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
		
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
	
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )
		DEF_OBJECT_ID ( EDT_DATA8 )
		DEF_OBJECT_ID ( EDT_DATA9 )
		DEF_OBJECT_ID ( EDT_DATA10 )
		
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	   1
	#define INIT_PHOTOVIEW 2
	
	//PNG ���� Ȯ�� ũ��
	#define PNG_CONVERT_WD DMS_X(900)
	#define PNG_CONVERT_HT DMS_Y(450)

	long m_bFirst;
	long m_lActiveIndex = -1;
	long m_lPhotoFlag = 0;		//m_lPhotoFlag = 0 ���� ����, m_lPhotoFlag = 1 ���� ����
	long m_lDataFlag = 0;		// = 0 ȭ�� ó�� ȣ�� �� �⺻ ������ ���� , = 1 �⺻ ������ ���� ȣ�� X >> �⺻������ : SetStruct()
	long m_lExistFlag = 0;		// = 0 jpg to png ȣ�� x , = 1 jpg to png ȣ�� 
	
	void* m_pImgBiz;
	void* m_pImgViewPng;
	
	char m_szfilenm[128];
	char m_szScrPht[256];
	char m_szPngPath[256];
	char m_szJpegPath[256];
	char m_szPngPath_View[256];		//Ȯ�� ���� png ���� �н�
	char m_szTmp[500];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void SetStruct(void);			//�⺻ �ҷ����� ���� ����
	void SetJsonStruct(void);
	void ReDraw(void);
	void Shoto_Photo(void);
	void Photo_View(void);
	void JpgToPng(void);		
	void PhotoDraw(void);
	
	long Rcv_Usecontnum(void);
	long TR242521(void);
	long Set_Usecontnum(long nservicenum);
	
	long Snd_Biz(void);
	long TR24252(void);
	long Validate(void);
	
	void Snd_Photo(void);
	long TR242522(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����ڵ���� ���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON( STARTX,      STARTY+825, 333, 74, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�����Կ�"),
		DLG_BUTTON( STARTX+333,  STARTY+825, 333, 74, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW, "��������"),
		DLG_BUTTON( STARTX+666,  STARTY+825, 334, 74, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SND, "����"),

		DLG_TEXT( STARTX,      STARTY-29, 300, 64, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�޴�����ȣ"),
		DLG_EDIT(STARTX+300,   STARTY-29, 190, 64, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_TEXT( STARTX+490,  STARTY-29,  50, 64, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, "-"),
		DLG_EDIT(STARTX+540,   STARTY-29, 200, 64, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_TEXT( STARTX+740,  STARTY-29,  50, 64, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, "-"),
		DLG_EDIT(STARTX+790,   STARTY-29, 210, 64, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		
		DLG_TEXT( STARTX,      STARTY+35, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "��ȭ��ȣ"),
		DLG_EDIT(STARTX+300,   STARTY+35, 190, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT( STARTX+490,  STARTY+35,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+540,   STARTY+35, 200, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_TEXT( STARTX+740,  STARTY+35,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "-"),
		DLG_EDIT(STARTX+790,   STARTY+35, 210, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		
		DLG_TEXT( STARTX,         STARTY+95, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "�̸����ּ�"),
		//DLG_EDIT(STARTX+295,    STARTY+95, 320, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 30,  ""),
		DLG_BUTTON( STARTX+300,   STARTY+95, 320, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE2,  ""),
		DLG_TEXT(STARTX+300,	  STARTY+95, 320, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, ""),
		//DLG_TEXT(STARTX+615,    STARTY+95, 60, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "@"),
		//DLG_EDIT(STARTX+675,    STARTY+95, 318, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 30,  ""),
		DLG_COMBO_DWE (STARTX+620,STARTY+95, 380, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
		DLG_BUTTON( STARTX+620,   STARTY+95, 260, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE3,  ""),

		DLG_TEXT( STARTX,         STARTY+155, 300, 370, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��Ÿ"),
		DLG_BUTTON( STARTX+300,   STARTY+155, 700, 370, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT(STARTX+300,      STARTY+155, 700, 370, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, ""),

		DLG_TEXT( STARTX,         STARTY+525, 300, 300, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "��������"),
		//DLG_TEXT( STARTX+295, STARTY+455, 698, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_BUTTON( STARTX+300,   STARTY+525, 700, 300, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PHOTOVIEW,  ""),
	};	


	// PDA ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, ""),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON( STARTX,      STARTY+825, 333, 74, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�����Կ�"),
		DLG_BUTTON( STARTX+333,  STARTY+825, 333, 74, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW, "��������"),
		DLG_BUTTON( STARTX+666,  STARTY+825, 334, 74, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SND, "����"),

		DLG_TEXT( STARTX,      STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�޴�����ȣ"),
		DLG_EDIT(STARTX+300,   STARTY-40, 190, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_TEXT( STARTX+490,  STARTY-40,  50, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, "-"),
		DLG_EDIT(STARTX+540,   STARTY-40, 200, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_TEXT( STARTX+740,  STARTY-40,  50, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, "-"),
		DLG_EDIT(STARTX+790,   STARTY-40, 210, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		
		DLG_TEXT( STARTX,      STARTY+30, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "��ȭ��ȣ"),
		DLG_EDIT(STARTX+300,   STARTY+30, 190, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT( STARTX+490,  STARTY+30,  50, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+540,   STARTY+30, 200, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_TEXT( STARTX+740,  STARTY+30,  50, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "-"),
		DLG_EDIT(STARTX+790,   STARTY+30, 210, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		
		DLG_TEXT( STARTX,         STARTY+95, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "�̸����ּ�"),
		DLG_EDIT(STARTX+300,      STARTY+95, 320, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 50,  ""),
		DLG_COMBO_DWE (STARTX+620,STARTY+95, 380, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),

		DLG_TEXT( STARTX,         STARTY+155, 300, 370, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��Ÿ"),
		DLG_EDIT(STARTX+300,      STARTY+155, 700, 670, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 500,  ""),

		//DLG_TEXT( STARTX,         STARTY+525, 300, 300, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "��������"),
		//DLG_TEXT( STARTX+295, STARTY+455, 698, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		//DLG_BUTTON( STARTX+300,   STARTY+525, 700, 300, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PHOTOVIEW,  ""),
	};	


	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_View[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
		
		DLG_BUTTON( STARTX+45,   STARTY, 900, 500, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_LARGEPHOTO,  ""),
		
		DLG_BUTTON( STARTX+645,   STARTY+520, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "�ݱ�"),
	};	


	// PDA ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_View_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON( STARTX+45,   STARTY, 900, 500, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_LARGEPHOTO,  ""),
		
		DLG_BUTTON( STARTX+645,   STARTY+520, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "�ݱ�"),
	};	
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void	OnInit(char bFirst)
	{
	long lCnt;	

		m_bFirst = bFirst;

		switch (bFirst)
		{
			case INIT_MAIN:
				
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
						break;		
				}
				SetBtnImg();
				SetStyle();
				
				if( m_lDataFlag == 0 )
				{
					m_lDataFlag = 1;
					SetStruct();
				}
				ReDraw();
				break;
			case INIT_PHOTOVIEW:
				
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_View_P, SIZEOF(DlgRes_View_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_View, SIZEOF(DlgRes_View));
						break;		
				}
				SetBtnImg();

				ON_DRAW();
				MessageBoxEx(MESSAGE, "������ Ȯ�����Դϴ�.");

				JpgToPng();
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_LARGEPHOTO), FALSE );
				ON_DRAW();
				break;
		}
		
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;
			case BID_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA8), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)) );
				break;
			case BID_WRITE3:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(CMB_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
				break;
			case BID_PHOTO:
				Shoto_Photo();
				break;
			case BID_VIEW:
			case BID_PHOTOVIEW:
				if( m_lPhotoFlag == 1 )
				{
					//�̸� ũ�� ���� �� ���̾�α� ȣ��
					ConvertImage(JPG, m_szJpegPath, PNG_CONVERT_WD, PNG_CONVERT_HT, m_szJpegPath, 60*1000);
					//VmSleep(100);
					SetJsonStruct();
					ON_EXIT();
					OnInit(INIT_PHOTOVIEW);
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "������ �Կ����ּ���.");
				}
				break;
			case BID_SND:
				if( Validate() > 0 )
				{
					Snd_Biz();
				}
				break;
			case GID_HOME:
				break;
			case GID_MENU:
				break;
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
			case GID_SCREEN:
				g_MOVE_DLG(400);
				break;
			case GID_CMMNWK:
				break;				
			case GID_PREV:
				break;	
			case GID_VMEXIT:
				break;
			case BID_CLOSE:
				g_DirFS_Clear(PHOTO_BIZ, "*.jjp");
				g_DirFS_Clear(PHOTO_BIZ, "*.jpg");
				g_DirFS_Clear(PHOTO_BIZ, "*.png");

				if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
				{				
					Card_Move("C6101_LST");
				}
				else
				{			
					Card_Prev();
				}
				break;
			case BID_OK:
			case BID_OK2:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
		}
	}
	
	
//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		//���ڸ� �Է� ����
		if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex  )
		{
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
				return;
			}
		}
	}
	
//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+490) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+35)  ||
				    X > DMS_X(STARTX+540) && X < DMS_X(STARTX+740) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+35)  ||
				    X > DMS_X(STARTX+790) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+35)  ||
				    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+490) && Y > DMS_Y(STARTY+35) && Y < DMS_Y(STARTY+95)  ||
				    X > DMS_X(STARTX+540) && X < DMS_X(STARTX+740) && Y > DMS_Y(STARTY+35) && Y < DMS_Y(STARTY+95)  ||
				    X > DMS_X(STARTX+790) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+35) && Y < DMS_Y(STARTY+95)   )
				{
					m_lActiveIndex = lActiveIndex;
				
					if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex  )	
					{
						g_Dlgflag = 1;
						g_MOVE_DLG(1);
					
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else
				{
					g_Dlgflag = 1;
					g_MOVE_DLG(1);
				
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
				ON_DRAW();
			}
		}
	}

	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		long sX[8], eX[8];
		long lenX;
		long i;
		long TABCNT;
		long starty, highty;
	
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_PHOTOVIEW )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
		}
	}

//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			///EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			//EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_DATA1), TRUE, 2, EDITSEP_NONE );
			
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10140' ", CMB_DATA1+2);
		}
		
		return;
	}

//------------------------------------------------------------------
//���� �⺻���� ����
	void SetStruct(void)
	{
		char szfilenm[128];
		char szfilepath[256];
		long i = 0;

		Mem_Set((byte*)&stBiz, 0x00, sizeof(stBiz));

		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			//������ȣ
			Str_Cpy(stBiz.szUse_Cont_Num, stGm.USE_CONT_NUM);
			//�޴�����ȣ
			Str_Cpy(stBiz.szCp_Ddd, stGm.CP_DDD);
			Str_Cpy(stBiz.szCp_Exn, stGm.CP_EXN);
			Str_Cpy(stBiz.szCp_Num, stGm.CP_NUM);
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, stGm.OWNHOUSE_TEL_DDD);
			Str_Cpy(stBiz.szTel_Exn, stGm.OWNHOUSE_TEL_EXN);
			Str_Cpy(stBiz.szTel_Num, stGm.OWNHOUSE_TEL_NUM);
			
			//��������
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "U");
			Str_Cat(szfilenm, stGm.USE_CONT_NUM);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)szfilepath, 0x00, sizeof(szfilepath));
			SPRINT (szfilepath, "%s/%s",PHOTO_BIZ, szfilenm, 0);
			if(FFS_Exist(szfilepath) > 0)
			{
				Str_Cpy(stBiz.szPhoto, "Y");
			}
			else
			{
				Str_Cpy(stBiz.szPhoto, "N");
			}
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
		{
			//������ȣ
			Str_Cpy(stBiz.szUse_Cont_Num, stSc.USE_CONT_NUM);
			//�޴�����ȣ
			Str_Cpy(stBiz.szCp_Ddd, stSc.CP_DDD);
			Str_Cpy(stBiz.szCp_Exn, stSc.CP_EXN);
			Str_Cpy(stBiz.szCp_Num, stSc.CP_NUM);
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, stSc.OWNHOUSE_TEL_DDD);
			Str_Cpy(stBiz.szTel_Exn, stSc.OWNHOUSE_TEL_EXN);
			Str_Cpy(stBiz.szTel_Num, stSc.OWNHOUSE_TEL_NUM);
			
			//��������
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "U");
			Str_Cat(szfilenm, stSc.USE_CONT_NUM);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)szfilepath, 0x00, sizeof(szfilepath));
			SPRINT (szfilepath, "%s/%s",PHOTO_BIZ, szfilenm, 0);
			if(FFS_Exist(szfilepath) > 0)
			{
				Str_Cpy(stBiz.szPhoto, "Y");
			}
			else
			{
				Str_Cpy(stBiz.szPhoto, "N");
			}
		}
		else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			//������ȣ
			Str_Cpy(stBiz.szUse_Cont_Num, g_szUSE_CONT_NUM);
			//�޴�����ȣ
			Str_Cpy(stBiz.szCp_Ddd, stMw.szCp_ddd);
			Str_Cpy(stBiz.szCp_Exn, stMw.szCp_exn);
			Str_Cpy(stBiz.szCp_Num, stMw.szCp_num);
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, stMw.szOwnhouse_tel_ddd);
			Str_Cpy(stBiz.szTel_Exn, stMw.szOwnhouse_tel_exn);
			Str_Cpy(stBiz.szTel_Num, stMw.szOwnhouse_tel_num);
			
			//��������
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "U");
			Str_Cat(szfilenm, g_szUSE_CONT_NUM);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)szfilepath, 0x00, sizeof(szfilepath));
			SPRINT (szfilepath, "%s/%s",PHOTO_BIZ, szfilenm, 0);
			if(FFS_Exist(szfilepath) > 0)
			{
				Str_Cpy(stBiz.szPhoto, "Y");
			}
			else
			{
				Str_Cpy(stBiz.szPhoto, "N");
			}
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			//������ȣ
			Str_Cpy(stBiz.szUse_Cont_Num, stMtrChg.USE_CONT_NUM);
			//�޴�����ȣ
			Str_Cpy(stBiz.szCp_Ddd, stMtrChg.CP_DDD);
			Str_Cpy(stBiz.szCp_Exn, stMtrChg.CP_EXN);
			Str_Cpy(stBiz.szCp_Num, stMtrChg.CP_NUM);
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, stMtrChg.OWNHOUSE_TEL_DDD);
			Str_Cpy(stBiz.szTel_Exn, stMtrChg.OWNHOUSE_TEL_EXN);
			Str_Cpy(stBiz.szTel_Num, stMtrChg.OWNHOUSE_TEL_NUM);
			
			//��������
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "U");
			Str_Cat(szfilenm, stMtrChg.USE_CONT_NUM);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)szfilepath, 0x00, sizeof(szfilepath));
			SPRINT (szfilepath, "%s/%s",PHOTO_BIZ, szfilenm, 0);
			if(FFS_Exist(szfilepath) > 0)
			{
				Str_Cpy(stBiz.szPhoto, "Y");
			}
			else
			{
				Str_Cpy(stBiz.szPhoto, "N");
			}
		}

		return;
	}

/*
//����ڵ����
typedef struct BIZ
{
	char szUse_Cont_Num    [20 +1];
	char szInstPlaceNum    [20 +1];
	char szCust_Nm         [50 +1];
	char szTel_Ddd         [5  +1];
	char szTel_Exn         [5  +1];
	char szTel_Num         [5  +1];
	char szCp_Ddd          [5  +1];
	char szCp_Exn          [5  +1];
	char szCp_Num          [5  +1];
	char szEmail           [100+1];
	char Biz_Regi_Num      [20 +1];
	char szFirm_Nm         [50 +1];
	char szPhoto           [256+1];
	char szRmk             [300+1];
	char szBranch_Cd       [10 +1];
	char szCenter_Cd       [10 +1];

}	BIZ;

global BIZ stBiz;
*/
//------------------------------------------------------------------
//�۽� ������ ����
	void SetJsonStruct(void)
	{
		char szTmp[300];
	
		Mem_Set((byte*)&stBiz, 0x00, sizeof(stBiz));
		
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			//������ȣ
			Str_Cpy(stBiz.szUse_Cont_Num, stGm.USE_CONT_NUM);
			
			//�޴���
			Str_Cpy(stBiz.szCp_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stBiz.szCp_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cpy(stBiz.szCp_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA4)));
			
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA5)));
			Str_Cpy(stBiz.szTel_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA6)));
			Str_Cpy(stBiz.szTel_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA7)));
			
			//�̸���
			Str_Cpy(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA8)));
			Str_Cat(stBiz.szEmail, "@");
			Str_Cat(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)));
			
			//��Ÿ
			Str_Cpy(stBiz.szRmk, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
			
			//branch_cd
			g_Sql_RetStr( "SELECT PARAM4 FROM RCV_LOG WHERE GUBUN = '1'", 30, stBiz.szBranch_Cd );
			
			//center_cd
			g_Sql_RetStr( "SELECT PARAM5 FROM RCV_LOG WHERE GUBUN = '1'", 30, stBiz.szCenter_Cd );
			
			//�ڷ������� , �ڵ����(10 : ����, 20 : ����, 30 : ��ħ, 40 : �跮�ⱳü)
			Str_Cpy(stBiz.szData_Col_Type, "30");
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
		{
			//������ȣ
			Str_Cpy(stBiz.szUse_Cont_Num, stSc.USE_CONT_NUM);
			
			//�޴���
			Str_Cpy(stBiz.szCp_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stBiz.szCp_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cpy(stBiz.szCp_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA4)));
			
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA5)));
			Str_Cpy(stBiz.szTel_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA6)));
			Str_Cpy(stBiz.szTel_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA7)));
			
			//�̸���
			Str_Cpy(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA8)));
			Str_Cat(stBiz.szEmail, "@");
			Str_Cat(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)));
			
			//��Ÿ
			Str_Cpy(stBiz.szRmk, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
			
			//branch_cd
			Str_Cpy(stBiz.szBranch_Cd, stUserinfo.szbranch_cd);
			//center_cd
			Str_Cpy(stBiz.szCenter_Cd, stUserinfo.szcenter_cd);
			
			//�ڷ������� , �ڵ����(10 : ����, 20 : ����, 30 : ��ħ, 40 : �跮�ⱳü)
			Str_Cpy(stBiz.szData_Col_Type, "20");
		}
		else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			Str_Cpy(stBiz.szUse_Cont_Num, g_szUSE_CONT_NUM);
			//�޴���
			Str_Cpy(stBiz.szCp_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stBiz.szCp_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cpy(stBiz.szCp_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA4)));
			
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA5)));
			Str_Cpy(stBiz.szTel_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA6)));
			Str_Cpy(stBiz.szTel_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA7)));
			
			//�̸���
			Str_Cpy(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA8)));
			Str_Cat(stBiz.szEmail, "@");
			Str_Cat(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)));
			
			//����
			
			//��Ÿ
			Str_Cpy(stBiz.szRmk, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
			
			Str_Cpy(stBiz.szBranch_Cd, stUserinfo.szbranch_cd);
			Str_Cpy(stBiz.szCenter_Cd, stUserinfo.szcenter_cd);
			Str_Cpy(stBiz.szData_Col_Type, "10");
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			Str_Cpy(stBiz.szUse_Cont_Num, stMtrChg.USE_CONT_NUM);
			//�޴���
			Str_Cpy(stBiz.szCp_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stBiz.szCp_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cpy(stBiz.szCp_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA4)));
			
			//��ȭ��ȣ
			Str_Cpy(stBiz.szTel_Ddd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA5)));
			Str_Cpy(stBiz.szTel_Exn, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA6)));
			Str_Cpy(stBiz.szTel_Num, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA7)));
			
			//�̸���
			Str_Cpy(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA8)));
			Str_Cat(stBiz.szEmail, "@");
			Str_Cat(stBiz.szEmail, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)));
			
			//����
			
			//��Ÿ
			Str_Cpy(stBiz.szRmk, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
			
			Str_Cpy(stBiz.szBranch_Cd, stUserinfo.szbranch_cd);
			Str_Cpy(stBiz.szCenter_Cd, stUserinfo.szcenter_cd);
			
			//�ڷ������� , �ڵ����(10 : ����, 20 : ����, 30 : ��ħ, 40 : �跮�ⱳü)
			Str_Cpy(stBiz.szData_Col_Type, "40");
		}
		
		return;
	}
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		long i = 0, k = 0;
		long lTotLen = 0;
		long lIdLen = 0;
		char szEmailId[50];
		char szEmailAddr[50];
		
		//�޴���
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), stBiz.szCp_Ddd );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), stBiz.szCp_Exn );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), stBiz.szCp_Num );
				
		//��ȭ��ȣ
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), stBiz.szTel_Ddd );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), stBiz.szTel_Exn );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA7), stBiz.szTel_Num );
		
		//�̸���
		Mem_Set((byte*)szEmailId, 0x00, sizeof(szEmailId));
		Mem_Set((byte*)szEmailAddr, 0x00, sizeof(szEmailAddr));
		lTotLen = Str_Len(stBiz.szEmail);
		if( lTotLen > 0 )
		{
			for( i=0 ; lTotLen ; i++)
			{
				if(stBiz.szEmail[i] == '@')
				{
					lIdLen = i;
					break;
				}
				else if(stBiz.szEmail[i] == '')
				{
					k++;
					break;
				}
			}

			Mem_Cpy((byte *)szEmailId, (byte *)stBiz.szEmail, lIdLen);
			if( k == 0 )
			{
				Mem_Cpy((byte *)szEmailAddr, (byte *)stBiz.szEmail+(lIdLen+1), lTotLen-(lIdLen+1));
			}
		}
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA8), szEmailId);
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), szEmailAddr);
		
		//��Ÿ
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), stBiz.szRmk);
		
		PhotoDraw();
		
		return;
	}
	
//----------------------------------------------------------------------------------------------
	void PhotoDraw(void)
	{
		char szfilenm[128];
		char szPhotopath[256];

		//PNG ���ϸ�
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stGm.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stSc.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, g_szUSE_CONT_NUM);
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stMtrChg.USE_CONT_NUM);
		}
		
		Str_Cpy(szfilenm, m_szfilenm);
		Str_Cat(szfilenm, ".png");

		//JPEG�� PNG�� ��ȯ ���ϸ�
		Mem_Set((byte*)m_szPngPath, 0x00, sizeof(m_szPngPath));
		SPRINT (m_szPngPath, "%s/%s",PHOTO_BIZ, szfilenm, 0);

		//m_lPhotoFlag = 0 ���� ����, m_lPhotoFlag = 1 ���� ����
		if( FFS_Exist(m_szPngPath) )
		{
			m_lPhotoFlag = 1;
			Str_Cpy(stBiz.szPhoto, "Y");
			m_pImgBiz    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  m_szPngPath );
			
			ButCtrl_SetImage( Get_hDlgCtrlByID(BID_PHOTOVIEW),  m_pImgBiz);
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11),   "Y");
			//EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA11), BLUE);
		}
		else
		{
			m_lPhotoFlag = 0;
			Str_Cpy(stBiz.szPhoto, "N");
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11),   "N");
			//EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA11), RED);
		}
		
		ON_DRAW();
	}

//----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
/*	
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				if( FFS_Exist(szfilenm)  )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h�� ���ǵǾ�����
					ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
					//ConvertImage(JPG, szfilenm, 240, 320, g_szphoto, 60*1000);

					ON_DRAW();
					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
					
					//VmSleep(100);
					FFS_Delete( szfilenm );

					JpgToPng();
				}
			}
		}
*/
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		
//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);
		CloseMessageBox();
		
		if( nEvent == TASK_SYS_CALL )
		{
			if( m_bFirst == INIT_MAIN && nData == TASK_CAMERA )
			{
				Mem_Set((byte*)szPhotopath, 0x00, sizeof(szPhotopath));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				szPath = (char*)System_GetResult((char*)&nRet);
				nLen = Str_Len(szPath);
				if( nLen > 19 )
				{
					Mem_Cpy((byte *)szTmp, (byte *)szPath+19, nLen-19);
					Str_Cpy(szPhotopath, "..");
					Str_Cat(szPhotopath, szTmp);
					PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
				//	Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
				//	if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
				//	{
				//		Str_Cpy(m_szfilenm, "U");
				//		Str_Cat(m_szfilenm, stGm.USE_CONT_NUM);
				//	}
				//	else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
				//	{
				//		Str_Cpy(m_szfilenm, "U");
				//		Str_Cat(m_szfilenm, stSc.USE_CONT_NUM);
				//	}
				//	else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
				//	{
				//		Str_Cpy(m_szfilenm, "U");
				//		Str_Cat(m_szfilenm, g_szUSE_CONT_NUM);
				//	}
				//	else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
				//	{
				//		Str_Cpy(m_szfilenm, "U");
				//		Str_Cat(m_szfilenm, stMtrChg.USE_CONT_NUM);
				//	}				
				//	Str_Cat(m_szfilenm, ".jjp");
					
					//�������� +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_BIZ,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h�� ���ǵǾ�����
					//ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
					//ConvertImage(JPG, szfilenm, 240, 320, g_szphoto, 60*1000);
					
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					ON_DRAW();
					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
					
					//VmSleep(100);
					//FFS_Delete( szfilenm );

					JpgToPng();
				}
			}
			else if( m_bFirst == INIT_MAIN && nData == 1 )
			{
				//JPEG -> PNG ��ȯ ��, ȭ�鿡 ���� Draw
				PhotoDraw();
			}
			else if( m_bFirst == INIT_PHOTOVIEW )
			{
				//���� Ȯ�� ����
				Photo_View();
			}
		}

		ON_DRAW();
		return;
	}

	
//----------------------------------------------------------------------------------------------
//U+������ȣ+D+�������+S+�Ϸù�ȣ.jpg
//�Ϸù�ȣ -> "������ȣ+������� �ߺ� ������ SEQ�Ϸù�ȣ�� ������, SEQ �Ϸù�ȣ 0���� PADDINGó���Ͽ� ��� ex) 001, 002, 003��"
//ex) U6001012345D20170329S001.jpg 
	void Shoto_Photo(void)
	{
		char *pCamera;
		char szDate[20];
		long nRet;
		handle h = NULL;
		handle hdata = NULL;

		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Str_ItoA(Time_GetDate(), szDate, 10);
		Str_Chg(szDate, STRCHG_DEL_NONDIGIT);

		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stGm.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stSc.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, g_szUSE_CONT_NUM);
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stMtrChg.USE_CONT_NUM);
		}
		
		//���� ���ϸ� ����
		Str_Cat(m_szfilenm, ".jjp");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_BIZ,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//��������
			//Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_BIZ,  m_szfilenm, 0);
			//���Ŀ��� Ȯ�ν�...
			//Str_Cpy(szScrPht, szfilenm);
			//ShootPhoto ( 1, 0, m_szfilenm );

			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				//2017-08-18 Sanghyun Lee
				//ī�޶� ȭ�� ����(photo_quality)	
				//"MEDIA_QUALITY_AUTO" ->> ���� �߻�, �ʿ�X
				//"MEDIA_QUALITY_LOWEST"
				//"MEDIA_QUALITY_LOW" ->> ���õǴ� ȭ���� ���� , �ʿ�X
				//"MEDIA_QUALITY_MEDIUM" ->> ���� ������ι���
				//"MEDIA_QUALITY_HIGH"
				//"MEDIA_QUALITY_HIGHEST"
				JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_HIGH");

				//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
				JSON_SetValue	(hdata	, 'C', "position_info"		, " ");
				JSON_SetValue	(h		, 'C', "method"				, "CameraActivity");
				
				JSON_Attach 	(h		, "data"					, hdata);
			
				System_Call		("Native_System_Call" , JSON_toString(h));
			}
			
			Finally:
		
			if (h)
			{
				JSON_Finalize(h);
			}	
		
			if (hdata)
			{
				JSON_Finalize(hdata);
			}	
		}
		
		return;
	}


//----------------------------------------------------------------------------------------------
//U+������ȣ+D+�������+S+�Ϸù�ȣ.jpg
//�Ϸù�ȣ -> "������ȣ+������� �ߺ� ������ SEQ�Ϸù�ȣ�� ������, SEQ �Ϸù�ȣ 0���� PADDINGó���Ͽ� ��� ex) 001, 002, 003��"
//ex) U6001012345D20170329S001.jpg 
/*
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
			JSON_SetValue	(hdata	, 'C', "position_info"		, " ");
			JSON_SetValue	(h		, 'C', "method"				, "CameraActivity");
			
			JSON_Attach 	(h		, "data"					, hdata);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hdata)
		{
			JSON_Finalize(hdata);
		}	
	}
*/

//------------------------------------------------------------------
	long Rcv_Usecontnum(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 242521, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  stBiz.szInstPlaceNum );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR242521; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR242521_IN",  "FR242521" , sndbuf, sztmp );
		return 0 ;
	}
	


//------------------------------------------------------------------
	long TR242521(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(242521) >= 0)
		{
			Set_Usecontnum(242521);
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

//------------------------------------------------------------------
	long Set_Usecontnum(long nservicenum)
	{
	char szJsonpath[500];
	char szMsg[500];
	char szCol[128];
	char szDate[50];
	long *nCol;
	long nCnt = 0;
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		//MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
			  char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				ON_DRAW();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								//������ȣ
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) stBiz.szUse_Cont_Num, 0x00, sizeof( stBiz.szUse_Cont_Num) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "use_cont_num", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(stBiz.szUse_Cont_Num, szCol);
							}

							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
			}
		}
		else
		{
			ret = 0;
		}
		
Finally:		
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}


//------------------------------------------------------------------
	long Snd_Biz(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24252, FALSE);

		//JSON ������ ����
		SetJsonStruct();

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",             stBiz.szUse_Cont_Num);
		JSON_SetValue( g_pjcomm, 'C', "repre_tel_ddd",            stBiz.szTel_Ddd);
		JSON_SetValue( g_pjcomm, 'C', "repre_tel_exn",            stBiz.szTel_Exn);
		JSON_SetValue( g_pjcomm, 'C', "repre_tel_num",            stBiz.szTel_Num);
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",                   stBiz.szCp_Ddd);
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",                   stBiz.szCp_Exn);
		JSON_SetValue( g_pjcomm, 'C', "cp_num",                   stBiz.szCp_Num);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stBiz.szEmail );
		JSON_SetValue( g_pjcomm, 'C', "email",                    szTmp);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stBiz.szRmk );
		JSON_SetValue( g_pjcomm, 'C', "rmk",                      szTmp);
		
		JSON_SetValue( g_pjcomm, 'C', "branch_cd",                stBiz.szBranch_Cd);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",                stBiz.szCenter_Cd);
		JSON_SetValue( g_pjcomm, 'C', "data_col_type",            stBiz.szData_Col_Type);

		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR24252; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR24252_IN",  "FR24252" , sndbuf, szbuf );
		return 1;
	}
	
//------------------------------------------------------------------
	long TR24252(void)
	{
		char szSql[350];
	
		if(g_Chk_Json(24252) >= 0)
		{
			Snd_Photo();
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
//------------------------------------------------------------------------------------------
	void Snd_Photo(void)
	{
		char szTmp[50];
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_BIZ );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);

		if(nRet > 0)
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 242522, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+11, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num", szdata );

			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );			
//PRINT("m_szScrPht : %s ",m_szScrPht,0,0);

			free((byte*)filedata);
			sndbuf = JSON_toString(g_pjcomm);
			
			g_Save_JsonFile(sndbuf);
			
			callBackfunc = TR242522; //��ſϷ� �Ŀ� ȣ�� �Լ�
			HTTP_DownloadData  ( szUrl, "FR242522_IN",  "FR242522" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			//( "UPDATE C6301_CHANGEDATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S'" );
			//�������� ����
			//FFS_Delete(m_szScrPht);		//jjp ���� ����
			//FFS_Delete(m_szPngPath);		//png ���� ����
			//FFS_Delete(m_szJpegPath);		//jpg ���� ����
			g_DirFS_Clear(PHOTO_BIZ, "*.jjp");
			g_DirFS_Clear(PHOTO_BIZ, "*.jpg");
			g_DirFS_Clear(PHOTO_BIZ, "*.png");
			
			g_Sock_Close();
			
			MessageBoxEx (CONFIRM_OK, "�����Ͽ����ϴ�.");
			
			if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
			{				
				Card_Move("C6101_LST");
			}
			else
			{			
				Card_Prev();
			}
		}
		
		return;
	}

//------------------------------------------------------------------------------------------
	long TR242522(void)
	{
		long lRet;
		char szTmp[30];
		char szDirPath[200];

		if(g_Chk_Json( 242522 ) >= 0)
		{
			FFS_Delete(m_szScrPht);			//jjp ���� ����
			FFS_Delete(m_szPngPath);		//png ���� ����
			FFS_Delete(m_szJpegPath);		//jpg ���� ����

			Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
			Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
			Str_Cpy(szDirPath, PHOTO_BIZ );
			lRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
			if(lRet > 0)
			{
				Snd_Photo();
				return 1;
			}
			else
			{
				//g_Sql_DirectExecute( "UPDATE C6301_CHANGEDATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S'" );
				//�������� ����
				//FFS_Delete(m_szScrPht);		//jjp ���� ����
				//FFS_Delete(m_szPngPath);		//png ���� ����
				//FFS_Delete(m_szJpegPath);		//jpg ���� ����
				g_DirFS_Clear(PHOTO_BIZ, "*.jjp");
				g_DirFS_Clear(PHOTO_BIZ, "*.jpg");
				g_DirFS_Clear(PHOTO_BIZ, "*.png");
				
				g_Sock_Close();
				
				MessageBoxEx (CONFIRM_OK, "�����Ͽ����ϴ�.");
				if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
				{				
					Card_Move("C6101_LST");
				}
				else
				{			
					Card_Prev();
				}
				return 1;
			}
		}
		else
		{
			g_Sock_Close();
		
			CloseMessageBox();
			return -1;
		}
	}
	
	
//------------------------------------------------------------------------------------------
	void fsgetitem(char* szSource, char* szTarget, int id, int len )
	{
	int i;
	int idx;
	int ids;
	
		idx =0;
		ids =1;
		for(i=0; i<len; i++)
		{
			if(szSource[i] == '_' || szSource[i] == '.')
			{
				if(ids == id )
				{
					szTarget[idx] = 0x00;
					break;
				}
				idx = 0;
				ids++;
				continue;
			}
			if(ids == id )
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}

//----------------------------------------------------------------------------------------------
	void Photo_View(void)
	{	
		char szTmp[256];
		char szViewnm[256];
		char szViewPath[256];
		char szPda_ViewPath[256];
		
		//���ϸ� ����
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stGm.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stSc.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, g_szUSE_CONT_NUM);
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stMtrChg.USE_CONT_NUM);
		}
		
		
		//���� ���� �� JPG ���ϸ�(PDA)
		Mem_Set((byte*)szViewnm, 0x00, sizeof(szViewnm));
		Str_Cpy(szViewnm, m_szfilenm);
		Str_Cat(szViewnm, ".jpg");

		//���� ���� �� PNG ���ϸ�
		Mem_Set((byte*)m_szPngPath_View, 0x00, sizeof(m_szPngPath_View));
		Str_Cpy(m_szPngPath_View, m_szfilenm);
		Str_Cat(m_szPngPath_View, "View");
		Str_Cat(m_szPngPath_View, ".png");

		//���� ���� �� JPG ���ϸ�
		Mem_Set((byte*)szPda_ViewPath, 0x00, sizeof(szPda_ViewPath));
		SPRINT (szPda_ViewPath, "%s/%s",PHOTO_BIZ, szViewnm, 0);
		//���� ���� �� PNG ���ϸ�
		Mem_Set((byte*)szViewPath, 0x00, sizeof(szViewPath));
		SPRINT (szViewPath, "%s/%s",PHOTO_BIZ, m_szPngPath_View, 0);
		

		//PDA
		if(Str_Cmp(g_szDEVICE_NAME, "DS3") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 )
		{
			if( FFS_Exist("\\windows\\iexplore.exe" ) )
			{
				RunApp( "iexplore.exe", szPda_ViewPath);
			}
			else if( FFS_Exist("\\windows\\iesample.exe" ) )
			{
				RunApp( "iesample.exe", szPda_ViewPath);
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "������ȸ ���α׷��� �����ϴ�.");
			}
		}
		else
		{	
			if(FFS_Exist(szViewPath))
			{
				m_pImgViewPng    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  szViewPath );
				
				ButCtrl_SetImage( Get_hDlgCtrlByID(BID_LARGEPHOTO),  m_pImgViewPng);
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "������ �����ϴ�.");
			}
		}

		ON_DRAW();
		return;
	}

	//-----------------------------------------------------------------
	void JpgToPng(void)
	{
		char szTmp[256];
		char szViewnm[256];
		char szPngnm[128];
		char szJpegViewPath[256];
		handle h = NULL;
		handle hdata = NULL;

		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)szViewnm, 0x00, sizeof(szViewnm));
		Mem_Set((byte*)szPngnm, 0x00, sizeof(szPngnm));

		//���ϸ� ����
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stGm.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stSc.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, g_szUSE_CONT_NUM);
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			Str_Cpy(m_szfilenm, "U");
			Str_Cat(m_szfilenm, stMtrChg.USE_CONT_NUM);
		}

		if( m_bFirst == INIT_MAIN )
		{
			//���� ���� �� JPG ���ϸ�
			Str_Cpy(szViewnm, m_szfilenm);
			//PNG ���ϸ�
			Str_Cpy(szPngnm, m_szfilenm);
			
			//���� ���� �� JJP ���ϸ�
			Str_Cat(m_szfilenm, ".jjp");
			//���� ���� �� JPG ���ϸ�
			Str_Cat(szViewnm, ".jpg");
			//PNG ���ϸ�
			Str_Cat(szPngnm, ".png");
	
			//���� ���� �� JJP ���ϸ�
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_BIZ, m_szfilenm, 0);
			//���� ���� �� JPG ���ϸ�
			Mem_Set((byte*)m_szJpegPath, 0x00, sizeof(m_szJpegPath));
			SPRINT (m_szJpegPath, "%s/%s",PHOTO_BIZ, szViewnm, 0);
			//JPEG�� PNG�� ��ȯ ���ϸ�
			Mem_Set((byte*)m_szPngPath, 0x00, sizeof(m_szPngPath));
			SPRINT (m_szPngPath, "%s/%s",PHOTO_BIZ, szPngnm, 0);
			
			//����(.jjp)�� .jpg �������� ����.
			FFS_Copy( m_szTmp, m_szJpegPath );
			
			ConvertImage(JPG, m_szJpegPath, DMS_X(698), DMS_Y(300), m_szJpegPath, 60*1000);
			VmSleep(100);
			
			//JPG�� PNG�������� ����
			//FFS_Copy( m_szTmp, m_szPngPath );
	
			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				//Native_System_Call > method �� data ���� �ʿ�(ex : Native_System_Call , 'TEST_MENU' ī�� Ȯ��
				//Native_System_Call�� �ƴ� System_Call > metod �� data ���� ���ʿ�(ex : ConvertJpegToPng , 'CM_BIZ' ī�� Ȯ��
				JSON_SetValue	(hdata	, 'C', "jpeg_path"		, m_szJpegPath);
				JSON_SetValue	(hdata	, 'C', "png_path"		, m_szPngPath);						//{true, false}
	
				System_Call		("ConvertJpegToPng" , JSON_toString(hdata));
			}
		}
		else
		{
			//���� ���� �� PNG ���ϸ�
			Mem_Set((byte*)m_szPngPath_View, 0x00, sizeof(m_szPngPath_View));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, m_szfilenm);
			Str_Cat(szTmp, "View");
			Str_Cat(szTmp, ".png");

			//���� ���� �� JPG ���ϸ�
			//Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			//SPRINT (szJpegViewPath, "%s/%s",PHOTO_BIZ, m_szJpegPath, 0);
			//���� ���� �� PNG ���ϸ�
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szPngPath_View, "%s/%s",PHOTO_BIZ, szTmp, 0);
	
			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				//Native_System_Call > method �� data ���� �ʿ�(ex : Native_System_Call , 'TEST_MENU' ī�� Ȯ��
				//Native_System_Call�� �ƴ� System_Call > metod �� data ���� ���ʿ�(ex : ConvertJpegToPng , 'CM_BIZ' ī�� Ȯ��
				JSON_SetValue	(hdata	, 'C', "jpeg_path"		, m_szJpegPath);
				JSON_SetValue	(hdata	, 'C', "png_path"		, m_szPngPath_View);						//{true, false}
	
				System_Call		("ConvertJpegToPng" , JSON_toString(hdata));
			}
		}
		
		m_lExistFlag = 1;
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hdata)
		{
			JSON_Finalize(hdata);
		}	
	}
	
	
	//-----------------------------------------------------------------
	long Validate(void)
	{
		long lRet = -1;
		char szFilePath[256];
		char szFilenm[128];
		
		Mem_Set((byte*)szFilenm, 0x00, sizeof(szFilenm));
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			Str_Cpy(szFilenm, "U");
			Str_Cat(szFilenm, stGm.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
		{
			Str_Cpy(szFilenm, "U");
			Str_Cat(szFilenm, stSc.USE_CONT_NUM);
		}
		else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			Str_Cpy(szFilenm, "U");
			Str_Cat(szFilenm, g_szUSE_CONT_NUM);
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			Str_Cpy(szFilenm, "U");
			Str_Cat(szFilenm, stMtrChg.USE_CONT_NUM);
		}
		
		Str_Cat(szFilenm, ".jjp");

		Mem_Set((byte*)szFilePath, 0x00, sizeof(szFilePath));
		SPRINT (szFilePath, "%s/%s",  PHOTO_BIZ,szFilenm,0);
		if( FFS_Exist(szFilePath)  )
		{
			lRet = 1;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "������ �Կ����ּ���.");
		}
		
		return lRet;
	}
}



