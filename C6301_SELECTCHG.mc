/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_SELECTCHG
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
//	#define USE_ON_UART

	#include "DefEvent.h"
	
//BUTTON ID define
	BEGIN_BUTTON_ID()
//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
//검색
		DEF_BUTTON_ID ( BID_SEARCH1 )		//계량기번호 조회
		DEF_BUTTON_ID ( BID_SEARCH2 )		//기물번호 조회
		DEF_BUTTON_ID ( BID_SEARCH3 )		//주소 조회
		DEF_BUTTON_ID ( BID_SEARCH4 )		//신주소 조회
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_NADDR )
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
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

		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )
				
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
//검색
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 )
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 )
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_NEW	2
	
	long m_lBtnId = -1;
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index 관련 flag
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_lActIndex = -1;		//액티브된 index
	char m_szCnt_page[10];		// 페이지 표시 변수
	char m_szSql[2][1200];
	char m_szCobSel[20];		//
	char m_bFirst;
	char m_szSingle_Flag[10];
	char m_szMtrNum[11];
	char m_szMtrIDNum[11];
	char m_CmdArea[51];
	char m_CmdNewArea[51];
	
	bool Search_Addr(long nbuttonid);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void REDRAW(void);
	void SetCombo(void);
	void Set_Index(void); 	//선택한 대상 인덱스 저장
	void SetSearch(void);
	void SaveInput(void);
	void SetBtnImg(void);
	void Barcode(void);
	void OnBarcodeRead(void);
	void PDA_OnBarcodeRead(void);
	long SearchCD(char *CD, CodeTable *CT);		//코드 값을 찾는다.
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "선택교체 검색"),

		DLG_BUTTON(STARTX+800,   STARTY+65, 200, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800,	STARTY+140, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX, 		STARTY+250, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+300,	STARTY+250, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+600,	STARTY+750, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,  	  STARTY+65, 300, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "계량기번호"),
		DLG_EDIT(STARTX+300,  STARTY+65, 500, 75, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 9,  ""),
		DLG_TEXT(STARTX,  	 STARTY+140, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "기물번호"),
		DLG_EDIT(STARTX+300, STARTY+140, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+350, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "구"),
		DLG_TEXT(STARTX,  	 STARTY+420, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "동"),
		DLG_TEXT(STARTX,  	 STARTY+490, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "리"),
		DLG_EDIT(STARTX+300, STARTY+490, 700, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+560, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "번지"),
		DLG_EDIT(STARTX+300, STARTY+560, 700, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 10,  ""),
		DLG_TEXT(STARTX,  	 STARTY+630, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "호수"),
		DLG_EDIT(STARTX+300, STARTY+630, 700, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 10,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+350, 700, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+300, STARTY+420, 700, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "선택교체 검색"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+800,   STARTY-40, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800,	 STARTY+40, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX, 		STARTY+150, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+330,	STARTY+150, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+600,	STARTY+700, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,  	  STARTY-40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "계량기번호"),
		DLG_EDIT(STARTX+300,  STARTY-40, 500, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 9,  ""),
		DLG_TEXT(STARTX,  	  STARTY+40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "기물번호"),
		DLG_EDIT(STARTX+300,  STARTY+40, 500, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+250, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "구"),
		DLG_TEXT(STARTX,  	 STARTY+330, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "동"),
		DLG_TEXT(STARTX,  	 STARTY+410, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "리"),
		DLG_EDIT(STARTX+300, STARTY+410, 700, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+490, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "번지"),
		DLG_EDIT(STARTX+300, STARTY+490, 700, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+570, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "호수"),
		DLG_EDIT(STARTX+300, STARTY+570, 700, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 20,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+250, 700, 200, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),
		DLG_COMBO (STARTX+300, STARTY+330, 700, 200, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),
	};

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_NEW[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "선택교체 검색"),

		DLG_BUTTON(STARTX+800,   STARTY+65, 200, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800,	STARTY+140, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX, 		STARTY+250, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+300,	STARTY+250, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+600,	STARTY+750, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,  	  STARTY+65, 300, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "계량기번호"),
		DLG_EDIT(STARTX+300,  STARTY+65, 500, 75, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 9,  ""),
		DLG_TEXT(STARTX,  	 STARTY+140, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "기물번호"),
		DLG_EDIT(STARTX+300, STARTY+140, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+350, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "구"),
		DLG_TEXT(STARTX,  	 STARTY+420, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "도로명"),
		DLG_TEXT(STARTX,  	 STARTY+490, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "본번"),
		DLG_EDIT(STARTX+300, STARTY+490, 700, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 10,  ""),
		DLG_TEXT(STARTX,  	 STARTY+560, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "부번"),
		DLG_EDIT(STARTX+300, STARTY+560, 700, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 10,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+350, 700, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_COMBO (STARTX+300, STARTY+420, 700, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_NEW_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "선택교체 검색"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+800,   STARTY-40, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800,	 STARTY+40, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX, 		STARTY+150, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+330,	STARTY+150, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+600,	STARTY+700, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,  	  STARTY-40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "계량기번호"),
		DLG_EDIT(STARTX+300,  STARTY-40, 500, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 9,  ""),
		DLG_TEXT(STARTX,  	  STARTY+40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "기물번호"),
		DLG_EDIT(STARTX+300,  STARTY+40, 500, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+250, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "구"),
		DLG_TEXT(STARTX,  	 STARTY+330, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "도로명"),
		DLG_TEXT(STARTX,  	 STARTY+410, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "본번"),
		DLG_EDIT(STARTX+300, STARTY+410, 700, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 20,  ""),
		DLG_TEXT(STARTX,  	 STARTY+490, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "부번"),
		DLG_EDIT(STARTX+300, STARTY+490, 700, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 20,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+250, 700, 200, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 20),
		DLG_COMBO (STARTX+300, STARTY+330, 700, 200, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 20),
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

				Mem_Set( (byte*)m_CmdArea, 0x00, sizeof(m_CmdArea) );

				SetBtnImg();
				SetCombo();
				SetStyle();
				REDRAW();
				break;
			case INIT_NEW:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_NEW_P, SIZEOF(DlgRes_NEW_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_NEW, SIZEOF(DlgRes_NEW));
						break;
				}

				Mem_Set( (byte*)m_CmdNewArea, 0x00, sizeof(m_CmdNewArea) );

				SetBtnImg();
				SetCombo();
				SetStyle();
				REDRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		
		if( theDevInfo.m_nType > FAMILY_PDA )
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
		if( m_bFirst == INIT_MAIN )
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex  )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
					return;
				}
			}
		}
		else if( m_bFirst == INIT_NEW )
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex  )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
					return;
				}
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
				if( m_bFirst == INIT_MAIN )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+70) && Y < DMS_Y(STARTY+140)  ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+140) && Y < DMS_Y(STARTY+210) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )	
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+490-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+560-(g_Dlgflag*400)) ||
					    	 X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+560-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+630-(g_Dlgflag*400)) ||
					    	 X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+630-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+700-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex )	
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
				}
				else if( m_bFirst == INIT_NEW )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+70) && Y < DMS_Y(STARTY+140) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+140) && Y < DMS_Y(STARTY+210) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )	
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+490-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+560-(g_Dlgflag*400)) ||
					    	 X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+560-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+630-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )	
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
				}				
				ON_DRAW();
			}
		}
	}

//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long i;
		long index = -1;
		char szArea[51];
		char szTown[51];
		char szSql[150];

		if( m_bFirst == INIT_MAIN )
		{
			Mem_Set( (byte*)szArea, 0x00, sizeof(szArea) );
			Str_Cpy(szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
			if( Str_Cmp(m_CmdArea,  szArea ) != 0 )
			{
				Mem_Set( (byte*)m_CmdArea, 0x00, sizeof(m_CmdArea) );
				Str_Cpy(m_CmdArea, szArea);

				ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA2+2));
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT TOWN FROM C6301_CHANGEDATA WHERE AREA = '%s' GROUP BY TOWN ORDER BY TOWN", m_CmdArea, 0, 0   );
				g_Sql_SetCombo(szSql, CMB_DATA2+2);
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
			}
		}
		else
		{
			Mem_Set( (byte*)szArea, 0x00, sizeof(szArea) );
			Str_Cpy(szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)) );
			if( Str_Cmp(m_CmdNewArea,  szArea ) != 0 )
			{
				Mem_Set( (byte*)m_CmdNewArea, 0x00, sizeof(m_CmdNewArea) );
				Str_Cpy(m_CmdNewArea, szArea);

				ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA4+2));
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT NEW_ROAD_NM FROM C6301_CHANGEDATA WHERE AREA = '%s' GROUP BY NEW_ROAD_NM ORDER BY NEW_ROAD_NM", m_CmdNewArea, 0, 0   );
				g_Sql_SetCombo(szSql, CMB_DATA4+2);

				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
			}
		}
	}



//-----------------------------------------------------------------------------------------------
	void SetCombo(void)
	{

		if( m_bFirst == INIT_MAIN )
		{
			g_Sql_SetCombo("SELECT AREA FROM C6301_CHANGEDATA GROUP BY AREA ORDER BY AREA", CMB_DATA1+2);
			//g_Sql_SetCombo("SELECT TOWN FROM C6301_CHANGEDATA GROUP BY TOWN ORDER BY TOWN", CMB_DATA2+2);
		}
		else if( m_bFirst == INIT_NEW )
		{
			g_Sql_SetCombo("SELECT AREA FROM C6301_CHANGEDATA GROUP BY AREA ORDER BY AREA", CMB_DATA3+2);
			g_Sql_SetCombo("SELECT NEW_ROAD_NM FROM C6301_CHANGEDATA GROUP BY NEW_ROAD_NM ORDER BY NEW_ROAD_NM", CMB_DATA4+2);
		}

		return;
	}
	
//---------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{
	long d, k;
	char szToday[11];
	char szDate[11];
	
		switch(ID)
		{
			case BID_ADDR:
				if( m_bFirst == INIT_NEW )
				{
					SaveInput();
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_NADDR:
				if( m_bFirst == INIT_MAIN )
				{
					SaveInput();
					ON_EXIT();
					OnInit(INIT_NEW);
				}
				break;
			//검색화면
			case BID_SEARCH1:
			case BID_SEARCH2:
			case BID_SEARCH3:
			case BID_SEARCH4:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( Search_Addr(ID) == FALSE)
					break;

				if(FS_GetSrchTotCnt() == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "입력한 자료가 없습니다.확인해 주세요.");
					break;
				}

				g_nWorkFlag = 730;
				Card_Move("C6301_LST");
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
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "계량기교체 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6301_MENU");
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
				Card_Move("C6301_MENU");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;

				g_Exit();
				break;
		}
	}

//-----------------------------------------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);

		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
		}
		else if( m_bFirst == INIT_NEW )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
		}
		
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
			{
				return i;
			}
		}
		return -1;
	}


	/*=======================================================================================
	함수명 : Set_Index
	기  능 : 최종 인덱스 저장한다.
	Param  : 
	Return : TRUE :성공
			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

	
//-------------------------------------------------------------------------------
	bool Search_Addr(long nbuttonid)
	{
		char szSql[500];
		char szWhere[400];
		long chki= 0;
	
	  	Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		
		Str_Cpy( szSql, "SELECT ROWID FROM C6301_CHANGEDATA WHERE ");
		
		if( nbuttonid == BID_SEARCH1 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "계량기번호를 입력하세요.");
				return FALSE;
			}

			Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1) ) > 0   ) 
			{
				Str_Cat( g_szSqlWhere, "MTR_NUM LIKE '%" );
				Str_Cat( g_szSqlWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1) ) );
				Str_Cat( g_szSqlWhere, "%' " );
				
				Str_Cat( szSql, g_szSqlWhere );
			}
		}
		else if( nbuttonid == BID_SEARCH2 )
		{
			Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "기물번호를 입력하세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) > 0 ) 
			{
				Str_Cat( g_szSqlWhere, "MTR_ID_NUM LIKE '%" );
				Str_Cat( g_szSqlWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2) ) );
				Str_Cat( g_szSqlWhere, "%' " );
				
				Str_Cat( szSql, g_szSqlWhere );
			}			
		}
		else if( nbuttonid == BID_SEARCH3 )
		{	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA1)) == 0 ||
				EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA2)) == 0 ||
				EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "주소입력을 확인하세요.");
				return FALSE;
			}
			
			Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA1) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "AREA LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cpy( g_szSqlWhere, szWhere);
				chki++;
			}

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA2) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "TOWN LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( g_szSqlWhere, szWhere);
				chki++;
			}

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA3) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "VILLAGE LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( g_szSqlWhere, szWhere);
				chki++;
			}
				
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_M LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( g_szSqlWhere, szWhere);
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA5) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_S LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( g_szSqlWhere, szWhere);
			}
		}
		else if( nbuttonid == BID_SEARCH4 )
		{	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA3)) == 0 ||
				EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA4)) == 0 ||
				EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA6)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "주소입력을 확인하세요.");
				return FALSE;
			}
			
			Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA3) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "AREA LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cpy( g_szSqlWhere, szWhere);
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA4) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ROAD_NM LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( g_szSqlWhere, szWhere);
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA6) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_M LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( g_szSqlWhere, szWhere);
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA7) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_S LIKE '%" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7) ) );
				Str_Cat( szWhere, "%' " );
				Str_Cat( szSql, szWhere );
				Str_Cat( g_szSqlWhere, szWhere);
			}
		}

		Str_Cat( szSql, "ORDER BY ROWID");
//PRINT("szSql : %s",szSql,0,0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);

		//페이지를 초기화시킨다.
		m_lpage = 0;
		
		return TRUE;
	}
		
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetSearch(void)
	{
/*		long i, idx;
		long k = ROW + 1;
		long lRow;
		char sztmp[201];	
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		else
			hstmt = sql->CreateStatement(sql, m_szSql[1]);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{	
			//2016-05-24 Sanghyun Lee , 상세리스트에서 화면 분리 후 Value 얻어오는 부분 수정
			if( m_lBtnId == 1 )
			{	//기물번호 검색
				Mem_Set( (byte*)stMtrChg.CHK_EXEC_NUM, 0x00, sizeof(stMtrChg.CHK_EXEC_NUM) );
				sql->GetValue(sql, 0, 'U', (long*)stMtrChg.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stMtrChg.CHK_EXEC_NUM);
				
				Mem_Set( (byte*)stMtrChg.SEND_YN, 0x00, sizeof(stMtrChg.SEND_YN) );
				sql->GetValue(sql, 1, 'U', (long*)stMtrChg.SEND_YN, 1 + 1, DECRYPT);
			}
			else
			{	//기물번호를 제외한 나머지 검색
				Mem_Set( (byte*)stMtrChg.CHK_EXEC_NUM, 0x00, sizeof(stMtrChg.CHK_EXEC_NUM) );
				sql->GetValue(sql, 0, 'U', (long*)stMtrChg.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stMtrChg.CHK_EXEC_NUM);

				Mem_Set( (byte*)stMtrChg.SEND_YN, 0x00, sizeof(stMtrChg.SEND_YN) );
				sql->GetValue(sql, 1, 'U', (long*)stMtrChg.SEND_YN, 1 + 1, DECRYPT);
			}

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY HOUSE_NUM_ORD, DONG_ORD ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetInt( szSql, &lRow );

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
			g_Sql_SaveSeq( szSql, SREACH_FILE);

			g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
*/
		return;
	}
	
	/*=======================================================================================
	함수명 : FS_GetSrchTotCnt
	기  능 : 검색인덱스파일의 레코드 수를 리턴한다.
	Param  : nPos:검색 인덱스 파일의 순번
 	Return : 레코드수
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;
		
		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}
	
	
//-------------------------------------------------------------------------------------------
	void SaveInput(void)
	{
		Mem_Set( (byte*)m_szMtrNum, 0x00, sizeof(m_szMtrNum) );
		Mem_Set( (byte*)m_szMtrIDNum, 0x00, sizeof(m_szMtrIDNum) );
		
		Str_Cpy(m_szMtrNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)) );
		Str_Cpy(m_szMtrIDNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)) );
	}
	
//-------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		if( Str_Len(m_szMtrNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), m_szMtrNum);
		}
		
		if( Str_Len(m_szMtrIDNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), m_szMtrIDNum);
		}
	}
}





