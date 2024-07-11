/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MOBILE_USEDOC_MENU
	Card Desc : ����� ����༭ �޴�
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MOBILE_USE_DOC_MENU
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
//	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/*  ����                        */
		/********************************/
		DEF_BUTTON_ID ( BID_CLOSE )			// ����_CLOSE
		DEF_BUTTON_ID ( BID_TRANS_IN_NEW ) 	// ���Խű�
		DEF_BUTTON_ID ( BID_NAME_CHANGE )	// ���Ǻ���
		DEF_BUTTON_ID ( BID_NAME_KEEP )		// ��������
		DEF_BUTTON_ID ( BID_NAME_NEW )		// �ű�
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )					// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )				// ������
		
		/********************************/
		/* ��������                     */
		/********************************/
		DEF_OBJECT_ID ( TXT_SERVADD )				// �������� ����	
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAININFO		1		// ������
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_bFirst;				// ȭ�� Index
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void ReDraw(void);
	
	void Snd_91001(void);
	long Rcv_91001(void);
	
	long Chk_Json_91001(void);
	void setCardMove(void);
	
	//---------------------------------------------------------------------------------------
	// ������ ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_MainInfo[] = 
	{	
		/******* ��� ������ ********/
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ð��� ����û(���)��"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_BUTTON(STARTX,      STARTY  -10, 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TRANS_IN_NEW, "���Խű�"),
		
		DLG_TEXT ( STARTX,      STARTY  +90, 1000, 80, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, RED, WHITE, TXT_SERVADD, "!! ����� �������� �����Դϴ�. !!"),
		
		DLG_BUTTON(STARTX,      STARTY  -10, 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_KEEP, "���� ����"),
		DLG_BUTTON(STARTX,      STARTY  +90, 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_CHANGE, "���� ����"),
		DLG_BUTTON(STARTX,      STARTY +190, 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_NEW, "�ű�"),
		DLG_BUTTON(STARTX +550,	STARTY +330,  450, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),
		
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
			case INIT_MAININFO:
				CREATE_DIALOG_OBJECT (DlgRes_MainInfo, SIZEOF(DlgRes_MainInfo));
				
				SetBtnImg();
				ReDraw();
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
		switch(ID)
		{
			/******************************/
			/* ����                       */
			/******************************/
			case BID_CLOSE:
				setCardMove();
				break;
			
			// ���Խű�
			case BID_TRANS_IN_NEW:
				g_lMobile_Use_Doc_Type = 1;
				Snd_91001();
				break;
				
			// ��������
			case BID_NAME_KEEP:
				g_lMobile_Use_Doc_Type = 2;
				Snd_91001();
				break;
			
			// ���Ǻ���
			case BID_NAME_CHANGE:
				g_lMobile_Use_Doc_Type = 3;
				Snd_91001();
				break;
			
			// �ű�
			case BID_NAME_NEW:
				g_lMobile_Use_Doc_Type = 4;
				Snd_91001();
				break;
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
	void SetBtnImg(void)
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
	void ReDraw(void)
	{	
		// ����� ����༭ ���Ա��� : 0 = ���� �ű�, 1 = �ο� ����_�ű�, 2 = ��������, 3 = ��ħ, 4 = �跮�ⱳü, 5 = �ο� ����_����
		if( g_lMobile_Inflow_Path == 0 || g_lMobile_Inflow_Path == 1 )
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_IN_NEW), TRUE );	
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NAME_KEEP), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NAME_CHANGE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NAME_NEW), FALSE );
		}
		else
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_IN_NEW), FALSE );	
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NAME_KEEP), TRUE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NAME_CHANGE), TRUE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NAME_NEW), TRUE );
		}
		
		if( g_nWorkFlag == 610 )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SERVADD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			if(g_szSERV_ADD_YN[0] == 'Y')
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_TRANS_IN_NEW), RED);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SERVADD), TRUE);	
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_TRANS_IN_NEW), BTNCTRLBKCOLOR);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SERVADD), FALSE);
			}
		}
	}	
	
	/*=======================================================================================
	�Լ��� : Snd_91001
	��  �� : ����� ����༭ ������ / FR91001
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_91001(void)
	{
		char sztmp[200];
		char szUrl[256];
		char* sndbuf;
		long ret;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 91001, FALSE);
		
		// ����� ����༭ ���Ա��� : 0 = ���� �ű�, 1 = �ο� ����, 2 = ��������, 3 = ��ħ, 4 = �跮�ⱳü
		// 0. ���� �ű�( �ο� �������� ������ ��쵵 ����)
		if( g_lMobile_Inflow_Path == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num",     stMw.szCivil_serv_receive_num );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",             stMw.szInst_place_num );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",                   stMw.szTrans_in_cust_num);
		}
		// 1. �ο� ����_�ű�
		else if( g_lMobile_Inflow_Path == 1 ) 
		{
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num",     stMw.szCivil_serv_receive_num );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",             stMw.szInst_place_num );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",                   stMw.szTrans_in_cust_num);
		}
		// 2. ��������
		else if( g_lMobile_Inflow_Path == 2 ) 
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	stSc.USE_CONT_NUM );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",               stSc.CUST_NUM );
		}
		// 3. ��ħ
		else if( g_lMobile_Inflow_Path == 3 )
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	stGm.USE_CONT_NUM );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",               stGm.CUST_NUM );
		}
		// 4. �跮�ⱳü
		else if( g_lMobile_Inflow_Path == 4 ) 
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	stMtrChg.USE_CONT_NUM );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",               stMtrChg.CUST_NUM );
		}
		// 5. �ο� ����_����
		else if( g_lMobile_Inflow_Path == 5 ) 
		{
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num",     stMw.szCivil_serv_receive_num );
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",               stMw.szUse_cont_num);
			JSON_SetValue( g_pjcomm, 'C', "cust_num",                   stMw.szCust_num);
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	"6000000279" );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",               "0000000131" );
		}
		
		// ��༭ Ÿ�� : 1 = ���Խű�, 2 = ��������, 3 = ���Ǻ���, 4 = �ű�
		// ���� ���� ������ ��� ���������� ����(2) 
		if( g_lMobile_Use_Doc_Type == 1 )
		{
			if( Str_Cmp(stMw.szSend_Info_Trans_yn, "Y") == 0 )
			{
				JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "2" );
			}
			else
			{
				JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "1" );
			}
		}
		else if( g_lMobile_Use_Doc_Type == 2 )
		{
			JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "2" );
		}
		else if( g_lMobile_Use_Doc_Type == 3 )
		{
			JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "3" );
		}
		else if ( g_lMobile_Use_Doc_Type == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "4" );
		}
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = Rcv_91001;
		ret = HTTP_DownloadData(szUrl, "FR91001_IN",  "FR91001" , sndbuf, sztmp );
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_91001
	��  �� : Rcv_91001 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_91001(void)	
	{
		long ret = 0;
		
		ret = Chk_Json_91001();
		
		g_Sock_Close();
		CloseMessageBox();
		
		if( ret >= 0)
		{
			Card_Move("CM_MOBILE_USE_DOC");
			return 1;
			
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Chk_Json_91001
	��  �� : 
	Param  : 
	Return : 
	========================================================================================*/
	long Chk_Json_91001(void)
	{
		char szJsonpath[500];
		char szMsg[500];
		char szCol[128];
		char szDate[50];
		long *nCol;
		long nCnt = 0;
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		long k = 0, len = 0, length = 0;
		char *pStr;
		char *szcode;
		char *szmessage;
		char *szitem;
		char szType[2] = {0,0};
		long ret = 11;
		handle hitem = NULL;
		handle hcnt = NULL;
		
		MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);
		
		/**********************************/
		/* JSON FILE READ                 */
		/**********************************/
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 91001, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 91001, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		
		pStr = Mem_Alloc(fsize);
		
		fd = FFS_Open( szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG );
		
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read( fd, (byte*)pStr, fsize );
		
		for( i = 0 ; i < fsize - 9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			
			if( chkmsg > 0 &&  chkcode > 0 )
			{
				break;
			}
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		/**********************************/
		/* JSON DATA READ                 */
		/**********************************/
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
		
		/**********************************/
		/* JSON FILE READ SUCC            */
		/**********************************/
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);
			
			/**********************************/
			/* SERVER RSLT : FAIL             */
			/**********************************/
			if( Str_Cmp(szcode, "0000") != 0)
			{
			    char* pMsg = NULL;
			  			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );

				if(Str_Len(szmessage) < 500 )
				{
					SQL_ConvMbStr( szMsg, szmessage);
				}
				
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);

				ret = -1;

				ON_DRAW();	
			}
			/**********************************/
			/* SERVER RSLT : SUCC             */
			/**********************************/
			else
			{
				/***************************************************************************/
				/* stMudData Setting_ORI And stMudData Setting And stMudCancelData Setting */
				/***************************************************************************/
				Mem_Set((byte*)&stMudData, 0x00, sizeof(stMudData) );
				Mem_Set((byte*)&stMudData_ORI, 0x00, sizeof(stMudData_ORI) );
				Mem_Set((byte*)&stMudCancelData, 0x00, sizeof(stMudCancelData) );
				Mem_Set( (byte*)g_szAccnameSignYn, 0x00, sizeof( g_szAccnameSignYn) );
				
				Str_Cpy( stMudData.USE_CONT_NUM, JSON_GetValue(g_pjcomm, "use_cont_num", szType) );
				Str_Cpy( stMudData_ORI.USE_CONT_NUM, stMudData.USE_CONT_NUM );
				
				Str_Cpy( stMudData.CUST_NUM, JSON_GetValue(g_pjcomm, "cust_num", szType) );
				Str_Cpy( stMudData_ORI.CUST_NUM, stMudData.CUST_NUM );
				
				Str_Cpy( stMudData.INST_PLACE_NUM, JSON_GetValue (g_pjcomm, "inst_place_num", szType) );
				Str_Cpy( stMudData_ORI.INST_PLACE_NUM, stMudData.INST_PLACE_NUM );
					
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Str_Cpy( szMsg , JSON_GetValue( g_pjcomm, "cust_nm", szType) );
				SQL_ConvMbStr( stMudData.CUST_NM, szMsg );
				Str_Cpy( stMudData_ORI.CUST_NM, stMudData.CUST_NM );
				
				Str_Cpy( stMudData.BIRTH_DATE, JSON_GetValue( g_pjcomm, "birth_date", szType) );
				Str_Cpy( stMudData_ORI.BIRTH_DATE , stMudData.BIRTH_DATE );
				
				Str_Cpy( stMudData.GENDER, JSON_GetValue( g_pjcomm, "gender", szType) );
				Str_Cpy( stMudData_ORI.GENDER, stMudData.GENDER );
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
				Str_Cpy(szMsg, JSON_GetValue( g_pjcomm, "curr_addr_union", szType) );
				SQL_ConvMbStr( stMudData.CURR_ADDR_UNION, szMsg );
				Str_Cpy( stMudData_ORI.CURR_ADDR_UNION, stMudData.CURR_ADDR_UNION );
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
				Str_Cpy( szMsg, JSON_GetValue( g_pjcomm, "new_addr_union", szType) );
				SQL_ConvMbStr( stMudData.NEW_ADDR_UNION, szMsg );
				Str_Cpy( stMudData_ORI.NEW_ADDR_UNION, stMudData.NEW_ADDR_UNION );
				
				Str_Cpy( stMudData.OWNHOUSE_TEL_DDD, JSON_GetValue(g_pjcomm, "ownhouse_tel_ddd", szType) );
				Str_Cpy( stMudData_ORI.OWNHOUSE_TEL_DDD, stMudData.OWNHOUSE_TEL_DDD );
				
				Str_Cpy( stMudData.OWNHOUSE_TEL_EXN, JSON_GetValue(g_pjcomm, "ownhouse_tel_exn", szType) );
				Str_Cpy( stMudData_ORI.OWNHOUSE_TEL_EXN, stMudData.OWNHOUSE_TEL_EXN );
				
				Str_Cpy( stMudData.OWNHOUSE_TEL_NUM, JSON_GetValue(g_pjcomm, "ownhouse_tel_num", szType) );
				Str_Cpy( stMudData_ORI.OWNHOUSE_TEL_NUM, stMudData.OWNHOUSE_TEL_NUM );
				
				Str_Cpy( stMudData.CP_DDD, JSON_GetValue(g_pjcomm, "cp_ddd", szType) );
				Str_Cpy( stMudData_ORI.CP_DDD,  stMudData.CP_DDD );
				
				Str_Cpy( stMudData.CP_EXN, JSON_GetValue(g_pjcomm, "cp_exn", szType) );
				Str_Cpy( stMudData_ORI.CP_EXN, stMudData.CP_EXN );
				
				Str_Cpy( stMudData.CP_NUM, JSON_GetValue(g_pjcomm, "cp_num", szType) );
				Str_Cpy( stMudData_ORI.CP_NUM, stMudData.CP_NUM );
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Str_Cpy( szMsg , JSON_GetValue( g_pjcomm, "firm_nm", szType) );
				SQL_ConvMbStr( stMudData.FIRM_NM, szMsg );
				Str_Cpy( stMudData_ORI.FIRM_NM, stMudData.FIRM_NM );
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
				Str_Cat( szMsg, JSON_GetValue (g_pjcomm, "soc_num", szType) );
				Mem_Cpy( (byte*)stMudData.SOC_NUM, (byte *)szMsg, 6 );
				Str_Chg( stMudData.SOC_NUM, STRCHG_DEL_NONDIGIT );
				Str_Cpy( stMudData_ORI.SOC_NUM, stMudData.SOC_NUM );
				
				Str_Cpy( stMudData.BIZ_REGI_NUM, JSON_GetValue(g_pjcomm, "biz_regi_num", szType) );
				Str_Chg( stMudData.BIZ_REGI_NUM, STRCHG_DEL_ALL_SPACE );
				Str_Cpy( stMudData_ORI.BIZ_REGI_NUM, stMudData.BIZ_REGI_NUM );
				
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				Str_Cpy( szMsg, JSON_GetValue( g_pjcomm, "email_req_id", szType ) );
				SQL_ConvMbStr( stMudData.EMAIL_REQ_ID, szMsg );
				Str_Cpy( stMudData_ORI.EMAIL_REQ_ID, stMudData.EMAIL_REQ_ID );
				
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				Str_Cpy( szMsg, JSON_GetValue( g_pjcomm, "email_req_addr", szType ) );
				SQL_ConvMbStr( stMudData.EMAIL_REQ_ADDR, szMsg );
				Str_Cpy( stMudData_ORI.EMAIL_REQ_ADDR, stMudData.EMAIL_REQ_ADDR );
				
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				Str_Cpy( szMsg, JSON_GetValue( g_pjcomm, "email", szType ) );
				SQL_ConvMbStr( stMudCancelData.EMAIL_REQ_ADDR, szMsg );
				
				Str_Cpy( stMudData.SAFE_KEY, JSON_GetValue( g_pjcomm, "safe_key", szType) );	
				Str_Chg( stMudData.SAFE_KEY, STRCHG_DEL_ALL_SPACE );
				Str_Cpy( stMudData_ORI.SAFE_KEY, stMudData.SAFE_KEY );
				Str_Cpy( stMudCancelData.SAFE_KEY, stMudData.SAFE_KEY );
				
				Str_Cpy( stMudData.LMS_TEL_DDD, JSON_GetValue(g_pjcomm, "lms_tel_ddd", szType) );
				Str_Cpy( stMudData_ORI.LMS_TEL_DDD, stMudData.LMS_TEL_DDD );
				Str_Cpy( stMudCancelData.LMS_TEL_DDD, stMudData.LMS_TEL_DDD );
				
				Str_Cpy( stMudData.LMS_TEL_EXN, JSON_GetValue(g_pjcomm, "lms_tel_exn", szType) );
				Str_Cpy( stMudData_ORI.LMS_TEL_EXN, stMudData.LMS_TEL_EXN );
				Str_Cpy( stMudCancelData.LMS_TEL_EXN, stMudData.LMS_TEL_EXN );
				
				Str_Cpy( stMudData.LMS_TEL_NUM, JSON_GetValue(g_pjcomm, "lms_tel_num", szType) );
				Str_Cpy( stMudData_ORI.LMS_TEL_NUM, stMudData.LMS_TEL_NUM );
				Str_Cpy( stMudCancelData.LMS_TEL_NUM, stMudData.LMS_TEL_NUM );
				
				Str_Cpy( stMudData.BILING_METHOD, JSON_GetValue (g_pjcomm, "biling_method", szType) );
				Str_Cpy( stMudData_ORI.BILING_METHOD, stMudData.BILING_METHOD );
				
				Str_Cpy( stMudData.PAYMENT_METHOD, JSON_GetValue (g_pjcomm, "payment_method", szType) );
				Str_Cpy( stMudData_ORI.PAYMENT_METHOD, stMudData.PAYMENT_METHOD );
					
				Str_Cpy( stMudData.MTR_ID_NUM, JSON_GetValue(g_pjcomm, "mtr_id_num", szType) );
				Str_Cpy( stMudData_ORI.MTR_ID_NUM, stMudData.MTR_ID_NUM );
				
				// ���ι�� ( 10 : �����ڵ���ü, 20 : ī���ڵ���ü, NULL : ���� )
				if( Str_Cmp(stMudData.PAYMENT_METHOD, "20") == 0 )
				{
					Str_Cpy( stMudCancelData.PAYMENT_METHOD, "10" );	
				}
				else if( Str_Cmp(stMudData.PAYMENT_METHOD, "30") == 0 )
				{
					Str_Cpy( stMudCancelData.PAYMENT_METHOD, "20" );
				}
				else
				{
					Str_Cpy( stMudCancelData.PAYMENT_METHOD, "" );
				}
				
				ret = 0;
				
				/*************************************************/
				/* stMudData Item Setting                        */
				/*************************************************/
				szitem = JSON_GetValue(g_pjcomm, "item", szType);
				
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						
						if( hitem != NULL)
						{
							JSON_toJson( hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );

							if( ret > 0 )
							{
								// ��������̸鼭, �ڵ���ü������ �ִ� ��� OR ���Կ����̸鼭 �ڵ���ü������ �ִ� ��� N
								if( g_szSERV_ADD_YN[0] == 'Y' )
								{
								    Str_Cpy( g_szAccnameSignYn, "N" );
								}
								else
								{
									if( g_lMobile_Use_Doc_Type == 1 )
									{
										if( Str_Cmp(stMw.szSend_Info_Trans_yn, "Y") == 0 )
										{
											Str_Cpy( g_szAccnameSignYn, "N" );
										}
									}
									else
									{
								    	Str_Cpy( g_szAccnameSignYn, "Y" );
								    }
								}
								
								Str_Cpy( stMudData.BNK_CD, JSON_GetValue(hitem, "bnk_cd", szType) );
								Str_Cpy( stMudData_ORI.BNK_CD, stMudData.BNK_CD );
								Str_Cpy( stMudCancelData.BNK_CD, stMudData.BNK_CD );
								
								Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
								Str_Cpy( szMsg, JSON_GetValue( hitem, "bnk_branch_nm", szType) );
								SQL_ConvMbStr( stMudData.BNK_BRANCH_NM, szMsg );
								Str_Cpy( stMudData_ORI.BNK_BRANCH_NM, stMudData.BNK_BRANCH_NM );
								
								Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
								Str_Cpy( szMsg, JSON_GetValue( hitem, "depositor_nm", szType) );
								SQL_ConvMbStr( stMudData.DEPOSITOR_NM, szMsg);
								Str_Cpy( stMudData_ORI.DEPOSITOR_NM, stMudData.DEPOSITOR_NM );
								Str_Cpy( stMudCancelData.DEPOSITOR_NM, stMudData.DEPOSITOR_NM );

								Str_Cpy( stMudData.DEPOSITOR_TEL_DDD, JSON_GetValue( hitem, "depositor_tel_ddd", szType) );
								Str_Cpy( stMudData.DEPOSITOR_TEL_EXN, JSON_GetValue( hitem, "depositor_tel_exn", szType) );
								Str_Cpy( stMudData.DEPOSITOR_TEL_NUM, JSON_GetValue( hitem, "depositor_tel_num", szType) );
								
								Str_Cpy( stMudData_ORI.DEPOSITOR_TEL_DDD, stMudData.DEPOSITOR_TEL_DDD );
								Str_Cpy( stMudData_ORI.DEPOSITOR_TEL_EXN, stMudData.DEPOSITOR_TEL_EXN );
								Str_Cpy( stMudData_ORI.DEPOSITOR_TEL_NUM, stMudData.DEPOSITOR_TEL_NUM );
								
								Str_Cpy( stMudData.DEFRAY_ACCOUNT_NUM, JSON_GetValue(hitem, "defray_account_num", szType) );
								Str_Cpy( stMudData_ORI.DEFRAY_ACCOUNT_NUM, stMudData.DEFRAY_ACCOUNT_NUM);
								Str_Cpy( stMudCancelData.DEFRAY_ACCOUNT_NUM, stMudData.DEFRAY_ACCOUNT_NUM);
								
								Str_Cpy( stMudData.DEPOSITOR_BIRTH_DATE, JSON_GetValue(hitem, "depositor_birth_date", szType) );
								Str_Cpy( stMudData_ORI.DEPOSITOR_BIRTH_DATE, stMudData.DEPOSITOR_BIRTH_DATE);
								Str_Cpy( stMudCancelData.DEPOSITOR_BIRTH_DATE, stMudData.DEPOSITOR_BIRTH_DATE);
								
								Str_Cpy( stMudData.DEPOSITOR_RELAT_CD, JSON_GetValue(hitem, "depositor_relat_cd", szType) );
								Str_Cpy( stMudData_ORI.DEPOSITOR_RELAT_CD, stMudData.DEPOSITOR_RELAT_CD);
								Str_Cpy( stMudCancelData.DEPOSITOR_RELAT_CD, stMudData.DEPOSITOR_RELAT_CD);
								
								Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
								Str_Cpy( szMsg, JSON_GetValue( hitem, "req_nm", szType) );
								SQL_ConvMbStr( stMudData.REQ_NM, szMsg);
								Str_Cpy( stMudData_ORI.REQ_NM, stMudData.REQ_NM);
								
								Str_Cpy( stMudData.REQ_TEL_DDD, JSON_GetValue( hitem, "req_tel_ddd", szType) );
								Str_Cpy( stMudData.REQ_TEL_EXN, JSON_GetValue( hitem, "req_tel_exn", szType) );
								Str_Cpy( stMudData.REQ_TEL_NUM, JSON_GetValue( hitem, "req_tel_num", szType) );
								
								Str_Cpy( stMudData_ORI.REQ_TEL_DDD, stMudData.REQ_TEL_DDD );
								Str_Cpy( stMudData_ORI.REQ_TEL_EXN, stMudData.REQ_TEL_EXN );
								Str_Cpy( stMudData_ORI.REQ_TEL_NUM, stMudData.REQ_TEL_NUM );
								
								Str_Cpy( stMudData.SECU_DEFRAY_ACCOUNT_NUM, JSON_GetValue( hitem, "secu_defray_account_num", szType) );
								Str_Cpy( stMudData_ORI.SECU_DEFRAY_ACCOUNT_NUM, stMudData.SECU_DEFRAY_ACCOUNT_NUM );
							}

							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}	
				}
			}
		}
		/**********************************/
		/* JSON FILE READ FAIL            */
		/**********************************/
		else
		{
			ret = 0;
		}
		
Finally:		
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : setCardMove
	��  �� : ī�� MOVE
	Param  : 
	Return :
	========================================================================================*/	
	void setCardMove(void)
	{
		// ���Խű�
		if( g_lMobile_Inflow_Path == 0 )
		{
			Card_Move("C6101_LST");
		}
		// �ο� ����_�ű�
		else if( g_lMobile_Inflow_Path == 1 )
		{
			Card_Move("C6101_WINFO");
		}
		// ��������
		else if( g_lMobile_Inflow_Path == 2 )
		{
			Card_Move("SC_CONFIRM");
		}
		// ��ħ
		else if( g_lMobile_Inflow_Path == 3 )
		{
			Card_Move("GM_CUSTINFO");
		}
		// �跮��
		else if( g_lMobile_Inflow_Path == 4 )
		{
			Card_Move("C6301_CUSTINFO");
		}
		// �ο� ����_����
		else if( g_lMobile_Inflow_Path == 5 )
		{
			Card_Move("C6101_WINFO");
		}
		// ��Ÿ
		else
		{
			Card_Move("CM_MENU");
		}
	}
}
