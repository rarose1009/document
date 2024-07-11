/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		MWDATA_H
#define		MWDATA_H

//-----------------------------------------------------------------------------------------------	
// 	¹Î¿ø ´ë»ó 
//-----------------------------------------------------------------------------------------------	
typedef struct _MWINFO
{
	char szPROMISE_ASSIGN_SEQ    [10 +1]; //
	char szPDA_IP                [15 +1]; //
	char szUPD_EMPID             [20 +1]; //
	char szREG_FLAG              [2  +1]; //
	char szBRANCH_CD             [6  +1]; //
	char szCENTER_CD             [2  +1]; //
	char szASSIGN_EMPID          [9  +1]; //
	char szCUST_NUM              [10 +1]; //
	char szUSE_CONT_NUM          [10 +1]; //
	char szINST_PLACE_NUM        [9  +1]; //
	char szZIP_SEQ               [10 +1]; //
	char szETC_ADDR              [100+1]; //
	char szCIVIL_SERV_CLASS_CD   [6  +1]; //
	char szPROMISE_YMD           [8  +1]; //
	char szPROMISE_TIME          [4  +1]; //
	char szEND_EXPECT_TIME       [4  +1]; //
	char szJOB_STR_DTM           [14 +1]; //
	char szJOB_END_DTM           [14 +1]; //
	char szPROMISE_ASSIGN_DESC   [500+1]; //
	char szCIVIL_SERV_RECEIVE_NUM[14 +1]; //
	char szTREAT_SEQ             [10 +1]; //
	char szPROC_STS_CD           [2  +1]; //
	char szPDA_NUM               [5  +1]; //
	char szONCE_PAY              [10 +1]; //
	char szSEND_YN               [1  +1]; //
	char szCIVIL_SERV_CLASS_NM   [50 +1]; //
	char szPDA_DUTY              [20 +1]; //
	char szREQ_TEL_DDD           [4  +1]; //
	char szREQ_TEL_EXN           [4  +1]; //
	char szREQ_TEL_NUM           [4  +1]; //
	char szREQ_CP_DDD            [4  +1]; //
	char szREQ_CP_EXN            [4  +1]; //
	char szREQ_CP_NUM            [4  +1]; //
	char szTRANS_IN_CUST_NM      [50 +1]; //
	char szTRANS_IN_SOC_NUM      [13 +1]; //
	char szREQ_NM                [50 +1]; //
	char szREQ_SOC_NUM           [13 +1]; //
	char szRECEIVE_DTM           [20 +1]; //
	char szCUST_TYPE_CD          [2  +1]; //
	char szCUST_NM               [30 +1]; //
	char szFIRM_NM               [50 +1]; //
	char szSOC_NUM               [13 +1]; //
	char szBIZ_REGI_NUM          [10 +1]; //
	char szCP_DDD                [4  +1]; //
	char szCP_EXN                [4  +1]; //
	char szCP_NUM                [4  +1]; //
	char szOWNHOUSE_TEL_DDD      [4  +1]; //
	char szOWNHOUSE_TEL_EXN      [4  +1]; //
	char szOWNHOUSE_TEL_NUM      [4  +1]; //
	char szFIRM_TEL_DDD          [4  +1]; //
	char szFIRM_TEL_EXN          [4  +1]; //
	char szFIRM_TEL_NUM          [4  +1]; //
	char szSCG_RELAT_CD          [2  +1]; //
	char szEMAIL                 [50 +1]; //
	char szFAMILY_CNT            [10 +1]; //
	char szCUST_TRND_CD          [2  +1]; //
	char szCHK                   [1  +1]; //
	char szBUILT_IN_YN           [2  +1]; //
	char szSQUARE_METER          [5  +1]; //
	char szCURR_ADDR_UNION       [50 +1]; //
	char szBLD_FLOOR             [20 +1]; //
	char szHOUSE_CNT             [10 +1]; //
	char szPDA_DUTY_FLAG         [10 +1]; //
	char szPAY_CALU              [10 +1]; //
	char szPDA_TRANS_FLAG        [5  +1]; //
	char szREQ_INFO_NUM          [10 +1]; //
	char szTRANS_IN_CUST_NUM     [10 +1]; //
	char szCONT_STS_CD           [2  +1]; //
	char szPDA_READ_DTM          [15 +1]; //
	char szMEMO                  [500+1]; //
	char szAUTO_YN               [1  +1]; //
	char szCUST_YN               [1  +1]; //
	char szBUR_YN                [1  +1]; //
	char szPROD_YN               [1  +1]; //
	char szONCE_YN               [1  +1]; //
	char szPRICE_YN              [1  +1]; //
	char szZIP_NO1               [10 +1]; //
	char szZIP_NO2               [10 +1]; //
	char szCITY                  [20 +1]; //
	char szCOUNTY                [20 +1]; //
	char szTOWN                  [20 +1]; //
	char szVILLAGE_RI            [20 +1]; //
	char szVILLAGE               [30 +1]; //
	char szBUILDING              [20 +1]; //
	char szADDR1_M               [10 +1]; //
	char szADDR1_S               [10 +1]; //
	char szACCOUNT               [10 +1]; //
	char szONCE_ACCOUNT          [10 +1]; //
	char szCHK_TIME_FROM         [16 +1]; //
	char szCHK_TIME_END          [16 +1]; //
	char szMTR_CHG_YN            [1  +1]; //
	char szINFO_USE_AGREE_YN     [2  +1]; //
	char szPAS_USE_CONT_NUM_YN   [1  +1]; //
	char szADJ_ALT_AMT           [10 +1]; //
	char szPAS_DEFRAY_ACCOUNT_NUM[20 +1]; //
	char szPAS_CUST_NUM          [10 +1]; //
	char szPAS_REQ_INFO_NUM      [10 +1]; //
	char szAPPRO_NUM             [10 +1]; //
	char szADJ_CAUSE             [2  +1]; //
	char szDEADLINE_FLAG         [2  +1]; //
	char szGMTR_BASE_DAY         [2  +1]; //
	char szCARD_GASPAY           [10 +1]; //
	char szCARD_ONEPAY           [1  +1]; //
	char szCASH_GASPAY           [10 +1]; //
	char szINFO_USE_YN           [1  +1]; //
	char szUSE_CONT_DOC_YN       [1  +1]; //
	char szPAY_METHOD            [10 +1]; //
	char szDEFRAY_ACCOUNT_NUM    [20 +1]; //
	char szDEPOSITOR_NM          [16 +1]; //
	char szBANK_NM               [10 +1]; //
	char szDEBT_AMT              [10 +1]; //
	char szLAW_ETC_AMT           [10 +1]; //
	char szLAW_TOWN              [10 +1]; //
	char szNEW_ROAD_NM           [30 +1]; //
	char szNEW_ADDR_M            [10 +1]; //
	char szNEW_ADDR_S            [10 +1]; //
	char szNEW_ADDR_UNION        [50 +1]; //
	char szBILL_GUBUN            [2  +1]; //
	char szTRANS_CONN_YN         [1  +1]; //
	char szCONN_YN               [1  +1]; //
	char szBAR_YN                [1  +1]; //
	char szBAR_GBN               [2  +1]; //
	char szBAR_WHY               [2  +1]; //
	char szCHK_YN                [1  +1]; //
}	MWINFO;
global MWINFO stMw;



typedef struct _MWMTR
{
	char szPROMISE_ASSIGN_SEQ    [10+1]; //
	char szMTR_NUM               [9 +1]; //
	char szPDA_IP                [15+1]; //
	char szUPD_EMPID             [20+1]; //
	char szCIVIL_SERV_RECEIVE_NUM[15+1]; //
	char szTREAT_SEQ             [10+1]; //
	char szINST_PLACE_NUM        [9 +1]; //
	char szUSE_CONT_NUM          [10+1]; //
	char szMTR_ID_NUM            [20+1]; //
	char szMTR_GRD               [7 +1]; //
	char szMTR_FORM              [2 +1]; //
	char szMTR_FORM_NM           [50+1]; //
	char szMTR_TYPE              [2 +1]; //
	char szMTR_TYPE_NM           [50+1]; //
	char szMTR_REMOTE_FLAG       [2 +1]; //
	char szMTR_REMOTE_FLAG_NM    [50+1]; //
	char szMTR_KIND              [2 +1]; //
	char szMTR_KIND_NM           [50+1]; //
	char szMTR_DIGIT_CNT         [10+1]; //
	char szMTR_NEW_FIX_FLAG      [2 +1]; //
	char szMTR_VALID_YM          [6 +1]; //
	char szMTR_APPRO_YN          [1 +1]; //
	char szSEALED_YMD            [8 +1]; //
	char szSEALED_STS            [2 +1]; //
	char szCHK_BAR_ADHERE_YMD    [8 +1]; //
	char szCHK_BAR_ADHERE_STS    [2 +1]; //
	char szMTR_DETA_LOC          [30+1]; //
	char szKEEPER_YN             [2 +1]; //
	char szREVIS_FLAG            [2 +1]; //
	char szMTR_LOC_FLAG          [2 +1]; //
	char szMTR_LOC_FLAG_NM       [50+1]; //
	char szMTR_INST_HEIGHT       [20+1]; //
	char szMTR_RESOU_FLAG        [2 +1]; //
	char szMTR_SUPPLY_STS        [2 +1]; //
	char szMTR_SUPPLY_STS_NM     [50+1]; //
	char szMTR_MODEL_CD          [5 +1]; //
	char szMTR_MODEL_NM          [50+1]; //
	char szCOMPENS_MODEL_NM      [50+1]; //
	char szPROD_CONT_SEQ         [3 +1]; //
	char szPROD_CONT_YMD         [8 +1]; //
	char szBIZ_TYPE_CD           [6 +1]; //
	char szPROD_CD               [5 +1]; //
	char szPROD_NM               [50+1]; //
	char szPROD_AREA_FLAG        [2 +1]; //
	char szCONT_FLAG_CD          [2 +1]; //
	char szPROD_STS_CD           [2 +1]; //
	char szCONT_REVIS_PARA       [10+1]; //
	char szCUT_YMD               [8 +1]; //
	char szCUT_TYPE_CD           [2 +1]; //
	char szCUT_TREAT_EMPID       [9 +1]; //
	char szCUT_WHY_CD            [2 +1]; //
	char szCUT_CNL_YMD           [8 +1]; //
	char szINDI_CUT_VC_AFTER     [10+1]; //
	char szINDI_CUT_VA_AFTER     [10+1]; //
	char szINDI_CUT_VM_AFTER     [10+1]; //
	char szINDI_CUT_YMD          [8 +1]; //
	char szINDI_TYPE_CD          [2 +1]; //
	char szINDI_TYPE_NM          [50+1]; //
	char szINDI_VC_AFTER         [10+1]; //
	char szINDI_VA_AFTER         [10+1]; //
	char szINDI_VM_AFTER         [10+1]; //
	char szINDI_VC               [10+1]; //
	char szINDI_VA               [10+1]; //
	char szINDI_VM               [10+1]; //
	char szNONPAY                [10+1]; //
	char szACCOUNT               [9 +1]; //
	char szTOTALCOUNT            [9 +1]; //
	char szSEND_YN               [1 +1]; //
	char szADJ_CHK               [1 +1]; //
	char szCNL_WHY_CD            [2 +1]; //
	char szCUT_CNL_FEE_YN        [1 +1]; //
	char szCUT_CNL_FEE_EXEMPT_WHY[2 +1]; //
	char szADJ_ALT_AMT           [9 +1]; //
	char szTOT_USE_QTY           [9 +1]; //
	char szREQ_YM                [6 +1]; //
	char szDEADLINE_FLAG         [2 +1]; //
	char szCHK_YN                [1 +1]; //
	char szADJ_YMD               [8 +1]; //
	char szUSE_PERIOD_STR        [8 +1]; //
	char szUSE_PERIOD_END        [8 +1]; //
	char szCARD_YN               [1 +1]; //
	char szTOT_ENER_QTY          [10+1]; //
	char szTOT_REVIS_QTY         [10+1]; //
	char szSUPPLY_UNIT_ENER      [10+1]; //
	char szBILL_GUBUN            [2 +1]; //
}	MWMTR;
	
typedef struct _MWBUR
{
	char szPROMISE_ASSIGN_SEQ    [10+1]; //
	char szMTR_NUM               [10+1]; //
	char szBURNER_NUM            [10+1]; //
	char szPDA_IP                [15+1]; //
	char szUPD_EMPID             [20+1]; //
	char szCIVIL_SERV_RECEIVE_NUM[2 +1]; //
	char szTREAT_SEQ             [10+1]; //
	char szINST_PLACE_NUM        [20+1]; //
	char szBURNER_CLASS_CD       [20+1]; //
	char szBURNER_KIND_NUM       [20+1]; //
	char szBURNER_KIND_NM        [20+1]; //
	char szBURNER_MODEL_CD       [20+1]; //
	char szBURNER_CAPA           [10+1]; //
	char szBURNER_CAPA_UNIT      [20+1]; //
	char szBURNER_CAPA_UNIT_NM   [20+1]; //
	char szBURNER_INST_YMD       [8 +1]; //
	char szBURNER_REMOV_YMD      [8 +1]; //
	char szBURNER_MODEL_NM       [20+1]; //
	char szBURNER_QTY            [10+1]; //
	char szMAKER_NM              [20+1]; //
	char szBOILER_FORM           [20+1]; //
	char szBOILER_FORM_NM        [20+1]; //
	char szMAKE_NUM              [20+1]; //
	char szMAKE_YMD              [8 +1]; //
	char szWORK_DOCU_RECEIVE_YMD [8 +1]; //
	char szINST_FLAG             [20+1]; //
	char szINST_LOC              [20+1]; //
	char szINST_LOC_NM           [20+1]; //
	char szBOILER_INST_FIRM_CD   [20+1]; //
	char szBOILER_INST_FIRM_NM   [20+1]; //
	char szDATA_FLAG             [2 +1]; //
	char szMTR_ID_NUM            [15+1]; //
	char szSEND_YN               [1 +1]; //
	char szMAKER_NUM             [8 +1]; //
	char szSPECIAL_YN			 [1 +1]; //
}	MWBUR;

typedef struct _MWCUST
{
	char szPROMISE_ASSIGN_SEQ    [10+1]; //
	char szCIVIL_SERV_RECEIVE_NUM[14+1]; //
	char szTREAT_SEQ             [10+1]; //
	char szUSE_CONT_NUM          [10+1]; //
	char szCNT                   [10+1]; //
	char szUNPAY_AMT             [10+1]; //
	char szCUST_NUM              [10+1]; //
	char szCUST_TYPE_CD          [2 +1]; //
	char szCUST_NM               [30+1]; //
	char szFIRM_NM               [50+1]; //
	char szSOC_NUM               [13+1]; //
	char szBIZ_REGI_NUM          [10+1]; //
	char szCP_DDD                [4 +1]; //
	char szCP_EXN                [4 +1]; //
	char szCP_NUM                [4 +1]; //
	char szOWNHOUSE_TEL_DDD      [4 +1]; //
	char szOWNHOUSE_TEL_EXN      [4 +1]; //
	char szOWNHOUSE_TEL_NUM      [4 +1]; //
	char szFIRM_TEL_DDD          [4 +1]; //
	char szFIRM_TEL_EXN          [4 +1]; //
	char szFIRM_TEL_NUM          [4 +1]; //
	char szSCG_RELAT_CD          [2 +1]; //
	char szEMAIL                 [50+1]; //
	char szFAMILY_CNT            [10+1]; //
	char szCUST_TRND_CD          [2 +1]; //
	char szDEFRAY_ACCOUNT_NUM    [20+1]; //
	char szREQ_INFO_NUM          [10+1]; //
	char szDEPOSITOR_NM          [20+1]; //
	char szBANK_NM               [50+1]; //
}	MWCUST;

typedef struct _MWNONPAY
{
	char PROMISE_ASSIGN_SEQ    [10+1]; //
	char CIVIL_SERV_RECEIVE_NUM[14+1]; //
	char TREAT_SEQ             [10+1]; //
	char USE_CONT_NUM          [10+1]; //
	char MTR_NUM               [9 +1]; //
	char REQ_YM                [6 +1]; //
	char PROD_CONT_SEQ         [3 +1]; //
	char DEADLINE_FLAG         [2 +1]; //
	char USE_QTY               [15+1]; //
	char INDI_COMPENS_VC       [10+1]; //
	char SUBTR_REQ_AMT         [10+1]; //
	char UNPAY_AMT             [10+1]; //
	char CENTER_CD             [4 +1]; //
	char UPD_EMPID             [20+1]; //
	char PDA_IP                [15+1]; //
	char REQ_MANAGE_STS        [20+1]; //
	char PAY_YMD               [8 +1]; //
	char USE_PERIOD_STR        [8 +1]; //
	char USE_PERIOD_END        [8 +1]; //
	char CHK                   [1 +1]; //
	char SEND_YN               [1 +1]; //
	char CARD_YN               [1 +1]; //
	char TOT_ENER_QTY          [10+1]; //
	char TOT_REVIS_QTY         [10+1]; //
	char SUPPLY_UNIT_ENER      [10+1]; //
}	MWNONPAY;

#endif

