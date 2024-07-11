/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		BSDATA_H
#define		BSDATA_H

//�跮�� ����Ʈ ��������
#define BSMTRLST_FILE	 		"BSMTRLST.dat"

//-----------------------------------------------------------------------------------------------	
// 	Ư������ ��� 
//-----------------------------------------------------------------------------------------------	
	typedef struct _BSINFO
	{
		char ROWID               [5 + 1];	//rowid
		char CHK_EXEC_NUM        [12 +1]; // ���˽����ȣ             
		char ADDR1_M             [4  +1]; // ����_����                
		char ADDR1_S             [4  +1]; // ����_�ι�                
		char SECOND_ADDR         [100+1]; // ����_�����ּ�            
		char BLD_DONG            [4  +1]; // �ǹ���                   
		char HOSU                [4  +1]; // ȣ��                     
		char ZIP_NO1             [3  +1]; // �����ȣ1                
		char ZIP_NO2             [3  +1]; // �����ȣ2                
		char NEW_HOSU            [4  +1]; // ���ּ�_ȣ��              
		char NEW_ADDR_UNGRNOUD_YN[1  +1]; // ���ּ�_���Ͽ���          
		char NEW_ADDR_UNION      [300+1]; // ���ּ�����               
		char CHK_YEAR            [4  +1]; // ���˳⵵                 
		char CHK_ORDER           [2  +1]; // ��������                 
		char SPECIAL_NUM         [7  +1]; // Ư����ȣ                 
		char CHK_TYPE            [2  +1]; // ��������                 
		char OBJ_YM              [6  +1]; // �����                 
		char PLAN_YM             [6  +1]; // ��ȹ���                 
		char SPECIAL_NM          [50 +1]; // Ư����                   
		char CENTER_CD           [6  +1]; // �����ڵ�                 
		char ZONE_MANAGE_NUM     [5  +1]; // ������ȣ                 
		char PDA_NUM             [5  +1]; // PDA��ȣ                  
		char BEFO_HALF_CHK_RSLT  [2  +1]; // ���ݱ����˰��           
		char BEFO_HALF_CHK_YMD   [8  +1]; // ���ݱ���������           
		char BEFO_HALF_CHKER_NM  [12 +1]; // ���ݱ������ڸ�           
		char BEFO_HALF_MEMO      [100+1]; // ���ݱ����˸޸�           
		char BEFO_HALF_MEMO_WHY  [2  +1]; // ���ݱ����˸޸����       
		char BAR                 [20 +1]; // ���ڵ�                   
		char REPRE_NM            [30 +1]; // ��ǥ�ڸ�                 
		char REPRE_TEL_DDD       [4  +1]; // ��ǥ����ȭ_�ĺ���ȣ      
		char REPRE_TEL_EXN       [4  +1]; // ��ǥ����ȭ_����          
		char REPRE_TEL_NUM       [4  +1]; // ��ǥ����ȭ_��ȣ          
		char REPRE_CP_DDD        [4  +1]; // ��ǥ���޴���_�ĺ���ȣ    
		char REPRE_CP_EXN        [4  +1]; // ��ǥ���޴���_����        
		char REPRE_CP_NUM        [4  +1]; // ��ǥ���޴���_��ȣ        
		char SAFE_MANAGER_NM     [32 +1]; // �����Ŵ�����             
		char MANAGE_TEL_DDD      [4  +1]; // �����Ŵ�����ȭ_�ĺ���ȣ  
		char MANAGE_TEL_EXN      [4  +1]; // �����Ŵ�����ȭ_����      
		char MANAGE_TEL_NUM      [4  +1]; // �����Ŵ�����ȭ_��ȣ      
		char MANAGE_CP_DDD       [4  +1]; // �����Ŵ����޴���_�ĺ���ȣ
		char MANAGE_CP_EXN       [4  +1]; // �����Ŵ����޴���_����    
		char MANAGE_CP_NUM       [4  +1]; // �����Ŵ����޴���_��ȣ    
		char PRESS_FLAG          [1  +1]; // �з±���                 
		char MULTI_USE_FACI_KIND [3  +1]; // �����̿�ü�����         
		char SPECIAL_YN          [1  +1]; // Ư������                 
		char COMPL_INSPECT_YMD   [8  +1]; // �ϼ��˻���               
		char MM_USE_PLAN_QTY     [10 +1]; // ����뿹����             
		char INS_JOIN_YN         [1  +1]; // ���谡�Կ���             
		char INS_JOIN_YMD        [8  +1]; // ���谡������             
		char CHK_EMPID           [9  +1]; // �����ڻ��               
		char CHKER_NM            [12 +1]; // �����ڸ�                 
		char CHK_YMD             [8  +1]; // ��������                 
		char CHK_TIME_FROM       [6  +1]; // ���˽��۽ð�             
		char CHK_TIME_TO         [6  +1]; // ��������ð�             
		char CHK_RSLT            [2  +1]; // ���˰��                 
		char ADV_DIST_YN         [1  +1]; // ȫ������������           
		char SIGN_RELAT          [20 +1]; // �����ΰ���
		char SIGN				 [300+1]; // ����, ���ǰ� ����. ���� TEXT              
		char CURR_BAR            [20 +1]; // ������ڵ�               
		char BAR_WHY             [2  +1]; // ���ڵ��νĺҰ�����       
		char INFO_FLAG           [1  +1]; // ��������                 
		char GOV_RSLT            [1  +1]; // ���б����˰��           
		char REG_RSLT            [1  +1]; // ���������˰��           
		char PIPE_RSLT           [1  +1]; // ������˰��             
		char PIPEETC_RSLT        [1  +1]; // ��������˰��           
		char SPECIAL_RSLT        [2  +1]; // Ư���ü����˰��         
		char MRT_RSLT            [1  +1]; // �跮�����˰��           
		char SEND_YN             [1  +1]; // �۽ſ���                 
		char CITY                [20 +1]; // �õ�                     
		char COUNTY              [20 +1]; // �ñ���                   
		char TOWN                [20 +1]; // ���鵿                   
		char VILLAGE             [20 +1]; // ��                       
		char NOGOOD_RSLT         [1  +1]; // �����հ��               
		char UPD_EMPID           [20 +1]; // �����ڻ��               
		char PDA_IP              [15 +1]; // PDAIP                    
		char PERIOD_CHK_YMD      [8  +1]; // ����˻�����  
		char BEFO_PERIOD_YMD     [8  +1]; // �����˻�����
		char LAW_TOWN            [30 +1]; // ������                   
		char NEW_ROAD_NM         [100+1]; // ���ּ�_���θ�            
		char NEW_ADDR_M          [10 +1]; // ���ּ�_����              
		char NEW_ADDR_S          [10 +1]; // ���ּ�_�ι�              
		char HEAT_PUMP_YN        [2  +1]; // ��Ʈ��������             
		char PIPE_BURY_YN        [2  +1]; // ����Ÿ�����             
		char PIPE_HIDE_YN        [2  +1]; // �����������
		char INST_BAR_PHOTO_YN   [2  +1]; // Ư������ ���� ����
		char TEMP_INST_BAR_PHOTO_ID [30  +1]; // Ư������ ���� ID
		char TEMP_INST_BAR_PHOTO_YN [2  +1]; // Ư������ ���� ����
		char PREUSE_CHK_WHY		 [2  +1]; // Ư���켱���˴�󿩺�
		char END_YN		         [2  +1]; // �����մ�� END_YN1
		char INFO_YN 			 [2  +1];
		char IMPOSSIBLE_YN       [2  +1];
	}	BSINFO;
	global BSINFO stBs;
	
	typedef struct _GOVINFO
	{
		char CHK_EXEC_NUM        [12+1]; // 
		char GOV_REGTR_FLAG      [2 +1]; // 
		char GOV_REGTR_NUM       [9 +1]; // 
		char MAKER_FLAG          [2 +1]; // 
		char MAKER_NUM           [5 +1]; // 
		char MAKER_NM            [30+1]; // 
		char MODEL_CD            [5 +1]; // 
		char MODEL_NM            [30+1]; // 
		char DISJOINT_CHK_YMD    [8 +1]; // 
		char DISJOINT_CHK_FIRM_CD[10+1]; // 
		char DISJOINT_CHK_FIRM_NM[30+1]; // 
		char SEND_YN             [1 +1];
	
	}	GOVINFO;
	
	// GOVINFO�� �ٸ������� ���� �־ ���б� �������� �������� ����
	typedef struct _GOVINFO2
	{
		char CHK_EXEC_NUM        [12+1];
		char GOV_REGTR_FLAG      [2 +1];
		char GOV_REGTR_NUM       [9 +1];
		char MAKER_FLAG          [2 +1];
		char MAKER_NUM           [5 +1];
		char MAKER_NM            [30+1];
		char MODEL_CD            [5 +1];
		char MODEL_NM            [30+1];
		char DISJOINT_CHK_YMD    [8 +1];
		char DISJOINT_CHK_FIRM_CD[10+1];
		char DISJOINT_CHK_FIRM_NM[30+1];
		char DETA_LOC            [90+1];
		char INST_YMD            [8+1];
		char CRT_DTM             [30+1];
		char SEND_YN             [1 +1];
		char NEW_DISJOINT_CHK_YMD    [8 +1];
		char NEW_DISJOINT_CHK_FIRM_CD[10+1];
		char NEW_DISJOINT_CHK_FIRM_NM[30+1];
		char SET_YMD 			 [1 +1];

		char FILTER_CLEAN_YMD    [8 +1];
		char FILTER_CLEAN_FIRM_CD[10+1];
		char FILTER_CLEAN_FIRM_NM[30+1];

		char NEW_FILTER_CLEAN_YMD    [8 +1];
		char NEW_FILTER_CLEAN_FIRM_CD[10+1];
		char NEW_FILTER_CLEAN_FIRM_NM[30+1];

		char REGTR_LOC_FLAG[2+1];
		char REGTR_STD[2+1];

		
	} GOVINFO2;
	global GOVINFO2 stGovinfo2;
	
//-----------------------------------------------------------------------------------------------	
//				�����ǰ����� ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _BSNOGOOD
	{
		char CHK_EXEC_NUM        	[12 +1];
		char OBJ_YM              	[6  +1];
		char SPECIAL_NUM         	[7  +1];
		char CHK_TYPE            	[2  +1];
		char SPECIAL_NM          	[50 +1];
		char CHK_YEAR            	[4  +1];
		char CHK_ORDER           	[2  +1];
		char CENTER_CD           	[6  +1];
		char ZONE_MANAGE_NUM     	[5  +1];
		char PDA_NUM             	[5  +1];
		char CITY                	[20 +1];
		char COUNTY              	[20 +1];
		char TOWN                	[20 +1];
		char VILLAGE             	[20 +1];
		char ADDR1_M             	[4  +1];
		char ADDR1_S             	[4  +1];
		char SECOND_ADDR         	[100+1];
		char BLD_DONG            	[4  +1];
		char HOSU                	[4  +1];
		char CURR_ADDR_UNION     	[300+1];
		char ZIP_NO1             	[3  +1];
		char ZIP_NO2             	[3  +1];
		char NEW_HOSU            	[4  +1];
		char NEW_ADDR_UNGRNOUD_YN	[1  +1];
		char NEW_ADDR_UNION      	[300+1];
		char SAFE_MANAGER_NM     	[32 +1];
		char MANAGE_TEL_DDD      	[4  +1];
		char MANAGE_TEL_EXN      	[4  +1];
		char MANAGE_TEL_NUM      	[4  +1];
		char MANAGE_CP_DDD       	[4  +1];
		char MANAGE_CP_EXN       	[4  +1];
		char MANAGE_CP_NUM       	[4  +1];
		char PRESS_FLAG          	[1  +1];
		char SPECIAL_YN          	[1  +1];
		char COMPL_INSPECT_YMD   	[8  +1];
		char MM_USE_PLAN_QTY     	[7  +1];
		char INS_JOIN_YN         	[1  +1];
		char INS_JOIN_YMD        	[8  +1];
		char END_YN              	[1  +1];
		char SEND_YN             	[1  +1];
		char EMP_ID              	[20 +1];
		char UPD_EMPID           	[20 +1];
		char PDA_IP              	[15 +1];
		char LAW_TOWN            	[30 +1];
		char NEW_ROAD_NM         	[100+1];
		char NEW_ADDR_M          	[10 +1];
		char NEW_ADDR_S          	[10 +1];
//�����ջ�
		char CHK_SEC_CD       	[2   +1];              
		char MTR_NUM          	[9   +1];              
		char BURNER_NUM       	[6   +1];              
		char NOT_PASS_ITEM_CD 	[2   +1];              
		char CHK_SEC_NM       	[32  +1];              
		char NOT_PASS_ITEM_NM 	[32  +1];              
		char VISIT_DTM        	[14  +1];              
		char BETTER_PLAN_YMD  	[8   +1];              
		char BETTER_YN        	[1   +1];              
		char BETTER_END_YMD   	[8   +1];              
		char BETTER_CONF_EMPID	[9   +1];              
		char BETTER_CONF_NM   	[20  +1];              
		char PHOTO            	[300 +1];	//[TEXT];
		char BETTER_DEGREE    	[3   +1]; 
		char MTR_ID_NUM      	[20   +1];              
			
	}	BSNOGOOD;
	
	global BSNOGOOD stBsNogood;
	
//-----------------------------------------------------------------------------------------------
//				�跮��
//-----------------------------------------------------------------------------------------------
	typedef struct _BSMTR
	{
		char CHK_EXEC_NUM        [12 +1];
		char MTR_NUM             [9  +1];
		char BLD_NUM             [9  +1];
		char INST_PLACE_NUM      [9  +1];
		char REPL_OCCU_FLAG      [2  +1];
		char ADDR1_S             [30 +1];
		char LOT_NUM_SECOND_ADDR [100+1];
		char CO_LIVE_NM          [60 +1];
		char HOUSE_CNT           [6  +1];
		char BLD_NM              [150+1];
		char DETA_FLOOR          [6  +1];
		char CUST_NUM            [10 +1];
		char CUST_NM             [30 +1];
		char FIRM_NM             [50 +1];
		char SOC_NUM             [13 +1];
		char CP_DDD              [4  +1];
		char CP_EXN              [4  +1];
		char CP_NUM              [4  +1];
		char OWNHOUSE_TEL_DDD    [4  +1];
		char OWNHOUSE_TEL_EXN    [4  +1];
		char OWNHOUSE_TEL_NUM    [4  +1];
		char USE_CONT_NUM        [10 +1];
		char PROD_NM             [50 +1];
		char MTR_SUPPLY_STS      [10 +1];
		char MTR_ID_NUM          [20 +1];
		char MTR_MODEL_NM        [50 +1];
		char MTR_GRD             [11 +1];	//���� ���´� NUMERIC(10.2)�� ��ϵǾ��־���
		char MTR_VALID_YM        [6  +1];
		char COMPENS_YN          [1  +1];
		char COMPENS_NUM         [8  +1];
		char COMPENS_ID_NUM      [8  +1];
		char COMPENS_MODEL_NM    [50 +1];
		char COMPENS_VALID_YM    [6  +1];
		char MTR_INDI            [9  +1];
		char INDI_VA             [9  +1];
		char INDI_VC             [9  +1];
		char MRT_RSLT            [1  +1];
		char CHK_EXCEP_WHY       [2  +1];
		char CHK_RSLT            [1  +1];
		char SEND_YN             [1  +1];
		char MTR_INDI_CUR        [9  +1];
		char INDI_VA_CUR         [9  +1];
		char INDI_VC_CUR         [9  +1];
		char UPD_EMPID           [20 +1];
		char VISIT_DTM           [14 +1];
		char PDA_IP              [15 +1];
		char CHK_YEAR            [4  +1];
		char CHK_ORDER           [2  +1];
		char SPECIAL_NUM         [7  +1];
		char CHK_TYPE            [2  +1];
		char OBJ_YM              [6  +1];
		char PLAN_YM             [6  +1];
		char MEMO                [100+1];
		char SOCIAL_WELF_FACI_YN [1  +1];
		char FACI_STS_CD         [1  +1];
		char MTR_DETA_LOC        [30  +1];
		char BUILT_IN_YN		 [1   +1];
	}	BSMTR;

	global BSMTR stBsMtr;
	
//-----------------------------------------------------------------------------------------------
//				���ұ�,���Ϸ�
//-----------------------------------------------------------------------------------------------
	typedef struct _BSBUR
	{
		char CHK_EXEC_NUM        [12+1];
		char MTR_NUM             [10+1];
		char BURNER_NUM          [10+1];
		char UPD_IP              [15+1];
		char UPD_EMPID           [20+1];
		char BURNER_CLASS_CD     [20+1];
		char BURNER_CLASS_NM     [20+1];
		char BURNER_KIND_NUM     [30+1];
		char BURNER_KIND_NM      [30+1];
		char BURNER_MODEL_CD     [20+1];
		char BURNER_CAPA         [10+1];
		char BURNER_CAPA_UNIT    [20+1];
		char BURNER_INST_YMD     [8 +1];
		char BURNER_MODEL_NM     [20+1];
		char MAKER_NM            [20+1];
		char BOILER_FORM         [20+1];
		char BOILER_FORM_NM      [25+1];
		char MAKE_NUM            [30+1];
		char INST_FLAG           [20+1];
		char INST_FLAG_NM        [20+1];
		char INST_LOC            [20+1];
		char INST_LOC_NM         [20+1];
		char BOILER_INST_FIRM_CD [20+1];
		char CHG_FLAG            [1 +1];
		char MTR_ID_NUM          [15+1];
		char MAKER_NUM           [8 +1];
		char SEND_YN             [1 +1];
		char SPECIAL_NUM         [20+1];
		char CHK_TYPE            [2 +1];
		char CHK_YEAR            [4 +1];
		char CHK_ORDER           [2 +1];
		char OBJ_YM              [6 +1];
		char PLAN_YM             [6 +1];
		char BUR_RSLT            [1 +1];
		char BURNER_REMOV_YMD    [10+1];
		char DETA_LOC    		 [30+1];
		char WORK_YMD 			 [8 +1];
		char WORK_FIRM 			 [50 +1];
	}	BSBUR;

	global BSBUR stBsBur;
	
	
//-----------------------------------------------------------------------------------------------
//				�������
//-----------------------------------------------------------------------------------------------
	typedef struct _BSPIPE
	{
		char CHK_EXEC_NUM          [20+1];
		char CHK_YEAR              [4 +1];
		char CHK_ORDER             [2 +1];
		char CHK_TYPE              [2 +1];
		char SPECIAL_NUM           [20+1];
		char MTR_NUM               [9 +1];
		char CHK_YMD               [8 +1];
		char UPD_EMPID             [9 +1];
		char PDA_IP                [13+1];
		char PIPE_FLAG             [2 +1];
		char GAS_DAMP_YN           [2 +1];
		char MULTI_GAS_MTR_YN      [2 +1];
		char PIPE_INSPEC_HOLE_YN   [2 +1];
		char CUTOFF_INSPEC_HOLE_YN [2 +1];
		char PIPE_LOC_MARK_YN      [2 +1];
	}	BSPIPE;

	global BSPIPE stBsPipe;

//-----------------------------------------------------------------------------------------------	
//				�����ǰ�����(����������) ����
//-----------------------------------------------------------------------------------------------	
	typedef struct _BSNOGOODCHA
	{
		char CHK_EXEC_NUM        	[12+1];
		char BETTER_ADVICE_DEGREE	[3 +1];
		char OBJ_YM              	[6 +1];
		char SPECIAL_NUM         	[7 +1];
		char CHK_TYPE            	[2 +1];
		char BETTER_ADVICE_YMD   	[8 +1];
		char BETTER_ADVICE_EXPIRE	[8 +1];
		char BETTER_YN           	[1 +1];
		char BETTER_END_YMD      	[8 +1];
		char SUPPLY_STOP_YMD     	[8 +1];
		char NOT_PERMIT_WHY      	[2 +1];
		char SEND_YN             	[1 +1];
		char UPD_EMPID           	[20+1];
		char PDA_IP              	[15+1];
		char CHK_YEAR            	[4 +1];
		char CHK_ORDER           	[2 +1];
	}	BSNOGOODCHA;
	
	global BSNOGOODCHA stBsNogoodCha;
	
	


#endif

