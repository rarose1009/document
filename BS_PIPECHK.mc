/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_PIPECHK
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

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CLOSE3 )
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_CHECK1 )
		DEF_BUTTON_ID ( BID_CHECK2 )
//매립배관점검
		DEF_BUTTON_ID ( BID_CLOSE )
		DEF_BUTTON_ID ( BID_CHECK3 )
		DEF_BUTTON_ID ( BID_BOX1 )		//체크박스버튼
		DEF_BUTTON_ID ( BID_BOX2 )
		DEF_BUTTON_ID ( BID_BOX3 )
		DEF_BUTTON_ID ( BID_BOX4 )
		DEF_BUTTON_ID ( BID_BOX5 )
		DEF_BUTTON_ID ( BID_BOX6 )
//은폐배관점검
		DEF_BUTTON_ID ( BID_CLOSE2 )
		DEF_BUTTON_ID ( BID_RESET )
		DEF_BUTTON_ID ( BID_CHECK4 )
		DEF_BUTTON_ID ( BID_BOX7 )		//체크박스버튼
		DEF_BUTTON_ID ( BID_BOX8 )
		DEF_BUTTON_ID ( BID_BOX9 )
		DEF_BUTTON_ID ( BID_BOX10 )
		DEF_BUTTON_ID ( BID_BOX11 )
		DEF_BUTTON_ID ( BID_BOX12 )
		DEF_BUTTON_ID ( BID_BOX13 )
		DEF_BUTTON_ID ( BID_BOX14 )
		DEF_BUTTON_ID ( BID_BOX15 )
		DEF_BUTTON_ID ( BID_BOX16 )
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
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
//매립배관점검
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
//은폐배관점검
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )

		DEF_OBJECT_ID ( ICON_TITLE)		//타이틀

		DEF_OBJECT_ID ( CMB_DATA1 ) 
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 			
	END_OBJECT_ID()
	
	#define INIT_MAIN		1
	#define INIT_LAYCHK	 	2
	#define INIT_HIDECHK 	3
		
	long m_bFirst;
	long m_lLayFlag = 0;
	long m_lHideFlag = 0;
	long m_lActiveIndex;
	
	char m_Pipe_Bury_Yn[3];
	char m_Pipe_Hide_Yn[3];
		
	void SetStyle(void);
	void SetBtnImg(void);
	void SetDataPipe(void);
	void Sel_Btn(long nBtnId);
	void REDRAW(void);
	void Clean_Data(void);
	bool Save_Pipe(long nbuttonid);			//매립, 은폐 배관 점검 저장
	bool Save_Result(void);
	bool Validate(void);
	void Del_PipeData(void);

	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "배관 점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE3, ""),

		DLG_BUTTON(STARTX+790,   STARTY-29, 210, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1, "점검"),
		DLG_BUTTON(STARTX+790,   STARTY+51, 210, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2, "점검"),
		DLG_BUTTON(STARTX,      STARTY+200, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE3, "닫기"),
		DLG_BUTTON(STARTX+600,  STARTY+200, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		DLG_TEXT ( STARTX,  STARTY-29, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "배관매립여부"),
		DLG_TEXT ( STARTX,  STARTY+51, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "배관은폐여부"),
		
		DLG_COMBO (STARTX+350,  STARTY-29, 440, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+350,  STARTY+51, 440, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};	
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "배관 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE3, ""),

		DLG_BUTTON(STARTX+800,   STARTY-40, 200, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1, "점검"),
		DLG_BUTTON(STARTX+800,   STARTY+60, 200, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2, "점검"),
		DLG_BUTTON(STARTX,      STARTY+200, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE3, "닫기"),
		DLG_BUTTON(STARTX+600,  STARTY+200, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		DLG_TEXT ( STARTX,  STARTY-40, 350, 100, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "배관매립여부"),
		DLG_TEXT ( STARTX,  STARTY+60, 350, 100, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "배관은폐여부"),
		
		DLG_COMBO (STARTX+350,  STARTY-40, 450, 200, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+350,  STARTY+60, 450, 200, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};	
	
	//  다이얼로그:매립배관점검
	//---------------------------------------------------------------
	DlgObject	DlgRes_LAYCHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "매립배관 점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,      STARTY+310, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "닫기"),
		DLG_BUTTON(STARTX+600,  STARTY+310, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "점검"),
		
		DLG_BUTTON(STARTX+550,   STARTY+41, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_BUTTON(STARTX+770,   STARTY+41, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+111, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3,  CHKOFF),
		DLG_BUTTON(STARTX+770,  STARTY+111, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+181, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX5,  CHKOFF),
		DLG_BUTTON(STARTX+770,  STARTY+181, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX6,  CHKOFF),
		
		DLG_TEXT ( STARTX,	     STARTY-29, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "점검항목"),
		DLG_TEXT ( STARTX+550,	 STARTY-29, 220, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "적"),
		DLG_TEXT ( STARTX+770,	 STARTY-29, 230, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "부"),
		DLG_TEXT ( STARTX,	     STARTY+41, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "가스누기"),
		DLG_TEXT ( STARTX,	    STARTY+111, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "다기능 가스계량기"),
		DLG_TEXT ( STARTX,	    STARTY+181, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "배관위치표시(스티커)"),
	};
	
	//  다이얼로그:매립배관점검
	//---------------------------------------------------------------
	DlgObject	DlgRes_LAYCHK_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "매립배관 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,      STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "닫기"),
		DLG_BUTTON(STARTX+600,  STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "점검"),
		
		DLG_BUTTON(STARTX+550,   STARTY+40, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_BUTTON(STARTX+775,   STARTY+40, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+120, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3,  CHKOFF),
		DLG_BUTTON(STARTX+775,  STARTY+120, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+200, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX5,  CHKOFF),
		DLG_BUTTON(STARTX+775,  STARTY+200, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX6,  CHKOFF),
		
		DLG_TEXT ( STARTX,	     STARTY-40, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "점검항목"),
		DLG_TEXT ( STARTX+550,	 STARTY-40, 225, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "적"),
		DLG_TEXT ( STARTX+775,	 STARTY-40, 225, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "부"),
		DLG_TEXT ( STARTX,	     STARTY+40, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "가스누기"),
		DLG_TEXT ( STARTX,	    STARTY+120, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "다기능 가스계량기"),
		DLG_TEXT ( STARTX,	    STARTY+200, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "배관위치표시(스티커)"),
	};
	
	//  다이얼로그:은폐배관점검
	//---------------------------------------------------------------
	DlgObject	DlgRes_HIDECHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "은폐배관 점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE2, ""),

		DLG_BUTTON(STARTX,      STARTY+500, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE2,  "닫기"),
		DLG_BUTTON(STARTX+333,	STARTY+500, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RESET,  "초기화"),
		DLG_BUTTON(STARTX+666,	STARTY+500, 334, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "점검"),
		
		DLG_BUTTON(STARTX+550,   STARTY+41, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX7 ,  CHKOFF),
		DLG_BUTTON(STARTX+770,   STARTY+41, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX8 ,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+111, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX9 ,  CHKOFF),
		DLG_BUTTON(STARTX+770,  STARTY+111, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX10,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+181, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX11,  CHKOFF),
		DLG_BUTTON(STARTX+770,  STARTY+181, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX12,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+251, 220, 100,0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX13,  CHKOFF),
		DLG_BUTTON(STARTX+770,  STARTY+251, 230, 100,0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX14,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+351, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX15,  CHKOFF),
		DLG_BUTTON(STARTX+770,  STARTY+351, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX16,  CHKOFF),
		
		DLG_TEXT ( STARTX,	    STARTY-29, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "점검항목"),
		DLG_TEXT ( STARTX+550,	STARTY-29, 220, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "적"),
		DLG_TEXT ( STARTX+770,	STARTY-29, 230, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "부"),
		DLG_TEXT ( STARTX,	    STARTY+41, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "가스누기"),
		DLG_TEXT ( STARTX,	   STARTY+111, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "다기능 가스계량기"),
		DLG_TEXT ( STARTX,	   STARTY+181, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "보호관및점검구"),
		DLG_TEXT ( STARTX,	   STARTY+251, 550, 100,0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "누출차단자동장치 \n 및 점검구"),
		DLG_TEXT ( STARTX,	   STARTY+351, 550, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "배관위치표시(스티커)"),
	};	
	
	//  다이얼로그:은폐배관점검
	//---------------------------------------------------------------
	DlgObject	DlgRes_HIDECHK_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "은폐배관 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE2, ""),

		DLG_BUTTON(STARTX,      STARTY+500, 333, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE2,  "닫기"),
		DLG_BUTTON(STARTX+333,	STARTY+500, 333, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RESET,  "초기화"),
		DLG_BUTTON(STARTX+666,	STARTY+500, 333, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "점검"),
		
		DLG_BUTTON(STARTX+550,   STARTY+40, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX7 ,  CHKOFF),
		DLG_BUTTON(STARTX+775,   STARTY+40, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX8 ,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+120, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX9 ,  CHKOFF),
		DLG_BUTTON(STARTX+775,  STARTY+120, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX10,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+200, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX11,  CHKOFF),
		DLG_BUTTON(STARTX+775,  STARTY+200, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX12,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+280, 225, 100,0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX13,  CHKOFF),
		DLG_BUTTON(STARTX+775,  STARTY+280, 225, 100,0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX14,  CHKOFF),
		DLG_BUTTON(STARTX+550,  STARTY+380, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX15,  CHKOFF),
		DLG_BUTTON(STARTX+775,  STARTY+380, 225, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX16,  CHKOFF),
		
		
		DLG_TEXT ( STARTX,	    STARTY-40, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "점검항목"),
		DLG_TEXT ( STARTX+550,	STARTY-40, 225, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "적"),
		DLG_TEXT ( STARTX+775,	STARTY-40, 225, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "부"),
		DLG_TEXT ( STARTX,	    STARTY+40, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "가스누기"),
		DLG_TEXT ( STARTX,	   STARTY+120, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "다기능 가스계량기"),
		DLG_TEXT ( STARTX,	   STARTY+200, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "보호관및점검구"),
		DLG_TEXT ( STARTX,	   STARTY+280, 550, 100,0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "누출차단자동장치 \n 및 점검구"),
		DLG_TEXT ( STARTX,	   STARTY+380, 550, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "배관위치표시(스티커)"),
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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				REDRAW();
				break;

			case INIT_LAYCHK:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_LAYCHK_P, SIZEOF(DlgRes_LAYCHK_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_LAYCHK, SIZEOF(DlgRes_LAYCHK));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				SetDataPipe();
				REDRAW();
				break;
				
			case INIT_HIDECHK:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_HIDECHK_P, SIZEOF(DlgRes_HIDECHK_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_HIDECHK, SIZEOF(DlgRes_HIDECHK));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				SetDataPipe();
				REDRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
	}
	
//-------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "Y", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "N", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "Y", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "N", 0, ICON_NONE);
		}
		else if( m_bFirst == INIT_LAYCHK )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		}
		else if( m_bFirst == INIT_HIDECHK )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA15), TRUE, 2, EDITSEP_NONE );
		}
	}
	
//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{	
			case BID_CHECK1:
				//m_lLayFlag = 1;
				ON_EXIT();
				OnInit(INIT_LAYCHK);
				break;
			case BID_CHECK2:
				//m_lHideFlag = 1;
				ON_EXIT();
				OnInit(INIT_HIDECHK);
				break;
			case BID_CLOSE3:
			/*
				if( g_lDataflag == 0 )
				{
					Del_PipeData();
				}
			*/
				if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
				{
					Del_PipeData();
				}

				Card_Move("BS_MTRCHK");
				break;
			case BID_OK:
				if( Save_Result() )
				{
					g_lSCMoveFlag = 1;
					g_lDataflag = 1;
					Card_Move("BS_MTRCHK");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
					{
						Del_PipeData();
					}
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
					if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
					{
						Del_PipeData();
					}
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
				if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
				{
					Del_PipeData();
				}

				Card_Move("BS_MTRCHK");
				break;	
			case GID_VMEXIT:
				if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
				{
					Del_PipeData();
				}
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Exit_DelBsData();
					return;
				}
				g_Exit();
				return;
				
			case BID_CLOSE:
			case BID_CLOSE2:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
				
			case BID_CHECK3:
			case BID_CHECK4:
				if( Save_Pipe(ID) )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
//체크박스_매립
			case BID_BOX1:
				Str_Cpy(stBsPipe.GAS_DAMP_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				break;
			case BID_BOX2:
				Str_Cpy(stBsPipe.GAS_DAMP_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				break;
			case BID_BOX3:
				Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				break;
			case BID_BOX4:
				Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				break;
			case BID_BOX5:
				Str_Cpy(stBsPipe.PIPE_LOC_MARK_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKOFF);
				break;
			case BID_BOX6:
				Str_Cpy(stBsPipe.PIPE_LOC_MARK_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKOFF);
				break;
//체크박스_은폐
			case BID_RESET:
				Clean_Data();
				break;
			case BID_BOX7:
				Str_Cpy(stBsPipe.GAS_DAMP_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX8), CHKOFF);
				break;
			case BID_BOX8:
				Str_Cpy(stBsPipe.GAS_DAMP_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX8), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKOFF);
				break;

			case BID_BOX9:
				Sel_Btn(ID);
				break;
			case BID_BOX10:
				Sel_Btn(ID);
				break;
			case BID_BOX11:
				Sel_Btn(ID);
				break;
			case BID_BOX12:
				Sel_Btn(ID);
				break;
			case BID_BOX13:
				Sel_Btn(ID);
				break;
			case BID_BOX14:
				Sel_Btn(ID);
				break;
			case BID_BOX15:
				Str_Cpy(stBsPipe.PIPE_LOC_MARK_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX15), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX16), CHKOFF);
				break;
			case BID_BOX16:
				Str_Cpy(stBsPipe.PIPE_LOC_MARK_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX16), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX15), CHKOFF);
				break;
		}
	}		
	
//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		char szSql[400];
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{	
			//매립여부
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_DATA1+1) )
			{
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), m_Pipe_Bury_Yn) != 0 )
				{
					g_lDataflag = 0;
				}
				
				Str_Cpy(m_Pipe_Bury_Yn, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
				if( Str_Cmp(m_Pipe_Bury_Yn, "Y") == 0 )
				{
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
				}
				else
				{
					Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
					SPRINT(szSql, " DELETE FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '10' "
									, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
					g_Sql_DirectExecute( szSql );
				
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK1), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
				}
			}

			//은폐여부
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_DATA2+1) )
			{
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), m_Pipe_Hide_Yn) != 0 )
				{
					g_lDataflag = 0;
				}
			
				Str_Cpy(m_Pipe_Hide_Yn, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)));
				if( Str_Cmp(m_Pipe_Hide_Yn, "Y") == 0 )
				{
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
				}
				else
				{
					Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
					SPRINT(szSql, " DELETE FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '20' "
									, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
					g_Sql_DirectExecute( szSql );
				
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
				}
			}
		}
	}

//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		m_lActiveIndex = -1;

		if( m_bFirst == INIT_MAIN )
		{
			//OSelect에서 은폐/매립배관 조건문 설정을위해.
			m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		}
	}
	
//-----------------------------------------------------------------	
//화면 초기화
	void Clean_Data(void)
	{
		Str_Cpy(stBsPipe.GAS_DAMP_YN , "");
		Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "");
		Str_Cpy(stBsPipe.PIPE_INSPEC_HOLE_YN , "");
		Str_Cpy(stBsPipe.CUTOFF_INSPEC_HOLE_YN , "");
		Str_Cpy(stBsPipe.PIPE_LOC_MARK_YN , "");
		
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX8), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX9), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX10), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX11), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX12), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX13), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX14), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX15), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX16), CHKOFF);
		
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), FALSE );
		
		return;
	}

//-----------------------------------------------------------------		
	void REDRAW(void)
	{
		char szSql[300];
		long lBuryCnt = 0;
		long lHideCnt = 0;
	
		if( m_bFirst == INIT_MAIN )
		{
			//배관매립여부
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG ='10' "
							, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
			g_Sql_RetInt(szSql, &lBuryCnt);
			
			//배관은폐여부
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG ='20' "
							, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
			g_Sql_RetInt(szSql, &lHideCnt);

			if( g_lDataflag == 1 )
			{
				//배관매립여부
				if( lBuryCnt > 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "Y" );
					Str_Cpy(m_Pipe_Bury_Yn, "Y");
					
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK1), RED);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "N" );
					Str_Cpy(m_Pipe_Bury_Yn, "N");
					
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK1), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
				}
				
				//배관은폐여부
				if( lHideCnt > 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "Y" );
					Str_Cpy(m_Pipe_Hide_Yn, "Y");
					
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), RED);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "N" );
					Str_Cpy(m_Pipe_Hide_Yn, "N");
					
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
				}
			}
			else
			{
				//배관매립여부
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), m_Pipe_Bury_Yn );
				if( Str_Cmp(m_Pipe_Bury_Yn, "Y") == 0 && lBuryCnt <= 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK1), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
				}
				else if( Str_Cmp(m_Pipe_Bury_Yn, "Y") == 0 && lBuryCnt > 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK1), RED);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
				}
				else // if( Str_Cmp(stBs.PIPE_BURY_YN, "N") == 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK1), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
				}
	
				//배관은폐여부
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), m_Pipe_Hide_Yn );
				if( Str_Cmp(m_Pipe_Hide_Yn, "Y") == 0 && lHideCnt <= 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
				}
				else if( Str_Cmp(m_Pipe_Hide_Yn, "Y") == 0 && lHideCnt > 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), RED);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
				}
				else // if( Str_Cmp(stBs.PIPE_HIDE_YN, "N") == 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
				}
			}
		}
		else if( m_bFirst == INIT_LAYCHK )
		{
			if( Str_Cmp(stBsPipe.GAS_DAMP_YN, "Y") == 0 )
			{
				OnButton(BID_BOX1);
			}
			else if( Str_Cmp(stBsPipe.GAS_DAMP_YN, "N") == 0 )
			{
				OnButton(BID_BOX2);
			}
			
			if( Str_Cmp(stBsPipe.MULTI_GAS_MTR_YN, "Y") == 0 )
			{
				OnButton(BID_BOX3);
			}
			else if( Str_Cmp(stBsPipe.MULTI_GAS_MTR_YN, "N") == 0 )
			{
				OnButton(BID_BOX4);
			}
			
			if( Str_Cmp(stBsPipe.PIPE_LOC_MARK_YN, "Y") == 0 )
			{
				OnButton(BID_BOX5);
			}
			else if( Str_Cmp(stBsPipe.PIPE_LOC_MARK_YN, "N") == 0 )
			{
				OnButton(BID_BOX6);
			}
		}
		else if( m_bFirst == INIT_HIDECHK )
		{
			if( Str_Cmp(stBsPipe.GAS_DAMP_YN, "Y") == 0 )
			{
				OnButton(BID_BOX7);
			}
			else if( Str_Cmp(stBsPipe.GAS_DAMP_YN, "N") == 0 )
			{
				OnButton(BID_BOX8);
			}
			
			
			if( Str_Cmp(stBsPipe.MULTI_GAS_MTR_YN, "Y") == 0 )
			{
				OnButton(BID_BOX9);
			}
			else if( Str_Cmp(stBsPipe.MULTI_GAS_MTR_YN, "N") == 0 )
			{
				OnButton(BID_BOX10);
			}
			if( Str_Cmp(stBsPipe.PIPE_INSPEC_HOLE_YN, "Y") == 0 )
			{
				OnButton(BID_BOX11);
			}
			else if( Str_Cmp(stBsPipe.PIPE_INSPEC_HOLE_YN, "N") == 0 )
			{
				OnButton(BID_BOX12);
			}
			if( Str_Cmp(stBsPipe.CUTOFF_INSPEC_HOLE_YN, "Y") == 0 )
			{
				OnButton(BID_BOX13);
			}
			else if( Str_Cmp(stBsPipe.CUTOFF_INSPEC_HOLE_YN, "N") == 0 )
			{
				OnButton(BID_BOX14);
			}
			
			
			if( Str_Cmp(stBsPipe.PIPE_LOC_MARK_YN, "Y") == 0 )
			{
				OnButton(BID_BOX15);
			}
			else if( Str_Cmp(stBsPipe.PIPE_LOC_MARK_YN, "N") == 0 )
			{
				OnButton(BID_BOX16);
			}
		}
	}
	
//-----------------------------------------------------------------	
	void SetDataPipe(void)
	{
		long i, idx;
		char szSql[400];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)&stBsPipe, 0x00, sizeof(stBsPipe));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( m_bFirst == INIT_LAYCHK )
		{
			SPRINT(szSql, "SELECT CHK_EXEC_NUM, CHK_YEAR, CHK_ORDER, CHK_TYPE, SPECIAL_NUM, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP \
			, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN, PIPE_INSPEC_HOLE_YN, CUTOFF_INSPEC_HOLE_YN, PIPE_LOC_MARK_YN \
				FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = ? AND MTR_NUM = ? AND PIPE_FLAG = '10'"
			, 0, 0, 0);
		}
		else if( m_bFirst == INIT_HIDECHK )
		{
			SPRINT(szSql, "SELECT CHK_EXEC_NUM, CHK_YEAR, CHK_ORDER, CHK_TYPE, SPECIAL_NUM, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP \
			, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN, PIPE_INSPEC_HOLE_YN, CUTOFF_INSPEC_HOLE_YN, PIPE_LOC_MARK_YN \
			FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = ? AND MTR_NUM = ? AND PIPE_FLAG = '20'"
			, 0, 0, 0);
		}

		hstmt = sql->CreateStatement(sql, szSql);		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCHK_EXEC_NUM , 12, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szMTR_NUM , 9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.CHK_EXEC_NUM			  , 20+ 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.CHK_YEAR               , 4 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.CHK_ORDER              , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.CHK_TYPE               , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.SPECIAL_NUM            , 20+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.MTR_NUM                , 9 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.CHK_YMD                , 8 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.UPD_EMPID              , 9 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.PDA_IP                 , 13+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.PIPE_FLAG              , 2 + 1, DECRYPT );

			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.GAS_DAMP_YN            , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.MULTI_GAS_MTR_YN       , 2 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.PIPE_INSPEC_HOLE_YN    , 2 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.CUTOFF_INSPEC_HOLE_YN  , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsPipe.PIPE_LOC_MARK_YN       , 2 + 1, DECRYPT );

		}
		//sql->Commit(sql);

Finally:
		
		DelSqLite(sql);
		return;
	}
	
//----------------------------------------------------------------------------
	bool Save_Pipe(long nbuttonid)
	{
		char szSql[500];
		char szChkYmd[10];
		long idx;
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

		
		Mem_Set( (byte*)szChkYmd, 0x00, sizeof(szChkYmd) );
		Str_ItoA(Time_GetDate(), szChkYmd, 10);
			
		if( nbuttonid == BID_CHECK3 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '10' ", g_szCHK_EXEC_NUM, stBsMtr.MTR_NUM, 0);
			g_Sql_RetInt( szSql, &lCnt );
		}
		else if( nbuttonid == BID_CHECK4 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '20' ", g_szCHK_EXEC_NUM, stBsMtr.MTR_NUM, 0);
			g_Sql_RetInt( szSql, &lCnt );
		}


		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		if( lCnt > 0 )
		{
			if( nbuttonid == BID_CHECK3 )
			{
				SPRINT(szSql, "UPDATE SPECIAL_PIPE_CHK_DATA SET \
				GAS_DAMP_YN = ?, MULTI_GAS_MTR_YN = ?, PIPE_LOC_MARK_YN = ?  \
				, CHK_YEAR = ?, CHK_ORDER = ?, CHK_TYPE = ?, SPECIAL_NUM = ?, MTR_NUM = ?, CHK_YMD = ?, UPD_EMPID = ?, PDA_IP = ?, SEND_YN = 'S' \
				WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '10' "
				, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
			}
			else if( nbuttonid == BID_CHECK4 )
			{
				SPRINT(szSql, "UPDATE SPECIAL_PIPE_CHK_DATA SET \
				GAS_DAMP_YN = ?, MULTI_GAS_MTR_YN = ?, PIPE_INSPEC_HOLE_YN = ?, CUTOFF_INSPEC_HOLE_YN = ?, PIPE_LOC_MARK_YN = ? \
				, CHK_YEAR = ?, CHK_ORDER = ?, CHK_TYPE = ?, SPECIAL_NUM = ?, MTR_NUM = ?, CHK_YMD = ?, UPD_EMPID = ?, PDA_IP = ?, SEND_YN = 'S' \
				WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '20' "
				, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
			}
		}
		else
		{
			if( nbuttonid == BID_CHECK3 )
			{
				SPRINT(szSql, "INSERT INTO SPECIAL_PIPE_CHK_DATA \
				(CHK_EXEC_NUM, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN, PIPE_LOC_MARK_YN, CHK_YEAR, CHK_ORDER \
				, CHK_TYPE, SPECIAL_NUM, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP, SEND_YN ) \
				VALUES(?, '10', ?, ?, ?, ?, ?, ?, ?, ? \
					 , ?, ?, ?, 'S') "
				, 0, 0, 0);
			}
			else if( nbuttonid == BID_CHECK4 )
			{
				SPRINT(szSql, "INSERT INTO SPECIAL_PIPE_CHK_DATA \
				(CHK_EXEC_NUM, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN, PIPE_INSPEC_HOLE_YN, CUTOFF_INSPEC_HOLE_YN \
				, PIPE_LOC_MARK_YN, CHK_YEAR, CHK_ORDER, CHK_TYPE, SPECIAL_NUM, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP, SEND_YN ) \
				VALUES(?, '20', ?, ?, ?, ?, ?, ?, ?, ? \
					 , ?, ?, ?, ?, ?, 'S' )"
				, 0, 0, 0);
			}
		}

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		if( lCnt > 0 )
		{
			if( nbuttonid == BID_CHECK3 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.GAS_DAMP_YN			   ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.MULTI_GAS_MTR_YN	       ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.PIPE_LOC_MARK_YN	       ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_YEAR                    ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_ORDER                   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_TYPE                    ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_NUM                 ,20 ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsMtr.MTR_NUM                  ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)szChkYmd                         ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id         ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip              ,13 ,DECRYPT);
			}
			else if( nbuttonid == BID_CHECK4 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.GAS_DAMP_YN				,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.MULTI_GAS_MTR_YN		    ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.PIPE_INSPEC_HOLE_YN		,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.CUTOFF_INSPEC_HOLE_YN	,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.PIPE_LOC_MARK_YN		    ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_YEAR                     ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_ORDER                    ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_TYPE                     ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_NUM                  ,20 ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsMtr.MTR_NUM                   ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)szChkYmd                          ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id          ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip               ,13 ,DECRYPT);
			}
		}
		else
		{
			if( nbuttonid == BID_CHECK3 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM				   ,20	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.GAS_DAMP_YN			   ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.MULTI_GAS_MTR_YN		   ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.PIPE_LOC_MARK_YN		   ,2	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_YEAR                    ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_ORDER                   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_TYPE                    ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_NUM                 ,20 ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)g_szMTR_NUM                      ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)szChkYmd                         ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id         ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip              ,13 ,DECRYPT);
			}
			else if( nbuttonid == BID_CHECK4 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM				   ,20 ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.GAS_DAMP_YN			   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.MULTI_GAS_MTR_YN		   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.PIPE_INSPEC_HOLE_YN	   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.CUTOFF_INSPEC_HOLE_YN   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBsPipe.PIPE_LOC_MARK_YN		   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_YEAR                    ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_ORDER                   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_TYPE                    ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_NUM                 ,20 ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)g_szMTR_NUM                      ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)szChkYmd                         ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id         ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip              ,13 ,DECRYPT);
			}
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			if( nbuttonid == BID_CHECK3 )
			{
				//m_lLayFlag = 1;
				MessageBoxEx (CONFIRM_OK, "매립배관점검이 완료되었습니다.");
			}
			else if( nbuttonid == BID_CHECK4 )
			{
				//m_lHideFlag = 1;
				MessageBoxEx (CONFIRM_OK, "은폐배관점검이 완료되었습니다.");
			}
		}
		
		//sql->Commit(sql);
Finally:
		
		DelSqLite(sql);
		return ret;
	}

//----------------------------------------------------------------------------
	bool Save_Result(void)
	{
		char szSql[500];
		char szChkYmd[10];
		long lCount;
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( !Validate() )
			return FALSE;

		Str_ItoA(Time_GetDate(), szChkYmd, 10);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					PIPE_BURY_YN = ?, PIPE_HIDE_YN = ?, CHK_YEAR = ?, CHK_ORDER = ?, CHK_TYPE = ? \
					, SPECIAL_NUM = ?, CHK_YMD = ?, UPD_EMPID = ?, PDA_IP = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)m_Pipe_Bury_Yn	               ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)m_Pipe_Hide_Yn	               ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_YEAR                    ,4  ,DECRYPT);	
		sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_ORDER                   ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_TYPE                    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_NUM                 ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)szChkYmd                         ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id         ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip              ,15 ,DECRYPT);


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

//----------------------------------------------------------------------------
	bool Validate(void)
	{
		long lCount = 0;
		char szSql[300];
	
		if( m_bFirst == INIT_MAIN )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "매립배관여부를 입력해주세요.");
				return FALSE;
			}
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "은폐배관여부를 입력해주세요.");
				return FALSE;
			}
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG ='10' "
							, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
			g_Sql_RetInt(szSql, &lCount);
			if( Str_Cmp(m_Pipe_Bury_Yn, "Y") == 0 && lCount <= 0 )
			//if( Str_Cmp(stBs.PIPE_BURY_YN, "Y") == 0 && m_lLayFlag == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "매립배관점검을 하시기 바랍니다.");
				return FALSE;
			}
			
			lCount = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG ='20' "
							, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
			g_Sql_RetInt(szSql, &lCount);
			if( Str_Cmp(m_Pipe_Hide_Yn, "Y") == 0 && lCount <= 0 )
			//if( Str_Cmp(stBs.PIPE_HIDE_YN, "Y") == 0 && m_lHideFlag == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "은폐배관점검을 하시기 바랍니다.");
				return FALSE;
			}
		}
		else if( m_bFirst == INIT_LAYCHK )
		{
			if( Str_Cmp(stBsPipe.GAS_DAMP_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "가스누기 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stBsPipe.MULTI_GAS_MTR_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "다기능가스계량기 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stBsPipe.PIPE_LOC_MARK_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관위치표시 항목을 선택하세요.");
				return FALSE;
			}
		}
		else if( m_bFirst == INIT_HIDECHK )
		{
			if( Str_Cmp(stBsPipe.GAS_DAMP_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "가스누기 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stBsPipe.MULTI_GAS_MTR_YN, "") == 0 && Str_Cmp(stBsPipe.PIPE_INSPEC_HOLE_YN, "") == 0 
			&& Str_Cmp(stBsPipe.CUTOFF_INSPEC_HOLE_YN, "") == 0)
			{
				MessageBoxEx (CONFIRM_OK, "안전조치방법 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stBsPipe.PIPE_LOC_MARK_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관위치표시 항목을 선택하세요.");
				return FALSE;
			}
		}

		return TRUE;
	}
	
//----------------------------------------------------------------------------
	void Sel_Btn(long nBtnId)
	{
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX9), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX10), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX11), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX12), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX13), CHKOFF);
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX14), CHKOFF);
		
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), TRUE );
		
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), FALSE );
		DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), FALSE );

		if( nBtnId == BID_BOX9 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX9), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), FALSE );
			
			Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "Y");
			Str_Cpy(stBsPipe.PIPE_INSPEC_HOLE_YN , "");
			Str_Cpy(stBsPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX10 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX10), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), FALSE );
			
			Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "N");
			Str_Cpy(stBsPipe.PIPE_INSPEC_HOLE_YN , "");
			Str_Cpy(stBsPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX11 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX11), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), FALSE );
			
			Str_Cpy(stBsPipe.PIPE_INSPEC_HOLE_YN , "Y");
			Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stBsPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX12 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX12), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), FALSE );
			
			Str_Cpy(stBsPipe.PIPE_INSPEC_HOLE_YN , "N");
			Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stBsPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX13 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX13), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), FALSE );
			
			Str_Cpy(stBsPipe.CUTOFF_INSPEC_HOLE_YN , "Y");
			Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stBsPipe.PIPE_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX14 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX14), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), FALSE );
			
			Str_Cpy(stBsPipe.CUTOFF_INSPEC_HOLE_YN , "N");
			Str_Cpy(stBsPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stBsPipe.PIPE_INSPEC_HOLE_YN , "");
		}
		
		ON_DRAW();
		return;
	}
	
	
//----------------------------------------------------------------------------------
	void Del_PipeData(void)
	{
		char szSql[300];
	
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '10' "
						, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
		g_Sql_DirectExecute( szSql );
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '20' "
						, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
		g_Sql_DirectExecute( szSql );
	}
	
}
