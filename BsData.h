/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		BSDATA_H
#define		BSDATA_H

//계량기 리스트 저장파일
#define BSMTRLST_FILE	 		"BSMTRLST.dat"

//-----------------------------------------------------------------------------------------------	
// 	특정점검 대상 
//-----------------------------------------------------------------------------------------------	
	typedef struct _BSINFO
	{
		char ROWID               [5 + 1];	//rowid
		char CHK_EXEC_NUM        [12 +1]; // 점검시행번호             
		char ADDR1_M             [4  +1]; // 지번_본번                
		char ADDR1_S             [4  +1]; // 지번_부번                
		char SECOND_ADDR         [100+1]; // 지번_보조주소            
		char BLD_DONG            [4  +1]; // 건물동                   
		char HOSU                [4  +1]; // 호수                     
		char ZIP_NO1             [3  +1]; // 우편번호1                
		char ZIP_NO2             [3  +1]; // 우편번호2                
		char NEW_HOSU            [4  +1]; // 새주소_호수              
		char NEW_ADDR_UNGRNOUD_YN[1  +1]; // 새주소_지하여부          
		char NEW_ADDR_UNION      [300+1]; // 새주소조합               
		char CHK_YEAR            [4  +1]; // 점검년도                 
		char CHK_ORDER           [2  +1]; // 점검차수                 
		char SPECIAL_NUM         [7  +1]; // 특정번호                 
		char CHK_TYPE            [2  +1]; // 점검유형                 
		char OBJ_YM              [6  +1]; // 대상년월                 
		char PLAN_YM             [6  +1]; // 계획년월                 
		char SPECIAL_NM          [50 +1]; // 특정명                   
		char CENTER_CD           [6  +1]; // 센터코드                 
		char ZONE_MANAGE_NUM     [5  +1]; // 구역번호                 
		char PDA_NUM             [5  +1]; // PDA번호                  
		char BEFO_HALF_CHK_RSLT  [2  +1]; // 전반기점검결과           
		char BEFO_HALF_CHK_YMD   [8  +1]; // 전반기점검일자           
		char BEFO_HALF_CHKER_NM  [12 +1]; // 전반기점검자명           
		char BEFO_HALF_MEMO      [100+1]; // 전반기점검메모           
		char BEFO_HALF_MEMO_WHY  [2  +1]; // 전반기점검메모사유       
		char BAR                 [20 +1]; // 바코드                   
		char REPRE_NM            [30 +1]; // 대표자명                 
		char REPRE_TEL_DDD       [4  +1]; // 대표자전화_식별번호      
		char REPRE_TEL_EXN       [4  +1]; // 대표자전화_국번          
		char REPRE_TEL_NUM       [4  +1]; // 대표자전화_번호          
		char REPRE_CP_DDD        [4  +1]; // 대표자휴대폰_식별번호    
		char REPRE_CP_EXN        [4  +1]; // 대표자휴대폰_국번        
		char REPRE_CP_NUM        [4  +1]; // 대표자휴대폰_번호        
		char SAFE_MANAGER_NM     [32 +1]; // 안전매니저명             
		char MANAGE_TEL_DDD      [4  +1]; // 안전매니저전화_식별번호  
		char MANAGE_TEL_EXN      [4  +1]; // 안전매니저전화_국번      
		char MANAGE_TEL_NUM      [4  +1]; // 안전매니저전화_번호      
		char MANAGE_CP_DDD       [4  +1]; // 안전매니저휴대폰_식별번호
		char MANAGE_CP_EXN       [4  +1]; // 안전매니저휴대폰_국번    
		char MANAGE_CP_NUM       [4  +1]; // 안전매니저휴대폰_번호    
		char PRESS_FLAG          [1  +1]; // 압력구분                 
		char MULTI_USE_FACI_KIND [3  +1]; // 다중이용시설종류         
		char SPECIAL_YN          [1  +1]; // 특정여부                 
		char COMPL_INSPECT_YMD   [8  +1]; // 완성검사일               
		char MM_USE_PLAN_QTY     [10 +1]; // 월사용예정량             
		char INS_JOIN_YN         [1  +1]; // 보험가입여부             
		char INS_JOIN_YMD        [8  +1]; // 보험가입일자             
		char CHK_EMPID           [9  +1]; // 점검자사번               
		char CHKER_NM            [12 +1]; // 점검자명                 
		char CHK_YMD             [8  +1]; // 점검일자                 
		char CHK_TIME_FROM       [6  +1]; // 점검시작시간             
		char CHK_TIME_TO         [6  +1]; // 점검종료시간             
		char CHK_RSLT            [2  +1]; // 점검결과                 
		char ADV_DIST_YN         [1  +1]; // 홍보물배포여부           
		char SIGN_RELAT          [20 +1]; // 서명인관계
		char SIGN				 [300+1]; // 서명, 임의값 설정. 본래 TEXT              
		char CURR_BAR            [20 +1]; // 현재바코드               
		char BAR_WHY             [2  +1]; // 바코드인식불가사유       
		char INFO_FLAG           [1  +1]; // 정보구분                 
		char GOV_RSLT            [1  +1]; // 정압기점검결과           
		char REG_RSLT            [1  +1]; // 조정기점검결과           
		char PIPE_RSLT           [1  +1]; // 배관점검결과             
		char PIPEETC_RSLT        [1  +1]; // 배관외점검결과           
		char SPECIAL_RSLT        [2  +1]; // 특정시설점검결과         
		char MRT_RSLT            [1  +1]; // 계량기점검결과           
		char SEND_YN             [1  +1]; // 송신여부                 
		char CITY                [20 +1]; // 시도                     
		char COUNTY              [20 +1]; // 시군구                   
		char TOWN                [20 +1]; // 읍면동                   
		char VILLAGE             [20 +1]; // 리                       
		char NOGOOD_RSLT         [1  +1]; // 부적합결과               
		char UPD_EMPID           [20 +1]; // 수정자사번               
		char PDA_IP              [15 +1]; // PDAIP                    
		char PERIOD_CHK_YMD      [8  +1]; // 정기검사일자  
		char BEFO_PERIOD_YMD     [8  +1]; // 이전검사일자
		char LAW_TOWN            [30 +1]; // 법정동                   
		char NEW_ROAD_NM         [100+1]; // 새주소_도로명            
		char NEW_ADDR_M          [10 +1]; // 새주소_본번              
		char NEW_ADDR_S          [10 +1]; // 새주소_부번              
		char HEAT_PUMP_YN        [2  +1]; // 히트펌프유무             
		char PIPE_BURY_YN        [2  +1]; // 배관매립유무             
		char PIPE_HIDE_YN        [2  +1]; // 배관은폐유무
		char INST_BAR_PHOTO_YN   [2  +1]; // 특정점검 사진 유무
		char TEMP_INST_BAR_PHOTO_ID [30  +1]; // 특정점검 사진 ID
		char TEMP_INST_BAR_PHOTO_YN [2  +1]; // 특정점검 사진 유무
		char PREUSE_CHK_WHY		 [2  +1]; // 특정우선점검대상여부
		char END_YN		         [2  +1]; // 부적합대상 END_YN1
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
	
	// GOVINFO를 다른곳에서 쓰고 있어서 정압기 분해점검 전용으로 만듬
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
//				개선권고진행 관련
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
//부적합상세
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
//				계량기
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
		char MTR_GRD             [11 +1];	//원래 형태는 NUMERIC(10.2)로 등록되어있었음
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
//				연소기,보일러
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
//				배관점검
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
//				개선권고진행(부적합차수) 관련
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

