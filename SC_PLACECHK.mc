/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_PLACECHK
	Card Desc : 안전점검시작_설치장소점검
	Card Hist :
----------------------------------------------------------------------------------*/

card SC_PLACECHK
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
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		// 화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		// 홈
		DEF_BUTTON_ID ( BID_MENU )		// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )	// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	// 공통업무
		DEF_BUTTON_ID ( BID_PREV )		// 이전
		DEF_BUTTON_ID ( BID_EXIT )		// 종료
		
		// 설치장소점검
		DEF_BUTTON_ID ( BID_CHECK1 )	// 내외관 점검
		DEF_BUTTON_ID ( BID_CHECK2 )	// 배관매립여부 점검
		DEF_BUTTON_ID ( BID_CHECK3 )	// 배관은폐여부 점검
		DEF_BUTTON_ID ( BID_OK )		// 저장
		DEF_BUTTON_ID ( BID_CLOSE )		// 닫기
		
		// 매립배관점검
		DEF_BUTTON_ID ( BID_CLOSE2 )	// 닫기
		DEF_BUTTON_ID ( BID_CHECK5 )	// 점검
		DEF_BUTTON_ID ( BID_BOX1 )		// 가스누기_적
		DEF_BUTTON_ID ( BID_BOX2 )		// 가스누기_부
		DEF_BUTTON_ID ( BID_BOX3 )		// 다기능 가스계량기_적
		DEF_BUTTON_ID ( BID_BOX4 )		// 다기능 가스계량기_부
		DEF_BUTTON_ID ( BID_BOX5 )		// 배관위치표시_적
		DEF_BUTTON_ID ( BID_BOX6 )		// 배관위치표시_부
		
		// 은폐배관점검
		DEF_BUTTON_ID ( BID_CLOSE3 )	// 닫기
		DEF_BUTTON_ID ( BID_RESET )		// 초기화
		DEF_BUTTON_ID ( BID_CHECK6 )	// 점검
		DEF_BUTTON_ID ( BID_BOX7 )		// 가스누기_적
		DEF_BUTTON_ID ( BID_BOX8 )		// 가스누기_부
		DEF_BUTTON_ID ( BID_BOX9 )		// 다기능가스계량기_적
		DEF_BUTTON_ID ( BID_BOX10 )		// 다기능가스계량기_부
		DEF_BUTTON_ID ( BID_BOX11 )		// 보호관및점검구_적
		DEF_BUTTON_ID ( BID_BOX12 )		// 보호관및점검구_부
		DEF_BUTTON_ID ( BID_BOX13 )		// 누출차단자동장치 및 점검구_적
		DEF_BUTTON_ID ( BID_BOX14 )		// 누출차단자동장치 및 점검구_부
		DEF_BUTTON_ID ( BID_BOX15 )		// 배관위치표시_적
		DEF_BUTTON_ID ( BID_BOX16 )		// 배과위치표시_부
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		// 타이틀
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		
		// 설치장소점검
		DEF_OBJECT_ID ( TXT_DATA1 )		// 내외관
		DEF_OBJECT_ID ( TXT_DATA2 )		// 내외관 결과
		DEF_OBJECT_ID ( TXT_DATA3 )		// 자율점검
		DEF_OBJECT_ID ( TXT_DATA4 )		// 홍보물
		DEF_OBJECT_ID ( TXT_DATA5 )		// 누출차단기
		DEF_OBJECT_ID ( TXT_DATA6 )		// CO감지기
		DEF_OBJECT_ID ( TXT_DATA7 )		// 배관도색상태
		DEF_OBJECT_ID ( TXT_DATA8 ) 	// 배관매립여부
		DEF_OBJECT_ID ( TXT_DATA9 ) 	// 배관은폐여부
		
		DEF_OBJECT_ID ( TXT_CO_ALARM ) 			// CO경보기설치여부
		
		// 매립배관점검
		DEF_OBJECT_ID ( TXT_DATA22 )	// 점검항목
		DEF_OBJECT_ID ( TXT_DATA23 )	// 적
		DEF_OBJECT_ID ( TXT_DATA24 )	// 부
		DEF_OBJECT_ID ( TXT_DATA25 )	// 가스누기	
		DEF_OBJECT_ID ( TXT_DATA28 )	// 다기능 가스계량기
		DEF_OBJECT_ID ( TXT_DATA31 )	// 배관위치표시
		
		// 은폐배관점검
		DEF_OBJECT_ID ( TXT_DATA34 )	// 점검항목
		DEF_OBJECT_ID ( TXT_DATA35 )	// 적
		DEF_OBJECT_ID ( TXT_DATA36 )	// 부
		DEF_OBJECT_ID ( TXT_DATA37 )	// 가스누기
		DEF_OBJECT_ID ( TXT_DATA40 )	// 다기능 가스계량기
		DEF_OBJECT_ID ( TXT_DATA43 )	// 보호관 및 점검구
		DEF_OBJECT_ID ( TXT_DATA46 )	// 누축차단자동장치 및 점검구
		DEF_OBJECT_ID ( TXT_DATA49 )	// 배관위치표시
		
		// 라인
		DEF_OBJECT_ID ( LINE_DATA_1 )				// 라인_1
		
		// 콤보박스
		DEF_OBJECT_ID ( CMB_DATA1 ) 				// 자율점검
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )	// 홍보물
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 ) 	// 누출차단기
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 ) 	// CO감지기
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4+3 ) 	// 배관도색상태
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA5+3 ) 	// 배관매립여부
		DEF_OBJECT_ID ( CMB_DATA7 = CMB_DATA6+3 ) 	// 배관은폐여부
		DEF_OBJECT_ID ( CMB_CO_ALARM = CMB_DATA7+3 )	// CO경보기설치여부
	END_OBJECT_ID()

	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN		1
	#define INIT_LAYCHK	 	2
	#define INIT_HIDECHK 	3
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_bFirst;
	long m_lActiveIndex;
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetStyle(void);
	void SetBtnImg(void);
	void SetCombo(void);
	void Sel_Btn(long nBtnId);
	void SetDataPipe(void);
	void REDRAW(void);
	void Clean_Data(void);
	bool Save_Pipe(long nbuttonid);	
	bool Save_Result(void);
	bool Validate(void);
	bool Chk_PipeRslt(long nButtonId);
	
	//---------------------------------------------------------------
	// 공통버튼
	//---------------------------------------------------------------	
	SysButCtrl SysButRes_MAIN[] =
	{
		SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
		SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
		SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0 ),
		SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	
	//-----------------------------------------------------------------
	//	main entry map
	//-----------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------------------------------
	// 설치장소 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON (0, BTNY_2, ICON_TITLE, ""),
		DLG_TEXT (TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "설치장소 점검"),
		
		DLG_TEXT ( STARTX,	    STARTY  +65, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "내·외관"),
		DLG_TEXT ( STARTX +400, STARTY  +65, 350,  70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_BUTTON(STARTX +750, STARTY  +65, 250,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHECK1, "점검"),
		
		DLG_TEXT ( STARTX,	    STARTY +135, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "자율점검"),
		DLG_COMBO (STARTX +400, STARTY +135, 600, 200, 250, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		
		DLG_TEXT ( STARTX,	    STARTY +205, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "홍보물"),
		DLG_COMBO (STARTX +400, STARTY +205, 600, 200, 250, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		
		DLG_TEXT ( STARTX,	    STARTY +275, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "누출차단기"),
		DLG_COMBO (STARTX +400, STARTY +275, 600, 200, 250, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		
		DLG_TEXT ( STARTX,	    STARTY +345, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CO_ALARM, "CO경보기"),
		DLG_COMBO (STARTX +400, STARTY +345, 600, 200, 250, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CO_ALARM, 10),
			
		DLG_TEXT ( STARTX,      STARTY +415, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "배관도색상태"),
		DLG_COMBO (STARTX +400, STARTY +415, 600, 200, 250, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 10),
		
		DLG_TEXT ( STARTX,      STARTY +485, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "배관매립여부"),
		DLG_COMBO (STARTX +400, STARTY +485, 350, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 10),
		DLG_BUTTON(STARTX +750, STARTY +485, 250,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHECK2, "점검"),
		
		DLG_TEXT ( STARTX,      STARTY +555, 400,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "배관은폐여부"),
		DLG_COMBO (STARTX +400, STARTY +555, 350, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 10),
		DLG_BUTTON(STARTX +750, STARTY +555, 250,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHECK3, "점검"),
		
		DLG_LINE ( STARTX,      STARTY +824, 1000, STARTY +824, DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_BUTTON(STARTX,      STARTY +829, 500,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLOSE, "닫기"),
		DLG_BUTTON(STARTX +500, STARTY +829, 500,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_OK, "저장"),	
	};
	
	//---------------------------------------------------------------------------------------
	// 매립배관점검 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_LAYCHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "매립배관 점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE2, ""),
		
		DLG_TEXT ( STARTX,	   STARTY-29 , 550, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "점검항목"),
		DLG_TEXT ( STARTX+550, STARTY-29 , 220, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, "적"),
		DLG_TEXT ( STARTX+770, STARTY-29 , 230, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "부"),
		
		DLG_TEXT ( STARTX,	   STARTY+41 , 550, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA25, "가스누기"),
		DLG_BUTTON(STARTX+550, STARTY+41 , 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+41 , 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),
		
		DLG_TEXT ( STARTX,	   STARTY+111, 550, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "다기능 가스계량기"),
		DLG_BUTTON(STARTX+550, STARTY+111, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+111, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4,  CHKOFF),
		
		DLG_BUTTON(STARTX,     STARTY+350, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE2,  "닫기"),
		DLG_BUTTON(STARTX+600, STARTY+350, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK5,  "점검"),
		
		DLG_TEXT ( STARTX,	   STARTY+181, 550, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA31, "배관위치표시(스티커)"),
		DLG_BUTTON(STARTX+550, STARTY+181, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX5,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+181, 230, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX6,  CHKOFF),
	};
	//---------------------------------------------------------------------------------------
	// 은폐배관점검 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_HIDECHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "은폐배관 점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE3, ""),
		
		DLG_TEXT ( STARTX,	   STARTY-29 , 550,  70, 0 ,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, "점검항목"),
		DLG_TEXT ( STARTX+550, STARTY-29 , 220,  70, 0 ,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA35, "적"),
		DLG_TEXT ( STARTX+770, STARTY-29 , 230,  70, 0 ,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA36, "부"),
		
		DLG_TEXT ( STARTX,	   STARTY+41 , 550,  70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA37, "가스누기"),
		DLG_BUTTON(STARTX+550, STARTY+41 , 220,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX7 ,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+41 , 230,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX8 ,  CHKOFF),
		
		DLG_TEXT ( STARTX,	   STARTY+111, 550,  70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA40, "다기능 가스계량기"),
		DLG_BUTTON(STARTX+550, STARTY+111, 220,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX9 ,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+111, 230,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX10,  CHKOFF),
		
		DLG_TEXT ( STARTX,	   STARTY+181, 550,  70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA43, "보호관및점검구"),
		DLG_BUTTON(STARTX+550, STARTY+181, 220,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX11,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+181, 230,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX12,  CHKOFF),
		
		DLG_TEXT ( STARTX,	   STARTY+251, 550, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA46, "누출차단자동장치 \n 및 점검구"),
		DLG_BUTTON(STARTX+550, STARTY+251, 220, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX13,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+251, 230, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX14,  CHKOFF),
		
		DLG_TEXT ( STARTX,	   STARTY+351, 550,  70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA49, "배관위치표시(스티커)"),
		DLG_BUTTON(STARTX+550, STARTY+351, 220,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX15,  CHKOFF),
		DLG_BUTTON(STARTX+770, STARTY+351, 230,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX16,  CHKOFF),
		
		DLG_BUTTON(STARTX,	   STARTY+500, 333,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE3,  "닫기"),
		DLG_BUTTON(STARTX+333, STARTY+500, 333,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RESET,  "초기화"),
		DLG_BUTTON(STARTX+666, STARTY+500, 334,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK6,  "점검"),
	};
	
	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : OnInit
	기  능 : 최초 시작
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit(char bFirst)
	{
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));

				if(g_lSCMoveFlag == 1)
				{
					Card_Load("SC_START");
					return;
				}
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				REDRAW();
				break;
				
			case INIT_LAYCHK:

				CREATE_DIALOG_OBJECT (DlgRes_LAYCHK, SIZEOF(DlgRes_LAYCHK));
					
				SetBtnImg();
				SetDataPipe();
				SetStyle();
				
				if( Str_Cmp(stScPipe.GAS_DAMP_YN, "N") == 0 )
				{
					OnButton(BID_BOX2);
				}
				else if( Str_Cmp(stScPipe.GAS_DAMP_YN, "Y") == 0 )
				{
					OnButton(BID_BOX1);
				}
				if( Str_Cmp(stScPipe.MULTI_GAS_MTR_YN, "N") == 0 )
				{
					OnButton(BID_BOX4);
				}
				else if( Str_Cmp(stScPipe.MULTI_GAS_MTR_YN, "Y") == 0 )
				{
					OnButton(BID_BOX3);
				}
				if( Str_Cmp(stScPipe.PIPE_LOC_MARK_YN, "N") == 0 )
				{
					OnButton(BID_BOX6);
				}
				else if( Str_Cmp(stScPipe.PIPE_LOC_MARK_YN, "Y") == 0 )
				{
					OnButton(BID_BOX5);
				}
				break;
				
			case INIT_HIDECHK:

				CREATE_DIALOG_OBJECT (DlgRes_HIDECHK, SIZEOF(DlgRes_HIDECHK));
								
				SetBtnImg();
				SetDataPipe();
				SetStyle();
				
				if( Str_Cmp(stScPipe.GAS_DAMP_YN, "N") == 0 )
				{
					OnButton(BID_BOX8);
				}
				else if( Str_Cmp(stScPipe.GAS_DAMP_YN, "Y") == 0 )
				{
					OnButton(BID_BOX7);
				}
				
				if( Str_Cmp(stScPipe.MULTI_GAS_MTR_YN, "N") == 0 )
				{
					OnButton(BID_BOX10);
				}
				else if( Str_Cmp(stScPipe.MULTI_GAS_MTR_YN, "Y") == 0 )
				{
					OnButton(BID_BOX9);
				}
				
				if( Str_Cmp(stScPipe.PIPE_INSPEC_HOLE_YN, "N") == 0 )
				{
					OnButton(BID_BOX12);
				}
				else if( Str_Cmp(stScPipe.PIPE_INSPEC_HOLE_YN, "Y") == 0 )
				{
					OnButton(BID_BOX11);
				}
				
				if( Str_Cmp(stScPipe.CUTOFF_INSPEC_HOLE_YN, "N") == 0 )
				{
					OnButton(BID_BOX14);
				}
				else if( Str_Cmp(stScPipe.CUTOFF_INSPEC_HOLE_YN, "Y") == 0 )
				{
					OnButton(BID_BOX13);
				}
				
				if( Str_Cmp(stScPipe.PIPE_LOC_MARK_YN, "N") == 0 )
				{
					OnButton(BID_BOX16);
				}
				else if( Str_Cmp(stScPipe.PIPE_LOC_MARK_YN, "Y") == 0 )
				{
					OnButton(BID_BOX15);
				}
				break;
		}		
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{
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
				if( MessageBoxEx (CONFIRM_YESNO, "SOS 긴급호출을 하시겠습니까?") == MB_OK )
				{
					g_Send_SOS(1);
				}

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
			
			case BID_CHECK1:
				g_nWorkChkFlag = 10;
				g_lSCMoveFlag = 1;
				Str_Cpy(stScNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stScNogood.CHK_SEC_CD, "40");
				Str_Cpy(stScNogood.MTR_NUM, "");
				Str_Cpy(stScNogood.BURNER_NUM, "");
				Str_Cpy(stScNogood.CHK_SEC_NM, "배관");
				Card_Move("CHK_DTL");
				break;
				
			case BID_CHECK2:
				if( Chk_PipeRslt(ID) )
				{
					ON_EXIT();
					OnInit(INIT_LAYCHK);
				}
				break;
				
			case BID_CHECK3:
				if( Chk_PipeRslt(ID) )
				{
					ON_EXIT();
					OnInit(INIT_HIDECHK);
				}
				break;
				
			case BID_OK:				
				if( Save_Result() )
				{
					Card_Move("SC_START");
				}
				break;
				
			case BID_CLOSE:
				Card_Move("SC_START");
				break;
			
//팝업창 버튼
			case BID_CLOSE2:
			case BID_CLOSE3:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;	
	
			case BID_CHECK5:			//매립
			case BID_CHECK6:			//은폐
				if( Save_Pipe(ID) )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_RESET:				//은폐초기화
				Clean_Data();
				break;
//체크박스_매립
			case BID_BOX1:
				Str_Cpy(stScPipe.GAS_DAMP_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				break;
			case BID_BOX2:
				Str_Cpy(stScPipe.GAS_DAMP_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				break;
			case BID_BOX3:
				Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				break;
			case BID_BOX4:
				Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				break;
			case BID_BOX5:
				Str_Cpy(stScPipe.PIPE_LOC_MARK_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKOFF);
				break;
			case BID_BOX6:
				Str_Cpy(stScPipe.PIPE_LOC_MARK_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKOFF);
				break;
//체크박스_은폐
			case BID_BOX7:
				Str_Cpy(stScPipe.GAS_DAMP_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX8), CHKOFF);
				break;
			case BID_BOX8:
				Str_Cpy(stScPipe.GAS_DAMP_YN , "N");
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
				Str_Cpy(stScPipe.PIPE_LOC_MARK_YN , "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX15), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX16), CHKOFF);
				break;
			case BID_BOX16:
				Str_Cpy(stScPipe.PIPE_LOC_MARK_YN , "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX16), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX15), CHKOFF);
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnSelect
	기  능 : 콤보박스 선택
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		char szSql[400];
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{	
			//자율점검
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SCSELF );
			if (i == -1)
			{
				Str_Cpy(stSc.SELF_CHK_YN, "");
			}
			else
			{
				Str_Cpy(stSc.SELF_CHK_YN, SCSELF[i].Code);
			}
			
			//홍보물
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), SCADV );
			if (i == -1)
			{
				Str_Cpy(stSc.ADV_DIST_YN, "");
			}
			else
			{
				Str_Cpy(stSc.ADV_DIST_YN, SCADV[i].Code);
			}
	
			//누출차단기
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), SCLK_CO );
			if (i == -1)
			{
				Str_Cpy(stSc.LK_BREAKER, "");
			}
			else
			{
				Str_Cpy(stSc.LK_BREAKER, SCLK_CO[i].Code);
			}
			/*
			//CO감지기
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)), SCLK_CO );
			if (i == -1)
			{
				Str_Cpy(stSc.CO_SENSOR, "");
			}
			else
			{
				Str_Cpy(stSc.CO_SENSOR, SCLK_CO[i].Code);
			}
			*/
			//CO경보기
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CO_ALARM)), SCCOALARM );
			if (i == -1)
			{
				Str_Cpy(stSc.CO_ALARM_INST_YN, "");
			}
			else
			{
				Str_Cpy(stSc.CO_ALARM_INST_YN, SCCOALARM[i].Code);
			}
			
			//배관도색상태
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5)), SCCOLOR );
			if (i == -1)
			{
				Str_Cpy(stSc.PIPE_COLOR_STS, "");
			}
			else
			{
				Str_Cpy(stSc.PIPE_COLOR_STS, SCCOLOR[i].Code);
			}

			//매립여부
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_DATA6+1) )
			{
				Str_Cpy(stSc.PIPE_BURY_YN, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)));
				if( Str_Cmp(stSc.PIPE_BURY_YN, "Y") == 0 )
				{
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
				}
				else
				{
					Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
					SPRINT(szSql, " DELETE FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG = '10' "
									, g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_DirectExecute( szSql );
				
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
				}
			}

			//은폐여부
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_DATA7+1) )
			{
				Str_Cpy(stSc.PIPE_HIDE_YN, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)));
				if( Str_Cmp(stSc.PIPE_HIDE_YN, "Y") == 0 )
				{
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), FALSE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK3), BTNMENUFRCOLOR);
				}
				else
				{
					Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
					SPRINT(szSql, " DELETE FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG = '20' "
									, g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_DirectExecute( szSql );
				
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK3), BTNMENUFRCOLOR);
				}
			}
		}
	}

	/*=======================================================================================
	함수명 : OnPointing
	기  능 : 키보드
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		m_lActiveIndex = -1;

		if( m_bFirst == INIT_MAIN )
		{
			// OnSelect에서 은폐/매립배관 조건문 설정을위해.
			m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		}
	}
	
	//---------------------------------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : 버튼 이미지
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		
		return;
	}
	
	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CO_ALARM), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);	
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CO_ALARM), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		}
		else if( m_bFirst == INIT_LAYCHK )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		}
		else if( m_bFirst == INIT_HIDECHK )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA46), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA49), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA46), TRUE, 2, EDITSEP_NONE );
		}
	}

	/*=======================================================================================
	함수명 : SetCombo
	기  능 : 콤보박스 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;

		//자율점검
		for ( i = 0 ;  SCSELF[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), SCSELF[i].Str, 0, ICON_NONE);
		}
		
		//홍보물
		for ( i = 0 ;  SCADV[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), SCADV[i].Str, 0, ICON_NONE);
		}
		
		//누출차단기
		for ( i = 0 ;  SCLK_CO[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCLK_CO[i].Str, 0, ICON_NONE);
		}
		
		//배관도색상태
		for ( i = 0 ;  SCCOLOR[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA5+2), SCCOLOR[i].Str, 0, ICON_NONE);
		}
		
		//CO경보기
		for ( i = 0 ;  SCCOALARM[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CO_ALARM+2), SCCOALARM[i].Str, 0, ICON_NONE);
		}

		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), "Y", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), "N", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA7+2), "Y", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA7+2), "N", 0, ICON_NONE);
	}

	
	/*=======================================================================================
	함수명 : Clean_Data
	기  능 : 화면 초기화
	Param  : 
	Return : 
	========================================================================================*/
	void Clean_Data(void)
	{
		Str_Cpy(stScPipe.GAS_DAMP_YN , "");
		Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "");
		Str_Cpy(stScPipe.PIPE_INSPEC_HOLE_YN , "");
		Str_Cpy(stScPipe.CUTOFF_INSPEC_HOLE_YN , "");
		Str_Cpy(stScPipe.PIPE_LOC_MARK_YN , "");
		
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
	
	/*=======================================================================================
	함수명 : SetDataPipe
	기  능 : 매립배관점검 데이터
	Param  : 
	Return : 
	========================================================================================*/
	void SetDataPipe(void)
	{
		long i, idx;
		char szSql[400];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)&stScPipe, 0x00, sizeof(stScPipe));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( m_bFirst == INIT_LAYCHK )
		{
			SPRINT(szSql, "SELECT CHK_EXEC_NUM, CHK_YEAR, CHK_ORDER, CHK_TYPE, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP \
			, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN,PIPE_INSPEC_HOLE_YN, CUTOFF_INSPEC_HOLE_YN, PIPE_LOC_MARK_YN \
			FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = ? AND PIPE_FLAG = '10' ORDER BY ROWID"
			, 0, 0, 0);
		}
		else if( m_bFirst == INIT_HIDECHK )
		{
			SPRINT(szSql, "SELECT CHK_EXEC_NUM, CHK_YEAR, CHK_ORDER, CHK_TYPE, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP \
			, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN,PIPE_INSPEC_HOLE_YN, CUTOFF_INSPEC_HOLE_YN, PIPE_LOC_MARK_YN \
			FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = ? AND PIPE_FLAG = '20' ORDER BY ROWID"
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

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.CHK_EXEC_NUM			  , 20+ 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.CHK_YEAR               , 4 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.CHK_ORDER              , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.CHK_TYPE               , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.MTR_NUM                , 9 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.CHK_YMD                , 8 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.UPD_EMPID              , 9 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.PDA_IP                 , 13+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.PIPE_FLAG              , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.GAS_DAMP_YN            , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.MULTI_GAS_MTR_YN       , 2 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.PIPE_INSPEC_HOLE_YN    , 2 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.CUTOFF_INSPEC_HOLE_YN  , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScPipe.PIPE_LOC_MARK_YN       , 2 + 1, DECRYPT );
		}

Finally:
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 Redraw
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i;
		long lCount;
		char szSql[300];
	
		//입상관/내관/외관
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='40' ", g_szCHK_EXEC_NUM, 0, 0);

		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			Str_Cpy(stSc.PIPE_RSLT, "N");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "부적합");	
		}
		else if( lCount == 0 )
		{
			Str_Cpy(stSc.PIPE_RSLT, "Y");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "적합");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "");
		}
		
		//자율점검
		i = g_SearchCD( stSc.SELF_CHK_YN, SCSELF );
		
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SCSELF[1].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SCSELF[i].Str);
		}
		
		//홍보물
		i = g_SearchCD( stSc.ADV_DIST_YN, SCADV );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), SCADV[0].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), SCADV[i].Str);
		}
		
		//누출차단기
		i = g_SearchCD( stSc.LK_BREAKER, SCLK_CO );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), SCLK_CO[1].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), SCLK_CO[i].Str);
		}
		/*
		//CO감지기
		i = g_SearchCD( stSc.CO_SENSOR, SCLK_CO );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), SCLK_CO[1].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), SCLK_CO[i].Str);
		}
		*/
		
		//배관도색상태
		i = g_SearchCD( stSc.PIPE_COLOR_STS, SCCOLOR );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), SCCOLOR[0].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), SCCOLOR[i].Str);
		}
		
		// CO경보기
		i = g_SearchCD( stSc.CO_ALARM_INST_YN, SCCOALARM );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CO_ALARM), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CO_ALARM), SCCOALARM[i].Str);
		}
		
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG ='10' " , g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		// 배관매립여부
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), stSc.PIPE_BURY_YN);
		
		if( Str_Cmp(stSc.PIPE_BURY_YN, "Y") == 0 && lCount <= 0)
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
		}
		else if( Str_Cmp(stSc.PIPE_BURY_YN, "Y") == 0 && lCount > 0)
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), RED);

		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK2), BTNMENUFRCOLOR);
		}
		
		// 배관은폐여부
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG ='20' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), stSc.PIPE_HIDE_YN);
		
		if( Str_Cmp(stSc.PIPE_HIDE_YN, "Y") == 0  && lCount <= 0 )
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), FALSE );
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK3), BTNMENUFRCOLOR);
		}
		else if( Str_Cmp(stSc.PIPE_HIDE_YN, "Y") == 0 && lCount > 0)
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), FALSE );
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK3), RED);
		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK3), TRUE );
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHECK3), BTNMENUFRCOLOR);
		}
	}
	
    /*=======================================================================================
	함수명 : Save_Pipe
	기  능 : 배관 저장
	Param  : 
	Return : 
	========================================================================================*/
	bool Save_Pipe(long nbuttonid)
	{
		char szSql[300];
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
			
		if( nbuttonid == BID_CHECK5 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = '%s' AND PIPE_FLAG = '10' ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );
		}
		else if( nbuttonid == BID_CHECK6 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM = '%s' AND PIPE_FLAG = '20' ", g_szCHK_EXEC_NUM, 0, 0);
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
			if( nbuttonid == BID_CHECK5 )
			{
				SPRINT(szSql, "UPDATE NORMAL_PIPE_CHK_DATA SET \
							GAS_DAMP_YN = ?, MULTI_GAS_MTR_YN = ?, PIPE_LOC_MARK_YN = ?, CHK_YEAR = ?, CHK_ORDER = ? \
				          , CHK_TYPE = ?, CHK_YMD = ?, UPD_EMPID = ?, PDA_IP = ? \
							WHERE CHK_EXEC_NUM = '%s' AND PIPE_FLAG = '10' "
							, g_szCHK_EXEC_NUM, 0, 0);
			}
			else if( nbuttonid == BID_CHECK6 )
			{
				SPRINT(szSql, "UPDATE NORMAL_PIPE_CHK_DATA SET \
							GAS_DAMP_YN = ?, MULTI_GAS_MTR_YN = ?, PIPE_INSPEC_HOLE_YN = ?, CUTOFF_INSPEC_HOLE_YN = ? \
							, PIPE_LOC_MARK_YN = ?, CHK_YEAR = ?, CHK_ORDER = ?, CHK_TYPE = ?, CHK_YMD = ? \
							, UPD_EMPID = ?, PDA_IP = ?	WHERE CHK_EXEC_NUM = '%s' AND PIPE_FLAG = '20' "
							, g_szCHK_EXEC_NUM, 0, 0);
			}
		}
		else
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT MTR_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr( szSql, 10, stScMtr.MTR_NUM );
		
			if( nbuttonid == BID_CHECK5 )
			{
				SPRINT(szSql, "INSERT INTO NORMAL_PIPE_CHK_DATA \
				(CHK_EXEC_NUM, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN, PIPE_LOC_MARK_YN, CHK_YEAR, CHK_ORDER \
				, CHK_TYPE, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP) \
				VALUES(?, '10', ?, ?, ?, ?, ?, ?, ?, ? \
					 , ?, ?) "
				, 0, 0, 0);
			}
			else if( nbuttonid == BID_CHECK6 )
			{
				SPRINT(szSql, "INSERT INTO NORMAL_PIPE_CHK_DATA \
				(CHK_EXEC_NUM, PIPE_FLAG, GAS_DAMP_YN, MULTI_GAS_MTR_YN, PIPE_INSPEC_HOLE_YN, CUTOFF_INSPEC_HOLE_YN \
				, PIPE_LOC_MARK_YN, CHK_YEAR, CHK_ORDER, CHK_TYPE, MTR_NUM, CHK_YMD, UPD_EMPID, PDA_IP) \
				VALUES(?, '20', ?, ?, ?, ?, ?, ?, ?, ? \
					 , ?,    ?, ?, ?)"
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
			if( nbuttonid == BID_CHECK5 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.GAS_DAMP_YN			,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.MULTI_GAS_MTR_YN	,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.PIPE_LOC_MARK_YN	,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YEAR                ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_ORDER               ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_TYPE                ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YMD                 ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szemployee_id     ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szpda_ip          ,13 ,DECRYPT);
			}
			else if( nbuttonid == BID_CHECK6 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.GAS_DAMP_YN				,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.MULTI_GAS_MTR_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.PIPE_INSPEC_HOLE_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.CUTOFF_INSPEC_HOLE_YN	,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.PIPE_LOC_MARK_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YEAR                    ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_ORDER                   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_TYPE                    ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YMD                     ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szemployee_id         ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szpda_ip              ,13 ,DECRYPT);
			}
		}
		else
		{
			if( nbuttonid == BID_CHECK5 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM					,20	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.GAS_DAMP_YN				,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.MULTI_GAS_MTR_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.PIPE_LOC_MARK_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YEAR                    ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_ORDER                   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_TYPE                    ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stScMtr.MTR_NUM                  ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YMD                     ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szemployee_id         ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szpda_ip              ,13 ,DECRYPT);
			}
			else if( nbuttonid == BID_CHECK6 )
			{
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM					,20	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.GAS_DAMP_YN				,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.MULTI_GAS_MTR_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.PIPE_INSPEC_HOLE_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.CUTOFF_INSPEC_HOLE_YN	,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long *)stScPipe.PIPE_LOC_MARK_YN		,1	,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YEAR                    ,4  ,DECRYPT);	
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_ORDER                   ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_TYPE                    ,2  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stScMtr.MTR_NUM                  ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stSc.CHK_YMD                     ,8  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szemployee_id         ,9  ,DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szpda_ip              ,13 ,DECRYPT);
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
			if( nbuttonid == BID_CHECK5 )
			{
				MessageBoxEx (CONFIRM_OK, "매립배관점검이 완료되었습니다.");
			}
			else if( nbuttonid == BID_CHECK6 )
			{
				MessageBoxEx (CONFIRM_OK, "은폐배관점검이 완료되었습니다.");
			}
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Save_Result
	기  능 : 결과 저장
	Param  : 
	Return : 
	========================================================================================*/
	bool Save_Result(void)
	{
		char szSql[300];
		long lCount;
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( !Validate() )
		{
			return FALSE;
		}
		
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG ='10' ", g_szCHK_EXEC_NUM, 0, 0);
		
		g_Sql_RetInt(szSql, &lCount);
		
		if( Str_Cmp(stSc.PIPE_BURY_YN, "Y") == 0 && lCount == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "배관매립여부를 입력하세요.");
			return FALSE;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG ='20' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		if( Str_Cmp(stSc.PIPE_HIDE_YN, "Y") == 0 && lCount == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "배관은폐여부를 입력하세요.");
			return FALSE;
		}
		
		// 자율점검
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SCSELF );
		Str_Cpy(stSc.SELF_CHK_YN, SCSELF[i].Code);
		
		// 홍보물
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), SCADV );
		Str_Cpy(stSc.ADV_DIST_YN, SCADV[i].Code);
		
		// 누출차단기
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), SCLK_CO );
		Str_Cpy(stSc.LK_BREAKER, SCLK_CO[i].Code);
		
		/*
		// CO감지기
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)), SCLK_CO );
		Str_Cpy(stSc.CO_SENSOR, SCLK_CO[i].Code);
		*/
		
		// CO경보기
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CO_ALARM)), SCCOALARM );
		Str_Cpy(stSc.CO_ALARM_INST_YN, SCCOALARM[i].Code);

		if(Str_Cmp(stSc.CO_ALARM_INST_YN, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "CO경보기 상태를 점검해주세요.");
			return FALSE;
		}
		
		// 배관도색상태
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5)), SCCOLOR );
		Str_Cpy(stSc.PIPE_COLOR_STS, SCCOLOR[i].Code);
		
		// LOC_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='40' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		if( lCount > 0 )
		{
			Str_Cpy(stSc.LOC_RSLT, "N");
			Str_Cpy( stSc.NOGOOD_RSLT, "N" );
		}
		else
		{
			Str_Cpy(stSc.LOC_RSLT, "Y");
		}

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, "UPDATE NORMAL_DATA \
		                   SET PIPE_RSLT = ?, SELF_CHK_YN = ?, ADV_DIST_YN = ?, LK_BREAKER = ?, CO_SENSOR = ? \
				 	         , PIPE_COLOR_STS = ?, PIPE_BURY_YN = ?, PIPE_HIDE_YN = ?, LOC_RSLT = ?, CO_ALARM_INST_YN = ? \
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
		sql->Bind(sql, idx++, 'U', (long *)stSc.PIPE_RSLT		, 1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.SELF_CHK_YN		, 1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.ADV_DIST_YN		, 1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.LK_BREAKER	    , 1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CO_SENSOR	    , 1, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.PIPE_COLOR_STS  , 1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PIPE_BURY_YN	, 2, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PIPE_HIDE_YN	, 2, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.LOC_RSLT		, 1, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CO_ALARM_INST_YN, 1, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Validate
	기  능 : 결과 Validation
	Param  : 
	Return : 
	========================================================================================*/
	bool Validate(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "자율점검을 점검해주세요.");
				return FALSE;
			}
		
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "홍보물을 점검해주세요.");
				return FALSE;
			}
		
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "누출차단기를 점검해주세요.");
				return FALSE;
			}
			
			/*
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "CO감지기를 점검해주세요.");
				return FALSE;
			}
			*/
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관도색상태를 점검해주세요.");
				return FALSE;
			}
	
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관매립여부를 입력하세요.");
				return FALSE;
			}
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관은폐여부를 입력하세요.");
				return FALSE;
			}
		}
		else if( m_bFirst == INIT_LAYCHK )
		{
			if( Str_Cmp(stScPipe.GAS_DAMP_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "가스누기 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stScPipe.MULTI_GAS_MTR_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "다기능가스계량기 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stScPipe.PIPE_LOC_MARK_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관위치표시 항목을 선택하세요.");
				return FALSE;
			}
		}
		else if( m_bFirst == INIT_HIDECHK )
		{
			if( Str_Cmp(stScPipe.GAS_DAMP_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "가스누기 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stScPipe.MULTI_GAS_MTR_YN, "") == 0 && Str_Cmp(stScPipe.PIPE_INSPEC_HOLE_YN, "") == 0 
			&& Str_Cmp(stScPipe.CUTOFF_INSPEC_HOLE_YN, "") == 0)
			{
				MessageBoxEx (CONFIRM_OK, "안전조치방법 항목을 선택하세요.");
				return FALSE;
			}
			else if( Str_Cmp(stScPipe.PIPE_LOC_MARK_YN, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관위치표시 항목을 선택하세요.");
				return FALSE;
			}
		}

		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Sel_Btn
	기  능 : 버튼 Setting
	Param  : 
	Return : 
	========================================================================================*/
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
			
			Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "Y");
			Str_Cpy(stScPipe.PIPE_INSPEC_HOLE_YN , "");
			Str_Cpy(stScPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX10 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX10), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX9), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX10), FALSE );
			
			Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "N");
			Str_Cpy(stScPipe.PIPE_INSPEC_HOLE_YN , "");
			Str_Cpy(stScPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX11 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX11), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), FALSE );
			
			Str_Cpy(stScPipe.PIPE_INSPEC_HOLE_YN , "Y");
			Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stScPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX12 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX12), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX11), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX12), FALSE );
			
			Str_Cpy(stScPipe.PIPE_INSPEC_HOLE_YN , "N");
			Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stScPipe.CUTOFF_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX13 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX13), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), FALSE );
			
			Str_Cpy(stScPipe.CUTOFF_INSPEC_HOLE_YN , "Y");
			Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stScPipe.PIPE_INSPEC_HOLE_YN , "");
		}
		else if( nBtnId == BID_BOX14 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX14), CHKON);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX13), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOX14), FALSE );
			
			Str_Cpy(stScPipe.CUTOFF_INSPEC_HOLE_YN , "N");
			Str_Cpy(stScPipe.MULTI_GAS_MTR_YN , "");
			Str_Cpy(stScPipe.PIPE_INSPEC_HOLE_YN , "");
		}
		
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	함수명 : Chk_PipeRslt
	기  능 : 배관 점검 여부
	Param  : 
	Return : 
	========================================================================================*/
	bool Chk_PipeRslt(long nButtonId)
	{
		long lCount = 0;
		char szSql[300];
		
		
		if( nButtonId == BID_CHECK2 )
		{
			//배관매립여부
			lCount = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG ='10' "
							, g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetInt(szSql, &lCount);

			if( Str_Cmp(stSc.PIPE_BURY_YN, "Y") == 0 && lCount > 0)
			{
				MessageBoxEx (CONFIRM_OK, "점검완료된 항목은 점검이 불가합니다.");
				
				return FALSE;
			}
		}
		else if( nButtonId == BID_CHECK3 )
		{
			//배관은폐여부
			lCount = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND PIPE_FLAG ='20' "
							, g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetInt(szSql, &lCount);
			
			if( Str_Cmp(stSc.PIPE_HIDE_YN, "Y") == 0 && lCount > 0)
			{
				MessageBoxEx (CONFIRM_OK, "점검완료된 항목은 점검이 불가합니다.");
				
				return FALSE;
			}
		}
		
		return TRUE;
	}
}


