/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		GMDATA_H
#define		GMDATA_H


global char g_szIndi_MtrCode[10];
global char g_szIndi_Qty[10];

//-----------------------------------------------------------------------------------------------	
//				��ħ 
//-----------------------------------------------------------------------------------------------	
	typedef struct _GMINFO
	{
		char ROWID								[5 + 1];	//rowid
		char REQ_YM								[6 +1];		//û�����                  
		char DEADLINE_FLAG						[2 +1];		//���ⱸ��                  
		char MTR_NUM							[9 +1];		//�跮���ȣ                
		char GMTR_APPLY_YMD						[8 +1];		//��ħ��������              
		char GMTR_OBJ_FLAG						[2 +1];		//��ħ��󱸺�              
		char SUPPLY_STS_CD						[20 +1];	//���޻����ڵ�              
		char SUPPLY_STS_WHY						[20 +1];	//���޻��»���              
		char STR_IND_APPLY_YMD					[8 +1];		//��ħ��������              
		char BASE_YMD							[8 +1];		//��������                  
		char MTR_ID_NUM							[20 +1];	//�跮��⹰��ȣ            
		char MTR_LOC_FLAG						[2 +1];		//�跮����ġ����            
		char MTR_RESOU_FLAG						[2 +1];		//�跮���ڿ�����            
		char GRD_TITLE							[30 +1];	//���Ÿ��Ʋ                
		char USAGE_TITLE						[30 +1];	//�뵵Ÿ��Ʋ                
		char HOUSE_NUM_ORD						[40 +1];	//��������                  
		char DONG_ORD							[40 +1];	//������                    
		char MTR_COURSE							[5 +1];		//�跮������                
		char USE_CONT_NUM						[10 +1];	//������ȣ              
		char PROD_CD							[30 +1];	//��ǰ�ڵ�                  
		char CONT_YMD							[8 +1];		//�������                  
		char CNL_YMD							[8 +1];		//��������                  
		char PAY_METHOD							[20 +1];	//���ι��                  
		char NONPAY_EXIST_YN					[1 +1];		//ü�����翩��              
		char ZIP_NO1							[3 +1];		//�����ȣ1                 
		char ZIP_NO2							[3 +1];		//�����ȣ2                 
		char AREA								[30 +1];	//�ñ���                    
		char TOWN								[30 +1];	//���鵿                    
		char VILLAGE							[30 +1];	//��                        
		char ADDR1_M							[30 +1];	//����                      
		char ADDR1_S							[30 +1];	//�ι�                      
		char CO_LIVE_NM							[60 +1];	//�������ø�                
		char DONG_NUM							[20 +1];	//����ȣ                    
		char HOSU								[20 +1];	//ȣ��                      
		char BLD_NM								[60 +1];	//�ǹ���                    
		char BLD_NUM							[20 +1];	//�ǹ���ȣ
		char DETA_FLOOR							[100 +1];	//������                    
		char NEW_ADDR_UNION						[100 +1];	//���ּ�����                
		char CUST_NUM							[10 +1];	//����ȣ                  
		char CUST_TYPE_CD						[2 +1];		//�������ڵ�              
		char CUST_NM							[30 +1];	//����                    
		char FIRM_NM							[50 +1];	//��ȣ��                    
		char BIZ_REGI_NUM						[10 +1];	//����ڹ�ȣ                
		char SOC_NUM							[13 +1];	//�ֹι�ȣ                  
		char REPRE_NM							[30 +1];	//��ǥ�ڸ�                  
		char CP_DDD								[4 +1];		//�޴���_�ĺ���ȣ           
		char CP_EXN								[4 +1];		//�޴���_����               
		char CP_NUM								[4 +1];		//�޴���_��ȣ               
		char OWNHOUSE_TEL_DDD					[4 +1];		//������ȭ_�ĺ���ȣ         
		char OWNHOUSE_TEL_EXN					[4 +1];		//������ȭ_����             
		char OWNHOUSE_TEL_NUM					[4 +1];		//������ȭ_��ȣ             
		char BEFO_GMTR_CD_1						[10 +1];	//������ħ�ڵ�1             
		char BEFO_MM_INDI_MTR_1					[10 +1];	//������ħ_�跮��1          
		char BEFO_MM_INDI_COMPENS_VA_1			[10 +1];	//������ħ_������_VA1       
		char BEFO_MM_INDI_COMPENS_VC_1			[10 +1];	//������ħ_������_VC1       
		char BEFO_GMTR_CD_2						[10 +1];	//������ħ�ڵ�2             
		char BEFO_MM_INDI_MTR_2					[10 +1];	//������ħ_�跮��2          
		char BEFO_MM_INDI_COMPENS_VA_2			[10 +1];	//������ħ_������_VA2       
		char BEFO_MM_INDI_COMPENS_VC_2			[10 +1];	//������ħ_������_VC2       
		char BEFO_GMTR_CD_3						[10 +1];	//������ħ�ڵ�3             
		char BEFO_MM_INDI_MTR_3					[10 +1];	//������ħ_�跮��3          
		char BEFO_MM_INDI_COMPENS_VA_3			[10 +1];	//������ħ_������_VA3       
		char BEFO_MM_INDI_COMPENS_VC_3			[10 +1];	//������ħ_������_VC3       
		char BEFO_YY_GMTR_CD					[10 +1];	//���⵿����ħ�ڵ�          
		char BEFO_YY_MTR						[10 +1];	//���⵿����ħ_�跮��       
		char BEFO_YY_COMPENS_VA					[10 +1];	//���⵿����ħ_������_VA    
		char BEFO_YY_COMPENS_VC					[10 +1];	//���⵿����ħ_������_VC    
		char BEFO_MM_USE_QTY_1					[10 +1];	//������뷮1               
		char BEFO_MM_USE_QTY_2					[10 +1];	//������뷮2               
		char BEFO_MM_USE_QTY_3					[10 +1];	//������뷮3               
		char BEFO_YM_USE_QTY					[10 +1];	//���⵿����뷮            
		char MTR_CHG_YMD						[8 +1];		//�跮�ⱳü����            
		char MTR_REPL_WHY						[20 +1];	//�跮�ⱳü����            
		char MTR_INDI_CUST						[10 +1];	//��ħ�跮��ο�            
		char INDI_COMPENS_CIVIL_SERV_VA			[10 +1];	//��ħ������ο�_VA         
		char INDI_COMPENS_CIVIL_SERV_VC			[10 +1];	//��ħ������ο�_VC         
		char RMK								[200 +1];	//���
		char CHK_MEMO							[200 +1];	//���ո޸�-���˸޸�
		char MTR_WORK_CODE						[2 +1];		//�跮���۾��ڵ�            
		char INDI_SET_VM						[10 +1];	//������ħ_VM               
		char INDI_SET_VA						[10 +1];	//������ħ_VA               
		char INDI_SET_VC						[10 +1];	//������ħ_VC               
		char INDI_DATE							[16 +1];	//��ħ����                  
		char SEND_YN							[1 +1];		//�۽ſ���                  
		char INDI_QTY							[9 +1];		//��ħ��                    
		char COMPENS_FLAG						[2 +1];		//��������                  
		char GCHK_FLAG							[2 +1];		//�������˱���              
		char GMTR_YM_FLAG						[2 +1];		//��ħ������                
		char EBPP_FLAG							[1 +1];		//EBPP����                  
		char MTR_YN								[1 +1];		//�跮�⿩��                
		char MONITOR_FLAG						[2 +1];		//����͸�����
		char SUBMONITOR_FLAG					[2 +1];		//�ӽ����� ����͸�����
		char CUST_TRND_YN						[1 +1];		//�����⿩��              
		char GMETER_SEND_YN						[1 +1];		//��ħ�۴޿���              
		char CURR_TEMPER						[10 +1];	//��ÿµ�                  
		char CURR_PRES							[10 +1];	//��þз�                  
		char CURR_REVIS_PARA					[10 +1];	//��ú������              
		char MAX_GMTR_QTY						[10 +1];	//�ִ��ħ��                
		char LAW_TOWN							[30 +1];	//������                    
		char NEW_ROAD_NM						[200 +1];	//���ּҵ��θ�              
		char NEW_ADDR_M							[30 +1];	//���ּҺ���                
		char NEW_ADDR_S							[30 +1];	//���ּҺι�                
		char BIZ_TYPE_YN						[1 +1];		//���Ͼ�������              
		char SAME_GMTR_YN						[1 +1];		//���ϰ�ħ�ڵ忩��          
		char SELF_GMTR_YN						[2 +1];		//�ڰ���ħ����              
		char MTR_FORM							[20 +1];	//�跮�� ����
		char INSP_YN						    [5  +1];	//�ǻ� ����
		char INSP_MEMO							[300+1];	//�ǻ� �޸�
		char INDI_INSP_VM						[10 +1];	//�ǻ� VM
		char INDI_INSP_VA						[10 +1];	//�ǻ� VA
		char INDI_INSP_VC						[10 +1];	//�ǻ� VC
		char INSP_YMD						    [20 +1];	//�ǻ�����
		char INSP_SAVE_YN					    [5  +1];	//�ǻ� ���忩��
		char SMS_GMTR_MAN_YN				    [5  +1];	//���ڰ�ħ ��� ����
		char NONPAY_MANAGE_SEC				    [10 +1];	//���ڰ�ħ 
		char GMTR_SEND_STS						[30 +1];	//���ڰ�ħ �߼��������
		char RCV_SMS_DESC						[500+1];	//���Ź��ڳ���
		char SMS_NUM							[20 +1];	//SMS_NUM
		char SMS_CP_DDD							[5  +1];	//���ڰ�ħ ��ȭ��ȣ1
		char SMS_CP_EXN							[5  +1];	//���ڰ�ħ ��ȭ��ȣ2
		char SMS_CP_NUM							[5  +1];	//���ڰ�ħ ��ȭ��ȣ3
		char SERVER_DTM							[30 +1];	//���� �ð�
		char RECEIVE_DTM						[30 +1];	//ȸ�� ���� �ð�?
		char PLAN_DTM							[30 +1];	//���� �ð�
		char MULTI_USE_CONT_YN					[5  +1];	//�������� ����
		char SMS_SEND_AGREE_YN					[5  +1];	//���ڰ�ħ ���� ����
		char CONT_STS_CD						[5  +1];	//���ڰ�ħ ��������
		char RCV_STS_VERIFY_CD					[10 +1];	//���ڰ�ħ ȸ�Ű����ڵ�
		char SEND_SEQ							[10 +1];	//SEND_SEQ(������� ����)
		char COMPENS_REMOVE_ALARM               [1  +1];    //������ ����ö�� �˸�YN
		char MTR_DIGIT_CNT                      [1  +1];    //�跮�� �ڸ���
		char SEND_TYPE                          [2  +1];    //SEND_TYPE
		char SELF_GMTR_STR_YMD                  [8  +1];    //�ڰ���ħ����
		char SELF_GMTR_END_YMD                  [8  +1];    //�ڰ���ħ����
		char GMTR_SEND_FLAG                     [3  +1];    //GMTR_SEND_FLAG
		char BEFO_GMTR_SMS_YN                   [2  +1];    //BEFO_GMTR_SMS_YN
		char GMTR_MANAGE_STS                    [2  +1];    //GMTR_MANAGE_STS
		char DEADLINE_CHG_YN                    [1  +1];    //DEADLINE_CHG_YN
		char COMPENS_REMOVE_ALARM_2             [1  +1];    //COMPENS_REMOVE_ALARM_2
		char INST_PLACE_NUM                     [9  +1];	//INST_PLACE_NUM
		char OLD_COMPENS_REMOVE_ALARM_2         [1  +1];    //COMPENS_REMOVE_ALARM_2
		char PHOTO_MTR_YN                       [1  +1];	//��ħ�跮�����
		char PHOTO_COMPENS_VC_YN                [1  +1];	//��ħ������VC����
		char PHOTO_COMPENS_VA_YN                [1  +1];	//��ħ������VA����
		char PHOTO_COMPENS_VM_YN                [1  +1];	//��ħ������VM����
		char GUM_TYPE              			    [1  +1];	//��ħTYPE
		char USE_CONT_STS_CD              		[2  +1];	//��������
		char CHK_VISIBLE						[2  +1];    //�޸��������
		char GMTR_JOB_YMD_END					[8  +1];    //��ħ�۾���������
		char REMOTE_GMTR_YN						[2  +1];    //���ݰ�ħYN
		char RECENT_INDI_MTR_MM_VC				[10 +1];    //���ݰ�ħ��ħ
		char RECENT_GMTR_JOB_YMD				[8 +1];    //���ݰ�ħ����
		char RECENT_GMTR_JOB_YMD_YEAR			[6 +1];    //���ݰ�ħ�⵵
		char RECENT_GMTR_JOB_YMD_MONTHS			[4 +1];    //���ݰ�ħ��
		char RECENT_GMTR_JOB_YMD_DAYS			[4 +1];    //���ݰ�ħ��
		char ZONE_MANAGE_NUM					[5 +1];    //����������ȣ
		char AMI_REQ_YM							[3 +1];    //3, 11�� AMI��ħ
	}	GMINFO;
	
	global GMINFO stGm;


//-----------------------------------------------------------------------------------------------	
//				�����ȸ - ��ݳ���
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
//				�����ȸ - ��ݰ��
//-----------------------------------------------------------------------------------------------	
	typedef struct _FEECALCUL
	{
		char USE_CONT_NUM           	[15 +1];	//������ȣ                 
		char ADJ_BASE_YMD           	[20 +1];	//�����������           	   
		char ADJ_JOB_DTM            	[20 +1];	//�����۾��Ͻ�                 
		char ADJ_REQ_STS            	[20 +1];	//����û������                 
		char SUPPLY_VAL             	[15 +1];	//���ް���                     
		char VAT                    	[15 +1];	//�ΰ�����                     
		char THIS_MM_OCCU_AMT       	[15 +1];	//����߻���                   
		char ADJ_ALT_AMT            	[15 +1];	//�����ü��                   
		char SUBTR_REQ_AMT          	[15 +1];	//����û����                   
		char RECEIVE_AMT            	[15 +1];	//������                       
		char UNPAY_AMT              	[15 +1];	//�̳���                       
		char UNCOL_AMT_REMA         	[15 +1];	//�̼����ܾ�                   
		char TOT_REQ_AMT            	[15 +1];	//��û����                     
		char REQ_AMT					[15 +1];	//û����
		char SUSPN_REQ_AMT				[15 +1];	//�����ݴ�ü��
		char SUSPN_REMA             	[15 +1];	//�������ܾ�                   
		char REQ_YM                 	[10 +1];	//û�����                     
		char DEADLINE_FLAG          	[10 +1];	//���ⱸ��                     
		char USE_PERIOD_STR         	[20 +1];	//���Ⱓ_����                
		char USE_PERIOD_END         	[20 +1];	//���Ⱓ_����                
		char USE_QTY                	[20 +1];	//��뷮                       
		char SET_QTY                	[20 +1];	//������                       
		char SUPPLY_UNIT_ENER       	[20 +1];	//��������(�������տ���)       
		char ENER_QTY               	[20 +1];	//��뿭��                     
		char USE_CHARG              	[15 +1];	//����                       
		char USE_CHARG_DISC_AMT     	[15 +1];	//�����                       
		char BASE_CHARG             	[15 +1];	//�⺻�ݾ�                     
		char REPL_COST              	[15 +1];	//��ü��                       
		char OVERDUE_AMT            	[15 +1];	//��ü��                       
		char ADJ_SET_CHARG          	[15 +1];	//����ݾ�                     
		char CNL_CHARG_SUPPY        	[15 +1];	//����������                   
		char REVIS_PARA             	[20 +1];	//�������                     
		char SEQ                    	[20 +1];	//�Ϸù�ȣ                     
		char INDI_COMPENS_THIS_MM_VC	[20 +1];	//�Է���ħ                     
		char BF_UNPAY_AMT           	[15 +1];	//����(��)����ڹ̳���         
		char SUMAMT2                	[15 +1];	//�����Ҽ۹ױ�Ÿ�ݾ�           
		char DEBT_UNPAY_AMT         	[15 +1];	//��չ̳���                   
		char CP_DDD                 	[6  +1];	//��ȭ��ȣ1                    
		char CP_EXN                 	[6  +1];	//��ȭ��ȣ2                    
		char CP_NUM                 	[6  +1];	//��ȭ��ȣ3                    
		char WOORI_ACCNO                [30 +1];    //�츮���� ���¹�ȣ                              
		char KOOKMIN_ACCNO              [30 +1];    //�������� ���¹�ȣ                                
		char SHINHAN_ACCNO              [30 +1];    //�������� ���¹�ȣ                                
		char HANA_ACCNO                 [30 +1];    //�ϳ����� ���¹�ȣ                                
		char FB_ACCNO                   [30 +1];    //SC���� ���¹�ȣ                                  
		char NH_ACCNO                   [30 +1];    //���� ���¹�ȣ                                    
		char CITY_ACCNO                 [30 +1];    //��Ƽ���� ���¹�ȣ                                
		char IBK_ACCNO                  [30 +1];    //������� ���¹�ȣ                                
		char CUST_NM                    [50 +1];    //����            
        char ADDR                       [300+1];    //�ּ�                                             
        char CENTER_NM                  [50 +1];    //�����͸�                                       
		char TEL1_DDD                   [6  +1];    //��������ȭ��ȣ1                                
		char TEL1_EXN                   [6  +1];    //��������ȭ��ȣ2                                             
		char TEL1_NUM                   [6  +1];    //��������ȭ��ȣ3 
        char INDI_COMPENS_VC            [10 +1];    //������ħ                     
        char TOT_UNPAY_AMT              [20 +1];    //�̳��Ѿ�                     
	}	FEECALCUL;					                
	
	global FEECALCUL stFee_Calcul;


#endif

