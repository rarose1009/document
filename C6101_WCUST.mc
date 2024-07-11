/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_WCUST
	Card Desc : 민원 고객정보( 전입, 전입 외 )
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_WCUST
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
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/* 고객정보                     */
		/********************************/
		DEF_BUTTON_ID ( BID_WCUST )				// 고객
		DEF_BUTTON_ID ( BID_WMTR )				// 정산
		DEF_BUTTON_ID ( BID_WBUR )				// 연소기
		DEF_BUTTON_ID ( BID_WCHK )				// 점검
		DEF_BUTTON_ID ( BID_WONE )				// 일회성
		DEF_BUTTON_ID ( BID_WSTOP )				// 중지
		DEF_BUTTON_ID ( BID_WRELE )				// 해제
		DEF_BUTTON_ID ( BID_WPAY )				// 요금
		DEF_BUTTON_ID ( BID_CLOSE )				// 종료
		DEF_BUTTON_ID ( BID_BUILT_IN_Y )    	// 빌트인_Y
		DEF_BUTTON_ID ( BID_BUILT_IN_N )		// 빌트인_N
		DEF_BUTTON_ID ( BID_ADDR )				// 주소
		DEF_BUTTON_ID ( BID_PRECUST )			// 이전고객
		DEF_BUTTON_ID ( BID_CUST_NM )			// 고객명
		DEF_BUTTON_ID ( BID_FIRM_NM )			// 상호명
		DEF_BUTTON_ID ( BID_EMAIL )				// 이메일
		DEF_BUTTON_ID ( BID_WFIN )		    	// 완료
		DEF_BUTTON_ID ( BID_INFO_TRANS_YN_Y )   // 연계여부_Y
		DEF_BUTTON_ID ( BID_INFO_TRANS_YN_N )	// 연계여부_N
		DEF_BUTTON_ID ( BID_INFO_TRANS_YN_INFO )// 연계항목
		
		/********************************/
		/* 이전계약                     */
		/********************************/
		DEF_BUTTON_ID ( BID_SUBCLOSE )			// 이전계약종료
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* 타이틀                       */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )		
		DEF_OBJECT_ID ( TAB_LINE )		
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		DEF_OBJECT_ID ( TTL_DATA01 )			// 사용계약번호
		DEF_OBJECT_ID ( TXT_DATA01 )			// 사용계약번호
		DEF_OBJECT_ID ( TTL_DATA02 )			// 체납개월수
		DEF_OBJECT_ID ( TXT_DATA02 )			// 체납개월수
		DEF_OBJECT_ID ( TTL_DATA03 )			// 총미납분
		DEF_OBJECT_ID ( TXT_DATA03 )			// 총미납분
		
		DEF_OBJECT_ID ( TTL_USE_CONT_NUM )		// 사용계약번호
		DEF_OBJECT_ID ( TXT_USE_CONT_NUM )		// 사용계약번호
		DEF_OBJECT_ID ( TTL_CUST_NUM )			// 고객번호
		DEF_OBJECT_ID ( TXT_CUST_NUM )			// 고객번호
		DEF_OBJECT_ID ( TTL_ADDR )				// 주소
		DEF_OBJECT_ID ( TXT_ADDR1 )				// 주소
		DEF_OBJECT_ID ( TXT_ADDR2 )				// 주소	
		DEF_OBJECT_ID ( TXT_ADDR3 )				// 주소
		DEF_OBJECT_ID ( TTL_CUST_NM )			// 고객명
		DEF_OBJECT_ID ( TXT_CUST_NM )			// 고객명
		DEF_OBJECT_ID ( TTL_SOC_NUM )			// 생년월일
		DEF_OBJECT_ID ( TXT_SOC_NUM )			// 생년월일
		DEF_OBJECT_ID ( TTL_CP )				// 핸드폰
		DEF_OBJECT_ID ( TXT_CP_DDD )			// 핸드폰
		DEF_OBJECT_ID ( TXT_CP_EXN )			// 핸드폰
		DEF_OBJECT_ID ( TXT_CP_NUM )			// 핸드폰
		DEF_OBJECT_ID ( TTL_OWNHOUSE_TEL )		// 자택번호
		DEF_OBJECT_ID ( TXT_OWNHOUSE_TEL_DDD )	// 자택번호
		DEF_OBJECT_ID ( TXT_OWNHOUSE_TEL_EXN )	// 자택번호
		DEF_OBJECT_ID ( TXT_OWNHOUSE_TEL_NUM )	// 자택번호
		
		DEF_OBJECT_ID ( TTL_DEADLINEFLAG )		// 납기
		DEF_OBJECT_ID ( TXT_DEADLINEFLAG )		// 납기
		DEF_OBJECT_ID ( TTL_GMTRBASEDAY )		// 검침일
		DEF_OBJECT_ID ( TXT_GMTRBASEDAY )		// 검침일
		
		DEF_OBJECT_ID ( TTL_FIRM_NM )			// 상호
		DEF_OBJECT_ID ( TXT_FIRM_NM )			// 상호
		DEF_OBJECT_ID ( TTL_CUST_TRND_CD )		// 성향	
		DEF_OBJECT_ID ( TTL_FAMILY_CNT )		// 가족수
		DEF_OBJECT_ID ( TXT_FAMILY_CNT )		// 가족수
		DEF_OBJECT_ID ( TTL_SQUARE_METER )		// 평수
		DEF_OBJECT_ID ( TTL_BUILT_IN_YN )		// 빌트인
		DEF_OBJECT_ID ( TTL_EMAIL )				// 이메일
		DEF_OBJECT_ID ( TXT_EMAIL )				// 이메일
		DEF_OBJECT_ID ( TXT_EMAIL_AT )			// 이메일
		
		/********************************/
		/* 자판                         */
		/********************************/
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
		
		/********************************/
		/* COMBO                        */
		/********************************/
		DEF_OBJECT_ID ( CMB_CUST_TRND_CD )							// 성향
		DEF_OBJECT_ID ( CMB_SQUARE_METER = CMB_CUST_TRND_CD + 3 ) 	// 평수
		DEF_OBJECT_ID ( CMB_EMAIL = CMB_SQUARE_METER + 3 )			// 이메일
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN		1	// 전입
	#define INIT_PRECUST	2	// 이전계약
	
	#define CHK_N1	"□N"
	#define CHK_N2	"▣N"
	#define CHK_Y1	"□Y"
	#define CHK_Y2	"▣Y"
	
	#define INFO_TRANS_N1	"□N"
	#define INFO_TRANS_N2	"▣N"
	#define INFO_TRANS_Y1	"□Y"
	#define INFO_TRANS_Y2	"▣Y"
	
	#define	W_MAIN	CWD*39+10
	#define	H_MAIN	CHT*21
	#define SYH		(CHT+20)
	#define Line(x)	(STARTY+5+SYH*x)
	 
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	long m_bFirst;
	long m_lActiveIndex = -1;
	long m_lbilutin_flag = 0;
	
	char m_szCnt_index[11];     //인덱스 문자열(현재 페이지)
	char m_szUse_cont_num[11];
	char m_szCnt[11];
	char m_szUnpay_amt[20];
	
	char m_szTrans_info_rslt[300];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void Read_CustInfo(void);
	void Save_Cust(void);
	bool Chk_Custinfo(void);
	
	void Snd_FR68304(void);
	long Rcv_FR68304(void);
	long Chk_Json_68304(void);
	
	//---------------------------------------------------------------
	// 메인 다이얼로그( 전입 외 )
	//---------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),		
		DLG_ICON(  POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(  POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		/******* TAB *********/
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WCUST, "고객"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "연소기"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "정산"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WONE, "일회성"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WPAY, "요금"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "중지"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "해제"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "점검"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WFIN, "완료"),
		
		DLG_TEXT ( STARTX,     Line(1)    , 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_USE_CONT_NUM, "계약번호"),
		DLG_TEXT ( STARTX+215, Line(1)    , 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_USE_CONT_NUM, ""),
		
		DLG_TEXT ( STARTX,     Line(2)    , 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUST_NUM, "고객번호"),
		DLG_TEXT ( STARTX+215, Line(2)    , 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CUST_NUM, ""),
		
		DLG_BUTTON(STARTX,     Line(3) +15, 215, SYH*3, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번\n주 소"),
		DLG_TEXT ( STARTX+215, Line(3) +15, 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),
		DLG_TEXT ( STARTX+215, Line(4) +15, 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		DLG_TEXT ( STARTX+215, Line(5) +15, 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		
		DLG_TEXT ( STARTX,     Line(6) +15, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUST_NM, "고 객 명"),
		DLG_TEXT ( STARTX+215, Line(6) +15, 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CUST_NM, ""),
		
		DLG_TEXT ( STARTX,     Line(7) +15, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SOC_NUM, "생년월일"),
		DLG_TEXT ( STARTX+215, Line(7) +15, 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SOC_NUM,  ""),
		
		DLG_TEXT ( STARTX,     Line(8) +15, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CP, "핸드폰"),
		DLG_TEXT ( STARTX+215, Line(8) +15, 260, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CP_DDD, ""),
		DLG_TEXT ( STARTX+475, Line(8) +15, 260, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CP_EXN, ""),
		DLG_TEXT ( STARTX+735, Line(8) +15, 265, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CP_NUM, ""),
		
		DLG_TEXT ( STARTX,     Line(9) +15, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_OWNHOUSE_TEL, "자택전화"),
		DLG_TEXT ( STARTX+215, Line(9) +15, 260, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_OWNHOUSE_TEL_DDD, ""),
		DLG_TEXT ( STARTX+475, Line(9) +15, 260, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_OWNHOUSE_TEL_EXN, ""),
		DLG_TEXT ( STARTX+735, Line(9) +15, 265, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_OWNHOUSE_TEL_NUM, ""),
		
		DLG_TEXT ( STARTX,     Line(10)+15, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_FIRM_NM, "상호"),
		DLG_TEXT ( STARTX+215, Line(10)+15, 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FIRM_NM, ""),
		
		DLG_TEXT ( STARTX,     Line(11)+30, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUST_TRND_CD, "성향"),
		
		DLG_COMBO_UP(STARTX+215, Line(11)+30,285, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CUST_TRND_CD, 10), // 성향 콤보
		
		DLG_TEXT ( STARTX+500, Line(11)+30, 200, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_FAMILY_CNT, "가족수"),
		DLG_TEXT ( STARTX+700, Line(11)+30, 300, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FAMILY_CNT, ""),
		
		DLG_TEXT ( STARTX,     Line(12)+30, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SQUARE_METER, "평수"),
				
		DLG_COMBO_UP( STARTX+215, Line(12)+30,  285, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SQUARE_METER, 10), // 평수콤보
		
		DLG_TEXT ( STARTX+500, Line(12)+30, 200, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BUILT_IN_YN, "빌트인"),
		DLG_BUTTON(STARTX+700, Line(12)+30, 150, SYH  , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BUILT_IN_Y,  CHK_Y1),
		DLG_BUTTON(STARTX+850, Line(12)+30, 150, SYH  , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BUILT_IN_N,  CHK_N1),
		
		DLG_TEXT ( STARTX,     Line(13)+30, 215, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_EMAIL, "이 메 일"),
		DLG_TEXT ( STARTX+215, Line(13)+30, 785, SYH  , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_EMAIL, ""),
	};	
	
	//---------------------------------------------------------------
	// 메인 다이얼로그( 전입 )
	//---------------------------------------------------------------
	DlgObject DlgRes_M[] = 
	{
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),		
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		/******* TAB *********/
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WCUST, "고객"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "연소기"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "정산"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WONE, "일회성"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WPAY, "요금"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "중지"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "해제"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "점검"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WFIN, "완료"),
		
		DLG_TEXT ( STARTX,     Line(1)  -5, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUST_NUM, "고객번호"),
		DLG_TEXT ( STARTX+215, Line(1)  -5, 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CUST_NUM, ""),

		DLG_BUTTON(STARTX,     Line(2) +15, 215, SYH*3, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번\n주 소"),
		DLG_TEXT ( STARTX+215, Line(2) +15, 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),
		DLG_TEXT ( STARTX+215, Line(3) +15, 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		DLG_TEXT ( STARTX+215, Line(4) +15, 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		
		DLG_TEXT ( STARTX,     Line(5) +15, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUST_NM, "고 객 명"),
		DLG_BUTTON(STARTX+215, Line(5) +15, 785, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CUST_NM,  ""),
		DLG_TEXT ( STARTX+215, Line(5) +15, 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_CUST_NM, ""),
		
		DLG_TEXT ( STARTX,     Line(6) +15, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SOC_NUM, "생년월일"),
		DLG_TEXT ( STARTX+215, Line(6) +15, 875, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SOC_NUM, ""),
		
		DLG_TEXT ( STARTX,     Line(7) +15, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CP, "핸드폰"),
		DLG_EDIT ( STARTX+215, Line(7) +15, 135, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_CP_DDD, 4,""),
		DLG_EDIT ( STARTX+350, Line(7) +15, 150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_CP_EXN, 4,""),
		DLG_EDIT ( STARTX+500, Line(7) +15, 150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_CP_NUM, 4,""),
		
		DLG_TEXT ( STARTX+650, Line(7) +15, 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DEADLINEFLAG, "납기"),
		DLG_EDIT ( STARTX+850, Line(7) +15, 150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DEADLINEFLAG, 2,""),
		
		DLG_TEXT ( STARTX,     Line(8) +15, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_OWNHOUSE_TEL, "자택전화"),
		DLG_EDIT ( STARTX+215, Line(8) +15, 135, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_OWNHOUSE_TEL_DDD, 3,""),
		DLG_EDIT ( STARTX+350, Line(8) +15, 150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_OWNHOUSE_TEL_EXN, 4,""),
		DLG_EDIT ( STARTX+500, Line(8) +15, 150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_OWNHOUSE_TEL_NUM, 4,""),
		
		DLG_TEXT ( STARTX+650, Line(8) +15, 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GMTRBASEDAY, "검침일"),
		DLG_EDIT ( STARTX+850, Line(8) +15, 150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_GMTRBASEDAY, 2,""),
		
		DLG_TEXT ( STARTX,     Line(9) +15, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_EMAIL, "이 메 일"),
		DLG_BUTTON(STARTX+215, Line(9) +15, 285, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EMAIL,  ""),
		DLG_TEXT ( STARTX+215, Line(9) +15, 285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_EMAIL, ""),
		DLG_TEXT ( STARTX+500, Line(9) +15,  70, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_EMAIL_AT, "@"),
		
		DLG_COMBO_UPE(STARTX+570, Line(9)+15, 430, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_EMAIL, 20), // 이메일 콤보
		
		DLG_TEXT ( STARTX,     Line(10)+15, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_FIRM_NM, "상호"),
		DLG_BUTTON(STARTX+215, Line(10)+15, 785, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FIRM_NM,  ""),
		DLG_TEXT ( STARTX+215, Line(10)+15, 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_FIRM_NM, ""),
		
		DLG_TEXT ( STARTX,     Line(11)+30,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUST_TRND_CD, "성향"),
		
		DLG_COMBO_UP(STARTX+215, Line(11)+30,285, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CUST_TRND_CD, 10), // 성향 콤보
		
		DLG_TEXT ( STARTX+500, Line(11)+30,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_FAMILY_CNT, "가족수"),
		DLG_EDIT ( STARTX+700, Line(11)+30,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_FAMILY_CNT, 2,""),
		
		DLG_TEXT ( STARTX,     Line(12)+30,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SQUARE_METER, "평수"),
				
		DLG_COMBO_UP( STARTX+215, Line(12)+30, 285, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SQUARE_METER, 10), // 평수 콤보
		
		DLG_BUTTON(STARTX,     Line(13)+54,  215, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO_TRANS_YN_INFO,  "연계여부"),
		
		DLG_BUTTON(STARTX+215, Line(13)+54,  143, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_INFO_TRANS_YN_Y,  INFO_TRANS_Y1),
		DLG_BUTTON(STARTX+358, Line(13)+54,  142, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_INFO_TRANS_YN_N,  INFO_TRANS_N1),
		
		DLG_TEXT ( STARTX+500, Line(12)+30,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BUILT_IN_YN, "빌트인"),
		DLG_BUTTON(STARTX+700, Line(12)+30,  150, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BUILT_IN_Y,  CHK_Y1),
		DLG_BUTTON(STARTX+850, Line(12)+30,  150, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BUILT_IN_N,  CHK_N1),
		
		DLG_BUTTON(STARTX+500, Line(13)+54,  500, SYH, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRECUST, "이전계약미납분"),
		
		/******* 숫자 자판 *********/
		DLG_TEXT ( 0,   STARTY +940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT ( 333, STARTY +940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT ( 666, STARTY +940, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT ( 0,   STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT ( 333, STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT ( 666, STARTY+1030, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT ( 0,   STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT ( 333, STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT ( 666, STARTY+1120, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT ( 333, STARTY+1210, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT ( 666, STARTY+1210, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "←"),
	};	
	
	//---------------------------------------------------------------
	// 이전계약정보 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_PRECUST[] = 
	{
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "이전계약미납분"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY      , 300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_DATA01, "사용번호"),
		DLG_TEXT ( STARTX+300, STARTY      , 650, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA01, ""),
		DLG_TEXT ( STARTX,     STARTY+SYH  , 300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_DATA02, "체납개월수"),
		DLG_TEXT ( STARTX+300, STARTY+SYH  , 650, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA02, ""),
		DLG_TEXT ( STARTX,     STARTY+SYH*2, 300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_DATA03, "총미납분"),
		DLG_TEXT ( STARTX+300, STARTY+SYH*2, 650, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA03, ""),

		DLG_BUTTON(STARTX+730, STARTY+SYH*4, 240, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, "확 인"),
	};	
	
	//---------------------------------------------------------------
	//	main 
	//---------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		return TRUE;
	}
	
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
			/* 고객정보                     */
			/********************************/
			case INIT_MAIN:
				if( g_nWorkFlag == 610 )
				{
					CREATE_DIALOG_OBJECT (DlgRes_M, SIZEOF(DlgRes_M));
				}
				else
				{
					CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				}
				break;
			/********************************/
			/* 이전계약정보                 */
			/********************************/	
			case INIT_PRECUST:
				CREATE_DIALOG_OBJECT (DlgRes_PRECUST, SIZEOF(DlgRes_PRECUST));
				break;
		}
		
		SetBtnImg();
		SetStyle();
		ReDraw();
	}

	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		char szSql[200];
		
		switch(ID)
		{
			/********************************/
			/* 탭 버튼                      */
			/********************************/
			case BID_WCUST:
				//Card_Move("C6101_WCUST");
				break;
				
			case BID_WMTR:
				if(Chk_Custinfo())
				{
					Save_Cust();
					Card_Move("C6101_WMTR");
				}
				break;
				
			case BID_WBUR:
				if(Chk_Custinfo())
				{
					Save_Cust();
					Card_Move("C6101_WBUR");
				}
				break;
				
			case BID_WCHK:
				if(Chk_Custinfo())
				{
					Save_Cust();
					Card_Move("C6101_WCHK");
				}
				break;
				
			case BID_WONE:
				if(Chk_Custinfo())
				{
					Save_Cust();
					Card_Move("C6101_WONE");
				}
				break;
				
			case BID_WSTOP:
				if(Chk_Custinfo())
				{
					Save_Cust();
					Card_Move("C6101_WSTOP");
				}
				break;
				
			case BID_WRELE:
				if(Chk_Custinfo())
				{
					Save_Cust();
					Card_Move("C6101_WRELE");
				}
				break;
				
			case BID_WPAY:
				if(Chk_Custinfo())
				{
					Save_Cust();
					Card_Move("C6101_WPAY");
				}
				break;
				
			case BID_CLOSE:	
				if( MessageBoxEx (CONFIRM_YESNO, "작업리스트 화면으로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6101_LST");
				}
				break;
				
			case BID_WFIN:
				if( MessageBoxEx (CONFIRM_YESNO, "전출확인을 완료하시겠습니까?")  == MB_OK)
				{
					Str_ItoA( Time_GetDate(), stMw.szChk_time_end, 10);
					g_Str_TimeType(stMw.szChk_time_end+8, Time_GetTime());

					g_Snd_RstMin_690(1);
				}
				break;
			
			/********************************/
			/* 고객정보                     */
			/********************************/
			case BID_ADDR:
				if(g_nAddrFlag == 0 )
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				
				ReDraw();		
				
				break;
				
			case BID_CUST_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_CUST_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CUST_NM)) );
				break;

			case BID_FIRM_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_FIRM_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_FIRM_NM)) );
				break;

			case BID_EMAIL:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_EMAIL), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_EMAIL)) );
				break;
		
			case BID_BUILT_IN_Y:
				m_lbilutin_flag = 1;
				stMw.szBuilt_in_yn[0] = 'Y'; 
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_N), CHK_N1);
				break;
				
			case BID_BUILT_IN_N:
				m_lbilutin_flag = 0;
				stMw.szBuilt_in_yn[0] = 'N'; 
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_N), CHK_N2);				
				break;
				
			case BID_INFO_TRANS_YN_Y:
				
				Mem_Set((byte*)stMw.szSend_Info_Trans_yn, 0x00, sizeof(stMw.szSend_Info_Trans_yn));
				Str_Cpy( stMw.szSend_Info_Trans_yn, "Y" );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE C6101_PROMISE_ASSIGN SET SEND_INFO_TRANS_YN = 'Y' WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_Y), INFO_TRANS_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_N), INFO_TRANS_N1);
				
				break;
				
			case BID_INFO_TRANS_YN_N:
				
				if( MessageBoxEx (CONFIRM_YESNO, "전입연계를 취소하시겠습니까?")  == MB_OK)
				{
					Mem_Set((byte*)stMw.szSend_Info_Trans_yn, 0x00, sizeof(stMw.szSend_Info_Trans_yn));
					Str_Cpy( stMw.szSend_Info_Trans_yn, "N" );
					
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "UPDATE C6101_PROMISE_ASSIGN SET SEND_INFO_TRANS_YN = 'N' WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_DirectExecute(szSql);
					
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_Y), INFO_TRANS_Y1);
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_N), INFO_TRANS_N2);	
				}			
				
				break;
				
			case BID_PRECUST:
				if(Chk_Custinfo())
				{
					Save_Cust();
					ON_EXIT();
					OnInit(INIT_PRECUST);
				}
				break;
			
			case BID_INFO_TRANS_YN_INFO:
			    Snd_FR68304();
			    break;
			    
			/********************************/
			/* 이전계약정보                 */
			/********************************/	
			case BID_SUBCLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnChar
	기  능 : 숫자만 입력 가능
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		/********************************/
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// 생년월일 - 숫자만 입력 가능
			if( Get_iDlgCtrlByID(TXT_SOC_NUM) == m_lActiveIndex )
			{	
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}

				Str_Cpy(stMw.szSoc_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_SOC_NUM)));
			}
			// 전화번호 - 숫자만 입력 가능
			else if( Get_iDlgCtrlByID(TXT_CP_DDD) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}

				//Str_Cpy(stMw.szCp_ddd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_DDD)));
			}
			else if( Get_iDlgCtrlByID(TXT_CP_EXN) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}

				//Str_Cpy(stMw.szCp_exn, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_EXN)));
			}
			else if( Get_iDlgCtrlByID(TXT_CP_NUM) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}
				
				//Str_Cpy(stMw.szCp_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_NUM)));
			}
			else if( Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}
				
				//Str_Cpy(stMw.szOwnhouse_tel_ddd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD)));
			}
			else if( Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}
				
				//Str_Cpy(stMw.szOwnhouse_tel_exn, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN)));
			}
			else if( Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}
				
				//Str_Cpy(stMw.szOwnhouse_tel_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM)));
			}
			// 가족 수 - 숫자만 입력가능
			else if( Get_iDlgCtrlByID(TXT_FAMILY_CNT) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}
				
				Str_Cpy(stMw.szFamily_cnt, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_FAMILY_CNT)));
			}
			// 검침일 - 숫자만 입력가능
			else if( Get_iDlgCtrlByID(TXT_GMTRBASEDAY) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}
				
				Str_Cpy(stMw.szGmtr_base_day, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_GMTRBASEDAY)));
			}
			// 납기일 - 숫자만 입력가능
			else if( Get_iDlgCtrlByID(TXT_DEADLINEFLAG) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY( 5 );
					return;
				}
				
				Str_Cpy(stMw.szDeadline_flag, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DEADLINEFLAG)));
			}
		}
	}
		
	/*=======================================================================================
	함수명 : OnPointing
	기  능 : 화면 포인팅 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( g_nWorkFlag == 610 )
			{
				m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}

			if( POINTING_UP == nAction && ( g_nWorkFlag == 610 && ( stMw.szCust_num[0] != '0' && Str_Len(stMw.szCust_num) > 0 ) ) )
			{
				if( ( X > DMS_X(STARTX+215) && X < DMS_X(STARTX+650) && Y > DMS_Y( Line(7)+15-(g_Dlgflag*400)) && Y < DMS_Y(Line(8)+15-(g_Dlgflag*400)) && stMw.szCust_num[0] != '0' )
				 || ( X > DMS_X(STARTX+215) && X < DMS_X(STARTX+650) && Y > DMS_Y( Line(8)+15-(g_Dlgflag*400) ) && Y < DMS_Y( Line(9)+15-(g_Dlgflag*400)) && stMw.szCust_num[0] != '0' )
				 || ( X > DMS_X(STARTX+700) && X < DMS_X(STARTX+1000) && Y > DMS_Y( Line(11)+30-(g_Dlgflag*400) ) && Y < DMS_Y( Line(12)+30-(g_Dlgflag*400)) && stMw.szCust_num[0] != '0' )
				 || ( X > DMS_X(STARTX+850) && X < DMS_X(STARTX+1000) && Y > DMS_Y( Line(8)+15-(g_Dlgflag*400) ) && Y < DMS_Y( Line(9)+15-(g_Dlgflag*400)) )
				 || ( X > DMS_X(STARTX+570) && X < DMS_X(STARTX+1000-SYH*2) && Y > DMS_Y( Line(9)+15-(g_Dlgflag*400) ) && Y < DMS_Y( Line(10)+15-(g_Dlgflag*400) ) && stMw.szCust_num[0] != '0' )
				 || ( X > DMS_X(STARTX+850) && X < DMS_X(STARTX+1000) && Y > DMS_Y( Line(7)+15-(g_Dlgflag*400)) && Y < DMS_Y(Line(8)+15-(g_Dlgflag*400)) ) )
				{
					if( Get_iDlgCtrlByID(TXT_CP_DDD) == m_lActiveIndex 
					 || Get_iDlgCtrlByID(TXT_CP_EXN) == m_lActiveIndex 
					 || Get_iDlgCtrlByID(TXT_CP_NUM) == m_lActiveIndex
					 || Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD) == m_lActiveIndex 
					 || Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN) == m_lActiveIndex 
					 || Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM) == m_lActiveIndex 
					 || Get_iDlgCtrlByID(TXT_FAMILY_CNT) == m_lActiveIndex  
					 || Get_iDlgCtrlByID(TXT_GMTRBASEDAY) == m_lActiveIndex 
					 || Get_iDlgCtrlByID(TXT_DEADLINEFLAG) == m_lActiveIndex )
					{
						g_Dlgflag = 0;
						g_MOVE_DLG(400);
					}
					else
					{
						g_Dlgflag = 1;
						g_MOVE_DLG(1);
					}
				}
				else
				{
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
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
		long sX[8], eX[8];
		long lenX;
		long i;
		long TABCNT;
		long starty, highty;
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// 타이틀
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			// 탭 스타일
			// 610 : 전입 [ 고객, 연소기, 상품, 일회성, 요금 ]
			// 620 : 전출 [ 고객, 연소기, 정산,  일회성, 요금 ]
			// 630 : 중지 [ 고객, 정산, 중지, 일회성, 요금 ]
			// 640 : 해제 [ 고객, 해제, 일회성, 요금 ]
			// 650 : 교체 [ 고객, 연소기, 일회성, 요금 ]
			// 660 : 점검 [ 고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
			// 690 : 전출 [ 고객, 연소기, 일회성, 완료 ]
			Mem_Set((byte*)&sX , 0x00, sizeof(sX));
			Mem_Set((byte*)&eX , 0x00, sizeof(eX));
			
			if( g_nWorkFlag == 640 || g_nWorkFlag == 690 )			
			{
				TABCNT = 4;
				lenX = CWD*10;
				
				sX[0] = 0;
			}
			else if(g_nWorkFlag == 660)
			{
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
					TABCNT = 6;
					lenX = 166;
				}
				else{
					TABCNT = 5;
					lenX = 200;
				}
				
				sX[0] = 0;
			}
			else if(g_nWorkFlag == 650)
			{	//연소기 업무 중 배관/계량기 또는 해제인애들은 상품탭 제외
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) == 0 || Str_Cmp (stMw.szCont_sts_cd, "30") == 0 || Str_Cmp (stMw.szCont_sts_cd, "20") == 0) 
				{
					TABCNT = 4;
					lenX = CWD*10;
				}
				else {
					TABCNT = 5;
					lenX = CWD*8;
				}
				
				sX[0] = 0;
			}
			else
			{
				TABCNT = 5;
				lenX = CWD*8;
				
				sX[0] = 0;
			}
			
			for(i = 0 ; i < TABCNT ; i++)
			{
				eX[i] = sX[i] + lenX;
				sX[i+1] = eX[i];
			}
			
			starty = STARTY-29;
			highty = STARTY+40;
			
			i = 0;
			
			// 업무별공통 업무[고객, 계량기, 연소기]
			if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  "누설점검" );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  stMw.szPda_duty );
			}
			
			// 각 업무에 따라 탭을 없앰
			// 610 : 전입 [ 고객, 연소기, 상품, 일회성, 요금 ]
			if( g_nWorkFlag == 610 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE); // 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE);  // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);  // 확인
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );	
			}
			// 620 : 전출 [ 고객, 연소기, 정산,  일회성, 요금 ]
			else if( g_nWorkFlag == 620 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE); // 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE);  // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);  // 확인
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST),sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "정산" );
			}
			// 630 : 중지 [ 고객, 정산, 중지, 일회성, 요금 ]
			else if( g_nWorkFlag == 630 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);  // 연소기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE); // 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE);  // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);  // 확인
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WSTOP), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "정산" );
			}
			// 640 : 해제 [ 고객, 해제, 일회성, 요금 ]
			else if( g_nWorkFlag == 640 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);  // 연소기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);  // 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE);  // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);  // 확인
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WRELE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );	
			}
			// 650 : 교체 [ 고객, 연소기, 일회성, 요금 ]
			else if( g_nWorkFlag == 650 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE); // 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE);  // 점검
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);  // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);  // 확인
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) != 0)
				{
					if(Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
						BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
						i++;
					}
				}
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );
			}
			// 660 : 점검 [ 고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
			else if( g_nWorkFlag == 660 )
			{	
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);  // 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE); // 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);  // 확인
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0){
					BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
					i++;
				}
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCHK), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );
			}
			// 690 : 전출 [ 고객, 연소기, 일회성, 완료 ]
			else if( g_nWorkFlag == 690 )
			{	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);  // 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE); // 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WPAY), FALSE);  // 요금
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE);  // 확인
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WFIN), sX[i], starty, eX[i], highty ); // 완료
			}
			// 선택된 탭을 활성화된것처럼 보이게 함.			
			// EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[0]+4, highty-5, eX[0]-4, highty+5 );
		}
		else
		{
			// 타이틀
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}

	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		long i;
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// 610 : 전입 [ 고객, 연소기, 상품, 일회성, 요금 ]
			if( g_nWorkFlag == 610 )
			{
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_EMAIL_AT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DEADLINEFLAG), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GMTRBASEDAY), EDITALIGN_MIDDLE);

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
				
				// 연계여부
				if( Str_Cmp( stMw.szInfo_Trans_yn, "Y" ) == 0 )
				{
					DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_INFO_TRANS_YN_INFO), TRUE);
					DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_INFO_TRANS_YN_Y), TRUE);
					DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_INFO_TRANS_YN_N), TRUE);
				}
				else
				{
					DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_INFO_TRANS_YN_INFO), FALSE);
					DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_INFO_TRANS_YN_Y), FALSE);
					DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_INFO_TRANS_YN_N), FALSE);
				}
			}
			// 이외
			else
			{
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_USE_CONT_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USE_CONT_NUM), EDITALIGN_MIDDLE);
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_CUST_TRND_CD+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_SQUARE_METER+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BUILT_IN_Y), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BUILT_IN_N), FALSE );
				EditCtrl_SetBkColorEx( Get_hDlgCtrlByID(CMB_SQUARE_METER), TXTINCTRLBK);
				EditCtrl_SetBkColorEx( Get_hDlgCtrlByID(CMB_CUST_TRND_CD), TXTINCTRLBK);
				ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(CMB_SQUARE_METER+1), TXTINCTRLBK);
				ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(CMB_CUST_TRND_CD+1), TXTINCTRLBK);
			}
			
			// 공통
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUST_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUST_NM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SOC_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_OWNHOUSE_TEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_FIRM_NM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUST_TRND_CD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_FAMILY_CNT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SQUARE_METER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BUILT_IN_YN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_EMAIL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUST_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUST_NM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SOC_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CP_DDD), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CP_EXN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CP_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FIRM_NM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CUST_TRND_CD), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FAMILY_CNT), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SQUARE_METER), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_EMAIL), EDITALIGN_MIDDLE);
			
			// 성향 콤보박스
			for ( i = 0 ;  SCTRND_CD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CUST_TRND_CD+2), SCTRND_CD[i].Str, 0, ICON_NONE);
			}
			
			//평수 콤보박스
			for ( i = 0 ;  SCSQUARE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SQUARE_METER+2), SCSQUARE[i].Str, 0, ICON_NONE);
			}
			
			// 이메일 콤보박스
			if( g_nWorkFlag == 610 )
			{
				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_EMAIL), EDITALIGN_MIDDLE);
				
				for ( i = 0 ;  SCEMAIL[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_EMAIL+2), SCEMAIL[i].Str, 0, ICON_NONE);
				}
			}
			
		}
		/********************************/
		/* 이전계약정보                 */
		/********************************/
		else if( m_bFirst == INIT_PRECUST )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA01), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA02), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA03), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA01), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA02), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA03), EDITALIGN_MIDDLE);
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
		long i, n, length, k;
		long len = 0;
		char sztmp[128];
		char szSql[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;	
		
		if( g_lDataflag == 0 )
		{
			g_lDataflag = 1;
			
			i = 0;
			
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			SPRINT(szSql, "SELECT COUNT(*) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetInt(szSql, &i);
			
			if( i > 1 )
			{
				MessageBoxEx (CONFIRM_OK, "설치된 계량기는 1개인데 계량기가 2개이상 조회된 경우 자료를 재수신해주시기 바랍니다.");
				ON_DRAW();
			}
		}
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{	
			/*********** 전입 ************/	
			if( g_nWorkFlag == 610 )
			{
				if( g_nCustFlag == 0 )
				{
					// 고객정보 Read
					Read_CustInfo();
										
					// 임시고객인 경우 수정불가
					if( stMw.szCust_num[0] != '0' && Str_Len(stMw.szCust_num ) > 0 )
					{
						if( Str_Len(stMw.szCp_ddd) == 0)
						{
							Str_Cpy(stMw.szCp_ddd , stMw.szReq_cp_ddd);
							Str_Cpy(stMw.szCp_exn , stMw.szReq_cp_exn);
							Str_Cpy(stMw.szCp_num , stMw.szReq_cp_num);
						}
						
						if( Str_Len(stMw.szOwnhouse_tel_ddd) == 0)
						{
							Str_Cpy(stMw.szOwnhouse_tel_ddd , stMw.szReq_tel_ddd);
							Str_Cpy(stMw.szOwnhouse_tel_exn , stMw.szReq_tel_exn);
							Str_Cpy(stMw.szOwnhouse_tel_num , stMw.szReq_tel_num);
						}
					}
					
					g_nCustFlag = 1;
				}
				
				// 임시고객인 경우 수정불가
				if(stMw.szCust_num[0] == '0' || Str_Len(stMw.szCust_num) == 0)
				{					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CUST_NM), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_CUST_NM), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_SOC_NUM), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_CP_DDD), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_CP_EXN), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_CP_NUM), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_FIRM_NM), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_FIRM_NM), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_FAMILY_CNT), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_EMAIL), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_EMAIL), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_EMAIL), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_EMAIL+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_CUST_TRND_CD+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_SQUARE_METER+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_EMAIL+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BUILT_IN_Y), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BUILT_IN_N), FALSE );	
				}
				
				// 고객 번호
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Cpy( (byte*)sztmp, (byte*)stMw.szTrans_in_cust_num, 5 );
				Str_Cat( sztmp, "-" );
				Str_Cat( sztmp, stMw.szTrans_in_cust_num + 5 );
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CUST_NUM), sztmp);	
				
				// 이전계약 버튼
				if( Str_AtoI(m_szUnpay_amt) > 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PRECUST), TRUE );
					DlgCtrl_SetGray(this->m_hDlg, Get_iDlgCtrlByID(BID_PRECUST), FALSE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PRECUST), FALSE );
					DlgCtrl_SetGray(this->m_hDlg, Get_iDlgCtrlByID(BID_PRECUST), TRUE );
				}
				
				// 연계
				if( Str_Cmp( stMw.szSend_Info_Trans_yn, "Y" ) == 0 )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_Y), INFO_TRANS_Y2);
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_N), INFO_TRANS_N1);
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_Y), INFO_TRANS_Y1);
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_INFO_TRANS_YN_N), INFO_TRANS_N2);
				}
					
			}
			/*********** 전입 이외 ************/
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Cpy( (byte*)sztmp, (byte*)stMw.szUse_cont_num, 5);
				Str_Cat( sztmp, "-");
				Str_Cat( sztmp, stMw.szUse_cont_num+5);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USE_CONT_NUM), sztmp);
				
				// 임시고객인 경우 빨간색 표기
				if(stMw.szCust_num[0] == '0' )
				{
					EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_CUST_NUM), RED);
					EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_CUST_NM), RED);
				}

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Cpy( (byte*)sztmp, (byte*)stMw.szCust_num, 5);
				Str_Cat( sztmp, "-");
				Str_Cat( sztmp, stMw.szCust_num+5);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CUST_NUM), sztmp);	
			}
			
			// 지번주소
			if( g_nAddrFlag == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지 번\n주 소");
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szCounty);
				Str_Cat( sztmp," " );
				Str_Cat( sztmp, stMw.szTown);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), sztmp);
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szVillage_ri);
				Str_Cat( sztmp," " );
				Str_Cat( sztmp, stMw.szAddr1_m);
				Str_Cat( sztmp,"-" );
				Str_Cat( sztmp, stMw.szAddr1_s);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR2), sztmp);
			}
			// 도로명 주소
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주 소");
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szCounty);
				Str_Cat( sztmp," " );
				Str_Cat( sztmp, stMw.szLaw_town);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), sztmp);
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szNew_road_nm);
				Str_Cat( sztmp," " );
				Str_Cat( sztmp, stMw.szNew_addr_m);
				Str_Cat( sztmp,"-" );
				Str_Cat( sztmp, stMw.szNew_addr_s);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR2), sztmp);
			}
			
			// 건물 명
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
			if( ( Str_Len(stMw.szVillage) + Str_Len(stMw.szBuilding) ) > 0 )
			{
				Str_Cpy( sztmp, stMw.szVillage);
				Str_Cat( sztmp," " );
				Str_Cat( sztmp, stMw.szBuilding);
				Str_Cat( sztmp,"-" );
				Str_Cat( sztmp, stMw.szHouse_cnt);
				Str_Cat( sztmp," " );
				Str_Cat( sztmp, stMw.szEtc_addr);
			}
			else
			{
				Str_Cpy( sztmp, stMw.szHouse_cnt);
				Str_Cat( sztmp," " );
				Str_Cat( sztmp, stMw.szEtc_addr);
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR3), sztmp);
				
			// 고객명		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CUST_NM), stMw.szCust_nm);
			
			// 생년월일
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Cpy( (byte*)sztmp, (byte*)stMw.szSoc_num, 6 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_SOC_NUM), sztmp);
			
			// 핸드폰
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CP_DDD), stMw.szCp_ddd);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CP_EXN), stMw.szCp_exn);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CP_NUM), stMw.szCp_num);
			
			// 전화
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD), stMw.szOwnhouse_tel_ddd);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN), stMw.szOwnhouse_tel_exn);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM), stMw.szOwnhouse_tel_num);
			
			// 상호
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_FIRM_NM), stMw.szFirm_nm);
			
			// 가족수
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_FAMILY_CNT), stMw.szFamily_cnt);
			
			if( g_nWorkFlag == 610 )
			{
				// 납기일, 검침일
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_GMTRBASEDAY), stMw.szGmtr_base_day);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DEADLINEFLAG), stMw.szDeadline_flag);
				
				// 이메일
				length = Str_Len(stMw.szEmail);
				
				if( length > 0 )
				{
					for( i = 0; i < length; i++ )
					{
						len = 0;
						
						if(stMw.szEmail[i] == '@')
						{
							len = i;
							break;
						}
					}
					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
					
					if( len > 0 )
					{
						Mem_Cpy((byte *)sztmp, (byte *)stMw.szEmail, len);
					} 
					else 
					{
						Str_Cpy(sztmp, stMw.szEmail);
					}
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_EMAIL), sztmp);
					
					if( len > 0 && length-(len+1) > 0 )
					{
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Cpy((byte *)sztmp, (byte *)stMw.szEmail+(len+1), length-(len+1) );
						
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_EMAIL), sztmp);
					}
				}
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_EMAIL),      stMw.szEmail);
			}
			
			// 성향
			n = g_SearchCD( stMw.szCust_trnd_cd, SCTRND_CD );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CUST_TRND_CD), SCTRND_CD[n].Str);
			
			// 평수
			n = g_SearchCD( stMw.szSquare_meter, SCSQUARE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SQUARE_METER), SCSQUARE[n].Str);
			
			// 빌트인	
			if( stMw.szBuilt_in_yn[0] == 'Y' )
			{
				m_lbilutin_flag = 1;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_N), CHK_N1);
			}
			else if( stMw.szBuilt_in_yn[0] == 'N' )
			{
				m_lbilutin_flag = 0;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_N), CHK_N2);
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BUILT_IN_N), CHK_N1);
			}
		}
		/********************************/
		/* 이전계약정보                 */
		/********************************/	
		else if( m_bFirst == INIT_PRECUST )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA01), m_szUse_cont_num);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA02), m_szCnt);
			Str_Chg(m_szUnpay_amt, STRCHG_INS_COMMA );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA03), m_szUnpay_amt);
		}
	}
	
	/*=======================================================================================
	함수명 : Read_CustInfo
	기  능 : 고객정보 Read
	Param  : 
	Return : 
	========================================================================================*/
	void Read_CustInfo(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		// 초기화
		Mem_Set((byte*)m_szUse_cont_num, 0x00, sizeof(m_szUse_cont_num) );
		Mem_Set((byte*)m_szCnt, 0x00, sizeof(m_szCnt) );
		Mem_Set((byte*)m_szUnpay_amt, 0x00, sizeof(m_szUnpay_amt) );
		Mem_Set((byte*)stMw.szCust_nm          , 0x00, sizeof(stMw.szCust_nm          ));
		Mem_Set((byte*)stMw.szSoc_num          , 0x00, sizeof(stMw.szSoc_num          ));
		Mem_Set((byte*)stMw.szCp_ddd           , 0x00, sizeof(stMw.szCp_ddd           ));
		Mem_Set((byte*)stMw.szCp_exn           , 0x00, sizeof(stMw.szCp_exn           ));
		Mem_Set((byte*)stMw.szCp_num           , 0x00, sizeof(stMw.szCp_num           ));
		Mem_Set((byte*)stMw.szOwnhouse_tel_ddd , 0x00, sizeof(stMw.szOwnhouse_tel_ddd ));
		Mem_Set((byte*)stMw.szOwnhouse_tel_exn , 0x00, sizeof(stMw.szOwnhouse_tel_exn ));
		Mem_Set((byte*)stMw.szOwnhouse_tel_num , 0x00, sizeof(stMw.szOwnhouse_tel_num ));
		Mem_Set((byte*)stMw.szFirm_nm          , 0x00, sizeof(stMw.szFirm_nm          ));
		Mem_Set((byte*)stMw.szFamily_cnt       , 0x00, sizeof(stMw.szFamily_cnt       ));
		Mem_Set((byte*)stMw.szEmail            , 0x00, sizeof(stMw.szEmail            ));
		Mem_Set((byte*)stMw.szCust_trnd_cd     , 0x00, sizeof(stMw.szCust_trnd_cd     ));
		Mem_Set((byte*)stMw.szCust_num         , 0x00, sizeof(stMw.szCust_num         ));
		Mem_Set((byte*)stMw.szBiz_regi_num     , 0x00, sizeof(stMw.szBiz_regi_num     ));
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, " SELECT USE_CONT_NUM, CNT, UNPAY_AMT, TRIM(CUST_NM), TRIM(SOC_NUM) \
		                                         , TRIM(CP_DDD), TRIM(CP_EXN), TRIM(CP_NUM), TRIM(OWNHOUSE_TEL_DDD), TRIM(OWNHOUSE_TEL_EXN) \
                                                 , TRIM(OWNHOUSE_TEL_NUM), FIRM_NM, FAMILY_CNT, EMAIL, CUST_TRND_CD \
                                                 , CUST_NUM, BIZ_REGI_NUM \
                                              FROM C6101_PRE_CUST_INFO WHERE PROMISE_ASSIGN_SEQ = ? ");
	
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		
		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			idx++;
			
			sql->GetValue( sql, i++, 'U', (long*)m_szUse_cont_num        , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)m_szCnt                 , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)m_szUnpay_amt           , 14 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_nm          , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSoc_num          , 13 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_ddd           , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_exn           , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_num           , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_ddd , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_exn , 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_num , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_nm          , 50 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFamily_cnt       , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEmail            , 50 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_trnd_cd     , 2  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_num         , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBiz_regi_num     , 10 + 1, DECRYPT );
		}
		
		if( idx == 0 )
		{
			Mem_Set((byte*)m_szUse_cont_num        , 0x00, sizeof(m_szUse_cont_num        ));
			Mem_Set((byte*)m_szCnt                 , 0x00, sizeof(m_szCnt                 ));
			Mem_Set((byte*)m_szUnpay_amt           , 0x00, sizeof(m_szUnpay_amt           ));
			Mem_Set((byte*)stMw.szCust_nm          , 0x00, sizeof(stMw.szCust_nm          ));
			Mem_Set((byte*)stMw.szSoc_num          , 0x00, sizeof(stMw.szSoc_num          ));
			Mem_Set((byte*)stMw.szCp_ddd           , 0x00, sizeof(stMw.szCp_ddd           ));
			Mem_Set((byte*)stMw.szCp_exn           , 0x00, sizeof(stMw.szCp_exn           ));
			Mem_Set((byte*)stMw.szCp_num           , 0x00, sizeof(stMw.szCp_num           ));
			Mem_Set((byte*)stMw.szOwnhouse_tel_ddd , 0x00, sizeof(stMw.szOwnhouse_tel_ddd ));
			Mem_Set((byte*)stMw.szOwnhouse_tel_exn , 0x00, sizeof(stMw.szOwnhouse_tel_exn ));
			Mem_Set((byte*)stMw.szOwnhouse_tel_num , 0x00, sizeof(stMw.szOwnhouse_tel_num ));
			Mem_Set((byte*)stMw.szFirm_nm          , 0x00, sizeof(stMw.szFirm_nm          ));
			Mem_Set((byte*)stMw.szFamily_cnt       , 0x00, sizeof(stMw.szFamily_cnt       ));
			Mem_Set((byte*)stMw.szEmail            , 0x00, sizeof(stMw.szEmail            ));
			Mem_Set((byte*)stMw.szCust_trnd_cd     , 0x00, sizeof(stMw.szCust_trnd_cd     ));
			Mem_Set((byte*)stMw.szCust_num         , 0x00, sizeof(stMw.szCust_num         ));
			Mem_Set((byte*)stMw.szBiz_regi_num     , 0x00, sizeof(stMw.szBiz_regi_num     ));
		}
		
Finally:
		DelSqLite(sql);
	}
	
	/*=======================================================================================
	함수명 : Save_Cust
	기  능 : 고객정보 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Cust(void)
	{
		char sztmp[64];
		long i;
	
		if( g_nWorkFlag == 610 )
		{
			Mem_Set((byte*)stMw.szCust_nm, 0x00, sizeof(stMw.szCust_nm) );
			Mem_Set((byte*)stMw.szSoc_num, 0x00, sizeof(stMw.szSoc_num) );
			Mem_Set((byte*)stMw.szCp_ddd, 0x00, sizeof(stMw.szCp_ddd) );
			Mem_Set((byte*)stMw.szCp_exn, 0x00, sizeof(stMw.szCp_exn) );
			Mem_Set((byte*)stMw.szCp_num, 0x00, sizeof(stMw.szCp_num) );
			Mem_Set((byte*)stMw.szOwnhouse_tel_ddd, 0x00, sizeof(stMw.szOwnhouse_tel_ddd) );
			Mem_Set((byte*)stMw.szOwnhouse_tel_exn, 0x00, sizeof(stMw.szOwnhouse_tel_exn) );
			Mem_Set((byte*)stMw.szOwnhouse_tel_num, 0x00, sizeof(stMw.szOwnhouse_tel_num) );
			Mem_Set((byte*)stMw.szFirm_nm, 0x00, sizeof(stMw.szFirm_nm) );
			Mem_Set((byte*)stMw.szFamily_cnt, 0x00, sizeof(stMw.szFamily_cnt) );
			Mem_Set((byte*)stMw.szEmail, 0x00, sizeof(stMw.szEmail) );
			Mem_Set((byte*)stMw.szCust_trnd_cd, 0x00, sizeof(stMw.szCust_trnd_cd) );
			Mem_Set((byte*)stMw.szSquare_meter, 0x00, sizeof(stMw.szSquare_meter) );
			Mem_Set((byte*)stMw.szGmtr_base_day, 0x00, sizeof(stMw.szGmtr_base_day) );
			Mem_Set((byte*)stMw.szDeadline_flag, 0x00, sizeof(stMw.szDeadline_flag) );
		
			Str_Cpy( stMw.szCust_nm,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CUST_NM)) );
			Str_Cpy( stMw.szSoc_num,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_SOC_NUM)) );
			Str_Cpy( stMw.szCp_ddd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_DDD)) );
			Str_Cpy( stMw.szCp_exn, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_EXN)) );
			Str_Cpy( stMw.szCp_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_NUM)) );
			Str_Cpy( stMw.szOwnhouse_tel_ddd,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD)) );
			Str_Cpy( stMw.szOwnhouse_tel_exn,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN)) );
			Str_Cpy( stMw.szOwnhouse_tel_num,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM)) );

			Str_Cpy( stMw.szFirm_nm,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_FIRM_NM)) );
			Str_Cpy( stMw.szFamily_cnt,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_FAMILY_CNT)) );
			Str_Cpy( stMw.szEmail,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_EMAIL)) );
			
			Str_Cpy( stMw.szGmtr_base_day,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_GMTRBASEDAY)) );
			Str_Cpy( stMw.szDeadline_flag,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DEADLINEFLAG)) );
			
			if( Str_Len( stMw.szSoc_num ) == 6 )
			{
				Str_Cat( stMw.szSoc_num, "0000000");
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_EMAIL))  > 0 )
			{
				Str_Cat( stMw.szEmail,"@");
				Str_Cat( stMw.szEmail,EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_EMAIL)) );
			}
			
			//성향
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CUST_TRND_CD) ) );
			
			i = g_SearchStr( sztmp, SCTRND_CD );
			
			if (i == -1)
			{
				Str_Cpy(stMw.szCust_trnd_cd, "");
			}
			else
			{
				Str_Cpy(stMw.szCust_trnd_cd, SCTRND_CD[i].Code);
			}
			
			// 평수
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SQUARE_METER) ) );
			
			i = g_SearchStr( sztmp, SCSQUARE );
			
			if (i == -1)
			{
				Str_Cpy(stMw.szSquare_meter, "");
			}
			else
			{
				Str_Cpy(stMw.szSquare_meter, SCSQUARE[i].Code);
			}
			
			// 생년월일 없을 경우 
			if( Str_Len(stMw.szSoc_num) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "주민번호 확인.");
			}
		}
	}
	
	/*=======================================================================================
	함수명 : Chk_Custinfo
	기  능 : 고객정보를 확인하는 함수
	Param  : 
	Return : 
	========================================================================================*/
	bool Chk_Custinfo(void)
	{
		long cnt1 = 0;
		long cnt2 = 0;	
		char temp[20];
		
		if( g_nWorkFlag == 610 && stMw.szCust_num[0] != '0' )
		{
			if( Str_Cmp( stMw.szCp_ddd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_DDD)) ) != 0 
			 || Str_Cmp( stMw.szCp_exn, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_EXN)) ) != 0 
			 || Str_Cmp( stMw.szCp_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_NUM)) ) != 0 )
			{
				if( !g_CheckPhoneNumber( "1", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_DDD)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_EXN)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CP_NUM)) ) )
				{
					MessageBoxEx (CONFIRM_OK, "고객님의 핸드폰번호\n형식이 맞지않습니다.");
					return FALSE;
				}
			}
			
			if( Str_Cmp( stMw.szOwnhouse_tel_ddd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD)) ) != 0
			 || Str_Cmp( stMw.szOwnhouse_tel_exn, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN)) ) != 0
			 || Str_Cmp( stMw.szOwnhouse_tel_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM)) ) != 0 )
			{
				if( !g_CheckPhoneNumber( "2", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_DDD)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_EXN)), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_OWNHOUSE_TEL_NUM)) ) )
				{
					MessageBoxEx (CONFIRM_OK, "고객님의 자택전화번호\n형식이 맞지않습니다.");
					return FALSE;
				}
			}
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Snd_FR68304
	기  능 : 전입지이관 항목 Select / FR68304
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_FR68304(void)
	{
		char sztmp[128];
		char szUrl[200];
		char szbuf[128];
		char szMsg[351];
		char szUMsg[701];
		char* sndbuf;
		long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szUMsg, 0x00, sizeof(szUMsg) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68304, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR68304; 
		ret = HTTP_DownloadData(szUrl, "FR68304_IN",  "FR68304" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Rcv_FR68304
	기  능 : CallBack FR68304
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_FR68304(void)
	{
		long ret = 0;
		
		ret = Chk_Json_68304();
		
		g_Sock_Close();
		
		if( ret >= 0)
		{		
			MessageBoxEx (CONFIRM_OK, m_szTrans_info_rslt);
			
			ON_DRAW();
			return 1;
		}
		else
		{	
			ON_DRAW();	
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Chk_Json_68304
	기  능 : FR68304 전송 결과 파일을 검토한다.
	Param  : 
	Return : 1:정상적인 통신완료, 0: 에러응답or응답형식오류, -1: 알수없는 에러
	========================================================================================*/
	long Chk_Json_68304(void)
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
		
		/* FR68304에서 받아오는 변수 선언 */
		char *szRslt= NULL;
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 68304, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 68304, 0 );
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
			szRslt		= JSON_GetValue (g_pjcomm, "rslt", szType);
			
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
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szRslt);
				
				Mem_Set((byte*) m_szTrans_info_rslt, 0x00, sizeof( m_szTrans_info_rslt) );
				Str_Cpy( m_szTrans_info_rslt, szTmp );
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
}
