/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_RSRVLST
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

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		//����
		DEF_BUTTON_ID ( BID_ADDR2 )		//���θ�
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�����ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//���θ��ּ� ��ũ�� ȣ��
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
		DEF_OBJECT_ID ( TXT_ADDR )
		DEF_OBJECT_ID ( TXT_ADDR2 )
		DEF_OBJECT_ID ( TXT_PAGE )		//������
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6					// table�� �ళ��
	#define		COL 	    6					// table�� ������
	#define		GRID_H		(CHT+42)			// table �� ����
	#define		GRID_H_P	(CHT+51)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+255  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"��",	 CWD*8+10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"������",   CWD*7+13,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ð�",     CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ȭ��ȣ", CWD*17,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�⺻�ּ�", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};		
	
	#define INIT_MAIN	1	
	
	long m_bFirst;
	long m_lstartidx = 0;
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lSelIndex = -1;
	char m_szCnt_page[20];		// ������ ǥ�� ����
	
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	long FS_GetSrchTotCnt(void);
	void SetComboIdx(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ����Ʈ"),
		
		DLG_BUTTON(STARTX,      STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
    	DLG_BUTTON(STARTX+250,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ�"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		DLG_BUTTON(STARTX+750,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),

		DLG_TEXT(STARTX,  STARTY+135, 1000, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),		//�ּ�2
		//DLG_TEXT(STARTX,  STARTY+200, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),	//�ּ�3
		
		DLG_TEXT(STARTX,       STARTY+825, 350, 74, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), //����������/��������
		DLG_BUTTON(STARTX+500, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+750, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+250,	STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ�"),
		
		DLG_TEXT(STARTX,		STARTY+40, 1000, 160, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),		//�ּ�2
		//DLG_TEXT(STARTX,		STARTY+100, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		//�ּ�3
		
		DLG_TEXT(STARTX,       STARTY+829, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_BUTTON(STARTX+500, STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+750, STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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
			g_Sql_SaveSeq( "SELECT ROWID FROM NORMAL_DATA WHERE ARG_DATE IS NOT NULL AND (SEND_YN = 'N' OR SEND_YN IS NULL OR SEND_YN = '') ORDER BY ARG_DATE", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			g_lMoveFlag = 1;
			g_nWorkFlag = 204;
			Set_Index();			
			
			Card_Move("SC_CONFIRM");
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
				REDRAW();
				break;
		}
	}
	
//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR), TRUE, 2, EDITSEP_NONE );
	}	

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		
		
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


//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		char szAddr[200];
	
		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			// ���� �ε����� ���� �ε����� ���� �� ���
			if ( index-1 == m_lSelIndex )
			{
				//���õ� ������ ��ġ INDEX�� �۷ι������� ����
				g_nActIndex = m_lpage*ROW + index - 1;
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				g_lMoveFlag = 1;
				g_nWorkFlag = 204;
				Set_Index();
				
				Card_Move("SC_CONFIRM");
				return;
			}
			else
			{
				m_lSelIndex = index - 1;
				
				//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
				Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
				Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
				Str_Cat(szAddr, "  ");
				Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), szAddr);
				
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
			}
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
			case BID_ADDR2:
				g_nAddrFlag = 1;
				REDRAW();
				break;	
			case BID_NEXTPG:
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
				m_lSelIndex = 0;
				REDRAW();
				break;
			case BID_PREVPG:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_lSelIndex = 0;
				REDRAW();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					Card_Move("MENU");			
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					Card_Move("SC_MENU");
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
				Card_Move("SC_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;

		}
	}		
	
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;	//i�� ��ġ�� �ʴ� ���ڷ� �ʱ�ȭ
		long lTotpage;
		char sztmp[201];
		char szRow[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Str_Cpy(szRow, "SELECT ROWID FROM NORMAL_DATA WHERE ARG_DATE IS NOT NULL AND (SEND_YN = 'N' OR SEND_YN IS NULL OR SEND_YN = '') ORDER BY ARG_DATE");

		g_Sql_SaveSeq( szRow, SREACH_FILE);
		
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

		if( g_lMoveFlag == 1 )
		{
			m_lpage = g_nActIndex / ROW;
			m_lSelIndex = (g_nActIndex % ROW);
			
			g_lMoveFlag = 0;
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
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
			hstmt = sql->CreateStatement(sql, "SELECT SINGLE_COLIVE_FLAG, CUST_NM, SubStr(ARG_DATE,5,2) ||'-'|| SubStr(ARG_DATE,7,2), SubStr(ARG_DATE,9,2) ||':'|| SubStr(ARG_DATE,11,2), ifnull(OWNHOUSE_TEL_DDD,CP_DDD) ||'-'|| ifnull(OWNHOUSE_TEL_EXN,CP_EXN) ||'-'|| ifnull(OWNHOUSE_TEL_NUM,CP_NUM), ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(HOUSE_CNT, '') ||' '|| ifnull(LOT_NUM_SECOND_ADDR, ''), ifnull(CO_LIVE_NM, '') ||' '|| ifnull(BLD_NM, '') ||' '|| ifnull(HOUSE_CNT, '') FROM NORMAL_DATA WHERE ARG_DATE IS NOT NULL AND (SEND_YN = 'N' OR SEND_YN IS NULL OR SEND_YN = '') ORDER BY ARG_DATE LIMIT ?,? ");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), FALSE );
			hstmt = sql->CreateStatement(sql, "SELECT SINGLE_COLIVE_FLAG, CUST_NM, SubStr(ARG_DATE,5,2) ||'-'|| SubStr(ARG_DATE,7,2), SubStr(ARG_DATE,9,2) ||':'|| SubStr(ARG_DATE,11,2), ifnull(OWNHOUSE_TEL_DDD,CP_DDD) ||'-'|| ifnull(OWNHOUSE_TEL_EXN,CP_EXN) ||'-'|| ifnull(OWNHOUSE_TEL_NUM,CP_NUM), ifnull(COUNTY,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(HOUSE_CNT, '') ||' '|| ifnull(LOT_NUM_SECOND_ADDR, ''), ifnull(CO_LIVE_NM, '') ||' '|| ifnull(BLD_NM, '') ||' '|| ifnull(HOUSE_CNT, '') FROM NORMAL_DATA WHERE ARG_DATE IS NOT NULL AND (SEND_YN = 'N' OR SEND_YN IS NULL OR SEND_YN = '') ORDER BY ARG_DATE  LIMIT ?,? ");
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
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
					continue;
				}
				
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 2 + 1, DECRYPT);
				if( Str_Cmp(sztmp, "10") == 0 )
				{
					//����
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 30 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//������
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 6 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					//�ð�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 6 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					//��ȭ��ȣ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 15 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					//�⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				}
				else if( Str_Cmp(sztmp, "20") == 0 )
				{
					//����
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//������
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					//�ð�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					//��ȭ��ȣ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					//�⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				}
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			if( m_lSelIndex < 0 )
			{
				m_lSelIndex = 0;
			}
		
			//m_lSelIndex
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
			Str_Cat(sztmp, "  ");
			Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), sztmp);
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
		}

		ON_DRAW();
		return;
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
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", g_lindex, 0, 0);
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
		SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '2' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);		
		m_lpage = g_nActIndex / ROW;
		m_lSelIndex = (g_nActIndex % ROW);
	}


//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetComboIdx(void)
	{
		long i, idx;
		long k = ROW+1;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		//g_szCHK_EXEC_NUM
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY HOUSE_NUM_ORD, DONG_ORD ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szSql, &lRow );

		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", lActIndex, 0, 0);		
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
			JSON_SetValue ( js, 'C', "title", "�������� ���ฮ��Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM, '') ||' '|| ifnull(BLD_NM, '') ||' '|| ifnull(HOUSE_CNT, '') ||' '|| ifnull(LOT_NUM_SECOND_ADDR, '') , ifnull(CUST_NM, '') ||' /������:'|| SubStr(ARG_DATE,5,2) ||'-'|| SubStr(ARG_DATE,7,2) ||' /�ð�:'|| SubStr(ARG_DATE,9,2) ||':'|| SubStr(ARG_DATE,11,2) ||' \n��ȭ��ȣ:'|| ifnull(OWNHOUSE_TEL_DDD,CP_DDD) ||'-'|| ifnull(OWNHOUSE_TEL_EXN,CP_EXN) ||'-'|| ifnull(OWNHOUSE_TEL_NUM,CP_NUM) FROM NORMAL_DATA WHERE ARG_DATE IS NOT NULL AND (SEND_YN = 'N' OR SEND_YN IS NULL OR SEND_YN = '') ORDER BY ARG_DATE");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "�������� ���ฮ��Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(CO_LIVE_NM, '') ||' '|| ifnull(BLD_NM, '') ||' '|| ifnull(HOUSE_CNT, '') ||' '|| ifnull(LOT_NUM_SECOND_ADDR, '') , ifnull(CUST_NM, '') ||' /������:'|| SubStr(ARG_DATE,5,2) ||'-'|| SubStr(ARG_DATE,7,2) ||' /�ð�:'|| SubStr(ARG_DATE,9,2) ||':'|| SubStr(ARG_DATE,11,2) ||' \n��ȭ��ȣ:'|| ifnull(OWNHOUSE_TEL_DDD,CP_DDD) ||'-'|| ifnull(OWNHOUSE_TEL_EXN,CP_EXN) ||'-'|| ifnull(OWNHOUSE_TEL_NUM,CP_NUM) FROM NORMAL_DATA WHERE ARG_DATE IS NOT NULL AND (SEND_YN = 'N' OR SEND_YN IS NULL OR SEND_YN = '') ORDER BY ARG_DATE");
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
		
		char col_name[5][32] = {"��", "������", "�ð�", "��ȭ��ȣ", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"2","2","2","3","0"};
		char col_align[5][10]  = {"center", "center", "center","left", ""};
		
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
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lSelIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", "SELECT \
 IFNULL(CUST_NM, ''), SUBSTR(ARG_DATE,5,2) ||'-'|| SUBSTR(ARG_DATE,7,2) \
 , SUBSTR(ARG_DATE,9,2) ||':'|| SUBSTR(ARG_DATE,11,2) , IFNULL(OWNHOUSE_TEL_DDD,CP_DDD) ||'-'|| IFNULL(OWNHOUSE_TEL_EXN,CP_EXN) ||'-'|| IFNULL(OWNHOUSE_TEL_NUM,CP_NUM) \
FROM NORMAL_DATA WHERE ARG_DATE IS NOT NULL AND (SEND_YN = 'N' OR SEND_YN IS NULL OR SEND_YN = '') ORDER BY ARG_DATE");
			
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
			
			JSON_SetValue	(h		, 'C', "title"			, "���� ����Ʈ");
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


