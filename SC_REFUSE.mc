/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_REFUSE
	Card Desc : �������� �ź�
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_REFUSE
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/*  ����                        */
		/********************************/
		DEF_BUTTON_ID ( BID_CLOSE )			// ����_CLOSE
		DEF_BUTTON_ID ( BID_SAVE ) 			// ����
		DEF_BUTTON_ID ( BID_REFUSE_SMS )	// ���ڹ߼�
		DEF_BUTTON_ID ( BID_REFUSE_IMG )	// ÷��
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )			// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )		// ������
		
		/********************************/
		/* ��������                     */
		/********************************/
		DEF_OBJECT_ID ( TXT_SERVADD )		// �������� ����	
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	1	// ����
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_bFirst;			// ȭ�� Index
	char m_szSms_Desc[800];
	char m_szReceiver_Tel[50];
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void fn_SetBtnImg(void);
	void fn_ReDraw(void);
	void fn_Img(void);
	bool fn_Save(void);
	bool fn_Validation(void);
	
	void fn_Run_img_gallery(void);
	long fn_Analy_Phone(char*phone, char* num1, char* num2, char* num3 );
	void fn_GetItem(char* szSource, char* szTarget, int id, int len );
	
	long fn_SMS_Refuse(void);
	long fn_FR312400(void);
	long fn_TR312400(void);
	
	//---------------------------------------------------------------------------------------
	// ������ ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_Main[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG  ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON  ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT  ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� �ź�"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_BUTTON(STARTX +250, STARTY  +60, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFUSE_SMS, "�ź� \n ���� �߼�"),
		DLG_BUTTON(STARTX +250,	STARTY +430, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFUSE_IMG, "�ź� ����\nȭ�� ÷��"), 	  
		
		DLG_BUTTON(STARTX,      STARTY +819, 500,  80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),
		DLG_BUTTON(STARTX +500,	STARTY +819, 500,  80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�� ��"),		
	};
	
	//---------------------------------------------------------------------------------------
	//	main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		
		return TRUE;
	}
	
	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : OnInit
	��  �� : ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit(char bFirst)
	{
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			/********************************/
			/* ����                         */
			/********************************/
			case INIT_MAIN:
				CREATE_DIALOG_OBJECT (DlgRes_Main, SIZEOF(DlgRes_Main));
				
				fn_SetBtnImg();
				fn_ReDraw();
				break;
		
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		long lRet = 0;
		
		switch(ID)
		{
			/******************************/
			/* ����                       */
			/******************************/
			case BID_CLOSE:
				
				Card_Move("SC_CONFIRM");
				break;
				
			case BID_SAVE:
				if( fn_Validation() )
				{
       	        	if( fn_Save() )
       	        	{
       	        		Card_Move("SC_CONFIRM");
       	        	}
       	        }
       	        
				break;
				
			case BID_REFUSE_SMS:
			
				if( Str_Cmp(stSc.CONT_STS_CD, "30") != 0  )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "�ź� ���ڸ� �����ðڽ��ϱ�?") == MB_OK)
					{	
						lRet = fn_SMS_Refuse();
						
						if( lRet > 0 )
						{
							fn_FR312400();
						}
					}
				}
				
				break;
				
			case BID_REFUSE_IMG:
				fn_Run_img_gallery();
				
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : Main Style Setting
	Param  : 
	Return : 
	========================================================================================*/
	void OnTask(long nEvent, long nData)
	{
		long nRet = 0;
		char szTmp[300];
		char szTmp2[300];
		char szFilenm[300];
		char szSql[300];
		
		if( m_bFirst == INIT_MAIN )
		{			
			if( nEvent == TASK_SYS_CALL)
			{
				char* ptr = (char*)System_GetResult((char*)&nRet);
				
				if( nData == (TASK_IC_CARD + 1) )
				{
					PRINT("TASK_SYS_CALL:: PHOTO_GALLERY : path = %s, size = %d ", ptr, nRet, 0);
					
					if( FFS_Exist(ptr) )
					{
						MessageBoxEx( MESSAGE, "������ �������Դϴ�." );
						
						Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
						Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
						
						SPRINT(szSql, "SELECT MTR_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
						g_Sql_RetStr( szSql, 20, szTmp );
						
						Mem_Set( (byte*)szTmp2, 0x00, sizeof(szTmp2) );
						
						Str_Cpy(szTmp2, g_szCHK_EXEC_NUM);
						Str_Cat(szTmp2, "_");			
						Str_Cat(szTmp2, szTmp);
						Str_Cat(szTmp2, "_");			
						Str_Cat(szTmp2, stSc.INST_PLACE_NUM);
						Str_Cat(szTmp2, ".jjp");
						
						Mem_Set( (byte*)szFilenm, 0x00, sizeof(szFilenm) );
						SPRINT( szFilenm, "%s/%s", PHOTO_SCREFUSE, szTmp2, 0 );
						
						VmSleep( 100 );
						
						FFS_Copy( ptr, szFilenm );
						
						VmSleep( 100 );
						
						FFS_Delete( ptr );
						
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REFUSE_IMG), RED);
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_REFUSE_IMG), BTNMENUFRCOLOR);
						
						ON_DRAW();
					}
				}
			}	
		}
	}
	
	//---------------------------------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void fn_SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	�Լ��� : ReDraw
	��  �� : ȭ���� �ٽ� �׸���.
	Param  : 
	Return : 
	========================================================================================*/
	void fn_ReDraw(void)
	{	
		char szScrPht[258];
		char szDirPath[258];
		char szTmp[100];
		long ret = 0;
		
		Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy(szDirPath, PHOTO_SCREFUSE );
		Str_Cpy( szTmp, g_szCHK_EXEC_NUM );
		Str_Cat( szTmp, "_" );
		Str_Cat( szTmp, "*" );
		
		ret = g_FindFiles( szDirPath, szTmp , szScrPht);

		if( ret > 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REFUSE_IMG), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_REFUSE_IMG), BTNMENUFRCOLOR);				
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REFUSE_IMG), BTNCTRLBKCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_REFUSE_IMG), BTNMENUFRCOLOR);
		}

		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Sms_Reject
	��  �� : �źι��� �߼�
	Param  : 
	Return : 
	========================================================================================*/
	long fn_SMS_Refuse(void)
	{
		char szSql[1000];
		char szMsg[2000];
		char szMsg2[1000];
		char szCustTel[50];
		char szUserTel[50];
		char szUserTel2[50];
		char szRecvTelDdd[6];
		char szRecvTelExn[6];
		char szRecvTelNum[6];
		char szTmp[500];
		char szFirstNm[32];
		char szLastNm[32];
		
		long idx = 0;
		long len = 0;
		long lTime = 100; // VmSleep �ð�Setting
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/*******************************************************************/
		/* ��ȭ��ȣ ����                                                   */
		/*******************************************************************/
		Mem_Set( (byte*)szUserTel, 0x00, sizeof(szUserTel) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		
		Tapi_GetPhoneNum( (byte*)szTmp, 0);
		
		if( Str_Cmp(szTmp, "01099991111") == 0 || Str_Cmp(szTmp, "00000000000") == 0 )
		{
			MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
			return -1;
		}
		else
		{
			Str_Cpy(szUserTel, szTmp);
		}
		
		Str_Chg( szUserTel, STRCHG_DEL_NONDIGIT );
		
		//�׽�Ʈ ���� ���� ��ȣ �Է�
		/*
		Mem_Set( (byte*)m_szReceiver_Tel, 0x00, sizeof(m_szReceiver_Tel) );
		Str_Cpy(m_szReceiver_Tel, "01023100247");
		*/
		
		//����� ���� ���� ��ȣ
		Mem_Set( (byte*)m_szReceiver_Tel, 0x00, sizeof(m_szReceiver_Tel) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ifnull(CP_DDD, '') ||''|| ifnull(CP_EXN, '') ||''|| ifnull(CP_NUM, '') FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 30, m_szReceiver_Tel );
		Str_Chg( m_szReceiver_Tel, STRCHG_DEL_NONDIGIT);
		
		Mem_Set((byte*)szRecvTelDdd, 0x00, sizeof(szRecvTelDdd));	
		Mem_Set((byte*)szRecvTelExn, 0x00, sizeof(szRecvTelExn));	
		Mem_Set((byte*)szRecvTelNum, 0x00, sizeof(szRecvTelNum));
		
		fn_Analy_Phone(m_szReceiver_Tel, szRecvTelDdd, szRecvTelExn, szRecvTelNum);
		
		if( !g_CheckPhoneNumberFormat( szRecvTelExn, szRecvTelNum) )
		{
			MessageBoxEx (CONFIRM_OK, "������ �ڵ�����ȣ\n������ �����ʽ��ϴ�.");
			return -1;
		}
		
		Mem_Set( (byte*)m_szSms_Desc, 0x00, sizeof(m_szSms_Desc) );
		
		/* ������ȣ
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );	
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szTmp, "������ȣ : %s\n", stSc.USE_CONT_NUM, 0, 0);	
		Str_Cat(szMsg, szTmp);
		*/ 
		
		/*******************************************************************/
		/* 1.�ּ�                                                          */
		/*******************************************************************/
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		Str_Cpy( szMsg, "�ּ� : " );
		
		SPRINT( szSql, " SELECT CASE WHEN SINGLE_COLIVE_FLAG = '20' THEN ( IFNULL( CO_LIVE_NM,'' ) || \
																		   IFNULL( ( CASE WHEN INSTR(BLD_NM,'��') = LENGTH(BLD_NM) AND LENGTH(BLD_NM) > 0 \
																						  THEN ' ' || SUBSTR(BLD_NM, 1, LENGTH(BLD_NM)-1) || '��' \
																						  WHEN LENGTH(BLD_NM) = 0 \
																						  THEN '' \
																						  ELSE ' ' || BLD_NM || '��' END ), '' ) ||' '|| \
																		   IFNULL( ( CASE WHEN TRIM(HOUSE_CNT) <> '' THEN TRIM(HOUSE_CNT) || 'ȣ' END ),'' ) ) \
									 ELSE ( IFNULL( NEW_ROAD_NM, '' ) ||' '|| \
											IFNULL( ( CASE WHEN NEW_ADDR_S <> '0' THEN NEW_ADDR_M || '-' || NEW_ADDR_S ELSE NEW_ADDR_M END ), '' ) || \
											IFNULL( ( CASE WHEN TRIM(HOUSE_CNT) <> '' THEN ', '|| TRIM(HOUSE_CNT) || 'ȣ' END ),'' ) ||' '|| \
											IFNULL( LOT_NUM_SECOND_ADDR, '' ) ) \
								 END AS ADDR \
						   FROM NORMAL_DATA WHERE CHK_EXEC_NUM = %s ", g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetStr( szSql, 50, szMsg2 );
		
		Str_Cat( szMsg, szMsg2 );
		
		/*******************************************************************/
		/* 2.���� ���� ����                                                */
		/*******************************************************************/
		Str_Cat(szMsg, "\n���� �ȳ��Ͻʴϱ�?\n");
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szTmp, "���ﵵ�ð��� %s ������ %s �����Ŵ��� �Դϴ�.", stUserinfo.szcenter_nm, stUserinfo.sznm_kor, 0);
		Str_Cat(szMsg, szTmp);
		Str_Cat(szMsg, "���ð��� ���������� ���ñ����� ���� �ݵ�� �ǽ��ϼž� �մϴ�.\n");
		Str_Cat(szMsg, "������ ������ ������ ���� �ź��ϼ̽��ϴ�. �ź� ����� �����ø� '�ź�' ���� ȸ�� �� �ֽø�\n");
		Str_Cat(szMsg, "������ �ݿ��ϵ��� �ϰڽ��ϴ�.\n");
		// Str_Cat(szMsg, "�ڷγ�19 ������ Ȯ������ ���ü��� ���ð������������� ��Ȱ�� ����ǰ� ���� �ʽ��ϴ�.\n");
		// Str_Cat(szMsg, "������ ���������� ���� ��ݱ� ���������� �ź� �Ͻ� ��� '�ź�'\n");
		// Str_Cat(szMsg, "�Ǵ� ������ ��������� ���� ���������� ���Ͻø� '���˿�û'\n");
		// Str_Cat(szMsg, "���� ȸ�Ź��ڸ� �����ֽø� ������ �ݿ���� �ϰڽ��ϴ�.");
		// Str_Cat(szMsg, "���ñ����� �ǰ� ���ü��� ���� ���������� ���������� �����ؾ� �մϴ�.\n");
		// Str_Cat(szMsg, "������ ���Բ����� ���� ���������� �ź� �ϼ̽��ϴ�.\n");
		// Str_Cat(szMsg, "�� ������ �����ø� ȸ�Ź��ڸ� ���źΡ��� �����ֽñ� �ٶ��ϴ�.\n");
		// Str_Cat(szMsg, "������ �ݿ���� �ϰڽ��ϴ�. ");
		
		// Hist Msg Setting
		Str_Cpy(m_szSms_Desc, szMsg);
		
		// ����
		ret = Tapi_SendSmsEx( m_szReceiver_Tel, szUserTel, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return ret;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return ret;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return ret;
			}
		}
		
		VmSleep(lTime);
		
		ret = 1;
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : fn_FR312400
	��  �� : �ź� ���� hist / FR312400
	Param  : 
	Return : 
	========================================================================================*/
	long fn_FR312400(void)
	{
		char szUrl[200];
		char szbuf[128];
		char szTmp[800];
		char szSendYmd[20];
		char szSendTime[10];
		char szSendDtm[50];
		char szSendTelDdd[6];
		char szSendTelExn[6];
		char szSendTelNum[6];
		char szRecvTelDdd[6];
		char szRecvTelExn[6];
		char szRecvTelNum[6];
		char* sndbuf;
		long i = 0;
		long ntotcnt = 0;
		long nLen = 0;
		long ret = 0;
	
		Mem_Set((byte*)szSendYmd, 0x00, sizeof(szSendYmd));	
		Mem_Set((byte*)szSendTime, 0x00, sizeof(szSendTime));	
		Mem_Set((byte*)szSendDtm, 0x00, sizeof(szSendDtm));	
		Mem_Set((byte*)szSendTelDdd, 0x00, sizeof(szSendTelDdd));	
		Mem_Set((byte*)szSendTelExn, 0x00, sizeof(szSendTelExn));	
		Mem_Set((byte*)szSendTelNum, 0x00, sizeof(szSendTelNum));	
		Mem_Set((byte*)szRecvTelDdd, 0x00, sizeof(szRecvTelDdd));	
		Mem_Set((byte*)szRecvTelExn, 0x00, sizeof(szRecvTelExn));	
		Mem_Set((byte*)szRecvTelNum, 0x00, sizeof(szRecvTelNum));	
		
		Str_ItoA(Time_GetDate(), szSendYmd, 10);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		//Str_ItoA(Time_GetTime(), szTmp, 10);
		g_Str_TimeType( szTmp , Time_GetTime());
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		Mem_Cpy((byte*)szSendTime, (byte*)szTmp, 4);
		
		Str_Cpy(szSendDtm, szSendYmd);
		Str_Cat(szSendDtm, szTmp);

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Tapi_GetPhoneNum( (byte*)szTmp, 0);
		ret = fn_Analy_Phone(szTmp, szSendTelDdd, szSendTelExn, szSendTelNum);
		if( ret < 0 )
		{
			MessageBoxEx (WARNING_OK, "����ڹ�ȣ�� Ȯ�����ּ���.");
			return -1;
		}

		fn_Analy_Phone(m_szReceiver_Tel, szRecvTelDdd, szRecvTelExn, szRecvTelNum);
		if( ret < 0 )
		{
			MessageBoxEx (WARNING_OK, "����ȣ�� Ȯ�����ּ���.");
			return -1;
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312400, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "center_cd",          stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       stSc.USE_CONT_NUM);
		JSON_SetValue( g_pjcomm, 'C', "cust_num",        	stSc.CUST_NUM);
		JSON_SetValue( g_pjcomm, 'C', "send_ymd",           szSendYmd);
		JSON_SetValue( g_pjcomm, 'C', "send_time",          szSendTime);
		JSON_SetValue( g_pjcomm, 'C', "send_dtm",           szSendDtm);
		JSON_SetValue( g_pjcomm, 'C', "send_tel_ddd",       szSendTelDdd);
		JSON_SetValue( g_pjcomm, 'C', "send_tel_exn",       szSendTelExn);
		JSON_SetValue( g_pjcomm, 'C', "send_tel_num",       szSendTelNum);
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",   szRecvTelDdd);
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",   szRecvTelExn);
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",   szRecvTelNum);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_szSms_Desc );
		JSON_SetValue( g_pjcomm, 'C', "sms_desc",           szTmp );
		
		JSON_SetValue( g_pjcomm, 'C', "sms_type",          "13");

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = fn_TR312400;
		HTTP_DownloadData( szUrl, "FR312400_IN",  "FR312400" , sndbuf, szbuf );

		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : fn_TR312400
	��  �� : FR312400 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long fn_TR312400(void)
	{
		char szSql[250];
		char szTmp[100];
		long ntotcnt = 0, i = 0;
		
		g_Sock_Close();
		CloseMessageBox();
			
		if(g_Chk_Json(312400) >= 0)
		{
			ON_DRAW();
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : fn_Run_img_gallery
	��  �� : �̹��� ������
	Param  : 
	Return : 
	========================================================================================*/
	void fn_Run_img_gallery(void)
	{
		RunApp( "PHOTOVIEWER", "" );
	}
	
	/*=======================================================================================
	�Լ��� : fn_Analy_Phone
	��  �� : ��ȭ��ȣ ���� üũ
	Param  : 
	Return : 
	========================================================================================*/
	long fn_Analy_Phone(char*phone, char* num1, char* num2, char* num3 )
	{
		long len;
	
		Str_Chg(phone, STRCHG_DEL_NONDIGIT );
		len = Str_Len(phone);
		
		if( len == 9 )
		{
			Mem_Cpy( (byte*)num1, (byte*)phone, 2);
			Mem_Cpy( (byte*)num2, (byte*)phone+2, 3);
			Mem_Cpy( (byte*)num3, (byte*)phone+5, 4);
		}
		else if( len == 10 )
		{
			if( Mem_Cmp((byte*)phone, (byte*)"01", 2) == 0  )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone, 3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3, 3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6, 4);
			}
			else if(  Mem_Cmp((byte*)phone, (byte*)"02", 2) == 0 )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone, 2);
				Mem_Cpy( (byte*)num2, (byte*)phone+2, 4);
				Mem_Cpy( (byte*)num3, (byte*)phone+6, 4);
			}
			else
			{
				Mem_Cpy( (byte*)num1, (byte*)phone, 3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3, 3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6, 4);
			}
		}
		else if( len == 11 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone, 3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3, 4);
				Mem_Cpy( (byte*)num3, (byte*)phone+7, 4);
		}
		else if( len == 12 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone, 4);
				Mem_Cpy( (byte*)num2, (byte*)phone+4, 4);
				Mem_Cpy( (byte*)num3, (byte*)phone+8, 4);
		}
		else
		{
			return -1;
		}
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : fn_GetItem
	��  �� : - / . ���а����� ������.
	Param  : 
	Return : 
	========================================================================================*/
	void fn_GetItem( char* szSource, char* szTarget, int id, int len )
	{
		int i;
		int idx;
		int ids;
	
		idx =0;
		ids =1;
		
		for( i=0; i<len; i++ )
		{
			if(szSource[i] == '_' || szSource[i] == '.')
			{
				if(ids == id )
				{
					szTarget[idx] = 0x00;
					break;
				}
				idx = 0;
				ids++;
				continue;
			}
			if(ids == id )
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}
	
	
	/*=======================================================================================
	�Լ��� : fn_Validation
	��  �� : Validation
	Param  : 
	Return :
	========================================================================================*/		
	bool fn_Validation(void)
	{
		char szScrPht[258];
		char szDirPath[258];
		char szTmp[100];
		long ret = 0;	
		long rslt = 0;
		
		Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szDirPath, PHOTO_SCREFUSE );
		Str_Cpy( szTmp, g_szCHK_EXEC_NUM );
		Str_Cat( szTmp, "_" );
		Str_Cat( szTmp, "*" );
		
		ret = g_FindFiles( szDirPath, szTmp , szScrPht);

		if( ret > 0 )
		{
			rslt = 1;
		}
		else
		{
			MessageBoxEx (WARNING_OK, "�ź� ���� ȭ���� ÷���ϼ���.");
			rslt = 0;
		}
		
		return rslt;
	}
	
	/*=======================================================================================
	�Լ��� : fn_Save
	��  �� : ����
	Param  : 
	Return :
	========================================================================================*/		
	bool fn_Save(void)
	{
		char szSql[300];
		char szMemo[300];
		char szToday[15];
		
		long idx;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		// ���� ���� ����
		Mem_Set( (byte*)stSc.CHK_EXCEP_WHY, 0x00, sizeof(stSc.CHK_EXCEP_WHY ) );
		Str_Cpy( stSc.CHK_EXCEP_WHY, "82");
		
		// ������
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10);
		
		Mem_Set( (byte*)stSc.CHK_YMD, 0x00, sizeof(stSc.CHK_YMD) );
		Str_Cpy(stSc.CHK_YMD, szToday);
		g_Str_TimeType( stSc.CHK_TIME_TO, Time_GetTime() );
		
		Mem_Set( (byte*)stSc.CHK_RSLT, 0x00, sizeof(stSc.CHK_RSLT) );
		Mem_Set( (byte*)stSc.SEND_YN, 0x00, sizeof(stSc.SEND_YN) );
		
		Str_Cpy(stSc.CHK_RSLT,"40");
		Str_Cpy(stSc.SEND_YN,"S");
		
		hdb = sql->Open(sql);
			
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
	    hstmt = sql->CreateStatement(sql, " UPDATE NORMAL_DATA \
	                                           SET CHK_EXCEP_WHY = ?, CHK_EMPID = ?, CHKER_NM = ?, CHK_YMD = ?, CHK_TIME_FROM = ? \
											     , CHK_TIME_TO = ?, CHK_RSLT = ?, SEND_YN = ?, PDA_IP = ?, UPD_EMPID = ? \
											 WHERE CHK_EXEC_NUM = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_EXCEP_WHY	     ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor	     ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YMD			     ,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TIME_FROM	     ,6	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TIME_TO		     ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_RSLT		     ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.SEND_YN			     ,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip		 ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,20,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM		     ,12,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		DelSqLite(sql);
		
		return ret;
	}
}
