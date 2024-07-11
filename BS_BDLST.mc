/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
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
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
//리스트
		DEF_BUTTON_ID ( BID_LIST_SEARCH )	//검색
		DEF_BUTTON_ID ( BID_ADDR )		//주소
		DEF_BUTTON_ID ( BID_NADDR )		//신주소
		DEF_BUTTON_ID ( BID_UP )		//이전페이지
		DEF_BUTTON_ID ( BID_DOWN )		//다음페이지
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//도로명주소 스크롤 호출
//검색
		DEF_BUTTON_ID ( BID_SEARCH1 )	//기물번호조회
		DEF_BUTTON_ID ( BID_SEARCH2 )	//구 주소조회
		DEF_BUTTON_ID ( BID_SEARCH3 )	//신 주소조회
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//리스트
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//총페이지
		DEF_OBJECT_ID ( TXT_FIT )			// 적합
		DEF_OBJECT_ID ( TXT_NOFIT )			// 부적합
		DEF_OBJECT_ID ( TXT_NOACTION )		// 미실시
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
//검색
		DEF_OBJECT_ID ( TXT_ALONE )			//단독(체크박스)
		DEF_OBJECT_ID ( TXT_TOGETHER )		//공동(체크박스)
		DEF_OBJECT_ID ( TXT_OBJNUM )		//기물번호
		DEF_OBJECT_ID ( TXT_ADDR)			//주소
		DEF_OBJECT_ID ( TXT_GOO )			//구
		DEF_OBJECT_ID ( TXT_DONG )			//동
		DEF_OBJECT_ID ( TXT_BUNJI )			//번지
		DEF_OBJECT_ID ( TXT_HOSOO )			//호수
		DEF_OBJECT_ID ( TXT_BDNM )			//건물명
		DEF_OBJECT_ID ( TXT_NWADDR )		//신주소
		DEF_OBJECT_ID ( TXT_NWGOO )			//구
		DEF_OBJECT_ID ( TXT_STREET )		//도로명
		DEF_OBJECT_ID ( TXT_BONBUN )		//본번
		DEF_OBJECT_ID ( TXT_BOOBUN )		//부번
		DEF_OBJECT_ID ( TXT_NBDNM )			//건물명
//검색
		DEF_OBJECT_ID ( EDT_OBJNUM )		//기물번호 입력
		DEF_OBJECT_ID ( EDT_BUNJI )			//번지 입력
		DEF_OBJECT_ID ( EDT_HOSOO )			//호수 입력
		DEF_OBJECT_ID ( EDT_BDNM )			//건물명 입력
		DEF_OBJECT_ID ( EDT_BONBUN )		//본번 입력
		DEF_OBJECT_ID ( EDT_BOOBUN )		//부번 입력
		DEF_OBJECT_ID ( EDT_NBDNM )			//건물명 입력
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
//리스트
		DEF_OBJECT_ID ( CMB_SELECT )
//검색
		DEF_OBJECT_ID ( CMB_GOO = CMB_SELECT+3 )		//구
		DEF_OBJECT_ID ( CMB_DONG = CMB_GOO+3 ) 			//동
		DEF_OBJECT_ID ( CMB_NWGOO = CMB_DONG+3 ) 		//구
		DEF_OBJECT_ID ( CMB_STREET = CMB_NWGOO+3 ) 		//도로명
//리스트
		DEF_OBJECT_ID ( ID_TBLLIST = CMB_STREET+3 )	// 테이블 리스트
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+32)			// table 행 높이
	#define		GRID_H_P	(CHT+55)			// table 행 높이
	#define		GRID_TTL_P	(CHT+10)			// table 행 높이 , PDA 타이틀 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+250  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+120 	        // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"주소/개소", CWD*23+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"압력", 	  CWD*8 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"결과", 	  CWD*8 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상세주소",  CWD*0 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"우선점검여부",  CWD*0 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}

	};	
	
	#define INIT_MAIN	1	
	//#define INIT_SRCH	2
	
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_nbuttonid = 0;		//m_nbuttonid = 0 나머지 검색 sql, m_nbuttonid = 1 기물번호 sql
	long m_nActIndex = -1;
	long m_lIdxFlag = 0;
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szAdrss[120];		// 상단 주소 표시
	char m_szSql[2][800];
	char m_szQuickSql[1000];
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	char m_szSqlFlag = 0;		//m_szSqlFlag = 0 - 기본리스트, m_szSqlFlag = 1 - 검색된 리스트
	char m_szCobSel[20];
	
	bool REDRAW(void);
	bool Search_Addr(long nbuttonid);
	long FS_GetSrchTotCnt(void);
	void SetStyle(void);
	void SetCombo(void);
	void Cmb_Result(void);
	void Cmb_Filter(void);
	void SetBtnImg(void);
	void Set_Index(void); 	//선택한 대상 인덱스 저장
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
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
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "정기특정점검 개소 선택"),
		
		DLG_BUTTON(STARTX,     STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+250, STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+500, STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+125, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_BUTTON(STARTX,     STARTY+185, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		DLG_BUTTON(STARTX+250, STARTY+185, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		
		DLG_TEXT(STARTX,       STARTY+65, 500, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지

		DLG_TEXT(STARTX,      STARTY+828, 140, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIT, "적합"), 		//적합
		DLG_TEXT(STARTX+140,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+310,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT, "부적합"), 	//부적합
		DLG_TEXT(STARTX+480,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 		//
		DLG_TEXT(STARTX+650,  STARTY+828, 170, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOACTION, "미실시"),	//미실시
		DLG_TEXT(STARTX+820,  STARTY+828, 180, 71, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//					
		
		DLG_COMBO (STARTX+500, STARTY+65, 500, 250, 150, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "개소 선택"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
				
		DLG_TEXT(STARTX,       STARTY-40, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		
		DLG_BUTTON(STARTX,     STARTY+40, 250, 80, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+250, STARTY+40, 250, 80, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+500, STARTY+40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),

		DLG_TEXT(STARTX,      STARTY+829, 185, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIT, "적합"), 		//적합
		DLG_TEXT(STARTX+185,  STARTY+829, 145, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+330,  STARTY+829, 185, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT, "부적합"), 	//부적합
		DLG_TEXT(STARTX+515,  STARTY+829, 145, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 		//
		DLG_TEXT(STARTX+660,  STARTY+829, 185, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOACTION, "미실시"),	//미실시
		DLG_TEXT(STARTX+845,  STARTY+829, 155, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//					
		
		DLG_COMBO (STARTX+500, STARTY-40, 500, 250, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// 리스트
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
				
				if( g_nWorkFlag == 301 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "미검");
					Str_Cpy(m_szCobSel, "미검");							
				}
				else if ( g_nWorkFlag == 302 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "우선");
					Str_Cpy(m_szCobSel, "우선");			
				}
				else if ( g_nWorkFlag == 303 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "일반");
					Str_Cpy(m_szCobSel, "일반");			
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "전체");
					Str_Cpy(m_szCobSel, "전체");							
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
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
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
				if( MessageBoxEx (CONFIRM_YESNO, "특정점검 메뉴로\n나가시겠습니까?")  == MB_OK)
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
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					
					Set_Index();
					Card_Move("BS_CONFIRM");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//선택된 INDEX 저장
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//콤보박스 선택으로 리스트 목록 필터링.(검침,미검침,전체대상)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
					g_nWorkFlag = 300;
				else if( Str_Cmp(m_szCobSel, "미검" ) == 0 )
					g_nWorkFlag = 301;
				else if( Str_Cmp(m_szCobSel, "우선" ) == 0 )
					g_nWorkFlag = 302;
				else if( Str_Cmp(m_szCobSel, "일반" ) == 0 )
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
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "전체", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "미검", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "일반", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "우선", 0, ICON_NONE);
		
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
				//주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				idx = 0;
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//압력
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				if(sztmp[0] == 'L')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "저압" );
				else if(sztmp[0] == 'M')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "중압");
				else if(sztmp[0] == 'R')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "중간압" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 1,  "");
				//결과
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				if(Str_Cmp(sztmp, "20") == 0)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "적합" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLACK);
				}
				else if(Str_Cmp(sztmp, "21") == 0)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "부적합");
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else if(Str_Cmp(sztmp, "40") == 0)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "제외" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLACK);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "미검");	
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLACK);
				}
				
				//상세주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				//우선점검여부
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
				MessageBoxEx (CONFIRM_OK, "기물번호를 입력하세요.");
				return FALSE;
			}
			m_nbuttonid = 1;		//sql문 관련
			
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
				MessageBoxEx (CONFIRM_OK, "(구)주소 정보를 입력하세요.");
				return FALSE;
			}
			m_nbuttonid = 0;		//sql문 관련
			
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
				MessageBoxEx (CONFIRM_OK, "(신)주소 정보를 입력하세요.");
				return FALSE;
			}
			m_nbuttonid = 0;		//sql문 관련
			
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
		//페이지를 초기화시킨다.
		m_lpage = 0;
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		return TRUE;
	}

	/*=======================================================================================
	함수명 : FS_GetSrchTotCnt
	기  능 : 검색인덱스파일의 레코드 수를 리턴한다.
	Param  : nPos:검색 인덱스 파일의 순번
 	Return : 레코드수
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;
		
		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}
	
	//-----------------------------------------------------------------------------------------------
	//콤보박스를 이용한 전체,점검,미점검 목록 필터
	//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[300];

		if( Str_Cmp(m_szCobSel, "미검") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null  ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 301;
		}
		else if( Str_Cmp(m_szCobSel, "우선") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 302;
		}
		else if( Str_Cmp(m_szCobSel, "일반") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA WHERE TRIM(PREUSE_CHK_WHY) IS NULL ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 303;
		}
		else // if( Str_Cmp(m_szCobSel, "전체") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
			g_nWorkFlag = 300;
		}

		g_Sql_SaveSeq( szRow, SREACH_FILE);
	
		if( Str_Cmp(m_szCobSel, "미검") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT,  ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ? , ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ? , ?");
		}
		else if ( Str_Cmp(m_szCobSel, "우선") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PRESS_FLAG, CHK_RSLT, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||'\n'|| ifnull(SPECIAL_NM,' '), PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ?");
		}
		else if ( Str_Cmp(m_szCobSel, "일반") == 0 )
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
	//콤보박스를 이용한 전체,점검,미점검 목록 필터, 상단 대상 확인부분
	//-----------------------------------------------------------------------------------------------
	void Cmb_Result(void)
	{
		char sztmp[20];
		char szSql[300];
		
		if( Str_Cmp(m_szCobSel, "전체") == 0 )
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
		else if( Str_Cmp(m_szCobSel, "미검") == 0 )
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
		else if( Str_Cmp(m_szCobSel, "우선") == 0 )
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
		else if( Str_Cmp(m_szCobSel, "일반") == 0 )
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
	함수명 : Set_Index
	기  능 : 최종 인덱스 저장한다.
	Param  : 
	Return : TRUE :성공
			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '5' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}
	
	/*=======================================================================================
	함수명 : Get_Index
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
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
		
		//nAddrType = 0 지번 ,, nAddrType = 1 도로명
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "특정점검 개소선택");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), ifnull(SPECIAL_NM, '') ||' / 압력:'|| Case When PRESS_FLAG = 'L' Then '저압' When PRESS_FLAG = 'M' Then '중압' When PRESS_FLAG = 'R' Then '중간압' Else '' End ||' / 결과:'|| Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' Else '미검' End FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "특정점검 개소선택");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||' '|| ifnull(SPECIAL_NM,' '), ifnull(SPECIAL_NM, '') ||' / 압력:'|| Case When PRESS_FLAG = 'L' Then '저압' When PRESS_FLAG = 'M' Then '중압' When PRESS_FLAG = 'R' Then '중간압' Else '' End ||' / 결과:'|| Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' Else '미검' End FROM SPECIAL_DATA ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
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
		
		char col_name[5][32] = {"주소/개소", "압력", "결과", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","2","2","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( nBtnID == BID_QUICK_ADDR )
		{
			Str_Cpy(m_szQuickSql, "SELECT \
IFNULL(TOWN,' ') ||' '|| IFNULL(ADDR1_M,' ') ||'-'|| IFNULL(ADDR1_S,' ') ||' '|| ifnull(SPECIAL_NM,' ') \
, CASE WHEN PRESS_FLAG = 'L' THEN '저압' WHEN PRESS_FLAG = 'M' THEN '중압' WHEN PRESS_FLAG = 'R' THEN '중간압' ELSE '' END \
, CASE WHEN CHK_RSLT = '20' THEN '적합' WHEN CHK_RSLT = '21' THEN '부적합' WHEN CHK_RSLT = '40' THEN '제외' ELSE '미검' END \
FROM SPECIAL_DATA ");
		}
		else
		{
			Str_Cpy(m_szQuickSql, "SELECT \
ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||' '|| ifnull(SPECIAL_NM,' ') \
, CASE WHEN PRESS_FLAG = 'L' THEN '저압' WHEN PRESS_FLAG = 'M' THEN '중압' WHEN PRESS_FLAG = 'R' THEN '중간압' ELSE '' END \
, CASE WHEN CHK_RSLT = '20' THEN '적합' WHEN CHK_RSLT = '21' THEN '부적합' WHEN CHK_RSLT = '40' THEN '제외' ELSE '미검' END \
FROM SPECIAL_DATA ");
		}
		

		if( Str_Cmp(m_szCobSel, "미검" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE ( CHK_RSLT != '20' AND CHK_RSLT != '21' AND CHK_RSLT != '40' ) or CHK_RSLT is null ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		if( Str_Cmp(m_szCobSel, "우선" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		if( Str_Cmp(m_szCobSel, "일반" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE TRIM(PREUSE_CHK_WHY) IS NULL ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 ");
		}
		else //if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
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
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
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
			
			JSON_SetValue	(h		, 'C', "title"			, "개소 선택");
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
