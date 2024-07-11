/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		SCDATA_H
#define		SCDATA_H

//-----------------------------------------------------------------------------------------------	
//				�������� ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCINFO
	{
		char CHK_EXEC_NUM			[12 +1]; 
		char ZIP_NO1				[3 +1];  
		char ZIP_NO2				[3 +1];  
		char CITY					[30 +1]; 
		char COUNTY					[30 +1]; 
		char TOWN					[30 +1]; 
		char VILLAGE				[30 +1]; 
		char ADDR1_M				[30 +1]; 
		char ADDR1_S				[30 +1]; 
		char LOT_NUM_SECOND_ADDR	[100 +1];
		char CO_LIVE_NM				[60 +1]; 
		char HOUSE_CNT				[6 +1];  
		char BLD_NM					[150 +1];
		char DETA_FLOOR				[6 +1];  
		char SINGLE_COLIVE_FLAG		[2 +1];  
		char BUILT_IN_YN			[1 +1];  
		char SQUARE_METER			[2 +1];  
		char BLD_NUM				[9 +1];  
		char INST_PLACE_NUM			[9 +1];  
		char REGTR_NUM				[8 +1];  
		char ADD_CHK_WHY			[2 +1];  
		char PREUSE_CHK_WHY			[2 +1];  
		char CHK_TYPE				[2 +1];  
		char CHK_YEAR				[4 +1];  
		char CHK_ORDER				[2 +1];  
		char OBJ_YM					[6 +1];  
		char PLAN_YM				[6 +1];  
		char BEFO_HALF_CHK_RSLT		[2 +1];  
		char BEFO_HALF_CHK_YMD		[8 +1];  
		char BEFO_HALF_CHKER_NM		[12 +1]; 
		char BEFO_HALF_MEMO			[100 +1];
		char BEFO_HALF_MEMO_WHY		[2 +1];  
		char BAR					[20 +1]; 
		char CUST_NUM				[10 +1]; 
		char CUST_NM				[30 +1]; 
		char CUST_TYPE_CD			[2 +1];  
		char CUST_TRND_CD			[2 +1];  
		char USE_CONT_NUM			[10 +1]; 
		char USE_CONT_NM			[50 +1]; 
		char USE_CONT_YMD			[8 +1];  
		char CONT_STS_CD			[2 +1];  
		char OWNHOUSE_TEL_DDD		[4 +1];  
		char OWNHOUSE_TEL_EXN		[4 +1];  
		char OWNHOUSE_TEL_NUM		[4 +1];  
		char CP_DDD					[4 +1];  
		char CP_EXN					[4 +1];  
		char CP_NUM					[4 +1];  
		char FAMILY_CNT				[3 +1];  
		char FIRM_NM				[50 +1]; 
		char BIZ_REGI_NUM			[10 +1]; 
		char EMAIL					[50 +1]; 
		char FIRM_TEL_DDD			[4 +1];  
		char FIRM_TEL_EXN			[4 +1];  
		char FIRM_TEL_NUM			[4 +1];  
		char FAX_DDD				[4 +1];  
		char FAX_EXN				[4 +1];  
		char FAX_NUM				[4 +1];  
		char SOC_NUM				[13 +1]; 
		char SCG_RELAT_CD			[2 +1];  
		char CENTER_CD				[2 +1];  
		char ZONE_MANAGE_NUM		[5 +1];  
		char PDA_NUM				[15 +1]; 
		char HOUSE_NUM_ORD			[5 +1];  
		char DONG_ORD				[5 +1];  
		char CHK_EMPID				[9 +1];  
		char CHKER_NM				[12 +1]; 
		char CHK_YMD				[8 +1];  
		char CHK_TIME_FROM			[6 +1];  
		char CHK_TIME_TO			[6 +1];  
		char CHK_RSLT				[2 +1];  
		char CHK_EXCEP_WHY			[2 +1];  
		char ADV_DIST_YN			[1 +1];  
		char SELF_CHK_YN			[1 +1];  
		char LK_BREAKER				[1 +1];  
		char CO_SENSOR				[1 +1];  
		char PIPE_COLOR_STS			[1 +1];  
		char SIGN_RELAT				[20 +1]; 
		char SIGN					[200 +1];
		char CURR_BAR				[128 +1]; 
		char BAR_WHY				[2 +1];  
		char ARG_DATE				[14+1]; 	//YYYYMMDD,	**���� �� ������ ARG_DATA+ARG_HOUR+ARG_MIN �� ���ļ� �ѹ��� �־����.
		char ARG_HOUR				[2 +1]; 	//HH24D		  (�ʵ�� : ARG_DATE)
		char ARG_MIN				[2 +1]; 	//HH24D
		char PIPE_RSLT				[1 +1];  
		char REG_RSLT				[1 +1];  
		char LOC_RSLT				[1 +1];  
		char MTR_RSLT				[1 +1];  
		char BO_RSLT				[1 +1];  
		char BUR_FLAG				[1 +1];  
		char CUST_FLAG				[1 +1];  
		char SEND_YN				[1 +1];  
		char NOGOOD_RSLT			[1 +1];  
		char CUST_YN				[1 +1];  
		char PDA_IP					[32 +1]; 
		char UPD_EMPID				[20 +1]; 
		char MEMO					[100 +1];
		char MEMO_WHY				[2 +1];  
		char CONT_YN				[1 +1];  
		char INFO_USE_AGREE_YN		[1 +1];  
		char INFO_USE_YN			[1 +1];  
		char REAL_NM_CONF_YN		[2 +1];  
		char CUST_TRND_YN			[1 +1];  
		char SAFE_YN				[1 +1];  
		char SMS_SEND_AGREE_YN		[2 +1];  
		char LAW_TOWN				[30 +1]; 
		char NEW_ROAD_NM			[100 +1];
		char NEW_ADDR_M				[10 +1]; 
		char NEW_ADDR_S				[10 +1]; 
		char COMP_CHK_OBJ_YN		[2 +1];  
		char PIPE_BURY_YN			[2 +1];  
		char PIPE_HIDE_YN			[2 +1];  
		char TOT_BURNER_CAPA		[20 +1]; 
		char USE_PLAN_QTY			[20 +1];
		char CHK_MEMO				[200 +1];	//���ո޸�-���˸޸�
		char GUM_MEMO				[200 +1];	//���ո޸�-��ħ�޸�	
		char PROTE_FACI_GRD			[20  +1];
		char PARCEL_OUT_YN   		[20  +1];
		char BAR_YN	    			[1 +1];	    //���ڵ� ��߱޿���
		char PROD_CD				[2 +1];	    //��ǰ�ڵ�
		char PIPE_NUM               [12 +1];    //�Ի����ȣ
		char INDUCTION_INST_YN      [1 + 1];
		char SOCIAL_WELF_FACI_YN    [1 + 1];
		char DEADLINE_FLAG          [2 + 1];
		char BILL_SEND_METHOD       [2 +1];
		char BILL_SEND_CP_DDD       [4 +1];
		char BILL_SEND_CP_EXN       [4 +1];
		char BILL_SEND_CP_NUM       [4 +1];
		char BILL_SEND_EMAIL        [50 +1];
		char PHOTO_BUR_YN           [1  +1];
		char PHOTO_BOIL_YN1         [1  +1];
		char PHOTO_BOIL_YN2         [1  +1];
		char OLD_BOILER_YN          [1  +1];
		char PHOTO_BAR_YN           [1  +1];
		char CO_ALARM_INST_YN       [1  +1];
		char KIT_AUTO_EXTINGU_INST_YN [1  +1];
		char CHK_VISIBLE_YN 		[1  +1];
		char CHK_REJECT             [5  +1];
		char CHK_MISS				[5  +1];
		char NON_PAY_YN 			[2  +1];
		char MTR_KIND 				[10  +1];
		char MTR_REMOTE_AMI 		[10  +1];
		char BILL_YN                [2   +1];
		
	}	SCINFO;
	
	global SCINFO stSc;

//-----------------------------------------------------------------------------------------------	
//				�ּ�Ȯ�� ����
//-----------------------------------------------------------------------------------------------	


//-----------------------------------------------------------------------------------------------	
//				���ݱ������ ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCADDR
	{
		char BLD_NUM          	[9  + 1];
		char NEW_ADDR_BLD_SEQ 	[10 +1]; 
		char ZIP_SEQ          	[10 +1];  
		char TOWN             	[30 +1];  
		char VILLAGE          	[30 +1]; 
		char HILL             	[3  +1]; 
		char ADDR1_M          	[4  +1]; 
		char ADDR1_S          	[4  +1]; 
		char CO_LIVE_NM       	[60 +1]; 
		char BLD_NM           	[150+1]; 
		char NEW_ROAD_NM      	[50 +1];
		char NEW_ADDR_M       	[4  +1]; 
		char NEW_ADDR_S       	[4  +1];  
		char NEW_BLD_NM       	[150+1];
		char BEFO_ADDR1_M     	[4  + 1];
		char BEFO_ADDR1_S     	[4  +1]; 
		char BEFO_NEW_ADDR_M  	[4  +1];  
		char BEFO_NEW_ADDR_S  	[4  +1];  
		char CURR_ADDR_RSLT   	[2  +1]; 
		char NEW_ADDR_RSLT    	[2  +1]; 
		char SEND_YN          	[1  +1]; 
	}	SCADDR;
	
	global SCADDR stScAddr;
	
//-----------------------------------------------------------------------------------------------	
//				�湮��� ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCVISIT
	{
		char CHK_EXEC_NUM    	[12+ 1];
		char VISIT_FLAG      	[2 +1]; 
		char VISIT_DEGREE    	[2 +1];  
		char VISITOR_ID      	[9 +1]; 
		char SEND_YN         	[1 +1]; 
		char PDA_IP          	[32+1];
		char UPD_EMPID       	[20+1]; 
		char BLD_NUM         	[9 +1];  
		char INST_PLACE_NUM  	[9 +1];
		char CHK_TYPE        	[2 +1];
		char CHK_YEAR        	[4 +1];
		char CHK_ORDER       	[2 +1];
		char OBJ_YM          	[6 +1];
		char PLAN_YM         	[6 +1];
		char VISIT_YMD       	[8 +1];
		char NO_CHK_WHY      	[30 +1]; 
		char VISITOR_NM      	[30+1]; 
		char SUPPLY_STOP_YMD 	[8 +1]; 
		char NOT_PERMIT_WHY  	[2 +1];
	}	SCVISIT;
	
	global SCVISIT stScVisit;
	
//-----------------------------------------------------------------------------------------------	
//				��� ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCPIPE
	{
		char CHK_EXEC_NUM			[20+ 1];
		char CHK_YEAR              	[4 + 1];
		char CHK_ORDER             	[2 +1]; 
		char CHK_TYPE              	[2 +1];  
		char MTR_NUM               	[9 +1]; 
		char CHK_YMD               	[8 +1]; 
		char UPD_EMPID             	[9 +1];
		char PDA_IP                	[13+1]; 
		char PIPE_FLAG             	[2 +1];  
		char GAS_DAMP_YN           	[2 +1];
		char MULTI_GAS_MTR_YN      	[2 +1];
		char PIPE_INSPEC_HOLE_YN   	[2 +1];
		char CUTOFF_INSPEC_HOLE_YN 	[2 +1];
		char PIPE_LOC_MARK_YN      	[2 +1];
	}	SCPIPE;
	
	global SCPIPE stScPipe;
	
//-----------------------------------------------------------------------------------------------	
//				�跮�� ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCMTR
	{
		char ROWID				[5  +1];	//rowid
		char CHK_EXEC_NUM      	[12 +1]; 
		char MTR_NUM           	[9  +1];  
		char PROD_CD           	[5  +1];  
		char PROD_NM           	[50 +1]; 
		char MTR_ID_NUM        	[20 +1]; 
		char MTR_SUPPLY_STS    	[2  +1]; 
		char MTR_MODEL_CD      	[5  +1]; 
		char MTR_MODEL_NM      	[50 +1]; 
		char MTR_LOC_FLAG      	[2  +1]; 
		char MTR_GRD           	[8  +1];	//NUMERIC(6,1)
		char MTR_VALID_YM      	[6  +1]; 
		char SEALED_STS        	[2  +1];  
		char MTR_INDI          	[9  +1];
		char INDI_VA           	[9  +1];  
		char INDI_VC           	[9  +1];  
		char COMPENS_YN        	[1  +1];  
		char MTR_DETA_LOC      	[30 +1];  
		char MAKER_NM          	[60 +1];  
		char FUSE_COCK_INST_YN 	[1  +1];  
		char VISIT_DTM         	[14 +1];  
		char MTR_INDI_CUR      	[9  +1];  
		char INDI_VA_CUR       	[9  +1];  
		char INDI_VC_CUR       	[9  +1];  
		char SEND_YN           	[1  +1];  
		char MTR_RSLT          	[1  +1];  
		char PIPE_RSLT         	[1  +1];  
		char CHK_RSLT          	[1  +1];  
		char PDA_IP            	[32 +1];  
		char UPD_EMPID         	[20 +1];  
		char BLD_NUM           	[9  +1]; 
		char INST_PLACE_NUM    	[10 +1];
		char CHK_TYPE          	[2  +1];  
		char CHK_YEAR          	[4  +1]; 
		char CHK_ORDER         	[2  +1]; 
		char OBJ_YM            	[6  +1]; 
		char PLAN_YM           	[6  +1];  
		char MTR_FORM_NM       	[30 +1];  
		char ADDR1_M           	[30 +1]; 
		char ADDR1_S           	[30 +1]; 
		char CO_LIVE_NM        	[60 +1];  
		char HOUSE_CNT         	[6  +1];  
		char BLD_NM            	[150+1];  
		char ETC_ADDR          	[100+1];  
		char TIMER_COCK_INST_YN	[1  +1];
		char INSIDE_MTR_PHOTO_ID[30  +1];
		//�������� �����ȸ ȭ��뵵��.
		char CUST_NM          	[30+1];  
		char CUST_NUM          	[10+1];  
		char REMOTE_MTR_YN      [1  +1];
		
	}	SCMTR;
	
	global SCMTR stScMtr;
	
//-----------------------------------------------------------------------------------------------	
//				���ұ� ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCBURINFO
	{
		char ROWID					[5  +1];	//rowid
		char CHK_EXEC_NUM        	[12 +1]; 
		char MTR_NUM             	[9  +1];  
		char BURNER_NUM          	[6  +1];  
		char BURNER_CLASS_CD     	[2  +1]; 
		char BURNER_KIND_NUM     	[20 +1]; 
		char BURNER_MODEL_CD     	[6  +1]; 
		char BURNER_MODEL_NM     	[50 +1]; 
		char BURNER_CAPA         	[10 +1]; 
		char BURNER_CAPA_UNIT    	[2  +1]; 
		char BURNER_INST_YMD     	[8  +1];
		char BURNER_REMOV_YMD    	[8  +1]; 
		char MAKER_NUM           	[5  +1];  
		char MAKER_NM            	[60 +1];
		char BOILER_FORM         	[2  +1];  
		char MAKE_NUM            	[30 +1];  
		char MAKE_YMD            	[8  +1];  
		char INST_FLAG           	[2  +1];  
		char INST_LOC            	[2  +1];  
		char BOILER_INST_FIRM_CD 	[6  +1];  
		char CHG_FLAG            	[1  +1];  
		char SEND_YN             	[1  +1];  
		char BOILER_INST_FIRM_NM 	[20 +1];  
		char BOILER_FORM_NM      	[20 +1];  
		char BEFO_SUPPLY_CHK_YMD 	[8  +1];  
		char BEFO_SUPPLY_CHKER_NM	[12 +1];  
		char BEFO_SUPPLY_CHK_RSLT	[2  +1];  
		char CHK_RSLT            	[2  +1];  
		char BURNER_CAPA_UNIT_NM 	[20 +1];  
		char LOC_RSLT            	[1  +1];  
		char AIR_RSLT            	[1  +1]; 
		char PIPE_RSLT           	[1  +1];
		char ETC_RSLT            	[1  +1];  
		char BURNER_KIND_NM      	[30 +1];
		char BURNER_CLASS_NM     	[20 +1];  
		char MTR_ID_NUM          	[20 +1];  
		char PDA_IP              	[20 +1];  
		char UPD_EMPID           	[12 +1];  
		char BLD_NUM             	[9  +1];  
		char INST_PLACE_NUM      	[9  +1];  
		char CHK_TYPE            	[2  +1];  
		char CHK_YEAR            	[4  +1];  
		char CHK_ORDER           	[2  +1];  
		char OBJ_YM              	[6  +1];  
		char PLAN_YM             	[6  +1];  
		char INST_LOC_NM         	[20 +1];
		char TIMER_COCK_INST_YN     [5  +1];
		char FUSE_COCK_INST_YN      [5  +1];
		char GAS_RSLT               [1  +1];
		char HOSE_RSLT              [1  +1];
		char PLUG_NOGOOD_YN			[1  +1];
		char DATA_FLAG   			[2  +1];
		char BUR_RSLT   			[1  +1];
	}	SCBURINFO;
	
	global SCBURINFO stScBur;
	
//-----------------------------------------------------------------------------------------------	
//				������ ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCCUSTINFO
	{
		char CHK_EXEC_NUM    	[12 +1]; 
		char BUILT_IN_YN     	[1  +1];  
		char SQUARE_METER    	[2  +1];  
		char CUST_NUM        	[10 +1]; 
		char CUST_NM         	[30 +1]; 
		char CUST_TYPE_CD    	[2  +1]; 
		char CUST_TRND_CD    	[2  +1]; 
		char OWNHOUSE_TEL_DDD	[4  +1]; 
		char OWNHOUSE_TEL_EXN	[4  +1]; 
		char OWNHOUSE_TEL_NUM	[4  +1];
		char CP_DDD          	[4  +1]; 
		char CP_EXN          	[4  +1];  
		char CP_NUM          	[4  +1];
		char FAMILY_CNT      	[3  +1];  
		char FIRM_NM         	[50 +1];  
		char EMAIL           	[50 +1];  
		char FIRM_TEL_DDD    	[4  +1];  
		char FIRM_TEL_EXN    	[4  +1];  
		char FIRM_TEL_NUM    	[4  +1];  
		char FAX_DDD         	[4  +1];  
		char FAX_EXN         	[4  +1];  
		char FAX_NUM         	[4  +1];  
		char SOC_NUM         	[13 +1];  
		char SCG_RELAT_CD    	[2  +1];  
		char PDA_IP          	[32 +1];  
		char UPD_EMPID       	[20 +1];  
		char BLD_NUM         	[20 +1];  
		char INST_PLACE_NUM  	[9  +1];  
		char CHK_TYPE        	[2  +1];  
		char CHK_YEAR        	[4  +1]; 
		char CHK_ORDER       	[2  +1];
		char OBJ_YM          	[6  +1];  
		char PLAN_YM         	[6  +1]; 
		char SEND_YN         	[1  +1];
		char INDUCTION_INST_YN  [1 + 1];
		char FACI_STS_CD        [1 + 1];
		char CHK_YMD            [8 + 1];
	}	SCCUSTINFO;
	
	global SCCUSTINFO stScCustInfo;

//-----------------------------------------------------------------------------------------------	
//				������ ����(Sub Struct, ����� ȭ����������)
//-----------------------------------------------------------------------------------------------	
	typedef struct _SUBCUSTINFO
	{
		char BUILT_IN_YN     	[1  +1];
		char SQUARE_METER    	[2  +1];
		char CUST_NUM        	[10 +1];
		char CUST_NM         	[30 +1]; 
		char CUST_TYPE_CD    	[2  +1];
		char CUST_TRND_CD    	[2  +1];
		char OWNHOUSE_TEL_DDD	[4  +1];
		char OWNHOUSE_TEL_EXN	[4  +1];
		char OWNHOUSE_TEL_NUM	[4  +1];
		char CP_DDD          	[4  +1];
		char CP_EXN          	[4  +1];
		char CP_NUM          	[4  +1];
		char FAMILY_CNT      	[3  +1];
		char FIRM_NM        	[50 +1];
		char EMAIL           	[50 +1];
		char EMAILADDR         	[50 +1];
		char FIRM_TEL_DDD    	[4  +1];
		char FIRM_TEL_EXN    	[4  +1];
		char FIRM_TEL_NUM    	[4  +1];
		char FAX_DDD         	[4  +1];
		char FAX_EXN         	[4  +1];
		char FAX_NUM         	[4  +1];
		char SOC_NUM         	[13 +1];
		char SCG_RELAT_CD    	[2  +1];
		char INDUCTION_INST_YN  [1 + 1];
		char FACI_STS_CD        [1 + 1];
	}	SUBCUSTINFO;
	
	global SUBCUSTINFO stSubCustInfo;


//-----------------------------------------------------------------------------------------------	
//				�����ǰ����� ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCNOGOOD
	{
		char CHK_EXEC_NUM        	[12 +1];
		char ZIP_NO1             	[3  +1];
		char ZIP_NO2             	[3  +1];
		char CITY                	[30 +1];
		char COUNTY              	[30 +1];
		char TOWN                	[30 +1];
		char VILLAGE             	[30 +1];
		char ADDR1_M             	[30 +1];
		char ADDR1_S             	[30 +1];
		char LOT_NUM_SECOND_ADDR 	[100+1];
		char CO_LIVE_NM          	[60 +1];
		char HOUSE_CNT           	[6  +1];
		char BLD_NM              	[150+1];
		char DETA_FLOOR          	[6  +1];
		char NEW_ADDR_HOSU       	[4  +1];
		char NEW_ADDR_UNGRNOUD_YN	[1  +1];
		char NEW_ADDR_UNION      	[300+1];
		char INST_PLACE_NUM      	[9  +1];
		char CHK_TYPE            	[2  +1];
		char CHK_YEAR            	[4  +1];
		char CHK_ORDER           	[2  +1];
		char OBJ_YM              	[6  +1];
		char PLAN_YM             	[6  +1];
		char CUST_NUM            	[10 +1];
		char CUST_NM             	[30 +1];
		char CUST_TYPE_CD        	[2  +1];
		char CUST_TRND_CD        	[2  +1];
		char USE_CONT_NUM        	[10 +1];
		char FIRM_NM             	[50 +1];
		char BIZ_REGI_NUM        	[10 +1];
		char SOC_NUM             	[13 +1];
		char OWNHOUSE_TEL_DDD    	[4  +1];
		char OWNHOUSE_TEL_EXN    	[4  +1];
		char OWNHOUSE_TEL_NUM    	[4  +1];
		char CP_DDD              	[4  +1];
		char CP_EXN              	[4  +1];
		char CP_NUM              	[4  +1];
		char CENTER_CD           	[2  +1];
		char ZONE_MANAGE_NUM     	[5  +1];
		char PRE_CHK_OBJ_YN      	[1  +1];
		char END_YN              	[1  +1];
		char SEND_YN             	[1  +1];
		char PDA_IP              	[32 +1];
		char UPD_EMPID           	[20 +1];
		char BLD_NUM             	[9  +1];
		char SMS_SEND_AGREE_YN   	[2  +1];
		char LAW_TOWN            	[30 +1];
		char NEW_ROAD_NM         	[100+1];
		char NEW_ADDR_M          	[10 +1];
		char NEW_ADDR_S          	[10 +1];
//�����ջ�
		char CHK_SEC_CD				[2	 +1];	     
		char MTR_NUM				[9	 +1];	
		char BURNER_NUM				[6	 +1];	
		char NOT_PASS_ITEM_CD		[2	 +1];	
		char CHK_SEC_NM				[32	 +1];	
		char NOT_PASS_ITEM_NM		[32	 +1];	
		char MTR_ID_NUM				[20	 +1];	
		char VISIT_DTM				[14	 +1];	
		char BETTER_PLAN_YMD		[8	 +1];	
		char BETTER_YN				[1   +1];	
		char BETTER_END_YMD			[8   +1];	
		char BETTER_CONF_EMPID		[9   +1];	
		char BETTER_CONF_NM			[20  +1];		
		char PHOTO					[128 +1];	
		char BETTER_PHOTO			[128 +1];	
		char BETTER_DEGREE			[2   +1];
		char CONT_STS_CD			[2   +1];		
	}	SCNOGOOD;
	
	global SCNOGOOD stScNogood;
	
//-----------------------------------------------------------------------------------------------	
//				�����ǰ�����(����������) ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCNOGOODCHA
	{
		char CHK_EXEC_NUM        	[12+1];
		char BETTER_ADVICE_DEGREE	[2 +1];
		char INST_PLACE_NUM      	[9 +1];
		char OBJ_YM              	[6 +1];
		char CHK_TYPE            	[2 +1];
		char BETTER_ADVICE_YMD   	[8 +1];
		char BETTER_ADVICE_EXPIRE	[8 +1];
		char BETTER_YN           	[1 +1];
		char BETTER_END_YMD      	[8 +1];
		char SUPPLY_STOP_YMD     	[8 +1];
		char NOT_PERMIT_WHY      	[2 +1];
		char PRE_CHK_OBJ_YN      	[1 +1];
		char SEND_YN             	[1 +1];
		char PDA_IP              	[32+1];
		char UPD_EMPID           	[20+1];
		char BLD_NUM             	[9 +1];
		char CHK_YEAR            	[4 +1];
		char CHK_ORDER           	[2 +1];
		char PLAN_YM             	[6 +1];
	}	SCNOGOODCHA;
	
	global SCNOGOODCHA stScNogoodCha;
	
//-----------------------------------------------------------------------------------------------	
//				������ ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCJJCHK
	{
		char REGTR_NUM           	[8  +1];
		char CHK_PLAN_YM         	[6  +1];
		char SAFE_CHK_TYPE       	[2  +1];
		char BRANCH_CD           	[6  +1];
		char CENTER_CD           	[2  +1];
		char SINGLE_COLIVE_FLAG  	[2  +1];
		char GENER_REGTR_CHK_FLAG	[2  +1];
		char REGTR_FILTER_FLAG   	[20 +1];
		char REGTR_ID_NUM        	[15 +1];
		char REGTR_MODEL_CD      	[5  +1];
		char REGTR_MODEL_NM      	[50 +1];
		char REGTR_INST_YMD      	[8  +1];
		char MTRCNT              	[9  +1];
		char REGTR_LOC_FLAG      	[20 +1];
		char REGTR_TYPE          	[2  +1];
		char REGTR_LR_TYPE_NM    	[20 +1];
		char FIRST_PRESS         	[5  +1];
		char BLD_NUM             	[9  +1];
		char BLD_NM              	[150+1];
		char MAKER_NUM           	[5  +1];
		char MAKER_NM            	[60 +1];
		char ZIP_NO1             	[3  +1];
		char ZIP_NO2             	[3  +1];
		char ZIP_NO3             	[3  +1];
		char CITY                	[30 +1];
		char COUNTY              	[30 +1];
		char TOWN                	[30 +1];
		char VILLAGE             	[30 +1];
		char ADDR1_M             	[30 +1];
		char ADDR1_S             	[30 +1];
		char LOT_NUM_SECOND_ADDR 	[30 +1];
		char FILTER_REPL_YMD     	[8  +1];
		char FHALF_CHK_RSLT      	[2  +1];
		char FHALF_CHK_YMD       	[8  +1];
		char FHALF_CHKER_NM      	[20 +1];
		char FHALF_MEMO          	[100+1];
		char FHALF_MEMO_FLAG     	[2  +1];
		char BAR                 	[20 +1];
		char ZONE_MANAGE_NUM     	[5  +1];
		char FILTER_REPL_FLAG    	[2  +1];
		char NEW_FILTER_REPL_YMD 	[8  +1];
		char CURR_BAR            	[20 +1];
		char BAR_NOT_PERMIT_WHY  	[6  +1];
		char CHK_EMPID           	[9  +1];
		char CHK_YMD             	[8  +1];
		char CHK_RSLT            	[2  +1];
		char CHK_EXCEP_WHY       	[6  +1];
		char SECOND_PRESS        	[5  +1];
//		char CHK_SIGN_IMAGE      	[TEXT +1];
		char CHK_STR_DTM         	[20 +1];
		char CHK_END_DTM         	[20 +1];
		char INFO_FLAG           	[1  +1];
		char REG1_RSLT           	[1  +1];
		char REG2_RSLT           	[1  +1];
		char REG3_RSLT           	[1  +1];
		char CHK_END_YN          	[1  +1];
		char UPD_EMPID           	[20 +1];
		char UPD_EMPNM           	[20 +1];
		char CO_LIVE_NM          	[30 +1];
		char LAW_TOWN            	[30 +1];
		char NEW_ROAD_NM         	[100+1];
		char NEW_ADDR_M          	[10 +1];
		char NEW_ADDR_S          	[10 +1];
		char SPECIAL_ETC         	[2  +1];
	}	SCJJCHK;
	
	global SCJJCHK stScJjChk;
	
//-----------------------------------------------------------------------------------------------	
//				������ ���� ������
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCJJNogood
	{
		char REGTR_NUM           	[8 +1];
		char CHK_PLAN_YM         	[6 +1];
		char SAFE_CHK_TYPE       	[2 +1];
		char REGTR_NOT_PASS_FLAG 	[2 +1];
		char REGTR_NOT_PASS_ITEM 	[2 +1];
//		char NOT_PASS_PHOTO_IMAGE	[2 +1];
		char NOT_PASS_BETTER_YMD 	[8 +1];
		char CORRECTION_FLAG     	[1 +1];
		char SEND_YN             	[1 +1];
		char EMP_ID              	[9 +1];
		char UPD_EMPID           	[20+1];
	}	SCJJNogood;
	
	global SCJJNogood stScJjNogood;
	
//-----------------------------------------------------------------------------------------------	
//				������ ����_�跮�⸮��Ʈ
//-----------------------------------------------------------------------------------------------	
	typedef struct _SCJJMtr
	{
		char REGTR_NUM          [8 +1];
		char CHK_PLAN_YM        [6 +1];
		char SAFE_CHK_TYPE      [2 +1];
		char MTR_ID_NUM         [20+1];
		char REGTR_ID_NUM       [15+1];
		char MTR_NUM            [9 +1];
		char MTR_LOC_FLAG       [20+1];
		char MTR_DETA_LOC       [30+1];
		char MTR_GRD            [10+1];
		char REGTR_RESOU_CHG_STS[2 +1];
		char SEND_YN            [1 +1];
		char EMP_ID             [9 +1];
		char UPD_EMPID          [9 +1];
		char RSLT_REFLE_YMD     [8 +1];
		char CHK                [1 +1];
	}	SCJJMtr;
	
	global SCJJMtr stScJjMtr;
	
	
//-----------------------------------------------------------------------------------------------	
//				������
//-----------------------------------------------------------------------------------------------	
	typedef struct _CUSTPTRN
	{
		char CHK_YEAR       	[4  +1];
		char CHK_ORDER      	[2  +1]; 
		char CHK_TYPE       	[2  +1];  
		char BLD_NUM        	[9  +1];  
		char INST_PLACE_NUM 	[9  +1]; 
		char UPD_EMPID      	[9  +1]; 
		char UPD_IP         	[32 +1]; 
		char CUST_NUM       	[10 +1]; 
		char USE_CONT_NUM   	[10 +1]; 
		char CHK_VISIT_GBN  	[10 +1]; 
		char CHK_WISH_WEEK  	[10 +1];
		char CHK_WISH_TIME  	[10 +1]; 
		char EMR_DDD        	[4  +1];  
		char EMR_EXN        	[4  +1];
		char EMR_NUM        	[4  +1];
		char OUT_PLAN_YN    	[5  +1]; 
		char OUT_PLAN_YMD   	[8  +1];  
		char INDU_YN        	[1  +1];  
		char COLL_YMD       	[8  +1]; 
		char COLL_EMPID     	[9  +1]; 
		char COLL_EMPNM     	[20 +1]; 
		char SEND_YN        	[1  +1]; 
	}	CUSTPTRN;
	
	global CUSTPTRN stCustPtrn;

//-----------------------------------------------------------------------------------------------	
//				�Ի������
//-----------------------------------------------------------------------------------------------	
	typedef struct _STANDPIPECHK
	{
		char CHK_YEAR       	[4  +1];
		char CHK_ORDER      	[2  +1]; 
		char CHK_TYPE       	[2  +1];  
		char BLD_NUM        	[9  +1];  
		char CHK_EMPID  	    [9  +1]; 
		char CHKER_NM       	[12 +1]; 
		char CHK_YMD          	[8  +1]; 
		char CHK_TIME        	[6  +1]; 
		char GAS_LK    	        [1  +1]; 
		char PIPE_RUST   	    [1  +1]; 
		char STAND_PIPE_PROTE_INST [1 +1];
		char PIPE_CNT   	    [3  +1]; 
		char SEND_YN        	[1  +1];  
	}	STANDPIPECHK;
	
	global STANDPIPECHK stStandPipChk;	
	
#endif

