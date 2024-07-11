/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_USEQTY
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Biglong.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_BACK )
//연간비교
		DEF_BUTTON_ID ( BID_TAB1 )
		DEF_BUTTON_ID ( BID_TAB2 )
		DEF_BUTTON_ID ( BID_YEARPREV )
		DEF_BUTTON_ID ( BID_YEARNEXT )
//추이분석
		DEF_BUTTON_ID ( BID_PRGSPREV )
		DEF_BUTTON_ID ( BID_PRGSNEXT )
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
//연간비교		
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
		DEF_OBJECT_ID ( TXT_DATA32 )
		
//추이분석
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		DEF_OBJECT_ID ( TXT_DATA22 )
		DEF_OBJECT_ID ( TXT_DATA23 )
		DEF_OBJECT_ID ( TXT_DATA24 )
		DEF_OBJECT_ID ( TXT_DATA25 )
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA29 )
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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

//연간비교		
		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
		DEF_OBJECT_ID ( LINE_DATA4 )
		DEF_OBJECT_ID ( LINE_DATA32 )
		DEF_OBJECT_ID ( LINE_DATA33 )
//추이분석
		DEF_OBJECT_ID ( LINE_DATA5 )
		DEF_OBJECT_ID ( LINE_DATA6 )
		DEF_OBJECT_ID ( LINE_DATA7 )
		DEF_OBJECT_ID ( LINE_DATA8 )
		DEF_OBJECT_ID ( LINE_DATA9 )
		DEF_OBJECT_ID ( LINE_DATA10 )
		DEF_OBJECT_ID ( LINE_DATA11 )
		DEF_OBJECT_ID ( LINE_DATA12 )
		DEF_OBJECT_ID ( LINE_DATA13 )
		DEF_OBJECT_ID ( LINE_DATA14 )
		DEF_OBJECT_ID ( LINE_DATA15 )
		DEF_OBJECT_ID ( LINE_DATA16 )
		DEF_OBJECT_ID ( LINE_DATA17 )
		DEF_OBJECT_ID ( LINE_DATA18 )
		DEF_OBJECT_ID ( LINE_DATA19 )
		DEF_OBJECT_ID ( LINE_DATA20 )
		DEF_OBJECT_ID ( LINE_DATA21 )
		DEF_OBJECT_ID ( LINE_DATA22 )
		DEF_OBJECT_ID ( LINE_DATA23 )
		DEF_OBJECT_ID ( LINE_DATA24 )
		DEF_OBJECT_ID ( LINE_DATA25 )
		DEF_OBJECT_ID ( LINE_DATA26 )
		DEF_OBJECT_ID ( LINE_DATA27 )
		DEF_OBJECT_ID ( LINE_DATA28 )
		DEF_OBJECT_ID ( LINE_DATA29 )
		DEF_OBJECT_ID ( LINE_DATA30 )
		DEF_OBJECT_ID ( LINE_DATA31 )

		DEF_OBJECT_ID ( ID_YEARLIST )	// 테이블 리스트
		DEF_OBJECT_ID ( ID_PRGSLIST )	// 테이블 리스트
	END_OBJECT_ID()
	
	#define INIT_MAIN	    1
	#define INIT_PROGRESS	2
		
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

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(연간비교)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_Y	    3					// table의 행개수
	#define		COL_Y	    3					// table의 열개수
	#define		GRID_H_Y	(CHT+14)			// table 행 높이
	#define		GRID_H_Y_P	(CHT+22)			// table 행 높이
	#define		GRID_CLR_Y	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_Y	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_Y	300 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_Y	STARTY+685	 	    // table 시작y좌표
	#define		GRID_Y_Y_P  STARTY+650 		    // table 시작y좌표
	#define		GRID_ENDY_Y	(GRID_Y_Y+(ROW_Y+1)*GRID_H_Y) //table마지막 row의 Y값
	
	char	m_szTableBuf_Y [COL_Y*(ROW_Y+1)*MAXCHAR_Y]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_Y[] = {
		{"청구년월"    , CWD*10    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"사용량"      , CWD*14+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"사용금액"    , CWD*15    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
	};

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(추이분석)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_P	    3					// table의 행개수
	#define		COL_P	    3					// table의 열개수
	#define		GRID_H_P	(CHT+14)			// table 행 높이
	#define		GRID_H_Y_P	(CHT+22)			// table 행 높이
	#define		GRID_CLR_P	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_P	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_P	300 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_P	STARTY+685	 	    // table 시작y좌표
	#define		GRID_Y_P_P  STARTY+650  		    // table 시작y좌표
	#define		GRID_ENDY_P	(GRID_Y_P+(ROW_P+1)*GRID_H_P) //table마지막 row의 Y값
	
	char	m_szTableBuf_P [COL_P*(ROW_P+1)*MAXCHAR_P]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_P[] = {
		{"청구년월"    , CWD*10    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"사용량"      , CWD*14+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"사용금액"    , CWD*15    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};


	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, x1,y1, x2,y2 )
	//연간비교
	#define YEAR_GRAPH_SX 155;
	#define YEAR_GRAPH_EX 185;
	#define YEAR_GRAPH_GAP 335;
	//추이분석
	#define PRGRS_GRAPH_SX 33;
	#define PRGRS_GRAPH_EX 53;
	#define PRGRS_GRAPH_GAP 76;
	
	//라인 그래프 색상
	#define LINE_GRAPH_COL	ORANGERED
	//막대 그래프 색상
	#define REC_GRAPH_COL	DODGERBLUE
	
	long m_bFirst;
	long m_lCount = 0;
	long m_aGraph[13];			//막대 그래프 값 array
	long m_aLine[13];			//라인 그래프 값 array
	long m_lYearRcvFlag = 0;	//m_lYearRcvFlag = 0 연간비교 수신 , =1 연간비교 수신X
	long m_lPrgrsRcvFlag = 0;	//m_lPrgrsRcvFlag = 0 연간비교 수신 , =1 연간비교 수신X

	long m_lpage_Y = 0;			// 현재 페이지
	long m_lTotpage_Y = 0;		// 총 페이지
	long m_nActIndex_Y = -1;	//선택된 row index
	char m_szCnt_page_Y[20];	// 페이지 표시 변수

	long m_lpage_P = 0;			// 현재 페이지
	long m_lTotpage_P = 0;		// 총 페이지
	long m_nActIndex_P = -1;	//선택된 row index
	char m_szCnt_page_P[20];	// 페이지 표시 변수
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	
	long BAR_DMS_X( long x );
	long BAR_DMS_Y( long y );
	void Set_Array(long lCnt);
	long Value_Graph(void);	//막대 그래프 그리는 함수!!!
	long Value_Line(void);	//라인 그리는 함수!!!
	
	long Rcv_Year(void);
	long TR242490(void);
	void Year_Draw(void);
	
	long Rcv_Progress(void);
	long TR242492(void);
	void Progress_Draw(void);

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "사용량 추이"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX,         STARTY-29, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "연간비교"),
		DLG_BUTTON(STARTX+500,     STARTY-29, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "추이분석"),
		DLG_BUTTON(STARTX+500,    STARTY+620, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_YEARPREV, "▲"),
		DLG_BUTTON(STARTX+750,    STARTY+620, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_YEARNEXT, "▼"),

		DLG_TEXT(STARTX,          STARTY+40, 420, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ">3개년 사용추이"),
		DLG_TEXT(STARTX+445,      STARTY+40,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, REC_GRAPH_COL, TXTINCTRLBK, TXT_DATA2, "■"),
		DLG_TEXT(STARTX+495,      STARTY+40, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, "사용량"),
		DLG_TEXT(STARTX+695,      STARTY+40,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, LINE_GRAPH_COL, TXTINCTRLBK, TXT_DATA4, "■"),
		DLG_TEXT(STARTX+745,      STARTY+40, 248, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "사용금액"),
		DLG_TEXT(STARTX,              STARTY+620, 300, 65, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA28, m_szCnt_page_Y),

		DLG_TEXT(STARTX+70,      STARTY+140, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA30, ""),
		DLG_TEXT(STARTX+400,     STARTY+140, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX+730,     STARTY+140, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA32, ""),

		DLG_LINE(STARTX,     STARTY+210,     STARTX, STARTY+620, BLACK, 2, LINE_DATA1),
		DLG_LINE(STARTX,     STARTY+620, STARTX+994, STARTY+620, BLACK, 2, LINE_DATA2),
		DLG_LINE(STARTX+333, STARTY+210, STARTX+333, STARTY+619, BRIGHTGRAY, 2, LINE_DATA3),
		DLG_LINE(STARTX+666, STARTY+210, STARTX+666, STARTY+619, BRIGHTGRAY, 2, LINE_DATA4),
		
		DLG_TEXT(STARTX+150, STARTY+270, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA6, ""),
		DLG_TEXT(STARTX+470, STARTY+270, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA7, ""),
		DLG_TEXT(STARTX+820, STARTY+270, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA8, ""),

		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA32),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA33),

		// 리스트
		DLG_TABLE(GRID_X_Y, GRID_Y_Y, ROW_Y, COL_Y, 0, GRID_H_Y, 1, GRID_H_Y, SEL_ROW, MAXCHAR_Y, m_stGridTitle_Y, ID_YEARLIST, m_szTableBuf_Y),
	};		
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "사용량 추이"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX,         STARTY-40, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "연간비교"),
		DLG_BUTTON(STARTX+500,     STARTY-40, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "추이분석"),

		DLG_TEXT(STARTX,         STARTY+585, 300, 65, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA28, m_szCnt_page_Y),
		DLG_BUTTON(STARTX+500,    STARTY+585, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_YEARPREV, "▲"),
		DLG_BUTTON(STARTX+750,    STARTY+585, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_YEARNEXT, "▼"),

		DLG_TEXT(STARTX,          STARTY+20, 420, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ">3개년 사용추이"),
		DLG_TEXT(STARTX+445,      STARTY+20,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, REC_GRAPH_COL, TXTINCTRLBK, TXT_DATA2, "■"),
		DLG_TEXT(STARTX+495,      STARTY+20, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, "사용량"),
		DLG_TEXT(STARTX+695,      STARTY+20,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, LINE_GRAPH_COL, TXTINCTRLBK, TXT_DATA4, "■"),
		DLG_TEXT(STARTX+745,      STARTY+20, 248, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "사용금액"),

		DLG_TEXT(STARTX+70,      STARTY+80, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA30, ""),
		DLG_TEXT(STARTX+400,     STARTY+80, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX+730,     STARTY+80, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA32, ""),

		DLG_LINE(STARTX,     STARTY+140,     STARTX, STARTY+580, BLACK, 2, LINE_DATA1),
		DLG_LINE(STARTX,     STARTY+580, STARTX+994, STARTY+580, BLACK, 2, LINE_DATA2),
		DLG_LINE(STARTX+333, STARTY+140, STARTX+333, STARTY+573, BRIGHTGRAY, 2, LINE_DATA3),
		DLG_LINE(STARTX+666, STARTY+140, STARTX+666, STARTY+573, BRIGHTGRAY, 2, LINE_DATA4),
		
		DLG_TEXT(STARTX+150, STARTY+270, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA6, ""),
		DLG_TEXT(STARTX+470, STARTY+270, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA7, ""),
		DLG_TEXT(STARTX+820, STARTY+270, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA8, ""),

		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA32),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA33),

		// 리스트
		DLG_TABLE(GRID_X_Y, GRID_Y_Y_P, ROW_Y, COL_Y, 0, GRID_H_Y_P, 1, GRID_H_Y_P, SEL_ROW, MAXCHAR_Y, m_stGridTitle_Y, ID_YEARLIST, m_szTableBuf_Y),
	};		
	

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Progress[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "사용량 추이"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX,         STARTY-29, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "연간비교"),
		DLG_BUTTON(STARTX+500,     STARTY-29, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "추이분석"),
		DLG_BUTTON(STARTX+500,    STARTY+620, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRGSPREV, "▲"),
		DLG_BUTTON(STARTX+750,    STARTY+620, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRGSNEXT, "▼"),

		DLG_TEXT(STARTX,          STARTY+40, 420, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ">최근1년 사용추이"),
		DLG_TEXT(STARTX+445,      STARTY+40,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, REC_GRAPH_COL, TXTINCTRLBK, TXT_DATA11, "■"),
		DLG_TEXT(STARTX+495,      STARTY+40, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, "사용량"),
		DLG_TEXT(STARTX+695,      STARTY+40,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, LINE_GRAPH_COL, TXTINCTRLBK, TXT_DATA13, "■"),
		DLG_TEXT(STARTX+745,      STARTY+40, 248, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, "사용금액"),
		DLG_TEXT(STARTX,         STARTY+620, 300, 65, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, m_szCnt_page_P),

		DLG_TEXT(STARTX+5,       STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(STARTX+81,      STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA34, ""),
		DLG_TEXT(STARTX+157,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX+233,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA36, ""),
		DLG_TEXT(STARTX+309,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX+385,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA38, ""),
		DLG_TEXT(STARTX+461,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX+537,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA40, ""),
		DLG_TEXT(STARTX+613,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX+689,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA42, ""),
		DLG_TEXT(STARTX+765,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		DLG_TEXT(STARTX+841,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA44, ""),
		DLG_TEXT(STARTX+917,     STARTY+140, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),

		DLG_LINE(STARTX,     STARTY+210,     STARTX, STARTY+620, BLACK, 2, LINE_DATA5),
		DLG_LINE(STARTX,     STARTY+620, STARTX+994, STARTY+620, BLACK, 2, LINE_DATA6),
		DLG_LINE(STARTX+76,  STARTY+210, STARTX+76, STARTY+619, BRIGHTGRAY, 2, LINE_DATA7),
		DLG_LINE(STARTX+152, STARTY+210, STARTX+152, STARTY+619, BRIGHTGRAY, 2, LINE_DATA8),
		DLG_LINE(STARTX+228, STARTY+210, STARTX+228, STARTY+619, BRIGHTGRAY, 2, LINE_DATA9),
		DLG_LINE(STARTX+304, STARTY+210, STARTX+304, STARTY+619, BRIGHTGRAY, 2, LINE_DATA10),
		DLG_LINE(STARTX+380, STARTY+210, STARTX+380, STARTY+619, BRIGHTGRAY, 2, LINE_DATA11),
		DLG_LINE(STARTX+456, STARTY+210, STARTX+456, STARTY+619, BRIGHTGRAY, 2, LINE_DATA12),
		DLG_LINE(STARTX+532, STARTY+210, STARTX+532, STARTY+619, BRIGHTGRAY, 2, LINE_DATA13),
		DLG_LINE(STARTX+608, STARTY+210, STARTX+608, STARTY+619, BRIGHTGRAY, 2, LINE_DATA14),
		DLG_LINE(STARTX+684, STARTY+210, STARTX+684, STARTY+619, BRIGHTGRAY, 2, LINE_DATA15),
		DLG_LINE(STARTX+760, STARTY+210, STARTX+760, STARTY+619, BRIGHTGRAY, 2, LINE_DATA16),
		DLG_LINE(STARTX+836, STARTY+210, STARTX+836, STARTY+619, BRIGHTGRAY, 2, LINE_DATA17),
		DLG_LINE(STARTX+912, STARTY+210, STARTX+912, STARTY+619, BRIGHTGRAY, 2, LINE_DATA18),
		
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA15, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA16, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA17, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA18, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA19, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA20, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA21, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA22, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA23, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA24, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA25, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA26, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA27, ""),

		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA19),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA20),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA21),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA22),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA23),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA24),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA25),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA26),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA27),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA28),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA29),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA30),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 7, LINE_DATA31),

		// 리스트
		DLG_TABLE(GRID_X_P, GRID_Y_P, ROW_P, COL_P, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR_P, m_stGridTitle_P, ID_PRGSLIST, m_szTableBuf_P),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Progress_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "사용량 추이"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX,         STARTY-40, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "연간비교"),
		DLG_BUTTON(STARTX+500,     STARTY-40, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "추이분석"),

		DLG_TEXT(STARTX,          STARTY+585, 300, 65, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, m_szCnt_page_P),
		DLG_BUTTON(STARTX+500,    STARTY+585, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRGSPREV, "▲"),
		DLG_BUTTON(STARTX+750,    STARTY+585, 250, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRGSNEXT, "▼"),

		DLG_TEXT(STARTX,          STARTY+20, 420, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ">최근1년 사용추이"),
		DLG_TEXT(STARTX+445,      STARTY+20,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, REC_GRAPH_COL, TXTINCTRLBK, TXT_DATA11, "■"),
		DLG_TEXT(STARTX+495,      STARTY+20, 200, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, "사용량"),
		DLG_TEXT(STARTX+695,      STARTY+20,  50, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, LINE_GRAPH_COL, TXTINCTRLBK, TXT_DATA13, "■"),
		DLG_TEXT(STARTX+745,      STARTY+20, 248, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, "사용금액"),

		DLG_TEXT(STARTX+5,        STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(STARTX+81,       STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA34, ""),
		DLG_TEXT(STARTX+157,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX+233,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA36, ""),
		DLG_TEXT(STARTX+309,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX+385,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA38, ""),
		DLG_TEXT(STARTX+461,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX+537,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA40, ""),
		DLG_TEXT(STARTX+613,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX+689,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA42, ""),
		DLG_TEXT(STARTX+765,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		DLG_TEXT(STARTX+841,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA44, ""),
		DLG_TEXT(STARTX+917,      STARTY+80, 65, 50, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),

		DLG_LINE(STARTX,     STARTY+140,     STARTX, STARTY+580, BLACK, 2, LINE_DATA5),
		DLG_LINE(STARTX,     STARTY+580, STARTX+994, STARTY+580, BLACK, 2, LINE_DATA6),
		DLG_LINE(STARTX+76,  STARTY+140,  STARTX+76, STARTY+573, BRIGHTGRAY, 2, LINE_DATA7),
		DLG_LINE(STARTX+152, STARTY+140, STARTX+152, STARTY+573, BRIGHTGRAY, 2, LINE_DATA8),
		DLG_LINE(STARTX+228, STARTY+140, STARTX+228, STARTY+573, BRIGHTGRAY, 2, LINE_DATA9),
		DLG_LINE(STARTX+304, STARTY+140, STARTX+304, STARTY+573, BRIGHTGRAY, 2, LINE_DATA10),
		DLG_LINE(STARTX+380, STARTY+140, STARTX+380, STARTY+573, BRIGHTGRAY, 2, LINE_DATA11),
		DLG_LINE(STARTX+456, STARTY+140, STARTX+456, STARTY+573, BRIGHTGRAY, 2, LINE_DATA12),
		DLG_LINE(STARTX+532, STARTY+140, STARTX+532, STARTY+573, BRIGHTGRAY, 2, LINE_DATA13),
		DLG_LINE(STARTX+608, STARTY+140, STARTX+608, STARTY+573, BRIGHTGRAY, 2, LINE_DATA14),
		DLG_LINE(STARTX+684, STARTY+140, STARTX+684, STARTY+573, BRIGHTGRAY, 2, LINE_DATA15),
		DLG_LINE(STARTX+760, STARTY+140, STARTX+760, STARTY+573, BRIGHTGRAY, 2, LINE_DATA16),
		DLG_LINE(STARTX+836, STARTY+140, STARTX+836, STARTY+573, BRIGHTGRAY, 2, LINE_DATA17),
		DLG_LINE(STARTX+912, STARTY+140, STARTX+912, STARTY+573, BRIGHTGRAY, 2, LINE_DATA18),
		
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA15, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA16, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA17, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA18, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA19, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA20, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA21, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA22, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA23, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA24, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA25, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA26, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, REC_GRAPH_COL, TXT_DATA27, ""),

		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA19),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA20),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA21),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA22),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA23),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA24),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA25),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA26),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA27),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA28),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA29),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA30),
		DLG_LINE(0, 0, 0, 0, LINE_GRAPH_COL, 2, LINE_DATA31),

		// 리스트
		DLG_TABLE(GRID_X_P, GRID_Y_P_P, ROW_P, COL_P, 0, GRID_H_Y_P, 1, GRID_H_Y_P, SEL_ROW, MAXCHAR_P, m_stGridTitle_P, ID_PRGSLIST, m_szTableBuf_P),
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
		long lCnt;
		
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
						//CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), TRUE );
				
				SetBtnImg();	
				SetStyle();
				Mem_Set((byte*)m_szTableBuf_Y+(COL_Y*MAXCHAR_Y), 0x00, sizeof(m_szTableBuf_Y)-(COL_Y*MAXCHAR_Y));

				if( m_lYearRcvFlag == 0 )
				{
					Rcv_Year();
					m_lYearRcvFlag = 1;
				}
				else
				{
					Year_Draw();
				}
				break;
			case INIT_PROGRESS:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Progress_P, SIZEOF(DlgRes_Progress_P));
						break;
					default:
						//CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_Progress, SIZEOF(DlgRes_Progress));
						break;		
				}

				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), FALSE );
				
				SetBtnImg();	
				SetStyle();
				Mem_Set((byte*)m_szTableBuf_P+(COL_P*MAXCHAR_P), 0x00, sizeof(m_szTableBuf_P)-(COL_P*MAXCHAR_P));

				if( m_lPrgrsRcvFlag == 0 )
				{
					Rcv_Progress();
					m_lPrgrsRcvFlag = 1;
				}
				else
				{
					Progress_Draw();
				}
				break;
		}
	}
	
	
//------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		//GrDev_DrawLineEx(BAR_DMS_X(STARTX+38),  BAR_DMS_Y(100), BAR_DMS_X(STARTX+114),  BAR_DMS_Y(30), BLUE);
		GrDev_Refresh();
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{				
		switch(ID)
		{
			case BID_BACK:
				if( g_nGmType == 1 )
				{
					Card_Move("GM_REENTRY");
				}
				else
				{
					Card_Move("GM_ENTRY");
				}
				break;
			case BID_TAB1:
				if( m_bFirst == INIT_PROGRESS )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_TAB2:
				if( m_bFirst == INIT_MAIN )
				{
					ON_EXIT();
					OnInit(INIT_PROGRESS);
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "체납 메뉴로 나가시겠습니까?")  == MB_OK)
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
				if( g_nGmType == 1 )
				{
					Card_Move("GM_REENTRY");
				}
				else
				{
					Card_Move("GM_ENTRY");
				}
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			case BID_PRGSPREV:
				m_lpage_P--;
				if(m_lpage_P < 0)
				{
					m_lpage_P = 0;
					if(m_lTotpage_P > 0)
					{
						if( m_nActIndex_P < 0)
						{
							m_nActIndex_P = 0;
						}
					
						DlgTbl_SetActive(ID_PRGSLIST , m_nActIndex_P+1 );
						DlgTbl_SetRowColor(ID_PRGSLIST, m_nActIndex_P+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex_P = 0;
				Progress_Draw();
				break;			
			case BID_PRGSNEXT:
				m_lpage_P++ ;
				if( m_lpage_P > m_lTotpage_P-1 )
				{
					m_lpage_P = m_lTotpage_P-1;
					if(m_lpage_P < 0)
					{
						m_lpage_P = 0;
					}
					if(m_lTotpage_P > 0)
					{
						if( m_nActIndex_P < 0 )
						{
							m_nActIndex_P = 0;
						}
					
						DlgTbl_SetActive(ID_PRGSLIST , m_nActIndex_P+1 );
						DlgTbl_SetRowColor(ID_PRGSLIST, m_nActIndex_P+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex_P = 0;
				Progress_Draw();
				break;
		}
	}		
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_PROGRESS )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA33), TRUE, 2, EDITSEP_NONE );
		}
	}
	

//------------------------------------------------------------------
	void ReDraw(void)
	{
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA49),  m_stAucInfo.PROC_CNT );
		
		ON_DRAW();
		return;
	}

//------------------------------------------------------------------
	long BAR_DMS_X( long x )
	{
		long dms_x = 0;

		dms_x = (x*theDevInfo.m_nMx)/1000;
		return dms_x;
	}

//------------------------------------------------------------------
	long BAR_DMS_Y( long y )
	{
		long dms_y = 0;

		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			dms_y = (720*theDevInfo.m_nMy)/1000  - (y * 400*theDevInfo.m_nMy) /1000/100 ;
		}
		else
		{
			dms_y = (680*theDevInfo.m_nMy)/1000  - (y * 400*theDevInfo.m_nMy) /1000/100 ;
		}
		
//PRINT("dms_y : %d, y : %d",dms_y,y,0);
		return dms_y;		
	}
		

//------------------------------------------------------------------
//막대 그래프 그리는 함수.
	long Value_Graph(void)
	{
		long lRet[13];
		long i, j;
		long max = 0;
		long lMaxIndex = 0;
		long lStartX = 0;
		long lEndX = 0;
		long lStartLineX = 0;
		long lEndLineX = 0;
		long lTxtId = 0;
		long lLineId = 0;
		//연간비교
		long Main_TxtCtrl[3] = {TXT_DATA6, TXT_DATA7, TXT_DATA8};
		//추이분석
		long Prgs_TxtCtrl[13] = {TXT_DATA15, TXT_DATA16, TXT_DATA17, TXT_DATA18, TXT_DATA19, TXT_DATA20,
		TXT_DATA21, TXT_DATA22, TXT_DATA23, TXT_DATA24, TXT_DATA25, TXT_DATA26, TXT_DATA27};
		char szValue[30];
		char szBuf[30];
		char szMax[30];
		char szCalcul[30];
		char szRet[30];
		char szTmp[30];

		//Array에서 가장 큰 숫자 찾기
		for(i = 0;i<m_lCount;i++)
		{
		    if(m_aGraph[i] > max ) 
		    {
		        max = m_aGraph[i]; 
		        lMaxIndex = i;
		        Mem_Set((byte*)szMax, 0x00, sizeof(szMax));	
		        Str_ItoA(max, szMax, 10);
		    }
		}

		//가장 큰 수를 100으로 두고, 그 수를 기준으로 나머지의 비율을 구함.
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
		Str_Cpy(szBuf, "100");
		for(i = 0 ; i < m_lCount ; i++)
		{
			if( i == lMaxIndex )
			{
				lRet[lMaxIndex] = 100;
			}
			else
			{
				Mem_Set((byte*)szValue, 0x00, sizeof(szValue));	
				Mem_Set((byte*)szCalcul, 0x00, sizeof(szCalcul));	
				Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
				
				Str_ItoA(m_aGraph[i], szValue, 10);
				Str_Mul(szValue, szBuf, szCalcul);
//PRINT("1111 >>>> szCalcul : %s , szValue : %s",szCalcul,szValue,0);
				Str_Div	(szCalcul, szMax, szRet, szTmp);
//PRINT("2222 >>>> szRet : %s, szCalcul : %s , szMax : %s",szRet,szCalcul,szMax);

				lRet[i] = Str_AtoI(szRet);
//PRINT("3333 >>>> lRet[i] : %d , szRet : %s",lRet[i],szRet,0);

				//lRet[i] = m_aGraph[i] * 100 / max;
			}
		}

		for(i = 0 ; i < m_lCount ; i++)
		{
			if( m_bFirst == INIT_MAIN )
			{
				//연간비교
				if( i == 0 )
				{
					lStartX = YEAR_GRAPH_SX;
					lEndX = YEAR_GRAPH_EX;
				}
				else
				{
					lStartX += YEAR_GRAPH_GAP;
					lEndX += YEAR_GRAPH_GAP;
				}

				//2017-09-06 Sanghyun Lee
				//PDA의 경우!!! 텍스트 컨트롤 길이가 5보다 작으면 화면에 표시가 되지 않음.
				//따라서 크기 계산 후 5보다 작으면 5보다 크게 만들어주는 예외처리 코드 삽입.
				if( theDevInfo.m_nType == FAMILY_PDA && ( BAR_DMS_X(lEndX)-BAR_DMS_X(lStartX) < 5 ) )
				{
					while( 1 )
					{
						if( BAR_DMS_X(lEndX)-BAR_DMS_X(lStartX) < 5 )
						{
							lEndX = lEndX+1;
						}
						else
						{
							break;
						}
					}
				}

//PRINT("Prgs_TxtCtrl[i] : %d",Prgs_TxtCtrl[i],0,0);
//PRINT("BAR_DMS_X(lStartX) : %d .. BAR_DMS_X(lEndX) : %d",BAR_DMS_X(lStartX),BAR_DMS_X(lEndX),0);
//PRINT("BAR_DMS_Y(lRet[i]) : %d , BAR_DMS_Y(0) : %d",BAR_DMS_Y(lRet[i]),BAR_DMS_Y(0),0);

				//막대그래프
				EDITSETRANGE(Get_hDlgCtrlByID(Main_TxtCtrl[i]), BAR_DMS_X(lStartX),  BAR_DMS_Y(lRet[i]), BAR_DMS_X(lEndX),  BAR_DMS_Y(0) ) ;
			}
			else
			{
				//추이분석
				if( i == 0 )
				{
					lStartX = PRGRS_GRAPH_SX;
					lEndX = PRGRS_GRAPH_EX;
				}
				else
				{
					lStartX += PRGRS_GRAPH_GAP;
					lEndX += PRGRS_GRAPH_GAP;
				}
				
				//2017-09-06 Sanghyun Lee
				//PDA의 경우!!! 텍스트 컨트롤 길이가 5보다 작으면 화면에 표시가 되지 않음.
				//따라서 크기 계산 후 5보다 작으면 5보다 크게 만들어주는 예외처리 코드 삽입.
				if( theDevInfo.m_nType == FAMILY_PDA && ( BAR_DMS_X(lEndX)-BAR_DMS_X(lStartX) < 5 ) )
				{
					while( 1 )
					{
						if( BAR_DMS_X(lEndX)-BAR_DMS_X(lStartX) < 5 )
						{
							lEndX = lEndX+1;
						}
						else
						{
							break;
						}
					}
				}

//PRINT("Prgs_TxtCtrl[i] : %d",Prgs_TxtCtrl[i],0,0);
//PRINT("BAR_DMS_X(lStartX) : %d .. BAR_DMS_X(lEndX) : %d",BAR_DMS_X(lStartX),BAR_DMS_X(lEndX),0);
//PRINT("BAR_DMS_Y(lRet[i]) : %d , BAR_DMS_Y(0) : %d",BAR_DMS_Y(lRet[i]),BAR_DMS_Y(0),0);

				//막대그래프
				EDITSETRANGE(Get_hDlgCtrlByID(Prgs_TxtCtrl[i]), BAR_DMS_X(lStartX),  BAR_DMS_Y(lRet[i]), BAR_DMS_X(lEndX),  BAR_DMS_Y(0) ) ;
			}
		}

		return 1;
	}


//------------------------------------------------------------------
//=라인 그래프 그리는 함수.
	long Value_Line(void)
	{
		long lCalcul = 0;
		long lRet[13];
		long i, j;
		long max = 0;
		long lMaxIndex = 0;
		long lStartX = 0;
		long lEndX = 0;
		long lStartLineX = 0;
		long lEndLineX = 0;
		long lTxtId = 0;
		long lLineId = 0;
		//연간비교
		long Main_LineCtrl[2] = {LINE_DATA32, LINE_DATA33};
		//추이분석
		long Prgs_LineCtrl[12] = {LINE_DATA19, LINE_DATA20, LINE_DATA21, LINE_DATA22, LINE_DATA23,
		LINE_DATA24, LINE_DATA25, LINE_DATA26, LINE_DATA27, LINE_DATA28, LINE_DATA29, LINE_DATA30};
		char szValue[30];
		char szMax[30];
		char szCalcul[30];
		char szBuf[30];
		char szRet[30];
		char szTmp[30];

		//Array에서 가장 큰 숫자 찾기
		for(i = 0;i<m_lCount;i++)
		{
		    if(m_aLine[i] > max ) 
		    {
		        max = m_aLine[i]; 
		        lMaxIndex = i;
		        Mem_Set((byte*)szMax, 0x00, sizeof(szMax));	
		        Str_ItoA(max, szMax, 10);
		    }
		}

		//가장 큰 수를 100으로 두고, 그 수를 기준으로 나머지의 비율을 구함.
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
		Str_Cpy(szBuf, "100");
		for(i = 0 ; i < m_lCount ; i++)
		{
			lCalcul = 0;
			if( i == lMaxIndex )
			{
				lRet[i] = 100;
			}
			else
			{
				Mem_Set((byte*)szValue, 0x00, sizeof(szValue));	
				Mem_Set((byte*)szCalcul, 0x00, sizeof(szCalcul));	
				Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
				
				Str_ItoA(m_aLine[i], szValue, 10);
				Str_Mul(szValue, szBuf, szCalcul);
//PRINT("1111 >>>> szCalcul : %s , szValue : %s",szCalcul,szValue,0);
				Str_Div	(szCalcul, szMax, szRet, szTmp);
//PRINT("2222 >>>> szRet : %s, szCalcul : %s , szMax : %s",szRet,szCalcul,szMax);

				lRet[i] = Str_AtoI(szRet);
//PRINT("3333 >>>> lRet[i] : %d , szRet : %s",lRet[i],szRet,0);
			}
		}
		
		for(i = 0 ; i < m_lCount ; i++)
		{
			if( m_bFirst == INIT_MAIN )
			{
				//연간비교
				if( i == 0 )
				{
					lStartX = YEAR_GRAPH_SX;
					//lEndX = YEAR_GRAPH_EX;
					lStartLineX = lStartX+10;
				}
				else
				{
					lStartX += YEAR_GRAPH_GAP;
					//lEndX += YEAR_GRAPH_GAP;
					lStartLineX = lStartX+10;
				}
				
				if( m_lCount == 1 )
				{
					lEndLineX = lStartLineX+9;
				}
				else
				{
					lEndLineX = lStartLineX + YEAR_GRAPH_GAP;
				}

				//라인그래프
				if( i == 0  && m_lCount > 1 )
				{
					LineCtrl_SetStartPos( Get_hDlgCtrlByID(Main_LineCtrl[i]), 0, BAR_DMS_X(lStartLineX),  BAR_DMS_Y(lRet[i]) );
					LineCtrl_SetEndPos( Get_hDlgCtrlByID(Main_LineCtrl[i]), 0, BAR_DMS_X(lEndLineX),  BAR_DMS_Y(lRet[i+1]) );
				}
				else if( i > 0 && i < m_lCount-1)
				{
					LineCtrl_SetStartPos( Get_hDlgCtrlByID(Main_LineCtrl[i]), 0, BAR_DMS_X(lStartLineX),  BAR_DMS_Y(lRet[i]) );
					LineCtrl_SetEndPos( Get_hDlgCtrlByID(Main_LineCtrl[i]), 0, BAR_DMS_X(lEndLineX),  BAR_DMS_Y(lRet[i+1]) );
				}
				else if( i == 0 && m_lCount == 1 )
				{
					LineCtrl_SetThickness( Get_hDlgCtrlByID(Main_LineCtrl[i]), 15);

					LineCtrl_SetStartPos( Get_hDlgCtrlByID(Main_LineCtrl[i]), 0, BAR_DMS_X(lStartLineX),  BAR_DMS_Y(lRet[i]) );
					LineCtrl_SetEndPos( Get_hDlgCtrlByID(Main_LineCtrl[i]), 0, BAR_DMS_X(lEndLineX),  BAR_DMS_Y(lRet[i]) );
				}
				//PRINT(">>>>>>>>>>>>>>>>>> i : %d , StartY : %d , EndY : %d",i,BAR_DMS_Y(lRet[i]),BAR_DMS_Y(lRet[i+1]));				
			}
			else
			{
				//추이분석
				if( i == 0 )
				{
					lStartX = PRGRS_GRAPH_SX;
					//lEndX = PRGRS_GRAPH_EX;
					lStartLineX = lStartX+10;
				}
				else
				{
					lStartX += PRGRS_GRAPH_GAP;
					//lEndX += PRGRS_GRAPH_GAP;
					lStartLineX = lStartX+10;
				}
				
				if( m_lCount == 1 )
				{
					lEndLineX = lStartLineX+9;
				}
				else
				{
					lEndLineX = lStartLineX + PRGRS_GRAPH_GAP;
				}

				//라인그래프
				if( i == 0 && m_lCount > 1 )
				{
					LineCtrl_SetStartPos( Get_hDlgCtrlByID(Prgs_LineCtrl[i]), 0, BAR_DMS_X(lStartLineX),  BAR_DMS_Y(lRet[i]) );
					LineCtrl_SetEndPos( Get_hDlgCtrlByID(Prgs_LineCtrl[i]), 0, BAR_DMS_X(lEndLineX),  BAR_DMS_Y(lRet[i+1]) );
				}
				else if( i > 0 && i < m_lCount-1)
				{
					LineCtrl_SetStartPos( Get_hDlgCtrlByID(Prgs_LineCtrl[i]), 0, BAR_DMS_X(lStartLineX),  BAR_DMS_Y(lRet[i]) );
					LineCtrl_SetEndPos( Get_hDlgCtrlByID(Prgs_LineCtrl[i]), 0, BAR_DMS_X(lEndLineX),  BAR_DMS_Y(lRet[i+1]) );
				}
				else if( i == 0 && m_lCount == 1 )
				{
					LineCtrl_SetThickness( Get_hDlgCtrlByID(Prgs_LineCtrl[i]), 15);

					LineCtrl_SetStartPos( Get_hDlgCtrlByID(Prgs_LineCtrl[i]), 0, BAR_DMS_X(lStartLineX),  BAR_DMS_Y(lRet[i]) );
					LineCtrl_SetEndPos( Get_hDlgCtrlByID(Prgs_LineCtrl[i]), 0, BAR_DMS_X(lEndLineX),  BAR_DMS_Y(lRet[i]) );
				}
			}
		}

		return 1;
	}

	
	
//------------------------------------------------------------------
	long Rcv_Year(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute( "DELETE FROM RCV_TMP" );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 242490, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stGm.USE_CONT_NUM );

		sndbuf = JSON_toString(g_pjcomm);

		//전송데이터 확인
		//g_Save_JsonFile(sndbuf);
				
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR242490; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR242490_IN",  "FR242490" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR242490(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(242490) >= 0)
		{
			Year_Draw();
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	

//------------------------------------------------------------------
	void Year_Draw(void)
	{
		long Main_Reqym[3] = {TXT_DATA32, TXT_DATA31, TXT_DATA30};
		long i, idx;
		long lValue, lAmt;
		long k = ROW_Y + 1;
		char sztmp[201];
		char szDate[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lTotpage_Y );
		m_lCount = m_lTotpage_Y;
		
		if( m_lTotpage_Y % ROW_Y > 0 )
		{
			m_lTotpage_Y = (m_lTotpage_Y / ROW_Y) + 1;
		}
		else
		{
			m_lTotpage_Y = m_lTotpage_Y / ROW_Y;
		}
		//페이지
		SPRINT(m_szCnt_page_Y, "%d/%d", m_lpage_Y+1, m_lTotpage_Y, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3 FROM RCV_TMP ORDER BY PARAM1 DESC LIMIT ?, ?" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage_Y*ROW_Y;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage_Y*ROW_Y+ROW_Y;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_Y ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				k++;
				DlgTbl_SetStr ( ID_YEARLIST, i, 0, sztmp );
				DlgTbl_SetStr ( ID_YEARLIST, i, 1, sztmp );
				DlgTbl_SetStr ( ID_YEARLIST, i, 2, sztmp );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					k = i + 1;
					DlgTbl_SetStr ( ID_YEARLIST, i, 0, sztmp );
					DlgTbl_SetStr ( ID_YEARLIST, i, 1, sztmp );
					DlgTbl_SetStr ( ID_YEARLIST, i, 2, sztmp );
					continue;
				}

				idx = 0;
				//청구년월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_YEARLIST, i, 0, sztmp );
				if( m_lCount > i )
				{
					if( m_lCount == 3 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(Main_Reqym[i]), sztmp );
					}
					else if( m_lCount == 2 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(Main_Reqym[i+1]), sztmp );
					}
					else if( m_lCount == 1 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(Main_Reqym[i+2]), sztmp );
					}
				}
				//사용량
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_YEARLIST, i, 1, sztmp );
				//사용금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_YEARLIST, i, 2, sztmp );
			}
		}		

Finally:

		if(m_lTotpage_Y > 0)
		{
			if( m_nActIndex_Y == -1 )
			{
				m_nActIndex_Y = 0;
			}

			DlgTbl_SetActive(ID_YEARLIST , m_nActIndex_Y+1 );
			DlgTbl_SetRowColor(ID_YEARLIST, m_nActIndex_Y+1, TABLEACTIVE_COLOR);
			
			//데이터가 3개년이 넘어가면, 최신 청구년월부터 3개년 데이터만을 셋팅해서 보여준다.
			if( m_lCount > 3 )
			{
				m_lCount = 3;
			}
			else if( m_lCount <= 0 )
			{
				return;
			}
			
			//array에 값 셋팅
			for(i = 0 ; i < m_lCount ; i++)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(sztmp, "SELECT PARAM2 FROM RCV_TMP ORDER BY PARAM1 LIMIT %d, 1", i,0,0);
				g_Sql_RetInt( sztmp, &lValue );
				
				m_aGraph[i] = lValue;
			}

			//array에 값 셋팅
			for(i = 0 ; i < m_lCount ; i++)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(sztmp, "SELECT PARAM3 FROM RCV_TMP ORDER BY PARAM1 LIMIT %d, 1", i,0,0);
				g_Sql_RetInt( sztmp, &lAmt );
				
				m_aLine[i] = lAmt;
//PRINT(">>>>>> lAmt : %d , m_aGraph[i] : %d , i : %d",lAmt,m_aGraph[i],i);
			}

			Value_Graph();
			Value_Line();
		}

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return;
	}
	
//------------------------------------------------------------------
	long Rcv_Progress(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute( "DELETE FROM RCV_RELEASE" );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 242492, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stGm.USE_CONT_NUM );

		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR242492; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR242492_IN",  "FR242492" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR242492(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(242492) >= 0)
		{
			Progress_Draw();
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	
//------------------------------------------------------------------
	void Progress_Draw(void)
	{
		long Prgs_Reqym[13] = {TXT_DATA33, TXT_DATA34, TXT_DATA35, TXT_DATA36, TXT_DATA37, TXT_DATA38, TXT_DATA39, TXT_DATA40, TXT_DATA41, TXT_DATA42, TXT_DATA43, TXT_DATA44, TXT_DATA45};
		long i, idx;
		long k = ROW_P + 1;
		long lTotCnt = 0;
		long lValue, lAmt;
		long ret = -1;	
		long lstartidx;
		char sztmp[256];
		char szDate[30];
		char szRet[30];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_RELEASE", &m_lTotpage_P );
		m_lCount = m_lTotpage_P;

		if( m_lTotpage_P % ROW_P > 0 )
		{
			m_lTotpage_P = (m_lTotpage_P / ROW_P) + 1;
		}
		else
		{
			m_lTotpage_P = m_lTotpage_P / ROW_P;
		}
		
		//페이지
		SPRINT(m_szCnt_page_P, "%d/%d", m_lpage_P+1, m_lTotpage_P, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3 FROM RCV_RELEASE ORDER BY PARAM1 DESC LIMIT ?, ?" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage_P*ROW_P;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage_P*ROW_P+ROW_P;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_P ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				DlgTbl_SetStr ( ID_PRGSLIST, i, 0, sztmp );
				DlgTbl_SetStr ( ID_PRGSLIST, i, 1, sztmp );
				DlgTbl_SetStr ( ID_PRGSLIST, i, 2, sztmp );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					DlgTbl_SetStr ( ID_PRGSLIST, i, 0, sztmp );
					DlgTbl_SetStr ( ID_PRGSLIST, i, 1, sztmp );
					DlgTbl_SetStr ( ID_PRGSLIST, i, 2, sztmp );
					continue;
				}

				idx = 0;
				//청구년월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_PRGSLIST, i, 0, sztmp );
				//사용량
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_PRGSLIST, i, 1, sztmp );
				//사용금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_PRGSLIST, i, 2, sztmp );
			}
		}		

Finally:

		if(m_lTotpage_P > 0)
		{
			if( m_nActIndex_P == -1 )
			{
				m_nActIndex_P = 0;
			}

			DlgTbl_SetActive(ID_PRGSLIST , m_nActIndex_P+1 );
			DlgTbl_SetRowColor(ID_PRGSLIST, m_nActIndex_P+1, TABLEACTIVE_COLOR);
			
			//데이터가 13개월이 넘어가면, 최신 청구년월부터 13개월 데이터만을 셋팅해서 보여준다.
			if( m_lCount > 13 )
			{
				m_lCount = 13;
			}
			else if( m_lCount <= 0 )
			{
				return;
			}
			
			//array에 값 셋팅
			for(i = 0 ; i < m_lCount ; i++)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(sztmp, "SELECT PARAM2 FROM RCV_RELEASE ORDER BY PARAM1 LIMIT %d, 1", i,0,0);
				g_Sql_RetInt( sztmp, &lValue );
				
				m_aGraph[i] = lValue;
//PRINT(">>>>>> lAmt : %d , m_aGraph[i] : %d , i : %d",lAmt,m_aGraph[i],i);
			}
			
			
			//array에 값 셋팅
			for(i = 0 ; i < m_lCount ; i++)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(sztmp, "SELECT PARAM3 FROM RCV_RELEASE ORDER BY PARAM1 LIMIT %d, 1", i,0,0);
				g_Sql_RetInt( sztmp, &lAmt );
				
				m_aLine[i] = lAmt;
//PRINT(">>>>>> lAmt : %d , m_aGraph[i] : %d , i : %d",lAmt,m_aGraph[i],i);
			}

			for(i=0 ; i<m_lCount ; i++)
			{
				//청구년월 표시
				Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(sztmp,"SELECT PARAM1 FROM RCV_RELEASE ORDER BY PARAM1 LIMIT %d, 1",i,0,0);
				g_Sql_RetStr(sztmp, 10, szDate);
				Mem_Cpy( (byte*)szRet, (byte*)szDate+4,  2);
				EditCtrl_SetStr( Get_hDlgCtrlByID(Prgs_Reqym[i]), szRet );
			}

			Value_Graph();
			Value_Line();
		}

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return;
	}
	
	
//------------------------------------------------------------------
	void Set_Array(long lCnt)
	{
		long Prgs_Reqym[13] = {TXT_DATA33, TXT_DATA34, TXT_DATA35, TXT_DATA36, TXT_DATA37, TXT_DATA38, TXT_DATA39, TXT_DATA40, TXT_DATA41, TXT_DATA42, TXT_DATA43, TXT_DATA44, TXT_DATA45};
		long i, idx;
		long k = ROW_P + 1;
		long lTotCnt = 0;
		long lValue, lAmt;
		long ret = -1;	
		long lstartidx;
		char sztmp[256];
		char szDate[30];
		handle hdb = NULL;
		handle hstmt = NULL;
/*
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3 FROM RCV_RELEASE ORDER BY PARAM1 DESC LIMIT 0, 13" );

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

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_P ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					continue;
				}

				idx = 0;
				//청구년월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				//사용량
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				//사용금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
			}
		}		

Finally:

		if(lCnt > 0)
		{
			//array에 값 셋팅
			for(i = 0 ; i < m_lCount ; i++)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(sztmp, "SELECT PARAM2 FROM RCV_RELEASE ORDER BY PARAM1 LIMIT %d, 1", i,0,0);
				g_Sql_RetInt( sztmp, &lValue );
				
				m_aGraph[i] = lValue;
//PRINT(">>>>>> lAmt : %d , m_aGraph[i] : %d , i : %d",lAmt,m_aGraph[i],i);
			}
			
			//array에 값 셋팅
			for(i = 0 ; i < m_lCount ; i++)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(sztmp, "SELECT PARAM3 FROM RCV_RELEASE ORDER BY PARAM1 LIMIT %d, 1", i,0,0);
				g_Sql_RetInt( sztmp, &lAmt );
				
				m_aLine[i] = lAmt;
//PRINT(">>>>>> lAmt : %d , m_aGraph[i] : %d , i : %d",lAmt,m_aGraph[i],i);
			}

//			for(i=0 ; i<m_lCount ; i++)
//			{
//				Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
//				SPRINT(szTmp,"SELECT PARAM1 FROM RCV_RELEASE ORDER BY PARAM1 LIMIT %d, 1",i,0,0);
//				g_Sql_RetStr(szTmp, 10, szBuf);
//				//청구년월 표시
//				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
//				Mem_Cpy( (byte*)szDate, (byte*)sztmp+4,  2);
//				EditCtrl_SetStr( Get_hDlgCtrlByID(Prgs_Reqym[i]), szDate );
//			}
		}

		//sql->Commit(sql);
		DelSqLite(sql);
*/
		ON_DRAW();
		return;
	}
}



