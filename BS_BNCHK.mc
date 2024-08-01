/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_BNCHK
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_PREVPG )	//����������
		DEF_BUTTON_ID ( BID_NEXTPG )	//����������
		DEF_BUTTON_ID ( BID_CAMERA )	//�Կ�
		DEF_BUTTON_ID ( BID_CHECK )		//����
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
		DEF_OBJECT_ID ( TXT_TYPE )	//������
		DEF_OBJECT_ID ( TXT_COMPANY )	//������
		DEF_OBJECT_ID ( TXT_MODEL )		//��
		DEF_OBJECT_ID ( TXT_VOLUME )	//�뷮
		DEF_OBJECT_ID ( TXT_UNIT )		//����
		DEF_OBJECT_ID ( TXT_INSDT )		//��ġ����
		DEF_OBJECT_ID ( TXT_INSPLACE )	//��ġ��ġ
		DEF_OBJECT_ID ( TXT_MAKENUM )	//������ȣ
		DEF_OBJECT_ID ( TXT_FORM )		//����
		DEF_OBJECT_ID ( TXT_INSTALL )	//��ġ����
		DEF_OBJECT_ID ( TXT_DETA_LOC )  //����ġ
		DEF_OBJECT_ID ( TXT_PAGE )		//��������
		DEF_OBJECT_ID ( TXT_WORKYMD )	//����������
		DEF_OBJECT_ID ( TXT_WORKFIRM )	//�ð���
		
		DEF_OBJECT_ID ( TXT_NO )		//NO
		DEF_OBJECT_ID ( TXT_BSITEM )	//�����׸�
		DEF_OBJECT_ID ( TXT_BOO )		//��
		DEF_OBJECT_ID ( TXT_DATA0 )
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
		
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3							// table�� �ళ��
	#define		COL 	    4							// table�� ������
	#define		GRID_H		(CHT+30)					// table �� ����
	#define		GRID_CLR	TRANSPARENT   				// table Ŭ���� color
	#define		GRID_X		STARTX 						// table ����x��ǥ
	#define		MAXCHAR		51 			    			// table�� ���� �ִ� �ִ� char ����
	#define		GRID_Y		STARTY+550 	    			// table ����y��ǥ
	#define		GRID_Y_P	STARTY+430      			// table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) 	// table������ row�� Y��
	#define		GRID_ENDY_P	(GRID_Y_P+(ROW+1)*GRID_H) 	// table������ row�� Y�� PDA
	
	char		m_szTableBuf [COL*(ROW+1)*MAXCHAR]; 	// �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
	 	  {"NO",	       CWD*6,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
		, {"�����׸�",	   CWD*27+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
		, {"��",           CWD*6,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
		, {"�켱���˿���", CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	#define INIT_MAIN	1
	
	CodeTable *m_CT;
	long m_nSec_cd;
	long m_lActive = -1;
	char m_Title[30];
	long m_lTotpage;
	char m_szfilenm[128];
	
	long m_lpage;
	char m_szCnt_page[10];

	long Chk_Photo(void);
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void UpdateBur(void);
	void Save_Row(long row, long col);
	bool Save_NotPassItem(char* szNOT_PASS_ITEM_CD, char* szNOT_PASS_ITEM_NM);
	void Shoto_Photo(void);
	void Photo_View(void);
	
	SysButCtrl SysButRes_MAIN[] =
	 {
		  SYS_BUT_IMG (  BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME,  0),
		  SYS_BUT_IMG (  BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD,  0),
		  SYS_BUT_IMG (  BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0),
		  SYS_BUT_IMG (  BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK,  0),
		  SYS_BUT_IMG (  BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0),
		  SYS_BUT_IMG (  BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0),
		  SYS_BUT_IMG (  BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0),
	 };
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� ����"),
	
		DLG_TEXT(STARTX,     STARTY+65,  240, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TYPE, "����"),
		DLG_TEXT(STARTX+240, STARTY+65,  760, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA0, ""),
		DLG_TEXT(STARTX+530, STARTY+65,  240, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMPANY, "������"),
		DLG_TEXT(STARTX+770, STARTY+65,  760, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),	
		
		DLG_TEXT(STARTX,     STARTY+130, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMPANY, "������"),
		DLG_TEXT(STARTX+240, STARTY+130, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),	
		
		DLG_TEXT(STARTX,     STARTY+130, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSDT, "��ġ����"),
		DLG_TEXT(STARTX+240, STARTY+130, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),

		// DLG_TEXT(STARTX,     STARTY+130, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VOLUME, "�뷮"),
		// DLG_TEXT(STARTX+240, STARTY+130, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),

		// DLG_TEXT(STARTX+530, STARTY+130, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_UNIT, "����"),
		// DLG_TEXT(STARTX+770, STARTY+130, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		
		DLG_TEXT(STARTX+530, STARTY+130, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODEL, "��"),
		DLG_TEXT(STARTX+770, STARTY+130, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_TEXT(STARTX,     STARTY+190, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VOLUME, "�뷮"),
		DLG_TEXT(STARTX+240, STARTY+190, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),

		// DLG_TEXT(STARTX+530, STARTY+190, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSPLACE, "��ġ��ġ"),
		// DLG_TEXT(STARTX+770, STARTY+190, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),

		DLG_TEXT(STARTX+530, STARTY+190, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_UNIT, "����"),
		DLG_TEXT(STARTX+770, STARTY+190, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),

		
		//DLG_TEXT(STARTX,     STARTY+310, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSPLACE, "��ġ��ġ"),
		//DLG_TEXT(STARTX+240, STARTY+310, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		
		DLG_TEXT(STARTX,     STARTY+250, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DETA_LOC, "��ġ"),
		DLG_TEXT(STARTX+240, STARTY+250, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),

		// DLG_TEXT(STARTX,     STARTY+250, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MAKENUM, "������ȣ"),
		// DLG_TEXT(STARTX+240, STARTY+250, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		// DLG_TEXT(STARTX+530, STARTY+250, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"),
		// DLG_TEXT(STARTX+770, STARTY+250, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		DLG_TEXT(STARTX, 	 STARTY+310, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, " ����"),
		DLG_TEXT(STARTX+240, STARTY+310, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TEXT(STARTX+530, STARTY+310, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MAKENUM, "������ȣ"),
		DLG_TEXT(STARTX+770, STARTY+310, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		

		DLG_TEXT(STARTX,     STARTY+370, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKYMD, "��������"),
		DLG_TEXT(STARTX+240, STARTY+370, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),

		DLG_TEXT(STARTX+530, STARTY+370, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSTALL, "��ġ����"),
		DLG_TEXT(STARTX+770, STARTY+370, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),

		// DLG_TEXT(STARTX, STARTY+310, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKFIRM, " �� �� ��"),
		// DLG_TEXT(STARTX+240, STARTY+310, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),

		DLG_TEXT(STARTX,     STARTY+430, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKFIRM, " �� �� ��"),
		DLG_TEXT(STARTX+240, STARTY+430, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),

		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT  (STARTX,     STARTY+490, 500, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500, STARTY+490, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+490, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, " ��"),
		
		DLG_BUTTON(STARTX    , STARTY+829, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA, "�Կ�"),
		DLG_BUTTON(STARTX+500, STARTY+829, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK, "����"),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���ұ� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX,		STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA, "�Կ�"),
		DLG_BUTTON(STARTX+600,	STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK, "����"),
		
		DLG_TEXT(STARTX,      STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMPANY, "������"),
		DLG_TEXT(STARTX+300,  STARTY-40, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,      STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODEL, "��"),
		DLG_TEXT(STARTX+300,  STARTY+30, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),		
		DLG_TEXT(STARTX,     STARTY+100, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VOLUME, "�뷮"),
		DLG_TEXT(STARTX+200, STARTY+100, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+530,     STARTY+250, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_UNIT, "����"),
		DLG_TEXT(STARTX+770, STARTY+250, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+450, STARTY+100, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSDT, "��ġ����"),
		DLG_TEXT(STARTX+700, STARTY+100, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+170, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSPLACE, "��ġ��ġ"),
		DLG_TEXT(STARTX+300, STARTY+170, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+240, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MAKENUM, "������ȣ"),
		DLG_TEXT(STARTX+300, STARTY+240, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+310, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"),
		DLG_TEXT(STARTX+200, STARTY+310, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+450, STARTY+310, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSTALL, "��ġ����"),
		DLG_TEXT(STARTX+700, STARTY+310, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),

		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				REDRAW();
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			//��ܰ���޴�
			h = GetSysButHandle(GID_HOME);
			ButCtrl_SetImage( h,  g_pImgHomeI);
			ButCtrl_SetActiveImage( h,  g_pImgHomeA);
			
			h = GetSysButHandle(GID_KEYBOARD);
			ButCtrl_SetImage( h,  g_pImgKeybrdI);
			ButCtrl_SetActiveImage( h,  g_pImgKeybrdA);
			
			h = GetSysButHandle(GID_SCREEN);
			ButCtrl_SetImage( h,  g_pImgScreenI);
			ButCtrl_SetActiveImage( h,  g_pImgScreenA);
			
			h = GetSysButHandle(GID_CMMNWK);
			ButCtrl_SetImage( h,  g_pImgCmmnwrkI);
			ButCtrl_SetActiveImage( h,  g_pImgCmmnwrkA);
			
			h = GetSysButHandle(GID_VMEXIT);
			ButCtrl_SetImage( h,  g_pImgExitI);
			ButCtrl_SetActiveImage( h,  g_pImgExitA);
		}
	}

//-----------------------------------------------------------------
void	SetStyle(void)
{
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMPANY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VOLUME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_UNIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INSDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INSPLACE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKENUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INSTALL) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DETA_LOC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKFIRM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKYMD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA0), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
	
	Str_Cpy(m_Title, stBsNogood.CHK_SEC_NM);
	Str_Cat(m_Title, " ����");
	m_nSec_cd = Str_AtoI(stBsNogood.CHK_SEC_CD);
	m_lTotpage = sizeof(SCHKBUR)/sizeof( CodeTable )-1;
	m_CT = SCHKBUR;
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_PREVPG:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					return;
				}
				m_lActive = 0;
				REDRAW();
				break;			
			case BID_NEXTPG:
				m_lpage += ROW;
				if( m_lpage >= m_lTotpage )
				{
					m_lpage -= ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_lActive = 0;
				REDRAW();
				break;					
			case BID_CAMERA:
				Shoto_Photo();
				break;
			case BID_CHECK:
				UpdateBur();
				if (Chk_Photo() > 0)
				{
					Card_Move("BS_MTRINFO");
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "�������׸� �����Կ��� ���ּ���.");
					break;
				}
				
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "Ư������ �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
					Card_Move("BS_MENU");
				}
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
				Card_Move("BS_MTRINFO");
				break;	
			case GID_VMEXIT:
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Exit_DelBsData();
					return;
				}
				g_Exit();
				return;
		}
	}

//------------------------------------------------------------------	
	void	OnSelect(long Index)
	{
		long index = -1;
		long lpage = 0;
		long lrow, lcol;
		char sztmp[20];
	
		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			m_lActive = index;
			
			lrow = index/COL;
			lcol = index%COL;
			lrow--;

			// ���� �ε����� ���� �ε����� ���� �� ���
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, lcol) );
			
			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, lrow, 3), "Y") != 0  )
			{
				if( lcol == 2 )
				{
					if( Str_Cmp( sztmp, CHKGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-2 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-1 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), RED);
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-2 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-1 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), BLUE);
					}
	
					Save_Row(lrow, lcol);
					ON_DRAW();
				}
			}
			else
			{
				// MessageBoxEx (CONFIRM_OK, "�켱���� ������ �׸���\n���� �� �� �����ϴ�.");	

				if( MessageBoxEx (CONFIRM_YESNO, "�켱���� ������ �׸���\n���� �� �� �����ϴ�. \n\n �����ǰ� ���ڸ� �Է��Ͻðڽ��ϱ�?")  == MB_OK)
				{
					g_lGovBetterFlag = 2;
					Card_Move("BS_RFRMRSK");

				}
			}
			
			lpage = m_lpage + (index/COL);
			g_nChkIndex = index;
			SPRINT(m_szCnt_page, "%d/%d", lpage, m_lTotpage, 0);
			ON_DRAW();
		}
	}
	
//------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long lpage = 1;
		long k = ROW + 1;
		long lrow, lcol;
		char szSql[401];
		char szTmp[200];
		char szDate[20];
		char szNOT_PASS_ITEM_CD[3];
		char szPRE_CHK_OBJ_YN[3];
		long ret = -1;	

		//����
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA0)   , stBsBur.BURNER_KIND_NM);
				
		//������
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1)   , stBsBur.MAKER_NM);
		
		//��
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)   , stBsBur.BURNER_MODEL_NM);
		
		//�뷮
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)   , stBsBur.BURNER_CAPA);
		
		//����
		i = SearchCD( stBsBur.BURNER_CAPA_UNIT, SCBOIL_CAPA );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), SCBOIL_CAPA[i].Str);

		//�ð���
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11)   , stBsBur.WORK_FIRM);

		//����������
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12)   , stBsBur.WORK_YMD);
		
		
		//��ġ����
		Mem_Set((byte*)szDate ,0x00, sizeof(szDate) );
		g_Str_DateType(szDate, stBsBur.BURNER_INST_YMD);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)   , szDate );
		
		//��ġ��ġ
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		// SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30028' AND CODE_ITEM = '%s'", stBsBur.INST_LOC, 0, 0 );
		// g_Sql_RetStr( stBsBur.INST_LOC, 20, szTmp );
		// EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), szTmp );

		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)   , stBsBur.INST_LOC_NM);
		
		//������ȣ
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)   , stBsBur.MAKE_NUM);
		
		//����
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)   , stBsBur.BOILER_FORM);
		
		//��ġ����
		// if( Str_Cmp(stBsBur.CHG_FLAG, "1") == 0 )
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8)   , stBsBur.INST_FLAG_NM);
		// else
		
		//����ġ
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9)   , stBsBur.INST_LOC_NM);
		// EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9)   , stBsBur.DETA_LOC);
		
		
		//��ũ��
		if( m_lActive == -1 )
		{
			m_lActive = 0;
		}
		
		if( g_nPhotoFlag == 4 )
		{
			lpage = m_lpage + (g_nChkIndex / COL);
			m_lActive = g_nChkIndex;
		
			lrow = (m_lActive/COL) - 1;
			lcol = m_lActive%COL;

			g_nPhotoFlag = 0;
		}
		else
		{
			lpage = m_lpage;
		
			lrow = 0;
			lcol = 0;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", lpage+1, m_lTotpage, 0);
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i = 0 ; i < ROW ; i++)
		{
			if( m_lpage+i+1 > m_lTotpage )//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, m_CT[m_lpage+i].Str );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				SPRINT(szSql, " SELECT NOT_PASS_ITEM_CD FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, m_CT[m_lpage+i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' AND BURNER_NUM = '%s' ", stBsNogood.MTR_NUM, stBsNogood.BURNER_NUM, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );

				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, m_CT[m_lpage+i].Code );
				
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szPRE_CHK_OBJ_YN ,0x00, sizeof(szPRE_CHK_OBJ_YN) );
				SPRINT(szSql, " SELECT PRE_CHK_OBJ_YN FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, m_CT[m_lpage+i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' AND BURNER_NUM = '%s' ", stBsNogood.MTR_NUM, stBsNogood.BURNER_NUM, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 3, szPRE_CHK_OBJ_YN );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, szPRE_CHK_OBJ_YN );
			}			
		}
				
		ON_DRAW();
		return;
	}
	
//-----------------------------------------------------------------	
	void UpdateBur(void)
	{
		char szSql[300];
		long lCnt;
	
		//�跮����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='50' \
						AND MTR_NUM = '%s' AND BURNER_NUM = '%s' AND BETTER_YN = 'N'  "
						, g_szCHK_EXEC_NUM, stBsNogood.MTR_NUM, stBsNogood.BURNER_NUM);
		g_Sql_RetInt(szSql, &lCnt);
		if( lCnt > 0 )
		{
			SPRINT(szSql, " UPDATE SPECIAL_BUR SET BUR_RSLT = 'N' WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND BURNER_NUM = '%s' "
							, g_szCHK_EXEC_NUM, stBsNogood.MTR_NUM, stBsNogood.BURNER_NUM);
			g_Sql_DirectExecute(szSql);
		}
		else
		{
			SPRINT(szSql, " UPDATE SPECIAL_BUR SET BUR_RSLT = 'Y' WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' \
							AND BURNER_NUM = '%s' AND (CHG_FLAG <> '3' OR CHG_FLAG IS NULL)"
							, g_szCHK_EXEC_NUM, stBsNogood.MTR_NUM, stBsNogood.BURNER_NUM);
			g_Sql_DirectExecute(szSql);
		}

	}
	
//-----------------------------------------------------------------
	void Save_Row(long row, long col)
	{
	char szNOT_PASS_ITEM_CD[3];
	char szNOT_PASS_ITEM_NM[33];
	char sztmp[20];
	char szSql[300];
	
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set((byte*)szNOT_PASS_ITEM_NM ,0x00, sizeof(szNOT_PASS_ITEM_NM) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
	
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, row, col) );
		Str_Cpy( szNOT_PASS_ITEM_NM, DlgTbl_GetStr( ID_TBLLIST, row, col-1) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, row, col-2) );
		//������ ��� �׸� ����
		if(Str_Cmp( sztmp, CHKGOOD) == 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
			g_Sql_DirectExecute( szSql );
		}
		else // �������� ��� �׸� �߰�
		{
			Save_NotPassItem(szNOT_PASS_ITEM_CD, szNOT_PASS_ITEM_NM);

			//������ ���ý�, ���� ȣ��
			Shoto_Photo();
		}
	}
	
//-----------------------------------------------------------------
	bool Save_NotPassItem(char* szNOT_PASS_ITEM_CD, char* szNOT_PASS_ITEM_NM)
	{
	long idx;
	bool ret = TRUE;
	SQLITE sql = NewSqLite();
	long nDate;
	long BettePlanymd;
	char sztmp[20];	
	handle hdb = NULL;
	handle hstmt = NULL;
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		nDate = Time_GetDate();
		BettePlanymd = Time_DateUpDown(nDate, 30 );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}		
		hstmt = sql->CreateStatement(sql,
		"INSERT INTO SPECIAL_NOGOOD_DETAL \
		( CHK_EXEC_NUM     , CHK_SEC_CD       , MTR_NUM          , BURNER_NUM   , NOT_PASS_ITEM_CD \
		, OBJ_YM           , CHK_YEAR         , CHK_ORDER        , SPECIAL_NUM       \
		, CHK_TYPE         , CHK_SEC_NM       , NOT_PASS_ITEM_NM , VISIT_DTM         \
		, BETTER_PLAN_YMD  , BETTER_YN        , SEND_YN          , PHOTO             \
		, UPD_EMPID        , PDA_IP) \
		VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
			 , ?, ?, ?, ?, 'N', 'S', ?, ?, ? ) " 
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.CHK_EXEC_NUM    ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.CHK_SEC_CD      ,2 ,DECRYPT);
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "000000000");
		if(  Str_Len(stBsNogood.MTR_NUM) > 0  )
			sql->Bind(sql, idx++, 'U', (long *)stBsNogood.MTR_NUM         ,9 ,DECRYPT);
		else
			sql->Bind(sql, idx++, 'U', (long *)sztmp                      ,9 ,DECRYPT);

		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "000000");
		if(  Str_Len(stBsNogood.BURNER_NUM) > 0  )			
			sql->Bind(sql, idx++, 'U', (long *)stBsNogood.BURNER_NUM      ,6 ,DECRYPT);
		else
			sql->Bind(sql, idx++, 'U', (long *)sztmp                      ,6 ,DECRYPT);
			
		sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_CD         ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.OBJ_YM          	  ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_YEAR         	  ,4  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_ORDER        	  ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_NUM       	  ,7  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_TYPE        	  ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.CHK_SEC_NM  	  ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_NM         ,32 ,DECRYPT);
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA( nDate, sztmp, 10);
		g_Str_TimeType(sztmp+8, Time_GetTime( ) );
		sql->Bind(sql, idx++, 'U', (long *)sztmp  , 14 ,DECRYPT);
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA( BettePlanymd, sztmp,10);
		sql->Bind(sql, idx++, 'U', (long *)sztmp , 8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.PHOTO           ,300,DECRYPT);		//���� ���ǰ� ����
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,15 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//-----------------------------------------------------------------
	void Shoto_Photo(void)
	{
		char sztmp[256];
		char szfilenm[256];
		char szScrPht[256];
		char szDirPath[256];
		char szNOT_PASS_ITEM_CD[3];
		long nRet, idx;
		long lrow, lcol;
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
				
		lrow = m_lActive/COL;
		lcol = m_lActive%COL;
		lrow--;
				
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		if( m_lActive < 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�׸��� �����ϼ���.");
			return;
		}
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, 2) );
		
		if( Str_Cmp( sztmp, CHKGOOD) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "������ �׸��� �����ϼ���.");
			return;
		}
		
		//���ϸ�
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, lrow, 0) );

		Str_Cpy(m_szfilenm , "1");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , stBsNogood.CHK_EXEC_NUM);
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(stBsNogood.MTR_NUM) > 0)
			Str_Cat(m_szfilenm , stBsNogood.MTR_NUM);
		else
			Str_Cat(m_szfilenm , "000000000");

		Str_Cat(m_szfilenm , "_");

		if(Str_Len(stBsNogood.BURNER_NUM) > 0)
			Str_Cat(m_szfilenm , stBsNogood.BURNER_NUM);
		else
			Str_Cat(m_szfilenm , "000000");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , stBsNogood.CHK_SEC_CD);
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , szNOT_PASS_ITEM_CD);
		Str_Cat(m_szfilenm , ".jjp");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_nPhotoFlag = 4;
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//��������
			//Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
			//���Ŀ��� Ȯ�ν�...
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
				
					VmSleep(100);
					FFS_Delete( szfilenm );
				}
				
			}
		}
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		long lrow = 0;
		char szNOT_PASS_ITEM_CD[10];
		char szResult[10];
		char szTmp[256];
		char szfilenm[256];
		char szMsg[150];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		long lcol ;
		lcol = m_lActive%COL;
		
		//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);
		CloseMessageBox();
		
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_CAMERA )
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
					SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);

					lrow = m_lActive/COL;
					lrow--;
					Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
					Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, lrow, 0) );
				
					Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
					SPRINT(szTmp, "UPDATE SPECIAL_NOGOOD_DETAL SET PHOTO = 'Y' WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
					g_Sql_DirectExecute( szTmp );

					// MessageBoxEx (CONFIRM_OK, stBsNogood.CHK_EXEC_NUM); //245720
					// MessageBoxEx (CONFIRM_OK, stBsNogood.CHK_SEC_CD);//50
					// MessageBoxEx (CONFIRM_OK, szNOT_PASS_ITEM_CD);

					

					Mem_Set((byte*)szResult ,0x00, sizeof(szResult) );
					// Str_Cat(szResult,szNOT_PASS_ITEM_CD);
					Str_Cat(szResult,"\n�Կ�O");

					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 0 ), GREEN);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 1 ), GREEN);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 2 ), GREEN);
					EditCtrl_SetStr(DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 0 ), szResult);	

					ON_DRAW();
					MessageBoxEx(MESSAGE, "������ ����� �׸��� \n �ʷϻ����� ��Ÿ���ϴ�.");
					
				}
				
			}
		}

		ON_DRAW();
		return;
	}
	
//----------------------------------------------------------------------------------------------
	void Photo_View(void)
	{
	char sztmp[256];
	char szfilenm[256];
	char szNOT_PASS_ITEM_CD[3];
		
		Mem_Set((byte*)szfilenm ,0x00, sizeof(szfilenm) );

		//���ϸ�
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3) );
		
		Str_Cpy(szfilenm , "1");
		Str_Cat(szfilenm , "_");
		Str_Cpy(szfilenm , stBsNogood.CHK_EXEC_NUM);
		Str_Cat(szfilenm , "_");
		if(Str_Len(stBsNogood.MTR_NUM) > 0)
			Str_Cat(szfilenm , stBsNogood.MTR_NUM);
		else
			Str_Cat(szfilenm , "000000000");
		Str_Cat(szfilenm , "_");
		if(Str_Len(stBsNogood.BURNER_NUM) > 0)
			Str_Cat(szfilenm , stBsNogood.BURNER_NUM);
		else
			Str_Cat(szfilenm , "000000");
		Str_Cat(szfilenm , "_");
		Str_Cat(szfilenm , stBsNogood.CHK_SEC_CD);
		Str_Cat(szfilenm , "_");
		Str_Cat(szfilenm , szNOT_PASS_ITEM_CD);
		Str_Cat(szfilenm , ".jjp");

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT (sztmp, "%s/%s",PHOTO_BS, szfilenm, 0);
		
		if(Str_Cmp(g_szDEVICE_NAME, "DS3") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 ) //PDA
		{
			if( FFS_Exist("\\windows\\iexplore.exe" ) )
			{
				RunApp( "iexplore.exe", szfilenm);
			}
			else if( FFS_Exist("\\windows\\iesample.exe" ) )
			{
				RunApp( "iesample.exe", szfilenm);
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "������ȸ ���α׷��� �����ϴ�.");
			}
		}
		else
		{		
			RunApp( "WEBVIEWER", sztmp);
		}
	}

	/*=======================================================================================
	�Լ��� : Chk_Photo
	��  �� : �����ո�� �������� ���� ���� Ȯ��
	Param  : 
	Return : 
	========================================================================================*/
	long Chk_Photo(void)
	{
		long lNogoodCnt, lPhotoCnt = 0;
		long lPreNogoodCnt,lPrePhotoCnt = 0;
		long lCount = 0;
		long lRet = 0;
		char szSql[400];
		char strMsg[100];
 
		// if(Str_Cmp(szPRE_CHK_OBJ_YN, "Y") != 0)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		g_Sql_RetInt( szSql, &lNogoodCnt );		

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PHOTO = 'Y' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		g_Sql_RetInt( szSql, &lPhotoCnt );

		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
		// SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PRE_CHK_OBJ_YN = 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		// g_Sql_RetInt( szSql, &lPreNogoodCnt );

		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PHOTO = 'Y' AND PRE_CHK_OBJ_YN = 'Y'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		// g_Sql_RetInt( szSql, &lPrePhotoCnt );
		
		if( lNogoodCnt == lPhotoCnt )
			{				
				lRet = 1;				
			}
			else
			{	
				lRet = 0;
			}

		return lRet;
	}

	/*=======================================================================================
	�Լ��� : SearchCD
	��  �� : �ڵ尪���� �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
				return i;
		}
		
		return -1;
	}
}

