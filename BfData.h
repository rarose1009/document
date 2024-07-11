/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		BFDATA_H
#define		BFDATA_H


#define UPSIGNDATA_FILE	 		"UPSIGNDATA.dat"

//-----------------------------------------------------------------------------------------------	
// 	공급전 대상
//-----------------------------------------------------------------------------------------------	
	typedef struct _BFINFO
	{
		char ROWID              [5  +1];
		char CREATE_YMD         [8  +1];
		char MTR_NUM            [9  +1];
		char BEFO_OBJ_YN        [1  +1];
		char BLD_NUM            [9  +1];
		char INST_PLACE_NUM     [9  +1];
		char SINGLE_COLIVE_FLAG [2  +1];
		char CENTER_CD          [2  +1];
		char ZONE_MANAGE_NUM    [5  +1];
		char PDA_NUM            [5  +1];
		char ZIP_NO1            [3  +1];
		char ZIP_NO2            [3  +1];
		char COUNTY             [30 +1];
		char TOWN               [30 +1];
		char VILLAGE            [30 +1];
		char ADDR1_M            [9  +1];
		char ADDR1_S            [30 +1];
		char LOT_NUM_SECOND_ADDR[100+1];
		char CO_LIVE_NM         [60 +1];
		char HOUSE_CNT          [6  +1];
		char BLD_NM             [100+1];
		char DETA_FLOOR         [6  +1];
		char COMPX_FLAG_NM      [60 +1];
		char CUST_NUM           [10 +1];
		char CUST_TYPE_CD       [2  +1];
		char CUST_NM            [30 +1];
		char FIRM_NM            [50 +1];
		char BIZ_REGI_NUM       [10 +1];
		char SOC_NUM            [13 +1];
		char REPRE_NM           [30 +1];
		char CP_DDD             [4  +1];
		char CP_EXN             [4  +1];
		char CP_NUM             [4  +1];
		char OWNHOUSE_TEL_DDD   [4  +1];
		char OWNHOUSE_TEL_EXN   [4  +1];
		char OWNHOUSE_TEL_NUM   [4  +1];
		char USE_CONT_NUM       [10 +1];
		char PROD_NM            [50 +1];
		char CONT_YMD           [8  +1];
		char CNL_YMD            [8  +1];
		char MTR_ID_NUM         [20 +1];
		char MTR_MODEL_CD       [20 +1];
		char MTR_GRD            [62 +1];
		char CONT_STS_CD        [2  +1];
		char INS_JOIN_YN        [1  +1];
		char INS_EXPLA_YN       [1  +1];
		char COMPENS_OBJ_YN     [1  +1];
		char CHK_YMD            [8  +1];
		char CHK_TIME_FROM      [6  +1];
		char CHK_TIME_TO        [6  +1];
		char CHK_EMPID          [9  +1];
		char CHK_RSLT           [2  +1];
		char SIGN               [300+1];
		char INDI_DTM           [14 +1];
		char MTR_INDI           [9  +1];
		char INDI_VA            [9  +1];
		char INDI_VC            [9  +1];
		char SEND_FLAG          [1  +1];
		char CRT_EMPID          [9  +1];
		char CRT_IP             [32 +1];
		char LAW_TOWN           [30 +1];
		char NEW_ROAD_NM        [100+1];
		char NEW_ADDR_M         [10 +1];
		char NEW_ADDR_S         [10 +1];
           
	}	BFINFO;
	global BFINFO stBf;
	
	
//-----------------------------------------------------------------------------------------------
//				보일러
//-----------------------------------------------------------------------------------------------
	typedef struct _BFBOIL
	{
		char CREATE_YMD            [8 +1];
		char MTR_NUM               [9 +1];
		char BURNER_NUM            [6 +1];
		char CHK_OBJ_BOILER_YN     [1 +1];
		char NEW_REPL_FLAG         [2 +1];
		char BURNER_MODEL_CD       [6 +1];
		char BURNER_CLASS_CD       [2 +1];
		char BURNER_KIND_NUM       [3 +1];
		char BURNER_CAPA           [10+1];
		char BURNER_CAPA_UNIT      [2 +1];
		char BURNER_INST_YMD       [8 +1];
		char BURNER_REMOV_YMD      [8 +1];
		char BURNER_MODEL_NM       [50+1];
		char MAKER_FLAG            [2 +1];
		char MAKER_NUM             [5 +1];
		char MAKER_NM              [60+1];
		char BOILER_FORM           [2 +1];
		char MAKE_NUM              [30+1];
		char WORK_DOCU_RECEIVE_YMD [8 +1];
		char INST_FLAG             [2 +1];
		char INST_LOC              [2 +1];
		char BOILER_INST_FIRM_CD   [6 +1];
		char BO1_RSLT              [2 +1];
		char BO2_RSLT              [2 +1];
		char BO3_RSLT              [2 +1];
		char BO4_RSLT              [2 +1];
		char CHK_RSLT              [2 +1];
		char SEND_FLAG             [1 +1];
		char CRT_EMPID             [9 +1];
		char CRT_IP                [32+1];
		char CHG_FLAG              [2 +1];
		char BURNER_CAPA_UNIT_NM   [30+1];
		char BURNER_CLASS_NM       [30+1];
		char BURNER_KIND_NM        [30+1];
		char BOILER_FORM_NM        [30+1];
	}	BFBOIL;

	global BFBOIL stBfBoil;
	
	
//-----------------------------------------------------------------------------------------------
//				부적합
//-----------------------------------------------------------------------------------------------
	typedef struct _BFNOGOOD
	{
		char CREATE_YMD         [8  +1];
		char MTR_NUM            [9  +1];
		char BLD_NUM            [9  +1];
		char INST_PLACE_NUM     [9  +1];
		char SINGLE_COLIVE_FLAG [2  +1];
		char CENTER_CD          [2  +1];
		char ZONE_MANAGE_NUM    [5  +1];
		char ZIP_NO1            [3  +1];
		char ZIP_NO2            [3  +1];
		char CITY               [30 +1];
		char AREA               [30 +1];
		char TOWN               [30 +1];
		char VILLAGE            [30 +1];
		char ADDR1_M            [30 +1];
		char ADDR1_S            [30 +1];
		char LOT_NUM_SECOND_ADDR[100+1];
		char CO_LIVE_NM         [60 +1];
		char HOUSE_CNT          [6  +1];
		char BLD_NM             [150+1];
		char DETA_FLOOR         [6  +1];
		char COMPX_FLAG_NM      [60 +1];
		char CUST_NUM           [10 +1];
		char CUST_TYPE_CD       [2  +1];
		char CUST_NM            [30 +1];
		char FIRM_NM            [50 +1];
		char BIZ_REGI_NUM       [10 +1];
		char SOC_NUM            [13 +1];
		char REPRE_NM           [30 +1];
		char CP_DDD             [4  +1];
		char CP_EXN             [4  +1];
		char CP_NUM             [4  +1];
		char OWNHOUSE_TEL_DDD   [4  +1];
		char OWNHOUSE_TEL_EXN   [4  +1];
		char OWNHOUSE_TEL_NUM   [4  +1];
		char END_YN             [1  +1];
		char SEND_YN            [1  +1];
		char CRT_EMPID          [9  +1];
		char CRT_IP             [32 +1];
		char LAW_TOWN           [30 +1];
		char NEW_ROAD_NM        [100+1];
		char NEW_ADDR_M         [10 +1];
		char NEW_ADDR_S         [10 +1];
//NOGOOD_DETAL
		char BURNER_NUM         [6  +1];
		char CHK_SEC_CD         [2  +1];
		char NOT_PASS_ITEM_CD   [2  +1];
		char VISIT_DTM          [14 +1];
		char CHK_SEC_NM         [30 +1];
		char NOT_PASS_ITEM_NM   [50 +1];
		char PHOTO              [300+1];
		char BETTER_PLAN_YMD    [8  +1];
		char BETTER_YMD         [8  +1];
		char BETTER_YN          [1  +1];
		char MTR_ID_NUM         [30 +1];
		char EMP_ID             [9  +1];
		char BETTER_CONF_EMPID  [9  +1];
	}	BFNOGOOD;

	global BFNOGOOD stBfNogood;

#endif

