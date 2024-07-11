/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_CUSTINFO
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
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
		DEF_BUTTON_ID ( BID_ADDR )			//지번
		DEF_BUTTON_ID ( BID_ADDR2 )			//◀
		DEF_BUTTON_ID ( BID_CHANGE )		//수정
		DEF_BUTTON_ID ( BID_BIZ )			//사업자등록증
		DEF_BUTTON_ID ( BID_USEDOC )		//사용계약서
		DEF_BUTTON_ID ( BID_USEDOC_SMS )	//사용계약서 발송
		DEF_BUTTON_ID ( BID_OK )			//확인
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
		
		DEF_BUTTON_ID ( BID_MOVING_CENT ) //이동고객센터
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_CLNUM )			//고객번호
		DEF_OBJECT_ID ( TXT_CLNAME )		//고객명
		DEF_OBJECT_ID ( TXT_CMPNNAME )		//상호
		DEF_OBJECT_ID ( TXT_BIRTH )			//생년월일
		DEF_OBJECT_ID ( TXT_CMPNNUM )		//사업자번호
		DEF_OBJECT_ID ( TXT_CABLEHP )		//유선전화
		DEF_OBJECT_ID ( TXT_NCABLEHP )		//무선전화
		DEF_OBJECT_ID ( TXT_PAYTYPE )		//납부방법
		DEF_OBJECT_ID ( TXT_STATEEOM )		//상태/격월
		DEF_OBJECT_ID ( TXT_CNTRCTNUM )		//사용계약번호
		DEF_OBJECT_ID ( TXT_CNTRCTDATE )	//계약/해지일
		DEF_OBJECT_ID ( TXT_OBJECT )		//상품
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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	
	void SetStyle(void);
	void SetData(void);
	void REDRAW(void);
	void SetBtnImg(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	void SND_21362(void);
	long TR21362(void);
	void Save_Custinfo(void);

	long Rcv_62602(void);
	long TR62602(void);
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 );
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객 정보"),

		//DLG_BUTTON(STARTX+200, STARTY+320, 100, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "◀"),	
		DLG_BUTTON(STARTX, STARTY+315, 300, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),

		DLG_BUTTON(STARTX,     STARTY+765, 333, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BIZ, "사업자\n등록증"),
		DLG_BUTTON(STARTX+333, STARTY+765, 333, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_USEDOC, "사용계약서"),
		DLG_BUTTON(STARTX+666, STARTY+765, 334, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_USEDOC_SMS, "사용계약서\n발송"),

		DLG_BUTTON(STARTX,     STARTY+830, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "수 정"),
		DLG_BUTTON(STARTX+500, STARTY+830, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),
		
		DLG_TEXT(STARTX, 	 STARTY+65,  300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLNUM, "고객번호"),
		DLG_TEXT(STARTX+300, STARTY+65,  366, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_BUTTON(STARTX+666, STARTY+65, 334, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MOVING_CENT, "이동고객센터"),
		
		DLG_TEXT(STARTX, 	 STARTY+115, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLNAME, "고객명"),
		DLG_TEXT(STARTX+300, STARTY+115, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX, 	 STARTY+165, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPNNAME, "상호"),
		DLG_TEXT(STARTX+300, STARTY+165, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX, 	 STARTY+215, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BIRTH, "생년월일"),
		DLG_TEXT(STARTX+300, STARTY+215, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX, 	 STARTY+265, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPNNUM, "사업자번호"),
		DLG_TEXT(STARTX+300, STARTY+265, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+300, STARTY+315, 700, 100,0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX, 	 STARTY+415, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CABLEHP, "유선전화"),
		DLG_EDIT(STARTX+300, STARTY+415, 195, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA7,3, ""),
		DLG_TEXT(STARTX+495, STARTY+415,  50, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+545, STARTY+415, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA9, 4,""),
		DLG_TEXT(STARTX+745, STARTY+415,  50, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, "-"),
		DLG_EDIT(STARTX+795, STARTY+415, 205, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA11, 4,""),
		DLG_TEXT(STARTX, 	 STARTY+465, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NCABLEHP, "무선전화"),
		DLG_EDIT(STARTX+300, STARTY+465, 195, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA12,3, ""),
		DLG_TEXT(STARTX+495, STARTY+465,  50, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, "-"),
		DLG_EDIT(STARTX+545, STARTY+465, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA14,4, ""),
		DLG_TEXT(STARTX+745, STARTY+465,  50, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "-"),
		DLG_EDIT(STARTX+795, STARTY+465, 205, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA16, 4,""),
		DLG_TEXT(STARTX, 	 STARTY+515, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PAYTYPE, "납부방법"),
		DLG_TEXT(STARTX+300, STARTY+515, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX, 	 STARTY+565, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STATEEOM, "상태/격월"),
		DLG_TEXT(STARTX+300, STARTY+565, 350, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+650, STARTY+565, 350, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX,	 STARTY+615, 350, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTNUM, "사용계약번호"),
		DLG_TEXT(STARTX+350, STARTY+615, 650, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX, 	 STARTY+665, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTDATE, "계약/해지일"),
		DLG_TEXT(STARTX+300, STARTY+665, 350, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+650, STARTY+665, 350, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX, 	 STARTY+715, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "상품"),
		DLG_TEXT(STARTX+300, STARTY+715, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),

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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "고객 정보"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,     STARTY+260, 300, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		//DLG_BUTTON(STARTX+200, STARTY+300, 100, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "◀"),	
		DLG_BUTTON(STARTX,     STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "수 정"),
		DLG_BUTTON(STARTX+600, STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),
		
		DLG_TEXT(STARTX, 	  STARTY-40, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLNUM, "고객번호"),
		DLG_TEXT(STARTX+300,  STARTY-40, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX, 	  STARTY+20, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLNAME, "고객명"),
		DLG_TEXT(STARTX+300,  STARTY+20, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX, 	  STARTY+80, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPNNAME, "상호"),
		DLG_TEXT(STARTX+300,  STARTY+80, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX, 	 STARTY+140, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BIRTH, "생년월일"),
		DLG_TEXT(STARTX+300, STARTY+140, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX, 	 STARTY+200, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPNNUM, "사업자번호"),
		DLG_TEXT(STARTX+300, STARTY+200, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+300, STARTY+260, 700, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX, 	 STARTY+360, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CABLEHP, "유선전화"),
		DLG_EDIT(STARTX+300, STARTY+360, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA7, 3,""),
		DLG_TEXT(STARTX+475, STARTY+360,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+525, STARTY+360, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA9, 4,""),
		DLG_TEXT(STARTX+725, STARTY+360,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, "-"),
		DLG_EDIT(STARTX+775, STARTY+360, 225, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA11, 4, ""),
		DLG_TEXT(STARTX, 	 STARTY+420, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NCABLEHP, "무선전화"),
		DLG_EDIT(STARTX+300, STARTY+420, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA12, 3,""),
		DLG_TEXT(STARTX+475, STARTY+420,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, "-"),
		DLG_EDIT(STARTX+525, STARTY+420, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA14, 4,""),
		DLG_TEXT(STARTX+725, STARTY+420,  50, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "-"),
		DLG_EDIT(STARTX+775, STARTY+420, 225, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA16,4, ""),
		DLG_TEXT(STARTX, 	 STARTY+480, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PAYTYPE, "납부방법"),
		DLG_TEXT(STARTX+300, STARTY+480, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		
		DLG_TEXT(STARTX, 	 STARTY+540, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STATEEOM, "상태/격월"),
		DLG_TEXT(STARTX+300, STARTY+540, 345, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+645, STARTY+540, 355, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX, 	 STARTY+600, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTNUM, "사용계약번호"),
		DLG_TEXT(STARTX+350, STARTY+600, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX, 	 STARTY+660, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTDATE, "계약/해지일"),
		DLG_TEXT(STARTX+300, STARTY+660, 345, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+645, STARTY+660, 355, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX, 	 STARTY+720, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "상품"),
		DLG_TEXT(STARTX+300, STARTY+720, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLNAME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMPNNAME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BIRTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMPNNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CABLEHP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NCABLEHP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAYTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STATEEOM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CNTRCTNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CNTRCTDATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA6), TRUE, 2, EDITSEP_NONE );

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
		
		// 2018.05.24 CS팀 김미영 과장님 SMS 발송 버튼 막기 요청
		//DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_USEDOC_SMS), FALSE );
		// 2018.12.03 CS팀 김미영 과장님 SMS 발송 버튼 다시 살림
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_USEDOC_SMS), TRUE );
		
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
		//숫자만 입력 가능
		if( Get_iDlgCtrlByID(TXT_DATA7) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(TXT_DATA9) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(TXT_DATA11) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(TXT_DATA12) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(TXT_DATA14) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(TXT_DATA16) == m_lActiveIndex )
		{
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
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+495) && Y > DMS_Y(STARTY+415-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+465-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+545) && X < DMS_X(STARTX+745) && Y > DMS_Y(STARTY+415-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+465-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+795) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+415-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+465-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+495) && Y > DMS_Y(STARTY+465-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+515-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+545) && X < DMS_X(STARTX+745) && Y > DMS_Y(STARTY+465-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+515-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+795) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+465-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+515-(g_Dlgflag*400)) )
				{
					m_lActiveIndex = lActiveIndex;

					if( Get_iDlgCtrlByID(TXT_DATA7) == lActiveIndex ||
					    Get_iDlgCtrlByID(TXT_DATA9) == lActiveIndex ||
					    Get_iDlgCtrlByID(TXT_DATA11) == lActiveIndex ||
					    Get_iDlgCtrlByID(TXT_DATA12) == lActiveIndex ||
					    Get_iDlgCtrlByID(TXT_DATA14) == lActiveIndex ||
					    Get_iDlgCtrlByID(TXT_DATA16) == lActiveIndex )
					{
						g_Dlgflag = 0;
						g_MOVE_DLG(400);

						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);

						//ShowSip(TRUE);
						//g_Sipflag = 1;
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
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_ADDR:
			case BID_ADDR2:
				//g_nAddrFlag = 0 -> 구주소    g_nAddrFlag = 1 -> 신주소
				if( g_nAddrFlag == 0)
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
				ON_DRAW();
				break;
			case BID_BIZ:
				Card_Move("CM_BIZ");
				break;
			case BID_USEDOC:
				//Card_Move("CM_USEDOC");
				
				g_lMobile_Inflow_Path = 3;
				Card_Move("CM_MOBILE_USE_DOC_MENU");
				
				break;
				
			case BID_USEDOC_SMS:
				/*
				if( Str_Cmp(stGm.SUPPLY_STS_CD, "해지") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "사용계약상태가 해지인 고객님께는\n모바일발송을 할 수 없습니다.\n고객센터로 문의해주세요.");
				}
				else
				{
					if( MessageBoxEx (CONFIRM_YESNO, "고객님께 사용계약서를\n발송하시겠습니까?") == MB_OK)
					{
						Rcv_62602();
					}
				}
				*/
				g_lCmContDocMoveFlag = 2;
				Mem_Set((byte*)g_szInstPlaceNum, 0x00, sizeof(g_szInstPlaceNum));
				Str_Cpy( g_szInstPlaceNum, stGm.USAGE_TITLE );
				Card_Move("CM_USEDOC_SEND");
				
				break;
			case BID_CHANGE:
				if(  MessageBoxEx (CONFIRM_YESNO, "전화 번호를 수정 하시겠습니까?")  == MB_OK )
				{
					if( !g_CheckPhoneNumber( "2",EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA7)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA9)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA11)) ))
					{
						MessageBoxEx (CONFIRM_OK, "고객님의 유선전화\n형식이 맞지않습니다.");
						break;
					}
					
					if ( !g_CheckPhoneNumber( "1",EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA12)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA14)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA16))) )
					{
						MessageBoxEx (CONFIRM_OK, "고객님의 무선전화\n형식이 맞지않습니다.");
						break;
					}
					
					SND_21362();	
				}
				break;
			case BID_OK:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( g_nGmType == 1 )
				{
					Card_Move("GM_REENTRY");
				}
				else
				{
					Card_Move("GM_ENTRY");
				}
				
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( g_Dlgflag == 0 )
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					if( MessageBoxEx (CONFIRM_YESNO, "검침 메뉴로 나가시겠습니까?")  == MB_OK)
					{
						Card_Move("GM_MENU");
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
				if( g_Dlgflag == 0 )
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					if( g_nGmType == 1 )
					{
						Card_Move("GM_REENTRY");
					}
					else
					{
						Card_Move("GM_ENTRY");
					}
				}
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			
			case BID_MOVING_CENT:
				
				Mem_Set( (byte*)g_szMC_InstPlaceNum, 0x00, sizeof(g_szMC_InstPlaceNum) );
				Str_Cpy( g_szMC_InstPlaceNum, stGm.INST_PLACE_NUM );
				
				g_lMC_MoveCard_Flag = 1;
				
				Card_Move("CM_MOVING_CENT");
				
				break;
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
	
//--------------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szDate[20];
		char szAddr[201];
		char szNum[30];
		char szTmp[20];
		char szEtc[20];
		long i;
		long lAddr = 0;
	
		//고객번호
		Mem_Set( (byte*)szNum, 0x00, sizeof(szNum) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szNum, (byte *)stGm.CUST_NUM, 5);
		Mem_Cpy((byte *)szTmp, (byte *)stGm.CUST_NUM+5, 5);
		Str_Cat(szNum, "-");
		Str_Cat(szNum, szTmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), szNum        );		
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stGm.CUST_NM         );		//고객명
		
		if( stGm.CUST_NUM[0] == '0')
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA1), RED);
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), RED);
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA1), TXTFRCOLOR);
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), TXTFRCOLOR);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), stGm.FIRM_NM         );		//상호명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stGm.SOC_NUM         );		//주민번호
		
		//사업자번호 , SubStr(BIZ_REGI_NUM,0,3)+'-'+SubStr(BIZ_REGI_NUM,3,2)+'-'+SubStr(BIZ_REGI_NUM,5,5)
		Mem_Set( (byte*)szNum, 0x00, sizeof(szNum) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szEtc, 0x00, sizeof(szEtc) );
		Mem_Cpy((byte *)szNum, (byte *)stGm.BIZ_REGI_NUM, 3);
		Mem_Cpy((byte *)szTmp, (byte *)stGm.BIZ_REGI_NUM+3, 2);
		Mem_Cpy((byte *)szEtc, (byte *)stGm.BIZ_REGI_NUM+5, 5);
		Str_Cat(szNum, "-");
		Str_Cat(szNum, szTmp);
		Str_Cat(szNum, "-");
		Str_Cat(szNum, szEtc);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), szNum        );		

		//주소
		Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr) );
		if( g_nAddrFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
		
			//기본주소
			Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
			if(Str_Len(stGm.TOWN) > 0)
			{
				Str_Cpy(szAddr,  stGm.TOWN );
			}
			else
			{
				Str_Cpy(szAddr,  "" );
			}
			if(Str_Len(stGm.VILLAGE) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.VILLAGE );
			}
			if(Str_Len(stGm.ADDR1_M) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.ADDR1_M);
			}			
			if(Str_Len(stGm.ADDR1_S) > 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.ADDR1_S);
			}
			Str_Cat(szAddr, "\n");
			//상세주소
			lAddr = Str_Len(stGm.CO_LIVE_NM);

			if( lAddr > 0 )
			{
				if( Str_Len(stGm.CO_LIVE_NM) > 0 )
				{
					Str_Cat(szAddr,  stGm.CO_LIVE_NM );
				}
				else
				{
					Str_Cat(szAddr,  "" );
				}
					
				if( Str_Len(stGm.BLD_NM) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.BLD_NM );
				}
				
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szAddr,  "-" );	
					Str_Cat(szAddr,  stGm.HOSU );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.DETA_FLOOR );		//세부층
				}
			}
			else
			{
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szAddr,  stGm.HOSU );
				}
				else
				{
					Str_Cat(szAddr,  "" );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.DETA_FLOOR );		//세부층
				}
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), szAddr);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
		
			//기본주소
			Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
			if(Str_Len(stGm.NEW_ROAD_NM) > 0)
			{
				Str_Cpy(szAddr,  stGm.NEW_ROAD_NM );
			}
			else
			{
				Str_Cpy(szAddr,  "" );
			}
			if(Str_Len(stGm.NEW_ADDR_M) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.NEW_ADDR_M);
			}
			if(Str_Len(stGm.NEW_ADDR_S) > 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.NEW_ADDR_S);
			}
			Str_Cat(szAddr, "\n");
			
			//상세주소
			Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
			if( Str_Len(stGm.CO_LIVE_NM) > 0 )
			{
				Str_Cpy(szAddr,  stGm.CO_LIVE_NM );
			}
			else
			{
				Str_Cpy(szAddr,  "" );
			}
			if( Str_Len(stGm.BLD_NM) > 0 )
			{
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.BLD_NM );
			}
			if( Str_Len(stGm.HOSU) > 0 )
			{
				Str_Cat(szAddr,  "-" );	
				Str_Cat(szAddr,  stGm.HOSU );
			}
			if( Str_Len(stGm.DETA_FLOOR) > 0 )
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.DETA_FLOOR );		//세부층
			}
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), szAddr);
		}
/*
		if( g_nAddrFlag == 0)
		{
			Str_Cpy(szAddr,  stGm.AREA );		//시군구
			
			if(Str_Len(stGm.TOWN) != 0)			//읍면동
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.TOWN );
			}
			if(Str_Len(stGm.ADDR1_M) == 0)		//본번
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.ADDR1_M);
			}			
			if(Str_Len(stGm.ADDR1_S) == 0)		//부번
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.ADDR1_S);
			}
			
			//조회화면에서의 주소
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.CO_LIVE_NM );	//공동주택명
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.BLD_NM );		//건물명
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DONG_NUM );	//동번호
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.HOSU );		//호수
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DETA_FLOOR );		//세부층
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), szAddr);
		}
		else
		{
			Str_Cpy(szAddr,  stGm.AREA );		//시군구
			
			if(Str_Len(stGm.NEW_ROAD_NM) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.NEW_ROAD_NM );
			}
			if(Str_Len(stGm.NEW_ADDR_M) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.NEW_ADDR_M);
			}
			if(Str_Len(stGm.NEW_ADDR_S) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.NEW_ADDR_S);
			}
			
			//조회화면에서의 주소
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.CO_LIVE_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.BLD_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DONG_NUM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.HOSU );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DETA_FLOOR );		//세부층
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), szAddr);
		}
*/
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), stGm.OWNHOUSE_TEL_DDD);		//자택전화_식별번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), stGm.OWNHOUSE_TEL_EXN);		//자택전화_국번
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), stGm.OWNHOUSE_TEL_NUM);		//자택전화_번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12),  stGm.CP_DDD          );		//휴대폰_식별번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14),  stGm.CP_EXN          );		//휴대폰_국번
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), stGm.CP_NUM          );		//휴대폰_번호
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), stGm.PAY_METHOD      );		//납부방법
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), stGm.SUPPLY_STS_CD);			//고객상태
		//격월
		if( Str_Cmp(stGm.GMTR_YM_FLAG, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "짝수월");
		}
		else if( Str_Cmp(stGm.GMTR_YM_FLAG, "30") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "홀수월");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "매월");
		}
		
		//사용계약번호
		Mem_Set( (byte*)szNum, 0x00, sizeof(szNum) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szNum, (byte *)stGm.USE_CONT_NUM, 5);
		Mem_Cpy((byte *)szTmp, (byte *)stGm.USE_CONT_NUM+5, 5);
		Str_Cat(szNum, "-");
		Str_Cat(szNum, szTmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), szNum        );		
		
		//계약일자
		if( Str_Cmp(stGm.CONT_YMD, "99991231") == 0 || Str_Cmp(stGm.CONT_YMD, "00000000") == 0 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), "");
		else
		{
			Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
			g_Str_DateType(szDate, stGm.CONT_YMD);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), szDate);
		}
		//해제일자
		if( Str_Cmp(stGm.CNL_YMD, "99991231") == 0 || Str_Cmp(stGm.CNL_YMD, "00000000") == 0 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), "");
		else
		{
			Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
			g_Str_DateType(szDate, stGm.CNL_YMD);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), szDate);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), stGm.PROD_CD);		//상품코드
	}
	
//--------------------------------------------------------------------------------------------
	void SND_21362(void)
	{
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		if(stGm.CUST_NUM[0] == '0' )
		{
			MessageBoxEx (CONFIRM_OK, "임시 고객은 수정할수 없습니다.");
			return;
		}
		
		Mem_Set( (byte*)stGm.CP_DDD, 0x00, sizeof(stGm.CP_DDD) );
		Mem_Set( (byte*)stGm.CP_EXN, 0x00, sizeof(stGm.CP_EXN) );
		Mem_Set( (byte*)stGm.CP_NUM, 0x00, sizeof(stGm.CP_NUM) );
		Mem_Set( (byte*)stGm.OWNHOUSE_TEL_DDD, 0x00, sizeof(stGm.OWNHOUSE_TEL_DDD) );
		Mem_Set( (byte*)stGm.OWNHOUSE_TEL_EXN, 0x00, sizeof(stGm.OWNHOUSE_TEL_EXN) );
		Mem_Set( (byte*)stGm.OWNHOUSE_TEL_NUM, 0x00, sizeof(stGm.OWNHOUSE_TEL_NUM) );
		
		Str_Cpy( stGm.OWNHOUSE_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA7)) );		//자택전화_식별번호
		Str_Cpy( stGm.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA9)) );		//자택전화_국번
		Str_Cpy( stGm.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA11)) );		//자택전화_번호
		Str_Cpy( stGm.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA12))           );		//휴대폰_식별번호
		Str_Cpy( stGm.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA14))           );		//휴대폰_국번
		Str_Cpy( stGm.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA16))           );		//휴대폰_번호
		
		if( !( ( Str_Len(stGm.OWNHOUSE_TEL_DDD) > 0 && Str_Len(stGm.OWNHOUSE_TEL_EXN) > 0 &&  Str_Len(stGm.OWNHOUSE_TEL_NUM) > 0 ) ||
			( Str_Len(stGm.OWNHOUSE_TEL_DDD) == 0 && Str_Len(stGm.OWNHOUSE_TEL_EXN) == 0 &&  Str_Len(stGm.OWNHOUSE_TEL_NUM) == 0 ) ) )
		{
			MessageBoxEx (CONFIRM_OK, "유선전화 입력을 확인해주세요.");
			return;
		}
		else if(!( ( Str_Len(stGm.CP_DDD) > 0 && Str_Len(stGm.CP_EXN) > 0 &&  Str_Len(stGm.CP_NUM) > 0 ) ||
			( Str_Len(stGm.CP_DDD) == 0 && Str_Len(stGm.CP_EXN) == 0 &&  Str_Len(stGm.CP_NUM) == 0 ) ))
		{
			MessageBoxEx (CONFIRM_OK, "무선전화 입력을 확인해주세요.");
			return;
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21362, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "cust_num",   stGm.CUST_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",   stGm.CP_DDD );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",   stGm.CP_EXN );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",   stGm.CP_NUM );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_ddd",   stGm.OWNHOUSE_TEL_DDD );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_exn",   stGm.OWNHOUSE_TEL_EXN );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_num",   stGm.OWNHOUSE_TEL_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		//g_Save_JsonFile(sndbuf);
		
		callBackfunc = TR21362; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR21362_IN",  "FR21362" , sndbuf, szbuf );		
		
	}
	
	long TR21362(void)
	{
	char szSql[200];
	long tot;
		
		g_Sock_Close();
		
		if(g_Chk_Json(21362) >= 0)
		{
			Save_Custinfo();
			return 0;
		}
		else
		{
			CloseMessageBox();
			return -1;
		}
	}
	
	
	/*=======================================================================================
	함수명 : Save_Custinfo
	기  능 : 고객정보를 저장한다.
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Custinfo(void)
	{
		char sztmp[100];
		long idx, ret;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
			
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nGmType == 1 )
		{
			hstmt = sql->CreateStatement(sql,
			"UPDATE REGUMDATA SET CP_DDD = ?, CP_EXN = ?, CP_NUM = ?,\
			 OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ?, OWNHOUSE_TEL_NUM = ?  WHERE CUST_NUM = ? " 
			);
		}
		else
		{
			hstmt = sql->CreateStatement(sql,
			"UPDATE GUMDATA SET CP_DDD = ?, CP_EXN = ?, CP_NUM = ?,\
			 OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ?, OWNHOUSE_TEL_NUM = ?  WHERE CUST_NUM = ? " 
			);
		}
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		
		sql->Bind(sql, idx++, 'U', (long *)stGm.CP_DDD	    ,4	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.CP_EXN		,4	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.CP_NUM		,4	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.OWNHOUSE_TEL_DDD		,4	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.OWNHOUSE_TEL_EXN		,4	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.OWNHOUSE_TEL_NUM		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.CUST_NUM	    ,10	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "수정이 완료 되었습니다.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
//-----------------------------------------------------------------------
	long Rcv_62602(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szbuf[128];
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char* sndbuf;
		long ret = 0;

		Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
		Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
		Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
		Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
		Str_Cpy(szPhoneNum, stGm.CP_DDD);
		Str_Cat(szPhoneNum, stGm.CP_EXN);
		Str_Cat(szPhoneNum, stGm.CP_NUM);
		ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
		if( ret < 0 )
		{
			MessageBoxEx (CONFIRM_OK, "전화번호를 확인해주세요.");
			return 0;
		}

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62602, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stGm.USE_CONT_NUM);
		JSON_SetValue( g_pjcomm, 'C', "cust_num", stGm.CUST_NUM);
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd", stGm.CP_DDD);
		JSON_SetValue( g_pjcomm, 'C', "cp_exn", stGm.CP_EXN);
		JSON_SetValue( g_pjcomm, 'C', "cp_num", stGm.CP_NUM);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SQL_ConvUcStr( szbuf, stGm.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm", szbuf);
				
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR62602; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR62602_IN",  "FR62602" , sndbuf, sztmp );
		return 0 ;
	}
	
//-----------------------------------------------------------------------
	long TR62602(void)
	{
		if( g_Chk_Json(62602) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "사용계약서 MMS발송신청에 완료하였습니다.");
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

	//---------------------------------------------------------------------------------------------
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 )
	{
	long len;
	
		Str_Chg(phone, STRCHG_DEL_NONDIGIT );
		len = Str_Len(phone);
		
		if( len == 9 )
		{
			Mem_Cpy( (byte*)num1, (byte*)phone,  2);
			Mem_Cpy( (byte*)num2, (byte*)phone+2,  3);
			Mem_Cpy( (byte*)num3, (byte*)phone+5,  4);
		}
		else if( len == 10 )
		{
			if( Mem_Cmp((byte*)phone, (byte*)"01", 2) == 0  )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else if(  Mem_Cmp((byte*)phone, (byte*)"02", 2) == 0 )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  2);
				Mem_Cpy( (byte*)num2, (byte*)phone+2,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
		}
		else if( len == 11 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+7,  4);
		}
		else if( len == 12 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  4);
				Mem_Cpy( (byte*)num2, (byte*)phone+4,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+8,  4);
		}
		else
		{
			return -1;
		}
		
		return 1;
	}
}


