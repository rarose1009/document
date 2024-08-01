/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		C6301DATA_H
#define		C6301DATA_H

//-----------------------------------------------------------------------------------------------	
// 	공급전 대상
//-----------------------------------------------------------------------------------------------	
	typedef struct _MTRCHGINFO
	{
		char ROWID                   [3  +1];
		char MTR_NUM                 [9  +1];
		char OBJ_CRT_YMD             [8  +1];
		char REPL_OCCU_FLAG          [2  +1];
		char CENTER_CD               [2  +1];
		char PDA_REPL_JOB_ITEM       [2  +1];
		char INST_PLACE_NUM          [9  +1];
		char CITY                    [30 +1];
		char AREA                    [30 +1];
		char TOWN                    [30 +1];
		char VILLAGE                 [30 +1];
		char ADDR1_M                 [30 +1];
		char ADDR1_S                 [30 +1];
		char LOT_NUM_SECOND_ADDR     [100+1];
		char CO_LIVE_NM              [60 +1];
		char HOUSE_CNT               [6  +1];
		char BLD_NM                  [150+1];
		char DETA_FLOOR              [6  +1];
		char CUST_NUM                [10 +1];
		char CUST_TYPE_CD            [2  +1];
		char CUST_NM                 [30 +1];
		char FIRM_NM                 [50 +1];
		char BIZ_REGI_NUM            [10 +1];
		char SOC_NUM                 [13 +1];
		char REPRE_NM                [30 +1];
		char CP_DDD                  [4  +1];
		char CP_EXN                  [4  +1];
		char CP_NUM                  [4  +1];
		char OWNHOUSE_TEL_DDD        [4  +1];
		char OWNHOUSE_TEL_EXN        [4  +1];
		char OWNHOUSE_TEL_NUM        [4  +1];
		char FIRM_TEL_DDD            [4  +1];
		char FIRM_TEL_EXN            [4  +1];
		char FIRM_TEL_NUM            [4  +1];
		char USE_CONT_NUM            [10 +1];
		char PROD_NM                 [50 +1];
		char CONT_YMD                [8  +1];
		char CNL_YMD                 [8  +1];
		char MTR_ID_NUM              [25 +1];
		char MTR_MODEL_CD            [6  +1];
		char MTR_GRD                 [7  +1];
		char MTR_FORM                [2  +1];
		char MTR_TYPE                [2  +1];
		char MTR_REMOTE_FLAG         [2  +1];
		char MTR_KIND                [3  +1];
		char MTR_FORM_APPRO_YN       [6  +1];
		char MTR_DIGIT_CNT           [4  +1];
		char MTR_NEW_FIX_FLAG        [2  +1];
		char FIX_FIRM_NM_CD          [2  +1];
		char MTR_VALID_YM            [6  +1];
		char MTR_LOC_FLAG            [2  +1];
		char MTR_DETA_LOC            [30 +1];
		char COMPENS_NUM             [8  +1];
		char COMPENS_ID_NUM          [20 +1];
		char COMPENS_MODEL_CD        [8  +1];
		char COMPENS_FLAG            [2  +1];
		char COMPENS_VALID_YM        [6  +1];
		char COMPENS_FORM_APPRO_YN   [6  +1];
		char BEFO_INDI_VM            [9  +1];
		char BEFO_INDI_VA            [9  +1];
		char BEFO_INDI_VC            [9  +1];
		char REPL_STS                [2  +1];
		char ZIP_NO1                 [3  +1];
		char ZIP_NO2                 [3  +1];
		char MTR_FEE_FREE_FLAG       [1  +1];
		char MTR_REPL_WHY            [6  +1];
		char MTR_BAR                 [20 +1];
		char AFTER_MTR_ID_NUM        [25 +1];
		char AFTER_MTR_MODEL_CD      [8  +1];
		char AFTER_MTR_GRD           [6  +1];
		char AFTER_MTR_FORM          [2  +1];
		char AFTER_MTR_TYPE          [2  +1];
		char AFTER_MTR_REMOTE_FLAG   [2  +1];
		char AFTER_MTR_KIND          [2  +1];
		char AFTER_MTR_DIGIT_CNT     [4  +1];
		char AFTER_MTR_NEW_FIX_FLAG  [2  +1];
		char AFTER_FIX_FIRM_NM_CD    [2  +1];
		char AFTER_MTR_VALID_YM      [6  +1];
		char COMPENS_FEE_FREE_FLAG   [1  +1];
		char COMPENS_REPL_WHY        [2  +1];
		char COMPENS_BAR             [30 +1];
		char AFTER_COMPENS_NUM       [15 +1];
		char AFTER_COMPENS_ID_NUM    [15 +1];
		char AFTER_COMPENS_MODEL_CD  [8  +1];
		char AFTER_COMPENS_VALID_YM  [6  +1];
		char AFTER_COMPENS_PRESS     [6  +1];
		char REMOVE_INDI_VM          [9  +1];
		char REMOVE_INDI_VA          [9  +1];
		char REMOVE_INDI_VC          [9  +1];
		char REMOVE_MTR_FLAG         [6  +1];
		char REPL_NOT_PERMIT_WHY     [3  +1];
		char JOB_DTM                 [14 +1];
		char JOBER_EMPID             [9  +1];
		char MTR_PHOTO               [128+1];
		char COMPENS_PHOTO           [128+1];
		char CUST_SIGN               [200+1];
		char SEND_YN                 [1  +1];
		char AFTER_MTR_APPRO_YN      [1  +1];
		char AFTER_FORM_APPRO_YN     [1  +1];
		char INST_INDI_VM            [9  +1];
		char INST_INDI_VA            [9  +1];
		char INST_INDI_VC            [9  +1];
		char TEMPER                  [13 +1];
		char PRESS                   [7  +1];
		char REVIS_PARA              [10 +1];
		char BEFO_TEMPER             [13 +1];
		char BEFO_PRESS              [8  +1];
		char BEFO_REVIS_PARA         [10 +1];
		char UPD_DTM                 [14 +1];
		char UPD_EMPID               [9  +1];
		char CRT_DTM                 [14 +1];
		char CRT_EMPID               [9  +1];
		char PDA_NUM                 [1  +1];
		char TREAT_FLAG              [2  +1];
		char REVIS_FLAG              [2  +1];
		char MTR_SUPPLY_STS          [20 +1];
		char COMPENS_MAKER_NM        [30 +1];
		char VISIT_YMD               [8  +1];
		char MEMO                    [100+1];
		char LAW_TOWN                [30 +1];
		char NEW_ROAD_NM             [255+1];
		char NEW_ADDR_M              [10 +1];
		char NEW_ADDR_S              [10 +1];
		char BACK_REPL_STS			 [2  +1];
		char CONT_STS_CD			 [2  +1];
		char COMM_NUM_24			 [24 +1];
		char COMM_FIRM				 [2  +1];
		char INFLOW_FLAG			 [2  +1];
		char NOBILL_YN 				 [1  +1];
		char PROD_CONT_SEQ			 [10 +1];
		char BULD_CENTER_CD			 [2 +1];
		char REPL_TREAT_INSTI        [2 +1];
		char NO_BILL_REPL_WHY        [9 +1];
		char BEFO_MTR_ID_NUM 		 [25 +1];
		char BATTERY_YN   		     [2 +1];
		char MTRDISPLAY_YN      	 [2 +1];
		char OTHER_PRICE			 [10 +1];
		char CHK_BULD_CENTER_CD 	 [2 +1];
		char REMOTE_SYSTEM			 [2 +1];
		char OLD_MTR_ID_NUM          [25 +1];
		char AMI_OBJ_YN   		     [1 +1];
		char CONCENT_INST_AMT_YN	 [1 +1];

		

		


	}	MTRCHGINFO;
	global MTRCHGINFO stMtrChg;
	
#endif
