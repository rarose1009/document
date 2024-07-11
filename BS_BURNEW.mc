/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_BURNEW
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
//보일러
		DEF_BUTTON_ID ( BID_SAVE )
		DEF_BUTTON_ID ( BID_SCHDL )
		DEF_BUTTON_ID ( BID_WRITE1 )
		DEF_BUTTON_ID ( BID_WRITE2 )
		DEF_BUTTON_ID ( BID_WORKFIRM )
//연소기
		DEF_BUTTON_ID ( BID_SAVE2 )
		DEF_BUTTON_ID ( BID_SCHDL2 )
		DEF_BUTTON_ID ( BID_WRITE3 )
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
		DEF_OBJECT_ID ( TXT_TITLE )
//보일러
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
		DEF_OBJECT_ID ( TXT_DATA34 )
		DEF_OBJECT_ID ( TXT_DATA35 )
		DEF_OBJECT_ID ( TXT_DATA36 )
		DEF_OBJECT_ID ( TXT_DATA37 )
		DEF_OBJECT_ID ( TXT_DATA38 )
		
//연소기신규등록
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA29 )
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
		DEF_OBJECT_ID ( TXT_DATA32 )
		DEF_OBJECT_ID ( TXT_DATA33 )
		DEF_OBJECT_ID ( TXT_DATA39 )
		DEF_OBJECT_ID ( TXT_DATA40 )
		DEF_OBJECT_ID ( TXT_DATA41 )
		DEF_OBJECT_ID ( TXT_DATA42 )
//보일러
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )
		DEF_OBJECT_ID ( EDT_DATA8 )
		
//연소기신규등록
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA9 )
		DEF_OBJECT_ID ( EDT_DATA10 )
		DEF_OBJECT_ID ( EDT_DATA11 )

		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

//보일러
		DEF_OBJECT_ID ( CMB_DATA1 ) 					//
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA5+3 ) 		//
//연소기
		DEF_OBJECT_ID ( CMB_DATA7 = CMB_DATA6+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA8 = CMB_DATA7+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA9 = CMB_DATA8+3 ) 		//
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	 1
	#define INIT_BURNEW   2
	
	long m_lEditCtrlIndex = -1;
	long m_bFirst;
	
	SQLITE m_sql = NULL;
	handle m_hdb = NULL;
	handle m_hstmt = NULL;


	void SetStyle(void);
	void SetCombo(void);
	void INST_DRAW(void);		//설치업체 관련 자료 디스플레이
	bool Save_BoilNew(void);	//신규 보일러
	bool Save_BurnNew(void);	//신규 연소기
	bool Validate(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	void SetBtnImg(void);
	void QuickList(void);
	void OnList(quad lParam);
	long Sql_SetCombo(char* szSql, long CTRLID );
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "보일러 신규등록"),

		DLG_BUTTON(STARTX+200, STARTY+750, 600, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "저장"),
		
		DLG_TEXT(STARTX, 	 STARTY+65 , 300, 45, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA1, "연소기번호"),
		DLG_TEXT(STARTX+300, STARTY+65 , 700, 45, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTGRAY,	TXT_DATA24, ""),	//연소기는 자동 으로+1되서 추가
		DLG_TEXT(STARTX, 	 STARTY+110, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA2, "종류"),

		DLG_TEXT(STARTX, 	 STARTY+160, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA4, "모델명"),
		DLG_BUTTON(STARTX+300,STARTY+160 , 700, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),
		DLG_TEXT( STARTX+300,STARTY+160 , 700, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1,   ""),

		DLG_TEXT(STARTX, 	 STARTY+210, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA5, "용량"),
		DLG_EDIT( STARTX+300,STARTY+210 , 300, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),

		DLG_TEXT(STARTX, 	 STARTY+260, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA6, "제조사명"),		
		DLG_TEXT(STARTX, 	 STARTY+310, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "설치일자"),
		//DLG_TEXT(STARTX+300, STARTY+310, 525, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),	//설치일자
		//DLG_BUTTON(STARTX+825,STARTY+310, 150, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),
		DLG_EDIT( STARTX+300,  STARTY+310, 200, 50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_TEXT(STARTX+500,   STARTY+310, 18, 20, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX+500,   STARTY+330, 18, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA36, "."),
		DLG_EDIT( STARTX+518,  STARTY+310, 145, 50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 2,  ""),
		DLG_TEXT(STARTX+663,   STARTY+310, 17, 20, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX+663,   STARTY+330, 17, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA38, "."),
		DLG_EDIT( STARTX+680,  STARTY+310, 145, 50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY+310, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "▼"),
		
		DLG_TEXT(STARTX, 	 STARTY+360, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA8, "설치위치"),
		DLG_TEXT(STARTX, 	 STARTY+410, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA9, "형식"),

		DLG_TEXT(STARTX, 	 STARTY+460, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA10, "제조번호"),
		DLG_BUTTON(STARTX+300,STARTY+460 , 700, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE2,  ""),
		DLG_TEXT( STARTX+300,STARTY+460 , 700, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3,   ""),

		DLG_TEXT(STARTX, 	 STARTY+510, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA11, "설치업체"),
		DLG_TEXT( STARTX+300, STARTY+510 , 525, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CMB_DATA6,  ""),
		DLG_BUTTON(STARTX+825, STARTY+510, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_WORKFIRM, "▼"),

		DLG_TEXT(STARTX, 	 STARTY+560, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA12, "대표자명"),
		DLG_TEXT(STARTX+300, STARTY+560, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX,	 STARTY+610, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA13, "면허번호"),
		DLG_TEXT(STARTX+300, STARTY+610, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX, 	 STARTY+660, 250, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA14, "전화번호"),
		DLG_TEXT(STARTX+250, STARTY+660, 220, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+470, STARTY+660, 50 , 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 	TXT_DATA15, "-"),
		DLG_TEXT(STARTX+520, STARTY+660, 220, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+740, STARTY+660, 50 , 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 	TXT_DATA16, "-"),
		DLG_TEXT(STARTX+790, STARTY+660, 210, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		
		DLG_COMBO (STARTX+300, STARTY+110, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),		
		DLG_COMBO (STARTX+600, STARTY+210, 400, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),		
		DLG_COMBO (STARTX+300, STARTY+260, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 30),
		DLG_COMBO (STARTX+300, STARTY+360, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
		DLG_COMBO (STARTX+300, STARTY+410, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 30),
		
		//DLG_COMBO (STARTX+300, STARTY+510, 675, 290, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 30),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "보일러 신규등록"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+200, STARTY+780, 600, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "저장"),
		
		DLG_TEXT(STARTX, 	  STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA1, "연소기번호"),
		DLG_TEXT(STARTX+300,  STARTY-40, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTGRAY,	TXT_DATA24, ""),	//연소기는 자동 으로+1되서 추가
		DLG_TEXT(STARTX, 	  STARTY+30, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA2, "종류"),
		DLG_TEXT(STARTX, 	  STARTY+90, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA4, "모델명"),
		DLG_EDIT( STARTX+300,   STARTY+90, 700, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 20,  ""),
		DLG_TEXT(STARTX, 	 STARTY+150, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA5, "용량"),
		DLG_EDIT( STARTX+300,  STARTY+150, 300, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_TEXT(STARTX, 	 STARTY+210, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA6, "제조사명"),
		
		DLG_TEXT(STARTX, 	 STARTY+270, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "설치일자"),
		DLG_EDIT( STARTX+300,  STARTY+270, 200, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_TEXT(STARTX+500,   STARTY+270, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX+500,   STARTY+300, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA36, "."),
		DLG_EDIT( STARTX+520,  STARTY+270, 145, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 2,  ""),
		DLG_TEXT(STARTX+665,   STARTY+270, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX+665,   STARTY+300, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA38, "."),
		DLG_EDIT( STARTX+685,  STARTY+270, 145, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 2,  ""),
		DLG_BUTTON(STARTX+830, STARTY+270, 170, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "▼"),
		//DLG_TEXT(STARTX+300, STARTY+270, 525, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),	//설치일자
		//DLG_BUTTON(STARTX+825,STARTY+270, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),
		
		DLG_TEXT(STARTX, 	 STARTY+330, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA8, "설치위치"),
		DLG_TEXT(STARTX, 	 STARTY+390, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA9, "형식"),
		DLG_TEXT(STARTX, 	 STARTY+450, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA10, "제조번호"),
		DLG_EDIT( STARTX+300,  STARTY+450, 700, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),
		DLG_TEXT(STARTX, 	 STARTY+510, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA11, "설치업체"),
		DLG_TEXT(STARTX, 	 STARTY+570, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA12, "대표자명"),
		DLG_TEXT(STARTX+300, STARTY+570, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX,	 STARTY+630, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA13, "면허번호"),
		DLG_TEXT(STARTX+300, STARTY+630, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX, 	 STARTY+690, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA14, "전화번호"),
		DLG_TEXT(STARTX+250, STARTY+690, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+455, STARTY+690, 50 , 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 	TXT_DATA15, "-"),
		DLG_TEXT(STARTX+505, STARTY+690, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+715, STARTY+690, 50 , 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 	TXT_DATA16, "-"),
		DLG_TEXT(STARTX+765, STARTY+690, 235, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		
		DLG_COMBO (STARTX+300,  STARTY+30, 700, 290, 170, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),		
		DLG_COMBO (STARTX+600, STARTY+150, 400, 290, 170, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),		
		DLG_COMBO (STARTX+300, STARTY+210, 700, 290, 170, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 30),
		DLG_COMBO (STARTX+300, STARTY+330, 700, 290, 170, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
		DLG_COMBO (STARTX+300, STARTY+390, 700, 290, 170, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 30),
		DLG_COMBO (STARTX+300, STARTY+510, 700, 290, 170, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 30),

	};	
	
	//  다이얼로그:연소기신규등록
	//---------------------------------------------------------------
	DlgObject	DlgRes_BURNEW[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "연소기 신규등록"),

		DLG_BUTTON(STARTX+600,  STARTY+550, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE2,  "저장"),
		
		DLG_TEXT ( STARTX,       STARTY+65, 330, 75, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "연소기번호"),
		DLG_TEXT ( STARTX+330,   STARTY+65, 670, 75, 0,0, 			 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTGRAY, TXT_DATA27, ""),
		DLG_TEXT ( STARTX,	    STARTY+140, 330, 70, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "종류"),
		DLG_TEXT ( STARTX,	    STARTY+210, 330, 70, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, "모델명"),
		DLG_BUTTON(STARTX+330,	STARTY+210, 670, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE3,  ""),
		DLG_TEXT ( STARTX+330,	STARTY+210, 670, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4,   ""),
		DLG_TEXT ( STARTX,	    STARTY+280, 330, 70, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "용량"),
		DLG_EDIT ( STARTX+330,	STARTY+280, 300, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 10,  ""),
		DLG_TEXT ( STARTX,      STARTY+350, 330, 70, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA31, "제조사명"),
		
		DLG_TEXT ( STARTX,      STARTY+420, 330, 70, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, "설치일자"),
		//DLG_TEXT ( STARTX+330,  STARTY+420, 495, 70, 0,0, 			 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		//DLG_BUTTON(STARTX+825,  STARTY+420, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL2,  "▼"),
		DLG_EDIT( STARTX+330,  STARTY+420, 170, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 4,  ""),
		DLG_TEXT(STARTX+500,   STARTY+420, 18, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX+500,   STARTY+460, 18, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA40, "."),
		DLG_EDIT( STARTX+518,  STARTY+420, 145, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 2,  ""),
		DLG_TEXT(STARTX+663,   STARTY+420, 17, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX+663,   STARTY+460, 17, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA42, "."),
		DLG_EDIT( STARTX+680,  STARTY+420, 145, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY+420, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL2, "▼"),

		DLG_COMBO (STARTX+330,  STARTY+140, 670, 200, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 10),
		DLG_COMBO (STARTX+630,  STARTY+280, 370, 200, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA8, 10),
		DLG_COMBO (STARTX+330,  STARTY+350, 670, 200, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA9, 10),
	};
	
	//  다이얼로그:연소기신규등록
	//---------------------------------------------------------------
	DlgObject	DlgRes_BURNEW_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "연소기 신규등록"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+670,  STARTY+550, 300, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE2,  "저장"),
		
		DLG_TEXT ( STARTX,       STARTY-40, 330, 80, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "연소기번호"),
		DLG_TEXT ( STARTX+330,   STARTY-40, 670, 80, 0,0, 			 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTGRAY, TXT_DATA27, ""),
		DLG_TEXT ( STARTX,	     STARTY+40, 330, 80, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "종류"),
		DLG_TEXT ( STARTX,	    STARTY+120, 330, 80, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, "모델명"),
		DLG_EDIT ( STARTX+330,	STARTY+120, 670, 80, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 20,  ""),
		DLG_TEXT ( STARTX,	    STARTY+200, 330, 80, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "용량"),
		DLG_EDIT ( STARTX+330,	STARTY+200, 300, 80, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 10,  ""),
		DLG_TEXT ( STARTX,      STARTY+280, 330, 80, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA31, "제조사명"),
		
		DLG_TEXT ( STARTX,     STARTY+360, 330, 80, 0,0, 			 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, "설치일자"),
		DLG_EDIT( STARTX+330,  STARTY+360, 170, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 4,  ""),
		DLG_TEXT(STARTX+500,   STARTY+360, 20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX+500,   STARTY+400, 20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA40, "."),
		DLG_EDIT( STARTX+520,  STARTY+360, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 2,  ""),
		DLG_TEXT(STARTX+670,   STARTY+360, 20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX+670,   STARTY+400, 20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA42, "."),
		DLG_EDIT( STARTX+690,  STARTY+360, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11, 2,  ""),
		DLG_BUTTON(STARTX+840, STARTY+360, 160, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL2, "▼"),
		//DLG_TEXT ( STARTX+330,  STARTY+350, 495, 70, 0,0, 			 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		//DLG_BUTTON(STARTX+825,  STARTY+350, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL2,  "▼"),
		
		DLG_COMBO (STARTX+330,   STARTY+40, 670, 200, 160, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 10),
		DLG_COMBO (STARTX+630,  STARTY+200, 370, 200, 160, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA8, 10),
		DLG_COMBO (STARTX+330,  STARTY+280, 670, 200, 160, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA9, 10),
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
		long lRowid;
		char szSql[300];
		char szWork_Firm[30];
		
		if( m_bFirst == INIT_MAIN )
		{
			i = lParam+1;
			// PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
			if( i > 0 )
			{			
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szWork_Firm, 0x00, sizeof(szWork_Firm) );
				SPRINT(szSql, "SELECT WORK_FIRM FROM BO_INST WHERE ROWID = '%d' ORDER BY CAST(SEQ AS INTEGER)", i, 0, 0   );
				g_Sql_RetStr( szSql, 20, szWork_Firm );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA6), szWork_Firm );
				
				INST_DRAW(); // 설치업체 정보
			}
		}
		
		return;
	}

	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
	void	OnInit(char bFirst)
	{
		if( g_lNewBurFlag == 1 )
		{
			bFirst = INIT_MAIN;
		}
		else
		{
			bFirst = INIT_BURNEW;
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				break;
			case INIT_BURNEW:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_BURNEW_P, SIZEOF(DlgRes_BURNEW_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_BURNEW, SIZEOF(DlgRes_BURNEW));
						break;
				}
				SetBtnImg();
				SetStyle();
				SetCombo();
				break;
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

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szToday[11];
	
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE);

/*
			Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szToday, 10);
			Str_Cpy(stBsBur.BURNER_INST_YMD, szToday);
			g_Str_DateType(szDate, szToday);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), szDate );
*/
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Str_ItoA(Time_GetDate(), szToday, 10);
			Str_Cpy(stBsBur.BURNER_INST_YMD, szToday);
			Mem_Cpy((byte *)szYear, (byte *)stBsBur.BURNER_INST_YMD, 4);
			Mem_Cpy((byte *)szMonth, (byte *)stBsBur.BURNER_INST_YMD+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)stBsBur.BURNER_INST_YMD+6, 2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA7), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA8), szDay );
		}
		else if( m_bFirst == INIT_BURNEW)
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA10), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA11), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
/*
			Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szToday, 10);
			Str_Cpy(stBsBur.BURNER_INST_YMD, szToday);
			g_Str_DateType(szDate, szToday);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA33), szDate );
*/
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Str_ItoA(Time_GetDate(), szToday, 10);
			Str_Cpy(stBsBur.BURNER_INST_YMD, szToday);
			Mem_Cpy((byte *)szYear, (byte *)stBsBur.BURNER_INST_YMD, 4);
			Mem_Cpy((byte *)szMonth, (byte *)stBsBur.BURNER_INST_YMD+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)stBsBur.BURNER_INST_YMD+6, 2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA9), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA10), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA11), szDay );
		}
	}


//------------------------------------------------------------------

	long Sql_SetCombo(char* szSql, long CTRLID )
	{
		long ret = -1;
		char szBuf[101];
		long cnt  = 0;
		SQLITE sql = m_sql;

		m_hstmt = sql->CreateStatement(sql, szSql);
		if( m_hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		sql->Begin(sql);

		ret = sql->Execute(sql);

		cnt = 0;
		while(sql->Next(sql) == TRUE)
		{
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)szBuf, sizeof(szBuf), DECRYPT );
			ListCtrl_AddItem (Get_hDlgCtrlByID(CTRLID), szBuf, 0, ICON_NONE);
			cnt++;
			if(cnt == 100)
				break;
		}
		
Finally:
		return ret;
	}

//------------------------------------------------------------------
	void SetCombo(void)
	{	
		char szSql[300];
		long i;

		m_sql = NewSqLite();
		if (m_sql == NULL)
		{
			goto Finally;
		}

		m_hdb = m_sql->Open(m_sql);
		if( m_hdb == NULL )
		{
			goto Finally;
		}
		
		if( m_bFirst == INIT_MAIN )			//보일러
		{
			//종류
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM IN (201, 301)",0, 0, 0   );		
			Sql_SetCombo(szSql, CMB_DATA1+2);
					
			//용량단위
			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
			//제조사명
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			//SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY CAST(TEL_NUM AS NUMERIC) ASC ",0, 0, 0   );
			SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ",0, 0, 0);
			Sql_SetCombo(szSql, CMB_DATA3+2);
			
			//위치
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30028' ",0, 0, 0   );
			Sql_SetCombo(szSql, CMB_DATA4+2);
			
			//형식
			for ( i = 0 ;  SCBOIL_FORM[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA5+2), SCBOIL_FORM[i].Str, 0, ICON_NONE);
			}
			
			//설치업체
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				g_Sql_SetCombo("SELECT WORK_FIRM FROM BO_INST LIMIT 0, 200 ", CMB_DATA6+2);
			}
		}
		else if( m_bFirst == INIT_BURNEW )		//연소기
		{
			//종류
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM NOT IN ('201', '301') ORDER BY BURNER_KIND_NM",0, 0, 0   );		
			Sql_SetCombo(szSql, CMB_DATA7+2);
			
			//용량단위
			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA8+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
			
			//제조사명
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			//SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY MAKER_NM  ",0, 0, 0   );
			SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BURNER_SEQ ",0, 0, 0);
			Sql_SetCombo(szSql, CMB_DATA9+2);
		}
		
Finally:

		if(m_sql != NULL)
			m_sql->Commit(m_sql);
		
		DelSqLite(m_sql);
		return;
	}


/*
//2016-10-24 Sanghyun Lee
//SQL OPEN/CLOSE 통합 전 코드
//------------------------------------------------------------------
	void SetCombo(void)
	{	
		char szSql[300];
		long i;
		
		if( m_bFirst == INIT_MAIN )			//보일러
		{
			//종류
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM IN (201, 301)",0, 0, 0   );		
			g_Sql_SetCombo(szSql, CMB_DATA1+2);
					
			//용량단위
			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
			//제조사명
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			//SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY CAST(TEL_NUM AS NUMERIC) ASC ",0, 0, 0   );
			SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ",0, 0, 0);
			g_Sql_SetCombo(szSql, CMB_DATA3+2);
			
			//위치
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30028' ",0, 0, 0   );
			g_Sql_SetCombo(szSql, CMB_DATA4+2);
			
			//형식
			for ( i = 0 ;  SCBOIL_FORM[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA5+2), SCBOIL_FORM[i].Str, 0, ICON_NONE);
			}
			
			//설치업체
			//g_Sql_SetCombo("SELECT WORK_FIRM FROM BO_INST LIMIT 0, 200 ", CMB_DATA6+2);
		}
		else if( m_bFirst == INIT_BURNEW )		//연소기
		{
			//종류
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM NOT IN ('201', '301') ORDER BY BURNER_KIND_NM",0, 0, 0   );		
			g_Sql_SetCombo(szSql, CMB_DATA7+2);
			//용량단위
			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA8+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
			//제조사명
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			//SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY MAKER_NM  ",0, 0, 0   );
			SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BURNER_SEQ ",0, 0, 0);
			g_Sql_SetCombo(szSql, CMB_DATA9+2);
		}
	}
*/

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char sztmp[20];
	
		switch(ID)
		{
			case BID_WORKFIRM:
				QuickList();
				break;

			case BID_SCHDL:
				ShowSip(FALSE);
				g_Sipflag = 0;

				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
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
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Str_ItoA( d, szDate, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
					Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA7), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA8), szDay );
				}
				break;
			case BID_WRITE1:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;	
			case BID_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA3), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
				break;	
			case BID_WRITE3:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA4), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );
				break;

			case BID_SAVE:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( Save_BoilNew() )
				{
					Card_Move("BS_MTRINFO");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "특정점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
	
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
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
				ShowSip(FALSE);
				g_Sipflag = 0;

				Card_Move("BS_MTRINFO");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Exit_DelBsData();
					return;
				}
				g_Exit();
				return;
//연소기 신규등록
			case BID_SCHDL2:
				ShowSip(FALSE);
				g_Sipflag = 0;

				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)));
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
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Str_ItoA( d, szDate, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
					Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA9), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA10), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA11), szDay );
				}
				break;
			case BID_SAVE2:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Save_BurnNew() )
				{
					Card_Move("BS_MTRINFO");
				}
				break;
		}
	}
	
//------------------------------------------------------------------
	void	OnSelect(long Index)
	{
			if( (theDevInfo.m_nType == FAMILY_PDA) && (m_bFirst == INIT_MAIN) )
			{
				INST_DRAW();		//설치업체 정보
			}
	}	
	
//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];

		//숫자만 입력 가능
		if( m_bFirst == INIT_MAIN )
		{
			if((Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA7) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA8) == m_lEditCtrlIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
			
			if( Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA6)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA7));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA7)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA8));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA8), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}

			ON_DRAW();
			return;
		}
		else if( m_bFirst == INIT_BURNEW )
		{
			if((Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA9) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA10) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA11) == m_lEditCtrlIndex )
			 && (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
			
			if( Get_iDlgCtrlByID(EDT_DATA9) == m_lEditCtrlIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA9)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA10));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA10)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA11) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA9), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA10), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA11), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA9));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
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
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+600) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+260) ||
						X > DMS_X(STARTX+300) && X < DMS_X(STARTX+500) && Y > DMS_Y(STARTY+310) && Y < DMS_Y(STARTY+360) ||
						X > DMS_X(STARTX+518) && X < DMS_X(STARTX+663) && Y > DMS_Y(STARTY+310) && Y < DMS_Y(STARTY+360) ||
						X > DMS_X(STARTX+680) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY+310) && Y < DMS_Y(STARTY+360) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex )
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
				}
				else if( theDevInfo.m_nType == FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+90) && Y < DMS_Y(STARTY+150) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+450) && Y < DMS_Y(STARTY+510) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
				
				ON_DRAW();
			}
		}
		else if( m_bFirst == INIT_BURNEW )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
			
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+330) && X < DMS_X(STARTX+630) && Y > DMS_Y(STARTY+280) && Y < DMS_Y(STARTY+450) )
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
					else if( X > DMS_X(STARTX+330) && X < DMS_X(STARTX+500) && Y > DMS_Y(STARTY+420) && Y < DMS_Y(STARTY+490) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA9) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+518) && X < DMS_X(STARTX+663) && Y > DMS_Y(STARTY+420) && Y < DMS_Y(STARTY+490) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA10) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+680) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY+420) && Y < DMS_Y(STARTY+490) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA11) == lActiveIndex )	
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
				}
				else if( theDevInfo.m_nType == FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+330) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+140) && Y < DMS_Y(STARTY+210) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
				
				ON_DRAW();
			}
		}
		
/*
		if( m_bFirst == INIT_MAIN )
		{
			if(m_lEditCtrlIndex != lActiveIndex  )
			{
				m_lEditCtrlIndex = lActiveIndex;
				if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )			
				{
					ShowSip(TRUE);
					g_Sipflag = 1;
				}
				else
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
			}
		}
		else if( m_bFirst == INIT_BURNEW )
		{
			if(m_lEditCtrlIndex != lActiveIndex  )
			{
				m_lEditCtrlIndex = lActiveIndex;
				if( Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex )			
				{
					ShowSip(TRUE);
					g_Sipflag = 1;
				}
				else
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
			}
		}
*/
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
				return i;
		}
		
		return -1;
	}
	
//------------------------------------------------------------------
	void INST_DRAW(void)
	{
		long i, idx;
		char szWork_Firm[300];
		char sztmp[300];
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szWork_Firm, 0x00, sizeof(szWork_Firm));
		Str_Cpy(szWork_Firm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)));
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		//BURNER_KIND_NUM = 201 || 301 이면 보일러, 나머지는 연소기
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT REPRE_NM, REG_NUM1, WORK_FIRM_TEL_DDD, WORK_FIRM_TEL_EXN, WORK_FIRM_TEL_NUM \
		FROM BO_INST WHERE WORK_FIRM = ? ORDER BY BOILER_INST_FIRM_CD "
		, 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&szWork_Firm, 20, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			//대표자명
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 30+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19)   , sztmp);
			//면허번호
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 15+ 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20)   , sztmp);
			//전화_1
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 4+ 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21)   , sztmp);
			//전화_2
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 4+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22)   , sztmp);
			EditCtrl_ModifyStyle( Get_hDlgCtrlByID(TXT_DATA22), 0, EDITSTY_HIDDEN);
			//전화_1
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 4 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA23)   , sztmp);
		}
	
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		ON_DRAW();
		return;
	}

//------------------------------------------------------------------	
	bool Validate(void)
	{
		long nLen = 0;
		char sztmp[10];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szMsg[150];
	
		if( m_bFirst == INIT_MAIN )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "연소기 종류를 선택해 주세요.");
				return FALSE;
			}
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "연소기 제조사를 선택해 주세요.");
				return FALSE;
			}
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "연소기 형식을 선택해 주세요.");
				return FALSE;
			}
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "용량을 입력해주세요.");
				return FALSE;
			}
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "설치위치를 입력해주세요.");
				return FALSE;
			}
			
			Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
			Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
			if( Str_Len(sztmp) > 0 && Str_Len(sztmp) < 8 )
			{
				MessageBoxEx (CONFIRM_OK, "유효한 날짜 형식이 아닙니다.\n(ex: 2016. 01. 01)");
				return FALSE;
			}
			
			nLen = 0;
			nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			if( nLen > 20 )
			{
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				SPRINT(szMsg, "저장실패!\n(모델명은 한글 6자,\n영문,숫자 20자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szMsg);
				return FALSE;
			}
			
			nLen = 0;
			nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			if( nLen > 20 )
			{
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				SPRINT(szMsg, "저장실패!\n(제조번호는 한글 6자,\n영문,숫자 20자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szMsg);
				return FALSE;
			}
		}
		else if( m_bFirst == INIT_BURNEW )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "연소기 종류를 선택해 주세요.");
				return FALSE;
			}
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA9))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "연소기 제조사를 선택해 주세요.");
				return FALSE;
			}
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "용량을 입력해주세요.");
				return FALSE;
			}
			
			Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
			Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)));
			if( Str_Len(sztmp) > 0 && Str_Len(sztmp) < 8 )
			{
				MessageBoxEx (CONFIRM_OK, "유효한 날짜 형식이 아닙니다.\n(ex: 2016. 01. 01)");
				return FALSE;
			}
			
			nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			if( nLen > 20 )
			{
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				SPRINT(szMsg, "저장실패!\n(모델명은 한글 6자,\n영문,숫자 20자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szMsg);
				return FALSE;
			}
		}
		
		return TRUE;
	}
	
//------------------------------------------------------------------
	bool Save_BoilNew(void)
	{
		char sztmp[300];
		char szSql[300];
		long idx;
		long i;
		long lVal;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//연소기번호
		// WHERE AND SUBSTR(BURNER_NUM,0,1)= '1' -> 보일러 시작 : 1 , 연소기 시작 : 2
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(BURNER_NUM) FROM SPECIAL_BUR WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND BURNER_KIND_NUM IN (201, 301)"
		, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0   );
		g_Sql_RetInt( szSql, &lVal );
		if( lVal > 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, "SELECT MAX(BURNER_NUM)+1 AS MAX_NUM FROM SPECIAL_BUR \
			WHERE CHK_EXEC_NUM= '%s'  AND MTR_NUM= '%s' AND SUBSTR(BURNER_NUM,1,1)= '1' "
			, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0   );
			g_Sql_RetStr( szSql, 20, stBsBur.BURNER_NUM );
		}
		else
		{
			Str_Cpy(stBsBur.BURNER_NUM, "100001");
		}
		//종류
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(stBsBur.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
		SPRINT(szSql, "SELECT BURNER_KIND_NUM FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBsBur.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.BURNER_KIND_NUM );

		//보일러 분류
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NUM = '%s' AND BURNER_KIND_NUM IN ('201', '301') ", stBsBur.BURNER_KIND_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.BURNER_CLASS_CD );

		//모델명
		Str_Cpy(stBsBur.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		//용량
		Str_Cpy(stBsBur.BURNER_CAPA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
		
		//단위
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), SCBOIL_CAPA );
		if (i == -1)
			Str_Cpy(stBsBur.BURNER_CAPA_UNIT, "");
		else
			Str_Cpy(stBsBur.BURNER_CAPA_UNIT, SCBOIL_CAPA[i].Code);
		
		//제조사명 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(stBsBur.MAKER_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)));
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", stBsBur.MAKER_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.MAKER_NUM );
		
		//설치위치
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(stBsBur.INST_LOC_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)));
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30028' AND ITEM_KNAME = '%s' ", stBsBur.INST_LOC_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.INST_LOC );

		//형식
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5)), SCBOIL_FORM );
		if (i == -1)
			Str_Cpy(stBsBur.BOILER_FORM, "");
		else
			Str_Cpy(stBsBur.BOILER_FORM, SCBOIL_FORM[i].Code);
		//형식명
		i = SearchCD( stBsBur.BOILER_FORM, SCBOIL_FORM );
		Str_Cpy(stBsBur.BOILER_FORM_NM, SCBOIL_FORM[i].Str);

		//제조번호
		Str_Cpy(stBsBur.MAKE_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );

		//설치업체
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)));
		SPRINT(szSql, "SELECT BOILER_INST_FIRM_CD FROM BO_INST  where WORK_FIRM = '%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.BOILER_INST_FIRM_CD );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql,
		"INSERT INTO SPECIAL_BUR \
		 ( MTR_NUM, BURNER_NUM, CHK_EXEC_NUM, BURNER_MODEL_NM, BURNER_KIND_NM \
	     , BURNER_CAPA, BURNER_CAPA_UNIT, BURNER_INST_YMD, MAKER_NM, BOILER_FORM \
	     , MAKE_NUM, INST_LOC, INST_LOC_NM, BOILER_FORM_NM, BURNER_CLASS_CD \
	     , BURNER_KIND_NUM, MAKER_NUM, BOILER_INST_FIRM_CD, CHK_YEAR, CHK_ORDER \
		 , SPECIAL_NUM, CHK_TYPE, OBJ_YM, PLAN_YM, UPD_IP \
		 , UPD_EMPID, CHG_FLAG, SEND_YN, BUR_RSLT ) \
		 VALUES \
		 ( ?, ?, ?, ?, ? \
		 , ?, ?, ?, ?, ? \
		 , ?, ?, ?, ?, ? \
		 , ?, ?, ?, ?, ? \
		 , ?, ?, ?, ?, ? \
		 , ?, '1', 'S', 'Y')" 
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM                ,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_NUM         ,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM           ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_MODEL_NM    ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_KIND_NM     ,20,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_CAPA        ,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_CAPA_UNIT   ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_INST_YMD    ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.MAKER_NM           ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BOILER_FORM        ,20,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.MAKE_NUM           ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.INST_LOC           ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.INST_LOC_NM        ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BOILER_FORM_NM     ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_CLASS_CD    ,20,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_KIND_NUM    ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.MAKER_NUM          ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BOILER_INST_FIRM_CD,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_YEAR         	  ,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_ORDER        	  ,2 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_NUM       	  ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_TYPE        	  ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.OBJ_YM          	  ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PLAN_YM               ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,15,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,20,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "신규 저장 되었습니다!");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Save_BurnNew
	기  능 : 연소기 신규생성 디스플레이
	Param  : 
	Return : 
	========================================================================================*/	
	bool Save_BurnNew(void)
	{
		char sztmp[300];
		char szSql[300];
		long idx, i;
		long lCnt;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//연소기번호
		// WHERE AND SUBSTR(BURNER_NUM,0,1)= '1' -> 보일러 시작 : 1 , 연소기 시작 : 2
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(BURNER_NUM) FROM SPECIAL_BUR WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND BURNER_KIND_NUM NOT IN (201, 301)"
		, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0   );
		g_Sql_RetInt( szSql, &lCnt );
		if( lCnt > 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, "SELECT MAX(BURNER_NUM)+1 AS MAX_NUM FROM SPECIAL_BUR \
			WHERE CHK_EXEC_NUM= '%s'  AND MTR_NUM= '%s' AND BURNER_KIND_NUM NOT IN ('201', '301') "
			, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0   );
			g_Sql_RetStr( szSql, 20, stBsBur.BURNER_NUM );
		}
		else
		{
			Str_Cpy(stBsBur.BURNER_NUM, "200001");
		}
		//종류
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(stBsBur.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)));
		SPRINT(szSql, "SELECT BURNER_KIND_NUM FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBsBur.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.BURNER_KIND_NUM );

		//연소기 분류
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NUM = '%s' AND BURNER_KIND_NUM NOT IN ('201', '301') ", stBsBur.BURNER_KIND_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.BURNER_CLASS_CD );

		//모델명
		Str_Cpy(stBsBur.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );

		//용량
		Str_Cpy(stBsBur.BURNER_CAPA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)) );
		
		//단위
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)), SCBOIL_CAPA );
		if (i == -1)
			Str_Cpy(stBsBur.BURNER_CAPA_UNIT, "");
		else
			Str_Cpy(stBsBur.BURNER_CAPA_UNIT, SCBOIL_CAPA[i].Code);
		
		//제조사명 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(stBsBur.MAKER_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA9)));
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", stBsBur.MAKER_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBsBur.MAKER_NUM );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
		"INSERT INTO SPECIAL_BUR  \
		( MTR_NUM, BURNER_NUM, CHK_EXEC_NUM, BURNER_MODEL_NM, BURNER_KIND_NM, BURNER_CAPA \
		, BURNER_CAPA_UNIT, BURNER_INST_YMD, MAKER_NM, MAKER_NUM, BURNER_CLASS_CD, BURNER_KIND_NUM, CHK_YEAR, CHK_ORDER \
		, SPECIAL_NUM, CHK_TYPE, OBJ_YM, PLAN_YM, UPD_IP, UPD_EMPID, CHG_FLAG, SEND_YN, BUR_RSLT ) \
		  VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
			   , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
			   , '1', 'S', 'Y')" 
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM                ,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_NUM         ,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM           ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_MODEL_NM    ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_KIND_NM     ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_CAPA        ,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_CAPA_UNIT   ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_INST_YMD    ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.MAKER_NM           ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.MAKER_NUM          ,8,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_CLASS_CD    ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_KIND_NUM    ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_YEAR         	  ,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_ORDER        	  ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_NUM       	  ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_TYPE        	  ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.OBJ_YM          	  ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PLAN_YM               ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,15,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,20,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "신규 연소기가 등록되었습니다.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	
//---------------------------------------------------------------------------------------------------------------
	void QuickList(void)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}

		JSON_SetValue ( js, 'C', "title", "보일러 설치업체");
		JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
		JSON_SetValue ( js, 'C', "query", "SELECT WORK_FIRM, WORK_FIRM FROM BO_INST ORDER BY CAST( SEQ AS INTEGER)");

		sztmp = JSON_toString(js);
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return;
	}
}


