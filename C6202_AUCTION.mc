/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_AUCTION
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_INFO1 )
		DEF_BUTTON_ID ( BID_INFO2 )
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_ETC )
		DEF_BUTTON_ID ( BID_OK )
//임차상세
		DEF_BUTTON_ID ( BID_CLOSE )
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
//경매정보2
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
		DEF_OBJECT_ID ( TXT_DATA32 )
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
		DEF_OBJECT_ID ( TXT_DATA46 )
		DEF_OBJECT_ID ( TXT_DATA47 )
		DEF_OBJECT_ID ( TXT_DATA48 )
		DEF_OBJECT_ID ( TXT_DATA49 )
		
//임차상세
		DEF_OBJECT_ID ( TXT_DATA50 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_SUB	2
	#define INIT_ETC    3
		
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

	typedef struct _AUCINFO
	{
		char LAWCOURT_EVENT_NUM[20];
		char CUST_NUM[20];
		char AUCTION_FLAG[20];
		char USAGE[30];
		char CITY[30];
		char AREA[30];
		char TOWN[30];
		char VILLAGE[30];
		char ADDR1_M[10];
		char ADDR1_S[10];
		char CO_LIVE_NM[30];
		char DONG_NUM[30];
		char HOSU[30];
		char ADDR[200];
		char LAW_TOWN[30];
		char NEW_ROAD_NM[30];
		char NEW_ADDR_M[10];
		char NEW_ADDR_S[10];
		char NEW_ADDR[200];
		char FINL_RSLT[10];
		char FINL_RSLT_YMD[30];
		char HOLD_BID_CNT[10];
		char JUDGE_YMD[30];
		char OWNER_REG_YMD[30];
		char DISTRIB_YMD[30];
		char STR_DECISION_YMD[30];
		char OK_BID_YMD[30];
		char DISTRIB_REQ_YMD[30];
		char BIDDING_YMD[30];
		char TRANS_IN_YMD[30];
		char CONF_YMD[30];
		char REQ_AMT[20];
		char RENT_WARR_AMT[20];
		char MM_RENT[20];
		char RENT_FLAG[10];
		char RENTER_NM[30];
		char ETC_RENT_DETA[950];
		char LAWCOURT_NM[30];
		char PROC_CNT[20];
	}	AUCINFO;
	
	AUCINFO	m_stAucInfo;

	
	long m_bFirst;
	long m_RcvFlag = 0;		//0 : 수신 , 1 : 수신받지않음 , 화면처음에 한번만 수신받도록.
	long m_lInitFlag = 0;	//0 : MAIN , 1 : SUB, 임차상세 확인 후 돌아올때 사용.
	
	void SetBtnImg(void);
	void SetStyle(void);
	void AddrDraw(void);
	void ReDraw(void);
	long SetStruct(long nservicenum);
	long Rcv_AucInfo(void);
	long TR82236(void);
	
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "경매정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "경매정보1"),
		DLG_BUTTON(STARTX+300,  STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "경매정보2"),
		DLG_BUTTON(STARTX,     STARTY+270, 230,120, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),

		DLG_TEXT(STARTX,        STARTY+30, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "경매번호"),
		DLG_TEXT(STARTX+230,    STARTY+30, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,        STARTY+90, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "경매구분"),
		DLG_TEXT(STARTX+230,    STARTY+90, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,       STARTY+150, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "고객번호"),
		DLG_TEXT(STARTX+230,   STARTY+150, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,       STARTY+210, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "용도"),
		DLG_TEXT(STARTX+230,   STARTY+210, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+230,   STARTY+270, 770,120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		
		DLG_TEXT(STARTX,       STARTY+390, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "최종결과"),
		DLG_TEXT(STARTX+230,   STARTY+390, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+510,   STARTY+390, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "결과일"),
		DLG_TEXT(STARTX+710,   STARTY+390, 295, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,       STARTY+450, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "유찰회수"),
		DLG_TEXT(STARTX+230,   STARTY+450, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+510,   STARTY+450, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "감정일"),
		DLG_TEXT(STARTX+710,   STARTY+450, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX,       STARTY+510, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "소유권"),
		DLG_TEXT(STARTX+230,   STARTY+510, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+510,   STARTY+510, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "배당일"),
		DLG_TEXT(STARTX+710,   STARTY+510, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX,       STARTY+570, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "개시예정"),
		DLG_TEXT(STARTX+230,   STARTY+570, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+510,   STARTY+570, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "낙찰일"),
		DLG_TEXT(STARTX+710,   STARTY+570, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX,       STARTY+630, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "배당요구"),
		DLG_TEXT(STARTX+230,   STARTY+630, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(STARTX+510,   STARTY+630, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "입찰일"),
		DLG_TEXT(STARTX+710,   STARTY+630, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "경매정보"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "경매정보1"),
		DLG_BUTTON(STARTX+400,  STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "경매정보2"),
		DLG_BUTTON(STARTX,     STARTY+270, 230,120, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),

		DLG_TEXT(STARTX,        STARTY+30, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "경매번호"),
		DLG_TEXT(STARTX+230,    STARTY+30, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,        STARTY+90, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "경매구분"),
		DLG_TEXT(STARTX+230,    STARTY+90, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,       STARTY+150, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "고객번호"),
		DLG_TEXT(STARTX+230,   STARTY+150, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,       STARTY+210, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "용도"),
		DLG_TEXT(STARTX+230,   STARTY+210, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+230,   STARTY+270, 770,120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		
		DLG_TEXT(STARTX,       STARTY+390, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "최종결과"),
		DLG_TEXT(STARTX+230,   STARTY+390, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+510,   STARTY+390, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "결과일"),
		DLG_TEXT(STARTX+710,   STARTY+390, 295, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,       STARTY+450, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "유찰회수"),
		DLG_TEXT(STARTX+230,   STARTY+450, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+510,   STARTY+450, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "감정일"),
		DLG_TEXT(STARTX+710,   STARTY+450, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX,       STARTY+510, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "소유권"),
		DLG_TEXT(STARTX+230,   STARTY+510, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+510,   STARTY+510, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "배당일"),
		DLG_TEXT(STARTX+710,   STARTY+510, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX,       STARTY+570, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "개시예정"),
		DLG_TEXT(STARTX+230,   STARTY+570, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+510,   STARTY+570, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "낙찰일"),
		DLG_TEXT(STARTX+710,   STARTY+570, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX,       STARTY+630, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "배당요구"),
		DLG_TEXT(STARTX+230,   STARTY+630, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(STARTX+510,   STARTY+630, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "입찰일"),
		DLG_TEXT(STARTX+710,   STARTY+630, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),
	};		
	

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Sub[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "경매정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,      STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "경매정보1"),
		DLG_BUTTON(STARTX+300,  STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "경매정보2"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),

		DLG_TEXT(STARTX,       STARTY+30, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "전입일자"),
		DLG_TEXT(STARTX+270,   STARTY+30, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX,       STARTY+90, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, "확정일자"),
		DLG_TEXT(STARTX+270,   STARTY+90, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(STARTX,      STARTY+150, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, "청구금액"),
		DLG_TEXT(STARTX+270,  STARTY+150, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX,      STARTY+210, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA36, "임차보증금"),
		DLG_TEXT(STARTX+270,  STARTY+210, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX,      STARTY+270, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA38, "월세금"),
		DLG_TEXT(STARTX+270,  STARTY+270, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX,      STARTY+330, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA40, "임차구분"),
		DLG_TEXT(STARTX+270,  STARTY+330, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX,      STARTY+390, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA42, "임차인명"),
		DLG_TEXT(STARTX+270,  STARTY+390, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		//DLG_TEXT(0,           STARTY+450, 260, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA44, "임차상세"),
		DLG_BUTTON(STARTX,    STARTY+450, 270, 260, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ETC, "임차상세"),
		DLG_TEXT(STARTX+270,  STARTY+450, 730, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),
		DLG_TEXT(STARTX,      STARTY+710, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA46, "법원"),
		DLG_TEXT(STARTX+270,  STARTY+710, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA47, ""),
		DLG_TEXT(STARTX,      STARTY+770, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA48, "진행회수"),
		DLG_TEXT(STARTX+270,  STARTY+770, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA49, ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Sub_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "경매정보"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,      STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "경매정보1"),
		DLG_BUTTON(STARTX+400,  STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "경매정보2"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),

		DLG_TEXT(STARTX,       STARTY+30, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "전입일자"),
		DLG_TEXT(STARTX+270,   STARTY+30, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX,       STARTY+90, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, "확정일자"),
		DLG_TEXT(STARTX+270,   STARTY+90, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(STARTX,      STARTY+150, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, "청구금액"),
		DLG_TEXT(STARTX+270,  STARTY+150, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX,      STARTY+210, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA36, "임차보증금"),
		DLG_TEXT(STARTX+270,  STARTY+210, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX,      STARTY+270, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA38, "월세금"),
		DLG_TEXT(STARTX+270,  STARTY+270, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX,      STARTY+330, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA40, "임차구분"),
		DLG_TEXT(STARTX+270,  STARTY+330, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX,      STARTY+390, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA42, "임차인명"),
		DLG_TEXT(STARTX+270,  STARTY+390, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		//DLG_TEXT(0,           STARTY+450, 260, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA44, "임차상세"),
		DLG_BUTTON(STARTX,    STARTY+450, 270, 260, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ETC, "임차상세"),
		DLG_TEXT(STARTX+270,  STARTY+450, 730, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),
		DLG_TEXT(STARTX,      STARTY+710, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA46, "법원"),
		DLG_TEXT(STARTX+270,  STARTY+710, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA47, ""),
		DLG_TEXT(STARTX,      STARTY+770, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA48, "진행회수"),
		DLG_TEXT(STARTX+270,  STARTY+770, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA49, ""),
	};		

	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Etc[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "임차상세"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+829, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "닫기"),

		DLG_TEXT(STARTX,     STARTY-29, 1000, 825, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA50, ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Etc_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "임차상세"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+829, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "닫기"),

		DLG_TEXT(STARTX,     STARTY-40, 1000, 850, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA50, ""),
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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				
				if( m_RcvFlag == 0 )
				{
					m_RcvFlag = 1;
					Rcv_AucInfo();
				}
				else
				{
					ReDraw();
				}
				break;
			case INIT_SUB:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Sub_P, SIZEOF(DlgRes_Sub_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Sub, SIZEOF(DlgRes_Sub));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				ReDraw();
				break;
			case INIT_ETC:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Etc_P, SIZEOF(DlgRes_Etc_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Etc, SIZEOF(DlgRes_Etc));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA50),  m_stAucInfo.ETC_RENT_DETA );
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{				
		switch(ID)
		{
			case BID_INFO1:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_INFO2:
				ON_EXIT();
				OnInit(INIT_SUB);
				break;
			case BID_ADDR:
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				AddrDraw();
				ON_DRAW();
				break;
			case BID_ETC:
				if( m_bFirst == INIT_MAIN )
				{
					m_lInitFlag = 0;
				}
				else
				{
					m_lInitFlag = 1;
				}
				
				ON_EXIT();
				OnInit(INIT_ETC);
				break;
			case BID_OK:
				Card_Move("C6202_NPACTIVE");
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
					Card_Move("C6202_MENU");
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
				Card_Move("C6202_NPACTIVE");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
//임차상세
			case BID_CLOSE:
				if( m_lInitFlag == 0 )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else if( m_lInitFlag == 1 )
				{
					ON_EXIT();
					OnInit(INIT_SUB);
				}
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA9), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_SUB )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA46), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA47), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA48), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA49), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA45), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_ETC )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA50), EDITALIGN_TOP);
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA50), TRUE, 2, EDITSEP_NONE );
		}
	}
	
//------------------------------------------------------------------
	long Rcv_AucInfo(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82236, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "cust_num",  stNoPayObj.CUST_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		//넘겨주는 item데이터 확인
		//g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82236; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR82236_IN",  "FR82236" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR82236(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82236) >= 0)
		{
			SetStruct(82236);
			ReDraw();
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
	long SetStruct(long nservicenum)
	{
	char szJsonpath[500];
	char szMsg[500];
	char szCol[950];
	char szDate[50];
	long *nCol;
	long nCnt = 0;
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		//MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
			  char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				ON_DRAW();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								Mem_Set((byte*)&m_stAucInfo, 0x00, sizeof(m_stAucInfo));

								//법원사건번호
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "lawcourt_event_num", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.LAWCOURT_EVENT_NUM , szCol);

								//경매구분
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "auction_flag", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.AUCTION_FLAG , szCol);

								//고객번호
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "cust_num", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.CUST_NUM , szCol);

								//용도
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "usage", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.USAGE , szCol);

								//시도
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "city", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.CITY , szCol);

								//시군구
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "area", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.AREA , szCol);

								//읍면동
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "town", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.TOWN , szCol);

								//리
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "village", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.VILLAGE , szCol);

								//지번_본번
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "addr1_m", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ADDR1_M , szCol);

								//지번_부번
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "addr1_s", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ADDR1_S , szCol);

								//공동주택명
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "co_live_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.CO_LIVE_NM , szCol);

								//동번호
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "dong_num", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.DONG_NUM , szCol);

								//호수
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "hosu", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.HOSU , szCol);

								//지번주소
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "addr", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ADDR , szCol);

								//법정동
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "law_town", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.LAW_TOWN , szCol);

								//도로명
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_road_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ROAD_NM , szCol);

								//새주소본번
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_addr_m", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ADDR_M , szCol);

								//새주소부번
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_addr_s", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ADDR_S , szCol);

								//새주소조합
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_addr", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ADDR , szCol);

								//최종결과
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "finl_rslt", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.FINL_RSLT , szCol);

								//최종결과일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "finl_rslt_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.FINL_RSLT_YMD , szDate);

								//유찰회수
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "hold_bid_cnt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Cpy(m_stAucInfo.HOLD_BID_CNT , szCol);

								//감정일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "judge_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.JUDGE_YMD , szDate);

								//소유자등기일
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "owner_reg_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.OWNER_REG_YMD , szDate);

								//배당일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "distrib_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.DISTRIB_YMD , szDate);

								//개시결정일
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "str_decision_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.STR_DECISION_YMD , szDate);

								//낙찰일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "ok_bid_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.OK_BID_YMD , szDate);

								//배당요구일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "distrib_req_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.DISTRIB_REQ_YMD , szDate);

								//입찰일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "bidding_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.BIDDING_YMD , szDate);

								//전입일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "trans_in_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.TRANS_IN_YMD , szDate);

								//확정일자
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "conf_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.CONF_YMD , szDate);

								//청구금액
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "req_amt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								Str_Chg(szCol, STRCHG_INS_COMMA);
								Str_Cpy(m_stAucInfo.REQ_AMT , szCol);

								//임차보증금
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "rent_warr_amt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								Str_Chg(szCol, STRCHG_INS_COMMA);
								Str_Cpy(m_stAucInfo.RENT_WARR_AMT , szCol);

								//월세금액
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "mm_rent", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								Str_Chg(szCol, STRCHG_INS_COMMA);
								Str_Cpy(m_stAucInfo.MM_RENT , szCol);

								//임차구분
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "rent_flag", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.RENT_FLAG , szCol);

								//임차자명
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "renter_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.RENTER_NM , szCol);

								//기타임차상세
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "etc_rent_deta", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ETC_RENT_DETA , szCol);
//PRINT("m_stAucInfo.ETC_RENT_DETA : %s",m_stAucInfo.ETC_RENT_DETA,0,0);

								//법원계명칭
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "lawcourt_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.LAWCOURT_NM , szCol);

								//진행횟수
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "proc_cnt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Cpy(m_stAucInfo.PROC_CNT , szCol);
							}

							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
			}
		}
		else
		{
			ret = 0;
		}
		
Finally:		
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}

//------------------------------------------------------------------
	void ReDraw(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO1), FALSE );		
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO2), TRUE );

			//경매번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2),  m_stAucInfo.LAWCOURT_EVENT_NUM );
			
			//경매구분
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4),  m_stAucInfo.AUCTION_FLAG );
			
			//고객번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6),  m_stAucInfo.CUST_NUM );
			
			//용도
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8),  m_stAucInfo.USAGE );

			//주소
			AddrDraw();
			
			//최종결과
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11),  m_stAucInfo.FINL_RSLT );
			
			//결과일
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13),  m_stAucInfo.FINL_RSLT_YMD );
			
			//유찰회수
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15),  m_stAucInfo.HOLD_BID_CNT );
			
			//감정일
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17),  m_stAucInfo.JUDGE_YMD );
			
			//소유권
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19),  m_stAucInfo.OWNER_REG_YMD );
			
			//배당일
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21),  m_stAucInfo.DISTRIB_YMD );
			
			//개시예정
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA23),  m_stAucInfo.STR_DECISION_YMD );
			
			//낙찰일
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA25),  m_stAucInfo.OK_BID_YMD );
			
			//배당요구
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA27),  m_stAucInfo.DISTRIB_REQ_YMD );
			
			//입찰일
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA29),  m_stAucInfo.BIDDING_YMD );
		}
		else if( m_bFirst == INIT_SUB )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO1), TRUE );		
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO2), FALSE );

			//전입일자
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA31),  m_stAucInfo.TRANS_IN_YMD );
			
			//확정일자
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA33),  m_stAucInfo.CONF_YMD );
			
			//청구금액
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA35),  m_stAucInfo.REQ_AMT );
			
			//임차보증금
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA37),  m_stAucInfo.RENT_WARR_AMT );
			
			//월세금
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA39),  m_stAucInfo.MM_RENT );
			
			//임차구분
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA41),  m_stAucInfo.RENT_FLAG );
			
			//임차인명
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA43),  m_stAucInfo.RENTER_NM );
			
			//임차상세
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA45),  m_stAucInfo.ETC_RENT_DETA );
			
			//법원
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA47),  m_stAucInfo.LAWCOURT_NM );
			
			//진행회수
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA49),  m_stAucInfo.PROC_CNT );
		}
		
		ON_DRAW();
		return;
	}

//------------------------------------------------------------------
	void AddrDraw(void)
	{
		char szTmp[400];
	
		//주소
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stNoPayObj.AREA);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.TOWN);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.VILLAGE);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.ADDR1_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.ADDR1_S);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주소");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stNoPayObj.NEW_ROAD_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.NEW_ADDR_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.NEW_ADDR_S);
		}
		
		if( ( Str_Len(stNoPayObj.CO_LIVE_NM) + Str_Len(stNoPayObj.BLD_NM) ) > 0 )
		{
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.CO_LIVE_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.BLD_NM);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.DETAIL_FLOOR);
		}
		else
		{
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.DETAIL_FLOOR);
		}
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9),  szTmp);

		return;
	}
}



