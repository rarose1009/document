/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MOVING_CENT
	Card Desc : 이동 고객센터
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MOVING_CENT
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
	#define USE_ON_SELECT
//  #define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		DEF_BUTTON_ID ( BID_INQUIRY )				// BID_조회
		DEF_BUTTON_ID ( BID_REAL_HP_TEL )				// BID_HP/TEL
		DEF_BUTTON_ID ( BID_HP_CHG )				// BID_변경
		DEF_BUTTON_ID ( BID_HP_SMS )				// BID_SMS
		
		DEF_BUTTON_ID ( BID_PAY_METHOD_DTL )	   	// BID_납부방법_상세
		DEF_BUTTON_ID ( BID_BILL_SEND_METHOD_DTL ) 	// BID_발송방법_상세
		DEF_BUTTON_ID ( BID_UNPAY_MONTH )		   	// BID_미납개월_상세
		
		DEF_BUTTON_ID ( BID_VISIT )					// BID_방문일자(방문내역)
		DEF_BUTTON_ID ( BID_RSLT )					// BID_결과(메모)
		
		DEF_BUTTON_ID ( BID_CMB_BILL_SEND_METHOD )	// BID_CMB_발송방법
		DEF_BUTTON_ID ( BID_CLOSE )					// BID_취소
		DEF_BUTTON_ID ( BID_MEMO )					// BID_메모
		DEF_BUTTON_ID ( BID_OK )					// BID_등록
		
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		DEF_BUTTON_ID ( BID_SEARCH_CLEAR )			// BID_초기화
		DEF_BUTTON_ID ( BID_SEARCH )				// BID_검색
		DEF_BUTTON_ID ( BID_SEARCH_ADDR_CHG )		// BID_주소 변경
		DEF_BUTTON_ID ( BID_SEARCH_PAGE )			// BID_PAGE, 퀵뷰
		DEF_BUTTON_ID ( BID_SEARCH_UP )				// BID_조회_▲
		DEF_BUTTON_ID ( BID_SEARCH_DOWN )			// BID_조회_▼
		DEF_BUTTON_ID ( BID_SEARCH_WRITE_ADDR ) 	// BID_검색
		DEF_BUTTON_ID ( BID_SEARCH_WRITE_NAME ) 	// BID_성명
		DEF_BUTTON_ID ( BID_SEARCH_CLOSE )     	    // BID_조회_닫기
		
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		DEF_BUTTON_ID ( BID_REAL_SAVE )				// BID_변경
		DEF_BUTTON_ID ( BID_REAL_SMS )				// BID_SMS
		
		/********************************/
		/* 이동고객센터_요금내역        */
		/********************************/
		DEF_BUTTON_ID ( BID_CHARGE_UP )				// BID_요금_▲
		DEF_BUTTON_ID ( BID_CHARGE_DOWN )			// BID_요금_▼
		
		/********************************/
		/* 이동고객센터_방문내역        */
		/********************************/
		DEF_BUTTON_ID ( BID_VISIT_UP )				// BID_방문_▲
		DEF_BUTTON_ID ( BID_VISIT_DOWN )			// BID_방문_▼
		
		/********************************/
		/* 이동고객센터_메모            */
		/********************************/
		DEF_BUTTON_ID ( BID_MEMO_DEL )				// BID_메모삭제
		DEF_BUTTON_ID ( BID_MEMO_SAVE )				// BID_메모저장
		DEF_BUTTON_ID ( BID_MEMO_WRITE )			// BID_메모EDIT
		
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/
		DEF_BUTTON_ID ( BID_BILL_SEND_SAVE )		 // BID_등록
		DEF_BUTTON_ID ( BID_BILL_SEND_REQ_NM_WRITE ) // BID_신청자명
		DEF_BUTTON_ID ( BID_BILL_SEND_EMAIL_WRITE )	 // BID_이메일
		DEF_BUTTON_ID ( BID_BILL_SEND_EMAIL_WRITE2 ) // BID_이메일2
		
		/********************************/
		/* 공통                         */
		/********************************/
		DEF_BUTTON_ID ( BID_POPUP_CLOSE )			// BID_팝업_취소
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* 이동고객센터_타이틀          */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )				
		DEF_OBJECT_ID ( ICON_TITLE )
		
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		DEF_OBJECT_ID ( ST_USE_CONT_NUM )		// ST_사용계약번호
		DEF_OBJECT_ID ( TXT_USE_CONT_NUM )		// TXT_사용계약번호
		DEF_OBJECT_ID ( TXT_USE_CONT_DOC )		// TXT_사용계약신청서_여부
		DEF_OBJECT_ID ( TXT_PHONE_NUM )			// TXT_HP/TEL번호
		
		DEF_OBJECT_ID ( ST_DEADLINE )			// ST_마감일
		DEF_OBJECT_ID ( TXT_DEADLINE )			// TXT_마감일
		DEF_OBJECT_ID ( ST_GMTR_METHOD )		// ST_검침방법
		DEF_OBJECT_ID ( TXT_GMTR_METHOD )		// TXT_검침방법
		DEF_OBJECT_ID ( ST_PAY_METHOD )			// ST_납부방법
		DEF_OBJECT_ID ( TXT_PAY_METHOD )		// TXT_납부방법
		DEF_OBJECT_ID ( ST_BILL_SEND_METHOD )	// ST_발송방법
		DEF_OBJECT_ID ( TXT_BILL_SEND_METHOD )	// TXT_발송방법
		DEF_OBJECT_ID ( ST_UNPAY_MONTH )		// ST_미납개월
		DEF_OBJECT_ID ( TXT_UNPAY_MONTH )		// TXT_미납개월
		DEF_OBJECT_ID ( ST_UNPAY_AMT )			// ST_미납금액
		DEF_OBJECT_ID ( TXT_UNPAY_AMT )			// TXT_미납금액
		
		DEF_OBJECT_ID ( ST_VISIT_TYPE )			// ST_방문구분
		DEF_OBJECT_ID ( TXT_VISIT_YMD )			// TXT_방문일자
		DEF_OBJECT_ID ( TXT_VISIT_TYPE )		// TXT_방문구분
		DEF_OBJECT_ID ( TXT_VISIT_RESULT )		// TXT_방문결과
		
		DEF_OBJECT_ID ( ST_CMB_REFUSE )			// ST_CMB_거부
		DEF_OBJECT_ID ( ST_CMB_PAY_METHOD )		// ST_CMB_납부방법
		DEF_OBJECT_ID ( ST_CMB_SELF_GMTR )		// ST_CMB_자가검침
		DEF_OBJECT_ID ( ST_CMB_USE_CONT )		// ST_CMB_사용계약
		
		DEF_OBJECT_ID ( LINE_DATA1 )			// 라인1
		DEF_OBJECT_ID ( LINE_DATA2 )			// 라인2
		DEF_OBJECT_ID ( LINE_DATA3 )			// 라인3
		DEF_OBJECT_ID ( LINE_DATA4 )			// 라인4
		
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		DEF_OBJECT_ID ( ST_SEARCH_TYPE )		// ST_구분
		DEF_OBJECT_ID ( ST_SEARCH_ADDR_TYPE )	// ST_주소
		DEF_OBJECT_ID ( ST_SEARCH_CITY )		// ST_시/구
		DEF_OBJECT_ID ( ST_SEARCH_CITY2 )		// ST_시/구2
		DEF_OBJECT_ID ( ST_SEARCH_ADDR )		// ST_검색
		DEF_OBJECT_ID ( ST_SEARCH_USE_CONT )	// ST_사용계약
		DEF_OBJECT_ID ( ST_SEARCH_NAME )		// ST_성명
		DEF_OBJECT_ID ( ST_SEARCH_PHONE )		// ST_전화번호
		DEF_OBJECT_ID ( ST_SEARCH_PHONE_EXN )	// ST_전화번호_EXN
		DEF_OBJECT_ID ( ST_SEARCH_PHONE_NUM )	// ST_전화번호_NUM
		DEF_OBJECT_ID ( TXT_SEARCH_ADDR_EX )	// TXT_검색예제
		DEF_BUTTON_ID ( TXT_SEARCH_PAGE )		// TXT_페이지
		DEF_OBJECT_ID ( LINE_DATA5 )			// 라인5
		DEF_OBJECT_ID ( LINE_DATA6 )			// 라인6
		
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		DEF_OBJECT_ID ( ST_REAL_HP )			// ST_실사용자_HP
		DEF_OBJECT_ID ( TXT_REAL_HP )			// TXT_실사용자_HP
		DEF_OBJECT_ID ( ST_REAL_USER )			// ST_실사용자
		DEF_OBJECT_ID ( ST_REAL_EXN )			// ST_실사용자_-
		DEF_OBJECT_ID ( ST_REAL_NUM )			// ST_실사용자_-
		DEF_OBJECT_ID ( LINE_DATA7 )			// 라인7
		
		/********************************/
		/* 이동고객센터_요금내역        */
		/********************************/
		DEF_OBJECT_ID ( TXT_CHARGE_PAGE )		// TXT_요금_PAGE
		DEF_OBJECT_ID ( LINE_DATA8 )			// 라인8
		
		/********************************/
		/* 이동고객센터_방문내역        */
		/********************************/
		DEF_OBJECT_ID ( TXT_VISIT_PAGE )		// TXT_방문_PAGE
		DEF_OBJECT_ID ( LINE_DATA9 )			// 라인9
		
		/********************************/
		/* 이동고객센터_메모            */
		/********************************/
		DEF_OBJECT_ID ( EDT_MEMO ) 				// EDIT_MEMO
		DEF_OBJECT_ID ( LINE_DATA10 )			// 라인10
		
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/
		DEF_OBJECT_ID ( ST_BILL_SEND_REQ_NM )	// ST_신청자
		DEF_OBJECT_ID ( ST_BILL_SEND_PHONE )	// ST_핸드폰
		DEF_OBJECT_ID ( ST_BILL_SEND_EXN )		// ST_EXN_-
		DEF_OBJECT_ID ( ST_BILL_SEND_NUM )		// ST_NUM_-+
		DEF_OBJECT_ID ( ST_BILL_SEND_EMAIL1 )	// ST_이메일
		DEF_OBJECT_ID ( ST_BILL_SEND_EMAIL2 )	// ST_@
		DEF_OBJECT_ID ( LINE_DATA11 )			// 라인11
		
		/********************************/
		/* 공통                         */
		/********************************/
		// 포인팅 자판
		DEF_OBJECT_ID ( TXT_KEY_ONE )			// 1
		DEF_OBJECT_ID ( TXT_KEY_TWO )			// 2
		DEF_OBJECT_ID ( TXT_KEY_THREE )			// 3 
		DEF_OBJECT_ID ( TXT_KEY_FOUR )			// 4
		DEF_OBJECT_ID ( TXT_KEY_FIVE )			// 5
		DEF_OBJECT_ID ( TXT_KEY_SIX )			// 6
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )			// 7
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )			// 8
		DEF_OBJECT_ID ( TXT_KEY_NINE )			// 9
		DEF_OBJECT_ID ( TXT_KEY_ZERO )			// 0
		DEF_OBJECT_ID ( TXT_KEY_DEL )			// <-
		DEF_OBJECT_ID ( TXT_KEY_EMPTY )			// 빈칸
		
		/********************************/
		/* 테이블                       */
		/********************************/
		DEF_OBJECT_ID ( ID_SEARCH_TBLLIST )		// 조회 테이블
		DEF_OBJECT_ID ( ID_CHARGE_TBLLIST )		// 요금 테이블
		DEF_OBJECT_ID ( ID_VISIT_TBLLIST )		// 방문 테이블
		
		/********************************/
		/* EDIT                         */
		/********************************/
		// 조회
		DEF_OBJECT_ID ( EDT_SEARCH_ADDR )			// EDT_주소 검색
		DEF_OBJECT_ID ( EDT_SEARCH_USE_CONT_NUM )	// EDT_사용계약번호 검색
		DEF_OBJECT_ID ( EDT_SEARCH_NAME )			// EDT_성명
		DEF_OBJECT_ID ( EDT_SEARCH_PHONE_EXN )		// EDT_전화번호_EXN
		DEF_OBJECT_ID ( EDT_SEARCH_PHONE_NUM )		// EDT_전화번호_NUM
		
		// 실사용자
		DEF_OBJECT_ID ( EDT_REAL_PHONE_EXN )		// EDT_EXN
		DEF_OBJECT_ID ( EDT_REAL_PHONE_NUM )		// EDT_NUM
		
		// 발송등록
		DEF_OBJECT_ID ( EDT_BILL_SEND_REQ_NM )		// EDT_신청자
		DEF_OBJECT_ID ( EDT_BILL_SEND_PHONE_EXN )	// EDT_EXN
		DEF_OBJECT_ID ( EDT_BILL_SEND_PHONE_NUM )	// EDT_NUM
		DEF_OBJECT_ID ( EDT_BILL_SEND_EMAIL )		// EDT_EMAIL
		DEF_OBJECT_ID ( EDT_BILL_SEND_EMAIL2 )		// DET_EMIAL
		
		/********************************/
		/* COMBO                        */
		/********************************/
		// 메인
		DEF_OBJECT_ID ( CMB_BILL_SEND_METHOD )					// CMB_발송방법
		DEF_OBJECT_ID ( CMB_REFUSE = CMB_BILL_SEND_METHOD + 3 )	// CMB_거부
		DEF_OBJECT_ID ( CMB_PAY_METHOD = CMB_REFUSE + 3 )		// CMB_납부방법
		DEF_OBJECT_ID ( CMB_SELF_GMTR = CMB_PAY_METHOD + 3 )	// CMB_자가검침
		DEF_OBJECT_ID ( CMB_USE_CONT = CMB_SELF_GMTR + 3 )		// CMB_사용계약
		
		// 조회
		DEF_OBJECT_ID ( CMB_SEARCH_TYPE = CMB_USE_CONT + 3 )			// CMB_사용계약
		DEF_OBJECT_ID ( CMB_SEARCH_ADDR_TYPE = CMB_SEARCH_TYPE + 3 )	// CMB_주소
		DEF_OBJECT_ID ( CMB_SEARCH_CITY = CMB_SEARCH_ADDR_TYPE + 3 )	// CMB_시/군
		DEF_OBJECT_ID ( CMB_SEARCH_CITY2 = CMB_SEARCH_CITY + 3 )		// CMB_시/군2
		DEF_OBJECT_ID ( CMB_SEARCH_PHONE_DDD = CMB_SEARCH_CITY2 + 3 )	// CMB_전화번호
		
		// 실사용자
		DEF_OBJECT_ID ( CMB_REAL_PHONE_DDD = CMB_SEARCH_PHONE_DDD + 3 )		// CMB_실사용자_DDD
		
		// 발송등록
		DEF_OBJECT_ID ( CMB_BILL_SEND_PHONE_DDD = CMB_REAL_PHONE_DDD + 3 )	// CMB_발송등록_DDD
		DEF_OBJECT_ID ( CMB_BILL_SEND_EMAIL = CMB_BILL_SEND_PHONE_DDD + 3 )	// CMB_발송등록_이메일
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	조회 Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3						// table의 행개수
	#define		COL 	    4						// table의 열개수
	#define		GRID_H_H	(CHT+15)				// table 헤더 행 높이
	#define		GRID_H		(CHT+107)				// table 행 높이
	#define		GRID_CLR	TRANSPARENT   			// table 클리어 color
	#define		GRID_X		STARTX 			    	// table 시작x좌표
	#define		GRID_Y		STARTY+340  	    	// table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table마지막 row의 Y값
	#define		MAXCHAR		1000     	    		// table에 들어갈수 있는 최대  char 길이
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; 	// 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"사용계약",	CWD*10, EDITALIGN_CENTER, TABLE_TEXT, 0},
		{"주소",		CWD*22, EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"고객명",		CWD*8 , EDITALIGN_CENTER, TABLE_TEXT, 0},
		{"설치장소번호",	0 , EDITALIGN_CENTER, TABLE_TEXT, 0}
	};
	
	//-------------------------------------------------------------------------------------------------	
	//	요금 Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW2 	    9							// table의 행개수
	#define		COL2 	    7							// table의 열개수
	#define		GRID_H2		(CHT+45)					// table 바디 행 높이
	#define		GRID_CLR2	TRANSPARENT   				// table 클리어 color
	#define		GRID_X2		STARTX 			    		// table 시작x좌표
	#define		GRID_Y2		STARTY-29  	    			// table 시작y좌표
	#define		GRID_ENDY2	(GRID_Y2+(ROW2+1)*GRID_H2) 	// table마지막 row의 Y값
	#define		MAXCHAR2	51 			    			// table에 들어갈수 있는 최대  char 길이
	
	char	m_szTableBuf2 [COL2*(ROW2+1)*MAXCHAR2]; 	// 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	
	Column m_stGridTitle2[] = {
		{"청구\n년월",	CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"지침",		CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"사용량",		CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"청구금액",	CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"납부",		CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"납부방법",	0 	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"납부일자",	0 	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//-------------------------------------------------------------------------------------------------	
	//	방문 Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW3 	    4							// table의 행개수
	#define		COL3 	    4							// table의 열개수
	#define		GRID_H_H3	(CHT+21)					// table 헤더 행 높이
	#define		GRID_H3		(CHT+155)					// table 바디 행 높이
	#define		GRID_CLR3	TRANSPARENT   				// table 클리어 color
	#define		GRID_X3		STARTX 			    		// table 시작x좌표
	#define		GRID_Y3		STARTY-29  	    			// table 시작y좌표
	#define		GRID_ENDY3	(GRID_Y3+(ROW3+1)*GRID_H3) 	// table마지막 row의 Y값
	#define		MAXCHAR3	500 	       			    // table에 들어갈수 있는 최대  char 길이
	
	char	m_szTableBuf3 [COL3*(ROW3+1)*MAXCHAR3]; 	// 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle3[] = {
		{"방문일자",	CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"구분",		CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"결과",		CWD*23, EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ETC" ,		0     , EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN 1				// 메인
	#define INIT_SEARCH 2			// 조회
	#define INIT_REALUSER 3			// 실사용자
	#define INIT_CHARGEHIST 4		// 요금내역
	#define INIT_VISITHIST 5		// 방문내역
	#define INIT_MEMO 6				// 메모
	#define INIT_BILL_SEND_METHOD 7	// 발송등록
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	long m_bFirst;					// 화면 Index
	long m_lActiveIndex;			// 현재 터치한 Index	
	long m_lAIarmIndex = -1; 		// 테이블 더블 터치 시 파업을 띄우기 위한 Index 관리	
	long m_lReal_hp_tel = 0; 		// REAL/HP/TEL Change Pamram, HP = 0, tel = 1, real = 2
	long m_lInitRedraw = 0; 		// Init Screen Param, 최초 = 0, 조회했음 = 1 
	long m_lSearch_Addr_Chg = 0;    // 조회 주소 변경 flag : 0 = 지번, 1 = 도로명
	long m_lSearch_Move_flag = 0;	// 조회 클릭 후 Snd_FR90001에서 사용, 0 = 메인, 1 = 조회
	long m_lBldOk_flag = 0;			// 등록 버튼 flag : 0 = 등록, 1 = 발송등록
	
	long m_lVisit_Totpage; 		  	// Visit hist Total page
	long m_lVisit_page;	 		  	// Visit hist current page
	char m_szCnt_Visit_page[20];  	// Visit hist show page
	
	long m_lCharge_Totpage; 	  	// Charge hist Total page
	long m_lCharge_page;	 	  	// Charge hist current page
	char m_szCnt_Charge_page[20]; 	// Charge hist show page
	
	long m_lSearch_Totpage; 	  	// Search Total page
	long m_lSearch_page;	 	  	// Search current page
	char m_szCnt_Search_page[20]; 	// Search show page
	
	char m_szInst_Place_Num[10];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void SetCombo(void);
	
	void TableDraw_ChargeHist(void);
	void TableDraw_VisitHist(void);
    void TableDraw_Search(long flag);
	
	void SetCombo_Filter(void);
	
	void Set_Bill_Alarm(void);
	void Set_Pay_Alarm(void);
	
	void Save_Main_Combo(void);
	void Save_BillSend_Method(void);
	void Save_Real(void);
	void Save_Search(void);
	void Save_Memo(char* szMemo);
	
	void Clear_Data(void);
	void Clear_RsltData(void);
	
	bool Validation(void);
	
	void Snd_FR90001(char* szInst_Place_Num);
	long Rcv_FR90001(void);
	long Chk_Json_90001(void);
	
	void Snd_FR90002(void);
	long Rcv_FR90002(void);

	void Snd_FR90003(void);
	long Rcv_FR90003(void);

	void Snd_FR90004(void);
	long Rcv_FR90004(void);
	
	void Snd_FR90005(void);
	long Rcv_FR90005(void);
	
	void Snd_FR90006(void);
	long Rcv_FR90006(void);
	
	void Snd_FR90007(void);
	long Rcv_FR90007(void);
	
	void Quick_View_Search(void);
	void OnList(quad lParam);
	
	void Back_Move_Card(void);
	
	void Set_View_Main_PhoneNum(void);
	
	//---------------------------------------------------------------
	//	main 
	//---------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if( MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST )
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "이동 고객센터"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,  220,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_USE_CONT_NUM , "사용계약"),
		DLG_TEXT ( STARTX+220, STARTY- 29,  400,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_USE_CONT_NUM, ""),
		DLG_TEXT ( STARTX+620, STARTY- 29,  180,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_USE_CONT_DOC, ""),
		DLG_BUTTON(STARTX+800, STARTY- 29,  200,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_INQUIRY, "조회"),
		
		DLG_BUTTON(STARTX,	   STARTY+ 31,  219,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REAL_HP_TEL, "HP"),
		DLG_TEXT ( STARTX+220, STARTY+ 31,  400,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_PHONE_NUM, ""),
		DLG_BUTTON(STARTX+620, STARTY+ 31,  180,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_HP_CHG, "변경"),
		DLG_BUTTON(STARTX+800, STARTY+ 31,  200,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_HP_SMS, "SMS"),
		
		DLG_LINE ( STARTX,     STARTY+94, 1000, STARTY+94, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT ( STARTX,     STARTY+ 99,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_DEADLINE, "마감일"),
		DLG_TEXT ( STARTX+220, STARTY+ 99,  180,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_DEADLINE, ""),
		DLG_TEXT ( STARTX+400, STARTY+ 99,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_GMTR_METHOD, "검침방법"),
		DLG_TEXT ( STARTX+620, STARTY+ 99,  380,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_GMTR_METHOD, ""),
		
		DLG_TEXT ( STARTX,     STARTY+149,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_BILL_SEND_METHOD, "발송방법"),
		DLG_TEXT ( STARTX+220, STARTY+149,  580,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_BILL_SEND_METHOD, ""),
		DLG_BUTTON(STARTX+800, STARTY+149,  200,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_BILL_SEND_METHOD_DTL, "상세"),
		
		DLG_TEXT ( STARTX,     STARTY+199,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_PAY_METHOD, "납부방법"),
		DLG_TEXT ( STARTX+220, STARTY+199,  580,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_PAY_METHOD, ""),
		DLG_BUTTON(STARTX+800, STARTY+199,  200,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_PAY_METHOD_DTL, "상세"),
		
		DLG_TEXT ( STARTX,     STARTY+249,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_UNPAY_MONTH, "미납개월"),
		DLG_TEXT ( STARTX+220, STARTY+249,  580,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_UNPAY_MONTH, ""),
		DLG_BUTTON(STARTX+800, STARTY+249,  200,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_UNPAY_MONTH, "상세"),
		
		DLG_TEXT ( STARTX,     STARTY+299,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_UNPAY_AMT, "미납금액"),
		DLG_TEXT ( STARTX+220, STARTY+299,  780,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_UNPAY_AMT, ""),
		
		DLG_LINE ( STARTX,     STARTY+352, 1000, STARTY+352, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_BUTTON(STARTX,	   STARTY+357,  299,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_VISIT, "방문일자"),
		DLG_TEXT ( STARTX+300, STARTY+357,  150,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_VISIT_TYPE, "구분"),
		DLG_BUTTON(STARTX+450, STARTY+357,  550,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_RSLT, "결과"),
		
		DLG_TEXT ( STARTX,     STARTY+407,  300, 155, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_VISIT_YMD, ""),
		DLG_TEXT ( STARTX+300, STARTY+407,  150, 155, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_VISIT_TYPE, ""),
		DLG_TEXT ( STARTX+450, STARTY+407,  550, 155, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_VISIT_RESULT, ""),
		
		DLG_LINE ( STARTX,     STARTY+566, 1000, STARTY+566, DARKSLATEBLUE, 10, LINE_DATA3),
		
		DLG_BUTTON(STARTX,	   STARTY+570,  219,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CMB_BILL_SEND_METHOD, "발송방법"),
		DLG_COMBO( STARTX+220, STARTY+570,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_BILL_SEND_METHOD, 5), // 발송방법
		
		DLG_TEXT ( STARTX,     STARTY+620,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_REFUSE, "거부"),
		DLG_COMBO( STARTX+220, STARTY+620,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_REFUSE, 5), // 거부
		
		DLG_TEXT ( STARTX,     STARTY+670,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_PAY_METHOD, "납부방법"),
		DLG_COMBO( STARTX+220, STARTY+670,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_PAY_METHOD, 5), // 납부방법
		
		DLG_TEXT ( STARTX,     STARTY+720,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_SELF_GMTR, "자가검침"),
		DLG_COMBO( STARTX+220, STARTY+720,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SELF_GMTR, 5), // 자가검침
		
		DLG_TEXT ( STARTX,     STARTY+770,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_USE_CONT, "사용계약"),
		DLG_COMBO( STARTX+220, STARTY+770,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_USE_CONT, 5), // 사용계약
		
		DLG_LINE ( STARTX,     STARTY+823, 1000, STARTY+823, DARKSLATEBLUE, 10, LINE_DATA4),
		
		DLG_BUTTON(STARTX,	   STARTY+827,  330,  72, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLOSE, "취소"),
		DLG_BUTTON(STARTX+330, STARTY+827,  330,  72, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_MEMO, "메모"),
		DLG_BUTTON(STARTX+660, STARTY+827,  340,  72, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_OK, "등록"),		
	};
	
	//---------------------------------------------------------------
	// 조회 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_Search[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "조회"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEARCH_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_TYPE , "구분"),
		DLG_COMBO( STARTX+220, STARTY- 29,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_TYPE, 5), // 구분
		
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_ADDR_TYPE , "주소타입"),
		DLG_COMBO( STARTX+220, STARTY+ 31,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_ADDR_TYPE, 5), // 주소
		
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_USE_CONT , "사용\n계약번호"),
		DLG_EDIT ( STARTX+220, STARTY+ 31,  780, 69, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR    , PDAEDTCTRLBK  , EDT_SEARCH_USE_CONT_NUM, 11,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_CITY2 , "시/구"),
		DLG_COMBO( STARTX+220, STARTY+ 31,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_CITY2, 5), // 시/구
		
		DLG_TEXT ( STARTX,     STARTY+ 91,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_CITY , "시/구"),
		DLG_COMBO( STARTX+220, STARTY+ 91,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_CITY, 5), // 시/구
		
		DLG_TEXT ( STARTX,     STARTY+ 91,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR, TXTCTRLBK, ST_SEARCH_PHONE, "전화번호"),
		DLG_COMBO (STARTX+220, STARTY+ 91,  290, 60, 115, 60, TXTFRCOLOR, PDAEDTCTRLBK    , CALL_FUNC, "", CMB_SEARCH_PHONE_DDD, 5), // DDD
		DLG_TEXT ( STARTX+510, STARTY+ 91,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_SEARCH_PHONE_EXN, "-"),
		DLG_EDIT ( STARTX+565, STARTY+ 91,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_SEARCH_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+755, STARTY+ 91,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_SEARCH_PHONE_NUM, "-"),
		DLG_EDIT ( STARTX+810, STARTY+ 91,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_SEARCH_PHONE_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,     STARTY +91,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_NAME , "성명"),
		DLG_BUTTON(STARTX+220, STARTY +91,  780, 60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER  , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEARCH_WRITE_NAME,  ""),
		DLG_EDIT ( STARTX+220, STARTY +91,  780, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR    , PDAEDTCTRLBK  , EDT_SEARCH_NAME, 11,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+151,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_ADDR , "검색"),
		
		DLG_BUTTON(STARTX+220, STARTY+151,  580, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER  , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEARCH_WRITE_ADDR,  ""),
		DLG_EDIT ( STARTX+220, STARTY+151,  580, 59, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_SEARCH_ADDR, 50,  ""),
		
		DLG_BUTTON(STARTX+800, STARTY+151,  200, 60, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_CLEAR, "초기화"),
		
		DLG_TEXT ( STARTX,     STARTY+211, 1000, 60, 0, 0, 0, EDITSTY_BORDER              , TXTFRCOLOR    , TXTINCTRLBK   , TXT_SEARCH_ADDR_EX , "예: 은평터널 111-105 대림"),
		
		DLG_BUTTON(STARTX,     STARTY+271, 1000, 60, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH, "검 색"),
		
		DLG_LINE ( STARTX,     STARTY+335, 1000, STARTY+335, DARKSLATEBLUE, 10, LINE_DATA5),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_SEARCH_TBLLIST, m_szTableBuf),
		
		DLG_BUTTON(STARTX+250, STARTY+339,  550, 55, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, TABCOLOR4, CALL_FUNC, "", BID_SEARCH_ADDR_CHG, "주소"),
		
		DLG_LINE ( STARTX,     STARTY+836, 1000, STARTY+836, DARKSLATEBLUE, 10, LINE_DATA6),
		
		DLG_BUTTON(STARTX,     STARTY+840,  330, 59, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_PAGE, m_szCnt_Search_page),
		DLG_BUTTON(STARTX+330, STARTY+840,  330, 59, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_UP, "▲"),
		DLG_BUTTON(STARTX+660, STARTY+840,  340, 59, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_DOWN, "▼"),
		
		//숫자 자판
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY  , ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "←"),	
	};
	
	//---------------------------------------------------------------
	// 실사용자 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_RealUser[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "실사용자"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR, TXTCTRLBK, ST_REAL_HP, "HP"),
		DLG_TEXT ( STARTX+220, STARTY- 29,  780, 60, 0, 0, 0, EDITSTY_BORDER              , TXTFRCOLOR    , TXTINCTRLBK   , TXT_REAL_HP, ""),
		 
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR, TXTCTRLBK, ST_REAL_USER, "실사용자"),
		DLG_COMBO (STARTX+220, STARTY+ 31,  290, 60, 115, 60, TXTFRCOLOR, PDAEDTCTRLBK    , CALL_FUNC, "", CMB_REAL_PHONE_DDD, 5), // DDD
		DLG_TEXT ( STARTX+510, STARTY+ 31,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_REAL_EXN, "-"),
		DLG_EDIT ( STARTX+565, STARTY+ 31,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_REAL_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+755, STARTY+ 31,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_REAL_NUM, "-"),
		DLG_EDIT ( STARTX+810, STARTY+ 31,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_REAL_PHONE_NUM, 4,  ""),
		
		DLG_LINE ( STARTX,     STARTY+ 94, 1000, STARTY+94, DARKSLATEBLUE, 10, LINE_DATA7),
		
		DLG_BUTTON(STARTX,     STARTY+ 97,  330, 80, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_POPUP_CLOSE, "취소"),
		DLG_BUTTON(STARTX+330, STARTY+ 97,  330, 80, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REAL_SAVE, "변경"),
		DLG_BUTTON(STARTX+660, STARTY+ 97,  340, 80, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REAL_SMS, "SMS"),
		
		//숫자 자판
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY  , ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "←"),
	};
	
	//---------------------------------------------------------------
	// 요금내역 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_ChargeHist[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "요금내역"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TABLE (GRID_X2, GRID_Y2, ROW2, COL2, 0, GRID_H2, 1, GRID_H2, SEL_ROW, MAXCHAR2, m_stGridTitle2, ID_CHARGE_TBLLIST, m_szTableBuf2),
		
		DLG_LINE ( STARTX,     STARTY+ 815, 1000, STARTY+815, DARKSLATEBLUE, 10, LINE_DATA8),
		
		DLG_TEXT ( STARTX,     STARTY+ 820,  330, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CHARGE_PAGE, m_szCnt_Charge_page),
		
		DLG_BUTTON(STARTX+330, STARTY+ 820,  330, 79, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHARGE_UP, "▲"),
		DLG_BUTTON(STARTX+660, STARTY+ 820,  340, 79, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHARGE_DOWN, "▼"),
	};
	
	//---------------------------------------------------------------
	// 방문내역 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_VisitHist[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "방문 내역"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TABLE (GRID_X3, GRID_Y3, ROW3, COL3, 0, GRID_H3, 1, GRID_H_H3, SEL_ROW, MAXCHAR3, m_stGridTitle3, ID_VISIT_TBLLIST, m_szTableBuf3),
		
		DLG_LINE ( STARTX,     STARTY+ 815, 1000, STARTY+815, DARKSLATEBLUE, 10, LINE_DATA9),
		
		DLG_TEXT ( STARTX,     STARTY+ 819,  330, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_VISIT_PAGE, m_szCnt_Visit_page ),
		
		DLG_BUTTON(STARTX+330, STARTY+ 819,  330, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_VISIT_UP, "▲"),
		DLG_BUTTON(STARTX+660, STARTY+ 819,  340, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_VISIT_DOWN, "▼"),
	};
	
	//---------------------------------------------------------------
	// 메모 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_Memo[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "이동 고객센터 메모"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_BUTTON( STARTX,		STARTY- 29, 1000, 820, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MEMO_WRITE,  ""),	
		DLG_TEXT  ( STARTX,		STARTY- 29, 1000, 820, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_MEMO,  ""),
		
		DLG_LINE ( STARTX,     STARTY+ 796, 1000, STARTY+796, DARKSLATEBLUE, 10, LINE_DATA10),
		
		DLG_BUTTON( STARTX,		STARTY+800,  333, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE,  "취소"),
		DLG_BUTTON( STARTX+333, STARTY+800,  333, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO_DEL,   "삭제"),	
		DLG_BUTTON( STARTX+666, STARTY+800,  334, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO_SAVE,  "저장"),	
	};
	
	//---------------------------------------------------------------
	// 발송등록 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_BillSendMethod[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "발송등록"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,   220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_BILL_SEND_REQ_NM, "신청자"),
		
		DLG_BUTTON(STARTX+220, STARTY- 29,   780, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BILL_SEND_REQ_NM_WRITE,  ""),
		DLG_EDIT ( STARTX+220, STARTY- 29,   780, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_REQ_NM, 50,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+ 31,   220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_BILL_SEND_PHONE, "핸드폰"),
		
		DLG_COMBO (STARTX+220, STARTY+ 31,   290, 59, 115, 59, TXTFRCOLOR, PDAEDTCTRLBK   , CALL_FUNC, "", CMB_BILL_SEND_PHONE_DDD, 5), // DDD
		DLG_TEXT ( STARTX+510, STARTY+ 31,    55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_BILL_SEND_EXN, "-"),
		DLG_EDIT ( STARTX+565, STARTY+ 31,   190, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+755, STARTY+ 31,    55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_BILL_SEND_NUM, "-"),
		DLG_EDIT ( STARTX+810, STARTY+ 31,   190, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_PHONE_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+ 91,   220, 120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_BILL_SEND_EMAIL1, "이메일"),
		
		DLG_BUTTON(STARTX+220, STARTY+ 91,   662, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BILL_SEND_EMAIL_WRITE,  ""),
		DLG_EDIT ( STARTX+220, STARTY+ 91,   662, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_EMAIL, 50,  ""),
		DLG_TEXT ( STARTX+882, STARTY+ 91,   118, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_BILL_SEND_EMAIL2, "@"),
		
		DLG_BUTTON(STARTX+220, STARTY+ 151,  662, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BILL_SEND_EMAIL_WRITE2,  ""),
		DLG_EDIT ( STARTX+220, STARTY+ 151,  662, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_EMAIL2, 50,  ""),
		DLG_COMBO (STARTX+882, STARTY+ 151,  118, 60, 118, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BILL_SEND_EMAIL, 20), // 이메일
		
		DLG_LINE ( STARTX,     STARTY+ 215, 1000, STARTY+215, DARKSLATEBLUE, 10, LINE_DATA11),
		
		DLG_BUTTON(STARTX,     STARTY+ 220,  500, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_POPUP_CLOSE, "취소"),
		DLG_BUTTON(STARTX+500, STARTY+ 220,  500, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_BILL_SEND_SAVE, "등록"),
		
		//숫자 자판
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY  , ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "←"),
	};
	
	//---------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------
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
			/********************************/
			/* 이동고객센터_메인            */
			/********************************/
			case INIT_MAIN:
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				if( m_lInitRedraw == 0 )
				{
					if( m_lSearch_Move_flag == 0)
					{
						Snd_FR90001(g_szMC_InstPlaceNum);
					}
					else
					{
						Snd_FR90001(m_szInst_Place_Num);
					}
				}
				else
				{
					ReDraw();
				}
				
				break;
				
			/********************************/
			/* 이동고객센터_조회            */
			/********************************/
			case INIT_SEARCH:
				CREATE_DIALOG_OBJECT (DlgRes_Search, SIZEOF(DlgRes_Search));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
				TableDraw_Search(m_lSearch_Addr_Chg);
				break;
				
			/********************************/
			/* 이동고객센터_실사용자        */
			/********************************/
			case INIT_REALUSER:
				CREATE_DIALOG_OBJECT (DlgRes_RealUser, SIZEOF(DlgRes_RealUser));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
				
				break;
				
			/********************************/
			/* 이동고객센터_요금내역        */
			/********************************/	
			case INIT_CHARGEHIST:
				CREATE_DIALOG_OBJECT (DlgRes_ChargeHist, SIZEOF(DlgRes_ChargeHist));
					
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				TableDraw_ChargeHist();
				
				break;
				
			/********************************/
			/* 이동고객센터_방문내역        */
			/********************************/
			case INIT_VISITHIST:
				CREATE_DIALOG_OBJECT (DlgRes_VisitHist, SIZEOF(DlgRes_VisitHist));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				TableDraw_VisitHist();
				
				break;
					
			/********************************/
			/* 이동고객센터_메모            */
			/********************************/
			case INIT_MEMO:
				CREATE_DIALOG_OBJECT (DlgRes_Memo, SIZEOF(DlgRes_Memo));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				break;
			
			/********************************/
			/* 이동고객센터_발송등록        */
			/********************************/	
			case INIT_BILL_SEND_METHOD:
				CREATE_DIALOG_OBJECT (DlgRes_BillSendMethod, SIZEOF(DlgRes_BillSendMethod));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
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
		char szTmp[2000];
		
		switch(ID)
		{
			/****************************/
			/* 이동고객센터_메인        */
			/****************************/
			// 뒤로 가기, 취소
			case BID_CLOSE:
				if( m_lSearch_Move_flag == 0 )
				{
					Clear_Data();
					Back_Move_Card();
				}
				else
				{	
					Clear_RsltData();
					ON_EXIT();
					OnInit(INIT_SEARCH);
				}
				break;
			
			// 조회
			case BID_INQUIRY:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_SEARCH);
				break;
			
			// HP/TEL
			case BID_REAL_HP_TEL:
				// HP = 0, tel = 1, real = 2
				if( m_lReal_hp_tel == 0 )
				{
					m_lReal_hp_tel = 1;
				}
				else if( m_lReal_hp_tel == 1)
				{
					m_lReal_hp_tel = 2;
				}
				else
				{
					m_lReal_hp_tel = 0;
				}
				
				Save_Main_Combo();
				
				ReDraw();
				break;
			
			// 변경
			case BID_HP_CHG:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_REALUSER);
				break;
			
			// SMS
			case BID_HP_SMS:
				Snd_FR90007();
				break;
			
			// 미납개월 상세
			case BID_UNPAY_MONTH:
				Save_Main_Combo();
				Snd_FR90002();
				break;
			
			// 발송방법 상세	
			case BID_BILL_SEND_METHOD_DTL:
			    Set_Bill_Alarm();
			    break;
			
			// 납부방법 상세  
			case BID_PAY_METHOD_DTL:
				Set_Pay_Alarm();
				break;
			
			// 방문 일자
			case BID_VISIT:
				Save_Main_Combo();
				Snd_FR90003();
				break;
			
			// 메모
			case BID_MEMO:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_MEMO);
				break;
			
			// 콤보 발송방법
			case BID_CMB_BILL_SEND_METHOD:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_BILL_SEND_METHOD);
				break;
			
			// 등록
			case BID_OK:
				if( m_lBldOk_flag == 0 )
				{
					Snd_FR90004();
				}
				else if( m_lBldOk_flag == 1 )
				{
					Save_Main_Combo();
					ON_EXIT();
					OnInit(INIT_BILL_SEND_METHOD);
				}
				
				break;
			
			// 결과버튼
			case BID_RSLT:
				MessageBoxEx (CONFIRM_OK, stMcMainInfo.VISIT_ETC);
				break;
			
			/********************************/
			/* 이동고객센터_조회            */
			/********************************/
			// 조회
			case BID_SEARCH:
				m_lSearch_page = 0;
				
				Snd_FR90006();
				
				break;
			
			// 조회 UP
			case BID_SEARCH_UP:
				m_lSearch_page--;
				
				if(m_lSearch_page < 0)
				{
					m_lSearch_page = 0;
				}
				
				TableDraw_Search(m_lSearch_Addr_Chg);
				
				break;
			
			// 조회 DOWN
			case BID_SEARCH_DOWN:
				m_lSearch_page++;
				if( m_lSearch_page > m_lSearch_Totpage-1 )
				{
					m_lSearch_page = m_lSearch_Totpage-1;
				}	
				
				TableDraw_Search(m_lSearch_Addr_Chg);
				
				break;
			
			// 주소 CHG
			case BID_SEARCH_ADDR_CHG:
				
				if( m_lSearch_Addr_Chg == 0 )
				{
					m_lSearch_Addr_Chg = 1;
				}
				else
				{
					m_lSearch_Addr_Chg = 0;
				}
				
				TableDraw_Search(m_lSearch_Addr_Chg);
				break;
				
			// 조회 초기화
			case BID_SEARCH_CLEAR:
				if( MessageBoxEx (CONFIRM_YESNO, "검색 내용을 초기화 하시겠습니까?") == MB_OK)
				{
					Mem_Set((byte*)stMcSearch.SEARCH_KEYWORD, 0x00, sizeof(stMcSearch.SEARCH_KEYWORD));
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR), "");
				}
				
				break;
				
			// 조회 검색 입력
			case BID_SEARCH_WRITE_ADDR:
			
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_SEARCH_ADDR), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR)) );
				break;
			
			// 조회 성명 입력
			case BID_SEARCH_WRITE_NAME:
			
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_SEARCH_NAME), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_NAME)) );
				break;
			
			// 조회 페이지
			case BID_SEARCH_PAGE:
				Quick_View_Search();
				break;
			
			// 조회 닫기
			case BID_SEARCH_CLOSE:
				if( m_lSearch_Move_flag == 0)
				{
					m_lInitRedraw = 1;
					ON_EXIT();
					OnInit(INIT_MAIN);				
				}
				else
				{
					m_lSearch_Move_flag = 0;
					Clear_Data();
					Snd_FR90001(g_szMC_InstPlaceNum);
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				
				break;
			
			/********************************/
			/* 이동고객센터_실사용자        */
			/********************************/
			// 실사용자 저장
			case BID_REAL_SAVE:
				Snd_FR90005();
				break;
			
			// 실사용자 SMS
			case BID_REAL_SMS:
				Snd_FR90007();
				break;
			
			/********************************/
			/* 이동고객센터_요금내역        */
			/********************************/
			// 요금 UP
			case BID_CHARGE_UP:
				m_lCharge_page--;
				
				if(m_lCharge_page < 0)
				{
					m_lCharge_page = 0;
				}
				
				TableDraw_ChargeHist();
				break;
			
			// 요금 DOWN
			case BID_CHARGE_DOWN:
				m_lCharge_page++;
				if( m_lCharge_page > m_lCharge_Totpage-1 )
				{
					m_lCharge_page = m_lCharge_Totpage-1;
				}	
				
				TableDraw_ChargeHist();
				break;
			
			/********************************/
			/* 이동고객센터_방문내역        */
			/********************************/
			// 방문 UP	
			case BID_VISIT_UP:
				m_lVisit_page--;
				
				if(m_lVisit_page < 0)
				{
					m_lVisit_page = 0;
				}
				
				TableDraw_VisitHist();
				break;
				
			// 방문 DOWN
			case BID_VISIT_DOWN:
				m_lVisit_page++;
				
				if( m_lVisit_page > m_lVisit_Totpage-1 )
				{
					m_lVisit_page = m_lVisit_Totpage-1;
				}	
				
				TableDraw_VisitHist();
				break;

			/********************************/
			/* 이동고객센터_메모            */
			/********************************/
			// 메모 입력
			case BID_MEMO_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_MEMO), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO)) );
				break;
			
			// 메모 저장
			case BID_MEMO_SAVE:
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO)) );
				Save_Memo(szTmp);
				ReDraw();
				
				MessageBoxEx(CONFIRM_OK, "저장되었습니다.");
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			// 메모 삭제	
			case BID_MEMO_DEL:
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), "");
				Save_Memo(szTmp);
				ReDraw();
				
				MessageBoxEx(CONFIRM_OK, "삭제되었습니다.");
				break;
				
			/********************************/
			/* 이동고객센터_발송등록        */
			/********************************/
			// 발송등록 저장
			case BID_BILL_SEND_SAVE:
				
				if( Validation() )
				{	
					Save_BillSend_Method();
					
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				
				break;
				
			// 발송등록 신청자명
			case BID_BILL_SEND_REQ_NM_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM)) );
				break;
			
			// 발송등록 메일
			case BID_BILL_SEND_EMAIL_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL)) );
				break;
				
			// 발송등록 메일2
			case BID_BILL_SEND_EMAIL_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2)) );
				break;
			
			/****************************/
			/* 공통                     */
			/****************************/
			// 닫기, 뒤로가기
			case BID_POPUP_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
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
		long index = -1;
		char szMsg[100];
		char szTmp[100];
		char szTmp2[100];
		char szTmp3[100];
		char szTmp4[100];
		long i;
		
		m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);			 
		
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD+1) )
			{
				SetCombo_Filter();
				ReDraw();
			}
		}
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_SEARCH_TYPE+1) )
			{
				SetCombo_Filter();
			}
			else if(DlgTbl_IsSelect(ID_SEARCH_TBLLIST))
			{
				if( g_Dlgflag == 0 )
				{
					return;
				}
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_SEARCH_TBLLIST);
				
				if( m_lAIarmIndex == index - 1 )
				{
					Mem_Set((byte*)m_szInst_Place_Num, 0x00, sizeof(m_szInst_Place_Num));
					Str_Cpy(m_szInst_Place_Num, DlgTbl_GetStr( ID_SEARCH_TBLLIST, m_lAIarmIndex, 3 ) );
					
					Clear_RsltData();
					
					m_lInitRedraw = 0;
					m_lSearch_Move_flag = 1;
					
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else
				{	
					m_lAIarmIndex = index - 1;
				}
			}
		}
		/********************************/
		/* 이동고객센터_요금내역        */
		/********************************/
		else if( m_bFirst == INIT_CHARGEHIST )
		{
			if (DlgTbl_IsSelect(ID_CHARGE_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_CHARGE_TBLLIST);
				
				if( m_lAIarmIndex == index - 1 )
				{
					if( Str_Cmp( DlgTbl_GetStr( ID_CHARGE_TBLLIST, m_lAIarmIndex, 4 ), "미납") != 0 )
					{
						Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
						Str_Cpy( szMsg, "납부일자 : " );
						
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
						Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
						Mem_Set((byte*)szTmp4, 0x00, sizeof(szTmp4));
						
						Str_Cpy( szTmp, DlgTbl_GetStr( ID_CHARGE_TBLLIST, m_lAIarmIndex, 6 ) );
						
						Mem_Cpy( (byte*)szTmp2, (byte*)szTmp, 4 );
						Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+4 , 2 );
						Mem_Cpy( (byte*)szTmp4, (byte*)szTmp+6 , 2 );
						
						Str_Cat( szMsg, szTmp2 );
						Str_Cat( szMsg, "년 " );
						Str_Cat( szMsg, szTmp3 );
						Str_Cat( szMsg, "월 " );
						Str_Cat( szMsg, szTmp4 );
						Str_Cat( szMsg, "일" );
						
						Str_Cat( szMsg, "\n납부방법 : " );
						Str_Cat( szMsg, DlgTbl_GetStr( ID_CHARGE_TBLLIST, m_lAIarmIndex, 5 ) );
					
						MessageBoxEx (CONFIRM_OK, szMsg);
					}
				}
				else
				{	
					m_lAIarmIndex = index - 1;
				}
			}
		}
		/********************************/
		/* 이동고객센터_방문내역        */
		/********************************/
		else if( m_bFirst == INIT_VISITHIST )
		{
			if (DlgTbl_IsSelect(ID_VISIT_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_VISIT_TBLLIST);
				
				if( m_lAIarmIndex == index - 1 )
				{
					if( Str_Cmp( DlgTbl_GetStr( ID_VISIT_TBLLIST, m_lAIarmIndex, 3 ), "") != 0 )
					{
						Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
						Str_Cat( szMsg, DlgTbl_GetStr( ID_VISIT_TBLLIST, m_lAIarmIndex, 3 ) );
					
						MessageBoxEx (CONFIRM_OK, szMsg);
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "메모 없음");
					}
				}
				else
				{	
					m_lAIarmIndex = index - 1;
				}
			}
		}
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL+1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
				Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL) ) );
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2),  szTmp);
			}
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : OnPointing
	기  능 : 화면 포인팅 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
			
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{	
			/********************************/
			/* 이동고객센터_조회            */
			/********************************/
			if( m_bFirst == INIT_SEARCH )
			{
				if( X > DMS_X(STARTX+220) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+100) 
				 || X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755) && Y > DMS_Y(STARTY+91) && Y < DMS_Y(STARTY+151)
				 || X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+91) && Y < DMS_Y(STARTY+151) )
				{	
					if( Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM) == lActiveIndex 
					 || Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN) == lActiveIndex
					 || Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), TRUE );
					}
				}
				else
				{	
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{	
						g_Dlgflag = 1;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), FALSE );
					}
				}
			}
			/********************************/
			/* 이동고객센터_실사용자        */
			/********************************/
			else if( m_bFirst == INIT_REALUSER )
			{
				if( X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) 
				 || X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) )
				{	
					if( Get_iDlgCtrlByID(EDT_REAL_PHONE_EXN) == lActiveIndex
					 || Get_iDlgCtrlByID(EDT_REAL_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
					}
				}
				else
				{	
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{	
						g_Dlgflag = 1;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
					}
				}
			}
			/********************************/
			/* 이동고객센터_발송등록        */
			/********************************/
			else if( m_bFirst == INIT_BILL_SEND_METHOD )
			{
				if( X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) 
				 || X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) )
				{	
					if( Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN) == lActiveIndex
					 || Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
					}
				}
				else
				{	
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{	
						g_Dlgflag = 1;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
					}
				}
			}	
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : OnChar
	기  능 : 전화번호 칸 자동으로 넘어가게 함
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		long lActiveIndex = -1;
		char szTmp[100];
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		if( m_bFirst == INIT_SEARCH )
		{
			if( Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM) == lActiveIndex )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM)));
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				
				if( Str_Len(szTmp) == 5 )
				{
					Str_Cat(szTmp, "-");
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), szTmp);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_EXN))) == 4 )
			{
				lActiveIndex = Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM);
				Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
			}
		}
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			if( Get_iDlgCtrlByID(EDT_REAL_PHONE_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN))) == 4 )
			{
				lActiveIndex = Get_iDlgCtrlByID(EDT_REAL_PHONE_NUM);
				Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
			}	
		}
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/	
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			if( Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN))) == 4 )
			{
				lActiveIndex = Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM);
				Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
			}
		}
	}
	
	//---------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage( Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE );
	}
	
	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{	
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_USE_CONT_NUM)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USE_CONT_NUM)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USE_CONT_DOC)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PHONE_NUM)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DEADLINE)   		 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DEADLINE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_GMTR_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMTR_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_PAY_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_METHOD) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_UNPAY_MONTH)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_UNPAY_AMT)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_VISIT_TYPE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_YMD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_TYPE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_RESULT)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_REFUSE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_PAY_METHOD)	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_SELF_GMTR)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_USE_CONT)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_REFUSE)   		 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PAY_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELF_GMTR)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_USE_CONT)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_RESULT)    	, EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_VISIT_RESULT) 	, TRUE, 2, EDITSEP_NONE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
		}
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		else if ( m_bFirst == INIT_SEARCH )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_TYPE)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_ADDR_TYPE)	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_CITY)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_CITY2)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_ADDR)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_USE_CONT) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_NAME) 		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_PHONE) 		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_PHONE_EXN) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_PHONE_NUM) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEARCH_ADDR_EX) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_TYPE)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_CITY)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_CITY2)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD)	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(ST_SEARCH_USE_CONT), TRUE, 2, EDITSEP_NONE );
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			
			// 숫자판
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
		}
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		else if ( m_bFirst == INIT_REALUSER )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_HP)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REAL_HP)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_USER)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_EXN)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_NUM)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			// 숫자판
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
		}
		/********************************/
		/* 이동고객센터_요금내역        */
		/********************************/
		else if ( m_bFirst == INIT_CHARGEHIST )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHARGE_PAGE)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		}
		/********************************/
		/* 이동고객센터_방문내역        */
		/********************************/
		else if ( m_bFirst == INIT_VISITHIST )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_PAGE)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		}
		/********************************/
		/* 이동고객센터_메모            */
		/********************************/
		else if ( m_bFirst == INIT_MEMO )
		{
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_MEMO), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetEditableMode( Get_hDlgCtrlByID(EDT_MEMO), EDITMODE_HANGUL );
			EditCtrl_SetMaxChar(Get_hDlgCtrlByID(EDT_MEMO), 1000);
		}
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/
		else if ( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_REQ_NM)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_PHONE)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_EXN)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_NUM)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_EMAIL1)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_EMAIL2)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL)   		, EDITALIGN_MIDDLE );
			
			// 숫자판
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
			
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL2), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL+1), FALSE);	
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL2), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE2), FALSE);
			}
			else if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL1), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL2), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL), TRUE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL+1), TRUE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL2), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE2), TRUE);
			}	
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
		
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// 발송방법
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD+2 ) );
			
			for ( i = 0 ;  MC_BILL_SEND_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD+2), MC_BILL_SEND_METHOD[i].Str, 0, ICON_NONE);
			}

			// 거부
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_REFUSE+2 ) );
			
			for ( i = 0 ;  MC_REFUSE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_REFUSE+2), MC_REFUSE[i].Str, 0, ICON_NONE);
			}
			
			// 납부방법
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_PAY_METHOD+2 ) );
			
			for ( i = 0 ;  MC_PAY_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PAY_METHOD+2), MC_PAY_METHOD[i].Str, 0, ICON_NONE);
			}
			
			// 자가검침
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SELF_GMTR+2 ) );
			
			for ( i = 0 ;  MC_SELF_GMTR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELF_GMTR+2), MC_SELF_GMTR[i].Str, 0, ICON_NONE);
			}
			
			// 사용계약
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_USE_CONT+2 ) );
			
			for ( i = 0 ;  MC_USE_CONT[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_USE_CONT+2), MC_USE_CONT[i].Str, 0, ICON_NONE);
			}
		}
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			// 구분
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "주소", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "사용계약번호", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "전화번호", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "성명", 0, ICON_NONE);
			
			// 주소 구분
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+2), "지번", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+2), "도로명", 0, ICON_NONE);
			
			// 시/구
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_CITY2+2 ) );
			for ( i = 0 ;  MC_NEW_ADDR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_CITY2+2), MC_NEW_ADDR[i].Str, 0, ICON_NONE);
			}
			
			// 전화번호
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD+2 ) );
			for ( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
		}
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			//핸드폰
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD+2 ) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_REAL_PHONE_DDD+2);
		}
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			//핸드폰
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD+2 ) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_BILL_SEND_PHONE_DDD+2);
			
			//메일주소
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL+2 ) );
			for ( i = 0 ;  MC_EMAIL_ADDR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL+2), MC_EMAIL_ADDR[i].Str, 0, ICON_NONE);
			}
		}
	}
	
	/*=======================================================================================
	함수명 : ReDraw
	기  능 : 화면을 다시 그린다.
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{	
	 	char szTmp[100];
	 	char szTmp2[100];
	 	char szTmp3[100];
	 	long i;
	 	
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			/********* 사용계약번호 *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
			Mem_Cpy( (byte*)szTmp, (byte*)stMcMainInfo.USE_CONT_NUM , 5 );
			Mem_Cpy( (byte*)szTmp2, (byte*)stMcMainInfo.USE_CONT_NUM+5 , 5 );
			
			Str_Cpy(szTmp, szTmp);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, szTmp2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_USE_CONT_NUM), szTmp );
			
			/********* 사용계약서 작성 여부 *********/
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_USE_CONT_DOC), stMcMainInfo.USE_CONT_DOC_YN );
			
			/********* HP OR TEL / SMS버튼 *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			// HP
			if( m_lReal_hp_tel == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_REAL_HP_TEL), "HP");
				
				Str_Cpy( szTmp, stMcMainInfo.CP_DDD);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.CP_EXN);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.CP_NUM);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), FALSE );
			}
			// TEL
			else if( m_lReal_hp_tel == 1 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_REAL_HP_TEL), "TEL");
				
				Str_Cpy( szTmp, stMcMainInfo.OWNHOUSE_TEL_DDD);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.OWNHOUSE_TEL_EXN);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.OWNHOUSE_TEL_NUM);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), TRUE );	
			}
			// REAL
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_REAL_HP_TEL), "실사용");
				
				Str_Cpy( szTmp, stMcMainInfo.REAL_CP_DDD);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.REAL_CP_EXN);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.REAL_CP_NUM);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), FALSE );
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_PHONE_NUM), szTmp);
			
			/********* 마감일 *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			Str_Cpy( szTmp, stMcMainInfo.DEADLINE_FLAG);
			Str_Cat( szTmp, "납기" );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DEADLINE), szTmp);
			
			/********* 검침방법 *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_GMTR_METHOD), stMcMainInfo.GMTR_METHOD_NM);
			
			/********* 발송방법 *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_BILL_SEND_METHOD), stMcMainInfo.BILL_SEND_METHOD_NM);
			
			/********* 발송방법 상세 *********/
			if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "10") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), FALSE );
			}
			
			/********* 납부방법 상세 *********/
			if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "10") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), FALSE );
			}
			
			/********* 납부방법 *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_PAY_METHOD), stMcMainInfo.PAY_METHOD_NM);
			
			/********* 미납개월 *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			Str_Cpy( szTmp, stMcMainInfo.UNPAY_MONTH);
			Str_Cat( szTmp, "개월" );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_UNPAY_MONTH), szTmp);
			
			/********* 미납금액 *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			Str_Cpy( szTmp, stMcMainInfo.UNPAY_AMT);
			Str_Chg( szTmp, STRCHG_INS_COMMA );
			Str_Cat( szTmp, "원" );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_UNPAY_AMT), szTmp);
			
			/********* 방문버튼 *********/
			if( Str_Cmp( stMcMainInfo.VISIT_YMD, "" ) == 0 )
			{
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), FALSE );
			}
			
			/********* 방문일자 *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Mem_Cpy((byte*)szTmp, (byte*)stMcMainInfo.VISIT_YMD, 4);
			Str_Cat(szTmp, "-");
			
			Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
			Mem_Cpy((byte*)szTmp2, (byte*)stMcMainInfo.VISIT_YMD+4, 2);
			Str_Cat(szTmp, szTmp2);
			Str_Cat(szTmp, "-");
			
			Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
			Mem_Cpy((byte*)szTmp3, (byte*)stMcMainInfo.VISIT_YMD+6, 2);
			Str_Cat(szTmp, szTmp3);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_VISIT_YMD), szTmp);
			
			/********* 구분 *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_VISIT_TYPE), stMcMainInfo.VISIT_TYPE_NM);
			
			/********* 결과버튼 *********/
			if( Str_Cmp( stMcMainInfo.VISIT_ETC, "") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), FALSE );
			}
			
			/********* 결과 *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_VISIT_RESULT), stMcMainInfo.VISIT_RESULT);
				
			/********* 발송방법 버튼 색상 *********/
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20") == 0 ) // LMS
			{
				if( Str_Cmp(stMcMainRslt.REQ_NM, "") != 0 
				 && Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") != 0 )
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);	
					
					m_lBldOk_flag = 0;
				}
				else
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);
					
					m_lBldOk_flag = 1;
				}	
			}
			else if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30") == 0 ) // EMAIL
			{
				if( Str_Cmp(stMcMainRslt.REQ_NM, "") != 0 
				 && Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_EMAIL, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_EMAIL_ADDR, "") != 0 )
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);	
					
					m_lBldOk_flag = 0;
				}
				else
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);
					
					m_lBldOk_flag = 1;
				}
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);
				
				m_lBldOk_flag = 1;
			}
			
			/********* 메모 버튼 색상 *********/
			if( Str_Cmp(stMcMainRslt.ETC, "") != 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNMENUFRCOLOR);	
			}
			else
			{	
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNMENUFRCOLOR);
			}
			
			/********* 발송방법 콤보박스 *********/	
			if( Str_Cmp(stMcMainRslt.CMB_BILL_SEND_METHOD, "") == 0 )
			{
				if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "10") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "송달");
				}
				else if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "40") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "메일");
				}
				else if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "70") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "LMS");
				}
				else if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "80") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "가스앱");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), stMcMainInfo.BILL_SEND_METHOD_NM);
				}
			}
			else
			{
				i = g_SearchCD( stMcMainRslt.CMB_BILL_SEND_METHOD, MC_BILL_SEND_METHOD );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), MC_BILL_SEND_METHOD[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_REFUSE, MC_REFUSE );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), MC_REFUSE[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_PAY_METHOD, MC_PAY_METHOD );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), MC_PAY_METHOD[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_SELF_GMTR, MC_SELF_GMTR );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), MC_SELF_GMTR[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_USE_CONT, MC_USE_CONT );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), MC_USE_CONT[i].Str);
				}
			}
			
			SetCombo_Filter();
			
			/********* 등록 버튼 *********/
			// SetCombo_Filter()안에 m_lBldOk_flag 로직이 있으므로 SetCombo_Filter() 이후 등록 버튼 로직이 있어야함
			if( m_lBldOk_flag == 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_OK), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_OK), BTNMENUFRCOLOR);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_OK), "등록");
			}
			else if( m_lBldOk_flag == 1 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_OK), GREEN);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_OK), BTNMENUFRCOLOR);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_OK), "발송등록");
			}
		}
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( Str_Cmp(stMcSearch.SEARCH_TYPE, "주소" ) == 0 )
			{	
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), stMcSearch.SEARCH_ADDR_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY), stMcSearch.SEARCH_CITY);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR), stMcSearch.SEARCH_KEYWORD);
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "사용계약번호" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), stMcSearch.SEARCH_USE_CONT_NUM);
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "전화번호" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY2), stMcSearch.SEARCH_CITY2);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD), stMcSearch.SEARCH_PHONE_DDD);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_EXN), stMcSearch.SEARCH_PHONE_EXN);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_NUM), stMcSearch.SEARCH_PHONE_NUM);
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "성명" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY2), stMcSearch.SEARCH_CITY2);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_NAME), stMcSearch.SEARCH_NAME);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), "사용계약번호");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), "도로명");
			}
			
			SetCombo_Filter();
		}
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, stMcMainInfo.CP_DDD);
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.CP_EXN);
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.CP_NUM);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_REAL_HP), szTmp);
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD), stMcMainInfo.REAL_CP_DDD);
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN), stMcMainInfo.REAL_CP_EXN);
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM), stMcMainInfo.REAL_CP_NUM);
		}
		/********************************/
		/* 이동고객센터_메모            */
		/********************************/
		else if( m_bFirst == INIT_MEMO )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_MEMO), stMcMainRslt.ETC );
		}
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{	
			// 신청자 명
			if( Str_Cmp( stMcMainRslt.REQ_NM, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM), stMcMainRslt.REQ_NM);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM), stMcMainInfo.CUST_NM);
			}
			
			// 핸드폰 DDD
			if( Str_Cmp( stMcMainRslt.REQ_LMS_DDD, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD), stMcMainRslt.REQ_LMS_DDD);
			}
			else
			{
				if( Str_Cmp( stMcMainInfo.REAL_CP_DDD, "") != 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD), stMcMainInfo.REAL_CP_DDD);
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD), stMcMainInfo.CP_DDD);
				}
			}
			
			// 핸드폰 EXN
			if( Str_Cmp( stMcMainRslt.REQ_LMS_EXN, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN), stMcMainRslt.REQ_LMS_EXN);
			}
			else
			{
				if( Str_Cmp( stMcMainInfo.REAL_CP_EXN, "") != 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN), stMcMainInfo.REAL_CP_EXN);
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN), stMcMainInfo.CP_EXN);
				}
			}
			
			// 핸드폰 NUM
			if( Str_Cmp( stMcMainRslt.REQ_LMS_NUM, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM), stMcMainRslt.REQ_LMS_NUM);
			}
			else
			{
				if( Str_Cmp( stMcMainInfo.REAL_CP_NUM, "") != 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM), stMcMainInfo.REAL_CP_NUM);
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM), stMcMainInfo.CP_NUM);
				}
			}
			
			// EMAIL
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL), stMcMainRslt.REQ_EMAIL);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2), stMcMainRslt.REQ_EMAIL_ADDR);
			}
		}
		
		ON_DRAW();
	}
		
	/*=======================================================================================
	함수명 : TableDraw_VisitHist
	기  능 : 방문이력 화면 테이블 Draw
	Param  : 
	Return : 
	========================================================================================*/	
	void TableDraw_VisitHist(void)
	{
		long i, idx;
		long k = 4;
		char szTmp[500];
		char szTmp2[50];
		char szTmp3[50];
		char szTmp4[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		/************************************/
		/* 변수 초기화                      */
		/************************************/
		m_lAIarmIndex = -1;
		
		/************************************/
		/* Page Setting                     */
		/************************************/
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lVisit_Totpage );
		
		if( m_lVisit_Totpage % ROW3 > 0 )
		{
			m_lVisit_Totpage = (m_lVisit_Totpage / ROW3) + 1;
		}
		else
		{
			m_lVisit_Totpage = m_lVisit_Totpage / ROW3;
		}

		Mem_Set( (byte*)m_szCnt_Visit_page, 0x00, sizeof(m_szCnt_Visit_page) );
		SPRINT(m_szCnt_Visit_page, "%d/%d", m_lVisit_page+1, m_lVisit_Totpage, 0);

		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// PARAM1 : visit_ymd, PARAM2 : seq, PARAM3 : visit_type, PARAM4 : visit_result, PARAM5 : visit_etc
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM3, PARAM4, PARAM5 FROM RCV_TMP ORDER BY PARAM1 DESC, PARAM2 DESC LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		
		lstartidx = m_lVisit_page * ROW3;
		
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		
		i = m_lVisit_page * ROW3 + ROW3;
		
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for(i = 0 ; i < ROW3 ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 3, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 3, "" );
					continue;
				}
				
				idx = 0;
				
				// 방문일자
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
				Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
				Mem_Set((byte*)szTmp4, 0x00, sizeof(szTmp4));
				
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				
				Mem_Cpy( (byte*)szTmp2, (byte*)szTmp, 4 );
				Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+4 , 2 );
				Mem_Cpy( (byte*)szTmp4, (byte*)szTmp+6 , 2 );
				
				Str_Cpy(szTmp, szTmp2);
				Str_Cat(szTmp, "년\n");
				Str_Cat(szTmp, szTmp3);
				Str_Cat(szTmp, "월 ");
				Str_Cat(szTmp, szTmp4);
				Str_Cat(szTmp, "일");
				
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 0, szTmp );

				// 구분
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 1, szTmp );
				
				// 결과
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 2, szTmp );
				
				// 메모
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 500, DECRYPT);
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 3, szTmp );
			}
		}
				
Finally:
		DelSqLite(sql);
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : TableDraw_ChargeHist
	기  능 : 요금내역 화면 테이블 Draw
	Param  : 
	Return : 
	========================================================================================*/	
	void TableDraw_ChargeHist(void)
	{
		long i, idx;
		long k = 9;
		char szTmp[200];
		char szTmp2[50];
		char szTmp3[50];
		char szTmp4[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		/************************************/
		/* 변수 초기화                      */
		/************************************/
		m_lAIarmIndex = -1;
		
		/************************************/
		/* Page Setting                     */
		/************************************/
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lCharge_Totpage );
		
		if( m_lCharge_Totpage % ROW2 > 0 )
		{
			m_lCharge_Totpage = (m_lCharge_Totpage / ROW2) + 1;
		}
		else
		{
			m_lCharge_Totpage = m_lCharge_Totpage / ROW2;
		}
		
		Mem_Set( (byte*)m_szCnt_Charge_page, 0x00, sizeof(m_szCnt_Charge_page) );
		SPRINT(m_szCnt_Charge_page, "%d/%d", m_lCharge_page+1, m_lCharge_Totpage, 0);
		
		/************************************/
		/* 테이블 ONDRAW                    */
		/************************************/
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// param1 : requestYm, param2 : indicatorQty, param3 : usageQty
		// param4 : chargeAmt, param5 : paymentFlag, param6 : paymentType, param7 : payDate
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7 FROM RCV_TMP ORDER BY PARAM1 DESC LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		
		lstartidx = m_lCharge_page * ROW2;
		
		sql->Bind(sql, idx++, 'X', &lstartidx, 9, DECRYPT);
		
		i = m_lCharge_page * ROW2 + ROW2;
		
		sql->Bind(sql, idx++, 'X', &i, 9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for(i = 0 ; i < ROW2 ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 6, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 6, "" );
					continue;
				}
				
				idx = 0;
				
				// 청구년월
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
				Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
				
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				
				Mem_Cpy( (byte*)szTmp2, (byte*)szTmp, 4 );
				Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+4 , 2 );
				Str_Cpy(szTmp, szTmp2);
				Str_Cat(szTmp, "\n - ");
				Str_Cat(szTmp, szTmp3);
				
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 0, szTmp );

				// 지침
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				Str_Chg( szTmp, STRCHG_INS_COMMA );
				
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 1, szTmp );
				
				// 사용량
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				Str_Chg( szTmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 2, szTmp );
				
				// 청구금액
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				Str_Chg( szTmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 3, szTmp );
				
				// 납부
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 4, szTmp );
				
				// 납부방법
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 5, szTmp );
				
				// 납부일자
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 6, szTmp );
				
			}
		}
				
Finally:
		DelSqLite(sql);
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : TableDraw_Search
	기  능 : 조회 화면 테이블 Draw
	Param  : flag : 0 = 지번, 1= 도로명
	Return : 
	========================================================================================*/	
	void TableDraw_Search(long flag)
	{
		long i, idx;
		long k = 4;
		char szTmp[1000];
		char szTmp2[100];
		char szTmp3[100];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		/************************************/
		/* 변수 초기화                      */
		/************************************/
		m_lAIarmIndex = -1;
		
		/************************************/
		/* Page Setting                     */
		/************************************/
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_RELEASE", &m_lSearch_Totpage );
		
		if( m_lSearch_Totpage % ROW > 0 )
		{
			m_lSearch_Totpage = ( m_lSearch_Totpage / ROW ) + 1;
		}
		else
		{
			m_lSearch_Totpage = m_lSearch_Totpage / ROW;
		}
		
		Mem_Set( (byte*)m_szCnt_Search_page, 0x00, sizeof(m_szCnt_Search_page) );
		SPRINT(m_szCnt_Search_page, "%d/%d", m_lSearch_page+1, m_lSearch_Totpage, 0);
		
		/************************************/
		/* 테이블 ONDRAW                    */
		/************************************/
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// param1 : inst_place_num, param2 : use_cont_num, param3 : cust_nm, param4 : curr_addr_union, param5 : new_addr_union
		if( flag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SEARCH_ADDR_CHG), "지번주소");
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM4 LIMIT  ?, ? " );
		}
		else if( flag == 1 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SEARCH_ADDR_CHG), "도로명주소");
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM5, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM5 LIMIT  ?, ? " );
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SEARCH_ADDR_CHG), "주소");
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE LIMIT ?, ? " );
		}
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		
		lstartidx = m_lSearch_page * ROW;
		
		sql->Bind(sql, idx++, 'X', &lstartidx, 3, DECRYPT);
		
		i = m_lSearch_page * ROW + ROW;
		
		sql->Bind(sql, idx++, 'X', &i, 3, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for(i = 0 ; i < ROW ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 3, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 3, "" );
					continue;
				}
				
				idx = 0;
				
				// 사용계약
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Mem_Set( (byte*)szTmp2, 0x00, sizeof(szTmp2) );
				Mem_Set( (byte*)szTmp3, 0x00, sizeof(szTmp3) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				
				Mem_Cpy( (byte*)szTmp2, (byte*)szTmp , 5 );
				Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+5 , 5 );
				
				Str_Cpy(szTmp, szTmp2);
				Str_Cat(szTmp, "\n-");
				Str_Cat(szTmp, szTmp3);
				
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 0, szTmp );
				
				// 주소
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 1000, DECRYPT);
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 1, szTmp );

				// 고객명
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 2, szTmp );

				// 설치장소번호
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 3, szTmp );
			}
		}
				
Finally:
		DelSqLite(sql);
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90001
	기  능 : 이동 고객센터 데이터 조회 / FR90001
	Param  : szInst_Place_Num / 설치장소번호
	Return : 
	========================================================================================*/
	void Snd_FR90001(char* szInst_Place_Num)
	{
		char sztmp[32];
		char szUtmp[100];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90001, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  szInst_Place_Num );
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = Rcv_FR90001; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR90001_IN",  "FR90001" , sndbuf, sztmp );	
	}
	
	/*=======================================================================================
	함수명 : Rcv_FR90001
	기  능 : FR90001 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_FR90001(void)
	{
		long ret = 0;
		
		ret = Chk_Json_90001();
		
		g_Sock_Close();
		CloseMessageBox();
		
		if( ret >= 0)
		{
			m_lInitRedraw = 1;
			Set_View_Main_PhoneNum();
			ReDraw();
				
			return 1;
		}
		else
		{
			if( m_lSearch_Move_flag == 0 )
			{
				Back_Move_Card();
			}
			else
			{
				ON_DRAW();
			}
			
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rcv_FR90001
	기  능 : FR90001 전송 결과 파일을 검토한다.
	Param  : 
	Return : 1:정상적인 통신완료, 0: 에러응답or응답형식오류, -1: 알수없는 에러
	========================================================================================*/
	long Chk_Json_90001(void)
	{
		char szJsonpath[500];
		char szMsg[500];
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		char *pStr = NULL;
		char *szCode = NULL;
		char *szMessage = NULL;
		long *nCol = NULL;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 11;
		
		char szTmp[100];
		handle hitem = NULL;
		handle hcnt = NULL;
		
		/* FR90001에서 받아오는 변수 선언 */
		char *szInst_place_num = NULL;
		char *szUse_cont_num = NULL;
		char *szUse_cont_doc_yn = NULL;
		char *szCp_ddd = NULL;
		char *szCp_exn = NULL;
		char *szCp_num = NULL;
		char *szOwnhouse_tel_ddd = NULL;
		char *szOwnhouse_tel_exn = NULL;
		char *szOwnhouse_tel_num = NULL;
		char *szReal_cp_ddd = NULL;
		char *szReal_cp_exn = NULL;
		char *szReal_cp_num = NULL;
		char *szDeadline_flag = NULL;
		char *szGmtr_method_nm = NULL;
		char *szBill_send_method_cd = NULL;
		char *szBill_send_method_nm = NULL;
		char *szPay_method_cd = NULL;
		char *szPay_method_nm = NULL;
		
		char *szReq_cp_ddd = NULL;
		char *szReq_cp_exn = NULL;
		char *szReq_cp_num = NULL;
		char *szReq_email = NULL;
		
		char *szAddr = NULL;
		char *szCust_nm = NULL;
		
		char *szVisit_ymd = NULL;
		char *szVisit_type_nm = NULL;
		char *szVisit_result = NULL;
		char *szVisit_etc = NULL;
		
		char *szUnpay_amt = NULL;
		char *szUnpay_month = NULL;
		
		char *szBnk_nm = NULL;
		char *szDefray_account_num = NULL;
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 90001, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 90001, 0 );
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
		
		for(i = 0; i < fsize - 9; i++ )
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
		
		/********************************/
		/* 정상 Callback                */
		/********************************/
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
		szCode = JSON_GetValue (g_pjcomm, "code", szType);
			szMessage = JSON_GetValue (g_pjcomm, "message", szType);
			
			/* FR90001 데이터 */
			szInst_place_num		= JSON_GetValue (g_pjcomm, "inst_place_num", szType);
			szUse_cont_num 			= JSON_GetValue (g_pjcomm, "use_cont_num", szType);
			szUse_cont_doc_yn 		= JSON_GetValue (g_pjcomm, "use_cont_doc_yn", szType);
			szCp_ddd 				= JSON_GetValue (g_pjcomm, "cp_ddd", szType);
			szCp_exn 				= JSON_GetValue (g_pjcomm, "cp_exn", szType);
			szCp_num 				= JSON_GetValue (g_pjcomm, "cp_num", szType);
			szOwnhouse_tel_ddd 		= JSON_GetValue (g_pjcomm, "ownhouse_tel_ddd", szType);
			szOwnhouse_tel_exn 		= JSON_GetValue (g_pjcomm, "ownhouse_tel_exn", szType);
			szOwnhouse_tel_num		= JSON_GetValue (g_pjcomm, "ownhouse_tel_num", szType);
			szReal_cp_ddd 			= JSON_GetValue (g_pjcomm, "real_cp_ddd", szType);
			szReal_cp_exn 			= JSON_GetValue (g_pjcomm, "real_cp_exn", szType);
			szReal_cp_num 			= JSON_GetValue (g_pjcomm, "real_cp_num", szType);
			szDeadline_flag 		= JSON_GetValue (g_pjcomm, "deadline_flag", szType);
			szGmtr_method_nm 		= JSON_GetValue (g_pjcomm, "gmtr_method_nm", szType);
			szBill_send_method_cd 	= JSON_GetValue (g_pjcomm, "bill_send_method_cd", szType);
			szBill_send_method_nm 	= JSON_GetValue (g_pjcomm, "bill_send_method_nm", szType);
			szPay_method_cd 		= JSON_GetValue (g_pjcomm, "pay_method_cd", szType);
			szPay_method_nm 		= JSON_GetValue (g_pjcomm, "pay_method_nm", szType);
			szReq_cp_ddd			= JSON_GetValue (g_pjcomm, "req_cp_ddd", szType);
			szReq_cp_exn			= JSON_GetValue (g_pjcomm, "req_cp_exn", szType);
			szReq_cp_num			= JSON_GetValue (g_pjcomm, "req_cp_num", szType);
			szReq_email				= JSON_GetValue (g_pjcomm, "req_email", szType);
			szAddr            		= JSON_GetValue (g_pjcomm, "addr", szType);
			szCust_nm			    = JSON_GetValue (g_pjcomm, "cust_nm", szType);
			
			szVisit_ymd 			= JSON_GetValue (g_pjcomm, "visit_ymd", szType);
			szVisit_type_nm 		= JSON_GetValue (g_pjcomm, "visit_type_nm", szType);
			szVisit_result 			= JSON_GetValue (g_pjcomm, "visit_result", szType);
			szVisit_etc 			= JSON_GetValue (g_pjcomm, "visit_etc", szType);
			
			szUnpay_amt			 	= JSON_GetValue (g_pjcomm, "unpay_amt", szType);
			szUnpay_month 			= JSON_GetValue (g_pjcomm, "unpay_month", szType);
			
			szBnk_nm  				= JSON_GetValue (g_pjcomm, "bnk_nm", szType);
			szDefray_account_num  	= JSON_GetValue (g_pjcomm, "defray_account_num", szType);
			/********************************/
			/* 비정상 Callback              */
			/********************************/
			if( Str_Cmp(szCode, "0000") != 0)
			{
			  	char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szMessage) < 500 )
				{
					SQL_ConvMbStr( szMsg, szMessage);
				}
				
				//SPRINT(szJsonpath, "[%s] %s", szCode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szCode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				
				EvtDraw();
				
				ret = -1;
			}
			/********************************/
			/* 정상 Callback                */
			/********************************/
			else
			{
				Mem_Set((byte*)&stMcMainInfo, 0x00, sizeof(stMcMainInfo));
				
				Str_Cpy(stMcMainInfo.INST_PLACE_NUM, szInst_place_num);
				Str_Cpy(stMcMainInfo.USE_CONT_NUM, szUse_cont_num);
				Str_Cpy(stMcMainInfo.USE_CONT_DOC_YN, szUse_cont_doc_yn);
				Str_Cpy(stMcMainInfo.CP_DDD, szCp_ddd);
				Str_Cpy(stMcMainInfo.CP_EXN, szCp_exn);
				Str_Cpy(stMcMainInfo.CP_NUM, szCp_num);
				Str_Cpy(stMcMainInfo.OWNHOUSE_TEL_DDD, szOwnhouse_tel_ddd);
				Str_Cpy(stMcMainInfo.OWNHOUSE_TEL_EXN, szOwnhouse_tel_exn);
				Str_Cpy(stMcMainInfo.OWNHOUSE_TEL_NUM, szOwnhouse_tel_num);
				Str_Cpy(stMcMainInfo.REAL_CP_DDD, szReal_cp_ddd);
				Str_Cpy(stMcMainInfo.REAL_CP_EXN, szReal_cp_exn);
				Str_Cpy(stMcMainInfo.REAL_CP_NUM, szReal_cp_num);
				Str_Cpy(stMcMainInfo.DEADLINE_FLAG, szDeadline_flag);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szGmtr_method_nm);
				Str_Cpy(stMcMainInfo.GMTR_METHOD_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.BILL_SEND_METHOD_CD, szBill_send_method_cd);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szBill_send_method_nm);
				Str_Cpy(stMcMainInfo.BILL_SEND_METHOD_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.PAY_METHOD_CD, szPay_method_cd);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szPay_method_nm);
				Str_Cpy(stMcMainInfo.PAY_METHOD_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.REQ_CP_DDD, szReq_cp_ddd);
				Str_Cpy(stMcMainInfo.REQ_CP_EXN, szReq_cp_exn);
				Str_Cpy(stMcMainInfo.REQ_CP_NUM, szReq_cp_num);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szReq_email);
				Str_Cpy(stMcMainInfo.REQ_EMAIL, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szAddr);
				Str_Cpy(stMcMainInfo.ADDR, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szCust_nm);
				Str_Cpy(stMcMainInfo.CUST_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.VISIT_YMD, szVisit_ymd);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szVisit_type_nm);
				Str_Cpy(stMcMainInfo.VISIT_TYPE_NM, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szVisit_result);
				Str_Cpy(stMcMainInfo.VISIT_RESULT, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szVisit_etc);
				Str_Cpy(stMcMainInfo.VISIT_ETC, szTmp);
				
				Str_Cpy(stMcMainInfo.UNPAY_AMT, szUnpay_amt);
				Str_Cpy(stMcMainInfo.UNPAY_MONTH, szUnpay_month);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szBnk_nm);
				Str_Cpy(stMcMainInfo.BNK_NM, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szDefray_account_num);
				Str_Cpy(stMcMainInfo.DEFRAY_ACCOUNT_NUM, szTmp);
			}
		}
		/********************************/
		/* 비정상 Callback              */
		/********************************/
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
		ON_DRAW();
		
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90002
	기  능 : 요금내역 조회 / FR90002 / RCV_TMP
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90002(void)
	{
		char szUrl[200];
		char szbuf[128];
		char sztmp[128];
		char* sndbuf;
		long ret = 0;
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		// TABLE CLEAR
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		// PARAM SETTING
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90002, FALSE);
		
		// USE_CONT_NUM
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stMcMainInfo.USE_CONT_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90002; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR90002_IN",  "FR90002" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Rcv_FR90002
	기  능 : FR90002 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90002(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90002) >= 0)
		{
			ON_EXIT();
			OnInit(INIT_CHARGEHIST);
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rcv_FR90003
	기  능 : 방문이력 조회 / FR90003 / RCV_TMP
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90003(void)
	{
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		// TABLE CLEAR
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		// PARAM SETTING
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90003, FALSE);
		
		// USE_CONT_NUM
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stMcMainInfo.USE_CONT_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90003;
		ret = HTTP_DownloadData(szUrl, "FR90003_IN",  "FR90003" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Rcv_FR90003
	기  능 : FR90003 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90003(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90003) >= 0)
		{
			ON_EXIT();
			OnInit(INIT_VISITHIST);
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90004
	기  능 : 메인 등록 / FR90004
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90004(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[500];
		char szTmp2[200];
		char* sndbuf;
		long ret = 0;
		
		/************************************************************/
		/* 데이터 저장                                              */
		/************************************************************/
		Save_Main_Combo();
		
		/************************************************************/
		/* Validation                                               */
		/************************************************************/
		if( !Validation() )
		{
			return;
		}
		
		Mem_Set((byte*)stMcMainRslt.REQ_FLAG, 0x00, sizeof(stMcMainRslt.REQ_FLAG));
		
		/*****************************************************************************************/
		/* REQ_FLAG SETTING                                                                      */
		/* 1. 이메일 신규, 2. LMS 신규, 3. 이메일 삭제, 4. LMS 삭제, 5. 이중고지 삭제            */
		/*****************************************************************************************/
		// 송달 -> EMAIL = 신규신청
		if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "10" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 ) 
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "1" ); 
		}
		// 송달 -> LMS = 신규신청
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "10" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "2" ); 
		}
		// EMAIL -> 송달 = 해지
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "60" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "3" ); 
		}
		// EMAIL -> LMS = 신규신청
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "2" ); 
		}
		// LMS -> 송달 = 해지
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "60" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "4" ); 
		}
		// LMS -> EMAIL = 신규신청
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "1" ); 
		}
		// 이중고지 -> 송달 = 해지
		else if( ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 ) && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "60" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "5" ); 
		}
		// 이중고지 -> EMAIL = 신규신청
		else if( ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 ) && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "1" ); 
		}
		// 이중고지 -> LMS = 신규신청
		else if( ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 ) && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "2" ); 
		}
		else
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "0" ); 
		}
		
		/************************************************************/
		/* PARAM SETTING                                            */
		/************************************************************/
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90004, FALSE);
		
		// REQ_FLAG
		JSON_SetValue( g_pjcomm, 'C', "req_flag",  stMcMainRslt.REQ_FLAG ); 
		
		// REQ_NM
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMcMainRslt.REQ_NM  );
		JSON_SetValue( g_pjcomm, 'C', "req_nm", szTmp );
		
		// REQ_LMS_DDD, REQ_LMS_EXN, REQ_LMS_NUM
		JSON_SetValue( g_pjcomm, 'C', "req_lms_ddd", stMcMainRslt.REQ_LMS_DDD );
		JSON_SetValue( g_pjcomm, 'C', "req_lms_exn", stMcMainRslt.REQ_LMS_EXN );
		JSON_SetValue( g_pjcomm, 'C', "req_lms_num", stMcMainRslt.REQ_LMS_NUM);
		
		// 이메일
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
		Str_Cpy( szTmp, stMcMainRslt.REQ_EMAIL );
		Str_Cat( szTmp, "@");
		Str_Cat( szTmp, stMcMainRslt.REQ_EMAIL_ADDR );
		
		SQL_ConvUcStr( szTmp2, szTmp );
		JSON_SetValue( g_pjcomm, 'C', "req_email", szTmp2 );
		
		// USE_CONT_NUM
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMcMainInfo.USE_CONT_NUM );
		
		// 주소
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMcMainInfo.ADDR );
		JSON_SetValue( g_pjcomm, 'C', "addr", szTmp );
		
		// 납부방법(한빌용)
		JSON_SetValue( g_pjcomm, 'C', "payMethodCd",  stMcMainInfo.PAY_METHOD_CD );
		
		// 발송방법(한빌용)
		JSON_SetValue( g_pjcomm, 'C', "billSendMethodCd",  stMcMainRslt.CMB_BILL_SEND_METHOD );
		
		// 설치장소번호
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  stMcMainInfo.INST_PLACE_NUM );
		
		// 발송방법
		JSON_SetValue( g_pjcomm, 'C', "send_ret_cd",  stMcMainRslt.CMB_BILL_SEND_METHOD );
		
		// 거부
		JSON_SetValue( g_pjcomm, 'C', "reject_cd",    stMcMainRslt.CMB_REFUSE );
		
		// 자가검침
		JSON_SetValue( g_pjcomm, 'C', "self_ret_cd",  stMcMainRslt.CMB_SELF_GMTR );
		
		// 사용계약
		JSON_SetValue( g_pjcomm, 'C', "udoc_ret_cd",  stMcMainRslt.CMB_USE_CONT );
		
		// 납부방법
		JSON_SetValue( g_pjcomm, 'C', "pay_ret_cd",   stMcMainRslt.CMB_PAY_METHOD );
		
		// 메모
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMcMainRslt.ETC  );
		JSON_SetValue( g_pjcomm, 'C', "etc",  szTmp );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90004;
		ret = HTTP_DownloadData(szUrl, "FR90004_IN",  "FR90004" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90004
	기  능 : FR90001 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90004(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90004) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "등록 완료하였습니다.");
			Clear_RsltData();
			Snd_FR90001(stMcMainInfo.INST_PLACE_NUM);
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90005
	기  능 : 실사용 번호 UPDATE / FR90005
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90005(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[200];
		char* sndbuf;
		long ret = 0;
		
		// 	Validation	
		if( !Validation() )
		{
			return;
		}
		
		// 실사용자 번호 저장 
		Save_Real();
		
		// PARAM SETTING
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90005, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num", stMcMainInfo.INST_PLACE_NUM);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMcMainInfo.USE_CONT_NUM);
		JSON_SetValue( g_pjcomm, 'C', "real_cp_ddd", stMcMainInfo.REAL_CP_DDD);
		JSON_SetValue( g_pjcomm, 'C', "real_cp_exn", stMcMainInfo.REAL_CP_EXN);
		JSON_SetValue( g_pjcomm, 'C', "real_cp_num", stMcMainInfo.REAL_CP_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90005;
		ret = HTTP_DownloadData(szUrl, "FR90005_IN",  "FR90005" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90005
	기  능 : FR90005 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90005(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90005) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "변경 완료하였습니다.");
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90006
	기  능 : 조회 / FR90006 / RCV_RELEASE
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90006(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[200];
		char szAddr_city[200];
		char* sndbuf;
		long ret = 0;
		long i;
		handle js = NULL;
		
		// 조회 데이터 저장
		Save_Search();
		
		// Validation
		if( !Validation() )
		{	
			return;
		}
		
		// TABLE CLEAR
		g_Sql_DirectExecute(" DELETE FROM RCV_RELEASE ");
		
		// PARAM SETTING
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90006, FALSE);
		
		/********************************************************************************/
		/* search_type : 1 = 사용계약번호, 2 = 지번, 3 = 도로명, 4 = 전화번호, 5 = 성명 */
		/********************************************************************************/
		// 주소
		if( Str_Cmp(stMcSearch.SEARCH_TYPE, "주소" ) == 0 )
		{
			Mem_Set( (byte*)szAddr_city, 0x00, sizeof(szAddr_city) );
			
			// 지번
			if( Str_Cmp(stMcSearch.SEARCH_ADDR_TYPE, "지번" ) == 0 )
			{
				JSON_SetValue( g_pjcomm, 'C', "search_type", "2" );
				
				i = g_SearchStr( stMcSearch.SEARCH_CITY, MC_CURR_ADDR );
				
				if (i == -1)
				{
					Str_Cpy(szAddr_city, "");
				}
				else
				{
					Str_Cpy(szAddr_city, MC_CURR_ADDR[i].Code);
				}	
			}
			//도로명
			else
			{
				JSON_SetValue( g_pjcomm, 'C', "search_type", "3" );
				
				i = g_SearchStr( stMcSearch.SEARCH_CITY, MC_NEW_ADDR );
			
				if (i == -1)
				{
					Str_Cpy(szAddr_city, "");
				}
				else
				{
					Str_Cpy(szAddr_city, MC_NEW_ADDR[i].Code);
				}
			}
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, szAddr_city );
			JSON_SetValue( g_pjcomm, 'C', "addr_city", szTmp );
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, stMcSearch.SEARCH_KEYWORD );
			JSON_SetValue( g_pjcomm, 'C', "addr_keyword",  szTmp );
			
			// JSON_SetValue( g_pjcomm, 'C', "use_cont_num", "");
		}
		// 사용계약번호
		else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "사용계약번호" ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "search_type", "1" );
			// JSON_SetValue( g_pjcomm, 'C', "addr_city", "" );
			// JSON_SetValue( g_pjcomm, 'C', "addr_keyword", "" );
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy( szTmp, stMcSearch.SEARCH_USE_CONT_NUM );
			Str_Chg( szTmp, STRCHG_DEL_NONDIGIT);
			
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num", szTmp );
		}
		// 전화번호
		else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "전화번호" ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "search_type", "4" );
			
			Mem_Set( (byte*)szAddr_city, 0x00, sizeof(szAddr_city) );
				
			i = g_SearchStr( stMcSearch.SEARCH_CITY2, MC_NEW_ADDR );
		
			if (i == -1)
			{
				Str_Cpy(szAddr_city, "");
			}
			else
			{
				Str_Cpy(szAddr_city, MC_NEW_ADDR[i].Code);
			}
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, szAddr_city );
			JSON_SetValue( g_pjcomm, 'C', "addr_city", szTmp );
			JSON_SetValue( g_pjcomm, 'C', "phone_ddd", stMcSearch.SEARCH_PHONE_DDD );
			JSON_SetValue( g_pjcomm, 'C', "phone_exn", stMcSearch.SEARCH_PHONE_EXN );
			JSON_SetValue( g_pjcomm, 'C', "phone_num", stMcSearch.SEARCH_PHONE_NUM );
		}
		// 성명
		else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "성명" ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "search_type", "5" );
			
			Mem_Set( (byte*)szAddr_city, 0x00, sizeof(szAddr_city) );
				
			i = g_SearchStr( stMcSearch.SEARCH_CITY2, MC_NEW_ADDR );
		
			if (i == -1)
			{
				Str_Cpy(szAddr_city, "");
			}
			else
			{
				Str_Cpy(szAddr_city, MC_NEW_ADDR[i].Code);
			}

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, szAddr_city );
			JSON_SetValue( g_pjcomm, 'C', "addr_city", szTmp );
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, stMcSearch.SEARCH_NAME );
			JSON_SetValue( g_pjcomm, 'C', "cust_nm", szTmp );
		}
		
		// FR90006_IN에 있는 List<FR90006_IN_Item> items때문에 빈 JSON데이터를 넘겨야함, 삭제 X
		js = JSON_Create(JSON_Array);
		
		JSON_Attach(g_pjcomm, "items", js);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90006;
		ret = HTTP_DownloadData(szUrl, "FR90006_IN",  "FR90006" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90006
	기  능 : FR90006 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90006(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90006) >= 0)
		{
			if( Str_Cmp(stMcSearch.SEARCH_ADDR_TYPE, "지번" ) == 0 )
			{
				m_lSearch_Addr_Chg = 0;
			}
			else
			{
				m_lSearch_Addr_Chg = 1;
			}
			
			TableDraw_Search(m_lSearch_Addr_Chg);
			MessageBoxEx (CONFIRM_OK, "조회를 완료하였습니다.");
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90007
	기  능 : SMS발송 / FR90007
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90007(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[200];
		char szMsg[200];
		char* sndbuf;
		long ret = 0;
		
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// HP
			if( m_lReal_hp_tel == 0 )
			{
				if( Str_Len(stMcMainInfo.CP_DDD) < 3
				 || Str_Len(stMcMainInfo.CP_EXN) < 4
				 || Str_Len(stMcMainInfo.CP_NUM) < 4 )
				{
					MessageBoxEx (CONFIRM_OK, "전화번호 형식이 맞지않습니다.");
					return;
				
				}
				else
				{
					Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					
					Str_Cpy( szTmp, stMcMainInfo.CP_DDD );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.CP_EXN );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.CP_NUM );
					
					SPRINT(szMsg, "고객님께 SMS발송을 하시겠습니까?\n( HP : %s )", szTmp, 0, 0);	
	
					if( MessageBoxEx(CONFIRM_YESNO, szMsg) != MB_OK)
					{
						return;
					}
				}
			}
			// REAL
			else if( m_lReal_hp_tel == 2 )
			{
				if( Str_Len(stMcMainInfo.REAL_CP_DDD) < 3
				 || Str_Len(stMcMainInfo.REAL_CP_EXN) < 4
				 || Str_Len(stMcMainInfo.REAL_CP_NUM) < 4 )
				{
					MessageBoxEx (CONFIRM_OK, "전화번호 형식이 맞지않습니다.");
					return;
				}
				else
				{
					Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					
					Str_Cpy( szTmp, stMcMainInfo.REAL_CP_DDD );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.REAL_CP_EXN );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.REAL_CP_NUM );
					
					SPRINT(szMsg, "고객님께 SMS발송을 하시겠습니까?\n( HP : %s )", szTmp, 0, 0);	
	
					if( MessageBoxEx(CONFIRM_YESNO, szMsg) != MB_OK)
					{
						return;
					}
				}
			}	
		}
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			if( Str_Cmp( stMcMainInfo.REAL_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)) ) != 0 
			 || Str_Cmp( stMcMainInfo.REAL_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN)) ) != 0 
			 || Str_Cmp( stMcMainInfo.REAL_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM)) ) != 0 )
			{
				MessageBoxEx (CONFIRM_OK, "변경을 먼저 하세요.");
				return;
			}
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			
			Str_Cpy( szTmp, stMcMainInfo.REAL_CP_DDD );
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.REAL_CP_EXN );
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.REAL_CP_NUM );
			
			if( Str_Len(stMcMainInfo.REAL_CP_DDD) < 3
			 || Str_Len(stMcMainInfo.REAL_CP_EXN) < 4
			 || Str_Len(stMcMainInfo.REAL_CP_NUM) < 4 )
			{
				
				MessageBoxEx (CONFIRM_OK, "전화번호 형식이 맞지않습니다.");
				return;
			
			}
			else
			{
				SPRINT(szMsg, "고객님께 SMS발송을 하시겠습니까?\n( HP : %s )", szTmp, 0, 0);	

				if( MessageBoxEx(CONFIRM_YESNO, szMsg) != MB_OK)
				{
					return;
				}
			}
		}
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90007, FALSE);
		
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{	
			if( m_lReal_hp_tel == 0 )
			{
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber1", stMcMainInfo.CP_DDD);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber2", stMcMainInfo.CP_EXN);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber3", stMcMainInfo.CP_NUM);
			}
			else if( m_lReal_hp_tel == 2 )
			{
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber1", stMcMainInfo.REAL_CP_DDD);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber2", stMcMainInfo.REAL_CP_EXN);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber3", stMcMainInfo.REAL_CP_NUM);
			}
		}
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			JSON_SetValue( g_pjcomm, 'C', "receiverNumber1", stMcMainInfo.REAL_CP_DDD);
			JSON_SetValue( g_pjcomm, 'C', "receiverNumber2", stMcMainInfo.REAL_CP_EXN);
			JSON_SetValue( g_pjcomm, 'C', "receiverNumber3", stMcMainInfo.REAL_CP_NUM);
		}
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMcMainInfo.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "recommender_id", stUserinfo.szRecommender_id );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stUserinfo.sztel );
		JSON_SetValue( g_pjcomm, 'C', "center_tel", szTmp );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90007;
		ret = HTTP_DownloadData(szUrl, "FR90007_IN",  "FR90007" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Snd_FR90007
	기  능 : FR90007 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90007(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90007) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "SMS발송을 완료하였습니다.");
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Set_Bill_Alarm
	기  능 : 발송방법 상세 버튼 이벤트
	Param  : 
	Return : 
	========================================================================================*/	
	void Set_Bill_Alarm(void)
	{
		char szMsg[200];
		
		Mem_Set((byte *)szMsg, 0x00, sizeof(szMsg));
		
		/*********************/
		/* LMS               */
		/*********************/
		if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 )
		{
			Str_Cpy( szMsg, "[ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		/*********************/
		/* EMAIL             */
		/*********************/
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 )
		{
			Str_Cpy( szMsg, "[ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
		}
		/*********************/
		/* MOBILE            */
		/*********************/
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "80" ) == 0 )
		{
			Str_Cpy( szMsg, "[ 모바일 ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 )
		{
			Str_Cpy( szMsg, "[ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 )
		{
			Str_Cpy( szMsg, "[ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 )
		{
			Str_Cpy( szMsg, "[ 모바일 ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0 )
		{
			Str_Cpy( szMsg, "[ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
			Str_Cat( szMsg, "\n [ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0 )
		{
			Str_Cpy( szMsg, "[ 모바일 \n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
			Str_Cat( szMsg, "\n [ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 )
		{
			Str_Cpy( szMsg, "[ 모바일 ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
			Str_Cat( szMsg, "\n[ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		
		MessageBoxEx (CONFIRM_OK, szMsg);
	}
	
	/*=======================================================================================
	함수명 : Set_Pay_Alarm
	기  능 : 납부방법 상세 버튼 이벤트
	Param  : 
	Return : 
	========================================================================================*/	
	void Set_Pay_Alarm(void)
	{
		char szMsg[200];
		char szTmp[10];
		char szTmp2[10];
		
		Mem_Set((byte *)szMsg, 0x00, sizeof(szMsg));
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte *)szTmp2, 0x00, sizeof(szTmp2));
		
		/*********************/
		/* 은행이체          */
		/*********************/
		if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) == 0 )
		{
			Str_Cpy( szMsg, "[ 은행이체 ]\n" );
			Str_Cat( szMsg, stMcMainInfo.BNK_NM );
			Str_Cat( szMsg, "\n" );
			Str_Cat( szMsg, stMcMainInfo.DEFRAY_ACCOUNT_NUM );
		}
		/*********************/
		/* 카드이체          */
		/*********************/
		else if ( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) == 0 )
		{
			Str_Cpy( szMsg, "[ 카드이체 ]\n" );
			Str_Cat( szMsg, stMcMainInfo.BNK_NM );
			Str_Cat( szMsg, "\n" );
			Str_Cat( szMsg, stMcMainInfo.DEFRAY_ACCOUNT_NUM );
		}
		
		MessageBoxEx (CONFIRM_OK, szMsg);
	}
	
	/*=======================================================================================
	함수명 : SetCombo_Filter
	기  능 : 콤보박스 Filter
	Param  : 
	Return : 
	========================================================================================*/	
	void SetCombo_Filter(void)
	{
		long i;
		char szSql[500];
		
		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// 1. 청구서발송방법 콤보박스
			// 1-1. 가스앱 : 거부 콤보박스 비활성화
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "가스앱") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_REFUSE), "" );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
				
				m_lBldOk_flag = 0;
			}
			// 1-2. LMS : 발송방법 버튼 활성화
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_REFUSE), "" );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
			}
			// 1-3. 메일 : 발송방법 버튼 활성화
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "메일") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_REFUSE), "" );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
			}
			// 1-4. 송달 : 발송방법 버튼 비활성화
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "송달") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				
				m_lBldOk_flag = 0;
			}
			else
			{
				m_lBldOk_flag = 0;
			}
			
			// 2. 납부방법 콤보박스
			// 2-1. 기존 납부방법이 은행, 카드 : 납부방법 콤보박스 비활성화
			if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) == 0 || Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), TRUE );
			}
			// 2-2. 기존 납부방법이 은행, 카드가 아닌 경우 : 납부방법 콤보박스 활성화
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), FALSE );
			}
			
			// 3. 기존 청구서발송방법이 메일, LMS고, 콤보박스로 선택한 값이 메일, LMS인 경우 발송방법 비활성화
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "메일") == 0 && Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				m_lBldOk_flag = 0;
			}
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS") == 0 && Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				m_lBldOk_flag = 0;
			}
			
			// 4. 기존 청구서발송방법이 가스앱인 경우 발송방법콤보박스 비 활성화
			if(  Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "80" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD+1), TRUE );
				
				m_lBldOk_flag = 0;
			}
			
			Save_Main_Combo();
		}
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "사용계약번호") == 0 )
			{
				// 주소타입
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), FALSE);
				
				// 시/군
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), FALSE);
				
				// 시/군2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), FALSE);
				
				// 성명
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), FALSE);
				
				// 전화번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), FALSE);
				
				// 검색
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), FALSE);	
				
				// 사용계약번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), TRUE);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "주소") == 0 )
			{
				// 주소타입
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), TRUE);
				
				// 시/군
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), TRUE);
				
				// 시/군2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), FALSE);
				
				// 성명
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), FALSE);
				
				// 전화번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), FALSE);
				
				// 검색
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), TRUE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), TRUE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), TRUE);	
				
				// 사용계약번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "전화번호") == 0 )
			{
				// 주소타입
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), FALSE);
				
				// 시/군
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), FALSE);
				
				// 시/군2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), TRUE);
				
				// 성명
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), FALSE);
				
				// 전화번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), TRUE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), TRUE);
				
				// 검색
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), FALSE);	
				
				// 사용계약번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "성명") == 0 )
			{
				// 주소타입
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), FALSE);
				
				// 시/군
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), FALSE);
				
				// 시/군2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), TRUE);
				
				// 성명
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), TRUE);
				
				// 전화번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), FALSE);
				
				// 검색
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), FALSE);	
				
				// 사용계약번호
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			}
			
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE)), "지번") == 0 )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_CITY+2 ) );
				for ( i = 0 ;  MC_CURR_ADDR[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_CITY+2), MC_CURR_ADDR[i].Str, 0, ICON_NONE);
				}
			}
			else
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_CITY+2 ) );
				for ( i = 0 ;  MC_NEW_ADDR[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_CITY+2), MC_NEW_ADDR[i].Str, 0, ICON_NONE);
				}
			}
		}
	}
	
	/*=======================================================================================
	함수명 : Validation
	기  능 : 
	Param  : 
	Return : 
	========================================================================================*/
	bool Validation(void)
	{
		long lActiveIndex = -1;
	
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		/********************************/
		/* 이동고객센터_메인            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// 가스앱
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "가스앱" )  == 0 )
			{
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "")  == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "납부방법을 선택하세요.");
						return FALSE;
					}
				}
			}
			// LMS
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS" )  == 0 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "" ) == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "납부방법을 선택하세요.");
						return FALSE;
					}
				}
				
				if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) != 0 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS" )  == 0 )
				{
					if( Str_Cmp(stMcMainRslt.REQ_NM, "") == 0 
					 || Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") == 0 )
					{
						MessageBoxEx(CONFIRM_OK, "LMS 발송등록 정보를 확인하세요.");
						return FALSE;
					}
				}
			}
			// 이메일
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "메일" )  == 0 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "" ) == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "납부방법을 선택하세요.");
						return FALSE;
					}
				}
				
				if (  Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) != 0 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "메일" )  == 0 )
				{
					if( Str_Cmp(stMcMainRslt.REQ_NM, "") == 0 
					 || Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_EMAIL, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_EMAIL_ADDR, "") == 0 )
					{
						MessageBoxEx(CONFIRM_OK, "EMAIL 발송등록 정보를 확인하세요.");
						return FALSE;
					}
				}
			}
			// 송달
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "송달" )  == 0 )
			{
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REFUSE)), "")  == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "거부를 선택하세요.");
					return FALSE;
				}
				
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "" ) == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "납부방법을 선택하세요.");
						return FALSE;
					}
				}
			}
		}
		/********************************/
		/* 이동고객센터_조회            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( Str_Cmp(stMcSearch.SEARCH_TYPE, "주소" ) == 0 )
			{
				if( Str_Cmp(stMcSearch.SEARCH_ADDR_TYPE, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "주소타입을 선택하세요.");
					return FALSE;
				}
				else if( Str_Cmp(stMcSearch.SEARCH_CITY, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "시/구를 선택하세요.");
					return FALSE;
				}
				else if( Str_Cmp(stMcSearch.SEARCH_KEYWORD, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "검색 내용을 입력하세요.\n[예: 은평터널 111-105 대림]");
					return FALSE;
				}
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "사용계약번호" ) == 0 )
			{
				if( Str_Len(stMcSearch.SEARCH_USE_CONT_NUM) != 11 )
				{
					MessageBoxEx(CONFIRM_OK, "사용계약번호를 입력하세요.");
					return FALSE;
				}
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "전화번호" ) == 0 )
			{
				if( Str_Cmp(stMcSearch.SEARCH_CITY2, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "시/구를 선택하세요.");
					return FALSE;
				}
				else if( Str_Len( stMcSearch.SEARCH_PHONE_DDD ) < 3 
					  || Str_Len( stMcSearch.SEARCH_PHONE_EXN ) < 4 
					  || Str_Len( stMcSearch.SEARCH_PHONE_NUM ) < 4 )
				{
					MessageBoxEx(CONFIRM_OK, "전화번호 형식이 맞지 않습니다.");
					return FALSE;	
				}
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "성명" ) == 0 )
			{
				if( Str_Cmp(stMcSearch.SEARCH_CITY2, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "시/구를 선택하세요.");
					return FALSE;
				}
				else if( Str_Cmp(stMcSearch.SEARCH_NAME, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "성명을 입력하세요");
					return FALSE;
				}
			}
		}
		/********************************/
		/* 이동고객센터_실사용자        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			if( Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)) ) < 3 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN)) ) < 4 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM)) ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "전화번호 형식이 맞지 않습니다.");
				return FALSE;	
			}
		}
		
		/********************************/
		/* 이동고객센터_발송등록        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM)), "" ) == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "신청인을 입력하세요.");
				return FALSE;
			}
			
			if( Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD)) ) < 3 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN)) ) < 4 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM)) ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "전화번호 형식이 맞지 않습니다.");
				return FALSE;	
			}
			
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" )  == 0 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL)), "" ) == 0
				 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2)), "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "EMAIL정보를 입력하세요.");
					return FALSE;
				}
			}
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Save_Main_Combo
	기  능 : 메인 등록
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Main_Combo(void)
	{
		long i;
		char szTmp[300];
		
		Mem_Set((byte*)stMcMainRslt.REQ_FLAG, 0x00, sizeof(stMcMainRslt.REQ_FLAG));
		
		// 1. 발송방법
		Mem_Set((byte*)stMcMainRslt.CMB_BILL_SEND_METHOD, 0x00, sizeof(stMcMainRslt.CMB_BILL_SEND_METHOD));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD) ) );
		
		i = g_SearchStr( szTmp, MC_BILL_SEND_METHOD );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_BILL_SEND_METHOD, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_BILL_SEND_METHOD, MC_BILL_SEND_METHOD[i].Code);
		}
		
		// 2. 거부
		Mem_Set((byte*)stMcMainRslt.CMB_REFUSE, 0x00, sizeof(stMcMainRslt.CMB_REFUSE));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_REFUSE) ) );
		
		i = g_SearchStr( szTmp, MC_REFUSE );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_REFUSE, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_REFUSE, MC_REFUSE[i].Code);
		}
		
		// 3. 납부방법
		Mem_Set((byte*)stMcMainRslt.CMB_PAY_METHOD, 0x00, sizeof(stMcMainRslt.CMB_PAY_METHOD));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PAY_METHOD) ) );
		
		i = g_SearchStr( szTmp, MC_PAY_METHOD );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_PAY_METHOD, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_PAY_METHOD, MC_PAY_METHOD[i].Code);
		}
		
		// 4. 자가검침
		Mem_Set((byte*)stMcMainRslt.CMB_SELF_GMTR, 0x00, sizeof(stMcMainRslt.CMB_SELF_GMTR));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELF_GMTR) ) );
		
		i = g_SearchStr( szTmp, MC_SELF_GMTR );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_SELF_GMTR, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_SELF_GMTR, MC_SELF_GMTR[i].Code);
		}
		
		// 5. 사용계약
		Mem_Set((byte*)stMcMainRslt.CMB_USE_CONT, 0x00, sizeof(stMcMainRslt.CMB_USE_CONT));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_USE_CONT) ) );
		
		i = g_SearchStr( szTmp, MC_USE_CONT );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_USE_CONT, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_USE_CONT, MC_USE_CONT[i].Code);
		}
	}
	
	/*=======================================================================================
	함수명 : Save_BillSend_Method
	기  능 : 발송방법 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Save_BillSend_Method(void)
	{
		Mem_Set((byte*)stMcMainRslt.REQ_NM, 0x00, sizeof(stMcMainRslt.REQ_NM));
		Str_Cpy(stMcMainRslt.REQ_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_LMS_DDD, 0x00, sizeof(stMcMainRslt.REQ_LMS_DDD));
		Str_Cpy(stMcMainRslt.REQ_LMS_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_LMS_EXN, 0x00, sizeof(stMcMainRslt.REQ_LMS_EXN));
		Str_Cpy(stMcMainRslt.REQ_LMS_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_LMS_NUM, 0x00, sizeof(stMcMainRslt.REQ_LMS_NUM));
		Str_Cpy(stMcMainRslt.REQ_LMS_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_EMAIL, 0x00, sizeof(stMcMainRslt.REQ_EMAIL));
		Str_Cpy(stMcMainRslt.REQ_EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_EMAIL_ADDR, 0x00, sizeof(stMcMainRslt.REQ_EMAIL_ADDR));
		Str_Cpy(stMcMainRslt.REQ_EMAIL_ADDR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2)));
	}
	
	/*=======================================================================================
	함수명 : Save_Real
	기  능 : 실사용번호 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Real(void)
	{
		Mem_Set((byte*)stMcMainInfo.REAL_CP_DDD, 0x00, sizeof(stMcMainInfo.REAL_CP_DDD));
		Str_Cpy(stMcMainInfo.REAL_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)));
		
		Mem_Set((byte*)stMcMainInfo.REAL_CP_EXN, 0x00, sizeof(stMcMainInfo.REAL_CP_EXN));
		Str_Cpy(stMcMainInfo.REAL_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN)));
		
		Mem_Set((byte*)stMcMainInfo.REAL_CP_NUM, 0x00, sizeof(stMcMainInfo.REAL_CP_NUM));
		Str_Cpy(stMcMainInfo.REAL_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM)));
	}
	
	/*=======================================================================================
	함수명 : Save_Search
	기  능 : 조회 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Search(void)
	{
		Mem_Set((byte*)&stMcSearch, 0x00, sizeof(stMcSearch));

		Str_Cpy(stMcSearch.SEARCH_TYPE, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)));

		Str_Cpy(stMcSearch.SEARCH_ADDR_TYPE, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE)));

		Str_Cpy(stMcSearch.SEARCH_CITY, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY)));
		
		Str_Cpy(stMcSearch.SEARCH_CITY2, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY2)));
		
		Str_Cpy(stMcSearch.SEARCH_KEYWORD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR)));
		
		Str_Cpy(stMcSearch.SEARCH_USE_CONT_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM)));
		
		Str_Cpy(stMcSearch.SEARCH_NAME, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_NAME)));
		
		Str_Cpy(stMcSearch.SEARCH_PHONE_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD)));
		
		Str_Cpy(stMcSearch.SEARCH_PHONE_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_EXN)));
		
		Str_Cpy(stMcSearch.SEARCH_PHONE_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_NUM)));
	}
	
	/*=======================================================================================
	함수명 : Save_Memo
	기  능 : 메모 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Memo(char* szMemo)
	{
		Mem_Set((byte*)stMcMainRslt.ETC, 0x00, sizeof(stMcMainRslt.ETC));
		Str_Cpy(stMcMainRslt.ETC, szMemo);
	}
	
	/*=======================================================================================
	함수명 : Quick_View_Search
	기  능 : 조회 퀵뷰 호출
	Param  : 
	Return : 
	========================================================================================*/
	void Quick_View_Search(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		char szTmp[400];
		
		char col_name[5][32] = {"사용\n계약번호", "주소", "고객명", "", ""};
		
		//필드 간격 조정
		char col_weight[5][10] = {"2","4","2","0","0"};
		char col_align[5][10]  = {"center", "left", "center", "center", ""};
		
		
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
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");	// true/false
			
			col_count = 4;
			
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			//주소가 표시되는 필드가 존재해서 세로길이가 자동조절이 안된다면 
			//일반 퀵뷰리스트와 같이 높이 조절이 필요할거같습니다.
			col_height = 300;
			
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = 0;
			
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			
			if( m_lSearch_Addr_Chg == 0 )
			{
				Str_Cpy( szTmp, "SELECT SUBSTR(PARAM2,1,5) || '\n-' || SUBSTR(PARAM2,6) AS PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM4" );
			}
			else if( m_lSearch_Addr_Chg == 1 )
			{
				Str_Cpy( szTmp, "SELECT SUBSTR(PARAM2,1,5) || '\n-' || SUBSTR(PARAM2,6) AS PARAM2, PARAM5, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM5" );
			}
			else
			{
				Str_Cpy( szTmp, "SELECT SUBSTR(PARAM2,1,5) || '\n-' || SUBSTR(PARAM2,6) AS PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE" );
			}
			
			JSON_SetValue	(hData	, 'C', "query", szTmp);

			hHead = JSON_Create( JSON_Array );
			
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for( i=0; i < col_count; i++ )
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "조회");
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
	
	/*=======================================================================================
	함수명 : OnList
	기  능 : 조회 퀵뷰 결과
	Param  : 
	Return : 
	========================================================================================*/
	void OnList(quad lParam)
	{
		long i;
		char szTmp[200];
		long lActIndex;
		long lindex;
		
		i = lParam;
		
		if( i > -1 )
		{
			if( m_lSearch_Addr_Chg == 0 )
			{
				g_Sql_SaveSeq( "SELECT ROWID FROM RCV_RELEASE ORDER BY PARAM4", SREACH_FILE);
			}
			else if( m_lSearch_Addr_Chg == 1 )
			{
				g_Sql_SaveSeq( "SELECT ROWID FROM RCV_RELEASE ORDER BY PARAM5", SREACH_FILE);
			}
			else
			{
				g_Sql_SaveSeq( "SELECT ROWID FROM RCV_RELEASE", SREACH_FILE);
			}
		
			lActIndex = lParam;
			lindex = g_SREACHFILE_GetSeq(SREACH_FILE, lActIndex);
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)m_szInst_Place_Num, 0x00, sizeof(m_szInst_Place_Num));
			
			SPRINT(szTmp, "SELECT PARAM1 FROM RCV_RELEASE A WHERE ROWID = '%d'", lindex, 0, 0);

			g_Sql_RetStr(szTmp, 10, m_szInst_Place_Num);
			
			Clear_RsltData();
			
			m_lInitRedraw = 0;
			m_lSearch_Move_flag = 1;
			
			ON_EXIT();
			OnInit(INIT_MAIN);
		}
	}
	
	/*=======================================================================================
	함수명 : Clear_Data
	기  능 : 데이터 Clear
	Param  : 
	Return : 
	========================================================================================*/
	void Clear_Data(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), "");
		}
		
		Mem_Set((byte*)&stMcMainInfo, 0x00, sizeof(stMcMainInfo));
		Mem_Set((byte*)&stMcMainRslt, 0x00, sizeof(stMcMainRslt));
		Mem_Set((byte*)&stMcSearch, 0x00, sizeof(stMcSearch));
		
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		g_Sql_DirectExecute(" DELETE FROM RCV_RELEASE ");
	}
	
	/*=======================================================================================
	함수명 : Clear_RsltData
	기  능 : 메인 데이터 Clear
	Param  : 
	Return : 
	========================================================================================*/
	void Clear_RsltData(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), "");
		}
		
		Mem_Set((byte*)&stMcMainRslt, 0x00, sizeof(stMcMainRslt));
		
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
	}
	
	/*=======================================================================================
	함수명 : Set_Move_Card
	기  능 : 이동고객센터 화면에서 뒤로 돌아갈때 어느업무로 이동할지 결정하는 함수
	Param  : 
	Return : 
	========================================================================================*/
	void Back_Move_Card(void)
	{	
		// g_lMC_MoveCard_Flag : 0 = 안전점검, 1 = 검침, 2 = 공급전 단독, 3 = 공급전 공동, 4 = 안전점검 등록
		if( g_lMC_MoveCard_Flag == 0 )
		{
			Card_Move("SC_START");
		}
		else if( g_lMC_MoveCard_Flag == 1 )
		{
			Card_Move("GM_ENTRY");
		}
		else if( g_lMC_MoveCard_Flag == 2 )
		{
			Card_Move("BF_BEFOCONFIRM");
		}
		else if( g_lMC_MoveCard_Flag == 3 )
		{
			Card_Move("BF_TGTCONFIRM");
		}
		else if( g_lMC_MoveCard_Flag == 4 )
		{
			Card_Move("SC_CONFIRM");
		}
		else
		{
			Card_Move("MENU");
		}
	}
	
	/*=======================================================================================
	함수명 : Set_View_Main_PhoneNum
	기  능 : 메인 전화번호 화면 view
	Param  : 
	Return : 
	========================================================================================*/
	void Set_View_Main_PhoneNum(void)
	{
		// m_lReal_hp_tel : HP = 0, tel = 1, real = 2
		if( Str_Cmp(stMcMainInfo.REAL_CP_DDD, "") != 0 || Str_Cmp(stMcMainInfo.REAL_CP_EXN, "") != 0 || Str_Cmp(stMcMainInfo.REAL_CP_NUM, "") != 0 )
		{
			m_lReal_hp_tel = 2;
		}
		else if( Str_Cmp(stMcMainInfo.CP_DDD, "") != 0 || Str_Cmp(stMcMainInfo.CP_EXN, "") != 0 || Str_Cmp(stMcMainInfo.CP_NUM, "") != 0 )
		{
			m_lReal_hp_tel = 0;	
		}
		else
		{
			m_lReal_hp_tel = 1;
		}
	}
}
