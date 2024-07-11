/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ��� ����
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Name : McData.h
	Desc : �̵� ������ ����ü ����
	Hist :
----------------------------------------------------------------------------------*/
#ifndef		MCDATA_H
#define		MCDATA_H

/*=======================================================================================
����ü�� : _MC_MAIN_INFO / MC_MAIN_INFO / stMcMainInfo
��  ��   : �̵������� ���� ����ü
Param    : 
Return   : 
========================================================================================*/
typedef struct _MC_MAIN_INFO
{
	char INST_PLACE_NUM      [9 +1];
	char USE_CONT_NUM		 [10 +1];
	char USE_CONT_DOC_YN	 [1 +1];
	char CP_DDD				 [4 +1];
	char CP_EXN				 [4 +1];
	char CP_NUM				 [4 +1];
	char OWNHOUSE_TEL_DDD    [4 +1];
	char OWNHOUSE_TEL_EXN    [4 +1];
	char OWNHOUSE_TEL_NUM    [4 +1];
	char REAL_CP_DDD         [4 +1];
	char REAL_CP_EXN         [4 +1];
	char REAL_CP_NUM         [4 +1];
	char DEADLINE_FLAG       [2 +1];
	char GMTR_METHOD_NM      [50 +1];
	char BILL_SEND_METHOD_CD [2 +1];
	char BILL_SEND_METHOD_NM [50 +1];
	char PAY_METHOD_CD       [2 +1];
	char PAY_METHOD_NM       [50 +1];
	char REQ_CP_DDD          [4 +1];
	char REQ_CP_EXN          [4 +1];
	char REQ_CP_NUM          [4 +1];
	char REQ_EMAIL           [50 +1];
	char VISIT_YMD           [8 +1];
	char VISIT_TYPE_NM       [50 +1];
	char VISIT_RESULT		 [100 +1];
	char VISIT_ETC           [2000 +1];
	char UNPAY_AMT           [20 +1];
	char UNPAY_MONTH         [15 +1];
	char BNK_NM         	 [50 +1];
	char DEFRAY_ACCOUNT_NUM  [50 +1];
	char ADDR				 [300 +1];
	char CUST_NM			 [30 +1];
} MC_MAIN_INFO;

global MC_MAIN_INFO stMcMainInfo;

/*=======================================================================================
����ü�� : _MC_MAIN_RSLT / MC_MAIN_RSLT / stMcMainRslt
��  ��   : �̵������� ��� �� ����
Param    : 
Return   : 
========================================================================================*/
typedef struct _MC_MAIN_RSLT
{
	char REQ_FLAG		  	  [2 +1];
	char CMB_BILL_SEND_METHOD [2 +1];
	char CMB_REFUSE  	   	  [2 +1];
	char CMB_PAY_METHOD  	  [2 +1];
	char CMB_SELF_GMTR  	  [2 +1];
	char CMB_USE_CONT  		  [2 +1];
	char REQ_NM		          [30 +1];
	char REQ_LMS_DDD		  [4 +1];
	char REQ_LMS_EXN		  [4 +1];
	char REQ_LMS_NUM		  [4 +1];
	char REQ_EMAIL		      [50 +1];
	char REQ_EMAIL_ADDR		  [50 +1];
	char ETC                  [2000 +1];
} MC_MAIN_RSLT;

global MC_MAIN_RSLT stMcMainRslt;

/*=======================================================================================
����ü�� : _MC_SEARCH / MC_SEARCH / stMcSearch
��  ��   : �̵������� ��ȸ �� ����
Param    : 
Return   : 
========================================================================================*/
typedef struct _MC_SEARCH
{
	char SEARCH_TYPE		  [30 +1];
	char SEARCH_ADDR_TYPE 	  [30 +1];
	char SEARCH_CITY  	   	  [100 +1];
	char SEARCH_CITY2  	   	  [100 +1];
	char SEARCH_KEYWORD  	  [1000 +1];
	char SEARCH_USE_CONT_NUM  [20 +1];
	char SEARCH_NAME		  [30 +1];
	char SEARCH_PHONE_DDD	  [4 +1];
	char SEARCH_PHONE_EXN	  [4 +1];
	char SEARCH_PHONE_NUM	  [4 +1];
} MC_SEARCH;

global MC_SEARCH stMcSearch;

#endif
