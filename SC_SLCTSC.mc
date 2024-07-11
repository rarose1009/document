/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_SLCTSC
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
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
//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
//검색
		DEF_BUTTON_ID ( BID_BAR )
		DEF_BUTTON_ID ( BID_SEARCH1 )		//수용가번호 조회
		DEF_BUTTON_ID ( BID_SEARCH2 )		//기물번호 조회
		DEF_BUTTON_ID ( BID_SEARCH3 )		//바코드 조회
		DEF_BUTTON_ID ( BID_SEARCH4 )
		DEF_BUTTON_ID ( BID_SEARCH5 )
		DEF_BUTTON_ID ( BID_SEARCH6 )		//조회
		DEF_BUTTON_ID ( BID_SEARCH7 )
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_NADDR )
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//검색
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_CSMNUM )		//수용가번호
		DEF_OBJECT_ID ( TXT_OBJNUM )		//기물번호
		DEF_OBJECT_ID ( TXT_BARNUM )		//바코드
		DEF_OBJECT_ID ( TXT_CPTEL  )		//휴대폰
		DEF_OBJECT_ID ( TXT_OWNTEL )		//집전화
		DEF_OBJECT_ID ( TXT_ADDR)			//주소
		DEF_OBJECT_ID ( TXT_GOO )			//구
		DEF_OBJECT_ID ( TXT_DONG )			//동
		DEF_OBJECT_ID ( TXT_BUNJI )			//번지
		DEF_OBJECT_ID ( TXT_HOSOO )			//호수
		DEF_OBJECT_ID ( TXT_NWADDR )		//새주소
		DEF_OBJECT_ID ( TXT_NWGOO )			//구
		DEF_OBJECT_ID ( TXT_STREET )		//도로명
		DEF_OBJECT_ID ( TXT_BONBUN )		//본번
		DEF_OBJECT_ID ( TXT_BOOBUN )		//부번

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

//검색
		DEF_OBJECT_ID ( EDT_CSMNUM )		//수용가번호 입력
		DEF_OBJECT_ID ( EDT_OBJNUM )		//기물번호 입력
		DEF_OBJECT_ID ( EDT_BARNUM )		//바코드 입력
		DEF_OBJECT_ID ( EDT_CPTEL  )		//휴대폰
		DEF_OBJECT_ID ( EDT_OWNTEL )		//집전화
		DEF_OBJECT_ID ( EDT_BUNJI )			//번지 입력
		DEF_OBJECT_ID ( EDT_HOSOO )			//호수 입력
		DEF_OBJECT_ID ( EDT_BONBUN )		//본번 입력
		DEF_OBJECT_ID ( EDT_BOOBUN )		//부번 입력
				
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
//검색
		DEF_OBJECT_ID ( CMB_GOO ) 				//구
		DEF_OBJECT_ID ( CMB_DONG = CMB_GOO+3 ) 			//동
		DEF_OBJECT_ID ( CMB_NWGOO = CMB_DONG+3 ) 		//구
		DEF_OBJECT_ID ( CMB_STREET = CMB_NWGOO+3 ) 		//도로명
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
	char m_szInstNum[11];
	char m_szMtrNum[11];
	char m_szBarNum[22];
	char m_szCpNum[15];
	char m_szHouseNum[15];
	char m_szBarcode_Value[20];	//바코드 스캔 결과
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "지정 점검"),

		DLG_BUTTON(STARTX+800,  STARTY+65, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+135, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+205, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+275, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+345, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "조 회"),
		DLG_BUTTON(STARTX+600, STARTY+830, 400, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,	 STARTY+65, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "수용가번호"),
		DLG_TEXT(STARTX,	STARTY+135, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_BUTTON(STARTX,	STARTY+205, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "바코드"),
		DLG_TEXT(STARTX,	STARTY+275, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "핸드폰번호"),
		DLG_TEXT(STARTX,	STARTY+345, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "집전화번호"),
		
		DLG_TEXT(STARTX,       STARTY+440, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "◎주소검색"),
		DLG_BUTTON(STARTX+300, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+650, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		
		DLG_EDIT(STARTX+300,  STARTY+65, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+135, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+205, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+275, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+345, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),

		DLG_TEXT(STARTX,	 STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOO, "구"),
		DLG_TEXT(STARTX,	 STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DONG, "동"),
		DLG_TEXT(STARTX,	 STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BUNJI, "번지"),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BUNJI , 10,  ""),
		DLG_TEXT(STARTX,	 STARTY+730, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HOSOO, "호수"),
		DLG_EDIT(STARTX+200, STARTY+730, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_HOSOO , 10,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//구(구 주소)
		DLG_COMBO (STARTX+200, STARTY+590, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//동

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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "지정 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+800,  STARTY-40, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800,  STARTY+30, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+100, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+170, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+240, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "조 회"),
		DLG_BUTTON(STARTX+600, STARTY+780, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "조 회"),
//		DLG_BUTTON(STARTX+800, STARTY+440, 175, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,    STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "수용가번호"),
		DLG_TEXT(STARTX,    STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_BUTTON(STARTX, STARTY+100, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "바코드"),
		DLG_TEXT(STARTX,   STARTY+170, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "핸드폰번호"),
		DLG_TEXT(STARTX,   STARTY+240, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "집전화번호"),

		DLG_EDIT(STARTX+300,  STARTY-40, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300,  STARTY+30, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+100, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+170, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+240, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),
		
		DLG_TEXT(STARTX,       STARTY+350, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "◎주소검색"),
		DLG_BUTTON(STARTX+300, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+650, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		
		DLG_TEXT(STARTX, STARTY+450, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOO, "구"),
		DLG_TEXT(STARTX, STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DONG, "동"),
		DLG_TEXT(STARTX, STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BUNJI, "번지"),
		DLG_TEXT(STARTX, STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HOSOO, "호수"),
		
		DLG_EDIT(STARTX+200, STARTY+590, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BUNJI , 10,  ""),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_HOSOO , 10,  ""),
		
//		DLG_EDIT(STARTX+200, STARTY+750, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
//		DLG_EDIT(STARTX+200, STARTY+800, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		DLG_COMBO (STARTX+200, STARTY+450, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//구(구 주소)
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//동
		//DLG_COMBO (STARTX+200, STARTY+650, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//구(신 주소)
		//DLG_COMBO (STARTX+200, STARTY+700, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//도로명
	};

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_NEW[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "지정 점검"),

		DLG_BUTTON(STARTX+800,  STARTY+65, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+135, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+205, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+275, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+345, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "조 회"),
//		DLG_BUTTON(STARTX+675, STARTY+750, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "조 회"),
		DLG_BUTTON(STARTX+600, STARTY+830, 400, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,	 STARTY+65, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "수용가번호"),
		DLG_TEXT(STARTX,	STARTY+135, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_BUTTON(STARTX,	STARTY+205, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "바코드"),
		DLG_TEXT(STARTX,	STARTY+275, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "핸드폰번호"),
		DLG_TEXT(STARTX,	STARTY+345, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "집전화번호"),

		DLG_EDIT(STARTX+300,  STARTY+65, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+135, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+205, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+275, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+345, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),
		
		DLG_TEXT(STARTX,       STARTY+440, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "◎주소검색"),
		DLG_BUTTON(STARTX+300, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+650, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		
		DLG_TEXT(STARTX,	 STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NWGOO, "구"),
		DLG_TEXT(STARTX,	 STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STREET, "도로명"),
		DLG_TEXT(STARTX,	 STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BONBUN, "본번"),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_TEXT(STARTX,	 STARTY+730, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "부번"),
		DLG_EDIT(STARTX+200, STARTY+730, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//구(신 주소)
		DLG_COMBO (STARTX+200, STARTY+590, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//도로명

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
	DlgObject	DlgRes_NEW_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "지정 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+800,  STARTY-40, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800,  STARTY+30, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+100, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+170, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+240, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "조 회"),
		DLG_BUTTON(STARTX+600, STARTY+780, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX,    STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "수용가번호"),
		DLG_TEXT(STARTX,    STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_BUTTON(STARTX, STARTY+100, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "바코드"),
		DLG_TEXT(STARTX,   STARTY+170, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "핸드폰번호"),
		DLG_TEXT(STARTX,   STARTY+240, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "집전화번호"),
		
		DLG_EDIT(STARTX+300,  STARTY-40, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300,  STARTY+30, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+100, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+170, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+240, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),
		
		DLG_TEXT(STARTX,       STARTY+350, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "◎주소검색"),
		DLG_BUTTON(STARTX+300, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+650, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),

		DLG_TEXT(STARTX, STARTY+450, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NWGOO, "구"),
		DLG_TEXT(STARTX, STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STREET, "도로명"),
		DLG_TEXT(STARTX, STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BONBUN, "본번"),
		DLG_TEXT(STARTX, STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "부번"),

		DLG_EDIT(STARTX+200, STARTY+590, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+450, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//구(신 주소)
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//도로명
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
				m_lActiveIndex = lActiveIndex;
				
				if( m_bFirst == INIT_MAIN )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+65) && Y < DMS_Y(STARTY+135) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+135) && Y < DMS_Y(STARTY+205) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+205) && Y < DMS_Y(STARTY+275) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+275) && Y < DMS_Y(STARTY+345) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+345) && Y < DMS_Y(STARTY+415) )
					{
						if( Get_iDlgCtrlByID(EDT_CSMNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OBJNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BARNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_CPTEL)  == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OWNTEL) == lActiveIndex )	
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
					else if( X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+660-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+730-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+730-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400))
					       )
					{
						if( Get_iDlgCtrlByID(EDT_BUNJI) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_HOSOO) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
						//	ShowSip(TRUE);
						//	g_Sipflag = 1;
						}
					}
					else
					{
						if( Get_iDlgCtrlByID(EDT_BUNJI) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_HOSOO) == lActiveIndex )
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
						else
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
						}
					}
				}
				else
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+65) && Y < DMS_Y(STARTY+135) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+135) && Y < DMS_Y(STARTY+205) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+205) && Y < DMS_Y(STARTY+275) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+275) && Y < DMS_Y(STARTY+345) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+345) && Y < DMS_Y(STARTY+415) 
					  )
					{
						if( Get_iDlgCtrlByID(EDT_CSMNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OBJNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BARNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_CPTEL) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OWNTEL) == lActiveIndex )	
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
					else if( X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+660-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+730-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+730-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400))
					       )
					{
						if( Get_iDlgCtrlByID(EDT_BONBUN) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BOOBUN) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
						//	ShowSip(TRUE);
						//	g_Sipflag = 1;
						}
					}
					else
					{
						if( Get_iDlgCtrlByID(EDT_BONBUN) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BOOBUN) == lActiveIndex )	
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
	
//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		char szStscd[5];
		char szcmb[20];
/*
		if( INIT_MAIN == m_bFirst )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				if ( index-1 == m_lActIndex )
				{
					//선택된 파일의 위치 INDEX를 글로벌변수에 저장
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					g_lMoveFlag = 1;
					Set_Index();
					if(g_nWorkFlag == 205)//선택검침으로 이동하면 
						g_nWorkFlag = 200;

					Card_Move("SC_CONFIRM");
					return;
				}
				else
				{
					//처음 선택된 대상의 주소를 상단에 표시
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "10") == 0 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 9));
					}
					else if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "20") == 0 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 6));
					}
					
					
					Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
					Mem_Set((byte*)szStscd, 0x00, sizeof(szStscd));
					Str_Cpy(szcmb, DlgTbl_GetStr( ID_TBLLIST, index-1, 8) );
					Str_Cpy(szStscd, DlgTbl_GetStr( ID_TBLLIST, index-1, 11) );
					
					if( szcmb[0] == 'Y' )
					{
						if( Str_Cmp(szStscd, "30") == 0 )
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), RED);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
						}
						else
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), BLACK);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						}
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), BLACK);
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
					}
										
					ON_DRAW();
					
					m_lActIndex = index - 1;//선택된 INDEX 저장
					//g_nActIndex = m_lpage*ROW + index - 1;
					Str_Cpy( g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
					Str_Cpy( stScAddr.SEND_YN, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 10));
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//콤보박스 선택으로 리스트 목록 필터링.(검침,미검침,전체대상)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
					g_nWorkFlag = 200;
				else if( Str_Cmp(m_szCobSel, "점검" ) == 0 )
					g_nWorkFlag = 206;
				else if( Str_Cmp(m_szCobSel, "미점검" ) == 0 )
					g_nWorkFlag = 207;
				else if( Str_Cmp(m_szCobSel, "우선점검" ) == 0 )
					g_nWorkFlag = 208;
					
				m_lpage = 0;
				m_lActIndex = 0;
				Cmb_Filter();
				REDRAW();
			}
			else
			{
				REDRAW();
			}
		}
*/
	}
	
//-----------------------------------------------------------------------------------------------
	void SetCombo(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			g_Sql_SetCombo("SELECT COUNTY FROM NORMAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_GOO+2);
			g_Sql_SetCombo("SELECT TOWN FROM NORMAL_DATA WHERE TOWN IS NOT NULL GROUP BY TOWN", CMB_DONG+2);
		}
		else
		{
			g_Sql_SetCombo("SELECT COUNTY FROM NORMAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_NWGOO+2);
			g_Sql_SetCombo("SELECT NEW_ROAD_NM FROM NORMAL_DATA WHERE NEW_ROAD_NM IS NOT NULL GROUP BY NEW_ROAD_NM", CMB_STREET+2);
		}
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
			//검색화면  ,, Barcode();
			case BID_SEARCH1:
			case BID_SEARCH2:
			case BID_SEARCH3:
			case BID_SEARCH4:
			case BID_SEARCH5:
			case BID_SEARCH6:
			case BID_SEARCH7:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( Search_Addr(ID) == FALSE)
					break;

				if(FS_GetSrchTotCnt() == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "입력한 자료가 없습니다.확인해 주세요.");
					break;
				}

				g_nWorkFlag = 205;
				m_lpage = 0;
				SetSearch();
				Set_Index();
				Card_Move("SC_CONFIRM");
				break;
			case BID_BAR:
				Barcode();
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
				if( g_Dlgflag > 0 )
				{
					return;
				}

				ShowSip(FALSE);
				g_Sipflag = 0;
				
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
				if( g_Dlgflag > 0 )
				{
					return;
				}
				
				Card_Move("SC_MENU");
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
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CSMNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CPTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DONG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BUNJI), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HOSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CSMNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OBJNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BARNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CPTEL), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OWNTEL), EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BUNJI), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_HOSOO), EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DONG), EDITALIGN_MIDDLE);
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
		}
		else
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CSMNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CPTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWGOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STREET), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BONBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOOBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CSMNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OBJNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BARNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CPTEL), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OWNTEL), EDITALIGN_MIDDLE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BONBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BOOBUN), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_NWGOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_STREET), EDITALIGN_MIDDLE);
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
		}
		
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
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

	
//-------------------------------------------------------------------------------
	bool Search_Addr(long nbuttonid)
	{
		char szWhere[400];
		char szObj[400];
		char szSql[2][600];
		long chki= 0;
	
	  	Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		Mem_Set( (byte*)szObj, 0x00, sizeof(szObj) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		
		if( nbuttonid == BID_SEARCH2 )
		{
			m_lBtnId = 1;
		
			Str_Cpy( szSql[1], "SELECT A.ROWID FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[0], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[1], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
		}
		else
		{
			m_lBtnId = 2;
		
			Str_Cpy( szSql[0], "SELECT ROWID FROM NORMAL_DATA WHERE ");
			Str_Cpy( m_szSql[0], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[1], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
		}

		
		if( nbuttonid == BID_SEARCH1 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CSMNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "설치장소 번호를 입력해 주세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CSMNUM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "INST_PLACE_NUM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CSMNUM) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		else if( nbuttonid == BID_SEARCH2 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OBJNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "기물 번호를 입력해 주세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OBJNUM)) > 0   ) 
			{
				Mem_Set( (byte*)szObj, 0x00, sizeof(szObj) );
				Str_Cat( szObj, "B.MTR_ID_NUM = '" );
				Str_Cat( szObj, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_OBJNUM) ) );
				Str_Cat( szObj, "' " );
				
				Str_Cat( szSql[1], szObj );
				Str_Cat( m_szSql[0], szObj );
				Str_Cat( m_szSql[1], szObj );
			}			
		}
		else if( nbuttonid == BID_SEARCH3)
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BARNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "바코드를 입력해 주세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BARNUM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "BAR = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BARNUM) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}	
		}
		else if( nbuttonid == BID_SEARCH4)
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CPTEL)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "전화번호를 입력해 주세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CPTEL) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "CP_DDD ||''|| CP_EXN ||''|| CP_NUM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CPTEL) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}	
		}
		else if( nbuttonid == BID_SEARCH5)
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OWNTEL)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "전화번호를 입력해 주세요.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OWNTEL) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "OWNHOUSE_TEL_DDD ||''|| OWNHOUSE_TEL_EXN ||''|| OWNHOUSE_TEL_NUM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_OWNTEL) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}	
		}
		else if( nbuttonid == BID_SEARCH6 )
		{	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BUNJI)) == 0   
        	)
			{
				MessageBoxEx (CONFIRM_OK, "번지를 입력해 주세요.");
				return FALSE;
			}
			/*
			else if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HOSOO)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "호수를 입력해 주세요.");
				return FALSE;
			}
			*/
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_GOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "COUNTY = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_GOO) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DONG) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "TOWN = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DONG) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BUNJI) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_M = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BUNJI) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HOSOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_S = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_HOSOO) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		else if( nbuttonid == BID_SEARCH7 )
		{	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BONBUN)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "본번을 입력해 주세요.");
				return FALSE;
			}
			/*
			else if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BOOBUN)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "부번을 입력해 주세요.");
				return FALSE;
			}
			*/
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_NWGOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "COUNTY = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_NWGOO) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_STREET) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ROAD_NM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_STREET) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BONBUN) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_M = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BONBUN) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BOOBUN) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_S = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BOOBUN) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}

		if( nbuttonid == BID_SEARCH2 )
		{
			Str_Cat( szSql[1], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			Str_Cat( m_szSql[0], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			Str_Cat( m_szSql[1], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			g_Sql_SaveSeq( szSql[1], SREACH_FILE);
		}
		else
		{
			Str_Cat( szSql[0], "ORDER BY HOUSE_NUM_ORD, DONG_ORD");
			Str_Cat( m_szSql[0], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			Str_Cat( m_szSql[1], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			g_Sql_SaveSeq( szSql[0], SREACH_FILE);
		}

		//페이지를 초기화시킨다.
		m_lpage = 0;
		
		return TRUE;
	}
		
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetSearch(void)
	{
		long i, idx;
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
				Mem_Set( (byte*)stSc.CHK_EXEC_NUM, 0x00, sizeof(stSc.CHK_EXEC_NUM) );
				sql->GetValue(sql, 0, 'U', (long*)stSc.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stSc.CHK_EXEC_NUM);
				
				Mem_Set( (byte*)stScAddr.SEND_YN, 0x00, sizeof(stScAddr.SEND_YN) );
				sql->GetValue(sql, 1, 'U', (long*)stScAddr.SEND_YN, 1 + 1, DECRYPT);
			}
			else
			{	//기물번호를 제외한 나머지 검색
				Mem_Set( (byte*)stSc.CHK_EXEC_NUM, 0x00, sizeof(stSc.CHK_EXEC_NUM) );
				sql->GetValue(sql, 0, 'U', (long*)stSc.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stSc.CHK_EXEC_NUM);

				Mem_Set( (byte*)stScAddr.SEND_YN, 0x00, sizeof(stScAddr.SEND_YN) );
				sql->GetValue(sql, 1, 'U', (long*)stScAddr.SEND_YN, 1 + 1, DECRYPT);
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

		return;
	}
	
//-----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		if (nEvent == UART_BARCODE)
		{
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				PDA_OnBarcodeRead();
			}
			else
			{
				OnBarcodeRead();
			}
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

//=======================================================================================
	void OnBarcodeRead(void)
	{
		char szSql[300];
		char szBar[10];
		long lCnt, lRow;
		long RetFlag = -1;
		long ret = 0;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			ret = Barcode_Read( m_szBarcode_Value );	
			if( ret < 0)
			{
				MessageBoxEx (ERROR_OK, "바코드 읽기 실패");
				goto Finally;
			}
		}

		if( Str_Len(m_szBarcode_Value) > 5 )
		{
			//바코드 정보
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 9);
			Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), m_szBarcode_Value ) ;

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );

			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
				g_Sql_RetInt( szSql, &lRow );
				
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
				g_Sql_SaveSeq( szSql, SREACH_FILE);
	
				g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				RetFlag = 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "입력한 자료가 없습니다.확인해 주세요.");
				Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				goto Finally;
			}

		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "바코드 길이가 맞지 않습니다.");
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			goto Finally;
		}

Finally:
		
		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}
		
		if( RetFlag > 0 )
		{
			Card_Move("SC_CONFIRM");
		}

		ON_DRAW();
		return;
	}
	
	
//=======================================================================================
	void PDA_OnBarcodeRead(void)
	{
	char szSql[300];
	char szBar[10];
	long lCnt, lRow;
	long RetFlag = -1;
	long ret = 0;

		Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
		ret = Barcode_Read( m_szBarcode_Value );	
		if( ret < 0)
		{
			MessageBoxEx (ERROR_OK, "바코드 읽기 실패");
			goto Finally;
		}

		if( Str_Len(m_szBarcode_Value) > 5 )
		{
			//바코드 정보
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 9);
			Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), m_szBarcode_Value ) ;

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );

			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
				g_Sql_RetInt( szSql, &lRow );
				
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
				g_Sql_SaveSeq( szSql, SREACH_FILE);
	
				g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				RetFlag = 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "입력한 자료가 없습니다.확인해 주세요.");
				Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				goto Finally;
			}

		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "바코드 길이가 맞지 않습니다.");
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			goto Finally;
		}

Finally:
		
		ON_DRAW();
		
		if( RetFlag > 0 )
		{
			Card_Move("SC_CONFIRM");
		}
		
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
/*
	if( Get_iDlgCtrlByID(EDT_CSMNUM) == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_OBJNUM) == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_BARNUM) == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_CPTEL)  == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_OWNTEL) == lActiveIndex )	

	char m_szInstNum[11];
	char m_szMtrNum[11];
	char m_szBarNum[22];
	char m_szCpNum[15];
	char m_szHouseNum[15];
*/

		Mem_Set( (byte*)m_szInstNum, 0x00, sizeof(m_szInstNum) );
		Mem_Set( (byte*)m_szMtrNum, 0x00, sizeof(m_szMtrNum) );
		Mem_Set( (byte*)m_szBarNum, 0x00, sizeof(m_szBarNum) );
		Mem_Set( (byte*)m_szCpNum, 0x00, sizeof(m_szCpNum) );
		Mem_Set( (byte*)m_szHouseNum, 0x00, sizeof(m_szHouseNum) );
		
		Str_Cpy(m_szInstNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_CSMNUM)) );
		Str_Cpy(m_szMtrNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_OBJNUM)) );
		Str_Cpy(m_szBarNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_BARNUM)) );
		Str_Cpy(m_szCpNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_CPTEL)) );
		Str_Cpy(m_szHouseNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_OWNTEL)) );
	}
	
//-------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		if( Str_Len(m_szInstNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CSMNUM), m_szInstNum);
		}
		
		if( Str_Len(m_szMtrNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_OBJNUM), m_szMtrNum);
		}
		
		if( Str_Len(m_szBarNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_BARNUM), m_szBarNum);
		}
		
		if( Str_Len(m_szCpNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CPTEL), m_szCpNum);
		}
		
		if( Str_Len(m_szHouseNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_OWNTEL), m_szHouseNum);
		}
	}
}



