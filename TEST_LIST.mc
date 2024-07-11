/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card TEST_LIST
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
		DEF_BUTTON_ID ( BID_QUICK )		//����
		DEF_BUTTON_ID ( BID_UP )		//�� ������
		DEF_BUTTON_ID ( BID_DOWN )		//�Ʒ� ������
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
		DEF_OBJECT_ID ( TXT_PAGE ) 		//������
		
		DEF_OBJECT_ID ( ID_TBLLIST ) 	// ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_SCROLL )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+20)			// table �� ����
	#define		GRID_H_P	(CHT+30)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX+20 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+140  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"����", CWD*15, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����", CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���", CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̰�", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	long    m_lSubIndex = -1;
	long    m_lSubpage = 0;
	long	m_ActIndex  = -1; 		// ���� ���� ROW
	long 	m_lpage = 0;			// ���� ������
	long 	m_lTotpage = 0;			// �� ������
	long 	m_lindex[ROW];			// �׷� ���� �ε���
	long    m_lIdxFlag = 0; 
	char 	m_szCnt_page[10];		// ������ ǥ�� ����
	
	bool	REDRAW(void);      //ȭ�� DLSPLAY
	void	SetStyle(void);
	void	SetBtnImg(void);
	void	ListTest(void);
	void	ListEvent(quad lParam);
	void	test_OzView(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����Ʈ �׽�Ʈ"),
		
		DLG_BUTTON(STARTX+20,  STARTY+70, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK, "�� ��"),
			
		DLG_TEXT(STARTX+20,    STARTY+810, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), //����������/��������
		DLG_BUTTON(STARTX+450, STARTY+810, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+725, STARTY+810, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),	
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_COMBO (STARTX+500, STARTY+70, 475, 290, 250, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SCROLL, 30),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "����Ʈ �� ��"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX+20,           70, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), //����������/��������
		
		DLG_BUTTON(STARTX+20,  STARTY+70, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK, "����ȣ��"),
		
		DLG_BUTTON(STARTX+530, STARTY+60, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+770, STARTY+60, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),			
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);

		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			ListEvent(lParam);
		}
		
		return TRUE;
	}


	//-----------------------------------------------------------------------
	void ListEvent(quad lParam)
	{
		g_Sql_SaveSeq( "SELECT ROWID FROM GUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE", SREACH_FILE);
//PRINT("lParam : %d",lParam,0,0);
		if( lParam > -1 )
		{
			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
	
			Card_Move("GM_ENTRY");
		}
		
		return;
	}
	

//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void	OnInit(char bFirst)
	{
		long i;
		long nRet;
	
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

			
				nRet = ScrlBar_SetThickness(Get_hDlgCtrlByID(CMB_SCROLL+2), 50);
PRINT(">>>>>>>>>>>>>>>>>>>>>>>>> nRet : %d",nRet,0,0);
				
				i = ScrlBar_GetThickness(Get_hDlgCtrlByID(CMB_SCROLL+2));
PRINT("22>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> i : %d",i,0,0);



				ON_DRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		//��ܰ���޴�
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
		char szSql[150];
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SCROLL), EDITALIGN_MIDDLE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		//SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY CAST(TEL_NUM AS NUMERIC) ASC ",0, 0, 0   );
		SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ",0, 0, 0);
		g_Sql_SetCombo(szSql, CMB_SCROLL+2);

	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_QUICK:
				//���� ȣ��
				//ListTest();
				
				//OZ�� ȣ��
				test_OzView();
				break;
			case BID_UP:
				m_lpage--;
				if( m_lpage < 0)
				{
					m_lpage = 0;

					if(m_lTotpage > 0)
					{
						if( m_ActIndex == -1 )
						{
							m_ActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_ActIndex = 0;
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage - 1 )
				{
					m_lpage = m_lTotpage-1;
					if( m_lpage < 0)
					{
						m_lpage = 0;
					}
					
					if(m_lTotpage > 0)
					{
						if( m_ActIndex == -1 )
						{
							m_ActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_ActIndex = 0;
				REDRAW();
				break;
			case GID_HOME:
				g_lMoveFlag = 0;
				Card_Move("TEST_MENU");
				break;
			case GID_MENU:
				g_lMoveFlag = 0;
				Card_Move("TEST_MENU");
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
				Card_Move("TEST_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}

//=======================================================================================
//=======================================================================================
	void	OnSelect(long Index)
	{
		long index = -1;
	}
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ�� �ڷḦ ���÷����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	bool REDRAW(void)
	{
		long i, idx;
		long j = 0;
		long index;
		long lstartidx = 0;
		char sztmp[200];
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//�׷� ����Ʈ�� �� ����
		g_Sql_RetInt("SELECT COUNT(*) FROM GUMGROUP", &m_lTotpage);
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, "SELECT TOWN, ADDR1_M, CNT, GMCNT, CNT-GMCNT, IDX FROM GUMGROUP ORDER BY SEQ LIMIT ?, ?");
		else
			hstmt = sql->CreateStatement(sql, "SELECT NEW_ROAD_NM, NEW_ADDR_M, CNT, GMCNT, CNT-GMCNT, IDX FROM GUMGROUP ORDER BY SEQ LIMIT ?, ?");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		for (i=0; i < ROW; i++)
		{
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
		}
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0; i < ROW; i++)
		{
			if(sql->Next(sql) == FALSE)
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				break;
			}

			idx = 0;
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			//��ħ����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			//��ħ�Ϸ����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			//�̰�ħ����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			//�ε��� ��			
			index = Str_AtoI(sztmp);
			m_lindex[i] = index;
		}
		
Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lTotpage > 0)
		{
			if( m_ActIndex < 0 )
			{
				m_ActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
			
			m_lIdxFlag = 1;
		}
		
		ON_DRAW();
		return ret;
	}
	
	
//---------------------------------------------------------------------------------------------------
/*
//opt 1 Ÿ��
//	{
//		  "title" : "����",  
//		  "item": [
//		    {"text":"��â��", "value":"2016-07-01"},
//		    {"text":"���׵�", "value":"2016-07-02"}
//		  ]
//	}	

//opt 2 Ÿ��
//	{
//		  "title" : "����",
//		  "dbname": "mydb.db3",
//		  "query" : "select col1, col2 from table where etc...",
//	}	

<<opt>>
#define		LISTCTRL_PLAIN			1
#define		LISTCTRL_QUERY			2

void ListCtrl_QuickView(char* pInData, long opt);
*/
	void ListTest(void)
	{
		handle js = NULL;
		char* sztmp;

//PRINT("00000000000 >>>>>>>>>>>>>>>> ListTest",0,0,0);
		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		JSON_SetValue ( js, 'C', "title", "��ħ �󼼸���Ʈ");
		JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
		//JSON_SetValue ( js, 'C', "query", "select cust_nm, ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') from gumdata");
		JSON_SetValue ( js, 'C', "query", "select ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(CUST_NM, '') ||' / D:'|| ifnull(BASE_YMD, '') ||' / C:'|| ifnull(MTR_WORK_CODE, '') ||' / ��ħ:'|| ifnull(INDI_SET_VC, '') ||' / ��뷮��:'|| ifnull(INDI_QTY, '') from gumdata");

/*
		JSON_AddArrayItem(js);
		JSON_SetArrayItem(js, 'C', "title", "test");
		JSON_SetArrayItem(js, 'C', "dbname", "APP_DBF/SCGGAS.db");
		JSON_SetArrayItem(js, 'C', "query", "select cust_nm from gumdata limit 0,20");
*/

		sztmp = JSON_toString(js);
		
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
	}
	
	
//-----------------------------------------------------------------
	void test_OzView(void)
	{
		handle h = NULL;
		handle header = NULL;
		handle body = NULL;
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			header = JSON_Create( JSON_Object );
			if(header == NULL)
			{
				goto Finally;
			}
			
			body = JSON_Create( JSON_Object );
		
			if(body == NULL)
			{
				goto Finally;
			} 
		
			//�ٵ� �Է� (����� ǥ�õ� �ʵ�)
			JSON_SetValue (body , 'C', "pmPatnm" , "(��)���������");
			JSON_SetValue (body , 'C', "pmAddr" , "����� ���ʱ� ��赿 828-1 �������� 3��");
			JSON_SetValue (body , 'C', "pmJumin" , "991231");
			JSON_SetValue (body , 'C', "pmPhone" , "010-1234-5678");
			JSON_SetValue (body , 'C', "pmEmail" , "pwrlove@valuecmd.co.kr");
			JSON_SetValue (body , 'C', "pmCurrentDate" , "2017-02-23");
			
			//��� �Է� (���� ������ ��û�� ��, url
			JSON_SetValue (header , 'C', "Ozserver" , GET_URL(OZ_BASE_URL));
			JSON_SetValue (header , 'C', "Formcode" , "00001");
			JSON_Attach (header  , "Paramdata" , body);
			
			//�ý����� ��û
			// { "method" : "�ý����� �Ž���", "data" : "json object ��Ʈ��" }
			JSON_SetValue (h , 'C', "method" , "OzViewActivity");
			JSON_Attach (h , "data" , header);
			
			System_Call ("Native_System_Call" , JSON_toString(h));
		}
		
Finally:
		
		if (h)
		{
			JSON_Finalize(h);
		} 
		
		if (header)
		{
			JSON_Finalize(header);
		}
		
		if (body)
		{
			JSON_Finalize(body);
		} 
	}

}

