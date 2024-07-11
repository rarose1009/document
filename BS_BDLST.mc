/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_BDLST
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
//	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
	//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
//����Ʈ
		DEF_BUTTON_ID ( BID_LIST_SEARCH )	//�˻�
		DEF_BUTTON_ID ( BID_ADDR )		//�ּ�
		DEF_BUTTON_ID ( BID_NADDR )		//���ּ�
		DEF_BUTTON_ID ( BID_UP )		//����������
		DEF_BUTTON_ID ( BID_DOWN )		//����������
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�����ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//���θ��ּ� ��ũ�� ȣ��
//�˻�
		DEF_BUTTON_ID ( BID_SEARCH1 )	//�⹰��ȣ��ȸ
		DEF_BUTTON_ID ( BID_SEARCH2 )	//�� �ּ���ȸ
		DEF_BUTTON_ID ( BID_SEARCH3 )	//�� �ּ���ȸ
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//����Ʈ
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )			//��������
		DEF_OBJECT_ID ( TXT_FIT )			// ����
		DEF_OBJECT_ID ( TXT_NOFIT )			// ������
		DEF_OBJECT_ID ( TXT_NOACTION )		// �̽ǽ�
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
//�˻�
		DEF_OBJECT_ID ( TXT_ALONE )			//�ܵ�(üũ�ڽ�)
		DEF_OBJECT_ID ( TXT_TOGETHER )		//����(üũ�ڽ�)
		DEF_OBJECT_ID ( TXT_OBJNUM )		//�⹰��ȣ
		DEF_OBJECT_ID ( TXT_ADDR)			//�ּ�
		DEF_OBJECT_ID ( TXT_GOO )			//��
		DEF_OBJECT_ID ( TXT_DONG )			//��
		DEF_OBJECT_ID ( TXT_BUNJI )			//����
		DEF_OBJECT_ID ( TXT_HOSOO )			//ȣ��
		DEF_OBJECT_ID ( TXT_BDNM )			//�ǹ���
		DEF_OBJECT_ID ( TXT_NWADDR )		//���ּ�
		DEF_OBJECT_ID ( TXT_NWGOO )			//��
		DEF_OBJECT_ID ( TXT_STREET )		//���θ�
		DEF_OBJECT_ID ( TXT_BONBUN )		//����
		DEF_OBJECT_ID ( TXT_BOOBUN )		//�ι�
		DEF_OBJECT_ID ( TXT_NBDNM )			//�ǹ���
//�˻�
		DEF_OBJECT_ID ( EDT_OBJNUM )		//�⹰��ȣ �Է�
		DEF_OBJECT_ID ( EDT_BUNJI )			//���� �Է�
		DEF_OBJECT_ID ( EDT_HOSOO )			//ȣ�� �Է�
		DEF_OBJECT_ID ( EDT_BDNM )			//�ǹ��� �Է�
		DEF_OBJECT_ID ( EDT_BONBUN )		//���� �Է�
		DEF_OBJECT_ID ( EDT_BOOBUN )		//�ι� �Է�
		DEF_OBJECT_ID ( EDT_NBDNM )			//�ǹ��� �Է�
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
//����Ʈ
		DEF_OBJECT_ID ( CMB_SELECT )
//�˻�
		DEF_OBJECT_ID ( CMB_GOO = CMB_SELECT+3 )		//��
		DEF_OBJECT_ID ( CMB_DONG = CMB_GOO+3 ) 			//��
		DEF_OBJECT_ID ( CMB_NWGOO = CMB_DONG+3 ) 		//��
		DEF_OBJECT_ID ( CMB_STREET = CMB_NWGOO+3 ) 		//���θ�
//����Ʈ
		DEF_OBJECT_ID ( ID_TBLLIST = CMB_STREET+3 )	// ���̺� ����Ʈ
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+32)			// table �� ����
	#define		GRID_H_P	(CHT+55)			// table �� ����
	#define		GRID_TTL_P	(CHT+10)			// table �� ���� , PDA Ÿ��Ʋ ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+250  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+120 	        // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�/����", CWD*23+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"�з�", 	  CWD*8 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���", 	  CWD*8 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���ּ�",  CWD*0 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"�켱���˿���",  CWD*0 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}

	};	
	
	#define INIT_MAIN	1	
	//#define INIT_SRCH	2
	
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nbuttonid = 0;		//m_nbuttonid = 0 ������ �˻� sql, m_nbuttonid = 1 �⹰��ȣ sql
	long m_nActIndex = -1;
	long m_lIdxFlag = 0;
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szAdrss[120];		// ��� �ּ� ǥ��
	char m_szSql[2][800];
	char m_szQuickSql[1000];
	char m_bFirst;				//INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	char m_szSqlFlag = 0;		//m_szSqlFlag = 0 - �⺻����Ʈ, m_szSqlFlag = 1 - �˻��� ����Ʈ
	char m_szCobSel[20];
	
	bool REDRAW(void);
	bool Search_Addr(long nbuttonid);
	long FS_GetSrchTotCnt(void);
	void SetStyle(void);
	void SetCombo(void);
	void Cmb_Result(void);
	void Cmb_Filter(void);
	void SetBtnImg(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	void SetComboIdx(void);
	void OnList(quad lParam);
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����Ư������ ���� ����"),
		
		DLG_BUTTON(STARTX,     STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+250, STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+500, STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		DLG_BUTTON(STARTX,     STARTY+185, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		DLG_BUTTON(STARTX+250, STARTY+185, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),
		
		DLG_TEXT(STARTX,       STARTY+65, 500, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������

		DLG_TEXT(STARTX,      STARTY+828, 140, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIT, "����"), 		//����
		DLG_TEXT(STARTX+140,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+310,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT, "������"), 	//������
		DLG_TEXT(STARTX+480,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 		//
		DLG_TEXT(STARTX+650,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOACTION, "�̽ǽ�"),	//�̽ǽ�
		DLG_TEXT(STARTX+820,  STARTY+828, 180, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//					
		
		DLG_COMBO (STARTX+500, STARTY+65, 500, 250, 150, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
				
		DLG_TEXT(STARTX,       STARTY-40, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		
		DLG_BUTTON(STARTX,     STARTY+40, 250, 80, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+250, STARTY+40, 250, 80, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+500, STARTY+40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),

		DLG_TEXT(STARTX,      STARTY+829, 185, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIT, "����"), 		//����
		DLG_TEXT(STARTX+185,  STARTY+829, 145, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+330,  STARTY+829, 185, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT, "������"), 	//������
		DLG_TEXT(STARTX+515,  STARTY+829, 145, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 		//
		DLG_TEXT(STARTX+660,  STARTY+829, 185, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOACTION, "�̽ǽ�"),	//�̽ǽ�
		DLG_TEXT(STARTX+845,  STARTY+829, 155, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//					
		
		DLG_COMBO (STARTX+500, STARTY-40, 500, 250, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_TTL_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
	};	

	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i;
		char szTmp[200];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			Set_Index();
			
			Card_Move("BS_CONFIRM");
		}
		
		return;
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

				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				
				if( g_nWorkFlag == 301 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "�̰�");
					Str_Cpy(m_szCobSel, "�̰�");							
				}
				else if ( g_nWorkFlag == 302 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "�켱");
					Str_Cpy(m_szCobSel, "�켱");			
				}
				else if ( g_nWorkFlag == 303 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "�Ϲ�");
					Str_Cpy(m_szCobSel, "�Ϲ�");			
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "��ü");
					Str_Cpy(m_szCobSel, "��ü");							
				}
				Cmb_Filter();
				REDRAW();
				break;
/*
			case INIT_SRCH:
				m_bFirst = bFirst;
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_Srch_P, SIZEOF(DlgRes_Srch_P));
						SetCombo();
						SetStyle();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Srch, SIZEOF(DlgRes_Srch));
						SetCombo();
						SetStyle();
						break;		
				}
				break;
*/
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
	void	OnButton(long ID)
	{	
		switch(ID)
		{	
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList(ID);
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;

				REDRAW();
				break;
			case BID_NADDR:
				g_nAddrFlag = 1;
				
				REDRAW();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;		
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 )
					{
						SetComboIdx();
					}
					else
					{
						Set_Index();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "Ư������ �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 )
					{
						SetComboIdx();
					}
					else
					{
						Set_Index();
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
				if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 )
				{
					SetComboIdx();
				}
				else
				{
					Set_Index();
				}
				Card_Move("BS_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		char szcmb[20];

		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_nActIndex )
				{
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					
					Set_Index();
					Card_Move("BS_CONFIRM");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ħ,�̰�ħ,��ü���)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "��ü" ) == 0 )
					g_nWorkFlag = 300;
				else if( Str_Cmp(m_szCobSel, "�̰�" ) == 0 )
					g_nWorkFlag = 301;
				else if( Str_Cmp(m_szCobSel, "�켱" ) == 0 )
					g_nWorkFlag = 302;
				else if( Str_Cmp(m_szCobSel, "�Ϲ�" ) == 0 )
					g_nWorkFlag = 303;
				m_lpage = 0;
				m_nActIndex = 0;
				Cmb_Filter();
				REDRAW();
			}
			else
			{
				REDRAW();
			}
		}
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ü", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "�̰�", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "�Ϲ�", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "�켱", 0, ICON_NONE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOFIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOACTION), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
/*
		else
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ALONE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TOGETHER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DONG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BUNJI), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HOSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BDNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWGOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STREET), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BONBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOOBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NBDNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OBJNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BUNJI), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_HOSOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BDNM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BONBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BOOBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_NBDNM), EDITALIGN_MIDDLE);
	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DONG), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_NWGOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_STREET), EDITALIGN_MIDDLE);
		}
*/
	}
	//-----------------------------------------------------------------
	void SetCombo(void)
	{
		g_Sql_SetCombo("SELECT COUNTY FROM SPECIAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_GOO+2);
		g_Sql_SetCombo("SELECT TOWN FROM SPECIAL_DATA WHERE TOWN IS NOT NULL GROUP BY TOWN", CMB_DONG+2);
		g_Sql_SetCombo("SELECT COUNTY FROM SPECIAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_NWGOO+2);
		g_Sql_SetCombo("SELECT NEW_ROAD_NM FROM SPECIAL_DATA WHERE NEW_ROAD_NM IS NOT NULL GROUP BY NEW_ROAD_NM", CMB_STREET+2);
	}

	//------------------------------------------------------------------------------------------
	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW + 1;
		long lTotpage;
		char sztmp[201];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		lTotpage = FS_GetSrchTotCnt();
		m_lTotpage = lTotpage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0 )
		{
			Get_Index();
		}
		
		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotpage);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
			hstmt = sql->CreateStatement(sql, m_szSql[1]);
		}
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
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
					continue;
				}
				//�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				idx = 0;
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//�з�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				if(sztmp[0] == 'L')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "����" );
				else if(sztmp[0] == 'M')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�߾�");
				else if(sztmp[0] == 'R')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�߰���" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 1,  "");
				//���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				if(Str_Cmp(sztmp, "20") == 0)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLACK);
				}
				else if(Str_Cmp(sztmp, "21") == 0)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "������");
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else if(Str_Cmp(sztmp, "40") == 0)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLACK);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "�̰�");	
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLACK);
				}
				
				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				//�켱���˿���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				
				if( Str_Len(sztmp) > 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BLUE);
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTFRCOLOR);
				}
			}
		}
			
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
			
			Cmb_Result();
			
			m_lIdxFlag = 1;
		}
		
		ON_DRAW();
		return TRUE;
	}

//------------------------------------------------------------------------------------------
	bool Search_Addr(long nbuttonid)
	{
		char szWhere[400];
		char szObj[400];
		char szSql[600];
		long chki= 0;
	
	  	Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		Mem_Set( (byte*)szObj, 0x00, sizeof(szObj) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		
		
		if( nbuttonid == BID_SEARCH1 )
		{
			Str_Cpy( szSql, "SELECT A.ROWID FROM SPECIAL_DATA A INNER JOIN SPECIAL_MTR B ON A.CHK_EXEC_NUM == B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[0], "SELECT ifnull(A.TOWN,' ') ||' '|| ifnull(A.ADDR1_M,' ') ||' '|| ifnull(A.ADDR1_S,' ') ||' '|| ifnull(A.SECOND_ADDR,' '), A.PRESS_FLAG, A.CHK_RSLT,  ifnull(A.BLD_DONG,' ')||'-'||ifnull(A.HOSU,' ') FROM SPECIAL_DATA A INNER JOIN SPECIAL_MTR B ON A.CHK_EXEC_NUM == B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[1], "SELECT ifnull(A.NEW_ROAD_NM,' ') ||' '|| ifnull(A.NEW_ADDR_M,' ') ||' '|| ifnull(A.NEW_ADDR_S,' '), A.PRESS_FLAG, A.CHK_RSLT,  ifnull(A.BLD_DONG,' ')||'-'||ifnull(A.NEW_HOSU,' ') FROM SPECIAL_DATA A INNER JOIN SPECIAL_MTR B ON A.CHK_EXEC_NUM == B.CHK_EXEC_NUM WHERE ");

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OBJNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ�� �Է��ϼ���.");
				return FALSE;
			}
			m_nbuttonid = 1;		//sql�� ����
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OBJNUM) ) > 0   ) 
			{
				Mem_Set( (byte*)szObj, 0x00, sizeof(szObj) );
				Str_Cat( szObj, "B.MTR_ID_NUM == '" );
				Str_Cat( szObj, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_OBJNUM) ) );
				Str_Cat( szObj, "' " );
				
				Str_Cat( szSql, szObj );
				Str_Cat( m_szSql[0], szObj );
				Str_Cat( m_szSql[1], szObj );
			}			
		}
		else if( nbuttonid == BID_SEARCH2 )
		{	
	
			Str_Cpy( szSql, "SELECT ROWID FROM SPECIAL_DATA WHERE ");
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT,  ifnull(BLD_DONG,' ') ||' '|| ifnull(HOSU,' ') FROM SPECIAL_DATA WHERE ");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||' '|| ifnull(NEW_ADDR_S,' '), PRESS_FLAG, CHK_RSLT, ifnull(BLD_DONG,' ') ||'-'|| ifnull(NEW_HOSU,' ') FROM SPECIAL_DATA WHERE ");

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_GOO)) == 0  
			&&  EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DONG)) == 0  
			&&  EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BUNJI)) == 0  
			&&  EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HOSOO)) == 0  
        	)
			{
				MessageBoxEx (CONFIRM_OK, "(��)�ּ� ������ �Է��ϼ���.");
				return FALSE;
			}
			m_nbuttonid = 0;		//sql�� ����
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_GOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "COUNTY like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_GOO) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DONG) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "TOWN like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DONG) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BUNJI) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_M like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BUNJI) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HOSOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_S like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_HOSOO) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BDNM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "BLD_DONG like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BDNM) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		else if( nbuttonid == BID_SEARCH3 )
		{	
			Str_Cpy( szSql, "SELECT ROWID FROM SPECIAL_DATA WHERE ");
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT,  ifnull(BLD_DONG,' ') ||' '|| ifnull(HOSU,' ') FROM SPECIAL_DATA WHERE ");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||' '|| ifnull(NEW_ADDR_S,' '), PRESS_FLAG, CHK_RSLT,, ifnull(BLD_DONG,' ') ||'-'|| ifnull(NEW_HOSU,' ') FROM SPECIAL_DATA WHERE ");
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_NWGOO)) == 0
			&&  EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_STREET)) == 0
			&&  EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BONBUN)) == 0
			&&  EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BOOBUN)) == 0
			)
			{
				MessageBoxEx (CONFIRM_OK, "(��)�ּ� ������ �Է��ϼ���.");
				return FALSE;
			}
			m_nbuttonid = 0;		//sql�� ����
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_NWGOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "COUNTY like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_NWGOO) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_STREET) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ROAD_NM like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_STREET) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BONBUN) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_M like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BONBUN) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BOOBUN) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_S like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BOOBUN) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_NBDNM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "BLD_DONG like '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_NBDNM) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}

		if( nbuttonid == BID_SEARCH1 )
		{
			Str_Cat( szSql, "ORDER BY A.ROWID");
			Str_Cat( m_szSql[0], "ORDER BY A.ROWID LIMIT ?,?");
			Str_Cat( m_szSql[1], "ORDER BY A.ROWID LIMIT ?,?");
			g_Sql_SaveSeq( szSql, SREACH_FILE);

		}
		else
		{
			Str_Cat( szSql, "ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			Str_Cat( m_szSql[0], "ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?,?");
			Str_Cat( m_szSql[1], "ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?,?");
			
		}
		//�������� �ʱ�ȭ��Ų��.
		m_lpage = 0;
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		return TRUE;
	}

	/*=======================================================================================
	�Լ��� : FS_GetSrchTotCnt
	��  �� : �˻��ε��������� ���ڵ� ���� �����Ѵ�.
	Param  : nPos:�˻� �ε��� ������ ����
 	Return : ���ڵ��
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;
		
		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}
	
	//-----------------------------------------------------------------------------------------------
	//�޺��ڽ��� �̿��� ��ü,����,������ ��� ����
	//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[300];

		if( Str_Cmp(m_szCobSel, "�̰�") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null  ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 301;
		}
		else if( Str_Cmp(m_szCobSel, "�켱") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 302;
		}
		else if( Str_Cmp(m_szCobSel, "�Ϲ�") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA WHERE TRIM(PREUSE_CHK_WHY) IS NULL ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 303;
		}
		else // if( Str_Cmp(m_szCobSel, "��ü") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 300;
		}

		g_Sql_SaveSeq( szRow, SREACH_FILE);
	
		if( Str_Cmp(m_szCobSel, "�̰�") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT,  ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ? , ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ? , ?");
		}
		else if ( Str_Cmp(m_szCobSel, "�켱") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
		}
		else if ( Str_Cmp(m_szCobSel, "�Ϲ�") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE TRIM(PREUSE_CHK_WHY) IS NULL ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE TRIM(PREUSE_CHK_WHY) IS NULL ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
		}
		else
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
		}
	}
	
	//-----------------------------------------------------------------------------------------------
	//�޺��ڽ��� �̿��� ��ü,����,������ ��� ����, ��� ��� Ȯ�κκ�
	//-----------------------------------------------------------------------------------------------
	void Cmb_Result(void)
	{
		char sztmp[20];
		char szSql[300];
		
		if( Str_Cmp(m_szCobSel, "��ü") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '20' ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '21' ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE (( CHK_RSLT <> '20' AND CHK_RSLT <> '21' ) OR CHK_RSLT IS NULL) ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
		}
		else if( Str_Cmp(m_szCobSel, "�̰�") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			//g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '20' AND (SEND_YN = 'N' OR SEND_YN IS NULL)", 4 , sztmp );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '20' AND (( CHK_RSLT <> '20' AND CHK_RSLT <> '21' ) OR CHK_RSLT IS NULL)", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '21' AND (( CHK_RSLT <> '20' AND CHK_RSLT <> '21' ) OR CHK_RSLT IS NULL) ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			//g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE (SEND_YN = 'N' OR SEND_YN IS NULL) AND (( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null) ", 4 , sztmp );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE (( CHK_RSLT <> '20' AND CHK_RSLT <> '21' ) OR CHK_RSLT IS NULL) ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
		}
		else if( Str_Cmp(m_szCobSel, "�켱") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '20' AND LENGTH(PREUSE_CHK_WHY) > 0 ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '21' AND LENGTH(PREUSE_CHK_WHY) > 0 ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE (( CHK_RSLT <> '20' AND CHK_RSLT <> '21' ) OR CHK_RSLT IS NULL) AND LENGTH(PREUSE_CHK_WHY) > 0 ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
		}
		else if( Str_Cmp(m_szCobSel, "�Ϲ�") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '20' AND TRIM(PREUSE_CHK_WHY) IS NULL ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE CHK_RSLT = '21' AND TRIM(PREUSE_CHK_WHY) IS NULL ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM SPECIAL_DATA WHERE (( CHK_RSLT <> '20' AND CHK_RSLT <> '21' ) OR CHK_RSLT IS NULL) AND TRIM(PREUSE_CHK_WHY) IS NULL ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
		}
	}
	
	
	/*=======================================================================================
	�Լ��� : Set_Index
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
	Return : TRUE :����
			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '5' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}
	
	/*=======================================================================================
	�Լ��� : Get_Index
	��  �� : ���� �ε��� �о�´�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Get_Index(void)
	{
		char szSql[201];
		char szbuf[10];
				
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '5' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);		
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = (g_nActIndex % ROW);
	}
	
	
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetComboIdx(void)
	{
		long i, idx;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		//g_szCHK_EXEC_NUM
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szSql, &lRow );

		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '5' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);

		return;
	}
	
	
//---------------------------------------------------------------------------------------------------------------
	void QuickList(long nBtnID)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		//nAddrType = 0 ���� ,, nAddrType = 1 ���θ�
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "Ư������ ���Ҽ���");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), ifnull(SPECIAL_NM, '') ||' / �з�:'|| Case When PRESS_FLAG = 'L' Then '����' When PRESS_FLAG = 'M' Then '�߾�' When PRESS_FLAG = 'R' Then '�߰���' Else '' End ||' / ���:'|| Case When CHK_RSLT = '20' Then '����' When CHK_RSLT = '21' Then '������' When CHK_RSLT = '40' Then '����' Else '�̰�' End FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "Ư������ ���Ҽ���");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), ifnull(SPECIAL_NM, '') ||' / �з�:'|| Case When PRESS_FLAG = 'L' Then '����' When PRESS_FLAG = 'M' Then '�߾�' When PRESS_FLAG = 'R' Then '�߰���' Else '' End ||' / ���:'|| Case When CHK_RSLT = '20' Then '����' When CHK_RSLT = '21' Then '������' When CHK_RSLT = '40' Then '����' Else '�̰�' End FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}

		sztmp = JSON_toString(js);
		
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
	}
	
	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(long nBtnID)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"�ּ�/����", "�з�", "���", "", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","2","2","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( nBtnID == BID_QUICK_ADDR )
		{
			Str_Cpy(m_szQuickSql, "SELECT \
IFNULL(TOWN,' ') ||' '|| IFNULL(ADDR1_M,' ') ||'-'|| IFNULL(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' ') \
, CASE WHEN PRESS_FLAG = 'L' THEN '����' WHEN PRESS_FLAG = 'M' THEN '�߾�' WHEN PRESS_FLAG = 'R' THEN '�߰���' ELSE '' END \
, CASE WHEN CHK_RSLT = '20' THEN '����' WHEN CHK_RSLT = '21' THEN '������' WHEN CHK_RSLT = '40' THEN '����' ELSE '�̰�' END \
FROM SPECIAL_DATA ");
		}
		else
		{
			Str_Cpy(m_szQuickSql, "SELECT \
ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||' '|| ifnull(SPECIAL_NM,' ') \
, CASE WHEN PRESS_FLAG = 'L' THEN '����' WHEN PRESS_FLAG = 'M' THEN '�߾�' WHEN PRESS_FLAG = 'R' THEN '�߰���' ELSE '' END \
, CASE WHEN CHK_RSLT = '20' THEN '����' WHEN CHK_RSLT = '21' THEN '������' WHEN CHK_RSLT = '40' THEN '����' ELSE '�̰�' END \
FROM SPECIAL_DATA ");
		}
		

		if( Str_Cmp(m_szCobSel, "�̰�" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		if( Str_Cmp(m_szCobSel, "�켱" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		if( Str_Cmp(m_szCobSel, "�Ϲ�" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE TRIM(PREUSE_CHK_WHY) IS NULL ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		else //if( Str_Cmp(m_szCobSel, "��ü" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			//�� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ����
			//true�� �� �־�� �Ѵ�.
			//���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ���
			//���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szQuickSql);
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "���� ����");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}

}
