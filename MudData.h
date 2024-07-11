/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ��� ����
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Name : MudData.h
	Desc : ����� ����༭ ����ü ����
	Hist :
----------------------------------------------------------------------------------*/
#ifndef		MUDDATA_H
#define		MUDDATA_H

/*=======================================================================================
����ü�� : _MUD_DATA_ORI / MUD_DATA_ORI / stMudData_ORI
��  ��   : ���� �޾ƿ� ������
Param    : 
Return   : 
========================================================================================*/
typedef struct _MUD_DATA_ORI
{
	char USE_CONT_NUM         	[20 +1];
	char CUST_NUM             	[20 +1];
	char INST_PLACE_NUM       	[20 +1];
	char CUST_NM              	[50 +1];
	char BIRTH_DATE         	[8  +1];
	char GENDER               	[10 +1];
	char CURR_ADDR_UNION      	[500+1];
	char NEW_ADDR_UNION			[500+1];
	char OWNHOUSE_TEL_DDD     	[6  +1];
	char OWNHOUSE_TEL_EXN     	[6  +1];
	char OWNHOUSE_TEL_NUM     	[6  +1];
	char CP_DDD               	[6  +1];
	char CP_EXN               	[6  +1];
	char CP_NUM               	[6  +1];
	char FIRM_NM               	[50 +1];
	char SOC_NUM              	[20 +1];
	char BIZ_REGI_NUM         	[20 +1];
	char EMAIL_REQ_ID         	[50 +1];
	char EMAIL_REQ_ADDR       	[50 +1];
	char SAFE_KEY             	[20 +1];
	char LMS_TEL_DDD          	[6  +1];
	char LMS_TEL_EXN          	[6  +1];
	char LMS_TEL_NUM          	[6  +1];
	char BILING_METHOD        	[50 +1];
	char PAYMENT_METHOD       	[50 +1];
	char MTR_ID_NUM				[20 +1];
	char BNK_CD               	[20 +1];
	char BNK_BRANCH_NM        	[50 +1];
	char DEPOSITOR_NM         	[50 +1];
	char DEPOSITOR_TEL_DDD    	[6  +1];
	char DEPOSITOR_TEL_EXN    	[6  +1];
	char DEPOSITOR_TEL_NUM    	[6  +1];
	char DEFRAY_ACCOUNT_NUM   	[50 +1];
	char DEPOSITOR_BIRTH_DATE 	[20 +1];
	char DEPOSITOR_RELAT_CD   	[20 +1];
	char CUST_RELAT_CD        	[20 +1];
	char REQ_NM               	[50 +1];
	char REQ_TEL_DDD          	[6  +1];
	char REQ_TEL_EXN          	[6  +1];
	char REQ_TEL_NUM          	[6  +1];
	char INFO_USE_AGREE_YN    	[5  +1];
	char INFO_USE_YN          	[5  +1];
	char INFO_USE_YN4         	[5  +1];
	char INFO_USE_YN5         	[5  +1];
	
	char SECU_DEFRAY_ACCOUNT_NUM [100  +1];
	
} MUD_DATA_ORI;

global MUD_DATA_ORI stMudData_ORI;

/*=======================================================================================
����ü�� : _MUD_DATA / MUD_DATA / stMudData
��  ��   : OZ�� ������ ���� ����ü
Param    : 
Return   : 
========================================================================================*/
typedef struct _MUD_DATA
{
	char USE_CONT_NUM         	[20 +1];
	char CUST_NUM             	[20 +1];
	char INST_PLACE_NUM       	[20 +1];
	char CUST_NM              	[50 +1];
	char BIRTH_DATE         	[8  +1];
	char GENDER               	[10 +1];
	char CURR_ADDR_UNION      	[500+1];
	char NEW_ADDR_UNION			[500+1];
	char OWNHOUSE_TEL_DDD     	[6  +1];
	char OWNHOUSE_TEL_EXN     	[6  +1];
	char OWNHOUSE_TEL_NUM     	[6  +1];
	char CP_DDD               	[6  +1];
	char CP_EXN               	[6  +1];
	char CP_NUM               	[6  +1];
	char FIRM_NM               	[50 +1];
	char SOC_NUM              	[20 +1];
	char BIZ_REGI_NUM         	[20 +1];
	char EMAIL_REQ_ID         	[50 +1];
	char EMAIL_REQ_ADDR       	[50 +1];
	char SAFE_KEY             	[20 +1];
	char TAXBILL         		[2  +1];
	char LMS_TEL_DDD          	[6  +1];
	char LMS_TEL_EXN          	[6  +1];
	char LMS_TEL_NUM          	[6  +1];
	char BILING_METHOD        	[50 +1];
	char PAYMENT_METHOD       	[50 +1];
	
	char MTR_ID_NUM				[20 +1];
	char BNK_CD               	[20 +1];
	char BNK_BRANCH_NM        	[50 +1];
	char DEPOSITOR_NM         	[50 +1];
	char DEPOSITOR_TEL_DDD    	[6  +1];
	char DEPOSITOR_TEL_EXN    	[6  +1];
	char DEPOSITOR_TEL_NUM    	[6  +1];
	char DEFRAY_ACCOUNT_NUM   	[50 +1];
	char DEPOSITOR_BIRTH_DATE 	[20 +1];
	char DEPOSITOR_RELAT_CD   	[20 +1];
	char CUST_RELAT_CD        	[20 +1];
	char REQ_NM               	[50 +1];
	char REQ_TEL_DDD          	[6  +1];
	char REQ_TEL_EXN          	[6  +1];
	char REQ_TEL_NUM          	[6  +1];
	
	char INFO_USE_AGREE_YN    	[5  +1];
	char INFO_USE_YN          	[5  +1];
	char INFO_USE_YN4         	[5  +1];
	char INFO_USE_YN5         	[5  +1];
	char INFO_USE_YN6       	[5  +1];
	
	char SECU_DEFRAY_ACCOUNT_NUM [100  +1];
	
} MUD_DATA;

global MUD_DATA stMudData;

/*=======================================================================================
����ü�� : _MUD_CANCEL_DATA / MUD_CANCEL_DATA / stMudCancelData
��  ��   : û����� ������ �ʿ��� ������
Param    : 
Return   : 
========================================================================================*/
typedef struct _MUD_CANCEL_DATA
{
	char SAFE_KEY				[20 +1];
	char PAYMENT_METHOD       	[50 +1];
	char BNK_CD               	[20 +1];
	char DEPOSITOR_NM         	[50 +1];
	char DEFRAY_ACCOUNT_NUM   	[50 +1];
	char DEPOSITOR_BIRTH_DATE 	[20 +1];
	char DEPOSITOR_RELAT_CD   	[20 +1];
	char LMS_TEL_DDD          	[5  +1];
	char LMS_TEL_EXN          	[5  +1];
	char LMS_TEL_NUM          	[5  +1];
	char EMAIL_REQ_ADDR       	[100+1];
	
} MUD_CANCEL_DATA;

global MUD_CANCEL_DATA stMudCancelData;
	
/*=======================================================================================
����ü�� : _OZ_DATA / OZ_DATA / stOzData
��  ��   : OZ���� �� ������
Param    : 
Return   : 
========================================================================================*/
typedef struct _OZ_DATA
{
	char USE_CONT_NUM        	[20 +1];
	char BRANCH_CD           	[10 +1];
	char CENTER_CD           	[10 +1];
	char INST_PLACE_NUM      	[20 +1];
	char CUST_NUM            	[20 +1];
	char CUST_NM             	[50 +1];
	char CHG_CUST_TYPE       	[10 +1];
	char DATA_COL_TYPE       	[10 +1];
	char TRAN_FLAG           	[10 +1];
	char GENDER              	[10 +1];
	char INFO_USE_AGREE_YN   	[5  +1];
	char INFO_USE_YN         	[5  +1];
	char INFO_USE_YN4        	[5  +1];
	char INFO_USE_YN5        	[5  +1];
	char INFO_USE_YN6        	[5  +1];
	char RMK                 	[300+1];
	char TRAN_REQ_YMD        	[20 +1];
	char TRANS_FLAG          	[10 +1];
	char LMS_TEL_DDD         	[5  +1];
	char LMS_TEL_EXN         	[5  +1];
	char LMS_TEL_NUM         	[5  +1];
	char EMAIL_REQ_ADDR      	[100+1];
	char PAYMENT_METHOD      	[30 +1];
	char BILING_METHOD       	[30 +1];
	char PAY_METHOD_TYPE     	[30 +1];
	char BILL_METHOD_TYPE    	[30 +1];
	char BNK_TYPE            	[20 +1];
	char BNK_CD              	[20 +1];
	char BNK_BRANCH_NM       	[100+1];
	char DEPOSITOR_NM        	[50 +1];
	char DEPOSITOR_TEL_DDD   	[5  +1];
	char DEPOSITOR_TEL_EXN   	[5  +1];
	char DEPOSITOR_TEL_NUM   	[5  +1];
	char DEFRAY_ACCOUNT_NUM  	[50 +1];
	char DEPOSITOR_BIRTH_DATE	[20 +1];
	char DEPOSITOR_RELAT_CD  	[10 +1];
	char CUST_RELAT_CD       	[10 +1];
	char REQ_NM              	[50 +1];
	char REQ_TEL_DDD         	[5  +1];
	char REQ_TEL_EXN         	[5  +1];
	char REQ_TEL_NUM         	[5  +1];
	char OZ_TRAN_REQ_FLAG    	[10 +1];
	char SOC_NUM             	[50 +1];
	char OWNHOUSE_TEL_DDD    	[5  +1];
	char OWNHOUSE_TEL_EXN    	[5  +1];
	char OWNHOUSE_TEL_NUM    	[5  +1];
	char CP_DDD              	[5  +1];
	char CP_EXN              	[5  +1];
	char CP_NUM              	[5  +1];
	char OZ_EMAIL_REQ_FLAG   	[10 +1];
	char OZ_LMS_REQ_FLAG     	[10 +1];
	char OZ_JIRO_REQ_FLAG     	[10 +1];
	char CARD_VALID_PERIOD   	[30 +1];
	char CARD_JOIN_YN        	[10 +1];
	char PDFPATH			 	[256+1];
	char ADDR_UNION          	[500+1];
	char CHK_CHG_USERINFO_FLAG  [5  +1];
	
} OZ_DATA;

OZ_DATA stOzData;

#endif
