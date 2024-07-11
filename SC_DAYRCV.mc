/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_DAYRCV
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
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_QUICK_CHK )		//체크 퀵뷰
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지
		DEF_BUTTON_ID ( BID_RECV )			//자료수신
		DEF_BUTTON_ID ( BID_ALL )			//자료수신
		DEF_BUTTON_ID ( BID_ADDR )			//지번/도로명
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )	//홈
		DEF_BUTTON_ID ( BID_MENU )	//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )	//이전
		DEF_BUTTON_ID ( BID_EXIT )	//종료
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( ICON_TITLE )	//
		DEF_OBJECT_ID ( TXT_PAGE )		//
		
		DEF_OBJECT_ID ( ID_TBLLIST ) // 테이블 리스트
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    8					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+43)			// table 행 높이
	#define		GRID_H_P	(CHT+53)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+125  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+30  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"그룹주소",      CWD*30,  EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"대상",          CWD*6 ,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"",              CWD*3+24,EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"BLD_NUM",       0 ,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"HOUSE_NUM_ORD", 0 ,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}

	};
	
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lTotCnt = 0;			// 총 갯수
	long m_lActive = -1;
	long m_msgflag = 0;
	long m_lAddrFlag = 0;		// = 0 지번, = 1 도로명
	
	char m_szCnt_page[10];
	char m_szchkyear[5];
	char m_szchkorder[3];
	char m_szchktype[3];
	char m_szobjym[7];
	char m_szzone_manage_num[6];
	long m_nCnt311311 = 0;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Save_Row(long row);
	
	long TR311311(void);
	void Rev311312(void);
	long TR311312(void);
	void Rev311313(void);
	long TR311313(void);
	void Rev311314(void);
	long TR311314(void);
	void Rev311315(void);
	long TR311315(void);
	void Rev311323(void);
	long TR311323(void);	
	void Rev311326(void);
	long TR311326(void);
	
	long Add_Item(handle pj);
	void Rcv_ScData(void);
	void Sel_All(void);
	
	void Grid_CheckLst(void);
	void Grid_CheckRet(char* szRet);
	
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
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "일일점검 자료수신"),
		
		DLG_TEXT(STARTX,        STARTY+65, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지	
		DLG_BUTTON(STARTX+250,  STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_CHK, "체크 퀵뷰"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "▲"),
		DLG_BUTTON(STARTX+750,  STARTY+65, 249, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "▼"),	
		
		DLG_TEXT(STARTX,       STARTY+833, 220, 66, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_BUTTON(STARTX+220, STARTY+833, 250, 66, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+470, STARTY+833, 280, 66, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ALL, "페이지선택"),
		DLG_BUTTON(STARTX+750, STARTY+833, 250, 66, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),	
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, 45, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "일일점검 자료수신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_TEXT(   STARTX,      STARTY-40, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지				
		DLG_BUTTON( STARTX+400,  STARTY-40, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON( STARTX+700,  STARTY-40, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),	
		
		DLG_TEXT(STARTX,		STARTY+829, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_BUTTON(STARTX+200,  STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+450,  STARTY+829, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ALL, "페이지선택"),
		DLG_BUTTON(STARTX+750,  STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-30, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		return TRUE;
	}
	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
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
				REDRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			//상단공통메뉴
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
			case BID_QUICK_CHK:
				Grid_CheckLst();
				break;
			case BID_ADDR:
				if( m_lAddrFlag == 0 )
				{
					m_lAddrFlag = 1;
				}
				else
				{
					m_lAddrFlag = 0;
				}
				REDRAW();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//REDRAW();
					break;
				}
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
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;
			case BID_ALL:
				Sel_All();
				REDRAW();
				break;
			case BID_RECV:
				m_nCnt311311 = 0;
				Rcv_ScData();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "안전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
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
				Card_Move("SC_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void	OnSelect(long Index)
	{
		long index = -1;
		char sztmp[20];
	
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
						
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, index-1, 2) );
			if( Str_Cmp( sztmp, CHKOFF) == 0 )
			{
				DlgTbl_SetStr ( ID_TBLLIST, index-1, 2, CHKON );
				EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, index-1, 2 ), RED);

			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, index-1, 2, CHKOFF );
				EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, index-1, 2 ), BLUE );
			}
			
			m_lActive = index - 1;
			Save_Row(m_lActive);
			ON_DRAW();
		}
		else
		{
			DlgTbl_SetActive(ID_TBLLIST, m_lActive+1);
			ON_DRAW();
		}
	}
	
/*	
	//──────────────────────────────────────────────
	void	OnExtctrl(long nEvent, long nData)
	{
		char* szRet;
		long nRet = 0;

PRINT("OnExtctrl : %d , nData : %d",nEvent,nData,0);		
		if( nEvent == 1 )
		{
			//OnList(lParam);
			szRet = (char*)System_GetResult((char*)&nRet);
			PRINT("EVENT >>>>>>>>>>>>>>>>>>>>>>quick view ret : %s",szRet,0,0);
			
		}
	}
*/

	//──────────────────────────────────────────────
	void	OnTask(long nEvent, long nData)
	{
		char* szRet;
		long nRet = 0;

		if( nEvent == 1 )
		{
			szRet = (char*)System_GetResult((char*)&nRet);
			//PRINT("EVENT >>>>>>>>>>>>>>>>>>>>>>quick view ret : %s",szRet,0,0);		
			
			Grid_CheckRet(szRet);	
		}
	}

	//──────────────────────────────────────────────
	void Save_Row(long row)
	{
	char sztmp[20];
	char szSql[300];
	char szBLD_NUM[11];
	char szHOUSE_NUM_ORD[11];
	char szCHK[2];
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szCHK ,0x00, sizeof(szCHK) );
		Mem_Set((byte*)szBLD_NUM ,0x00, sizeof(szBLD_NUM) );
		Mem_Set((byte*)szHOUSE_NUM_ORD ,0x00, sizeof(szHOUSE_NUM_ORD) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		
		Str_Cpy( szBLD_NUM,       DlgTbl_GetStr( ID_TBLLIST, row, 3) );
		Str_Cpy( szHOUSE_NUM_ORD, DlgTbl_GetStr( ID_TBLLIST, row, 4) );
		Str_Cpy( sztmp,           DlgTbl_GetStr( ID_TBLLIST, row, 2) );
		
		//선택된 경우
		if(Str_Cmp( sztmp, CHKON ) == 0)
		{
			szCHK[0] = 'Y';
		}
		else
		{
			szCHK[0] = 'N';
		}
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_GROUP SET CHK_YN = '%s' WHERE BLD_NUM = '%s' AND HOUSE_NUM_ORD= '%s' ", szCHK, szBLD_NUM, szHOUSE_NUM_ORD);
		g_Sql_DirectExecute( szSql );
	}
	
	void REDRAW(void)
	{
	long i, idx;
	long k = ROW + 1;
	char sztmp[201];
	long ret = -1;	
	long lstartidx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		g_Sql_RetInt( "SELECT COUNT(*) FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ", &m_lTotpage );
		
		m_lTotCnt = m_lTotpage;
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA(m_lTotpage , sztmp,10 );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1 ), sztmp);
		
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
			goto Finally;
		}

		if( m_lAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
			hstmt = sql->CreateStatement(sql, "SELECT COUNTY||' '|| TOWN ||' '|| ADDR1_M||CASE WHEN ADDR1_S =' ' THEN ' ' ELSE '-' END || ADDR1_S||' '||CO_LIVE_NM,  CNT, CHK_YN, BLD_NUM, HOUSE_NUM_ORD FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ORDER BY  HOUSE_NUM_ORD,TOWN,ADDR1_M,ADDR1_S,BLD_NUM LIMIT ?, ? " );
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
			hstmt = sql->CreateStatement(sql, "SELECT COUNTY||' '|| NEW_ROAD_NM ||' '|| NEW_ADDR_M ||'-'|| NEW_ADDR_S ||' '||CO_LIVE_NM,  CNT, CHK_YN, BLD_NUM, HOUSE_NUM_ORD FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ORDER BY  HOUSE_NUM_ORD,TOWN,ADDR1_M,ADDR1_S,BLD_NUM LIMIT ?, ? " );
		}
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
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
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
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
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				if(sztmp[0] != 'Y')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKOFF );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKON );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), RED);
				}	
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			}
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		ON_DRAW();
		return;
	}
	
	void Rcv_ScData(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret = 0;	
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT count(*) FROM NORMAL_GROUP WHERE CHK_YN = 'Y' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &ret);	
		if( ret <= 0 )
		{
			MessageBoxEx (CONFIRM_OK, "선택된 자료가 없습니다.");
			return;
		}

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '2' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, m_szchkyear);	
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '2' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 2, m_szchkorder);
			
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM4 FROM RCV_LOG WHERE GUBUN = '2' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 3, m_szchktype);	

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM3 FROM RCV_LOG WHERE GUBUN = '2' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 7, m_szobjym);	

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM6 FROM RCV_LOG WHERE GUBUN = '2' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 6, m_szzone_manage_num);
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311311, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",         m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311311; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311311_IN",  "FR311311" , sndbuf, sztmp );		
	}
	
	long TR311311(void)
	{
		m_nCnt311311 = g_Chk_Json(311311);
		if(m_nCnt311311 >= 0)
		{
			Rev311312();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev311312(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311312, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",         m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
	
		callBackfunc = TR311312; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311312_IN",  "FR311312" , sndbuf, sztmp );		
	}
	
	long TR311312(void)
	{
		if(g_Chk_Json(311312) >= 0)
		{
			Rev311313();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	
	void Rev311313(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311313, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",         m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
	
		callBackfunc = TR311313; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311313_IN",  "FR311313" , sndbuf, sztmp );		
	}
	
	long TR311313(void)
	{
		if(g_Chk_Json(311313) >= 0)
		{
			Rev311314();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev311314(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311314, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",         m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);

		callBackfunc = TR311314; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311314_IN",  "FR311314" , sndbuf, sztmp );		
	}
	
	long TR311314(void)
	{
	char szSql[256];
	
		if(g_Chk_Json(311314) >= 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE NORMAL_ADDR SET BEFO_ADDR1_M=ADDR1_M, BEFO_ADDR1_S=ADDR1_S, BEFO_NEW_ADDR_M=NEW_ADDR_M, BEFO_NEW_ADDR_S=NEW_ADDR_S  ", 0, 0, 0);
			g_Sql_DirectExecute( szSql );
			Rev311323();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev311323(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311323, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",        m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);

		callBackfunc = TR311323; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311323_IN",  "FR311323" , sndbuf, sztmp );		
	}
	
	long TR311323(void)
	{
	char szSql[256];
	
		if(g_Chk_Json(311323) >= 0)
		{
			Rev311315();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev311315(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311315, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",         m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
	
		callBackfunc = TR311315; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311315_IN",  "FR311315" , sndbuf, sztmp );		
	}
	
	// 2017.11.08 신기호 추가
	long TR311315(void)
	{
		char szSql[256];
	
		if(g_Chk_Json(311315) >= 0)
		{
			Rev311326();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*
	long TR311315(void)
	{
	char szSql[200];
		
		g_Sock_Close();
		
		if(g_Chk_Json(311315) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE NORMAL_GROUP SET SEND_YN = 'Y' WHERE CHK_YN = 'Y' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );

			if(m_nCnt311311 > 0)
				MessageBoxEx (CONFIRM_OK, "자료수신을 완료 했습니다.");
			else
				MessageBoxEx (CONFIRM_OK, "점검대상 자료가 없습니다!");
			m_lpage = 0;
			REDRAW();
			ON_DRAW();
			return 1;
		}
		else
		{
			
			return -1;
		}
	}
	*/
	
	void Rev311326(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311326, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",        m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",           m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
	
		callBackfunc = TR311326; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311326_IN",  "FR311326" , sndbuf, sztmp );		
	}
	
	long TR311326(void)
	{
		char szSql[200];
		
		g_Sock_Close();
		
		if(g_Chk_Json(311326) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE NORMAL_GROUP SET SEND_YN = 'Y' WHERE CHK_YN = 'Y' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );

			if(m_nCnt311311 > 0)
				MessageBoxEx (CONFIRM_OK, "자료수신을 완료 했습니다.");
			else
				MessageBoxEx (CONFIRM_OK, "점검대상 자료가 없습니다!");
			
			m_lpage = 0;
			
			REDRAW();
			ON_DRAW();
			
			return 1;
		}
		else
		{
			return -1;
		}
	}

	void Sel_All(void)
	{
		long i, idx;
		char szSql[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		char sztmp[21];
		long ret = -1;			
		char szBLD_NUM[11];
		char szHOUSE_NUM_ORD[11];
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "UPDATE NORMAL_GROUP SET CHK_YN = 'Y' WHERE BLD_NUM = ? AND HOUSE_NUM_ORD= ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		for (i=0 ; i<ROW ; i++)
		{
			Mem_Set((byte*)szBLD_NUM ,0x00, sizeof(szBLD_NUM) );
			Mem_Set((byte*)szHOUSE_NUM_ORD ,0x00, sizeof(szHOUSE_NUM_ORD) );
			
			Str_Cpy( szBLD_NUM,       DlgTbl_GetStr( ID_TBLLIST, i, 3) );
			Str_Cpy( szHOUSE_NUM_ORD, DlgTbl_GetStr( ID_TBLLIST, i, 4) );
			
			if( Str_Len(szBLD_NUM) == 0 )
			{
				break;
			}
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szBLD_NUM      	,12,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szHOUSE_NUM_ORD  ,10,DECRYPT);
			
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
		}
Finally:
		DelSqLite(sql);
		return;
	}
	
	long Add_Item(handle pj)
	{
		char szSql[500];
		char sztmp[20];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		handle js = NULL;
		char szbld_num[11];
		char szhouse_num_ord[11];

		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT house_num_ord, bld_num FROM NORMAL_GROUP WHERE CHK_YN = 'Y' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szhouse_num_ord,0x00, sizeof(szhouse_num_ord) );
			Mem_Set( (byte*)szbld_num,0x00, sizeof(szbld_num) );
			
			sql->GetValue(sql, 0, 'U', (long*)szhouse_num_ord, 11, DECRYPT);
			sql->GetValue(sql, 1, 'U', (long*)szbld_num, 11, DECRYPT);
			
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "house_num_ord",  szhouse_num_ord );
			JSON_SetArrayItem(js, 'C', "bld_num",        szbld_num );
			
			ret =1;
		}
		
		JSON_Attach(pj, "item", js);
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return ret;
	}
	
	//------------------------------------------------------------------------
	void Grid_CheckLst(void)
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
		
		char col_name[5][32] = {"그룹주소", "대상", "", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","1","1","0","0"};
		char col_align[5][10]  = {"left", "center", "center", "", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridCheckView");
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			//주소가 표시되는 필드가 존재해서 세로길이가 자동조절이 안된다면 
			//일반 퀵뷰리스트와 같이 높이 조절이 필요할거같습니다.
			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lActive;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			if( m_lAddrFlag == 0 )
			{
				JSON_SetValue	(hData	, 'C', "query",
"SELECT COUNTY ||' '|| TOWN ||' '|| ADDR1_M ||'-'|| ADDR1_S ||' '|| CO_LIVE_NM , CNT \
, CASE WHEN CHK_YN = 'Y' THEN 'Y' ELSE 'N' END FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ORDER BY HOUSE_NUM_ORD,TOWN,ADDR1_M,ADDR1_S,BLD_NUM"
								);
			}
			else
			{
				JSON_SetValue	(hData	, 'C', "query",
"SELECT COUNTY||' '|| NEW_ROAD_NM ||' '|| NEW_ADDR_M ||'-'|| NEW_ADDR_S ||' '||CO_LIVE_NM , CNT \
, CASE WHEN CHK_YN = 'Y' THEN 'Y' ELSE 'N' END FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ORDER BY HOUSE_NUM_ORD,TOWN,ADDR1_M,ADDR1_S,BLD_NUM"
								);
			}

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
			
			JSON_SetValue	(h		, 'C', "title"			, "일일점검자료수신");
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

/*
	//------------------------------------------------------------------------
	void Grid_CheckLst(void)
	{
		char szBuf[32];
		char szChk[32];
		char szTmp[256];
		long i;
		long check = 0;
		long start_position = 0;
		long idx = 0;
		long k = m_lTotCnt+1;		//임의의 큰 수로 초기화
		long lstartidx = 0;
		//json
		handle h = NULL;
		handle hHead = NULL;
		handle hData = NULL;
		handle hBody = NULL;
		//db
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		long col_height = 250;
		long col_count;
		char col_name[5][32] = {"그룹주소", "대상", "", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","1","1","0","0"};
		char col_align[5][10]  = {"left", "center", "center", "", ""};

		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			hBody = JSON_Create( JSON_Array );
			if(hBody == NULL)
			{
				goto Finally;
			}
			
			//JSON_SetValue	(hData	, 'C', "list_type"	, "CheckListView");
			JSON_SetValue	(hData	, 'C', "list_type"	, "GridCheckView");
			JSON_SetValue	(hData	, 'C', "bind_type"	, "json");				//json or query
			
			if( m_lActive < 0 )
			{
				m_lActive = 0;
			}
			JSON_SetValue	(hData	, 'X', "start_position"	, &m_lActive);
			
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false

			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

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

			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally;
			}
			
			hstmt = sql->CreateStatement(sql, "SELECT COUNTY ||' '|| TOWN ||' '|| ADDR1_M ||'-'|| ADDR1_S ||' '|| CO_LIVE_NM , CNT \
, CHK_YN FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ORDER BY HOUSE_NUM_ORD,TOWN,ADDR1_M,ADDR1_S,BLD_NUM" );
					
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
	
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
	
	
			while( sql->Next(sql) )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Mem_Set( (byte*)szChk, 0x00, sizeof(szChk) );
	
				idx = 0;
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 255+1 , DECRYPT);
				sql->GetValue(sql, idx++, 'U', (long*)szBuf, 20 +1 , DECRYPT);
				sql->GetValue(sql, idx++, 'U', (long*)szChk, 20 +1 , DECRYPT);
					
				JSON_AddArrayItem(hBody);
				JSON_SetArrayItem(hBody, 'C', "col_1", szTmp);
				JSON_SetArrayItem(hBody, 'C', "col_2", szBuf);
				
				if( Str_Cmp(szChk, "Y") == 0 )
				{
					Str_Cpy(szChk, "Y");
				}
				else
				{
					Str_Cpy(szChk, "N");
				}
				JSON_SetArrayItem(hBody, 'C', "check", szChk);
			}

			JSON_Attach 	(hData	, "body"			, hBody);
			
			JSON_SetValue	(h		, 'C', "title"		, "일일점검자료수신");
			JSON_SetValue	(h		, 'C', "method"		, "ListViewActivity");
			JSON_Attach 	(h		, "data"			, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		DelSqLite(sql);

		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hBody)
		{
			JSON_Finalize(hBody);
		}	
	}
*/

	//------------------------------------------------------------------------
	void Grid_CheckRet(char* szRet)
	{
		char szSql[3000];
		char szTmp[100];
		char szFile[10];
		long fd;
		long i = 0, k = 0, idx = 0;
		long lCnt = 0;
		long lRet = 0;
		long lRowid = 0;
		long *nCol;
		char *pStr;
		char *szitem;
		char szType[2] = {0,0};
		handle hitem = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hitem = JSON_Create( JSON_Array );
		
		if( hitem != NULL)
		{
			JSON_toJson(hitem, szRet ) ;
			lCnt = JSON_GetArrayCount( hitem );
			
			if( lCnt > 0 )
			{
				g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = 'N' WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL" );

				g_Sql_SaveSeq( "SELECT ROWID FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ORDER BY HOUSE_NUM_ORD,TOWN,ADDR1_M,ADDR1_S,BLD_NUM", SREACH_FILE);
//WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL
				fd = FFS_Open( SREACH_FILE, FS_READ_MODE, FS_NORMAL_FLAG);
				if(fd == -1)
				{
					MessageBoxEx (ERROR_OK, "파일을 찾을수 없습니다.");
					FFS_Flush(fd);
					FFS_Close(fd);
					return;
				}
				
				if( m_lTotCnt != lCnt )
				{
					Mem_Set((byte*) szSql, 0x00, sizeof( szSql) );
					Str_Cpy(szSql, "UPDATE NORMAL_GROUP SET CHK_YN = 'Y' WHERE ROWID IN (");
					for(i=0 ; i<lCnt ; i++)
					{
						Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
						nCol = (long*)JSON_GetArrayItem ( hitem, i, "check", szType);
						lRet = *nCol;
						//lRet = lRet+1;
						//PRINT("lRet : %d",lRet,0,0);
						
						//lRowid = g_SREACHFILE_GetSeq(SREACH_FILE, lRet);
						Mem_Set((byte*)szFile, 0x00, sizeof(szFile));
						if(FREAD(fd, lRet*SRCH_FS_SIZE+SRCH_FS_INDEX_POS, szFile, 8) == FALSE)
						{
							PRINT("Grid_CheckRet >> FREAD ERROR",0,0,0);
						  	FFS_Flush(fd);
							FFS_Close(fd);
							return;
						}
						if(Str_Len(szFile) == 0)
						{
							PRINT("Grid_CheckRet >> FILE LENGTH",0,0,0);
						  	FFS_Flush(fd);
							FFS_Close(fd);
							return;
						}
						lRowid = Str_AtoI(szFile);

						if(i > 0)
						{
							Str_Cat(szSql, ",");
						}

						Str_ItoA( lRowid, szTmp, 10);
						Str_Cat(szSql, szTmp);
						
						//PRINT("RCV_GRID_CHECK >>>>>> i : %d , Ret_Row : %s",i,szTmp,0);
						
					}
					
					Str_Cat(szSql, ")");
					//PRINT(">>>>>>>>>>>>>> %d , %s",Str_Len(szSql),szSql,0);
					g_Sql_DirectExecute( szSql );
				}
				else
				{
					g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = 'Y'" );
					
				}
				
				FFS_Flush(fd);
				FFS_Close(fd);
			}
			else
			{
				g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = 'N'" );

			}
		}
		else
		{
			g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = 'N'" );
		}
		
Finally:		
		
		if(hitem != NULL)
		{
			JSON_Finalize(hitem);
			hitem = NULL;
		}

		g_Close_SubDlg();
		
		REDRAW();

		return ;
	}
}

