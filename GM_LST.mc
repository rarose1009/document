/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_LST
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_TASK

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
//검침 리스트
		DEF_BUTTON_ID ( BID_LIST_SEARCH )	//조회
		DEF_BUTTON_ID ( BID_NADDR )			//주소 토글
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//도로명주소 스크롤 호출
		DEF_BUTTON_ID ( BID_HISTORY )		//이력
//검색
		DEF_BUTTON_ID ( BID_SEARCH1 )		//기물번호조회
		DEF_BUTTON_ID ( BID_SEARCH2 )		//구주소조회
		DEF_BUTTON_ID ( BID_SEARCH3 )		//신주소조회
		DEF_BUTTON_ID ( BID_SEARCH4 )		//구주소 공동
		DEF_BUTTON_ID ( BID_CHKBOX1)		//
		DEF_BUTTON_ID ( BID_CHKBOX2 )		//
		
		DEF_BUTTON_ID ( BID_REFLESH )
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
//검침 리스트
		DEF_OBJECT_ID ( TXT_PAGE )			//페이지
		DEF_OBJECT_ID ( TXT_ADDR1 )			//주소
		DEF_OBJECT_ID ( TXT_ADDR2 )			//주소
		DEF_OBJECT_ID ( TXT_DATA1 )			//완료
		DEF_OBJECT_ID ( TXT_DATA2 )			//완료 대상 수
//검색
		DEF_OBJECT_ID ( TXT_ALONE )			//단독(체크박스)
		DEF_OBJECT_ID ( TXT_TOGETHER )		//공동(체크박스)
		DEF_OBJECT_ID ( TXT_OBJNUM )		//기물번호
		DEF_OBJECT_ID ( TXT_ADDR)			//주소
		DEF_OBJECT_ID ( TXT_GOO )			//구
		DEF_OBJECT_ID ( TXT_DONG )			//동
		DEF_OBJECT_ID ( TXT_BUNJI )			//번지
		DEF_OBJECT_ID ( TXT_HOSOO )			//호수
		DEF_OBJECT_ID ( TXT_TGTADDR)		//주소
		DEF_OBJECT_ID ( TXT_TGTHBDNM )		//공동주택명
		DEF_OBJECT_ID ( TXT_BDNM )			//건물명
		DEF_OBJECT_ID ( TXT_HO )			//호
		DEF_OBJECT_ID ( TXT_NWADDR )		//신주소
		DEF_OBJECT_ID ( TXT_NWGOO )			//구
		DEF_OBJECT_ID ( TXT_STREET )		//도로명
		DEF_OBJECT_ID ( TXT_BONBUN )		//본번
		DEF_OBJECT_ID ( TXT_BOOBUN )		//부번
		
//검색
		DEF_OBJECT_ID ( EDT_OBJNUM )		//기물번호 입력
		DEF_OBJECT_ID ( EDT_BUNJI )			//번지 입력
		DEF_OBJECT_ID ( EDT_HOSOO )			//호수 입력
		DEF_OBJECT_ID ( EDT_HO )			//호 입력
		DEF_OBJECT_ID ( EDT_BONBUN )		//본번 입력
		DEF_OBJECT_ID ( EDT_BOOBUN )		//부번 입력
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
//그리드
		DEF_OBJECT_ID ( ID_GRIDLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		DEF_OBJECT_ID ( ICON_TITLE_Srch )		//타이틀
//검색
		DEF_OBJECT_ID ( CMB_GOO ) 						//구
		DEF_OBJECT_ID ( CMB_DONG = CMB_GOO+3 ) 			//동
		DEF_OBJECT_ID ( CMB_TGTHBDNM = CMB_DONG+3 ) 	//공동주택명
		DEF_OBJECT_ID ( CMB_BDNM = CMB_TGTHBDNM+3 ) 	//건물명
		DEF_OBJECT_ID ( CMB_NWGOO = CMB_BDNM+3 ) 		//구
		DEF_OBJECT_ID ( CMB_STREET = CMB_NWGOO+3 ) 		//도로명
		DEF_OBJECT_ID ( CMB_SELECT = CMB_STREET+3 ) 	//리스트 목록 필터
	END_OBJECT_ID()
	
	//Grid 적용
	//#define GRID_DEBUG

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(상세리스트)
	//-------------------------------------------------------------------------------------------------
#ifdef GRID_DEBUG
	#define		ROW 	    50					// table의 행개수
#else
	#define		ROW 	    7					// table의 행개수
#endif
	#define		COL 	    10					// table의 열개수
	#define		GRID_H		(CHT+34)			// table 행 높이
	#define		GRID_H_P	(CHT+48)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+240  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    //table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"주소",     CWD*17, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"D",        CWD*4,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"C",        CWD*3,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"지침",     CWD*8,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"사용량",   CWD*7+23,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소",	 CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ROWID",    CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"INST_PLACE_NUM",  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"COUNS_HIST",  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	


#ifdef GRID_DEBUG

	//그리드 테스트
	Column m_stGridCtrl_Title[] = {
		{ "주소",     		308, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "D",         		100, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "C",     			100, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "지침",     		180, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "사용량", 		180, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "주소",           0 , 0, GCTYPE_TEXTCTRL	, 32},
		{ "상세주소",       0 , 0, GCTYPE_TEXTCTRL	, 32},
		{ "ROWID",          0 , 0, GCTYPE_TEXTCTRL	, 32},
		{ "INST_PLACE_NUM", 0 , 0, GCTYPE_TEXTCTRL	, 32},
		{ "COUNS_HIST",     0 , 0, GCTYPE_TEXTCTRL	, 32},
		{ "",               130 , 0, GCTYPE_TEXTCTRL, 1}
	};

//#else

//	Column m_stGridCtrl_Title[] = {
//		{ "주소",    200, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "D",       100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "C",     	 100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "지침",    100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "사용량",  100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "",        80 , 0, GCTYPE_TEXTCTRL	, 32}
//	};
	
#endif

	#define INIT_MAIN	 1
	#define	INIT_SRCH 	 2		// 검색
	// #define	INIT_REFLESH 	 3		// 검색
	
	handle m_hGrid = NULL;
	
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index 관련 flag
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_nActIndex = -1;		//선택된 row index
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szAdrss[120];		// 상단 주소 표시
	char m_szSql[2][800];
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	char m_szCobSel[20];		//콤보박스

	bool Search_Addr(long nbuttonid);
	bool REDRAW(void);
	void Cmb_Result(void);
	void SetStyle(void);
	void SetCombo(void);
	void SetComboIdx(void);
	bool SetSearch(void);		//검색 후 데이터 저장.
	void Cmb_Filter(void);	//콤보박스 필터
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//선택한 대상 인덱스 저장
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
	void SetBtnImg(void);
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	void OnList(quad lParam);
	
	void Rcv25012(void);
	long TR25012(void);
	
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
	
	// 메인 다이얼로그(리스트)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "상세 리스트"),
		
		DLG_BUTTON(STARTX+735,   STARTY+5, 90, 50, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REFLESH, ""),
		
		DLG_TEXT(STARTX+550,    STARTY+65, 200, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "완료"),
		DLG_TEXT(STARTX+750,    STARTY+65, 249, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
//		DLG_BUTTON(STARTX+20,   STARTY+70, 300, 50, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "지 번"),
		DLG_BUTTON(STARTX,      STARTY+65, 275, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		DLG_BUTTON(STARTX+275,  STARTY+65, 275, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		
		DLG_TEXT(STARTX,       STARTY+130, 849, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),			//기본주소
		DLG_BUTTON(STARTX+849, STARTY+130, 150, 110, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISTORY, "이력"),
		
		//DLG_TEXT(STARTX+20,    STARTY+180, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),			//상세주소

		DLG_TEXT(STARTX,       STARTY+829, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		DLG_BUTTON(STARTX+800, STARTY+829, 199, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "지 번"),

#ifdef GRID_DEBUG
			
		DLG_GRID(GRID_X, GRID_Y, 1000, 590, 0, FRMSTY_BORDER|FRMSTY_ALWAYSSHOWSB, ID_GRIDLIST, ROW, 70, 150, 800, 90, TABLEACTIVE_COLOR, m_stGridCtrl_Title),

#else

		DLG_BUTTON(STARTX+400, STARTY+829, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+600, STARTY+829, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
#endif		
	};	
	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "상세 리스트"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX,	  STARTY-40, 450, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		DLG_BUTTON(STARTX,	  STARTY+20, 450, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "지번"),
		
		DLG_TEXT(STARTX+500,  STARTY-40, 200, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "완료"),
		DLG_TEXT(STARTX+700,  STARTY-40, 300, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_TEXT(STARTX,	   STARTY+80, 850, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),			//기본주소
		DLG_BUTTON(STARTX+850, STARTY+80, 150, 120, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISTORY, "이력"),
		//DLG_TEXT(STARTX+20,  STARTY+135, 950, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),			//상세주소

		DLG_BUTTON(STARTX+500, STARTY+20, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+20, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};
	
	// 메인 다이얼로그(검색)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Srch[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE_Srch, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "지정 검침"),
		
		DLG_BUTTON(STARTX+775,  STARTY+70, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),		//기물번호
		DLG_BUTTON(STARTX+775, STARTY+170, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),	//구주소
		DLG_BUTTON(STARTX+775, STARTY+400, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),	//구주소 공동
		DLG_BUTTON(STARTX+775, STARTY+630, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),	//신주소
				
		DLG_TEXT(STARTX, 	 STARTY+70, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		
		DLG_TEXT(STARTX, 	 STARTY+170, 775, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_ADDR, "지번(단독)"),
		DLG_TEXT(STARTX, 	 STARTY+230, 100, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_GOO, "구"),
		DLG_TEXT(STARTX+490, STARTY+230, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DONG, "동"),
		DLG_TEXT(STARTX, 	 STARTY+290, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BUNJI, "번지"),
		DLG_TEXT(STARTX+490, STARTY+290, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_HOSOO, "호수"),
		
		DLG_TEXT(STARTX, 	 STARTY+400, 775, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TGTADDR, "지번(공동)"),
		DLG_TEXT(STARTX, 	 STARTY+460, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TGTHBDNM, "공동주택명"),
		DLG_TEXT(STARTX, 	 STARTY+520, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BDNM, "건물명"),
		DLG_TEXT(STARTX+690, STARTY+520, 100, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_HO, "호"),		
		
		DLG_TEXT(STARTX, 	 STARTY+630, 775, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWADDR, "도로명"),
		DLG_TEXT(STARTX, 	 STARTY+690, 100, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWGOO, "구"),
		DLG_TEXT(STARTX+490, STARTY+690, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_STREET, "도로명"),
		DLG_TEXT(STARTX, 	 STARTY+750, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BONBUN, "본번"),
		DLG_TEXT(STARTX+490, STARTY+750, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "부번"),
		
		DLG_EDIT(STARTX+300,  STARTY+70, 475, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+200, STARTY+290, 290, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BUNJI, 10,  ""),
		DLG_EDIT(STARTX+640, STARTY+290, 335, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_HOSOO, 10,  ""),
		DLG_EDIT(STARTX+790, STARTY+520, 185, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_HO, 10,  ""),
		DLG_EDIT(STARTX+200, STARTY+750, 290, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_EDIT(STARTX+690, STARTY+750, 285, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR , EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+100, STARTY+230, 390, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//구(구 주소)
		DLG_COMBO (STARTX+640, STARTY+230, 335, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//동
		DLG_COMBO (STARTX+350, STARTY+460, 625, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_TGTHBDNM, 10),	//공동주택명
		DLG_COMBO (STARTX+200, STARTY+520, 490, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BDNM, 10),		//건물명
		DLG_COMBO (STARTX+100, STARTY+690, 390, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//구(신 주소)
		DLG_COMBO (STARTX+690, STARTY+690, 285, 200, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//도로명
	};	
	// PDA 다이얼로그(검색)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Srch_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE_Srch, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "지정 검침"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),


		DLG_BUTTON(STARTX+775,         80, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),		//기물번호
		DLG_BUTTON(STARTX+775,  STARTY+80, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),	//구주소 단독
		DLG_BUTTON(STARTX+775, STARTY+340, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),	//구주소 공동
		DLG_BUTTON(STARTX+775, STARTY+600, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),	//신주소
	
		DLG_TEXT(STARTX, 	         80, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_EDIT(STARTX+300,         80, 475, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_OBJNUM, 20,  ""),
		
		DLG_TEXT(STARTX, 	  STARTY+80, 775, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_ADDR, "지번(단독)"),
		DLG_TEXT(STARTX, 	 STARTY+160, 100, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_GOO, "구"),
		DLG_TEXT(STARTX+490, STARTY+160, 150, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DONG, "동"),
		DLG_TEXT(STARTX, 	 STARTY+240, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BUNJI, "번지"),
		DLG_TEXT(STARTX+490, STARTY+240, 150, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_HOSOO, "호수"),
		DLG_EDIT(STARTX+200, STARTY+240, 290, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_BUNJI, 10,  ""),
		DLG_EDIT(STARTX+640, STARTY+240, 335, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_HOSOO, 10,  ""),

		
		DLG_TEXT(STARTX, 	 STARTY+340, 775, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TGTADDR, "지번(공동)"),
		DLG_TEXT(STARTX, 	 STARTY+420, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TGTHBDNM, "공동주택명"),
		DLG_TEXT(STARTX, 	 STARTY+500, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BDNM, "건물명"),
		DLG_TEXT(STARTX+690, STARTY+500, 100, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_HO, "호"),		
		DLG_EDIT(STARTX+790, STARTY+500, 185, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_HO, 10,  ""),
		
		DLG_TEXT(STARTX, 	 STARTY+600, 775, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWADDR, "도로명"),
		DLG_TEXT(STARTX, 	 STARTY+680, 100, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWGOO, "구"),
		DLG_TEXT(STARTX+490, STARTY+680, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_STREET, "도로명"),
		DLG_TEXT(STARTX, 	 STARTY+760, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BONBUN, "본번"),
		DLG_TEXT(STARTX+490, STARTY+760, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "부번"),
		DLG_EDIT(STARTX+200, STARTY+760, 290, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_EDIT(STARTX+690, STARTY+760, 285, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+100, STARTY+160, 405, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//구(구 주소)
		DLG_COMBO (STARTX+640, STARTY+160, 335, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//동
		DLG_COMBO (STARTX+350, STARTY+420, 625, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TGTHBDNM, 10),	//공동주택명
		DLG_COMBO (STARTX+200, STARTY+500, 490, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_BDNM, 10),		//건물명
		DLG_COMBO (STARTX+100, STARTY+680, 390, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//구(신 주소)
		DLG_COMBO (STARTX+690, STARTY+680, 285, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//도로명
	};	
    //검침 반영 화면
	// DlgObject	DlgRes_Reflesh[] = 
	// {
	// 	NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
	// 	DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
	// 	DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
	// 	//타이틀
	// 	DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "검침반영"),
		
	// 	DLG_BUTTON(STARTX+600, STARTY+350, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMSOK , "문자/기타"),
	// 	DLG_BUTTON(STARTX+700, STARTY+350, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REMOTEOK , "원격"),
		
	// 	DLG_TEXT(STARTX, 		 STARTY+65,  230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA57 , " 항 목 "),
	// 	// DLG_TEXT(STARTX+230, 	 STARTY+65,  350, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA43 , "철거 계량기"),
	// 	DLG_TEXT(STARTX+230, 	 STARTY+65,  770, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA58 , "소요비용"),
	// 	DLG_TEXT(STARTX, 		 STARTY+115, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA59 , "배터리"),
	// 	DLG_TEXT(STARTX, 		 STARTY+165, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA60 , "지시부"),
	// 	// DLG_TEXT(STARTX, 		 STARTY+215, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA61 , "기타비용"),
	// 	// DLG_TEXT(STARTX+230,     STARTY+215, 760, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA48, ""),
	// 	// DLG_EDIT(STARTX+230, 	 STARTY+215, 760, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA12,9, ""),
		
	// 	DLG_COMBO(STARTX+230,  STARTY+115, 770, 50, 80, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA13, 15),
	// 	DLG_COMBO(STARTX+230,  STARTY+165, 770, 50, 80, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA14, 15),
	// };	


	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
//PRINT("MsgType : %d , wParam : %d",MsgType,wParam,0);
		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
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
			
			// case INIT_REFLESH:
			// 	switch (theDevInfo.m_nType)
			// 	{
			// 		default:
			// 			CREATE_DIALOG_OBJECT (DlgRes_Reflesh, SIZEOF(DlgRes_Reflesh));
			// 			break;
			// 	}
			// 	SetBtnImg();
			// 	SetStyle();
			// 	SetCombo();
			// 	break;

#ifdef GRID_DEBUG

				m_hGrid = Get_hDlgCtrlByID(ID_GRIDLIST);
				GridCtrl_SetPageInfo(m_hGrid, ROW, m_lpage, m_lTotpage, REDRAW);

#endif				
				g_nAddrFlag = 0;
				g_nTelFlag = 0;
				g_nNameFlag = 0;
				g_lDataflag = 0;
				SetBtnImg();
				SetStyle();
				REDRAW();
				break;
			case INIT_SRCH:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Srch_P, SIZEOF(DlgRes_Srch_P));
						
						SetBtnImg();
						SetCombo();
						SetStyle();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_Srch, SIZEOF(DlgRes_Srch));
						
						SetBtnImg();
						SetCombo();
						SetStyle();
						break;	
				}
				break;

			// case INIT_REFLESH:
			// 	switch (theDevInfo.m_nType)
			// 	{
			// 		default:
			// 			CREATE_DIALOG_OBJECT (DlgRes_PAY, SIZEOF(DlgRes_PAY));
			// 			break;
			// 	}
			// 	SetBtnImg();
			// 	SetStyle();
			// 	SetCombo();
			// 	break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		
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
				
				h = Get_hDlgCtrlByID(BID_REFLESH);
				ButCtrl_SetImage( h,  g_pImgCm_Reflesh);
			}
		}
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		}

	}


//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( m_bFirst == INIT_SRCH )
		{	
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+70) && Y < DMS_Y(STARTY+130) ||
					    X > DMS_X(STARTX+200) && X < DMS_X(STARTX+490) && Y > DMS_Y(STARTY+290) && Y < DMS_Y(STARTY+350) ||
					    X > DMS_X(STARTX+640) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+290) && Y < DMS_Y(STARTY+350) )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( Get_iDlgCtrlByID(EDT_OBJNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BUNJI) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_HOSOO) == lActiveIndex )	
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
					else if( X > DMS_X(STARTX+790) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+520-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+580-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+490) && Y > DMS_Y(STARTY+750-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+810-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+690) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+750-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+810-(g_Dlgflag*400)) )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( Get_iDlgCtrlByID(EDT_HO) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BONBUN) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BOOBUN) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
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


//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		char sztmp[20];
		char szAddr[200];
		
		if( INIT_MAIN == m_bFirst )
		{

#ifdef GRID_DEBUG

			if (Index > 0)
			{
				if (Index == m_nActIndex)
				{
					//선택된 파일의 위치 INDEX를 글로벌변수에 저장
					//g_nWorkFlag :  101 -> 검색 , 102 -> 검침&송신 완료 + 검침완료 & 송신 미완료 , 103 -> 미검침
					g_nActIndex = m_lpage*ROW + Index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					Set_Index();
					//g_lMoveFlag = 1;
					if(g_nWorkFlag == 101)//선택검침으로 이동하면 
					{
						g_nWorkFlag = 100;
					}
					Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
					Card_Move("GM_ENTRY");
					return;
				}
				
				m_nActIndex = Index;

				Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr));
				Str_Cpy(szAddr, GridCtrl_GetCellStr(m_hGrid, 5, m_nActIndex));
				Str_Cat(szAddr, "  ");
				Str_Cat(szAddr, GridCtrl_GetCellStr(m_hGrid, 6, m_nActIndex));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), szAddr);
				
				//PRINT("addr : [%d] = %s",m_nActIndex,GridCtrl_GetCellStr(m_hGrid, 3, m_nActIndex),0);
				
				Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
				Str_Cpy(g_szROWID, GridCtrl_GetCellStr(m_hGrid, 7, m_nActIndex));

				Mem_Set( (byte*)g_szINST_PLACE_NUM, 0x00, sizeof(g_szINST_PLACE_NUM));
				Str_Cpy(g_szINST_PLACE_NUM, GridCtrl_GetCellStr(m_hGrid, 8, m_nActIndex));

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, GridCtrl_GetCellStr(m_hGrid, 9, m_nActIndex));
				if( Str_Cmp(sztmp, "Y") == 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), RED);
				}
				else
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), BTNMENUFRCOLOR);
				}
			}			

#else
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				if ( index-1 == m_nActIndex )
				{
					//선택된 파일의 위치 INDEX를 글로벌변수에 저장
					//g_nWorkFlag :  101 -> 검색 , 102 -> 검침&송신 완료 + 검침완료 & 송신 미완료 , 103 -> 미검침
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					Set_Index();
					//g_lMoveFlag = 1;
					if(g_nWorkFlag == 101)//선택검침으로 이동하면 
					{
						g_nWorkFlag = 100;
					}
					Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
					
					Card_Move("GM_ENTRY");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//선택된 INDEX 저장
				
					//처음 선택된 대상의 주소를 상단에 표시
					Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr));
					Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
					Str_Cat(szAddr, "  ");
					Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), szAddr);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					
					Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
					Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
					Mem_Set( (byte*)g_szINST_PLACE_NUM, 0x00, sizeof(g_szINST_PLACE_NUM));
					Str_Cpy( g_szINST_PLACE_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), RED);
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), BTNMENUFRCOLOR);
					}
				}
			}
#endif
		}
	}
	
	//------------------------------------------------------------------------
	void OnTask(long nEvent, long nData)
	{
		long nRet = 0;
		if(nEvent == TASK_SYS_CALL)
		{
			return;
		}
	}

//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i;
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM GUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
			
			Card_Move("GM_ENTRY");
		}
		
		return;
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR1), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_SRCH )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DONG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BUNJI), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HOSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TGTADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TGTHBDNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BDNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWGOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STREET), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BONBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOOBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OBJNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BUNJI), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_HOSOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_HO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BONBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BOOBUN), EDITALIGN_MIDDLE);		
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DONG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_TGTHBDNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BDNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_NWGOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_STREET), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}
	
	//------------------------------------------------------------------
	void SetCombo(void)
	{
		g_Sql_SetCombo("SELECT AREA FROM GUMDATA WHERE AREA IS NOT NULL GROUP BY AREA", CMB_GOO+2);
		g_Sql_SetCombo("SELECT TOWN FROM GUMDATA WHERE TOWN IS NOT NULL GROUP BY TOWN", CMB_DONG+2);
		g_Sql_SetCombo("SELECT CO_LIVE_NM FROM GUMDATA WHERE CO_LIVE_NM IS NOT NULL GROUP BY CO_LIVE_NM", CMB_TGTHBDNM+2);
		g_Sql_SetCombo("SELECT BLD_NM FROM GUMDATA WHERE BLD_NM IS NOT NULL GROUP BY BLD_NM", CMB_BDNM+2);
		g_Sql_SetCombo("SELECT AREA FROM GUMDATA WHERE AREA IS NOT NULL GROUP BY AREA", CMB_NWGOO+2);
		g_Sql_SetCombo("SELECT NEW_ROAD_NM FROM GUMDATA WHERE NEW_ROAD_NM IS NOT NULL GROUP BY NEW_ROAD_NM", CMB_STREET+2);
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList(ID);
				break;
			case BID_NADDR:
				//g_nAddrFlag = 0 -> 구주소    g_nAddrFlag = 1 -> 신주소
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NADDR), "도로명");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NADDR), "지번");
				}

				REDRAW();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0)
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
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
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0 )
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;
			case BID_HISTORY:
				if( m_nActIndex < 0 )
				{
					MessageBoxEx (CONFIRM_OK, "대상을 선택해주세요.");
				}
				else
				{
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					g_nGrpFlag = 0;
					Card_Move("GM_HISTORY");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "검침 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("GM_MENU");
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
				Card_Move("GM_GRPLST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			
			case BID_REFLESH:
			
				if( MessageBoxEx (CONFIRM_YESNO, "자료를 수신받겠습니까?")  == MB_OK)
				{
					Rcv25012();
					
				}
				
				break;
		}
	}	
//------------------------------------------------------------------------------------------
//한글 검색 안됨. 나중에 얘기 후 수정 해야 할 부분(UTF-8변환 문제)
//------------------------------------------------------------------------------------------
	bool Search_Addr(long nbuttonid)
	{
		char szWhere[400];
		char szSql[600];
		long chki= 0;
	
		Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		
		Str_Cpy( szSql, "SELECT ROWID FROM GUMDATA WHERE ");
		Str_Cpy( m_szSql[0], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ') ||' '|| ifnull(HOSU,' ') ||' '|| ifnull(DETA_FLOOR,' '), ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' ') ||' '|| ifnull(HOSU,' ') ||' '|| ifnull(DETA_FLOOR,' '), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||'-'|| ifnull(ADDR1_S,' '),  ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ')||'-'||ifnull(HOSU,' ') ||' '||ifnull(DETA_FLOOR,' '), ROWID FROM GUMDATA WHERE ");
		Str_Cpy( m_szSql[1], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ') ||' '|| ifnull(HOSU,' ') ||' '|| ifnull(DETA_FLOOR,' '), ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' ') ||' '|| ifnull(HOSU,' ') ||' '|| ifnull(DETA_FLOOR,' '), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||'-'|| ifnull(NEW_ADDR_S,' '), ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ')||'-'||ifnull(HOSU,' ') ||' '|| ifnull(DETA_FLOOR,' '), ROWID FROM GUMDATA WHERE ");

		
		if(nbuttonid == BID_SEARCH1 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OBJNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "기물번호를 입력하세요.");
				return FALSE;
			}
			
			Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
			Str_Cat( szWhere, "MTR_ID_NUM = '" );
			Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_OBJNUM) ) );
			Str_Cat( szWhere, "' " );
			
			Str_Cat( szSql, szWhere );
			Str_Cat( m_szSql[0], szWhere );
			Str_Cat( m_szSql[1], szWhere );
		}
		else if(nbuttonid == BID_SEARCH2 )
		{
			//지번 단독 검색
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_GOO)) == 0 ||
			    EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DONG)) == 0 ||
			    EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BUNJI)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "주소입력을 확인하세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_GOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "AREA = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_GOO) ) );
				Str_Cat( szWhere, "' " );
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
				Str_Cat( szWhere, "TOWN = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DONG) ) );
				Str_Cat( szWhere, "' " );
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
				Str_Cat( szWhere, "ADDR1_M = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BUNJI) ) );
				Str_Cat( szWhere, "' " );
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
				Str_Cat( szWhere, "ADDR1_S = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_HOSOO) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		else if(nbuttonid == BID_SEARCH4 )
		{
			//지번 공동 검색
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_TGTHBDNM)) == 0 ||
			    EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_BDNM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "공동 주택 입력을 확인하세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_TGTHBDNM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "CO_LIVE_NM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_TGTHBDNM) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_BDNM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "BLD_NM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BDNM) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "HOSU = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_HO) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		else if(nbuttonid == BID_SEARCH3 )
		{	
			//도로명 검색
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_NWGOO)) == 0 ||
			    EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_STREET)) == 0 ||
			    EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BONBUN)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "주소입력을 확인하세요..");
				return FALSE;
			}

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_NWGOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "AREA = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_NWGOO) ) );
				Str_Cat( szWhere, "' " );
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
				Str_Cat( szWhere, "NEW_ROAD_NM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_STREET) ) );
				Str_Cat( szWhere, "' " );
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
				Str_Cat( szWhere, "NEW_ADDR_M = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BONBUN) ) );
				Str_Cat( szWhere, "' " );
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
				Str_Cat( szWhere, "NEW_ADDR_S = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BOOBUN) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		
		Str_Cat( szSql, "ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE " );
		//Str_Cat( m_szSql[0], "ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ? , ? "  );
		//Str_Cat( m_szSql[1], "ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ? , ? "  );
		Str_Cat( m_szSql[0], "ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE "  );
		Str_Cat( m_szSql[1], "ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE "  );

		//페이지를 초기화시킨다.
		m_lpage = 0;
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		return TRUE;
	}

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	bool SetSearch(void)
	{
		bool ret = TRUE;
		long i, idx;
		long k = ROW+1;
		long lRow;
		char sztmp[201];
		char szSql[301];	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		else
			hstmt = sql->CreateStatement(sql, m_szSql[1]);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{	
			Mem_Set( (byte*)stGm.ROWID, 0x00, sizeof(stGm.ROWID) );
			sql->GetValue(sql, 9, 'U', (long*)stGm.ROWID, 5 + 1, DECRYPT);
			lRow = Str_AtoI(stGm.ROWID);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE ", 0, 0, 0);
			g_Sql_SaveSeq( szSql, SREACH_FILE);
			
			g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		return ret;
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
		SPRINT(szSql, "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		lRow = Str_AtoI(g_szROWID);
		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '1' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);


		return;
	}

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------

#ifdef GRID_DEBUG

	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char sztmp[201];
		bool ret = TRUE;	
		handle h = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_SaveSeq( "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", SREACH_FILE);

		lTotPage = FS_GetSrchTotCnt();
		m_lTotpage = lTotPage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		//if(g_lMoveFlag == 1 && m_lIdxFlag == 0)
		//{
			//화면 이동 후 인덱스
		//	m_lpage = g_nActIndex / ROW;
		//	m_nActIndex = (g_nActIndex % ROW);
		//}
		//if( g_lMoveFlag == 0 && m_lIdxFlag == 0)
		if( m_lIdxFlag == 0)
		{
			//프로그램 시작 시 불러오는 인덱스
			Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		else
			hstmt = sql->CreateStatement(sql, "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
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
			ret = FALSE;
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		//i가 1부터 시작하기 때문에 전체갯수에 +1 을 해준다.
		for (i=1 ; i<lTotPage+1 ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				GridCtrl_SetCellStr ( m_hGrid, 0, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 1, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 2, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 3, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 4, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 5, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 6, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 7, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 8, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 9, i, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					GridCtrl_SetCellStr ( m_hGrid, 0, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 1, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 2, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 3, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 4, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 5, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 6, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 7, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 8, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 9, i, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				//idx = 0;
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				if( Str_Cmp(sztmp, "0") > 0 )
				{
					//주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 200, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 0, i, sztmp );
					h = GridCtrl_GetCellHandle(m_hGrid, i, 0);
					EditCtrl_SetAlign(h, EDITALIGN_LEFT|EDITALIGN_MIDDLE);
					EditCtrl_SetMultiLine(h, TRUE, 2, EDITSEP_NONE );
	
					//기준일자
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 1, i, sztmp );
	
					//계량기작업코드
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 2, i, sztmp );
	
					//지침
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 3, i, sztmp );
	
					//사용량
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 20, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 4, i, sztmp );

					//기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 5, i, sztmp );

					//상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 200, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 6, i, sztmp );
				}
				else
				{
					//주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 200, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 0, i, sztmp );
					h = GridCtrl_GetCellHandle(m_hGrid, i, 0);
					EditCtrl_SetAlign(h, EDITALIGN_LEFT|EDITALIGN_MIDDLE);
					EditCtrl_SetMultiLine(h, TRUE, 2, EDITSEP_NONE );
	
					//기준일자
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 1, i, sztmp );
	
					//계량기작업코드
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 2, i, sztmp );
	
					//지침
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 3, i, sztmp );
	
					//사용량
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 20, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 4, i, sztmp );

					//기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 5, i, sztmp );

					//상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 200, DECRYPT);
					GridCtrl_SetCellStr ( m_hGrid, 6, i, sztmp );
				}
				
				//ROWID
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 10, 'U', (long*)sztmp, 20, DECRYPT);
				GridCtrl_SetCellStr ( m_hGrid, 7, i, sztmp );

				//INST_PLACE_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 11, 'U', (long*)sztmp, 20, DECRYPT);
				GridCtrl_SetCellStr ( m_hGrid, 8, i, sztmp );

				//COUNS_HIST
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 12, 'U', (long*)sztmp, 20, DECRYPT);
				GridCtrl_SetCellStr ( m_hGrid, 9, i, sztmp );

			}
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			//DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			//DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//처음 선택된 대상의 주소를 상단에 표시
			//Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			//Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			
			//Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
			//Str_Cpy( g_szUSE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			m_lIdxFlag = 1;
		}
		ON_DRAW();		
		return TRUE;
	}

#else
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char sztmp[201];
		char szProd_cd[10];
		char szGmtr_ym_flag[10];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		g_Sql_SaveSeq( "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", SREACH_FILE);

		lTotPage = FS_GetSrchTotCnt();
		m_lTotpage = lTotPage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		//if(g_lMoveFlag == 1 && m_lIdxFlag == 0)
		//{
			//화면 이동 후 인덱스
		//	m_lpage = g_nActIndex / ROW;
		//	m_nActIndex = (g_nActIndex % ROW);
		//}
		//if( g_lMoveFlag == 0 && m_lIdxFlag == 0)
		if( m_lIdxFlag == 0)
		{
			//프로그램 시작 시 불러오는 인덱스
			Get_Index();
		}


		SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST, PROD_CD, GMTR_YM_FLAG, REMOTE_MTR_ERR_YN , DISC_CUST_YN FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		else
			hstmt = sql->CreateStatement(sql, "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST, PROD_CD, GMTR_YM_FLAG, REMOTE_MTR_ERR_YN, DISC_CUST_YN FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
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
			ret = FALSE;
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
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
					continue;
				}
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				//idx = 0;
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				if( Str_Cmp(sztmp, "0") > 0 )
				{
					//idx = 1;
					//주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//기준일자
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					//계량기작업코드
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					//지침
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					//사용량
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					//ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 10, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					//INST_PLACE_NUM
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 11, 'U', (long*)sztmp, 20, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					//COUNS_HIST
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 12, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					//PROD_CD
					Mem_Set( (byte*)szProd_cd, 0x00, sizeof(szProd_cd) );
					sql->GetValue(sql, 13, 'U', (long*)szProd_cd, 10, DECRYPT);
					
					//GMTR_YM_FLAG
					Mem_Set( (byte*)szGmtr_ym_flag, 0x00, sizeof(szGmtr_ym_flag) );
					sql->GetValue(sql, 14, 'U', (long*)szGmtr_ym_flag, 10, DECRYPT);
					
					//REMOTE_MTR_ERR_YN
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 15, 'U', (long*)sztmp, 10, DECRYPT);
					
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), RED);	
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), TXTFRCOLOR);
					}
				}
				else
				{
					//주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//기준일자
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					//계량기작업코드
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					//지침
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					//사용량
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					//ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 10, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					//INST_PLACE_NUM
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 11, 'U', (long*)sztmp, 20, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					//COUNS_HIST
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 12, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					//PROD_CD
					Mem_Set( (byte*)szProd_cd, 0x00, sizeof(szProd_cd) );
					sql->GetValue(sql, 13, 'U', (long*)szProd_cd, 10, DECRYPT);
					//DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					//GMTR_YM_FLAG
					Mem_Set( (byte*)szGmtr_ym_flag, 0x00, sizeof(szGmtr_ym_flag) );
					sql->GetValue(sql, 14, 'U', (long*)szGmtr_ym_flag, 10, DECRYPT);
					
					//REMOTE_MTR_ERR_YN
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 15, 'U', (long*)sztmp, 10, DECRYPT);
					
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), RED);	
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), TXTFRCOLOR);
					}
				}

				if( Str_Cmp(szProd_cd, "순수취사") == 0 || Str_Cmp(szProd_cd, "겸용취사") == 0 || Str_Cmp(szProd_cd, "순수난방") == 0 || Str_Cmp(szProd_cd, "냉난방공조용") == 0)
				{	
					//DISC_CUST_YN
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 16, 'U', (long*)sztmp, 10, DECRYPT);

					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), LIGHTPINK);	
					}
					else
					{
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), BTNMENUFRCOLOR);
						
					}

				}

			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//처음 선택된 대상의 주소를 상단에 표시
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			Str_Cat(sztmp, "  ");
			Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), sztmp);
/*
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
*/
			
			Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
			Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
			Mem_Set( (byte*)g_szINST_PLACE_NUM, 0x00, sizeof(g_szINST_PLACE_NUM));
			Str_Cpy( g_szINST_PLACE_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));
			if( Str_Cmp(sztmp, "Y") == 0 )
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), RED);
			}
			else
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), BTNMENUFRCOLOR);
			}
			
			//g_lMoveFlag = 0;
			m_lIdxFlag = 1;
			
			Cmb_Result();
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "0");
		}
		ON_DRAW();		
		return TRUE;
	}
	
#endif
	
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
	
	/*=======================================================================================
	함수명 : Set_Index
	기  능 : 최종 인덱스 저장한다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '1' ", g_lindex, 0, 0);		
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
		
		// g_nGrpFlag = 0 > 그룹리스트->상세리스트 이동 //// g_nGrpFlag = 1 > 점검등록->상세리스트 이동
		if( g_nGrpFlag == 0 )
		{
			//g_nActIndex = Str_AtoI(szbuf);
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = (g_nActIndex % ROW);
			
			g_nGrpFlag = 1;
		}
		else
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
			SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '1' ", 0, 0, 0);		
			g_Sql_RetStr(szSql, 4, szbuf);
		
			g_lindex = Str_AtoI(szbuf);
			g_nActIndex = g_Get_FsIndex(g_lindex, SREACH_FILE);
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = ((g_nActIndex) % ROW);
		}
	}


//-----------------------------------------------------------------------------------------------
//콤보박스를 이용한 전체,검침,미검침 목록 필터 -> 사용 안함!?
//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[300];

		if( Str_Cmp(m_szCobSel, "검침") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM GUMDATA WHERE SEND_YN = 'Y' or SEND_YN = 'S' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE");

			g_nWorkFlag = 102;
		}
		else if( Str_Cmp(m_szCobSel, "미검침") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM GUMDATA WHERE SEND_YN = 'N' OR SEND_YN IS NULL ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE");
			
			g_nWorkFlag = 103;
		}
		else if( Str_Cmp(m_szCobSel, "부재") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM GUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE");

			g_nWorkFlag = 104;
		}
		else //if( Str_Cmp(m_szCobSel, "전체") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE");

			g_nWorkFlag = 100;
		}

		g_Sql_SaveSeq( szRow, SREACH_FILE);

		if( Str_Cmp(m_szCobSel, "검침") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA WHERE SEND_YN = 'Y' or SEND_YN = 'S' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA WHERE SEND_YN = 'Y' or SEND_YN = 'S' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}
		else if( Str_Cmp(m_szCobSel, "미검침") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA WHERE SEND_YN = 'N' OR SEND_YN IS NULL ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA WHERE SEND_YN = 'N' OR SEND_YN IS NULL ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}
		else if( Str_Cmp(m_szCobSel, "부재") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}
		else
		{
			//Str_Cpy( m_szSql[0], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(DETA_FLOOR,' '), ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
			Str_Cpy( m_szSql[0], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
			Str_Cpy( m_szSql[1], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
			//Str_Cpy( m_szSql[1], "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(DETA_FLOOR,' '), ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}
		return;
	}
	
	
//=======================================================================================
	void Cmb_Result(void)
	{
	char sztmp[20];
	char szSql[300];
		
/*
		if( Str_Cmp(m_szCobSel, "검침") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) from GUMDATA WHERE Length(MTR_WORK_CODE) > 0 AND (SEND_YN = 'S' OR SEND_YN = 'Y') ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp);
		}
		else if( Str_Cmp(m_szCobSel, "미검침") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) from GUMDATA WHERE SEND_YN = 'N' OR SEND_YN = '' ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "0");
		}
		else if( Str_Cmp(m_szCobSel, "부재") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM GUMDATA WHERE MTR_WORK_CODE = '2' AND (SEND_YN = 'S' OR SEND_YN = 'Y') ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
		}
		else
		{	//전체
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) from GUMDATA WHERE (SEND_YN = 'S' OR SEND_YN = 'Y') ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
		}
*/
		//전체
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Sql_RetStr( "SELECT COUNT(*) from GUMDATA WHERE (SEND_YN = 'S' OR SEND_YN = 'Y') ", 4 , sztmp );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 

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
			JSON_SetValue ( js, 'C', "title", "검침 상세리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(CUST_NM, '') ||' / D:'|| ifnull(BASE_YMD, '') ||' / C:'|| ifnull(MTR_WORK_CODE, '') ||' / 지침:'|| ifnull(INDI_SET_VC, '') ||' / 사용량:'|| ifnull(INDI_QTY, '') from gumdata ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "검침 상세리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||'  '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(CUST_NM, '') ||' / D:'|| ifnull(BASE_YMD, '') ||' / C:'|| ifnull(MTR_WORK_CODE, '') ||' / 지침:'|| ifnull(INDI_SET_VC, '') ||' / 사용량:'|| ifnull(INDI_QTY, '') from gumdata ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE");
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
		
		char col_name[5][32] = {"주소", "D", "C", "지침", "사용량"};
		//필드 간격 조정
		char col_weight[5][10] = {"5","2","2","3","3"};
		char col_align[5][10]  = {"left", "center", "center","right", "right"};
	
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
			
			col_count = 5;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			if( nBtnID == BID_QUICK_ADDR )
			{
				JSON_SetValue	(hData	, 'C', "query",
	"select CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN \
	 ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE  \
	 ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END \
	,ifnull(BASE_YMD, ''),ifnull(MTR_WORK_CODE, ''),ifnull(INDI_SET_VC, ''),ifnull(INDI_QTY, '') \
	from gumdata ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
								);
			}
			else
			{
				JSON_SetValue	(hData	, 'C', "query",
	"select CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN \
	 ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE  \
	 ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END \
	,ifnull(BASE_YMD, ''),ifnull(MTR_WORK_CODE, ''),ifnull(INDI_SET_VC, ''),ifnull(INDI_QTY, '') \
	from gumdata ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
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
			
			JSON_SetValue	(h		, 'C', "title"			, "검침 상세리스트");
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
	
	/*=======================================================================================
	함수명 : g_GM_Rcv25012
	기  능 : FR25012
	Param  : 
	Return : 
	========================================================================================*/	
	void Rcv25012(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char* sndbuf;
		char szReqym[20];
		char szDeadlineflag[20];
		char szMtrCnt[2];
		long ret = 0;
		
		Mem_Set( (byte*)szReqym, 0x00, sizeof(szReqym) );
		g_Sql_RetStr( "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1'", 10, szReqym );
		
		Mem_Set( (byte*)szDeadlineflag, 0x00, sizeof(szDeadlineflag) );
		g_Sql_RetStr( "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1'", 5, szDeadlineflag );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25012, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",          szReqym );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",   szDeadlineflag );
		
		Mem_Set( (byte*)szMtrCnt, 0x00, sizeof(szMtrCnt) );
		g_Sql_RetStr( "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1'", 5, szMtrCnt );

		g_GM_Mtr_Add_Item(g_pjcomm);
		g_GM_Use_Cont_Num_Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25012;
		ret = HTTP_DownloadData( szUrl, "FR25012_IN",  "FR25012" , sndbuf, sztmp );
		
		return;		
	}
	
	/*=======================================================================================
	함수명 : g_GM_TR25012
	기  능 : FR25012 CALLBACK
	Param  : 
	Return : 
	========================================================================================*/	
	long TR25012(void)
	{
		long lRet = -1;
		
		g_Sock_Close();
		
		if(g_Chk_Json(25012) >= 0)
		{
			lRet = g_GM_SetFR25012();
			
			MessageBoxEx (CONFIRM_OK, "검침 데이터를 반영 완료했습니다.");
			REDRAW();
			return lRet;
		}
		else
		{
			return lRet;
		}
	}
}



