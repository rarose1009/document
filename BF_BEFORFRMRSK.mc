/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_BEFORFRMRSK
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
		
//	#define USE_ON_EXIT
//	#define USE_ON_CHARF
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_REFORM )	//�����Ϸ�
		DEF_BUTTON_ID ( BID_OK1 )		//Ȯ��
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
//���������Է�
		DEF_BUTTON_ID ( BID_OK2 )
		DEF_BUTTON_ID ( BID_REFSCHDL ) //������������
		
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
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )			
		DEF_OBJECT_ID ( TXT_BSUNIT )		//���˴���
		DEF_OBJECT_ID ( TXT_ITEMNM )		//�׸��
		DEF_OBJECT_ID ( TXT_CMBSTRNUM )		//���ұ��ȣ
		DEF_OBJECT_ID ( TXT_OBJNUM )		//�⹰��ȣ
		DEF_OBJECT_ID ( TXT_VISITDT )		//�湮�Ͻ�
		DEF_OBJECT_ID ( TXT_REFSCHDL2 )		//������������
		DEF_OBJECT_ID ( TXT_NUMBER )		//����
		DEF_OBJECT_ID ( TXT_REFORMDT )		//��������
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )

		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table�� �ళ��
	#define		COL 	    12					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_H_P	(CHT+30)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		51 				    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+65	  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY-40			// table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�������׸�",   CWD*19+23, EDITALIGN_MIDDLE,      			  TABLE_TEXT, 0},
		{"����������",   CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",         CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���˴���",     CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�׸��",       CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�⹰��ȣ",     CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���ұ��ȣ",   CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�湮�Ͻ�",     CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"������������", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��������",     CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���˴����ڵ�", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�����׸��ڵ�", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	char m_szCnt_page[10];
	char m_szChk_Cd[5];
	char m_szNotPass_Cd[5];
	char m_szEndDate[20];
	char m_szPlanDate[20];
	char m_szDegree[10];
	long m_lpage = 0;
	long m_lTotpage;
	long m_lActive = -1;
	long m_bFirst;
	
	void SetStyle(void);
	void REDRAW(void);
	void TBL_DRAW(void);
	void Save_BetterEnd(void);
	void Save_BetterYn(void);
	void SetBtnImg(void);
	void Clear_Screen(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ �׸�"),

		DLG_TEXT( STARTX,     STARTY+315, 350, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+350,STARTY+315, 325, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+675,STARTY+315, 325, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		
		DLG_TEXT( STARTX,     STARTY+380, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSUNIT, "���˴���"),
		DLG_TEXT( STARTX+350, STARTY+380, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT( STARTX,     STARTY+440, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEMNM, "�׸��"),
		DLG_TEXT( STARTX+350, STARTY+440, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT( STARTX,     STARTY+500, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+500, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT( STARTX,     STARTY+560, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "���ұ��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+560, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT( STARTX,     STARTY+620, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "�湮�Ͻ�"),
		DLG_TEXT( STARTX+350, STARTY+620, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT( STARTX,     STARTY+680, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFSCHDL2, "������������"),
		DLG_TEXT( STARTX+350, STARTY+680, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT(STARTX,      STARTY+740, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "��������"),
		DLG_TEXT(STARTX+350,  STARTY+740, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_BUTTON(STARTX+700,STARTY+740, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "�����Ϸ�"),
		
		DLG_BUTTON(STARTX+500, STARTY+815, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1, "Ȯ ��"),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "������ �׸�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),		
		
		DLG_TEXT( STARTX,     STARTY+305, 350, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500,STARTY+305, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750,STARTY+305, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		
		DLG_TEXT( STARTX,     STARTY+370, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSUNIT, "���˴���"),
		DLG_TEXT( STARTX+350, STARTY+370, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,      STARTY+430, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEMNM, "�׸��"),
		DLG_TEXT(STARTX+350,  STARTY+430, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT( STARTX,     STARTY+490, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+490, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT( STARTX,     STARTY+550, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "���ұ��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+550, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT( STARTX,     STARTY+610, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "�湮�Ͻ�"),
		DLG_TEXT( STARTX+350, STARTY+610, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT( STARTX,     STARTY+670, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFSCHDL2, "������������"),
		DLG_TEXT( STARTX+350, STARTY+670, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT(STARTX,     STARTY+730, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "��������"),
		DLG_TEXT(STARTX+350, STARTY+730, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_BUTTON(STARTX+700,STARTY+730, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "�����Ϸ�"),
		
		DLG_BUTTON(STARTX+200, STARTY+810, 600, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1, "Ȯ ��"),
		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSUNIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ITEMNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMBSTRNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISITDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFSCHDL2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFORMDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
	}

	//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	long d, k;
	char szDate[20];
	char szTmp[30];
	
		switch(ID)
		{
			case BID_PREVLST:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;
			case BID_NEXTLST:
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
				REDRAW();
				break;	
			case BID_REFORM:
				if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2), "����") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �����Ϸ� �Ǿ����ϴ�.");
					break;
				}
				
				if( MessageBoxEx (CONFIRM_YESNO, "������ �Ϸ� �Ͻðڽ��ϱ�?") == MB_OK )
				{
					Save_BetterEnd();
					Save_BetterYn();
					REDRAW();
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("BF_BEFOMENU");
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
				
			case BID_OK1:
			case GID_PREV:
				g_nBackFlag++;
				
				if( g_nBackFlag > 9 )
				{
					g_Db_Backup();
					g_nBackFlag = 0;
				}
			
				Card_Move("BF_BEFORFRMLST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
//-------------------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long index = -1;
		long lPage = 0;

		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_lActive = index-1;
				//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
				TBL_DRAW();

				lPage = m_lpage + index;
				SPRINT(m_szCnt_page, "%d/%d", lPage, m_lTotpage, 0);
				ON_DRAW();
			}
		}
	}
	
	//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW + 1;
		long lpage;
		char sztmp[401];
		char szDate[25];
		char szTime[9];
		char szCat[9];
		long ret = -1;	
		long lstartidx ;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' ",g_szCREATE_YMD, g_szMTR_NUM, 0   );
		g_Sql_RetInt( sztmp, &m_lTotpage );


		if( m_lActive == -1 )
		{
			m_lActive = 0;
		}
		
		lpage = m_lpage + m_lActive;
		SPRINT(m_szCnt_page, "%d/%d", lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, 
		" SELECT NOT_PASS_ITEM_NM, BETTER_PLAN_YMD, BETTER_YN, CHK_SEC_NM, NOT_PASS_ITEM_NM, MTR_ID_NUM, BURNER_NUM \
		, VISIT_DTM, BETTER_PLAN_YMD, BETTER_YMD, CHK_SEC_CD, NOT_PASS_ITEM_CD \
		FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD = ? AND MTR_NUM = ? LIMIT ?, ? "
		, 0, 0, 0 );
		hstmt = sql->CreateStatement(sql, sztmp);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)&g_szCREATE_YMD , 8, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)&g_szMTR_NUM ,    9, DECRYPT);
		lstartidx = m_lpage;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i,10, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i,11, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i,10, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i,11, "" );
					continue;
				}
				
				idx = 0;
				//������ �׸�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//����������
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 8  +1, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, szDate );
				//����  , Decode(BETTER_YN,'Y','����','�̰���')
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 1  +1, DECRYPT);
				if(sztmp[0] == 'Y')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "�̰���");	
				}
				//���˴���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//�׸��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//�⹰��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );			
				//���ұ��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 6  +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );	
				
				//�湮�Ͻ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
				Mem_Set( (byte*)szCat, 0x00, sizeof(szCat) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 14 +1, DECRYPT);
				Mem_Cpy((byte *)szDate, (byte *)sztmp, 8);
				Mem_Cpy((byte *)szCat, (byte *)sztmp+8, 6);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, szDate );	

				//������������
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 8  +1, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, szDate );

				//��������
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 8  +1, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, szDate );	
				
				//CHK_SEC_CD
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2  +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
				//NOT_PASS_ITEM_CD
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2  +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 11, sztmp );
			}
		}
		//sql->Commit(sql);
		
Finally:
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActive+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActive+1, TABLEACTIVE_COLOR);
			
			TBL_DRAW();
		}
		else
		{
			Clear_Screen();
		}
		
		ON_DRAW();
		return;
	}
	
	
//----------------------------------------------------------------------------------	
	void TBL_DRAW(void)
	{
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 6));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 7));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 8));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));
	}
	
//----------------------------------------------------------------------------------
	void Save_BetterEnd(void)
	{
		char sztmp[401];
		char szSql[401];
		char szdate[20];
		char szBURNER_NUM[7];
		char szCHK_SEC_CD[3];
		char szNOT_PASS_ITEM_CD[3];
		long idx;
		long nDate;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szCHK_SEC_CD, 0x00, sizeof(szCHK_SEC_CD) );
		Mem_Set( (byte*)szNOT_PASS_ITEM_CD, 0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set( (byte*)szBURNER_NUM, 0x00, sizeof(szBURNER_NUM) );
		
		//���ұ��ȣ
		Str_Cpy(szBURNER_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 6));
		//���˴����ڵ�, CHK_SEC_CD
		Str_Cpy(szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));

		//�����׸��ڵ�, NOT_PASS_ITEM_CD
		Str_Cpy(szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 11));

		//��������
		Mem_Set( (byte*)szdate, 0x00, sizeof(szdate) );
		Str_ItoA(Time_GetDate(), stBfNogood.BETTER_YMD, 10);
		
		nDate = Time_GetDate();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE BEFO_NOGOOD_DETAL SET BETTER_YMD = ?, BETTER_YN = 'Y', SEND_YN= 'S' \
					 , EMP_ID = ?, CRT_EMPID = ?, CRT_IP = ?, VISIT_DTM = ? \
					   WHERE CREATE_YMD = ? AND MTR_NUM = ? AND BURNER_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD = ? "
					, 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBfNogood.BETTER_YMD    ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,32,DECRYPT);

		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA( nDate, sztmp, 10);
		g_Str_TimeType(sztmp+8, Time_GetTime( ) );
		sql->Bind(sql, idx++, 'U', (long *)sztmp  , 14 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCREATE_YMD           ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM              ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szBURNER_NUM             ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szCHK_SEC_CD             ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_CD       ,2 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		//sql->Commit(sql);
		
Finally:
		DelSqLite(sql);
		return;
	}
	
//----------------------------------------------------------------------------------
	void Save_BetterYn(void)
	{
		char szSql[400];
		char szSql2[200];
		long lCnt = 0;
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL)"
		,g_szCREATE_YMD, g_szMTR_NUM, 0   );
		g_Sql_RetInt( szSql, &lCnt );

		if( lCnt == 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szSql2, 0x00, sizeof(szSql2) );
			SPRINT(szSql, "UPDATE BEFO_NOGOOD_MAIN SET SEND_YN='S', END_YN='Y', CRT_EMPID = '%s', CRT_IP = '%s'  "
			,stUserinfo.szemployee_id, stUserinfo.szpda_ip, 0   );
			SPRINT(szSql2, "WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s'  "
			,g_szCREATE_YMD, g_szMTR_NUM, 0   );
			
			Str_Cat(szSql, szSql2);
			g_Sql_DirectExecute( szSql );
		}
		
		return;
	}
	
//------------------------------------------------------------------
	void Clear_Screen(void)
	{
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)  , "");
	}
}


