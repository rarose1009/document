/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_JOJUNGCHKTGT
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CHECK1 )	//
		DEF_BUTTON_ID ( BID_CHECK2 )	//
		DEF_BUTTON_ID ( BID_CHECK3 )	//
		DEF_BUTTON_ID ( BID_BARCODE )	//바코드
		DEF_BUTTON_ID ( BID_SIGN )		//서명
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
		DEF_OBJECT_ID ( TXT_JJGNUM )		//조정기번호
		DEF_OBJECT_ID ( TXT_JUNSOO )		//전수
		DEF_OBJECT_ID ( TXT_WORKTYPE )		//작업구분
		DEF_OBJECT_ID ( TXT_FORM )			//형태
		DEF_OBJECT_ID ( TXT_MODELNM )		//모델명
		DEF_OBJECT_ID ( TXT_JJGSN )			//조정기S/N
		DEF_OBJECT_ID ( TXT_FILTERCHNG )	//필터교체유무
		DEF_OBJECT_ID ( TXT_ETC )			//특이사항
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
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_FILTERCHNG ) 	
		DEF_OBJECT_ID ( CMB_ETC = CMB_FILTERCHNG+3 ) 			
		DEF_OBJECT_ID ( CMB_BARCODE = CMB_ETC+3 )
	END_OBJECT_ID()
	

	#define INIT_MAIN	1

	long m_bFirst;
	long m_lActiveIndex = -1;
	char m_szBarcode_Value[20];	//바코드 스캔 결과

	void SetStyle(void);
	void SetCombo(void);
	void SetBtnImg(void);
	void REDRAW(void);
	bool Save_Result(void);
	void Del_Sc(void);
	bool Validate(void);
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	void Barcode(void);
	void OnBarcodeRead(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "조정기 점검(공동)"),

		DLG_BUTTON(STARTX+600, STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서명"),
		
		DLG_TEXT(STARTX,      STARTY+65, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "조정기번호"), 
		DLG_TEXT(STARTX+300,  STARTY+65, 325, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+625,  STARTY+65, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "전수"),
		DLG_TEXT(STARTX+825,  STARTY+65, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,      STARTY+125, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "작업구분"), 
		DLG_TEXT(STARTX+300,  STARTY+125, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,      STARTY+185, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "형태"), 
		DLG_TEXT(STARTX+300,  STARTY+185, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,      STARTY+245, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODELNM, "모델명"), 
		DLG_TEXT(STARTX+300,  STARTY+245, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,      STARTY+305, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "조정기S/N"),
		DLG_TEXT(STARTX+300,  STARTY+305, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT(STARTX,      STARTY+400, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "작동상태"),
		DLG_TEXT(STARTX+350,  STARTY+400, 425, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 
		DLG_BUTTON(STARTX+775,STARTY+400, 225, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1, "점검"),
		DLG_TEXT(STARTX,      STARTY+460, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "가스누출여부"),
		DLG_TEXT(STARTX+350,  STARTY+460, 425, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_BUTTON(STARTX+775,STARTY+460, 225, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2, "점검"),
		DLG_TEXT(STARTX,      STARTY+520, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "조정기"),
		DLG_TEXT(STARTX+350,  STARTY+520, 425, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_BUTTON(STARTX+775,STARTY+520, 225, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3, "점검"),
		DLG_TEXT(STARTX,      STARTY+580, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "출구압력"),
		DLG_EDIT(STARTX+350,  STARTY+580, 425, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA1, 10,  ""),
		DLG_TEXT(STARTX+775,  STARTY+580, 225, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, "kpa"),
		DLG_TEXT(STARTX,      STARTY+640, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERCHNG, "필터교체유무"),
		DLG_COMBO (STARTX+350,STARTY+640, 650, 290, 225, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_FILTERCHNG, 10),
		DLG_TEXT(STARTX,      STARTY+700, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ETC, "특이사항"),
		DLG_COMBO (STARTX+350,STARTY+700, 650, 290, 225, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ETC, 10),
		
//		DLG_BUTTON(STARTX,    STARTY+660, 350, 120, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "바코드"),
//		DLG_TEXT(STARTX+350,  STARTY+660, 625, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
//		DLG_COMBO (STARTX+350,STARTY+720, 625, 290, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),

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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "조정기 점검(공동)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+600, STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서명"),
		
		DLG_TEXT(STARTX,       STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "조정기번호"), 
		DLG_TEXT(STARTX+300,   STARTY-40, 325, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+625,   STARTY-40, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "전수"),
		DLG_TEXT(STARTX+825,   STARTY-40, 175, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,       STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "작업구분"), 
		DLG_TEXT(STARTX+300,   STARTY+30, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,      STARTY+100, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "형태"), 
		DLG_TEXT(STARTX+300,  STARTY+100, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,      STARTY+170, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODELNM, "모델명"), 
		DLG_TEXT(STARTX+300,  STARTY+170, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,      STARTY+240, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "조정기S/N"),
		DLG_TEXT(STARTX+300,  STARTY+240, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,      STARTY+310, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "작동상태"),
		DLG_TEXT(STARTX+350,  STARTY+310, 425, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 
		DLG_BUTTON(STARTX+775,STARTY+310, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1, "점검"),
		DLG_TEXT(STARTX,      STARTY+380, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "가스누출여부"),
		DLG_TEXT(STARTX+350,  STARTY+380, 425, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_BUTTON(STARTX+775,STARTY+380, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2, "점검"),
		DLG_TEXT(STARTX,      STARTY+450, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "조정기"),
		DLG_TEXT(STARTX+350,  STARTY+450, 425, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""), 
		DLG_BUTTON(STARTX+775,STARTY+450, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3, "점검"),
		DLG_TEXT(STARTX,      STARTY+520, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "출구압력"),
		DLG_EDIT(STARTX+350,  STARTY+520, 425, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA1, 5,  ""),
		DLG_TEXT(STARTX+775,  STARTY+520, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, "Kpa"),
		DLG_TEXT(STARTX,      STARTY+590, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERCHNG, "필터교체유무"),
		DLG_COMBO (STARTX+350,STARTY+590, 650, 290, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_FILTERCHNG, 10),
		DLG_TEXT(STARTX,      STARTY+660, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ETC, "특이사항"),
		DLG_COMBO (STARTX+350,STARTY+660, 650, 290, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ETC, 10),
		
//		DLG_BUTTON(STARTX,     STARTY+650, 350, 120, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "바코드"),
//		DLG_TEXT(STARTX+350,   STARTY+650, 625, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
//		DLG_COMBO (STARTX+350, STARTY+710, 625, 290, 80, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),
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
				SetCombo();
				SetStyle();
				REDRAW();
				break;
		}
	}
	
	//------------------------------------------------------------------------
	void	OnKey(long nKey)
	{
		long nIndiVc = 0;
		long nBefo_IndiVc = 0;
		long nRet = 0;
		
		if( nKey == 5 && m_bFirst == INIT_MAIN )
		{
			Str_Cpy(stScJjChk.SECOND_PRESS, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		}
	}
	
	//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nIndiVc = 0;
		long nBefo_IndiVc = 0;
		long nRet = 0;
		
		if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex && m_bFirst == INIT_MAIN)
		{
			Str_Cpy(stScJjChk.SECOND_PRESS, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		}
		
		//숫자만 입력 가능
		if( (nChar < 48 ||  nChar > 57) && Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex && m_bFirst == INIT_MAIN)
		{
			MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
			EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
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
		
		if( m_bFirst == INIT_MAIN )
		{
			m_lActiveIndex = lActiveIndex;
			
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+580-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+640-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )			
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
					//		ShowSip(FALSE);
					//		g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
					//		ShowSip(TRUE);
					//		g_Sipflag = 1;
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
				}
				
				ON_DRAW();
			}
		}
	}
	
/*=======================================================================================
========================================================================================*/	
	void	OnSelect(long Index)
	{
		long i = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			//필터교체유무
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG)), SCFLTCHG );
			if (i == -1)
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "");
			else
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, SCFLTCHG[i].Code);
			//특이사항
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC)), SCRMK );
			if (i == -1)
				Str_Cpy(stScJjChk.SPECIAL_ETC, "");
			else
				Str_Cpy(stScJjChk.SPECIAL_ETC, SCRMK[i].Code);
/*
			//바코드불가이유
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), SCBARWHY );
			if (i == -1)
				Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");
			else
				Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY[i].Code);
*/
		}
	}

//-----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char* ptr;
		long nRet = 0;
		
		if(nEvent == TASK_SYS_CALL && nData == TASK_BARCODE )
		{
			//카메라 바코드 스캔 값
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			ptr = (char*)System_GetResult((char*)&nRet);
			Str_Cpy(m_szBarcode_Value, ptr);

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				OnBarcodeRead();
			}
		}
	}

//-----------------------------------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		if( m_bFirst == INIT_MAIN )
		{
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
		}
	}
	
//-----------------------------------------------------------------	
	void SetCombo(void)
	{
		long i;

		//필터교체유무
		for ( i = 0 ;  SCFLTCHG[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_FILTERCHNG+2), SCFLTCHG[i].Str, 0, ICON_NONE);
		}
		
		//특이사항
		for ( i = 0 ;  SCRMK[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ETC+2), SCRMK[i].Str, 0, ICON_NONE);
		}
/*
		//바코드
		for ( i = 0 ;  SCBARWHY[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BARCODE+2), SCBARWHY[i].Str, 0, ICON_NONE);
		}
*/
	}
	
	//-----------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN)
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JUNSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODELNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGSN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FILTERCHNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ETC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_FILTERCHNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ETC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BARCODE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
		}
	}
	
	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long i;

		switch(ID)
		{
			case BID_CHECK1:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				g_nWorkChkFlag = 30;
				Str_Cpy( stScJjNogood.REGTR_NOT_PASS_FLAG, "20");
				Str_Cpy( stScJjChk.REG1_RSLT, "Y");
				Card_Move("CHK_JOJUNGDTL");
				break;
			case BID_CHECK2:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				g_nWorkChkFlag = 30;
				Str_Cpy( stScJjNogood.REGTR_NOT_PASS_FLAG, "30");
				Str_Cpy( stScJjChk.REG2_RSLT, "Y");
				Card_Move("CHK_JOJUNGDTL");
				break;
			case BID_CHECK3:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				g_nWorkChkFlag = 30;
				Str_Cpy( stScJjNogood.REGTR_NOT_PASS_FLAG, "40");
				Str_Cpy( stScJjChk.REG3_RSLT, "Y");
				Card_Move("CHK_JOJUNGDTL");
				break;
/*
			case BID_BARCODE:
				if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE))) > 0 )
				{
					MessageBoxEx (CONFIRM_OK, "바코드 또는 바코드미점검사유 중 하나만 입력 가능합니다.");
				}
				else
				{
					Barcode();
				}
				break;
*/
			case BID_SIGN:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				if( Save_Result() )
				{
					g_nBackFlag++;
					
					if( g_nBackFlag > 9)
					{
						g_Db_Backup();
						g_nBackFlag = 0;
					}
				
					if( g_nWorkFlag != 203 )
						Card_Move("SC_CONFIRM");
					else
						Card_Move("SC_JOJUNGLST");
				}
				break;		
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
					if( g_nWorkFlag == 101 )
					{
						g_nWorkFlag = 100;
					}
					if( Str_Cmp( stScJjChk.CHK_END_YN, "N") == 0 || Str_Cmp(stScJjChk.CHK_END_YN, "") == 0 )
					{
						Del_Sc();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				if( MessageBoxEx (CONFIRM_YESNO, "조정기점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
					if( g_nWorkFlag == 101 )
					{
						g_nWorkFlag = 100;
					}
					if( Str_Cmp( stScJjChk.CHK_END_YN, "N") == 0 || Str_Cmp(stScJjChk.CHK_END_YN, "") == 0 )
					{
						Del_Sc();
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
			
				if( m_bFirst == INIT_MAIN )
				{
					if( Str_Cmp( stScJjChk.CHK_END_YN, "N") == 0 || Str_Cmp(stScJjChk.CHK_END_YN, "") == 0 )
					{
						Del_Sc();
					}
					Card_Move("SC_JOJUNGLST");
				}
				else
				{
					ON_EXIT()
					OnInit(INIT_MAIN);
				}
				
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				Del_Sc();
				g_Exit();
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
			{
				return i;
			}
		}
		return -1;
	}

/*=======================================================================================
함수명 : REDRAW
기  능 : 검침 자료를 읽어와서 화면에 설정한다.
Param  : 
Return : 
========================================================================================*/
	void REDRAW(void)
	{
		char szSql[300];
		char szAddr[300];
		char sztmp[50];
		long i;

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1 ), g_szREGTR_NUM);	//조정기 번호
		
		//SPRINT(szSql, "SELECT COUNT(*) FROM REGTR_DATA WHERE REGTR_NUM = '%s'",g_szREGTR_NUM, 0, 0   );
		//g_Sql_RetStr( szSql, 10, sztmp );
		//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2 ), sztmp);		//전수(계량기 갯수)
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2 ), stScJjChk.MTRCNT);  //전수(계량기 갯수)
		
		//작업구분
		i = SearchCD( stScJjChk.GENER_REGTR_CHK_FLAG, SCWORK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), SCWORK[i].Str);
		
		//형태
		if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "10") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4 ), "단독");
		}
		else if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4 ), "공동");
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5 ), stScJjChk.REGTR_MODEL_NM);  //모델명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6 ), stScJjChk.REGTR_ID_NUM);	  //조정기S/N
		
		//작동상태 부적합결과
		if( stScJjChk.REG1_RSLT[0] == 'Y' )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8 ), "양호");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8 ), TXTFRCOLOR);
		}
		else if( stScJjChk.REG1_RSLT[0] == 'N')
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8 ), "부적합");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8 ), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8 ), "미점검");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8 ), TXTFRCOLOR);
		}
		//가스누출여부 부적합결과
		if( stScJjChk.REG2_RSLT[0] == 'Y' )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10 ), "양호");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA10 ), TXTFRCOLOR);
		}
		else if( stScJjChk.REG2_RSLT[0] == 'N')
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10 ), "부적합");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA10 ), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10 ), "미점검");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA10 ), TXTFRCOLOR);
		}
		//조정기 부적합결과
		if( stScJjChk.REG3_RSLT[0] == 'Y' )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12 ), "양호");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA12 ), TXTFRCOLOR);
		}
		else if( stScJjChk.REG3_RSLT[0] == 'N')
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12 ), "부적합");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA12 ), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12 ), "미점검");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA12 ), TXTFRCOLOR);
		}
				
		//출구압력
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stScJjChk.SECOND_PRESS);

		//필터교체유무
		if( Str_Len(stScJjChk.FILTER_REPL_FLAG) == 0 )
		{
			if(Str_Cmp(stScJjChk.GENER_REGTR_CHK_FLAG, "10") == 0)
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "20");
			else
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "30");
		}
		
		i = SearchCD( stScJjChk.FILTER_REPL_FLAG, SCFLTCHG );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG), SCFLTCHG[i].Str);

		//특이사항
		i = SearchCD( stScJjChk.SPECIAL_ETC, SCRMK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ETC), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ETC), SCRMK[i].Str);
					
/*
		//바코드
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), stScJjChk.CURR_BAR);
		if( Str_Len( stScJjChk.CURR_BAR ) == 0)
		{
			//바코드 미점검 이유
			if( Str_Len( stScJjChk.BAR_NOT_PERMIT_WHY ) == 0 )
			{
				Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "10");
			}
			i = SearchCD( stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY );
			if( i == -1 )
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");
			else
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), SCBARWHY[i].Str);
		}
*/

		ON_DRAW();
	}


//-----------------------------------------------------------------	
	bool Validate(void)
	{
		if( Str_Cmp( stScJjChk.CHK_END_YN, "Y") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "이미 송신 완료한 자료입니다.");
			return FALSE;
		}
		
		if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8)), "미점검") == 0 ||
			Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA10)), "미점검") == 0 ||
			Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA12)), "미점검") == 0 ) 
		{
			MessageBoxEx (CONFIRM_OK, "점검을 완료 하지 않았습니다.");
			return FALSE;
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "출구압력을 입력해주세요.");
			return FALSE;
		}
	
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "특이사항을 선택해주세요.");
			return FALSE;
		}
/*
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8))) == 0
		&&  Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "바코드를 스캔해 주세요.");
			return FALSE;
		}
*/
		return TRUE;
	}
	
//-----------------------------------------------------------------
	bool Save_Result(void)
	{
		char szSql[500];
		long lCount;
		long idx;
		long i, lsign, lSign_Len;
		bool ret = TRUE;
		char*pRst;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//서명
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
//		lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명" );
		lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명", SIGN_OPT_NONE );
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			ret = FALSE;
			goto Finally;
		}
		else
		{
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
			//fd= FFS_Open ( "BASE64_Encode.txt", FS_WRITE_MODE , FS_CREATE_FLAG );
			//FFS_Write(fd, (byte*)pRst, Str_Len(pRst) );
			//FFS_Close(fd);
		}

		//출구압력
		Mem_Set( (byte*)stScJjChk.SECOND_PRESS, 0x00, sizeof(stScJjChk.SECOND_PRESS) );
		Str_Cpy(stScJjChk.SECOND_PRESS, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));

		//점검종료		
		Str_ItoA(  Time_GetDate(), stScJjChk.CHK_END_DTM, 10 );
		Str_Cpy( stScJjChk.CHK_YMD,stScJjChk.CHK_END_DTM );
		g_Str_TimeType( stScJjChk.CHK_END_DTM+8 , Time_GetTime() );
		
		//필터교체유무
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG)), SCFLTCHG );
		if (i == -1)
			Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "");
		else
			Str_Cpy(stScJjChk.FILTER_REPL_FLAG, SCFLTCHG[i].Code);
		
		//특이사항
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC)), SCRMK );
		if (i == -1)
			Str_Cpy(stScJjChk.SPECIAL_ETC, "");
		else
			Str_Cpy(stScJjChk.SPECIAL_ETC, SCRMK[i].Code);
			
/*
		//바코드 
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), SCBARWHY );
		if (i == -1)
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");
		else
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY[i].Code);
		//바코드
		Str_Cpy( stScJjChk.CURR_BAR, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA15)) );
*/

		//점검결과
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s'", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
						
		Str_Cpy(stScJjChk.CHK_END_YN, "S");
		 
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
			Str_Cpy(stScJjChk.CHK_RSLT, "21");
		else
			Str_Cpy(stScJjChk.CHK_RSLT, "20");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

/*
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE REGTR_DATA SET \
CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ?, CURR_BAR = ? \
, BAR_NOT_PERMIT_WHY = ?, CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ?, SPECIAL_ETC = ? \
, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_SIGN_IMAGE=? \
WHERE REGTR_NUM = ? ", 0, 0, 0);
*/

		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE REGTR_DATA SET \
CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ? , CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ? \
, SPECIAL_ETC = ?, REG1_RSLT = ?, REG2_RSLT = ?, REG3_RSLT = ?, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_SIGN_IMAGE=? \
WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ?", 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_YN        ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_STR_DTM       ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_DTM       ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,9	,DECRYPT);
		//sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CURR_BAR          ,20	,DECRYPT);
		//sql->Bind(sql, idx++, 'U', (long *)stScJjChk.BAR_NOT_PERMIT_WHY,6	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_YMD           ,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.FILTER_REPL_FLAG  ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SECOND_PRESS      ,5	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SPECIAL_ETC       ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG1_RSLT         ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG2_RSLT         ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG3_RSLT         ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor         ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_RSLT          ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)pRst			               ,Str_Len(pRst) ,DECRYPT);

		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM               ,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM		       ,6	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	       ,2	,DECRYPT);
		

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "점검이 완료되었습니다.");
		}
		
Finally:
		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}


	
//-----------------------------------------------------------------	
	void Barcode(void)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;

		//2017-08-22 Sanghyun Lee
		//카메라 바코드(스마트폰 전용) & 빔 바코드 구분 사용 추가(설정은 공통메뉴에서 진행)
		if( Str_Cmp(g_szBarcodeSet, PHOTO_BARCODE) == 0 && theDevInfo.m_nType > FAMILY_PDA )
		{
			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				JSON_SetValue	(hdata	, 'C', "desc"				, "카메라바코드");
				JSON_SetValue	(hdata	, 'C', "imgSaveEnabled"		, "false");						//{true, false}
				JSON_SetValue	(hdata	, 'C', "imgOutPath"			, "Barcode/barcode.jpg");		//Smart 하위 경로만 설정
				
				JSON_SetValue	(h		, 'C', "method"				, "BarcodeActivity");
				
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
		else
		{
			//스마트폰 -> Barcode_Init, Barcode_Exit 필요 ,, PDA -> Barcode_Init, Barcode_Exit 불필요 
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				Barcode_Init();
			}

			ret = Barcode_SendCommand( "start" );
		}

		return;
	}

//-----------------------------------------------------------------	
	void OnBarcodeRead(void)
	{
		long ret = 0;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			ret = Barcode_Read( m_szBarcode_Value );	
			if( ret < 0)
			{
				MessageBoxEx (ERROR_OK, "바코드 읽기 실패");
			}
		}

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), m_szBarcode_Value ) ;

		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}

		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	함수명 : Del_Sc
	기  능 : 점검취소
	Param  : 
	Return :
	========================================================================================*/
	void Del_Sc(void)
	{
		char szSql[300];

		//부적합사항
		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s'", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		g_Sql_DirectExecute( szSql );
		return;
	}
}

