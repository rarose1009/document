/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_BEFOTGTLST
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
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
//리스트
		DEF_BUTTON_ID ( BID_SIGN )
		DEF_BUTTON_ID ( BID_ADDR )		//주소
		DEF_BUTTON_ID ( BID_UP )		//이전페이지
		DEF_BUTTON_ID ( BID_DOWN )		//다음페이지
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//도로명주소 스크롤 호출
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//리스트
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//총페이지
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
//리스트
		DEF_OBJECT_ID ( CMB_SELECT )
//리스트
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    8					// table의 행개수
	#define		COL 	    7					// table의 열개수
	#define		GRID_H		(CHT+28)			// table 행 높이
	#define		GRID_H_P	(CHT+40)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+285  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    // table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"공동주택명", CWD*21+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"대상",       CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"점검",       CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"서명",       CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상세주소",   CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"건물번호",   CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"ROWID",      CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1	
	
	long m_lIdxFlag = 0;
	long m_lSubIndex = -1;
	long m_lSubpage = 0;
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_nbuttonid = 0;		//m_nbuttonid = 0 나머지 검색 sql, m_nbuttonid = 1 기물번호 sql
	long m_nActIndex = -1;
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szAdrss[120];		// 상단 주소 표시
	char m_szSql[2][1000];
	char m_szQuickSql[1200];
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	char m_szSqlFlag = 0;		//m_szSqlFlag = 0 - 기본리스트, m_szSqlFlag = 1 - 검색된 리스트
	char m_szCobSel[20];
	
	void REDRAW(void);
	void Cmb_Filter(void);
	void SetStyle(void);
	bool Save_TotSign(void);
	bool Update_Nogood(void);
	void SetBtnImg(void);
	void SET_HDINDEX(void);
	void GET_HDINDEX(void);
	void SET_DTLINDEX(void);	//상세리스트 인덱스
	void SetComboIdx(void);
	void OnList(quad lParam);
	void QuickList(long nBtnID);
	void Grid_QuickList(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공급전 안전점검(공동)"),
		
		DLG_BUTTON(STARTX+666,  STARTY+65, 334, 60, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "일괄서명"),
		
		DLG_BUTTON(STARTX    , STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+250, STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "퀵뷰\n스크롤"),
//		DLG_BUTTON(STARTX+420, STARTY+200, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		DLG_BUTTON(STARTX+500, STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),				
		
		DLG_TEXT(STARTX,      STARTY+65,   333, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		DLG_TEXT(STARTX,      STARTY+125,  1000, 95, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//
		
		DLG_COMBO (STARTX+333, STARTY+65, 333, 250, 130, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "공급전 안전점검(공동)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
				
		DLG_BUTTON(STARTX+600,  STARTY-40, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "일괄서명"),
		DLG_BUTTON(STARTX    , STARTY+120, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+500, STARTY+120, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+120, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),				
		
		DLG_TEXT(STARTX,      STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		DLG_TEXT(STARTX,      STARTY+40, 1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//
		
		DLG_COMBO (STARTX+250, STARTY-40, 380, 350, 130, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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
		char szTmp[150];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Mem_Set((byte*)g_szROWID, 0x00, sizeof(g_szROWID));
			Str_ItoA(g_lindex, g_szROWID, 10);

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)g_szBLD_NUM, 0x00, sizeof(g_szBLD_NUM));
			SPRINT(szTmp, "SELECT BLD_NUM FROM BEFO_DATA WHERE  ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 10, g_szBLD_NUM);

			g_lDataflag = 0;
			g_lGrpCmbFlag = g_nWorkFlag;
			SET_HDINDEX();
			
			Card_Move("BF_BEFODETALST");
		}
		
		return;
	}

	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
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
				
				if( g_lGrpCmbFlag == 511 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), g_szTown);
					Str_Cpy(m_szCobSel, g_szTown);							
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "전체");
					Str_Cpy(m_szCobSel, "전체");							
				}

				Cmb_Filter();
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
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList();
				break;
			case BID_SIGN:
				if( Save_TotSign() )
				{
					Cmb_Filter();
					REDRAW();
				}
				break;
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
					//ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "도로명\n스크롤");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
					//ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "지번\n스크롤");
				}

				REDRAW();
				if(m_nActIndex >= 0)
				{					
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
				}
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//REDRAW();
					return;
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
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//REDRAW();
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;		
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					if( g_lGrpCmbFlag == 510 )
					{
						SET_HDINDEX();
					}
					else
					{
						SetComboIdx();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "공급전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					if( g_lGrpCmbFlag == 510 )
					{
						SET_HDINDEX();
					}
					else
					{
						SetComboIdx();
					}
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
			case GID_PREV:
				if( g_lGrpCmbFlag == 510 )
				{
					SET_HDINDEX();
				}
				else
				{
					SetComboIdx();
				}
				Card_Move("BF_BEFOMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		char szcmb[20];

		if( INIT_MAIN == m_bFirst )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				if ( index-1 == m_nActIndex )
				{
					g_lDataflag = 0;	//점검화면 SaveInput() 적용/미적용 flag
					
					g_nGrpIndex = m_lpage*ROW + index - 1;
					
					if( (m_lSubIndex != m_nActIndex) || (m_lSubpage != m_lpage) )
					{
						SET_DTLINDEX();
					}
					
					SET_HDINDEX();
					
					g_lGrpCmbFlag = g_nWorkFlag;
					
					Card_Move("BF_BEFODETALST");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//선택된 INDEX 저장
				
					Mem_Set( (byte*)g_szBLD_NUM, 0x00, sizeof(g_szBLD_NUM) );
					Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID) );
					//처음 선택된 대상의 주소를 상단에 표시
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
					Str_Cpy(g_szBLD_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
					Str_Cpy(g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					
					return;
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//콤보박스 선택으로 리스트 목록 필터링.(검침,미검침,전체대상)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				//페이지를 초기화시킨다.
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
					g_nWorkFlag = 510;
				else if( Str_Cmp(m_szCobSel, szcmb) == 0 )
				{
					g_nWorkFlag = 511;
					Mem_Set((byte*)g_szTown, 0x00, sizeof(g_szTown));
					Str_Cpy(g_szTown, szcmb);
				}
				
				m_lpage = 0;
				m_nActIndex = 0;
				Cmb_Filter();
				REDRAW();
			}
		}
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "전체", 0, ICON_NONE);
		g_Sql_SetCombo("SELECT TOWN FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY TOWN ORDER BY TOWN", CMB_SELECT+2);

		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SELECT), "전체");
		
		m_lpage = g_nGrpIndex/ROW;
		m_nActIndex = g_nGrpIndex% ROW+1;
	}

/*=======================================================================================
함수명 : REDRAW
기  능 : 화면 자료를 디스플레이한다.
Param  : 
Return : TRUE :성공
		 FALSE:파일이 없을시에 실패
========================================================================================*/
	void REDRAW(void)
	{
		long i, idx;
		long j = 0;
		long index;
		long lstartidx = 0;
		char sztmp[256];
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//그룹 리스트의 총 갯수
		g_Sql_RetInt("select count(A.BLD_NUM) from (SELECT  BLD_NUM FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM) A", &m_lTotpage);

		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
/*
		if( m_lpage > m_lTotpage )
		{
			m_lpage = m_lTotpage;
		}
*/
		if( m_lIdxFlag == 0 )
		{
			GET_HDINDEX();
		}

		if( m_nActIndex == -1 )
		{
			m_nActIndex = 0;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		}
		else
		{
			hstmt = sql->CreateStatement(sql, m_szSql[1]);
		}

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
			goto Finally;
		}
		
		for (i=0; i < ROW; i++)
		{
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
		}
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0; i < ROW; i++)
		{
			if(sql->Next(sql) == FALSE)
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				break;
			}

			idx = 0;
			//공동주택명
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
			//대상수
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5   +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			//점검수
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5   +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			//서명완료수
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5   +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			//상세 주소
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			//건물번호
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30  +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
			//ROWID
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5  +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
		}
		//sql->Commit(sql);
		
Finally:
		DelSqLite(sql);

		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)g_szBLD_NUM, 0x00, sizeof(g_szBLD_NUM) );
			Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID) );
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			Str_Cpy(g_szBLD_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			Str_Cpy(g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			
			m_lIdxFlag = 1;
		}

		return;
	}
	
	//-----------------------------------------------------------------------------------------------
	//콤보박스를 이용한 전체,점검,미점검 목록 필터m_szCobSel
	//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[600];

		Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		if( Str_Cmp(m_szCobSel, "전체") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM");
			g_nWorkFlag = 510;
		}
		else
		{
			SPRINT(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND TOWN = '%s' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", g_szTown, 0, 0 );
			g_nWorkFlag = 511;
		}

		g_Sql_SaveSeq( szRow, SREACH_FILE);

		if( Str_Cmp(m_szCobSel, "전체") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ");
			Str_Cpy( m_szSql[1], "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ");
		}
		else
		{
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' AND TOWN = '%s' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ", g_szTown, 0, 0 );
			Str_Cpy( m_szSql[0], szRow);
			
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' AND TOWN = '%s' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ", g_szTown, 0, 0 );
			Str_Cpy( m_szSql[1], szRow);
		}


	}
	
	
//-----------------------------------------------------------------------------------------------
	bool Save_TotSign(void)
	{
		bool ret = TRUE;
		char szSql[500];
		long idx, i;
		long lCount;
		long lsign, lSign_Len;
		char* pRst;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		
		//대상수와 점검완료대상을 비교	
		if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2)) != 0 )
		{
			MessageBoxEx (CONFIRM_OK, "점검을 완료후 일괄서명 하세요.");
			ret = FALSE;
			goto Finally;
		}
		
		//서명
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		//lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명" );
		lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명", SIGN_OPT_NONE );
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			ret = FALSE;
			goto Finally;
		}
		else
		{
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}		

		//부적합점검 송신플래그 업데이트
		Update_Nogood();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE BEFO_DATA SET \
						CHK_EMPID = ?, CRT_EMPID = ?, CRT_IP = ?, SEND_FLAG = 'S', SIGN = ? \
						WHERE BLD_NUM = ? AND SINGLE_COLIVE_FLAG = '20' AND (CHK_RSLT='20' OR CHK_RSLT='21') \
						AND (SIGN IS NULL OR SIGN = '') "
					, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)pRst			 ,Str_Len(pRst) ,DECRYPT);	//서명

		sql->Bind(sql, idx++, 'U', (long *)g_szBLD_NUM		        ,9  ,DECRYPT);


		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "일괄 서명을 완료 하였습니다.");
		}
		//sql->Commit(sql);
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		DelSqLite(sql);
		return ret;
	}
	
//--------------------------------------------------------------------------------------
	bool Update_Nogood(void)
	{
		char szSql[400];
		char szRow[10];
		char szCreate[10];
		char szMtr[10];
		long i, lCnt, Row;
		long ret;
//UPSIGNDATA_FILE
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM BEFO_DATA WHERE BLD_NUM = '%s' AND SINGLE_COLIVE_FLAG = '20' AND CHK_RSLT='21' ",g_szBLD_NUM, 0, 0   );
		ret = g_Sql_RetInt( szSql, &lCnt );
/*		if( ret != 1 )
		{
			return FALSE;
		}*/
		

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE BLD_NUM = '%s' AND SINGLE_COLIVE_FLAG = '20' AND \
		CHK_RSLT='21' AND (SIGN IS NULL OR SIGN = '') ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM "
		,g_szBLD_NUM, 0, 0 );		
		g_Sql_SaveSeq( szSql, UPSIGNDATA_FILE);

		for(i=0 ; i<lCnt ; i++)
		{
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			Mem_Set( (byte*)szCreate, 0x00, sizeof(szCreate) );
			Mem_Set( (byte*)szMtr, 0x00, sizeof(szMtr) );
			
			Str_ItoA(g_SREACHFILE_GetSeq(UPSIGNDATA_FILE, i), szRow, 10);

			//MTR_NUM , 
			SPRINT(szSql, "SELECT MTR_NUM FROM BEFO_DATA WHERE BLD_NUM = '%s' AND ROWID = '%s' AND SINGLE_COLIVE_FLAG = '20' AND \
			CHK_RSLT='21' AND (SIGN IS NULL OR SIGN = '') ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM "
			,g_szBLD_NUM, szRow, 0 );
			ret = g_Sql_RetStr( szSql, 10, szMtr );
/*			if( ret != 1 )
			{
				return FALSE;
			}*/
			
			//CREATE_YMD , CHK_RSLT='21' AND 
			SPRINT(szSql, "SELECT CREATE_YMD FROM BEFO_DATA WHERE BLD_NUM = '%s' AND ROWID = '%s' AND SINGLE_COLIVE_FLAG = '20' AND \
			CHK_RSLT='21' AND (SIGN IS NULL OR SIGN = '') ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM "
			,g_szBLD_NUM, szRow, 0 );
			ret = g_Sql_RetStr( szSql, 10, szCreate );
/*			if( ret != 1 )
			{
				return FALSE;
			}*/

			//부적합점검 송신플래그 업데이트
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE BEFO_NOGOOD_MAIN SET SEND_YN = 'S' WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s'  "
			, szCreate, szMtr, 0 );
			ret = g_Sql_DirectExecute( szSql );
/*			if( ret != 0 )
			{
				return FALSE;
			}*/
	
			//부적합점검 송신플래그 업데이트
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE BEFO_NOGOOD_DETAL SET SEND_YN = 'S' WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' "
			, szCreate, szMtr, 0 );
			ret = g_Sql_DirectExecute( szSql );
/*			if( ret != 0 )
			{
				return FALSE;
			}*/
		}

		return TRUE;
	}
	
	
	/*=======================================================================================
	함수명 : SET_HDINDEX
	기  능 : 최종 인덱스 저장한다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void SET_HDINDEX(void)
	{
		char sztmp[101];
		
		//공급전 공동 GUBUN = 6 , PARAM9 -> 그룹리스트 index , PARAM10 -> 상세리스트 index
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));

		SPRINT(sztmp, " UPDATE RCV_LOG SET PARAM9= '%d'  WHERE GUBUN = '6' ", g_nGrpIndex, 0, 0);		

		g_Sql_DirectExecute(sztmp);
	}
	
	/*=======================================================================================
	함수명 : GET_HDINDEX
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void GET_HDINDEX(void)
	{
		char szSql[100];
		long lParam9 = 0;
		long lidx = 0;
	
		g_Sql_RetInt("SELECT PARAM9 FROM RCV_LOG WHERE GUBUN = '6'", &lParam9);

		m_lpage = (lParam9)/ROW;
		m_nActIndex = (lParam9)%ROW;
		
	    m_lSubIndex = m_nActIndex;
	    m_lSubpage = m_lpage;
	}
	
	
//========================================================================================
//상세리스트 인덱스 초기화
	void SET_DTLINDEX(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM10 = '0' WHERE GUBUN = '6' ", 0, 0, 0);		
		g_Sql_DirectExecute(szSql);
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
		SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		lRow = Str_AtoI(g_szROWID);
		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '6' ", lActIndex, 0, 0);		
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
		
		//nAddrType = 0 지번 ,, nAddrType = 1 도로명
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "공급전점검(공동) 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT  ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), ifnull(A.CO_LIVE_NM, '') ||' / 대상:'|| COUNT(*) ||' / 점검:'|| (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) ||' / 서명:'|| (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "공급전점검(공동) 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT  ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), ifnull(A.CO_LIVE_NM, '') ||' / 대상:'|| COUNT(*) ||' / 점검:'|| (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) ||' / 서명:'|| (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
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
	void Grid_QuickList(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		char szTmp[128];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"공동주택명", "대상", "점검", "서명", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","1","1","1","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		Str_Cpy(m_szQuickSql, "SELECT \
 ifnull(A.CO_LIVE_NM, '') ||' '|| ifnull(A.BLD_NM,''),COUNT(*) \
 ,(SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) \
 ,(SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) \
 FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' ");

		if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
		}
		else //if( Str_Cmp(m_szCobSel, "공동주택명" ) == 0 )
		{
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szTmp, "AND TOWN = '%s'",g_szTown,0,0);
			
			Str_Cat(m_szQuickSql, szTmp);
			Str_Cat(m_szQuickSql, " GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
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
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 4;
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
			
			JSON_SetValue	(h		, 'C', "title"			, "공급전 안전점검(공동)");
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
