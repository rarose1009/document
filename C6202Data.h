/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		C6202DATA_H
#define		C6202DATA_H

//-----------------------------------------------------------------------------------------------	
// 	체납활동 대상
//-----------------------------------------------------------------------------------------------	
	typedef struct _NOPAYOBJ
	{
		char ROWID               [5  +1];
		char USE_CONT_NUM        [10 +1];
		char BASE_YMD            [8  +1];
		char CONT_YMD            [8  +1];
		char CNL_YMD             [8  +1];
		char PAY_METHOD          [2  +1];
		char DEADLINE_FLAG       [20 +1];
		char CONT_STS_CD         [2  +1];
		char NONPAY_OBJ_FLAG     [2  +1];
		char NONPAY_MANAGE_FLAG  [2  +1];
		char NONPAY_MANAGE_AMT   [10 +1];
		char WARR_AMT_SUM        [10 +1];
		char UNPAY_AMT_SUM       [10 +1];
		char NONPAY_MM_CNT       [10 +1];
		char ZIP_NO1             [3  +1];
		char ZIP_NO2             [3  +1];
		char CITY                [30 +1];
		char AREA                [30 +1];
		char TOWN                [30 +1];
		char VILLAGE             [30 +1];
		char ADDR1_M             [30 +1];
		char ADDR1_S             [30 +1];
		char CO_LIVE_NM          [60 +1];
		char DONG_NUM            [20 +1];
		char HOSU                [20 +1];
		char BLD_NM              [60 +1];
		char DETAIL_FLOOR        [20 +1];
		char NEW_ADDR_UNION      [300+1];
		char CUST_NUM            [10 +1];
		char CUST_TYPE_CD        [2  +1];
		char CUST_NM             [30 +1];
		char FIRM_NM             [50 +1];
		char BIZ_REGI_NUM        [10 +1];
		char SOC_NUM             [13 +1];
		char REPRE_NM            [30 +1];
		char CP_DDD              [6  +1];
		char CP_EXN              [6  +1];
		char CP_NUM              [6  +1];
		char OWNHOUSE_TEL_DDD    [6  +1];
		char OWNHOUSE_TEL_EXN    [6  +1];
		char OWNHOUSE_TEL_NUM    [6  +1];
		char PAY_CUST_NUM        [10 +1];
		char PAY_CUST_TYPE_CD    [2  +1];
		char PAY_CUST_NM         [30 +1];
		char PAY_FIRM_NM         [50 +1];
		char PAY_BIZ_REGI_NUM    [10 +1];
		char PAY_SOC_NUM         [13 +1];
		char PAY_REPRE_NM        [30 +1];
		char PAY_CP_NUM          [50 +1];
		char PAY_TEL_NUM         [50 +1];
		char OWNER_CUST_NUM      [10 +1];
		char OWNER_CUST_TYPE_CD  [2  +1];
		char OWNER_CUST_NM       [30 +1];
		char OWNER_FIRM_NM       [50 +1];
		char OWNER_BIZ_REGI_NUM  [10 +1];
		char OWNER_SOC_NUM       [13 +1];
		char OWNER_REPRE_NM      [30 +1];
		char OWNER_CP_NUM        [50 +1];
		char OWNER_TEL_NUM       [50 +1];
		char NONPAY_ACTIVE_DEPT  [4  +1];
		char NONPAY_MANAGE_ZONE  [6  +1];
		char TAKER_NM            [30 +1];
		char RMK                 [300+1];
		char STOP_FLAG           [2  +1];
		char CUST_FLAG           [1  +1];
		char ACCEPT_AMT          [20 +1];
		char SEL_M_CNT           [20 +1];
		char VISIT_FLAG          [1  +1];
		char CUT_FLAG            [1  +1];
		char AUTO_FLAG           [1  +1];
		char RELE_FLAG           [1  +1];
		char RCEI_FLAG           [1  +1];
		char RSLT_NOTICE_YN      [1  +1];
		char OBJ_PERS_SOC_NUM    [15 +1];
		char LAW_ETC_AMT         [10 +1];
		char DEBT_AMT            [10 +1];
		char DEBT_UNPAY_AMT      [10 +1];
		char ALL_UNPAY           [10 +1];
		char LAW_TOWN            [30 +1];
		char NEW_ROAD_NM         [200+1];
		char NEW_ADDR_M          [5  +1];
		char NEW_ADDR_S          [5  +1];
		char CURR_ADDR_UNION     [300+1];
		char ENER_VOUCH_YN       [1  +1];
		char EARLY_ALAM_YN       [1  +1];
		char VISIT_REG_YN        [1  +1];
		char WARR_YN             [1  +1];
		char READ_MEMO_YN        [1  +1];
		char INST_PLACE_NUM      [13 +1];
		char REAL_NM_CONF_YN     [2  +1];
		char SAFE_KEY_YN         [2  +1];
		char UNPAY_AMT			 [20 +1];
		char UNPAY_MONTH		 [15 +1];
		char RELEASE_YN			 [2  +1];
		char STOP_YN    		 [2  +1];
		char PAYCONFIRM_FLAG     [5  +1];
		char USE_CD              [2  +1];
		char EXCEP_TEL_YN		 [1  +1];
		char STOP_SMS_YN         [1  +1];
		char PAY_DELAY_YN        [1  +1];
	}	NOPAYOBJ;
	global NOPAYOBJ stNoPayObj;


//-----------------------------------------------------------------------------------------------	
// 	해제활동 대상
//-----------------------------------------------------------------------------------------------	
	typedef struct _CLEAR
	{
		char ROWID                 [5  +1];
		char MTR_NUM               [10 +1];
		char PROD_CONT_SEQ         [30 +1];
		char INDI_COMPENS_CUT_VA   [9  +1];
		char INDI_COMPENS_CUT_VC   [9  +1];
		char KEEPER_YN             [30 +1];
		char CITY                  [30 +1];
		char AREA                  [30 +1];
		char TOWN                  [30 +1];
		char VILLAGE               [30 +1];
		char ADDR1_M               [30 +1];
		char ADDR1_S               [30 +1];
		char CO_LIVE_NM            [30 +1];
		char DONG_NUM              [30 +1];
		char HOSU                  [30 +1];
		char BLD_NM                [30 +1];
		char DETAIL_FLOOR          [30 +1];
		char NEW_ADDR_UNION        [300+1];
		char RMK                   [300+1];
		char SEQ                   [9  +1];
		char USE_CONT_NUM          [30 +1];
		char BASE_DTM              [30 +1];
		char NONPAY_MM_CNT         [9  +1];
		char NONPAY_AMT            [10 +1];
		char WHY_CD                [30 +1];
		char REQ_EMPID             [30 +1];
		char TREAT_EMPID           [30 +1];
		char CUT_YMD               [30 +1];
		char CUT_TYPE_CD           [30 +1];
		char GMTR_OBJ_FLAG         [30 +1];
		char INDI_MTR_CUT          [9  +1];
		char MTR_ID_NUM            [30 +1];
		char PROC                  [1  +1];
		char CUT_JOB_FLAG          [2  +1];
		char CURRENT_VA            [9  +1];
		char CURRENT_VC            [9  +1];
		char CURRENT_VM            [9  +1];
		char SEALED_STS            [10 +1];
		char CUT_CNL_FEE_EXEMPT_WHY[100+1];
		char CUT_CNL_FEE_YN        [2  +1];
		char NONPAY_ACTIVE_DEPT    [4  +1];
		char NONPAY_MANAGE_ZONE    [6  +1];
		char INST_PLACE_NUM        [9  +1];
		char RSLT_NOTICE_YN        [1  +1];
		char LAW_ETC_AMT           [10 +1];
		char DEBT_AMT              [10 +1];
		char DEBT_UNPAY_AMT        [10 +1];
		char ALL_UNPAY             [10 +1];
		char LAW_TOWN              [30 +1];
		char NEW_ROAD_NM           [200+1];
		char NEW_ADDR_M            [5  +1];
		char NEW_ADDR_S            [5  +1];
		char CURR_ADDR_UNION       [300+1];
		char MTR_KIND              [50 +1];
		char RELEASE_YN			   [2  +1];
		char STOP_YN    		   [2  +1];
	}	CLEAR;
	global CLEAR stClear;


//-----------------------------------------------------------------------------------------------	
// 	수납내역
//-----------------------------------------------------------------------------------------------	
	typedef struct _RECEIPT
	{
		char PDA_DUTY_FLAG            [10 +1];
		char CUST_NM                  [30 +1];
		char AREA                     [30 +1];
		char TOWN                     [30 +1];
		char VILLAGE                  [30 +1];
		char ADDR1_M                  [30 +1];
		char ADDR1_S                  [30 +1];
		char CO_LIVE_NM               [30 +1];
		char BLD_NM                   [30 +1];
		char HOSU                     [30 +1];
		char DETAIL_FLOOR             [30 +1];
		char LAW_TOWN                 [30 +1];
		char NEW_ROAD_NM              [30 +1];
		char NEW_ADDR_M               [30 +1];
		char NEW_ADDR_S               [30 +1];
		char ACCOUNT                  [30 +1];
		char ONCE_ACCOUNT             [30 +1];
		char TOT_ACCOUNT			  [50 +1];
		char USE_CONT_NUM             [30 +1];
		char CUST_NUM                 [30 +1];
	}	RECEIPT;
	global RECEIPT stReceipt;


#endif
