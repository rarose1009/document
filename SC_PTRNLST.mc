/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_PTRNLST
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		//지번
		DEF_BUTTON_ID ( BID_ADDR2 )		//도로명
		DEF_BUTTON_ID ( BID_SMS )
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
		DEF_BUTTON_ID ( BID_FIND )
		DEF_BUTTON_ID ( BID_CLEAR )
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//도로명주소 스크롤 호출
//sms
		DEF_BUTTON_ID ( BID_SCHDL )
		DEF_BUTTON_ID ( BID_CANCEL )
		DEF_BUTTON_ID ( BID_SEND )
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
		DEF_OBJECT_ID ( TXT_ADDR )
		DEF_OBJECT_ID ( TXT_ADDR2 )
		DEF_OBJECT_ID ( TXT_PAGE )		//페이지
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		
		DEF_OBJECT_ID ( TXT_DATA3 )		//SMS 송신
		DEF_OBJECT_ID ( TXT_DATA4 )		//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA5 )		//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA6 )		//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA7 )		//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA8 )		//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA9 )		//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA10 )	//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA11 )	//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA12)		//SMS 송신		
		DEF_OBJECT_ID ( TXT_DATA13)		//SMS 송신	
		DEF_OBJECT_ID ( TXT_DATA14)
		DEF_OBJECT_ID ( TXT_DATA15)
		DEF_OBJECT_ID ( TXT_DATA16)
		DEF_OBJECT_ID ( TXT_DATA17)
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )

		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		DEF_OBJECT_ID ( ID_TBLLIST_N )	// 테이블 리스트, 새주소
		
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 	
//SMS 송신
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 )
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5					// table의 행개수
	#define		COL 	    9					// table의 열개수
	#define		GRID_H		(CHT+40)			// table 행 높이
	#define		GRID_H_P	(CHT+70)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+415  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+250  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"주소",	     CWD*24+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"요일",         CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"시간",         CWD*8,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"기본주소",     CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소",     CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"점검시행번호", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"SMS발송",      CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소확인",     CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CONT_STS_CD",  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	#define INIT_MAIN	1
	#define INIT_SMS    2
	
	long m_lSearchFlag = 0;		//조회관련 flag , m_lSearchFlag = 0 default / m_lSearchFlag = 1 조회
	long m_bFirst;
	long m_lstartidx = 0;
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lSelIndex = -1;
	long m_lActiveIndex = -1;
	
	char m_szSql[2000];
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szAdrss[120];		// 상단 주소 표시
	char m_szTime[10];
	char m_szDay[10];
	char m_szChk_Exec_num[13];

	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void SMSSEND_DRAW(void);
	bool Save_SmsSend(void);
	long FS_GetSrchTotCnt(void);
	long SearchCD(char *CD, CodeTable *CT);		//코드 값을 찾는다.
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	void Set_Index(void);
	void OnList(quad lParam);
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "선택점검 리스트"),
		
		DLG_BUTTON(STARTX+710,  STARTY+65, 170, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FIND, "조회"),
		DLG_BUTTON(STARTX+880,  STARTY+65, 120, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLEAR, "초"),
		
		DLG_TEXT(STARTX,        STARTY+135, 1000, 140, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),		//주소2
		//DLG_TEXT(STARTX,      STARTY+200, 985, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		//주소3

		DLG_TEXT(STARTX,        STARTY+275, 500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), //현재페이지/총페이지
    	DLG_BUTTON(STARTX+500,  STARTY+275, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
    	DLG_BUTTON(STARTX+750,  STARTY+275, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS\n발송"),
		DLG_BUTTON(STARTX,      STARTY+345, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+250,  STARTY+345, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),		
		DLG_BUTTON(STARTX+500,  STARTY+345, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		DLG_BUTTON(STARTX+750,  STARTY+345, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		
		DLG_TEXT(STARTX,        STARTY+65, 120, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "요일"),
		DLG_TEXT(STARTX+340,    STARTY+65, 120, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "시간"),
		DLG_COMBO (STARTX+120,  STARTY+65, 220, 250, 90, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+460,  STARTY+65, 250, 250, 90, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "선택점검 리스트"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+710,  STARTY-40, 170, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FIND, "조회"),
		DLG_BUTTON(STARTX+880,  STARTY-40, 120, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLEAR, "초"),
		
		DLG_TEXT(STARTX,		 STARTY+40, 1000, 140, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),		//주소2
//		DLG_TEXT(STARTX,		STARTY+100, 1000, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		//주소3
    	DLG_TEXT(STARTX,        STARTY+180, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), //현재페이지/총페이지
    	DLG_BUTTON(STARTX+225,  STARTY+180, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
    	DLG_BUTTON(STARTX+450,  STARTY+180, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS발송"),
		DLG_BUTTON(STARTX+700,  STARTY+180, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+850,  STARTY+180, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-30, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
		
		DLG_TEXT(STARTX,       STARTY-40, 120, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "요일"),
		DLG_TEXT(STARTX+340,   STARTY-40, 120, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "시간"),
		DLG_COMBO (STARTX+120, STARTY-40, 220, 250, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+460, STARTY-40, 250, 250, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};		
		
	//  SMS발송
	//---------------------------------------------------------------
	DlgObject	DlgRes_SMSSEND[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SMS 문자발송"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),

		DLG_BUTTON(STARTX,		 STARTY+390, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "닫기"),
		DLG_BUTTON(STARTX+600,   STARTY+390, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "전송"),
		
		DLG_TEXT ( STARTX,	   STARTY-29, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "방문일자"),
		DLG_EDIT( STARTX+250,  STARTY-29, 200, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+450,   STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+450,   STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, "."),
		DLG_EDIT( STARTX+470,  STARTY-29, 170, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+640,   STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+640,   STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, "."),
		DLG_EDIT( STARTX+660,  STARTY-29, 165, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY-29, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "▼"),
		//DLG_TEXT ( STARTX+250,	    STARTY, 575, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		//DLG_BUTTON(STARTX+825,      STARTY, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),

		DLG_TEXT ( STARTX,	     STARTY+41, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "방문시간"),
		DLG_COMBO (STARTX+250,   STARTY+41, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_TEXT ( STARTX+500,	 STARTY+41, 125, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "시 ~"),
		DLG_COMBO (STARTX+625,   STARTY+41, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),
		DLG_TEXT ( STARTX+875,	 STARTY+41, 125, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "시"),
			
		DLG_TEXT ( STARTX,	    STARTY+111, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "소속"),
		DLG_TEXT ( STARTX+250,	STARTY+111, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	    STARTY+181, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "점검원"),
		DLG_TEXT ( STARTX+250,	STARTY+181, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT ( STARTX,	    STARTY+251, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "고객H.P"),
		DLG_TEXT ( STARTX+250,	STARTY+251, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
	};
	
	//  SMS발송
	//---------------------------------------------------------------
	DlgObject	DlgRes_SMSSEND_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SMS 문자발송"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),

		DLG_BUTTON(STARTX,		STARTY+400, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "닫기"),
		DLG_BUTTON(STARTX+600,	STARTY+400, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "전송"),
		
		DLG_TEXT ( STARTX,		STARTY-40, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "방문일자"),
		DLG_EDIT( STARTX+250,   STARTY-40, 200, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+450,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+450,	   STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, "."),
		DLG_EDIT( STARTX+470,   STARTY-40, 170, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+640,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+640,	   STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, "."),
		DLG_EDIT( STARTX+660,   STARTY-40, 165, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825,  STARTY-40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "▼"),
		//DLG_TEXT ( STARTX+250,	    STARTY, 575, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		//DLG_BUTTON(STARTX+825,      STARTY, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),

		DLG_TEXT ( STARTX,	     STARTY+40, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "방문시간"),
		DLG_COMBO (STARTX+250,   STARTY+40, 250, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_TEXT ( STARTX+500,	 STARTY+40, 125, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "시 ~"),
		DLG_COMBO (STARTX+625,   STARTY+40, 250, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),
		DLG_TEXT ( STARTX+875,	 STARTY+40, 125, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "시"),
			
		DLG_TEXT ( STARTX,	    STARTY+120, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "소속"),
		DLG_TEXT ( STARTX+250,	STARTY+120, 750, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	    STARTY+200, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "점검원"),
		DLG_TEXT ( STARTX+250,	STARTY+200, 750, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT ( STARTX,	    STARTY+280, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "고객H.P"),
		DLG_TEXT ( STARTX+250,	STARTY+280, 750, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
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
			g_Sql_SaveSeq( "SELECT A.ROWID FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			g_lMoveFlag = 1;
			Set_Index();			
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "SELECT (SELECT B.SEND_YN FROM NORMAL_ADDR B WHERE B.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A WHERE ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 5, stScAddr.SEND_YN);
			
			Card_Move("SC_CONFIRM");
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
				
				SetBtnImg();
				SetStyle();
				
				if( Str_Len(g_szPtrn_Week) > 0 || Str_Len(g_szPtrn_Time) > 0 )
				{
					m_lSearchFlag = 1;
				}
				
				REDRAW();
				break;
			case INIT_SMS:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_SMSSEND_P, SIZEOF(DlgRes_SMSSEND_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_SMSSEND, SIZEOF(DlgRes_SMSSEND));
						break;
				}
				
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				SMSSEND_DRAW();
				break;

		}
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		long i;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR), TRUE, 2, EDITSEP_NONE );
		
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_DATA1+2));
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_DATA2+2));
		
		//요일
		for ( i = 0 ;  PTRN_DAY[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), PTRN_DAY[i].Str, 0, ICON_NONE);
		}
		//시간
		for ( i = 0 ;  PTRN_TIME[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), PTRN_TIME[i].Str, 0, ICON_NONE);
		}
	}	

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
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
		}
	}

	//-------------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		char szDate[10];

		if( m_bFirst == INIT_SMS )
		{
			//숫자만 입력 가능
			if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex 
			|| Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex
			|| Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
	
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
			
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				else
				{
					Mem_Set((byte *)szDate, 0x00, sizeof(szDate));
					Str_ItoA(Time_GetDate(), szDate, 10);
					if( Str_AtoI(szDate) > Str_AtoI(szTmp) )
					{
						MessageBoxEx (CONFIRM_OK, "날짜를 확인하세요..");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
						
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
						m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
				}
			}
			
			ON_DRAW();
			return;
		}
	}


	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		
		//EDITCTRL에 ACTIVE시에 CTRLINDEX를 저장
		//키보드 BUTTONCTRL이 ACTIVE시에도 EDITCTRL에 커서를 두기위해서 INDEX를 저장
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		m_lActiveIndex = lActiveIndex;
		
		if( m_bFirst == INIT_SMS )
		{
			if( POINTING_UP == nAction )
			{
				m_lActiveIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+450) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+470) && X < DMS_X(STARTX+640) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+660) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
	
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
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
		char szTmp[30];
		char szAddr[200];
	
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			if ( index-1 == m_lSelIndex )
			{
				//선택된 파일의 위치 INDEX를 글로벌변수에 저장
				g_nActIndex = m_lpage*ROW + index - 1;
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				Str_Cpy( g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));

				g_lMoveFlag = 1;
				g_nWorkFlag = 209;

				Set_Index();
				Card_Move("SC_CONFIRM");
				return;
			}
			else
			{
				if( m_bFirst == INIT_MAIN )
				{
					m_lSelIndex = index - 1;
				
					Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
					Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
					Str_Cat(szAddr, "  ");
					Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), szAddr);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
					
					Mem_Set((byte*)m_szChk_Exec_num, 0x00, sizeof(m_szChk_Exec_num));
					Str_Cpy( m_szChk_Exec_num, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
					Str_Cpy( stScAddr.SEND_YN, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 7));
					
					if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 6), "Y") == 0 )
					{
						if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 8), "30") == 0 )
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), RED);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
						}
						else
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						}
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
					}
				}
			}
		}
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k, n;
		char szToday[11];
		char szDate[11];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char sztmp[20];	

	
		switch(ID)
		{
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				Grid_QuickList(ID);
				break;
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
				}
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
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
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
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//REDRAW();
					break;
				}
				m_lSelIndex = 0;
				REDRAW();
				break;
				
			case BID_CLEAR:
				Mem_Set( (byte*)g_szPtrn_Week, 0x00, sizeof(g_szPtrn_Week) );
				Mem_Set( (byte*)g_szPtrn_Time, 0x00, sizeof(g_szPtrn_Time) );
				m_lSearchFlag = 0;
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_FIND:
				Mem_Set( (byte*)g_szPtrn_Week, 0x00, sizeof(g_szPtrn_Week) );
				n = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), PTRN_DAY );
				if (n == -1)
				{
					Str_Cpy(g_szPtrn_Week, "");
				}
				else
				{
					Str_Cpy(g_szPtrn_Week, PTRN_DAY[n].Code);
				}

				Mem_Set( (byte*)g_szPtrn_Time, 0x00, sizeof(g_szPtrn_Time) );
				n = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), PTRN_TIME );
				if (n == -1)
				{
					Str_Cpy(g_szPtrn_Time, "");
				}
				else
				{
					Str_Cpy(g_szPtrn_Time, PTRN_TIME[n].Code);
				}	
			
			
/*
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), m_szDay);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), m_szTime);

				Mem_Set( (byte*)m_szDay, 0x00, sizeof(m_szDay) );
				Mem_Set( (byte*)m_szTime, 0x00, sizeof(m_szTime) );
				Str_Cpy(m_szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
				Str_Cpy(m_szTime, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)));
*/
				if( Str_Len(g_szPtrn_Week) == 0 && Str_Len(g_szPtrn_Time) == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "조회 내용을 입력해주세요.");
					break;
				}

				m_lSearchFlag = 1;	
				m_lpage = 0;			
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_SMS:
				ON_EXIT();
				OnInit(INIT_SMS);
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "안전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
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
//SMS
			case BID_SCHDL:
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));		
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>sztmp : %s",sztmp,0,0);
				k = Str_AtoI(sztmp);

				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Str_ItoA ( d, szDate, 10);
					Str_ItoA ( Time_GetDate(), szToday, 10);
					if( Str_AtoI(szToday) <= Str_AtoI(szDate) )
					{
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
						Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
						Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

						//g_Str_DateType(szToday, szDate);
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), szToday );
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "날짜를 확인하세요..");
					}
					
				}
				break;
			case BID_SEND:
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));

				if( Str_Len(sztmp) < 8 )
				{
					MessageBoxEx (CONFIRM_OK, "방문일자를 선택해주세요.");
				}
				else
				{
					if( Save_SmsSend() )
					{
						ON_EXIT();
						OnInit(INIT_MAIN);
					}
					//Snd_Sms();
				}
				break;
				
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;	
		}
	}		
	
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, n, idx;
		long k = ROW+1;	//i랑 겹치지 않는 숫자로 초기화
		long lTotPage = 0;
		char sztmp[201];
		char szSingFlag[10];
		char szRow[300];
		char szPreuse[15];
		char szChkNum[15];
		char szCnt[15];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
	
		//if( m_bFirst == INIT_MAIN )
		{
			
			if( m_lSearchFlag == 0 )
			{
				Str_Cpy(szRow, "SELECT A.ROWID FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		
				g_Sql_SaveSeq( szRow, SREACH_FILE);
				
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
		
				if( g_lMoveFlag == 1 )
				{
					m_lpage = g_nActIndex / ROW;
					m_lSelIndex = (g_nActIndex % ROW);
					
					g_lMoveFlag = 0;
				}
		
				SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

				hstmt = sql->CreateStatement(sql, "SELECT Trim(A.SINGLE_COLIVE_FLAG), ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, '') ||' '|| ifnull(A.HOUSE_CNT, '') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,''), Trim(B.CHK_WISH_WEEK), Trim(B.CHK_WISH_TIME), ifnull(A.COUNTY, '') ||' '|| ifnull(A.TOWN, '') ||' '|| ifnull(A.VILLAGE, '') ||' '|| ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, ''), ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(Trim(A.CO_LIVE_NM), '') ||' '|| ifnull(A.BLD_NM, '') ||'-'|| ifnull(A.HOUSE_CNT, ''), Trim(A.CHK_EXEC_NUM), Trim(A.SMS_SEND_AGREE_YN), (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM), ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ?, ? ");
			}
			else
			{
				//m_lSearchFlag = 0;
				i = SearchCD( g_szPtrn_Week, PTRN_DAY );
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), PTRN_DAY[i].Str);
				}
				
				i = SearchCD( g_szPtrn_Time, PTRN_TIME );
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), PTRN_TIME[i].Str);
				}
				
				Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
				if( Str_Len(g_szPtrn_Week) > 0 && Str_Len(g_szPtrn_Time) > 0 )
				{
					SPRINT(m_szSql, "SELECT A.ROWID FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM AND Trim(B.CHK_WISH_TIME) = '%s' AND Trim(B.CHK_WISH_WEEK) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD ", g_szPtrn_Time, g_szPtrn_Week, 0);
				}
				else if( Str_Len(g_szPtrn_Week) > 0 )
				{
					SPRINT(m_szSql, "SELECT A.ROWID FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM AND Trim(B.CHK_WISH_WEEK) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD ", g_szPtrn_Week, 0, 0);
				}
				else if( Str_Len(g_szPtrn_Time) > 0 )
				{
					SPRINT(m_szSql, "SELECT A.ROWID FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM AND Trim(B.CHK_WISH_TIME) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD ", g_szPtrn_Time, 0, 0);
				}

				g_Sql_SaveSeq( m_szSql, SREACH_FILE);

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
		
				if( g_lMoveFlag == 1 )
				{
					m_lpage = g_nActIndex / ROW;
					m_lSelIndex = (g_nActIndex % ROW);
					
					g_lMoveFlag = 0;
				}

				SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

				Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );

				if( Str_Len(g_szPtrn_Week) > 0 && Str_Len(g_szPtrn_Time) > 0 )
				{
					SPRINT(m_szSql, "SELECT Trim(A.SINGLE_COLIVE_FLAG), ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, '') ||' '|| ifnull(A.HOUSE_CNT, '') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,''), Trim(B.CHK_WISH_WEEK), Trim(B.CHK_WISH_TIME), ifnull(A.COUNTY, '') ||' '|| ifnull(A.TOWN, '') ||' '|| ifnull(A.VILLAGE, '') ||' '|| ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, ''), ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(Trim(A.CO_LIVE_NM), '') ||' '|| ifnull(A.BLD_NM, '') ||'-'|| ifnull(A.HOUSE_CNT, ''), Trim(A.CHK_EXEC_NUM), Trim(A.SMS_SEND_AGREE_YN), (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM), ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,''), A.CONT_STS_CD FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM AND Trim(B.CHK_WISH_TIME) = '%s' AND Trim(B.CHK_WISH_WEEK) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ?, ? ", g_szPtrn_Time, g_szPtrn_Week, 0);
				}
				else if( Str_Len(g_szPtrn_Week) > 0 )
				{
					SPRINT(m_szSql, "SELECT Trim(A.SINGLE_COLIVE_FLAG), ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, '') ||' '|| ifnull(A.HOUSE_CNT, '') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,''), Trim(B.CHK_WISH_WEEK), Trim(B.CHK_WISH_TIME), ifnull(A.COUNTY, '') ||' '|| ifnull(A.TOWN, '') ||' '|| ifnull(A.VILLAGE, '') ||' '|| ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, ''), ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(Trim(A.CO_LIVE_NM), '') ||' '|| ifnull(A.BLD_NM, '') ||'-'|| ifnull(A.HOUSE_CNT, ''), Trim(A.CHK_EXEC_NUM), Trim(A.SMS_SEND_AGREE_YN), (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM), ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,''), A.CONT_STS_CD FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM AND Trim(B.CHK_WISH_WEEK) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ?, ? ", g_szPtrn_Week, 0, 0);
				}
				else if( Str_Len(g_szPtrn_Time) > 0 )
				{
					SPRINT(m_szSql, "SELECT Trim(A.SINGLE_COLIVE_FLAG), ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, '') ||' '|| ifnull(A.HOUSE_CNT, '') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,''), Trim(B.CHK_WISH_WEEK), Trim(B.CHK_WISH_TIME), ifnull(A.COUNTY, '') ||' '|| ifnull(A.TOWN, '') ||' '|| ifnull(A.VILLAGE, '') ||' '|| ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, ''), ifnull(A.LOT_NUM_SECOND_ADDR, ''), ifnull(Trim(A.CO_LIVE_NM), '') ||' '|| ifnull(A.BLD_NM, '') ||'-'|| ifnull(A.HOUSE_CNT, ''), Trim(A.CHK_EXEC_NUM), Trim(A.SMS_SEND_AGREE_YN), (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM), ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,''), A.CONT_STS_CD FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM AND Trim(B.CHK_WISH_TIME) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ?, ? ", g_szPtrn_Time, 0, 0);
				}
				hstmt = sql->CreateStatement(sql, m_szSql);
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
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
						continue;
					}
					
					idx = 0;
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					if( Str_Cmp(sztmp, "10") == 0 )
					{
						//주소
						if( g_nAddrFlag == 0 )
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							sql->GetValue(sql, 1, 'U', (long*)sztmp, 100 + 1, DECRYPT);
							DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
						}
						else
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							sql->GetValue(sql, 11, 'U', (long*)sztmp, 100 + 1, DECRYPT);
							DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
						}
						//요일
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 3, 'U', (long*)sztmp, 2 + 1, DECRYPT);
						n = SearchCD( sztmp, PTRN_DAY );
						if( n == -1 )
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
						}
						else
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 1, PTRN_DAY[n].Str );
						}
						//시간
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 4, 'U', (long*)sztmp, 2 + 1, DECRYPT);
						n = SearchCD( sztmp, PTRN_TIME );
						if( n == -1 )
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
						}
						else
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 2, PTRN_TIME[n].Str );
						}
						//기본주소
						if( g_nAddrFlag == 0 )
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							sql->GetValue(sql, 5, 'U', (long*)sztmp, 100, DECRYPT);
							DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
						}
						else
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							sql->GetValue(sql, 12, 'U', (long*)sztmp, 100, DECRYPT);
							DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
						}
						//상세주소
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 6, 'U', (long*)sztmp, 100, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
						//점검시행번호
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 8, 'U', (long*)sztmp, 15, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
						//SMS발송
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 9, 'U', (long*)sztmp, 5, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
						if( Str_Cmp(sztmp, "Y") == 0 )
						{
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BLUE);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
						}
						else
						{
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTFRCOLOR);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						}
						//주소확인
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 10, 'U', (long*)sztmp, 100, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
						//CONT_STS_CD, SMS송신버튼 관련
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 13, 'U', (long*)sztmp, 2 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					}
					else if( Str_Cmp(sztmp, "20") == 0 )
					{
						//주소
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 2, 'U', (long*)sztmp, 100 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
						//요일
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 3, 'U', (long*)sztmp, 2 + 1, DECRYPT);
						n = SearchCD( sztmp, PTRN_DAY );
						if( n == -1 )
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
						}
						else
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 1, PTRN_DAY[n].Str );
						}
						//시간
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 4, 'U', (long*)sztmp, 2 + 1, DECRYPT);
						n = SearchCD( sztmp, PTRN_TIME );
						if( n == -1 )
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
						}
						else
						{
							DlgTbl_SetStr ( ID_TBLLIST, i, 2, PTRN_TIME[n].Str );
						}
						//기본주소
						if( g_nAddrFlag == 0 )
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							sql->GetValue(sql, 5, 'U', (long*)sztmp, 100, DECRYPT);
							DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
						}
						else
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							sql->GetValue(sql, 12, 'U', (long*)sztmp, 100, DECRYPT);
							DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
						}
						//상세주소
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
						//점검시행번호
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 8, 'U', (long*)sztmp, 15, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
						//SMS발송
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 9, 'U', (long*)sztmp, 5, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
						if( Str_Cmp(sztmp, "Y") == 0 )
						{
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BLUE);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
						}
						else
						{
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTFRCOLOR);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						}
						//주소확인
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 10, 'U', (long*)sztmp, 100, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
						//CONT_STS_CD, SMS송신버튼 관련
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 13, 'U', (long*)sztmp, 2 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					}
				}
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			if( m_bFirst == INIT_MAIN )
			{
				if( m_lSelIndex == -1 )
				{
					m_lSelIndex = 0;
				}
			
				DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
				DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
				Str_Cat(sztmp, "  ");
				Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), sztmp);
/*
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
*/				
				Mem_Set((byte*)m_szChk_Exec_num, 0x00, sizeof(m_szChk_Exec_num));
				Str_Cpy( m_szChk_Exec_num, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
				Str_Cpy( stScAddr.SEND_YN, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 7));
				
				
				if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 6), "Y") == 0 )
				{
					if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 8), "30") == 0 )
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), RED);
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
					}
				}
				else
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
				}
			}
		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), BTNMENUFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), BTNCTRLBKCOLOR);
		}

		ON_DRAW();
		return;
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

	/*=======================================================================================
	함수명 : SearchStr
	기  능 : 스트링으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
	long	SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; CT[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	/*=======================================================================================
	함수명 : SearchCD
	기  능 : 코드값으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
			{
				return i;
			}
		}
		return -1;
	}
	
	
	/*=======================================================================================
	함수명 : SMSSEND_DRAW
	기  능 : 
	Param  : 
	Return :
	========================================================================================*/		
	void SMSSEND_DRAW(void)
	{
	char szPhone[30];
	char szToday[11];
	char szDate[11];
	char szSql[100];
	char szYear[5];
	char szMonth[3];
	char szDay[3];
	char szZero[3];
	char szHour[3];
	char szHour2[3];
	long lHour = 24;
	long lTime;
	long i;
		
		Mem_Set( (byte*)szPhone, 0x00, sizeof(szPhone) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		//시 셋팅
		for(i=0 ; i<lHour ; i++)
		{
			Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
			if( i < 10 )
			{
				Str_ItoA(i, szHour, 10);
				Str_Cpy(szZero, "0");
				Str_Cat(szZero, szHour);
				Str_Cpy(szHour, szZero);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), szHour, 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), szHour, 0, ICON_NONE);
			}
			else
			{
				Str_ItoA(i, szHour, 10);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), szHour, 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), szHour, 0, ICON_NONE);
			}
		}

		Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
		Mem_Set( (byte*)szZero, 0x00, sizeof(szZero) );
		lTime = Time_GetHour();
		if( lTime < 10 )
		{
			Str_ItoA(lTime, szHour, 10);
			Str_Cpy(szZero, "0");
			Str_Cat(szZero, szHour);
			Str_Cpy(szHour, szZero);
		}
		else
		{
			Str_ItoA(lTime, szHour, 10);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), szHour);
		
		Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
		Mem_Set( (byte*)szHour2, 0x00, sizeof(szHour2) );
		Mem_Set( (byte*)szZero, 0x00, sizeof(szZero) );
		lTime += 1;
		if( lTime < 10 )
		{
			Str_ItoA(lTime, szHour, 10);
			Str_Cpy(szZero, "0");
			Str_Cat(szZero, szHour);
			Str_Cpy(szHour, szZero);
		}
		else
		{
			Str_ItoA(lTime, szHour, 10);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), szHour);
		
		//날짜
		Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Str_ItoA ( Time_GetDate(), szToday, 10);
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)szToday, 4);
		Mem_Cpy((byte *)szMonth, (byte *)szToday+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)szToday+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

		//g_Str_DateType(szDate, szToday);
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), szDate );

		//소속
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), stUserinfo.szcenter_nm);
		
		//점검원
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), stUserinfo.sznm_kor);
		//고객H.P
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szPhone, 0x00, sizeof(szPhone) );
		SPRINT(szSql, "SELECT CP_DDD ||'-'|| CP_EXN||'-'||CP_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ", m_szChk_Exec_num, 0, 0   );
		g_Sql_RetStr( szSql, 20, szPhone );
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), szPhone);
	}
	
	
	/*=======================================================================================
	함수명 : Save_SmsSend
	기  능 : 
	Param  : 
	Return :
	========================================================================================*/		
//전송 문자1 : 도시가스 안전점검 예정일 XX월 XX일 (상단의 방문일자)    안전점검원 : 점검원명 (  디바이스 전화번호  )   방문 
//전송문자 2:  서울도시가스 + stUserinfo.szcenter_nm + 고객센터 + stUserinfo.sztel
	bool Save_SmsSend(void)
	{
		char szSql[1000];
		char szCustTel[50];
		char szUserTel[50];
		char szUserTel2[50];
		char szMsg[2000];
		char szMsg2[1000];
		char szARG_DATE[15];
		char szTime[4];
		char szTime2[4];
		char szDay[30];
		char szTmp[500];
		long idx;
		bool ret = TRUE;
		long lTime = 100;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/*************************************/
		/* 전송문자 1                        */
		/*************************************/
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
		Mem_Set( (byte*)szTime2, 0x00, sizeof(szTime2) );
		Mem_Set( (byte*)szCustTel, 0x00, sizeof(szCustTel) );
		Mem_Set( (byte*)szUserTel, 0x00, sizeof(szUserTel) );
		
		Tapi_GetPhoneNum( (byte*)szUserTel, 0);
		Str_Chg( szUserTel, STRCHG_DEL_NONDIGIT);

		Str_Cpy(szCustTel, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA10)));
		Str_Chg( szCustTel, STRCHG_DEL_NONDIGIT);
		
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		g_Str_DateType( szDay, szTmp);
		
		Str_Cpy( szTime, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)));
		Str_Cpy( szTime2, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)));

		Str_Cpy(szMsg, "안녕하십니까 서울도시가스입니다.");
		Str_Cat(szMsg, "\n도시가스 안전관리규정(가스사용자는 회사(공급자)가 수행하는 사용시설의 안전점검에 적극 협조하여야 한다)에 의하여,");
		Str_Cat(szMsg, "\n아래와 같이 안전점검을 위해 방문 예정입니다.");
		
		SPRINT( szSql, "\n도시가스 안전점검 예정일 : %s\n방문예정시간 : %s시 ~ %s시", szDay, szTime, szTime2 );

		Str_Cat( szMsg, szSql );
		/*************************************/
		/* 전송문자 2                        */
		/*************************************/
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szUserTel2, 0x00, sizeof(szUserTel2) );

		Str_Cat(szMsg, "\n<<안전점검은 고객의 생명과 재산을 지키는 첫걸음 입니다>>");			

		g_FormatPhoneNumber(szUserTel, szUserTel2);	
		
		SPRINT(szTmp, "\n서울도시가스 %s 고객센터", stUserinfo.szcenter_nm, 0, 0);	
		Str_Cat(szMsg, szTmp);
		// SPRINT(szTmp, "\n안전점검원 : %s(%s)\n*업무시간만 통화가능합니다.\n(09시~18시)", stUserinfo.sznm_kor, szUserTel2, 0);
		SPRINT(szTmp, "\n안전점검원 : %s(%s)\n*문의전화는 업무시간(09시~18시)에 해주시면 감사하겠습니다.", stUserinfo.sznm_kor, szUserTel2, 0);
		Str_Cat(szMsg, szTmp);
		SPRINT(szTmp, "\n안전사고 예방을 위해 반려동물은 점검장소와 분리된 공간에 머물도록 부탁드립니다.",0,0,0);
		Str_Cat(szMsg, szTmp);
		
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "메시지 받을 전화 번호가 잘못되었습니다.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "응답을 받을 전화번호가 잘못되었습니다.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "내용이 비었습니다.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "내용이 너무 깁니다.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
					return FALSE;
			}
		}

		VmSleep(lTime);
		
		/*************************************/
		/* 전송문자 2                        */
		/*************************************/
		/*
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		
		SPRINT(szMsg, "서울도시가스 %s 고객센터\n", stUserinfo.szcenter_nm, 0, 0);
		SPRINT(szMsg2, "안전점검원 : %s(%s) 방문", stUserinfo.sznm_kor, szUserTel, 0);
		
		Str_Cat(szMsg, szMsg2);
		
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "메시지 받을 전화 번호가 잘못되었습니다.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "응답을 받을 전화번호가 잘못되었습니다.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "내용이 비었습니다.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "내용이 너무 깁니다.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
					return FALSE;
			}
		}
		*/
		
		MessageBoxEx (CONFIRM_OK, "SMS 전송이 완료되었습니다.");
		
		ret = TRUE;
		
		return ret;
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
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", g_lindex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

//---------------------------------------------------------------------------------------------------------------
/*
	void Grid_QuickList(long nBtnID)
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
			JSON_SetValue ( js, 'C', "title", "선택점검 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(A.COUNTY, '') ||' '|| ifnull(A.TOWN, '') ||' '|| ifnull(A.VILLAGE, '') ||' '|| ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, '') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR, '') ||' '|| ifnull(Trim(A.CO_LIVE_NM), '') ||' '|| ifnull(A.BLD_NM, '') ||'-'|| ifnull(A.HOUSE_CNT, '') , ifnull(CUST_NM, '') ||' /요일:'|| Case When B.CHK_WISH_WEEK = '0' Then '모두' When B.CHK_WISH_WEEK = '1' Then '월' When B.CHK_WISH_WEEK = '2' Then '화' When B.CHK_WISH_WEEK = '3' Then '수' When B.CHK_WISH_WEEK = '4' Then '목' When B.CHK_WISH_WEEK = '5' Then '금' When B.CHK_WISH_WEEK = '6' Then '토' When B.CHK_WISH_WEEK = '7' Then '일' else '' END ||' /시간:'|| Case When B.CHK_WISH_TIME = '0' Then '모두' When B.CHK_WISH_TIME = '1' Then '출근전' When B.CHK_WISH_TIME = '2' Then '오전' When B.CHK_WISH_TIME = '3' Then '오후' When B.CHK_WISH_TIME = '4' Then '퇴근후' else '' END FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "선택점검 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR, '') ||' '|| ifnull(Trim(A.CO_LIVE_NM), '') ||' '|| ifnull(A.BLD_NM, '') ||'-'|| ifnull(A.HOUSE_CNT, '') , ifnull(CUST_NM, '') ||' /요일:'|| Case When B.CHK_WISH_WEEK = '0' Then '모두' When B.CHK_WISH_WEEK = '1' Then '월' When B.CHK_WISH_WEEK = '2' Then '화' When B.CHK_WISH_WEEK = '3' Then '수' When B.CHK_WISH_WEEK = '4' Then '목' When B.CHK_WISH_WEEK = '5' Then '금' When B.CHK_WISH_WEEK = '6' Then '토' When B.CHK_WISH_WEEK = '7' Then '일' else '' END ||' /시간:'|| Case When B.CHK_WISH_TIME = '0' Then '모두' When B.CHK_WISH_TIME = '1' Then '출근전' When B.CHK_WISH_TIME = '2' Then '오전' When B.CHK_WISH_TIME = '3' Then '오후' When B.CHK_WISH_TIME = '4' Then '퇴근후' else '' END FROM NORMAL_DATA A INNER JOIN CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
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
*/

//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(long nBtnID)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char szWhere[256];
		char key[32];
		char val[32];
		char szDay[32];
		char szTime[32];
		long i, j, n=0;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"주소", "요일", "시간", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"4","2","3","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};

		//요일
		Mem_Set( (byte*)szDay, 0x00, sizeof(szDay) );
		n = SearchCD( g_szPtrn_Week, PTRN_DAY );
		if( n == -1 )
		{
			Str_Cpy(szDay, "");
		}
		else
		{
			Str_Cpy(szDay, PTRN_DAY[n].Str);
		}
		//시간
		Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
		n = 0;
		n = SearchCD( szTime, PTRN_TIME );
		if( n == -1 )
		{
			Str_Cpy(szTime, "");
		}
		else
		{
			Str_Cpy(szTime, PTRN_DAY[n].Str);
		}

		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		if( nBtnID == BID_QUICK_ADDR )
		{
			SPRINT(m_szSql,"SELECT \
CASE WHEN Trim(A.SINGLE_COLIVE_FLAG) = '10' \
THEN  ifnull(A.ADDR1_M, '') ||'-'|| ifnull(A.ADDR1_S, '') ||' '|| ifnull(A.HOUSE_CNT, '') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR, '') \
ELSE ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') END, \
'%s' AS WEEK , '%s' AS TIME \
FROM NORMAL_DATA A \
INNER JOIN \
CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM ",szDay,szTime,0);
		}
		else
		{
			SPRINT(m_szSql,"SELECT \
CASE WHEN Trim(A.SINGLE_COLIVE_FLAG) = '10' \
THEN  ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') \
ELSE ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') END, \
'%s' AS WEEK , '%s' AS TIME \
FROM NORMAL_DATA A \
INNER JOIN \
CUST_PATT_COLL_INFO B WHERE A.BLD_NUM = B.BLD_NUM AND A.INST_PLACE_NUM = B.INST_PLACE_NUM ",szDay,szTime,0);
		}

		if( Str_Len(g_szPtrn_Week) > 0 && Str_Len(g_szPtrn_Time) > 0 )
		{
			SPRINT(szWhere, " AND Trim(B.CHK_WISH_TIME) = '%s' AND Trim(B.CHK_WISH_WEEK) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD ",g_szPtrn_Week,g_szPtrn_Time,0);
			Str_Cat(m_szSql, szWhere);
		}
		else if( Str_Len(g_szPtrn_Week) > 0 )
		{
			SPRINT(szWhere, " AND Trim(B.CHK_WISH_WEEK) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD ",g_szPtrn_Week,g_szPtrn_Time,0);
			Str_Cat(m_szSql, szWhere);
		}
		else if( Str_Len(g_szPtrn_Time) > 0 )
		{
			SPRINT(szWhere, " AND Trim(B.CHK_WISH_TIME) = '%s' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD ",g_szPtrn_Week,g_szPtrn_Time,0);
			Str_Cat(m_szSql, szWhere);
		}
		else 
		{
			Str_Cat(m_szSql, "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD ");
		}
		
//		PRINT(">>>>>>>>>>>>>>>>>>>>>>>>> %d",Str_Len(m_szSql),0,0);
//		PRINT(">>>>>>>>>>>>>>>>>>>>>>>>> %s",m_szSql,0,0);
	
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

			start_position = m_lpage*ROW + m_lSelIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szSql);
			
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
			
			JSON_SetValue	(h		, 'C', "title"			, "선택점검 리스트");
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


