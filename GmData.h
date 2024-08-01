/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		GMDATA_H
#define		GMDATA_H


global char g_szIndi_MtrCode[10];
global char g_szIndi_Qty[10];

//-----------------------------------------------------------------------------------------------	
//				검침 
//-----------------------------------------------------------------------------------------------	
	typedef struct _GMINFO
	{
		char ROWID								[5 + 1];	//rowid
		char REQ_YM								[6 +1];		//청구년월                  
		char DEADLINE_FLAG						[2 +1];		//납기구분                  
		char MTR_NUM							[9 +1];		//계량기번호                
		char GMTR_APPLY_YMD						[8 +1];		//검침적용일자              
		char GMTR_OBJ_FLAG						[2 +1];		//검침대상구분              
		char SUPPLY_STS_CD						[20 +1];	//공급상태코드              
		char SUPPLY_STS_WHY						[20 +1];	//공급상태사유              
		char STR_IND_APPLY_YMD					[8 +1];		//시침적용일자              
		char BASE_YMD							[8 +1];		//기준일자                  
		char MTR_ID_NUM							[20 +1];	//계량기기물번호            
		char MTR_LOC_FLAG						[2 +1];		//계량기위치구분            
		char MTR_RESOU_FLAG						[2 +1];		//계량기자원구분            
		char GRD_TITLE							[30 +1];	//등급타이틀                
		char USAGE_TITLE						[30 +1];	//용도타이틀                
		char HOUSE_NUM_ORD						[40 +1];	//번지순로                  
		char DONG_ORD							[40 +1];	//동순로                    
		char MTR_COURSE							[5 +1];		//계량기진로                
		char USE_CONT_NUM						[10 +1];	//사용계약번호              
		char PROD_CD							[30 +1];	//상품코드                  
		char CONT_YMD							[8 +1];		//계약일자                  
		char CNL_YMD							[8 +1];		//해제일자                  
		char PAY_METHOD							[20 +1];	//납부방법                  
		char NONPAY_EXIST_YN					[1 +1];		//체납존재여부              
		char ZIP_NO1							[3 +1];		//우편번호1                 
		char ZIP_NO2							[3 +1];		//우편번호2                 
		char AREA								[30 +1];	//시군구                    
		char TOWN								[30 +1];	//읍면동                    
		char VILLAGE							[30 +1];	//리                        
		char ADDR1_M							[30 +1];	//본번                      
		char ADDR1_S							[30 +1];	//부번                      
		char CO_LIVE_NM							[60 +1];	//공동주택명                
		char DONG_NUM							[20 +1];	//동번호                    
		char HOSU								[20 +1];	//호수                      
		char BLD_NM								[60 +1];	//건물명                    
		char BLD_NUM							[20 +1];	//건물번호
		char DETA_FLOOR							[100 +1];	//세부층                    
		char NEW_ADDR_UNION						[100 +1];	//새주소조합                
		char CUST_NUM							[10 +1];	//고객번호                  
		char CUST_TYPE_CD						[2 +1];		//고객유형코드              
		char CUST_NM							[30 +1];	//고객명                    
		char FIRM_NM							[50 +1];	//상호명                    
		char BIZ_REGI_NUM						[10 +1];	//사업자번호                
		char SOC_NUM							[13 +1];	//주민번호                  
		char REPRE_NM							[30 +1];	//대표자명                  
		char CP_DDD								[4 +1];		//휴대폰_식별번호           
		char CP_EXN								[4 +1];		//휴대폰_국번               
		char CP_NUM								[4 +1];		//휴대폰_번호               
		char OWNHOUSE_TEL_DDD					[4 +1];		//자택전화_식별번호         
		char OWNHOUSE_TEL_EXN					[4 +1];		//자택전화_국번             
		char OWNHOUSE_TEL_NUM					[4 +1];		//자택전화_번호             
		char BEFO_GMTR_CD_1						[10 +1];	//전월검침코드1             
		char BEFO_MM_INDI_MTR_1					[10 +1];	//전월지침_계량기1          
		char BEFO_MM_INDI_COMPENS_VA_1			[10 +1];	//전월지침_보정기_VA1       
		char BEFO_MM_INDI_COMPENS_VC_1			[10 +1];	//전월지침_보정기_VC1       
		char BEFO_GMTR_CD_2						[10 +1];	//전월검침코드2             
		char BEFO_MM_INDI_MTR_2					[10 +1];	//전월지침_계량기2          
		char BEFO_MM_INDI_COMPENS_VA_2			[10 +1];	//전월지침_보정기_VA2       
		char BEFO_MM_INDI_COMPENS_VC_2			[10 +1];	//전월지침_보정기_VC2       
		char BEFO_GMTR_CD_3						[10 +1];	//전월검침코드3             
		char BEFO_MM_INDI_MTR_3					[10 +1];	//전월지침_계량기3          
		char BEFO_MM_INDI_COMPENS_VA_3			[10 +1];	//전월지침_보정기_VA3       
		char BEFO_MM_INDI_COMPENS_VC_3			[10 +1];	//전월지침_보정기_VC3       
		char BEFO_YY_GMTR_CD					[10 +1];	//전년동월검침코드          
		char BEFO_YY_MTR						[10 +1];	//전년동월지침_계량기       
		char BEFO_YY_COMPENS_VA					[10 +1];	//전년동월지침_보정기_VA    
		char BEFO_YY_COMPENS_VC					[10 +1];	//전년동월지침_보정기_VC    
		char BEFO_MM_USE_QTY_1					[10 +1];	//전월사용량1               
		char BEFO_MM_USE_QTY_2					[10 +1];	//전월사용량2               
		char BEFO_MM_USE_QTY_3					[10 +1];	//전월사용량3               
		char BEFO_YM_USE_QTY					[10 +1];	//전년동월사용량            
		char MTR_CHG_YMD						[8 +1];		//계량기교체일자            
		char MTR_REPL_WHY						[20 +1];	//계량기교체사유            
		char MTR_INDI_CUST						[10 +1];	//지침계량기민원            
		char INDI_COMPENS_CIVIL_SERV_VA			[10 +1];	//지침보정기민원_VA         
		char INDI_COMPENS_CIVIL_SERV_VC			[10 +1];	//지침보정기민원_VC         
		char RMK								[200 +1];	//비고
		char CHK_MEMO							[200 +1];	//통합메모-점검메모
		char MTR_WORK_CODE						[2 +1];		//계량기작업코드            
		char INDI_SET_VM						[10 +1];	//설정지침_VM               
		char INDI_SET_VA						[10 +1];	//설정지침_VA               
		char INDI_SET_VC						[10 +1];	//설정지침_VC               
		char INDI_DATE							[16 +1];	//지침일자                  
		char SEND_YN							[1 +1];		//송신여부                  
		char INDI_QTY							[9 +1];		//지침량                    
		char COMPENS_FLAG						[2 +1];		//보정구분                  
		char GCHK_FLAG							[2 +1];		//안전점검구분              
		char GMTR_YM_FLAG						[2 +1];		//검침월구분                
		char EBPP_FLAG							[1 +1];		//EBPP구분                  
		char MTR_YN								[1 +1];		//계량기여부                
		char MONITOR_FLAG						[2 +1];		//모니터링여부
		char SUBMONITOR_FLAG					[2 +1];		//임시저장 모니터링여부
		char CUST_TRND_YN						[1 +1];		//고객성향여부              
		char GMETER_SEND_YN						[1 +1];		//검침송달여부              
		char CURR_TEMPER						[10 +1];	//상시온도                  
		char CURR_PRES							[10 +1];	//상시압력                  
		char CURR_REVIS_PARA					[10 +1];	//상시보정계수              
		char MAX_GMTR_QTY						[10 +1];	//최대검침량                
		char LAW_TOWN							[30 +1];	//법정동                    
		char NEW_ROAD_NM						[200 +1];	//새주소도로명              
		char NEW_ADDR_M							[30 +1];	//새주소본번                
		char NEW_ADDR_S							[30 +1];	//새주소부번                
		char BIZ_TYPE_YN						[1 +1];		//동일업종여부              
		char SAME_GMTR_YN						[1 +1];		//동일검침코드여부          
		char SELF_GMTR_YN						[2 +1];		//자가검침여부              
		char MTR_FORM							[20 +1];	//계량기 형식
		char INSP_YN						    [5  +1];	//실사 여부
		char INSP_MEMO							[300+1];	//실사 메모
		char INDI_INSP_VM						[10 +1];	//실사 VM
		char INDI_INSP_VA						[10 +1];	//실사 VA
		char INDI_INSP_VC						[10 +1];	//실사 VC
		char INSP_YMD						    [20 +1];	//실사일자
		char INSP_SAVE_YN					    [5  +1];	//실사 저장여부
		char SMS_GMTR_MAN_YN				    [5  +1];	//문자검침 대상 여부
		char NONPAY_MANAGE_SEC				    [10 +1];	//문자검침 
		char GMTR_SEND_STS						[30 +1];	//문자검침 발송진행상태
		char RCV_SMS_DESC						[500+1];	//수신문자내용
		char SMS_NUM							[20 +1];	//SMS_NUM
		char SMS_CP_DDD							[5  +1];	//문자검침 전화번호1
		char SMS_CP_EXN							[5  +1];	//문자검침 전화번호2
		char SMS_CP_NUM							[5  +1];	//문자검침 전화번호3
		char SERVER_DTM							[30 +1];	//서버 시간
		char RECEIVE_DTM						[30 +1];	//회신 받은 시간?
		char PLAN_DTM							[30 +1];	//예약 시간
		char MULTI_USE_CONT_YN					[5  +1];	//복수세대 여부
		char SMS_SEND_AGREE_YN					[5  +1];	//문자검침 동의 여부
		char CONT_STS_CD						[5  +1];	//문자검침 사용계약상태
		char RCV_STS_VERIFY_CD					[10 +1];	//문자검침 회신검증코드
		char SEND_SEQ							[10 +1];	//SEND_SEQ(예약취소 인자)
		char COMPENS_REMOVE_ALARM               [1  +1];    //보정기 전산철거 알림YN
		char MTR_DIGIT_CNT                      [1  +1];    //계량기 자릿수
		char SEND_TYPE                          [2  +1];    //SEND_TYPE
		char SELF_GMTR_STR_YMD                  [8  +1];    //자가검침시작
		char SELF_GMTR_END_YMD                  [8  +1];    //자가검침종료
		char GMTR_SEND_FLAG                     [3  +1];    //GMTR_SEND_FLAG
		char BEFO_GMTR_SMS_YN                   [2  +1];    //BEFO_GMTR_SMS_YN
		char GMTR_MANAGE_STS                    [2  +1];    //GMTR_MANAGE_STS
		char DEADLINE_CHG_YN                    [1  +1];    //DEADLINE_CHG_YN
		char COMPENS_REMOVE_ALARM_2             [1  +1];    //COMPENS_REMOVE_ALARM_2
		char INST_PLACE_NUM                     [9  +1];	//INST_PLACE_NUM
		char OLD_COMPENS_REMOVE_ALARM_2         [1  +1];    //COMPENS_REMOVE_ALARM_2
		char PHOTO_MTR_YN                       [1  +1];	//검침계량기사진
		char PHOTO_COMPENS_VC_YN                [1  +1];	//검침보정기VC사진
		char PHOTO_COMPENS_VA_YN                [1  +1];	//검침보정기VA사진
		char PHOTO_COMPENS_VM_YN                [1  +1];	//검침보정기VM사진
		char GUM_TYPE              			    [1  +1];	//검침TYPE
		char USE_CONT_STS_CD              		[2  +1];	//사용계약상태
		char CHK_VISIBLE						[2  +1];    //메모공개여부
		char GMTR_JOB_YMD_END					[8  +1];    //검침작업종료일자
		char REMOTE_GMTR_YN						[2  +1];    //원격검침YN
		char RECENT_INDI_MTR_MM_VC				[10 +1];    //원격검침지침
		char RECENT_GMTR_JOB_YMD				[8 +1];    //원격검침일자
		char RECENT_GMTR_JOB_YMD_YEAR			[6 +1];    //원격검침년도
		char RECENT_GMTR_JOB_YMD_MONTHS			[4 +1];    //원격검침월
		char RECENT_GMTR_JOB_YMD_DAYS			[4 +1];    //원격검침일
		char ZONE_MANAGE_NUM					[5 +1];    //구역관리번호
		char AMI_REQ_YM							[3 +1];    //3, 11월 AMI검침
	}	GMINFO;
	
	global GMINFO stGm;


//-----------------------------------------------------------------------------------------------	
//				요금조회 - 요금내역
//-----------------------------------------------------------------------------------------------	
	typedef struct _FEEHISTORY
	{
		char USE_CONT_NUM        [20]; 
		char SUPPLY_VAL          [30];
		char VAT                 [30];
		char THIS_MM_OCCU_AMT    [30];
		char ADJ_ALT_AMT         [30];
		char SUBTR_REQ_AMT       [30];
		char RECEIVE_AMT         [30];
		char UNPAY_AMT           [30];
		char UNCOL_AMT_REMA      [30];
		char REQ_YM              [10];
		char DEADLINE_FLAG       [10];
		char USE_PERIOD_STR      [30];
		char USE_PERIOD_END      [30];
		char USE_QTY             [30];
		char SET_QTY             [30];
		char SUPPLY_UNIT_ENER    [30];
		char ENER_QTY            [30];
		char USE_CHARG           [30];
		char USE_CHARG_DISC_AMT  [30];
		char BASE_CHARG          [30];
		char REPL_COST           [30];
		char OVERDUE_AMT         [30];
		char ADJ_SET_CHARG       [30];
		char CNL_CHARG_SUPPY     [30];
		char REVIS_PARA          [30];
		char INDI_COMPENS_VC     [30];
		char BF_UNPAY_AMT        [30];
		char SUMAMT2             [30];
		char DEBT_UNPAY_AMT      [30];
		char CP_DDD              [6];
		char CP_EXN              [6];
		char CP_NUM              [6];
		char WOORI_ACCNO         [30];
		char KOOKMIN_ACCNO       [30];
		char SHINHAN_ACCNO       [30];
		char HANA_ACCNO          [30];
		char FB_ACCNO            [30];
		char NH_ACCNO            [30];
		char CITY_ACCNO          [30];
		char IBK_ACCNO           [30];
		char CUST_NM             [50];
		char ADDR                [350];
		char CENTER_NM           [50];
		char TEL1_DDD            [6];
		char TEL1_EXN            [6];
		char TEL1_NUM            [6];
		char BF_INDI_COMPENS_VC  [30];
	}	FEEHISTORY;
	
	global FEEHISTORY stFee_History;

//-----------------------------------------------------------------------------------------------	
//				요금조회 - 요금계산
//-----------------------------------------------------------------------------------------------	
	typedef struct _FEECALCUL
	{
		char USE_CONT_NUM           	[15 +1];	//사용계약번호                 
		char ADJ_BASE_YMD           	[20 +1];	//정산기준일자           	   
		char ADJ_JOB_DTM            	[20 +1];	//정산작업일시                 
		char ADJ_REQ_STS            	[20 +1];	//정산청구상태                 
		char SUPPLY_VAL             	[15 +1];	//공급가액                     
		char VAT                    	[15 +1];	//부가세액                     
		char THIS_MM_OCCU_AMT       	[15 +1];	//당월발생액                   
		char ADJ_ALT_AMT            	[15 +1];	//정산대체액                   
		char SUBTR_REQ_AMT          	[15 +1];	//차감청구액                   
		char RECEIVE_AMT            	[15 +1];	//수납액                       
		char UNPAY_AMT              	[15 +1];	//미납액                       
		char UNCOL_AMT_REMA         	[15 +1];	//미수금잔액                   
		char TOT_REQ_AMT            	[15 +1];	//총청구액                     
		char REQ_AMT					[15 +1];	//청구액
		char SUSPN_REQ_AMT				[15 +1];	//예수금대체액
		char SUSPN_REMA             	[15 +1];	//예수금잔액                   
		char REQ_YM                 	[10 +1];	//청구년월                     
		char DEADLINE_FLAG          	[10 +1];	//납기구분                     
		char USE_PERIOD_STR         	[20 +1];	//사용기간_시작                
		char USE_PERIOD_END         	[20 +1];	//사용기간_종료                
		char USE_QTY                	[20 +1];	//사용량                       
		char SET_QTY                	[20 +1];	//조정량                       
		char SUPPLY_UNIT_ENER       	[20 +1];	//단위열량(가중형균열량)       
		char ENER_QTY               	[20 +1];	//사용열량                     
		char USE_CHARG              	[15 +1];	//사용료                       
		char USE_CHARG_DISC_AMT     	[15 +1];	//감면액                       
		char BASE_CHARG             	[15 +1];	//기본금액                     
		char REPL_COST              	[15 +1];	//교체비                       
		char OVERDUE_AMT            	[15 +1];	//연체료                       
		char ADJ_SET_CHARG          	[15 +1];	//정산금액                     
		char CNL_CHARG_SUPPY        	[15 +1];	//해제수수료                   
		char REVIS_PARA             	[20 +1];	//보정계수                     
		char SEQ                    	[20 +1];	//일련번호                     
		char INDI_COMPENS_THIS_MM_VC	[20 +1];	//입력지침                     
		char BF_UNPAY_AMT           	[15 +1];	//이전(후)사용자미납액         
		char SUMAMT2                	[15 +1];	//법적소송및기타금액           
		char DEBT_UNPAY_AMT         	[15 +1];	//대손미납액                   
		char CP_DDD                 	[6  +1];	//전화번호1                    
		char CP_EXN                 	[6  +1];	//전화번호2                    
		char CP_NUM                 	[6  +1];	//전화번호3                    
		char WOORI_ACCNO                [30 +1];    //우리은행 계좌번호                              
		char KOOKMIN_ACCNO              [30 +1];    //국민은행 계좌번호                                
		char SHINHAN_ACCNO              [30 +1];    //신한은행 계좌번호                                
		char HANA_ACCNO                 [30 +1];    //하나은행 계좌번호                                
		char FB_ACCNO                   [30 +1];    //SC은행 계좌번호                                  
		char NH_ACCNO                   [30 +1];    //농협 계좌번호                                    
		char CITY_ACCNO                 [30 +1];    //씨티은행 계좌번호                                
		char IBK_ACCNO                  [30 +1];    //기업은행 계좌번호                                
		char CUST_NM                    [50 +1];    //고객명            
        char ADDR                       [300+1];    //주소                                             
        char CENTER_NM                  [50 +1];    //고객센터명                                       
		char TEL1_DDD                   [6  +1];    //고객센터전화번호1                                
		char TEL1_EXN                   [6  +1];    //고객센터전화번호2                                             
		char TEL1_NUM                   [6  +1];    //고객센터전화번호3 
        char INDI_COMPENS_VC            [10 +1];    //전월지침                     
        char TOT_UNPAY_AMT              [20 +1];    //미납총액                     
	}	FEECALCUL;					                
	
	global FEECALCUL stFee_Calcul;


#endif

