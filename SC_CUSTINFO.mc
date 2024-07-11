/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_CUSTINFO
	Card Desc : 고객정보
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_CUSTINFO
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

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/*  공통                        */
		/********************************/
		DEF_BUTTON_ID ( BID_HOME )		// 홈
		DEF_BUTTON_ID ( BID_MENU )		// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )	// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	// 공통업무
		DEF_BUTTON_ID ( BID_PREV )		// 이전
		DEF_BUTTON_ID ( BID_EXIT )		// 종료
		
		/********************************/
		/* 고객1                        */
		/********************************/
		DEF_BUTTON_ID ( BID_CLIENT )	// 고객1
		DEF_BUTTON_ID ( BID_CLIENT2 )	// 고객2
		DEF_BUTTON_ID ( BID_CUSTPTRN)	// 고객패턴
		DEF_BUTTON_ID ( BID_SMSREQ)		// SMS신청
		DEF_BUTTON_ID ( BID_OK )		// 확인
		DEF_BUTTON_ID ( BID_REQ )		// 청구방법
		
		/********************************/
		/* SMS신청                      */
		/********************************/
		DEF_BUTTON_ID ( BID_ADDR )		// 주소
		DEF_BUTTON_ID ( BID_BOX1 )		// 예
		DEF_BUTTON_ID ( BID_BOX2 )		// 아니오
		DEF_BUTTON_ID ( BID_ENTRY )	 	// 등록
		DEF_BUTTON_ID ( BID_CANCEL ) 	// 취소
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* 공통                         */
		/********************************/
		DEF_OBJECT_ID ( ICON_TITLE )	// 타이틀
		DEF_OBJECT_ID ( TXT_TITLE )		// 타이틀
		
		/********************************/
		/* 고객1                        */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA1 )		// ST_사용계약
		DEF_OBJECT_ID ( TXT_DATA2 )		// TXT_사용계약번호
		DEF_OBJECT_ID ( TXT_DATA3 )		// TXT_사용계약상태
		DEF_OBJECT_ID ( TXT_DATA4 )		// ST_고객명
		DEF_OBJECT_ID ( TXT_DATA5 )		// ST_유형
		DEF_OBJECT_ID ( TXT_DATA6 )		// ST_성향
		DEF_OBJECT_ID ( TXT_DATA8 )		// ST_핸드폰번호1
		DEF_OBJECT_ID ( TXT_DATA9 )		// ST_핸드폰번호2
		DEF_OBJECT_ID ( TXT_DATA10 )	// ST_핸드폰번호3
		DEF_OBJECT_ID ( TXT_DATA11 )	// ST_자택전화1
		DEF_OBJECT_ID ( TXT_DATA12 )	// ST_자택전화2
		DEF_OBJECT_ID ( TXT_DATA13 )	// ST_자택전화3
		DEF_OBJECT_ID ( TXT_DATA14 )	// ST_빌트인
		DEF_OBJECT_ID ( TXT_DATA15 )	// ST_주소
		DEF_OBJECT_ID ( TXT_DATA16 )	// ST_번지
		DEF_OBJECT_ID ( TXT_DATA17 )	// ST_호수
		DEF_OBJECT_ID ( TXT_DATA18 )	// ST_세대호수
		DEF_OBJECT_ID ( TXT_DATA19 )	// ST_기타주소
		DEF_OBJECT_ID ( TXT_DATA20 )	// TXT_고객명	
		DEF_OBJECT_ID ( TXT_DATA22 )	// TXT_번지
		DEF_OBJECT_ID ( TXT_DATA23 )	// TXT_호수
		DEF_OBJECT_ID ( TXT_DATA24 )	// TXT_세대호수
		DEF_OBJECT_ID ( TXT_DATA25 )	// TXT_기타주소
		DEF_OBJECT_ID ( TXT_DATA41 )	// ST_생년월일
		DEF_OBJECT_ID ( TXT_DATA42 )	// TXT_생년월일
		DEF_OBJECT_ID ( TXT_DATA55 ) 	// ST_인덕션
		DEF_OBJECT_ID ( TXT_DATA56 ) 	// ST_사회복지시설
		DEF_OBJECT_ID ( TXT_DATA57 ) 	// TXT_유형
		
		/********************************/
		/* 고객2                        */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA26 )	// ST_회사번호1
		DEF_OBJECT_ID ( TXT_DATA27 )	// ST_회사번호2
		DEF_OBJECT_ID ( TXT_DATA28 )	// ST_회사번호3
		DEF_OBJECT_ID ( TXT_DATA29 )	// ST_팩스1
		DEF_OBJECT_ID ( TXT_DATA30 )	// ST_팩스2
		DEF_OBJECT_ID ( TXT_DATA31 )	// ST_팩스3
		DEF_OBJECT_ID ( TXT_DATA32 )	// ST_사업자번호
		DEF_OBJECT_ID ( TXT_DATA33 )	// ST_상호
		DEF_OBJECT_ID ( TXT_DATA34 )	// ST_이메일1
		DEF_OBJECT_ID ( TXT_DATA35 )	// ST_이메일2
		DEF_OBJECT_ID ( TXT_DATA36 )	// ST_면적
		DEF_OBJECT_ID ( TXT_DATA37 )	// ST_가족수
		DEF_OBJECT_ID ( TXT_DATA38 )	// ST_당사관계
		DEF_OBJECT_ID ( TXT_DATA39 )	// TXT_사업자번호
		DEF_OBJECT_ID ( TXT_DATA40 )	// TXT_상호
		
		/********************************/
		/* SMS신청                      */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA43 )	// ST_◎SMS사전안내 서비스 신청
		DEF_OBJECT_ID ( TXT_DATA44 )	// ST_고객성명
		DEF_OBJECT_ID ( TXT_DATA45 )	// TXT_고객성명
		DEF_OBJECT_ID ( TXT_DATA46 )	// TXT_주소
		DEF_OBJECT_ID ( TXT_DATA47 )	// ST_신청자명
		DEF_OBJECT_ID ( TXT_DATA48 )	// TXT_신청자명
		DEF_OBJECT_ID ( TXT_DATA49 )	// ST_H.P1
		DEF_OBJECT_ID ( TXT_DATA50 )	// ST_H.P2
		DEF_OBJECT_ID ( TXT_DATA51 )	// ST_H.P3
		DEF_OBJECT_ID ( TXT_DATA52 )	// ST_개인정보 수집
		DEF_OBJECT_ID ( TXT_DATA53 )	// ST_예
		DEF_OBJECT_ID ( TXT_DATA54 )	// ST_아니오
		
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
		/* 라인                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA_1 )	// 라인_1
		DEF_OBJECT_ID ( LINE_DATA_2 )	// 라인_2
		DEF_OBJECT_ID ( LINE_DATA_3 )	// 라인_3
		DEF_OBJECT_ID ( LINE_DATA_4 )	// 라인_4
		
		/********************************/
		/* EDIT                         */
		/********************************/
		// 고객
		DEF_OBJECT_ID ( EDT_DATA1 )		// EDT_핸드폰번호1
		DEF_OBJECT_ID ( EDT_DATA2 )		// EDT_핸드폰번호2
		DEF_OBJECT_ID ( EDT_DATA3 )		// EDT_자택번호1
		DEF_OBJECT_ID ( EDT_DATA4 )		// EDT_자택번호2
		DEF_OBJECT_ID ( EDT_DATA5 )		// EDT_회사번호1
		DEF_OBJECT_ID ( EDT_DATA6 )		// EDT_회사번호2
		DEF_OBJECT_ID ( EDT_DATA7 )		// EDT_팩스번호1
		DEF_OBJECT_ID ( EDT_DATA8 )		// EDT_팩스번호2
		DEF_OBJECT_ID ( EDT_DATA9 )		// EDT_이메일
		DEF_OBJECT_ID ( EDT_DATA10 )	// EDT_가족수

		// SMS신청
		DEF_OBJECT_ID ( EDT_DATA11 )	// EDT_H.P1
		DEF_OBJECT_ID ( EDT_DATA12 )	// EDT_H.P2
		
		/********************************/
		/* COMBO BOX                    */
		/********************************/
		// 고객
		DEF_OBJECT_ID ( CMB_DATA1 )					// 유형(사용안함 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )	// 성향
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 )	// 핸드폰번호
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 )	// 자택번호
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4+3 )	// 빌트인
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA5+3 )	// 회사번호
		DEF_OBJECT_ID ( CMB_DATA7 = CMB_DATA6+3 )	// 팩스
		DEF_OBJECT_ID ( CMB_DATA8 = CMB_DATA7+3 )	// 이메일
		DEF_OBJECT_ID ( CMB_DATA9 = CMB_DATA8+3 )	// 면적
		DEF_OBJECT_ID ( CMB_DATA10 = CMB_DATA9+3 )	// 당사관계
		DEF_OBJECT_ID ( CMB_DATA12 = CMB_DATA10+3 )	// 상호명
		DEF_OBJECT_ID ( CMB_DATA13 = CMB_DATA12+3 )	// 인덕션
		DEF_OBJECT_ID ( CMB_DATA14 = CMB_DATA13+3 )	// 사회복지시설
		
		// SMS신청
		DEF_OBJECT_ID ( CMB_DATA11 = CMB_DATA14+3 )	// H.P
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define	EDITSETRANGE( h, x1, y1, x2, y2 ) EditCtrl_SetRange( h, DMS_X(x1), DMS_Y(y1), DMS_X(x2), DMS_Y(y2) )
	#define INIT_MAIN 1
	#define INIT_SMSREQ 2
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	handle m_hDlg;				// 다이얼로그
	long m_lCnt = 0;			// NORMAL_CUSTINFO CNT
	long m_nOptionSet = 0;		// m_nOptionSet == 0 고객1, m_nOptionSet == 1 고객2	
	long m_bFirst;				// 화면
	long m_lDrawFlag = 0;		// 최초진입여부
	long m_lActiveIndex = -1;
	long m_lSmsReqFlag = 0;		// 동의여부
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	// 고객
	void SetStyle(void);		// Style Setting
	void SetStruct(void);		// 디비자료를 로컬 스트럭쳐에 저장
	void SetCombo(void);		// ComboBox Setting
	void SetBtnImg(void);		// 버튼img
	void REDRAW(void);			// 로컬 스트럭쳐 디스플레이
	void Cust_SetData(void);	// Normal_Cust에 정보가 있다면 셋
	void Copy_Info(void);		// 수정된 고객 정보를 대상정보에 copy하여 업데이트
	bool Save_Cust(void);		// Normal_Info 테이블에 저장 or 업데이트
	bool Validate(void);		// 고객정보 저장 Validate
	bool Compare_Data(void);	// 기존데이터와 현재 입력되어있는 데이터 비교. 같으면 고객정보 수정을 하지 않기위해서.
	bool Chk_Ptrn(void);		// 고객패턴수집 대상 확인
	void ReqMsg(void);			// 청구방법 메세지
		
	// SMS신청
	void SMSREQ_DRAW(void);		// SMS신청 DRAW
	bool Save_SmsReq(void);		// SMS신청(서버)
	void Snd_SmsReq(void);		// SMS신청(로컬)
	long TR312314(void);		// SMS신청 전문
	
	//---------------------------------------------------------------------------------------
	// Global Button
	//---------------------------------------------------------------------------------------
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
	
	//---------------------------------------------------------------------------------------
	// 고객정보 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON( 0, BTNY_2, ICON_TITLE, "" ),
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객 정보"),
		
		DLG_TEXT  (STARTX,      STARTY +65,  230, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "사용계약"),
		DLG_TEXT  (STARTX +230, STARTY +65,  325, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), 
		DLG_TEXT  (STARTX +550, STARTY +65,  160, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 
		DLG_BUTTON(STARTX +710, STARTY +65,  290, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REQ, ""),
		
		DLG_LINE ( STARTX,      STARTY +129, 1000, STARTY +129,     DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_BUTTON(STARTX,      STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLIENT, "고객1"),
		DLG_BUTTON(STARTX +245, STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLIENT2, "고객2"),
		DLG_BUTTON(STARTX +510, STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CUSTPTRN, "고객패턴"),
		DLG_BUTTON(STARTX +755, STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SMSREQ, "SMS신청"),
		
		DLG_LINE ( STARTX,      STARTY +205, 1000, STARTY +205,     DARKSLATEBLUE, 10, LINE_DATA_2),
		
		DLG_LINE ( STARTX,      STARTY +815, 1000, STARTY +815,     DARKSLATEBLUE, 10, LINE_DATA_3),
		DLG_BUTTON(STARTX +10,  STARTY +825, 980, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_OK, "확 인"),
				
        // 고객정보_1
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA55, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA56, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA42, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA57, ""),
		
		// 고객정보_2
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA36, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA38, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA40, ""),
		
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 30,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 3,  ""),
		
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA13, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA14, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 10),
		DLG_COMBO_DWE (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA8, 20),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA9, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA10, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA12, 50),
		
		//숫자 자판
		DLG_LINE(STARTX, STARTY +906, 1000, STARTY +906, DARKSLATEBLUE, 10, LINE_DATA_4),
		DLG_TEXT(0,    STARTY+910, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT(333,  STARTY+910, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT(666,  STARTY+910, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1000, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT(333, STARTY+1000, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT(666, STARTY+1000, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT(0,   STARTY+1090, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1090, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1090, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT(333, STARTY+1180, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT(666, STARTY+1180, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "←"),
	};
	
	//---------------------------------------------------------------------------------------
	// 안전점검 SMS 신청 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_SMSREQ[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "안전점검 SMS 신청"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),

		DLG_BUTTON(STARTX,		STARTY+110, 300, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR,  "지번\n주소"),
		DLG_BUTTON(STARTX,		STARTY+600, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_BUTTON(STARTX+600,  STARTY+600, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),		
		DLG_BUTTON(STARTX,		STARTY+700, 400, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ENTRY,  "등록"),
		DLG_BUTTON(STARTX+600,  STARTY+700, 400, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "취소"),
		
		DLG_TEXT  (STARTX,		 STARTY-29, 850, 70, 0,0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, "◎SMS사전안내 서비스 신청"),
		DLG_TEXT  (STARTX,		 STARTY+50, 300, 60, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA44, "고객성명"),
		DLG_TEXT  (STARTX+300,	 STARTY+50, 700, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),
		DLG_TEXT  (STARTX+300,	STARTY+110, 700,150, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA46, ""),
		DLG_TEXT  (STARTX,		STARTY+260, 300, 60, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA47, "신청자명"),
		DLG_TEXT  (STARTX+300,	STARTY+260, 700, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA48, ""),
		
		DLG_TEXT  (STARTX,		STARTY+320, 150, 60, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA49, "H.P"),
		DLG_TEXT  (STARTX+450,	STARTY+320,  50, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA50, "-"),
		DLG_EDIT  (STARTX+500,	STARTY+320, 225, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11, 4,  ""),
		DLG_TEXT  (STARTX+725,	STARTY+320,  50, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA51, "-"),
		DLG_EDIT  (STARTX+775,	STARTY+320, 225, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA12, 4,  ""),
		
		DLG_TEXT  (STARTX,		STARTY+430, 1000,150, 0,0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA52, "개인정보 수집·이용 내용을 \n숙지하고 이에 동의하며,\n안전점검 SMS 사전안내\n서비스를 신청합니다."),
		DLG_TEXT  (STARTX+200,	STARTY+600, 200, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA53, "예"),
		DLG_TEXT  (STARTX+800,	STARTY+600, 200, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA54, "아니오"),
		
		DLG_COMBO (STARTX+150,  STARTY+320, 300, 200, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA11, 4),		
	};
	
	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
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
		
		switch (bFirst)
		{
			/******************************/
			/* 고객                       */
			/******************************/
			case INIT_MAIN:
					
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				
				if( Chk_Ptrn() )
				{
					MessageBoxEx (CONFIRM_OK, "고객패턴정보 수집대상입니다.");
					g_lPtrnFlag = 2;
					Card_Move("SC_CUSTPTRN");
					return;
				}
				
				SetCombo();
				
				if( g_lPtrnFlag != 2 )
				{
					if( m_lDrawFlag == 0)
					{
						SetStruct();
						REDRAW();
						m_lDrawFlag = 1;
					}
					else
					{
						REDRAW();
					}
				}
				else
				{
					REDRAW();
				}
				
				break;
			
			/******************************/
			/* SMS 신청                   */
			/******************************/	
			case INIT_SMSREQ:
				
				CREATE_DIALOG_OBJECT (DlgRes_SMSREQ, SIZEOF(DlgRes_SMSREQ));
				
				SetBtnImg();
				SMSREQ_DRAW();
				
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
		long i, length;
	
		switch(ID)
		{
			/******************************/
			/* 공통                       */
			/******************************/
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
				g_lSCMoveFlag = 0;
				g_lPtrnFlag = 0;
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
				
			/******************************/
			/* 고객                       */
			/******************************/
			case BID_CLIENT:
				m_nOptionSet = 0;
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_CLIENT2:
				m_nOptionSet = 1;
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_SMSREQ:
				ON_EXIT();
				OnInit(INIT_SMSREQ);
				
				break;
				
			case BID_CUSTPTRN:
				g_lPtrnFlag = 2;
				Card_Move("SC_CUSTPTRN");
				
				break;
					
			case BID_REQ:
				ReqMsg();
				
				break;
					
			case BID_OK:
				g_lPtrnFlag = 0;
				
				if( !Compare_Data() )
				{
					if( Save_Cust() )
					{
						Card_Move("SC_START");
					}
				}
				else
				{
					Card_Move("SC_START");
				}
				
				break;
				
			/******************************/
			/* SMS 신청                   */
			/******************************/
			case BID_ADDR:
				// g_nAddrFlag = 0 -> 구주소,  g_nAddrFlag = 1 -> 신주소
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				
				SMSREQ_DRAW();
				
				break;
				
			case BID_ENTRY:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Validate() )
				{
					Snd_SmsReq();
				}
				
				break;
			
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_BOX1:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				m_lSmsReqFlag = 1;
				
				break;
				
			case BID_BOX2:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
				m_lSmsReqFlag = 2;
				
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
		char sztmp[50];
		long i;
		
		if( 0 == m_nOptionSet )
		{	
			// 성향
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.CUST_TRND_CD, 0x00, sizeof(stSubCustInfo.CUST_TRND_CD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2) ) );
			
			i = g_SearchStr( sztmp, SCTRND_CD );
			
			if( i == -1 )
			{
				Str_Cpy(stSubCustInfo.CUST_TRND_CD, "");
			}
			else
			{
				Str_Cpy(stSubCustInfo.CUST_TRND_CD, SCTRND_CD[i].Code);
			}

			// 핸드폰번호 없음 처리
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA3) ) );
			
			if( Str_Cmp(sztmp, "없음") == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3),  "");
			}
			
			// 핸드폰번호 처리
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.CP_DDD, 0x00, sizeof(stSubCustInfo.CP_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA3) ) );
			
			if( Str_Cmp(stSubCustInfo.CP_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.CP_DDD, sztmp);
			}
			
			// 자택전화 없음 처리
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA4) ) );
			
			if( Str_Cmp(sztmp, "없음") == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4),  "");
			}
			
			// 자택전화 처리
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_DDD, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA4) ) );
			
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_DDD, sztmp);
			}
			
			// 빌트인여부
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.BUILT_IN_YN, 0x00, sizeof(stSubCustInfo.BUILT_IN_YN));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA5) ) );
			
			if( Str_Cmp(stSubCustInfo.BUILT_IN_YN, sztmp ) != 0 )
			{	
				i = g_SearchStr( sztmp, SCBUILT_IN );
				
				if( i == -1 )
				{
					Str_Cpy(stSubCustInfo.BUILT_IN_YN, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.BUILT_IN_YN, SCBUILT_IN[i].Code);
				}
			}
			
			// 인덕션여부
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.INDUCTION_INST_YN, 0x00, sizeof(stSubCustInfo.INDUCTION_INST_YN));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA13) ) );
			
			if( Str_Cmp(stSubCustInfo.INDUCTION_INST_YN, sztmp ) != 0 )
			{
				i = g_SearchStr( sztmp, SCBUILT_IN );
				
				if( i == -1 )
				{
					Str_Cpy(stSubCustInfo.INDUCTION_INST_YN, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.INDUCTION_INST_YN, SCBUILT_IN[i].Code);
				}
			}
			
			// 사회복지시설여부
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.FACI_STS_CD, 0x00, sizeof(stSubCustInfo.FACI_STS_CD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA14) ) );
			
			if( Str_Cmp(stSubCustInfo.FACI_STS_CD, sztmp ) != 0 )
			{
				i = g_SearchStr( sztmp, SOCIAL_FACI_STS_CD );
				
				if( i == -1 )
				{
					Str_Cpy(stSubCustInfo.FACI_STS_CD, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.FACI_STS_CD, SOCIAL_FACI_STS_CD[i].Code);
				}
			}
		}
		else if( 1 == m_nOptionSet )
		{
			// 회사번호
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.FIRM_TEL_DDD, 0x00, sizeof(stSubCustInfo.FIRM_TEL_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA6) ) );
			
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.FIRM_TEL_DDD, sztmp);
			}
			
			// 팩스
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.FAX_DDD, 0x00, sizeof(stSubCustInfo.FAX_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA7) ) );
			
			if( Str_Cmp(stSubCustInfo.FAX_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.FAX_DDD, sztmp);
			}
			
			// 이메일
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.EMAILADDR, 0x00, sizeof(stSubCustInfo.EMAILADDR));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA8) ) );
			
			if( Str_Cmp(stSubCustInfo.EMAILADDR, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.EMAILADDR, sztmp);
			}
			
			// 면적
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.SQUARE_METER, 0x00, sizeof(stSubCustInfo.SQUARE_METER));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA9) ) );
			
			i = g_SearchStr( sztmp, SCSQUARE );
			
			if( i == -1 )
			{
				Str_Cpy(stSubCustInfo.SQUARE_METER, "");
			}
			else
			{
				Str_Cpy(stSubCustInfo.SQUARE_METER, SCSQUARE[i].Code);
			}
			
			// 당사관계
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.SCG_RELAT_CD, 0x00, sizeof(stSubCustInfo.SCG_RELAT_CD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA10) ) );
			
			if( Str_Cmp(stSc.PROD_CD, "20") == 0 || Str_Cmp(stSc.PROD_CD, "21") == 0 || Str_Cmp(stSc.PROD_CD, "22") == 0 )
			{
				i = g_SearchStr( sztmp, SCRELAT );
				
				if( i == -1 )
				{
					Str_Cpy(stScCustInfo.SCG_RELAT_CD, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.SCG_RELAT_CD, SCRELAT[i].Code);
				}
			}
		}
	}
		
	/*=======================================================================================
	함수명 : OnKey
	기  능 : 키 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnKey( long nKey )
	{
		if( 0 == m_nOptionSet )
		{
			// 입력 시 자동저장
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.CP_EXN, 0x00, sizeof(stSubCustInfo.CP_EXN));
				Str_Cpy(stSubCustInfo.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.CP_NUM, 0x00, sizeof(stSubCustInfo.CP_NUM));
				Str_Cpy(stSubCustInfo.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_EXN, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_EXN));
				Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_NUM, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_NUM));
				Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			}
		}
		else if( 1 == m_nOptionSet )
		{
			if( Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FIRM_TEL_EXN, 0x00, sizeof(stSubCustInfo.FIRM_TEL_EXN));
				Str_Cpy(stSubCustInfo.FIRM_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FIRM_TEL_NUM, 0x00, sizeof(stSubCustInfo.FIRM_TEL_NUM));
				Str_Cpy(stSubCustInfo.FIRM_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FAX_EXN, 0x00, sizeof(stSubCustInfo.FAX_EXN));
				Str_Cpy(stSubCustInfo.FAX_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FAX_NUM, 0x00, sizeof(stSubCustInfo.FAX_NUM));
				Str_Cpy(stSubCustInfo.FAX_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA9) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.EMAIL, 0x00, sizeof(stSubCustInfo.EMAIL));
				Str_Cpy(stSubCustInfo.EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FAMILY_CNT, 0x00, sizeof(stSubCustInfo.FAMILY_CNT));
				Str_Cpy(stSubCustInfo.FAMILY_CNT, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
			}
			else if( Get_iDlgCtrlByID(CMB_DATA8) == m_lActiveIndex )
			{
				PRINT("@@@@@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@@@@",0,0,0);
				Mem_Set((byte*)stSubCustInfo.EMAILADDR, 0x00, sizeof(stSubCustInfo.EMAILADDR));
				Str_Cpy(stSubCustInfo.EMAILADDR, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
			}
		}
	}
	
	/*=======================================================================================
	함수명 : OnChar
	기  능 : 숫자만 입력 가능 여부
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar( long nChar )
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( 0 == m_nOptionSet )
			{
				if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.CP_EXN, 0x00, sizeof(stSubCustInfo.CP_EXN));
					Str_Cpy(stSubCustInfo.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.CP_NUM, 0x00, sizeof(stSubCustInfo.CP_NUM));
					Str_Cpy(stSubCustInfo.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_EXN, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_EXN));
					Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_NUM, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_NUM));
					Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
				}
			}
			else if( 1 == m_nOptionSet )
			{
				if( Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FIRM_TEL_EXN, 0x00, sizeof(stSubCustInfo.FIRM_TEL_EXN));
					Str_Cpy(stSubCustInfo.FIRM_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FIRM_TEL_NUM, 0x00, sizeof(stSubCustInfo.FIRM_TEL_NUM));
					Str_Cpy(stSubCustInfo.FIRM_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FAX_EXN, 0x00, sizeof(stSubCustInfo.FAX_EXN));
					Str_Cpy(stSubCustInfo.FAX_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FAX_NUM, 0x00, sizeof(stSubCustInfo.FAX_NUM));
					Str_Cpy(stSubCustInfo.FAX_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA9) == m_lActiveIndex )
				{
				
					Mem_Set((byte*)stSubCustInfo.EMAIL, 0x00, sizeof(stSubCustInfo.EMAIL));
					Str_Cpy(stSubCustInfo.EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FAMILY_CNT, 0x00, sizeof(stSubCustInfo.FAMILY_CNT));
					Str_Cpy(stSubCustInfo.FAMILY_CNT, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
				}
			}
		}
		else if( m_bFirst == INIT_SMSREQ )
		{
			if( Get_iDlgCtrlByID(EDT_DATA11) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA12) == m_lActiveIndex )
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
	
	/*=======================================================================================
	함수명 : OnPointing
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing( long nAction, long X, long Y )
	{
		long lActiveIndex = -1;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		m_lActiveIndex = lActiveIndex;
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( 0 == m_nOptionSet )
					{
						if( X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+570-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+630-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+570-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+630-(g_Dlgflag*370))||
						    X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+630-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+630-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*370)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )	
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(370);
							
								ShowSip(FALSE);
								g_Sipflag = 0;
							}
						}
						else
						{
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370))  )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
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
					else if( 1 == m_nOptionSet )
					{
						if( X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+450-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+510-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+450-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+510-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+510-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+570-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+510-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+570-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+630-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*370)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA10) == lActiveIndex )	
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(370);
							
								ShowSip(FALSE);
								g_Sipflag = 0;
							}
						}
						else if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+895) && Y > DMS_Y(STARTY+330-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+390-(g_Dlgflag*370)) ||
						         X > DMS_X(STARTX+300) && X < DMS_X(STARTX+895) && Y > DMS_Y(STARTY+390-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+450-(g_Dlgflag*370)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA9) == lActiveIndex ||
							    Get_iDlgCtrlByID(CMB_DATA8) == lActiveIndex ) 
							{
								ShowSip(FALSE);
								g_Sipflag = 0;

								ShowSip(TRUE);
								g_Sipflag = 1;
							}
						}
						else
						{
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370))  )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
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
				}
			}
		}
		else if( m_bFirst == INIT_SMSREQ )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+500) && X < DMS_X(STARTX+725) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+380) ||
					    X > DMS_X(STARTX+775) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+380) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA11) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA12) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
			}
		}
		
		ON_DRAW();
		return;
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
			
			// 상단공통메뉴
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
		char ch[2];
		Mem_Set((byte *)ch, 0x00, sizeof(ch));
		
		/********************************/
		/* 공통                         */
		/********************************/
		// 사용계약
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		// 숫자판
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
		
		/********************************/
		/* 고객정보1                    */
		/********************************/
		if( 0 == m_nOptionSet )
		{
			/*********************** SetVisible ***********************/
			// 고객정보1 true
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA6), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA8), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA9), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA10), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA11), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA12), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA13), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA55), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA16), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA17), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA18), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA20), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA23), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA24), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA25), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA41), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA42), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA57), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13+1), TRUE);
			
			// 고객정보2 false
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA26), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA27), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA28), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA29), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA30), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA31), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA32), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA33), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA34), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA35), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA36), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA37), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA38), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA39), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA7), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA8), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA9), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA10), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9+1), FALSE);	
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), FALSE);
			
			// 사회복지시설 Visible				
			if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA56), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14+1), TRUE);
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA56), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14+1), FALSE);
			}
			
			/*********************** SetRange ***********************/
			// 주소
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), "주소");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA15),   STARTX,     STARTY+210, STARTX+150,  STARTY+270);
			
			// 번지
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), "번지");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA16),   STARTX+150, STARTY+210, STARTX+300,  STARTY+270);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA22),   STARTX+300, STARTY+210, STARTX+575,  STARTY+270);
			
			// 호수
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "호수");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA17),   STARTX+575, STARTY+210, STARTX+720,  STARTY+270);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA23),   STARTX+720, STARTY+210, STARTX+1000, STARTY+270);
			
			// 세대호수
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), "세대호수");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA18),   STARTX,     STARTY+270, STARTX+300,  STARTY+330);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA24),   STARTX+300, STARTY+270, STARTX+500,  STARTY+330);
			
			// 기타주소
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "기타주소");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA19),   STARTX+500, STARTY+270, STARTX+720,  STARTY+330);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA25),   STARTX+720, STARTY+270, STARTX+1000, STARTY+330);
			
			// 유형
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "유형");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA5),    STARTX,     STARTY+330, STARTX+300,  STARTY+390);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA57),   STARTX+300, STARTY+330, STARTX+1000, STARTY+390);
			
			// 고객명
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "고객명");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA4),    STARTX,     STARTY+390, STARTX+300,  STARTY+450);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA20),   STARTX+300, STARTY+390, STARTX+1000, STARTY+450);
			
			// 생년월일
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA41), "생년월일");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA41),   STARTX,     STARTY+450, STARTX+300,  STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA42),   STARTX+300, STARTY+450, STARTX+1000, STARTY+510);
			
			// 성향
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "성향");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA6),    STARTX,     STARTY+510, STARTX+300,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA2), 	 STARTX+300, STARTY+510, STARTX+1000, STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA2+1),  STARTX+895, STARTY+510, STARTX+1000, STARTY+570);
			
			// 핸드폰번호
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "핸드폰번호");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA8),    STARTX,     STARTY+570, STARTX+300,  STARTY+630);	
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA3), 	 STARTX+300, STARTY+570, STARTX+575,  STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA3+1),  STARTX+470, STARTY+572, STARTX+575,  STARTY+628);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA9),    STARTX+575, STARTY+570, STARTX+625,  STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA1),    STARTX+625, STARTY+570, STARTX+775,  STARTY+630);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA10),   STARTX+775, STARTY+570, STARTX+825,  STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA2),    STARTX+825, STARTY+570, STARTX+1000, STARTY+630);
			
			// 자택번호
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), "자택전화");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA11),   STARTX,     STARTY+630, STARTX+300,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA4), 	 STARTX+300, STARTY+630, STARTX+575,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA4+1),  STARTX+470, STARTY+630, STARTX+575,  STARTY+690);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA12),   STARTX+575, STARTY+630, STARTX+625,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA3),    STARTX+625, STARTY+630, STARTX+775,  STARTY+690);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "-");		
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA13),   STARTX+775, STARTY+630, STARTX+825,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA4),    STARTX+825, STARTY+630, STARTX+1000, STARTY+690);
			
			// 인덕션
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA55), "인덕션");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA55),   STARTX,     STARTY+690, STARTX+220,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA13), 	 STARTX+220, STARTY+690, STARTX+395,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA13+1), STARTX+395, STARTY+690, STARTX+500,  STARTY+750);
			
			// 빌트인
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "빌트인");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA14),   STARTX+500, STARTY+690, STARTX+720,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA5), 	 STARTX+720, STARTY+690, STARTX+895,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA5+1),  STARTX+895, STARTY+690, STARTX+1000, STARTY+750);
			
			// 사회복지시설여부
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA56), "사회복지시설여부");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA56),   STARTX,     STARTY+750, STARTX+500,  STARTY+810);	
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA14),   STARTX+500, STARTY+750, STARTX+900,  STARTY+810);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA14+1), STARTX+895, STARTY+750, STARTX+1000, STARTY+810);
			
			/*********************** SetAlign ***********************/
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA55), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA56), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA57), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		/********************************/
		/* 고객정보2                    */
		/********************************/
		else if( 1 == m_nOptionSet )
		{
			/*********************** SetVisible ***********************/
			// 고객정보1 false
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA6), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA8), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA9), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA10), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA11), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA12), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA13), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA55), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA56), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA16), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA17), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA18), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA20), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA23), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA24), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA25), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA41), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA42), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA57), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14+1), FALSE);
			
			// 고객정보2 true
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA26), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA27), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA28), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA29), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA30), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA31), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA32), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA33), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA34), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA35), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA36), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA37), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA38), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA39), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA7), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA8), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA9), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA10), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6+1), TRUE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7+1), TRUE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), TRUE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9+1), TRUE);	
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10+1), TRUE);
			
			/*********************** SetRange ***********************/
			// 상호
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA33), "상호");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA33),   STARTX,     STARTY+210, STARTX+300,  STARTY+270);
			
			if( Str_Cmp(stSc.PROD_CD, "20") == 0 || Str_Cmp(stSc.PROD_CD, "21") == 0 || Str_Cmp(stSc.PROD_CD, "22") == 0 )
			{
				if( Str_Len(stSc.FIRM_NM) == 0 )
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), TRUE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), TRUE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), FALSE);

					EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA12),   STARTX+300, STARTY+210, STARTX+1000, STARTY+270);
					EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA12+1), STARTX+895, STARTY+210, STARTX+1000, STARTY+270);
					
					for( i = 0;  FIRM_CD[i].Str[0] != 0; i++ )
					{
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA12+2), FIRM_CD[i].Str, 0, ICON_NONE);
					}
				}
				else
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), FALSE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), FALSE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), TRUE);
					
					EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA40), STARTX+300, STARTY+210, STARTX+1000, STARTY+270);
				}
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), TRUE);
				
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA40), STARTX+300, STARTY+210, STARTX+1000, STARTY+270);
			}
			
			// 사업자번호
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA32), "사업자번호");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA32),   STARTX,     STARTY+270, STARTX+300,  STARTY+330);
			
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA39),   STARTX+300, STARTY+270, STARTX+1000, STARTY+330);
			
			// 이메일
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA34), "이메일");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA34),   STARTX,     STARTY+330, STARTX+300,  STARTY+450);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA9),    STARTX+300, STARTY+330, STARTX+895,  STARTY+390);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA35), "@");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA35),   STARTX+895, STARTY+330, STARTX+1000, STARTY+390);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA8), 	 STARTX+300, STARTY+390, STARTX+895,  STARTY+450);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA8+1),  STARTX+895, STARTY+390, STARTX+1000, STARTY+450);

			// 회사번호	
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA26), "회사번호");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA26),  STARTX,     STARTY+450, STARTX+300,   STARTY+510);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA6), 	STARTX+300, STARTY+450, STARTX+575,   STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA6+1), STARTX+470, STARTY+450, STARTX+575,   STARTY+510);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA27), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA27),  STARTX+575, STARTY+450, STARTX+625,   STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA5),   STARTX+625, STARTY+450, STARTX+775,   STARTY+510);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA28), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA28),  STARTX+775, STARTY+450, STARTX+825,   STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA6),   STARTX+825, STARTY+450, STARTX+1000,  STARTY+510);
			
			// 팩스
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA29), "팩스");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA29),   STARTX,     STARTY+510, STARTX+300,  STARTY+570);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA7),  	 STARTX+300, STARTY+510, STARTX+575,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA7+1),  STARTX+470, STARTY+510, STARTX+575,  STARTY+570);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA30), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA30),   STARTX+575, STARTY+510, STARTX+625,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA7),    STARTX+625, STARTY+510, STARTX+775,  STARTY+570);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA31), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA31),   STARTX+775, STARTY+510, STARTX+825,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA8),    STARTX+825, STARTY+510, STARTX+1000, STARTY+570);
			
			// 면적
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA36), "면적");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA36),   STARTX,     STARTY+570, STARTX+170,  STARTY+630);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA9), 	 STARTX+170, STARTY+570, STARTX+1000, STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA9+1),  STARTX+895, STARTY+570, STARTX+1000, STARTY+630);
			
			// 가족수
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA37), "가족수");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA37),   STARTX,     STARTY+630, STARTX+300,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA10),   STARTX+300, STARTY+630, STARTX+1000, STARTY+690);
			
			// 당사관계
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA38), "당사관계");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA38),   STARTX,     STARTY+690, STARTX+300,  STARTY+750);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA10), 	 STARTX+300, STARTY+690, STARTX+1000, STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA10+1), STARTX+895, STARTY+690, STARTX+1000, STARTY+750);
			
			/*********************** SetAlign ***********************/
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA10), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA9), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA10), EDITALIGN_MIDDLE);		
		}
	}
	
	/*=======================================================================================
	함수명 : SetCombo
	기  능 : SetCombo
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;
		
		if( 0 == m_nOptionSet )
		{
			// 성향
			for( i = 0 ;  SCTRND_CD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), SCTRND_CD[i].Str, 0, ICON_NONE);
			}
			
			// 핸드폰
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA3+2), "없음", 0, ICON_NONE);
			
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// 자택
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA4+2), "없음", 0, ICON_NONE);
			
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA4+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			/*
			// 핸드폰
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA3+2) , "",0,ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_DATA3+2);
			
			// 자택
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA4+2) , "",0,ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '2' ORDER BY SORT_ORDER", CMB_DATA4+2);
			*/
			
			// 빌트인
			for( i = 0 ;  SCBUILT_IN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA5+2), SCBUILT_IN[i].Str, 0, ICON_NONE);
			}
			
			// 인덕션
			for( i = 0 ;  SCBUILT_IN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA13+2), SCBUILT_IN[i].Str, 0, ICON_NONE);
			}
			
			// 사회복지시설
			for( i = 0 ;  SOCIAL_FACI_STS_CD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA14+2), SOCIAL_FACI_STS_CD[i].Str, 0, ICON_NONE);
			}
		}
		else
		{
			// 회사
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// 팩스
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA7+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// 메일주소
			for( i = 0 ;  SCEMAIL[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA8+2), SCEMAIL[i].Str, 0, ICON_NONE);
			}
			
			// 면적
			for( i = 0 ;  SCSQUARE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA9+2), SCSQUARE[i].Str, 0, ICON_NONE);
			}
			
			// 당사관계
			for( i = 0 ;  SCRELAT[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA10+2), SCRELAT[i].Str, 0, ICON_NONE);
			}
		}
	}
	
	/*=======================================================================================
	함수명 : Cust_SetData
	기  능 : stScCustInfo setting
	Param  : 
	Return : 
	========================================================================================*/
	void Cust_SetData(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stScCustInfo, 0x00, sizeof(stScCustInfo));
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, " SELECT CHK_EXEC_NUM, BUILT_IN_YN, Trim(SQUARE_METER), CUST_NUM, CUST_NM \
												 , Trim(CUST_TYPE_CD), Trim(CUST_TRND_CD), Trim(OWNHOUSE_TEL_DDD), Trim(OWNHOUSE_TEL_EXN), Trim(OWNHOUSE_TEL_NUM) \
												 , Trim(CP_DDD), Trim(CP_EXN), Trim(CP_NUM), FAMILY_CNT, FIRM_NM \
												 , EMAIL, Trim(FIRM_TEL_DDD), Trim(FIRM_TEL_EXN), Trim(FIRM_TEL_NUM), Trim(FAX_DDD) \
												 , Trim(FAX_EXN), Trim(FAX_NUM), SOC_NUM, Trim(SCG_RELAT_CD), PDA_IP \
											     , UPD_EMPID, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR \
											     , CHK_ORDER, OBJ_YM, PLAN_YM, SEND_YN, INDUCTION_INST_YN \
											     , FACI_STS_CD \
											  FROM NORMAL_INFO \
											 WHERE CHK_EXEC_NUM = ? "
		);
		
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
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_EXEC_NUM      , 12 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.BUILT_IN_YN       , 1  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SQUARE_METER      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_NUM          , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_NM           , 30 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_TYPE_CD      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_TRND_CD      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OWNHOUSE_TEL_DDD  , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OWNHOUSE_TEL_EXN  , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OWNHOUSE_TEL_NUM  , 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CP_DDD            , 4  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CP_EXN            , 4  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CP_NUM            , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAMILY_CNT        , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_NM           , 50 + 1, DECRYPT );
				
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.EMAIL             , 50 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_TEL_DDD      , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_TEL_EXN      , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_TEL_NUM      , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAX_DDD           , 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAX_EXN           , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAX_NUM           , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SOC_NUM           , 13 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SCG_RELAT_CD      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.PDA_IP            , 32 + 1, DECRYPT );
				
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.UPD_EMPID         , 20 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.BLD_NUM           , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.INST_PLACE_NUM    , 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_TYPE          , 2  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_YEAR          , 4  + 1, DECRYPT );
				
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_ORDER         , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OBJ_YM            , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.PLAN_YM           , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SEND_YN           , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.INDUCTION_INST_YN , 1  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FACI_STS_CD       , 1  + 1, DECRYPT );
		}
		
	Finally:

		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	함수명 : SetStruct
	기  능 : stSubCustInfo setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetStruct(void)
	{
		char szSql[200];
		long lCnt;
		long i;
		long len;
		long length;
		long k = 0;
		
		Mem_Set( (byte*)&stSubCustInfo, 0x00, sizeof(stSubCustInfo) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_INFO WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lCnt);	

		if( m_lCnt > 0 )
		{
			Cust_SetData();

			Str_Cpy(stSubCustInfo.CUST_NUM,			stScCustInfo.CUST_NUM);
			Str_Cpy(stSubCustInfo.CUST_NM,			stScCustInfo.CUST_NM);
			Str_Cpy(stSubCustInfo.CUST_TYPE_CD,		stScCustInfo.CUST_TYPE_CD);
			Str_Cpy(stSubCustInfo.CUST_TRND_CD,		stScCustInfo.CUST_TRND_CD);
			Str_Cpy(stSubCustInfo.SOC_NUM,		    stScCustInfo.SOC_NUM);
			Str_Cpy(stSubCustInfo.CP_DDD, 			stScCustInfo.CP_DDD);
			Str_Cpy(stSubCustInfo.CP_EXN, 			stScCustInfo.CP_EXN);
			Str_Cpy(stSubCustInfo.CP_NUM, 			stScCustInfo.CP_NUM);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_DDD,	stScCustInfo.OWNHOUSE_TEL_DDD);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN,	stScCustInfo.OWNHOUSE_TEL_EXN);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM,	stScCustInfo.OWNHOUSE_TEL_NUM);
			Str_Cpy(stSubCustInfo.BUILT_IN_YN,		stScCustInfo.BUILT_IN_YN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_DDD,		stScCustInfo.FIRM_TEL_DDD);
			Str_Cpy(stSubCustInfo.FIRM_TEL_EXN,		stScCustInfo.FIRM_TEL_EXN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_NUM,		stScCustInfo.FIRM_TEL_NUM);
			Str_Cpy(stSubCustInfo.FAX_DDD,			stScCustInfo.FAX_DDD);
			Str_Cpy(stSubCustInfo.FAX_EXN,			stScCustInfo.FAX_EXN);
			Str_Cpy(stSubCustInfo.FAX_NUM,			stScCustInfo.FAX_NUM);
			Str_Cpy(stSubCustInfo.FIRM_NM,          stScCustInfo.FIRM_NM);
	
			length = Str_Len(stScCustInfo.EMAIL);
			
			if( length > 0 )
			{
				for( i=0 ; length ; i++)
				{
					if(stScCustInfo.EMAIL[i] == '@')
					{
						len = i;
						break;
					}
					else if(stScCustInfo.EMAIL[i] == '')
					{
						k++;
						break;
					}
				}

				Mem_Cpy((byte *)stSubCustInfo.EMAIL, (byte *)stScCustInfo.EMAIL, len);
				
				if( k == 0 )
				{
					Mem_Cpy((byte *)stSubCustInfo.EMAILADDR, (byte *)stScCustInfo.EMAIL+(len+1), length-(len+1));
				}
			}
			
			Str_Cpy(stSubCustInfo.SQUARE_METER,		stScCustInfo.SQUARE_METER);
			Str_Cpy(stSubCustInfo.FAMILY_CNT,		stScCustInfo.FAMILY_CNT);
			Str_Cpy(stSubCustInfo.SCG_RELAT_CD,		stScCustInfo.SCG_RELAT_CD);
			Str_Cpy(stSubCustInfo.INDUCTION_INST_YN,stScCustInfo.INDUCTION_INST_YN);
			Str_Cpy(stSubCustInfo.FACI_STS_CD,      stScCustInfo.FACI_STS_CD);
		}
		else
		{
			Str_Cpy(stSubCustInfo.CUST_NUM,			stSc.CUST_NUM);
			Str_Cpy(stSubCustInfo.CUST_NM,			stSc.CUST_NM);
			Str_Cpy(stSubCustInfo.CUST_TYPE_CD,		stSc.CUST_TYPE_CD);
			Str_Cpy(stSubCustInfo.CUST_TRND_CD,		stSc.CUST_TRND_CD);
			Str_Cpy(stSubCustInfo.SOC_NUM,	    	stSc.SOC_NUM);
			Str_Cpy(stSubCustInfo.CP_DDD, 			stSc.CP_DDD);
			Str_Cpy(stSubCustInfo.CP_EXN, 			stSc.CP_EXN);
			Str_Cpy(stSubCustInfo.CP_NUM, 			stSc.CP_NUM);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_DDD,	stSc.OWNHOUSE_TEL_DDD);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN,	stSc.OWNHOUSE_TEL_EXN);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM,	stSc.OWNHOUSE_TEL_NUM);
			Str_Cpy(stSubCustInfo.BUILT_IN_YN,		stSc.BUILT_IN_YN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_DDD,		stSc.FIRM_TEL_DDD);
			Str_Cpy(stSubCustInfo.FIRM_TEL_EXN,		stSc.FIRM_TEL_EXN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_NUM,		stSc.FIRM_TEL_NUM);
			Str_Cpy(stSubCustInfo.FAX_DDD,			stSc.FAX_DDD);
			Str_Cpy(stSubCustInfo.FAX_EXN,			stSc.FAX_EXN);
			Str_Cpy(stSubCustInfo.FAX_NUM,			stSc.FAX_NUM);
			Str_Cpy(stSubCustInfo.FIRM_NM,          stSc.FIRM_NM);
			
			length = Str_Len(stSc.EMAIL);
			
			if( length > 0 )
			{
				for( i=0 ; length ; i++)
				{
					if(stSc.EMAIL[i] == '@')
					{
						len = i;
						break;
					}
					else if(stSc.EMAIL[i] == '')
					{
						k++;
						break;
					}
				}
				
				Mem_Cpy((byte *)stSubCustInfo.EMAIL, (byte *)stSc.EMAIL, len+1);
				
				if( k == 0 )
				{
					Mem_Cpy((byte *)stSubCustInfo.EMAILADDR, (byte *)stSc.EMAIL+(len+1), length-(len+1));
				}
			}
			
			Str_Cpy(stSubCustInfo.SQUARE_METER,		 stSc.SQUARE_METER);
			Str_Cpy(stSubCustInfo.FAMILY_CNT,		 stSc.FAMILY_CNT);
			Str_Cpy(stSubCustInfo.SCG_RELAT_CD,		 stSc.SCG_RELAT_CD);
			Str_Cpy(stSubCustInfo.INDUCTION_INST_YN, stSc.INDUCTION_INST_YN);
			Str_Cpy(stSubCustInfo.FACI_STS_CD,       "1" );
		}
	}
	
	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 DRAW
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i;
		char szTmp[11];
		char szTmp2[30];
		
		/******************************/
		/* 공통                       */
		/******************************/
		// 사용계약번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stSc.USE_CONT_NUM);
		
		// 공급상태
		i = g_SearchCD( stSc.CONT_STS_CD, SCCONTSTS );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), SCCONTSTS[i].Str);
		
		if( Str_Cmp(stSc.CONT_STS_CD, "30") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), RED);
		}
		
		if( Str_Cmp(stSc.BILL_SEND_METHOD, "S" ) == 0 )
		{
			Str_Cpy( szTmp2, "송달" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "E" ) == 0 )
		{
			Str_Cpy( szTmp2, "이메일" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "L" ) == 0 )
		{
			Str_Cpy( szTmp2, "LMS" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "M" ) == 0 )
		{
			Str_Cpy( szTmp2, "모바일" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "A" ) == 0 )
		{
			Str_Cpy( szTmp2, "EM+송" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "B" ) == 0 )
		{
			Str_Cpy( szTmp2, "LM+송" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "C" ) == 0 )
		{
			Str_Cpy( szTmp2, "모+송" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "D" ) == 0 )
		{
			Str_Cpy( szTmp2, "E+LM" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "F" ) == 0 )
		{
			Str_Cpy( szTmp2, "모+EM" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "G" ) == 0 )
		{
			Str_Cpy( szTmp2, "모+LM" );
		}

		// 청구방법표시
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_REQ), szTmp2);
		
		/* 기존 SMS사전신청
			if( Str_Cmp(stSc.SMS_SEND_AGREE_YN, "Y") == 0 )
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), BTNMENUFRCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), BTNCTRLBKCOLOR);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
			}
			else
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), RED);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), PDAEDTCTRLBK);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
			}
		*/
		
		// SMS신청 : Y = GREEN, N = YELLOW
		if( Str_Cmp(stSc.SMS_SEND_AGREE_YN, "Y") == 0 )
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), TXTTTLFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), GREEN);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), TXTTTLFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), RED);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
		}
		
		/******************************/
		/* 고객정보1                  */
		/******************************/
		if( m_nOptionSet == 0 )
		{
			// 고객정보_1
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT), FALSE );
			
			// 고객정보_2
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT2), TRUE );
			
			// 고객명
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), stSc.CUST_NM);
				
			// 유형
			i = g_SearchCD( stSubCustInfo.CUST_TYPE_CD, SCTYPE_CD );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA57), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA57), SCTYPE_CD[i].Str);
			}
			
			// 성향
			i = g_SearchCD( stSubCustInfo.CUST_TRND_CD, SCTRND_CD );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), SCTRND_CD[i].Str);
			}
			
			// 생년월일
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Cpy((byte *)szTmp, (byte *)stSubCustInfo.SOC_NUM, 6);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA42),  szTmp);
			
			// 휴대전화1
			if(Str_Len(stSubCustInfo.CP_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3),  stSubCustInfo.CP_DDD);
			}
			
			// 휴대전화2
			if(Str_Len(stSubCustInfo.CP_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  stSubCustInfo.CP_EXN);
			}
			
			// 휴대전화3
			if(Str_Len(stSubCustInfo.CP_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2),  stSubCustInfo.CP_NUM);
			}
			
			// 자택전화1
			if(Str_Len(stSubCustInfo.OWNHOUSE_TEL_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), stSubCustInfo.OWNHOUSE_TEL_DDD);
			}
			
			// 자택전화2
			if(Str_Len(stSubCustInfo.OWNHOUSE_TEL_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), stSubCustInfo.OWNHOUSE_TEL_EXN);
			}
			
			// 자택전화3
			if(Str_Len(stSubCustInfo.OWNHOUSE_TEL_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), stSubCustInfo.OWNHOUSE_TEL_NUM);
			}

			// 빌트인
			i = g_SearchCD( stSubCustInfo.BUILT_IN_YN, SCBUILT_IN );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), SCBUILT_IN[i].Str);
			}
			
			// 인덕션
			i = g_SearchCD( stSubCustInfo.INDUCTION_INST_YN, SCBUILT_IN );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA13), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA13), SCBUILT_IN[i].Str);
			}
			
			// 사회복지시설
			i = g_SearchCD( stSubCustInfo.FACI_STS_CD, SOCIAL_FACI_STS_CD );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA14), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA14), SOCIAL_FACI_STS_CD[i].Str);
			}
			
			// 번지
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), stSc.ADDR1_M);
			
			// 호수		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), stSc.ADDR1_S);
							
			// 세대호수
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), stSc.HOUSE_CNT);
			
			// 기타주소			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), stSc.LOT_NUM_SECOND_ADDR);
		}
		else
		{
			// 고객정보_1
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT), TRUE );
			
			// 고객정보_2
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT2), FALSE );
			
			// 회사번호1
			if(Str_Len(stSubCustInfo.FIRM_TEL_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6),  stSubCustInfo.FIRM_TEL_DDD);
			}
			
			// 회사번호2
			if(Str_Len(stSubCustInfo.FIRM_TEL_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5),  stSubCustInfo.FIRM_TEL_EXN);
			}
			
			// 회사번호3
			if(Str_Len(stSubCustInfo.FIRM_TEL_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6),  stSubCustInfo.FIRM_TEL_NUM);
			}
			
			// 자택전화1
			if(Str_Len(stSubCustInfo.FAX_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), stSubCustInfo.FAX_DDD);
			}
			
			// 자택전화2
			if(Str_Len(stSubCustInfo.FAX_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), stSubCustInfo.FAX_EXN);
			}
			
			// 자택전화3
			if(Str_Len(stSubCustInfo.FAX_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA8), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA8), stSubCustInfo.FAX_NUM);
			}
			
			// 사업자번호
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA39), stSc.BIZ_REGI_NUM);
			
			// 상호
			if( Str_Cmp(stSc.PROD_CD, "20") == 0 || Str_Cmp(stSc.PROD_CD, "21") == 0 || Str_Cmp(stSc.PROD_CD, "22") == 0 )
			{
				if( Str_Len(stSc.FIRM_NM) == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA12), stSubCustInfo.FIRM_NM);	
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA40), stSubCustInfo.FIRM_NM);
				}
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA40), stSubCustInfo.FIRM_NM);
			}
			
			// 이메일
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA9), stSubCustInfo.EMAIL);
			
			// 이메일주소	
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA8), stSubCustInfo.EMAILADDR);
			
			// 면적
			i = g_SearchCD( stSubCustInfo.SQUARE_METER, SCSQUARE );
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA9), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA9), SCSQUARE[i].Str);
			}
			
			// 가족수
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA10), stSubCustInfo.FAMILY_CNT);
			
			// 당사관계
			i = g_SearchCD( stSubCustInfo.SCG_RELAT_CD, SCRELAT );
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA10), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA10), SCRELAT[i].Str);
			}
		}
	}

	/*=======================================================================================
	함수명 : Validate
	기  능 : 확인 Validation
	Param  : 
	Return : 
	========================================================================================*/	
	bool Validate(void)
	{
		char szEmail[60];
		char szMsg[100];
		long nLen = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5))) < 0 )
			{
				MessageBoxEx (CONFIRM_OK, "빌트인 여부를 선택주세요.");
				return FALSE;
			}
	
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9))) == 0 && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8))) > 0)
			{
				MessageBoxEx (CONFIRM_OK, "이메일 주소를 확인해주세요.");
				return FALSE;
			}
			else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9))) > 0 && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "이메일 주소를 확인해주세요.");
				return FALSE;
			}
			
			/*
			if( stSubCustInfo.CUST_NUM[0] == '0' )
			{
				MessageBoxEx (CONFIRM_OK, "임시고객은 수정이 불가능합니다.");
				return FALSE;
			}
			*/
			
			if( stSubCustInfo.CUST_NUM[0] == '0' && Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") != 0 )
			{
				MessageBoxEx (CONFIRM_OK, "임시고객은 수정이 불가능합니다.");
				return FALSE;
			}
			
			// 메일
			Mem_Set( (byte*)szEmail, 0x00, sizeof(szEmail) );
			Str_Cpy(szEmail, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			Str_Cat(szEmail, "@");
			Str_Cat(szEmail, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
			
			// 메모
			nLen = g_GetUtf8Size(szEmail);
			if( nLen > 50 )
			{
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				SPRINT(szMsg, "저장실패!\n(이메일은 한글 16자,\n영문,숫자 50자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szMsg);
				return FALSE;
			}
			
			// 핸드폰
			if( !g_CheckPhoneNumber( "1", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) ))
			{
				MessageBoxEx(CONFIRM_OK, "고객님의 핸드폰번호를\n확인해주세요.");
				return FALSE;
			}

			// 자택번호
			if( !g_CheckPhoneNumber("2", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)) , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) ))
			{
				MessageBoxEx(CONFIRM_OK, "고객님의 자택전화번호를\n확인해주세요.");
				return FALSE;
			}
			
		}
		else if( m_bFirst == INIT_SMSREQ )
		{
			if( m_lSmsReqFlag == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "동의여부를 선택해주세요.");
				return FALSE;
			}

			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA11))) == 0 ||
			    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11))) == 0 || 
			    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "휴대전화 번호를 입력하세요!");
				return FALSE;
			}
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Save_Cust
	기  능 : 고객정보 저장
	Param  : 
	Return : 
	========================================================================================*/	
	bool Save_Cust(void)
	{
		char szSql[650];
		long idx;
		long i;
		long lCnt;
		bool ret = TRUE;
		char szToday[20];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_INFO WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCnt);	
		
		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//점검시행번호
		Mem_Set( (byte*)stScCustInfo.CHK_EXEC_NUM, 0x00, sizeof(stScCustInfo.CHK_EXEC_NUM) );
		Str_Cpy(stScCustInfo.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		
		//고객번호
		Mem_Set( (byte*)stScCustInfo.CUST_NUM, 0x00, sizeof(stScCustInfo.CUST_NUM) );
		Str_Cpy(stScCustInfo.CUST_NUM, stSubCustInfo.CUST_NUM);
		
		//고객명
		Mem_Set( (byte*)stScCustInfo.CUST_NM, 0x00, sizeof(stScCustInfo.CUST_NM) );
		Str_Cpy(stScCustInfo.CUST_NM, stSubCustInfo.CUST_NM);
		
		//유형
		Mem_Set( (byte*)stScCustInfo.CUST_TYPE_CD, 0x00, sizeof(stScCustInfo.CUST_TYPE_CD) );
		Str_Cpy(stScCustInfo.CUST_TYPE_CD, stSubCustInfo.CUST_TYPE_CD);
		
		//성향
		Mem_Set( (byte*)stScCustInfo.CUST_TRND_CD, 0x00, sizeof(stScCustInfo.CUST_TRND_CD) );
		Str_Cpy(stScCustInfo.CUST_TRND_CD, stSubCustInfo.CUST_TRND_CD);
		
		//핸드폰번호
		Mem_Set( (byte*)stScCustInfo.CP_DDD, 0x00, sizeof(stScCustInfo.CP_DDD) );
		Mem_Set( (byte*)stScCustInfo.CP_EXN, 0x00, sizeof(stScCustInfo.CP_EXN) );
		Mem_Set( (byte*)stScCustInfo.CP_NUM, 0x00, sizeof(stScCustInfo.CP_NUM) );
		
		Str_Cpy(stScCustInfo.CP_DDD, stSubCustInfo.CP_DDD);
		Str_Cpy(stScCustInfo.CP_EXN, stSubCustInfo.CP_EXN);
		Str_Cpy(stScCustInfo.CP_NUM, stSubCustInfo.CP_NUM);
		
		//자택전화
		Mem_Set( (byte*)stScCustInfo.OWNHOUSE_TEL_DDD, 0x00, sizeof(stScCustInfo.OWNHOUSE_TEL_DDD) );
		Mem_Set( (byte*)stScCustInfo.OWNHOUSE_TEL_EXN, 0x00, sizeof(stScCustInfo.OWNHOUSE_TEL_EXN) );
		Mem_Set( (byte*)stScCustInfo.OWNHOUSE_TEL_NUM, 0x00, sizeof(stScCustInfo.OWNHOUSE_TEL_NUM) );
		
		Str_Cpy(stScCustInfo.OWNHOUSE_TEL_DDD, stSubCustInfo.OWNHOUSE_TEL_DDD);
		Str_Cpy(stScCustInfo.OWNHOUSE_TEL_EXN, stSubCustInfo.OWNHOUSE_TEL_EXN);
		Str_Cpy(stScCustInfo.OWNHOUSE_TEL_NUM, stSubCustInfo.OWNHOUSE_TEL_NUM);
		
		//빌트인여부
		Str_Cpy(stScCustInfo.BUILT_IN_YN, stSubCustInfo.BUILT_IN_YN);
		
		//회사번호
		Str_Cpy(stScCustInfo.FIRM_TEL_DDD, stSubCustInfo.FIRM_TEL_DDD);
		Str_Cpy(stScCustInfo.FIRM_TEL_EXN, stSubCustInfo.FIRM_TEL_EXN);
		Str_Cpy(stScCustInfo.FIRM_TEL_NUM, stSubCustInfo.FIRM_TEL_NUM);
		
		//팩스
		Str_Cpy(stScCustInfo.FAX_DDD, stSubCustInfo.FAX_DDD);
		Str_Cpy(stScCustInfo.FAX_EXN, stSubCustInfo.FAX_EXN);
		Str_Cpy(stScCustInfo.FAX_NUM, stSubCustInfo.FAX_NUM);
		
		//상호
		Str_Cpy(stScCustInfo.FIRM_NM, stSubCustInfo.FIRM_NM);

		//이메일
		Str_Cpy(stSubCustInfo.EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
		Str_Cpy(stSubCustInfo.EMAILADDR, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
		
		if(Str_Len(stSubCustInfo.EMAIL) > 0 && Str_Len(stSubCustInfo.EMAILADDR) > 0 )
		{
			Str_Cpy(stScCustInfo.EMAIL, stSubCustInfo.EMAIL);
			Str_Cat(stScCustInfo.EMAIL, "@");
			Str_Cat(stScCustInfo.EMAIL, stSubCustInfo.EMAILADDR);
		}
		else
		{
			Str_Cpy(stScCustInfo.EMAIL, stSubCustInfo.EMAIL);
			Str_Cat(stScCustInfo.EMAIL, stSubCustInfo.EMAILADDR);
		}
		//면적
		Str_Cpy(stScCustInfo.SQUARE_METER, stSubCustInfo.SQUARE_METER);
		//가족수
		Str_Cpy(stScCustInfo.FAMILY_CNT, stSubCustInfo.FAMILY_CNT);
		//당사관계
		Str_Cpy(stScCustInfo.SCG_RELAT_CD, stSubCustInfo.SCG_RELAT_CD);
		
		//인덕션
		Str_Cpy(stScCustInfo.INDUCTION_INST_YN, stSubCustInfo.INDUCTION_INST_YN);
		//사회복지시설
		Str_Cpy(stScCustInfo.FACI_STS_CD, stSubCustInfo.FACI_STS_CD);
		
		//송신여부
		Str_Cpy(stScCustInfo.SEND_YN, "S" );
		
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10);
		
		//사회복지시설 체크 날짜
		Str_Cpy( stScCustInfo.CHK_YMD, szToday );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
		{
			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " UPDATE NORMAL_INFO \
				                   SET CHK_EXEC_NUM = ?, CUST_NUM = ?, CUST_NM = ?, CUST_TYPE_CD = ?, CUST_TRND_CD = ? \
				                     , CP_DDD = ?, CP_EXN = ?, CP_NUM = ?, OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ? \
				                     , OWNHOUSE_TEL_NUM = ?, BUILT_IN_YN = ?, FIRM_TEL_DDD = ?, FIRM_TEL_EXN = ?, FIRM_TEL_NUM = ? \
				                     , FAX_DDD = ?, FAX_EXN = ?, FAX_NUM = ?, FIRM_NM = ?, EMAIL = ? \
				                     , SQUARE_METER = ?, FAMILY_CNT = ?, SCG_RELAT_CD = ?, SEND_YN = ?, BLD_NUM = ?, INST_PLACE_NUM = ? \
				                     , CHK_TYPE = ?, CHK_YEAR = ?, CHK_ORDER = ?, OBJ_YM = ?, PLAN_YM = ? \
				                     , PDA_IP = ?, UPD_EMPID = ?, INDUCTION_INST_YN = ?, CHK_YMD = ?, FACI_STS_CD = ? \
				                 WHERE CHK_EXEC_NUM = '%s' "
				      , g_szCHK_EXEC_NUM, 0, 0);
			}
			else
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " INSERT INTO NORMAL_INFO \
				                ( CHK_EXEC_NUM, CUST_NUM, CUST_NM, CUST_TYPE_CD, CUST_TRND_CD, CP_DDD, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN \
				                , OWNHOUSE_TEL_NUM, BUILT_IN_YN, FIRM_TEL_DDD, FIRM_TEL_EXN, FIRM_TEL_NUM, FAX_DDD, FAX_EXN, FAX_NUM, FIRM_NM, EMAIL \
				                , SQUARE_METER, FAMILY_CNT, SCG_RELAT_CD, SEND_YN, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM \
				                , PLAN_YM, PDA_IP, UPD_EMPID, INDUCTION_INST_YN, CHK_YMD, FACI_STS_CD ) \
				                VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
					 	              , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
						              , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
						              , ?, ?, ?, ?, ?, ? ) "
				      , 0, 0, 0);
			}
		}
		else
		{
			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " UPDATE NORMAL_INFO \
				                   SET CHK_EXEC_NUM = ?, CUST_NUM = ?, CUST_NM = ?, CUST_TYPE_CD = ?, CUST_TRND_CD = ? \
				                     , CP_DDD = ?, CP_EXN = ?, CP_NUM = ?, OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ? \
				                     , OWNHOUSE_TEL_NUM = ?, BUILT_IN_YN = ?, FIRM_TEL_DDD = ? , FIRM_TEL_EXN = ?, FIRM_TEL_NUM = ? \
				                     , FAX_DDD = ?, FAX_EXN = ?, FAX_NUM = ?, FIRM_NM = ?, EMAIL = ? \
				                     , SQUARE_METER = ?, FAMILY_CNT = ?, SCG_RELAT_CD = ?, SEND_YN = ?, BLD_NUM = ?, INST_PLACE_NUM = ? \
				                     , CHK_TYPE = ?, CHK_YEAR = ?, CHK_ORDER = ?, OBJ_YM = ?, PLAN_YM = ? \
				                     , PDA_IP = ?, UPD_EMPID = ?, INDUCTION_INST_YN = ?, CHK_YMD = ? \
				                 WHERE CHK_EXEC_NUM = '%s' "
				      , g_szCHK_EXEC_NUM, 0, 0);
			}
			else
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " INSERT INTO NORMAL_INFO \
						        ( CHK_EXEC_NUM, CUST_NUM, CUST_NM, CUST_TYPE_CD, CUST_TRND_CD, CP_DDD, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN \
							    , OWNHOUSE_TEL_NUM, BUILT_IN_YN, FIRM_TEL_DDD, FIRM_TEL_EXN, FIRM_TEL_NUM, FAX_DDD, FAX_EXN, FAX_NUM, FIRM_NM, EMAIL \
							    , SQUARE_METER, FAMILY_CNT, SCG_RELAT_CD, SEND_YN, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM \
							    , PLAN_YM, PDA_IP, UPD_EMPID, INDUCTION_INST_YN, CHK_YMD ) \
							    VALUES \
							    ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
							    , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
							    , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
							    , ?, ?, ?, ?, ? ) " 
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

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CHK_EXEC_NUM      	,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_NUM         	,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_NM         	,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_TYPE_CD        ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_TRND_CD      	,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_DDD 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_EXN 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_NUM     			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_DDD	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_EXN	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_NUM	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.BUILT_IN_YN			,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_DDD		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_EXN		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_NUM		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_DDD        		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_EXN 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_NUM 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_NM     		,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.EMAIL				,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SQUARE_METER		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAMILY_CNT			,3 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SCG_RELAT_CD		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SEND_YN				,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       				,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM				,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      				,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     				,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM        				,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM       				,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip		        ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id         ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.INDUCTION_INST_YN	,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CHK_YMD             ,8 + 1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FACI_STS_CD         ,1 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			Copy_Info();
			MessageBoxEx (CONFIRM_OK, "등록되었습니다.");
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Copy_Info
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/	
	void Copy_Info(void)
	{
		long idx = 0;
		char szSql[650];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE NORMAL_DATA \
		                  SET CP_DDD = ?, CP_EXN = ?, CP_NUM = ?, OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ? \
							, OWNHOUSE_TEL_NUM = ?, BUILT_IN_YN = ?, FIRM_TEL_DDD = ?, FIRM_TEL_EXN = ?, FIRM_TEL_NUM = ? \
							, FAX_DDD = ?, FAX_EXN = ?, FAX_NUM = ?, FIRM_NM = ?, EMAIL = ? \
							, SQUARE_METER = ?, FAMILY_CNT = ?, SCG_RELAT_CD = ?, CUST_TRND_CD = ?, INDUCTION_INST_YN = ? \
					    WHERE CHK_EXEC_NUM = '%s' "
				    , g_szCHK_EXEC_NUM, 0, 0);
			
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_DDD 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_EXN 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_NUM     			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_DDD	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_EXN	,4 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_NUM	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.BUILT_IN_YN			,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_DDD		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_EXN		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_NUM		,4 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_DDD        		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_EXN 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_NUM 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_NM     		,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.EMAIL				,50,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SQUARE_METER		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAMILY_CNT			,3 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SCG_RELAT_CD		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_TRND_CD      	,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.INDUCTION_INST_YN   ,1 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

Finally:
		DelSqLite(sql);
		return ;
	}
	
	/*=======================================================================================
	함수명 : Compare_Data
	기  능 : 수정됬는지 데이터 비교
	Param  : 
	Return : 
	========================================================================================*/
	bool Compare_Data(void)
	{
		char szTmp[100];
		long lChk = 0;
		long i;
		bool ret = TRUE;

		if( m_lCnt > 0 )
		{
			// 성향
			if( Str_Cmp(stSubCustInfo.CUST_TRND_CD, stScCustInfo.CUST_TRND_CD) != 0 )
			{
				lChk++;
			}
			
			// 핸드폰번호1
			if( Str_Cmp(stSubCustInfo.CP_DDD, stScCustInfo.CP_DDD) != 0 )
			{
				lChk++;
			}
			
			// 핸드폰번호2
			if( Str_Cmp(stSubCustInfo.CP_EXN, stScCustInfo.CP_EXN) != 0 )
			{
				lChk++;
			}
			
			// 핸드폰번호3
			if( Str_Cmp(stSubCustInfo.CP_NUM, stScCustInfo.CP_NUM) != 0 )
			{
				lChk++;
			}
			
			// 자택번호1
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_DDD, stScCustInfo.OWNHOUSE_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// 자택번호2
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_EXN, stScCustInfo.OWNHOUSE_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// 자택번호3
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_NUM, stScCustInfo.OWNHOUSE_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// 빌트인
			if( Str_Cmp(stSubCustInfo.BUILT_IN_YN, stScCustInfo.BUILT_IN_YN) != 0 )
			{
				lChk++;
			}
			
			// 인덕션
			if( Str_Cmp(stSubCustInfo.INDUCTION_INST_YN, stScCustInfo.INDUCTION_INST_YN) != 0 )
			{
				lChk++;
			}
			
			// 사회복지시설 -> 대상이 Y인 경우면 무조건 데이터 만들도록 한다.
			if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
			{
				lChk++;
			}

			// 회사번호1
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_DDD, stScCustInfo.FIRM_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// 회사번호2
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_EXN, stScCustInfo.FIRM_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// 회사번호3
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_NUM, stScCustInfo.FIRM_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// 팩스1
			if( Str_Cmp(stSubCustInfo.FAX_DDD, stScCustInfo.FAX_DDD) != 0 )
			{
				lChk++;
			}
			
			// 팩스2
			if( Str_Cmp(stSubCustInfo.FAX_EXN, stScCustInfo.FAX_EXN) != 0 )
			{
				lChk++;
			}
			
			// 팩스3
			if( Str_Cmp(stSubCustInfo.FAX_NUM, stScCustInfo.FAX_NUM) != 0 )
			{
				lChk++;
			}
			
			// 이메일
			if( Str_Len(stSubCustInfo.EMAIL) > 0 || Str_Len(stSubCustInfo.EMAILADDR) > 0 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, stSubCustInfo.EMAIL);
				Str_Cat(szTmp, "@");
				Str_Cat(szTmp, stSubCustInfo.EMAILADDR);
				if( Str_Cmp(szTmp, stScCustInfo.EMAIL) != 0 )
				{
					lChk++;
				}
			}
			
			// 면적
			if( Str_Cmp(stSubCustInfo.SQUARE_METER, stScCustInfo.SQUARE_METER) != 0 )
			{
				lChk++;
			}
			
			// 가족수
			if( Str_Cmp(stSubCustInfo.FAMILY_CNT, stScCustInfo.FAMILY_CNT) != 0 )
			{
				lChk++;
			}
			
			// 당사관계
			if( Str_Cmp(stSubCustInfo.SCG_RELAT_CD, stScCustInfo.SCG_RELAT_CD) != 0 )
			{
				lChk++;
			}
		}
		else
		{
			// 성향
			if( Str_Cmp(stSubCustInfo.CUST_TRND_CD, stSc.CUST_TRND_CD) != 0 )
			{
				lChk++;
			}
			
			// 핸드폰번호1
			if( Str_Cmp(stSubCustInfo.CP_DDD, stSc.CP_DDD) != 0 )
			{
				lChk++;
			}
			
			// 핸드폰번호2
			if( Str_Cmp(stSubCustInfo.CP_EXN, stSc.CP_EXN) != 0 )
			{
				lChk++;
			}
			
			// 핸드폰번호3
			if( Str_Cmp(stSubCustInfo.CP_NUM, stSc.CP_NUM) != 0 )
			{
				lChk++;
			}
			
			// 자택번호1
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_DDD, stSc.OWNHOUSE_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// 자택번호2
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_EXN, stSc.OWNHOUSE_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// 자택번호3
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_NUM, stSc.OWNHOUSE_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// 빌트인
			if( Str_Cmp(stSubCustInfo.BUILT_IN_YN, stSc.BUILT_IN_YN) != 0 )
			{
				lChk++;
			}
			
			// 인덕션
			if( Str_Cmp(stSubCustInfo.INDUCTION_INST_YN, stSc.INDUCTION_INST_YN) != 0 )
			{
				lChk++;
			}
			
			// 사회복지시설 -> 대상이 Y인 경우면 무조건 데이터 만들도록 한다.
			if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
			{
				lChk++;
			}
			
			// 회사번호1
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_DDD, stSc.FIRM_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// 회사번호2
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_EXN, stSc.FIRM_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// 회사번호3
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_NUM, stSc.FIRM_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// 팩스1
			if( Str_Cmp(stSubCustInfo.FAX_DDD, stSc.FAX_DDD) != 0 )
			{
				lChk++;
			}
			
			// 팩스2
			if( Str_Cmp(stSubCustInfo.FAX_EXN, stSc.FAX_EXN) != 0 )
			{
				lChk++;
			}
			
			// 팩스3
			if( Str_Cmp(stSubCustInfo.FAX_NUM, stSc.FAX_NUM) != 0 )
			{
				lChk++;
			}
			
			// 이메일
			if( Str_Len(stSubCustInfo.EMAILADDR) > 0 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, stSubCustInfo.EMAIL);
				Str_Cat(szTmp, "@");
				Str_Cat(szTmp, stSubCustInfo.EMAILADDR);
				if( Str_Cmp(szTmp, stSc.EMAIL) != 0 )
				{
					lChk++;
				}
			}
			
			// 면적
			if( Str_Cmp(stSubCustInfo.SQUARE_METER, stSc.SQUARE_METER) != 0 )
			{
				lChk++;
			}
			
			// 가족수
			if( Str_Cmp(stSubCustInfo.FAMILY_CNT, stSc.FAMILY_CNT) != 0 )
			{
				lChk++;
			}
			
			// 당사관계
			if( Str_Cmp(stSubCustInfo.SCG_RELAT_CD, stSc.SCG_RELAT_CD) != 0 )
			{
				lChk++;
			}
		}
		
		if( lChk > 0 )
		{
			ret = FALSE;
		}
		else
		{
			ret = TRUE;
		}

		return ret;
	}


	/*=======================================================================================
	함수명 : SMSREQ_DRAW
	기  능 : SMS draw
	Param  : 
	Return :
	========================================================================================*/	
	void SMSREQ_DRAW(void)
	{
		long i;
		char szAddr[100];
	
		for ( i = 0 ;  SCSMSTEL[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA11+2), SCSMSTEL[i].Str, 0, ICON_NONE);
		}
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA47), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA48), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA49), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA50), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA51), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA52), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA53), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA54), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA11), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA12), EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA11), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA46), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA52), TRUE, 2, EDITSEP_NONE );
		
		// 고객성명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA45), stSc.CUST_NM);
		
		// 주소
		Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr) );
		
		if( g_nAddrFlag == 0)
		{
			Str_Cpy(szAddr,  stSc.CITY );
			
			if(Str_Len(stSc.COUNTY) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.COUNTY );
			}
						
			if(Str_Len(stSc.TOWN) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.TOWN );
			}
			
			if(Str_Len(stSc.ADDR1_M) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.ADDR1_M);
			}
						
			if(Str_Len(stSc.ADDR1_S) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stSc.ADDR1_S);
			}
			
			// 조회화면에서의 주소
			Str_Cat(szAddr,  stSc.LOT_NUM_SECOND_ADDR );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.CO_LIVE_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.BLD_NM );		
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.HOUSE_CNT );		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA46), szAddr);
		}
		else
		{
			Str_Cpy(szAddr,  stSc.CITY );
			
			if(Str_Len(stSc.COUNTY) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.COUNTY );
			}
					
			if(Str_Len(stSc.NEW_ROAD_NM) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.NEW_ROAD_NM );
			}
			
			if(Str_Len(stSc.NEW_ADDR_M) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.NEW_ADDR_M);
			}
			
			if(Str_Len(stSc.NEW_ADDR_S) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stSc.NEW_ADDR_S);
			}
			
			// 조회화면에서의 주소
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.CO_LIVE_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.BLD_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.HOUSE_CNT );		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA46), szAddr);
		}
		
		// 휴대전화
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA11), stSc.CP_DDD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA11), stSc.CP_EXN);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA12), stSc.CP_NUM);
		
		// 예, 아니오
		if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "Y" ) == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
			
			m_lSmsReqFlag = 1;
		}
		else if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "N" ) == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
			
			m_lSmsReqFlag = 2;
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_SmsReq
	기  능 : SMS신청/FR312314
	Param  : 
	Return :
	========================================================================================*/	
	void Snd_SmsReq(void)
	{
		char szUrl[200];
		char szbuf[128];
		char szCUST_NM[62];
		char szDay[11];
		char* sndbuf;
		long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
			
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312314, FALSE);
		
		Str_Cpy(stSc.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA11)) );
		Str_Cpy(stSc.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)) );
		Str_Cpy(stSc.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12)) );
		
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",   stSc.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num", stSc.INST_PLACE_NUM );
		
		Mem_Set( (byte*) szCUST_NM, 0x00, sizeof( szCUST_NM) );
		SQL_ConvUcStr( szCUST_NM, stSc.CUST_NM );
		
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",  szCUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "tel_ddd",  stSc.CP_DDD );
		JSON_SetValue( g_pjcomm, 'C', "tel_exn",  stSc.CP_EXN );
		JSON_SetValue( g_pjcomm, 'C', "tel_num",  stSc.CP_NUM );
		
		if( m_lSmsReqFlag == 1 )
		{
			JSON_SetValue( g_pjcomm, 'C', "sms_send_agree_yn",  "Y" );
		}
		else if( m_lSmsReqFlag == 2 )
		{
			JSON_SetValue( g_pjcomm, 'C', "sms_send_agree_yn",  "N" );
		}
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR312314;
		ret = HTTP_DownloadData(szUrl, "FR312314_IN",  "FR312314" , sndbuf, szbuf );
		return;
	}

	/*=======================================================================================
	함수명 : TR312314
	기  능 : FR312314 callback
	Param  : 
	Return :
	========================================================================================*/	
	long TR312314(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(312314) >= 0 )
		{
			CloseMessageBox();
			
			if( Save_SmsReq() )
			{
				ON_EXIT();
				OnInit(INIT_MAIN);
				ON_DRAW();
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
	함수명 : Save_SmsReq
	기  능 : SMS 신청 저장
	Param  : 
	Return :
	========================================================================================*/	
	bool Save_SmsReq(void)
	{
		char szSql[100];
		long idx;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		// 핸드폰번호
		Str_Cpy(stSc.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA11)) );
		Str_Cpy(stSc.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)) );
		Str_Cpy(stSc.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12)) );
		
		// 동의여부
		if( m_lSmsReqFlag == 1 )
		{
			Str_Cpy(stSc.SMS_SEND_AGREE_YN, "Y");
		}
		else
		{
			Str_Cpy(stSc.SMS_SEND_AGREE_YN, "N");
		}
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE NORMAL_DATA SET SMS_SEND_AGREE_YN = ? WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stSc.SMS_SEND_AGREE_YN	,2 ,DECRYPT);

		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "Y" ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "SMS신청 등록을\n완료하였습니다.");
			}
			else if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "N" ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "SMS신청 거부를\n완료하였습니다.");
			}
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}

	/*=======================================================================================
	함수명 : Chk_Ptrn
	기  능 : 고객패턴 check
	Param  : 
	Return :
	========================================================================================*/	
	bool Chk_Ptrn(void)
	{
		char szSql[200];
		char szTmp[20];
		long lCnt = 0;
		bool bRet = FALSE;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		
		SPRINT(szSql, "SELECT COUNT(*) FROM CUST_PATT_COLL_INFO WHERE BLD_NUM = '%s' AND INST_PLACE_NUM = '%s' ", stSc.BLD_NUM, stSc.INST_PLACE_NUM, 0 );

		g_Sql_RetInt(szSql, &lCnt);

		if( lCnt == 0 )
		{
			bRet = TRUE;
		}

		return bRet;
	}
	
	/*=======================================================================================
	함수명 : ReqMsg
	기  능 : 청구방법 메세지
	Param  : 
	Return :
	========================================================================================*/
	void ReqMsg(void)
	{
		char strMsg[200];
		
		Mem_Set( (byte *)strMsg, 0x00, sizeof(strMsg) );
		
		if( Str_Cmp(stSc.CONT_STS_CD, "30") != 0 )
		{
			if( Str_Cmp(stSc.BILL_SEND_METHOD, "M") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ 모바일 ] 입니다.\n \n");
				Str_Cat(strMsg, "전화번호 : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "L") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ LMS ] 입니다.\n \n");
				Str_Cat(strMsg, "전화번호 : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "E") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ 이메일 ] 입니다.\n \n");
				Str_Cat(strMsg, "이메일주소 : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "A") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ 이메일 ] 입니다.\n \n");
				Str_Cat(strMsg, "이메일주소 : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "B") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ LMS ] 입니다.\n \n");
				Str_Cat(strMsg, "전화번호 : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "C") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ 모바일 ] 입니다.\n \n");
				Str_Cat(strMsg, "전화번호 : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "D") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ 모바일,EMAIL ] 입니다.\n \n");
				Str_Cat(strMsg, "전화번호 : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				Str_Cat(strMsg, "이메일주소 : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "F") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ LMS,EMAIL ] 입니다.\n \n");
				Str_Cat(strMsg, "전화번호 : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				Str_Cat(strMsg, "이메일주소 : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "G") == 0 )
			{
				Str_Cat(strMsg, "고객님의 청구방법은\n[ LMS,모바일 ] 입니다.\n \n");
				Str_Cat(strMsg, "전화번호 : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
		}

		REDRAW();	
	}
}
