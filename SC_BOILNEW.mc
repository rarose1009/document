/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_BOILNEW
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
		DEF_BUTTON_ID ( BID_SAVE )		//
		DEF_BUTTON_ID ( BID_INST_YMD )		//
		DEF_BUTTON_ID ( BID_WRITE1 )		//
		DEF_BUTTON_ID ( BID_WRITE2 )		//
		DEF_BUTTON_ID ( BID_WORKFIRM )
		
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
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA29 )
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )

		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

		DEF_OBJECT_ID ( CMB_DATA1 ) 					//
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA5+3 ) 		//
		DEF_OBJECT_ID ( CMB_DATA7 = CMB_DATA6+3 ) 		//
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	 1
	#define INIT_BOINST  2
	

	long m_lActiveIndex = -1;
	
	SQLITE m_sql = NULL;
	handle m_hdb = NULL;
	handle m_hstmt = NULL;
	
	void SetStyle(void);
	void SetCombo(void);
	void REDRAW(void);
	void INST_DRAW(void);	//설치업체 관련 자료 디스플레이
	bool Save_BoilNew(void);	//신규 보일러
	bool Validate(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	void SetBtnImg(void);
	void QuickList(void);
	void OnList(quad lParam);
	long Sql_SetCombo(char* szSql, long CTRLID );
	void Find_Burner_Class_Cd(void);
	void Chk_Prod_Cd_Alarm(char* burclscd);
	
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

		DLG_BUTTON(STARTX+600, STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "저장"),
		
		DLG_TEXT(STARTX, 	 STARTY+65 , 300, 45, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA1, "연소기번호"),
		DLG_TEXT(STARTX+300, STARTY+65 , 700, 45, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTGRAY,	TXT_DATA24, ""),	//연소기는 자동 으로+1되서 추가
		DLG_TEXT(STARTX, 	 STARTY+110, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA2, "종류"),
		DLG_TEXT(STARTX, 	 STARTY+160, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA3, "기물번호"),
		DLG_TEXT(STARTX, 	 STARTY+210, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA4, "모델명"),
		DLG_TEXT(STARTX, 	 STARTY+260, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA5, "용량"),
		DLG_TEXT(STARTX, 	 STARTY+310, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA6, "제조사명"),
		DLG_TEXT(STARTX, 	 STARTY+410, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA8, "설치위치"),
		DLG_TEXT(STARTX, 	 STARTY+460, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA9, "형식"),
		DLG_TEXT(STARTX, 	 STARTY+510, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA10, "제조번호"),
		DLG_TEXT(STARTX, 	 STARTY+560, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA11, "설치업체"),
		DLG_TEXT(STARTX, 	 STARTY+610, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA12, "대표자명"),
		DLG_TEXT(STARTX+300, STARTY+610, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX,	 STARTY+660, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA13, "면허번호"),
		DLG_TEXT(STARTX+300, STARTY+660, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX, 	 STARTY+710, 250, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA14, "전화번호"),
		DLG_TEXT(STARTX+250, STARTY+710, 205, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+455, STARTY+710, 50 , 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 	TXT_DATA15, "-"),
		DLG_TEXT(STARTX+505, STARTY+710, 210, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+715, STARTY+710, 50 , 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 	TXT_DATA16, "-"),
		DLG_TEXT(STARTX+765, STARTY+710, 235, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX, 	 STARTY+760, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA17, "설치구분"),
		DLG_TEXT(STARTX+300, STARTY+760, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, "신규"),

		DLG_TEXT(STARTX, 	  STARTY+360, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "설치일자"),
		//DLG_TEXT(STARTX+300,  STARTY+360, 525, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),	//설치일자
		//DLG_EDIT( STARTX+300,  STARTY+360, 525, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, 10,  ""),
		DLG_EDIT( STARTX+300,  STARTY+360, 200, 50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT(STARTX+500,  STARTY+360, 18, 20, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(STARTX+500,  STARTY+380, 18, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA27, "."),
		DLG_EDIT( STARTX+518,  STARTY+360, 145, 50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_TEXT(STARTX+663,  STARTY+360, 17, 20, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA28, ""),
		DLG_TEXT(STARTX+663,  STARTY+380, 17, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA29, "."),
		DLG_EDIT( STARTX+680,  STARTY+360, 145, 50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY+360, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_INST_YMD, "▼"),
		
		DLG_BUTTON(STARTX+300,STARTY+210 , 700, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),
		DLG_TEXT( STARTX+300, STARTY+210 , 700, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1,  ""),
		
		DLG_EDIT( STARTX+300,STARTY+260 , 300, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		
		DLG_BUTTON(STARTX+300,STARTY+510 , 700, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE2,  ""),
		DLG_TEXT( STARTX+300, STARTY+510 , 700, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+110, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),		
		DLG_COMBO (STARTX+300, STARTY+160, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),		
		DLG_COMBO (STARTX+600, STARTY+260, 400, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 30),
		DLG_COMBO (STARTX+300, STARTY+310, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
		DLG_COMBO (STARTX+300, STARTY+410, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 30),
		DLG_COMBO (STARTX+300, STARTY+460, 700, 290, 175, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 30),
		
		//DLG_COMBO_DWE (STARTX+300, STARTY+560, 675, 290, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 30),
		DLG_TEXT( STARTX+300, STARTY+560 , 525, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CMB_DATA7,  ""),
		DLG_BUTTON(STARTX+825, STARTY+560, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_WORKFIRM, "▼")
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
		
		DLG_BUTTON(STARTX+200, STARTY+809, 600, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "저장"),
		
		DLG_TEXT(STARTX, 	  STARTY-40, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "연소기번호"),
		DLG_TEXT(STARTX+300,  STARTY-40, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTGRAY ,TXT_DATA24, ""),	//연소기는 자동 으로+1되서 추가
		DLG_TEXT(STARTX, 	  STARTY+20, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "종류"),
		DLG_TEXT(STARTX, 	  STARTY+75, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "기물번호"),
		DLG_TEXT(STARTX, 	 STARTY+130, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "모델명"),
		DLG_TEXT(STARTX, 	 STARTY+185, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "용량"),
		DLG_TEXT(STARTX, 	 STARTY+240, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "제조사명"),
		
		DLG_TEXT(STARTX, 	  STARTY+295, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "설치일자"),
		//DLG_TEXT(STARTX+300,   STARTY+295, 575, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),	//설치일자
		DLG_EDIT( STARTX+300, STARTY+295, 150, 55, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT(STARTX+450,  STARTY+295, 20, 25, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(STARTX+450,  STARTY+320, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA27, "."),
		DLG_EDIT( STARTX+470, STARTY+295, 155, 55, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_TEXT(STARTX+625,  STARTY+295, 20, 25, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA28, ""),
		DLG_TEXT(STARTX+625,  STARTY+320, 20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA29, "."),
		DLG_EDIT( STARTX+645, STARTY+295, 155, 55, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 2,  ""),
		DLG_BUTTON(STARTX+800,STARTY+295, 200, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_INST_YMD, "▼"),

		DLG_TEXT(STARTX, 	 STARTY+350, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "설치위치"),
		DLG_TEXT(STARTX, 	 STARTY+405, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "형식"),
		DLG_TEXT(STARTX, 	 STARTY+460, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "제조번호"),
		DLG_TEXT(STARTX, 	 STARTY+515, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "설치업체"),
		DLG_TEXT(STARTX, 	 STARTY+570, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "대표자명"),
		DLG_TEXT(STARTX+300, STARTY+570, 700, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX,	 STARTY+625, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "면허번호"),
		DLG_TEXT(STARTX+300, STARTY+625, 700, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX, 	 STARTY+680, 250, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "전화번호"),
		DLG_TEXT(STARTX+250, STARTY+680, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+455, STARTY+680, 50 , 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "-"),
		DLG_TEXT(STARTX+505, STARTY+680, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+715, STARTY+680, 50 , 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, "-"),
		DLG_TEXT(STARTX+765, STARTY+680, 235, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX, 	 STARTY+735, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "설치구분"),
		DLG_TEXT(STARTX+300, STARTY+735, 700, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, "신규"),
		
		DLG_EDIT( STARTX+300, STARTY+130, 700, 55, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1, 50,  ""),
		DLG_EDIT( STARTX+300, STARTY+185, 300, 55, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_EDIT( STARTX+300, STARTY+460, 700, 55, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA3, 30,  ""),

		DLG_COMBO (STARTX+300,  STARTY+20, 700, 290, 200, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),		
		DLG_COMBO (STARTX+300,  STARTY+75, 700, 290, 200, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),		
		DLG_COMBO (STARTX+600, STARTY+185, 400, 290, 200, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 30),
		DLG_COMBO (STARTX+300, STARTY+240, 700, 290, 200, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
		DLG_COMBO (STARTX+300, STARTY+350, 700, 290, 200, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 30),
		DLG_COMBO (STARTX+300, STARTY+405, 700, 290, 200, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 30),
		DLG_COMBO_DWE (STARTX+300, STARTY+515, 700, 290, 200, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 30),
	};		
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);

		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST && theDevInfo.m_nType > FAMILY_PDA)
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
		char szSql[150];
		char szWork_Firm[30];
		
		i = lParam+1;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > 0 )
		{			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szWork_Firm, 0x00, sizeof(szWork_Firm) );
			SPRINT(szSql, "SELECT WORK_FIRM FROM BO_INST WHERE ROWID = '%d'", i, 0, 0   );
			g_Sql_RetStr( szSql, 20, szWork_Firm );
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA7), szWork_Firm );
			
			INST_DRAW();		//설치업체 정보
		}
		
		return;
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
				SetCombo();
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
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA7), EDITALIGN_MIDDLE);
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
		char sztmp[100];
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

		//종류
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM IN (201, 301)",0, 0, 0   );		
		Sql_SetCombo(szSql, CMB_DATA1+2);
		
		//기물번호
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MTR_ID_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		Sql_SetCombo(szSql, CMB_DATA2+2);
		
		//용량단위
		for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
		}
		
		//제조사명
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		//SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY CAST(TEL_NUM AS NUMERIC) ASC ",0, 0, 0   );
		SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ",0, 0, 0);
		Sql_SetCombo(szSql, CMB_DATA4+2);
		
		//위치
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30028' ",0, 0, 0   );
		Sql_SetCombo(szSql, CMB_DATA5+2);
		
		//형식 
		for ( i = 0 ;  SCBOIL_FORM[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), SCBOIL_FORM[i].Str, 0, ICON_NONE);
		}
		
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			//설치업체
			g_Sql_SetCombo("SELECT WORK_FIRM FROM BO_INST LIMIT 0, 200 ", CMB_DATA7+2);
		}
		
Finally:

		if(m_sql != NULL)
			m_sql->Commit(m_sql);
		
		DelSqLite(m_sql);
		return;
	}

//------------------------------------------------------------------
/*
//2016-10-21 Sanghyun Lee
//SQL OPEN/CLOSE 통합 전 코드

	void SetCombo(void)
	{	
		char szSql[300];
		char sztmp[100];
		long i;

		//종류
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM IN (201, 301)",0, 0, 0   );		
		g_Sql_SetCombo(szSql, CMB_DATA1+2);
		
		//기물번호
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MTR_ID_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_SetCombo(szSql, CMB_DATA2+2);
		
		//용량단위
		for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
		}
		
		//제조사명
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		//SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY CAST(TEL_NUM AS NUMERIC) ASC ",0, 0, 0   );
		SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ",0, 0, 0);
		g_Sql_SetCombo(szSql, CMB_DATA4+2);
		
		//위치
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30028' ",0, 0, 0   );
		g_Sql_SetCombo(szSql, CMB_DATA5+2);
		
		//형식 
		for ( i = 0 ;  SCBOIL_FORM[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), SCBOIL_FORM[i].Str, 0, ICON_NONE);
		}
		
		//설치업체
		//g_Sql_SetCombo("SELECT WORK_FIRM FROM BO_INST LIMIT 0, 200", CMB_DATA7+2);
	}
*/

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char sztmp[10];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
	
		switch(ID)
		{
			case BID_WORKFIRM:
				QuickList();
				break;

			case BID_WRITE1:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;
			case BID_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA3), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
				break;	
			
			case BID_INST_YMD:
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));		
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
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
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_ItoA ( d, sztmp, 10);
					//g_Str_DateType( szDp, sztmp);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
					Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA7), szDay );
				}
				break;
			case BID_SAVE:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Save_BoilNew() )
				{
					Find_Burner_Class_Cd();
				}
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
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
				ShowSip(FALSE);
				g_Sipflag = 0;
				
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
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				Card_Move("SC_BOILCHK");
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
	
//------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		if( theDevInfo.m_nType == FAMILY_PDA )
		{	
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_DATA7+1) )
			{
				INST_DRAW();
			}
		}
	}	
	

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		
		//숫자만 입력 가능
		if( (Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex 
		|| Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex
		|| Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex
		|| Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex)
		&& (nChar < 48 ||  nChar > 57) )
		{
			MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
			ON_KEY( 5 );
			return;
		}

		if( Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA5)) == 4 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6));
				m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 1);
			if( Str_AtoI(szTmp) > 1 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
			{
				ON_KEY( 5 );
				return;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA6)) == 2 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA7));
				m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)), 1);
			if( Str_AtoI(szTmp) > 3 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
			{
				ON_KEY( 5 );
				return;
			}
		}
		

		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
		if( Str_Len(szTmp) == 8 )
		{
			Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
			nDate = Str_AtoI(szTmp);
			nRet = Time_ValidateDate(nDate);
			//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
			
			if( nRet == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), "");
				
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5));
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
		
		m_lActiveIndex = lActiveIndex;
		
		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+600) && Y > DMS_Y(STARTY+260) && Y < DMS_Y(STARTY+310) ||
					X > DMS_X(STARTX+300) && X < DMS_X(STARTX+500) && Y > DMS_Y(STARTY+360) && Y < DMS_Y(STARTY+410) ||
					X > DMS_X(STARTX+518) && X < DMS_X(STARTX+663) && Y > DMS_Y(STARTY+360) && Y < DMS_Y(STARTY+410) ||
					X > DMS_X(STARTX+680) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY+360) && Y < DMS_Y(STARTY+410) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex )	
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
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+130) && Y < DMS_Y(STARTY+185) ||
				    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+460) && Y < DMS_Y(STARTY+515) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
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
	
//------------------------------------------------------------------
	void REDRAW(void)
	{
	char sztmp[11];
	char szYear[5];
	char szMonth[3];
	char szDay[3];
		
/*
		Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
		Str_ItoA(Time_GetDate(), szToday, 10);
		g_Str_DateType( szDP, szToday);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), szDP );
*/		

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_ItoA(Time_GetDate(), sztmp, 10);
//PRINT("sztmp : %s",sztmp,0,0);
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
		Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA7), szDay );

		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2+2), 0) );
		
		EditCtrl_SetStr (Get_hDlgCtrlByID(CMB_DATA3), SCBOIL_CAPA[0].Str);
		
	}
	
//------------------------------------------------------------------
	void INST_DRAW(void)
	{
		long i, idx;
		char szWork_Firm[50];
		char sztmp[300];
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szWork_Firm, 0x00, sizeof(szWork_Firm));
		Str_Cpy(szWork_Firm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)));
		
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
		char szMsg[150];
		char szTmp[10];
		long nLen = 0;
	
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "연소기 종류를 선택해 주세요.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "연소기 제조사를 선택해 주세요.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "연소기 형식을 선택해 주세요.");
			return FALSE;
		}
	//	if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
	//	{
	//		MessageBoxEx (CONFIRM_OK, "모델명을 입력해주세요.");
	//		return FALSE;
	//	}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "용량을 입력해주세요.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "설치위치를 입력해주세요.");
			return FALSE;
		}
		
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
		if( Str_Len(szTmp) > 0 && Str_Len(szTmp) < 8 )
		{
			MessageBoxEx (CONFIRM_OK, "유효한 날짜 형식이 아닙니다.\n(ex: 2016. 01. 01)");
			return FALSE;
		}
		
		if(  Str_AtoI( szTmp ) > Time_GetDate() )
		{
			MessageBoxEx (CONFIRM_OK, "설치일자가 현재보다 이후로 \n등록할 수 없습니다.");
			return FALSE;
		}
		
		//if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
		//{
		//	MessageBoxEx (CONFIRM_OK, "제조번호 입력해주세요.");
		//	return FALSE;
		//}
		//if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7))) == 0 )
		//{
		//	MessageBoxEx (CONFIRM_OK, "설치업체를 입력해주세요.");
		//	return FALSE;
		//}
	
		nLen = 0;
		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		if( nLen > 50 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "저장실패!\n(모델명은 한글 16자,\n영문,숫자 50자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			return FALSE;
		}
		
		nLen = 0;
		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		if( nLen > 30 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "저장실패!\n(제조번호는 한글 10자,\n영문,숫자 30자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			return FALSE;
		}
		
		return TRUE;
	}
	
//------------------------------------------------------------------
	bool Save_BoilNew(void)
	{
		char sztmp[300];
		char szSql[300];
		char szSeq[4];
		long lSeq;
		long idx, i;
		//long lVal;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//점검시행번호
		Str_Cpy(stScBur.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		//기물번호
		Str_Cpy(stScBur.MTR_ID_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );
		//계량기번호(MTR_NUM)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT MTR_NUM FROM NORMAL_MTR where CHK_EXEC_NUM = '%s' AND MTR_ID_NUM = '%s' ", g_szCHK_EXEC_NUM, stScBur.MTR_ID_NUM, 0   );
		g_Sql_RetStr( szSql, 10, stScBur.MTR_NUM );
		
		//연소기번호
		// WHERE AND SUBSTR(BURNER_NUM,0,1)= '1' -> 보일러 시작 : 1 , 연소기 시작 : 2
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ifnull(MAX(BURNER_NUM)+1,'100001' ) AS MAX_NUM  FROM NORMAL_BUR WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND SUBSTR(BURNER_NUM,1,1)= '1'  AND BURNER_KIND_NUM IN (201, 301)"
		, g_szCHK_EXEC_NUM, stScBur.MTR_NUM, 0   );
		g_Sql_RetStr( szSql, 6, stScBur.BURNER_NUM );		
		
		//종류
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)stScBur.BURNER_KIND_NM, 0x00, sizeof(stScBur.BURNER_KIND_NM) );
		Str_Cpy(stScBur.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
		
		SPRINT(szSql, "SELECT BURNER_KIND_NUM FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stScBur.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.BURNER_KIND_NUM );

		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stScBur.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.BURNER_CLASS_CD );

		i = SearchStr(stScBur.BURNER_CLASS_CD, BURNERCLASS);
		if (i > -1)
			Str_Cpy(stScBur.BURNER_CLASS_NM, BURNERCLASS[i].Str);

		//모델명
		Str_Cpy(stScBur.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		//용량
		Str_Cpy(stScBur.BURNER_CAPA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
		
		//단위
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), SCBOIL_CAPA );
		if (i == -1)
		{
			Str_Cpy(stScBur.BURNER_CAPA_UNIT, "");
		}
		else
		{
			Str_Cpy(stScBur.BURNER_CAPA_UNIT, SCBOIL_CAPA[i].Code);
			Str_Cpy(stScBur.BURNER_CAPA_UNIT_NM, SCBOIL_CAPA[i].Str);
		}
		//제조사명 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(stScBur.MAKER_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)));
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", stScBur.MAKER_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.MAKER_NUM );
		
		//설치일자
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
		Str_Chg(sztmp, STRCHG_DEL_NONDIGIT);
		Str_Cpy(stScBur.BURNER_INST_YMD, sztmp );
		
		//설치위치
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)stScBur.INST_LOC_NM, 0x00, sizeof(stScBur.INST_LOC_NM) );
		Str_Cpy(stScBur.INST_LOC_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5)));
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30028' AND ITEM_KNAME = '%s' ", stScBur.INST_LOC_NM, 0, 0   );
		g_Sql_RetStr( szSql, 3, stScBur.INST_LOC );
		
		//형식
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)), SCBOIL_FORM );
		if (i == -1)
			Str_Cpy(stScBur.BOILER_FORM, "");
		else
			Str_Cpy(stScBur.BOILER_FORM, SCBOIL_FORM[i].Code);
		//형식명
		i = SearchCD( stScBur.BOILER_FORM, SCBOIL_FORM );
		Str_Cpy(stScBur.BOILER_FORM_NM, SCBOIL_FORM[i].Str);
		
		//제조번호
		Str_Cpy(stScBur.MAKE_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
		
		//설치업체
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)stScBur.BOILER_INST_FIRM_CD, 0x00, sizeof(stScBur.BOILER_INST_FIRM_CD) );
		
		Str_Cpy(stScBur.BOILER_INST_FIRM_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)));
		SPRINT(szSql, "SELECT BOILER_INST_FIRM_CD FROM BO_INST  where WORK_FIRM = '%s' ", stScBur.BOILER_INST_FIRM_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.BOILER_INST_FIRM_CD );
		
		//설치구분  > 신규(1)로 밖아놓기
		Str_Cpy(stScBur.CHG_FLAG, "1" );
		
		//seq셋팅
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szSeq, 0x00, sizeof(szSeq) );
		SPRINT(szSql, "SELECT ifnull(MAX(SEQ)+1, 1) FROM NORMAL_BUR  WHERE CHK_EXEC_NUM = '%s' AND BURNER_KIND_NUM IN (201, 301)"
		, g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lSeq );
	
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

			
		hstmt = sql->CreateStatement(sql, " INSERT INTO NORMAL_BUR \
											( CHK_EXEC_NUM, MTR_ID_NUM, MTR_NUM, BURNER_NUM, BURNER_KIND_NUM \
											, BURNER_KIND_NM, BURNER_CLASS_CD, BURNER_CLASS_NM, BURNER_MODEL_NM, BURNER_CAPA \
											, BURNER_CAPA_UNIT, BURNER_CAPA_UNIT_NM, MAKER_NUM, MAKER_NM, BURNER_INST_YMD \
											, INST_LOC, INST_LOC_NM, BOILER_FORM, BOILER_FORM_NM, MAKE_NUM \
											, BOILER_INST_FIRM_CD, BOILER_INST_FIRM_NM, CHG_FLAG, BLD_NUM, INST_PLACE_NUM \
											, CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM, PLAN_YM \
											, SEND_YN, INST_FLAG, UPD_EMPID, PDA_IP, SEQ ) \
											VALUES \
											( ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, 'S', '10', ?, ?, ? )"
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_EXEC_NUM      	    ,12 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_ID_NUM         	,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_NUM        		,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_NUM      		,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_KIND_NUM 		,3  ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_KIND_NM 		,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CLASS_CD 		,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CLASS_NM 		,30 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_MODEL_NM 		,50 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA     		,10 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA_UNIT		,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA_UNIT_NM  ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MAKER_NUM			,5  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MAKER_NM			    ,60 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_INST_YMD		,8  ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.INST_LOC				,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.INST_LOC_NM			,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BOILER_FORM			,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BOILER_FORM_NM		,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MAKE_NUM				,30 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BOILER_INST_FIRM_CD	,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BOILER_INST_FIRM_NM	,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.CHG_FLAG        		,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       			,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM			,9  ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      			,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      			,4  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     			,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM        			,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM       			,6  ,DECRYPT);
		
		// 'S'
		// '10'
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id     ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip          ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'X', &lSeq                                ,4  ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "신규저장되었습니다!");
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
		JSON_SetValue ( js, 'C', "query", "SELECT WORK_FIRM, WORK_FIRM FROM BO_INST");

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
	
	void Find_Burner_Class_Cd(void)
	{	
		long i;
		char sztmp[8];
		char burclscd[8];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)burclscd, 0x00, sizeof(burclscd) );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT BURNER_CLASS_CD \
 										     FROM NORMAL_BUR \
										    WHERE (INST_FLAG <> '30' OR  INST_FLAG  IS NULL) \
											  AND CHK_EXEC_NUM= ? \
											  AND BURNER_KIND_NUM <> '398' \
										    GROUP BY BURNER_CLASS_CD ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    ,8 +1, DECRYPT );
			Str_Cat(burclscd, sztmp);
		}
		
		Chk_Prod_Cd_Alarm(burclscd);

	Finally:
		DelSqLite(sql);
		return;	
	}
	
	void Chk_Prod_Cd_Alarm(char* burclscd)
	{
		long i;
		long chk_count = 0;
		
		char sztmp[8];

		char szSql[50];
		char szProd[5];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)szProd, 0x00, sizeof(szProd));
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		
		SPRINT(szSql, "SELECT PROD_CD FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0);

		g_Sql_RetStr(szSql, 10, szProd);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT PROD_CD FROM C6101_BIZ_BURN A WHERE BURNER_CLASS_CD = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)burclscd , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    , 8 +1, DECRYPT );

			if( Str_Cmp(sztmp, szProd) == 0 )
			{
				chk_count ++;
			}	
		}
		
		if( Str_Cmp(stSc.CENTER_CD, "41") == 0 || Str_Cmp(stSc.CENTER_CD, "42") == 0 || Str_Cmp(stSc.CENTER_CD, "43") == 0 || Str_Cmp(stSc.CENTER_CD, "44") == 0 || Str_Cmp(stSc.CENTER_CD, "45") == 0 || Str_Cmp(stSc.CONT_STS_CD, "30") == 0)
		{
			Card_Move("SC_BOILCHK");	
		}
		else
		{
			if( Str_Cmp(szProd, "11") == 0 || Str_Cmp(szProd, "12") == 0 || Str_Cmp(szProd, "13") == 0 || Str_Cmp(szProd, "81") == 0 || Str_Cmp(szProd, "82") == 0 || Str_Cmp(szProd, "83") == 0 )
			{
				if(chk_count == 0)
				{
					MessageBoxEx (CONFIRM_OK, "상품을 변경해주세요!");
					g_nProdMoveFlag = 0;
					Card_Move("SC_PRODCHG");
				}
				else
				{
					Card_Move("SC_BOILCHK");
				}
			}
			else
			{
				Card_Move("SC_BOILCHK");
			}
		}
		
Finally:
		DelSqLite(sql);
		return;	
	}
}


