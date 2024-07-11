/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6501_NOTICE
	Card Desc : 공지사항
	Card Hist :
----------------------------------------------------------------------------------*/
card C6501_NOTICE
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
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/*  공통                        */
		/********************************/
		DEF_BUTTON_ID ( BID_HOME )			// 홈
		DEF_BUTTON_ID ( BID_MENU )			// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )		// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )		// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )		// 공통업무
		DEF_BUTTON_ID ( BID_PREV )			// 이전
		DEF_BUTTON_ID ( BID_EXIT )			// 종료
		DEF_BUTTON_ID ( BID_TAB1 )			// 공지사항 탭 1
		DEF_BUTTON_ID ( BID_TAB2 )			// 공지사항 탭 2
		
		/********************************/
		/*  공지사항                    */
		/********************************/	
		DEF_BUTTON_ID ( BID_OK )			// 확인
		DEF_BUTTON_ID ( BID_NOTICE_PREV )	// 이전	
		DEF_BUTTON_ID ( BID_NOTICE_NEXT )	// 다음
		DEF_BUTTON_ID ( BID_NOTICE_VIEW )	// 상세보기(공지내용)

		/********************************/
		/*  고객의 소리                 */
		/********************************/
		DEF_BUTTON_ID ( BID_WRITE )			// 처리내용
		DEF_BUTTON_ID ( BID_ADDR )			// 주소
		DEF_BUTTON_ID ( BID_TELNUM )		// 전화번호
		DEF_BUTTON_ID ( BID_MW_VIEW )		// 민원내용	
		DEF_BUTTON_ID ( BID_MW_MEMO )		// 민원메모
		DEF_BUTTON_ID ( BID_MW_DESC )		// 처리내용
		DEF_BUTTON_ID ( BID_COMPLAIN_PREV )	// 이전
		DEF_BUTTON_ID ( BID_COMPLAIN_NEXT )	// 다음
		DEF_BUTTON_ID ( BID_SAVE )			// 완료

		/********************************/
		/*  상세보기                    */
		/********************************/
		DEF_BUTTON_ID ( BID_TXT_OK )		// 확인
		DEF_BUTTON_ID ( BID_TXT_PREV )		// 이전
		DEF_BUTTON_ID ( BID_TXT_NEXT )		// 다음
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/*  공통                        */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		DEF_OBJECT_ID ( TXT_BORDER )
	
		/********************************/
		/*  공지사항                    */
		/********************************/	
		DEF_OBJECT_ID ( TXT_DATA2 )			// TXT_공지내용
		DEF_OBJECT_ID ( TXT_DATA3 )			// ST_소속
		DEF_OBJECT_ID ( TXT_DATA4 ) 		// TXT_소속
		DEF_OBJECT_ID ( TXT_DATA5 )			// ST_작성자
		DEF_OBJECT_ID ( TXT_DATA6 ) 		// TXT_작성자
		DEF_OBJECT_ID ( TXT_DATA22 )		// PAGE
		DEF_OBJECT_ID ( ID_NOTICELIST )		// TABLE
		
		/********************************/
		/*  고객의 소리                 */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA7 )			// ST_사용계약번호
		DEF_OBJECT_ID ( TXT_DATA8 )			// TXT_사용계약번호
		DEF_OBJECT_ID ( TXT_DATA9 )			// ST_신청인
		DEF_OBJECT_ID ( TXT_DATA10 )		// TXT_신청인
		DEF_OBJECT_ID ( TXT_DATA12 )		// TXT_핸드폰번호
		DEF_OBJECT_ID ( TXT_DATA14 )		// TXT_주소
		DEF_OBJECT_ID ( TXT_DATA16 )		// TXT_민원내용
		DEF_OBJECT_ID ( TXT_DATA18 )		// TXT_메모
		DEF_OBJECT_ID ( TXT_DATA20 )		// TXT_처리내용
		DEF_OBJECT_ID ( TXT_DATA23 )		// PAGE
		DEF_OBJECT_ID ( ID_COMPLAINIST )	// TABLE
		
		/********************************/
		/*  상세보기                    */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA21 )		// TXT_상세보기
		
		/********************************/
		/* 라인                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA_1 )
		DEF_OBJECT_ID ( LINE_DATA_2 )
		DEF_OBJECT_ID ( LINE_DATA_3 )
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	   1
	#define INIT_COMPLAIN  2
	#define INIT_VIEWTXT   3

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW_N 	    	5					// table의 행개수
	#define		COL_N 	    	8					// table의 열개수
	#define		GRID_H_N		(CHT+20)			// table 행 높이
	#define		GRID_H_N_P		(CHT+40)			// table 행 높이
	#define		GRID_CLR_N		TRANSPARENT   		// table 클리어 color
	#define		GRID_X_N		0    				// table 시작x좌표
	#define		MAXCHAR_N		3001 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_N		STARTY+135 	        // table 시작y좌표
	#define		GRID_Y_N_P		STARTY+40 	        // table 시작y좌표 PDA
	#define		GRID_ENDY_N		(GRID_Y_N+(ROW_N+1)*GRID_H_N) //table마지막 row의 Y값
	
	char m_szTableBuf_N [COL_N*(ROW_N+1)*MAXCHAR_N]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_N[] = {
		{"공지일시",     CWD*11,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"제목", 	     CWD*28+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"공지내용",     CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"소속", 	     CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"작성자", 	     CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"NOTICE_SEQ",   CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CHK_YN", 	     CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"NOTICE_DESC2", CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};

	//-------------------------------------------------------------------------------------------------
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW_C 	    	3					// table의 행개수
	#define		COL_C 	    	14					// table의 열개수
	#define		GRID_H_C		(CHT+20)			// table 행 높이
	#define		GRID_H_C_P		(CHT+40)			// table 행 높이
	#define		GRID_CLR_C		TRANSPARENT   		// table 클리어 color
	#define		GRID_X_C		STARTX 				// table 시작x좌표
	#define		MAXCHAR_C		3001 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_C		STARTY+135  	    // table 시작y좌표
	#define		GRID_Y_C_P		STARTY+40	  	    // table 시작y좌표 PDA
	#define		GRID_ENDY_C		(GRID_Y_C+(ROW_C+1)*GRID_H_C) //table마지막 row의 Y값
	
	char m_szTableBuf_C [COL_C*(ROW_C+1)*MAXCHAR_C]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_C[] = {
		{"작업배정", 	            CWD*10,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소", 		            CWD*19+23,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"처리상태", 	            CWD*10,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"사용계약번호",            CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"신청인", 	                CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"HP", 	                    CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소", 	                CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"민원내용", 	            CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"메모", 	                CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"처리내용",                CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"PROMISE_ASSIGN_SEQ",      CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CIVIL_SERV_RECEIVE_NUM",  CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"PROMISE_ASSIGN_SEQ",      CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"TREAT_SEQ",               CWD*0,      EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};

	//---------------------------------------------------------------------------------------
	// Global
	//---------------------------------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] =
	{
		SYS_BUT_IMG ( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
		SYS_BUT_IMG ( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		SYS_BUT_IMG ( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		SYS_BUT_IMG ( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
		SYS_BUT_IMG ( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0 ),
		SYS_BUT_IMG ( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		SYS_BUT_IMG ( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	
	//---------------------------------------------------------------------------------------
	// Struct
	//---------------------------------------------------------------------------------------
	typedef struct COMPLAIN
	{
		char szPromise_Assign_Seq[20];
		char szMemo[300];
		char szCivil_Serv_Receive_Num[30];
		char szTreat_Seq[20];
	}
	COMPLAIN;
	
	COMPLAIN m_stComplain;
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_bFirst;
	long m_lNotice_ActIdx = -1;
	long m_lTotpage_N = 0;
	long m_lPage_N = 0;
	long m_lTitleCnt = 0;
	char m_szCnt_page_N[10];
	char m_szNoticeSeq[20];
	char m_szNoticeChk_yn[5];
	char m_szTitle_N[50];

	long m_lComplain_ActIdx = -1;
	long m_lTotpage_C = 0;
	long m_lPage_C = 0;
	long m_lTelFlag = 0;
	char m_szCnt_page_C[10];
	char m_szComplainChk_yn[5];
	char m_szProc_Sts[10];
	char m_szTitle_C[50];
	
	char m_szCnt_Gubun[10];
	char m_szTxtView[2][3000];			// 민원내용, 처리내용 저장
	char m_szNoticeTxtView[2][3000];	// 공지사항(약 500자씩 나눔)
	long m_lViewFlag = 0;				// = 0 default, = 1 View 호출(고객의소리 : 민원내용,메모), = 2 View 호출(고객의소리 : 처리내용)
	
	long m_ltxtViewPageFlag = 0;			// Page flag 0 = 첫페이지, 1 = 두번째 페이지
	
	long m_lFlag = 0;
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetStyle(void);
	void SetBtnImg(void);
	
	//공지사항 - 리스트
	long Rcv_Notice(void);
	long TR12112(void);
	void Notice_Draw(void);
	
	//공지사항 - 조회 확인
	long Snd_NoticeCheck(void);
	long TR12114(void);

	//공지사항, 고객의소리 - 미조회 갯수
	long Rcv_Count(void);
	long TR12116(void);
	long CntDraw(long nservicenum);

	//고객의소리 - 리스트
	long Rcv_Complain(void);
	long TR12119(void);
	void Complain_Draw(void);
	
	//고객의소리 - 민원 처리
	long Snd_Success(void);
	long TR12121(void);
	
	//고객의소리 - 조회 확인
	long Snd_ComplainCheck(void);
	long TR121211(void);
	
	//텍스트 뷰
	void TxtDraw(void);
	
	//---------------------------------------------------------------------------------------
	// 공지사항 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공지사항"),
		
		DLG_BUTTON(STARTX,      STARTY+65, 500, 61, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "공지사항"),
		DLG_BUTTON(STARTX +500, STARTY+65, 500, 61, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "고객의 소리"),
		
		DLG_LINE ( STARTX,      STARTY +130, 1000, STARTY +130, DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_TABLE (GRID_X_N, GRID_Y_N, ROW_N, COL_N, 0, GRID_H_N, 1, GRID_H_N, SEL_ROW, MAXCHAR_N, m_stGridTitle_N, ID_NOTICELIST, m_szTableBuf_N),
		
		DLG_LINE ( STARTX,      STARTY +500, 1000, STARTY +500, DARKSLATEBLUE, 10, LINE_DATA_2),
		
		DLG_BUTTON(STARTX,      STARTY +505, 1000, 60,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOTICE_VIEW, "공지내용"),
		DLG_TEXT(  STARTX,      STARTY +565, 1000, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(  STARTX,      STARTY +765, 150,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "소속"),
		DLG_TEXT(  STARTX +150, STARTY +765, 340,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(  STARTX +490, STARTY +765, 170,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "작성자"),
		DLG_TEXT(  STARTX +660, STARTY +765, 340,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_LINE ( STARTX,      STARTY +829, 1000, STARTY +829, DARKSLATEBLUE, 10, LINE_DATA_3),
		
		DLG_BUTTON(STARTX,      STARTY +834, 250,  65,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOTICE_PREV, "▲"),
		DLG_BUTTON(STARTX +250, STARTY +834, 250,  65,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOTICE_NEXT, "▼"),
		DLG_TEXT(  STARTX +500, STARTY +834, 250,  65,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, m_szCnt_page_N),
		DLG_BUTTON(STARTX +750, STARTY +834, 250,  65,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인"),
		
	};	
	
	//---------------------------------------------------------------------------------------
	// 고객의 소리 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_Comp[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공지사항"),
		
		DLG_BUTTON(STARTX,      STARTY+65, 500, 61, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "공지사항"),
		DLG_BUTTON(STARTX +500, STARTY+65, 500, 61, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "고객의 소리"),
		
		DLG_LINE ( STARTX,      STARTY +130, 1000, STARTY +130, DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_BUTTON(STARTX,     STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLAIN_PREV, "▲"),
		DLG_BUTTON(STARTX+250, STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLAIN_NEXT, "▼"),
		DLG_BUTTON(STARTX+750, STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "완료"),
		
		DLG_TEXT(STARTX,       STARTY+370, 400, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "사용계약번호"),
		DLG_TEXT(STARTX+400,   STARTY+370, 600, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,       STARTY+420, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "신청인"),
		DLG_TEXT(STARTX+200,   STARTY+420, 250, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_BUTTON(STARTX+450, STARTY+420, 150, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TELNUM, "HP"),
		DLG_TEXT(STARTX+600,   STARTY+420, 400, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_BUTTON(STARTX,     STARTY+470, 200, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "도로명\n주소"),
		DLG_TEXT(STARTX+200,   STARTY+470, 800, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		
		DLG_BUTTON(STARTX,     STARTY+560, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MW_VIEW, "민원\n내용"),
		DLG_TEXT(STARTX+200,   STARTY+560, 800, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		
		DLG_BUTTON(STARTX,     STARTY+640, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MW_MEMO, "메모"),
		DLG_TEXT(STARTX+200,   STARTY+640, 800, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		
		DLG_BUTTON(STARTX,       STARTY+710, 200, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MW_DESC, "처리\n내용"),
		DLG_BUTTON(STARTX+200, STARTY+710, 800, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE, ""),
		DLG_TEXT(STARTX+200,   STARTY+710, 800, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA20, ""),

		DLG_TEXT(STARTX+500, STARTY+829, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, m_szCnt_page_C),
		
		DLG_TABLE (GRID_X_C, GRID_Y_C, ROW_C, COL_C, 0, GRID_H_C, 1, GRID_H_C, SEL_ROW, MAXCHAR_C, m_stGridTitle_C, ID_COMPLAINIST, m_szTableBuf_C),	
	};	
	
	//---------------------------------------------------------------------------------------
	// 내용 상세 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_Txt[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객의소리"),
		
		DLG_TEXT(  STARTX,      STARTY +65,  1000, 736, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		
		DLG_LINE ( STARTX,      STARTY +805, 1000, STARTY +805, DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_BUTTON(STARTX + 20, STARTY +820, 230,  70,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TXT_PREV, "◀"),
		DLG_BUTTON(STARTX +250, STARTY +820, 230,  70,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TXT_NEXT, "▶"),
		DLG_BUTTON(STARTX +510, STARTY +820, 470,  70,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TXT_OK, "확인"),
	};			
	
	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
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
	
		switch( bFirst )
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
					
				SetBtnImg();	
				SetStyle();
				Rcv_Notice();
				ON_DRAW();
				
				break;
				
			case INIT_COMPLAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes_Comp, SIZEOF(DlgRes_Comp));
				
				SetBtnImg();	
				SetStyle();
				
				if( m_lViewFlag == 1 || m_lViewFlag == 2 )
				{
					//Str_Cat(m_szTitle_N, " 공지사항");
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TAB1), m_szTitle_N);
		
					//Str_Cat(m_szTitle_C, " 고객의 소리");
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TAB2), m_szTitle_C);
		
					Complain_Draw();
				}
				else
				{
					Rcv_Complain();
				}
				
				ON_DRAW();
				
				break;
				
			case INIT_VIEWTXT:
			
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes_Txt, SIZEOF(DlgRes_Txt));
						
				SetBtnImg();	
				SetStyle();
				TxtDraw();
				
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			/******************************/
			/* 공통                       */
			/******************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
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
				if( m_bFirst == INIT_VIEWTXT )
				{
					if( m_lViewFlag == 3 )
					{
						ON_EXIT();
						OnInit(INIT_MAIN);
					}
					else
					{
						ON_EXIT();
						OnInit(INIT_COMPLAIN);
					}
				}
				else
				{
					Card_Move("MENU");
				}
				
				break;
			
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/******************************/
			/* 탭                         */
			/******************************/
			case BID_TAB1:
				if( m_bFirst == INIT_COMPLAIN )
				{
					m_lNotice_ActIdx = 0;
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_TAB2:
				if( m_bFirst == INIT_MAIN )
				{
					m_lComplain_ActIdx = 0;
					ON_EXIT();
					OnInit(INIT_COMPLAIN);
				}
				break;
				
			/******************************/
			/* 공지사항                   */
			/******************************/
			case BID_NOTICE_PREV:
				m_lPage_N--;
				
				if(m_lPage_N < 0)
				{
					m_lPage_N = 0;
					return;
				}
				
				m_lNotice_ActIdx = 0;
				Notice_Draw();
				
				break;	
						
			case BID_NOTICE_NEXT:
				m_lPage_N++ ;
				
				if( m_lPage_N > m_lTotpage_N-1 )
				{
					m_lPage_N = m_lTotpage_N-1;
					
					if(m_lPage_N < 0)
					{
						m_lPage_N = 0;
					}
					
					break;
				}
				
				m_lNotice_ActIdx = 0;
				Notice_Draw();
				
				break;
			
			case BID_NOTICE_VIEW:
				Mem_Set( (byte*)m_szTxtView, 0x00, sizeof(m_szTxtView) );
				m_lViewFlag = 3;
				m_ltxtViewPageFlag = 0;
				
				ON_EXIT();
				OnInit(INIT_VIEWTXT);
				
				break;

			case BID_OK:
				Card_Move("MENU");
				break;
			
			/******************************/
			/* 고객의 소리                */
			/******************************/
			case BID_ADDR:
				if( g_nAddrFlag == 0 )
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				Complain_Draw();
				break;
				
			case BID_TELNUM:
				if( m_lTelFlag == 0 )
				{
					m_lTelFlag = 1;
				}
				else
				{
					m_lTelFlag = 0;
				}
				Complain_Draw();
				break;
				
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DATA20), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA20)) );
				break;
				
			case BID_COMPLAIN_PREV:
				m_lPage_C--;
				
				if(m_lPage_C < 0)
				{
					m_lPage_C = 0;
					return;
				}
				
				m_lComplain_ActIdx = 0;
				Complain_Draw();
				
				break;	
						
			case BID_COMPLAIN_NEXT:
				m_lPage_C++ ;
				
				if( m_lPage_C > m_lTotpage_C-1 )
				{
					m_lPage_C = m_lTotpage_C-1;
					
					if(m_lPage_C < 0)
					{
						m_lPage_C = 0;
					}
					
					break;
				}
				
				m_lComplain_ActIdx = 0;
				Complain_Draw();
				
				break;
				
			case BID_MW_VIEW:
				Mem_Set( (byte*)m_szTxtView, 0x00, sizeof(m_szTxtView) );
				m_lViewFlag = 1;
				
				//민원내용
				Str_Cpy(m_szTxtView[0], EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA16)));
				//처리내용
				Str_Cpy(m_szTxtView[1], EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA20)));
				
				ON_EXIT();
				OnInit(INIT_VIEWTXT);
				
				break;
				
			case BID_MW_MEMO:
				Mem_Set( (byte*)m_szTxtView, 0x00, sizeof(m_szTxtView) );
				m_lViewFlag = 1;
				
				//민원내용
				Str_Cpy(m_szTxtView[0], EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA18)));
				//처리내용
				Str_Cpy(m_szTxtView[1], EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA20)));
				
				ON_EXIT();
				OnInit(INIT_VIEWTXT);
				
				break;
				
			case BID_MW_DESC:
				Mem_Set( (byte*)m_szTxtView, 0x00, sizeof(m_szTxtView) );
				m_lViewFlag = 2;
				
				//처리내용
				Str_Cpy(m_szTxtView[1], EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA20)));
				
				ON_EXIT();
				OnInit(INIT_VIEWTXT);
				
				break;
				
			case BID_SAVE:
				Snd_Success();
				break;
			
			/******************************/
			/* 상세 텍스트                */
			/******************************/
			case BID_TXT_OK:
				if( m_lViewFlag == 3 )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_COMPLAIN);
				}
				break;
			
			case BID_TXT_PREV:
				Mem_Set( (byte*)m_szTxtView, 0x00, sizeof(m_szTxtView) );
				m_lViewFlag = 3;
				m_ltxtViewPageFlag = 0;
				TxtDraw();
				break;
			
			case BID_TXT_NEXT:
				Mem_Set( (byte*)m_szTxtView, 0x00, sizeof(m_szTxtView) );
				m_lViewFlag = 3;
				m_ltxtViewPageFlag = 1;
				TxtDraw();
			
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
		long index;

		if( m_bFirst == INIT_MAIN )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_NOTICELIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_NOTICELIST);
				m_lNotice_ActIdx = index - 1;
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 2) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 3) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 4) );

				Mem_Set( (byte*)m_szNoticeSeq, 0x00, sizeof(m_szNoticeSeq) );
				Mem_Set( (byte*)m_szNoticeChk_yn, 0x00, sizeof(m_szNoticeChk_yn) );
				Str_Cpy(m_szNoticeSeq, DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 5));
				Str_Cpy(m_szNoticeChk_yn, DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 6));
				
				Mem_Set( (byte*)m_szNoticeTxtView, 0x00, sizeof(m_szNoticeTxtView) );
				Str_Cpy(m_szNoticeTxtView[0], DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 2));
				Str_Cpy(m_szNoticeTxtView[1], DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 7));
				
				if( Str_Cmp(m_szNoticeChk_yn, "Y") != 0 )
				{
					Snd_NoticeCheck();
				}
			}
		}
		else if( m_bFirst == INIT_COMPLAIN )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_COMPLAINIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_COMPLAINIST);
				m_lComplain_ActIdx = index - 1;
	
				Mem_Set( (byte*)m_szProc_Sts, 0x00, sizeof(m_szProc_Sts) );
				Str_Cpy(m_szProc_Sts, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 2));
				if( Str_Cmp(m_szProc_Sts, "Y") != 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
				}

				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8),  DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 3) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 4) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 5) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 6) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 7) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 8) );

				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 9) );
				
				Mem_Set( (byte*)m_stComplain.szPromise_Assign_Seq, 0x00, sizeof(m_stComplain.szPromise_Assign_Seq) );
				Str_Cpy(m_stComplain.szPromise_Assign_Seq, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 10));
				
				Mem_Set( (byte*)m_stComplain.szCivil_Serv_Receive_Num, 0x00, sizeof(m_stComplain.szCivil_Serv_Receive_Num) );
				Str_Cpy(m_stComplain.szCivil_Serv_Receive_Num, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 11));
				
				Mem_Set( (byte*)m_stComplain.szTreat_Seq, 0x00, sizeof(m_stComplain.szTreat_Seq) );
				Str_Cpy(m_stComplain.szTreat_Seq, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 12));
				

				Mem_Set( (byte*)m_szComplainChk_yn, 0x00, sizeof(m_szComplainChk_yn) );
				Str_Cpy(m_szComplainChk_yn, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 13));
				if( Str_Cmp(m_szComplainChk_yn, "Y") != 0 )
				{
					Snd_ComplainCheck();
				}
			}
		}
	}
	
	//---------------------------------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_TOP);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), TRUE );
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA2), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_COMPLAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_TOP);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA14), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA16), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA18), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA20), TRUE, 2, EDITSEP_NONE );
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), FALSE );
		}
		else if( m_bFirst == INIT_VIEWTXT )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_TOP);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA21), TRUE, 2, EDITSEP_NONE );
		}
	}
	
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : 버튼 이미지
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		
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
	
	/*=======================================================================================
	함수명 : Rcv_Notice
	기  능 : 공지사항 수신 / FR12112
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Notice(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
	
		g_Sql_DirectExecute("DELETE FROM C6501_NOTICE");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 12112, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "employee_id",        	stUserinfo.szemployee_id );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR12112;
		ret = HTTP_DownloadData(szUrl, "FR12112_IN",  "FR12112" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR12112
	기  능 : FR12112 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR12112(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(12112) >= 0)
		{
			Rcv_Count();
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Notice_Draw
	기  능 : 공지사항 화면 Draw
	Param  : 
	Return : 
	========================================================================================*/
	void Notice_Draw(void)
	{
		long i, idx;
		long k = ROW_N + 1;
		char sztmp[3000];
		char szDate[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM C6501_NOTICE", &m_lTotpage_N );
		
		if( m_lTotpage_N % ROW_N > 0 )
		{
			m_lTotpage_N = (m_lTotpage_N / ROW_N) + 1;
		}
		else
		{
			m_lTotpage_N = m_lTotpage_N / ROW_N;
		}
		
		//페이지
		SPRINT(m_szCnt_page_N, "%d/%d", m_lPage_N+1, m_lTotpage_N, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT NOTICE_TIME, NOTICE_TITLE, NOTICE_DESC,  CENTER_NM, WRITE_NM, NOTICE_SEQ, CHK_YN, NOTICE_DESC2 FROM C6501_NOTICE ORDER BY NOTICE_TIME DESC LIMIT ?, ?" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lPage_N*ROW_N;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lPage_N*ROW_N+ROW_N;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_N ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_NOTICELIST, i, 0, "" );
				DlgTbl_SetStr ( ID_NOTICELIST, i, 1, "" );
				DlgTbl_SetStr ( ID_NOTICELIST, i, 2, "" );
				DlgTbl_SetStr ( ID_NOTICELIST, i, 3, "" );
				DlgTbl_SetStr ( ID_NOTICELIST, i, 4, "" );
				DlgTbl_SetStr ( ID_NOTICELIST, i, 5, "" );
				DlgTbl_SetStr ( ID_NOTICELIST, i, 6, "" );
				DlgTbl_SetStr ( ID_NOTICELIST, i, 7, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_NOTICELIST, i, 0, "" );
					DlgTbl_SetStr ( ID_NOTICELIST, i, 1, "" );
					DlgTbl_SetStr ( ID_NOTICELIST, i, 2, "" );
					DlgTbl_SetStr ( ID_NOTICELIST, i, 3, "" );
					DlgTbl_SetStr ( ID_NOTICELIST, i, 4, "" );
					DlgTbl_SetStr ( ID_NOTICELIST, i, 5, "" );
					DlgTbl_SetStr ( ID_NOTICELIST, i, 6, "" );
					DlgTbl_SetStr ( ID_NOTICELIST, i, 7, "" );
					continue;
				}

				idx = 0;
				//공지일시
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_NOTICELIST, i, 0, szDate );
				
				//공지제목
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_NOTICELIST, i, 1, sztmp );
				
				//공지내용
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 3000, DECRYPT);
				DlgTbl_SetStr ( ID_NOTICELIST, i, 2, sztmp );
				
				//소속
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_NOTICELIST, i, 3, sztmp );
				
				//작성자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_NOTICELIST, i, 4, sztmp );
				
				//NOTICE_SEQ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_NOTICELIST, i, 5, sztmp );
				
				//CHK_YN
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5, DECRYPT);
				
				if( Str_Cmp(sztmp, "N") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NOTICELIST, i, 0 ), TXTFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NOTICELIST, i, 1 ), TXTFRCOLOR);
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NOTICELIST, i, 0 ), LIGHTGRAY);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NOTICELIST, i, 1 ), LIGHTGRAY);
				}
				
				DlgTbl_SetStr ( ID_NOTICELIST, i, 6, sztmp );
				
				//NOTICE_DESC2
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_NOTICELIST, i, 7, sztmp );
			}
		}		

	Finally:
		if(m_lTotpage_N > 0)
		{
			if( m_lNotice_ActIdx == -1 )
			{
				m_lNotice_ActIdx = 0;
			}

			DlgTbl_SetActive(ID_NOTICELIST , m_lNotice_ActIdx+1 );
			DlgTbl_SetRowColor(ID_NOTICELIST, m_lNotice_ActIdx+1, TABLEACTIVE_COLOR);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 2) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 3) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 4) );

			Mem_Set( (byte*)m_szNoticeSeq, 0x00, sizeof(m_szNoticeSeq) );
			Mem_Set( (byte*)m_szNoticeChk_yn, 0x00, sizeof(m_szNoticeChk_yn) );
			Str_Cpy(m_szNoticeSeq, DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 5));
			Str_Cpy(m_szNoticeChk_yn, DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 6));
			
			Mem_Set( (byte*)m_szNoticeTxtView, 0x00, sizeof(m_szNoticeTxtView) );
			Str_Cpy(m_szNoticeTxtView[0], DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 2));
			Str_Cpy(m_szNoticeTxtView[1], DlgTbl_GetStr( ID_NOTICELIST, m_lNotice_ActIdx, 7));	
				
			if( Str_Cmp(m_szNoticeChk_yn, "Y") != 0 )
			{
				Snd_NoticeCheck();
			}
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TAB1), "0 공지사항");
		}
		
		DelSqLite(sql);
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	함수명 : Snd_NoticeCheck
	기  능 : 공지사항 읽음 처리 / FR12114
	Param  : 
	Return : 
	========================================================================================*/
	long Snd_NoticeCheck(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 12114, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "notice_seq",        		m_szNoticeSeq );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "employee_id",        	stUserinfo.szemployee_id );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR12114;
		ret = HTTP_DownloadData(szUrl, "FR12114_IN",  "FR12114" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR12114
	기  능 : FR12114 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR12114(void)	
	{
		long ntotcnt = 0;
		char szTmp[256];
	
		if( g_Chk_Json(12114) >= 0)
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			SPRINT(szTmp, "UPDATE C6501_NOTICE SET CHK_YN = 'Y' WHERE NOTICE_SEQ = '%s'",m_szNoticeSeq,0,0);
			g_Sql_DirectExecute(szTmp);
			
			Rcv_Count();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

	/*=======================================================================================
	함수명 : Rcv_Count
	기  능 : 탭 Count / FR12116
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Count(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 12116, FALSE);
		
		if( Str_Cmp(m_szCnt_Gubun, "1") == 0 )
		{
			Mem_Set((byte*)m_szCnt_Gubun, 0x00, sizeof(m_szCnt_Gubun));	
			Str_Cpy(m_szCnt_Gubun, "2");
		}
		else
		{
			Mem_Set((byte*)m_szCnt_Gubun, 0x00, sizeof(m_szCnt_Gubun));	
			Str_Cpy(m_szCnt_Gubun, "1");
		}
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        	stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "gubun",        		m_szCnt_Gubun );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR12116;
		ret = HTTP_DownloadData(szUrl, "FR12116_IN",  "FR12116" , sndbuf, sztmp );
		
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR12116
	기  능 : FR12116 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR12116(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(12116) >= 0)
		{
			CntDraw(12116);
			
			if( Str_Cmp(m_szCnt_Gubun, "1") == 0 )
			{
				Rcv_Count();
				return 1;
			}
			else
			{
				Mem_Set((byte*)m_szCnt_Gubun, 0x00, sizeof(m_szCnt_Gubun));	
			}

			Str_Cat(m_szTitle_N, " 공지사항");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TAB1), m_szTitle_N);


			Str_Cat(m_szTitle_C, " 고객의 소리");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TAB2), m_szTitle_C);
		
			if( m_bFirst == INIT_MAIN )
			{
				Notice_Draw();
			}
			else
			{
				Complain_Draw();
			}
			
			ON_DRAW();
			
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : CntDraw
	기  능 : FR12116 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long CntDraw(long nservicenum)
	{
		char szJsonpath[500];
		char szMsg[500];
		char szCol[128];
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
			{
				break;
			}
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
				{
					SQL_ConvMbStr( szMsg, szmessage);
				}
				
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
								if( Str_Cmp(m_szCnt_Gubun, "1") == 0 )
								{
									// 공지사항
									Mem_Set((byte*) m_szTitle_N, 0x00, sizeof( m_szTitle_N) );
									Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
									
									nCol = (long*)JSON_GetArrayItem ( hitem, 0, "notice_count", szType);
									m_lTitleCnt = *nCol;
									Str_ItoA( m_lTitleCnt, szCol, 10);

									if( Str_Cmp(szCol, "0") == 0 || Str_Cmp(szCol, "") == 0 )
									{
										Str_Cpy(m_szTitle_N, "0");
									}
									else
									{
										Str_Cpy(m_szTitle_N, szCol);
									}
								}
								else
								{
									// 고객의소리
									Mem_Set((byte*) m_szTitle_C, 0x00, sizeof( m_szTitle_C) );
									Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
									
									nCol = (long*)JSON_GetArrayItem ( hitem, 0, "cust_notice_count", szType);
									m_lTitleCnt = *nCol;
									Str_ItoA( m_lTitleCnt, szCol, 10);
									
									if( Str_Cmp(szCol, "0") == 0 || Str_Cmp(szCol, "") == 0 )
									{
										Str_Cpy(m_szTitle_C, "0");
									}
									else
									{
										Str_Cpy(m_szTitle_C, szCol);
									}
								}
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
	
	/*=======================================================================================
	함수명 : Rcv_Complain
	기  능 : 고객의 소리 수신 / FR12119
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Complain(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
	
		g_Sql_DirectExecute("DELETE FROM C6501_COMPLAIN");
	
		PROGRESS_DUMP("");
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 12119, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR12119;
		ret = HTTP_DownloadData(szUrl, "FR12119_IN",  "FR12119" , sndbuf, sztmp );
		return 0 ;
	}

	/*=======================================================================================
	함수명 : TR12119
	기  능 : FR12119 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR12119(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(12119) >= 0)
		{
			Rcv_Count();
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Complain_Draw
	기  능 : 고객의 소리 화면 Draw
	Param  : 
	Return : 
	========================================================================================*/
	void Complain_Draw(void)
	{
		long i, idx;
		long k = ROW_C + 1;
		char sztmp[3000];
		char szBuf[30];
		char szDate[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_RetInt( "SELECT COUNT(*) FROM C6501_COMPLAIN", &m_lTotpage_C );
		
		if( m_lTotpage_C % ROW_C > 0 )
		{
			m_lTotpage_C = (m_lTotpage_C / ROW_C) + 1;
		}
		else
		{
			m_lTotpage_C = m_lTotpage_C / ROW_C;
		}
		
		//페이지
		SPRINT(m_szCnt_page_C, "%d/%d", m_lPage_C+1, m_lTotpage_C, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT CIVIL_SERV_CLASS_NM , CASE WHEN Length(ifnull(Trim(VILLAGE),'') )+Length( ifnull(Trim(BUILDING),'') ) > 0 THEN ifnull(Trim(VILLAGE), '') ||' '|| ifnull(Trim(BUILDING), '') ||'-'|| ifnull(HOUSE_CNT, '') ELSE ifnull(NEW_ADDR_M, '') ||'-'|| ifnull(NEW_ADDR_S, '') ||' '|| ifnull(HOUSE_CNT, '') ||' '|| ifnull(ETC_ADDR, '') END , CASE WHEN Length(ifnull(Trim(VILLAGE),'') )+Length( ifnull(Trim(BUILDING),'') ) > 0 THEN ifnull(Trim(VILLAGE), '') ||' '|| ifnull(Trim(BUILDING), '') ||'-'|| ifnull(HOUSE_CNT, '') ||' '|| ifnull(ETC_ADDR, '') ELSE ifnull(ADDR1_M, '') ||'-'|| ifnull(ADDR1_S, '') ||' '|| ifnull(HOUSE_CNT, '') ||' '|| ifnull(ETC_ADDR, '') END , PROC_STS, USE_CONT_NUM, REQ_NM, ifnull(REQ_TEL_DDD, '') ||'-'|| ifnull(REQ_TEL_EXN, '') ||'-'|| ifnull(REQ_TEL_NUM, ''), ifnull(REQ_CP_DDD, '') ||'-'|| ifnull(REQ_CP_EXN, '') ||'-'|| ifnull(REQ_CP_NUM, ''), NEW_ADDR_UNION, CURR_ADDR_UNION, CIVIL_SERV_DESC, PROMISE_ASSIGN_DESC, TREAT_END_DESC, PROMISE_ASSIGN_SEQ, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, CUST_NOTICE_CHK_YN FROM C6501_COMPLAIN ORDER BY PROMISE_TIME DESC LIMIT ?, ?" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		
		lstartidx = m_lPage_C*ROW_C;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		
		i = m_lPage_C*ROW_C+ROW_C;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_C ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 0, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 1, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 2, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 3, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 4, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 5, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 6, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 7, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 8, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 9, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i,10, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i,11, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i,12, "" );
				DlgTbl_SetStr ( ID_COMPLAINIST, i,13, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 0, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 1, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 2, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 3, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 4, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 5, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 6, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 7, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 8, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i, 9, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i,10, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i,11, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i,12, "" );
					DlgTbl_SetStr ( ID_COMPLAINIST, i,13, "" );
					continue;
				}

				idx = 0;
				//작업배정
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 0, sztmp );
				
				//주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				if( g_nAddrFlag == 1 )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주소");
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 300, DECRYPT);
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 300, DECRYPT);
				}
				
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 1, sztmp );
				
				//처리상태
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 2, sztmp );
				
				//사용계약번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 30, DECRYPT);
				Mem_Cpy( (byte*)szBuf, (byte*)sztmp, 5);
				Str_Cat(szBuf, "-");
				Mem_Cpy( (byte*)szDate, (byte*)sztmp+5, 5);
				Str_Cat(szBuf, szDate);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 3, szBuf );
				
				//신청인
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 5, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 4, sztmp );
				
				//핸드폰번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				
				if( m_lTelFlag == 0 )
				{
					//핸드폰
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TELNUM), "HP");
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 20, DECRYPT);
				}
				else
				{
					//집
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TELNUM), "자택");
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 20, DECRYPT);
				}
				
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 5, sztmp );
				
				//상세주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				if( g_nAddrFlag == 1 )
				{
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 300, DECRYPT);
				}
				else
				{
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 300, DECRYPT);
				}
				
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 6, sztmp );
				
				//민원내용
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 10, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 7, sztmp );
				
				//메모
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 11, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 8, sztmp );
				
				//처리내용
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 12, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 9, sztmp );
				
				//PROMISE_ASSIGN_SEQ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 13, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 10, sztmp );
				
				//CIVIL_SERV_RECEIVE_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 14, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 11, sztmp );
				
				//TREAT_SEQ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 15, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 12, sztmp );
				
				//CUST_NOTICE_CHK_YN
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 16, 'U', (long*)sztmp, 10, DECRYPT);
				
				if( Str_Cmp(sztmp, "Y") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_COMPLAINIST, i, 0 ), LIGHTGRAY);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_COMPLAINIST, i, 1 ), LIGHTGRAY);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_COMPLAINIST, i, 2 ), LIGHTGRAY);
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_COMPLAINIST, i, 0 ), TXTFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_COMPLAINIST, i, 1 ), TXTFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_COMPLAINIST, i, 2 ), TXTFRCOLOR);
				}
				
				DlgTbl_SetStr ( ID_COMPLAINIST, i, 13, sztmp );
			}
		}		

	Finally:

		if(m_lTotpage_C > 0)
		{
			if( m_lComplain_ActIdx == -1 )
			{
				m_lComplain_ActIdx = 0;
			}

			DlgTbl_SetActive(ID_COMPLAINIST , m_lComplain_ActIdx+1 );
			DlgTbl_SetRowColor(ID_COMPLAINIST, m_lComplain_ActIdx+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)m_szProc_Sts, 0x00, sizeof(m_szProc_Sts) );
			Str_Cpy(m_szProc_Sts, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 2));
			
			if( Str_Cmp(m_szProc_Sts, "Y") != 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
			}
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8),  DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 3) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 4) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 5) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 6) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 7) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 8) );
			
			if( m_lViewFlag == 1 || m_lViewFlag == 2 )
			{
				m_lViewFlag = 0;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), m_szTxtView[1] );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 9) );
			}
			
			Mem_Set( (byte*)m_stComplain.szPromise_Assign_Seq, 0x00, sizeof(m_stComplain.szPromise_Assign_Seq) );
			Str_Cpy(m_stComplain.szPromise_Assign_Seq, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 10));
			
			Mem_Set( (byte*)m_stComplain.szCivil_Serv_Receive_Num, 0x00, sizeof(m_stComplain.szCivil_Serv_Receive_Num) );
			Str_Cpy(m_stComplain.szCivil_Serv_Receive_Num, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 11));
			
			Mem_Set( (byte*)m_stComplain.szTreat_Seq, 0x00, sizeof(m_stComplain.szTreat_Seq) );
			Str_Cpy(m_stComplain.szTreat_Seq, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 12));

			Mem_Set( (byte*)m_szComplainChk_yn, 0x00, sizeof(m_szComplainChk_yn) );
			Str_Cpy(m_szComplainChk_yn, DlgTbl_GetStr( ID_COMPLAINIST, m_lComplain_ActIdx, 13));
			
			if( Str_Cmp(m_szComplainChk_yn, "Y") != 0 )
			{
				Snd_ComplainCheck();
			}
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TAB2), "0 고객의 소리");

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
		}
		
		DelSqLite(sql);
		ON_DRAW();
		return;
	}

	/*=======================================================================================
	함수명 : Snd_Success
	기  능 : 고객의 소리 처리결과 송신 / FR12121
	Param  : 
	Return : 
	========================================================================================*/
	long Snd_Success(void)
	{
		char sztmp[400];
		char szUrl[256];
		char* sndbuf;
		long ret;
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA20)));
		SQL_ConvUcStr( m_stComplain.szMemo, sztmp );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 12121, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",     m_stComplain.szPromise_Assign_Seq );
		JSON_SetValue( g_pjcomm, 'C', "memo",        		    m_stComplain.szMemo );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", m_stComplain.szCivil_Serv_Receive_Num );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq",        		m_stComplain.szTreat_Seq );

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR12121;
		ret = HTTP_DownloadData(szUrl, "FR12121_IN",  "FR12121" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR12121
	기  능 : FR12121 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR12121(void)	
	{
		char szSql[800];
		char sztmp[500];
		long ntotcnt = 0;
	
		if( g_Chk_Json(12121) >= 0)
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			
			Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA20)));
			SPRINT( szSql, "UPDATE C6501_COMPLAIN SET PROC_STS = 'Y', TREAT_END_DESC = '%s' WHERE PROMISE_ASSIGN_SEQ = '%s' AND CIVIL_SERV_RECEIVE_NUM = '%s'",sztmp, m_stComplain.szPromise_Assign_Seq, m_stComplain.szCivil_Serv_Receive_Num );
			g_Sql_DirectExecute(szSql);
			
			Mem_Set((byte*)m_szTxtView, 0x00, sizeof(m_szTxtView));	
			m_lViewFlag = 0;
			Complain_Draw();
			
			Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2));
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}
		
	/*=======================================================================================
	함수명 : Snd_ComplainCheck
	기  능 : 수신 체크 / FR121211
	Param  : 
	Return : 
	========================================================================================*/
	long Snd_ComplainCheck(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
	
		if( g_pjcomm != NULL )
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
				
		g_pjcomm = g_CreateJsonHead( g_pjcomm, szUrl, 121211, FALSE );
		
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq", m_stComplain.szPromise_Assign_Seq );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR121211;
		ret = HTTP_DownloadData( szUrl, "FR121211_IN", "FR121211" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR121211
	기  능 : Callback FR121211
	Param  : 
	Return : 
	========================================================================================*/
	long TR121211(void)	
	{
		long ntotcnt = 0;
		long lTitleCnt = 0;
		char szSql[500];
		
	
		if( g_Chk_Json(121211) >= 0)
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			SPRINT(szSql, " UPDATE C6501_COMPLAIN SET CUST_NOTICE_CHK_YN = 'Y' WHERE PROMISE_ASSIGN_SEQ = '%s' AND CIVIL_SERV_RECEIVE_NUM = '%s'", m_stComplain.szPromise_Assign_Seq, m_stComplain.szCivil_Serv_Receive_Num, 0);
			g_Sql_DirectExecute(szSql);
			
			Rcv_Count();
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

	/*=======================================================================================
	함수명 : TxtDraw
	기  능 : 상세보기
	Param  : 
	Return : 
	========================================================================================*/
	void TxtDraw(void)
	{
		if( m_lViewFlag == 3 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TITLE), "공지사항");
			
			if( m_ltxtViewPageFlag == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), m_szNoticeTxtView[0]);
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_PREV), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_PREV), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_NEXT), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_NEXT), FALSE );	
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), m_szNoticeTxtView[1]);
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_PREV), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_PREV), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_NEXT), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TXT_NEXT), TRUE );	
			}	
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TITLE), "고객의 소리");
			
			if( m_lViewFlag == 2 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), m_szTxtView[1]);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), m_szTxtView[0]);
			}
		}

		ON_DRAW();
		
		return;
	}
}

