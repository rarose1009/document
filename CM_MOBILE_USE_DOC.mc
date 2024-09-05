/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MOBILE_USE_DOC
	Card Desc : 모바일 사용계약서
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MOBILE_USE_DOC
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
	#define USE_ON_SELECT
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/*  공통                        */
		/********************************/
		DEF_BUTTON_ID ( BID_CLOSE )					// 메인_CLOSE
		
		/********************************/
		/* 탭                          */
		/********************************/
		DEF_BUTTON_ID ( BID_TAB_CUST_INFO )			// 탭_고객정보
		DEF_BUTTON_ID ( BID_TAB_PAY_METHOD )		// 탭_납부방법
		DEF_BUTTON_ID ( BID_TAB_AGREE )				// 탭_개인정보 활용 동의서
		DEF_BUTTON_ID ( BID_TAB_SIGN )				// 탭_확인
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		DEF_BUTTON_ID ( BID_CI_ADDR )				// 고객정보_주소
		
		DEF_BUTTON_ID ( BID_CI_CHKBOX_GENDER_MAN )	// 고객정보_체크박스_성별_Y
		DEF_BUTTON_ID ( BID_CI_CHKBOX_GENDER_GIRL )	// 고객정보_체크박스_성별_N
		
		DEF_BUTTON_ID ( BID_CI_CHKBOX_TXBILL_Y )	// 고객정보_체크박스_세금계산서_Y
		DEF_BUTTON_ID ( BID_CI_CHKBOX_TXBILL_N )	// 고객정보_체크박스_세금계산서_N
		
		DEF_BUTTON_ID ( BID_CI_CUST_NM )			// 고객정보_고객명
		DEF_BUTTON_ID ( BID_CI_EMAIL )				// 고객정보_이메일
		DEF_BUTTON_ID ( BID_CI_FRIM )				// 고객정보_상호
		
		/********************************/
		/* 개인정보 활용 첫번째 동의서  */
		/********************************/	
		DEF_BUTTON_ID ( BID_FAG_AGREE_CHK_OK )		// 동의서_동의서확인
		
		/********************************/
		/* 개인정보 활용 동의서         */
		/********************************/	
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_1_Y )	// 동의서_체크박스_동의_1_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_1_N )	// 동의서_체크박스_동의_1_N
		DEF_BUTTON_ID ( BID_AG_AGREE_1_DETAIL )		// 동의서_동의_1_상세
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_2_Y )	// 동의서_체크박스_동의_2_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_2_N )	// 동의서_체크박스_동의_2_N
		DEF_BUTTON_ID ( BID_AG_AGREE_2_DETAIL )		// 동의서_동의_2_상세
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_3_Y )	// 동의서_체크박스_동의_3_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_3_N )	// 동의서_체크박스_동의_3_N
		DEF_BUTTON_ID ( BID_AG_AGREE_3_DETAIL )		// 동의서_동의_3_상세
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_4_Y )	// 동의서_체크박스_동의_4_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_4_N )	// 동의서_체크박스_동의_4_N
		DEF_BUTTON_ID ( BID_AG_AGREE_4_DETAIL )		// 동의서_동의_4_상세
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_5_Y )	// 동의서_체크박스_동의_5_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_5_N )	// 동의서_체크박스_동의_5_N
		DEF_BUTTON_ID ( BID_AG_AGREE_5_DETAIL )		// 동의서_동의_5_상세
		
		DEF_BUTTON_ID ( BID_AG_ALL_AGREE )			// 동의서_전체동의
		
		/********************************/
		/* 동의내용_1                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_1_NEXT )				// 동의내용_1_화면_NEXT
		DEF_BUTTON_ID ( BID_AV_1_CLOSE )			// 동의내용_1_화면_CLOSE
		
		/********************************/
		/* 동의내용_2                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_2_NEXT )				// 동의내용_2_화면_NEXT
		DEF_BUTTON_ID ( BID_AV_2_CLOSE )			// 동의내용_2_화면_CLOSE
		
		/********************************/
		/* 동의내용_3                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_3_NEXT )				// 동의내용_3_화면_NEXT
		DEF_BUTTON_ID ( BID_AV_3_CLOSE )			// 동의내용_3_화면_CLOSE
		
		/********************************/
		/* 동의내용_4                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_4_NEXT )				// 동의내용_4_화면_NEXT
		DEF_BUTTON_ID ( BID_AV_4_CLOSE )			// 동의내용_4_화면_CLOSE
		
		/********************************/
		/* 동의내용_5                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_5_NEXT )				// 동의내용_5_화면_NEXT
		DEF_BUTTON_ID ( BID_AV_5_CLOSE )			// 동의내용_5_화면_CLOSE
		
		/********************************/
		/* 자동이체                     */
		/********************************/
		DEF_BUTTON_ID ( BID_AT_BACK )				// 자동이체_BACK(되돌리기)
		DEF_BUTTON_ID ( BID_AT_INIT )				// 자동이체_INIT(초기화)
		DEF_BUTTON_ID ( BID_AT_SAVE )				// 자동이체_SAVE
		
		DEF_BUTTON_ID ( BID_AT_DEP_NM )				// 자동이체_예금주명
		DEF_BUTTON_ID ( BID_AT_ALT_NM )				// 자동이체_대리인명
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* 공통                         */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )					// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )				// 아이콘
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		DEF_OBJECT_ID ( ST_CI_MTR_ID_NUM )			// ST_고객정보_기물번호
		DEF_OBJECT_ID ( TXT_CI_MTR_ID_NUM )			// TXT_고객정보_기물번호
		DEF_OBJECT_ID ( TXT_CI_ADDR )				// TXT_고객정보_주소
		DEF_OBJECT_ID ( ST_CI_CUST_NM )				// ST_고객정보_고객명
		DEF_OBJECT_ID ( ST_CI_BRITH_YMD )			// ST_고객정보_생일월일
		DEF_OBJECT_ID ( ST_CI_HP_1 )				// ST_고객정보_휴대폰번호
		DEF_OBJECT_ID ( TXT_CI_HP_2 )				// TXT_고객정보_휴대폰번호_-
		DEF_OBJECT_ID ( TXT_CI_HP_3 )				// TXT_고객정보_휴대폰번호_-
		DEF_OBJECT_ID ( ST_CI_TEL_1 )				// ST_고객정보_자택번호
		DEF_OBJECT_ID ( TXT_CI_TEL_2 )				// TXT_고객정보_자택번호_-
		DEF_OBJECT_ID ( TXT_CI_TEL_3 )				// TXT_고객정보_자택번호_-
		DEF_OBJECT_ID ( ST_CI_EMAIL_1 )				// ST_고객정보_이메일
		DEF_OBJECT_ID ( TXT_CI_EMAIL_2 )			// TXT_고객정보_이메일_@
		DEF_OBJECT_ID ( ST_CI_FIRM )				// ST_고객정보_상호
		DEF_OBJECT_ID ( ST_CI_TXBILL )				// ST_고객정보_세금계산서
		DEF_OBJECT_ID ( ST_CI_BIZREGNUM )			// ST_고객정보_사업자등록번호
		DEF_OBJECT_ID ( ST_CI_BILL_SEND_METHOD )	// ST_고객정보_요금청구방법
		
		/********************************/
		/* 개인정보 활용  첫번째 동의서 */
		/********************************/
		DEF_OBJECT_ID ( TXT_FAG_AGREE )				// TXT_동의서_동의서
		
		/********************************/
		/* 개인정보 활용 동의서         */
		/********************************/
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_1 )		// ST_동의서_동의서1
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_2 )		// ST_동의서_동의서2
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_3 )		// ST_동의서_동의서3
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_4 )		// ST_동의서_동의서4
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_5 )		// ST_동의서_동의서5
		
		/********************************/
		/* 동의내용_1                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_1_1 )					// ST_동의내용_1_1
		DEF_OBJECT_ID ( TXT_AV_1_1 )				// TXT_동의내용_1_1
		
		DEF_OBJECT_ID ( ST_AV_1_2 )					// ST_동의내용_1_2
		DEF_OBJECT_ID ( TXT_AV_1_2 )				// TXT_동의내용_1_2
		
		DEF_OBJECT_ID ( ST_AV_1_3 )					// ST_동의내용_1_3
		DEF_OBJECT_ID ( TXT_AV_1_3 )				// TXT_동의내용_1_3
		
		/********************************/
		/* 동의내용_2                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_2_1 )					// ST_동의내용_2_1
		DEF_OBJECT_ID ( TXT_AV_2_1 )				// TXT_동의내용_2_1
		
		DEF_OBJECT_ID ( ST_AV_2_2 )					// ST_동의내용_2_2
		DEF_OBJECT_ID ( TXT_AV_2_2 )				// TXT_동의내용_2_2
		
		DEF_OBJECT_ID ( ST_AV_2_3 )					// ST_동의내용_2_3
		DEF_OBJECT_ID ( TXT_AV_2_3 )				// TXT_동의내용_2_3
		
		DEF_OBJECT_ID ( ST_AV_2_4 )					// ST_동의내용_2_4
		DEF_OBJECT_ID ( TXT_AV_2_4 )				// TXT_동의내용_2_4
		
		DEF_OBJECT_ID ( TXT_AV_2_5 )				// TXT_동의내용_2_5
		
		/********************************/
		/* 동의내용_3                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_3_1 )					// ST_동의내용_3_1
		DEF_OBJECT_ID ( TXT_AV_3_1 )				// TXT_동의내용_3_1
		
		DEF_OBJECT_ID ( ST_AV_3_2 )					// ST_동의내용_3_2
		DEF_OBJECT_ID ( TXT_AV_3_2 )				// TXT_동의내용_3_2
		
		DEF_OBJECT_ID ( ST_AV_3_3 )					// ST_동의내용_3_3
		DEF_OBJECT_ID ( TXT_AV_3_3 )				// TXT_동의내용_3_3
		
		DEF_OBJECT_ID ( ST_AV_3_4 )					// ST_동의내용_3_4
		DEF_OBJECT_ID ( TXT_AV_3_4 )				// TXT_동의내용_3_4
		
		DEF_OBJECT_ID ( TXT_AV_3_5 )				// TXT_동의내용_3_5
		
		/********************************/
		/* 동의내용_4                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_4_1 )					// ST_동의내용_4_1
		DEF_OBJECT_ID ( TXT_AV_4_1_1 )				// TXT_동의내용_4_1_1
		DEF_OBJECT_ID ( TXT_AV_4_1_2 )				// TXT_동의내용_4_1_2
		
		DEF_OBJECT_ID ( ST_AV_4_2 )					// ST_동의내용_4_2
		DEF_OBJECT_ID ( TXT_AV_4_2_1 )				// TXT_동의내용_4_2_1
		DEF_OBJECT_ID ( TXT_AV_4_2_2 )				// TXT_동의내용_4_2_2
		
		DEF_OBJECT_ID ( ST_AV_4_3 )					// ST_동의내용_4_3
		DEF_OBJECT_ID ( TXT_AV_4_3 )				// TXT_동의내용_4_3
		
		DEF_OBJECT_ID ( ST_AV_4_4 )					// ST_동의내용_4_4
		DEF_OBJECT_ID ( TXT_AV_4_4 )				// TXT_동의내용_4_4
		
		DEF_OBJECT_ID ( ST_AV_4_5 )					// ST_동의내용_4_5
		DEF_OBJECT_ID ( TXT_AV_4_5 )				// TXT_동의내용_4_5
		
		DEF_OBJECT_ID ( TXT_AV_4_6 )				// TXT_동의내용_4_6
		
		/********************************/
		/* 동의내용_5                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_5_1 )					// ST_동의내용_5_1
		DEF_OBJECT_ID ( TXT_AV_5_1 )				// TXT_동의내용_5_1
		
		DEF_OBJECT_ID ( ST_AV_5_2 )					// ST_동의내용_5_2
		DEF_OBJECT_ID ( TXT_AV_5_2 )				// TXT_동의내용_5_2
		
		DEF_OBJECT_ID ( ST_AV_5_3 )					// ST_동의내용_5_3
		DEF_OBJECT_ID ( TXT_AV_5_3 )				// TXT_동의내용_5_3
		
		DEF_OBJECT_ID ( TXT_AV_5_4 )				// TXT_동의내용_5_5
		
		/********************************/
		/* 자동이체                     */
		/********************************/
		DEF_OBJECT_ID ( ST_AT_BANK )				// ST_자동이체_은행
		DEF_OBJECT_ID ( ST_AT_DEP_NM )				// ST_자동이체_예금주_명
		DEF_OBJECT_ID ( ST_AT_DEP_TEL_1 )			// ST_자동이체_예금주_TEL
		DEF_OBJECT_ID ( TXT_AT_DEP_TEL_2 )			// TXT_자동이체_예금주_TEL_-
		DEF_OBJECT_ID ( TXT_AT_DEP_TEL_3 )			// TXT_자동이체_예금주_TEL_-
		DEF_OBJECT_ID ( ST_AT_ACCOUNT )				// ST_자동이체_계좌번호
		DEF_OBJECT_ID ( ST_AT_DEP_BRITHDAY )		// ST_자동이체_생년월일
		
		DEF_OBJECT_ID ( ST_AT_DEP_RELAT )			// ST_자동이체_예금주_관계
		DEF_OBJECT_ID ( ST_AT_ALT_NM )				// ST_자동이체_대리인_명
		DEF_OBJECT_ID ( ST_AT_ALT_TEL_1 )			// ST_자동이체_대리인_TEL
		DEF_OBJECT_ID ( TXT_AT_ALT_TEL_2 )			// TXT_자동이체_대리인_TEL_-
		DEF_OBJECT_ID ( TXT_AT_ALT_TEL_3 )			// TXT_자동이체_대리인_TEL_-
		
		DEF_OBJECT_ID ( ST_AT_PAY_METHOD )			// ST_자동이체_지로번호
		
		/********************************/
		/* 라인                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA_1 )				// 라인_1
		DEF_OBJECT_ID ( LINE_DATA_2 )				// 라인_2
		DEF_OBJECT_ID ( LINE_DATA_3 )				// 라인_3
		DEF_OBJECT_ID ( LINE_DATA_4 )				// 라인_4
		DEF_OBJECT_ID ( LINE_DATA_5 )				// 라인_5
		DEF_OBJECT_ID ( LINE_DATA_6 )				// 라인_6
		DEF_OBJECT_ID ( LINE_DATA_7 )				// 라인_7
		
		/********************************/
		/* 숫자자판_1                   */
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
		/* 숫자자판_2                   */
		/********************************/
		DEF_OBJECT_ID ( TXT_KEY_ONE_2 )
		DEF_OBJECT_ID ( TXT_KEY_TWO_2 )
		DEF_OBJECT_ID ( TXT_KEY_THREE_2 )
		DEF_OBJECT_ID ( TXT_KEY_FOUR_2 )
		DEF_OBJECT_ID ( TXT_KEY_FIVE_2 )
		DEF_OBJECT_ID ( TXT_KEY_SIX_2 )
		DEF_OBJECT_ID ( TXT_KEY_SEVEN_2 )
		DEF_OBJECT_ID ( TXT_KEY_EIGHT_2 )
		DEF_OBJECT_ID ( TXT_KEY_NINE_2 )
		DEF_OBJECT_ID ( TXT_KEY_ZERO_2 )
		DEF_OBJECT_ID ( TXT_KEY_DEL_2 )
		DEF_OBJECT_ID ( TXT_KEY_EMPTY_2 )
		
		/********************************/
		/* EDIT                         */
		/********************************/
		// 1. 고객정보
		DEF_OBJECT_ID ( EDT_CI_CUST_NM )			// EDT_고객정보_고객명
		DEF_OBJECT_ID ( EDT_CI_BRITH_YMD )			// EDT_고객정보_생일월일			
		DEF_OBJECT_ID ( EDT_CI_HP_EXN )				// EDT_고객정보_휴대폰번호
		DEF_OBJECT_ID ( EDT_CI_HP_NUM )				// EDT_고객정보_휴대폰번호
		DEF_OBJECT_ID ( EDT_CI_TEL_EXN )			// EDT_고객정보_자택번호
		DEF_OBJECT_ID ( EDT_CI_TEL_NUM )			// EDT_고객정보_자택번호
		DEF_OBJECT_ID ( EDT_CI_EMAIL )				// EDT_고객정보_이메일
		DEF_OBJECT_ID ( EDT_CI_FRIM )				// EDT_고객정보_상호
		DEF_OBJECT_ID ( EDT_CI_BIZ_REG_NUM )	    // EDT_고객정보_사업자등록번호
		
		// 2. 자동이체
		DEF_OBJECT_ID ( EDT_AT_DEP_NM )				// EDT_자동이체_예금주_명
		DEF_OBJECT_ID ( EDT_AT_ACCOUNT )			// EDT_자동이체_계좌번호
		DEF_OBJECT_ID ( EDT_AT_DEP_BRITHDAY )		// EDT_자동이체_생년월일
		DEF_OBJECT_ID ( EDT_AT_DEP_TEL_EXN )		// EDT_자동이체_TEL_EXN
		DEF_OBJECT_ID ( EDT_AT_DEP_TEL_NUM )		// EDT_자동이체_TEL_NUM
		DEF_OBJECT_ID ( EDT_AT_ALT_NM )				// EDT_자동이체_대리인_명
		DEF_OBJECT_ID ( EDT_AT_ALT_TEL_EXN )		// EDT_자동이체_대리인_전화번호_EXN
		DEF_OBJECT_ID ( EDT_AT_ALT_TEL_NUM )		// EDT_자동이체_대리인_전화번호_NUM
		
		/********************************/
		/* COMBO                        */
		/********************************/
		// 1. 고객정보
		DEF_OBJECT_ID ( CMB_CI_HP_DDD )										// COMBO_고객정보_HP_DDD
		DEF_OBJECT_ID ( CMB_CI_TEL_DDD = CMB_CI_HP_DDD + 3 )				// COMBO_고객정보_TEL_DDD
		DEF_OBJECT_ID ( CMB_CI_EMAIL = CMB_CI_TEL_DDD + 3 )					// COMBO_고객정보_EMAIL
		DEF_OBJECT_ID ( CMB_CI_BILL_SEND_METHOD = CMB_CI_EMAIL + 3 )		// COMBO_고객정보_요금청구방법
			
		// 2. 자동이체
		DEF_OBJECT_ID ( CMB_AT_PAY_METHOD = CMB_CI_BILL_SEND_METHOD + 3 )	// COMBO_자동이체_납부방법
		DEF_OBJECT_ID ( CMB_AT_BANK = CMB_AT_PAY_METHOD + 3 )				// COMBO_자동이체_은행
		DEF_OBJECT_ID ( CMB_AT_DEP_TEL_DDD = CMB_AT_BANK + 3 )				// COMBO_자동이체_예금주_TEL_DDD
		DEF_OBJECT_ID ( CMB_AT_DEP_RELAT = CMB_AT_DEP_TEL_DDD + 3 )			// COMBO_자동이체_예금주_관계
		DEF_OBJECT_ID ( CMB_AT_ALT_TEL_DDD = CMB_AT_DEP_RELAT + 3 )			// COMBO_자동이체_대리인_TEL_DDD
		
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_CUSTINFO		1		// 고객정보
	#define INIT_FIRST_AGREE	2		// 개인정보 활용 첫번째 동의서
	#define INIT_AGREE			3		// 개인정보 활용 동의서
	#define INIT_AGREEVIEW_1	4		// 동의내용_1
	#define INIT_AGREEVIEW_2	5		// 동의내용_2
	#define INIT_AGREEVIEW_3	6		// 동의내용_3
	#define INIT_AGREEVIEW_4	7		// 동의내용_4
	#define INIT_AGREEVIEW_5	8		// 동의내용_5
	#define INIT_AUTOTRANS  	9		// 자동이체
	
	// 성별 체크박스
	#define CHKBOX_MAN_N				"남 □"
	#define CHKBOX_MAN_Y				"남 ▣"
	#define CHKBOX_GIRL_N				"여 □"
	#define CHKBOX_GIRL_Y				"여 ▣"
	
	// 세금계산서 발행여부
	#define CHKBOX_TXBILL_PUBL_N		"발행 □"
	#define CHKBOX_TXBILL_PUBL_Y		"발행 ▣"
	#define CHKBOX_TXBILL_NON_PUBL_N	"해당없음 □"
	#define CHKBOX_TXBILL_NON_PUBL_Y	"해당없음 ▣"
	
	// 개인정보 수집 및 이용 동의[필수]
	#define CHKBOX_AGREE_1_N			"동의 □"
	#define CHKBOX_AGREE_1_Y			"동의 ▣"
	#define CHKBOX_NON_AGREE_1_N		"미동의 □"
	#define CHKBOX_NON_AGREE_1_Y		"미동의 ▣"
	
	// 개인(신용)정보 제공 동의[필수]
	#define CHKBOX_AGREE_2_N			"동의 □"
	#define CHKBOX_AGREE_2_Y			"동의 ▣"
	#define CHKBOX_NON_AGREE_2_N		"미동의 □"
	#define CHKBOX_NON_AGREE_2_Y		"미동의 ▣"
	
	// 개인(신용)정보 조회 동의[선택]
	#define CHKBOX_AGREE_3_N			"동의 □"
	#define CHKBOX_AGREE_3_Y			"동의 ▣"
	#define CHKBOX_NON_AGREE_3_N		"미동의 □"
	#define CHKBOX_NON_AGREE_3_Y		"미동의 ▣"
	
	// 고유식별정보 제공 및 제공받는 동의[선택]
	#define CHKBOX_AGREE_4_N			"동의 □"
	#define CHKBOX_AGREE_4_Y			"동의 ▣"
	#define CHKBOX_NON_AGREE_4_N		"미동의 □"
	#define CHKBOX_NON_AGREE_4_Y		"미동의 ▣"
	
	// 마케팅 수신 및 개인정보 활용 동의[선택]
	#define CHKBOX_AGREE_5_N			"동의 □"
	#define CHKBOX_AGREE_5_Y			"동의 ▣"
	#define CHKBOX_NON_AGREE_5_N		"미동의 □"
	#define CHKBOX_NON_AGREE_5_Y		"미동의 ▣"
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_bFirst;						// 화면 Index
	long m_lActiveIndex;				// 현재 터치한 Index
	long m_lAgreeChk_Ok = 0;			// 동의서 화면 최초 확인 버튼_환면 전환 여부, 0 = 누르지 않음, 1 = 누름
	long m_lAgreeChk_Ok_Validation = 0; // 동의서 화면 최초 확인 버튼_Validation에 필요, 0 = 누르지 않음, 1 = 누름
	long m_lAllAgree = 0;				// 전체동의 버튼 눌렀는지 여부 : 0 = 안누름, 1 = 누름
	long m_lAddr_Chg = 1;    			// 조회 주소 변경 flag : 0 = 지번, 1 = 도로명
	long m_lDlgflag = 0;				// 키보드 flag
	long m_lBackAutoTrans = 0;			// 자동이체 되돌리기 flag : 0 = 되돌리기 상태, 1 = 초기화 상태(데이터 수정)
	long m_lPayMethod_Chk = 0;			// 납부방법 확인 유무 : 0 = 미확인, 1 = 확인
	char m_szTitle[50];         		// 타이틀	
	handle m_hBody = NULL;				// OzView Body handle
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void SetCombo(void);
	void SetCombo_Filter(void);
	void SetTab(long flag);
	void SetTitle(void);
	void setCardMove(void);
		
	void Snd_OzView(void);
	long TR822566(void);
		
	void SetOzView_Data(void);
	void SetOzView_JsonBody(SQLITE sql);
	void SetOzView_JsonArray_Bank(SQLITE sql);
	void SetOzView_JsonArray_Payment(void);
	void Rcv_OzData(char* szOzData);

	void SetViewAutoTrans(long flag);
	void SetBackAutoTrans(void);
	void ClearAutoTrans(void);
	
	void Save_Cust_Info_Data(void);
	void Save_PayMethod_Info_Data(void);
	
	long ChkChgUserInfo(void);
	long ChkOzTransReqFlag(void);
	
	bool Validation_Custinfo(void);
	bool Validation_Agree(void);
	bool Validation_PayMethod( long flag );
	
	//---------------------------------------------------------------------------------------
	// 고객정보 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CustInfo[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, "" ),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* 탭 ********/
		DLG_BUTTON(STARTX  +12, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_CUST_INFO, "고객정보"),
		DLG_BUTTON(STARTX +256, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_PAY_METHOD, "납부방법"),
		DLG_BUTTON(STARTX +500, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_AGREE, "동의서"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "서명"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,      DARKSLATEBLUE, 10, LINE_DATA_1),
		
		/******* 고객정보 *******/
		DLG_TEXT ( STARTX,      STARTY  +66,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_MTR_ID_NUM, "기물번호"),
		DLG_TEXT ( STARTX +220, STARTY  +66,  780,  66,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_MTR_ID_NUM, ""),
		
		DLG_BUTTON(STARTX,	    STARTY +132,  220, 147,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CI_ADDR, "주소"),
		DLG_TEXT ( STARTX +220, STARTY +132,  780, 147,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_ADDR, ""),
		
		DLG_LINE ( STARTX,      STARTY +283, 1000, STARTY +283,     DARKSLATEBLUE, 10, LINE_DATA_2),
		
		DLG_TEXT ( STARTX,      STARTY +288,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_CUST_NM, "고객명"),
		DLG_BUTTON(STARTX +220, STARTY +288,  780,  66,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CUST_NM,  ""),
		DLG_EDIT ( STARTX +220, STARTY +288,  780,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_CUST_NM, 10,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +354,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_BRITH_YMD, "생년월일"),
		DLG_EDIT ( STARTX +220, STARTY +354,  345,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_BRITH_YMD, 6,  ""),
		
		DLG_BUTTON(STARTX +565, STARTY +354,  217,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_GENDER_MAN, CHKBOX_MAN_N),  // 남 체크박스
		DLG_BUTTON(STARTX +782, STARTY +354,  218,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_GENDER_GIRL, CHKBOX_GIRL_N), // 여 체크박스
		
		DLG_TEXT ( STARTX,      STARTY +420,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_HP_1 , "핸드폰"),
		
		DLG_COMBO (STARTX +220, STARTY +420,  290,  66, 115, 66,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_HP_DDD, 5), // 핸드폰 콤보
		
		DLG_TEXT ( STARTX +510, STARTY +420,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_HP_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +420,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_HP_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +420,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_HP_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +420,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_HP_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +486,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CI_TEL_1, "전화"),
		
		DLG_COMBO (STARTX +220, STARTY +486,  290,  66, 115, 65,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_TEL_DDD, 5), // 전화 콤보
		
		DLG_TEXT ( STARTX +510, STARTY +486,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_TEL_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +486,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_TEL_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +486,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_TEL_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +486,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_TEL_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +552,  395,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_FIRM , "상호(법인명)"),
		DLG_BUTTON(STARTX +395, STARTY +552,  605,  66,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_FRIM,  ""),
		DLG_EDIT ( STARTX +395, STARTY +552,  605,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_FRIM, 15,  ""),
		
		DLG_LINE ( STARTX,      STARTY +622, 1000, STARTY +622,     DARKSLATEBLUE, 10, LINE_DATA_3),
		
		DLG_TEXT ( STARTX,      STARTY +627,  395,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK, ST_CI_BILL_SEND_METHOD , "요금청구방법"),
		DLG_COMBO (STARTX +395, STARTY +627,  605,  66, 115, 66,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_BILL_SEND_METHOD, 5), // 요금청구방법 콤보	
		
		DLG_TEXT ( STARTX,      STARTY +693,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_EMAIL_1 , "이메일"),
		DLG_BUTTON(STARTX +220, STARTY +693,  290,  66,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_EMAIL,  ""),
		DLG_EDIT ( STARTX +220, STARTY +693,  290,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_EMAIL, 15,  ""),
		
		DLG_TEXT ( STARTX +510, STARTY +693,   70,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_EMAIL_2, "@"),
		
		DLG_COMBO (STARTX +580, STARTY +693,  420,  66, 115, 66,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_EMAIL, 5), // 이메일 콤보
		
		DLG_LINE ( STARTX,      STARTY +763, 1000, STARTY +763,     DARKSLATEBLUE, 10, LINE_DATA_4),
		
		DLG_TEXT ( STARTX,      STARTY +768,  370,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_TXBILL , "세금계산서"),
		DLG_BUTTON(STARTX +370, STARTY +767,  315,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_TXBILL_Y, CHKBOX_TXBILL_PUBL_N),     // 발행 체크박스 
		DLG_BUTTON(STARTX +685, STARTY +767,  315,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_TXBILL_N, CHKBOX_TXBILL_NON_PUBL_N), // 해당없음 체크박스
		
		DLG_TEXT ( STARTX,      STARTY +834,  370,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_BIZREGNUM , "사업자등록번호"),
		DLG_EDIT ( STARTX +370, STARTY +834,  630,  65,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_BIZ_REG_NUM, 10,  ""),
		
		// 숫자 자판
		DLG_LINE ( STARTX,      STARTY +903, 1000, STARTY +903,  	DARKSLATEBLUE, 10, LINE_DATA_6),
		DLG_TEXT ( 0,           STARTY +908,  333,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_ONE, "1"),
		DLG_TEXT ( 333,  		STARTY +908,  333,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_TWO, "2"),
		DLG_TEXT ( 666,  		STARTY +908,  334,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_THREE, "3"),
		DLG_TEXT ( 0,   		STARTY +998,  333,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_FOUR, "4"),
		DLG_TEXT ( 333, 		STARTY +998,  333,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_FIVE, "5"),
		DLG_TEXT ( 666, 		STARTY +998,  334,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_SIX, "6"),
		DLG_TEXT ( 0,   		STARTY+1088,  333,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_SEVEN, "7"),
		DLG_TEXT ( 333, 		STARTY+1088,  333,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_EIGHT, "8"),
		DLG_TEXT ( 666, 		STARTY+1088,  334,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_NINE, "9"),
		DLG_TEXT ( 333, 		STARTY+1178,  333,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_ZERO, "0"),
		DLG_TEXT ( 666, 		STARTY+1178,  334,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_DEL, "←"),
	};
	
	//---------------------------------------------------------------------------------------
	// 개인정보 활용 첫 화면 동의서 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_First_Agree[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* 탭 ********/
		DLG_BUTTON(STARTX  +12, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_CUST_INFO, "고객정보"),
		DLG_BUTTON(STARTX +256, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_PAY_METHOD, "납부방법"),
		DLG_BUTTON(STARTX +500, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_AGREE, "동의서"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "서명"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,      DARKSLATEBLUE, 10, LINE_DATA_1),
		
		/******* 메인 동의서 ********/
		DLG_TEXT ( STARTX,      STARTY  +65, 1000, 735, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_FAG_AGREE, ""),
		
		DLG_BUTTON(STARTX,	    STARTY +800, 1000,  99, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_FAG_AGREE_CHK_OK, "확 인"),
	};
	
	//---------------------------------------------------------------------------------------
	// 개인정보 활용 동의서 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_Agree[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* 탭 ********/
		DLG_BUTTON(STARTX  +12, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_CUST_INFO, "고객정보"),
		DLG_BUTTON(STARTX +256, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_PAY_METHOD, "납부방법"),
		DLG_BUTTON(STARTX +500, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_AGREE, "동의서"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "서명"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,   DARKSLATEBLUE, 10, LINE_DATA_1),
		
		/******* 동의서 항목 ********/
		DLG_TEXT ( STARTX,      STARTY  +65, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_1, "개인정보 수집 및 이용 동의[ 필수 ]"),
		DLG_BUTTON(STARTX, 		STARTY +135,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_1_Y, CHKBOX_AGREE_1_N),     // 발행 체크박스 
		DLG_BUTTON(STARTX +390,	STARTY +135,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_1_N, CHKBOX_NON_AGREE_1_N), // 해당없음 체크박스
		DLG_BUTTON(STARTX +780, STARTY +135,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_1_DETAIL, "전문보기"),
		
		DLG_LINE ( STARTX,      STARTY +209, 1000, STARTY +209,  DARKSLATEBLUE, 11, LINE_DATA_2),
		
		DLG_TEXT ( STARTX,      STARTY +214, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_2, "개인(신용)정보 제공 동의[ 필수 ]"),
		DLG_BUTTON(STARTX, 		STARTY +284,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_2_Y, CHKBOX_AGREE_2_N),     // 발행 체크박스 
		DLG_BUTTON(STARTX +390,	STARTY +284,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_2_N, CHKBOX_NON_AGREE_2_N), // 해당없음 체크박스
		DLG_BUTTON(STARTX +780, STARTY +284,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_2_DETAIL, "전문보기"),
		
		DLG_LINE ( STARTX,      STARTY +358, 1000, STARTY +358,  DARKSLATEBLUE, 10, LINE_DATA_3),
		
		DLG_TEXT ( STARTX,      STARTY +363, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_3, "개인(신용)정보 조회 동의[ 선택 ]"),
		DLG_BUTTON(STARTX, 		STARTY +433,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_3_Y, CHKBOX_AGREE_3_N),     // 발행 체크박스 
		DLG_BUTTON(STARTX +390,	STARTY +433,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_3_N, CHKBOX_NON_AGREE_3_N), // 해당없음 체크박스
		DLG_BUTTON(STARTX +780, STARTY +433,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_3_DETAIL, "전문보기"),
		
		DLG_LINE ( STARTX,      STARTY +507, 1000, STARTY +507,  DARKSLATEBLUE, 10, LINE_DATA_4),
		
		DLG_TEXT ( STARTX,      STARTY +512, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_4, "고유식별정보 제공 및 제공받는 동의[ 선택 ]"),
		DLG_BUTTON(STARTX, 		STARTY +582,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_4_Y, CHKBOX_AGREE_4_N),     // 발행 체크박스 
		DLG_BUTTON(STARTX +390,	STARTY +582,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_4_N, CHKBOX_NON_AGREE_4_N), // 해당없음 체크박스
		DLG_BUTTON(STARTX +780, STARTY +582,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_4_DETAIL, "전문보기"),
		
		DLG_LINE ( STARTX,      STARTY +656, 1000, STARTY +656,  DARKSLATEBLUE, 10, LINE_DATA_5),
		
		DLG_TEXT ( STARTX,      STARTY +661, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_5, "마케팅 수신 및 개인정보 활용 동의[ 선택 ]"),
		DLG_BUTTON(STARTX, 		STARTY +731,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_5_Y, CHKBOX_AGREE_5_N),     // 발행 체크박스 
		DLG_BUTTON(STARTX +390,	STARTY +731,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_5_N, CHKBOX_NON_AGREE_5_N), // 해당없음 체크박스
		DLG_BUTTON(STARTX +780, STARTY +731,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_5_DETAIL, "전문보기"),
		
		/******* 전체동의 *******/
		DLG_LINE ( STARTX,      STARTY +805, 1000, STARTY +805,  DARKSLATEBLUE, 10, LINE_DATA_6),
		
		DLG_BUTTON(STARTX     , STARTY +810, 1000,  89, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_ALL_AGREE, "전 체 동 의"),
	};
	
	//---------------------------------------------------------------------------------------
	// 개인정보 수집 이용 및 제공 동의 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_1[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개인정보 수집 이용 및 제공 동의[필수]       "),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_1_CLOSE, ""),
		
		/******* 내용 ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_1_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  300, 400, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_1_1, "수집·이용\n하려는 개인\n정보의 항목"),
		DLG_TEXT ( STARTX +300, STARTY  -29,  700, 400, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_1_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +371,  300, 350, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_1_2, "개인정보의\n수집·이용\n목적"),
		DLG_TEXT ( STARTX +300, STARTY +371,  700, 350, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_1_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +721,  300, 179, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_1_3, "개인정보\n보유 및\n이용기간"),
		DLG_TEXT ( STARTX +300, STARTY +721,  700, 179, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_1_3, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// 개인(신용)정보 제공 동의 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_2[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개인(신용)정보 제공 동의[필수]"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_2_CLOSE, ""),
		
		/******* 내용 ********/
		DLG_BUTTON(STARTX,	    STARTY  -29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_2_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_1, "개인정보를\n제공 받는자"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +171,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_2, "제공받는 개인\n정보의 항목"),
		DLG_TEXT ( STARTX +400, STARTY +171,  600, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +371,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_3, "개인정보를 제공\n받는자의 개인\n정보 이용 목적"),
		DLG_TEXT ( STARTX +400, STARTY +371,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +571,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_4, "개인정보 보유\n및 이용기간"),
		DLG_TEXT ( STARTX +400, STARTY +571,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_4, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_5, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// 개인(신용)정보 조회 동의 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_3[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개인(신용)정보 제공 동의[선택]"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_3_CLOSE, ""),
		
		/******* 내용 ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_3_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_1, "신용조회 회사"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +171,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_2, "조회 대상 정보"),
		DLG_TEXT ( STARTX +400, STARTY +171,  600, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +371,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_3, "조회목적"),
		DLG_TEXT ( STARTX +400, STARTY +371,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +571,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_4, "조회 동의의\n효력기간"),
		DLG_TEXT ( STARTX +400, STARTY +571,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_4, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_5, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// 고유식별정보 제공 및 제공받는 동의 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_4[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고유식별정보 제공 및 제공받는 동의[선]         "),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_4_CLOSE, ""),
		
		/******* 내용 ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_4_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_1, "고유식별정보를\n제공하는자"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_1_1, ""),
		DLG_TEXT ( STARTX +400, STARTY  +51,  600,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_1_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +131,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_2, "고유식별정보를\n제공받는자"),
		DLG_TEXT ( STARTX +400, STARTY +131,  600,  80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_2_1, ""),
		DLG_TEXT ( STARTX +400, STARTY +211,  600,  80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_2_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +291,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_3, "제공받으려는\n고유식별정보의\n항목"),
		DLG_TEXT ( STARTX +400, STARTY +291,  600, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +451,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_4, "고유식별정보를\n제공받는자의\n고유식별정보\n이용목적"),
		DLG_TEXT ( STARTX +400, STARTY +451,  600, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_4, ""),
		
		DLG_TEXT ( STARTX,      STARTY +611,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_5, "고유식별정보를\n제공받는자의\n고유식별정보\n보유 및 이용기간"),
		DLG_TEXT ( STARTX +400, STARTY +611,  600, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_5, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_6, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// 마케팅 수신 및 개인정보 활용 동의 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_5[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "마케팅 수신 및 개인정보 활용 동의[선]     "),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_5_CLOSE, ""),
		
		/******* 내용 ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_5_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_5_1, "이용하려는\n개인정보의 항목"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600, 260, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +231,  400, 280, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_5_2, "이용 목적"),
		DLG_TEXT ( STARTX +400, STARTY +231,  600, 280, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +511,  400, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_5_3, "개인정보\n이용기간"),
		DLG_TEXT ( STARTX +400, STARTY +511,  600, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_4, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// 자동이체 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AutoTrans[] = 
	{	
		/******* 상단 아이콘 ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* 탭 ********/
		DLG_BUTTON(STARTX  +12, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_CUST_INFO, "고객정보"),
		DLG_BUTTON(STARTX +256, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_PAY_METHOD, "납부방법"),
		DLG_BUTTON(STARTX +500, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_AGREE, "동의서"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "서명"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,      DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_TEXT ( STARTX,      STARTY  +66,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_PAY_METHOD, "납부방법"),
		DLG_COMBO (STARTX +220, STARTY  +66,  780, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_PAY_METHOD, 5), // 납부방법 콤보
		
		DLG_LINE ( STARTX,      STARTY +140, 1000, STARTY +140,      DARKSLATEBLUE, 10, LINE_DATA_2),
		
		DLG_TEXT ( STARTX,      STARTY +145,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_BANK, ""),
		DLG_COMBO (STARTX +220, STARTY +145,  780, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_BANK, 5), // 은행/카드 콤보
		
		DLG_TEXT ( STARTX,      STARTY +215,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_ACCOUNT, ""),
		DLG_EDIT ( STARTX +220, STARTY +215,  780, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ACCOUNT, 20,  ""),
		
		DLG_LINE ( STARTX,      STARTY +289, 1000, STARTY +289,    DARKSLATEBLUE, 10, LINE_DATA_3),
		
		DLG_TEXT ( STARTX,      STARTY +294,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_NM, "예금주명"),
		DLG_BUTTON(STARTX +220, STARTY +294,  780, 70,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AT_DEP_NM,  ""),
		DLG_EDIT ( STARTX +220, STARTY +294,  780, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_NM, 10,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +364,  390, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_BRITHDAY, "예금주 생년월일\n사업자번호"),
		DLG_EDIT ( STARTX +390, STARTY +364,  610, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_BRITHDAY, 20,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +434,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_TEL_1, "예금주\n전화번호"),
		
		DLG_COMBO (STARTX +220, STARTY +434,  290, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_DEP_TEL_DDD, 5), // 핸드폰 콤보
		
		DLG_TEXT ( STARTX +510, STARTY +434,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_DEP_TEL_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +434,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_TEL_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +434,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_DEP_TEL_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +434,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_TEL_NUM, 4,  ""),
		
		DLG_LINE ( STARTX,      STARTY +508, 1000, STARTY +508,      DARKSLATEBLUE, 10, LINE_DATA_4),
		
		DLG_TEXT ( STARTX,      STARTY +513,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_RELAT, "예금주와\n관계"),
		DLG_COMBO (STARTX +220, STARTY +513,  780, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_DEP_RELAT, 5), // 예금주와 관계
		
		DLG_TEXT ( STARTX,      STARTY +583,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_ALT_NM, "대리인명"),
		DLG_BUTTON(STARTX +220, STARTY +583,  780, 70,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AT_ALT_NM,  ""),
		DLG_EDIT ( STARTX +220, STARTY +583,  780, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ALT_NM, 10,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +653,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_ALT_TEL_1, "대리인\n전화번호"),
		
		DLG_COMBO (STARTX +220, STARTY +653,  290, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_ALT_TEL_DDD, 5), // 핸드폰 콤보
		
		DLG_TEXT ( STARTX +510, STARTY +653,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_ALT_TEL_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +653,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ALT_TEL_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +653,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_ALT_TEL_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +653,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ALT_TEL_NUM, 4,  ""),
		
		DLG_LINE ( STARTX,      STARTY +727, 1000, STARTY +727,    DARKSLATEBLUE, 10, LINE_DATA_5),
		
		DLG_BUTTON(STARTX,	    STARTY +732,  500, 83,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AT_INIT, "자동이체\n신청취소/초기화"),
		DLG_BUTTON(STARTX +500, STARTY +732,  500, 83,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AT_BACK, "되돌리기"),
		DLG_BUTTON(STARTX,      STARTY +815, 1000, 84,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AT_SAVE, "확 인"),
		
		// 숫자 자판
		DLG_LINE ( STARTX,      STARTY +903, 1000, STARTY +903,    DARKSLATEBLUE, 10, LINE_DATA_6),
		DLG_TEXT ( 0,           STARTY +908,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_ONE, "1"),
		DLG_TEXT ( 333,  		STARTY +908,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_TWO, "2"),
		DLG_TEXT ( 666,  		STARTY +908,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_THREE, "3"),
		DLG_TEXT ( 0,   		STARTY +998,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_FOUR, "4"),
		DLG_TEXT ( 333, 		STARTY +998,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_FIVE, "5"),
		DLG_TEXT ( 666, 		STARTY +998,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_SIX, "6"),
		DLG_TEXT ( 0,   		STARTY+1088,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_SEVEN, "7"),
		DLG_TEXT ( 333, 		STARTY+1088,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_EIGHT, "8"),
		DLG_TEXT ( 666, 		STARTY+1088,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_NINE, "9"),
		DLG_TEXT ( 333, 		STARTY+1178,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_ZERO, "0"),
		DLG_TEXT ( 666, 		STARTY+1178,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_DEL, "←"),
		
		//숫자 자판_2
		DLG_LINE ( STARTX,      STARTY +536, 1000, STARTY +536,    DARKSLATEBLUE, 10, LINE_DATA_7),
		DLG_TEXT ( 0,   		STARTY +540,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_ONE_2  , "1"),
		DLG_TEXT ( 333, 		STARTY +540,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_TWO_2  , "2"),
		DLG_TEXT ( 666, 		STARTY +540,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_THREE_2, "3"),
		DLG_TEXT ( 0,   		STARTY +630,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_FOUR_2 , "4"),
		DLG_TEXT ( 333, 		STARTY +630,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_FIVE_2 , "5"),
		DLG_TEXT ( 666, 		STARTY +630,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_SIX_2  , "6"),
		DLG_TEXT ( 0,   		STARTY +720,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_SEVEN_2, "7"),
		DLG_TEXT ( 333, 		STARTY +720,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_EIGHT_2, "8"),
		DLG_TEXT ( 666, 		STARTY +720,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_NINE_2 , "9"),
		DLG_TEXT ( 0,   		STARTY +810,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_KEY_EMPTY_2  , ""),
		DLG_TEXT ( 333, 		STARTY +810,  333, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_ZERO_2 , "0"),
		DLG_TEXT ( 666, 		STARTY +810,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_DEL_2  , "←"),	
	};
	
	//---------------------------------------------------------------------------------------
	//	main
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
		char szTmp[256];
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			/********************************/
			/* 고객정보                     */
			/********************************/
			case INIT_CUSTINFO:
				CREATE_DIALOG_OBJECT (DlgRes_CustInfo, SIZEOF(DlgRes_CustInfo));
				
				SetBtnImg();
				SetStyle();	
				SetTitle();	
				SetCombo();
				ReDraw();
				// PRINT("stMudData_ORI.DEPOSITOR_BIRTH_DATE:%d",stMudData_ORI.DEPOSITOR_BIRTH_DATE[0],0,0);
				// PRINT("stMudData_ORI.DEPOSITOR_BIRTH_DATE:%d",stMudData_ORI.DEPOSITOR_BIRTH_DATE[1],0,0);
				// PRINT("stMudData_ORI.DEPOSITOR_BIRTH_DATE:%d",stMudData_ORI.DEPOSITOR_BIRTH_DATE[2],0,0);
				
				// }

				
				break;
			
			/********************************/
			/* 개인정보 활용 첫번째 동의서  */
			/********************************/	
			case INIT_FIRST_AGREE:
				CREATE_DIALOG_OBJECT (DlgRes_First_Agree, SIZEOF(DlgRes_First_Agree));
				
				SetBtnImg();
				SetStyle();
				SetTitle();
				ReDraw();
				break;
				
			/********************************/
			/* 개인정보 활용 동의서         */
			/********************************/	
			case INIT_AGREE:
				CREATE_DIALOG_OBJECT (DlgRes_Agree, SIZEOF(DlgRes_Agree));
				
				SetBtnImg();
				SetStyle();
				SetTitle();
				ReDraw();
				break;
			
			/********************************/
			/* 동의내용_1                   */
			/********************************/
			case INIT_AGREEVIEW_1:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_1, SIZEOF(DlgRes_AgreeView_1));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* 동의내용_2                   */
			/********************************/	
			case INIT_AGREEVIEW_2:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_2, SIZEOF(DlgRes_AgreeView_2));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* 동의내용_3                   */
			/********************************/
			case INIT_AGREEVIEW_3:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_3, SIZEOF(DlgRes_AgreeView_3));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* 동의내용_4                   */
			/********************************/
			case INIT_AGREEVIEW_4:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_4, SIZEOF(DlgRes_AgreeView_4));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* 동의내용_5                   */
			/********************************/
			case INIT_AGREEVIEW_5:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_5, SIZEOF(DlgRes_AgreeView_5));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* 자동이체                     */
			/********************************/
			case INIT_AUTOTRANS:
				CREATE_DIALOG_OBJECT (DlgRes_AutoTrans, SIZEOF(DlgRes_AutoTrans));
				
				SetBtnImg();
				SetStyle();
				SetTitle();
				SetCombo();
				ReDraw();
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
		char szTmp[500];
		
		switch(ID)
		{
			/******************************/
			/* 공통                       */
			/******************************/
			case BID_CLOSE:
				ON_EXIT();
				Card_Move("CM_MOBILE_USE_DOC_MENU");
				break;
				
			/******************************/
			/* 탭                         */
			/******************************/
			// 고객정보
			case BID_TAB_CUST_INFO:
				
				if( m_bFirst == INIT_AUTOTRANS )
				{
					Save_PayMethod_Info_Data();
					
					if( Validation_PayMethod(1) )
					{
						SetTab(0);
					}
				}
				else if( m_bFirst == INIT_FIRST_AGREE )
				{
					if ( Validation_Agree() )
					{
						SetTab(0);
					}
				}
				else if( m_bFirst == INIT_AGREE )
				{
					if ( Validation_Agree() )
					{
						SetTab(0);
					}
				}
				
				break;
				
			// 납부방법
			case BID_TAB_PAY_METHOD:
				
				if( m_bFirst == INIT_CUSTINFO )
				{
					Save_Cust_Info_Data();
				
					if( Validation_Custinfo() )
					{
						SetTab(2);
					}
				}
				else if( m_bFirst == INIT_FIRST_AGREE )
				{
					if ( Validation_Agree() )
					{
						SetTab(2);
					}
				}
				else if( m_bFirst == INIT_AGREE )
				{
					if ( Validation_Agree() )
					{
						SetTab(2);
					}
				}
				
				break;
			
			// 개인정보 활용 동의서
			case BID_TAB_AGREE:
			
				m_lAgreeChk_Ok = 0;
				
				if( m_bFirst == INIT_CUSTINFO )
				{
					Save_Cust_Info_Data();
				
					if( Validation_Custinfo() )
					{
						SetTab(1);
					}
				}
				else if( m_bFirst == INIT_AUTOTRANS )
				{
					Save_PayMethod_Info_Data();
					
					if( Validation_PayMethod(1) )
					{
						SetTab(1);
					}
				}
				
				break;
			
			// 서명
			case BID_TAB_SIGN:
				
			    if( m_bFirst == INIT_CUSTINFO )
				{
					Save_Cust_Info_Data();
				}
				else if( m_bFirst == INIT_AUTOTRANS )
				{
					Save_PayMethod_Info_Data();
				}
				
				if( Validation_Custinfo() && Validation_PayMethod(1) && Validation_Agree() )
				{
			    	SetOzView_Data();
			    }
				
				break;
			
			/******************************/
			/* 고객정보                   */
			/******************************/
			// 주소
			case BID_CI_ADDR:	
				Save_Cust_Info_Data();
				
				if( m_lAddr_Chg == 0 )
				{
					m_lAddr_Chg = 1;
				}
				else
				{
					m_lAddr_Chg = 0;
				}
				
				ReDraw();	
				break;
			
			// 성별_남
			case BID_CI_CHKBOX_GENDER_MAN:
			    
			    Mem_Set( (byte*)stMudData.GENDER, 0x00, sizeof(stMudData.GENDER) );
				Str_Cpy( stMudData.GENDER, "1" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_MAN), CHKBOX_MAN_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_GIRL), CHKBOX_GIRL_N);
				
				break;
				
			// 성별_여
			case BID_CI_CHKBOX_GENDER_GIRL:
				
				Mem_Set( (byte*)stMudData.GENDER, 0x00, sizeof(stMudData.GENDER) );
				Str_Cpy( stMudData.GENDER, "0" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_MAN), CHKBOX_MAN_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_GIRL), CHKBOX_GIRL_Y);
							
			    break;
			   
			// 세금계산서_발행
			case BID_CI_CHKBOX_TXBILL_Y:
				
				Mem_Set( (byte*)stMudData.TAXBILL, 0x00, sizeof(stMudData.TAXBILL) );
				Str_Cpy( stMudData.TAXBILL, "1" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_Y), CHKBOX_TXBILL_PUBL_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_N), CHKBOX_TXBILL_NON_PUBL_N);
				
			    break;
			
			// 세금계산서_해당없음
			case BID_CI_CHKBOX_TXBILL_N:
				
				Mem_Set( (byte*)stMudData.TAXBILL, 0x00, sizeof(stMudData.TAXBILL) );
				Str_Cpy( stMudData.TAXBILL, "0" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_Y), CHKBOX_TXBILL_PUBL_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_N), CHKBOX_TXBILL_NON_PUBL_Y);
				
			    break;
			
			// 고객명
			case BID_CI_CUST_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_CI_CUST_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_CUST_NM)) );
				break;
			
			// 이메일
			case BID_CI_EMAIL:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_CI_EMAIL), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_EMAIL)) );
				break;
			
			// 상호
			case BID_CI_FRIM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_CI_FRIM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_FRIM)) );
				break;
			
			/******************************/
			/* 개인정보 활용 첫번째동의서 */
			/******************************/
			case BID_FAG_AGREE_CHK_OK:
			    m_lAgreeChk_Ok = 1;
			    m_lAgreeChk_Ok_Validation = 1;
			    SetTab( 1 );
			    
				break;
			
			/******************************/
			/* 개인정보 활용 동의서       */
			/******************************/
			// 개인정보 수집 및 이용동의 전문보기
			case BID_AG_AGREE_1_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_1);
				
				break;
			
			// 개인(신용)정보 제공 동의 전문보기
			case BID_AG_AGREE_2_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_2);
				
				break;
			
			// 개인(신용)정보 조회 동의 전문보기	
			case BID_AG_AGREE_3_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_3);
				
				break;
			
			// 고유식별정보 제공 및 제공받는 동의 전문보기
			case BID_AG_AGREE_4_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_4);
				
				break;
			
			// 마케팅 수신 및 개인정보 활용동의 전문보기
			case BID_AG_AGREE_5_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_5);
				
				break;
			
			// 전체동의
			case BID_AG_ALL_AGREE:
			
				Mem_Set( (byte*)stMudData.INFO_USE_AGREE_YN, 0x00, sizeof(stMudData.INFO_USE_AGREE_YN) );
				Str_Cpy( stMudData.INFO_USE_AGREE_YN, "Y" );
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN, 0x00, sizeof(stMudData.INFO_USE_YN) );
				Str_Cpy( stMudData.INFO_USE_YN, "Y" );
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN4, 0x00, sizeof(stMudData.INFO_USE_YN4) );
				Str_Cpy( stMudData.INFO_USE_YN4, "Y" );
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN5, 0x00, sizeof(stMudData.INFO_USE_YN5) );
				Str_Cpy( stMudData.INFO_USE_YN5, "Y" );
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN6, 0x00, sizeof(stMudData.INFO_USE_YN6) );
				Str_Cpy( stMudData.INFO_USE_YN6, "Y" );
				
				m_lAllAgree = 1;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_1);
				
			    break;
			
			// 개인정보 수집 및 이용 동의_동의
			case BID_AG_CHKBOX_AGREE_1_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_AGREE_YN, 0x00, sizeof(stMudData.INFO_USE_AGREE_YN) );
				Str_Cpy( stMudData.INFO_USE_AGREE_YN, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_Y), CHKBOX_AGREE_1_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_N), CHKBOX_NON_AGREE_1_N);
				
				break;
			
			// 개인정보 수집 및 이용 동의_미동의
			case BID_AG_CHKBOX_AGREE_1_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_AGREE_YN, 0x00, sizeof(stMudData.INFO_USE_AGREE_YN) );
				Str_Cpy( stMudData.INFO_USE_AGREE_YN, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_Y), CHKBOX_AGREE_1_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_N), CHKBOX_NON_AGREE_1_Y);
							
			    break;
			
			// 개인(신용)정보 제공 동의_동의
			case BID_AG_CHKBOX_AGREE_2_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN, 0x00, sizeof(stMudData.INFO_USE_YN) );
				Str_Cpy( stMudData.INFO_USE_YN, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_Y), CHKBOX_AGREE_2_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_N), CHKBOX_NON_AGREE_2_N);
				
				break;
			
			// 개인(신용)정보 제공 동의_미동의
			case BID_AG_CHKBOX_AGREE_2_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN, 0x00, sizeof(stMudData.INFO_USE_YN) );
				Str_Cpy( stMudData.INFO_USE_YN, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_Y), CHKBOX_AGREE_2_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_N), CHKBOX_NON_AGREE_2_Y);
							
			    break;
			
			// 개인(신용)정보 조회 동의_동의
			case BID_AG_CHKBOX_AGREE_3_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN4, 0x00, sizeof(stMudData.INFO_USE_YN4) );
				Str_Cpy( stMudData.INFO_USE_YN4, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_Y), CHKBOX_AGREE_3_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_N), CHKBOX_NON_AGREE_3_N);
				
				break;
			
			// 개인(신용)정보 조회 동의_미동의
			case BID_AG_CHKBOX_AGREE_3_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN4, 0x00, sizeof(stMudData.INFO_USE_YN4) );
				Str_Cpy( stMudData.INFO_USE_YN4, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_Y), CHKBOX_AGREE_3_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_N), CHKBOX_NON_AGREE_3_Y);
							
			    break;
			    
			// 고유식별정보 제공 및 제공받는 동의_동의
			case BID_AG_CHKBOX_AGREE_4_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN5, 0x00, sizeof(stMudData.INFO_USE_YN5) );
				Str_Cpy( stMudData.INFO_USE_YN5, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_Y), CHKBOX_AGREE_4_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_N), CHKBOX_NON_AGREE_4_N);
				
				break;
			
			// 고유식별정보 제공 및 제공받는 동의_미동의
			case BID_AG_CHKBOX_AGREE_4_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN5, 0x00, sizeof(stMudData.INFO_USE_YN5) );
				Str_Cpy( stMudData.INFO_USE_YN5, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_Y), CHKBOX_AGREE_4_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_N), CHKBOX_NON_AGREE_4_Y);
							
			    break;
			
			// 마케팅 수신 및 개인정보 활용 동의_동의
			case BID_AG_CHKBOX_AGREE_5_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN6, 0x00, sizeof(stMudData.INFO_USE_YN6) );
				Str_Cpy( stMudData.INFO_USE_YN6, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_Y), CHKBOX_AGREE_5_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_N), CHKBOX_NON_AGREE_5_N);
				
				break;
			
			// 마케팅 수신 및 개인정보 활용 동의_미동의
			case BID_AG_CHKBOX_AGREE_5_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN6, 0x00, sizeof(stMudData.INFO_USE_YN6) );
				Str_Cpy( stMudData.INFO_USE_YN6, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_Y), CHKBOX_AGREE_5_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_N), CHKBOX_NON_AGREE_5_Y);
							
			    break;
			
			/******************************/
			/* 동의내용_1                 */
			/******************************/
			case BID_AV_1_NEXT:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_2);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				
				break;
			
			case BID_AV_1_CLOSE:
				
				ON_EXIT();
				OnInit(INIT_AGREE);
				
				break;
			
			/******************************/
			/* 동의내용_2                 */
			/******************************/
			case BID_AV_2_NEXT:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_3);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				break;
			
			case BID_AV_2_CLOSE:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_1);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				break;
				
			/******************************/
			/* 동의내용_3                 */
			/******************************/
			case BID_AV_3_NEXT:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_4);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				break;
			
			case BID_AV_3_CLOSE:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_2);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				break;
				
			/******************************/
			/* 동의내용_4                 */
			/******************************/
			case BID_AV_4_NEXT:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_5);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				break;
			
			case BID_AV_4_CLOSE:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_3);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				break;
				
			/******************************/
			/* 동의내용_5                 */
			/******************************/
			case BID_AV_5_NEXT:
			
				ON_EXIT();
				OnInit(INIT_AGREE);
				
				break;
			
			case BID_AV_5_CLOSE:
				if( m_lAllAgree == 1 )
				{
					ON_EXIT();
					OnInit(INIT_AGREEVIEW_4);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_AGREE);
				}
				break;
			
			/******************************/
			/* 자동이체                   */
			/******************************/	
			// 자동이체 취소
			case BID_AT_INIT:
				
				if( MessageBoxEx( CONFIRM_YESNO, "자동이체를\n신청취소/초기화 하시겠습니까?" ) == MB_OK)
				{
					Mem_Set((byte*)stMudData.PAYMENT_METHOD, 0x00, sizeof(stMudData.PAYMENT_METHOD) );
					Str_Cpy(stMudData.PAYMENT_METHOD, "10");
					
					ClearAutoTrans();
					
					m_lBackAutoTrans = 1;
					m_lPayMethod_Chk = 0;
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
				}
				
				break;
				
			// 되돌리기
			case BID_AT_BACK:
				if( MessageBoxEx( CONFIRM_YESNO, "기존 자동이체 정보로\n되돌리겠습니까?" ) == MB_OK)
				{
					SetBackAutoTrans();
				}
				
				break;
			
			// 확인
			case BID_AT_SAVE:
				
				if( m_lPayMethod_Chk == 1 )
				{
					if( MessageBoxEx( CONFIRM_YESNO, "확인 취소하시겠습니까?" ) == MB_OK)
					{
						m_lPayMethod_Chk = 0;
					
						ReDraw();
					}
				}
				else
				{ 
					Save_PayMethod_Info_Data();
					
					if( Validation_PayMethod(0) )
					{
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						
						// 은행
						if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
						{
							Str_Cpy( szTmp, "1. 은행종류 : " );
							Str_Cat( szTmp, stMudData.BNK_BRANCH_NM );
							
							Str_Cat( szTmp, "\n2. 계좌번호 : " );
							
							if( m_lBackAutoTrans == 0 )
							{
								Str_Cat( szTmp, stMudData.SECU_DEFRAY_ACCOUNT_NUM );
							}
							else
							{
								Str_Cat( szTmp, stMudData.DEFRAY_ACCOUNT_NUM );
							}
							
							Str_Cat( szTmp, "\n3. 예금주명 : " );
							Str_Cat( szTmp, stMudData.DEPOSITOR_NM );
							
							Str_Cat( szTmp, "\n맞습니까?" );
							
							if( MessageBoxEx( CONFIRM_YESNO, szTmp ) == MB_OK)
							{
								m_lPayMethod_Chk = 1;
								ReDraw();
							}
						}
						// 카드
						else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
						{
							Str_Cpy( szTmp, "1. 카드종류 : " );
							Str_Cat( szTmp, stMudData.BNK_BRANCH_NM );
							
							Str_Cat( szTmp, "\n2. 카드번호 : " );
							
							if( m_lBackAutoTrans == 0 )
							{
								Str_Cat( szTmp, stMudData.SECU_DEFRAY_ACCOUNT_NUM );
							}
							else
							{
								Str_Cat( szTmp, stMudData.DEFRAY_ACCOUNT_NUM );
							}
							
							Str_Cat( szTmp, "\n3. 예금주명 : " );
							Str_Cat( szTmp, stMudData.DEPOSITOR_NM );
							
							Str_Cat( szTmp, "\n맞습니까?" );
							
							if( MessageBoxEx( CONFIRM_YESNO, szTmp ) == MB_OK)
							{
								m_lPayMethod_Chk = 1;
								ReDraw();
							}
						}
						else
						{
							m_lPayMethod_Chk = 1;
							ReDraw();
						}
					}
				}
				
				break;
			
			// 고객명
			case BID_AT_DEP_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_AT_DEP_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_NM)) );
				break;
			
			// 대리인명
			case BID_AT_ALT_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_AT_ALT_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_NM)) );
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
		char szTmp[100];
		long i = 0;
		long len = 0;
		
		m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_HP_DDD + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CI_HP_DDD) ) );
				if( Str_Cmp(szTmp, "없음") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_TEL_DDD + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CI_TEL_DDD) ) );
				if( Str_Cmp(szTmp, "없음") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_TEL_DDD),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_EMAIL + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CI_EMAIL) ) );
				if( Str_Cmp(szTmp, "없음") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_EMAIL),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_BILL_SEND_METHOD + 1) )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "문자(LMS)" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "LMS+송달" ) == 0 
					|| Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "이메일+LMS" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "모바일+LMS" ) == 0)
				{
					len = 0;
					len += Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD)) );
					len += Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_EXN)) );
					len += Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM)) );
					
					if( len >= 11)
					{
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						
						Str_Cpy( szTmp, "[ LMS번호 ]\n");
						Str_Cat( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD)) );
						Str_Cat( szTmp, "-" );
						Str_Cat( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_EXN)) );
						Str_Cat( szTmp, "-" );
						Str_Cat( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM)) );
						
						MessageBoxEx (CONFIRM_OK, szTmp);
					}
					else
					{
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						
						Str_Cpy( szTmp, "LMS신청을 위해서는\n핸드폰번호를 정확히 입력해주세요." );
						MessageBoxEx (CONFIRM_OK, szTmp);
					}
				}
			}
		}
		/********************************/
		/* 자동이체                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_AT_PAY_METHOD + 1) )
			{
				// 콤보박스 코드를 가져오기위한 로직
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
				i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), MUD_PAY_METHOD );
				
				if (i == -1)
				{
					Str_Cpy(szTmp, "");
				}
				else
				{
					Str_Cpy(szTmp, MUD_PAY_METHOD[i].Code);
				}
				
				// 현재 납부방법과 원래 납부방법 코드와 다르면 아래 로직 실행
				if( m_lBackAutoTrans == 1 )
				{
					SetCombo();
					SetCombo_Filter();
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_BANK), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ACCOUNT), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_NM), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_BRITHDAY), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_NM), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM), "" );
					
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_AT_DEP_RELAT + 1) )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_DEP_RELAT)), "본인" ) == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_NM)) );
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD), EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD)) );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN)) );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM)) );	
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD) ) );
				if( Str_Cmp(szTmp, "없음") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD) ) );
				if( Str_Cmp(szTmp, "없음") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD),  "");
				}
			}
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : OnTask
	기  능 : 오즈 뷰 확인 시 System Call
	Param  : 
	Return : 
	========================================================================================*/
	void OnTask(long nEvent, long nData)
	{
		char* szOzData;
		long nRet = 0;
			
		if( nEvent == 1 )
		{
			// MessageBoxEx (CONFIRM_OK, "오즈뷰다!!!!!!!!!!!! CM_MOBILE_USE_DOC");
			szOzData = (char*)System_GetResult((char*)&nRet);
			
			Rcv_OzData(szOzData);
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
		long lActiveIndex = -1;
			
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			if( POINTING_UP == nAction )
			{	
				if( X > DMS_X(STARTX+220) && X < DMS_X(STARTX+565)  && Y > DMS_Y(STARTY+354-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+420-(g_Dlgflag*368)) ||
					X > DMS_X(STARTX+565) && X < DMS_X(STARTX+775)  && Y > DMS_Y(STARTY+420-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+486-(g_Dlgflag*368)) ||
				    X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+420-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+486-(g_Dlgflag*368)) ||
				    X > DMS_X(STARTX+565) && X < DMS_X(STARTX+775)  && Y > DMS_Y(STARTY+486-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+552-(g_Dlgflag*368)) ||
				    X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+486-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+552-(g_Dlgflag*368)) ||
				    X > DMS_X(STARTX+370) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+834-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+899-(g_Dlgflag*368)) )  
				{
					if( Get_iDlgCtrlByID(EDT_CI_BRITH_YMD)    == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_CI_HP_EXN)       == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_CI_HP_NUM)       == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_CI_TEL_EXN)      == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_CI_TEL_NUM)      == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_CI_BIZ_REG_NUM)  == lActiveIndex )
					{
						g_Dlgflag = 0;
						g_MOVE_DLG(368);
					
						ShowSip(FALSE);
						g_Sipflag = 0;
					}	
				}
				else
				{
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+908-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+998-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+908-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+998-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+908-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+998-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+998-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1088-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+998-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1088-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+998-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1088-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1088-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1178-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1088-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1178-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1088-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1178-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1178-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1268-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1178-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1268-(g_Dlgflag*368)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1178-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1268-(g_Dlgflag*368)) )
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
		/********************************/
		/* 자동이체                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			if( POINTING_UP == nAction )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "지로") != 0 && ( g_lMobile_Use_Doc_Type != 2 && m_lBackAutoTrans != 0 ) )
				{
					if( ( X > DMS_X(STARTX+390) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+364-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+434-(g_Dlgflag*368)) ||
						  X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755)  && Y > DMS_Y(STARTY+434-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+504-(g_Dlgflag*368)) ||
					      X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+434-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+504-(g_Dlgflag*368)) ||
					      X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755)  && Y > DMS_Y(STARTY+653-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+723-(g_Dlgflag*368)) ||
					      X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+653-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+723-(g_Dlgflag*368)) ) 
					 && ( Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY) == lActiveIndex ||
					 	  Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN)  == lActiveIndex || 
						  Get_iDlgCtrlByID(EDT_AT_DEP_TEL_NUM)  == lActiveIndex ||
						  Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN)  == lActiveIndex ||
						  Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM)  == lActiveIndex ) )
					{
						g_Dlgflag = 0;
						g_MOVE_DLG(368);
					
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA_7), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL_2), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY_2), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), FALSE );	
					}
					else if( ( X > DMS_X(STARTX+220) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+215) && Y < DMS_Y(STARTY+285) ) 
					        && Get_iDlgCtrlByID(EDT_AT_ACCOUNT)  == lActiveIndex )
					{	
						m_lDlgflag = 0;
						
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA_7), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL_2), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY_2), TRUE );
	
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), TRUE );	
					}
					else
					{
						if( Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN)  == lActiveIndex || 
						    Get_iDlgCtrlByID(EDT_AT_DEP_TEL_NUM)  == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN)  == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM)  == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY) == lActiveIndex )	
						{
							// 키보드 1
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+908-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+998-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+908-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+998-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+908-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+998-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+998-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1088-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+998-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1088-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+998-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1088-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1088-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1178-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1088-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1178-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1088-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1178-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1178-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1268-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
								
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1178-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1268-(g_Dlgflag*368)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1178-(g_Dlgflag*368)) && Y < DMS_Y(STARTY+1268-(g_Dlgflag*368)) )
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
						else if( Get_iDlgCtrlByID(EDT_AT_ACCOUNT)  == lActiveIndex ) 	
						{
							// 키보드 2
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '1' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '2' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '3' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '4' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '5' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )	
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '6' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '7' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '8' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '9' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+900) )
							{
								if( m_lDlgflag == 0 )
								{
									
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+900) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_CHAR( '0' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+900) )
							{
								if( m_lDlgflag == 0 )
								{
									ON_KEY( 5 );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else
							{
								m_lDlgflag = 1;
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA_7), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL_2), FALSE );
								DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY_2), FALSE );
								
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
								
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
						
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), FALSE );
								
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), FALSE );
								
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), FALSE );
								
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), FALSE );
								
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), FALSE );
								
								DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), FALSE );
							}
						}
						else
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							m_lDlgflag = 1;
							
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA_7), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL_2), FALSE );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY_2), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_BACK), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_INIT), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_SAVE), FALSE );
						}
					}
				}
			}
		}

		ON_DRAW();
		return;
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
		/* 고객정보            			*/
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			if( Get_iDlgCtrlByID(EDT_CI_HP_EXN) == lActiveIndex )
			{
				if( Get_iDlgCtrlByID(EDT_CI_HP_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_EXN))) == 4 )
				{
					lActiveIndex = Get_iDlgCtrlByID(EDT_CI_HP_NUM);
					Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
				}
				
			}
			else if( Get_iDlgCtrlByID(EDT_CI_TEL_EXN) == lActiveIndex )
			{
				if( Get_iDlgCtrlByID(EDT_CI_TEL_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_EXN))) == 4 )
				{
					lActiveIndex = Get_iDlgCtrlByID(EDT_CI_TEL_NUM);
					Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_CI_HP_NUM) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM))) == 4 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM)), "0000") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "끝번호가 [0000]입니다.\n맞는지 확인해주세요.");
				}
			}
			else if( Get_iDlgCtrlByID(EDT_CI_TEL_NUM) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_NUM))) == 4 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_NUM)), "0000") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "끝번호가 [0000]입니다.\n맞는지 확인해주세요.");
				}
			}
		}
		/********************************/
		/* 자동이체                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			if( Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN) == lActiveIndex )
			{
				if( Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN))) == 4 )
				{
					lActiveIndex = Get_iDlgCtrlByID(EDT_AT_DEP_TEL_NUM);
					Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
				}
				
			}
			else if( Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN) == lActiveIndex )
			{
				if( Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN))) == 4 )
				{
					lActiveIndex = Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM);
					Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
				}
			}
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
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
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
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			/******************* Style *******************/
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_MTR_ID_NUM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CI_MTR_ID_NUM), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CI_ADDR), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_CI_ADDR), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_CUST_NM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_BRITH_YMD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_HP_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CI_HP_DDD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CI_HP_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CI_HP_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_TEL_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CI_TEL_DDD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CI_TEL_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CI_TEL_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_EMAIL_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CI_EMAIL), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(CMB_CI_EMAIL), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CI_EMAIL_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_FIRM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_TXBILL), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_BIZREGNUM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CI_BILL_SEND_METHOD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
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
		}
		/******************************/
		/* 개인정보 활용 첫번째 동의서*/
		/******************************/
		else if( m_bFirst == INIT_FIRST_AGREE )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FAG_AGREE), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_FAG_AGREE), TRUE, 2, EDITSEP_NONE );	
		}
		/******************************/
		/* 개인정보 활용 동의서       */
		/******************************/
		else if( m_bFirst == INIT_AGREE )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AG_AGREE_TITLE_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AG_AGREE_TITLE_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AG_AGREE_TITLE_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AG_AGREE_TITLE_4), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AG_AGREE_TITLE_5), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		}
		/********************************/
		/* 동의내용_1                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_1 )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_1_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_1_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_1_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_1_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_1_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_1_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_1_2), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_1_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_1_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_1_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_1_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_1_3), TRUE, 2, EDITSEP_NONE );
		}
		/********************************/
		/* 동의내용_2                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_2 )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_2_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_2_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_2_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_2_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_2_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_2_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_2_2), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_2_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_2_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_2_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_2_3), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_2_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_2_4), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_2_4), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_2_4), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_2_4), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_2_5), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_2_5), TRUE, 2, EDITSEP_NONE );
		}
		/********************************/
		/* 동의내용_3                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_3 )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_3_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_3_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_3_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_3_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_3_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_3_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_3_2), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_3_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_3_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_3_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_3_3), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_3_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_3_4), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_3_4), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_3_4), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_3_4), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_3_5), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_3_5), TRUE, 2, EDITSEP_NONE );
		}
		/********************************/
		/* 동의내용_4                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_4 )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_4_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_4_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_1_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_1_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_1_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_1_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_4_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_4_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_2_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_2_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_2_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_2_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_4_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_4_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_4_4), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_4_4), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_4), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_4), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_4_5), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_4_5), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_5), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_5), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_4_6), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_4_6), TRUE, 2, EDITSEP_NONE );
		}
		/********************************/
		/* 동의내용_5                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_5 )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_5_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_5_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_5_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_5_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_5_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_5_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_5_2), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_5_2), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AV_5_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AV_5_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_5_3), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_5_3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AV_5_4), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_AV_5_4), TRUE, 2, EDITSEP_NONE );
		}
		/********************************/
		/* 자동이체                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_PAY_METHOD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_BANK), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_BANK), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_DEP_NM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_DEP_NM), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_DEP_TEL_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_DEP_TEL_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_ACCOUNT), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_ACCOUNT), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_DEP_BRITHDAY), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_DEP_BRITHDAY), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_DEP_RELAT), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_DEP_RELAT), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_ALT_NM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_ALT_NM), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AT_ALT_TEL_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(ST_AT_ALT_TEL_1), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
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
			
			// 숫자판2
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE_2)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO_2)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE_2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR_2) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE_2) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX_2)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN_2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT_2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE_2) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO_2) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL_2)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY_2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA_7)    , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE_2)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO_2)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE_2), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR_2) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE_2) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX_2)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN_2), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT_2), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE_2) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO_2) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL_2)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY_2), FALSE );
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
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			// 핸드폰
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_HP_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_CI_HP_DDD+2), "없음", 0, ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_CI_HP_DDD+2);
			
			// 전화번호
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_TEL_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_CI_TEL_DDD+2), "없음", 0, ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' ORDER BY SORT_ORDER", CMB_CI_TEL_DDD+2);
			
			// 이메일
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_EMAIL+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_CI_EMAIL+2), "없음", 0, ICON_NONE);
			for ( i = 0 ;  MC_EMAIL_ADDR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_EMAIL+2), MC_EMAIL_ADDR[i].Str, 0, ICON_NONE);
			}
			
			// 청구방법
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2 ) );
			for ( i = 0 ;  MUD_BILL_SEND_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD[i].Str, 0, ICON_NONE);
			}
			//테스트를 위한 추가
			// ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[1].Str, 0, ICON_NONE);
			// ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[2].Str, 0, ICON_NONE);
			// ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[3].Str, 0, ICON_NONE);
			// ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[4].Str, 0, ICON_NONE);
			// ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[5].Str, 0, ICON_NONE);
			if(Str_Cmp( stMudData.BILING_METHOD, "14" ) == 0)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[0].Str, 0, ICON_NONE);
			}
			else if(Str_Cmp( stMudData.BILING_METHOD, "17" ) == 0)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[1].Str, 0, ICON_NONE);
			}
			else if(Str_Cmp( stMudData.BILING_METHOD, "18" ) == 0)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[2].Str, 0, ICON_NONE);
			}
			else if(Str_Cmp( stMudData.BILING_METHOD, "47" ) == 0)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[3].Str, 0, ICON_NONE);
			}
			else if(Str_Cmp( stMudData.BILING_METHOD, "48" ) == 0)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[4].Str, 0, ICON_NONE);
			}
			else if(Str_Cmp( stMudData.BILING_METHOD, "78" ) == 0)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD_DOUBLE[5].Str, 0, ICON_NONE);
			}

			
			
		}
		/********************************/
		/* 자동이체                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			// 납부방법
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_PAY_METHOD+2 ) );
			for ( i = 0 ;  MUD_PAY_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_AT_PAY_METHOD+2), MUD_PAY_METHOD[i].Str, 0, ICON_NONE);
			}
			
			// 은행
			if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "은행이체") == 0 )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_BANK+2 ) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' ORDER BY CAST(SORT_ORDER as int ) ASC", CMB_AT_BANK+2);
			}
			// 카드
			else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "카드이체") == 0 )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_BANK+2 ) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' ORDER BY SUBSTR(ITEM_KNAME,6,10)", CMB_AT_BANK+2);
			}
			
			// 예금주 전화번호
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD+2), "없음", 0, ICON_NONE);
			for ( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// 예금주와 관계
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT+2 ) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' ORDER BY SORT_ORDER", CMB_AT_DEP_RELAT+2);
			
			// 대리인 전화번호
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD+2), "없음", 0, ICON_NONE);
			for ( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
		}
	}
	
	/*=======================================================================================
	함수명 : SetCombo_Filter
	기  능 : 콤보박스 Filter
	Param  : 
	Return : 
	========================================================================================*/	
	void SetCombo_Filter(void)
	{
		/********************************/
		/* 자동이체                     */
		/********************************/
		if( m_bFirst == INIT_AUTOTRANS )
		{
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "지로") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "" );
				
				SetViewAutoTrans(0);	
			}
			else
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "은행이체") == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "은행종류" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "계좌번호" );
				}
				else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "카드이체") == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "카드종류" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "카드번호" );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "" );
				}
				
				SetViewAutoTrans(1);
			}
			
			if( g_lMobile_Use_Doc_Type == 2 || m_lBackAutoTrans == 0 || m_lPayMethod_Chk == 1)
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_PAY_METHOD+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_PAY_METHOD+1), TRUE );
					
				SetViewAutoTrans(0);	
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_PAY_METHOD+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_PAY_METHOD+1), FALSE );
			}	
		}
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : ReDraw
	기  능 : 화면 새로고침
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{
		char szTmp[1000];
		char szSql[500];
		long i;
		long j;
		char szMsg[150];


		// Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		// SPRINT(szMsg, "11111 \n[%s] ", stMudData_ORI.BNK_CD, 0, 0);
		// MessageBoxEx(CONFIRM_OK, szMsg);

		// Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		// SPRINT(szMsg, "2222 \n[%s] ", stMudData.BNK_CD, 0, 0);
		// MessageBoxEx(CONFIRM_OK, szMsg);
		
		/********************************/
		/* 고객정보                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			/******************* Enable, Disable *******************/
			// 명의유지
			if( g_lMobile_Use_Doc_Type == 2)
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_CUST_NM), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_CUST_NM), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CI_CUST_NM), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CI_CUST_NM), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_BRITH_YMD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_BRITH_YMD), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_CUST_NM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_CUST_NM), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CI_CUST_NM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CI_CUST_NM), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_BRITH_YMD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_CI_BRITH_YMD), FALSE );
			}
			
			// 기물번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CI_MTR_ID_NUM), stMudData.MTR_ID_NUM );
			
			// 주소
			if( m_lAddr_Chg == 0 ) 
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_ADDR), "지 번\n주 소");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CI_ADDR), stMudData.CURR_ADDR_UNION );
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_ADDR), "도로명\n주 소");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CI_ADDR), stMudData.NEW_ADDR_UNION );
			}

			// 고객명
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_CUST_NM), stMudData.CUST_NM );
			
			// 생년월일
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_BRITH_YMD), stMudData.SOC_NUM );
			
			// 남여( 0:여자, 1:남자 )
			if( Str_Cmp( stMudData.GENDER, "0" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_MAN), CHKBOX_MAN_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_GIRL), CHKBOX_GIRL_Y);
			}
			else if( Str_Cmp( stMudData.GENDER, "1" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_MAN), CHKBOX_MAN_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_GIRL), CHKBOX_GIRL_N);
			}
			
			// 핸드폰번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CI_HP_DDD), stMudData.CP_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_HP_EXN), stMudData.CP_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_HP_NUM), stMudData.CP_NUM );
			
			// 전화번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CI_TEL_DDD), stMudData.OWNHOUSE_TEL_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_TEL_EXN), stMudData.OWNHOUSE_TEL_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_TEL_NUM), stMudData.OWNHOUSE_TEL_NUM );
			
			// 이메일
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_EMAIL), stMudData.EMAIL_REQ_ID );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CI_EMAIL), stMudData.EMAIL_REQ_ADDR );
			
			// 상호
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_FRIM), stMudData.FIRM_NM );
			 
			// 세금계산서( 0:발행, 1:해당없음 )
			if( Str_Cmp( stMudData.TAXBILL, "0" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_Y), CHKBOX_TXBILL_PUBL_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_N), CHKBOX_TXBILL_NON_PUBL_Y);
			}
			else if( Str_Cmp( stMudData.TAXBILL, "1" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_Y), CHKBOX_TXBILL_PUBL_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_N), CHKBOX_TXBILL_NON_PUBL_N);
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_Y), CHKBOX_TXBILL_PUBL_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_N), CHKBOX_TXBILL_NON_PUBL_Y);
			}
			
			// 사업자등록번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_BIZ_REG_NUM), stMudData.BIZ_REGI_NUM );
			
			// 요금청구방법
			i = g_SearchCD( stMudData.BILING_METHOD, MUD_BILL_SEND_METHOD );
			
			if( i == -1 )
			{
				j = g_SearchCD( stMudData.BILING_METHOD, MUD_BILL_SEND_METHOD_DOUBLE );
				if (j == -1)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD), "");	
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD), MUD_BILL_SEND_METHOD_DOUBLE[j].Str);	
				}
				
			}
			else
			{	
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD), MUD_BILL_SEND_METHOD[i].Str);
			}
			
			
			
		}
		/********************************/
		/* 개인정보 활용 첫번째 동의서  */
		/********************************/
		else if( m_bFirst == INIT_FIRST_AGREE )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "  서울도시가스(주)는 도시가스 사용관련 신");
			Str_Cat( szTmp, "\n 규, 전입, 명의변경, 자동이체, 기타( 이메일");
			Str_Cat( szTmp, "\n 요금청구, 세금계산서 발행 ) 신청 시 최소");
			Str_Cat( szTmp, "\n 한의 필수 개인정보를 처리( 수집·이용·");
			Str_Cat( szTmp, "\n 제공 위탁 )하고 있습니다.");
			Str_Cat( szTmp, "\n\n  개인정보 보호법 제15조 제1항 제1호, 제1");
			Str_Cat( szTmp, "\n 7조 제1항 제1호, 제24조 제1항 제1호에 따");
			Str_Cat( szTmp, "\n 라 각각의 동의가 필요합니다.");
			Str_Cat( szTmp, "\n\n  고객님께서는 개인정보 처리사항에 대한");
			Str_Cat( szTmp, "\n 동의를 거부 할 수있습니다.");
			Str_Cat( szTmp, "\n\n  다만 [필수] 사항에 대한 동의가 없는 경우");
			Str_Cat( szTmp, "\n 거래관계의 설정 또는 유지가 불가능하며");
			Str_Cat( szTmp, "\n 도시가스 사용에 대한 서비스가 제한될 수");
			Str_Cat( szTmp, "\n 있습니다.");
			Str_Cat( szTmp, "\n\n  또한 연체자의 경우 연체기간에 따라 개인");
			Str_Cat( szTmp, "\n 정보 보유기간, 이용기간, 조회동의 효력기");
			Str_Cat( szTmp, "\n 간이 연장될 수 있습니다.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FAG_AGREE), szTmp );
			
		}
		/********************************/
		/* 개인정보 활용 동의서         */
		/********************************/
		else if( m_bFirst == INIT_AGREE )
		{
			// 개인정보 수집 및 이용동의
			if( Str_Cmp( stMudData.INFO_USE_AGREE_YN, "N" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_Y), CHKBOX_AGREE_1_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_N), CHKBOX_NON_AGREE_1_Y);
			}
			else if( Str_Cmp( stMudData.INFO_USE_AGREE_YN, "Y" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_Y), CHKBOX_AGREE_1_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_N), CHKBOX_NON_AGREE_1_N);
			}
			
			// 개인(신용)정보 제공 동의
			if( Str_Cmp( stMudData.INFO_USE_YN, "N" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_Y), CHKBOX_AGREE_2_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_N), CHKBOX_NON_AGREE_2_Y);
			}
			else if( Str_Cmp( stMudData.INFO_USE_YN, "Y" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_Y), CHKBOX_AGREE_2_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_N), CHKBOX_NON_AGREE_2_N);
			}
			
			// 개인(신용)정보 조회 동의
			if( Str_Cmp( stMudData.INFO_USE_YN4, "N" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_Y), CHKBOX_AGREE_3_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_N), CHKBOX_NON_AGREE_3_Y);
			}
			else if( Str_Cmp( stMudData.INFO_USE_YN4, "Y" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_Y), CHKBOX_AGREE_3_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_N), CHKBOX_NON_AGREE_3_N);
			}
			
			// 교유식별정보 제공 및 제공받는 동의
			if( Str_Cmp( stMudData.INFO_USE_YN5, "N" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_Y), CHKBOX_AGREE_4_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_N), CHKBOX_NON_AGREE_4_Y);
			}
			else if( Str_Cmp( stMudData.INFO_USE_YN5, "Y" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_Y), CHKBOX_AGREE_4_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_N), CHKBOX_NON_AGREE_4_N);
			}
			
			// 마케팅 수신 및 개인정보 활용 동의
			if( Str_Cmp( stMudData.INFO_USE_YN6, "N" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_Y), CHKBOX_AGREE_5_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_N), CHKBOX_NON_AGREE_5_Y);
			}
			else if( Str_Cmp( stMudData.INFO_USE_YN6, "Y" ) == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_Y), CHKBOX_AGREE_5_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_N), CHKBOX_NON_AGREE_5_N);
			}	
		}
		/********************************/
		/* 동의내용_1                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_1 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 1. 고객정보 :");
			Str_Cat( szTmp, "\n 성명, 생년월일, 성별, 전화번");
			Str_Cat( szTmp, "\n 호, 휴대폰, 주소, 이메일");
			Str_Cat( szTmp, "\n\n 2. 자동이체신청 시:");
			Str_Cat( szTmp, "\n 성명, 생년월일, 은행명, 계좌");
			Str_Cat( szTmp, "\n 번호, 전화번호,카드사,카드번호,유효기간,");
			Str_Cat( szTmp, "\n (자동이체 신청 대리인)성명,");
			Str_Cat( szTmp, "\n 전화번호");
			Str_Cat( szTmp, "\n 3. 관리고객(임대업주 또는 집");
			Str_Cat( szTmp, "\n 주인) :");
			Str_Cat( szTmp, "\n 성명, 전화번호, 휴대폰");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_1_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 도시가스 공급(사용고객 등록");
			Str_Cat( szTmp, "\n , 변경, 해지)관리, 요금고지");
			Str_Cat( szTmp, "\n (모바일,어플,LMS청구) 및 ");
			Str_Cat( szTmp, "\n LMS사전안내, 결제 및 추심관");
			Str_Cat( szTmp, "\n 리, 안전점검 관리 및 SMS사전");
			Str_Cat( szTmp, "\n 안내, 계량기 교체관리, 휴대폰");
			Str_Cat( szTmp, "\n 인증 민원처리 및 결과확인,");
			Str_Cat( szTmp, "\n LMS요금미납안내, 부가서비");
			Str_Cat( szTmp, "\n 스 제공 등");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_1_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "사용계약 만료 후 5년");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_1_3), szTmp );
		}
		/********************************/
		/* 동의내용_2                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_2 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE평가정보(주)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 고객관리번호, 성명, 연락");
			Str_Cat( szTmp, "\n 처 , 생년월일, 성별, 연체");
			Str_Cat( szTmp, "\n 정보");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " 고객관리번호발금, 신용");
			Str_Cat( szTmp, "\n 정보조회, 채무불이행 등");
			Str_Cat( szTmp, "\n 록");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "이용목적 기간 내");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_4), szTmp );
			
			// 5
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "※제3자에 대한 신용정보조회 목적의 개인");
			Str_Cat( szTmp, "\n 정보 제공은 <개인(신용)정보 제공>에 동의");
			Str_Cat( szTmp, "\n 할뿐 아니라 <개인(신용)정보 조회>에도 동");
			Str_Cat( szTmp, "\n 의하는 경우에만 이루어집니다.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_5), szTmp );
		}
		/********************************/
		/* 동의내용_3                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_3 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE평가정보(주)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 개인정보, 신용도판단정");
			Str_Cat( szTmp, "\n 보(연체, 부도, 금융질서");
			Str_Cat( szTmp, "\n 문란), 공공정보, 신용등");
			Str_Cat( szTmp, "\n 급, 경매관련");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " 계약의 체결 및 유지판단");
			Str_Cat( szTmp, "\n 여부, 연체관리, 여신심사");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " 동의시점부터");
			Str_Cat( szTmp, "\n 계약종료 시까지");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_4), szTmp );
			
			// 5
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "※본 조회동의에 따른 조회 기록은 신용등급");
			Str_Cat( szTmp, "\n 에 영향을 주지 않습니다.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_5), szTmp );
		}
		/********************************/
		/* 동의내용_4                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_4 )
		{
			// 1_1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE평가정보(주)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_1_1), szTmp );
			
			// 1_2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 서울도시가스");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_1_2), szTmp );
			
			// 2_1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 서울도시가스");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_2_1), szTmp );
			
			// 2_2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE평가정보(주)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_2_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "연체자의 주민등록번호");
			Str_Cat( szTmp, "\n및 외국인등록번호");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "미납요금의 회수");
			Str_Cat( szTmp, "\n 및 채권추심업무");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_4), szTmp );
			
			// 5
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "이용목적 기간내");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_5), szTmp );
			
			// 6
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "※개인정보처리 위탁자 등 자세한 내용은 서");
			Str_Cat( szTmp, "\n울도시가스 홈페이지(www.seoulgas.co.kr)");
			Str_Cat( szTmp, "\n에 공개된 '개인정보처리방침'을 참조하시기");
			Str_Cat( szTmp, "\n바랍니다.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_6), szTmp );
		}
		/********************************/
		/* 동의내용_5                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_5 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 성명, 휴대폰번호, 주소");
			Str_Cat( szTmp, "\n , 이메일");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 고객 편의서비스 제공, 상");
			Str_Cat( szTmp, "\n 품, 서비스 안내 및 광고");
			Str_Cat( szTmp, "\n , 홍보, 프로모션 제공");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " 동의철회 시까지");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "※미동의 시 서울도시가스의 혜택정보, 프로");
			Str_Cat( szTmp, "\n모션 및 이벤트 정보를 받지 못하실 수 있습");
			Str_Cat( szTmp, "\n니다.");
			Str_Cat( szTmp, "\n ( 요금할인, 캐시백, 포인트 적립, 쿠폰 등 )");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_4), szTmp );
		}
		/********************************/
		/* 자동이체                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{	
			//납부방법
			i = g_SearchCD( stMudData.PAYMENT_METHOD, MUD_PAY_METHOD );
			
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), MUD_PAY_METHOD[i].Str);
			}
			
			// 은행
			if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "은행종류" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "계좌번호" );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );

				if( Str_Cmp (stMudData_ORI.BNK_CD, "021") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "026") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "088");
					//신한은행				
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "005") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "081");
					//하나은행
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "006") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "019") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "004");
					//국민은행
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "010") == 0 ||  Str_Cmp (stMudData_ORI.BNK_CD, "018") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "011");
					//농협은행
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "013") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "014") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "015") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "017") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "012");
					//단위농협
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "046") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "045");
					//새마을금고
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "043") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "003");
					//기업은행
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "047") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "049") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "048");
					//신협
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "072") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "073") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "074") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "075") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "071");
					//우체국
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "084") == 0 )
				{
					// MessageBox(MESSAGE, "111111111111", 0, 0, 0, 0);
					Str_Cpy(stMudData.BNK_CD , "020");
					//우리은행
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "230") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "238");
					//미래에셋대우
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "289") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "247");
					//NH투자증권
				}

				SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' AND CODE_ITEM = '%s' ", stMudData.BNK_CD, 0, 0   );
				g_Sql_RetStr( szSql, 20, szTmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_BANK), szTmp );
				
			}
			// 카드
			else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "카드종류" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "카드번호" );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' AND CODE_ITEM = '%s' ", stMudData.BNK_CD, 0, 0   );
				g_Sql_RetStr( szSql, 20, szTmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_BANK), szTmp );

			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "" );
			}
			
			// 계좌번호, 보안처리
			if( m_lBackAutoTrans == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ACCOUNT), stMudData.SECU_DEFRAY_ACCOUNT_NUM );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ACCOUNT), stMudData.DEFRAY_ACCOUNT_NUM );
			}
			
			// 예금주명
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_NM), stMudData.DEPOSITOR_NM );
			
			// 예금주 전화번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD), stMudData.DEPOSITOR_TEL_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN), stMudData.DEPOSITOR_TEL_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM), stMudData.DEPOSITOR_TEL_NUM );
			
			// 예금주 생년월일 사업자번호
			// 13자리면 주민번호 -> 앞의 6자리만
			// 아닌 경우는 사업자번호 -> 모두 넘기기
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			if( Str_Len(stMudData.DEPOSITOR_BIRTH_DATE) == 13 )
			{
				Mem_Cpy((byte *)szTmp, (byte *)stMudData.DEPOSITOR_BIRTH_DATE, 6);
			}
			else
			{
				Str_Cpy(szTmp, stMudData.DEPOSITOR_BIRTH_DATE);
			}
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_BRITHDAY), szTmp );
			
			// 예금주와 관계	
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' AND CODE_ITEM = '%s' ", stMudData.DEPOSITOR_RELAT_CD, 0, 0   );
			g_Sql_RetStr( szSql, 20, szTmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT), szTmp );
			
			// 대리인명
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_NM), stMudData.REQ_NM );
			
			// 대리인 전화번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD), stMudData.REQ_TEL_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN), stMudData.REQ_TEL_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM), stMudData.REQ_TEL_NUM );
			
			// 확인버튼	
			if( m_lPayMethod_Chk == 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), BTNMENUFRCOLOR);
			}
			else if( m_lPayMethod_Chk == 1 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), RED);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), BTNMENUFRCOLOR);
			}
			
			// 콤보박스 Setting
			SetCombo_Filter();
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : SetTab
	기  능 : 탭 버튼 이벤트
	Param  : flag : 0 = 고객정보, 1 = 개인정보 활용 동의서, 2 = 납부방법
	Return : 
	========================================================================================*/
	void SetTab( long flag )
	{
		// 고객정보
		if( flag == 0 )
		{
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
		}
		// 개인정보 활용 동의서
		else if( flag == 1 )
		{
			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}
		}
		// 납부방법
		else if( flag == 2 )
		{
			ON_EXIT();
			OnInit(INIT_AUTOTRANS);	
		}
	}
	
	/*=======================================================================================
	함수명 : SetOzView_Data
	기  능 : 오즈 뷰 데이터 Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetOzView_Data( void )
	{
		handle hHeader = NULL;
		handle h = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);

		h = JSON_Create( JSON_Object );
		
		if( h )
		{
			hHeader = JSON_Create( JSON_Object );
			
			if(hHeader == NULL)
			{
				goto Finally;
			}
			
			m_hBody = JSON_Create( JSON_Object );
			
			if(m_hBody == NULL)
			{
				goto Finally;
			}
			
			SetMessageBoxText("20 % 처리중...");

			// 1. 문서 별 Body Setting
			SetOzView_JsonBody(sql);
			
			// 2. 자동이체 인증 데이터(고객번호, 은행,카드 코드) Setting
			SetOzView_JsonArray_Bank(sql);
			
			SetMessageBoxText("90 % 처리중...");
			
			// 3. 납부방법 데이터 Setting
			SetOzView_JsonArray_Payment();
			
			SetMessageBoxText("100 % 완료.");
			
			JSON_SetValue( m_hBody, 'C', "cust_num",     stMudData.CUST_NUM );
			JSON_SetValue( m_hBody, 'C', "url",          GET_URL(WAS_BASE_URL) );
			JSON_SetValue( m_hBody, 'C', "clientid",     stUserinfo.szpda_ip );
			JSON_SetValue( m_hBody, 'C', "userid",       stUserinfo.szemployee_id );
			JSON_SetValue( m_hBody, 'C', "workcd",       stUserinfo.szworkcd );
			JSON_SetValue( m_hBody, 'C', "vmversion",    stUserinfo.szver_num );
			JSON_SetValue( m_hBody, 'C', "appversion",   stUserinfo.szappversion );

			// 헤더 입력
			/************************* 폼 코드 : 00001_1 **********************/
			JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00001_1");
			/******************************************************************/
			// JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00001_1_220223");
			
			JSON_SetValue	(hHeader	, 'C', "Ozserver"			, GET_URL(OZ_BASE_URL));
			JSON_Attach 	(hHeader		 , "Paramdata"			, m_hBody);
			
			//시스템콜 요청 { "method" : "시스템콜 매쏘드명", "data" : "json object 스트링" }
			JSON_SetValue	(h, 'C', "method", "OzViewActivity");
			JSON_Attach 	(h, "data", hHeader);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		DelSqLite(sql);
		
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hHeader)
		{
			JSON_Finalize(hHeader);
		}
			
		if (m_hBody)
		{
			JSON_Finalize(m_hBody);
		}	

		g_Close_SubDlg();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : SetOzView_JsonBody
	기  능 : 오즈 뷰 데이터 메인 Body Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetOzView_JsonBody( SQLITE sql )
	{
		long i = 0;
		long j = 0;
		long lAllAmt = 0;
		char szUseHpNum[20];
		char szUseTelNum[20];
		char szTemlNum[20];
		char szNumber[5];
		char szpmCost[50];
		char szTmp[256];
		char szComboData[700];
		
		// 모바일 사용계약서 Type [ 1(전입민원), 2(명의유지), 3(명의변경), 4(신규) ]
		if( g_lMobile_Use_Doc_Type == 1 )
		{
			JSON_SetValue( m_hBody, 'C', "pmWritetype", "1" );
		}
		else if( g_lMobile_Use_Doc_Type == 2 )
		{
			JSON_SetValue( m_hBody, 'C', "pmWritetype", "2" );
		} 
		else if( g_lMobile_Use_Doc_Type == 3 )
		{
			JSON_SetValue( m_hBody, 'C', "pmWritetype", "3" );
		}
		else if( g_lMobile_Use_Doc_Type == 4 )
		{
			JSON_SetValue( m_hBody, 'C', "pmWritetype", "4" );
		} 
		
		// 설치장소번호
		JSON_SetValue( m_hBody, 'C', "pmUsecontnum", stMudData.INST_PLACE_NUM ); 
		
		// 사용계약번호
		if( g_lMobile_Use_Doc_Type == 4 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmCustnum", "");
		}
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmCustnum", stMudData.USE_CONT_NUM );
		}
		
		// 성명
		JSON_SetValue( m_hBody, 'C', "pmName", stMudData.CUST_NM );
		
		// 생년월일
		JSON_SetValue( m_hBody, 'C', "pmBirthdate", stMudData.SOC_NUM );
		
		
		// 성별
		JSON_SetValue( m_hBody, 'C', "pmSex", stMudData.GENDER );
		
		// Safe 키
		if( Str_Len(stMudData.SAFE_KEY) > 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmSafekey", "Y" );
		}
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmSafekey", "" );
		}
		
		// 상호
		JSON_SetValue( m_hBody, 'C', "pmCorpname", stMudData.FIRM_NM );
		
		// 발행
		JSON_SetValue( m_hBody, 'C', "pmVat", stMudData.TAXBILL );
		
		// 사업자번호
		JSON_SetValue( m_hBody, 'C', "pmVatno", stMudData.BIZ_REGI_NUM );
		
		// 주소
		if( Str_Len(stMudData.NEW_ADDR_UNION) > 10 )
		{
			JSON_SetValue( m_hBody, 'C', "pmAddr", stMudData.NEW_ADDR_UNION );
		}
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmAddr", stMudData.CURR_ADDR_UNION );
		}
		
		SetMessageBoxText("30 % 처리중...");
		
		// 전화번호 콤보박스 값
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp, " CODE_ID = 'A10110' ORDER BY SORT_ORDER ", 0, 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmTelcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		// 전화번호
		JSON_SetValue( m_hBody, 'C', "pmTel1", stMudData.OWNHOUSE_TEL_DDD );
		JSON_SetValue( m_hBody, 'C', "pmTel2", stMudData.OWNHOUSE_TEL_EXN );
		JSON_SetValue( m_hBody, 'C', "pmTel3", stMudData.OWNHOUSE_TEL_NUM );
		
		// 휴대폰 콤보박스 값
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp, " CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER ", 0 , 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmPhonecombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		// 휴대폰 번호
		JSON_SetValue( m_hBody, 'C', "pmPhone1", stMudData.CP_DDD );
		JSON_SetValue( m_hBody, 'C', "pmPhone2", stMudData.CP_EXN );
		JSON_SetValue( m_hBody, 'C', "pmPhone3", stMudData.CP_NUM );
		
		// 이메일 주소
		// @를 빼고 넘겨야 함
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'A10140' ", 0, 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmEmailcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		JSON_SetValue( m_hBody, 'C', "pmEmail1", stMudData.EMAIL_REQ_ID );
		JSON_SetValue( m_hBody, 'C', "pmEmail2", stMudData.EMAIL_REQ_ADDR );
			
		SetMessageBoxText("40 % 처리중...");
		
		/************** BILL_SEND_METHOD *****************************/
		// 청구방법 : 10 = 고지서, 40 = 이메일, 70 = LMS, 80 = 모바일
		/*************************************************************/
		// 고지서
		if ( Str_Cmp( stMudData.BILING_METHOD, "10" ) == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "고지서" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );
		}
		// EMAIL
		else if( Str_Cmp(stMudData.BILING_METHOD, "40") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "E-mail" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );
			
		}
		// LMS
		else if( Str_Cmp(stMudData.BILING_METHOD, "70") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "LMS" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", stMudData.LMS_TEL_DDD );
			JSON_SetValue( m_hBody, 'C', "pmLms2", stMudData.LMS_TEL_EXN );
			JSON_SetValue( m_hBody, 'C', "pmLms3", stMudData.LMS_TEL_NUM );
		}
		// MOBILE
		else if( Str_Cmp(stMudData.BILING_METHOD, "80") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "모바일" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );
		}
		else if( Str_Cmp(stMudData.BILING_METHOD, "14") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "EG" );

			// JSON_SetValue( m_hBody, 'C', "pmBilling", "LMS" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );

		}
		else if( Str_Cmp(stMudData.BILING_METHOD, "17") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "LG" );

			// JSON_SetValue( m_hBody, 'C', "pmBilling", "LMS" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", stMudData.LMS_TEL_DDD );
			JSON_SetValue( m_hBody, 'C', "pmLms2", stMudData.LMS_TEL_EXN );
			JSON_SetValue( m_hBody, 'C', "pmLms3", stMudData.LMS_TEL_NUM );

		}
		else if( Str_Cmp(stMudData.BILING_METHOD, "18") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "MG" );

			// JSON_SetValue( m_hBody, 'C', "pmBilling", "LMS" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );

		}
		else if( Str_Cmp(stMudData.BILING_METHOD, "47") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "EL" );

			// JSON_SetValue( m_hBody, 'C', "pmBilling", "LMS" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", stMudData.LMS_TEL_DDD );
			JSON_SetValue( m_hBody, 'C', "pmLms2", stMudData.LMS_TEL_EXN );
			JSON_SetValue( m_hBody, 'C', "pmLms3", stMudData.LMS_TEL_NUM );

		}
		else if( Str_Cmp(stMudData.BILING_METHOD, "48") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "ME" );

			// JSON_SetValue( m_hBody, 'C', "pmBilling", "LMS" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );

		}
		else if( Str_Cmp(stMudData.BILING_METHOD, "78") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "ML" );

			// JSON_SetValue( m_hBody, 'C', "pmBilling", "LMS" );

			JSON_SetValue( m_hBody, 'C', "pmLms1", stMudData.LMS_TEL_DDD );
			JSON_SetValue( m_hBody, 'C', "pmLms2", stMudData.LMS_TEL_EXN );
			JSON_SetValue( m_hBody, 'C', "pmLms3", stMudData.LMS_TEL_NUM );

		}
		// 기타
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "" );
			
			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );
		}
		
		/*********************** PAYMETHOD ******************************/
		// 납부방법 : 10 = 은행자동이체, 20 = 카드자동이체, NULL = 지로
		// pmBankapply -> 자동이체 신청, 미신청 대상자 구분 (Y,N)
		/****************************************************************/
		// 카드
		if( Str_Cmp(stMudData.PAYMENT_METHOD, "20") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBankapply", "Y" );
			JSON_SetValue( m_hBody, 'C', "pmBanktitle", "은행" );	
		}
		// 은행
		else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBankapply", "Y" );
			JSON_SetValue( m_hBody, 'C', "pmBanktitle", "카드" );
		}
		// 기타
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmBankapply", "N" );
			JSON_SetValue( m_hBody, 'C', "pmBanktitle", "" );
		}
		
		SetMessageBoxText("50 % 처리중...");
		
		// 은행 콤보
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'C61999' ",0,0,0 );
		JSON_SetValue( m_hBody, 'C', "pmBankcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );

		SetMessageBoxText("60 % 처리중...");
		
		// 카드 콤보
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'C61998' ",0,0,0 );
		JSON_SetValue( m_hBody, 'C', "pmCardcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		SetMessageBoxText("70 % 처리중...");
		
		// 은행명
		JSON_SetValue( m_hBody	, 'C', "pmBank", stMudData.BNK_BRANCH_NM );
		
		// 계좌번호
		JSON_SetValue( m_hBody	, 'C', "pmAcc", stMudData.DEFRAY_ACCOUNT_NUM );
		
		// 예금주명
		JSON_SetValue( m_hBody	, 'C', "pmAccname", stMudData.DEPOSITOR_NM );
		
		// 예금주 생년월일, 사업자번호
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		
		if( Str_Len( stMudData.DEPOSITOR_BIRTH_DATE ) == 13 )
		{
			Mem_Cpy( (byte *)szTmp, (byte *)stMudData.DEPOSITOR_BIRTH_DATE, 6 );
		}
		else
		{
			Str_Cpy( szTmp, stMudData.DEPOSITOR_BIRTH_DATE );
		}
		
		JSON_SetValue( m_hBody, 'C', "pmAccbirthdate", szTmp );
		
		// 예금주 전화번호
		JSON_SetValue( m_hBody, 'C', "pmAccphone1", stMudData.DEPOSITOR_TEL_DDD );
		JSON_SetValue( m_hBody, 'C', "pmAccphone2", stMudData.DEPOSITOR_TEL_EXN );
		JSON_SetValue( m_hBody, 'C', "pmAccphone3", stMudData.DEPOSITOR_TEL_NUM );

		// 납부자와 관계 콤보박스 값
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'C10004' ", 0 ,0 ,0 );
		JSON_SetValue( m_hBody, 'C', "pmAccrelationcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT(szTmp," CODE_ID = 'C10004' AND CODE_ITEM = '%s' ", stMudData.DEPOSITOR_RELAT_CD, 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmAccrelation", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		SetMessageBoxText("80 % 처리중...");
		
		// 대리인명
		JSON_SetValue( m_hBody, 'C', "pmAgentname", stMudData.REQ_NM );
		
		// 대리인 전화번호
		JSON_SetValue( m_hBody, 'C', "pmAgentphone1", stMudData.REQ_TEL_DDD );
		JSON_SetValue( m_hBody, 'C', "pmAgentphone2", stMudData.REQ_TEL_EXN );
		JSON_SetValue( m_hBody, 'C', "pmAgentphone3", stMudData.REQ_TEL_NUM );
		
		// 동의여부 1
		JSON_SetValue( m_hBody, 'C', "pmAgree1", stMudData.INFO_USE_AGREE_YN );
		
		// 동의여부 2
		JSON_SetValue( m_hBody, 'C', "pmAgree2", stMudData.INFO_USE_YN );
		
		// 동의여부 3
		JSON_SetValue( m_hBody, 'C', "pmAgree3", stMudData.INFO_USE_YN4 );
		
		// 동의여부 4
		JSON_SetValue( m_hBody, 'C', "pmAgree4", stMudData.INFO_USE_YN5 );
		
		// 동의여부 5
		JSON_SetValue( m_hBody, 'C', "pmAgree5", stMudData.INFO_USE_YN6 );
		
		// 센터
		JSON_SetValue( m_hBody, 'C', "pmCenter", stUserinfo.sznm_kor );
		
		// 전입 중 사전접수 OR 전입연계 중 자동이체 데이터가 있으면 N
		if( Str_Cmp(g_szAccnameSignYn, "N") == 0 )
		{
			// 사전접수, 전입연계 자동이체 데이터를 수정하지 않았으면 N, 수정했으면 Y
			if( m_lBackAutoTrans == 0 )
			{
				JSON_SetValue( m_hBody, 'C', "pmAccnameSignYN", "N" );
			}
			else
			{
				JSON_SetValue( m_hBody, 'C', "pmAccnameSignYN", "Y" );
			}
		}
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmAccnameSignYN", "Y" );
		}
			
		return;
	}
	
	/*=======================================================================================
	함수명 : SetOzView_JsonArray_Bank
	기  능 : 오즈 뷰 데이터 은행카드 JsonArray Data Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetOzView_JsonArray_Bank( SQLITE sql )
	{
		long i = 0;
		long lCnt = 0;
		char szSql[256];
		char szTmp[128];
		char szRet_Cd[10];
		char szRet_Nm[128];
		handle hArray = NULL;
		bool sret = FALSE;
		handle hstmt = NULL;
		
		hArray = JSON_Create( JSON_Array );
		if( hArray == NULL  )
		{
			goto Finally;
		}
		
		/******************* 카드 콤보 - 5개 **********************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT( szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' ORDER BY SORT_ORDER ", 0, 0, 0 );
		SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' ORDER BY SUBSTR(ITEM_KNAME,6,10)", 0,  0, 0 );
		
		hstmt = sql->CreateStatement( sql, szSql );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		sret = sql->Execute(sql);
			
		if(sret == FALSE)
		{
			PRINT("::sql->Execute [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		while( sql->Next(sql) == TRUE )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			Mem_Set((byte*)szRet_Cd, 0x00, sizeof(szRet_Cd));	
			Mem_Set((byte*)szRet_Nm, 0x00, sizeof(szRet_Nm));	
			
			sql->GetValue( sql, 0, 'U', (long*)szTmp, sizeof(szTmp), DECRYPT );
			
			Mem_Cpy((byte *)szRet_Cd, (byte *)szTmp, 3);
			Mem_Cpy((byte *)szRet_Nm, (byte *)szTmp+5, Str_Len(szTmp)-5);

			JSON_AddArrayItem( hArray );
			JSON_SetArrayItem( hArray, 'C', "bnk_cd", szRet_Cd );
			JSON_SetArrayItem( hArray, 'C', "bnk_nm", szRet_Nm );
		}
		
		sql->DeleteStatement(sql);
		
		/****************** 은행 콤보 - 44개 **********************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' ORDER BY CAST(SORT_ORDER as int ) ASC ", 0, 0, 0 );
		
		hstmt = sql->CreateStatement( sql, szSql );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		sret = sql->Execute(sql);	
		if(sret == FALSE)
		{
			PRINT("::sql->Execute [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		while( sql->Next(sql) == TRUE )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			Mem_Set((byte*)szRet_Cd, 0x00, sizeof(szRet_Cd));	
			Mem_Set((byte*)szRet_Nm, 0x00, sizeof(szRet_Nm));	
			
			sql->GetValue( sql, 0, 'U', (long*)szTmp, sizeof(szTmp), DECRYPT );
			
			Mem_Cpy((byte *)szRet_Cd, (byte *)szTmp, 3);
			Mem_Cpy((byte *)szRet_Nm, (byte *)szTmp+5, Str_Len(szTmp)-5);

			JSON_AddArrayItem( hArray );
			JSON_SetArrayItem( hArray, 'C', "bnk_cd", szRet_Cd );
			JSON_SetArrayItem( hArray, 'C', "bnk_nm", szRet_Nm );
		}

		JSON_Attach(m_hBody, "bnk_cd", hArray);

Finally:
	
		sql->DeleteStatement(sql);

		if (hArray)
		{
			JSON_Finalize(hArray);
		}	
		
		return;
	}

	/*=======================================================================================
	함수명 : SetOzView_JsonArray_Payment
	기  능 : 오즈 뷰 데이터 납부방법 JsonArray Data Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetOzView_JsonArray_Payment( void )
	{
		long i = 0;
		long lCnt = 0;
		char szSql[256];
		char szTmp[128];
		char szRet_Cd[10];
		char szRet_Nm[128];
		handle hArray = NULL;
		
		hArray = JSON_Create(JSON_Array);
		
		if( hArray == NULL  )
		{
			goto Finally;
		}
		
		JSON_AddArrayItem( hArray );
		JSON_SetArrayItem( hArray, 'C', "payment_cd", "10" );
		JSON_SetArrayItem( hArray, 'C', "payment_nm", "은행자동이체" );

		JSON_AddArrayItem( hArray );
		JSON_SetArrayItem( hArray, 'C', "payment_cd", "20" );
		JSON_SetArrayItem( hArray, 'C', "payment_nm", "카드자동이체" );

		JSON_AddArrayItem( hArray );
		JSON_SetArrayItem( hArray, 'C', "payment_cd", "" );
		JSON_SetArrayItem( hArray, 'C', "payment_nm", "지로"  );

		JSON_Attach( m_hBody, "payment_method", hArray );

Finally:

		if( hArray )
		{
			JSON_Finalize( hArray );
		}	
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Rcv_OzData
	기  능 : 오즈 뷰 데이터 받아옴
	Param  : 
	Return : 
			CHG_CUST_TYPE(명의변경여부) = ?
			TRANS_FLAG( 타입 ) : 전입신규 = 1, 명의유지 = 2, 명의변경 = 3, 신규 = 4
			DATA_COL_TYPE( 유입 ) : 전입 = 10, 안전 = 20, 검침 = 30, 교체 = 40, 기타 = 50
			
			OZ_TRAN_REQ_FLAG( 자동이체 신청 타입 ) : 신청 = new, 해제 = cancel
			TRAN_FLAG( 자동이체 구분 ) : 은행 = 10, 카드 = 20
			
			PAYMENT_METHOD( 납부 방법 ) : 은행 = 10, 카드 = 20
			PAY_METHOD_TYPE( 신청해지 ) : 신청 = 10, 해지 = 20
			
			BILING_METHOD( 청구방법 ) : LMS = 30, EMAIL = 40, 모바일 = 50
		 	BILL_METHOD_TYPE( 신청 해지 ) : 신청 = 10, 해지 = 20
		 	
			OZ_LMS_REQ_FLAG( lms 청구방법 신청 타입 ) : 신청 = new, 해제 = modify, 취소 = cancel
			OZ_EMAIL_REQ_FLAG ( email 청구방법 신청 타입 ) : 신청 = new, 해제 = modify, 취소 = cancel
	========================================================================================*/
	void Rcv_OzData(char* szOzData)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		char szFolderNm[128];
		char szFileNm[256];
		char szCopyNm[256];
		char szCopyPath[256];
		char szBanknm[50];
		char szBankcd[10];
		char szType[2] = {0,0};
		
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lAddrLen = 0;
		long lRet = 0;
		long lCnt = 0;
		long *nCol;
		long nCnt = 0;
		long ret = 0;
		long lTmp = 0;
		
		handle hItem = NULL;
		handle hPath = NULL;
		handle hData = NULL;
		handle hAddrMode = NULL;
		handle hAddrSeq = NULL;
		
		char *szitem;
		char *szPath;
		char *szData;
		char *szAddrMode;
		char *szAddrSeq;
		char szMsg[150];
		
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szOzData ) ;

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy( szTmp, JSON_GetValue( hItem, "ret_action", szType ) );
			
			/***************************************/
			/* OZ에서 저장 누른 경우 진행          */
			/***************************************/
			if( Str_Cmp(szTmp, "btnSave") == 0 )
			{
				szData = JSON_GetValue( hItem, "ret_data", szType );
				hData = JSON_Create( JSON_Object );
				
				/***************************************/
				/* OZ 결과 데이터가 있는 경우          */
				/***************************************/
				if( hData != NULL )
				{
					JSON_toJson( hData, szData ) ;
					
					Mem_Set((byte*)&stOzData, 0x00, sizeof(stOzData));
					
					/*************************************/
					/* 유입경로(DATA_COL_TYPE)           */
					/*************************************/
					// 전입 신규
					if( g_lMobile_Inflow_Path == 0 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "10");
					} 
					// 민원 정보_신규
					else if( g_lMobile_Inflow_Path == 1 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "10");
					}
					// 안전점검
					else if( g_lMobile_Inflow_Path == 2 )
					{	
						Str_Cpy(stOzData.DATA_COL_TYPE, "20");
					}	
					// 검침
					else if( g_lMobile_Inflow_Path == 3 )
					{	
						Str_Cpy(stOzData.DATA_COL_TYPE, "30");
					}
					// 계량기교체
					else if( g_lMobile_Inflow_Path == 4 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "40");
					}
					// 민원 정보_유지
					else if( g_lMobile_Inflow_Path == 5 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "50");
					}
					// 기타민원
					else
					{	
						Str_Cpy(stOzData.DATA_COL_TYPE, "50");
					}
					
					/*************************************/
					/* 명의변경여부(CHG_CUST_TYPE)       */
					/*************************************/
					// CHG_CUST_TYPE : 명의변경여부
					// TRANS_FLAG( 타입 ) : 전입신규 = 1, 명의유지 = 2, 명의변경 = 3, 신규 = 4
					// 전입신규
					if( g_lMobile_Use_Doc_Type == 1 )
					{
						if( stMudData.CUST_NUM[0] == '0' )
						{
						    Str_Cpy(stOzData.CHG_CUST_TYPE, "20");
						    Str_Cpy(stOzData.TRANS_FLAG, "3");	
						}
						else
						{
						    Str_Cpy(stOzData.CHG_CUST_TYPE, "30");
						    Str_Cpy(stOzData.TRANS_FLAG , "1");
						}
					}
					// 명의유지
					else if( g_lMobile_Use_Doc_Type == 2 )
					{
						Str_Cpy(stOzData.CHG_CUST_TYPE, "10");
						Str_Cpy(stOzData.TRANS_FLAG, "2");
					}
					// 명의변경
					else if( g_lMobile_Use_Doc_Type == 3 )
					{
						Str_Cpy(stOzData.CHG_CUST_TYPE, "20");
						Str_Cpy(stOzData.TRANS_FLAG, "3");
					}
					// 신규
					else if( g_lMobile_Use_Doc_Type == 4 )
					{
						Str_Cpy(stOzData.CHG_CUST_TYPE, "30");
						Str_Cpy(stOzData.TRANS_FLAG, "1");
					}
					// 기타
					else
					{	
						Str_Cpy(stOzData.CHG_CUST_TYPE, "");
						Str_Cpy(stOzData.TRANS_FLAG, "1");
					}
					
					/*************************************/
					/* 고객정보                          */
					/*************************************/
					// 사용계약번호
					Str_Cpy( stOzData.USE_CONT_NUM, stMudData.USE_CONT_NUM);
					
					// 지사코드
					Str_Cpy( stOzData.BRANCH_CD, stUserinfo.szbranch_cd);
					
					// 센터코드
					Str_Cpy( stOzData.CENTER_CD, stUserinfo.szcenter_cd);
					
					// 설치장소번호				
					Str_Cpy( stOzData.INST_PLACE_NUM, JSON_GetValue( hData, "pmUsecontnum", szType ) );
					
					// 고객번호
					Str_Cpy( stOzData.CUST_NUM, stMudData.CUST_NUM);
					
					// 고객명
					Str_Cpy( stOzData.CUST_NM, JSON_GetValue( hData, "pmName", szType) );
					
					// SOC_NUM
					// 입력데이터 형식 확인(yyyymmdd OR yyyy년mm월dd일) -> 현재는 후자로 내려옴
					Str_Cpy(stOzData.SOC_NUM                     , JSON_GetValue (hData, "pmBirthdate",    szType) );
					Str_Cat(stOzData.SOC_NUM, "0000000");
					Str_Chg(stOzData.SOC_NUM, STRCHG_DEL_NONDIGIT);
					
					// 성별
					Str_Cpy(stOzData.GENDER                      , JSON_GetValue (hData, "pmSex",    szType) );
					
					// 변경날짜
					Str_Cpy(stOzData.TRAN_REQ_YMD                , JSON_GetValue (hData, "pmCurrentdate",    szType) );
					Str_Chg(stOzData.TRAN_REQ_YMD, STRCHG_DEL_NONDIGIT);

					// 전화번호
					Str_Cpy(stOzData.OWNHOUSE_TEL_DDD            , JSON_GetValue (hData, "pmTel1",    szType) );
					Str_Cpy(stOzData.OWNHOUSE_TEL_EXN            , JSON_GetValue (hData, "pmTel2",    szType) );
					Str_Cpy(stOzData.OWNHOUSE_TEL_NUM            , JSON_GetValue (hData, "pmTel3",    szType) );
					
					// 핸드폰번호
					Str_Cpy(stOzData.CP_DDD                      , JSON_GetValue (hData, "pmPhone1",    szType) );
					Str_Cpy(stOzData.CP_EXN                      , JSON_GetValue (hData, "pmPhone2",    szType) );
					Str_Cpy(stOzData.CP_NUM                      , JSON_GetValue (hData, "pmPhone3",    szType) );
					
					// 주소
					Str_Cpy(stOzData.ADDR_UNION                  , JSON_GetValue (hData, "pmAddr",    szType) );
					
					// 동의
					Str_Cpy(stOzData.INFO_USE_AGREE_YN           , JSON_GetValue (hData, "pmAgreetitle1",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN4                , JSON_GetValue (hData, "pmAgreetitle2",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN                 , JSON_GetValue (hData, "pmAgreetitle3",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN5                , JSON_GetValue (hData, "pmAgreetitle4",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN6                , JSON_GetValue (hData, "pmAgreetitle5",    szType) );
					
					/*************************************/
					/* 납부방법                          */
					/*************************************/
					// 자동이체 FLAG 확인 ( 0 = 같음, 1 = NEW, 2 = CANCEL )
					lTmp = ChkOzTransReqFlag();

					
					if( lTmp == 1 )
					{
						Str_Cpy( stOzData.OZ_TRAN_REQ_FLAG, "new" );
					}
					else if( lTmp == 2 )
					{
						Str_Cpy( stOzData.OZ_TRAN_REQ_FLAG, "cancel" );
					}
					else
					{
						Str_Cpy( stOzData.OZ_TRAN_REQ_FLAG, "" );
					}
					
					// 자동이체정보 수정이 일어난 경우( NEW, CANCEL )
					if( Str_Cmp( stOzData.OZ_TRAN_REQ_FLAG, "new" ) == 0 || Str_Cmp( stOzData.OZ_TRAN_REQ_FLAG, "cancel" ) == 0 )
					{
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(szTmp     , JSON_GetValue (hData, "pmPayment",    szType));
						
						/*************************************/
						/* 은행                              */
						/*************************************/
						if( Str_Cmp(szTmp, "은행자동이체") == 0 )
						{
							Str_Cpy( stOzData.TRAN_FLAG, "10" );
							Str_Cpy( stOzData.PAYMENT_METHOD, "10" );
							Str_Cpy( stOzData.PAY_METHOD_TYPE, "10" );
							
							lCnt = 0;
							
							g_Sql_RetInt( "SELECT COUNT(*) FROM COMMONCODE WHERE CODE_ID = 'C61999'", &lCnt );
							
							Mem_Set( (byte*)szBanknm, 0x00, sizeof(szBanknm) );	
							Str_Cpy( szBanknm, JSON_GetValue( hData, "pmBankText", szType ) );
							
							for( i = 0 ; i < lCnt ; i++ )
							{
								Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
								Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );	
								Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
								
								SPRINT( szTmp, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' LIMIT %d, 1" , i, 0, 0 );
								g_Sql_RetStr( szTmp, 10, szBuf );
								
								Mem_Cpy( (byte *)szRet, (byte *)szBuf+5, Str_Len(szBuf)-5 );
								
								if( Str_Cmp(szBanknm, szRet) == 0 )
								{
									Mem_Set( (byte*)szBankcd, 0x00, sizeof(szBankcd) );	
									Mem_Cpy( (byte *)szBankcd, (byte *)szBuf, 3 );
									
									Str_Cpy( stOzData.BNK_CD, szBankcd );
									Str_Cpy( stOzData.BNK_BRANCH_NM, szBanknm );
									
									break;
								}
							}
							
							Str_Cpy(stOzData.DEPOSITOR_NM        , JSON_GetValue (hData, "pmAccname",    szType));
							Str_Cpy(stOzData.DEPOSITOR_TEL_DDD   , JSON_GetValue (hData, "pmAccphone1",    szType));
							Str_Cpy(stOzData.DEPOSITOR_TEL_EXN   , JSON_GetValue (hData, "pmAccphone2",    szType));
							Str_Cpy(stOzData.DEPOSITOR_TEL_NUM   , JSON_GetValue (hData, "pmAccphone3",    szType));
							Str_Cpy(stOzData.DEFRAY_ACCOUNT_NUM  , JSON_GetValue (hData, "pmAcc",    szType));
							Str_Cpy(stOzData.DEPOSITOR_BIRTH_DATE, JSON_GetValue (hData, "pmAccbirthdate",    szType));
							Str_Chg(stOzData.DEPOSITOR_BIRTH_DATE, STRCHG_DEL_NONDIGIT);
							Str_Cpy(stOzData.CUST_RELAT_CD  , "");
							
							Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
							Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
							Str_Cpy(szRet, JSON_GetValue (hData, "pmAccrelation",    szType));
							SPRINT(szTmp,"SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s'", szRet,0,0);
							g_Sql_RetStr(szTmp, 20, stOzData.DEPOSITOR_RELAT_CD);
							
							Str_Cpy(stOzData.REQ_NM              , JSON_GetValue (hData, "pmAgentname",    szType));
							Str_Cpy(stOzData.REQ_TEL_DDD         , JSON_GetValue (hData, "pmAgentphone1",    szType));
							Str_Cpy(stOzData.REQ_TEL_EXN         , JSON_GetValue (hData, "pmAgentphone2",    szType));
							Str_Cpy(stOzData.REQ_TEL_NUM         , JSON_GetValue (hData, "pmAgentphone3",    szType));
						}
						/*************************************/
						/* 카드                              */
						/*************************************/
						else if( Str_Cmp(szTmp, "카드자동이체") == 0 )
						{
							Str_Cpy(stOzData.TRAN_FLAG, "20");
							Str_Cpy(stOzData.PAYMENT_METHOD, "20");
							Str_Cpy(stOzData.PAY_METHOD_TYPE, "10");
							
							lCnt = 0;
							g_Sql_RetInt("SELECT COUNT(*) FROM COMMONCODE WHERE CODE_ID = 'C61998'", &lCnt);
							
							Mem_Set((byte*)szBanknm, 0x00, sizeof(szBanknm));	
							Str_Cpy(szBanknm     , JSON_GetValue (hData, "pmBankText",    szType));
							for( i=0 ; i < lCnt ; i++ )
							{
								Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
								Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
								Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
								SPRINT(szTmp,"SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' LIMIT %d, 1",i,0,0);
								g_Sql_RetStr(szTmp, 10, szBuf);
								Mem_Cpy((byte *)szRet, (byte *)szBuf+5, Str_Len(szBuf)-5);
								if( Str_Cmp(szBanknm, szRet) == 0 )
								{
									Mem_Set((byte*)szBankcd, 0x00, sizeof(szBankcd));	
									Mem_Cpy((byte *)szBankcd, (byte *)szBuf, 3);
									Str_Cpy(stOzData.BNK_CD, szBankcd);
									Str_Cpy(stOzData.BNK_BRANCH_NM, szBanknm);
									break;
								}
							}
	
							Str_Cpy(stOzData.DEPOSITOR_NM        , JSON_GetValue (hData, "pmAccname",    szType));
							Str_Cpy(stOzData.DEPOSITOR_TEL_DDD   , JSON_GetValue (hData, "pmAccphone1",    szType));
							Str_Cpy(stOzData.DEPOSITOR_TEL_EXN   , JSON_GetValue (hData, "pmAccphone2",    szType));
							Str_Cpy(stOzData.DEPOSITOR_TEL_NUM   , JSON_GetValue (hData, "pmAccphone3",    szType));
							Str_Cpy(stOzData.DEFRAY_ACCOUNT_NUM  , JSON_GetValue (hData, "pmAcc",    szType));
							Str_Cpy(stOzData.DEPOSITOR_BIRTH_DATE, JSON_GetValue (hData, "pmAccbirthdate",    szType));
							Str_Chg(stOzData.DEPOSITOR_BIRTH_DATE, STRCHG_DEL_NONDIGIT);
							Str_Cpy(stOzData.CUST_RELAT_CD  , "");
	
							Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
							Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
							Str_Cpy(szRet       , JSON_GetValue (hData, "pmAccrelation",    szType));
							SPRINT(szTmp,"SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s'", szRet,0,0);
							g_Sql_RetStr(szTmp, 20, stOzData.DEPOSITOR_RELAT_CD);
							
							Str_Cpy(stOzData.REQ_NM              , JSON_GetValue (hData, "pmAgentname",    szType));
							Str_Cpy(stOzData.REQ_TEL_DDD         , JSON_GetValue (hData, "pmAgentphone1",    szType));
							Str_Cpy(stOzData.REQ_TEL_EXN         , JSON_GetValue (hData, "pmAgentphone2",    szType));
							Str_Cpy(stOzData.REQ_TEL_NUM         , JSON_GetValue (hData, "pmAgentphone3",    szType));
						}
						/*************************************/
						/* NULL                              */
						/*************************************/
						else
						{
							if( Str_Cmp(stOzData.OZ_TRAN_REQ_FLAG, "cancel") == 0 )
							{
								//자동이체 신청 취소
								Str_Cpy(stOzData.PAYMENT_METHOD, "");
								Str_Cpy(stOzData.PAY_METHOD_TYPE, "20");
							}
							else
							{
								//지로 -> 지로
								Str_Cpy(stOzData.PAYMENT_METHOD, "");
								Str_Cpy(stOzData.PAY_METHOD_TYPE, "");
							}
							
							Str_Cpy(stOzData.TRAN_FLAG           , "");
							Str_Cpy(stOzData.BNK_CD              , "");
							Str_Cpy(stOzData.BNK_BRANCH_NM       , "");
							Str_Cpy(stOzData.DEPOSITOR_NM        , "");
							Str_Cpy(stOzData.DEPOSITOR_TEL_DDD   , "");
							Str_Cpy(stOzData.DEPOSITOR_TEL_EXN   , "");
							Str_Cpy(stOzData.DEPOSITOR_TEL_NUM   , "");
							Str_Cpy(stOzData.DEFRAY_ACCOUNT_NUM  , "");
							Str_Cpy(stOzData.DEPOSITOR_BIRTH_DATE, "");
							Str_Cpy(stOzData.DEPOSITOR_RELAT_CD  , "");
							Str_Cpy(stOzData.CUST_RELAT_CD       , "");
							Str_Cpy(stOzData.REQ_NM              , "");
							Str_Cpy(stOzData.REQ_TEL_DDD         , "");
							Str_Cpy(stOzData.REQ_TEL_EXN         , "");
							Str_Cpy(stOzData.REQ_TEL_NUM         , "");
						}
					}
					else
					{
						Str_Cpy(stOzData.PAYMENT_METHOD      , "");
						Str_Cpy(stOzData.PAY_METHOD_TYPE     , "");
						Str_Cpy(stOzData.TRAN_FLAG           , "");
						Str_Cpy(stOzData.BNK_CD              , "");
						Str_Cpy(stOzData.BNK_BRANCH_NM       , "");
						Str_Cpy(stOzData.DEPOSITOR_NM        , "");
						Str_Cpy(stOzData.DEPOSITOR_TEL_DDD   , "");
						Str_Cpy(stOzData.DEPOSITOR_TEL_EXN   , "");
						Str_Cpy(stOzData.DEPOSITOR_TEL_NUM   , "");
						Str_Cpy(stOzData.DEFRAY_ACCOUNT_NUM  , "");
						Str_Cpy(stOzData.DEPOSITOR_BIRTH_DATE, "");
						Str_Cpy(stOzData.DEPOSITOR_RELAT_CD  , "");
						Str_Cpy(stOzData.CUST_RELAT_CD       , "");
						Str_Cpy(stOzData.REQ_NM              , "");
						Str_Cpy(stOzData.REQ_TEL_DDD         , "");
						Str_Cpy(stOzData.REQ_TEL_EXN         , "");
						Str_Cpy(stOzData.REQ_TEL_NUM         , "");
					}
					
					/*************************************/
					/* 청구방법                          */
					/*************************************/
					// LMS = 30, EMAIL = 40, MOBILE = 50
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy(szTmp, JSON_GetValue (hData, "pmBilling", szType));
					
					// LMS
					// LMS + 고지서 , 모바일 + LMS

					// PRINT("szTmp szTmp szTmp szTmp : %d ",szTmp,0,0);

					// Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					// SPRINT(szMsg, "리턴받은 pmBilling 값 \n[%s] ", szTmp, 0, 0);
					// MessageBoxEx(CONFIRM_OK, szMsg);

					// if( Str_Cmp(szTmp, "LMS") == 0 || Str_Cmp(szTmp, "LG") == 0 || Str_Cmp(szTmp, "ML") == 0)
					if( Str_Cmp(szTmp, "LMS") == 0 || Str_Cmp(szTmp, "LMS,고지서") == 0 || Str_Cmp(szTmp, "모바일,LMS") == 0)
					{
						// Str_Cpy(stOzData.BILING_METHOD, szTmp);
						
						// if(Str_Cmp(szTmp, "ML") == 0)
						if(Str_Cmp(szTmp, "모바일,LMS") == 0)
						{
							Str_Cpy(stOzData.BILING_METHOD, "31");
						}
						else if(Str_Cmp(szTmp, "LMS,고지서") == 0)
						{
							Str_Cpy(stOzData.BILING_METHOD, "32");
							Str_Cpy(stOzData.OZ_JIRO_REQ_FLAG, "new");							
						}
						else
						{
							Str_Cpy(stOzData.BILING_METHOD, "30");
						}
						
						Str_Cpy(stOzData.LMS_TEL_DDD, JSON_GetValue (hData, "pmLms1", szType) );
						Str_Cpy(stOzData.LMS_TEL_EXN, JSON_GetValue (hData, "pmLms2", szType) );
						Str_Cpy(stOzData.LMS_TEL_NUM, JSON_GetValue (hData, "pmLms3", szType) );
						
						// 기존 데이터가 70이 아니면 신규임
						// 20220224 기존에는 이중고지에 관련된건이 없었으나, 추가예정이기때문에
						// 70 LMS , 17 LMS+고지서 , 47 EMAIL+LMS , 78 모바일+LMS
						if( Str_Cmp(stMudData_ORI.BILING_METHOD, "70") != 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "17") != 0 
						|| Str_Cmp(stMudData_ORI.BILING_METHOD, "47") != 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "78") != 0)
						// if( Str_Cmp(stMudData_ORI.BILING_METHOD, "70") != 0 )
						{
							if (Str_Cmp(stMudData_ORI.BILING_METHOD, "14") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "48") == 0)
							{
								if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, stMudData.EMAIL_REQ_ID) != 0 ||
							    Str_Cmp(szTmp, stMudData.EMAIL_REQ_ADDR) != 0 )
								{
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "modify");
								}
								Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "new");
							}
							else
							{
								Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "new");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "");

							}							
						}
						else
						{
							if( Str_Cmp(stOzData.LMS_TEL_DDD, stMudData.LMS_TEL_DDD) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_EXN, stMudData.LMS_TEL_EXN) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_NUM, stMudData.LMS_TEL_NUM) != 0 )
							{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "modify");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "");
							}
							else
							{
								if( Str_Cmp(stOzData.CHG_CUST_TYPE, "20") == 0 )
								{
									Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
									Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
									Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");

								}
								else
								{
									if( g_lMobile_Use_Doc_Type == 1 )
									{
										//전입민원의 경우 -> 무조건 신청(데이터가 들어가있어도 신청, 무조건!!)
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "new");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");
									}
									else
									{
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");
									}
								}
							}
						}
						
						// 이메일 SETTING
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(stOzData.EMAIL_REQ_ADDR, JSON_GetValue (hData, "pmEmail1", szType) );
						Str_Cpy(szTmp, JSON_GetValue (hData, "pmEmail2", szType) );
						
						if( Str_Len(stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(stOzData.EMAIL_REQ_ADDR, szTmp);

							//입력된 이메일 주소가 없는 경우 @제거
							Str_Chg(stOzData.EMAIL_REQ_ADDR, STRCHG_DEL_ALL_SPACE);
							if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, "@") == 0 )
							{
								Str_Cpy(stOzData.EMAIL_REQ_ADDR, "");
							}
						}
						else
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "");
						}
					}
					// 이메일
					// 이메일+고지서 , 모바일 + 이메일
					// else if( Str_Cmp(szTmp, "E-mail") == 0 || Str_Cmp(szTmp, "EG") == 0 || Str_Cmp(szTmp, "ME") == 0)
					else if( Str_Cmp(szTmp, "E-mail") == 0 || Str_Cmp(szTmp, "E-mail,고지서") == 0 || Str_Cmp(szTmp, "모바일,E-mail") == 0)
					{
						// Str_Cpy(stOzData.BILING_METHOD, szTmp);
						
						if(Str_Cmp(szTmp, "모바일,E-mail") == 0)
						{
							Str_Cpy(stOzData.BILING_METHOD, "41");
						}
						else if(Str_Cmp(szTmp, "E-mail,고지서") == 0)
						{
							Str_Cpy(stOzData.BILING_METHOD, "42");
							Str_Cpy(stOzData.OZ_JIRO_REQ_FLAG, "new");
						}
						else 
						{
							Str_Cpy(stOzData.BILING_METHOD, "40");
						}

						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(stOzData.EMAIL_REQ_ADDR, JSON_GetValue (hData, "pmEmail1",    szType) );
						Str_Cpy(szTmp, JSON_GetValue (hData, "pmEmail2",    szType) );

						//20220224
						// if( Str_Cmp(stMudData_ORI.BILING_METHOD, "40") != 0)
						PRINT("stMudData_ORI.BILING_METHOD : %d" , stMudData_ORI.BILING_METHOD,0,0);
						if( Str_Cmp(stMudData_ORI.BILING_METHOD, "40") != 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "14") != 0 
						|| Str_Cmp(stMudData_ORI.BILING_METHOD, "47") != 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "48") != 0 )
						{
							if(Str_Cmp(stMudData_ORI.BILING_METHOD, "17") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "78") == 0)
							{
								if( Str_Cmp(stOzData.LMS_TEL_DDD, stMudData.LMS_TEL_DDD) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_EXN, stMudData.LMS_TEL_EXN) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_NUM, stMudData.LMS_TEL_NUM) != 0 )
								{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "modify");
								}
								Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "new");
							}
							else
							{
								Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "new");
							}							
						}
						else
						{
							if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, stMudData.EMAIL_REQ_ID) != 0 ||
							    Str_Cmp(szTmp, stMudData.EMAIL_REQ_ADDR) != 0 )
							{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "modify");
							}
							else
							{
								if( Str_Cmp(stOzData.CHG_CUST_TYPE, "20") == 0 )
								{
									Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
									Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
									Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");

								}
								else
								{
									if( g_lMobile_Use_Doc_Type == 1 )
									{
										//전입민원의 경우 -> 무조건 신청(데이터가 들어가있어도 신청, 무조건!!)
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "new");
									}
									else
									{
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");
									}
								}
							}
						}
						
						if( Str_Len(stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(stOzData.EMAIL_REQ_ADDR, szTmp);

							//입력된 이메일 주소가 없는 경우 @제거
							Str_Chg(stOzData.EMAIL_REQ_ADDR, STRCHG_DEL_ALL_SPACE);
							if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, "@") == 0 )
							{
								Str_Cpy(stOzData.EMAIL_REQ_ADDR, "");
							}
						}
						else
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "");
						}
						
						Str_Cpy(stOzData.LMS_TEL_DDD, "" );
						Str_Cpy(stOzData.LMS_TEL_EXN, "" );
						Str_Cpy(stOzData.LMS_TEL_NUM, "" );
					}
					// else if( Str_Cmp(szTmp, "EL") == 0) 
					else if( Str_Cmp(szTmp, "LMS,E-mail") == 0)
					{
						Str_Cpy(stOzData.BILING_METHOD, "60");	

						Str_Cpy(stOzData.LMS_TEL_DDD, JSON_GetValue (hData, "pmLms1", szType) );
						Str_Cpy(stOzData.LMS_TEL_EXN, JSON_GetValue (hData, "pmLms2", szType) );
						Str_Cpy(stOzData.LMS_TEL_NUM, JSON_GetValue (hData, "pmLms3", szType) );

						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(stOzData.EMAIL_REQ_ADDR, JSON_GetValue (hData, "pmEmail1",    szType) );
						Str_Cpy(szTmp, JSON_GetValue (hData, "pmEmail2",    szType) );

						// 기존 70도 아니고 40이 아닐때
						// if( Str_Cmp(stMudData_ORI.BILING_METHOD, "70") != 0 && Str_Cmp(stMudData_ORI.BILING_METHOD, "40") != 0)
						if( Str_Cmp(stMudData_ORI.BILING_METHOD, "18") == 0 && Str_Cmp(stMudData_ORI.BILING_METHOD, "80") == 0)
						{
							Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
							Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "new");
							Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "new");
						}
						// else if(Str_Cmp(stMudData_ORI.BILING_METHOD, "70") == 0)
						// 70 LMS , 17 LMS+송달 , 78 모+LMS
						else if( Str_Cmp(stMudData_ORI.BILING_METHOD, "70") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "17") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "78") == 0)
						{
							if( Str_Cmp(stOzData.LMS_TEL_DDD, stMudData.LMS_TEL_DDD) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_EXN, stMudData.LMS_TEL_EXN) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_NUM, stMudData.LMS_TEL_NUM) != 0 )
							{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "modify");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "new");
							}
							else
							{
								if( Str_Cmp(stOzData.CHG_CUST_TYPE, "20") == 0 )
								{
									Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
									Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
									Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");

								}
								else
								{
									if( g_lMobile_Use_Doc_Type == 1 )
									{
										//전입민원의 경우 -> 무조건 신청(데이터가 들어가있어도 신청, 무조건!!)
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "new");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "new");
									}
									else
									{
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");
									}
								}
							}

						}						
						// else if(Str_Cmp(stMudData_ORI.BILING_METHOD, "40") == 0)
						// 40 EMAIL , 14 EMAIL + 고지서 , 48 모바일 + 이메일
						else if( Str_Cmp(stMudData_ORI.BILING_METHOD, "40") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "14") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "48") == 0 )
						{
							if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, stMudData.EMAIL_REQ_ID) != 0 ||
							    Str_Cmp(szTmp, stMudData.EMAIL_REQ_ADDR) != 0 )
							{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "new");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "modify");
							}
							else
							{
								if( Str_Cmp(stOzData.CHG_CUST_TYPE, "20") == 0 )
								{
									Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
									Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
									Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");

								}
								else
								{
									if( g_lMobile_Use_Doc_Type == 1 )
									{
										//전입민원의 경우 -> 무조건 신청(데이터가 들어가있어도 신청, 무조건!!)
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "new");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "new");
									}
									else
									{
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");
									}
								}
							}
						}
						else if (Str_Cmp(stMudData_ORI.BILING_METHOD, "47") == 0 )
						{
							if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, stMudData.EMAIL_REQ_ID) != 0 ||
							    Str_Cmp(szTmp, stMudData.EMAIL_REQ_ADDR) != 0 )
							{
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "modify");

								if( Str_Cmp(stOzData.LMS_TEL_DDD, stMudData.LMS_TEL_DDD) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_EXN, stMudData.LMS_TEL_EXN) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_NUM, stMudData.LMS_TEL_NUM) != 0 )
								{
									Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "modify");
								}
								else
								{	
									Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "");		
								}

							}
							else if( Str_Cmp(stOzData.LMS_TEL_DDD, stMudData.LMS_TEL_DDD) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_EXN, stMudData.LMS_TEL_EXN) != 0 ||
							    Str_Cmp(stOzData.LMS_TEL_NUM, stMudData.LMS_TEL_NUM) != 0 )
							{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "modify");

								if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, stMudData.EMAIL_REQ_ID) != 0 ||
							    Str_Cmp(szTmp, stMudData.EMAIL_REQ_ADDR) != 0 )
								{
									Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "modify");
								}
								else
								{
									Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "");
								}
								// Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "");
							}
							else
							{
								if( Str_Cmp(stOzData.CHG_CUST_TYPE, "20") == 0 )
								{
									Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
									Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
									Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");

								}
								else
								{
									if( g_lMobile_Use_Doc_Type == 1 )
									{
										//전입민원의 경우 -> 무조건 신청(데이터가 들어가있어도 신청, 무조건!!)
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "new");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "new");
									}
									else
									{
										Str_Cpy(stOzData.BILL_METHOD_TYPE, "");
										Str_Cpy(stOzData.OZ_LMS_REQ_FLAG     , "");
										Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG     , "");
									}
								}
							}
						}

						if( Str_Len(stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(stOzData.EMAIL_REQ_ADDR, szTmp);

							//입력된 이메일 주소가 없는 경우 @제거
							Str_Chg(stOzData.EMAIL_REQ_ADDR, STRCHG_DEL_ALL_SPACE);
							if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, "@") == 0 )
							{
								Str_Cpy(stOzData.EMAIL_REQ_ADDR, "");
							}
						}
						else
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "");
						}
					}
					else
					{	
						//기존 청구방법 확인 -> 취소 or 고지서
						// if( Str_Cmp(stMudData_ORI.BILING_METHOD, "70") == 0 )
						if( Str_Cmp(stMudData_ORI.BILING_METHOD, "70") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "17") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "78") == 0)
						{
							Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "");
							Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "cancel");
							Str_Cpy(stOzData.BILL_METHOD_TYPE, "20");
						}
						// else if( Str_Cmp(stMudData_ORI.BILING_METHOD, "40") == 0 )
						else if( Str_Cmp(stMudData_ORI.BILING_METHOD, "40") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "14") == 0 || Str_Cmp(stMudData_ORI.BILING_METHOD, "48") == 0 )
						{
							Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "cancel");
							Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "");
							Str_Cpy(stOzData.BILL_METHOD_TYPE, "20");
						}
						else if (Str_Cmp(stMudData_ORI.BILING_METHOD, "47") == 0)
						{
							Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "cancel");
							Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "cancel");
							Str_Cpy(stOzData.BILL_METHOD_TYPE, "20");
						}
						else
						{
							if( Str_Cmp(szTmp, "모바일") == 0 )
							{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "");
								Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
							}
							else
							{
								Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "");
								Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "");
								Str_Cpy(stOzData.BILL_METHOD_TYPE, "");
							}
						}
						
						if( Str_Cmp(szTmp, "모바일") == 0 )
						{
							Str_Cpy(stOzData.BILING_METHOD, "50");
						}
						else if(Str_Cmp(szTmp, "모바일,고지서") == 0 )
						{
							Str_Cpy(stOzData.BILING_METHOD, "51");
							Str_Cpy(stOzData.OZ_JIRO_REQ_FLAG, "new");
						}
						else
						{
							Str_Cpy(stOzData.BILING_METHOD, "");
						}
						
						Str_Cpy(stOzData.LMS_TEL_DDD         , "" );
						Str_Cpy(stOzData.LMS_TEL_EXN         , "" );
						Str_Cpy(stOzData.LMS_TEL_NUM         , "" );

						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(stOzData.EMAIL_REQ_ADDR, JSON_GetValue (hData, "pmEmail1",    szType) );
						Str_Cpy(szTmp, JSON_GetValue (hData, "pmEmail2",    szType) );
						
						if( Str_Len(stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(stOzData.EMAIL_REQ_ADDR, szTmp);

							//입력된 이메일 주소가 없는 경우 @제거
							Str_Chg(stOzData.EMAIL_REQ_ADDR, STRCHG_DEL_ALL_SPACE);
							if( Str_Cmp(stOzData.EMAIL_REQ_ADDR, "@") == 0 )
							{
								Str_Cpy(stOzData.EMAIL_REQ_ADDR, "");
							}
						}
						else
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "");
						}
					}	
				}
				
				//인증 카드 정보
				Str_Cpy(stOzData.CARD_VALID_PERIOD               , JSON_GetValue (hItem, "card_valid_period",    szType) );
				Str_Cpy(stOzData.CARD_JOIN_YN                    , JSON_GetValue (hItem, "card_join_yn"		,    szType) );
				
				//PDF 경로
				szPath = JSON_GetValue (hItem, "pdf_path",    szType);
	
				hPath = JSON_Create( JSON_Object );
				if( hPath != NULL )
				{
					//OZ 파일(PDF) 을 Smart폴더 안의 폴더에 복사
					JSON_toJson( hPath, szPath ) ;
		
					j = 0;
					k = 0;
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Mem_Set((byte*)szFolderNm, 0x00, sizeof(szFolderNm));
					Mem_Set((byte*)szCopyNm, 0x00, sizeof(szCopyNm));
					
					Str_Cpy(szTmp, JSON_GetValue (hPath, "Path",    szType));
					lFileLen = Str_Len(szTmp);
					if( lFileLen > 0 )
					{
						for( i=0 ; lFileLen ; i++)
						{
							if(szTmp[i] == '0')
							{
								j = i;
								break;
							}
							else
							{
								k++;
							}
						}

						Mem_Cpy((byte *)szFolderNm, (byte *)szTmp+(j+9), 17);
						Mem_Cpy((byte *)szCopyNm, (byte *)szTmp+(j+9), 14);
					}
	
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
					Str_Cpy(szBuf, "../LCTECH/");
					Str_Cat(szBuf, szFolderNm);
					if( FFS_Exist(szBuf) )
					{
						lRet = g_FindFiles( szBuf, "*.Enc" , szFileNm);
						if( lRet > 0 )
						{
							SPRINT (stOzData.PDFPATH, "OZ_FILE/%s_%s_.pdf.Enc",  szCopyNm, stOzData.USE_CONT_NUM, 0);
							FFS_Copy(szFileNm, stOzData.PDFPATH);
	
							//데이터 옮긴 후 LCTECH 폴더 클리어(남은 oz파일 삭제)
							FFS_Delete(szFileNm);
						}
						
						Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
						lRet = g_FindFiles( szBuf, "*.pdf" , szFileNm);
						if( lRet > 0 )
						{
							//데이터 옮긴 후 LCTECH 폴더 클리어(남은 oz파일 삭제)
							FFS_Delete(szFileNm);
						}
					}
				}
			}
			else
			{
				if(hItem != NULL)
				{
					JSON_Finalize(hItem);
					hItem = NULL;
				}
				
				if(hPath != NULL)
				{
					JSON_Finalize(hPath);
					hPath = NULL;
				}
				
				if(hData != NULL)
				{
					JSON_Finalize(hData);
					hData = NULL;
				}
		
				g_Close_SubDlg();
				
				ON_DRAW();
				return;
			}
		}

		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
		
		if(hPath != NULL)
		{
			JSON_Finalize(hPath);
			hPath = NULL;
		}
		
		if(hData != NULL)
		{
			JSON_Finalize(hData);
			hData = NULL;
		}

		g_Close_SubDlg();
		
		Snd_OzView();
		
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	함수명 : Save_Cust_Info_Data
	기  능 : stMudData 저장
	Param  : 
	Return : 
	========================================================================================*/	
	void Save_Cust_Info_Data(void)
	{
		char szTmp[200];
		long i = 0;
		long j = 0;
		
		if( m_bFirst == INIT_CUSTINFO )
		{
			// 고객명
			Mem_Set( (byte*)stMudData.CUST_NM, 0x00, sizeof(stMudData.CUST_NM) );
			Str_Cpy( stMudData.CUST_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_CUST_NM)) );
			
			// 생년월일
			Mem_Set( (byte*)stMudData.SOC_NUM, 0x00, sizeof(stMudData.SOC_NUM) );
			Str_Cpy( stMudData.SOC_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_BRITH_YMD)) );
			
			// 핸드폰 DDD
			Mem_Set( (byte*)stMudData.CP_DDD, 0x00, sizeof(stMudData.CP_DDD) );
			Str_Cpy( stMudData.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD)) );
			
			// 핸드폰 EXN
			Mem_Set( (byte*)stMudData.CP_EXN, 0x00, sizeof(stMudData.CP_EXN) );
			Str_Cpy( stMudData.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_EXN)) );
			
			// 핸드폰 NUM
			Mem_Set( (byte*)stMudData.CP_NUM, 0x00, sizeof(stMudData.CP_NUM) );
			Str_Cpy(stMudData.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM)) );
			
			// 전화 DDD
			Mem_Set( (byte*)stMudData.OWNHOUSE_TEL_DDD, 0x00, sizeof(stMudData.OWNHOUSE_TEL_DDD) );
			Str_Cpy(stMudData.OWNHOUSE_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_TEL_DDD)) );
			
			// 전화 EXN
			Mem_Set( (byte*)stMudData.OWNHOUSE_TEL_EXN, 0x00, sizeof(stMudData.OWNHOUSE_TEL_EXN) );
			Str_Cpy(stMudData.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_EXN)) );
			
			// 전화 NUM
			Mem_Set( (byte*)stMudData.OWNHOUSE_TEL_NUM, 0x00, sizeof(stMudData.OWNHOUSE_TEL_NUM) );
			Str_Cpy(stMudData.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_NUM)) );
			
			// LMS DDD
			Mem_Set( (byte*)stMudData.LMS_TEL_DDD, 0x00, sizeof(stMudData.LMS_TEL_DDD) );
			Str_Cpy(stMudData.LMS_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD)) );
			
			// LMS EXN
			Mem_Set( (byte*)stMudData.LMS_TEL_EXN, 0x00, sizeof(stMudData.LMS_TEL_EXN) );
			Str_Cpy(stMudData.LMS_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_EXN)) );
			
			// LMS NUM
			Mem_Set( (byte*)stMudData.LMS_TEL_NUM, 0x00, sizeof(stMudData.LMS_TEL_NUM) );
			Str_Cpy(stMudData.LMS_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM)) );
			
			// EMAIL_ID
			Mem_Set( (byte*)stMudData.EMAIL_REQ_ID, 0x00, sizeof(stMudData.EMAIL_REQ_ID) );
			Str_Cpy(stMudData.EMAIL_REQ_ID, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_EMAIL)) );
			
			// EMAIL_ADDR
			Mem_Set( (byte*)stMudData.EMAIL_REQ_ADDR, 0x00, sizeof(stMudData.EMAIL_REQ_ADDR) );
			Str_Cpy(stMudData.EMAIL_REQ_ADDR, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_EMAIL)) );
			
			// 법인
			Mem_Set( (byte*)stMudData.FIRM_NM, 0x00, sizeof(stMudData.FIRM_NM) );
			Str_Cpy(stMudData.FIRM_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_FRIM)) );
			
			// 사업자등록번호
			Mem_Set( (byte*)stMudData.BIZ_REGI_NUM, 0x00, sizeof(stMudData.BIZ_REGI_NUM) );
			Str_Cpy(stMudData.BIZ_REGI_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_BIZ_REG_NUM)) );
			
			// 요금청구방법
			Mem_Set((byte*)stMudData.BILING_METHOD, 0x00, sizeof(stMudData.BILING_METHOD));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD) ) );
			
			i = g_SearchStr( szTmp, MUD_BILL_SEND_METHOD );
			j = g_SearchStr( szTmp, MUD_BILL_SEND_METHOD_DOUBLE );
			
			if (i == -1)
			{
				if(j == -1 )
				{
					Str_Cpy(stMudData.BILING_METHOD, "");
				}
				else
				{
					Str_Cpy(stMudData.BILING_METHOD, MUD_BILL_SEND_METHOD_DOUBLE[j].Code);
				}
				
			}
			else
			{
				Str_Cpy(stMudData.BILING_METHOD, MUD_BILL_SEND_METHOD[i].Code);
			}
		}
	}
	
	/*=======================================================================================
	함수명 : Save_PayMethod_Info_Data
	기  능 : stMudData 저장
	Param  : 
	Return : 
	========================================================================================*/	
	void Save_PayMethod_Info_Data(void)
	{
		char szTmp[200];
		char szSql[200];
		long i = 0;
		
		if( m_bFirst == INIT_AUTOTRANS )
		{
			// 납부방법
			Mem_Set( (byte*)stMudData.PAYMENT_METHOD, 0x00, sizeof(stMudData.PAYMENT_METHOD) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			
			Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_PAY_METHOD) ) );
			
			i = g_SearchStr( szTmp, MUD_PAY_METHOD );
			
			if (i == -1)
			{
				Str_Cpy(stMudData.PAYMENT_METHOD, "");
			}
			else
			{
				Str_Cpy(stMudData.PAYMENT_METHOD, MUD_PAY_METHOD[i].Code);
			}
			
			// 은행, 카드 코드
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stMudData.BNK_CD, 0x00, sizeof(stMudData.BNK_CD) );
			
			// 은행
			if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
			{
				SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C61999' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), 0, 0);
				g_Sql_RetStr( szSql, 20, szTmp );
			}
			// 카드
			else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
			{
				SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C61998' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), 0, 0);
				g_Sql_RetStr( szSql, 20, szTmp );
			}
			// 지로
			else
			{
				Str_Cpy( szTmp, "" );
			}
			
			Str_Cpy( stMudData.BNK_CD, szTmp );
			
			// 은행, 카드 명
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stMudData.BNK_BRANCH_NM, 0x00, sizeof(stMudData.BNK_BRANCH_NM) );
			
			if( Str_Cmp( EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), "") != 0 )
			{
				// 은행
				if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
				{
					SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), 0, 0);
					g_Sql_RetStr( szSql, 20, szTmp );
					Mem_Cpy((byte *)stMudData.BNK_BRANCH_NM, (byte *)szTmp+5, Str_Len(szTmp)-5);
				}
				// 카드
				else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
				{
					SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), 0, 0);
					g_Sql_RetStr( szSql, 20, szTmp );
					Mem_Cpy((byte *)stMudData.BNK_BRANCH_NM, (byte *)szTmp+5, Str_Len(szTmp)-5);
				}
				
			}
			else
			{
				Str_Cpy( stMudData.BNK_BRANCH_NM, "" );
			}
			
			// 계좌번호
			Mem_Set( (byte*)stMudData.DEFRAY_ACCOUNT_NUM, 0x00, sizeof(stMudData.DEFRAY_ACCOUNT_NUM) );
			
			if( m_lBackAutoTrans == 0 )
			{
				Str_Cpy( stMudData.DEFRAY_ACCOUNT_NUM, stMudData_ORI.DEFRAY_ACCOUNT_NUM );
			}
			else
			{
				Str_Cpy( stMudData.DEFRAY_ACCOUNT_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ACCOUNT)) );
			}

			// 예금주명
			Mem_Set( (byte*)stMudData.DEPOSITOR_NM, 0x00, sizeof(stMudData.DEPOSITOR_NM) );
			Str_Cpy( stMudData.DEPOSITOR_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_NM)) );
			
			// 예금주 전화번호
			Mem_Set( (byte*)stMudData.DEPOSITOR_TEL_DDD, 0x00, sizeof(stMudData.DEPOSITOR_TEL_DDD) );
			Str_Cpy( stMudData.DEPOSITOR_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD)) );
			
			Mem_Set( (byte*)stMudData.DEPOSITOR_TEL_EXN, 0x00, sizeof(stMudData.DEPOSITOR_TEL_EXN) );
			Str_Cpy( stMudData.DEPOSITOR_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN)) );
			
			Mem_Set( (byte*)stMudData.DEPOSITOR_TEL_NUM, 0x00, sizeof(stMudData.DEPOSITOR_TEL_NUM) );
			Str_Cpy( stMudData.DEPOSITOR_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM)) );
			
			// 예금주 생년월일 사업자번호
			Mem_Set( (byte*)stMudData.DEPOSITOR_BIRTH_DATE, 0x00, sizeof(stMudData.DEPOSITOR_BIRTH_DATE) );
			Str_Cpy( stMudData.DEPOSITOR_BIRTH_DATE, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_BRITHDAY)) );
			
			// 예금주와 관계
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stMudData.DEPOSITOR_RELAT_CD, 0x00, sizeof(stMudData.DEPOSITOR_RELAT_CD) );
			
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT) ), 0, 0);
			g_Sql_RetStr( szSql, 20, szTmp );
			
			Str_Cpy( stMudData.DEPOSITOR_RELAT_CD, szTmp );
			
			// 대리인명
			Mem_Set( (byte*)stMudData.REQ_NM, 0x00, sizeof(stMudData.REQ_NM) );
			Str_Cpy( stMudData.REQ_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_NM)) );
			
			// 대리인전화번호
			Mem_Set( (byte*)stMudData.REQ_TEL_DDD, 0x00, sizeof(stMudData.REQ_TEL_DDD) );
			Str_Cpy( stMudData.REQ_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD)) );
			
			Mem_Set( (byte*)stMudData.REQ_TEL_EXN, 0x00, sizeof(stMudData.REQ_TEL_EXN) );
			Str_Cpy( stMudData.REQ_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN)) );
			
			Mem_Set( (byte*)stMudData.REQ_TEL_NUM, 0x00, sizeof(stMudData.REQ_TEL_NUM) );
			Str_Cpy( stMudData.REQ_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM)) );
		}
	}
	
	/*=======================================================================================
	함수명 : SetBackAutoTrans
	기  능 : 자동이체신청 되돌리기
	Param  : 
	Return : 
	========================================================================================*/	
	void SetBackAutoTrans(void)
	{
		char szSql[200];
		char szTmp[200];
		long i = 0;
		
		//납부방법
		i = g_SearchCD( stMudData_ORI.PAYMENT_METHOD, MUD_PAY_METHOD );
		
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), MUD_PAY_METHOD[i].Str);
		}
		
		// 은행
		if( Str_Cmp( stMudData_ORI.PAYMENT_METHOD, "20" ) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "은행종류" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "계좌번호" );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' AND CODE_ITEM = '%s' ", stMudData_ORI.BNK_CD, 0, 0   );
			g_Sql_RetStr( szSql, 20, szTmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_BANK), szTmp );	
		}
		// 카드
		else if( Str_Cmp( stMudData_ORI.PAYMENT_METHOD, "30" ) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "카드종류" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "카드번호" );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' AND CODE_ITEM = '%s' ", stMudData_ORI.BNK_CD, 0, 0   );
			g_Sql_RetStr( szSql, 20, szTmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_BANK), szTmp );
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "" );
		}
		
		// 계좌번호, 보안처리
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ACCOUNT), stMudData_ORI.SECU_DEFRAY_ACCOUNT_NUM );
		
		// 예금주명
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_NM), stMudData_ORI.DEPOSITOR_NM );
		
		// 예금주 전화번호
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD), stMudData_ORI.DEPOSITOR_TEL_DDD );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN), stMudData_ORI.DEPOSITOR_TEL_EXN );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM), stMudData_ORI.DEPOSITOR_TEL_NUM );
		
		// 예금주 생년월일 사업자번호
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		if( Str_Len(stMudData_ORI.DEPOSITOR_BIRTH_DATE) == 13 )
		{
			Mem_Cpy( (byte *)szTmp, (byte *)stMudData_ORI.DEPOSITOR_BIRTH_DATE, 6 );
		}
		else
		{
			Str_Cpy(szTmp, stMudData_ORI.DEPOSITOR_BIRTH_DATE);
		}
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_BRITHDAY), szTmp );
		
		// 예금주와 관계	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' AND CODE_ITEM = '%s' ", stMudData_ORI.DEPOSITOR_RELAT_CD, 0, 0   );
		g_Sql_RetStr( szSql, 20, szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT), szTmp );
		
		// 대리인명
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_NM), stMudData_ORI.REQ_NM );
		
		// 대리인 전화번호
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD), stMudData_ORI.REQ_TEL_DDD );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN), stMudData_ORI.REQ_TEL_EXN );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM), stMudData_ORI.REQ_TEL_NUM );
		
		// 확인버튼
		m_lPayMethod_Chk = 0;
		ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), BTNCTRLBKCOLOR);
		ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), BTNMENUFRCOLOR);
	
		// m_lBackAutoTrans
		m_lBackAutoTrans = 0;
		
		// 콤보 Setting
		SetCombo_Filter();
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : ClearAutoTrans
	기  능 : 자동이체신청 데이터 Clear
	Param  : 
	Return : 
	========================================================================================*/	
	void ClearAutoTrans(void)
	{
		Mem_Set((byte*)stMudData.BNK_CD, 0x00, sizeof(stMudData.BNK_CD) );
		Mem_Set((byte*)stMudData.BNK_BRANCH_NM, 0x00, sizeof(stMudData.BNK_BRANCH_NM) );
		Mem_Set((byte*)stMudData.DEPOSITOR_NM, 0x00, sizeof(stMudData.DEPOSITOR_NM) );
		Mem_Set((byte*)stMudData.DEPOSITOR_TEL_DDD, 0x00, sizeof(stMudData.DEPOSITOR_TEL_DDD) );
		Mem_Set((byte*)stMudData.DEPOSITOR_TEL_EXN, 0x00, sizeof(stMudData.DEPOSITOR_TEL_EXN) );
		Mem_Set((byte*)stMudData.DEPOSITOR_TEL_NUM, 0x00, sizeof(stMudData.DEPOSITOR_TEL_NUM) );
		Mem_Set((byte*)stMudData.DEFRAY_ACCOUNT_NUM, 0x00, sizeof(stMudData.DEFRAY_ACCOUNT_NUM) );
		Mem_Set((byte*)stMudData.DEPOSITOR_BIRTH_DATE, 0x00, sizeof(stMudData.DEPOSITOR_BIRTH_DATE) );
		Mem_Set((byte*)stMudData.DEPOSITOR_RELAT_CD, 0x00, sizeof(stMudData.DEPOSITOR_RELAT_CD) );
		Mem_Set((byte*)stMudData.CUST_RELAT_CD, 0x00, sizeof(stMudData.CUST_RELAT_CD) );
		Mem_Set((byte*)stMudData.REQ_NM, 0x00, sizeof(stMudData.REQ_NM) );
		Mem_Set((byte*)stMudData.REQ_TEL_DDD, 0x00, sizeof(stMudData.REQ_TEL_DDD) );
		Mem_Set((byte*)stMudData.REQ_TEL_EXN, 0x00, sizeof(stMudData.REQ_TEL_EXN) );
		Mem_Set((byte*)stMudData.REQ_TEL_NUM, 0x00, sizeof(stMudData.REQ_TEL_NUM) );
		
		m_lBackAutoTrans = 1;
	}
	
	/*=======================================================================================
	함수명 : SetViewAutoTrans
	기  능 : 자동이체신청 버튼 Enable, Disable
	Param  : flag : 0 = FALSE, 1 = TRUE
	Return : 
	========================================================================================*/	
	void SetViewAutoTrans(long flag)
	{
		if( flag == 1 )
		{
			// 은행/카드
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), FALSE );
			
			// 계좌번호/카드번호
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), FALSE );
			
			// 예금주명
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), FALSE );
			
			// 예금주 전화번호
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_TEL_1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_TEL_1), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD+1), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_2), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_3), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_NUM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_NUM), FALSE );
			
			// 예금주 생년월일
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), FALSE );
			
			// 예금주와 관계
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), FALSE );
			
			// 대리인명
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
			
			// 대리인 전화번호
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_TEL_1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_TEL_1), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_2), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_3), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), FALSE );
		}
		else
		{
			// 은행/카드
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), TRUE );
			
			// 계좌번호
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), TRUE );
			
			// 예금주명
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), TRUE );
			
			// 예금주 전화번호
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_TEL_1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_TEL_1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_TEL_DDD+1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_2), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_EXN), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_DEP_TEL_3), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_NUM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_TEL_NUM), TRUE );
			
			// 예금주 생년월일
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), TRUE );
			
			// 예금주 관계
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), TRUE );
			
			// 대리인 명
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
			
			// 대리인 전화번호
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_TEL_1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_TEL_1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD+1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_2), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_EXN), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AT_ALT_TEL_3), TRUE );		
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_TEL_NUM), TRUE );
		}
	}
	
	/*=======================================================================================
	함수명 : ChkOzTransReqFlag
	기  능 : OZ_TRAN_REQ_FLAG 결정
	Param  : 
	Return : 0 = 바뀐거 없음, 1 = NEW, 2 = CANCEL
	========================================================================================*/	
	long ChkOzTransReqFlag(void)
	{	
		char szMsg[150];
		char szTmp[256];
		long i;
		long j;
		
		// 전입인 경우
		if( g_lMobile_Use_Doc_Type == 1 )
		{
			// 전입인 경우에는 무조건 사전접수로만 받아오기 때문에 20, 30이면 사전접수로 판단한다.
			if( Str_Cmp(stMudData.PAYMENT_METHOD, "10" ) != 0)
			{
				return 1;
			}
		}
		// 이외의 경우
		else
		{
			// CANCEL
			if( Str_Cmp(stMudData_ORI.PAYMENT_METHOD, "10" ) != 0 && Str_Cmp(stMudData.PAYMENT_METHOD, "10" ) == 0 )
			{
				return 2;
			}

			// Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			// SPRINT(szMsg, "TEST_ORI \n[%s] ", stMudData_ORI.DEPOSITOR_BIRTH_DATE, 0, 0);
			// MessageBoxEx(CONFIRM_OK, szMsg);

			if( Str_Len(stMudData_ORI.DEPOSITOR_BIRTH_DATE) == 13 )
			{
				Mem_Cpy((byte *)szTmp, (byte *)stMudData_ORI.DEPOSITOR_BIRTH_DATE, 6);
				// Mem_Cpy((byte *)stMudData_ORI.DEPOSITOR_BIRTH_DATE, (byte *)stMudData_ORI.DEPOSITOR_BIRTH_DATE, 6);
				// Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				// SPRINT(szMsg, "TEST_ORI2222 \n[%s] ", szTmp, 0, 0);
				// MessageBoxEx(CONFIRM_OK, szMsg);
			}
			else
			{
				Str_Cpy(szTmp, stMudCancelData.DEPOSITOR_BIRTH_DATE);
			}
			
			// NEW 0802
			// if( Str_Cmp(stMudData_ORI.BNK_CD, stMudData.BNK_CD ) != 0 )
			// {					
			// 	return 1;
			// }
			// else if(Str_Cmp(stMudData_ORI.BNK_BRANCH_NM, stMudData.BNK_BRANCH_NM ) != 0 )
			// if(Str_Cmp(stMudData_ORI.BNK_BRANCH_NM, stMudData.BNK_BRANCH_NM ) != 0 )
			// {
			// 	return 1;
			// }
			//else if(Str_Cmp(stMudData_ORI.DEPOSITOR_NM, stMudData.DEPOSITOR_NM ) != 0 )
			if(Str_Cmp(stMudData_ORI.DEPOSITOR_NM, stMudData.DEPOSITOR_NM ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.DEPOSITOR_TEL_DDD, stMudData.DEPOSITOR_TEL_DDD ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.DEPOSITOR_TEL_EXN, stMudData.DEPOSITOR_TEL_EXN ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.DEPOSITOR_TEL_NUM, stMudData.DEPOSITOR_TEL_NUM ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.DEFRAY_ACCOUNT_NUM, stMudData.DEFRAY_ACCOUNT_NUM ) != 0 )
			{
				return 1;
			}
			// else if(Str_Cmp(stMudData_ORI.DEPOSITOR_BIRTH_DATE,stMudData.DEPOSITOR_BIRTH_DATE ) != 0 )
			else if(Str_Cmp(szTmp,stMudData.DEPOSITOR_BIRTH_DATE ) != 0 )
			{	
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.DEPOSITOR_RELAT_CD, stMudData.DEPOSITOR_RELAT_CD ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.REQ_NM, stMudData.REQ_NM ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.REQ_TEL_DDD, stMudData.REQ_TEL_DDD ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.REQ_TEL_EXN, stMudData.REQ_TEL_EXN ) != 0 )
			{
				return 1;
			}
			else if(Str_Cmp(stMudData_ORI.REQ_TEL_NUM, stMudData.REQ_TEL_NUM ) != 0 )
			{	
				return 1;
			}
		}
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : Snd_OzView
	기  능 : FR822566
	Param  : 
	Return :
	========================================================================================*/	
	void Snd_OzView(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long nLen = 0;
		char* szfile;
		char* filedata;
		long nRet, filesize, fd;
		handle file;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822566, FALSE);

		if( g_lMobile_Use_Doc_Type == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "cust_num",              " "                            );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "cust_num",              stOzData.CUST_NUM            );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",              stOzData.USE_CONT_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd",                 stOzData.BRANCH_CD           );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",                 stOzData.CENTER_CD           );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",            stOzData.INST_PLACE_NUM      );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stOzData.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",                   szTmp                          );
		
		JSON_SetValue( g_pjcomm, 'C', "chg_cust_type",             stOzData.CHG_CUST_TYPE       );
		JSON_SetValue( g_pjcomm, 'C', "data_col_type",             stOzData.DATA_COL_TYPE       );
		JSON_SetValue( g_pjcomm, 'C', "tran_flag",                 stOzData.TRAN_FLAG           );
		JSON_SetValue( g_pjcomm, 'C', "gender",                    stOzData.GENDER              );
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn",         stOzData.INFO_USE_AGREE_YN   );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn",               stOzData.INFO_USE_YN         );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn4",              stOzData.INFO_USE_YN4        );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn5",              stOzData.INFO_USE_YN5        );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn6",              stOzData.INFO_USE_YN6        );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stOzData.RMK );
		JSON_SetValue( g_pjcomm, 'C', "rmk",                       szTmp                          );
		
		JSON_SetValue( g_pjcomm, 'C', "trans_flag",                stOzData.TRANS_FLAG          );
		JSON_SetValue( g_pjcomm, 'C', "lms_tel_ddd",               stOzData.LMS_TEL_DDD         );
		JSON_SetValue( g_pjcomm, 'C', "lms_tel_exn",               stOzData.LMS_TEL_EXN         );
		JSON_SetValue( g_pjcomm, 'C', "lms_tel_num",               stOzData.LMS_TEL_NUM         );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stOzData.EMAIL_REQ_ADDR );
		JSON_SetValue( g_pjcomm, 'C', "email_req_addr",            szTmp                          );
		
		JSON_SetValue( g_pjcomm, 'C', "biling_method",             stOzData.BILING_METHOD       );
		JSON_SetValue( g_pjcomm, 'C', "payment_method",            stOzData.PAYMENT_METHOD      );
		JSON_SetValue( g_pjcomm, 'C', "pay_method_type",           stOzData.PAY_METHOD_TYPE     );
		JSON_SetValue( g_pjcomm, 'C', "bill_method_type",          stOzData.BILL_METHOD_TYPE    );
		JSON_SetValue( g_pjcomm, 'C', "bnk_cd",                    stOzData.BNK_CD              );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stOzData.DEPOSITOR_NM );
		JSON_SetValue( g_pjcomm, 'C', "depositor_nm",              szTmp                          );

		JSON_SetValue( g_pjcomm, 'C', "depositor_tel_ddd",         stOzData.DEPOSITOR_TEL_DDD   );
		JSON_SetValue( g_pjcomm, 'C', "depositor_tel_exn",         stOzData.DEPOSITOR_TEL_EXN   );
		JSON_SetValue( g_pjcomm, 'C', "depositor_tel_num",         stOzData.DEPOSITOR_TEL_NUM   );
		JSON_SetValue( g_pjcomm, 'C', "defray_account_num",        stOzData.DEFRAY_ACCOUNT_NUM  );
		JSON_SetValue( g_pjcomm, 'C', "depositor_birth_date",      stOzData.DEPOSITOR_BIRTH_DATE);
		JSON_SetValue( g_pjcomm, 'C', "depositor_relat_cd",        stOzData.DEPOSITOR_RELAT_CD  );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stOzData.REQ_NM );
		JSON_SetValue( g_pjcomm, 'C', "req_nm",                    szTmp                          );
		
		JSON_SetValue( g_pjcomm, 'C', "req_tel_ddd",               stOzData.REQ_TEL_DDD         );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_exn",               stOzData.REQ_TEL_EXN         );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_num",               stOzData.REQ_TEL_NUM         );
		JSON_SetValue( g_pjcomm, 'C', "oz_tran_req_flag",          stOzData.OZ_TRAN_REQ_FLAG    );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stOzData.ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "addr_union",                szTmp                          );
		
		JSON_SetValue( g_pjcomm, 'C', "soc_num",                   stOzData.SOC_NUM             );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_ddd",          stOzData.OWNHOUSE_TEL_DDD    );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_exn",          stOzData.OWNHOUSE_TEL_EXN    );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_num",          stOzData.OWNHOUSE_TEL_NUM    );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",                    stOzData.CP_DDD              );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",                    stOzData.CP_EXN              );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",                    stOzData.CP_NUM              );
		JSON_SetValue( g_pjcomm, 'C', "oz_email_req_flag",         stOzData.OZ_EMAIL_REQ_FLAG   );
		JSON_SetValue( g_pjcomm, 'C', "oz_lms_req_flag",           stOzData.OZ_LMS_REQ_FLAG     );
		JSON_SetValue( g_pjcomm, 'C', "oz_jiro_req_flag",          stOzData.OZ_JIRO_REQ_FLAG     );
		
		//기존 사용계약서 데이터(해지를 위해 필요함)
		JSON_SetValue( g_pjcomm, 'C', "cancel_payment_method",     stMudCancelData.PAYMENT_METHOD     );
		JSON_SetValue( g_pjcomm, 'C', "cancel_bnk_cd",             stMudCancelData.BNK_CD             );
		JSON_SetValue( g_pjcomm, 'C', "cancel_defray_account_num", stMudCancelData.DEFRAY_ACCOUNT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_relat_cd", stMudCancelData.DEPOSITOR_RELAT_CD );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMudCancelData.DEPOSITOR_NM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_nm",       szTmp );
		
		// 13자리면 주민번호 -> 앞의 6자리만
		// 아닌 경우는 사업자번호 -> 모두 넘기기
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		if( Str_Len(stMudCancelData.DEPOSITOR_BIRTH_DATE) == 13 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stMudCancelData.DEPOSITOR_BIRTH_DATE, 6);
		}
		else
		{
			Str_Cpy(szTmp, stMudCancelData.DEPOSITOR_BIRTH_DATE);
		}
		
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_birth_date", szTmp );

		JSON_SetValue( g_pjcomm, 'C', "cancel_lms_tel_ddd", stMudCancelData.LMS_TEL_DDD );
		JSON_SetValue( g_pjcomm, 'C', "cancel_lms_tel_exn", stMudCancelData.LMS_TEL_EXN );
		JSON_SetValue( g_pjcomm, 'C', "cancel_lms_tel_num", stMudCancelData.LMS_TEL_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_email_req_addr", stMudCancelData.EMAIL_REQ_ADDR);
		JSON_SetValue( g_pjcomm, 'C', "card_valid_period", stOzData.CARD_VALID_PERIOD );
		JSON_SetValue( g_pjcomm, 'C', "card_join_yn", stOzData.CARD_JOIN_YN );
		
		// 민원에서 유입된 경우
		if( g_lMobile_Inflow_Path == 0 || g_lMobile_Inflow_Path == 1 || g_lMobile_Inflow_Path == 5 )
		{
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
			JSON_SetValue( g_pjcomm, 'C', "zip_seq", stMw.szZip_seq );
	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, stMw.szEtc_addr );
			JSON_SetValue( g_pjcomm, 'C', "etc_addr", szTmp );
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, stMw.szTrans_in_cust_nm );
			JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_nm", szTmp );
			
			JSON_SetValue( g_pjcomm, 'C', "trans_in_soc_num", stMw.szTrans_in_soc_num );
			JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_num", stMw.szTrans_in_cust_num );
			JSON_SetValue( g_pjcomm, 'C', "assign_req_tel_ddd", stMw.szReq_tel_ddd );
			JSON_SetValue( g_pjcomm, 'C', "assign_req_tel_exn", stMw.szReq_tel_exn );
			JSON_SetValue( g_pjcomm, 'C', "assign_req_tel_num", stMw.szReq_tel_num );
			JSON_SetValue( g_pjcomm, 'C', "assign_req_cp_ddd", stMw.szReq_cp_ddd );
			JSON_SetValue( g_pjcomm, 'C', "assign_req_cp_exn", stMw.szReq_cp_exn );
			JSON_SetValue( g_pjcomm, 'C', "assign_req_cp_num", stMw.szReq_cp_num );
		}
					
		if( ChkChgUserInfo() > 0 )
		{	
			 Str_Cpy(stOzData.CHK_CHG_USERINFO_FLAG, "Y");
		}	
		else
		{
			Str_Cpy(stOzData.CHK_CHG_USERINFO_FLAG, "N");
		}
		
		JSON_SetValue( g_pjcomm, 'C', "chk_chg_userinfo_flag", stOzData.CHK_CHG_USERINFO_FLAG );
		
		//[FIXME] szSend_Info_Trans_yn 조건 추가 serv_add_yn 체크 필요 함.
		if( g_szSERV_ADD_YN[0] == 'Y' || stMw.szSend_Info_Trans_yn[0] == 'Y')
		{
			JSON_SetValue( g_pjcomm, 'C', "serv_add_yn", "Y" );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "serv_add_yn", "N" );
		}
		
		filesize = FFS_GetSize( stOzData.PDFPATH );
		filedata = Mem_Alloc(filesize);
		
		fd = FFS_Open(stOzData.PDFPATH, FS_READ_MODE, FS_NORMAL_FLAG );
		FFS_Read ( fd, (byte*)filedata, filesize );
		FFS_Close(fd);

		file = BASE64_Create();
		BASE64_Encode(file, filedata, filesize );
		szfile = BASE64_GetResult(file);	
		
		JSON_SetValue( g_pjcomm, 'C', "oz_file",  szfile );

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR822566;
		HTTP_DownloadData( szUrl, "FR822566_IN",  "FR822566" , sndbuf, szbuf );
		
		return;
	}
	
	/*=======================================================================================
	함수명 : TR822566
	기  능 : CallBack TR822566
	Param  : 
	Return :
	========================================================================================*/	
	long TR822566(void)
	{
		char szSql[600];
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(822566) >= 0)
		{
			if( g_lMobile_Inflow_Path == 2 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT( szSql, " UPDATE NORMAL_DATA SET BILL_YN = 'Y' WHERE USE_CONT_NUM = '%s' AND INST_PLACE_NUM = '%s'", stMudData.USE_CONT_NUM, stMudData.INST_PLACE_NUM, 0 );
				g_Sql_DirectExecute( szSql );
			}

			setCardMove();
			ON_DRAW();
			return 1;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "등록에 실패하였습니다.\n다시 전송하시겠습니까?")  == MB_OK)
			{
				Snd_OzView();
				
				if( g_lMobile_Inflow_Path == 2 )
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT( szSql, " UPDATE NORMAL_DATA SET BILL_YN = 'Y' WHERE USE_CONT_NUM = '%s' AND INST_PLACE_NUM = '%s'", stMudData.USE_CONT_NUM, stMudData.INST_PLACE_NUM, 0 );
					g_Sql_DirectExecute( szSql );
				}
				
				return 0;
			}
			
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : ChkChgUserInfo
	기  능 : 고객정보 변경 여부
	Param  : 
	Return :
	========================================================================================*/	
	long ChkChgUserInfo(void)
	{
		char szBefore_SocNum[7];
		char szAfter_SocNUm[7];
		
		Mem_Set((byte*)szBefore_SocNum, 0x00, sizeof(szBefore_SocNum));
		Mem_Cpy((byte *)szBefore_SocNum, (byte *)stMudData.SOC_NUM + 0, 6);
		
		Mem_Set((byte*)szAfter_SocNUm, 0x00, sizeof(szAfter_SocNUm));
		Mem_Cpy((byte *)szAfter_SocNUm, (byte *)stMudData_ORI.SOC_NUM + 0, 6);
	
		// 고객명
		if( Str_Cmp(stMudData.CUST_NM, stMudData_ORI.CUST_NM) != 0 )
		{
			return 1;
		}
		// 성별
		else if( Str_Cmp(stMudData.GENDER, stMudData_ORI.GENDER) != 0 )
		{
			return 1;
		}
		// 생년월일
		else if( Str_Cmp(szBefore_SocNum , szAfter_SocNUm) != 0 )
		{
			return 1;
		}

		return 0;
	}
	
	/*=======================================================================================
	함수명 : setCardMove
	기  능 : 카드 MOVE
	Param  : 
	Return :
	========================================================================================*/	
	void setCardMove(void)
	{
		// 전입신규
		if( g_lMobile_Inflow_Path == 0 )
		{
			Card_Move("C6101_LST");
		}
		// 민원 정보_신규
		else if( g_lMobile_Inflow_Path == 1 )
		{
			Card_Move("C6101_WINFO");
		}
		// 안전점검
		else if( g_lMobile_Inflow_Path == 2 )
		{
			Card_Move("SC_CONFIRM");
		}
		// 검침
		else if( g_lMobile_Inflow_Path == 3 )
		{
			Card_Move("GM_CUSTINFO");
		}
		// 계량기
		else if( g_lMobile_Inflow_Path == 4 )
		{
			Card_Move("C6301_CUSTINFO");
		}
		// 민원 정보_유지
		else if( g_lMobile_Inflow_Path == 5 )
		{
			Card_Move("C6101_WINFO");
		}
		// 기타
		else
		{
			Card_Move("CM_MENU");
		}
	}
	
	/*=======================================================================================
	함수명 : Validation_Custinfo
	기  능 : 고객정보 Validation
	Param  : 
	Return :
	========================================================================================*/	
	bool Validation_Custinfo(void)
	{
		long chk_1 = 0;
		long chk_2 = 0;
		
		// 고객명
		if( Str_Cmp( stMudData.CUST_NM, "" )  == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "고객명을 입력하세요.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// 생년월일
		if( Str_Len( stMudData.SOC_NUM ) != 6 )
		{
			MessageBoxEx(CONFIRM_OK, "생년월일을 입력하세요.\n( EX : 991231 )");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// 남, 여
		if( Str_Cmp( stMudData.GENDER, "" )  == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "성별을 선택하세요.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// 핸드폰 or 전화
		chk_1 = 0;
		chk_2 = 0;
		
		chk_1 += Str_Len( stMudData.CP_DDD );
		chk_1 += Str_Len( stMudData.CP_EXN );
		chk_1 += Str_Len( stMudData.CP_NUM );
		
		chk_2 += Str_Len( stMudData.OWNHOUSE_TEL_DDD );
		chk_2 += Str_Len( stMudData.OWNHOUSE_TEL_EXN );
		chk_2 += Str_Len( stMudData.OWNHOUSE_TEL_NUM );
		
		if( chk_1 < 0 && chk_2 < 0 )
		{
			MessageBoxEx(CONFIRM_OK, "핸드폰 혹은 전화번호를 입력하세요.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// 핸드폰
		if( chk_1 > 0 )
		{
			if( Str_Len( stMudData.CP_DDD ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_1을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_2을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_3을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// 전화
		if( chk_2 > 0 )
		{
			if( Str_Len( stMudData.OWNHOUSE_TEL_DDD ) < 2 )
			{
				MessageBoxEx(CONFIRM_OK, "전화번호_1을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
			
				return FALSE;
			}
			
			if( Str_Len( stMudData.OWNHOUSE_TEL_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "전화번호_2을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.OWNHOUSE_TEL_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "전화번호_3을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// 이메일
		chk_1 = 0;
		chk_2 = 0;
		
		chk_1 += Str_Len( stMudData.EMAIL_REQ_ID );
		chk_2 += Str_Len( stMudData.EMAIL_REQ_ADDR );
		
		if( chk_1 + chk_2 > 0 )
		{
			if( Str_Len( stMudData.EMAIL_REQ_ID ) <= 0 || Str_Len( stMudData.EMAIL_REQ_ADDR ) <= 0 )
			{
				MessageBoxEx(CONFIRM_OK, "이메일을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// 요금청구방법
		if( Str_Cmp( stMudData.BILING_METHOD, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "요금청구방법을 선택하세요.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
				
			return FALSE;
		}
		
		// 이메일 청구
		if( Str_Cmp( stMudData.BILING_METHOD, "40" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "14" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "48" ) == 0)
		{
			if( Str_Len( stMudData.EMAIL_REQ_ID ) <= 0 || Str_Len( stMudData.EMAIL_REQ_ADDR ) <= 0 )
			{
				MessageBoxEx(CONFIRM_OK, "이메일을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// LMS 청구
		if( Str_Cmp( stMudData.BILING_METHOD, "70" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "17" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "78" ) == 0 )
		{
			if( Str_Len( stMudData.CP_DDD ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_1을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_2을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_3을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}

		//20220216 이중고지로 인한 청구서 발송방법 Validate
		if( Str_Cmp( stMudData.BILING_METHOD, "47" ) == 0)
		{
			if( Str_Len( stMudData.EMAIL_REQ_ID ) <= 0 || Str_Len( stMudData.EMAIL_REQ_ADDR ) <= 0 )
			{
				MessageBoxEx(CONFIRM_OK, "이메일을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			if( Str_Len( stMudData.CP_DDD ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_1을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_2을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "핸드폰번호_3을 확인하세요.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		// 납부방법
		if( Str_Cmp( stMudData.PAYMENT_METHOD, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "납부방법을 선택하세요.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
				
			return FALSE;
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Validation_Agree
	기  능 : 개인정보 활용 동의서 Validation
	Param  : 
	Return :
	========================================================================================*/	
	bool Validation_Agree(void)
	{
		if( m_lAgreeChk_Ok_Validation == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "동의서 동의 여부를 체크해 주세요");
			
			ON_EXIT();
			OnInit(INIT_FIRST_AGREE);
			
			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_AGREE_YN, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "개인정보 수집 및 이용 동의\n동의/미동의를 선택해주세요.");

			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}

			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_AGREE_YN, "Y" ) != 0 )
		{
			MessageBoxEx(CONFIRM_OK, "개인정보 수집 및 이용 동의는\n[동의]만 가능합니다.");

			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}

			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_YN, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "개인(신용)정보 제공 동의\n동의/미동의를 선택해주세요.");
			
			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}
			
			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_YN, "Y" ) != 0 )
		{
			MessageBoxEx(CONFIRM_OK, "개인(신용)정보 제공 동의는\n[동의]만 가능합니다.");
			
			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}
			
			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_YN4, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "개인(신용)정보 조회\n동의/미동의를 선택해주세요.");
			
			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}
			
			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_YN5, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "고유식별정보 제공 및 제공받는 동의\n동의/미동의를 선택해주세요.");
			
			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}
			
			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_YN6, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "마케팅 수신 및 개인정보 활용 동의\n동의/미동의를 선택해주세요.");
			
			if( m_lAgreeChk_Ok == 0 )
			{
				ON_EXIT();
				OnInit(INIT_FIRST_AGREE);
			}
			else
			{
				ON_EXIT();
				OnInit(INIT_AGREE);
			}
			
			return FALSE;
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Validation_PayMethod
	기  능 : 납부방법 Validation
	Param  : flag : 0 = 확인버튼_CHK X, 1= 확인버튼_CHK O
	Return :
	========================================================================================*/	
	bool Validation_PayMethod( long flag )
	{
		if( g_lMobile_Use_Doc_Type != 2 && m_lBackAutoTrans != 0 )
		{
			if( Str_Cmp( stMudData.PAYMENT_METHOD, "10" ) != 0 )
			{
				if( Str_Cmp( stMudData.BNK_CD, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "은행/카드종류를 고르세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
				
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.DEFRAY_ACCOUNT_NUM, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "계좌/카드번호를 입력하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.DEPOSITOR_NM, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "예금주명을 입력하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_TEL_DDD ) < 2 )
				{
					MessageBoxEx(CONFIRM_OK, "예금주 전화번호_1를 확인하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_TEL_EXN ) < 3 )
				{
					MessageBoxEx(CONFIRM_OK, "예금주 전화번호_2를 확인하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_TEL_NUM ) < 4 )
				{
					MessageBoxEx(CONFIRM_OK, "예금주 전화번호_3을 확인하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_BIRTH_DATE ) < 6 )
				{
					MessageBoxEx(CONFIRM_OK, "예금주 생년월일( EX : 991231 )\n 혹은 사업자번호를 확인하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.DEPOSITOR_RELAT_CD, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "예금주와 관계를 선택하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.REQ_NM, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "대리인명을 입력하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}	
				
				if( Str_Len( stMudData.REQ_TEL_DDD ) < 2 )
				{
					MessageBoxEx(CONFIRM_OK, "대리인 전화번호_1를 확인하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.REQ_TEL_EXN ) < 3 )
				{
					MessageBoxEx(CONFIRM_OK, "대리인 전화번호_2를 확인하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.REQ_TEL_NUM ) < 4 )
				{
					MessageBoxEx(CONFIRM_OK, "대리인 전화번호_3을 확인하세요.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
			}
		}
		
		if( flag == 1 )
		{
			if( m_lPayMethod_Chk == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "납부방법의 확인버튼을 눌러주세요.");
				
				ON_EXIT();
				OnInit(INIT_AUTOTRANS);
						
				return FALSE;
			}
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : SetTitle
	기  능 : Title Setting
	Param  : 
	Return :
	========================================================================================*/	
	void SetTitle(void)
	{
		Mem_Set((byte*)m_szTitle, 0x00, sizeof(m_szTitle));
		
		// 계약서 타입 : 1 = 전입신규, 2 = 명의유지, 3 = 명의병경, 4 = 신규
		if( g_lMobile_Use_Doc_Type == 1 )
		{
			Str_Cpy( m_szTitle, "[전입] 도시가스 사용신청(계약)서" );
		}
		else if( g_lMobile_Use_Doc_Type == 2 )
		{
			Str_Cpy( m_szTitle, "[명.유] 도시가스 사용신청(계약)서" );
		}
		else if( g_lMobile_Use_Doc_Type == 3 )
		{
			Str_Cpy( m_szTitle, "[명.변] 도시가스 사용신청(계약)서" );
		}
		else if ( g_lMobile_Use_Doc_Type == 4 )
		{
			Str_Cpy( m_szTitle, "[신규] 도시가스 사용신청(계약)서" );
		}
	}
}
