/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_LST
	Card Desc : 안전점검 리스트
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_LST
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
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )			//홈
		DEF_BUTTON_ID ( BID_MENU )			//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )		//키보드
		DEF_BUTTON_ID ( BID_SCREEN )		//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )		//공통업무
		DEF_BUTTON_ID ( BID_PREV )			//이전
		DEF_BUTTON_ID ( BID_EXIT )			//종료
		
		//안전점검 리스트
		DEF_BUTTON_ID ( BID_BARCODE )		//바코드
		DEF_BUTTON_ID ( BID_LIST_SEARCH )	//검 색
		DEF_BUTTON_ID ( BID_ADDR )			//새주소
		DEF_BUTTON_ID ( BID_NADDR )
		DEF_BUTTON_ID ( BID_SMS )			//SMS 발송
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//도로명주소 스크롤 호출
		
		//검색
		DEF_BUTTON_ID ( BID_SEARCH1 )		//수용가번호 조회
		DEF_BUTTON_ID ( BID_SEARCH2 )		//기물번호 조회
		DEF_BUTTON_ID ( BID_SEARCH3 )		//바코드 조회
		DEF_BUTTON_ID ( BID_SEARCH4 )
		DEF_BUTTON_ID ( BID_SEARCH5 )
		DEF_BUTTON_ID ( BID_SEARCH6 )		//조회
		DEF_BUTTON_ID ( BID_SEARCH7 )

		DEF_BUTTON_ID ( BID_SCHDL )
		DEF_BUTTON_ID ( BID_CANCEL )
		DEF_BUTTON_ID ( BID_SEND )
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		//안전점검 리스트
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//페이지
		DEF_OBJECT_ID ( TXT_ADDR1 )
		DEF_OBJECT_ID ( TXT_ADDR2 )
		DEF_OBJECT_ID ( TXT_ADDR3 )
		//검색
		DEF_OBJECT_ID ( TXT_TITLE2 )		//타이틀
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
		//SMS 송신
		DEF_OBJECT_ID ( TXT_DATA1 )		
		DEF_OBJECT_ID ( TXT_DATA2 )			
		DEF_OBJECT_ID ( TXT_DATA3 )			
		DEF_OBJECT_ID ( TXT_DATA4 )		
		DEF_OBJECT_ID ( TXT_DATA5 )		
		DEF_OBJECT_ID ( TXT_DATA6 )			
		DEF_OBJECT_ID ( TXT_DATA7 )		
		DEF_OBJECT_ID ( TXT_DATA8 )		
		DEF_OBJECT_ID ( TXT_DATA9 )		
		DEF_OBJECT_ID ( TXT_DATA10)		
		DEF_OBJECT_ID ( TXT_DATA11)		
		DEF_OBJECT_ID ( TXT_DATA12)
		DEF_OBJECT_ID ( TXT_DATA13)
		DEF_OBJECT_ID ( TXT_DATA14)
		DEF_OBJECT_ID ( TXT_DATA15)
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )	
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		//안전점검 리스트
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		
		DEF_OBJECT_ID ( CMB_SELECT )    			//대상 필터
		DEF_OBJECT_ID ( CMB_GOO = CMB_SELECT+3 ) 	//구
		DEF_OBJECT_ID ( CMB_DONG = CMB_GOO+3 ) 		//동
		DEF_OBJECT_ID ( CMB_NWGOO = CMB_DONG+3 ) 	//구
		DEF_OBJECT_ID ( CMB_STREET = CMB_NWGOO+3 ) 	//도로명
		DEF_OBJECT_ID ( CMB_TIME1 = CMB_STREET+3 )
		DEF_OBJECT_ID ( CMB_TIME2 = CMB_TIME1+3 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5						// table의 행개수
	#define		COL 	    12						// table의 열개수
	#define		GRID_H		(CHT+66)				// table 행 높이
	#define		GRID_H_P	(CHT+60)				// table 행 높이
	#define		GRID_CLR	TRANSPARENT   			// table 클리어 color
	#define		GRID_X		STARTX 					// table 시작x좌표
	#define		MAXCHAR		201 			    	// table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+260  	    	// table 시작y좌표
	#define		GRID_Y_P	STARTY+250  	    	// table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; 	// 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"단독공동여부", CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소",	     CWD*19+13, EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상태",         CWD*5,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"결과",         CWD*7,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"전화번호",     CWD*8+10,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소",	     CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소",     CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"점검시행번호", CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"SMS발송여부",  CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소2",    CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소정보확인", CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CONT_STS_CD",  CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN	1
	#define INIT_SRCH	2
	#define INIT_SMS	3
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	long m_lBtnId = -1;
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index 관련 flag
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_lActIndex = -1;		//액티브된 index
	long m_lSmsNonPay ;	//
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szSql[2][3000];
	char m_szQuickSql[3000];	//퀵뷰 쿼리 전용
	char m_szCobSel[20];
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	char m_szSingle_Flag[10];
	char m_szBarcode_Value[20];	//바코드 스캔 결과
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	bool Search_Addr(long nbuttonid);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void Cmb_Filter(void);
	void SetCombo(void);
	void SetComboIdx(void);
	void Set_Index(void); 	//선택한 대상 인덱스 저장
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
	void SetSearch(void);
	void REDRAW(void);
	void SMSSEND_DRAW(void);
	bool Save_SmsSend(void);
	void Snd_Sms(void);
	long TR312316(void);
	
	void SetBtnImg(void);
	void Barcode(void);
	void OnBarcodeRead(void);
	void PDA_OnBarcodeRead(void);
	long SearchCD(char *CD, CodeTable *CT);		//코드 값을 찾는다.
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	void OnList(quad lParam);
	void Grid_QuickList(long nBtnID);
	
	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
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
	
	//---------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "상세 리스트"),

		DLG_BUTTON(STARTX,	   STARTY+ 65,  250,  65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		DLG_BUTTON(STARTX+250, STARTY+ 65,  250,  65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		DLG_COMBO (STARTX+500, STARTY+ 65,  500, 250, 150, 65, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),
		
		DLG_TEXT(  STARTX,     STARTY+130, 1000,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		
		DLG_BUTTON(STARTX,     STARTY+210,  333,  50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+333, STARTY+210,  333,  50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "바코드"),
		DLG_BUTTON(STARTX+666, STARTY+210,  334,  50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS발송"),
		
		// 리스트		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H-56, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(  STARTX, 	   STARTY+839,  333,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+333, STARTY+839,  333,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+666, STARTY+839,  334,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),	
	};	
	
	//---------------------------------------------------------------
	// 지정 점검 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Srch[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "지정 점검"),

		DLG_BUTTON(STARTX+800, STARTY+80 , 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+130 , 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+180, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+230, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+280, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+340, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+600, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX, STARTY+80 , 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "수용가번호"),
		DLG_TEXT(STARTX, STARTY+130 , 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_TEXT(STARTX, STARTY+180, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BARNUM, "바코드"),
		DLG_TEXT(STARTX, STARTY+230, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_CPTEL , "핸드폰번호"),
		DLG_TEXT(STARTX, STARTY+280, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "집전화번호"),
		DLG_TEXT(STARTX, STARTY+340, 800, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_ADDR, "주소"),
		DLG_TEXT(STARTX, STARTY+390, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_GOO, "구"),
		DLG_TEXT(STARTX, STARTY+440, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DONG, "동"),
		DLG_TEXT(STARTX, STARTY+490, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BUNJI, "번지"),
		DLG_TEXT(STARTX, STARTY+540, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_HOSOO, "호수"),
		DLG_TEXT(STARTX, STARTY+600, 800, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWADDR, "신주소"),
		DLG_TEXT(STARTX, STARTY+650, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWGOO, "구"),
		DLG_TEXT(STARTX, STARTY+700, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_STREET, "도로명"),
		DLG_TEXT(STARTX, STARTY+750, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BONBUN, "본번"),
		DLG_TEXT(STARTX, STARTY+800, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "부번"),
		
		DLG_EDIT(STARTX+300, STARTY+80 , 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+130 , 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+180, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+230, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+280, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),
		DLG_EDIT(STARTX+200, STARTY+490, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BUNJI , 10,  ""),
		DLG_EDIT(STARTX+200, STARTY+540, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_HOSOO , 10,  ""),
		DLG_EDIT(STARTX+200, STARTY+750, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_EDIT(STARTX+200, STARTY+800, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+390, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//구(구 주소)
		DLG_COMBO (STARTX+200, STARTY+440, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//동
		DLG_COMBO (STARTX+200, STARTY+650, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//구(신 주소)
		DLG_COMBO (STARTX+200, STARTY+700, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//도로명
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "상세 리스트"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+500,	STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+750,	STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),
//		DLG_BUTTON(STARTX,     STARTY+225, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_LIST_SEARCH, "지정 점검"),
		DLG_BUTTON(STARTX,		STARTY+180, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		//DLG_BUTTON(STARTX+330, STARTY+160, 320, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+333,	STARTY+180, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "바코드"),
		DLG_BUTTON(STARTX+666,	STARTY+180, 334, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS발송"),
				
		DLG_TEXT(STARTX,		 STARTY+30, 1000, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		DLG_TEXT(STARTX,		STARTY+829, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		
		DLG_COMBO (STARTX+500,  STARTY-40, 500, 250, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// 리스트		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};
	
	//---------------------------------------------------------------
	// PDA / 지정 점검 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_Srch_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "지정 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+800, 70		 , 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+20 , 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+70, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+120, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+170, 175, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+230, 175, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "조 회"),
		DLG_BUTTON(STARTX+800, STARTY+540, 175, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "조 회"),

		//체크박스 텍스트		
		DLG_TEXT(STARTX, 		 70, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "수용가번호"),
		DLG_TEXT(STARTX,  STARTY+20, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호"),
		DLG_TEXT(STARTX,  STARTY+70, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BARNUM, "바코드"),
		DLG_TEXT(STARTX, STARTY+120, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_CPTEL , "핸드폰번호"),
		DLG_TEXT(STARTX, STARTY+170, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "집전화번호"),
		
		DLG_EDIT(STARTX+300,		 70, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300,  STARTY+20, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300,  STARTY+70, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+120, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+170, 500, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_OWNTEL, 15,  ""),
		
		DLG_TEXT(STARTX, STARTY+230, 800, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_ADDR, "주소"),
		DLG_TEXT(STARTX, STARTY+290, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_GOO, "구"),
		DLG_TEXT(STARTX, STARTY+350, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DONG, "동"),
		DLG_TEXT(STARTX, STARTY+410, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BUNJI, "번지"),
		DLG_TEXT(STARTX, STARTY+470, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_HOSOO, "호수"),
		
		DLG_TEXT(STARTX, STARTY+540, 800, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWADDR, "신주소"),
		DLG_TEXT(STARTX, STARTY+600, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NWGOO, "구"),
		DLG_TEXT(STARTX, STARTY+660, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_STREET, "도로명"),
		DLG_TEXT(STARTX, STARTY+720, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BONBUN, "본번"),
		DLG_TEXT(STARTX, STARTY+780, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "부번"),
		
		DLG_EDIT(STARTX+200, STARTY+410, 775, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_BUNJI , 10,  ""),
		DLG_EDIT(STARTX+200, STARTY+470, 775, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_HOSOO , 10,  ""),
		
		DLG_EDIT(STARTX+200, STARTY+720, 775, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_EDIT(STARTX+200, STARTY+780, 775, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+290, 775, 200, 150, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//구(구 주소)
		DLG_COMBO (STARTX+200, STARTY+350, 775, 200, 150, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//동
		DLG_COMBO (STARTX+200, STARTY+600, 775, 200, 150, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//구(신 주소)
		DLG_COMBO (STARTX+200, STARTY+660, 775, 200, 150, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//도로명
	};
	
	//---------------------------------------------------------------
	//  SMS발송
	//---------------------------------------------------------------
	DlgObject	DlgRes_SMSSEND[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SMS 문자발송"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,		STARTY+390, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "닫기"),
		DLG_BUTTON(STARTX+600,	STARTY+390, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "전송"),
		
		DLG_TEXT ( STARTX,			STARTY-29, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "방문일자"),
		DLG_EDIT( STARTX+250,		STARTY-29, 200, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+450,		STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+450,		STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, "."),
		DLG_EDIT( STARTX+470,		STARTY-29, 170, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+640,		STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+640,		STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, "."),
		DLG_EDIT( STARTX+660,		STARTY-29, 165, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825,		STARTY-29, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "▼"),
		//DLG_TEXT ( STARTX+250,	    STARTY, 575, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		//DLG_BUTTON(STARTX+825,      STARTY, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),

		DLG_TEXT ( STARTX,	     STARTY+41, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "방문시간"),
		DLG_COMBO (STARTX+250,   STARTY+41, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME1, 10),
		DLG_TEXT ( STARTX+500,	 STARTY+41, 125, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "시 ~"),
		DLG_COMBO (STARTX+625,   STARTY+41, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME2, 10),
		DLG_TEXT ( STARTX+875,	 STARTY+41, 125, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "시"),
			
		DLG_TEXT ( STARTX,	    STARTY+111, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "소속"),
		DLG_TEXT ( STARTX+250,	STARTY+111, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	    STARTY+181, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "점검원"),
		DLG_TEXT ( STARTX+250,	STARTY+181, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	    STARTY+251, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "고객H.P"),
		DLG_TEXT ( STARTX+250,	STARTY+251, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
	};
	
	//---------------------------------------------------------------
	//  PDA SMS발송
	//---------------------------------------------------------------
	DlgObject	DlgRes_SMSSEND_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SMS 문자발송"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,  STARTY+390, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "닫기"),
		DLG_BUTTON(STARTX+675,   STARTY+390, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "전송"),
		
		DLG_TEXT ( STARTX,	        STARTY, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "방문일자"),
		DLG_EDIT( STARTX+250,     STARTY, 200, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+450,      STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+450,   STARTY+70,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, "."),
		DLG_EDIT( STARTX+470,     STARTY, 170, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+640,      STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+640,   STARTY+70,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, "."),
		DLG_EDIT( STARTX+660,     STARTY, 165, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825,    STARTY, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "▼"),
		//DLG_TEXT ( STARTX+250,	    STARTY, 575, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		//DLG_BUTTON(STARTX+825,      STARTY, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),

		DLG_TEXT ( STARTX,	     STARTY+70, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "방문시간"),
		DLG_COMBO (STARTX+250,   STARTY+70, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME1, 10),
		DLG_TEXT ( STARTX+500,	 STARTY+70, 125, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA10, "시 ~"),
		DLG_COMBO (STARTX+625,   STARTY+70, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME2, 10),
		DLG_TEXT ( STARTX+875,	 STARTY+70, 100, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA11, "시"),
			
		DLG_TEXT ( STARTX,	    STARTY+140, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "소속"),
		DLG_TEXT ( STARTX+250,	STARTY+140, 725, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	    STARTY+210, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5, "점검원"),
		DLG_TEXT ( STARTX+250,	STARTY+210, 725, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	    STARTY+280, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA7, "고객H.P"),
		DLG_TEXT ( STARTX+250,	STARTY+280, 725, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
	};
	
	//---------------------------------------------------------------
	// main
	//---------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
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
		char szTmp[200];
		
		i = lParam;
		
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			g_lMoveFlag = 1;
			Set_Index();			
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "SELECT (SELECT B.SEND_YN FROM NORMAL_ADDR B WHERE B.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A WHERE ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 5, stScAddr.SEND_YN);
			
			Card_Move("SC_CONFIRM");
		}
		
		return;
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

				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "전체", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "점검", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "순수미점검", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "부재미점검", 0, ICON_NONE);
				
				Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				SetBtnImg();
				SetStyle();
				//g_nWorkFlag = 205 > 선택점검(검색)
				if( g_nWorkFlag != 205 )
				{
					if( g_nWorkFlag == 206 )
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "점검");
						Str_Cpy(m_szCobSel, "점검");							
					}
					else if( g_nWorkFlag == 207 )
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "순수미점검");
						Str_Cpy(m_szCobSel, "순수미점검");							
					}
					else if( g_nWorkFlag == 210 )
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "부재미점검");
						Str_Cpy(m_szCobSel, "부재미점검");							
					}
					else
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "전체");
						Str_Cpy(m_szCobSel, "전체");							
					}
					//Cmb_Filter();
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "전체");
					Str_Cpy(m_szCobSel, "전체");	
				}
				Cmb_Filter();
				REDRAW();
				break;
			case INIT_SRCH:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Srch_P, SIZEOF(DlgRes_Srch_P));
						
						SetBtnImg();
						SetCombo();
						SetStyle();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_Srch, SIZEOF(DlgRes_Srch));
						
						SetBtnImg();
						SetCombo();
						SetStyle();
						break;		
				}
				break;
			case INIT_SMS:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_SMSSEND_P, SIZEOF(DlgRes_SMSSEND_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_SMSSEND, SIZEOF(DlgRes_SMSSEND));
						break;
				}
				
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				m_lSmsNonPay = 0;

				SMSSEND_DRAW();

				// if( m_lSmsNonPay == 1)
				// {
				// 	MessageBoxEx (CONFIRM_OK, "체납 중지세대 입니다.");
				// }
				
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
//		if( m_bFirst == INIT_MAIN )
//			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
//		else if( m_bFirst == INIT_SRCH )
//			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgSubTtl );		//타이틀
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀		
		
		if( theDevInfo.m_nType != FAMILY_PDA && (m_bFirst == INIT_MAIN || m_bFirst == INIT_SRCH ) )
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
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		char szDate[10];
		
		if( m_bFirst == INIT_SMS )
		{
			//숫자만 입력 가능
			if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex 
			|| Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex
			|| Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
	
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
			
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				else
				{
					Mem_Set((byte *)szDate, 0x00, sizeof(szDate));
					Str_ItoA(Time_GetDate(), szDate, 10);
					if( Str_AtoI(szDate) > Str_AtoI(szTmp) )
					{
						MessageBoxEx (CONFIRM_OK, "날짜를 확인하세요..");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
						
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
						m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
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
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( m_bFirst == INIT_SMS )
		{
			if( POINTING_UP == nAction )
			{
				m_lActiveIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+450) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+470) && X < DMS_X(STARTX+640) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+660) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
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


/*
		if( m_bFirst == INIT_SRCH )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+80) && Y < DMS_Y(STARTY+130) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+130) && Y < DMS_Y(STARTY+180) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+180) && Y < DMS_Y(STARTY+230) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+230) && Y < DMS_Y(STARTY+280) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+280) && Y < DMS_Y(STARTY+330) )
					{
						m_lActiveIndex = lActiveIndex;
					
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
					else if( X > DMS_X(STARTX+200) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+490-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+540-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+540-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+590-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+750-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+800-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+850-(g_Dlgflag*400)) )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( Get_iDlgCtrlByID(EDT_BUNJI) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_HOSOO) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BONBUN) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BOOBUN) == lActiveIndex )	
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
					
					ON_DRAW();
				}
			}
		}
*/
	}
	
//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		char szStscd[5];
		char szcmb[20];
		char szAddr[200];
		
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

					Card_Move("SC_CONFIRM");
					return;
				}
				else
				{
					Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
					//처음 선택된 대상의 주소를 상단에 표시
					Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					Str_Cat(szAddr, "  ");
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "10") == 0 )
					{
						Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, index-1, 9));
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 9));
					}
					else if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "20") == 0 )
					{
						Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, index-1, 6));
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 6));
					}
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), szAddr);
					
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
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						}
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
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
				else if( Str_Cmp(m_szCobSel, "순수미점검" ) == 0 )
					g_nWorkFlag = 207;
				else if( Str_Cmp(m_szCobSel, "부재미점검" ) == 0 )
					g_nWorkFlag = 210;
					
				m_lpage = 0;
				m_lActIndex = 0;
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), "");
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), "");
				Cmb_Filter();
				REDRAW();
			}
			else
			{
				REDRAW();
			}
		}
	}
	
//-----------------------------------------------------------------------------------------------
	void SetCombo(void)
	{
		g_Sql_SetCombo("SELECT COUNTY FROM NORMAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_GOO+2);
		g_Sql_SetCombo("SELECT TOWN FROM NORMAL_DATA WHERE TOWN IS NOT NULL GROUP BY TOWN", CMB_DONG+2);
		g_Sql_SetCombo("SELECT COUNTY FROM NORMAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_NWGOO+2);
		g_Sql_SetCombo("SELECT NEW_ROAD_NM FROM NORMAL_DATA WHERE NEW_ROAD_NM IS NOT NULL GROUP BY NEW_ROAD_NM", CMB_STREET+2);
	}
	
//---------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{
		long d, k;
		char szToday[11];
		char szDate[11];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char sztmp[20];	
	
		switch(ID)
		{
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				Grid_QuickList(ID);
				break;
			case BID_BARCODE:
				Barcode();
				break;
			case BID_ADDR:
				if( g_nAddrFlag == 0 )
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
				break;
			case BID_SMS:
				ON_EXIT();
				OnInit(INIT_SMS);
				break;
			case BID_SCHDL:
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));		
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
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
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Str_ItoA ( d, szDate, 10);
					Str_ItoA ( Time_GetDate(), szToday, 10);
					if( Str_AtoI(szToday) <= Str_AtoI(szDate) )
					{
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
						Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
						Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

						//g_Str_DateType(szToday, szDate);
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), szToday );
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "날짜를 확인하세요..");
					}
					
				}
				break;
			case BID_SEND:
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			
				
				if( Str_Len(sztmp) < 8 )
				{
					MessageBoxEx (CONFIRM_OK, "방문일자를 선택해주세요.");
					break;
				}
				else
				{
					if( m_lSmsNonPay == 1)
					{
						if( MessageBoxEx (CONFIRM_YESNO, "체납 중지세대입니다.\n 계속 진행하시겠습니까?")  == MB_OK)
						{
							if( Save_SmsSend() )
							{
								ON_EXIT();
								OnInit(INIT_MAIN);
							}
							//Snd_Sms();

						}
					}
					else
					{
						if( Save_SmsSend() )
						{
							ON_EXIT();
							OnInit(INIT_MAIN);
						}
					//Snd_Sms();
					}
					
				
				}
				

				break;
				
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;	
			case BID_PREVPG:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//REDRAW();
					break;
				}
				m_lActIndex = 0;
				REDRAW();
				break;
			case BID_NEXTPG:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//REDRAW();
					break;
				}
				m_lActIndex = 0;

				REDRAW();
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
				if( INIT_SMS == m_bFirst)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else
				{
					g_lMoveFlag = 0;
					Card_Move("SC_MENU");
				}
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR3), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_PAGE), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR2), TRUE, 2, EDITSEP_NONE );
		}
		
/*
		else
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CSMNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BARNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CPTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DONG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BUNJI), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HOSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWGOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STREET), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BONBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOOBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CSMNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OBJNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BARNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BUNJI), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_HOSOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BONBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BOOBUN), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DONG), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_NWGOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_STREET), EDITALIGN_MIDDLE);
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
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", g_lindex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

	/*=======================================================================================
	함수명 : Get_Index
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Get_Index(void)
	{
		char szSql[201];
		char szbuf[10];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '2' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

/*
		g_nActIndex = Str_AtoI(szbuf);
		g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		m_lpage = g_nActIndex / ROW;
		m_lActIndex = (g_nActIndex % ROW);
*/

		g_lindex = Str_AtoI(szbuf);
		g_nActIndex = g_Get_FsIndex(g_lindex, SREACH_FILE);
		m_lpage = g_nActIndex / ROW;
		m_lActIndex = (g_nActIndex % ROW);
	}

	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 그리드 DRAW
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i, idx, n;
		long k = ROW+1;		//i랑 겹치지 않는 숫자로 초기화
		long lTotpage = 0;
		char sztmp[201];
		char szPreuse[15];
		char szChkNum[15];
		char szCnt[15];
		char szStscd[5];
		char szOldBoilYn[2];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/*********************************************/
		/* PAGE SETTING                              */
		/*********************************************/
		lTotpage = FS_GetSrchTotCnt();
		m_lTotpage = lTotpage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		if( m_lIdxFlag == 0 )
		{
			//프로그램 시작 시 불러오는 인덱스
			Get_Index();
		}
		
		Mem_Set( (byte*)m_szCnt_page, 0x00, sizeof(m_szCnt_page) );
		SPRINT(m_szCnt_page, "%d/%d\n%d", m_lpage+1, m_lTotpage, lTotpage);
		
		/*********************************************/
		/* GRID SETTING                              */
		/*********************************************/
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
		}
		else
		{
			hstmt = sql->CreateStatement(sql, m_szSql[1]);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
		}

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				/************************************/
				/* 단독주택                         */
				/************************************/
				if( Str_Cmp(sztmp, "10") == 0 )
				{
					idx = 0;
					
					// 1. 주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 200 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					
					// 2. 상태
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szPreuse, 0x00, sizeof(szPreuse) );
					Mem_Set( (byte*)szChkNum, 0x00, sizeof(szChkNum) );
					Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
					Mem_Set( (byte*)szOldBoilYn, 0x00, sizeof(szOldBoilYn) );
					
					sql->GetValue(sql, 10, 'U', (long*)szPreuse, 2  + 1, DECRYPT);
					sql->GetValue(sql, 11, 'U', (long*)szChkNum, 12 + 1, DECRYPT);
					sql->GetValue(sql, 12, 'U', (long*)szCnt,     5 + 1, DECRYPT);
					sql->GetValue(sql, 17, 'U', (long*)szOldBoilYn,     2 + 1, DECRYPT);
					
					// 2.1. 우선점검 여부(F)
					if( Str_Len(szPreuse) > 0 )
					{
						Str_Cpy(sztmp, "F");
					}
					else
					{
						Str_Cpy(sztmp, "");
					}
					
					// 2.2. 부재방문 여부 및 카운트(B)
					if( Str_Len(szChkNum) > 0 )
					{
						Str_Cat(sztmp, "B");
						Str_Cat(sztmp, szCnt);
					}
					else
					{
						Str_Cat(sztmp, "");
					}
					
					// 2.3. 보일러점검 여부
					if( Str_Len(szOldBoilYn) > 0 )
					{
						Str_Cat(sztmp, "\n보");
					}
					else
					{
						Str_Cat(sztmp, "");
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					// 3. 결과
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					
					// 3.1. 부적합 글자 색 RED 변경  
					if( Str_Cmp(sztmp, "21") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					
					// 3.2. 결과 내용
					n = SearchCD( sztmp, SCCHK_RSLT );
					
					if( n == -1 || n == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "미검" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, SCCHK_RSLT[n].Str );
					}
					
					// 4. 전화번호
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 5 + 1, DECRYPT);
					
					// 4.1. 자택번호가 있다면
					if( Str_Len(sztmp) > 0 )
					{
						// 자택번호
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 5, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					// 4.2. 자택번호가 없다면
					else
					{
						// 휴대폰번호
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 6, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					
					// 5. 기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 190 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					
					// 6. 상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 190 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					
					// 7. 점검시행번호
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 12 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					
					// 8. SMS발송여부
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					
					// 8.1. SMS발송여부가 Y면 파란색 글자색 변경
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), BLUE);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), TXTFRCOLOR);
					}
					
					// 8.2. 보일러 점검 여부가 Y면 빨간색 글자색 변경
					if( Str_Cmp(szOldBoilYn, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
					}
					
					// 9. 상세주소2
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 14, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					// 10. 주소정보확인
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 15, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
					
					// 11. CONT_STS_CD, SMS송신버튼 관련
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 16, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, sztmp );
				}
				/************************************/
				/* 공동주택                         */
				/************************************/
				else
				{
					idx = 0;
					
					// 1. 주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 200, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

					// 2. 상태
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szPreuse, 0x00, sizeof(szPreuse) );
					Mem_Set( (byte*)szChkNum, 0x00, sizeof(szChkNum) );
					Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
					Mem_Set( (byte*)szOldBoilYn, 0x00, sizeof(szOldBoilYn) );
					
					sql->GetValue(sql, 10, 'U', (long*)szPreuse, 2  + 1, DECRYPT);
					sql->GetValue(sql, 11, 'U', (long*)szChkNum, 12 + 1, DECRYPT);
					sql->GetValue(sql, 12, 'U', (long*)szCnt,     5 + 1, DECRYPT);
					sql->GetValue(sql, 17, 'U', (long*)szOldBoilYn,     2 + 1, DECRYPT);
					
					// 2.1. 우선점검 여부(F)
					if( Str_Len(szPreuse) > 0 )
					{
						Str_Cpy(sztmp, "F");
					}
					else
					{
						Str_Cpy(sztmp, "");
					}
					
					// 2.2. 부재방문 여부 및 카운트(B)
					if( Str_Len(szChkNum) > 0 )
					{
						Str_Cat(sztmp, "B");
						Str_Cat(sztmp, szCnt);
					}
					else
					{
						Str_Cat(sztmp, "");
					}
					
					// 2.3. 보일러점검 여부
					if( Str_Len(szOldBoilYn) > 0 )
					{
						Str_Cat(sztmp, "\n보");
					}
					else
					{
						Str_Cat(sztmp, "");
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					// 3. 결과
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					
					// 3.1. 부적합 글자 색 RED 변경  
					if( Str_Cmp(sztmp, "21") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					
					// 3.2. 결과 내용
					n = SearchCD( sztmp, SCCHK_RSLT );
					
					if( n == -1 ||n == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "미검" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, SCCHK_RSLT[n].Str );
					}
					
					// 4. 전화번호
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 5 + 1, DECRYPT);
					
					// 4.1. 자택번호가 있다면
					if( Str_Len(sztmp) > 0 )
					{
						// 자택번호
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 5, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					// 4.2. 자택번호가 없다면
					else
					{
						// 휴대폰번호
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 6, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					
					// 5. 기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					
					// 6. 상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					
					// 7. 점검시행번호
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 12 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					
					// 8. SMS발송여부
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					
					// 8.1. SMS발송여부가 Y면 파란색 글자색 변경
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), BLUE);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), TXTFRCOLOR);
					}
					
					// 8.2. 보일러 점검 여부가 Y면 빨간색 글자색 변경
					if( Str_Cmp(szOldBoilYn, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
					}
					
					// 9. 상세주소2
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 14, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					// 10. 주소정보확인
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 15, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
					
					// 11. CONT_STS_CD, SMS송신버튼 관련
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 16, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, sztmp );
				}
			}
		}
Finally:
		
		DelSqLite(sql);
		
		if(m_lTotpage > 0 )
		{
			if( m_lActIndex == -1 )
			{
				m_lActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			//처음 선택된 대상의 주소를 상단에 표시
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
			Str_Cat(sztmp, "  ");

			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 0), "10") == 0 )
			{
				Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 9));
			}
			else if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 0), "20") == 0 )
			{
				Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 6));
			}
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), sztmp);

			Mem_Set((byte*)szCnt, 0x00, sizeof(szCnt));
			Mem_Set((byte*)szStscd, 0x00, sizeof(szStscd));
			Str_Cpy(szCnt, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 8) );
			Str_Cpy(szStscd, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 11) );
			
			if( szCnt[0] == 'Y' )
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
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
				}
			}
			else
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
			}
			
			Str_Cpy( g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
			Str_Cpy( stScAddr.SEND_YN, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 10));

			m_lIdxFlag = 1;
		}
		
		ON_DRAW();
		
		return;
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
//			Str_Cpy( m_szSql[0], "SELECT A.SINGLE_COLIVE_FLAG, ifnull(A.ADDR1_M,' ') ||'-'|| ifnull(A.ADDR1_S,' ') ||' '|| ifnull(A.HOUSE_CNT,' ') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,' '), ifnull(A.CO_LIVE_NM,' ') ||'-'|| ifnull(A.BLD_NM,' ') ||' '|| ifnull(A.HOUSE_CNT,' '), A.NOGOOD_RSLT, A.CHK_RSLT, ifnull(A.CP_DDD,A.OWNHOUSE_TEL_DDD) ||'-'|| ifnull(A.CP_EXN,A.OWNHOUSE_TEL_EXN) ||'-'|| ifnull(A.CP_NUM,A.OWNHOUSE_TEL_NUM), ifnull(A.TOWN,' ') ||' '|| ifnull(A.ADDR1_M,' ') ||' '|| ifnull(A.ADDR1_S,' ') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,' '),  ifnull(A.CO_LIVE_NM,' ') ||' '|| ifnull(A.BLD_NM,' ') ||'-'|| ifnull(A.HOUSE_CNT,' '), A.CHK_EXEC_NUM, A.PREUSE_CHK_WHY, B.CHK_EXEC_NUM AS ABSENT, B.CNT, A.SMS_SEND_AGREE_YN FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
//			Str_Cpy( m_szSql[1], "SELECT A.SINGLE_COLIVE_FLAG, ifnull(A.NEW_ROAD_NM,' ') ||' '|| ifnull(A.NEW_ADDR_M,' ') ||'-'|| ifnull(A.NEW_ADDR_S,' ') ||' '|| ifnull(A.HOUSE_CNT,' ') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,' '), ifnull(A.CO_LIVE_NM,' ') ||'-'|| ifnull(A.BLD_NM,' ') ||' '|| ifnull(A.HOUSE_CNT,' '), A.NOGOOD_RSLT, A.CHK_RSLT, ifnull(A.CP_DDD,A.OWNHOUSE_TEL_DDD) ||'-'|| ifnull(A.CP_EXN,A.OWNHOUSE_TEL_EXN) ||'-'|| ifnull(A.CP_NUM,A.OWNHOUSE_TEL_NUM), ifnull(A.NEW_ROAD_NM,' ') ||' '|| ifnull(A.NEW_ADDR_M,' ') ||' '|| ifnull(A.NEW_ADDR_S,' '),  ifnull(A.CO_LIVE_NM,' ') ||' '|| ifnull(A.BLD_NM,' ') ||'-'|| ifnull(A.HOUSE_CNT,' '), A.CHK_EXEC_NUM, A.PREUSE_CHK_WHY, B.CHK_EXEC_NUM AS ABSENT, B.CNT, A.SMS_SEND_AGREE_YN FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM  B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[0], "SELECT A.SINGLE_COLIVE_FLAG, ifnull(A.ADDR1_M,' ') ||'-'|| ifnull(A.ADDR1_S,' ') ||' '|| ifnull(A.HOUSE_CNT,' ') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,' '), ifnull(A.CO_LIVE_NM,' ') ||'-'|| ifnull(A.BLD_NM,' ') ||' '|| ifnull(A.HOUSE_CNT,' '), A.NOGOOD_RSLT, A.CHK_RSLT, Length(OWNHOUSE_TEL_EXN), ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,''), ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,''), ifnull(A.TOWN,' ') ||' '|| ifnull(A.ADDR1_M,' ') ||' '|| ifnull(A.ADDR1_S,' ') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,' '),  ifnull(A.CO_LIVE_NM,' ') ||' '|| ifnull(A.BLD_NM,' ') ||'-'|| ifnull(A.HOUSE_CNT,' '), A.CHK_EXEC_NUM, A.PREUSE_CHK_WHY, B.CHK_EXEC_NUM AS ABSENT, A.SMS_SEND_AGREE_YN, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[1], "SELECT A.SINGLE_COLIVE_FLAG, ifnull(A.NEW_ROAD_NM,' ') ||' '|| ifnull(A.NEW_ADDR_M,' ') ||'-'|| ifnull(A.NEW_ADDR_S,' ') ||' '|| ifnull(A.HOUSE_CNT,' ') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,' '), ifnull(A.CO_LIVE_NM,' ') ||'-'|| ifnull(A.BLD_NM,' ') ||' '|| ifnull(A.HOUSE_CNT,' '), A.NOGOOD_RSLT, A.CHK_RSLT, Length(OWNHOUSE_TEL_EXN), ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,''), ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,''), ifnull(A.NEW_ROAD_NM,' ') ||' '|| ifnull(A.NEW_ADDR_M,' ') ||' '|| ifnull(A.NEW_ADDR_S,' '),  ifnull(A.CO_LIVE_NM,' ') ||' '|| ifnull(A.BLD_NM,' ') ||'-'|| ifnull(A.HOUSE_CNT,' '), A.CHK_EXEC_NUM, A.PREUSE_CHK_WHY, B.CHK_EXEC_NUM AS ABSENT, A.SMS_SEND_AGREE_YN, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM  B.CHK_EXEC_NUM WHERE ");
		}
		else
		{
			m_lBtnId = 2;
		
			Str_Cpy( szSql[0], "SELECT ROWID FROM NORMAL_DATA WHERE ");
			Str_Cpy( m_szSql[0], "SELECT A.SINGLE_COLIVE_FLAG, ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''), ifnull(A.CO_LIVE_NM,'') ||'-'|| ifnull(A.BLD_NM,'') ||' '|| ifnull(A.HOUSE_CNT,''), A.CHK_RSLT, ifnull(A.CP_DDD,A.OWNHOUSE_TEL_DDD) ||'-'|| ifnull(A.CP_EXN,A.OWNHOUSE_TEL_EXN) ||'-'|| ifnull(A.CP_NUM,A.OWNHOUSE_TEL_NUM), ifnull(A.TOWN,'') ||' '|| ifnull(A.ADDR1_M,'') ||' '|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''),  ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,''), A.CHK_EXEC_NUM, A.PREUSE_CHK_WHY, B.CHK_EXEC_NUM AS ABSENT, B.CNT, A.SMS_SEND_AGREE_YN, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B  ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[1], "SELECT A.SINGLE_COLIVE_FLAG, ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''), ifnull(A.CO_LIVE_NM,'') ||'-'|| ifnull(A.BLD_NM,'') ||' '|| ifnull(A.HOUSE_CNT,''), A.CHK_RSLT, ifnull(A.CP_DDD,A.OWNHOUSE_TEL_DDD) ||'-'|| ifnull(A.CP_EXN,A.OWNHOUSE_TEL_EXN) ||'-'|| ifnull(A.CP_NUM,A.OWNHOUSE_TEL_NUM), ifnull(A.TOWN,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||' '|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,''),  ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,''), A.CHK_EXEC_NUM, A.PREUSE_CHK_WHY, B.CHK_EXEC_NUM AS ABSENT, B.CNT, A.SMS_SEND_AGREE_YN, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
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
			else if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HOSOO)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "호수를 입력해 주세요.");
				return FALSE;
			}
			
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
				MessageBoxEx (CONFIRM_OK, "본번를 입력해 주세요.");
				return FALSE;
			}
			else if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BOOBUN)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "부번를 입력해 주세요.");
				return FALSE;
			}
			
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
	
//-----------------------------------------------------------------------------------------------
//콤보박스를 이용한 전체,검침,미검침 목록 필터
//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[800];
		
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
		
		if( Str_Cmp(m_szCobSel, "점검") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM NORMAL_DATA WHERE SEND_YN = 'Y' or SEND_YN = 'S' ORDER BY HOUSE_NUM_ORD, DONG_ORD");
			
			g_nWorkFlag = 206;
		}
		else if( Str_Cmp(m_szCobSel, "순수미점검") == 0 )
		{
			Str_Cpy(szRow, " SELECT A.ROWID, A.CHK_EXEC_NUM \
			                   FROM NORMAL_DATA A \
			                  WHERE (A.SEND_YN = 'N' OR A.SEND_YN IS NULL) \
			                    AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) = 0 \
			                  ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");

			g_nWorkFlag = 207;
		}
		else if( Str_Cmp(m_szCobSel, "부재미점검") == 0 )
		{
			Str_Cpy(szRow, "SELECT A.ROWID, A.CHK_EXEC_NUM \
			                  FROM NORMAL_DATA A \
			                 WHERE (A.SEND_YN = 'N' OR A.SEND_YN IS NULL) \
			                   AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) > 0 \
			                 ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");

			g_nWorkFlag = 210;
		}
		else
		{
			Str_Cpy(szRow, "SELECT ROWID \
			                  FROM NORMAL_DATA \
			                 ORDER BY HOUSE_NUM_ORD, DONG_ORD");

			g_nWorkFlag = 200;
		}

		g_Sql_SaveSeq( szRow, SREACH_FILE);
		
		Mem_Set( (byte*)m_szSql[0], 0x00, sizeof(m_szSql[0]) );
		Mem_Set( (byte*)m_szSql[1], 0x00, sizeof(m_szSql[1]) );
		
		if( Str_Cmp(m_szCobSel, "점검") == 0 )
		{
        	Str_Cpy(m_szSql[0], "SELECT A.SINGLE_COLIVE_FLAG \
        	                          , ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
        	                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
        	                          , A.CHK_RSLT \
        	                          , Length(A.OWNHOUSE_TEL_EXN) \
        	                          , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
        	                          , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
        	                          , ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.VILLAGE,'') ||' '|| ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') \
        	                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
        	                          , A.CHK_EXEC_NUM \
        	                          , A.PREUSE_CHK_WHY \
        	                          , B.CHK_EXEC_NUM AS ABSENT \
        	                          , B.CNT \
        	                          , A.SMS_SEND_AGREE_YN \
        	                          , A.LOT_NUM_SECOND_ADDR \
        	                          , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
        	                          , A.CONT_STS_CD \
        	                          , A.OLD_BOILER_YN \
        	                       FROM NORMAL_DATA A \
        	                       LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
        	                                    ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
        	                      WHERE SEND_YN = 'Y' or SEND_YN = 'S' \
        	                      ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ?");
        	                      
			Str_Cpy(m_szSql[1], "SELECT A.SINGLE_COLIVE_FLAG \
			                          , ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_RSLT \
			                          , Length(A.OWNHOUSE_TEL_EXN) \
			                          , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
			                          , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
			                          , ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_EXEC_NUM \
			                          , A.PREUSE_CHK_WHY \
			                          , B.CHK_EXEC_NUM AS ABSENT \
			                          , B.CNT \
			                          , A.SMS_SEND_AGREE_YN \
			                          , A.LOT_NUM_SECOND_ADDR \
			                          , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
			                          , A.CONT_STS_CD \
			                          , A.OLD_BOILER_YN \
			                       FROM NORMAL_DATA A \
			                       LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
			                                    ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
			                      WHERE SEND_YN = 'Y' or SEND_YN = 'S' \
			                      ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ?");
		}
		else if( Str_Cmp(m_szCobSel, "순수미점검") == 0 )
		{
	        Str_Cpy(m_szSql[0], "SELECT A.SINGLE_COLIVE_FLAG \
	                                  , ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
	                                  , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
	                                  , A.CHK_RSLT \
	                                  , Length(A.OWNHOUSE_TEL_EXN) \
	                                  , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
	                                  , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
	                                  , ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.VILLAGE,'') ||' '|| ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') \
	                                  , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
	                                  , A.CHK_EXEC_NUM \
	                                  , A.PREUSE_CHK_WHY \
	                                  , B.CHK_EXEC_NUM AS ABSENT \
	                                  , B.CNT \
	                                  , A.SMS_SEND_AGREE_YN \
	                                  , A.LOT_NUM_SECOND_ADDR \
	                                  , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
	                                  , A.CONT_STS_CD \
	                                  , A.OLD_BOILER_YN \
	                               FROM NORMAL_DATA A \
	                               LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
	                                            ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
	                              WHERE (SEND_YN = 'N' OR SEND_YN IS NULL) \
	                                AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) = 0 \
	                              ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ?");
	                              
			Str_Cpy(m_szSql[1], "SELECT A.SINGLE_COLIVE_FLAG \
			                          , ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_RSLT \
			                          , Length(A.OWNHOUSE_TEL_EXN) \
			                          , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
			                          , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
			                          , ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_EXEC_NUM \
			                          , A.PREUSE_CHK_WHY \
			                          , B.CHK_EXEC_NUM AS ABSENT \
			                          , B.CNT \
			                          , A.SMS_SEND_AGREE_YN \
			                          , A.LOT_NUM_SECOND_ADDR \
			                          , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
			                          , A.CONT_STS_CD \
			                          , A.OLD_BOILER_YN \
			                       FROM NORMAL_DATA A \
			                       LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
			                                    ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
			                      WHERE (SEND_YN = 'N' OR SEND_YN IS NULL) \
			                        AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) = 0 \
			                      ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ?");
		}
		else if( Str_Cmp(m_szCobSel, "부재미점검") == 0 )
		{
 		    Str_Cpy(m_szSql[0], "SELECT A.SINGLE_COLIVE_FLAG \
 		                              , ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
 		                              , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
 		                              , A.CHK_RSLT \
 		                              , Length(A.OWNHOUSE_TEL_EXN) \
 		                              , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
 		                              , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'')  \
 		                              , ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.VILLAGE,'') ||' '|| ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') \
 		                              , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
 		                              , A.CHK_EXEC_NUM \
 		                              , A.PREUSE_CHK_WHY \
 		                              , B.CHK_EXEC_NUM AS ABSENT \
 		                              , B.CNT \
 		                              , A.SMS_SEND_AGREE_YN \
 		                              , A.LOT_NUM_SECOND_ADDR \
 		                              , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
 		                              , A.CONT_STS_CD \
 		                              , A.OLD_BOILER_YN \
 		                           FROM NORMAL_DATA A \
 		                           LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
 		                                        ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
 		                          WHERE (A.SEND_YN = 'N' OR A.SEND_YN IS NULL) \
 		                            AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) > 0 \
 		                          ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ?");
 		                          
			Str_Cpy(m_szSql[1], "SELECT A.SINGLE_COLIVE_FLAG \
			                          , ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_RSLT \
			                          , Length(A.OWNHOUSE_TEL_EXN) \
			                          , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
			                          , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
			                          , ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_EXEC_NUM \
			                          , A.PREUSE_CHK_WHY \
			                          , B.CHK_EXEC_NUM AS ABSENT \
			                          , B.CNT \
			                          , A.SMS_SEND_AGREE_YN \
			                          , A.LOT_NUM_SECOND_ADDR \
			                          , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
			                          , A.CONT_STS_CD \
			                          , A.OLD_BOILER_YN \
			                       FROM NORMAL_DATA A \
			                       LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
			                                    ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
			                      WHERE (A.SEND_YN = 'N' OR A.SEND_YN IS NULL) \
			                        AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) > 0 \
			                      ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ?");
		}
		else
		{
 		    Str_Cpy(m_szSql[0], " SELECT A.SINGLE_COLIVE_FLAG \
 		                              , ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
 		                              , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
 		                              , A.CHK_RSLT \
 		                              , Length(A.OWNHOUSE_TEL_EXN) \
 		                              , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
 		                              , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
 		                              , ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.VILLAGE,'') ||' '|| ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') \
 		                              , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
 		                              , A.CHK_EXEC_NUM \
 		                              , A.PREUSE_CHK_WHY \
 		                              , B.CHK_EXEC_NUM AS ABSENT \
 		                              , B.CNT \
 		                              , A.SMS_SEND_AGREE_YN \
 		                              , A.LOT_NUM_SECOND_ADDR \
 		                              , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
 		                              , A.CONT_STS_CD \
 		                              , A.OLD_BOILER_YN \
 		                           FROM NORMAL_DATA A \
 		                           LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
 		                             ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
 		                          ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ? ");
			
			Str_Cpy(m_szSql[1], " SELECT A.SINGLE_COLIVE_FLAG \
			                          , ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_RSLT \
			                          , Length(A.OWNHOUSE_TEL_EXN) \
			                          , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
			                          , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
			                          , ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') \
			                          , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                          , A.CHK_EXEC_NUM \
			                          , A.PREUSE_CHK_WHY \
			                          , B.CHK_EXEC_NUM AS ABSENT \
			                          , B.CNT \
			                          , A.SMS_SEND_AGREE_YN \
			                          , A.LOT_NUM_SECOND_ADDR \
			                          , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
			                          , A.CONT_STS_CD \
			                          , A.OLD_BOILER_YN \
			                       FROM NORMAL_DATA A \
			                       LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
			                                    ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
			                      ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ? ");
		}	
	}
	
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetSearch(void)
	{
		long i, idx;
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
			if( m_lBtnId == 1 )
			{	//기물번호 검색
				Mem_Set( (byte*)stSc.CHK_EXEC_NUM, 0x00, sizeof(stSc.CHK_EXEC_NUM) );
				sql->GetValue(sql, 10, 'U', (long*)stSc.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stSc.CHK_EXEC_NUM);
				
				Mem_Set( (byte*)stScAddr.SEND_YN, 0x00, sizeof(stScAddr.SEND_YN) );
				sql->GetValue(sql, 14, 'U', (long*)stScAddr.SEND_YN, 1 + 1, DECRYPT);
			}
			else
			{	//기물번호를 제외한 나머지 검색
				Mem_Set( (byte*)stSc.CHK_EXEC_NUM, 0x00, sizeof(stSc.CHK_EXEC_NUM) );
				sql->GetValue(sql, 7, 'U', (long*)stSc.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stSc.CHK_EXEC_NUM);

				Mem_Set( (byte*)stScAddr.SEND_YN, 0x00, sizeof(stScAddr.SEND_YN) );
				sql->GetValue(sql, 12, 'U', (long*)stScAddr.SEND_YN, 1 + 1, DECRYPT);
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
	void	OnUart(long nEvent, long nData)
	{
//PRINT("nEvent : %d ,,,, UART_BARCODE : %d",nEvent,UART_BARCODE,0);
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

		if( Str_Len(m_szBarcode_Value) > 8 )
		{
			//바코드 정보
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 9);
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), m_szBarcode_Value ) ;

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s' ", szBar, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );

			//PRINT("m_szBarcode_Value : %s",m_szBarcode_Value,0,0);
			if( lCnt > 0 )
			{
				Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s' ", szBar, 0, 0);
				g_Sql_RetInt( szSql, &lRow );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
				g_Sql_SaveSeq( szSql, SREACH_FILE);
	
				g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE NORMAL_DATA SET CURR_BAR = '%s' WHERE INST_PLACE_NUM = '%s' ", g_szCurrBar, szBar, 0);
				g_Sql_DirectExecute(szSql);
				
				RetFlag = 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "바코드와 일치하는 대상이 없습니다.");
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
			return;
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
//PRINT("PDA>>>>>>>>>>>>>>>>>Str_Len(m_szBarcode_Value) : %d ",Str_Len(m_szBarcode_Value),0,0);
		if( Str_Len(m_szBarcode_Value) > 8 )
		{
			//바코드 정보
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 9);
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), m_szBarcode_Value ) ;

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s' ", szBar, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );
//PRINT("PDA>>>>>>>>>>>>>>>>>>>>>>>>lCnt : %d ",lCnt,0,0);

			if( lCnt > 0 )
			{
				Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s' ", szBar, 0, 0);
				g_Sql_RetInt( szSql, &lRow );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
				g_Sql_SaveSeq( szSql, SREACH_FILE);
	
				g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE NORMAL_DATA SET CURR_BAR = '%s' WHERE INST_PLACE_NUM = '%s' ", g_szCurrBar, szBar, 0);
				g_Sql_DirectExecute(szSql);
				
				RetFlag = 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "바코드와 일치하는 대상이 없습니다.");
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
	}

	/*=======================================================================================
	함수명 : SMSSEND_DRAW
	기  능 : 
	Param  : 
	Return :
	========================================================================================*/		
	void SMSSEND_DRAW(void)
	{
	char szPhone[30];
	char szToday[11];
	char szDate[11];
	char szSql[100];
	char szZero[3];
	char szHour[3];
	char szHour2[3];
	char szYear[5];
	char szMonth[3];
	char szDay[3];
	char szNonPay[2];
	long lHour = 24;
	long lTime;
	long i;
		
		Mem_Set( (byte*)szPhone, 0x00, sizeof(szPhone) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_TIME1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_TIME2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		//시 셋팅
		for(i=0 ; i<lHour ; i++)
		{
			Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
			if( i < 10 )
			{
				Str_ItoA(i, szHour, 10);
				Str_Cpy(szZero, "0");
				Str_Cat(szZero, szHour);
				Str_Cpy(szHour, szZero);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME1+2), szHour, 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME2+2), szHour, 0, ICON_NONE);
			}
			else
			{
				Str_ItoA(i, szHour, 10);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME1+2), szHour, 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME2+2), szHour, 0, ICON_NONE);
			}
		}

		Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
		Mem_Set( (byte*)szZero, 0x00, sizeof(szZero) );
		lTime = Time_GetHour();
		if( lTime < 10 )
		{
			Str_ItoA(lTime, szHour, 10);
			Str_Cpy(szZero, "0");
			Str_Cat(szZero, szHour);
			Str_Cpy(szHour, szZero);
		}
		else
		{
			Str_ItoA(lTime, szHour, 10);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_TIME1), szHour);
		
		Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
		Mem_Set( (byte*)szHour2, 0x00, sizeof(szHour2) );
		Mem_Set( (byte*)szZero, 0x00, sizeof(szZero) );
		lTime += 1;
		if( lTime < 10 )
		{
			Str_ItoA(lTime, szHour, 10);
			Str_Cpy(szZero, "0");
			Str_Cat(szZero, szHour);
			Str_Cpy(szHour, szZero);
		}
		else
		{
			Str_ItoA(lTime, szHour, 10);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_TIME2), szHour);
		
		
		//날짜
		Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Str_ItoA ( Time_GetDate(), szToday, 10);
		
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)szToday, 4);
		Mem_Cpy((byte *)szMonth, (byte *)szToday+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)szToday+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

		//g_Str_DateType(szDate, szToday);
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), szDate );

		//소속
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stUserinfo.szcenter_nm);
		
		//점검원
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), stUserinfo.sznm_kor);
		//고객H.P
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szPhone, 0x00, sizeof(szPhone) );
		SPRINT(szSql, "SELECT CP_DDD ||'-'|| CP_EXN||'-'||CP_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, szPhone );
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), szPhone);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szNonPay, 0x00, sizeof(szNonPay) );
		SPRINT(szSql, "SELECT NON_PAY_YN FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, szNonPay );
		
		if( Str_Cmp(szNonPay, "Y") == 0 )
		{
			m_lSmsNonPay = 1;
		}
	}
	
	/*=======================================================================================
	함수명 : Save_SmsSend
	기  능 : 
	Param  : 
	Return :
	========================================================================================*/		
//전송 문자1 : 도시가스 안전점검 예정일 XX월 XX일 (상단의 방문일자)    안전점검원 : 점검원명 (  디바이스 전화번호  )   방문 
//전송문자 2:  서울도시가스 + stUserinfo.szcenter_nm + 고객센터 + stUserinfo.sztel
	bool Save_SmsSend(void)
	{
		char szSql[100];
		char szCustTel[50];
		char szUserTel[50];
		char szUserTel2[50];
		char szDay[50];
		char szTime[4];
		char szTime2[4];
		char szMsg[1000];
		char szMsg2[1000];
		char szMsg3[1000];
		char szTmp[1000];
		char szEx[1000];
		long idx;
		long lTime = 100;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//전송문자1
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		Mem_Set( (byte*)szMsg3, 0x00, sizeof(szMsg3) );
		Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
		Mem_Set( (byte*)szTime2, 0x00, sizeof(szTime2) );
		Mem_Set( (byte*)szCustTel, 0x00, sizeof(szCustTel) );
		Mem_Set( (byte*)szUserTel, 0x00, sizeof(szUserTel) );
		
		Tapi_GetPhoneNum( (byte*)szUserTel, 0);
		Str_Chg( szUserTel, STRCHG_DEL_NONDIGIT);

		Str_Cpy(szCustTel, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8)));
		Str_Chg( szCustTel, STRCHG_DEL_NONDIGIT);
		
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		g_Str_DateType( szDay, szTmp);
		
		Str_Cpy( szTime, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_TIME1)));
		Str_Cpy( szTime2, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_TIME2)));

		Str_Cpy(szMsg, "안녕하십니까 서울도시가스입니다.");
		Str_Cat(szMsg, "\n도시가스 안전관리규정(가스사용자는 회사(공급자)가 수행하는 사용시설의 안전점검에 적극 협조하여야 한다)에 의하여,");
		Str_Cat(szMsg, "\n아래와 같이 안전점검을 위해 방문 예정입니다.");
		
		SPRINT(szEx, "\n도시가스 안전점검 예정일 : %s\n방문예정시간 : %s시 ~ %s시 \n " , szDay, szTime, szTime2);		
		// MessageBoxEx (CONFIRM_OK, szEx);
		Str_Cat( szMsg, szEx );

		Str_Cat( szMsg, "방문주소 : " );
		
		SPRINT( szSql, " SELECT CASE WHEN SINGLE_COLIVE_FLAG = '20' THEN ( IFNULL( CO_LIVE_NM,'' ) || \
							                                               IFNULL( ( CASE WHEN INSTR(BLD_NM,'동') = LENGTH(BLD_NM) AND LENGTH(BLD_NM) > 0 \
																		                  THEN ' ' || SUBSTR(BLD_NM, 1, LENGTH(BLD_NM)-1) || '동' \
																						  WHEN LENGTH(BLD_NM) = 0 \
																						  THEN '' \
																		                  ELSE ' ' || BLD_NM || '동' END ), '' ) ||' '|| \
																		   IFNULL( ( CASE WHEN HOUSE_CNT <> '' THEN HOUSE_CNT || '호' END ),'' ) ) \
									 ELSE ( IFNULL( NEW_ROAD_NM, '' ) ||' '|| \
									        IFNULL( ( CASE WHEN NEW_ADDR_S <> '0' THEN NEW_ADDR_M || '-' || NEW_ADDR_S ELSE NEW_ADDR_M END ), '' ) || \
											IFNULL( ( CASE WHEN HOUSE_CNT <> '' THEN ', '|| HOUSE_CNT || '호' END ),'' ) ||' '|| \
											IFNULL( LOT_NUM_SECOND_ADDR, '' ) ) \
							     END AS ADDR \
						   FROM NORMAL_DATA WHERE CHK_EXEC_NUM = %s ", g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetStr( szSql, 50, szMsg2 );
		
		Str_Cat( szMsg, szMsg2 );
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szUserTel2, 0x00, sizeof(szUserTel2) );

		Str_Cat(szMsg, "\n<<안전점검은 고객의 생명과 재산을 지키는 첫걸음 입니다>>");			

		g_FormatPhoneNumber(szUserTel, szUserTel2);	
			
		SPRINT(szTmp, "\n서울도시가스 %s 고객센터", stUserinfo.szcenter_nm, 0, 0);	
		Str_Cat(szMsg, szTmp);
		// SPRINT(szTmp, "\n안전점검원 : %s(%s)\n*업무시간만 통화가능합니다.\n(09시~18시)", stUserinfo.sznm_kor, szUserTel2, 0);
		SPRINT(szTmp, "\n안전점검원 : %s(%s)\n*문의전화는 업무시간(09시~18시)에 해주시면 감사하겠습니다.\n", stUserinfo.sznm_kor, szUserTel2, 0);
		Str_Cat(szMsg, szTmp);
		SPRINT(szTmp, "\n* 안전사고 예방을 위해 반려동물은 점검장소와 분리된 공간에 머물도록 부탁드립니다.",0,0,0);
		Str_Cat(szMsg, szTmp);
	
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "메시지 받을 전화 번호가 잘못되었습니다.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "응답을 받을 전화번호가 잘못되었습니다.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "내용이 비었습니다.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "내용이 너무 깁니다.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
					return FALSE;
			}
		}

		VmSleep(lTime);
		
		//전송문자2
		/*
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		
		SPRINT(szMsg, "안전점검원 : %s(%s) 방문\n" , stUserinfo.sznm_kor, szUserTel, 0);
		
		SPRINT(szMsg2, "서울도시가스 %s 고객센터 : %s" , stUserinfo.szcenter_nm, stUserinfo.sztel, 0);

		Str_Cat(szMsg, szMsg2);

		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg, Str_Len(szMsg) );
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "메시지 받을 전화 번호가 잘못되었습니다.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "응답을 받을 전화번호가 잘못되었습니다.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "내용이 비었습니다.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "내용이 너무 깁니다.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
					return FALSE;
			}
		}

		MessageBoxEx (CONFIRM_OK, "SMS 전송이 완료되었습니다.");
		*/
		
		ret = TRUE;
		return ret;
	}
	
//-------------------------------------------------------------------------------------
	void Snd_Sms(void)
	{
	char szUrl[200];
	char szbuf[128];
	char szMemo[301];
	char szDay[11];
	char* sndbuf;
	long ret = 0;
	

		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		Mem_Set((byte*)szMemo, 0x00, sizeof(szMemo));	
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));		

		Str_Cpy( szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA2)));

		Str_Chg( szDay, STRCHG_DEL_NONDIGIT);				
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		SPRINT(szUrl, "SELECT BEFO_HALF_MEMO FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szUrl, 100, stSc.BEFO_HALF_MEMO );
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312316, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_exec_num",   g_szCHK_EXEC_NUM );
		JSON_SetValue( g_pjcomm, 'C', "gubun",          "1" );
		SQL_ConvUcStr( szMemo, stSc.BEFO_HALF_MEMO );
		JSON_SetValue( g_pjcomm, 'C', "befo_half_memo", szMemo );
		JSON_SetValue( g_pjcomm, 'C', "reserved_date",  szDay );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR312316; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR312316_IN",  "FR312316" , sndbuf, szbuf );
		
		return;
	}

	long TR312316(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(312316) >= 0)
		{
			if( Save_SmsSend() )
			{
				ON_EXIT();
				OnInit(INIT_MAIN);
			}
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
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

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetComboIdx(void)
	{
		long i, idx;
		long k = ROW+1;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		//g_szCHK_EXEC_NUM
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY HOUSE_NUM_ORD, DONG_ORD ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szSql, &lRow );

		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 = %d WHERE GUBUN = '2' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);
		
		return;
	}
	
//---------------------------------------------------------------------------------------------------------------
/*
	void Grid_QuickList(long nBtnID)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		//nAddrType = 0 지번 ,, nAddrType = 1 도로명
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "안전점검 상세리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOUSE_CNT,''), ifnull(CUST_NM, '') ||' /상태:'|| Case When Length(ifnull(PREUSE_CHK_WHY, '')) > 0 Then 'F' Else '' End ||''|| Case When (SELECT Length(ifnull(B.CHK_EXEC_NUM, '')) FROM NORMAL_VISIT B WHERE B.CHK_EXEC_NUM = A.CHK_EXEC_NUM) > 0 Then 'B' ||''|| B.CNT Else '' End ||' /결과:'|| Case When CHK_RSLT = '10' Then '미점검' When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' When CHK_RSLT = '50' Then '미실시' Else '미검' end ||' \n전화번호:'|| Case When Length(ifnull(OWNHOUSE_TEL_EXN, '')) > 1 Then ifnull(OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(OWNHOUSE_TEL_NUM,'') Else ifnull(CP_DDD,'') ||'-'|| ifnull(CP_EXN,'') ||'-'|| ifnull(CP_NUM,'') END  FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "안전점검 상세리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(COUNTY,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOUSE_CNT,''), ifnull(CUST_NM, '') ||' /상태:'|| Case When Length(ifnull(PREUSE_CHK_WHY, '')) > 0 Then 'F' Else '' End ||''|| Case When (SELECT Length(ifnull(B.CHK_EXEC_NUM, '')) FROM NORMAL_VISIT B WHERE B.CHK_EXEC_NUM = A.CHK_EXEC_NUM) > 0 Then 'B' ||''|| B.CNT Else '' End ||' /결과:'|| Case When CHK_RSLT = '10' Then '미점검' When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' When CHK_RSLT = '50' Then '미실시' Else '미검' end ||' \n전화번호:'|| Case When Length(ifnull(OWNHOUSE_TEL_EXN, '')) > 1 Then ifnull(OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(OWNHOUSE_TEL_NUM,'') Else ifnull(CP_DDD,'') ||'-'|| ifnull(CP_EXN,'') ||'-'|| ifnull(CP_NUM,'') END  FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}

		sztmp = JSON_toString(js);
		
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
	}
*/

	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(long nBtnID)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"주소", "상태", "결과", "전화번호", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","2","2","2","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( nBtnID == BID_QUICK_ADDR )
		{
			Str_Cpy(m_szQuickSql, "SELECT CASE WHEN A.SINGLE_COLIVE_FLAG = '10' \
											   THEN ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
											   ELSE ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') END \
										, CASE WHEN LENGTH(A.PREUSE_CHK_WHY) > 0 THEN 'F' ELSE '' END ||''|| CASE WHEN LENGTH(B.CHK_EXEC_NUM) > 0 THEN 'B' ||''|| B.CNT ELSE '' END ||''|| CASE WHEN LENGTH(A.OLD_BOILER_YN) > 0 THEN CHAR(10) || '보' ELSE '' END \
										, CASE WHEN A.CHK_RSLT = '10' THEN '미점검' \
										       WHEN A.CHK_RSLT = '20' THEN '적합' \
										       WHEN A.CHK_RSLT = '21' THEN '부적합' \
											   WHEN A.CHK_RSLT = '40' THEN '제외' \
											   WHEN A.CHK_RSLT = '50' THEN '미실시' \
											   ELSE '미검' END \
										, CASE WHEN LENGTH(A.OWNHOUSE_TEL_EXN) > 0 THEN ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
											   ELSE ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') END \
									 FROM NORMAL_DATA A \
								 	 LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B \
											      ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM ");
		}
		else
		{
			Str_Cpy(m_szQuickSql, "SELECT CASE WHEN A.SINGLE_COLIVE_FLAG = '10' \
									  	       THEN ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
										       ELSE ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') END \
										, CASE WHEN LENGTH(A.PREUSE_CHK_WHY) > 0 THEN 'F' ELSE '' END ||''|| CASE WHEN LENGTH(B.CHK_EXEC_NUM) > 0 THEN 'B' ||''|| B.CNT ELSE '' END ||''|| CASE WHEN LENGTH(A.OLD_BOILER_YN) > 0 THEN CHAR(10) || '보' ELSE '' END \
										, CASE WHEN A.CHK_RSLT = '10' THEN '미점검' \
										       WHEN A.CHK_RSLT = '20' THEN '적합' \
										       WHEN A.CHK_RSLT = '21' THEN '부적합' \
											   WHEN A.CHK_RSLT = '40' THEN '제외' \
											   WHEN A.CHK_RSLT = '50' THEN '미실시' \
											   ELSE '미검' END \
										, CASE WHEN LENGTH(A.OWNHOUSE_TEL_EXN) > 0 THEN ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
											   ELSE ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') END \
									 FROM NORMAL_DATA A \
									 LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT  FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B \
											      ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM ");
		}
		
		if( Str_Cmp(m_szCobSel, "점검" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE SEND_YN = 'Y' or SEND_YN = 'S' ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
		else if( Str_Cmp(m_szCobSel, "순수미점검" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE (SEND_YN = 'N' OR SEND_YN IS NULL) AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) = 0 ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
		else if( Str_Cmp(m_szCobSel, "부재미점검" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "WHERE (A.SEND_YN = 'N' OR A.SEND_YN IS NULL) AND (SELECT COUNT(*) FROM NORMAL_VISIT B WHERE A.CHK_EXEC_NUM = B.CHK_EXEC_NUM) > 0 ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
		else //if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
	
		//PRINT(">>>>>>>>>>>>>>>>>>>>>>>length(%d) , %s",Str_Len(m_szQuickSql),m_szQuickSql,0);
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szQuickSql);
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "상세리스트");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}

}



