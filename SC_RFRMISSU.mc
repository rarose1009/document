/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_RFRMISSU
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
	
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
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_REFORMSCHDL2 )
		DEF_BUTTON_ID ( BID_COMPLETE )	//완료
		DEF_BUTTON_ID ( BID_OK )		//확인
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
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//페이지
		DEF_OBJECT_ID ( TXT_NOFIT )			//부적합항목
		DEF_OBJECT_ID ( TXT_REFORMSCHDL )	//개선예정일
		DEF_OBJECT_ID ( TXT_POSSIBLE )		//여부
		DEF_OBJECT_ID ( TXT_SCUNIT )		//점검단위
		DEF_OBJECT_ID ( TXT_ITEMNM )		//항목명
		DEF_OBJECT_ID ( TXT_OBJNUM )		//기물번호
		DEF_OBJECT_ID ( TXT_CMBSTRNUM )		//연소기번호
		DEF_OBJECT_ID ( TXT_VISITDT )		//방문일시
		DEF_OBJECT_ID ( TXT_REFORMSCHDL2 )	//개선예정일자
		DEF_OBJECT_ID ( TXT_REFORMDT )		//개선일자
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
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

//포인팅 자판
		DEF_OBJECT_ID ( TXT_KEY_ONE )
		DEF_OBJECT_ID ( TXT_KEY_TWO )
		DEF_OBJECT_ID ( TXT_KEY_THREE )
		DEF_OBJECT_ID ( TXT_KEY_FOUR )
		DEF_OBJECT_ID ( TXT_KEY_FIVE )
		DEF_OBJECT_ID ( TXT_KEY_SIX )
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )
		DEF_OBJECT_ID ( TXT_KEY_NINE )
		DEF_OBJECT_ID ( TXT_KEY_ZERO )
		DEF_OBJECT_ID ( TXT_KEY_DEL )

		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )

		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+10)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		51 				    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+65  		    // table 시작y좌표
	#define		GRID_Y_P	STARTY-40 			// table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"부적합항목",	  CWD*20+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"개선예정일",	  CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"여부",		  CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"점검부문코드",  CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"부적합항목코드",CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	#define INIT_MAIN	1
	
	long m_bFirst;
	long m_lpage = 0;
	long m_lTotCnt = 0;
	long m_lTotpage = 0;
	long m_lSelIndex = -1;
	long m_lSelRow = -1;
	long m_lActiveIndex = -1;
	char m_szCnt_page[10];
	
	void SetStyle(void);
	void SetData(void);
	void SetClickData(void);
	bool Update_Better(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	void SetBtnImg(void);
	bool Save_REFORMSCHDL(void);
	bool Snd_Sms(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개선권고 발행"),

		DLG_BUTTON(STARTX+500, STARTY+365, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+365, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "▼"),
		DLG_BUTTON(STARTX+600, STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),
		
		DLG_TEXT(STARTX,     STARTY+365, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),	//페이지
		DLG_TEXT(STARTX,     STARTY+425, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCUNIT, "점검단위"),
		DLG_TEXT(STARTX+350, STARTY+425, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+485, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEMNM, "항목명"),
		DLG_TEXT(STARTX+350, STARTY+485, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX,     STARTY+545, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_TEXT(STARTX+350, STARTY+545, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX,     STARTY+605, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "연소기번호"),
		DLG_TEXT(STARTX+350, STARTY+605, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX,     STARTY+665, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "방문일시"),
		DLG_TEXT(STARTX+350, STARTY+665, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		
		DLG_TEXT(STARTX, 	 STARTY+725, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMSCHDL2, "개선예정일자"),
		DLG_EDIT( STARTX+350,  STARTY+725, 200, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+550,  STARTY+725, 18, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+550,  STARTY+755, 18, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA24, "."),
		DLG_EDIT( STARTX+568,  STARTY+725, 145, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+713,  STARTY+725, 17, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX+713,  STARTY+755, 17, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA26, "."),
		DLG_EDIT( STARTX+730,  STARTY+725, 145, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+875, STARTY+725, 125, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFORMSCHDL2, "▼"),
		//DLG_TEXT(STARTX+350, STARTY+680, 525, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		//DLG_BUTTON(STARTX+875, STARTY+680, 100,   60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORMSCHDL2, "▼"),

//		DLG_TEXT(STARTX,     STARTY+740, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "개선일자"),
//		DLG_TEXT(STARTX+350, STARTY+740, 625, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
	
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		//숫자 자판
		DLG_TEXT(0,    STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT(333,  STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT(666,  STARTY+940, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT(333, STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT(666, STARTY+1030, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT(0,   STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1120, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT(333, STARTY+1210, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT(666, STARTY+1210, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "←"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "개선권고 발행"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+500, STARTY+250, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+250, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "▼"),
		DLG_BUTTON(STARTX+200, STARTY+780, 600, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),
		
		DLG_TEXT(STARTX,     STARTY+250, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),	//페이지
		DLG_TEXT(STARTX, 	 STARTY+320, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCUNIT, "점검단위"),
		DLG_TEXT(STARTX+350, STARTY+320, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX, 	 STARTY+390, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEMNM, "항목명"),
		DLG_TEXT(STARTX+350, STARTY+390, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX, 	 STARTY+460, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_TEXT(STARTX+350, STARTY+460, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX, 	 STARTY+530, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "연소기번호"),
		DLG_TEXT(STARTX+350, STARTY+530, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX, 	 STARTY+600, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "방문일시"),
		DLG_TEXT(STARTX+350, STARTY+600, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		
		DLG_TEXT(STARTX, 	   STARTY+670, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMSCHDL2, "개선예정일자"),
		DLG_EDIT( STARTX+350,  STARTY+670, 200, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+550,   STARTY+670, 20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+550,   STARTY+710, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA24, "."),
		DLG_EDIT( STARTX+570,  STARTY+670, 150, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+720,   STARTY+670, 20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX+720,   STARTY+710, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA26, "."),
		DLG_EDIT( STARTX+740,  STARTY+670, 150, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+890, STARTY+670, 110, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFORMSCHDL2, "▼"),
		//DLG_TEXT(STARTX+350, STARTY+660, 475, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		//DLG_BUTTON(STARTX+825, STARTY+660, 150,   70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORMSCHDL2, "▼"),

//		DLG_TEXT(STARTX, 	 STARTY+740, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "개선일자"),
//		DLG_TEXT(STARTX+350, STARTY+740, 625, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
	
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
				SetStyle();
				SetData();
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

	//--------------------------------------------------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SCUNIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ITEMNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMBSTRNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISITDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFORMSCHDL2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		
		if( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") == 0 || Str_Cmp(stSc.PREUSE_CHK_WHY, "30") == 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORMSCHDL2), FALSE );
		}
		
		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			//숫자판
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}

		return;
	}

//--------------------------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d,k;
		long nRet;
		char szSql[200];
		char sztmp[30];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
	
		switch(ID)
		{
			case BID_PREVLST:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//SetData();
					break;
				}
				m_lSelIndex = 0;
				SetData();
				break;
			case BID_NEXTLST:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//SetData();
					break;
				}
				m_lSelIndex = 0;
				SetData();
				break;
/*
			case BID_COMPLETE:
				Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
				Str_ItoA(Time_GetDate(), szToday, 10);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), szToday );
				if( Update_Better() )
				{
					MessageBoxEx (CONFIRM_OK, "개선 완료되었습니다.");
				}
*/
				break;
			case BID_REFORMSCHDL2:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>szDate : %s",szDate,0,0);
				k = Str_AtoI(szDate);
			
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_ItoA ( d, sztmp, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
					Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

					
					//g_Str_DateType( szToday, sztmp);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), szToday );
					
					Save_REFORMSCHDL();
					SetData();
				}
				break;												
			case BID_OK:
				//우선점검 대상의 경우에는 아래의 코드 예외처리 하도록
				if( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") != 0 && Str_Cmp(stSc.PREUSE_CHK_WHY, "30") != 0 )
				{
					Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
					SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL  WHERE CHK_EXEC_NUM = '%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL)",g_szCHK_EXEC_NUM, 0, 0   );
					g_Sql_RetInt( szSql, &nRet );
					if( nRet == 0 )
					{
						Str_Cpy( stSc.LOC_RSLT, "Y");
						Str_Cpy( stSc.MTR_RSLT, "Y");
						Str_Cpy( stSc.BO_RSLT, "Y");
						Str_Cpy( stSc.NOGOOD_RSLT, "Y");
					}
				}
				Card_Move("SC_START");
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
					{
						g_Del_ScData();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "안전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
					{
						g_Del_ScData();
					}
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
				Card_Move("SC_START");
				break;	
			case GID_VMEXIT:
				if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
				{
					g_Exit_DelScData();
					return;
				}
				g_Exit();
				return;
		}
	}		

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];

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
		
		//개선권고일자
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
		}

		ON_DRAW();
		return;
	}

	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL에 ACTIVE시에 CTRLINDEX를 저장
		//키보드 BUTTONCTRL이 ACTIVE시에도 EDITCTRL에 커서를 두기위해서 INDEX를 저장
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{
			m_lActiveIndex = lActiveIndex;
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+550) && Y > DMS_Y(STARTY+725-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+785-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+568) && X < DMS_X(STARTX+713) && Y > DMS_Y(STARTY+725-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+785-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+730) && X < DMS_X(STARTX+875) && Y > DMS_Y(STARTY+725-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+785-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
					{
						g_Dlgflag = 0;
						g_MOVE_DLG(400);
					
					//	ShowSip(FALSE);
					//	g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
					//	ShowSip(TRUE);
					//	g_Sipflag = 1;
					}
				}
				else
				{
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400))  )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
					}
				}
				
				ON_DRAW();
			}
		}
		
		return;
	}


//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long lActIndex = -1;
	
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			lActIndex = DlgTbl_GetActiveRow(ID_TBLLIST);
			
			m_lSelIndex = lActIndex - 1;
			
			Str_Cpy(stScNogood.NOT_PASS_ITEM_NM	, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
			Str_Cpy(stScNogood.CHK_SEC_CD		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
			Str_Cpy(stScNogood.NOT_PASS_ITEM_CD	, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));

			SetClickData();
		}
	}
	
//--------------------------------------------------------------------------------------------------------	
	void SetData(void)
	{
		long i, idx, j;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char sztmp[200];
		char szSql[800];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//페이지
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL  WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( sztmp, &m_lTotpage );
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lSelIndex == -1 )
		{
			m_lSelIndex = 0;
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT NOT_PASS_ITEM_NM, BETTER_PLAN_YMD, BETTER_YN, CHK_SEC_CD, NOT_PASS_ITEM_CD \
		FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' LIMIT ?, ? "
		, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, i++, 'X', &lstartidx, 4, DECRYPT);
		j = m_lpage*ROW+ROW;
		sql->Bind(sql, i++, 'X', &j, 4, DECRYPT);
		
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
				//부적합항목
				idx = 0;
				Mem_Set( (byte*)stScNogood.NOT_PASS_ITEM_NM, 0x00, sizeof(stScNogood.NOT_PASS_ITEM_NM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScNogood.NOT_PASS_ITEM_NM , 2 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, stScNogood.NOT_PASS_ITEM_NM );
				//개선예정일
				Mem_Set( (byte*)stScNogood.BETTER_PLAN_YMD, 0x00, sizeof(stScNogood.BETTER_PLAN_YMD) );
				sql->GetValue( sql, idx++, 'U', (long*) stScNogood.BETTER_PLAN_YMD  , 8 + 1, DECRYPT );
				g_Str_DateType( sztmp, stScNogood.BETTER_PLAN_YMD);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//여부
				Mem_Set( (byte*)stScNogood.BETTER_YN, 0x00, sizeof(stScNogood.BETTER_YN) );
				sql->GetValue( sql, idx++, 'U', (long*) stScNogood.BETTER_YN        , 1+ 1, DECRYPT );
				if(stScNogood.BETTER_YN[0] == 'Y')
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "개선" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "미개선");
				//점검부문코드
				Mem_Set( (byte*)stScNogood.CHK_SEC_CD, 0x00, sizeof(stScNogood.CHK_SEC_CD) );
				sql->GetValue( sql, idx++, 'U', (long*) stScNogood.CHK_SEC_CD       , 2+ 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, stScNogood.CHK_SEC_CD );
				//점검부문코드
				Mem_Set( (byte*)stScNogood.NOT_PASS_ITEM_CD, 0x00, sizeof(stScNogood.NOT_PASS_ITEM_CD) );
				sql->GetValue( sql, idx++, 'U', (long*) stScNogood.NOT_PASS_ITEM_CD , 2+ 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, stScNogood.NOT_PASS_ITEM_CD );
			}
		}	
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
		
			Str_Cpy(stScNogood.NOT_PASS_ITEM_NM	, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
			Str_Cpy(stScNogood.CHK_SEC_CD		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
			Str_Cpy(stScNogood.NOT_PASS_ITEM_CD	, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
			
			SetClickData();
		}
		
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	함수명 : SetClickData
	기  능 : 계량기를 선택했을때 데이터 새로 셋팅
	Param  : 
	Return : 
	========================================================================================*/	
	void SetClickData(void)
	{
		long i, idx, j;
		long n;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char sztmp[300];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , stScNogood.NOT_PASS_ITEM_NM);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		//BURNER_KIND_NUM = 201 || 301 이면 보일러, 나머지는 연소기
		hstmt = sql->CreateStatement(sql, " SELECT CHK_SEC_NM, MTR_NUM, BURNER_NUM, VISIT_DTM, BETTER_PLAN_YMD \
		FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}


		i = 0;
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM,            12, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stScNogood.CHK_SEC_CD,        2, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stScNogood.NOT_PASS_ITEM_CD,  2, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			//점검단위
			Mem_Set( (byte*)stScNogood.CHK_SEC_NM, 0x00, sizeof(stScNogood.CHK_SEC_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScNogood.CHK_SEC_NM      , 32 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16)   , stScNogood.CHK_SEC_NM);
			//계량기번호
			Mem_Set( (byte*)stScNogood.MTR_NUM, 0x00, sizeof(stScNogood.MTR_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScNogood.MTR_NUM         , 9 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18)   , stScNogood.MTR_NUM);
			//연소기번호
			Mem_Set( (byte*)stScNogood.BURNER_NUM, 0x00, sizeof(stScNogood.BURNER_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScNogood.BURNER_NUM      , 6+ 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19)   , stScNogood.BURNER_NUM);
			//방문일시
			Mem_Set( (byte*)stScNogood.VISIT_DTM, 0x00, sizeof(stScNogood.VISIT_DTM) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) stScNogood.VISIT_DTM       , 14+ 1, DECRYPT );
			g_Str_DateType(sztmp, stScNogood.VISIT_DTM);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), sztmp);
			//개선예정일자
			Mem_Set( (byte*)stScNogood.BETTER_PLAN_YMD, 0x00, sizeof(stScNogood.BETTER_PLAN_YMD) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) stScNogood.BETTER_PLAN_YMD , 8 + 1, DECRYPT );
			
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Cpy((byte *)szYear, (byte *)stScNogood.BETTER_PLAN_YMD, 4);
			Mem_Cpy((byte *)szMonth, (byte *)stScNogood.BETTER_PLAN_YMD+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)stScNogood.BETTER_PLAN_YMD+6, 2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );	

			//g_Str_DateType(sztmp, stScNogood.BETTER_PLAN_YMD);
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22)   , sztmp);
		}
	
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
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

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
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
				return i;
		}
		
		return -1;
	}
	
//----------------------------------------------------------------
	bool Save_REFORMSCHDL(void)
	{
		char szSql[300];
		char sztmp[50];
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//Str_Cpy(sztmp, 	 EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)));	//개선예정일자
		//Str_Chg(sztmp, STRCHG_DEL_NONDIGIT );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Chg(sztmp, STRCHG_DEL_NONDIGIT);		
		
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, " UPDATE NORMAL_NOGOOD_DETAL SET BETTER_PLAN_YMD = ? \
WHERE CHK_EXEC_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)sztmp	                    ,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM			    ,12	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogood.CHK_SEC_CD		,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogood.NOT_PASS_ITEM_CD	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	
	/*=======================================================================================
	함수명 : Update_Better
	기  능 : BETTER_END_YMD 업데이트
	Param  : 
	Return :
	========================================================================================*/
/*
	bool Update_Better(void)
	{
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
				
		Str_Cpy(stScNogood.BETTER_END_YMD, 	 EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA21)));	//개선완료일자
		Str_Cpy(stScNogood.BETTER_YN, "Y" );
		Str_Cpy(stScNogood.SEND_YN, "S" );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, " UPDATE NORMAL_NOGOOD_DETAL SET \
BETTER_END_YMD = ?, BETTER_YN = ?, SEND_YN = ? \
WHERE CHK_EXEC_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScNogood.BETTER_END_YMD	,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogood.BETTER_YN			,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogood.SEND_YN			,1	,DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM			    ,12	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogood.CHK_SEC_CD		,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogood.NOT_PASS_ITEM_CD	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
*/

//-------------------------------------------------------------------------------------------------
	bool Snd_Sms(void)
	{
		char szSql[100];
		char szCustTel[50];
		char szUserTel[50];
		char szMsg[300];
		char szMsg2[300];
		char szARG_DATE[15];
		char szTime[4];
		char szDay[30];
		char szTmp[20];
		long idx;
		bool ret = TRUE;
		long lTime = 100;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();


		Mem_Set( (byte*)szUserTel, 0x00, sizeof(szUserTel) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );

		Tapi_GetPhoneNum( (byte*)szTmp, 0);
		
		if( Str_Cmp(szTmp, "01099991111") == 0 )
		{
			Str_Cpy(szUserTel, "00000000000");
			MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
			return FALSE;
		}
		else
		{
			Str_Cpy(szUserTel, szTmp);
		}
		
		Str_Chg( szUserTel, STRCHG_DEL_NONDIGIT);

		Mem_Set( (byte*)szCustTel, 0x00, sizeof(szCustTel) );
		//Str_Cpy(szCustTel, g_szCpNum);
		Str_Cpy(szCustTel, stSc.CP_DDD);
		Str_Cat(szCustTel, stSc.CP_EXN);
		Str_Cat(szCustTel, stSc.CP_NUM);
		Str_Chg( szCustTel, STRCHG_DEL_NONDIGIT);
		
		//전송문자 내용
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		SPRINT(szMsg, ""
					, 0, 0, 0);

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
		
/*
		//전송문자2
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		
		SPRINT(szMsg, "안전점검원:%s(%s) 방문\n"
					, stUserinfo.sznm_kor, szUserTel, 0);
		
		SPRINT(szMsg2, "서울도시가스 %s 고객센터:%s"
					, stUserinfo.szcenter_nm, stUserinfo.sztel, 0);
		
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

		ret = TRUE;
		return ret;
	}


}


