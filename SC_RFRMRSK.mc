/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_RFRMRSK
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
	#define USE_ON_UART
	#define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_REFORM )	//개선완료
		DEF_BUTTON_ID ( BID_OK1 )		//확인
		DEF_BUTTON_ID ( BID_REFSCHDL ) //개선예정일자
		DEF_BUTTON_ID ( BID_PREVLST )		//
		DEF_BUTTON_ID ( BID_NEXTLST )		//
//개선일자입력
		DEF_BUTTON_ID ( BID_OK2 )
		DEF_BUTTON_ID ( BID_CLOSE )
		DEF_BUTTON_ID ( BID_REFSCHDL2 ) //개선예정일자
		
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
		DEF_OBJECT_ID ( TXT_BSUNIT )		//점검단위
		DEF_OBJECT_ID ( TXT_CMBSTRNUM )		//연소기번호
		DEF_OBJECT_ID ( TXT_OBJNUM )		//기물번호
		DEF_OBJECT_ID ( TXT_VISITDT )		//방문일시
		DEF_OBJECT_ID ( TXT_REFSCHDL2 )		//개선예정일자
		DEF_OBJECT_ID ( TXT_NUMBER )		//차수
		DEF_OBJECT_ID ( TXT_REFPSSBL )		//개선여부
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
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
//개선일자 입력
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
//개선일자 입력
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )

		DEF_OBJECT_ID ( ID_TBLLIST )

		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

		DEF_OBJECT_ID ( CMB_DATA1  )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_REFORMDT 2
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5					// table의 행개수
	#define		COL 	    11					// table의 열개수
	#define		GRID_H		(CHT+10)			// table 행 높이
	#define		GRID_H_P	(CHT+20)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		51 				    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+65	  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY-40           // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"부적합항목", CWD*19+23, EDITALIGN_MIDDLE,      TABLE_TEXT, 0},
		{"개선예정일", CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"여부",       CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"점검단위",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"기물번호",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"연소기번호", 0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"방문일시",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"차수",       0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"개선일자",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"항목코드",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"단위코드",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	char m_szCnt_page[10];
	char m_szNotPassCD[50];
	char m_szBetterAdYmd[20];
	char m_szBETTER_ADVICE_DEGREE[3];
	
	char m_szEndDate[15];
	char m_szCHK_SEC_CD[3];
	char m_szNOT_PASS_ITEM_CD[3];
	char m_szMTR_NUM[10];
	char m_szBURNER_NUM[10];
	
	long m_lpage;
	long m_lTotpage;
	long m_lActive = -1;
	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	char m_szfilenm[128];
	
	void SetStyle(void);
	void REDRAW(void);
	void ReformDraw(void);
	bool Save_BetterEnd(void);
	void Save_BetterYn(void);
	void SetBtnImg(void);
	void SetActRow(void);
	bool Validate(void);
	void Shoto_Photo(void);
	void Photo_View(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개선권고 부적합상세"),

		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_BUTTON(STARTX+500, STARTY+365, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+365, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "▼"),

		DLG_TEXT( STARTX,     STARTY+365, 350, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_TEXT( STARTX,     STARTY+430, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSUNIT, "점검단위"),
		DLG_TEXT( STARTX+350, STARTY+430, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT( STARTX,     STARTY+490, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_TEXT( STARTX+350, STARTY+490, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT( STARTX,     STARTY+550, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "연소기번호"),
		DLG_TEXT( STARTX+350, STARTY+550, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT( STARTX,     STARTY+610, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "방문일시"),
		DLG_TEXT( STARTX+350, STARTY+610, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_TEXT( STARTX,       STARTY+670, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFSCHDL2, "개선예정일자"),
		DLG_EDIT(STARTX+350,    STARTY+670, 180, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+530,    STARTY+670,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+530,    STARTY+700,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, "."),
		DLG_EDIT(STARTX+550,    STARTY+670, 140, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+690,    STARTY+670,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+690,    STARTY+700,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, "."),
		DLG_EDIT(STARTX+710,    STARTY+670, 140, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+850,  STARTY+670, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		//DLG_TEXT( STARTX+350, STARTY+650, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		//DLG_BUTTON(STARTX+630,STARTY+650,  95, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		
		DLG_TEXT(STARTX,     STARTY+730, 350, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFPSSBL, "개선여부"),
		DLG_TEXT(STARTX+350, STARTY+730, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+650, STARTY+730, 150, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NUMBER, "차수"),
		DLG_TEXT(STARTX+800, STARTY+730, 200, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+785, 350, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "개선일자"),
		DLG_TEXT(STARTX+350, STARTY+785, 325, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_BUTTON(STARTX+675,STARTY+785, 325, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "개선완료"),
		
		DLG_BUTTON(STARTX+200, STARTY+840, 600, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1, "확 인"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//화면캡쳐
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "개선권고 부적합상세"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_TEXT(STARTX,	  STARTY+300, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500,STARTY+300, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "▲"),
		DLG_BUTTON(STARTX+750,STARTY+300, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "▼"),

		DLG_TEXT(STARTX,     STARTY+370, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSUNIT, "점검단위"),
		DLG_TEXT(STARTX+350, STARTY+370, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+430, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_TEXT(STARTX+350, STARTY+430, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+490, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "연소기번호"),
		DLG_TEXT(STARTX+350, STARTY+490, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,     STARTY+550, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "방문일시"),
		DLG_TEXT(STARTX+350, STARTY+550, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_TEXT(STARTX,        STARTY+610, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFSCHDL2, "개선예정일자"),
		DLG_EDIT(STARTX+350,    STARTY+610, 180, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+530,    STARTY+610,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+530,    STARTY+640,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, "."),
		DLG_EDIT(STARTX+550,    STARTY+610, 140, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+690,    STARTY+610,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+690,    STARTY+640,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, "."),
		DLG_EDIT(STARTX+710,    STARTY+610, 140, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+850,  STARTY+610, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		//DLG_TEXT(STARTX+330, STARTY+610, 270, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		//DLG_BUTTON(STARTX+600,STARTY+610, 125, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		
		DLG_TEXT(STARTX,      STARTY+670, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFPSSBL, "개선여부"),
		DLG_TEXT(STARTX+350,  STARTY+670, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+650,  STARTY+670, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NUMBER, "차수"),
		DLG_TEXT(STARTX+800,  STARTY+670, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),

		DLG_TEXT(STARTX,      STARTY+730, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "개선일자"),
		DLG_TEXT(STARTX+350,  STARTY+730, 325, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_BUTTON(STARTX+675,STARTY+730, 325, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "개선완료"),
		
		DLG_BUTTON(STARTX+200,STARTY+800, 600, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1, "확 인"),
		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//  다이얼로그:개선일자입력
	//---------------------------------------------------------------
	DlgObject	DlgRes_REFORMDT[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개선일자 입력"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+600,	 STARTY+100, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "확인"),

		DLG_TEXT ( STARTX,		STARTY-29, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "개선일자"),
		DLG_EDIT(STARTX+300,    STARTY-29, 185, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+485,    STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+485,    STARTY+11,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA16, "."),
		DLG_EDIT(STARTX+505,    STARTY-29, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 2,  ""),
		DLG_TEXT(STARTX+655,    STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+655,    STARTY+11,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, "."),
		DLG_EDIT(STARTX+675,    STARTY-29, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_BUTTON(STARTX+825,	STARTY-29, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL2, "▼"),
		//DLG_TEXT ( STARTX+300,	 STARTY-10, 450, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		//DLG_BUTTON(STARTX+750,	 STARTY-10, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL2,  "▼"),
	};
	
	//  다이얼로그:개선일자입력
	//---------------------------------------------------------------
	DlgObject	DlgRes_REFORMDT_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개선일자 입력"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+600,	 STARTY+100, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "확인"),

		DLG_TEXT ( STARTX,		STARTY-40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "개선일자"),
		DLG_EDIT(STARTX+300,    STARTY-40, 185, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+485,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+485,       STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA16, "."),
		DLG_EDIT(STARTX+505,    STARTY-40, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 2,  ""),
		DLG_TEXT(STARTX+655,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+655,       STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, "."),
		DLG_EDIT(STARTX+675,    STARTY-40, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_BUTTON(STARTX+825,	STARTY-40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL2, "▼"),
		//DLG_TEXT ( STARTX+300,	 STARTY-10, 450, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		//DLG_BUTTON(STARTX+750,	 STARTY-10, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL2,  "▼"),
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
				REDRAW();
				break;

			case INIT_REFORMDT:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_REFORMDT_P, SIZEOF(DlgRes_REFORMDT_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_REFORMDT, SIZEOF(DlgRes_REFORMDT));
						break;		
				}

				SetBtnImg();
				ReformDraw();
				break;

		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		if( m_bFirst == INIT_MAIN )
		{
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSUNIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMBSTRNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISITDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFSCHDL2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NUMBER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFPSSBL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFORMDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		}
	}

//--------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char sztmp[15];
		char szToday[15];
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
					//SetStyle();
					//REDRAW();
					return;
				}
				m_lActive = 0;
				//SetStyle();
				REDRAW();
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
					//SetStyle();
					//REDRAW();
					break;
				}
				m_lActive = 0;
				//SetStyle();
				REDRAW();
				break;
			case BID_REFORM:
				if( m_lActive != -1 )
				{
					if( Validate() )
					{
						if( MessageBoxEx (CONFIRM_YESNO, "개선하시겠습니까?") == MB_OK )
						{
							ON_EXIT();
							OnInit(INIT_REFORMDT);
						}
					}
				}
				else
				{
					MessageBoxEx (ERROR_OK, "개선 할 목록을 선택해 주세요.");
					SetActRow();
				}
				break;
			case BID_REFSCHDL:
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
					SetActRow();
					break;
				}
				else
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
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
					
					//Str_ItoA (Time_GetDate(), szToday, 10 );
					//g_Str_DateType( szToday, sztmp );
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), szToday );					

					SetActRow();
				}
				break;
			case BID_OK1:
				Save_BetterYn();
				Card_Move("SC_RFRMPRGRS");
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
				Card_Move("SC_RFRMPRGRS");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			case BID_EXIT:
				g_Exit();
				break;
				
//개선권고 완료
			case BID_OK2:
				if( Save_BetterEnd() )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_REFSCHDL2:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
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
					Mem_Set((byte*)m_szEndDate, 0x00, sizeof(m_szEndDate));
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_ItoA ( d, m_szEndDate, 10);
					Str_ItoA (Time_GetDate(), sztmp, 10 );
					if( Str_AtoI(sztmp) <= Str_AtoI(m_szEndDate) )
					{
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte *)szYear, (byte *)m_szEndDate, 4);
						Mem_Cpy((byte *)szMonth, (byte *)m_szEndDate+4, 2);
						Mem_Cpy((byte *)szDay, (byte *)m_szEndDate+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szDay );					

						//g_Str_DateType( sztmp, m_szEndDate);
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp );
					}
					else
					{
						MessageBoxEx (WARNING_OK, "개선완료일이 잘못 설정되었습니다.\n 다시 설정해주세요.");
						break;
					}
				}
				Str_Chg( m_szEndDate, STRCHG_DEL_NONDIGIT);
				break;
		}
	}

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		char szDate[10];

		if( m_bFirst == INIT_MAIN )
		{
			//숫자만 입력 가능
			if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex 
			|| Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
			
			//개선권고일자
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
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
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
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
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				
				SetActRow();
			}
		}
		else if( m_bFirst == INIT_REFORMDT )
		{
			//숫자만 입력 가능
			if( (Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex 
			|| Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
			
			//개선권고일자
			if( Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA5)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				else
				{
					Str_ItoA (Time_GetDate(), szDate, 10 );
					if( Str_AtoI(szDate) <= Str_AtoI(szTmp) )
					{
						Str_Cpy(m_szEndDate, szTmp);
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "개선완료일이 잘못 설정되었습니다.\n 다시 설정해주세요.");
						
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
						
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
						m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
				}
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
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+530) && Y > DMS_Y(STARTY+670-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+730-(g_Dlgflag*400)) ||
						X > DMS_X(STARTX+550) && X < DMS_X(STARTX+690) && Y > DMS_Y(STARTY+670-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+730-(g_Dlgflag*400)) ||
						X > DMS_X(STARTX+710) && X < DMS_X(STARTX+850) && Y > DMS_Y(STARTY+670-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+730-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
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
		else if( m_bFirst == INIT_REFORMDT )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+485) && Y > DMS_Y(STARTY-10) && Y < DMS_Y(STARTY+60) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+505) && X < DMS_X(STARTX+655) && Y > DMS_Y(STARTY-10) && Y < DMS_Y(STARTY+60) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+675) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY-10) && Y < DMS_Y(STARTY+60) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex )	
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


//--------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long index = -1;
		char sztmp[200];
		char szDate[12];
		char szYear[5];
		char szMonth[3];
		char szDay[3];

		if( INIT_MAIN == m_bFirst )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
				Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
				Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
				Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_lActive = index-1;
				//처음 선택된 대상의 주소를 상단에 표시
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 6));
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));

				Str_Cpy(szDate, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));
				Str_Chg( szDate, STRCHG_DEL_NONDIGIT);
				Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
				Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
				Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 7));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 8));
				
				Str_Cpy( m_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
				Str_Cpy( m_szBURNER_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
				Str_Cpy( m_szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));
				Str_Cpy( m_szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));
							
				ON_DRAW();
			}
		}
	}
	
//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[401];
		char szDp[20];
		long ret = -1;	
		long lstartidx ;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
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

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT NOT_PASS_ITEM_NM, BETTER_PLAN_YMD, BETTER_YN, CHK_SEC_NM, MTR_NUM, BURNER_NUM, VISIT_DTM, BETTER_DEGREE, Trim(BETTER_END_YMD), CHK_SEC_CD, NOT_PASS_ITEM_CD FROM NORMAL_NOGOOD_DETAL WHERE  CHK_EXEC_NUM = '%s' ORDER BY CHK_SEC_CD, NOT_PASS_ITEM_CD LIMIT ?, ?",g_szCHK_EXEC_NUM, 0, 0   );
                 
		hstmt = sql->CreateStatement(sql, sztmp);
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					continue;
				}
				//부적합 항목
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 33, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//개선예정일
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 9, DECRYPT);
				g_Str_DateType( szDp, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, szDp );
				//여부
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				if(sztmp[0] == 'Y')
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "개선" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "미개선");	
				//점검단위
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 33, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );			
				//기물번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );			
				//연소기번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 7, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );	
				//방문일시
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 15, DECRYPT);
				g_Str_DateType( szDp, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, szDp );	
				//차수
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 3, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );	
				//개선일자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 9, DECRYPT);
				g_Str_DateType( szDp, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, szDp );					
				//점검단위코드
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 3, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );	
				//항목코드
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 3, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
			}
		}		

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			//m_lActive = 0;
			SetActRow();
		}
		
		ON_DRAW();
		return;
	}
	
	
//------------------------------------------------------------------------------------------
	bool Validate(void)
	{
		char sztmp[100];
		char szSql[300];
		char szDay[20];
		long lDay;
		bool bRet = TRUE;
	
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2));
		if( Str_Cmp( sztmp, "개선" ) == 0  )
		{
			MessageBoxEx (CONFIRM_OK, "이미 개선 완료 된 항목입니다.");
			bRet = FALSE;
			return bRet;	
		}
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		SPRINT(szSql, "SELECT BETTER_ADVICE_YMD FROM NORMAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' AND BETTER_ADVICE_DEGREE = '%s' "
		,g_szCHK_EXEC_NUM, m_szBETTER_ADVICE_DEGREE, 0   );
		g_Sql_RetStr( szSql, 10 ,szDay );
		lDay = Str_AtoI(szDay);
		if( lDay == Time_GetDate() )
		{
			MessageBoxEx (CONFIRM_OK, "개선권고발행하여 수정 불가능 합니다.");
			bRet = FALSE;
			return bRet;	
		}
		
		return bRet;
	}
	
	
//------------------------------------------------------------------------------------------
	bool Save_BetterEnd(void)
	{
		bool bRet = TRUE;
		char sztmp[401];
		char szSql[401];
		char szdate[20];
		char szBetter[20];
		long lCnt, idx;
		long d,k;
		long lBETTER_ADVICE_DEGREE;
		long lChkFlag = 0;		//개선완료 쿼리 체크 flag , lChkFlag = 0 > 실패(오류) , lChkFlag = 1 > 성공
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();		
		
		Mem_Set( (byte*)m_szBETTER_ADVICE_DEGREE, 0x00, sizeof(m_szBETTER_ADVICE_DEGREE) );
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "SELECT MAX( BETTER_ADVICE_DEGREE) FROM NORMAL_NOGOOD_CHA  WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( sztmp, 3 ,m_szBETTER_ADVICE_DEGREE );
		
		//차수가 10보다 작으면 앞에 0을 빼고 저장한다.
		lBETTER_ADVICE_DEGREE = Str_AtoI(m_szBETTER_ADVICE_DEGREE);
		if( lBETTER_ADVICE_DEGREE > 0 && lBETTER_ADVICE_DEGREE < 10 )
		{
			Str_Chg(m_szBETTER_ADVICE_DEGREE, STRCHG_CONV_ZERO_TO_SPACE);
			Str_Chg(m_szBETTER_ADVICE_DEGREE, STRCHG_DEL_NONDIGIT);
		}
		

/*
		Str_Cpy( m_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
		Str_Cpy( m_szBURNER_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
		Str_Cpy( m_szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));
		Str_Cpy( m_szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));
*/
		
		hdb = sql->Open(sql);
		if( hdb == NULL ) 	
		{
			bRet = FALSE;
			goto Finally;
		}
		
		
		hstmt = sql->CreateStatement(sql, " UPDATE NORMAL_NOGOOD_DETAL \
SET  BETTER_PLAN_YMD=?, BETTER_END_YMD= ?, BETTER_DEGREE=?, BETTER_YN ='Y', SEND_YN = 'S', PDA_IP = ?, UPD_EMPID = ? \
WHERE CHK_EXEC_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD= ? AND MTR_NUM=? AND BURNER_NUM =? " );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)m_szEndDate               ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szEndDate               ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szBETTER_ADVICE_DEGREE  ,1 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip       ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,20,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM          ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szCHK_SEC_CD		     ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szNOT_PASS_ITEM_CD	     ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szMTR_NUM               ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szBURNER_NUM            ,2 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			lChkFlag = 0;
		
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}
		else
		{
			lChkFlag = 1;
			
			if( MessageBoxEx (CONFIRM_YESNO, "개선사진을 촬영 하시겠습니까?") == MB_OK )
			{
				Shoto_Photo();
			}	
		}	
	
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( lChkFlag == 1 )
		{
			Save_BetterYn();
		}
		
		return bRet;
	}

//------------------------------------------------------------------------------------------ 
	void Save_BetterYn(void)
	{
		char szSql[500];
		char szTmp[100];
		char szToday[10];
		char szBetter[3];
		char szEndYmd[10];
		long idx;
		long lCnt = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL)",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );

		Mem_Set( (byte*)szBetter, 0x00, sizeof(szBetter) );
		Mem_Set( (byte*)szEndYmd, 0x00, sizeof(szEndYmd) );
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		if( lCnt > 0 )
		{
			Str_Cpy(szBetter, "N");
			Str_Cpy(szEndYmd, "");
		}
		else
		{
			Str_Cpy(szBetter, "Y");
			Str_ItoA(Time_GetDate(), szEndYmd, 10);
		}
/*
		if( lCnt > 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_NOGOOD_CHA SET BETTER_YN = 'N' WHERE BETTER_ADVICE_DEGREE = '%s' "
			,m_szBETTER_ADVICE_DEGREE, 0, 0   );
			
			g_Sql_DirectExecute( szSql );
		}
		else
		{
			Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
			Str_ItoA(Time_GetDate(), szToday, 10);
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "UPDATE NORMAL_NOGOOD_CHA SET BETTER_END_YMD = '%s', BETTER_YN = 'Y', SEND_YN='S', PDA_IP = '%s', UPD_EMPID = '%s' "
			, szToday, stUserinfo.szpda_ip, stUserinfo.szemployee_id   );
			SPRINT(szTmp, "WHERE BETTER_ADVICE_DEGREE = '%s' ", m_szBETTER_ADVICE_DEGREE, 0, 0);
			Str_Cat(szSql, szTmp);

			g_Sql_DirectExecute( szSql );
		}
*/

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE NORMAL_NOGOOD_CHA SET BETTER_YN = ?, BETTER_END_YMD = ?, UPD_EMPID = ?, PDA_IP = ?, SEND_YN = 'S' \
		WHERE CHK_EXEC_NUM = ? AND \
		BETTER_ADVICE_DEGREE = (SELECT MAX( BETTER_ADVICE_DEGREE) FROM NORMAL_NOGOOD_CHA  WHERE CHK_EXEC_NUM = ?)  "
		, 0, 0, 0   );

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)szBetter                 ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szEndYmd                 ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id  ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		,32,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM         ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM         ,12,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}


//------------------------------------------------------------------------------------------ 
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;
				
		if( m_lActive < 0 )
		{
			MessageBoxEx (ERROR_OK, "항목을 선택하세요.");
			return;
		}

/*
		//파일명
		Mem_Set((byte*)szMTR_NUM, 0x00, sizeof(szMTR_NUM));
		Mem_Set((byte*)szBURNER_NUM, 0x00, sizeof(szBURNER_NUM));
		Mem_Set((byte*)szCHK_SEC_CD, 0x00, sizeof(szCHK_SEC_CD));
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );

		Str_Cpy( szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
		Str_Cpy( szBURNER_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
		Str_Cpy( szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));
*/
		
		Str_Cpy(m_szfilenm , "2");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , g_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(m_szMTR_NUM) > 0)
			Str_Cat(m_szfilenm , m_szMTR_NUM);
		else
			Str_Cat(m_szfilenm , "000000000");
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(m_szBURNER_NUM) > 0)
			Str_Cat(m_szfilenm , m_szBURNER_NUM);
		else
			Str_Cat(m_szfilenm , "000000");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , m_szCHK_SEC_CD);
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , m_szNOT_PASS_ITEM_CD);
		Str_Cat(m_szfilenm , ".jjp");
		
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_nPhotoFlag = 2;
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_SC,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//원본파일
			//Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_SC, m_szfilenm,  0);
			//에뮬에서 확인시...
			//Str_Cpy(szScrPht, szfilenm);
			//ShootPhoto ( 1, 0, m_szfilenm );

			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				//2017-08-18 Sanghyun Lee
				//카메라 화질 설정(photo_quality)	
				//"MEDIA_QUALITY_AUTO" ->> 에러 발생, 필요X
				//"MEDIA_QUALITY_LOWEST"
				//"MEDIA_QUALITY_LOW" ->> 선택되는 화질이 없음 , 필요X
				//"MEDIA_QUALITY_MEDIUM" ->> 현재 사용중인버전
				//"MEDIA_QUALITY_HIGH"
				//"MEDIA_QUALITY_HIGHEST"
				JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_MEDIUM");

				//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
				JSON_SetValue	(hdata	, 'C', "position_info"		, " ");
				JSON_SetValue	(h		, 'C', "method"				, "CameraActivity");
				
				JSON_Attach 	(h		, "data"					, hdata);
			
				System_Call		("Native_System_Call" , JSON_toString(h));
			}
			
			Finally:
		
			if (h)
			{
				JSON_Finalize(h);
			}	
		
			if (hdata)
			{
				JSON_Finalize(hdata);
			}	
		}
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		
		//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);
		CloseMessageBox();
		
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_CAMERA )
			{
				Mem_Set((byte*)szPhotopath, 0x00, sizeof(szPhotopath));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				szPath = (char*)System_GetResult((char*)&nRet);
				nLen = Str_Len(szPath);
				if( nLen > 19 )
				{
					Mem_Cpy((byte *)szTmp, (byte *)szPath+19, nLen-19);
					Str_Cpy(szPhotopath, "..");
					Str_Cat(szPhotopath, szTmp);
					//PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
					//원본파일 +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_SC,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					ON_DRAW();
					MessageBoxEx(MESSAGE, "사진을 저장중입니다.");
				}
			}
		}

		ON_DRAW();
		return;
	}

//------------------------------------------------------------------------------------------ 
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				if( FFS_Exist(szfilenm)  )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h에 정의되어있음
					ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);

					VmSleep(100);
					FFS_Delete( szfilenm );
				}
			}
		}
	}

	void Photo_View(void)
	{
	char sztmp[256];
/*	char szfilenm[256];
	char szNOT_PASS_ITEM_CD[3];
		
		Mem_Set((byte*)szfilenm ,0x00, sizeof(szfilenm) );
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2) );
		SPRINT (szfilenm, "%s_%s_%s.jjp",stScNogood.CHK_EXEC_NUM ,stScNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT (sztmp, "%s\\%s\\%s", FFS_GetWorkDir(), DIR_PHOTO, szfilenm);
		
		if(Str_Cmp(g_szDEVICE_NAME, "DS3") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 ) //PDA
		{
			if( FFS_Exist("\\windows\\iexplore.exe" ) )
			{
				RunApp( "iexplore.exe", szfilenm);
			}
			else if( FFS_Exist("\\windows\\iesample.exe" ) )
			{
				RunApp( "iesample.exe", szfilenm);
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "사진조회 프로그램이 없습니다.");
			}
			
		}
		else
		{		
			RunApp( "WEBVIEWER", sztmp);
		}	*/
	}
	
//-------------------------------------------------------------------------------------------------
//액티브된 row  유지
	void SetActRow(void)
	{
		char szDate[12];
		char szYear[5];
		char szMonth[4];
		char szDay[4];
	
		if( m_lActive == -1 )
		{
			m_lActive = 0;
		}
		
		Mem_Set((byte*)szDate ,0x00, sizeof(szDate) );
		Mem_Set((byte*)szYear ,0x00, sizeof(szYear) );
		Mem_Set((byte*)szMonth ,0x00, sizeof(szMonth) );
		Mem_Set((byte*)szDay ,0x00, sizeof(szDay) );
		
		DlgTbl_SetActive(ID_TBLLIST , m_lActive+1 );
		DlgTbl_SetRowColor(ID_TBLLIST, m_lActive+1, TABLEACTIVE_COLOR);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 6));
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));
		
		Str_Cpy(szDate, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));
		Str_Chg( szDate, STRCHG_DEL_NONDIGIT);
		Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
		Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);

		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 7));

		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 8));
		
		Mem_Set( (byte*)m_szCHK_SEC_CD, 0x00, sizeof(m_szCHK_SEC_CD) );
		Mem_Set( (byte*)m_szNOT_PASS_ITEM_CD, 0x00, sizeof(m_szNOT_PASS_ITEM_CD) );
		Mem_Set( (byte*)m_szMTR_NUM, 0x00, sizeof(m_szMTR_NUM) );
		Mem_Set( (byte*)m_szBURNER_NUM, 0x00, sizeof(m_szBURNER_NUM) );
		
		Str_Cpy( m_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
		Str_Cpy( m_szBURNER_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
		Str_Cpy( m_szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));
		Str_Cpy( m_szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));

	}
	
//-------------------------------------------------------------------------------------------------
	void ReformDraw(void)
	{
		char szYear[5];
		char szMonth[3];
		char szDay[3];
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
		
		//기본 오늘 날짜 셋팅
		Mem_Set((byte*)m_szEndDate ,0x00, sizeof(m_szEndDate) );
		Str_ItoA(Time_GetDate(), m_szEndDate, 10);
		
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)m_szEndDate, 4);
		Mem_Cpy((byte *)szMonth, (byte *)m_szEndDate+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)m_szEndDate+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szDay );		
		//g_Str_DateType( szDay, szTmp );
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), szDay);
	}
}


