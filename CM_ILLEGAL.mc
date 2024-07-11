/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card CM_ILLEGAL
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SAVE )			//저장
		DEF_BUTTON_ID ( BID_PREVPG )		//이전화면
		DEF_BUTTON_ID ( BID_RPRTDATE )		//신고일자
		DEF_BUTTON_ID ( BID_WRITE1 )		//입력창 호출 신고내용
		DEF_BUTTON_ID ( BID_WRITE2 )		//입력창 호출 성명
		
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
		DEF_OBJECT_ID ( TXT_RPRTINFO )		//신고자정보
		DEF_OBJECT_ID ( TXT_ID )			//사원번호
		DEF_OBJECT_ID ( TXT_NAME )			//성명
		DEF_OBJECT_ID ( TXT_ILLRPRT )		//불법 신고 내역
		DEF_OBJECT_ID ( TTT_RPRTDATE )		//신고일자
		DEF_OBJECT_ID ( TXT_ILLTYPE )		//불법 유형
		DEF_OBJECT_ID ( TXT_REPORT )		//신고내역
		DEF_OBJECT_ID ( TXT_OBJNUM )		//기물번호
		DEF_OBJECT_ID ( TXT_GRGRADE )		//계량기등급
		DEF_OBJECT_ID ( TXT_ILLGUIDE )		//불법지침
		DEF_OBJECT_ID ( TXT_NAME2 )			//성명
		DEF_OBJECT_ID ( TXT_BIRTH )			//생년월일
		DEF_OBJECT_ID ( TXT_HP )			//휴대폰
		DEF_BUTTON_ID ( TXT_RPRTDATE )		   //이전화면
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

		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )
		DEF_OBJECT_ID ( EDT_DATA8 )
		DEF_OBJECT_ID ( EDT_DATA9 )
		DEF_OBJECT_ID ( EDT_DATA10 )
		DEF_OBJECT_ID ( EDT_DATA11 )

		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_ILLTYPE  ) 		//불법유형 콤보박스
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	long SearchStr( char *Str, CodeTable *CT);
	void Snd_Illgal(void);
	long TR13331(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "무적 신고"),
		
		DLG_BUTTON(STARTX,     STARTY+830, 350, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "이 전"),
		DLG_BUTTON(STARTX+650, STARTY+830, 350, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "저 장"),
		
		DLG_TEXT(STARTX, 	  STARTY+65, 450, 60, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, WHITE, TXT_RPRTINFO, "◎신고자 정보"),
		DLG_TEXT(STARTX, 	 STARTY+125, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ID, "사원번호"),
		DLG_TEXT(STARTX+280, STARTY+125, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+580, STARTY+125, 170, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NAME, "성명"),
		DLG_TEXT(STARTX+750, STARTY+125, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_TEXT(STARTX, 	 STARTY+190, 600, 60, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, WHITE, TXT_ILLRPRT, "◎불법 신고 내역"),
		DLG_TEXT(STARTX,     STARTY+250, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTT_RPRTDATE, "신고일자"),
		DLG_TEXT(STARTX+280, STARTY+250, 570, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, WHITE, TXT_RPRTDATE, ""),
		DLG_BUTTON(STARTX+850, STARTY+250, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC , "", BID_RPRTDATE, "▼"),
		
		DLG_TEXT(STARTX, 	 STARTY+310, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ILLTYPE, "불법유형"),
		
		DLG_TEXT(STARTX, 	 STARTY+370, 280, 150, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REPORT, "신고내역"),
		DLG_BUTTON(STARTX+280, STARTY+370, 720, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),	
		DLG_TEXT(STARTX+280, STARTY+370, 720, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, ""),//300,
		
		DLG_TEXT(STARTX, 	 STARTY+520, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_EDIT(STARTX+280, STARTY+520, 720, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 20 ,""),
		DLG_TEXT(STARTX, 	 STARTY+580, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GRGRADE, "계량기등급"),
		DLG_EDIT(STARTX+280, STARTY+580, 225, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 10,""),
		DLG_TEXT(STARTX+505, STARTY+580, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ILLGUIDE, "불법지침"),
		DLG_EDIT(STARTX+755, STARTY+580, 245, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 20,""),

		DLG_TEXT(STARTX, 	 STARTY+640, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NAME2, "성명"),
		DLG_BUTTON(STARTX+280, STARTY+640, 720, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE2,  ""),	
		DLG_TEXT(STARTX+280, STARTY+640, 720, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, ""),// 10,

		DLG_TEXT(STARTX, 	 STARTY+700, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BIRTH, "생년월일"),
		DLG_EDIT(STARTX+280, STARTY+700, 720, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 6,""),

		DLG_TEXT(STARTX, 	 STARTY+760, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HP, "휴대폰"),
		DLG_EDIT(STARTX+280, STARTY+760, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9,3, ""),
		DLG_TEXT(STARTX+480, STARTY+760,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, "-"),
		DLG_EDIT(STARTX+530, STARTY+760, 210, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10,4, ""),
		DLG_TEXT(STARTX+740, STARTY+760,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, "-"),
		DLG_EDIT(STARTX+790, STARTY+760, 210, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11,4, ""),
		
		DLG_COMBO (STARTX+280, STARTY+310, 720, 290, 150, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ILLTYPE, 10),		//불법유형
		
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
		//화면캡쳐
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "무적 신고"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,     STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "이 전"),
		DLG_BUTTON(STARTX+600, STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "저 장"),
		
		DLG_TEXT(STARTX,        STARTY-30, 450, 70, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, WHITE, TXT_RPRTINFO, "◎신고자 정보"),
		DLG_TEXT(STARTX,        STARTY+50, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ID, "사원번호"),
		DLG_TEXT(STARTX+250,    STARTY+50, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550,    STARTY+50, 150, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NAME, "성명"),
		DLG_TEXT(STARTX+700,    STARTY+50, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_TEXT(STARTX,       STARTY+140, 600, 60, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, WHITE, TXT_ILLRPRT, "◎불법 신고 내역"),
		DLG_TEXT(STARTX,       STARTY+210, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTT_RPRTDATE, "신고일자"),
		DLG_TEXT(STARTX+250,   STARTY+210, 575, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_RPRTDATE, ""),
		DLG_BUTTON(STARTX+825, STARTY+210, 175, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CALL_FUNC , "", BID_RPRTDATE, "▼"),
		
		DLG_TEXT(STARTX,     STARTY+270, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ILLTYPE, "불법유형"),
		DLG_TEXT(STARTX,     STARTY+330, 250, 150, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REPORT, "신고내역"),
		//DLG_EDIT(STARTX+250, STARTY+310, 725, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 100, ""),
		//DLG_BUTTON(STARTX+250, STARTY+310, 725, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),	
		//DLG_TEXT(STARTX+250, STARTY+310, 725, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, ""),//300,
		DLG_EDIT(STARTX+250, STARTY+330, 750, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 300, ""),

		DLG_TEXT(STARTX,     STARTY+480, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_EDIT(STARTX+250, STARTY+480, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4,20 ,""),
		DLG_TEXT(STARTX,     STARTY+540, 280, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GRGRADE, "계량기등급"),
		DLG_EDIT(STARTX+280, STARTY+540, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 5,""),
		DLG_TEXT(STARTX+480, STARTY+540, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ILLGUIDE, "불법지침"),
		DLG_EDIT(STARTX+730, STARTY+540, 270, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 9,""),
		
		DLG_TEXT(STARTX,     STARTY+600, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NAME2, "성명"),
		DLG_EDIT(STARTX+250, STARTY+600, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7,10, ""),
		//DLG_BUTTON(STARTX+250, STARTY+580, 725, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE2,  ""),	
		//DLG_TEXT(STARTX+250, STARTY+580, 725, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, ""),
		
		DLG_TEXT(STARTX,     STARTY+660, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BIRTH, "생년월일"),
		DLG_EDIT(STARTX+250, STARTY+660, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 6,""),
		DLG_TEXT(STARTX,     STARTY+720, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HP, "휴대폰"),
		DLG_EDIT(STARTX+250, STARTY+720, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9,3, ""),
		DLG_TEXT(STARTX+450, STARTY+720,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, "-"),
		DLG_EDIT(STARTX+500, STARTY+720, 225, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10,4, ""),
		DLG_TEXT(STARTX+725, STARTY+720,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, "-"),
		DLG_EDIT(STARTX+775, STARTY+720, 225, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11,4, ""),
		
		DLG_COMBO (STARTX+250, STARTY+270, 750, 290, 175, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ILLTYPE, 10),		//불법유형
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
				REDRAW();
				break;
		}
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_RPRTINFO), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ID), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NAME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ILLRPRT), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTT_RPRTDATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ILLTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REPORT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GRGRADE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ILLGUIDE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NAME2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BIRTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ILLTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_RPRTDATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_DATA3), TRUE, 2, EDITSEP_NONE );		//신고내역
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA10), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA11), EDITALIGN_MIDDLE);
		
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

	//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		if( Get_iDlgCtrlByID(EDT_DATA8) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA9) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA10) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA11) == m_lActiveIndex )
		{
			//숫자만 입력 가능
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
				return;
			}
		}
	}
	
//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			m_lActiveIndex = lActiveIndex;
		
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+280) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+520-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+580-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+280) && X < DMS_X(STARTX+505) && Y > DMS_Y(STARTY+580-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+640-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+755) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+580-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+640-(g_Dlgflag*400)))
				{
					if( Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+280) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+700-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+760-(g_Dlgflag*400)) ||
					     X > DMS_X(STARTX+280) && X < DMS_X(STARTX+480) && Y > DMS_Y(STARTY+760-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+820-(g_Dlgflag*400)) ||
					     X > DMS_X(STARTX+530) && X < DMS_X(STARTX+740) && Y > DMS_Y(STARTY+760-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+820-(g_Dlgflag*400)) ||
					     X > DMS_X(STARTX+790) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+760-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+820-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA9) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA10) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA11) == lActiveIndex )	
					{
						if( g_Dlgflag == 0 )
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
	
							ShowSip(FALSE);
							g_Sipflag = 0;
						}
					}
				}
				else
				{
					if( Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA9) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA10) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA11) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
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
			else if( theDevInfo.m_nType == FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+310) && Y < DMS_Y(STARTY+460) ||
				    X > DMS_X(STARTX+250) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+580) && Y < DMS_Y(STARTY+640) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
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
				
				ON_DRAW();
			}
		}
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	long d, k;
	char szDate[15];
	char szToday[15];
		
		switch(ID)
		{					
			
			case BID_RPRTDATE:			
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
					Str_ItoA ( d, szToday, 10);
					g_Str_DateType(szDate, szToday);
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_RPRTDATE), szDate );
				}
				break;
			
			case BID_WRITE1:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA3), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
				break;
			case BID_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA7), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)) );
				break;
			
			case BID_SAVE:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				Snd_Illgal();
				break;
			case BID_PREVPG:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				Card_Prev();
				break;

			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( 100 == g_nWorkFlag)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "검침 메뉴로 나가시겠습니까?")  == MB_OK)
					{
						Card_Move("GM_MENU");
					}
				}
				else if( 200 == g_nWorkFlag)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "안전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
					{
						Card_Move("SC_MENU");
					}
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
				
				Card_Prev();
				break;
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void REDRAW(void)
	{
	long i;
	char sztmp[20];
	char szDp[20];

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
		Str_ItoA( Time_GetDate(), sztmp, 10 );
		g_Str_DateType( szDp, sztmp);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_RPRTDATE), szDp);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), stUserinfo.szemployee_id);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), stUserinfo.sznm_kor);
		
		for ( i = 0 ;  CHK_ILLGAL[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ILLTYPE+2), CHK_ILLGAL[i].Str, 0, ICON_NONE);
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
	
	void Snd_Illgal(void)
	{
	char sztmp[301];
	char szutf[601];
	char szUrl[256];
	char* sndbuf;
	char szSql[300];
	char szMsg[150];
	long ret, nLen;
	long i = 0;
		
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_ILLTYPE) )  == 0)
		{
			MessageBoxEx (CONFIRM_OK, "불법유형은 필수 입니다.");
			return;
		}
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_DATA6) )  == 0)
		{
			MessageBoxEx (CONFIRM_OK, "불법지침은 필수 입니다.");
			return;
		}
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_DATA4) )  == 0)
		{
			MessageBoxEx (CONFIRM_OK, "기물번호는 필수 입니다.");
			return;
		}
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_DATA5) )  == 0)
		{
			MessageBoxEx (CONFIRM_OK, "계량기등급은 필수 입니다.");
			return;
		}

		nLen = g_GetUtf8Size(EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)));
		if( nLen > 100 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "저장실패!\n(메모는 한글 33자,\n영문.숫자 100자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			return;
		}

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13331, FALSE);
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_RPRTDATE)) );
		Str_Chg(sztmp , STRCHG_DEL_NONDIGIT);
		JSON_SetValue( g_pjcomm, 'C', "ill_decl_ymd",   sztmp );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ILLTYPE)) );
		i = SearchStr( sztmp, CHK_ILLGAL);
		JSON_SetValue( g_pjcomm, 'C', "ill_type_cd",    CHK_ILLGAL[i].Code );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)) );
		Mem_Set( (byte*) szutf, 0x00, sizeof( szutf) );
		SQL_ConvUcStr( szutf, sztmp );
		JSON_SetValue( g_pjcomm, 'C', "applic_memo",    szutf );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA4)) );
		JSON_SetValue( g_pjcomm, 'C', "mtr_id_num",     sztmp );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA5)) );
		JSON_SetValue( g_pjcomm, 'C', "grd",            sztmp );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA6)) );
		Str_Chg(sztmp , STRCHG_DEL_NONDIGIT);
		JSON_SetValue( g_pjcomm, 'C', "ill_indi",       sztmp );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA7)) );
		Mem_Set( (byte*) szutf, 0x00, sizeof( szutf) );
		SQL_ConvUcStr( szutf, sztmp );
		JSON_SetValue( g_pjcomm, 'C', "ill_cust_nm",    szutf );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA8)) );
		Str_Chg(sztmp , STRCHG_DEL_NONDIGIT);
		Str_Cat( sztmp, "0000000" );
		JSON_SetValue( g_pjcomm, 'C', "ill_social_num", sztmp );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA9)) );
		Str_Chg(sztmp , STRCHG_DEL_NONDIGIT);
		JSON_SetValue( g_pjcomm, 'C', "ill_tel_ddd",    sztmp );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA10)) );
		Str_Chg(sztmp , STRCHG_DEL_NONDIGIT);
		JSON_SetValue( g_pjcomm, 'C', "ill_tel_exn",    sztmp );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(  sztmp,  EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA11)) );
		Str_Chg(sztmp , STRCHG_DEL_NONDIGIT);
		
		Mem_Set( (byte*) szutf, 0x00, sizeof( szutf) );
		SQL_ConvUcStr( szutf, sztmp );
		JSON_SetValue( g_pjcomm, 'C', "ill_tel_num",    szutf );
		Mem_Set( (byte*) szutf, 0x00, sizeof( szutf) );
		SQL_ConvUcStr( szutf, stUserinfo.sznm_kor );		
		JSON_SetValue( g_pjcomm, 'C', "applic_nm",      szutf );
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		
		callBackfunc = TR13331; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR13331_IN",  "FR13331" , sndbuf, sztmp );
	}
	
	long TR13331(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(13331) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "저장 되었습니다.");
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			return -1;
		}
	}
}


