/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_SILSA
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
//현장실사 메인 리스트
		DEF_BUTTON_ID ( BID_TAB1 )
		DEF_BUTTON_ID ( BID_TAB2 )
		DEF_BUTTON_ID ( BID_TAB3 )
		DEF_BUTTON_ID ( BID_SCREEN_PREV)
		DEF_BUTTON_ID ( BID_SEARCH )
		DEF_BUTTON_ID ( BID_PHOTOVIEW )
		DEF_BUTTON_ID ( BID_MAINPREV )
		DEF_BUTTON_ID ( BID_MAINNEXT )
//검침실사
		DEF_BUTTON_ID ( BID_GMADDR )
		DEF_BUTTON_ID ( BID_GMPREV )
		DEF_BUTTON_ID ( BID_GMMEMO )
		DEF_BUTTON_ID ( BID_GMPHOTO )
		
//주소검색
		DEF_BUTTON_ID ( BID_SEARCH_TAB1 )
		DEF_BUTTON_ID ( BID_SEARCH_TAB2 )
		DEF_BUTTON_ID ( BID_ADDRSEARCH )
		DEF_BUTTON_ID ( BID_JIBUN )
		DEF_BUTTON_ID ( BID_ROADNM )
		DEF_BUTTON_ID ( BID_TOGETHER )
		DEF_BUTTON_ID ( BID_ADDRCANCEL )
		DEF_BUTTON_ID ( BID_ADDROK )
//기물번호검색
		DEF_BUTTON_ID ( BID_MTRSEARCH )
		DEF_BUTTON_ID ( BID_MTRCANCEL )
		DEF_BUTTON_ID ( BID_MTROK )

//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_BORDER )
//기물번호 조회
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		
//지번 조회
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
//공동 조회
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
//도로명 조회
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
//검침실사
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		DEF_OBJECT_ID ( TXT_DATA22 )
		DEF_OBJECT_ID ( TXT_DATA23 )
		DEF_OBJECT_ID ( TXT_DATA24 )
		DEF_OBJECT_ID ( TXT_DATA25 )
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA29 )
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
		DEF_OBJECT_ID ( TXT_DATA32 )
		DEF_OBJECT_ID ( TXT_DATA33 )
		DEF_OBJECT_ID ( TXT_DATA34 )
		DEF_OBJECT_ID ( TXT_DATA35 )
		DEF_OBJECT_ID ( TXT_DATA36 )
		DEF_OBJECT_ID ( TXT_DATA37 )
		DEF_OBJECT_ID ( TXT_DATA38 )
		DEF_OBJECT_ID ( TXT_DATA39 )
		DEF_OBJECT_ID ( TXT_DATA40 )
		DEF_OBJECT_ID ( TXT_DATA41 )
		DEF_OBJECT_ID ( TXT_DATA42 )		
		DEF_OBJECT_ID ( TXT_DATA43 )
		DEF_OBJECT_ID ( TXT_DATA44 )
		DEF_OBJECT_ID ( TXT_DATA45 )
		DEF_OBJECT_ID ( TXT_DATA46 )
		
//기물번호 조회
		DEF_OBJECT_ID ( EDT_DATA1 )
//지번 조회
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
//공동 조회
		DEF_OBJECT_ID ( EDT_DATA4 )
//도로명 조회
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )

		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
//현장실사 메인 리스트
		DEF_OBJECT_ID ( ID_MAINLIST )	// 테이블 리스트

//주소 검색
		DEF_OBJECT_ID ( ID_ADDRLIST )	// 테이블 리스트

//검침실사
		DEF_OBJECT_ID ( ID_GMLIST )

//지번 조회
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )
//공동 조회
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2 + 3 )
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3 + 3 )
//도로명 검색
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4 + 3 )
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA5 + 3 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	      1
	#define INIT_GMSILSA      2
	#define INIT_MTRSEARCH    3
	#define INIT_JIBUNSEARCH  4
	#define INIT_TGTSEARCH    5
	#define INIT_NEWSEARCH    6
		
	SysButCtrl SysButRes_MAIN[] =
	 {
		  SYS_BUT_IMG (  BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME,  0),
		  SYS_BUT_IMG (  BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD,  0),
		  SYS_BUT_IMG (  BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0),
		  SYS_BUT_IMG (  BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK,  0),
		  SYS_BUT_IMG (  BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0),
		  SYS_BUT_IMG (  BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0),
		  SYS_BUT_IMG (  BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0),
//		  SYS_BUT_IMG (       0, STARTY+199, 998, 996, 0, 0, BUTSTY_BOLD , 0, WHITE, WHITE, OBJ_BUT, BID_VISIBLE, 0),
	 };
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(현장실사 메인)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_M	    6					// table의 행개수
	#define		COL_M	    3					// table의 열개수
	#define		GRID_H_M	(CHT+60)			// table 행 높이
	#define		GRID_CLR_M	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_M	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_M	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_M	STARTY+130	 	    // table 시작y좌표
	#define		GRID_Y_M_P  STARTY+40  		    // table 시작y좌표
	#define		GRID_ENDY_M	(GRID_Y_M+(ROW_M+1)*GRID_H_M) //table마지막 row의 Y값
	
	char	m_szTableBuf_M [COL_M*(ROW_M+1)*MAXCHAR_M]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_M[] = {
		{"계약번호"      , CWD*12+13    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"주소"          , CWD*19    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"처리상태"      , CWD*8+10  , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};


	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(주소검색)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_A	    6					// table의 행개수
	#define		COL_A	    3					// table의 열개수
	#define		GRID_H_A	(CHT+24)			// table 행 높이
	#define		GRID_CLR_A	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_A	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_A	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_A	STARTY+385	 	    // table 시작y좌표
	#define		GRID_Y_A_P  STARTY+40  		    // table 시작y좌표
	#define		GRID_ENDY_A	(GRID_Y_A+(ROW_A+1)*GRID_H_A) //table마지막 row의 Y값
	
	char	m_szTableBuf_A [COL_A*(ROW_A+1)*MAXCHAR_A]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_A[] = {
		{"주소"        , CWD*18    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상호"        , CWD*13    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"처리상태"    , CWD*8+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(검침실사)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_G	    3					// table의 행개수
	#define		COL_G	    7					// table의 열개수
	#define		GRID_H_G	(CHT+20)			// table 행 높이
	#define		GRID_CLR_G	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_G	0    			    // table 시작x좌표
	#define		MAXCHAR_G	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_G	STARTY+580	 	    // table 시작y좌표
	#define		GRID_Y_G_P  STARTY+40  		    // table 시작y좌표
	#define		GRID_ENDY_G	(GRID_Y_G+(ROW_G+1)*GRID_H_G) //table마지막 row의 Y값
	
	char	m_szTableBuf_G [COL_G*(ROW_G+1)*MAXCHAR_G]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_G[] = {
		{""           , CWD*8+5     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"지침"       , CWD*4+10    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"사용량"     , CWD*6+5     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"지침"       , CWD*4+10    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"사용량"     , CWD*6+5     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"지침"       , CWD*4+10    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"사용량"     , CWD*6+4     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};


	long m_bFirst;

	char m_szTabTitle_1[256];	//대상
	char m_szTabTitle_2[256];	//미완료
	char m_szTabTitle_3[256];	//완료

//현장실사 메인
	long m_lpage_M = 0;			// 현재 페이지
	long m_lTotpage_M = 0;		// 총 페이지
	long m_nActIndex_M = -1;	//선택된 row index
	char m_szCnt_page_M[20];	// 페이지 표시 변수
//주소검색
	long m_lpage_A = 0;			// 현재 페이지
	long m_lTotpage_A = 0;		// 총 페이지
	long m_nActIndex_A = -1;	//선택된 row index
	char m_szCnt_page_A[20];	// 페이지 표시 변수
//검침실사
	long m_lpage_G = 0;			// 현재 페이지
	long m_lTotpage_G = 0;		// 총 페이지
	long m_nActIndex_G = -1;	//선택된 row index
	char m_szCnt_page_G[20];	// 페이지 표시 변수


	void SetBtnImg(void);
	void SetStyle(void);
	void SetCombo(void);
	void ReDraw(long BtnId);	//현장실사 메인
	void AddrDraw(void);		//주소검색
	void Silsa_InfoDraw(void);
	void Silsa_QtyDraw(void);	
	

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "현장실사"),

		DLG_BUTTON(0,            STARTY+65, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, m_szTabTitle_1),
		DLG_BUTTON(STARTX+333,   STARTY+65, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, m_szTabTitle_2),
		DLG_BUTTON(STARTX+666,   STARTY+65, 334, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB3, m_szTabTitle_3),
		
		//DLG_BUTTON(STARTX+330,  STARTY+835, 330, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, "대상찾기"),
		//DLG_BUTTON(STARTX+480, STARTY+727, 250, 50, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREV, "▲"),
		//DLG_BUTTON(STARTX+743, STARTY+727, 250, 50, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXT, "▼"),
		DLG_BUTTON(0,           STARTY+832, 333, 67, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCREEN_PREV, "이전화면"),
		DLG_BUTTON(STARTX+333,  STARTY+832, 333, 67, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, "대상찾기"),
		DLG_BUTTON(STARTX+666,  STARTY+832, 334, 67, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTOVIEW, "사진보기"),

		// 리스트
		DLG_TABLE(GRID_X_M, GRID_Y_M, ROW_M, COL_M, 0, GRID_H_M, 1, GRID_H_M, SEL_ROW, MAXCHAR_M, m_stGridTitle_M, ID_MAINLIST, m_szTableBuf_M),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "현장실사"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
	};		
	
	
	// 메인 다이얼로그(검침실사)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Gmsilsa[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "검침실사"),

		DLG_BUTTON(0,          STARTY+830, 333, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMPREV, "이전화면"),
		DLG_BUTTON(STARTX+328, STARTY+830, 333, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMMEMO, "메모등록"),
		DLG_BUTTON(STARTX+663, STARTY+830, 332, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMPHOTO, "사진촬영"),
		
		DLG_TEXT(0,     	    STARTY+70, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA20, "계약번호"),
		DLG_TEXT(STARTX+245,    STARTY+70, 748, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		//DLG_BUTTON(0,          STARTY+110, 250, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMADDR, "지번\n주소"),
		DLG_TEXT(0,            STARTY+110, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA46, "도로명"),
		DLG_TEXT(STARTX+245,   STARTY+110, 748, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(0,     	   STARTY+180, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA23, "성명"),
		DLG_TEXT(STARTX+245,   STARTY+180, 748, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		DLG_TEXT(0,     	   STARTY+220, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA25, "상호"),
		DLG_TEXT(STARTX+245,   STARTY+220, 748, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(0,     	   STARTY+260, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA27, "전화번호"),
		DLG_TEXT(STARTX+245,   STARTY+260, 370, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA28, ""),
		DLG_TEXT(STARTX+615,   STARTY+260, 378, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),
		DLG_TEXT(0,     	   STARTY+300, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA30, "상품명"),
		DLG_TEXT(STARTX+245,   STARTY+300, 748, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(0,     	   STARTY+340, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA32, "계약상태"),
		DLG_TEXT(STARTX+245,   STARTY+340, 300, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(STARTX+545,   STARTY+340, 448, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA34, ""),
		DLG_TEXT(0,     	   STARTY+380, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA35, "등급/기물"),
		DLG_TEXT(STARTX+245,   STARTY+380, 300, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA36, ""),
		DLG_TEXT(STARTX+545,   STARTY+380, 448, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(0,     	   STARTY+420, 250, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA38, "압력/보정"),
		DLG_TEXT(STARTX+245,   STARTY+420, 300, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX+545,   STARTY+420, 448, 40, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA40, ""),
		
		// 리스트
		DLG_TABLE(GRID_X_G, GRID_Y_G, ROW_G, COL_G, 0, GRID_H_G, 1, GRID_H_G, SEL_ROW, MAXCHAR_G, m_stGridTitle_G, ID_GMLIST, m_szTableBuf_G),
		
		DLG_TEXT(0,     	   STARTY+460, 998, 60, 0, 0, 0, EDITSTY_BORDER,      WHITE,      BLUE, TXT_DATA41, "검침정보"),
		DLG_TEXT(0,     	   STARTY+520, 205,120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, GRIDTTLBK, TXT_DATA42, "청구\n년월"),
		DLG_TEXT(STARTX+200,   STARTY+520, 265, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, GRIDTTLBK, TXT_DATA43, "VC"),
		DLG_TEXT(STARTX+465,   STARTY+520, 265, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, GRIDTTLBK, TXT_DATA44, "VA"),
		DLG_TEXT(STARTX+730,   STARTY+520, 263, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, GRIDTTLBK, TXT_DATA45, "VM"),
	};	
	
	// PDA 다이얼로그(검침실사)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Gmsilsa_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "검침실사"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
	};		

	// 메인 다이얼로그(기물번호)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Mtr[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "현장실사"),

		DLG_BUTTON(STARTX,     STARTY+65,  500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB1, "주소로 찾기"),
		DLG_BUTTON(STARTX+500, STARTY+65,  500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB2, "기물번호로 찾기"),
		DLG_BUTTON(STARTX,     STARTY+195, 1000, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRSEARCH, "조 회"),
		DLG_BUTTON(STARTX,     STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRCANCEL, "이전화면"),
		DLG_BUTTON(STARTX+500, STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTROK, "확 인"),

		DLG_TEXT(STARTX,       STARTY+135, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "기물번호"),
		DLG_EDIT(STARTX+300,   STARTY+135, 700, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 20,  ""),
		
		DLG_TEXT(STARTX,       STARTY+280, 1000, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "조회결과"),
		DLG_TEXT(STARTX,       STARTY+340, 250, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "주소"),
		DLG_TEXT(STARTX+250,   STARTY+340, 750, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,       STARTY+490, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5, "상호"),
		DLG_TEXT(STARTX+250,   STARTY+490, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,       STARTY+550, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA7, "처리상태"),
		DLG_TEXT(STARTX+250,   STARTY+550, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
	};	
	
	// PDA 다이얼로그(기물번호)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Mtr_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "현장실사"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
	};		


	// 메인 다이얼로그(주소검색-단독)
	//---------------------------------------------------------------
	DlgObject	DlgRes_JibunSearch[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "현장실사"),

		DLG_BUTTON(0,           STARTY+65, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB1, "주소로 찾기"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB2, "기물번호로 찾기"),
		DLG_BUTTON(0,          STARTY+135, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_JIBUN, "지 번"),
		DLG_BUTTON(STARTX+333, STARTY+135, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ROADNM, "도로명"),
		DLG_BUTTON(STARTX+666, STARTY+135, 334, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TOGETHER, "공 동"),
		DLG_BUTTON(0,          STARTY+320, 998, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRSEARCH, "조 회"),
		DLG_BUTTON(0,          STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRCANCEL, "이전화면"),
		DLG_BUTTON(STARTX+500, STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDROK, "확 인"),

		DLG_TEXT(0, 	     STARTY+200, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "구"),
		DLG_TEXT(STARTX+515, STARTY+200, 130, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA10, "동"),
		DLG_TEXT(0, 	     STARTY+260, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA11, "번지"),
		DLG_EDIT(STARTX+195, STARTY+260, 320, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_TEXT(STARTX+515, STARTY+260, 130, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA12, "호수"),
		DLG_EDIT(STARTX+645, STARTY+260, 355, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 10,  ""),
	
		DLG_COMBO (STARTX+195, STARTY+200, 320, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+645, STARTY+200, 355, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),

		// 리스트
		DLG_TABLE(GRID_X_A, GRID_Y_A, ROW_A, COL_A, 0, GRID_H_A, 1, GRID_H_A, SEL_ROW, MAXCHAR_A, m_stGridTitle_A, ID_ADDRLIST, m_szTableBuf_A),
	};	
	
	// PDA 다이얼로그(주소검색-단독)
	//---------------------------------------------------------------
	DlgObject	DlgRes_JibunSearch_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "현장실사"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
	};		


	// 메인 다이얼로그(주소검색-공동)
	//---------------------------------------------------------------
	DlgObject	DlgRes_TgtSearch[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "현장실사"),

		DLG_BUTTON(0,           STARTY+65, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB1, "주소로 찾기"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB2, "기물번호로 찾기"),
		DLG_BUTTON(0,          STARTY+135, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_JIBUN, "지 번"),
		DLG_BUTTON(STARTX+333, STARTY+135, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ROADNM, "도로명"),
		DLG_BUTTON(STARTX+666, STARTY+135, 334, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TOGETHER, "공 동"),
		DLG_BUTTON(0,          STARTY+320, 998, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRSEARCH, "조 회"),
		DLG_BUTTON(0,          STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRCANCEL, "이전화면"),
		DLG_BUTTON(STARTX+500, STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDROK, "확 인"),

		DLG_TEXT(0,          STARTY+200, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA13, "공동주택명"),
		DLG_TEXT(0, 	     STARTY+260, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA14, "건물명"),
		DLG_TEXT(STARTX+665, STARTY+260, 130, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA15, "호"),
		DLG_EDIT(STARTX+795, STARTY+260, 205, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 10,  ""),
	
		DLG_COMBO (STARTX+295, STARTY+200, 705, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_COMBO (STARTX+195, STARTY+260, 470, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),

		// 리스트
		DLG_TABLE(GRID_X_A, GRID_Y_A, ROW_A, COL_A, 0, GRID_H_A, 1, GRID_H_A, SEL_ROW, MAXCHAR_A, m_stGridTitle_A, ID_ADDRLIST, m_szTableBuf_A),
	};	
	
	// PDA 다이얼로그(주소검색-공동)
	//---------------------------------------------------------------
	DlgObject	DlgRes_TgtSearch_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "현장실사"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
	};		


	// 메인 다이얼로그(주소검색-도로명)
	//---------------------------------------------------------------
	DlgObject	DlgRes_NewSearch[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "현장실사"),

		DLG_BUTTON(0,           STARTY+65, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB1, "주소로 찾기"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH_TAB2, "기물번호로 찾기"),
		DLG_BUTTON(0,          STARTY+135, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_JIBUN, "지 번"),
		DLG_BUTTON(STARTX+333, STARTY+135, 333, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ROADNM, "도로명"),
		DLG_BUTTON(STARTX+666, STARTY+135, 334, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TOGETHER, "공 동"),
		DLG_BUTTON(0,          STARTY+320, 998, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRSEARCH, "조 회"),
		DLG_BUTTON(0,          STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRCANCEL, "이전화면"),
		DLG_BUTTON(STARTX+500, STARTY+830, 500, 69, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDROK, "확 인"),

		DLG_TEXT(0, 	     STARTY+200, 130, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA16, "구"),
		DLG_TEXT(STARTX+445, STARTY+200, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA17, "도로명"),
		DLG_TEXT(0, 	     STARTY+260, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA18, "본번"),
		DLG_EDIT(STARTX+195, STARTY+260, 300, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 10,  ""),
		DLG_TEXT(STARTX+495, STARTY+260, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA19, "부번"),
		DLG_EDIT(STARTX+695, STARTY+260, 305, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 10,  ""),
	
		DLG_COMBO (STARTX+125, STARTY+200, 320, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 10),
		DLG_COMBO (STARTX+645, STARTY+200, 355, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 10),

		// 리스트
		DLG_TABLE(GRID_X_A, GRID_Y_A, ROW_A, COL_A, 0, GRID_H_A, 1, GRID_H_A, SEL_ROW, MAXCHAR_A, m_stGridTitle_A, ID_ADDRLIST, m_szTableBuf_A),
	};	
	
	// PDA 다이얼로그(주소검색-도로명)
	//---------------------------------------------------------------
	DlgObject	DlgRes_NewSearch_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "현장실사"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
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
		if( g_nMemoFlag == 7 )
		{
			g_nMemoFlag = 0;
			bFirst = INIT_GMSILSA;
		}
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						break;		
				}

				SetBtnImg();	
				SetStyle();
				ReDraw(BID_TAB1);
				break;
			case INIT_GMSILSA:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Gmsilsa_P, SIZEOF(DlgRes_Gmsilsa_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_Gmsilsa, SIZEOF(DlgRes_Gmsilsa));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				Silsa_InfoDraw();
				break;
			case INIT_MTRSEARCH:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Mtr_P, SIZEOF(DlgRes_Mtr_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_Mtr, SIZEOF(DlgRes_Mtr));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				break;
			case INIT_JIBUNSEARCH:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_JibunSearch_P, SIZEOF(DlgRes_JibunSearch_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_JibunSearch, SIZEOF(DlgRes_JibunSearch));
						break;		
				}
				
				SetBtnImg();	
				SetStyle();
				break;
			case INIT_TGTSEARCH:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_TgtSearch_P, SIZEOF(DlgRes_TgtSearch_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_TgtSearch, SIZEOF(DlgRes_TgtSearch));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				break;
			case INIT_NEWSEARCH:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_NewSearch_P, SIZEOF(DlgRes_NewSearch_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_NewSearch, SIZEOF(DlgRes_NewSearch));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_TAB1:
			case BID_TAB2:
			case BID_TAB3:
				ReDraw(ID);
				break;
			case BID_SEARCH:
				if( m_bFirst == INIT_MAIN )
				{
					ON_EXIT();
					OnInit(INIT_JIBUNSEARCH);
				}
				break;
			case BID_PHOTOVIEW:
				break;
/*
			case BID_HISPREV:
				m_lpage_H--;
				if(m_lpage_H < 0)
				{
					m_lpage_H = 0;
					if(m_lTotpage_H > 0)
					{
						if( m_nActIndex_H < 0)
						{
							m_nActIndex_H = 0;
						}
					
						DlgTbl_SetActive(ID_HISLIST , m_nActIndex_H+1 );
						DlgTbl_SetRowColor(ID_HISLIST, m_nActIndex_H+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex_H = 0;
				HistoryDraw();
				break;
			case BID_HISNEXT:
				m_lpage_H++ ;
				if( m_lpage_H > m_lTotpage_H-1 )
				{
					m_lpage_H = m_lTotpage_H-1;
					if(m_lpage_H < 0)
					{
						m_lpage_H = 0;
					}
					if(m_lTotpage_H > 0)
					{
						if( m_nActIndex_H < 0 )
						{
							m_nActIndex_H = 0;
						}
					
						DlgTbl_SetActive(ID_HISLIST , m_nActIndex_H+1 );
						DlgTbl_SetRowColor(ID_HISLIST, m_nActIndex_H+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex_H = 0;
				HistoryDraw();
				break;
*/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "업무 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6101_MENU");
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
				if( m_bFirst == INIT_MAIN )
				{
					Card_Move("C6101_MENU");
				}
				else //if( m_bFirst == INIT_GMSILSA || m_bFirst == INIT_MTRSEARCH || m_bFirst == INIT_JIBUNSEARCH || m_bFirst == INIT_TGTSEARCH || m_bFirst == INIT_NEWSEARCH )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;

			case BID_SEARCH_TAB1:
				if( m_bFirst != INIT_JIBUNSEARCH && m_bFirst != INIT_TGTSEARCH && m_bFirst != INIT_NEWSEARCH )
				{
					ON_EXIT();
					OnInit(INIT_JIBUNSEARCH);
				}
				break;
			case BID_SEARCH_TAB2:
				if( m_bFirst != INIT_MTRSEARCH )
				{
					ON_EXIT();
					OnInit(INIT_MTRSEARCH);
				}
				break;
//주소 조회
			case BID_JIBUN:
				if( m_bFirst == INIT_TGTSEARCH || m_bFirst == INIT_NEWSEARCH )
				{
					ON_EXIT();
					OnInit(INIT_JIBUNSEARCH);
				}
				break;
			case BID_ROADNM:
				if( m_bFirst == INIT_JIBUNSEARCH || m_bFirst == INIT_TGTSEARCH )
				{
					ON_EXIT();
					OnInit(INIT_NEWSEARCH);
				}
				break;
			case BID_TOGETHER:
				if( m_bFirst == INIT_JIBUNSEARCH || m_bFirst == INIT_NEWSEARCH )
				{
					ON_EXIT();
					OnInit(INIT_TGTSEARCH);
				}
				break;
			case BID_ADDRCANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;

//계량기번호 조회
			case BID_MTRSEARCH:
				break;
			case BID_MTRCANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_MTROK:
				break;
//검침실사
			case BID_GMPREV:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_GMMEMO:
				//g_nMemoFlag = 7;
				//Card_Move("CM_MEMO");
				break;
			case BID_GMPHOTO:
				//화면이동 후 검침실사 화면으로 돌아오기 위해 g_nMemoFlag 사용
				//g_nMemoFlag = 7;
				//Card_Move("GM_SILSA");
				break;
		}
	}		

//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;

		if( m_bFirst == INIT_MAIN )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_MAINLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_MAINLIST);
				if ( index-1 == m_nActIndex_M )
				{
					ON_EXIT();
					OnInit(INIT_GMSILSA);
				}
				else
				{
					m_nActIndex_M = index - 1;
				}
			}
		}
		
		ON_DRAW();
		return;
	}


//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		if( theDevInfo.m_nType > FAMILY_PDA )
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
	void	SetStyle(void)
	{
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);	//검색조건
		if( m_bFirst == INIT_MTRSEARCH )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA4), TRUE, 2, EDITSEP_NONE );
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_TAB1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_TAB2), FALSE );
		}
		else if( m_bFirst == INIT_JIBUNSEARCH || m_bFirst == INIT_TGTSEARCH || m_bFirst == INIT_NEWSEARCH )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_TAB1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_TAB2), TRUE );

			if( m_bFirst == INIT_JIBUNSEARCH )
			{
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_JIBUN), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ROADNM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TOGETHER), TRUE );
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);

				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
			}
			else if( m_bFirst == INIT_TGTSEARCH )
			{
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_JIBUN), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ROADNM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TOGETHER), FALSE );

				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);

				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
			}
			else if( m_bFirst == INIT_NEWSEARCH )
			{
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_JIBUN), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ROADNM), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TOGETHER), TRUE );

				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);

				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE);
			}
		}
		else if( m_bFirst == INIT_GMSILSA )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA46), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA22), TRUE, 2, EDITSEP_NONE );
		}

		return;
	}	
	
//------------------------------------------------------------------	
	void SetCombo(void)
	{
/*
		ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA1+2));
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "계약번호", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "전화번호", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "주소", 0, ICON_NONE);

		if( m_bFirst == INIT_JIBUNSEARCH )
		{
			g_Sql_SetCombo("SELECT AREA FROM GUMDATA WHERE AREA IS NOT NULL GROUP BY AREA", CMB_DATA6+2);
			g_Sql_SetCombo("SELECT TOWN FROM GUMDATA WHERE TOWN IS NOT NULL GROUP BY TOWN", CMB_DATA7+2);
		}
		else if( m_bFirst == INIT_TGTSEARCH )
		{
			g_Sql_SetCombo("SELECT CO_LIVE_NM FROM GUMDATA WHERE CO_LIVE_NM IS NOT NULL GROUP BY CO_LIVE_NM", CMB_DATA8+2);
			g_Sql_SetCombo("SELECT BLD_NM FROM GUMDATA WHERE BLD_NM IS NOT NULL GROUP BY BLD_NM", CMB_DATA9+2);
		}
		else if( m_bFirst == INIT_NEWSEARCH )
		{
			g_Sql_SetCombo("SELECT AREA FROM GUMDATA WHERE AREA IS NOT NULL GROUP BY AREA", CMB_DATA10+2);
			g_Sql_SetCombo("SELECT NEW_ROAD_NM FROM GUMDATA WHERE NEW_ROAD_NM IS NOT NULL GROUP BY NEW_ROAD_NM", CMB_DATA11+2);
		}
*/
		return;
	}
	
	
	//------------------------------------------------------------------
	void ReDraw(long BtnId)
	{
		long k = ROW_M + 1;
		long i, idx, lstartidx;
		long lDrawFlag = 0;
		char szAddr[500];
		char szName[100];
		char sztmp[400];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( BtnId == BID_TAB1 )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB3), TRUE );
		}
		else if( BtnId == BID_TAB2 )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB3), TRUE );
		}
		else if( BtnId == BID_TAB3 )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB3), FALSE );
		}

		Mem_Set( (byte*)m_szTabTitle_1, 0x00, sizeof(m_szTabTitle_1) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Sql_RetStr( "SELECT COUNT(*) FROM C6101_SILSA WHERE PARAM1 = '1'", 20, sztmp );
		Str_Cpy(m_szTabTitle_1, "대상(");
		Str_Cat(m_szTabTitle_1, sztmp);
		Str_Cat(m_szTabTitle_1, ")");
		if( BtnId == BID_TAB1 )
		{
			m_lTotpage_M = Str_AtoI(sztmp);
		}
		
		Mem_Set( (byte*)m_szTabTitle_2, 0x00, sizeof(m_szTabTitle_2) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Sql_RetStr( "SELECT COUNT(*) FROM C6101_SILSA WHERE PARAM1 = '1' AND PARAM4 = '미완료'", 20, sztmp );
		Str_Cpy(m_szTabTitle_2, "미완료(");
		Str_Cat(m_szTabTitle_2, sztmp);
		Str_Cat(m_szTabTitle_2, ")");
		if( BtnId == BID_TAB2 )
		{
			m_lTotpage_M = Str_AtoI(sztmp);
		}
		
		Mem_Set( (byte*)m_szTabTitle_3, 0x00, sizeof(m_szTabTitle_3) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Sql_RetStr( "SELECT COUNT(*) FROM C6101_SILSA WHERE PARAM1 = '1' AND PARAM4 = '완료'", 20, sztmp );
		Str_Cpy(m_szTabTitle_3, "완료(");
		Str_Cat(m_szTabTitle_3, sztmp);
		Str_Cat(m_szTabTitle_3, ")");
		if( BtnId == BID_TAB3 )
		{
			m_lTotpage_M = Str_AtoI(sztmp);
		}
		
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( BtnId == BID_TAB1 )
		{
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM3, PARAM4 FROM C6101_SILSA WHERE PARAM1 = '1' LIMIT ?, ?" );
		}
		else if( BtnId == BID_TAB2 )
		{
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM3, PARAM4 FROM C6101_SILSA WHERE PARAM1 = '1' AND PARAM4 = '미완료' LIMIT ?, ?" );
		}
		else if( BtnId == BID_TAB3 )
		{
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM3, PARAM4 FROM C6101_SILSA WHERE PARAM1 = '1' AND PARAM4 = '완료' LIMIT ?, ?" );
		}


		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage_M*ROW_M;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage_M*ROW_M+ROW_M;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_M ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_MAINLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_MAINLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_MAINLIST, i, 2, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_MAINLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_MAINLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_MAINLIST, i, 2, "" );
					continue;
				}

				idx = 0;
				//계약번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_MAINLIST, i, 0, sztmp );
				//주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_MAINLIST, i, 1, sztmp );
				//처리상태
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_MAINLIST, i, 2, sztmp );
			}
		}		
		
Finally:

		if(m_lTotpage_M > 0)
		{
			if( m_nActIndex_M == -1 )
			{
				m_nActIndex_M = 0;
			}

			DlgTbl_SetActive(ID_MAINLIST , m_nActIndex_M+1 );
			DlgTbl_SetRowColor(ID_MAINLIST, m_nActIndex_M+1, TABLEACTIVE_COLOR);
		}

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return;
	}

	
	//------------------------------------------------------------------
	void Silsa_InfoDraw(void)
	{
		long i;
		char szindex[5];
		char szTmp[400];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stMtrChg, 0x00, sizeof(stMtrChg));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT \
PARAM2, PARAM3, PARAM5, PARAM6, PARAM7, PARAM8, PARAM9 \
, PARAM10, PARAM11, PARAM12, PARAM13, PARAM14, PARAM15 \
FROM C6101_SILSA WHERE PARAM1 = '1' "
		);
		
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

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 20  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 300 +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA26), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 20  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA28), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 20  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA29), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 100 +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA31), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA33), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA34), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA36), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA37), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA39), szTmp);

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			sql->GetValue( sql, i++, 'U', (long*) szTmp       , 50  +1, DECRYPT );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA40), szTmp);
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}

		Silsa_QtyDraw();

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		ON_DRAW();
		return;
	}


	//------------------------------------------------------------------
	void Silsa_QtyDraw(void)
	{
		long k = ROW_G + 1;
		long i, idx, lstartidx;
		long lDrawFlag = 0;
		char sztmp[400];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		m_lpage_G = 0;

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7, PARAM8 FROM C6101_SILSA WHERE PARAM1 = '2' LIMIT ?, ?" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage_G*ROW_G;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage_G*ROW_G+ROW_G;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_G ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_GMLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 6, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_GMLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 6, "" );
					continue;
				}

				idx = 0;
				//청구년월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 0, sztmp );
				//VC지침
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 1, sztmp );
				//VC사용량
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 2, sztmp );
				//VA지침
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 3, sztmp );
				//VA사용량
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 4, sztmp );
				//VM지침
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 5, sztmp );
				//VM사용량
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 6, sztmp );
			}
		}		
		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
}




