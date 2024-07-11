/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_SILSA
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
		DEF_BUTTON_ID ( BID_SAVE )
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
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		
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
	END_OBJECT_ID()
	
	#define INIT_MAIN	   1
	#define INIT_PHOTOVIEW 2
	
	//PNG ���� Ȯ�� ũ��
	#define PNG_CONVERT_WD DMS_X(900)
	#define PNG_CONVERT_HT DMS_Y(450)

	long m_bFirst;
	long m_lActiveIndex = -1;
	long m_lPhotoFlag = 0;		//m_lPhotoFlag = 0 ���� ����, m_lPhotoFlag = 1 ���� ����
	
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
	void ReDraw(void);
	void Shoto_Photo(void);
	void Photo_View(void);
	void JpgToPng(void);		
	void PhotoDraw(void);
	long Save_Silsa(void);

	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ħ �ǻ�"),
		//DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON( STARTX,       STARTY-29, 1000, 404, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PHOTOVIEW,  ""),
		DLG_BUTTON( STARTX+500,  STARTY+375, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�����Կ�"),
		DLG_BUTTON( STARTX+500,  STARTY+830, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "Ȯ ��"),
		//DLG_BUTTON( 0,           STARTY+375, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW, "��������"),
		//DLG_BUTTON( 0,           STARTY+820, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),

		DLG_TEXT( STARTX,      STARTY+445, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5, "�⹰��ȣ"),
		DLG_TEXT( STARTX+250,  STARTY+445, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),

		DLG_TEXT( STARTX,      STARTY+505, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "VC ��ħ"),
		DLG_EDIT(STARTX+250,   STARTY+505, 750, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 35,  ""),
		DLG_TEXT( STARTX,      STARTY+565, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "VA ��ħ"),
		DLG_EDIT(STARTX+250,   STARTY+565, 750, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 35,  ""),
		DLG_TEXT( STARTX,      STARTY+625, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "VM ��ħ"),
		DLG_EDIT(STARTX+250,   STARTY+625, 750, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 35,  ""),

		DLG_TEXT( STARTX,         STARTY+685, 250, 145, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4, "�޸�"),
		DLG_BUTTON( STARTX+250,   STARTY+685, 750, 145, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT(STARTX+250,      STARTY+685, 750, 145, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, ""),
	};	

	// PDA ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "��ħ �ǻ�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SAVE, ""),

		DLG_BUTTON( STARTX,       STARTY-40, 1000, 350, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PHOTOVIEW,  ""),
		DLG_BUTTON( STARTX+500,  STARTY+310, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�����Կ�"),
		DLG_BUTTON( STARTX+500,  STARTY+830, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "Ȯ ��"),

		DLG_TEXT( STARTX,      STARTY+380, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5, "�⹰��ȣ"),
		DLG_TEXT( STARTX+250,  STARTY+380, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT( STARTX,      STARTY+440, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "VC ��ħ"),
		DLG_EDIT(STARTX+250,   STARTY+440, 750, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 35,  ""),
		DLG_TEXT( STARTX,      STARTY+500, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "VA ��ħ"),
		DLG_EDIT(STARTX+250,   STARTY+500, 750, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 35,  ""),
		DLG_TEXT( STARTX,      STARTY+560, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "VM ��ħ"),
		DLG_EDIT(STARTX+250,   STARTY+560, 750, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 35,  ""),
		DLG_TEXT( STARTX,      STARTY+620, 250, 210, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4, "�޸�"),
		DLG_EDIT(STARTX+250,   STARTY+620, 750, 210, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 500,  ""),
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
						break;		
				}
				SetBtnImg();
				SetStyle();
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
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA4), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );
				break;
			case BID_PHOTO:
				Shoto_Photo();
				break;
/*
			case BID_VIEW:
			case BID_PHOTOVIEW:
				if( m_lPhotoFlag == 1 )
				{
					//�̸� ũ�� ���� �� ���̾�α� ȣ��
					ConvertImage(JPG, m_szJpegPath, PNG_CONVERT_WD, PNG_CONVERT_HT, m_szJpegPath, 60*1000);
					ON_EXIT();
					OnInit(INIT_PHOTOVIEW);
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "������ �Կ����ּ���.");
				}
				break;
*/
			case BID_SAVE:
				if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
				{
					//��ħ�ǻ�
					if( Save_Silsa() > 0)
					{
						//MessageBoxEx (CONFIRM_OK, "�����Ͽ����ϴ�.");
						g_DirFS_Clear(PHOTO_GM, "*.jpg");
						Card_Move("GM_ENTRY");
					}
				}
				else
				{
					//�ο� ����ǻ�
					g_DirFS_Clear(PHOTO_GM, "*.mwjjp");
					g_DirFS_Clear(PHOTO_GM, "*.mwjpg");
					g_DirFS_Clear(PHOTO_GM, "*.mwpngi");
					Card_Move("C6101_SILSA");
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
		//2017-04-25 Sanghyun Lee
		//Ư�� �ǻ�� VC,VA,VM ��ħ ���� �Է��� ����. -> Ư��(����)�ǻ� �϶� �ּ� Ǯ� ���
		//��ħ �ǻ�� ���� ����ȭ�鿡�� �Ѱܹް�, �����Է� �Ұ���.
		if( g_nWorkFlag > 200 && g_nWorkFlag < 100 )
		{
			//���ڸ� �Է� ����
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
					return;
				}
			}
		}

		return;
	}
	
//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		//2017-04-25 Sanghyun Lee
		//Ư�� �ǻ�� VC,VA,VM ��ħ ���� �Է��� ����. -> Ư��(����)�ǻ� �϶� �ּ� Ǯ� ���
		//��ħ �ǻ�� ���� ����ȭ�鿡�� �Ѱܹް�, �����Է� �Ұ���.
		if( g_nWorkFlag > 200 && g_nWorkFlag < 100 )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+295) && X < DMS_X(STARTX+993) && Y > DMS_Y(STARTY+445-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+505-(g_Dlgflag*400)) ||
					    X > DMS_X(STARTX+295) && X < DMS_X(STARTX+993) && Y > DMS_Y(STARTY+505-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+565-(g_Dlgflag*400)) ||
					    X > DMS_X(STARTX+295) && X < DMS_X(STARTX+993) && Y > DMS_Y(STARTY+565-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+625-(g_Dlgflag*400)) )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
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
	}

	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
			}
			else
			{
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgBlankTtl );		//Ÿ��Ʋ
			}
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_DATA4), TRUE, 2, EDITSEP_NONE );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTOVIEW), FALSE );
		}
	}
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		long i = 0, k = 0;
		char szTmp[50];
		
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), stGm.MTR_ID_NUM );
		
			if( g_nUserData == 10 )
			{
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
	            //DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
	            DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
	            DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
	
				//VC
				Str_Chg(g_szIndi_Vc, STRCHG_DEL_NONDIGIT);
				if( Str_Len(g_szIndi_Vc) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), g_szIndi_Vc );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA1), TXTFRCOLOR);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), "��ħȭ�鿡�� ��ħ��� �ٶ��ϴ�." );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA1), BRIGHTGRAY);
				}
				
				//VA
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), "" );
				//VM
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), "" );
			}
			else if( g_nUserData == 20 )
			{
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
	            //DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
	            //DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
	            //DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
	
				//VC
				Str_Chg(g_szIndi_Vc, STRCHG_DEL_NONDIGIT);
				if( Str_Len(g_szIndi_Vc) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), g_szIndi_Vc );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA1), TXTFRCOLOR);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), "��ħȭ�鿡�� ��ħ��� �ٶ��ϴ�." );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA1), BRIGHTGRAY);
				}
				
				//VA
				Str_Chg(g_szIndi_Va, STRCHG_DEL_NONDIGIT);
				if( Str_Len(g_szIndi_Va) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), g_szIndi_Va );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA2), TXTFRCOLOR);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), "��ħȭ�鿡�� ��ħ��� �ٶ��ϴ�." );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA2), BRIGHTGRAY);
				}
				
				//VM
				Str_Chg(g_szIndi_Vm, STRCHG_DEL_NONDIGIT);
				if( Str_Len(g_szIndi_Vm) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), g_szIndi_Vm );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA3), TXTFRCOLOR);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), "��ħȭ�鿡�� ��ħ��� �ٶ��ϴ�." );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA3), BRIGHTGRAY);
				}
			}
			else if( g_nUserData == 40 || g_nUserData == 41 )
			{
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
	            //DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
	            DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
	            DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
	            //DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
	
				//VC
				Str_Chg(g_szIndi_Vc, STRCHG_DEL_NONDIGIT);
				if( Str_Len(g_szIndi_Vc) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), g_szIndi_Vc );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA1), TXTFRCOLOR);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), "��ħȭ�鿡�� ��ħ��� �ٶ��ϴ�." );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA1), BRIGHTGRAY);
				}
				
				//VA
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), "" );
				
				//VM
				Str_Chg(g_szIndi_Vm, STRCHG_DEL_NONDIGIT);
				if( Str_Len(g_szIndi_Vm) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), g_szIndi_Vm );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA3), TXTFRCOLOR);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), "��ħȭ�鿡�� ��ħ��� �ٶ��ϴ�." );
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(EDT_DATA3), BRIGHTGRAY);
				}
			}
			
			//�޸�
			if( g_szIndi_MtrCode[0] == '2' || g_szIndi_MtrCode[0] == 'C' )
			{
				//EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), g_szIndi_MtrCode);
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)g_szIndi_MtrCode+2, Str_Len(g_szIndi_MtrCode)-2);
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szTmp);
			}
			else if( Str_Cmp(stGm.INSP_SAVE_YN, "S") == 0 || Str_Cmp(stGm.INSP_SAVE_YN, "Y") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), stGm.INSP_MEMO);
			}
		}

		PhotoDraw();
		
		return;
	}
	
//----------------------------------------------------------------------------------------------
	void PhotoDraw(void)
	{
		char szDate[50];
		char szfilenm[128];
		char szPhotopath[256];

		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			Str_Cpy(stGm.INDI_INSP_VC, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cpy(stGm.INDI_INSP_VA, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stGm.INDI_INSP_VM, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Chg(stGm.INDI_INSP_VC, STRCHG_DEL_NONDIGIT);
			Str_Chg(stGm.INDI_INSP_VA, STRCHG_DEL_NONDIGIT);
			Str_Chg(stGm.INDI_INSP_VM, STRCHG_DEL_NONDIGIT);
	
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szDate, 10);
			Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
	
			Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
			Str_Cpy(m_szfilenm, stGm.MTR_NUM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VC);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VA);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, szDate);
			
			Str_Cpy(szfilenm, m_szfilenm);
			Str_Cat(szfilenm, ".pngi");
		}
		else
		{
			//�ο��ǻ�
			Str_Cpy(m_szfilenm, "MW_SILSA");
			Str_Cat(m_szfilenm, ".mwpngi");
		}

		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			//JPEG�� PNG�� ��ȯ ���ϸ�
			Mem_Set((byte*)m_szPngPath, 0x00, sizeof(m_szPngPath));
			SPRINT (m_szPngPath, "%s/%s",PHOTO_GM, szfilenm, 0);
	
			//m_lPhotoFlag = 0 ���� ����, m_lPhotoFlag = 1 ���� ����
			if( FFS_Exist(m_szPngPath) )
			{
				m_lPhotoFlag = 1;
				Str_Cpy(stBiz.szPhoto, "Y");
				m_pImgBiz    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  m_szPngPath );
				
				ButCtrl_SetImage( Get_hDlgCtrlByID(BID_PHOTOVIEW),  m_pImgBiz);
			}
			else
			{
				m_lPhotoFlag = 0;
				Str_Cpy(stBiz.szPhoto, "N");
			}
		}
		else //PDA
		{
			//JPEG�� PNG�� ��ȯ ���ϸ�
			Mem_Set((byte*)m_szPngPath, 0x00, sizeof(m_szPngPath));
			SPRINT (m_szPngPath, "%s/%s.jpg",PHOTO_GM, m_szfilenm, 0);

			if( FFS_Exist(m_szPngPath) )
			{
				m_lPhotoFlag = 1;
				Str_Cpy(stBiz.szPhoto, "Y");
				m_pImgBiz    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  m_szPngPath );
				
				ButCtrl_SetImage( Get_hDlgCtrlByID(BID_PHOTOVIEW),  m_pImgBiz);
			}
			else
			{
				m_lPhotoFlag = 0;
				Str_Cpy(stBiz.szPhoto, "N");
			}
		}
		
		ON_DRAW();
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		
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
					ON_DRAW();
					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
					
					FFS_Delete( szfilenm );

					JpgToPng();
				}
			}
		}
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

		if( nEvent == TASK_SYS_CALL && nData == TASK_CAMERA )
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
				//PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
				
				//�������� +19
				Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
				SPRINT (g_szphoto, "%s/%s", PHOTO_GM,  m_szfilenm, 0);
			}

			if( FFS_Exist(szPhotopath) )
			{
				FFS_Copy(szPhotopath, g_szphoto);
				FFS_Delete(szPhotopath);
				
				ON_DRAW();
				MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
			}
		}
		else if( nEvent == TASK_SYS_CALL && nData == 1 )
		{
			if( m_bFirst == INIT_MAIN )
			{
				//JPEG -> PNG ��ȯ ��, ȭ�鿡 ���� Draw
				PhotoDraw();
			}
/*
			else if( m_bFirst == INIT_PHOTOVIEW )
			{
				//���� Ȯ�� ����
				Photo_View();
			}
*/
		}
		
		ON_DRAW();
		return;
	}

	
//----------------------------------------------------------------------------------------------
/*
��ħ_��ħ�ǻ�	C21.C2BT_INSP_OBJ		INSP_PHOTO_ID 	�ǻ� ����
��ħ_��ħ�ǻ�	10.1.9.13  ,  /exdat03/C20/INSP/�����/û�����/����/�����ڵ�	
��ħ�ǻ�		C20(��������) | R(û�����) | D(����) | 1(�����ħ�ǻ�) | 0(����) | M(�跮���ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS)					
��ħ_��ħ�ǻ�	C20	C20R201704D2010M300117733D20170327(��ħ�ǻ�)
*/
	void Shoto_Photo(void)
	{
		char *pCamera;
		char szDate[20];
		long nRet;
		handle h = NULL;
		handle hdata = NULL;
		
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			//��ħ�ǻ� 
			Str_Cpy(stGm.INDI_INSP_VC, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cpy(stGm.INDI_INSP_VA, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stGm.INDI_INSP_VM, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Chg(stGm.INDI_INSP_VC, STRCHG_DEL_NONDIGIT);
			Str_Chg(stGm.INDI_INSP_VA, STRCHG_DEL_NONDIGIT);
			Str_Chg(stGm.INDI_INSP_VM, STRCHG_DEL_NONDIGIT);
	
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szDate, 10);
			Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
	
			Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
			Str_Cpy(m_szfilenm, stGm.MTR_NUM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VC);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VA);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, szDate);
		
			//���� ���ϸ� ����
			Str_Cat(m_szfilenm, ".jjp");
		}
		else
		{
			//�ο��ǻ�
			Str_Cpy(m_szfilenm, "MW_SILSA");
			Str_Cat(m_szfilenm, ".mwjjp");
		}

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_GM,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//��������
			//Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_GM,  m_szfilenm, 0);
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
				JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_MEDIUM");

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
/*
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
			Str_Cat(m_szfilenm, stGm.MTR_NUM);
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
		SPRINT (szPda_ViewPath, "%s/%s",PHOTO_GM, szViewnm, 0);
		//���� ���� �� PNG ���ϸ�
		Mem_Set((byte*)szViewPath, 0x00, sizeof(szViewPath));
		SPRINT (szViewPath, "%s/%s",PHOTO_GM, m_szPngPath_View, 0);
		

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
*/

	//-----------------------------------------------------------------
	void JpgToPng(void)
	{
		char szTmp[256];
		char szViewnm[256];
		char szPngnm[128];
		char szJpegViewPath[256];
		char szDate[20];
		handle h = NULL;
		handle hdata = NULL;


		if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
		{
			Str_Cpy(stGm.INDI_INSP_VC, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cpy(stGm.INDI_INSP_VA, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stGm.INDI_INSP_VM, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Chg(stGm.INDI_INSP_VC, STRCHG_DEL_NONDIGIT);
			Str_Chg(stGm.INDI_INSP_VA, STRCHG_DEL_NONDIGIT);
			Str_Chg(stGm.INDI_INSP_VM, STRCHG_DEL_NONDIGIT);
	
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szDate, 10);
			Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
	
			Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
			Str_Cpy(m_szfilenm, stGm.MTR_NUM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VC);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VA);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stGm.INDI_INSP_VM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, szDate);
	
			Mem_Set((byte*)szViewnm, 0x00, sizeof(szViewnm));
			Mem_Set((byte*)szPngnm, 0x00, sizeof(szPngnm));
	
			//���� ���� �� JPG ���ϸ�
			Str_Cpy(szViewnm, m_szfilenm);
			//PNG ���ϸ�
			Str_Cpy(szPngnm, m_szfilenm);
			
			//���� ���� �� JJP ���ϸ�
			Str_Cat(m_szfilenm, ".jjp");
			//���� ���� �� JPG ���ϸ�
			Str_Cat(szViewnm, ".jpg");
			//PNG ���ϸ�
			Str_Cat(szPngnm, ".pngi");
		}
		else
		{
			//�ο��ǻ�
			Str_Cpy(m_szfilenm, "MW_SILSA");
			Str_Cat(m_szfilenm, ".jjpdel");

			//���� ���� �� JPG ���ϸ�
			Str_Cpy(szViewnm, m_szfilenm);
			//PNG ���ϸ�
			Str_Cpy(szPngnm, m_szfilenm);
			
			//���� ���� �� JJP ���ϸ�
			Str_Cat(m_szfilenm, ".mwjjp");
			//���� ���� �� JPG ���ϸ�
			Str_Cat(szViewnm, ".mwjpg");
			//PNG ���ϸ�
			Str_Cat(szPngnm, ".mwpngi");
		}


		//���� ���� �� JJP ���ϸ�
		Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
		SPRINT (m_szTmp, "%s/%s",PHOTO_GM, m_szfilenm, 0);
		//���� ���� �� JPG ���ϸ�
		Mem_Set((byte*)m_szJpegPath, 0x00, sizeof(m_szJpegPath));
		SPRINT (m_szJpegPath, "%s/%s",PHOTO_GM, szViewnm, 0);
		//JPEG�� PNG�� ��ȯ ���ϸ�
		Mem_Set((byte*)m_szPngPath, 0x00, sizeof(m_szPngPath));
		SPRINT (m_szPngPath, "%s/%s",PHOTO_GM, szPngnm, 0);
		
		//����(.jjp)�� .jpg �������� ����.
		FFS_Copy( m_szTmp, m_szJpegPath );
		
		ConvertImage(JPG, m_szJpegPath, DMS_X(998), DMS_Y(399), m_szJpegPath, 60*1000);
		//VmSleep(100);
		
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
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hdata)
		{
			JSON_Finalize(hdata);
		}	
		
/*
//���� Ŭ�� �� �ٸ� ���̾�α׸� �ҷ��� Ȯ���Ͽ� �����ִ� ���
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
			//SPRINT (szJpegViewPath, "%s/%s",PHOTO_GM, m_szJpegPath, 0);
			//���� ���� �� PNG ���ϸ�
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szPngPath_View, "%s/%s",PHOTO_GM, szTmp, 0);
	
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
*/
	}
	
	
	//-----------------------------------------------------------------
	long Save_Silsa(void)
	{
		long idx;
		long i;
		long nLen = 0;
		long lRet = 0;
		char szPath[256];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Str_Cpy(stGm.INDI_INSP_VC, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cpy(stGm.INDI_INSP_VA, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cpy(stGm.INDI_INSP_VM, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Chg(stGm.INDI_INSP_VC, STRCHG_DEL_NONDIGIT);
		Str_Chg(stGm.INDI_INSP_VA, STRCHG_DEL_NONDIGIT);
		Str_Chg(stGm.INDI_INSP_VM, STRCHG_DEL_NONDIGIT);
		
		if( Str_Len(stGm.INDI_INSP_VC) == 0 )
		{
			Str_Cpy(stGm.INDI_INSP_VC, "0");
		}
		
		if( Str_Len(stGm.INDI_INSP_VA) == 0 )
		{
			Str_Cpy(stGm.INDI_INSP_VA, "0");
		}
		
		if( Str_Len(stGm.INDI_INSP_VM) == 0 )
		{
			Str_Cpy(stGm.INDI_INSP_VM, "0");
		}
		
		//�ǻ�����
		Str_ItoA(Time_GetDate(), stGm.INSP_YMD, 10);
		Str_Chg(stGm.INSP_YMD, STRCHG_DEL_NONDIGIT);
		
		//�ǻ�޸�
		Str_Cpy(stGm.INSP_MEMO, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA4)));
		
		//�ǻ����忩��
		Str_Cpy(stGm.INSP_SAVE_YN, "S");
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			lRet = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "UPDATE GUMDATA SET \
INSP_MEMO = ?, INDI_INSP_VM = ?, INDI_INSP_VA = ?, INDI_INSP_VC = ?, INSP_YMD = ?, INSP_SAVE_YN = ?  \
WHERE MTR_NUM = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			lRet = -1;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stGm.INSP_MEMO		    ,300,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_INSP_VM	    ,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_INSP_VA	    ,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_INSP_VC	    ,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INSP_YMD	        ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INSP_SAVE_YN	    ,5	,DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)stGm.MTR_NUM 	      	,9	,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			lRet = -1;
			goto Finally;
		}
		
		lRet = 1;
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		return lRet;
	}
}



