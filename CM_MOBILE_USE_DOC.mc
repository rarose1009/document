/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MOBILE_USE_DOC
	Card Desc : ����� ����༭
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
		/*  ����                        */
		/********************************/
		DEF_BUTTON_ID ( BID_CLOSE )					// ����_CLOSE
		
		/********************************/
		/* ��                          */
		/********************************/
		DEF_BUTTON_ID ( BID_TAB_CUST_INFO )			// ��_������
		DEF_BUTTON_ID ( BID_TAB_PAY_METHOD )		// ��_���ι��
		DEF_BUTTON_ID ( BID_TAB_AGREE )				// ��_�������� Ȱ�� ���Ǽ�
		DEF_BUTTON_ID ( BID_TAB_SIGN )				// ��_Ȯ��
		
		/********************************/
		/* ������                     */
		/********************************/
		DEF_BUTTON_ID ( BID_CI_ADDR )				// ������_�ּ�
		
		DEF_BUTTON_ID ( BID_CI_CHKBOX_GENDER_MAN )	// ������_üũ�ڽ�_����_Y
		DEF_BUTTON_ID ( BID_CI_CHKBOX_GENDER_GIRL )	// ������_üũ�ڽ�_����_N
		
		DEF_BUTTON_ID ( BID_CI_CHKBOX_TXBILL_Y )	// ������_üũ�ڽ�_���ݰ�꼭_Y
		DEF_BUTTON_ID ( BID_CI_CHKBOX_TXBILL_N )	// ������_üũ�ڽ�_���ݰ�꼭_N
		
		DEF_BUTTON_ID ( BID_CI_CUST_NM )			// ������_����
		DEF_BUTTON_ID ( BID_CI_EMAIL )				// ������_�̸���
		DEF_BUTTON_ID ( BID_CI_FRIM )				// ������_��ȣ
		
		/********************************/
		/* �������� Ȱ�� ù��° ���Ǽ�  */
		/********************************/	
		DEF_BUTTON_ID ( BID_FAG_AGREE_CHK_OK )		// ���Ǽ�_���Ǽ�Ȯ��
		
		/********************************/
		/* �������� Ȱ�� ���Ǽ�         */
		/********************************/	
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_1_Y )	// ���Ǽ�_üũ�ڽ�_����_1_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_1_N )	// ���Ǽ�_üũ�ڽ�_����_1_N
		DEF_BUTTON_ID ( BID_AG_AGREE_1_DETAIL )		// ���Ǽ�_����_1_��
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_2_Y )	// ���Ǽ�_üũ�ڽ�_����_2_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_2_N )	// ���Ǽ�_üũ�ڽ�_����_2_N
		DEF_BUTTON_ID ( BID_AG_AGREE_2_DETAIL )		// ���Ǽ�_����_2_��
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_3_Y )	// ���Ǽ�_üũ�ڽ�_����_3_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_3_N )	// ���Ǽ�_üũ�ڽ�_����_3_N
		DEF_BUTTON_ID ( BID_AG_AGREE_3_DETAIL )		// ���Ǽ�_����_3_��
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_4_Y )	// ���Ǽ�_üũ�ڽ�_����_4_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_4_N )	// ���Ǽ�_üũ�ڽ�_����_4_N
		DEF_BUTTON_ID ( BID_AG_AGREE_4_DETAIL )		// ���Ǽ�_����_4_��
		
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_5_Y )	// ���Ǽ�_üũ�ڽ�_����_5_Y
		DEF_BUTTON_ID ( BID_AG_CHKBOX_AGREE_5_N )	// ���Ǽ�_üũ�ڽ�_����_5_N
		DEF_BUTTON_ID ( BID_AG_AGREE_5_DETAIL )		// ���Ǽ�_����_5_��
		
		DEF_BUTTON_ID ( BID_AG_ALL_AGREE )			// ���Ǽ�_��ü����
		
		/********************************/
		/* ���ǳ���_1                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_1_NEXT )				// ���ǳ���_1_ȭ��_NEXT
		DEF_BUTTON_ID ( BID_AV_1_CLOSE )			// ���ǳ���_1_ȭ��_CLOSE
		
		/********************************/
		/* ���ǳ���_2                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_2_NEXT )				// ���ǳ���_2_ȭ��_NEXT
		DEF_BUTTON_ID ( BID_AV_2_CLOSE )			// ���ǳ���_2_ȭ��_CLOSE
		
		/********************************/
		/* ���ǳ���_3                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_3_NEXT )				// ���ǳ���_3_ȭ��_NEXT
		DEF_BUTTON_ID ( BID_AV_3_CLOSE )			// ���ǳ���_3_ȭ��_CLOSE
		
		/********************************/
		/* ���ǳ���_4                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_4_NEXT )				// ���ǳ���_4_ȭ��_NEXT
		DEF_BUTTON_ID ( BID_AV_4_CLOSE )			// ���ǳ���_4_ȭ��_CLOSE
		
		/********************************/
		/* ���ǳ���_5                   */
		/********************************/
		DEF_BUTTON_ID ( BID_AV_5_NEXT )				// ���ǳ���_5_ȭ��_NEXT
		DEF_BUTTON_ID ( BID_AV_5_CLOSE )			// ���ǳ���_5_ȭ��_CLOSE
		
		/********************************/
		/* �ڵ���ü                     */
		/********************************/
		DEF_BUTTON_ID ( BID_AT_BACK )				// �ڵ���ü_BACK(�ǵ�����)
		DEF_BUTTON_ID ( BID_AT_INIT )				// �ڵ���ü_INIT(�ʱ�ȭ)
		DEF_BUTTON_ID ( BID_AT_SAVE )				// �ڵ���ü_SAVE
		
		DEF_BUTTON_ID ( BID_AT_DEP_NM )				// �ڵ���ü_�����ָ�
		DEF_BUTTON_ID ( BID_AT_ALT_NM )				// �ڵ���ü_�븮�θ�
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )					// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )				// ������
		
		/********************************/
		/* ������                     */
		/********************************/
		DEF_OBJECT_ID ( ST_CI_MTR_ID_NUM )			// ST_������_�⹰��ȣ
		DEF_OBJECT_ID ( TXT_CI_MTR_ID_NUM )			// TXT_������_�⹰��ȣ
		DEF_OBJECT_ID ( TXT_CI_ADDR )				// TXT_������_�ּ�
		DEF_OBJECT_ID ( ST_CI_CUST_NM )				// ST_������_����
		DEF_OBJECT_ID ( ST_CI_BRITH_YMD )			// ST_������_���Ͽ���
		DEF_OBJECT_ID ( ST_CI_HP_1 )				// ST_������_�޴�����ȣ
		DEF_OBJECT_ID ( TXT_CI_HP_2 )				// TXT_������_�޴�����ȣ_-
		DEF_OBJECT_ID ( TXT_CI_HP_3 )				// TXT_������_�޴�����ȣ_-
		DEF_OBJECT_ID ( ST_CI_TEL_1 )				// ST_������_���ù�ȣ
		DEF_OBJECT_ID ( TXT_CI_TEL_2 )				// TXT_������_���ù�ȣ_-
		DEF_OBJECT_ID ( TXT_CI_TEL_3 )				// TXT_������_���ù�ȣ_-
		DEF_OBJECT_ID ( ST_CI_EMAIL_1 )				// ST_������_�̸���
		DEF_OBJECT_ID ( TXT_CI_EMAIL_2 )			// TXT_������_�̸���_@
		DEF_OBJECT_ID ( ST_CI_FIRM )				// ST_������_��ȣ
		DEF_OBJECT_ID ( ST_CI_TXBILL )				// ST_������_���ݰ�꼭
		DEF_OBJECT_ID ( ST_CI_BIZREGNUM )			// ST_������_����ڵ�Ϲ�ȣ
		DEF_OBJECT_ID ( ST_CI_BILL_SEND_METHOD )	// ST_������_���û�����
		
		/********************************/
		/* �������� Ȱ��  ù��° ���Ǽ� */
		/********************************/
		DEF_OBJECT_ID ( TXT_FAG_AGREE )				// TXT_���Ǽ�_���Ǽ�
		
		/********************************/
		/* �������� Ȱ�� ���Ǽ�         */
		/********************************/
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_1 )		// ST_���Ǽ�_���Ǽ�1
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_2 )		// ST_���Ǽ�_���Ǽ�2
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_3 )		// ST_���Ǽ�_���Ǽ�3
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_4 )		// ST_���Ǽ�_���Ǽ�4
		DEF_OBJECT_ID ( ST_AG_AGREE_TITLE_5 )		// ST_���Ǽ�_���Ǽ�5
		
		/********************************/
		/* ���ǳ���_1                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_1_1 )					// ST_���ǳ���_1_1
		DEF_OBJECT_ID ( TXT_AV_1_1 )				// TXT_���ǳ���_1_1
		
		DEF_OBJECT_ID ( ST_AV_1_2 )					// ST_���ǳ���_1_2
		DEF_OBJECT_ID ( TXT_AV_1_2 )				// TXT_���ǳ���_1_2
		
		DEF_OBJECT_ID ( ST_AV_1_3 )					// ST_���ǳ���_1_3
		DEF_OBJECT_ID ( TXT_AV_1_3 )				// TXT_���ǳ���_1_3
		
		/********************************/
		/* ���ǳ���_2                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_2_1 )					// ST_���ǳ���_2_1
		DEF_OBJECT_ID ( TXT_AV_2_1 )				// TXT_���ǳ���_2_1
		
		DEF_OBJECT_ID ( ST_AV_2_2 )					// ST_���ǳ���_2_2
		DEF_OBJECT_ID ( TXT_AV_2_2 )				// TXT_���ǳ���_2_2
		
		DEF_OBJECT_ID ( ST_AV_2_3 )					// ST_���ǳ���_2_3
		DEF_OBJECT_ID ( TXT_AV_2_3 )				// TXT_���ǳ���_2_3
		
		DEF_OBJECT_ID ( ST_AV_2_4 )					// ST_���ǳ���_2_4
		DEF_OBJECT_ID ( TXT_AV_2_4 )				// TXT_���ǳ���_2_4
		
		DEF_OBJECT_ID ( TXT_AV_2_5 )				// TXT_���ǳ���_2_5
		
		/********************************/
		/* ���ǳ���_3                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_3_1 )					// ST_���ǳ���_3_1
		DEF_OBJECT_ID ( TXT_AV_3_1 )				// TXT_���ǳ���_3_1
		
		DEF_OBJECT_ID ( ST_AV_3_2 )					// ST_���ǳ���_3_2
		DEF_OBJECT_ID ( TXT_AV_3_2 )				// TXT_���ǳ���_3_2
		
		DEF_OBJECT_ID ( ST_AV_3_3 )					// ST_���ǳ���_3_3
		DEF_OBJECT_ID ( TXT_AV_3_3 )				// TXT_���ǳ���_3_3
		
		DEF_OBJECT_ID ( ST_AV_3_4 )					// ST_���ǳ���_3_4
		DEF_OBJECT_ID ( TXT_AV_3_4 )				// TXT_���ǳ���_3_4
		
		DEF_OBJECT_ID ( TXT_AV_3_5 )				// TXT_���ǳ���_3_5
		
		/********************************/
		/* ���ǳ���_4                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_4_1 )					// ST_���ǳ���_4_1
		DEF_OBJECT_ID ( TXT_AV_4_1_1 )				// TXT_���ǳ���_4_1_1
		DEF_OBJECT_ID ( TXT_AV_4_1_2 )				// TXT_���ǳ���_4_1_2
		
		DEF_OBJECT_ID ( ST_AV_4_2 )					// ST_���ǳ���_4_2
		DEF_OBJECT_ID ( TXT_AV_4_2_1 )				// TXT_���ǳ���_4_2_1
		DEF_OBJECT_ID ( TXT_AV_4_2_2 )				// TXT_���ǳ���_4_2_2
		
		DEF_OBJECT_ID ( ST_AV_4_3 )					// ST_���ǳ���_4_3
		DEF_OBJECT_ID ( TXT_AV_4_3 )				// TXT_���ǳ���_4_3
		
		DEF_OBJECT_ID ( ST_AV_4_4 )					// ST_���ǳ���_4_4
		DEF_OBJECT_ID ( TXT_AV_4_4 )				// TXT_���ǳ���_4_4
		
		DEF_OBJECT_ID ( ST_AV_4_5 )					// ST_���ǳ���_4_5
		DEF_OBJECT_ID ( TXT_AV_4_5 )				// TXT_���ǳ���_4_5
		
		DEF_OBJECT_ID ( TXT_AV_4_6 )				// TXT_���ǳ���_4_6
		
		/********************************/
		/* ���ǳ���_5                   */
		/********************************/
		DEF_OBJECT_ID ( ST_AV_5_1 )					// ST_���ǳ���_5_1
		DEF_OBJECT_ID ( TXT_AV_5_1 )				// TXT_���ǳ���_5_1
		
		DEF_OBJECT_ID ( ST_AV_5_2 )					// ST_���ǳ���_5_2
		DEF_OBJECT_ID ( TXT_AV_5_2 )				// TXT_���ǳ���_5_2
		
		DEF_OBJECT_ID ( ST_AV_5_3 )					// ST_���ǳ���_5_3
		DEF_OBJECT_ID ( TXT_AV_5_3 )				// TXT_���ǳ���_5_3
		
		DEF_OBJECT_ID ( TXT_AV_5_4 )				// TXT_���ǳ���_5_5
		
		/********************************/
		/* �ڵ���ü                     */
		/********************************/
		DEF_OBJECT_ID ( ST_AT_BANK )				// ST_�ڵ���ü_����
		DEF_OBJECT_ID ( ST_AT_DEP_NM )				// ST_�ڵ���ü_������_��
		DEF_OBJECT_ID ( ST_AT_DEP_TEL_1 )			// ST_�ڵ���ü_������_TEL
		DEF_OBJECT_ID ( TXT_AT_DEP_TEL_2 )			// TXT_�ڵ���ü_������_TEL_-
		DEF_OBJECT_ID ( TXT_AT_DEP_TEL_3 )			// TXT_�ڵ���ü_������_TEL_-
		DEF_OBJECT_ID ( ST_AT_ACCOUNT )				// ST_�ڵ���ü_���¹�ȣ
		DEF_OBJECT_ID ( ST_AT_DEP_BRITHDAY )		// ST_�ڵ���ü_�������
		
		DEF_OBJECT_ID ( ST_AT_DEP_RELAT )			// ST_�ڵ���ü_������_����
		DEF_OBJECT_ID ( ST_AT_ALT_NM )				// ST_�ڵ���ü_�븮��_��
		DEF_OBJECT_ID ( ST_AT_ALT_TEL_1 )			// ST_�ڵ���ü_�븮��_TEL
		DEF_OBJECT_ID ( TXT_AT_ALT_TEL_2 )			// TXT_�ڵ���ü_�븮��_TEL_-
		DEF_OBJECT_ID ( TXT_AT_ALT_TEL_3 )			// TXT_�ڵ���ü_�븮��_TEL_-
		
		DEF_OBJECT_ID ( ST_AT_PAY_METHOD )			// ST_�ڵ���ü_���ι�ȣ
		
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA_1 )				// ����_1
		DEF_OBJECT_ID ( LINE_DATA_2 )				// ����_2
		DEF_OBJECT_ID ( LINE_DATA_3 )				// ����_3
		DEF_OBJECT_ID ( LINE_DATA_4 )				// ����_4
		DEF_OBJECT_ID ( LINE_DATA_5 )				// ����_5
		DEF_OBJECT_ID ( LINE_DATA_6 )				// ����_6
		DEF_OBJECT_ID ( LINE_DATA_7 )				// ����_7
		
		/********************************/
		/* ��������_1                   */
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
		/* ��������_2                   */
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
		// 1. ������
		DEF_OBJECT_ID ( EDT_CI_CUST_NM )			// EDT_������_����
		DEF_OBJECT_ID ( EDT_CI_BRITH_YMD )			// EDT_������_���Ͽ���			
		DEF_OBJECT_ID ( EDT_CI_HP_EXN )				// EDT_������_�޴�����ȣ
		DEF_OBJECT_ID ( EDT_CI_HP_NUM )				// EDT_������_�޴�����ȣ
		DEF_OBJECT_ID ( EDT_CI_TEL_EXN )			// EDT_������_���ù�ȣ
		DEF_OBJECT_ID ( EDT_CI_TEL_NUM )			// EDT_������_���ù�ȣ
		DEF_OBJECT_ID ( EDT_CI_EMAIL )				// EDT_������_�̸���
		DEF_OBJECT_ID ( EDT_CI_FRIM )				// EDT_������_��ȣ
		DEF_OBJECT_ID ( EDT_CI_BIZ_REG_NUM )	    // EDT_������_����ڵ�Ϲ�ȣ
		
		// 2. �ڵ���ü
		DEF_OBJECT_ID ( EDT_AT_DEP_NM )				// EDT_�ڵ���ü_������_��
		DEF_OBJECT_ID ( EDT_AT_ACCOUNT )			// EDT_�ڵ���ü_���¹�ȣ
		DEF_OBJECT_ID ( EDT_AT_DEP_BRITHDAY )		// EDT_�ڵ���ü_�������
		DEF_OBJECT_ID ( EDT_AT_DEP_TEL_EXN )		// EDT_�ڵ���ü_TEL_EXN
		DEF_OBJECT_ID ( EDT_AT_DEP_TEL_NUM )		// EDT_�ڵ���ü_TEL_NUM
		DEF_OBJECT_ID ( EDT_AT_ALT_NM )				// EDT_�ڵ���ü_�븮��_��
		DEF_OBJECT_ID ( EDT_AT_ALT_TEL_EXN )		// EDT_�ڵ���ü_�븮��_��ȭ��ȣ_EXN
		DEF_OBJECT_ID ( EDT_AT_ALT_TEL_NUM )		// EDT_�ڵ���ü_�븮��_��ȭ��ȣ_NUM
		
		/********************************/
		/* COMBO                        */
		/********************************/
		// 1. ������
		DEF_OBJECT_ID ( CMB_CI_HP_DDD )										// COMBO_������_HP_DDD
		DEF_OBJECT_ID ( CMB_CI_TEL_DDD = CMB_CI_HP_DDD + 3 )				// COMBO_������_TEL_DDD
		DEF_OBJECT_ID ( CMB_CI_EMAIL = CMB_CI_TEL_DDD + 3 )					// COMBO_������_EMAIL
		DEF_OBJECT_ID ( CMB_CI_BILL_SEND_METHOD = CMB_CI_EMAIL + 3 )		// COMBO_������_���û�����
			
		// 2. �ڵ���ü
		DEF_OBJECT_ID ( CMB_AT_PAY_METHOD = CMB_CI_BILL_SEND_METHOD + 3 )	// COMBO_�ڵ���ü_���ι��
		DEF_OBJECT_ID ( CMB_AT_BANK = CMB_AT_PAY_METHOD + 3 )				// COMBO_�ڵ���ü_����
		DEF_OBJECT_ID ( CMB_AT_DEP_TEL_DDD = CMB_AT_BANK + 3 )				// COMBO_�ڵ���ü_������_TEL_DDD
		DEF_OBJECT_ID ( CMB_AT_DEP_RELAT = CMB_AT_DEP_TEL_DDD + 3 )			// COMBO_�ڵ���ü_������_����
		DEF_OBJECT_ID ( CMB_AT_ALT_TEL_DDD = CMB_AT_DEP_RELAT + 3 )			// COMBO_�ڵ���ü_�븮��_TEL_DDD
		
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_CUSTINFO		1		// ������
	#define INIT_FIRST_AGREE	2		// �������� Ȱ�� ù��° ���Ǽ�
	#define INIT_AGREE			3		// �������� Ȱ�� ���Ǽ�
	#define INIT_AGREEVIEW_1	4		// ���ǳ���_1
	#define INIT_AGREEVIEW_2	5		// ���ǳ���_2
	#define INIT_AGREEVIEW_3	6		// ���ǳ���_3
	#define INIT_AGREEVIEW_4	7		// ���ǳ���_4
	#define INIT_AGREEVIEW_5	8		// ���ǳ���_5
	#define INIT_AUTOTRANS  	9		// �ڵ���ü
	
	// ���� üũ�ڽ�
	#define CHKBOX_MAN_N				"�� ��"
	#define CHKBOX_MAN_Y				"�� ��"
	#define CHKBOX_GIRL_N				"�� ��"
	#define CHKBOX_GIRL_Y				"�� ��"
	
	// ���ݰ�꼭 ���࿩��
	#define CHKBOX_TXBILL_PUBL_N		"���� ��"
	#define CHKBOX_TXBILL_PUBL_Y		"���� ��"
	#define CHKBOX_TXBILL_NON_PUBL_N	"�ش���� ��"
	#define CHKBOX_TXBILL_NON_PUBL_Y	"�ش���� ��"
	
	// �������� ���� �� �̿� ����[�ʼ�]
	#define CHKBOX_AGREE_1_N			"���� ��"
	#define CHKBOX_AGREE_1_Y			"���� ��"
	#define CHKBOX_NON_AGREE_1_N		"�̵��� ��"
	#define CHKBOX_NON_AGREE_1_Y		"�̵��� ��"
	
	// ����(�ſ�)���� ���� ����[�ʼ�]
	#define CHKBOX_AGREE_2_N			"���� ��"
	#define CHKBOX_AGREE_2_Y			"���� ��"
	#define CHKBOX_NON_AGREE_2_N		"�̵��� ��"
	#define CHKBOX_NON_AGREE_2_Y		"�̵��� ��"
	
	// ����(�ſ�)���� ��ȸ ����[����]
	#define CHKBOX_AGREE_3_N			"���� ��"
	#define CHKBOX_AGREE_3_Y			"���� ��"
	#define CHKBOX_NON_AGREE_3_N		"�̵��� ��"
	#define CHKBOX_NON_AGREE_3_Y		"�̵��� ��"
	
	// �����ĺ����� ���� �� �����޴� ����[����]
	#define CHKBOX_AGREE_4_N			"���� ��"
	#define CHKBOX_AGREE_4_Y			"���� ��"
	#define CHKBOX_NON_AGREE_4_N		"�̵��� ��"
	#define CHKBOX_NON_AGREE_4_Y		"�̵��� ��"
	
	// ������ ���� �� �������� Ȱ�� ����[����]
	#define CHKBOX_AGREE_5_N			"���� ��"
	#define CHKBOX_AGREE_5_Y			"���� ��"
	#define CHKBOX_NON_AGREE_5_N		"�̵��� ��"
	#define CHKBOX_NON_AGREE_5_Y		"�̵��� ��"
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_bFirst;						// ȭ�� Index
	long m_lActiveIndex;				// ���� ��ġ�� Index
	long m_lAgreeChk_Ok = 0;			// ���Ǽ� ȭ�� ���� Ȯ�� ��ư_ȯ�� ��ȯ ����, 0 = ������ ����, 1 = ����
	long m_lAgreeChk_Ok_Validation = 0; // ���Ǽ� ȭ�� ���� Ȯ�� ��ư_Validation�� �ʿ�, 0 = ������ ����, 1 = ����
	long m_lAllAgree = 0;				// ��ü���� ��ư �������� ���� : 0 = �ȴ���, 1 = ����
	long m_lAddr_Chg = 1;    			// ��ȸ �ּ� ���� flag : 0 = ����, 1 = ���θ�
	long m_lDlgflag = 0;				// Ű���� flag
	long m_lBackAutoTrans = 0;			// �ڵ���ü �ǵ����� flag : 0 = �ǵ����� ����, 1 = �ʱ�ȭ ����(������ ����)
	long m_lPayMethod_Chk = 0;			// ���ι�� Ȯ�� ���� : 0 = ��Ȯ��, 1 = Ȯ��
	char m_szTitle[50];         		// Ÿ��Ʋ	
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
	// ������ ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CustInfo[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, "" ),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* �� ********/
		DLG_BUTTON(STARTX  +12, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_CUST_INFO, "������"),
		DLG_BUTTON(STARTX +256, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_PAY_METHOD, "���ι��"),
		DLG_BUTTON(STARTX +500, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_AGREE, "���Ǽ�"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "����"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,      DARKSLATEBLUE, 10, LINE_DATA_1),
		
		/******* ������ *******/
		DLG_TEXT ( STARTX,      STARTY  +66,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_MTR_ID_NUM, "�⹰��ȣ"),
		DLG_TEXT ( STARTX +220, STARTY  +66,  780,  66,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_MTR_ID_NUM, ""),
		
		DLG_BUTTON(STARTX,	    STARTY +132,  220, 147,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CI_ADDR, "�ּ�"),
		DLG_TEXT ( STARTX +220, STARTY +132,  780, 147,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_ADDR, ""),
		
		DLG_LINE ( STARTX,      STARTY +283, 1000, STARTY +283,     DARKSLATEBLUE, 10, LINE_DATA_2),
		
		DLG_TEXT ( STARTX,      STARTY +288,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_CUST_NM, "����"),
		DLG_BUTTON(STARTX +220, STARTY +288,  780,  66,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CUST_NM,  ""),
		DLG_EDIT ( STARTX +220, STARTY +288,  780,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_CUST_NM, 10,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +354,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_BRITH_YMD, "�������"),
		DLG_EDIT ( STARTX +220, STARTY +354,  345,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_BRITH_YMD, 6,  ""),
		
		DLG_BUTTON(STARTX +565, STARTY +354,  217,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_GENDER_MAN, CHKBOX_MAN_N),  // �� üũ�ڽ�
		DLG_BUTTON(STARTX +782, STARTY +354,  218,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_GENDER_GIRL, CHKBOX_GIRL_N), // �� üũ�ڽ�
		
		DLG_TEXT ( STARTX,      STARTY +420,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_HP_1 , "�ڵ���"),
		
		DLG_COMBO (STARTX +220, STARTY +420,  290,  66, 115, 66,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_HP_DDD, 5), // �ڵ��� �޺�
		
		DLG_TEXT ( STARTX +510, STARTY +420,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_HP_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +420,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_HP_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +420,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_HP_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +420,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_HP_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +486,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CI_TEL_1, "��ȭ"),
		
		DLG_COMBO (STARTX +220, STARTY +486,  290,  66, 115, 65,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_TEL_DDD, 5), // ��ȭ �޺�
		
		DLG_TEXT ( STARTX +510, STARTY +486,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_TEL_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +486,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_TEL_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +486,   55,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_TEL_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +486,  190,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_TEL_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +552,  395,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_FIRM , "��ȣ(���θ�)"),
		DLG_BUTTON(STARTX +395, STARTY +552,  605,  66,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_FRIM,  ""),
		DLG_EDIT ( STARTX +395, STARTY +552,  605,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_FRIM, 15,  ""),
		
		DLG_LINE ( STARTX,      STARTY +622, 1000, STARTY +622,     DARKSLATEBLUE, 10, LINE_DATA_3),
		
		DLG_TEXT ( STARTX,      STARTY +627,  395,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK, ST_CI_BILL_SEND_METHOD , "���û�����"),
		DLG_COMBO (STARTX +395, STARTY +627,  605,  66, 115, 66,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_BILL_SEND_METHOD, 5), // ���û����� �޺�	
		
		DLG_TEXT ( STARTX,      STARTY +693,  220,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_EMAIL_1 , "�̸���"),
		DLG_BUTTON(STARTX +220, STARTY +693,  290,  66,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_EMAIL,  ""),
		DLG_EDIT ( STARTX +220, STARTY +693,  290,  66,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_EMAIL, 15,  ""),
		
		DLG_TEXT ( STARTX +510, STARTY +693,   70,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CI_EMAIL_2, "@"),
		
		DLG_COMBO (STARTX +580, STARTY +693,  420,  66, 115, 66,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_CI_EMAIL, 5), // �̸��� �޺�
		
		DLG_LINE ( STARTX,      STARTY +763, 1000, STARTY +763,     DARKSLATEBLUE, 10, LINE_DATA_4),
		
		DLG_TEXT ( STARTX,      STARTY +768,  370,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_TXBILL , "���ݰ�꼭"),
		DLG_BUTTON(STARTX +370, STARTY +767,  315,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_TXBILL_Y, CHKBOX_TXBILL_PUBL_N),     // ���� üũ�ڽ� 
		DLG_BUTTON(STARTX +685, STARTY +767,  315,  65,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CI_CHKBOX_TXBILL_N, CHKBOX_TXBILL_NON_PUBL_N), // �ش���� üũ�ڽ�
		
		DLG_TEXT ( STARTX,      STARTY +834,  370,  66,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_CI_BIZREGNUM , "����ڵ�Ϲ�ȣ"),
		DLG_EDIT ( STARTX +370, STARTY +834,  630,  65,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_CI_BIZ_REG_NUM, 10,  ""),
		
		// ���� ����
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
		DLG_TEXT ( 666, 		STARTY+1178,  334,  90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_DEL, "��"),
	};
	
	//---------------------------------------------------------------------------------------
	// �������� Ȱ�� ù ȭ�� ���Ǽ� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_First_Agree[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* �� ********/
		DLG_BUTTON(STARTX  +12, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_CUST_INFO, "������"),
		DLG_BUTTON(STARTX +256, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_PAY_METHOD, "���ι��"),
		DLG_BUTTON(STARTX +500, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_AGREE, "���Ǽ�"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "����"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,      DARKSLATEBLUE, 10, LINE_DATA_1),
		
		/******* ���� ���Ǽ� ********/
		DLG_TEXT ( STARTX,      STARTY  +65, 1000, 735, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_FAG_AGREE, ""),
		
		DLG_BUTTON(STARTX,	    STARTY +800, 1000,  99, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_FAG_AGREE_CHK_OK, "Ȯ ��"),
	};
	
	//---------------------------------------------------------------------------------------
	// �������� Ȱ�� ���Ǽ� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_Agree[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* �� ********/
		DLG_BUTTON(STARTX  +12, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_CUST_INFO, "������"),
		DLG_BUTTON(STARTX +256, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_PAY_METHOD, "���ι��"),
		DLG_BUTTON(STARTX +500, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_AGREE, "���Ǽ�"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "����"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,   DARKSLATEBLUE, 10, LINE_DATA_1),
		
		/******* ���Ǽ� �׸� ********/
		DLG_TEXT ( STARTX,      STARTY  +65, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_1, "�������� ���� �� �̿� ����[ �ʼ� ]"),
		DLG_BUTTON(STARTX, 		STARTY +135,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_1_Y, CHKBOX_AGREE_1_N),     // ���� üũ�ڽ� 
		DLG_BUTTON(STARTX +390,	STARTY +135,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_1_N, CHKBOX_NON_AGREE_1_N), // �ش���� üũ�ڽ�
		DLG_BUTTON(STARTX +780, STARTY +135,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_1_DETAIL, "��������"),
		
		DLG_LINE ( STARTX,      STARTY +209, 1000, STARTY +209,  DARKSLATEBLUE, 11, LINE_DATA_2),
		
		DLG_TEXT ( STARTX,      STARTY +214, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_2, "����(�ſ�)���� ���� ����[ �ʼ� ]"),
		DLG_BUTTON(STARTX, 		STARTY +284,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_2_Y, CHKBOX_AGREE_2_N),     // ���� üũ�ڽ� 
		DLG_BUTTON(STARTX +390,	STARTY +284,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_2_N, CHKBOX_NON_AGREE_2_N), // �ش���� üũ�ڽ�
		DLG_BUTTON(STARTX +780, STARTY +284,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_2_DETAIL, "��������"),
		
		DLG_LINE ( STARTX,      STARTY +358, 1000, STARTY +358,  DARKSLATEBLUE, 10, LINE_DATA_3),
		
		DLG_TEXT ( STARTX,      STARTY +363, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_3, "����(�ſ�)���� ��ȸ ����[ ���� ]"),
		DLG_BUTTON(STARTX, 		STARTY +433,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_3_Y, CHKBOX_AGREE_3_N),     // ���� üũ�ڽ� 
		DLG_BUTTON(STARTX +390,	STARTY +433,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_3_N, CHKBOX_NON_AGREE_3_N), // �ش���� üũ�ڽ�
		DLG_BUTTON(STARTX +780, STARTY +433,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_3_DETAIL, "��������"),
		
		DLG_LINE ( STARTX,      STARTY +507, 1000, STARTY +507,  DARKSLATEBLUE, 10, LINE_DATA_4),
		
		DLG_TEXT ( STARTX,      STARTY +512, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_4, "�����ĺ����� ���� �� �����޴� ����[ ���� ]"),
		DLG_BUTTON(STARTX, 		STARTY +582,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_4_Y, CHKBOX_AGREE_4_N),     // ���� üũ�ڽ� 
		DLG_BUTTON(STARTX +390,	STARTY +582,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_4_N, CHKBOX_NON_AGREE_4_N), // �ش���� üũ�ڽ�
		DLG_BUTTON(STARTX +780, STARTY +582,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_4_DETAIL, "��������"),
		
		DLG_LINE ( STARTX,      STARTY +656, 1000, STARTY +656,  DARKSLATEBLUE, 10, LINE_DATA_5),
		
		DLG_TEXT ( STARTX,      STARTY +661, 1000,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AG_AGREE_TITLE_5, "������ ���� �� �������� Ȱ�� ����[ ���� ]"),
		DLG_BUTTON(STARTX, 		STARTY +731,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_5_Y, CHKBOX_AGREE_5_N),     // ���� üũ�ڽ� 
		DLG_BUTTON(STARTX +390,	STARTY +731,  390,  70, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AG_CHKBOX_AGREE_5_N, CHKBOX_NON_AGREE_5_N), // �ش���� üũ�ڽ�
		DLG_BUTTON(STARTX +780, STARTY +731,  220,  70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_AGREE_5_DETAIL, "��������"),
		
		/******* ��ü���� *******/
		DLG_LINE ( STARTX,      STARTY +805, 1000, STARTY +805,  DARKSLATEBLUE, 10, LINE_DATA_6),
		
		DLG_BUTTON(STARTX     , STARTY +810, 1000,  89, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AG_ALL_AGREE, "�� ü �� ��"),
	};
	
	//---------------------------------------------------------------------------------------
	// �������� ���� �̿� �� ���� ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_1[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� ���� �̿� �� ���� ����[�ʼ�]       "),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_1_CLOSE, ""),
		
		/******* ���� ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_1_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  300, 400, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_1_1, "�������̿�\n�Ϸ��� ����\n������ �׸�"),
		DLG_TEXT ( STARTX +300, STARTY  -29,  700, 400, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_1_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +371,  300, 350, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_1_2, "����������\n�������̿�\n����"),
		DLG_TEXT ( STARTX +300, STARTY +371,  700, 350, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_1_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +721,  300, 179, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_1_3, "��������\n���� ��\n�̿�Ⱓ"),
		DLG_TEXT ( STARTX +300, STARTY +721,  700, 179, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_1_3, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// ����(�ſ�)���� ���� ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_2[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����(�ſ�)���� ���� ����[�ʼ�]"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_2_CLOSE, ""),
		
		/******* ���� ********/
		DLG_BUTTON(STARTX,	    STARTY  -29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_2_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_1, "����������\n���� �޴���"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +171,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_2, "�����޴� ����\n������ �׸�"),
		DLG_TEXT ( STARTX +400, STARTY +171,  600, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +371,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_3, "���������� ����\n�޴����� ����\n���� �̿� ����"),
		DLG_TEXT ( STARTX +400, STARTY +371,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +571,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_2_4, "�������� ����\n�� �̿�Ⱓ"),
		DLG_TEXT ( STARTX +400, STARTY +571,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_4, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_2_5, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// ����(�ſ�)���� ��ȸ ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_3[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����(�ſ�)���� ���� ����[����]"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_3_CLOSE, ""),
		
		/******* ���� ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_3_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_1, "�ſ���ȸ ȸ��"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +171,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_2, "��ȸ ��� ����"),
		DLG_TEXT ( STARTX +400, STARTY +171,  600, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +371,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_3, "��ȸ����"),
		DLG_TEXT ( STARTX +400, STARTY +371,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +571,  400, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_3_4, "��ȸ ������\nȿ�±Ⱓ"),
		DLG_TEXT ( STARTX +400, STARTY +571,  600, 200, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_4, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_3_5, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// �����ĺ����� ���� �� �����޴� ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_4[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�����ĺ����� ���� �� �����޴� ����[��]         "),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_4_CLOSE, ""),
		
		/******* ���� ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_4_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_1, "�����ĺ�������\n�����ϴ���"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_1_1, ""),
		DLG_TEXT ( STARTX +400, STARTY  +51,  600,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_1_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +131,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_2, "�����ĺ�������\n�����޴���"),
		DLG_TEXT ( STARTX +400, STARTY +131,  600,  80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_2_1, ""),
		DLG_TEXT ( STARTX +400, STARTY +211,  600,  80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_2_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +291,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_3, "������������\n�����ĺ�������\n�׸�"),
		DLG_TEXT ( STARTX +400, STARTY +291,  600, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +451,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_4, "�����ĺ�������\n�����޴�����\n�����ĺ�����\n�̿����"),
		DLG_TEXT ( STARTX +400, STARTY +451,  600, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_4, ""),
		
		DLG_TEXT ( STARTX,      STARTY +611,  400, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_4_5, "�����ĺ�������\n�����޴�����\n�����ĺ�����\n���� �� �̿�Ⱓ"),
		DLG_TEXT ( STARTX +400, STARTY +611,  600, 160, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_5, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_4_6, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// ������ ���� �� �������� Ȱ�� ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AgreeView_5[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ���� �� �������� Ȱ�� ����[��]     "),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_5_CLOSE, ""),
		
		/******* ���� ********/
		DLG_BUTTON(STARTX,	    STARTY - 29, 1000, 929, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AV_5_NEXT,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  400, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_5_1, "�̿��Ϸ���\n���������� �׸�"),
		DLG_TEXT ( STARTX +400, STARTY  -29,  600, 260, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_1, ""),
		
		DLG_TEXT ( STARTX,      STARTY +231,  400, 280, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_5_2, "�̿� ����"),
		DLG_TEXT ( STARTX +400, STARTY +231,  600, 280, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_2, ""),
		
		DLG_TEXT ( STARTX,      STARTY +511,  400, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_AV_5_3, "��������\n�̿�Ⱓ"),
		DLG_TEXT ( STARTX +400, STARTY +511,  600, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_3, ""),
		
		DLG_TEXT ( STARTX,      STARTY +771, 1000, 129, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AV_5_4, ""),
	};
	
	//---------------------------------------------------------------------------------------
	// �ڵ���ü ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_AutoTrans[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle ),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, "" ),
		
		/******* �� ********/
		DLG_BUTTON(STARTX  +12, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_CUST_INFO, "������"),
		DLG_BUTTON(STARTX +256, STARTY  -23,  244,  81,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, BTNMENUFRCOLOR, DARKSLATEBLUE, CALL_FUNC, "", BID_TAB_PAY_METHOD, "���ι��"),
		DLG_BUTTON(STARTX +500, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_AGREE, "���Ǽ�"),
		DLG_BUTTON(STARTX +744, STARTY  -16,  244,  74,   0,  0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_TAB_SIGN, "����"),
		
		DLG_LINE ( STARTX,      STARTY  +61, 1000, STARTY +61,      DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_TEXT ( STARTX,      STARTY  +66,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_PAY_METHOD, "���ι��"),
		DLG_COMBO (STARTX +220, STARTY  +66,  780, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_PAY_METHOD, 5), // ���ι�� �޺�
		
		DLG_LINE ( STARTX,      STARTY +140, 1000, STARTY +140,      DARKSLATEBLUE, 10, LINE_DATA_2),
		
		DLG_TEXT ( STARTX,      STARTY +145,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_BANK, ""),
		DLG_COMBO (STARTX +220, STARTY +145,  780, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_BANK, 5), // ����/ī�� �޺�
		
		DLG_TEXT ( STARTX,      STARTY +215,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_ACCOUNT, ""),
		DLG_EDIT ( STARTX +220, STARTY +215,  780, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ACCOUNT, 20,  ""),
		
		DLG_LINE ( STARTX,      STARTY +289, 1000, STARTY +289,    DARKSLATEBLUE, 10, LINE_DATA_3),
		
		DLG_TEXT ( STARTX,      STARTY +294,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_NM, "�����ָ�"),
		DLG_BUTTON(STARTX +220, STARTY +294,  780, 70,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AT_DEP_NM,  ""),
		DLG_EDIT ( STARTX +220, STARTY +294,  780, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_NM, 10,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +364,  390, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_BRITHDAY, "������ �������\n����ڹ�ȣ"),
		DLG_EDIT ( STARTX +390, STARTY +364,  610, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_BRITHDAY, 20,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +434,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_TEL_1, "������\n��ȭ��ȣ"),
		
		DLG_COMBO (STARTX +220, STARTY +434,  290, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_DEP_TEL_DDD, 5), // �ڵ��� �޺�
		
		DLG_TEXT ( STARTX +510, STARTY +434,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_DEP_TEL_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +434,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_TEL_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +434,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_DEP_TEL_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +434,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_DEP_TEL_NUM, 4,  ""),
		
		DLG_LINE ( STARTX,      STARTY +508, 1000, STARTY +508,      DARKSLATEBLUE, 10, LINE_DATA_4),
		
		DLG_TEXT ( STARTX,      STARTY +513,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_DEP_RELAT, "�����ֿ�\n����"),
		DLG_COMBO (STARTX +220, STARTY +513,  780, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_DEP_RELAT, 5), // �����ֿ� ����
		
		DLG_TEXT ( STARTX,      STARTY +583,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_ALT_NM, "�븮�θ�"),
		DLG_BUTTON(STARTX +220, STARTY +583,  780, 70,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_AT_ALT_NM,  ""),
		DLG_EDIT ( STARTX +220, STARTY +583,  780, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ALT_NM, 10,  ""),
		
		DLG_TEXT ( STARTX,      STARTY +653,  220, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AT_ALT_TEL_1, "�븮��\n��ȭ��ȣ"),
		
		DLG_COMBO (STARTX +220, STARTY +653,  290, 70, 115, 70,    TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_AT_ALT_TEL_DDD, 5), // �ڵ��� �޺�
		
		DLG_TEXT ( STARTX +510, STARTY +653,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_ALT_TEL_2, "-"),
		DLG_EDIT ( STARTX +565, STARTY +653,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ALT_TEL_EXN, 4,  ""),
		DLG_TEXT ( STARTX +755, STARTY +653,   55, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_AT_ALT_TEL_3, "-"),
		DLG_EDIT ( STARTX +810, STARTY +653,  190, 70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AT_ALT_TEL_NUM, 4,  ""),
		
		DLG_LINE ( STARTX,      STARTY +727, 1000, STARTY +727,    DARKSLATEBLUE, 10, LINE_DATA_5),
		
		DLG_BUTTON(STARTX,	    STARTY +732,  500, 83,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AT_INIT, "�ڵ���ü\n��û���/�ʱ�ȭ"),
		DLG_BUTTON(STARTX +500, STARTY +732,  500, 83,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AT_BACK, "�ǵ�����"),
		DLG_BUTTON(STARTX,      STARTY +815, 1000, 84,   0,  0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_AT_SAVE, "Ȯ ��"),
		
		// ���� ����
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
		DLG_TEXT ( 666, 		STARTY+1178,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_DEL, "��"),
		
		//���� ����_2
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
		DLG_TEXT ( 666, 		STARTY +810,  334, 90,   0,  0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNCTRLFRCOLOR_NP, BTNCTRLBKBLACK, TXT_KEY_DEL_2  , "��"),	
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
	�Լ��� : OnInit
	��  �� : ���� ����
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
			/* ������                     */
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
			/* �������� Ȱ�� ù��° ���Ǽ�  */
			/********************************/	
			case INIT_FIRST_AGREE:
				CREATE_DIALOG_OBJECT (DlgRes_First_Agree, SIZEOF(DlgRes_First_Agree));
				
				SetBtnImg();
				SetStyle();
				SetTitle();
				ReDraw();
				break;
				
			/********************************/
			/* �������� Ȱ�� ���Ǽ�         */
			/********************************/	
			case INIT_AGREE:
				CREATE_DIALOG_OBJECT (DlgRes_Agree, SIZEOF(DlgRes_Agree));
				
				SetBtnImg();
				SetStyle();
				SetTitle();
				ReDraw();
				break;
			
			/********************************/
			/* ���ǳ���_1                   */
			/********************************/
			case INIT_AGREEVIEW_1:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_1, SIZEOF(DlgRes_AgreeView_1));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* ���ǳ���_2                   */
			/********************************/	
			case INIT_AGREEVIEW_2:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_2, SIZEOF(DlgRes_AgreeView_2));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* ���ǳ���_3                   */
			/********************************/
			case INIT_AGREEVIEW_3:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_3, SIZEOF(DlgRes_AgreeView_3));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* ���ǳ���_4                   */
			/********************************/
			case INIT_AGREEVIEW_4:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_4, SIZEOF(DlgRes_AgreeView_4));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* ���ǳ���_5                   */
			/********************************/
			case INIT_AGREEVIEW_5:
				CREATE_DIALOG_OBJECT (DlgRes_AgreeView_5, SIZEOF(DlgRes_AgreeView_5));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				
				break;
			
			/********************************/
			/* �ڵ���ü                     */
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
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		char szTmp[500];
		
		switch(ID)
		{
			/******************************/
			/* ����                       */
			/******************************/
			case BID_CLOSE:
				ON_EXIT();
				Card_Move("CM_MOBILE_USE_DOC_MENU");
				break;
				
			/******************************/
			/* ��                         */
			/******************************/
			// ������
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
				
			// ���ι��
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
			
			// �������� Ȱ�� ���Ǽ�
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
			
			// ����
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
			/* ������                   */
			/******************************/
			// �ּ�
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
			
			// ����_��
			case BID_CI_CHKBOX_GENDER_MAN:
			    
			    Mem_Set( (byte*)stMudData.GENDER, 0x00, sizeof(stMudData.GENDER) );
				Str_Cpy( stMudData.GENDER, "1" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_MAN), CHKBOX_MAN_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_GIRL), CHKBOX_GIRL_N);
				
				break;
				
			// ����_��
			case BID_CI_CHKBOX_GENDER_GIRL:
				
				Mem_Set( (byte*)stMudData.GENDER, 0x00, sizeof(stMudData.GENDER) );
				Str_Cpy( stMudData.GENDER, "0" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_MAN), CHKBOX_MAN_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_GENDER_GIRL), CHKBOX_GIRL_Y);
							
			    break;
			   
			// ���ݰ�꼭_����
			case BID_CI_CHKBOX_TXBILL_Y:
				
				Mem_Set( (byte*)stMudData.TAXBILL, 0x00, sizeof(stMudData.TAXBILL) );
				Str_Cpy( stMudData.TAXBILL, "1" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_Y), CHKBOX_TXBILL_PUBL_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_N), CHKBOX_TXBILL_NON_PUBL_N);
				
			    break;
			
			// ���ݰ�꼭_�ش����
			case BID_CI_CHKBOX_TXBILL_N:
				
				Mem_Set( (byte*)stMudData.TAXBILL, 0x00, sizeof(stMudData.TAXBILL) );
				Str_Cpy( stMudData.TAXBILL, "0" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_Y), CHKBOX_TXBILL_PUBL_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_CHKBOX_TXBILL_N), CHKBOX_TXBILL_NON_PUBL_Y);
				
			    break;
			
			// ����
			case BID_CI_CUST_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_CI_CUST_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_CUST_NM)) );
				break;
			
			// �̸���
			case BID_CI_EMAIL:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_CI_EMAIL), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_EMAIL)) );
				break;
			
			// ��ȣ
			case BID_CI_FRIM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_CI_FRIM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_FRIM)) );
				break;
			
			/******************************/
			/* �������� Ȱ�� ù��°���Ǽ� */
			/******************************/
			case BID_FAG_AGREE_CHK_OK:
			    m_lAgreeChk_Ok = 1;
			    m_lAgreeChk_Ok_Validation = 1;
			    SetTab( 1 );
			    
				break;
			
			/******************************/
			/* �������� Ȱ�� ���Ǽ�       */
			/******************************/
			// �������� ���� �� �̿뵿�� ��������
			case BID_AG_AGREE_1_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_1);
				
				break;
			
			// ����(�ſ�)���� ���� ���� ��������
			case BID_AG_AGREE_2_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_2);
				
				break;
			
			// ����(�ſ�)���� ��ȸ ���� ��������	
			case BID_AG_AGREE_3_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_3);
				
				break;
			
			// �����ĺ����� ���� �� �����޴� ���� ��������
			case BID_AG_AGREE_4_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_4);
				
				break;
			
			// ������ ���� �� �������� Ȱ�뵿�� ��������
			case BID_AG_AGREE_5_DETAIL:
				m_lAllAgree = 0;
				ON_EXIT();
				OnInit(INIT_AGREEVIEW_5);
				
				break;
			
			// ��ü����
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
			
			// �������� ���� �� �̿� ����_����
			case BID_AG_CHKBOX_AGREE_1_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_AGREE_YN, 0x00, sizeof(stMudData.INFO_USE_AGREE_YN) );
				Str_Cpy( stMudData.INFO_USE_AGREE_YN, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_Y), CHKBOX_AGREE_1_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_N), CHKBOX_NON_AGREE_1_N);
				
				break;
			
			// �������� ���� �� �̿� ����_�̵���
			case BID_AG_CHKBOX_AGREE_1_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_AGREE_YN, 0x00, sizeof(stMudData.INFO_USE_AGREE_YN) );
				Str_Cpy( stMudData.INFO_USE_AGREE_YN, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_Y), CHKBOX_AGREE_1_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_1_N), CHKBOX_NON_AGREE_1_Y);
							
			    break;
			
			// ����(�ſ�)���� ���� ����_����
			case BID_AG_CHKBOX_AGREE_2_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN, 0x00, sizeof(stMudData.INFO_USE_YN) );
				Str_Cpy( stMudData.INFO_USE_YN, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_Y), CHKBOX_AGREE_2_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_N), CHKBOX_NON_AGREE_2_N);
				
				break;
			
			// ����(�ſ�)���� ���� ����_�̵���
			case BID_AG_CHKBOX_AGREE_2_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN, 0x00, sizeof(stMudData.INFO_USE_YN) );
				Str_Cpy( stMudData.INFO_USE_YN, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_Y), CHKBOX_AGREE_2_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_2_N), CHKBOX_NON_AGREE_2_Y);
							
			    break;
			
			// ����(�ſ�)���� ��ȸ ����_����
			case BID_AG_CHKBOX_AGREE_3_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN4, 0x00, sizeof(stMudData.INFO_USE_YN4) );
				Str_Cpy( stMudData.INFO_USE_YN4, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_Y), CHKBOX_AGREE_3_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_N), CHKBOX_NON_AGREE_3_N);
				
				break;
			
			// ����(�ſ�)���� ��ȸ ����_�̵���
			case BID_AG_CHKBOX_AGREE_3_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN4, 0x00, sizeof(stMudData.INFO_USE_YN4) );
				Str_Cpy( stMudData.INFO_USE_YN4, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_Y), CHKBOX_AGREE_3_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_3_N), CHKBOX_NON_AGREE_3_Y);
							
			    break;
			    
			// �����ĺ����� ���� �� �����޴� ����_����
			case BID_AG_CHKBOX_AGREE_4_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN5, 0x00, sizeof(stMudData.INFO_USE_YN5) );
				Str_Cpy( stMudData.INFO_USE_YN5, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_Y), CHKBOX_AGREE_4_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_N), CHKBOX_NON_AGREE_4_N);
				
				break;
			
			// �����ĺ����� ���� �� �����޴� ����_�̵���
			case BID_AG_CHKBOX_AGREE_4_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN5, 0x00, sizeof(stMudData.INFO_USE_YN5) );
				Str_Cpy( stMudData.INFO_USE_YN5, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_Y), CHKBOX_AGREE_4_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_4_N), CHKBOX_NON_AGREE_4_Y);
							
			    break;
			
			// ������ ���� �� �������� Ȱ�� ����_����
			case BID_AG_CHKBOX_AGREE_5_Y:
			    
			    Mem_Set( (byte*)stMudData.INFO_USE_YN6, 0x00, sizeof(stMudData.INFO_USE_YN6) );
				Str_Cpy( stMudData.INFO_USE_YN6, "Y" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_Y), CHKBOX_AGREE_5_Y);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_N), CHKBOX_NON_AGREE_5_N);
				
				break;
			
			// ������ ���� �� �������� Ȱ�� ����_�̵���
			case BID_AG_CHKBOX_AGREE_5_N:
				
				Mem_Set( (byte*)stMudData.INFO_USE_YN6, 0x00, sizeof(stMudData.INFO_USE_YN6) );
				Str_Cpy( stMudData.INFO_USE_YN6, "N" );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_Y), CHKBOX_AGREE_5_N);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_AG_CHKBOX_AGREE_5_N), CHKBOX_NON_AGREE_5_Y);
							
			    break;
			
			/******************************/
			/* ���ǳ���_1                 */
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
			/* ���ǳ���_2                 */
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
			/* ���ǳ���_3                 */
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
			/* ���ǳ���_4                 */
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
			/* ���ǳ���_5                 */
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
			/* �ڵ���ü                   */
			/******************************/	
			// �ڵ���ü ���
			case BID_AT_INIT:
				
				if( MessageBoxEx( CONFIRM_YESNO, "�ڵ���ü��\n��û���/�ʱ�ȭ �Ͻðڽ��ϱ�?" ) == MB_OK)
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
				
			// �ǵ�����
			case BID_AT_BACK:
				if( MessageBoxEx( CONFIRM_YESNO, "���� �ڵ���ü ������\n�ǵ����ڽ��ϱ�?" ) == MB_OK)
				{
					SetBackAutoTrans();
				}
				
				break;
			
			// Ȯ��
			case BID_AT_SAVE:
				
				if( m_lPayMethod_Chk == 1 )
				{
					if( MessageBoxEx( CONFIRM_YESNO, "Ȯ�� ����Ͻðڽ��ϱ�?" ) == MB_OK)
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
						
						// ����
						if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
						{
							Str_Cpy( szTmp, "1. �������� : " );
							Str_Cat( szTmp, stMudData.BNK_BRANCH_NM );
							
							Str_Cat( szTmp, "\n2. ���¹�ȣ : " );
							
							if( m_lBackAutoTrans == 0 )
							{
								Str_Cat( szTmp, stMudData.SECU_DEFRAY_ACCOUNT_NUM );
							}
							else
							{
								Str_Cat( szTmp, stMudData.DEFRAY_ACCOUNT_NUM );
							}
							
							Str_Cat( szTmp, "\n3. �����ָ� : " );
							Str_Cat( szTmp, stMudData.DEPOSITOR_NM );
							
							Str_Cat( szTmp, "\n�½��ϱ�?" );
							
							if( MessageBoxEx( CONFIRM_YESNO, szTmp ) == MB_OK)
							{
								m_lPayMethod_Chk = 1;
								ReDraw();
							}
						}
						// ī��
						else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
						{
							Str_Cpy( szTmp, "1. ī������ : " );
							Str_Cat( szTmp, stMudData.BNK_BRANCH_NM );
							
							Str_Cat( szTmp, "\n2. ī���ȣ : " );
							
							if( m_lBackAutoTrans == 0 )
							{
								Str_Cat( szTmp, stMudData.SECU_DEFRAY_ACCOUNT_NUM );
							}
							else
							{
								Str_Cat( szTmp, stMudData.DEFRAY_ACCOUNT_NUM );
							}
							
							Str_Cat( szTmp, "\n3. �����ָ� : " );
							Str_Cat( szTmp, stMudData.DEPOSITOR_NM );
							
							Str_Cat( szTmp, "\n�½��ϱ�?" );
							
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
			
			// ����
			case BID_AT_DEP_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_AT_DEP_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_NM)) );
				break;
			
			// �븮�θ�
			case BID_AT_ALT_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_AT_ALT_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_NM)) );
				break;
		}
	}	
	
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : �޺��ڽ� ����
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
		/* ������                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_HP_DDD + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CI_HP_DDD) ) );
				if( Str_Cmp(szTmp, "����") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_TEL_DDD + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CI_TEL_DDD) ) );
				if( Str_Cmp(szTmp, "����") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_TEL_DDD),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_EMAIL + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CI_EMAIL) ) );
				if( Str_Cmp(szTmp, "����") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_CI_EMAIL),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_CI_BILL_SEND_METHOD + 1) )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "����(LMS)" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "LMS+�۴�" ) == 0 
					|| Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "�̸���+LMS" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD)), "�����+LMS" ) == 0)
				{
					len = 0;
					len += Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD)) );
					len += Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_EXN)) );
					len += Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM)) );
					
					if( len >= 11)
					{
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						
						Str_Cpy( szTmp, "[ LMS��ȣ ]\n");
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
						
						Str_Cpy( szTmp, "LMS��û�� ���ؼ���\n�ڵ�����ȣ�� ��Ȯ�� �Է����ּ���." );
						MessageBoxEx (CONFIRM_OK, szTmp);
					}
				}
			}
		}
		/********************************/
		/* �ڵ���ü                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_AT_PAY_METHOD + 1) )
			{
				// �޺��ڽ� �ڵ带 ������������ ����
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
				
				// ���� ���ι���� ���� ���ι�� �ڵ�� �ٸ��� �Ʒ� ���� ����
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
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_DEP_RELAT)), "����" ) == 0 )
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
				if( Str_Cmp(szTmp, "����") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD),  "");
				}
			}
			else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_AT_ALT_TEL_DDD + 1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD) ) );
				if( Str_Cmp(szTmp, "����") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD),  "");
				}
			}
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : ���� �� Ȯ�� �� System Call
	Param  : 
	Return : 
	========================================================================================*/
	void OnTask(long nEvent, long nData)
	{
		char* szOzData;
		long nRet = 0;
			
		if( nEvent == 1 )
		{
			// MessageBoxEx (CONFIRM_OK, "������!!!!!!!!!!!! CM_MOBILE_USE_DOC");
			szOzData = (char*)System_GetResult((char*)&nRet);
			
			Rcv_OzData(szOzData);
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnPointing
	��  �� : Ű����
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
			
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		/********************************/
		/* ������                     */
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
		/* �ڵ���ü                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			if( POINTING_UP == nAction )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "����") != 0 && ( g_lMobile_Use_Doc_Type != 2 && m_lBackAutoTrans != 0 ) )
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
							// Ű���� 1
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
							// Ű���� 2
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
	�Լ��� : OnChar
	��  �� : ��ȭ��ȣ ĭ �ڵ����� �Ѿ�� ��
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		long lActiveIndex = -1;
 		char szTmp[100];
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		/********************************/
		/* ������            			*/
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
					MessageBoxEx(CONFIRM_OK, "����ȣ�� [0000]�Դϴ�.\n�´��� Ȯ�����ּ���.");
				}
			}
			else if( Get_iDlgCtrlByID(EDT_CI_TEL_NUM) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_NUM))) == 4 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_NUM)), "0000") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "����ȣ�� [0000]�Դϴ�.\n�´��� Ȯ�����ּ���.");
				}
			}
		}
		/********************************/
		/* �ڵ���ü                     */
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
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư �̹���
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		/********************************/
		/* ������                     */
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
			
			// ������
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
		/* �������� Ȱ�� ù��° ���Ǽ�*/
		/******************************/
		else if( m_bFirst == INIT_FIRST_AGREE )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FAG_AGREE), EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_FAG_AGREE), TRUE, 2, EDITSEP_NONE );	
		}
		/******************************/
		/* �������� Ȱ�� ���Ǽ�       */
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
		/* ���ǳ���_1                   */
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
		/* ���ǳ���_2                   */
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
		/* ���ǳ���_3                   */
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
		/* ���ǳ���_4                   */
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
		/* ���ǳ���_5                   */
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
		/* �ڵ���ü                     */
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
			
			// ������
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
			
			// ������2
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
	�Լ��� : SetCombo
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;
		
		/********************************/
		/* ������                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			// �ڵ���
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_HP_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_CI_HP_DDD+2), "����", 0, ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_CI_HP_DDD+2);
			
			// ��ȭ��ȣ
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_TEL_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_CI_TEL_DDD+2), "����", 0, ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' ORDER BY SORT_ORDER", CMB_CI_TEL_DDD+2);
			
			// �̸���
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_EMAIL+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_CI_EMAIL+2), "����", 0, ICON_NONE);
			for ( i = 0 ;  MC_EMAIL_ADDR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_EMAIL+2), MC_EMAIL_ADDR[i].Str, 0, ICON_NONE);
			}
			
			// û�����
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2 ) );
			for ( i = 0 ;  MUD_BILL_SEND_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CI_BILL_SEND_METHOD+2), MUD_BILL_SEND_METHOD[i].Str, 0, ICON_NONE);
			}
			//�׽�Ʈ�� ���� �߰�
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
		/* �ڵ���ü                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{
			// ���ι��
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_PAY_METHOD+2 ) );
			for ( i = 0 ;  MUD_PAY_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_AT_PAY_METHOD+2), MUD_PAY_METHOD[i].Str, 0, ICON_NONE);
			}
			
			// ����
			if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "������ü") == 0 )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_BANK+2 ) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' ORDER BY CAST(SORT_ORDER as int ) ASC", CMB_AT_BANK+2);
			}
			// ī��
			else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "ī����ü") == 0 )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_BANK+2 ) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' ORDER BY SUBSTR(ITEM_KNAME,6,10)", CMB_AT_BANK+2);
			}
			
			// ������ ��ȭ��ȣ
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD+2), "����", 0, ICON_NONE);
			for ( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// �����ֿ� ����
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT+2 ) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' ORDER BY SORT_ORDER", CMB_AT_DEP_RELAT+2);
			
			// �븮�� ��ȭ��ȣ
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD+2), "����", 0, ICON_NONE);
			for ( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetCombo_Filter
	��  �� : �޺��ڽ� Filter
	Param  : 
	Return : 
	========================================================================================*/	
	void SetCombo_Filter(void)
	{
		/********************************/
		/* �ڵ���ü                     */
		/********************************/
		if( m_bFirst == INIT_AUTOTRANS )
		{
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "����") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "" );
				
				SetViewAutoTrans(0);	
			}
			else
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "������ü") == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "��������" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "���¹�ȣ" );
				}
				else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD)), "ī����ü") == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "ī������" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "ī���ȣ" );
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
	�Լ��� : ReDraw
	��  �� : ȭ�� ���ΰ�ħ
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
		/* ������                     */
		/********************************/
		if( m_bFirst == INIT_CUSTINFO )
		{
			/******************* Enable, Disable *******************/
			// ��������
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
			
			// �⹰��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CI_MTR_ID_NUM), stMudData.MTR_ID_NUM );
			
			// �ּ�
			if( m_lAddr_Chg == 0 ) 
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_ADDR), "�� ��\n�� ��");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CI_ADDR), stMudData.CURR_ADDR_UNION );
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CI_ADDR), "���θ�\n�� ��");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CI_ADDR), stMudData.NEW_ADDR_UNION );
			}

			// ����
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_CUST_NM), stMudData.CUST_NM );
			
			// �������
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_BRITH_YMD), stMudData.SOC_NUM );
			
			// ����( 0:����, 1:���� )
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
			
			// �ڵ�����ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CI_HP_DDD), stMudData.CP_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_HP_EXN), stMudData.CP_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_HP_NUM), stMudData.CP_NUM );
			
			// ��ȭ��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CI_TEL_DDD), stMudData.OWNHOUSE_TEL_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_TEL_EXN), stMudData.OWNHOUSE_TEL_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_TEL_NUM), stMudData.OWNHOUSE_TEL_NUM );
			
			// �̸���
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_EMAIL), stMudData.EMAIL_REQ_ID );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CI_EMAIL), stMudData.EMAIL_REQ_ADDR );
			
			// ��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_FRIM), stMudData.FIRM_NM );
			 
			// ���ݰ�꼭( 0:����, 1:�ش���� )
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
			
			// ����ڵ�Ϲ�ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CI_BIZ_REG_NUM), stMudData.BIZ_REGI_NUM );
			
			// ���û�����
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
		/* �������� Ȱ�� ù��° ���Ǽ�  */
		/********************************/
		else if( m_bFirst == INIT_FIRST_AGREE )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "  ���ﵵ�ð���(��)�� ���ð��� ������ ��");
			Str_Cat( szTmp, "\n ��, ����, ���Ǻ���, �ڵ���ü, ��Ÿ( �̸���");
			Str_Cat( szTmp, "\n ���û��, ���ݰ�꼭 ���� ) ��û �� �ּ�");
			Str_Cat( szTmp, "\n ���� �ʼ� ���������� ó��( �������̿롤");
			Str_Cat( szTmp, "\n ���� ��Ź )�ϰ� �ֽ��ϴ�.");
			Str_Cat( szTmp, "\n\n  �������� ��ȣ�� ��15�� ��1�� ��1ȣ, ��1");
			Str_Cat( szTmp, "\n 7�� ��1�� ��1ȣ, ��24�� ��1�� ��1ȣ�� ��");
			Str_Cat( szTmp, "\n �� ������ ���ǰ� �ʿ��մϴ�.");
			Str_Cat( szTmp, "\n\n  ���Բ����� �������� ó�����׿� ����");
			Str_Cat( szTmp, "\n ���Ǹ� �ź� �� ���ֽ��ϴ�.");
			Str_Cat( szTmp, "\n\n  �ٸ� [�ʼ�] ���׿� ���� ���ǰ� ���� ���");
			Str_Cat( szTmp, "\n �ŷ������� ���� �Ǵ� ������ �Ұ����ϸ�");
			Str_Cat( szTmp, "\n ���ð��� ��뿡 ���� ���񽺰� ���ѵ� ��");
			Str_Cat( szTmp, "\n �ֽ��ϴ�.");
			Str_Cat( szTmp, "\n\n  ���� ��ü���� ��� ��ü�Ⱓ�� ���� ����");
			Str_Cat( szTmp, "\n ���� �����Ⱓ, �̿�Ⱓ, ��ȸ���� ȿ�±�");
			Str_Cat( szTmp, "\n ���� ����� �� �ֽ��ϴ�.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FAG_AGREE), szTmp );
			
		}
		/********************************/
		/* �������� Ȱ�� ���Ǽ�         */
		/********************************/
		else if( m_bFirst == INIT_AGREE )
		{
			// �������� ���� �� �̿뵿��
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
			
			// ����(�ſ�)���� ���� ����
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
			
			// ����(�ſ�)���� ��ȸ ����
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
			
			// �����ĺ����� ���� �� �����޴� ����
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
			
			// ������ ���� �� �������� Ȱ�� ����
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
		/* ���ǳ���_1                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_1 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " 1. ������ :");
			Str_Cat( szTmp, "\n ����, �������, ����, ��ȭ��");
			Str_Cat( szTmp, "\n ȣ, �޴���, �ּ�, �̸���");
			Str_Cat( szTmp, "\n\n 2. �ڵ���ü��û ��:");
			Str_Cat( szTmp, "\n ����, �������, �����, ����");
			Str_Cat( szTmp, "\n ��ȣ, ��ȭ��ȣ,ī���,ī���ȣ,��ȿ�Ⱓ,");
			Str_Cat( szTmp, "\n (�ڵ���ü ��û �븮��)����,");
			Str_Cat( szTmp, "\n ��ȭ��ȣ");
			Str_Cat( szTmp, "\n 3. ������(�Ӵ���� �Ǵ� ��");
			Str_Cat( szTmp, "\n ����) :");
			Str_Cat( szTmp, "\n ����, ��ȭ��ȣ, �޴���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_1_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " ���ð��� ����(���� ���");
			Str_Cat( szTmp, "\n , ����, ����)����, ��ݰ���");
			Str_Cat( szTmp, "\n (�����,����,LMSû��) �� ");
			Str_Cat( szTmp, "\n LMS�����ȳ�, ���� �� �߽ɰ�");
			Str_Cat( szTmp, "\n ��, �������� ���� �� SMS����");
			Str_Cat( szTmp, "\n �ȳ�, �跮�� ��ü����, �޴���");
			Str_Cat( szTmp, "\n ���� �ο�ó�� �� ���Ȯ��,");
			Str_Cat( szTmp, "\n LMS��ݹ̳��ȳ�, �ΰ�����");
			Str_Cat( szTmp, "\n �� ���� ��");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_1_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "����� ���� �� 5��");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_1_3), szTmp );
		}
		/********************************/
		/* ���ǳ���_2                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_2 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE������(��)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " ��������ȣ, ����, ����");
			Str_Cat( szTmp, "\n ó , �������, ����, ��ü");
			Str_Cat( szTmp, "\n ����");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " ��������ȣ�߱�, �ſ�");
			Str_Cat( szTmp, "\n ������ȸ, ä�������� ��");
			Str_Cat( szTmp, "\n ��");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "�̿���� �Ⱓ ��");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_4), szTmp );
			
			// 5
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "����3�ڿ� ���� �ſ�������ȸ ������ ����");
			Str_Cat( szTmp, "\n ���� ������ <����(�ſ�)���� ����>�� ����");
			Str_Cat( szTmp, "\n �һ� �ƴ϶� <����(�ſ�)���� ��ȸ>���� ��");
			Str_Cat( szTmp, "\n ���ϴ� ��쿡�� �̷�����ϴ�.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_2_5), szTmp );
		}
		/********************************/
		/* ���ǳ���_3                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_3 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE������(��)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " ��������, �ſ뵵�Ǵ���");
			Str_Cat( szTmp, "\n ��(��ü, �ε�, ��������");
			Str_Cat( szTmp, "\n ����), ��������, �ſ��");
			Str_Cat( szTmp, "\n ��, ��Ű���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " ����� ü�� �� �����Ǵ�");
			Str_Cat( szTmp, "\n ����, ��ü����, ���Žɻ�");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " ���ǽ�������");
			Str_Cat( szTmp, "\n ������� �ñ���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_4), szTmp );
			
			// 5
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "�غ� ��ȸ���ǿ� ���� ��ȸ ����� �ſ���");
			Str_Cat( szTmp, "\n �� ������ ���� �ʽ��ϴ�.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_3_5), szTmp );
		}
		/********************************/
		/* ���ǳ���_4                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_4 )
		{
			// 1_1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE������(��)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_1_1), szTmp );
			
			// 1_2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " ���ﵵ�ð���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_1_2), szTmp );
			
			// 2_1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " ���ﵵ�ð���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_2_1), szTmp );
			
			// 2_2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " NICE������(��)");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_2_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "��ü���� �ֹε�Ϲ�ȣ");
			Str_Cat( szTmp, "\n�� �ܱ��ε�Ϲ�ȣ");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "�̳������ ȸ��");
			Str_Cat( szTmp, "\n �� ä���߽ɾ���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_4), szTmp );
			
			// 5
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "�̿���� �Ⱓ��");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_5), szTmp );
			
			// 6
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "�ذ�������ó�� ��Ź�� �� �ڼ��� ������ ��");
			Str_Cat( szTmp, "\n�ﵵ�ð��� Ȩ������(www.seoulgas.co.kr)");
			Str_Cat( szTmp, "\n�� ������ '��������ó����ħ'�� �����Ͻñ�");
			Str_Cat( szTmp, "\n�ٶ��ϴ�.");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_4_6), szTmp );
		}
		/********************************/
		/* ���ǳ���_5                   */
		/********************************/
		else if( m_bFirst == INIT_AGREEVIEW_5 )
		{
			// 1
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " ����, �޴�����ȣ, �ּ�");
			Str_Cat( szTmp, "\n , �̸���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_1), szTmp );
			
			// 2
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
			Str_Cpy( szTmp, " �� ���Ǽ��� ����, ��");
			Str_Cat( szTmp, "\n ǰ, ���� �ȳ� �� ����");
			Str_Cat( szTmp, "\n , ȫ��, ���θ�� ����");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_2), szTmp );
			
			// 3
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, " ����öȸ �ñ���");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_3), szTmp );
			
			// 4
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, "�ع̵��� �� ���ﵵ�ð����� ��������, ����");
			Str_Cat( szTmp, "\n��� �� �̺�Ʈ ������ ���� ���Ͻ� �� �ֽ�");
			Str_Cat( szTmp, "\n�ϴ�.");
			Str_Cat( szTmp, "\n ( �������, ĳ�ù�, ����Ʈ ����, ���� �� )");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AV_5_4), szTmp );
		}
		/********************************/
		/* �ڵ���ü                     */
		/********************************/
		else if( m_bFirst == INIT_AUTOTRANS )
		{	
			//���ι��
			i = g_SearchCD( stMudData.PAYMENT_METHOD, MUD_PAY_METHOD );
			
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), MUD_PAY_METHOD[i].Str);
			}
			
			// ����
			if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "��������" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "���¹�ȣ" );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );

				if( Str_Cmp (stMudData_ORI.BNK_CD, "021") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "026") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "088");
					//��������				
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "005") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "081");
					//�ϳ�����
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "006") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "019") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "004");
					//��������
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "010") == 0 ||  Str_Cmp (stMudData_ORI.BNK_CD, "018") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "011");
					//��������
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "013") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "014") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "015") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "017") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "012");
					//��������
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "046") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "045");
					//�������ݰ�
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "043") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "003");
					//�������
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "047") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "049") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "048");
					//����
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "072") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "073") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "074") == 0 || Str_Cmp (stMudData_ORI.BNK_CD, "075") == 0)
				{
					Str_Cpy(stMudData.BNK_CD , "071");
					//��ü��
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "084") == 0 )
				{
					// MessageBox(MESSAGE, "111111111111", 0, 0, 0, 0);
					Str_Cpy(stMudData.BNK_CD , "020");
					//�츮����
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "230") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "238");
					//�̷����´��
				}
				else if( Str_Cmp (stMudData_ORI.BNK_CD, "289") == 0 )
				{
					Str_Cpy(stMudData.BNK_CD , "247");
					//NH��������
				}

				SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' AND CODE_ITEM = '%s' ", stMudData.BNK_CD, 0, 0   );
				g_Sql_RetStr( szSql, 20, szTmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_BANK), szTmp );
				
			}
			// ī��
			else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "ī������" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "ī���ȣ" );
				
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
			
			// ���¹�ȣ, ����ó��
			if( m_lBackAutoTrans == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ACCOUNT), stMudData.SECU_DEFRAY_ACCOUNT_NUM );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ACCOUNT), stMudData.DEFRAY_ACCOUNT_NUM );
			}
			
			// �����ָ�
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_NM), stMudData.DEPOSITOR_NM );
			
			// ������ ��ȭ��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD), stMudData.DEPOSITOR_TEL_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN), stMudData.DEPOSITOR_TEL_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM), stMudData.DEPOSITOR_TEL_NUM );
			
			// ������ ������� ����ڹ�ȣ
			// 13�ڸ��� �ֹι�ȣ -> ���� 6�ڸ���
			// �ƴ� ���� ����ڹ�ȣ -> ��� �ѱ��
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
			
			// �����ֿ� ����	
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' AND CODE_ITEM = '%s' ", stMudData.DEPOSITOR_RELAT_CD, 0, 0   );
			g_Sql_RetStr( szSql, 20, szTmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT), szTmp );
			
			// �븮�θ�
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_NM), stMudData.REQ_NM );
			
			// �븮�� ��ȭ��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD), stMudData.REQ_TEL_DDD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN), stMudData.REQ_TEL_EXN );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM), stMudData.REQ_TEL_NUM );
			
			// Ȯ�ι�ư	
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
			
			// �޺��ڽ� Setting
			SetCombo_Filter();
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : SetTab
	��  �� : �� ��ư �̺�Ʈ
	Param  : flag : 0 = ������, 1 = �������� Ȱ�� ���Ǽ�, 2 = ���ι��
	Return : 
	========================================================================================*/
	void SetTab( long flag )
	{
		// ������
		if( flag == 0 )
		{
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
		}
		// �������� Ȱ�� ���Ǽ�
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
		// ���ι��
		else if( flag == 2 )
		{
			ON_EXIT();
			OnInit(INIT_AUTOTRANS);	
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetOzView_Data
	��  �� : ���� �� ������ Setting
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
	
		MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);

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
			
			SetMessageBoxText("20 % ó����...");

			// 1. ���� �� Body Setting
			SetOzView_JsonBody(sql);
			
			// 2. �ڵ���ü ���� ������(����ȣ, ����,ī�� �ڵ�) Setting
			SetOzView_JsonArray_Bank(sql);
			
			SetMessageBoxText("90 % ó����...");
			
			// 3. ���ι�� ������ Setting
			SetOzView_JsonArray_Payment();
			
			SetMessageBoxText("100 % �Ϸ�.");
			
			JSON_SetValue( m_hBody, 'C', "cust_num",     stMudData.CUST_NUM );
			JSON_SetValue( m_hBody, 'C', "url",          GET_URL(WAS_BASE_URL) );
			JSON_SetValue( m_hBody, 'C', "clientid",     stUserinfo.szpda_ip );
			JSON_SetValue( m_hBody, 'C', "userid",       stUserinfo.szemployee_id );
			JSON_SetValue( m_hBody, 'C', "workcd",       stUserinfo.szworkcd );
			JSON_SetValue( m_hBody, 'C', "vmversion",    stUserinfo.szver_num );
			JSON_SetValue( m_hBody, 'C', "appversion",   stUserinfo.szappversion );

			// ��� �Է�
			/************************* �� �ڵ� : 00001_1 **********************/
			JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00001_1");
			/******************************************************************/
			// JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00001_1_220223");
			
			JSON_SetValue	(hHeader	, 'C', "Ozserver"			, GET_URL(OZ_BASE_URL));
			JSON_Attach 	(hHeader		 , "Paramdata"			, m_hBody);
			
			//�ý����� ��û { "method" : "�ý����� �Ž���", "data" : "json object ��Ʈ��" }
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
	�Լ��� : SetOzView_JsonBody
	��  �� : ���� �� ������ ���� Body Setting
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
		
		// ����� ����༭ Type [ 1(���Թο�), 2(��������), 3(���Ǻ���), 4(�ű�) ]
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
		
		// ��ġ��ҹ�ȣ
		JSON_SetValue( m_hBody, 'C', "pmUsecontnum", stMudData.INST_PLACE_NUM ); 
		
		// ������ȣ
		if( g_lMobile_Use_Doc_Type == 4 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmCustnum", "");
		}
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmCustnum", stMudData.USE_CONT_NUM );
		}
		
		// ����
		JSON_SetValue( m_hBody, 'C', "pmName", stMudData.CUST_NM );
		
		// �������
		JSON_SetValue( m_hBody, 'C', "pmBirthdate", stMudData.SOC_NUM );
		
		
		// ����
		JSON_SetValue( m_hBody, 'C', "pmSex", stMudData.GENDER );
		
		// Safe Ű
		if( Str_Len(stMudData.SAFE_KEY) > 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmSafekey", "Y" );
		}
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmSafekey", "" );
		}
		
		// ��ȣ
		JSON_SetValue( m_hBody, 'C', "pmCorpname", stMudData.FIRM_NM );
		
		// ����
		JSON_SetValue( m_hBody, 'C', "pmVat", stMudData.TAXBILL );
		
		// ����ڹ�ȣ
		JSON_SetValue( m_hBody, 'C', "pmVatno", stMudData.BIZ_REGI_NUM );
		
		// �ּ�
		if( Str_Len(stMudData.NEW_ADDR_UNION) > 10 )
		{
			JSON_SetValue( m_hBody, 'C', "pmAddr", stMudData.NEW_ADDR_UNION );
		}
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmAddr", stMudData.CURR_ADDR_UNION );
		}
		
		SetMessageBoxText("30 % ó����...");
		
		// ��ȭ��ȣ �޺��ڽ� ��
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp, " CODE_ID = 'A10110' ORDER BY SORT_ORDER ", 0, 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmTelcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		// ��ȭ��ȣ
		JSON_SetValue( m_hBody, 'C', "pmTel1", stMudData.OWNHOUSE_TEL_DDD );
		JSON_SetValue( m_hBody, 'C', "pmTel2", stMudData.OWNHOUSE_TEL_EXN );
		JSON_SetValue( m_hBody, 'C', "pmTel3", stMudData.OWNHOUSE_TEL_NUM );
		
		// �޴��� �޺��ڽ� ��
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp, " CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER ", 0 , 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmPhonecombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		// �޴��� ��ȣ
		JSON_SetValue( m_hBody, 'C', "pmPhone1", stMudData.CP_DDD );
		JSON_SetValue( m_hBody, 'C', "pmPhone2", stMudData.CP_EXN );
		JSON_SetValue( m_hBody, 'C', "pmPhone3", stMudData.CP_NUM );
		
		// �̸��� �ּ�
		// @�� ���� �Ѱܾ� ��
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'A10140' ", 0, 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmEmailcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		JSON_SetValue( m_hBody, 'C', "pmEmail1", stMudData.EMAIL_REQ_ID );
		JSON_SetValue( m_hBody, 'C', "pmEmail2", stMudData.EMAIL_REQ_ADDR );
			
		SetMessageBoxText("40 % ó����...");
		
		/************** BILL_SEND_METHOD *****************************/
		// û����� : 10 = ������, 40 = �̸���, 70 = LMS, 80 = �����
		/*************************************************************/
		// ������
		if ( Str_Cmp( stMudData.BILING_METHOD, "10" ) == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "������" );

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
			JSON_SetValue( m_hBody, 'C', "pmBilling", "�����" );

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
		// ��Ÿ
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmBilling", "" );
			
			JSON_SetValue( m_hBody, 'C', "pmLms1", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms2", "" );
			JSON_SetValue( m_hBody, 'C', "pmLms3", "" );
		}
		
		/*********************** PAYMETHOD ******************************/
		// ���ι�� : 10 = �����ڵ���ü, 20 = ī���ڵ���ü, NULL = ����
		// pmBankapply -> �ڵ���ü ��û, �̽�û ����� ���� (Y,N)
		/****************************************************************/
		// ī��
		if( Str_Cmp(stMudData.PAYMENT_METHOD, "20") == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBankapply", "Y" );
			JSON_SetValue( m_hBody, 'C', "pmBanktitle", "����" );	
		}
		// ����
		else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
		{
			JSON_SetValue( m_hBody, 'C', "pmBankapply", "Y" );
			JSON_SetValue( m_hBody, 'C', "pmBanktitle", "ī��" );
		}
		// ��Ÿ
		else
		{
			JSON_SetValue( m_hBody, 'C', "pmBankapply", "N" );
			JSON_SetValue( m_hBody, 'C', "pmBanktitle", "" );
		}
		
		SetMessageBoxText("50 % ó����...");
		
		// ���� �޺�
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'C61999' ",0,0,0 );
		JSON_SetValue( m_hBody, 'C', "pmBankcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );

		SetMessageBoxText("60 % ó����...");
		
		// ī�� �޺�
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'C61998' ",0,0,0 );
		JSON_SetValue( m_hBody, 'C', "pmCardcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		SetMessageBoxText("70 % ó����...");
		
		// �����
		JSON_SetValue( m_hBody	, 'C', "pmBank", stMudData.BNK_BRANCH_NM );
		
		// ���¹�ȣ
		JSON_SetValue( m_hBody	, 'C', "pmAcc", stMudData.DEFRAY_ACCOUNT_NUM );
		
		// �����ָ�
		JSON_SetValue( m_hBody	, 'C', "pmAccname", stMudData.DEPOSITOR_NM );
		
		// ������ �������, ����ڹ�ȣ
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
		
		// ������ ��ȭ��ȣ
		JSON_SetValue( m_hBody, 'C', "pmAccphone1", stMudData.DEPOSITOR_TEL_DDD );
		JSON_SetValue( m_hBody, 'C', "pmAccphone2", stMudData.DEPOSITOR_TEL_EXN );
		JSON_SetValue( m_hBody, 'C', "pmAccphone3", stMudData.DEPOSITOR_TEL_NUM );

		// �����ڿ� ���� �޺��ڽ� ��
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT( szTmp," CODE_ID = 'C10004' ", 0 ,0 ,0 );
		JSON_SetValue( m_hBody, 'C', "pmAccrelationcombo", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );	
		SPRINT(szTmp," CODE_ID = 'C10004' AND CODE_ITEM = '%s' ", stMudData.DEPOSITOR_RELAT_CD, 0, 0 );
		JSON_SetValue( m_hBody, 'C', "pmAccrelation", g_SetOzComboData( sql, szTmp, szComboData, 0 ) );
		
		SetMessageBoxText("80 % ó����...");
		
		// �븮�θ�
		JSON_SetValue( m_hBody, 'C', "pmAgentname", stMudData.REQ_NM );
		
		// �븮�� ��ȭ��ȣ
		JSON_SetValue( m_hBody, 'C', "pmAgentphone1", stMudData.REQ_TEL_DDD );
		JSON_SetValue( m_hBody, 'C', "pmAgentphone2", stMudData.REQ_TEL_EXN );
		JSON_SetValue( m_hBody, 'C', "pmAgentphone3", stMudData.REQ_TEL_NUM );
		
		// ���ǿ��� 1
		JSON_SetValue( m_hBody, 'C', "pmAgree1", stMudData.INFO_USE_AGREE_YN );
		
		// ���ǿ��� 2
		JSON_SetValue( m_hBody, 'C', "pmAgree2", stMudData.INFO_USE_YN );
		
		// ���ǿ��� 3
		JSON_SetValue( m_hBody, 'C', "pmAgree3", stMudData.INFO_USE_YN4 );
		
		// ���ǿ��� 4
		JSON_SetValue( m_hBody, 'C', "pmAgree4", stMudData.INFO_USE_YN5 );
		
		// ���ǿ��� 5
		JSON_SetValue( m_hBody, 'C', "pmAgree5", stMudData.INFO_USE_YN6 );
		
		// ����
		JSON_SetValue( m_hBody, 'C', "pmCenter", stUserinfo.sznm_kor );
		
		// ���� �� �������� OR ���Կ��� �� �ڵ���ü �����Ͱ� ������ N
		if( Str_Cmp(g_szAccnameSignYn, "N") == 0 )
		{
			// ��������, ���Կ��� �ڵ���ü �����͸� �������� �ʾ����� N, ���������� Y
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
	�Լ��� : SetOzView_JsonArray_Bank
	��  �� : ���� �� ������ ����ī�� JsonArray Data Setting
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
		
		/******************* ī�� �޺� - 5�� **********************/
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
		
		/****************** ���� �޺� - 44�� **********************/
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
	�Լ��� : SetOzView_JsonArray_Payment
	��  �� : ���� �� ������ ���ι�� JsonArray Data Setting
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
		JSON_SetArrayItem( hArray, 'C', "payment_nm", "�����ڵ���ü" );

		JSON_AddArrayItem( hArray );
		JSON_SetArrayItem( hArray, 'C', "payment_cd", "20" );
		JSON_SetArrayItem( hArray, 'C', "payment_nm", "ī���ڵ���ü" );

		JSON_AddArrayItem( hArray );
		JSON_SetArrayItem( hArray, 'C', "payment_cd", "" );
		JSON_SetArrayItem( hArray, 'C', "payment_nm", "����"  );

		JSON_Attach( m_hBody, "payment_method", hArray );

Finally:

		if( hArray )
		{
			JSON_Finalize( hArray );
		}	
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_OzData
	��  �� : ���� �� ������ �޾ƿ�
	Param  : 
	Return : 
			CHG_CUST_TYPE(���Ǻ��濩��) = ?
			TRANS_FLAG( Ÿ�� ) : ���Խű� = 1, �������� = 2, ���Ǻ��� = 3, �ű� = 4
			DATA_COL_TYPE( ���� ) : ���� = 10, ���� = 20, ��ħ = 30, ��ü = 40, ��Ÿ = 50
			
			OZ_TRAN_REQ_FLAG( �ڵ���ü ��û Ÿ�� ) : ��û = new, ���� = cancel
			TRAN_FLAG( �ڵ���ü ���� ) : ���� = 10, ī�� = 20
			
			PAYMENT_METHOD( ���� ��� ) : ���� = 10, ī�� = 20
			PAY_METHOD_TYPE( ��û���� ) : ��û = 10, ���� = 20
			
			BILING_METHOD( û����� ) : LMS = 30, EMAIL = 40, ����� = 50
		 	BILL_METHOD_TYPE( ��û ���� ) : ��û = 10, ���� = 20
		 	
			OZ_LMS_REQ_FLAG( lms û����� ��û Ÿ�� ) : ��û = new, ���� = modify, ��� = cancel
			OZ_EMAIL_REQ_FLAG ( email û����� ��û Ÿ�� ) : ��û = new, ���� = modify, ��� = cancel
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
			/* OZ���� ���� ���� ��� ����          */
			/***************************************/
			if( Str_Cmp(szTmp, "btnSave") == 0 )
			{
				szData = JSON_GetValue( hItem, "ret_data", szType );
				hData = JSON_Create( JSON_Object );
				
				/***************************************/
				/* OZ ��� �����Ͱ� �ִ� ���          */
				/***************************************/
				if( hData != NULL )
				{
					JSON_toJson( hData, szData ) ;
					
					Mem_Set((byte*)&stOzData, 0x00, sizeof(stOzData));
					
					/*************************************/
					/* ���԰��(DATA_COL_TYPE)           */
					/*************************************/
					// ���� �ű�
					if( g_lMobile_Inflow_Path == 0 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "10");
					} 
					// �ο� ����_�ű�
					else if( g_lMobile_Inflow_Path == 1 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "10");
					}
					// ��������
					else if( g_lMobile_Inflow_Path == 2 )
					{	
						Str_Cpy(stOzData.DATA_COL_TYPE, "20");
					}	
					// ��ħ
					else if( g_lMobile_Inflow_Path == 3 )
					{	
						Str_Cpy(stOzData.DATA_COL_TYPE, "30");
					}
					// �跮�ⱳü
					else if( g_lMobile_Inflow_Path == 4 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "40");
					}
					// �ο� ����_����
					else if( g_lMobile_Inflow_Path == 5 )
					{
						Str_Cpy(stOzData.DATA_COL_TYPE, "50");
					}
					// ��Ÿ�ο�
					else
					{	
						Str_Cpy(stOzData.DATA_COL_TYPE, "50");
					}
					
					/*************************************/
					/* ���Ǻ��濩��(CHG_CUST_TYPE)       */
					/*************************************/
					// CHG_CUST_TYPE : ���Ǻ��濩��
					// TRANS_FLAG( Ÿ�� ) : ���Խű� = 1, �������� = 2, ���Ǻ��� = 3, �ű� = 4
					// ���Խű�
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
					// ��������
					else if( g_lMobile_Use_Doc_Type == 2 )
					{
						Str_Cpy(stOzData.CHG_CUST_TYPE, "10");
						Str_Cpy(stOzData.TRANS_FLAG, "2");
					}
					// ���Ǻ���
					else if( g_lMobile_Use_Doc_Type == 3 )
					{
						Str_Cpy(stOzData.CHG_CUST_TYPE, "20");
						Str_Cpy(stOzData.TRANS_FLAG, "3");
					}
					// �ű�
					else if( g_lMobile_Use_Doc_Type == 4 )
					{
						Str_Cpy(stOzData.CHG_CUST_TYPE, "30");
						Str_Cpy(stOzData.TRANS_FLAG, "1");
					}
					// ��Ÿ
					else
					{	
						Str_Cpy(stOzData.CHG_CUST_TYPE, "");
						Str_Cpy(stOzData.TRANS_FLAG, "1");
					}
					
					/*************************************/
					/* ������                          */
					/*************************************/
					// ������ȣ
					Str_Cpy( stOzData.USE_CONT_NUM, stMudData.USE_CONT_NUM);
					
					// �����ڵ�
					Str_Cpy( stOzData.BRANCH_CD, stUserinfo.szbranch_cd);
					
					// �����ڵ�
					Str_Cpy( stOzData.CENTER_CD, stUserinfo.szcenter_cd);
					
					// ��ġ��ҹ�ȣ				
					Str_Cpy( stOzData.INST_PLACE_NUM, JSON_GetValue( hData, "pmUsecontnum", szType ) );
					
					// ����ȣ
					Str_Cpy( stOzData.CUST_NUM, stMudData.CUST_NUM);
					
					// ����
					Str_Cpy( stOzData.CUST_NM, JSON_GetValue( hData, "pmName", szType) );
					
					// SOC_NUM
					// �Էµ����� ���� Ȯ��(yyyymmdd OR yyyy��mm��dd��) -> ����� ���ڷ� ������
					Str_Cpy(stOzData.SOC_NUM                     , JSON_GetValue (hData, "pmBirthdate",    szType) );
					Str_Cat(stOzData.SOC_NUM, "0000000");
					Str_Chg(stOzData.SOC_NUM, STRCHG_DEL_NONDIGIT);
					
					// ����
					Str_Cpy(stOzData.GENDER                      , JSON_GetValue (hData, "pmSex",    szType) );
					
					// ���泯¥
					Str_Cpy(stOzData.TRAN_REQ_YMD                , JSON_GetValue (hData, "pmCurrentdate",    szType) );
					Str_Chg(stOzData.TRAN_REQ_YMD, STRCHG_DEL_NONDIGIT);

					// ��ȭ��ȣ
					Str_Cpy(stOzData.OWNHOUSE_TEL_DDD            , JSON_GetValue (hData, "pmTel1",    szType) );
					Str_Cpy(stOzData.OWNHOUSE_TEL_EXN            , JSON_GetValue (hData, "pmTel2",    szType) );
					Str_Cpy(stOzData.OWNHOUSE_TEL_NUM            , JSON_GetValue (hData, "pmTel3",    szType) );
					
					// �ڵ�����ȣ
					Str_Cpy(stOzData.CP_DDD                      , JSON_GetValue (hData, "pmPhone1",    szType) );
					Str_Cpy(stOzData.CP_EXN                      , JSON_GetValue (hData, "pmPhone2",    szType) );
					Str_Cpy(stOzData.CP_NUM                      , JSON_GetValue (hData, "pmPhone3",    szType) );
					
					// �ּ�
					Str_Cpy(stOzData.ADDR_UNION                  , JSON_GetValue (hData, "pmAddr",    szType) );
					
					// ����
					Str_Cpy(stOzData.INFO_USE_AGREE_YN           , JSON_GetValue (hData, "pmAgreetitle1",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN4                , JSON_GetValue (hData, "pmAgreetitle2",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN                 , JSON_GetValue (hData, "pmAgreetitle3",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN5                , JSON_GetValue (hData, "pmAgreetitle4",    szType) );
					Str_Cpy(stOzData.INFO_USE_YN6                , JSON_GetValue (hData, "pmAgreetitle5",    szType) );
					
					/*************************************/
					/* ���ι��                          */
					/*************************************/
					// �ڵ���ü FLAG Ȯ�� ( 0 = ����, 1 = NEW, 2 = CANCEL )
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
					
					// �ڵ���ü���� ������ �Ͼ ���( NEW, CANCEL )
					if( Str_Cmp( stOzData.OZ_TRAN_REQ_FLAG, "new" ) == 0 || Str_Cmp( stOzData.OZ_TRAN_REQ_FLAG, "cancel" ) == 0 )
					{
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(szTmp     , JSON_GetValue (hData, "pmPayment",    szType));
						
						/*************************************/
						/* ����                              */
						/*************************************/
						if( Str_Cmp(szTmp, "�����ڵ���ü") == 0 )
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
						/* ī��                              */
						/*************************************/
						else if( Str_Cmp(szTmp, "ī���ڵ���ü") == 0 )
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
								//�ڵ���ü ��û ���
								Str_Cpy(stOzData.PAYMENT_METHOD, "");
								Str_Cpy(stOzData.PAY_METHOD_TYPE, "20");
							}
							else
							{
								//���� -> ����
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
					/* û�����                          */
					/*************************************/
					// LMS = 30, EMAIL = 40, MOBILE = 50
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy(szTmp, JSON_GetValue (hData, "pmBilling", szType));
					
					// LMS
					// LMS + ������ , ����� + LMS

					// PRINT("szTmp szTmp szTmp szTmp : %d ",szTmp,0,0);

					// Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					// SPRINT(szMsg, "���Ϲ��� pmBilling �� \n[%s] ", szTmp, 0, 0);
					// MessageBoxEx(CONFIRM_OK, szMsg);

					// if( Str_Cmp(szTmp, "LMS") == 0 || Str_Cmp(szTmp, "LG") == 0 || Str_Cmp(szTmp, "ML") == 0)
					if( Str_Cmp(szTmp, "LMS") == 0 || Str_Cmp(szTmp, "LMS,������") == 0 || Str_Cmp(szTmp, "�����,LMS") == 0)
					{
						// Str_Cpy(stOzData.BILING_METHOD, szTmp);
						
						// if(Str_Cmp(szTmp, "ML") == 0)
						if(Str_Cmp(szTmp, "�����,LMS") == 0)
						{
							Str_Cpy(stOzData.BILING_METHOD, "31");
						}
						else if(Str_Cmp(szTmp, "LMS,������") == 0)
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
						
						// ���� �����Ͱ� 70�� �ƴϸ� �ű���
						// 20220224 �������� ���߰����� ���õȰ��� ��������, �߰������̱⶧����
						// 70 LMS , 17 LMS+������ , 47 EMAIL+LMS , 78 �����+LMS
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
										//���Թο��� ��� -> ������ ��û(�����Ͱ� ���־ ��û, ������!!)
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
						
						// �̸��� SETTING
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(stOzData.EMAIL_REQ_ADDR, JSON_GetValue (hData, "pmEmail1", szType) );
						Str_Cpy(szTmp, JSON_GetValue (hData, "pmEmail2", szType) );
						
						if( Str_Len(stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(stOzData.EMAIL_REQ_ADDR, szTmp);

							//�Էµ� �̸��� �ּҰ� ���� ��� @����
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
					// �̸���
					// �̸���+������ , ����� + �̸���
					// else if( Str_Cmp(szTmp, "E-mail") == 0 || Str_Cmp(szTmp, "EG") == 0 || Str_Cmp(szTmp, "ME") == 0)
					else if( Str_Cmp(szTmp, "E-mail") == 0 || Str_Cmp(szTmp, "E-mail,������") == 0 || Str_Cmp(szTmp, "�����,E-mail") == 0)
					{
						// Str_Cpy(stOzData.BILING_METHOD, szTmp);
						
						if(Str_Cmp(szTmp, "�����,E-mail") == 0)
						{
							Str_Cpy(stOzData.BILING_METHOD, "41");
						}
						else if(Str_Cmp(szTmp, "E-mail,������") == 0)
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
										//���Թο��� ��� -> ������ ��û(�����Ͱ� ���־ ��û, ������!!)
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

							//�Էµ� �̸��� �ּҰ� ���� ��� @����
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

						// ���� 70�� �ƴϰ� 40�� �ƴҶ�
						// if( Str_Cmp(stMudData_ORI.BILING_METHOD, "70") != 0 && Str_Cmp(stMudData_ORI.BILING_METHOD, "40") != 0)
						if( Str_Cmp(stMudData_ORI.BILING_METHOD, "18") == 0 && Str_Cmp(stMudData_ORI.BILING_METHOD, "80") == 0)
						{
							Str_Cpy(stOzData.BILL_METHOD_TYPE, "10");
							Str_Cpy(stOzData.OZ_LMS_REQ_FLAG, "new");
							Str_Cpy(stOzData.OZ_EMAIL_REQ_FLAG, "new");
						}
						// else if(Str_Cmp(stMudData_ORI.BILING_METHOD, "70") == 0)
						// 70 LMS , 17 LMS+�۴� , 78 ��+LMS
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
										//���Թο��� ��� -> ������ ��û(�����Ͱ� ���־ ��û, ������!!)
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
						// 40 EMAIL , 14 EMAIL + ������ , 48 ����� + �̸���
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
										//���Թο��� ��� -> ������ ��û(�����Ͱ� ���־ ��û, ������!!)
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
										//���Թο��� ��� -> ������ ��û(�����Ͱ� ���־ ��û, ������!!)
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

							//�Էµ� �̸��� �ּҰ� ���� ��� @����
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
						//���� û����� Ȯ�� -> ��� or ������
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
							if( Str_Cmp(szTmp, "�����") == 0 )
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
						
						if( Str_Cmp(szTmp, "�����") == 0 )
						{
							Str_Cpy(stOzData.BILING_METHOD, "50");
						}
						else if(Str_Cmp(szTmp, "�����,������") == 0 )
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

							//�Էµ� �̸��� �ּҰ� ���� ��� @����
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
				
				//���� ī�� ����
				Str_Cpy(stOzData.CARD_VALID_PERIOD               , JSON_GetValue (hItem, "card_valid_period",    szType) );
				Str_Cpy(stOzData.CARD_JOIN_YN                    , JSON_GetValue (hItem, "card_join_yn"		,    szType) );
				
				//PDF ���
				szPath = JSON_GetValue (hItem, "pdf_path",    szType);
	
				hPath = JSON_Create( JSON_Object );
				if( hPath != NULL )
				{
					//OZ ����(PDF) �� Smart���� ���� ������ ����
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
	
							//������ �ű� �� LCTECH ���� Ŭ����(���� oz���� ����)
							FFS_Delete(szFileNm);
						}
						
						Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
						lRet = g_FindFiles( szBuf, "*.pdf" , szFileNm);
						if( lRet > 0 )
						{
							//������ �ű� �� LCTECH ���� Ŭ����(���� oz���� ����)
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
	�Լ��� : Save_Cust_Info_Data
	��  �� : stMudData ����
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
			// ����
			Mem_Set( (byte*)stMudData.CUST_NM, 0x00, sizeof(stMudData.CUST_NM) );
			Str_Cpy( stMudData.CUST_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_CUST_NM)) );
			
			// �������
			Mem_Set( (byte*)stMudData.SOC_NUM, 0x00, sizeof(stMudData.SOC_NUM) );
			Str_Cpy( stMudData.SOC_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_BRITH_YMD)) );
			
			// �ڵ��� DDD
			Mem_Set( (byte*)stMudData.CP_DDD, 0x00, sizeof(stMudData.CP_DDD) );
			Str_Cpy( stMudData.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_HP_DDD)) );
			
			// �ڵ��� EXN
			Mem_Set( (byte*)stMudData.CP_EXN, 0x00, sizeof(stMudData.CP_EXN) );
			Str_Cpy( stMudData.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_EXN)) );
			
			// �ڵ��� NUM
			Mem_Set( (byte*)stMudData.CP_NUM, 0x00, sizeof(stMudData.CP_NUM) );
			Str_Cpy(stMudData.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_HP_NUM)) );
			
			// ��ȭ DDD
			Mem_Set( (byte*)stMudData.OWNHOUSE_TEL_DDD, 0x00, sizeof(stMudData.OWNHOUSE_TEL_DDD) );
			Str_Cpy(stMudData.OWNHOUSE_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CI_TEL_DDD)) );
			
			// ��ȭ EXN
			Mem_Set( (byte*)stMudData.OWNHOUSE_TEL_EXN, 0x00, sizeof(stMudData.OWNHOUSE_TEL_EXN) );
			Str_Cpy(stMudData.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_TEL_EXN)) );
			
			// ��ȭ NUM
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
			
			// ����
			Mem_Set( (byte*)stMudData.FIRM_NM, 0x00, sizeof(stMudData.FIRM_NM) );
			Str_Cpy(stMudData.FIRM_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_FRIM)) );
			
			// ����ڵ�Ϲ�ȣ
			Mem_Set( (byte*)stMudData.BIZ_REGI_NUM, 0x00, sizeof(stMudData.BIZ_REGI_NUM) );
			Str_Cpy(stMudData.BIZ_REGI_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CI_BIZ_REG_NUM)) );
			
			// ���û�����
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
	�Լ��� : Save_PayMethod_Info_Data
	��  �� : stMudData ����
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
			// ���ι��
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
			
			// ����, ī�� �ڵ�
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stMudData.BNK_CD, 0x00, sizeof(stMudData.BNK_CD) );
			
			// ����
			if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
			{
				SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C61999' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), 0, 0);
				g_Sql_RetStr( szSql, 20, szTmp );
			}
			// ī��
			else if( Str_Cmp( stMudData.PAYMENT_METHOD, "30" ) == 0 )
			{
				SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C61998' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), 0, 0);
				g_Sql_RetStr( szSql, 20, szTmp );
			}
			// ����
			else
			{
				Str_Cpy( szTmp, "" );
			}
			
			Str_Cpy( stMudData.BNK_CD, szTmp );
			
			// ����, ī�� ��
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stMudData.BNK_BRANCH_NM, 0x00, sizeof(stMudData.BNK_BRANCH_NM) );
			
			if( Str_Cmp( EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), "") != 0 )
			{
				// ����
				if( Str_Cmp( stMudData.PAYMENT_METHOD, "20" ) == 0 )
				{
					SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_BANK) ), 0, 0);
					g_Sql_RetStr( szSql, 20, szTmp );
					Mem_Cpy((byte *)stMudData.BNK_BRANCH_NM, (byte *)szTmp+5, Str_Len(szTmp)-5);
				}
				// ī��
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
			
			// ���¹�ȣ
			Mem_Set( (byte*)stMudData.DEFRAY_ACCOUNT_NUM, 0x00, sizeof(stMudData.DEFRAY_ACCOUNT_NUM) );
			
			if( m_lBackAutoTrans == 0 )
			{
				Str_Cpy( stMudData.DEFRAY_ACCOUNT_NUM, stMudData_ORI.DEFRAY_ACCOUNT_NUM );
			}
			else
			{
				Str_Cpy( stMudData.DEFRAY_ACCOUNT_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ACCOUNT)) );
			}

			// �����ָ�
			Mem_Set( (byte*)stMudData.DEPOSITOR_NM, 0x00, sizeof(stMudData.DEPOSITOR_NM) );
			Str_Cpy( stMudData.DEPOSITOR_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_NM)) );
			
			// ������ ��ȭ��ȣ
			Mem_Set( (byte*)stMudData.DEPOSITOR_TEL_DDD, 0x00, sizeof(stMudData.DEPOSITOR_TEL_DDD) );
			Str_Cpy( stMudData.DEPOSITOR_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD)) );
			
			Mem_Set( (byte*)stMudData.DEPOSITOR_TEL_EXN, 0x00, sizeof(stMudData.DEPOSITOR_TEL_EXN) );
			Str_Cpy( stMudData.DEPOSITOR_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN)) );
			
			Mem_Set( (byte*)stMudData.DEPOSITOR_TEL_NUM, 0x00, sizeof(stMudData.DEPOSITOR_TEL_NUM) );
			Str_Cpy( stMudData.DEPOSITOR_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM)) );
			
			// ������ ������� ����ڹ�ȣ
			Mem_Set( (byte*)stMudData.DEPOSITOR_BIRTH_DATE, 0x00, sizeof(stMudData.DEPOSITOR_BIRTH_DATE) );
			Str_Cpy( stMudData.DEPOSITOR_BIRTH_DATE, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_DEP_BRITHDAY)) );
			
			// �����ֿ� ����
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stMudData.DEPOSITOR_RELAT_CD, 0x00, sizeof(stMudData.DEPOSITOR_RELAT_CD) );
			
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT) ), 0, 0);
			g_Sql_RetStr( szSql, 20, szTmp );
			
			Str_Cpy( stMudData.DEPOSITOR_RELAT_CD, szTmp );
			
			// �븮�θ�
			Mem_Set( (byte*)stMudData.REQ_NM, 0x00, sizeof(stMudData.REQ_NM) );
			Str_Cpy( stMudData.REQ_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_NM)) );
			
			// �븮����ȭ��ȣ
			Mem_Set( (byte*)stMudData.REQ_TEL_DDD, 0x00, sizeof(stMudData.REQ_TEL_DDD) );
			Str_Cpy( stMudData.REQ_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD)) );
			
			Mem_Set( (byte*)stMudData.REQ_TEL_EXN, 0x00, sizeof(stMudData.REQ_TEL_EXN) );
			Str_Cpy( stMudData.REQ_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN)) );
			
			Mem_Set( (byte*)stMudData.REQ_TEL_NUM, 0x00, sizeof(stMudData.REQ_TEL_NUM) );
			Str_Cpy( stMudData.REQ_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM)) );
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetBackAutoTrans
	��  �� : �ڵ���ü��û �ǵ�����
	Param  : 
	Return : 
	========================================================================================*/	
	void SetBackAutoTrans(void)
	{
		char szSql[200];
		char szTmp[200];
		long i = 0;
		
		//���ι��
		i = g_SearchCD( stMudData_ORI.PAYMENT_METHOD, MUD_PAY_METHOD );
		
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AT_PAY_METHOD), MUD_PAY_METHOD[i].Str);
		}
		
		// ����
		if( Str_Cmp( stMudData_ORI.PAYMENT_METHOD, "20" ) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "��������" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "���¹�ȣ" );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' AND CODE_ITEM = '%s' ", stMudData_ORI.BNK_CD, 0, 0   );
			g_Sql_RetStr( szSql, 20, szTmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_BANK), szTmp );	
		}
		// ī��
		else if( Str_Cmp( stMudData_ORI.PAYMENT_METHOD, "30" ) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_BANK), "ī������" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(ST_AT_ACCOUNT), "ī���ȣ" );
			
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
		
		// ���¹�ȣ, ����ó��
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ACCOUNT), stMudData_ORI.SECU_DEFRAY_ACCOUNT_NUM );
		
		// �����ָ�
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_NM), stMudData_ORI.DEPOSITOR_NM );
		
		// ������ ��ȭ��ȣ
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_TEL_DDD), stMudData_ORI.DEPOSITOR_TEL_DDD );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_EXN), stMudData_ORI.DEPOSITOR_TEL_EXN );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_DEP_TEL_NUM), stMudData_ORI.DEPOSITOR_TEL_NUM );
		
		// ������ ������� ����ڹ�ȣ
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
		
		// �����ֿ� ����	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' AND CODE_ITEM = '%s' ", stMudData_ORI.DEPOSITOR_RELAT_CD, 0, 0   );
		g_Sql_RetStr( szSql, 20, szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_DEP_RELAT), szTmp );
		
		// �븮�θ�
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_NM), stMudData_ORI.REQ_NM );
		
		// �븮�� ��ȭ��ȣ
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AT_ALT_TEL_DDD), stMudData_ORI.REQ_TEL_DDD );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_EXN), stMudData_ORI.REQ_TEL_EXN );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_AT_ALT_TEL_NUM), stMudData_ORI.REQ_TEL_NUM );
		
		// Ȯ�ι�ư
		m_lPayMethod_Chk = 0;
		ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), BTNCTRLBKCOLOR);
		ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_AT_SAVE), BTNMENUFRCOLOR);
	
		// m_lBackAutoTrans
		m_lBackAutoTrans = 0;
		
		// �޺� Setting
		SetCombo_Filter();
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : ClearAutoTrans
	��  �� : �ڵ���ü��û ������ Clear
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
	�Լ��� : SetViewAutoTrans
	��  �� : �ڵ���ü��û ��ư Enable, Disable
	Param  : flag : 0 = FALSE, 1 = TRUE
	Return : 
	========================================================================================*/	
	void SetViewAutoTrans(long flag)
	{
		if( flag == 1 )
		{
			// ����/ī��
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), FALSE );
			
			// ���¹�ȣ/ī���ȣ
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), FALSE );
			
			// �����ָ�
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), FALSE );
			
			// ������ ��ȭ��ȣ
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
			
			// ������ �������
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), FALSE );
			
			// �����ֿ� ����
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), FALSE );
			
			// �븮�θ�
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
			
			// �븮�� ��ȭ��ȣ
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
			// ����/ī��
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_BANK), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_BANK+1), TRUE );
			
			// ���¹�ȣ
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ACCOUNT), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ACCOUNT), TRUE );
			
			// �����ָ�
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_DEP_NM), TRUE );
			
			// ������ ��ȭ��ȣ
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
			
			// ������ �������
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_BRITHDAY), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_DEP_BRITHDAY), TRUE );
			
			// ������ ����
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_DEP_RELAT), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AT_DEP_RELAT+1), TRUE );
			
			// �븮�� ��
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_AT_ALT_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AT_ALT_NM), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_AT_ALT_NM), TRUE );
			
			// �븮�� ��ȭ��ȣ
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
	�Լ��� : ChkOzTransReqFlag
	��  �� : OZ_TRAN_REQ_FLAG ����
	Param  : 
	Return : 0 = �ٲ�� ����, 1 = NEW, 2 = CANCEL
	========================================================================================*/	
	long ChkOzTransReqFlag(void)
	{	
		char szMsg[150];
		char szTmp[256];
		long i;
		long j;
		
		// ������ ���
		if( g_lMobile_Use_Doc_Type == 1 )
		{
			// ������ ��쿡�� ������ ���������θ� �޾ƿ��� ������ 20, 30�̸� ���������� �Ǵ��Ѵ�.
			if( Str_Cmp(stMudData.PAYMENT_METHOD, "10" ) != 0)
			{
				return 1;
			}
		}
		// �̿��� ���
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
	�Լ��� : Snd_OzView
	��  �� : FR822566
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
		
		//���� ����༭ ������(������ ���� �ʿ���)
		JSON_SetValue( g_pjcomm, 'C', "cancel_payment_method",     stMudCancelData.PAYMENT_METHOD     );
		JSON_SetValue( g_pjcomm, 'C', "cancel_bnk_cd",             stMudCancelData.BNK_CD             );
		JSON_SetValue( g_pjcomm, 'C', "cancel_defray_account_num", stMudCancelData.DEFRAY_ACCOUNT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_relat_cd", stMudCancelData.DEPOSITOR_RELAT_CD );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMudCancelData.DEPOSITOR_NM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_nm",       szTmp );
		
		// 13�ڸ��� �ֹι�ȣ -> ���� 6�ڸ���
		// �ƴ� ���� ����ڹ�ȣ -> ��� �ѱ��
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
		
		// �ο����� ���Ե� ���
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
		
		//[FIXME] szSend_Info_Trans_yn ���� �߰� serv_add_yn üũ �ʿ� ��.
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
	�Լ��� : TR822566
	��  �� : CallBack TR822566
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
			if( MessageBoxEx (CONFIRM_YESNO, "��Ͽ� �����Ͽ����ϴ�.\n�ٽ� �����Ͻðڽ��ϱ�?")  == MB_OK)
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
	�Լ��� : ChkChgUserInfo
	��  �� : ������ ���� ����
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
	
		// ����
		if( Str_Cmp(stMudData.CUST_NM, stMudData_ORI.CUST_NM) != 0 )
		{
			return 1;
		}
		// ����
		else if( Str_Cmp(stMudData.GENDER, stMudData_ORI.GENDER) != 0 )
		{
			return 1;
		}
		// �������
		else if( Str_Cmp(szBefore_SocNum , szAfter_SocNUm) != 0 )
		{
			return 1;
		}

		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : setCardMove
	��  �� : ī�� MOVE
	Param  : 
	Return :
	========================================================================================*/	
	void setCardMove(void)
	{
		// ���Խű�
		if( g_lMobile_Inflow_Path == 0 )
		{
			Card_Move("C6101_LST");
		}
		// �ο� ����_�ű�
		else if( g_lMobile_Inflow_Path == 1 )
		{
			Card_Move("C6101_WINFO");
		}
		// ��������
		else if( g_lMobile_Inflow_Path == 2 )
		{
			Card_Move("SC_CONFIRM");
		}
		// ��ħ
		else if( g_lMobile_Inflow_Path == 3 )
		{
			Card_Move("GM_CUSTINFO");
		}
		// �跮��
		else if( g_lMobile_Inflow_Path == 4 )
		{
			Card_Move("C6301_CUSTINFO");
		}
		// �ο� ����_����
		else if( g_lMobile_Inflow_Path == 5 )
		{
			Card_Move("C6101_WINFO");
		}
		// ��Ÿ
		else
		{
			Card_Move("CM_MENU");
		}
	}
	
	/*=======================================================================================
	�Լ��� : Validation_Custinfo
	��  �� : ������ Validation
	Param  : 
	Return :
	========================================================================================*/	
	bool Validation_Custinfo(void)
	{
		long chk_1 = 0;
		long chk_2 = 0;
		
		// ����
		if( Str_Cmp( stMudData.CUST_NM, "" )  == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "������ �Է��ϼ���.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// �������
		if( Str_Len( stMudData.SOC_NUM ) != 6 )
		{
			MessageBoxEx(CONFIRM_OK, "��������� �Է��ϼ���.\n( EX : 991231 )");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// ��, ��
		if( Str_Cmp( stMudData.GENDER, "" )  == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "������ �����ϼ���.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// �ڵ��� or ��ȭ
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
			MessageBoxEx(CONFIRM_OK, "�ڵ��� Ȥ�� ��ȭ��ȣ�� �Է��ϼ���.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
			
			return FALSE;
		}
		
		// �ڵ���
		if( chk_1 > 0 )
		{
			if( Str_Len( stMudData.CP_DDD ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_1�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_2�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_3�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// ��ȭ
		if( chk_2 > 0 )
		{
			if( Str_Len( stMudData.OWNHOUSE_TEL_DDD ) < 2 )
			{
				MessageBoxEx(CONFIRM_OK, "��ȭ��ȣ_1�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
			
				return FALSE;
			}
			
			if( Str_Len( stMudData.OWNHOUSE_TEL_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "��ȭ��ȣ_2�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.OWNHOUSE_TEL_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "��ȭ��ȣ_3�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// �̸���
		chk_1 = 0;
		chk_2 = 0;
		
		chk_1 += Str_Len( stMudData.EMAIL_REQ_ID );
		chk_2 += Str_Len( stMudData.EMAIL_REQ_ADDR );
		
		if( chk_1 + chk_2 > 0 )
		{
			if( Str_Len( stMudData.EMAIL_REQ_ID ) <= 0 || Str_Len( stMudData.EMAIL_REQ_ADDR ) <= 0 )
			{
				MessageBoxEx(CONFIRM_OK, "�̸����� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// ���û�����
		if( Str_Cmp( stMudData.BILING_METHOD, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "���û������� �����ϼ���.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
				
			return FALSE;
		}
		
		// �̸��� û��
		if( Str_Cmp( stMudData.BILING_METHOD, "40" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "14" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "48" ) == 0)
		{
			if( Str_Len( stMudData.EMAIL_REQ_ID ) <= 0 || Str_Len( stMudData.EMAIL_REQ_ADDR ) <= 0 )
			{
				MessageBoxEx(CONFIRM_OK, "�̸����� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		
		// LMS û��
		if( Str_Cmp( stMudData.BILING_METHOD, "70" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "17" ) == 0 || Str_Cmp( stMudData.BILING_METHOD, "78" ) == 0 )
		{
			if( Str_Len( stMudData.CP_DDD ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_1�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_2�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_3�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}

		//20220216 ���߰����� ���� û���� �߼۹�� Validate
		if( Str_Cmp( stMudData.BILING_METHOD, "47" ) == 0)
		{
			if( Str_Len( stMudData.EMAIL_REQ_ID ) <= 0 || Str_Len( stMudData.EMAIL_REQ_ADDR ) <= 0 )
			{
				MessageBoxEx(CONFIRM_OK, "�̸����� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			if( Str_Len( stMudData.CP_DDD ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_1�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_EXN ) < 3 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_2�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
			
			if( Str_Len( stMudData.CP_NUM ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "�ڵ�����ȣ_3�� Ȯ���ϼ���.");
				
				ON_EXIT();
				OnInit(INIT_CUSTINFO);
				
				return FALSE;
			}
		}
		// ���ι��
		if( Str_Cmp( stMudData.PAYMENT_METHOD, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "���ι���� �����ϼ���.");
			
			ON_EXIT();
			OnInit(INIT_CUSTINFO);
				
			return FALSE;
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	�Լ��� : Validation_Agree
	��  �� : �������� Ȱ�� ���Ǽ� Validation
	Param  : 
	Return :
	========================================================================================*/	
	bool Validation_Agree(void)
	{
		if( m_lAgreeChk_Ok_Validation == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "���Ǽ� ���� ���θ� üũ�� �ּ���");
			
			ON_EXIT();
			OnInit(INIT_FIRST_AGREE);
			
			return FALSE;
		}
		
		if( Str_Cmp( stMudData.INFO_USE_AGREE_YN, "" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "�������� ���� �� �̿� ����\n����/�̵��Ǹ� �������ּ���.");

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
			MessageBoxEx(CONFIRM_OK, "�������� ���� �� �̿� ���Ǵ�\n[����]�� �����մϴ�.");

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
			MessageBoxEx(CONFIRM_OK, "����(�ſ�)���� ���� ����\n����/�̵��Ǹ� �������ּ���.");
			
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
			MessageBoxEx(CONFIRM_OK, "����(�ſ�)���� ���� ���Ǵ�\n[����]�� �����մϴ�.");
			
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
			MessageBoxEx(CONFIRM_OK, "����(�ſ�)���� ��ȸ\n����/�̵��Ǹ� �������ּ���.");
			
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
			MessageBoxEx(CONFIRM_OK, "�����ĺ����� ���� �� �����޴� ����\n����/�̵��Ǹ� �������ּ���.");
			
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
			MessageBoxEx(CONFIRM_OK, "������ ���� �� �������� Ȱ�� ����\n����/�̵��Ǹ� �������ּ���.");
			
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
	�Լ��� : Validation_PayMethod
	��  �� : ���ι�� Validation
	Param  : flag : 0 = Ȯ�ι�ư_CHK X, 1= Ȯ�ι�ư_CHK O
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
					MessageBoxEx(CONFIRM_OK, "����/ī�������� ������.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
				
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.DEFRAY_ACCOUNT_NUM, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "����/ī���ȣ�� �Է��ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.DEPOSITOR_NM, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "�����ָ��� �Է��ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_TEL_DDD ) < 2 )
				{
					MessageBoxEx(CONFIRM_OK, "������ ��ȭ��ȣ_1�� Ȯ���ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_TEL_EXN ) < 3 )
				{
					MessageBoxEx(CONFIRM_OK, "������ ��ȭ��ȣ_2�� Ȯ���ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_TEL_NUM ) < 4 )
				{
					MessageBoxEx(CONFIRM_OK, "������ ��ȭ��ȣ_3�� Ȯ���ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.DEPOSITOR_BIRTH_DATE ) < 6 )
				{
					MessageBoxEx(CONFIRM_OK, "������ �������( EX : 991231 )\n Ȥ�� ����ڹ�ȣ�� Ȯ���ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.DEPOSITOR_RELAT_CD, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "�����ֿ� ���踦 �����ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Cmp( stMudData.REQ_NM, "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "�븮�θ��� �Է��ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}	
				
				if( Str_Len( stMudData.REQ_TEL_DDD ) < 2 )
				{
					MessageBoxEx(CONFIRM_OK, "�븮�� ��ȭ��ȣ_1�� Ȯ���ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.REQ_TEL_EXN ) < 3 )
				{
					MessageBoxEx(CONFIRM_OK, "�븮�� ��ȭ��ȣ_2�� Ȯ���ϼ���.");
					
					ON_EXIT();
					OnInit(INIT_AUTOTRANS);
					
					return FALSE;
				}
				
				if( Str_Len( stMudData.REQ_TEL_NUM ) < 4 )
				{
					MessageBoxEx(CONFIRM_OK, "�븮�� ��ȭ��ȣ_3�� Ȯ���ϼ���.");
					
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
				MessageBoxEx(CONFIRM_OK, "���ι���� Ȯ�ι�ư�� �����ּ���.");
				
				ON_EXIT();
				OnInit(INIT_AUTOTRANS);
						
				return FALSE;
			}
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	�Լ��� : SetTitle
	��  �� : Title Setting
	Param  : 
	Return :
	========================================================================================*/	
	void SetTitle(void)
	{
		Mem_Set((byte*)m_szTitle, 0x00, sizeof(m_szTitle));
		
		// ��༭ Ÿ�� : 1 = ���Խű�, 2 = ��������, 3 = ���Ǻ���, 4 = �ű�
		if( g_lMobile_Use_Doc_Type == 1 )
		{
			Str_Cpy( m_szTitle, "[����] ���ð��� ����û(���)��" );
		}
		else if( g_lMobile_Use_Doc_Type == 2 )
		{
			Str_Cpy( m_szTitle, "[��.��] ���ð��� ����û(���)��" );
		}
		else if( g_lMobile_Use_Doc_Type == 3 )
		{
			Str_Cpy( m_szTitle, "[��.��] ���ð��� ����û(���)��" );
		}
		else if ( g_lMobile_Use_Doc_Type == 4 )
		{
			Str_Cpy( m_szTitle, "[�ű�] ���ð��� ����û(���)��" );
		}
	}
}
