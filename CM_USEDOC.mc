/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card CM_USEDOC
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
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CLOSE )			//�ݱ�
		DEF_BUTTON_ID ( BID_NAME_CHANGE )	//���Ǻ���
		DEF_BUTTON_ID ( BID_NAME_KEEP )		//��������
		DEF_BUTTON_ID ( BID_NAME_NEW )		//�ű�
//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	
	#define INIT_MAIN	1
	
	//����༭ �Ѱ��ִ� �⺻ ������ struct(���� ������)
	typedef struct _USEDATA
	{
		char USE_CONT_NUM        [20]; 
		char BIZ_REGI_NUM        [20];
		char CUST_NUM            [20];
		char OWNHOUSE_TEL_DDD    [6];
		char OWNHOUSE_TEL_EXN    [6];
		char OWNHOUSE_TEL_NUM    [6];
		char CP_DDD              [6];
		char CP_EXN              [6];
		char CP_NUM              [6];
		char INST_PLACE_NUM      [20];
		
		char SOC_NUM             [20];
		char GENDER              [10];
		char SAFE_KEY            [20];
		char LMS_TEL_DDD         [6];
		char LMS_TEL_EXN         [6];
		char LMS_TEL_NUM         [6];
		char EMAIL_REQ_ID        [50];
		char EMAIL_REQ_ADDR      [50];
		char BILING_METHOD       [50];
		char PAYMENT_METHOD      [50];
		char CUST_NM             [50];
		char BNK_CD              [20];
		char BNK_BRANCH_NM       [50];
		char DEPOSITOR_NM        [50];
		char DEPOSITOR_TEL_DDD   [6];
		char DEPOSITOR_TEL_EXN   [6];
		char DEPOSITOR_TEL_NUM   [6];
		char DEFRAY_ACCOUNT_NUM  [50];
		char DEPOSITOR_BIRTH_DATE[20];
		char DEPOSITOR_RELAT_CD  [20];
		char CUST_RELAT_CD       [20];
		char REQ_NM              [50];
		char REQ_TEL_DDD         [6];
		char REQ_TEL_EXN         [6];
		char REQ_TEL_NUM         [6];
		char INFO_USE_AGREE_YN   [5];
		char INFO_USE_YN         [5];
		char INFO_USE_YN4        [5];
		char INFO_USE_YN5        [5];
		char CURR_ADDR_UNION     [500];
		char NEW_ADDR_UNION      [500];
	}	USEDATA;
	
	USEDATA m_stUsedata;
	
	//û����� ������ �ʿ��� ���� ��� ����
	typedef struct _CANCELDATA
	{
		char SAFE_KEY            [20];
		char PAYMENT_METHOD      [50];
		char BNK_CD              [20];
		char DEPOSITOR_NM        [50];
		char DEFRAY_ACCOUNT_NUM  [50];
		char DEPOSITOR_BIRTH_DATE[20];
		char DEPOSITOR_RELAT_CD  [20];
		char LMS_TEL_DDD         [5];
		char LMS_TEL_EXN         [5];
		char LMS_TEL_NUM         [5];
		char EMAIL_REQ_ADDR      [100];
	}	CANCELDATA;
	
	CANCELDATA m_stCancelData;
	
	//����༭���� �Ѿ���� ���� struct(���� ������)
	typedef struct _OZDATA
	{
		char USE_CONT_NUM        [20];
		char BRANCH_CD           [10];
		char CENTER_CD           [10];
		char INST_PLACE_NUM      [20];
		char CUST_NUM            [20];
		char CUST_NM             [50];
		char CHG_CUST_TYPE       [10];
		char DATA_COL_TYPE       [10];
		char TRAN_FLAG           [10];
		char GENDER              [10];
		char INFO_USE_AGREE_YN   [5];
		char INFO_USE_YN         [5];
		char INFO_USE_YN4        [5];
		char INFO_USE_YN5        [5];
		char RMK                 [300];
		char TRAN_REQ_YMD        [20];
		char TRANS_FLAG          [10];
		char LMS_TEL_DDD         [5];
		char LMS_TEL_EXN         [5];
		char LMS_TEL_NUM         [5];
		char EMAIL_REQ_ADDR      [100];
		char PAYMENT_METHOD      [30];
		char BILING_METHOD       [30];
		char PAY_METHOD_TYPE     [30];
		char BILL_METHOD_TYPE    [30];
		char BNK_TYPE            [20];
		char BNK_CD              [20];
		char BNK_BRANCH_NM       [100];
		char DEPOSITOR_NM        [50];
		char DEPOSITOR_TEL_DDD   [5];
		char DEPOSITOR_TEL_EXN   [5];
		char DEPOSITOR_TEL_NUM   [5];
		char DEFRAY_ACCOUNT_NUM  [50];
		char DEPOSITOR_BIRTH_DATE[20];
		char DEPOSITOR_RELAT_CD  [10];
		char CUST_RELAT_CD       [10];
		char REQ_NM              [50];
		char REQ_TEL_DDD         [5];
		char REQ_TEL_EXN         [5];
		char REQ_TEL_NUM         [5];
		char OZ_TRAN_REQ_FLAG    [10];
		char SOC_NUM             [50];
		char OWNHOUSE_TEL_DDD    [5];
		char OWNHOUSE_TEL_EXN    [5];
		char OWNHOUSE_TEL_NUM    [5];
		char CP_DDD              [5];
		char CP_EXN              [5];
		char CP_NUM              [5];
		char OZ_EMAIL_REQ_FLAG   [10];
		char OZ_LMS_REQ_FLAG     [10];
		char CARD_VALID_PERIOD   [30];
		char CARD_JOIN_YN        [10];
		char PDFPATH			 [256];
		char ADDR_UNION          [500];
		char CHK_CHG_USERINFO_FLAG  [5];
		char INFO_USE_YN6        [5];
	}	OZDATA;

	OZDATA m_stOzData;
	
	//ozview body �ڵ�
	handle m_hBody = NULL;
	long m_lDocFlag = 0;	//�������� = 2, ���Ǻ��� = 3 flag
	long m_lReActionFlag = 0; //m_lReActionFlag = 0 default , m_lReActionFlag = 1 ���� ���� ���� �� ���� �����
	
	void SetBtnImg(void);

	long Rcv_Data(void);
	long TR82256(void);
	long SetData(long nservicenum);
	void OzView(void);
	void SetJsonBody(SQLITE sql);
	void SetJsonArray_Bank(SQLITE sql);
	void SetJsonArray_Payment(void);
	
	void Rcv_OzData(char* OzData);
	long Snd_OzView(void);
	long TR822566(void);
	
	long Chk_chgUserInfo(void);
	
	SysButCtrl SysButRes_MAIN[] =
	 {
		  SYS_BUT_IMG (  BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME,  0),
		  SYS_BUT_IMG (  BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD,  0),
		  SYS_BUT_IMG (  BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0),
		  SYS_BUT_IMG (  BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK,  0),
		  SYS_BUT_IMG (  BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0),
		  SYS_BUT_IMG (  BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0),
		  SYS_BUT_IMG (  BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0),
	 };
	
	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����༭ ���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
	
		DLG_BUTTON(0,           STARTY-10 , 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_KEEP, "���� ����"),
		DLG_BUTTON(0,           STARTY+90 , 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_CHANGE, "���� ����"),
		DLG_BUTTON(0,           STARTY+190, 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_NEW, "�ű�"),
		DLG_BUTTON(STARTX+550,	STARTY+330, 450, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),
	};	
	

	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����༭ ���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
	
		DLG_BUTTON(0,           STARTY    , 450, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_KEEP, "���� ����"),
		DLG_BUTTON(0,           STARTY    , 450, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_CHANGE, "���� ����"),
		DLG_BUTTON(0,           STARTY+190, 450, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NAME_NEW, "�ű�"),
		DLG_BUTTON(STARTX+693,	STARTY+120, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),
	};

	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		return TRUE;
	}
	
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void	OnInit(char bFirst)
	{
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}

				SetBtnImg();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[300];
		long i = 0;;
	
		switch(ID)
		{
			case BID_NAME_KEEP: // ��������
				m_lDocFlag = 2;
				Rcv_Data();
				/*
				if (FFS_Exist("../LCTECH")) {
					PRINT("BID_NAME_KEEP ../LCTECH FFS_EXISTS true",0,0,0);
				} else {
					PRINT("BID_NAME_KEEP ../LCTECH FFS_EXISTS false",0,0,0);
				}
				
				//i = FFS_RemoveDir("../LCTECH");
				//i = FFS_RemoveDir(PHOTO_GM);
				i = FFS_RemoveDir("../LCTECH");
				//i = FFS_RemoveDir("/LCTECH");
				PRINT("i : %d",i,0,0);
				
				if( GetApiError() == FS_ERR_INTERNAL_ERROR )
				{
					PRINT("BID_NAME_KEEP ../LCTECH FS_ERR_INTERNAL_ERROR",0,0,0);
				}
				else if( GetApiError() == FS_ERR_NO_SUCH_FILE )
				{
					PRINT("BID_NAME_KEEP ../LCTECH FS_ERR_NO_SUCH_FILE",0,0,0);
				}
				else
				{
					PRINT("BID_NAME_KEEP ../LCTECH ETC ERROR",0,0,0);
				}
				//g_DirFS_Clear("../LCTECH"    , "*");
				*/
				break;
			case BID_NAME_CHANGE:
				m_lDocFlag = 3;
				Rcv_Data();
				break;
			case BID_NAME_NEW:
				m_lDocFlag = 4;
				Rcv_Data();
				break;
			case BID_CLOSE:
				Card_Prev();
				break;
			case GID_HOME:
				break;
			case GID_MENU:
				break;
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
			case GID_SCREEN:
				g_MOVE_DLG(400);
				break;
			case GID_CMMNWK:
				break;				
			case GID_PREV:
				Card_Prev();
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}	

//��������������������������������������������������������������������������������������������
	void	OnTask(long nEvent, long nData)
	{
		char* szOzData;
		long nRet = 0;

//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);		
		if( nEvent == 1 )
		{
			// MessageBoxEx (CONFIRM_OK, "������!!!!!!!!!!!! CM_USEDOC");
			//�ý�����
			szOzData = (char*)System_GetResult((char*)&nRet);
			//g_Save_JsonFile(szOzData);
			Rcv_OzData(szOzData);
		}
	}

	//��������������������������������������������������������������������������������������������
	//���� ������ ����
	void Rcv_OzData(char* szOzData)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		char szFolderNm[128];
		char szFileNm[256];
		char szCopyNm[256];
		char szCopyPath[256];
		char szBanknm[50];
		char szBankcd[10];
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lAddrLen = 0;
		long lRet = 0;
		long lCnt = 0;
		char *szitem;
		char *szPath;
		char *szData;
		char *szAddrMode;
		char *szAddrSeq;
		long *nCol;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 0;
		handle hItem = NULL;
		handle hPath = NULL;
		handle hData = NULL;
		handle hAddrMode = NULL;
		handle hAddrSeq = NULL;

		hItem = JSON_Create( JSON_Object );
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szOzData ) ;

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, JSON_GetValue (hItem, "ret_action",    szType));

			if( Str_Cmp(szTmp, "btnSave") == 0 )
			{
				//�Է� ����
				szData = JSON_GetValue (hItem, "ret_data",    szType);
				hData = JSON_Create( JSON_Object );
				
				if( hData != NULL )
				{
					JSON_toJson( hData, szData ) ;
					
					Mem_Set((byte*)&m_stOzData, 0x00, sizeof(m_stOzData));
	
					Str_Cpy(m_stOzData.USE_CONT_NUM       , m_stUsedata.USE_CONT_NUM);
					Str_Cpy(m_stOzData.BRANCH_CD          , stUserinfo.szbranch_cd);
					Str_Cpy(m_stOzData.CENTER_CD          , stUserinfo.szcenter_cd);
					Str_Cpy(m_stOzData.INST_PLACE_NUM     , JSON_GetValue (hData, "pmUsecontnum",    szType));
					Str_Cpy(m_stOzData.CUST_NUM           , m_stUsedata.CUST_NUM);
					Str_Cpy(m_stOzData.CUST_NM            , JSON_GetValue (hData, "pmName",    szType));
					
					// long m_lDocFlag = 0;	//�������� = 2, ���Ǻ��� = 3, �ű� = 4
					// CHG_CUST_TYPE, TRANS_FLAG
					if( m_lDocFlag == 2 )
					{
						Str_Cpy(m_stOzData.CHG_CUST_TYPE          , "10");
						Str_Cpy(m_stOzData.TRANS_FLAG             , "2");
					}
					else if( m_lDocFlag == 3 )
					{
						Str_Cpy(m_stOzData.CHG_CUST_TYPE          , "20");
						Str_Cpy(m_stOzData.TRANS_FLAG             , "3");
					}
					else if( m_lDocFlag == 4 )
					{
						Str_Cpy(m_stOzData.CHG_CUST_TYPE          , "30");
						Str_Cpy(m_stOzData.TRANS_FLAG             , "1");
					}
					else
					{	
						Str_Cpy(m_stOzData.CHG_CUST_TYPE          , "");
						Str_Cpy(m_stOzData.TRANS_FLAG             , "1");
					}
					
					// DATA_COL_TYPE
					if( g_nWorkFlag > 99 && g_nWorkFlag < 200 )
					{
						//��ħ
						Str_Cpy(m_stOzData.DATA_COL_TYPE          , "30");
					}
					else if( g_nWorkFlag > 199 && g_nWorkFlag < 300 )
					{
						//��������
						Str_Cpy(m_stOzData.DATA_COL_TYPE          , "20");
					}
					else if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
					{
						//�跮�ⱳü
						Str_Cpy(m_stOzData.DATA_COL_TYPE          , "40");
					}
					else if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
					{
						//��Ÿ�ο�
						Str_Cpy(m_stOzData.DATA_COL_TYPE          , "50");
					}
					
					//�ڵ���ü ��û&���� ���� = new ��û , = cancel ��û���(����), = NULL ���(������ ���)
					Str_Cpy(m_stOzData.OZ_TRAN_REQ_FLAG, JSON_GetValue (hData, "pmBanktype",    szType));
					
					if( Str_Cmp(m_stOzData.OZ_TRAN_REQ_FLAG, "new") == 0 || Str_Cmp(m_stOzData.OZ_TRAN_REQ_FLAG, "cancel") == 0 )
					{
						//���ι�� ( 10 : �����ڵ���ü, 20 : ī���ڵ���ü, NULL : ���� )
						//if( Str_Cmp(m_stOzData.PAYMENT_METHOD, "10") == 0 )
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(szTmp     , JSON_GetValue (hData, "pmPayment",    szType));
						if( Str_Cmp(szTmp, "�����ڵ���ü") == 0 )
						{
							Str_Cpy(m_stOzData.TRAN_FLAG, "10");
							Str_Cpy(m_stOzData.PAYMENT_METHOD, "10");
							Str_Cpy(m_stOzData.PAY_METHOD_TYPE, "10");
							
							lCnt = 0;
							g_Sql_RetInt("SELECT COUNT(*) FROM COMMONCODE WHERE CODE_ID = 'C61999'", &lCnt);
							
							Mem_Set((byte*)szBanknm, 0x00, sizeof(szBanknm));	
							Str_Cpy(szBanknm     , JSON_GetValue (hData, "pmBankText",    szType));
							for( i=0 ; i < lCnt ; i++ )
							{
								Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
								Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
								Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
								SPRINT(szTmp,"SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' LIMIT %d, 1",i,0,0);
								g_Sql_RetStr(szTmp, 10, szBuf);
								Mem_Cpy((byte *)szRet, (byte *)szBuf+5, Str_Len(szBuf)-5);
								if( Str_Cmp(szBanknm, szRet) == 0 )
								{
									Mem_Set((byte*)szBankcd, 0x00, sizeof(szBankcd));	
									Mem_Cpy((byte *)szBankcd, (byte *)szBuf, 3);
									Str_Cpy(m_stOzData.BNK_CD, szBankcd);
									Str_Cpy(m_stOzData.BNK_BRANCH_NM, szBanknm);
									break;
								}
							}
	
							Str_Cpy(m_stOzData.DEPOSITOR_NM        , JSON_GetValue (hData, "pmAccname",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_DDD   , JSON_GetValue (hData, "pmAccphone1",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_EXN   , JSON_GetValue (hData, "pmAccphone2",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_NUM   , JSON_GetValue (hData, "pmAccphone3",    szType));
							Str_Cpy(m_stOzData.DEFRAY_ACCOUNT_NUM  , JSON_GetValue (hData, "pmAcc",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_BIRTH_DATE, JSON_GetValue (hData, "pmAccbirthdate",    szType));
							Str_Chg(m_stOzData.DEPOSITOR_BIRTH_DATE, STRCHG_DEL_NONDIGIT);
							Str_Cpy(m_stOzData.CUST_RELAT_CD  , "");
	
							Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
							Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
							Str_Cpy(szRet       , JSON_GetValue (hData, "pmAccrelation",    szType));
							SPRINT(szTmp,"SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s'", szRet,0,0);
							g_Sql_RetStr(szTmp, 20, m_stOzData.DEPOSITOR_RELAT_CD);
							
							Str_Cpy(m_stOzData.REQ_NM              , JSON_GetValue (hData, "pmAgentname",    szType));
							Str_Cpy(m_stOzData.REQ_TEL_DDD         , JSON_GetValue (hData, "pmAgentphone1",    szType));
							Str_Cpy(m_stOzData.REQ_TEL_EXN         , JSON_GetValue (hData, "pmAgentphone2",    szType));
							Str_Cpy(m_stOzData.REQ_TEL_NUM         , JSON_GetValue (hData, "pmAgentphone3",    szType));
						}
						else if( Str_Cmp(szTmp, "ī���ڵ���ü") == 0 )
						{
							Str_Cpy(m_stOzData.TRAN_FLAG, "20");
							Str_Cpy(m_stOzData.PAYMENT_METHOD, "20");
							Str_Cpy(m_stOzData.PAY_METHOD_TYPE, "10");
							
							lCnt = 0;
							g_Sql_RetInt("SELECT COUNT(*) FROM COMMONCODE WHERE CODE_ID = 'C61998'", &lCnt);
							
							Mem_Set((byte*)szBanknm, 0x00, sizeof(szBanknm));	
							Str_Cpy(szBanknm     , JSON_GetValue (hData, "pmBankText",    szType));
							for( i=0 ; i < lCnt ; i++ )
							{
								Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
								Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
								Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
								SPRINT(szTmp,"SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' LIMIT %d, 1",i,0,0);
								g_Sql_RetStr(szTmp, 10, szBuf);
								Mem_Cpy((byte *)szRet, (byte *)szBuf+5, Str_Len(szBuf)-5);
								if( Str_Cmp(szBanknm, szRet) == 0 )
								{
									Mem_Set((byte*)szBankcd, 0x00, sizeof(szBankcd));	
									Mem_Cpy((byte *)szBankcd, (byte *)szBuf, 3);
									Str_Cpy(m_stOzData.BNK_CD, szBankcd);
									Str_Cpy(m_stOzData.BNK_BRANCH_NM, szBanknm);
									break;
								}
							}
	
							Str_Cpy(m_stOzData.DEPOSITOR_NM        , JSON_GetValue (hData, "pmAccname",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_DDD   , JSON_GetValue (hData, "pmAccphone1",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_EXN   , JSON_GetValue (hData, "pmAccphone2",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_NUM   , JSON_GetValue (hData, "pmAccphone3",    szType));
							Str_Cpy(m_stOzData.DEFRAY_ACCOUNT_NUM  , JSON_GetValue (hData, "pmAcc",    szType));
							Str_Cpy(m_stOzData.DEPOSITOR_BIRTH_DATE, JSON_GetValue (hData, "pmAccbirthdate",    szType));
							Str_Chg(m_stOzData.DEPOSITOR_BIRTH_DATE, STRCHG_DEL_NONDIGIT);
							Str_Cpy(m_stOzData.CUST_RELAT_CD  , "");
	
							Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
							Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
							Str_Cpy(szRet       , JSON_GetValue (hData, "pmAccrelation",    szType));
							SPRINT(szTmp,"SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s'", szRet,0,0);
							g_Sql_RetStr(szTmp, 20, m_stOzData.DEPOSITOR_RELAT_CD);
							
							Str_Cpy(m_stOzData.REQ_NM              , JSON_GetValue (hData, "pmAgentname",    szType));
							Str_Cpy(m_stOzData.REQ_TEL_DDD         , JSON_GetValue (hData, "pmAgentphone1",    szType));
							Str_Cpy(m_stOzData.REQ_TEL_EXN         , JSON_GetValue (hData, "pmAgentphone2",    szType));
							Str_Cpy(m_stOzData.REQ_TEL_NUM         , JSON_GetValue (hData, "pmAgentphone3",    szType));
						}
						else
						{
							if( Str_Cmp(m_stOzData.OZ_TRAN_REQ_FLAG, "cancel") == 0 )
							{
								//�ڵ���ü ��û ���
								Str_Cpy(m_stOzData.PAYMENT_METHOD, "");
								Str_Cpy(m_stOzData.PAY_METHOD_TYPE, "20");
							}
							else
							{
								//���� -> ����
								Str_Cpy(m_stOzData.PAYMENT_METHOD, "");
								Str_Cpy(m_stOzData.PAY_METHOD_TYPE, "");
							}
							Str_Cpy(m_stOzData.TRAN_FLAG           , "");
							
							Str_Cpy(m_stOzData.BNK_CD              , "");
							Str_Cpy(m_stOzData.BNK_BRANCH_NM       , "");
							Str_Cpy(m_stOzData.DEPOSITOR_NM        , "");
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_DDD   , "");
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_EXN   , "");
							Str_Cpy(m_stOzData.DEPOSITOR_TEL_NUM   , "");
							Str_Cpy(m_stOzData.DEFRAY_ACCOUNT_NUM  , "");
							Str_Cpy(m_stOzData.DEPOSITOR_BIRTH_DATE, "");
							Str_Cpy(m_stOzData.DEPOSITOR_RELAT_CD  , "");
							Str_Cpy(m_stOzData.CUST_RELAT_CD       , "");
							Str_Cpy(m_stOzData.REQ_NM              , "");
							Str_Cpy(m_stOzData.REQ_TEL_DDD         , "");
							Str_Cpy(m_stOzData.REQ_TEL_EXN         , "");
							Str_Cpy(m_stOzData.REQ_TEL_NUM         , "");
						}
						
						//���� ī�� ����
						//Str_Cpy(m_stOzData.CARD_VALID_PERIOD               , JSON_GetValue (hData, "card_valid_period",    szType) );
						//Str_Cpy(m_stOzData.CARD_JOIN_YN                    , JSON_GetValue (hData, "card_join_yn",    szType) );
					}
					else
					{
						Str_Cpy(m_stOzData.PAYMENT_METHOD      , "");
						Str_Cpy(m_stOzData.PAY_METHOD_TYPE     , "");
						Str_Cpy(m_stOzData.TRAN_FLAG           , "");
						Str_Cpy(m_stOzData.BNK_CD              , "");
						Str_Cpy(m_stOzData.BNK_BRANCH_NM       , "");
						Str_Cpy(m_stOzData.DEPOSITOR_NM        , "");
						Str_Cpy(m_stOzData.DEPOSITOR_TEL_DDD   , "");
						Str_Cpy(m_stOzData.DEPOSITOR_TEL_EXN   , "");
						Str_Cpy(m_stOzData.DEPOSITOR_TEL_NUM   , "");
						Str_Cpy(m_stOzData.DEFRAY_ACCOUNT_NUM  , "");
						Str_Cpy(m_stOzData.DEPOSITOR_BIRTH_DATE, "");
						Str_Cpy(m_stOzData.DEPOSITOR_RELAT_CD  , "");
						Str_Cpy(m_stOzData.CUST_RELAT_CD       , "");
						Str_Cpy(m_stOzData.REQ_NM              , "");
						Str_Cpy(m_stOzData.REQ_TEL_DDD         , "");
						Str_Cpy(m_stOzData.REQ_TEL_EXN         , "");
						Str_Cpy(m_stOzData.REQ_TEL_NUM         , "");

						//���� ī�� ����
						//Str_Cpy(m_stOzData.CARD_VALID_PERIOD               , "" );
						//Str_Cpy(m_stOzData.CARD_JOIN_YN                    , "" );
					}

					//��� û����� ���� ����or����
					//���û����� ( 30 : LMS, 40 : EMAIL, NULL : ������ )
					//if( Str_Cmp(m_stOzData.BILING_METHOD, m_stUsedata.BILING_METHOD) != 0 )
					//{
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy(szTmp     , JSON_GetValue (hData, "pmBilling",    szType));
					
					if( Str_Cmp(szTmp, "LMS") == 0 )
					{
						Str_Cpy(m_stOzData.BILING_METHOD, "30");

						Str_Cpy(m_stOzData.LMS_TEL_DDD         , JSON_GetValue (hData, "pmLms1",    szType) );
						Str_Cpy(m_stOzData.LMS_TEL_EXN         , JSON_GetValue (hData, "pmLms2",    szType) );
						Str_Cpy(m_stOzData.LMS_TEL_NUM         , JSON_GetValue (hData, "pmLms3",    szType) );
						
						if( Str_Cmp(m_stUsedata.BILING_METHOD, "70") != 0 )
						{
							Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "10");
							Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "new");
							Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG     , "");
						}
						else
						{
							if( Str_Cmp(m_stOzData.LMS_TEL_DDD, m_stUsedata.LMS_TEL_DDD) != 0 ||
							    Str_Cmp(m_stOzData.LMS_TEL_EXN, m_stUsedata.LMS_TEL_EXN) != 0 ||
							    Str_Cmp(m_stOzData.LMS_TEL_NUM, m_stUsedata.LMS_TEL_NUM) != 0 )
							{
								Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "modify");
								Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG     , "");
							}
							else
							{
								Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "");
								Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "");
								Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG     , "");
							}
						}

						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(m_stOzData.EMAIL_REQ_ADDR      , JSON_GetValue (hData, "pmEmail1",    szType) );
						Str_Cpy(szTmp                          , JSON_GetValue (hData, "pmEmail2",    szType) );
						
						if( Str_Len(m_stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, szTmp);

							//�Էµ� �̸��� �ּҰ� ���� ��� @����
							Str_Chg(m_stOzData.EMAIL_REQ_ADDR, STRCHG_DEL_ALL_SPACE);
							if( Str_Cmp(m_stOzData.EMAIL_REQ_ADDR, "@") == 0 )
							{
								Str_Cpy(m_stOzData.EMAIL_REQ_ADDR, "");
							}
						}
						else
						{
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, "");
						}
					}
					else if( Str_Cmp(szTmp, "E-mail") == 0 )
					{
						Str_Cpy(m_stOzData.BILING_METHOD, "40");

						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(m_stOzData.EMAIL_REQ_ADDR      , JSON_GetValue (hData, "pmEmail1",    szType) );
						Str_Cpy(szTmp                          , JSON_GetValue (hData, "pmEmail2",    szType) );

						if( Str_Cmp(m_stUsedata.BILING_METHOD, "40") != 0 )
						{
							Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "10");
							Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "");
							Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG     , "new");
						}
						else
						{
							if( Str_Cmp(m_stOzData.EMAIL_REQ_ADDR, m_stUsedata.EMAIL_REQ_ID) != 0 ||
							    Str_Cmp(szTmp, m_stUsedata.EMAIL_REQ_ADDR) != 0 )
							{
								Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "");
								Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG     , "modify");
							}
							else
							{
								Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "");
								Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "");
								Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG     , "");
							}
						}
						
						if( Str_Len(m_stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, szTmp);

							//�Էµ� �̸��� �ּҰ� ���� ��� @����
							Str_Chg(m_stOzData.EMAIL_REQ_ADDR, STRCHG_DEL_ALL_SPACE);
							if( Str_Cmp(m_stOzData.EMAIL_REQ_ADDR, "@") == 0 )
							{
								Str_Cpy(m_stOzData.EMAIL_REQ_ADDR, "");
							}
						}
						else
						{
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, "");
						}

						Str_Cpy(m_stOzData.LMS_TEL_DDD         , "" );
						Str_Cpy(m_stOzData.LMS_TEL_EXN         , "" );
						Str_Cpy(m_stOzData.LMS_TEL_NUM         , "" );
					}
					else
					{	
						//���� û����� Ȯ�� -> ��� or ������
						if( Str_Cmp(m_stUsedata.BILING_METHOD, "70") == 0 )
						{
							Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG   , "");
							Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "cancel");
							Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "20");
						}
						else if( Str_Cmp(m_stUsedata.BILING_METHOD, "40") == 0 )
						{
							Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG     , "cancel");
							Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "");
							Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "20");
						}
						else
						{
							if( Str_Cmp(szTmp, "�����") == 0 )
							{
								Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "");
								Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG   , "");
								Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "10");
							}
							else
							{
								Str_Cpy(m_stOzData.OZ_LMS_REQ_FLAG     , "");
								Str_Cpy(m_stOzData.OZ_EMAIL_REQ_FLAG   , "");
								Str_Cpy(m_stOzData.BILL_METHOD_TYPE, "");
							}
						}
						
						if( Str_Cmp(szTmp, "�����") == 0 )
						{
							Str_Cpy(m_stOzData.BILING_METHOD, "50");
						}
						else
						{
							Str_Cpy(m_stOzData.BILING_METHOD, "");
						}
						
						Str_Cpy(m_stOzData.LMS_TEL_DDD         , "" );
						Str_Cpy(m_stOzData.LMS_TEL_EXN         , "" );
						Str_Cpy(m_stOzData.LMS_TEL_NUM         , "" );

						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy(m_stOzData.EMAIL_REQ_ADDR      , JSON_GetValue (hData, "pmEmail1",    szType) );
						Str_Cpy(szTmp                          , JSON_GetValue (hData, "pmEmail2",    szType) );
						if( Str_Len(m_stOzData.EMAIL_REQ_ADDR) > 0 || Str_Len(szTmp) > 0 )
						{
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, "@");
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, szTmp);

							//�Էµ� �̸��� �ּҰ� ���� ��� @����
							Str_Chg(m_stOzData.EMAIL_REQ_ADDR, STRCHG_DEL_ALL_SPACE);
							if( Str_Cmp(m_stOzData.EMAIL_REQ_ADDR, "@") == 0 )
							{
								Str_Cpy(m_stOzData.EMAIL_REQ_ADDR, "");
							}
						}
						else
						{
							Str_Cat(m_stOzData.EMAIL_REQ_ADDR, "");
						}
					}
					//}

					//�Էµ����� ���� Ȯ��(yyyymmdd OR yyyy��mm��dd��) -> ����� ���ڷ� ������
					//Str_Cpy(m_stOzData.BIRTH_DATE_YEAR             , JSON_GetValue (hData, "pmBirthdateY",    szType) );
					//Str_Cpy(m_stOzData.BIRTH_DATE_MONTH            , JSON_GetValue (hData, "pmBirthdateM",    szType) );
					//Str_Cpy(m_stOzData.BIRTH_DATE_DAY              , JSON_GetValue (hData, "pmBirthdateD",    szType) );
					Str_Cpy(m_stOzData.SOC_NUM                     , JSON_GetValue (hData, "pmBirthdate",    szType) );
					Str_Cat(m_stOzData.SOC_NUM, "0000000");
					Str_Chg(m_stOzData.SOC_NUM, STRCHG_DEL_NONDIGIT);
					
					Str_Cpy(m_stOzData.GENDER                      , JSON_GetValue (hData, "pmSex",    szType) );
					Str_Cpy(m_stOzData.TRAN_REQ_YMD                , JSON_GetValue (hData, "pmCurrentdate",    szType) );
					Str_Chg(m_stOzData.TRAN_REQ_YMD, STRCHG_DEL_NONDIGIT);

					//�������� ������ ��ȭ��ȣ �ʵ� Ȯ��(OZ��)
					Str_Cpy(m_stOzData.OWNHOUSE_TEL_DDD            , JSON_GetValue (hData, "pmTel1",    szType) );
					Str_Cpy(m_stOzData.OWNHOUSE_TEL_EXN            , JSON_GetValue (hData, "pmTel2",    szType) );
					Str_Cpy(m_stOzData.OWNHOUSE_TEL_NUM            , JSON_GetValue (hData, "pmTel3",    szType) );
					Str_Cpy(m_stOzData.CP_DDD                      , JSON_GetValue (hData, "pmPhone1",    szType) );
					Str_Cpy(m_stOzData.CP_EXN                      , JSON_GetValue (hData, "pmPhone2",    szType) );
					Str_Cpy(m_stOzData.CP_NUM                      , JSON_GetValue (hData, "pmPhone3",    szType) );
					Str_Cpy(m_stOzData.ADDR_UNION                  , JSON_GetValue (hData, "pmAddr",    szType) );
					
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN           , JSON_GetValue (hData, "pmAgreetitle1",    szType) );
					Str_Cpy(m_stOzData.INFO_USE_YN4                , JSON_GetValue (hData, "pmAgreetitle2",    szType) );
					Str_Cpy(m_stOzData.INFO_USE_YN                 , JSON_GetValue (hData, "pmAgreetitle3",    szType) );
					Str_Cpy(m_stOzData.INFO_USE_YN5                , JSON_GetValue (hData, "pmAgreetitle4",    szType) );
					Str_Cpy(m_stOzData.INFO_USE_YN6                , JSON_GetValue (hData, "pmAgreetitle5",    szType) );
				}
				
				//���� ī�� ����
				Str_Cpy(m_stOzData.CARD_VALID_PERIOD               , JSON_GetValue (hItem, "card_valid_period",    szType) );
				Str_Cpy(m_stOzData.CARD_JOIN_YN                    , JSON_GetValue (hItem, "card_join_yn",    szType) );
				
				//PDF ���
				szPath = JSON_GetValue (hItem, "pdf_path",    szType);
	
				hPath = JSON_Create( JSON_Object );
				if( hPath != NULL )
				{
					//OZ ����(PDF) �� Smart���� ���� ������ ����
					JSON_toJson( hPath, szPath ) ;
		
					j = 0;
					k = 0;
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Mem_Set((byte*)szFolderNm, 0x00, sizeof(szFolderNm));
					Mem_Set((byte*)szCopyNm, 0x00, sizeof(szCopyNm));
					
					Str_Cpy(szTmp, JSON_GetValue (hPath, "Path",    szType));
					lFileLen = Str_Len(szTmp);
					if( lFileLen > 0 )
					{
						for( i=0 ; lFileLen ; i++)
						{
							if(szTmp[i] == '0')
							{
								j = i;
								break;
							}
							else
							{
								k++;
							}
						}

						Mem_Cpy((byte *)szFolderNm, (byte *)szTmp+(j+9), 17);
						Mem_Cpy((byte *)szCopyNm, (byte *)szTmp+(j+9), 14);
					}
	
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
					Str_Cpy(szBuf, "../LCTECH/");
					Str_Cat(szBuf, szFolderNm);
					if( FFS_Exist(szBuf) )
					{
						lRet = g_FindFiles( szBuf, "*.Enc" , szFileNm);
						if( lRet > 0 )
						{
							SPRINT (m_stOzData.PDFPATH, "OZ_FILE/%s_%s_.pdf.Enc",  szCopyNm, m_stOzData.USE_CONT_NUM, 0);
							FFS_Copy(szFileNm, m_stOzData.PDFPATH);
	
							//������ �ű� �� LCTECH ���� Ŭ����(���� oz���� ����)
							FFS_Delete(szFileNm);
						}
						
						Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
						lRet = g_FindFiles( szBuf, "*.pdf" , szFileNm);
						if( lRet > 0 )
						{
							//������ �ű� �� LCTECH ���� Ŭ����(���� oz���� ����)
							FFS_Delete(szFileNm);
						}
					}
				}
			}
			else
			{
				if(hItem != NULL)
				{
					JSON_Finalize(hItem);
					hItem = NULL;
				}
				
				if(hPath != NULL)
				{
					JSON_Finalize(hPath);
					hPath = NULL;
				}
				
				if(hData != NULL)
				{
					JSON_Finalize(hData);
					hData = NULL;
				}
		
				g_Close_SubDlg();
				
				ON_DRAW();
				return;
			}
		}

		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
		
		if(hPath != NULL)
		{
			JSON_Finalize(hPath);
			hPath = NULL;
		}
		
		if(hData != NULL)
		{
			JSON_Finalize(hData);
			hData = NULL;
		}

		g_Close_SubDlg();

		Snd_OzView();
		ON_DRAW();
		return;
	}

//------------------------------------------------------------------------------------------
	long Rcv_Data(void)
	{
		char szNonpayManageZone[20];
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82256, FALSE);
		
		if( g_nWorkFlag > 99 && g_nWorkFlag < 200)
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	stGm.USE_CONT_NUM );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",               stGm.CUST_NUM );
		}
		else if( g_nWorkFlag > 199 && g_nWorkFlag < 300)
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	stSc.USE_CONT_NUM );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",               stSc.CUST_NUM );
		}
		else if( g_nWorkFlag > 699 && g_nWorkFlag < 800)
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	stMtrChg.USE_CONT_NUM );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",               stMtrChg.CUST_NUM );
		}
		
		//��༭ �ۼ����� > 1(���Թο�), 2(��������), 3(���Ǻ���), 4(�ű�)
		//long m_lDocFlag = 0;	//�������� = 2, ���Ǻ��� = 3 flag
		if( m_lDocFlag == 2 )
		{
			JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "2" );
		}
		else if( m_lDocFlag == 3 )
		{
			JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "3" );
		}
		else if ( m_lDocFlag == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "trans_flag",     "4" );
		}
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82256; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR82256_IN",  "FR82256" , sndbuf, sztmp );
		return 0 ;
	}
	
	
//------------------------------------------------------------------------------------------
	long TR82256(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(82256) >= 0)
		{
			SetData(82256);

			//2017-05-25 Sanghyun Lee
			//�ӽð�, ����Ͼۻ���, ����ڰ��� ����ϻ���༭ �ۼ� �Ұ� ó���Ǿ�� ��
			if( Str_Cmp(m_stUsedata.BILING_METHOD, "80") == 0 )
			{
				//BILLING_METHOD = 80 -> ����Ͼ� ����
				MessageBoxEx (CONFIRM_OK, "����Ͼۻ�� ���� �ۼ� �� �� �����ϴ�.");
			}
			else if(m_stUsedata.CUST_NUM[0] == '0' )
			{
				if( m_lDocFlag == 3 || m_lDocFlag == 4 )
				{
					OzView();
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "�ӽ� ���� �ۼ� �� �� �����ϴ�.\n�ۼ��� ���Ͻø� ���Ǻ����� ������ּ���.");
				}
			}
			else if( Str_Len(m_stUsedata.BIZ_REGI_NUM) > 1 )
			{
				//���Ǻ���, �������� > BIZ_REGI_NUM ���� �����ϸ� �������� ������� �޼��� ȣ��
				MessageBoxEx (CONFIRM_OK, "����� ����� ���� ��� ���ּ���.");
			}
			else
			{
				OzView();
			}
			
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

//------------------------------------------------------------------------------------------
	long SetData(long nservicenum)
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

		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
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
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
				//Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				//if(Str_Len(szmessage) < 500 )
				//	SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				//g_Chk_Code(szJsonpath, szcode, szMsg);
			
				//MessageBoxEx (WARNING_OK, szJsonpath);
				
/*
//2017-05-31 Sanghyun Lee
//OZ ���� ���� �� �ٽ� OZ ���� �ڵ�
				if( nservicenum == 822566 )
				{
					m_lReActionFlag = 1;
					//����༭�� �Ѱ��ִ� ������
					Mem_Set((byte*)&m_stUsedata, 0x00, sizeof(m_stUsedata) );
		
					//�⺻���� INST_PLACE_NUM
					Str_Cpy(m_stUsedata.USE_CONT_NUM    , m_stOzData.USE_CONT_NUM);
					Str_Cpy(m_stUsedata.INST_PLACE_NUM  , m_stOzData.INST_PLACE_NUM);
					Str_Cpy(m_stUsedata.CUST_NUM        , m_stOzData.CUST_NUM);
					Str_Cpy(m_stUsedata.OWNHOUSE_TEL_DDD, m_stOzData.OWNHOUSE_TEL_DDD);
					Str_Cpy(m_stUsedata.OWNHOUSE_TEL_EXN, m_stOzData.OWNHOUSE_TEL_EXN);
					Str_Cpy(m_stUsedata.OWNHOUSE_TEL_NUM, m_stOzData.OWNHOUSE_TEL_NUM);
					Str_Cpy(m_stUsedata.CP_DDD          , m_stOzData.CP_DDD);
					Str_Cpy(m_stUsedata.CP_EXN          , m_stOzData.CP_EXN);
					Str_Cpy(m_stUsedata.CP_NUM          , m_stOzData.CP_NUM);
					Str_Cpy(m_stUsedata.INST_PLACE_NUM  , m_stOzData.INST_PLACE_NUM);
					Str_Cpy(m_stUsedata.BIRTH_DATE      , m_stOzData.BIRTH_DATE);
					Str_Cpy(m_stUsedata.GENDER          , m_stOzData.GENDER);
					
					Str_Cpy(m_stUsedata.SAFE_KEY        , m_stCancelData.SAFE_KEY);
					Str_Chg(m_stUsedata.SAFE_KEY, STRCHG_DEL_ALL_SPACE);
	
					Str_Cpy( m_stUsedata.NEW_ADDR_UNION, m_stOzData.ADDR_UNION);
					Str_Cpy(m_stUsedata.LMS_TEL_DDD     , m_stOzData.LMS_TEL_DDD);
					Str_Cpy(m_stUsedata.LMS_TEL_EXN     , m_stOzData.LMS_TEL_EXN);
					Str_Cpy(m_stUsedata.LMS_TEL_NUM     , m_stOzData.LMS_TEL_NUM);
	
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					Str_Cpy(szMsg  , m_stOzData.EMAIL_REQ_ADDR);
					length = Str_Len(szMsg);
					if( length > 0 )
					{
						for( i=0 ; length ; i++)
						{
							if(szMsg[i] == '@')
							{
								len = i;
								break;
							}
							else if(szMsg[i] == '')
							{
								k++;
								break;
							}
						}
		
						Mem_Cpy((byte *)m_stUsedata.EMAIL_REQ_ID, (byte *)szMsg, len);
						Mem_Cpy((byte *)m_stUsedata.EMAIL_REQ_ADDR, (byte *)szMsg+(len+1), length-(len+1));
					}
	
					Str_Cpy(m_stUsedata.BILING_METHOD   , m_stOzData.BILING_METHOD);
					Str_Cpy(m_stUsedata.PAYMENT_METHOD  , m_stOzData.PAYMENT_METHOD);
	
					Str_Cpy(m_stUsedata.CUST_NM, m_stOzData.CUST_NM);
				
					//�ڵ���ü ����
					Str_Cpy(m_stUsedata.BNK_CD              , m_stOzData.BNK_CD);
					Str_Cpy(m_stUsedata.BNK_BRANCH_NM       , m_stOzData.BNK_BRANCH_NM);
					Str_Cpy(m_stUsedata.DEPOSITOR_NM        , m_stOzData.DEPOSITOR_NM);
					Str_Cpy(m_stUsedata.DEPOSITOR_TEL_DDD   , m_stOzData.DEPOSITOR_TEL_DDD   );
					Str_Cpy(m_stUsedata.DEPOSITOR_TEL_EXN   , m_stOzData.DEPOSITOR_TEL_EXN   );
					Str_Cpy(m_stUsedata.DEPOSITOR_TEL_NUM   , m_stOzData.DEPOSITOR_TEL_NUM   );
					Str_Cpy(m_stUsedata.DEFRAY_ACCOUNT_NUM  , m_stOzData.DEFRAY_ACCOUNT_NUM  );
					Str_Cpy(m_stUsedata.DEPOSITOR_BIRTH_DATE, m_stOzData.DEPOSITOR_BIRTH_DATE);
					Str_Cpy(m_stUsedata.DEPOSITOR_RELAT_CD  , m_stOzData.CUST_RELAT_CD       );
					Str_Cpy(m_stUsedata.REQ_NM              , m_stOzData.REQ_NM       );
					Str_Cpy(m_stUsedata.REQ_TEL_DDD         , m_stOzData.REQ_TEL_DDD);
					Str_Cpy(m_stUsedata.REQ_TEL_EXN         , m_stOzData.REQ_TEL_EXN);
					Str_Cpy(m_stUsedata.REQ_TEL_NUM         , m_stOzData.REQ_TEL_NUM);
					Str_Cpy(m_stUsedata.INFO_USE_AGREE_YN   , m_stOzData.INFO_USE_AGREE_YN  );
					Str_Cpy(m_stUsedata.INFO_USE_YN         , m_stOzData.INFO_USE_YN        );
					Str_Cpy(m_stUsedata.INFO_USE_YN4        , m_stOzData.INFO_USE_YN4       );
					Str_Cpy(m_stUsedata.INFO_USE_YN5        , m_stOzData.INFO_USE_YN5       );
					
					ret = -2;
				}
				else
				{
				}
*/
				
			    char* pMsg = NULL;
			  			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);

				ret = -1;

				
				ON_DRAW();
				
			}
			else
			{
				if( nservicenum == 822566 )
				{
					//����༭ �۽� �Ϸ� �� �޽���
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					Str_Cpy(szMsg, szmessage);
					if( Str_Cmp(szMsg, "OK") == 0 )
					{
						Str_Cpy(szMsg, "����༭ ���忡 �����Ͽ����ϴ�.");
					}
					MessageBoxEx (CONFIRM_OK, szMsg);
				}
				else
				{
					m_lReActionFlag = 0;
				
					//����༭�� �Ѱ��ִ� ������
					Mem_Set((byte*)&m_stUsedata, 0x00, sizeof(m_stUsedata) );
					//û����� ������ �ʿ��� ���� ��� ����
					Mem_Set((byte*)&m_stCancelData, 0x00, sizeof(m_stCancelData) );
					//PRINT("JSON_toString(g_pjcomm) : %s",JSON_toString(g_pjcomm),0,0);	
					
					Str_Cpy(m_stUsedata.BIZ_REGI_NUM    , JSON_GetValue (g_pjcomm, "biz_regi_num",        szType));
					Str_Chg(m_stUsedata.BIZ_REGI_NUM, STRCHG_DEL_ALL_SPACE);
		
					//�⺻����
					Str_Cpy(m_stUsedata.USE_CONT_NUM    , JSON_GetValue (g_pjcomm, "use_cont_num",        szType));
					Str_Cpy(m_stUsedata.CUST_NUM        , JSON_GetValue (g_pjcomm, "cust_num",            szType));
					Str_Cpy(m_stUsedata.OWNHOUSE_TEL_DDD, JSON_GetValue (g_pjcomm, "ownhouse_tel_ddd",    szType));
					Str_Cpy(m_stUsedata.OWNHOUSE_TEL_EXN, JSON_GetValue (g_pjcomm, "ownhouse_tel_exn",    szType));
					Str_Cpy(m_stUsedata.OWNHOUSE_TEL_NUM, JSON_GetValue (g_pjcomm, "ownhouse_tel_num",    szType));
					Str_Cpy(m_stUsedata.CP_DDD          , JSON_GetValue (g_pjcomm, "cp_ddd",              szType));
					Str_Cpy(m_stUsedata.CP_EXN          , JSON_GetValue (g_pjcomm, "cp_exn",              szType));
					Str_Cpy(m_stUsedata.CP_NUM          , JSON_GetValue (g_pjcomm, "cp_num",              szType));
					Str_Cpy(m_stUsedata.INST_PLACE_NUM  , JSON_GetValue (g_pjcomm, "inst_place_num",      szType));
					
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					//Str_Cpy(szMsg      , JSON_GetValue (g_pjcomm, "birth_date",          szType));
					//Str_Cpy(szMsg, "19");
					Str_Cat(szMsg      , JSON_GetValue (g_pjcomm, "soc_num",          szType));
					Mem_Cpy((byte *)m_stUsedata.SOC_NUM, (byte *)szMsg, 6);
					Str_Chg(m_stUsedata.SOC_NUM, STRCHG_DEL_NONDIGIT);
					//Mem_Cpy((byte *)m_stUsedata.BIRTH_DATE_YEAR, (byte *)szMsg, 4);
					//Mem_Cpy((byte *)m_stUsedata.BIRTH_DATE_MONTH, (byte *)szMsg+4, 2);
					//Mem_Cpy((byte *)m_stUsedata.BIRTH_DATE_DAY, (byte *)szMsg+6, 2);
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> szMsg : %s",szMsg,0,0);

					Str_Cpy(m_stUsedata.GENDER          , JSON_GetValue (g_pjcomm, "gender",              szType));
					
					Str_Cpy(m_stUsedata.SAFE_KEY        , JSON_GetValue (g_pjcomm, "safe_key",            szType));
					Str_Chg(m_stUsedata.SAFE_KEY, STRCHG_DEL_ALL_SPACE);
					Str_Cpy(m_stCancelData.SAFE_KEY , m_stUsedata.SAFE_KEY);
	
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					Str_Cpy(szMsg , JSON_GetValue (g_pjcomm, "new_addr_union",     szType));
					SQL_ConvMbStr( m_stUsedata.NEW_ADDR_UNION, szMsg);
					
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					Str_Cpy(szMsg , JSON_GetValue (g_pjcomm, "curr_addr_union",     szType));
					SQL_ConvMbStr( m_stUsedata.CURR_ADDR_UNION, szMsg);
					//Str_Cpy(m_stUsedata.CURR_ADDR_UNION , JSON_GetValue (g_pjcomm, "curr_addr_union",     szType));
					
					Str_Cpy(m_stUsedata.LMS_TEL_DDD     , JSON_GetValue (g_pjcomm, "lms_tel_ddd",         szType));
					Str_Cpy(m_stUsedata.LMS_TEL_EXN     , JSON_GetValue (g_pjcomm, "lms_tel_exn",         szType));
					Str_Cpy(m_stUsedata.LMS_TEL_NUM     , JSON_GetValue (g_pjcomm, "lms_tel_num",         szType));
					Str_Cpy(m_stCancelData.LMS_TEL_DDD  , m_stUsedata.LMS_TEL_DDD);
					Str_Cpy(m_stCancelData.LMS_TEL_EXN  , m_stUsedata.LMS_TEL_EXN);
					Str_Cpy(m_stCancelData.LMS_TEL_NUM  , m_stUsedata.LMS_TEL_NUM);
	
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					Str_Cpy(szMsg  , JSON_GetValue (g_pjcomm, "email_req_addr",      szType));
					Str_Cpy(m_stCancelData.EMAIL_REQ_ADDR  , szMsg);
					if( Str_Cmp(szMsg, "null") == 0 || Str_Cmp(szMsg, "nullnull") == 0 || Str_Cmp(szMsg, "") == 0 )
					{
						Str_Cpy(m_stUsedata.EMAIL_REQ_ID  , "");
						Str_Cpy(m_stUsedata.EMAIL_REQ_ADDR  , "");
						Str_Cpy(m_stCancelData.EMAIL_REQ_ADDR  , "");
					}
					else
					{
						length = Str_Len(szMsg);
						if( length > 0 )
						{
							for( i=0 ; length ; i++)
							{
								if(szMsg[i] == '@')
								{
									len = i;
									break;
								}
								else if(szMsg[i] == '')
								{
									k++;
									break;
								}
							}
			
							Mem_Cpy((byte *)m_stUsedata.EMAIL_REQ_ID, (byte *)szMsg, len);
							Mem_Cpy((byte *)m_stUsedata.EMAIL_REQ_ADDR, (byte *)szMsg+(len+1), length-(len+1));
						}
					}
	
					Str_Cpy(m_stUsedata.BILING_METHOD   , JSON_GetValue (g_pjcomm, "biling_method",       szType));
					Str_Cpy(m_stUsedata.PAYMENT_METHOD  , JSON_GetValue (g_pjcomm, "payment_method",      szType));

					//���ι�� ( 10 : �����ڵ���ü, 20 : ī���ڵ���ü, NULL : ���� )
					if( Str_Cmp(m_stUsedata.PAYMENT_METHOD, "20") == 0 )
					{
						Str_Cpy(m_stCancelData.PAYMENT_METHOD, "10");
						
					}
					else if( Str_Cmp(m_stUsedata.PAYMENT_METHOD, "30") == 0 )
					{
						Str_Cpy(m_stCancelData.PAYMENT_METHOD, "20");
					}
					else
					{
						Str_Cpy(m_stCancelData.PAYMENT_METHOD, "");
					}
					
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					Str_Cpy(szMsg , JSON_GetValue (g_pjcomm, "cust_nm",     szType));
					SQL_ConvMbStr( m_stUsedata.CUST_NM, szMsg);
					
					ret = 0;
					szitem =JSON_GetValue(g_pjcomm, "item", szType);
					if(szitem != NULL)
					{
						if( Str_Len(szitem) > 0 )
						{
							hitem = JSON_Create( JSON_Array );
							if( hitem != NULL)
							{
								JSON_toJson(hitem, szitem ) ;
								ret = JSON_GetArrayCount( hitem );
	
								if( ret > 0 )
								{
									//�ڵ���ü ����
									Str_Cpy(m_stUsedata.BNK_CD              , JSON_GetValue (hitem, "bnk_cd",                szType));
									Str_Cpy(m_stCancelData.BNK_CD , m_stUsedata.BNK_CD);
									
									Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
									Str_Cpy(szMsg , JSON_GetValue (hitem, "bnk_branch_nm",     szType));
									SQL_ConvMbStr( m_stUsedata.BNK_BRANCH_NM, szMsg);
									
									Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
									Str_Cpy(szMsg , JSON_GetValue (hitem, "depositor_nm",     szType));
									SQL_ConvMbStr( m_stUsedata.DEPOSITOR_NM, szMsg);
									Str_Cpy(m_stCancelData.DEPOSITOR_NM , m_stUsedata.DEPOSITOR_NM);
									
									Str_Cpy(m_stUsedata.DEPOSITOR_TEL_DDD   , JSON_GetValue (hitem, "depositor_tel_ddd",     szType));
									Str_Cpy(m_stUsedata.DEPOSITOR_TEL_EXN   , JSON_GetValue (hitem, "depositor_tel_exn",     szType));
									Str_Cpy(m_stUsedata.DEPOSITOR_TEL_NUM   , JSON_GetValue (hitem, "depositor_tel_num",     szType));
									
									Str_Cpy(m_stUsedata.DEFRAY_ACCOUNT_NUM  , JSON_GetValue (hitem, "defray_account_num",    szType));
									Str_Cpy(m_stCancelData.DEFRAY_ACCOUNT_NUM , m_stUsedata.DEFRAY_ACCOUNT_NUM);
									
									Str_Cpy(m_stUsedata.DEPOSITOR_BIRTH_DATE, JSON_GetValue (hitem, "depositor_birth_date",  szType));
									Str_Cpy(m_stCancelData.DEPOSITOR_BIRTH_DATE , m_stUsedata.DEPOSITOR_BIRTH_DATE);
									
									Str_Cpy(m_stUsedata.DEPOSITOR_RELAT_CD  , JSON_GetValue (hitem, "depositor_relat_cd",    szType));
									Str_Cpy(m_stCancelData.DEPOSITOR_RELAT_CD , m_stUsedata.DEPOSITOR_RELAT_CD);
									//Str_Cpy(m_stUsedata.CUST_RELAT_CD       , JSON_GetValue (hitem, "cust_relat_cd",         szType));
	
									Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
									Str_Cpy(szMsg , JSON_GetValue (hitem, "req_nm",     szType));
									SQL_ConvMbStr( m_stUsedata.REQ_NM, szMsg);
									//Str_Cpy(m_stUsedata.REQ_NM              , JSON_GetValue (hitem, "req_nm",                szType));
	
									Str_Cpy(m_stUsedata.REQ_TEL_DDD         , JSON_GetValue (hitem, "req_tel_ddd",           szType));
									Str_Cpy(m_stUsedata.REQ_TEL_EXN         , JSON_GetValue (hitem, "req_tel_exn",           szType));
									Str_Cpy(m_stUsedata.REQ_TEL_NUM         , JSON_GetValue (hitem, "req_tel_num",           szType));
									
									//PRINT("JSON_toString(hitem) : %s",JSON_toString(hitem),0,0);
								}
	
								JSON_Finalize(hitem);
								hitem = NULL;
							}
						}
					}
				}
			}
		}
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
	

//------------------------------------------------------------------------------------------
	void OzView(void)
	{
		handle hHeader = NULL;
		handle h = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		PRINT("OzView start", 0, 0, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);

		h = JSON_Create( JSON_Object );
		if (h)
		{
			hHeader = JSON_Create( JSON_Object );
			if(hHeader == NULL)
			{
				goto Finally;
			}
			
			m_hBody = JSON_Create( JSON_Object );
			if(m_hBody == NULL)
			{
				goto Finally;
			}
			
			SetMessageBoxText("20 % ó����...");

			//���� �� Body �� ����
			SetJsonBody(sql);
//PRINT("JSON_toString(m_hBody) : %s",JSON_toString(m_hBody),0,0);

			//�ڵ���ü ���� ������(����ȣ, ����,ī�� �ڵ�)
			SetJsonArray_Bank(sql);
			
			SetMessageBoxText("90 % ó����...");
			
			SetJsonArray_Payment();
			
			JSON_SetValue( m_hBody, 'C', "cust_num",     m_stUsedata.CUST_NUM );
//PRINT("JSON_toString(m_hBody) : %s",JSON_toString(m_hBody),0,0);

			SetMessageBoxText("100 % �Ϸ�.");

			//��������Ȯ�༭ �� ���볳��Ȯ�༭ ������Ǽ� ����
			//JSON_SetValue( m_hBody, 'C', "detail1",     "<body> <div id='content' style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <div id ='con_header' style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <table class='list_th'> <thead> <tr> <th>�������� ���� �� �̿� ���� [�ʼ�]</th> </tr> </thead> </table> </div> <div id='con_container'> <div id='con_table'> <table class='list_td' style='width:100%;margin: 10px;'> <thead style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <tr> <th>�������̿��Ϸ��� ���������� �׸�</th> </tr> </thead> <tbody style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <tr class='current'> <td>- �������� : ����, �������, ����,<br> ��ȭ��ȣ, �޴�����ȣ, �ּ�, �̸���<br> - �ڵ���ü��û �� : ����, �������, �����,<br> ���¹�ȣ, ��ȭ��ȣ(�ڵ���ü ��û �븮��)<br> ����, ��ȭ��ȣ<br> - ������(�Ӵ���� �Ǵ� ������) : ����,<br> ��ȭ��ȣ, �޴��� </td> </tr> </tbody> </table> <table class='list_td' style='width:100%;margin: 10px;'> <thead style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <tr> <th>�������̿��Ϸ��� ���������� �׸�</th> </tr> </thead> <tbody style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <tr class='current'> <td>���ð��� ����(���� ���, ����, ����)��<br> �� ��ݰ���<br> (�����, ����, LMSû��) �� LMS�����ȳ�,��<br> �� �� �߽ɰ���,<br> �������� ���� �� SMS�����ȳ�, �跮�� ��ü<br> ����, �޴�������<br> �ο�ó�� �� ���Ȯ��, LMS��ݹ̳��ȳ�,  ��<br> ������ ���� �� </td> </tr> </tbody> </table> <table class='list_td' style='width:100%;margin: 10px;'> <thead style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <tr> <th>�������� ���� �� �̿�Ⱓ</th> </tr> </thead> <tbody style='outline-style: groove;outline-width: thin;outline-color: #bcbcbc;'> <tr class='current'> <td>����� ���� �� 5��</td> </tr> </tbody> </table> </div> </div> </div> </body>" );
			//JSON_SetValue( m_hBody, 'C', "detail1",     "<div class='content' style = 'border: 2px solid #bbbbbb; width : 100%; height : 100%; overflow-x: auto;' > <div class ='con_header'> <table class='list_table_h'> <thead> <tr> <th style='text-align: left;'> <p>�������� ���� �� �̿� ���� [�ʼ�]</p> </th> </tr> </thead> </table> </div> <div class='con_container'> <table class='list_table_f'> <thead> <tr> <th class='list_th'> <p>�������̿��Ϸ��� ���������� �׸�</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>- �������� : ����, �������, ����, ��ȭ��ȣ, �޴�����ȣ, �ּ�, �̸���</p> <p>- �ڵ���ü��û �� : ����, �������, �����, ���¹�ȣ, ��ȭ��ȣ</p> <p>&nbsp;&nbsp;(�ڵ���ü ��û �븮��) ����, ��ȭ��ȣ</p> <p>- ������(�Ӵ���� �Ǵ� ������) : ����, ��ȭ��ȣ, �޴���</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <thead> <tr> <th class='list_th'> <p>�������̿��Ϸ��� ���������� �׸�</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>���ð��� ����(���� ���, ����, ����)����, ��ݰ���</p> <p>(�����, ����, LMSû��) �� LMS�����ȳ�, ���� �� �߽ɰ���,</p> <p>�������� ���� �� SMS�����ȳ�, �跮�� ��ü����, �޴�������</p> <p>�ο�ó�� �� ���Ȯ��, LMS��ݹ̳��ȳ�, �ΰ����� ���� ��</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <thead> <tr> <th class='list_th'> <p>�������� ���� �� �̿�Ⱓ</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>����� ���� �� 5��</p> </td> </tr> </tbody> </table> </div> </div>");
			JSON_SetValue( m_hBody, 'C', "detail1",     "�������� ���� �� �̿� ���� [�ʼ�]<br><br> 1.�������̿��Ϸ��� ���������� �׸�<br> - �������� : ����, �������, ����, ��ȭ��ȣ, �޴�����ȣ, �ּ�, �̸���<br> - �ڵ���ü��û �� : ����, �������, �����, ���¹�ȣ, ��ȭ��ȣ(�ڵ���ü ��û �븮��) ����, ��ȭ��ȣ<br> - ������(�Ӵ���� �Ǵ� ������) : ����, ��ȭ��ȣ, �޴���<br> 2.�������̿��Ϸ��� ���������� �׸�<br> - ���ð��� ����(���� ���, ����, ����)����, ��ݰ���(�����, ����, LMSû��) �� LMS�����ȳ�, ���� �� �߽ɰ���,�������� ���� �� SMS�����ȳ�, �跮�� ��ü����, �޴������� �ο�ó�� �� ���Ȯ��, LMS��ݹ̳��ȳ�, �ΰ����� ���� ��<br> 3.�������� ���� �� �̿�Ⱓ<br> - ����� ���� �� 5��" );
			JSON_SetValue( m_hBody, 'C', "detail2",     "����(�ſ�)���� ���� ���� [�ʼ�]<br><br> 1.���������� �����޴���<br> - NICE������(��)<br> 2.�����޴� ���������� �׸�<br> - ��������ȣ, ����, ����ó, �������, ����, ��ü����<br> 3.���������� �����޴����� �������� �̿����<br> - ��������ȣ�߱�, �ſ�������ȸ, ä�������� ���<br> 4.���������� �����޴����� �������� ���� �� �̿�Ⱓ<br> - �̿���� �Ⱓ��<br>�� ��3�ڿ� ���� �ſ�������ȸ ������ �������� ������ <�������� ��3�� ����>�� ������ �� �ƴ϶� <����(�ſ�)���� ��ȸ>���� �����ϴ� ��쿡�� �̷�����ϴ�." );
			JSON_SetValue( m_hBody, 'C', "detail3",     "����(�ſ�)���� ��ȸ ���� [�ʼ�]<br><br> 1.�ſ���ȸȸ��<br> - NICE��������<br> 2.��ȸ ��� ����<br> - ��������, �ſ뵵�Ǵ�����(��ü, �ε�, ������������), ��������, �ſ���, ��Ű���<br> 3.��ȸ ����<br> - Ȯ�༭ ü�� �� �����Ǵܿ���, ��ü����, ���Žɻ�<br> 4.��ȸ ������ ȿ�±Ⱓ<br> - ���ǽ������� ��� ���� �ñ���<br> �غ� ��ȸ ���ǿ� ���� ��ȸ ����� �ſ��޿� ������ ���� �ʽ��ϴ�." );
			JSON_SetValue( m_hBody, 'C', "detail4",     "�����ĺ����� ���� �� �����޴� ���� [����]<br><br> 1.�����ĺ������� �����ϴ���<br> - NICE��������, ���ﵵ�ð���<br> 2.�����ĺ������� �����޴���<br> - ���ﵵ�ð���, NICE��������<br> 3.������������ �����ĺ������� �׸�<br> - ��ü���� �ֹε�Ϲ�ȣ �� �ܱ��� ��Ϲ�ȣ<br> 4.�����ĺ������� �����޴����� �����ĺ����� �̿����<br> - �̳������ ȸ�� �� ä���߽ɾ���<br> 5.�����ĺ������� �����޴����� �����ĺ����� ���� �� �̿�Ⱓ<br> - �̿���� �Ⱓ��<br> �ذ�������ó�� ��Ź�� �� �ڼ��� ������ ���ﵵ�ð��� Ȩ������(www.seoulgas.co.kr)�� �����ȡ���������ó����ħ���� �����Ͻñ� �ٶ��ϴ�." );
			
			//JSON_SetValue( m_hBody, 'C', "detail1",     "<html> <head> <style type='text/css'> p { margin: 0px; } body { overflow: hidden; } .content { border: 2px solid #bcbcbc; width : 100%; height : 100%; overflow-x: auto; } .con_header { border-bottom: 2px solid #bcbcbc; width : 100%; height : 37px; } .list_table_h { width: 100%; padding: 5px; top : 14px; } .list_table_f { width: 100%; padding: 8px; } .list_table_m { width: 100%; padding: 0px 8px 8px 8px; } .list_th { border: 1px solid #bcbcbc; text-align : left; background-color: #bcbcbc; } .list_td { border: 1px solid #bcbcbc; } </style> </head> <body> <div class='content'> <div class ='con_header'> <table class='list_table_h'> <thead> <tr> <th style='text-align: left;'> <p>�������� ���� �� �̿� ���� [�ʼ�]</p> </th> </tr> </thead> </table> </div> <div class='con_container'> <table class='list_table_f'> <thead> <tr> <th class='list_th'> <p>�������̿��Ϸ��� ���������� �׸�</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>- �������� : ����, �������, ����, ��ȭ��ȣ, �޴�����ȣ, �ּ�, �̸���</p> <p>- �ڵ���ü��û �� : ����, �������, �����, ���¹�ȣ, ��ȭ��ȣ</p> <p>&nbsp;&nbsp;(�ڵ���ü ��û �븮��) ����, ��ȭ��ȣ</p> <p>- ������(�Ӵ���� �Ǵ� ������) : ����, ��ȭ��ȣ, �޴���</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <thead> <tr> <th class='list_th'> <p>�������̿��Ϸ��� ���������� �׸�</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>���ð��� ����(���� ���, ����, ����)����, ��ݰ���</p> <p>(�����, ����, LMSû��) �� LMS�����ȳ�, ���� �� �߽ɰ���,</p> <p>�������� ���� �� SMS�����ȳ�, �跮�� ��ü����, �޴�������</p> <p>�ο�ó�� �� ���Ȯ��, LMS��ݹ̳��ȳ�, �ΰ����� ���� ��</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <thead> <tr> <th class='list_th'> <p>�������� ���� �� �̿�Ⱓ</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>����� ���� �� 5��</p> </td> </tr> </tbody> </table> </div> </div> </body> </html>");
			//JSON_SetValue( m_hBody, 'C', "detail2",     "<html> <head> <style type='text/css'> p { margin: 0px; } body { overflow: hidden; } .content { border: 2px solid #bcbcbc; width : 100%; height : 100%; overflow-x: auto; } .con_header { border-bottom: 2px solid #bcbcbc; width : 100%; height : 37px; } .list_table_h { width: 100%; padding: 5px; top : 14px; } .list_table_f { width: 100%; padding: 8px; } .list_table_m { width: 100%; padding: 0px 8px 8px 8px; } .list_th { border: 1px solid #bcbcbc; text-align : left; background-color: #bcbcbc; } .list_td { border: 1px solid #bcbcbc; } </style> </head> <body> <div class='content'> <div class ='con_header'> <table class='list_table_h' style='padding : 5px; top : 14px;'> <thead> <tr> <th style='text-align: left;'> <p>����(�ſ�)���� ���� ���� [�ʼ�]</p> </th> </tr> </thead> </table> </div> <div class='con_container'> <table class='list_table_f'> <thead> <tr> <th class='list_th'> <p>���������� �����޴���</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>NICE������(��)</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>�����޴� ���������� �׸�</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>��������ȣ, ����, ����ó, �������, ����, ��ü����</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>���������� �����޴����� �������� �̿����</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>��������ȣ�߱�, �ſ�������ȸ, ä�������� ���</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>���������� �����޴����� �������� ���� �� �̿�Ⱓ</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>�̿���� �Ⱓ��</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <td class='list_memo'> <p>�� ��3�ڿ� ���� �ſ�������ȸ ������ �������� ������</p> <p>&nbsp;&nbsp;<�������� ��3�� ����>�� ������ �� �ƴ϶�</p> <p>&nbsp;&nbsp;<����(�ſ�)���� ��ȸ>���� �����ϴ� ��쿡��</p> <p>&nbsp;&nbsp;�̷�����ϴ�.</p> </td> </tr> </tbody> </table> </div> </div> </body> </html> " );
			//JSON_SetValue( m_hBody, 'C', "detail3",     "<html> <head> <style type='text/css'> p { margin: 0px; } body { overflow: hidden; } .content { border: 2px solid #bcbcbc; width : 100%; height : 100%; overflow-x: auto; } .con_header { border-bottom: 2px solid #bcbcbc; width : 100%; height : 37px; } .list_table_h { width: 100%; padding: 5px; top : 14px; } .list_table_f { width: 100%; padding: 8px; } .list_table_m { width: 100%; padding: 0px 8px 8px 8px; } .list_th { border: 1px solid #bcbcbc; text-align : left; background-color: #bcbcbc; } .list_td { border: 1px solid #bcbcbc; } </style> </head> <body> <div class='content'> <div class ='con_header'> <table class='list_table_h' style='padding : 5px; top : 14px;'> <thead> <tr> <th style='text-align: left;'> <p>����(�ſ�)���� ��ȸ ���� [����]</p> </th> </tr> </thead> </table> </div> <div class='con_container'> <table class='list_table_f'> <thead> <tr> <th class='list_th'> <p>�ſ���ȸȸ��</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>NICE������(��)</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>��ȸ ��� ����</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>��������, �ſ뵵�Ǵ�����(��ü, �ε�, ������������), ��������, �ſ���, ��Ű���</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>��ȸ ����</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>����� ü�� �� �����Ǵܿ���, ��ü����, ���Žɻ�</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>��ȸ ������ ȿ�±Ⱓ</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>���ǽ������� ��� ���� �ñ���</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <td class='list_memo'> <p>�� �� ��ȸ ���ǿ� ���� ��ȸ ����� �ſ��޿� ������ ���� �ʽ��ϴ�.</p> </td> </tr> </tbody> </table> </div> </div> </body> </html> " );
			//JSON_SetValue( m_hBody, 'C', "detail4",     "<html> <head> <style type='text/css'> p { margin: 0px; } body { overflow: hidden; } .content { border: 2px solid #bcbcbc; width : 100%; height : 100%; overflow-x: auto; } .con_header { border-bottom: 2px solid #bcbcbc; width : 100%; height : 37px; } .list_table_h { width: 100%; padding: 5px; top : 14px; } .list_table_f { width: 100%; padding: 8px; } .list_table_m { width: 100%; padding: 0px 8px 8px 8px; } .list_th { border: 1px solid #bcbcbc; text-align : left; background-color: #bcbcbc; } .list_td { border: 1px solid #bcbcbc; } </style> </head> <body> <div class='content'> <div class ='con_header'> <table class='list_table_h' style='padding : 5px; top : 14px;'> <thead> <tr> <th style='text-align: left;'> <p>�����ĺ����� ���� �� �����޴� ���� [����]</p> </th> </tr> </thead> </table> </div> <div class='con_container'> <table class='list_table_f'> <thead> <tr> <th class='list_th'> <p>�����ĺ������� �����ϴ���</p> </th> <th class='list_th'> <p>�����ĺ������� �����޴���</p> </th> </tr> </thead> <tbody> <tr> <td class='list_td'> <p>NICE������(��)</p> </td> <td class='list_td'> <p>���ﵵ�ð���</p> </td> </tr> <tr> <td class='list_td'> <p>���ﵵ�ð���</p> </td> <td class='list_td'> <p>NICE������(��)</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>������������ �����ĺ������� �׸�</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>��ü���� �ֹε�Ϲ�ȣ �� �ܱ��� ��Ϲ�ȣ</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>�����ĺ������� �����޴����� �����ĺ����� �̿����</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>�̳������ ȸ�� �� ä���߽ɾ���</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <th class='list_th'> <p>�����ĺ������� �����޴����ǰ����ĺ����� ���� �� �̿�Ⱓ</p> </th> </tr> </tbody> <tbody> <tr> <td class='list_td'> <p>�̿���� �Ⱓ��</p> </td> </tr> </tbody> </table> <table class='list_table_m'> <tbody> <tr> <td class='list_memo'> <p>�� ��������ó�� ��Ź�� �� �ڼ��� ������</p> <p>&nbsp;&nbsp;���ﵵ�ð��� Ȩ������(www.seoulgas.co.kr)�� ������</p> <p>&nbsp;&nbsp;'��������ó����ħ'�� �����Ͻñ� �ٶ��ϴ�.</p> </td> </tr> </tbody> </table> </div> </div> </body> </html> " );
			
			//�ּ� �Է� ȭ�� �⺻ ������
			JSON_SetValue( m_hBody, 'C', "url",          GET_URL(WAS_BASE_URL) );
			JSON_SetValue( m_hBody, 'C', "clientid",     stUserinfo.szpda_ip );
			JSON_SetValue( m_hBody, 'C', "userid",       stUserinfo.szemployee_id );
			JSON_SetValue( m_hBody, 'C', "workcd",       stUserinfo.szworkcd );
			JSON_SetValue( m_hBody, 'C', "vmversion",    stUserinfo.szver_num );
			JSON_SetValue( m_hBody, 'C', "appversion",   stUserinfo.szappversion );

			//��� �Է�
			//����༭ �� �ڵ�(00001)
			JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00001");
			JSON_SetValue	(hHeader	, 'C', "Ozserver"			, GET_URL(OZ_BASE_URL));
			
			JSON_Attach 	(hHeader		 , "Paramdata"			, m_hBody);
			
			//�ý����� ��û
			// { "method" : "�ý����� �Ž���", "data" : "json object ��Ʈ��" }
			JSON_SetValue	(h, 'C', "method", "OzViewActivity");
			JSON_Attach 	(h, "data", hHeader);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		DelSqLite(sql);
		PRINT("OzView DelSqLite", 0, 0, 0);
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hHeader)
		{
			JSON_Finalize(hHeader);
		}
			
		if (m_hBody)
		{
			JSON_Finalize(m_hBody);
		}	

		g_Close_SubDlg();
		return;
	}

	
//------------------------------------------------------------------------------------------
	void SetJsonBody(SQLITE sql)
	{
		long i = 0, j = 0;
		long lAllAmt = 0;
		char szUseHpNum[20];
		char szUseTelNum[20];
		char szTemlNum[20];
		char szNumber[5];
		char szpmCost[50];
		char szTmp[256];
		char szComboData[700];

		//��༭ �ۼ����� > 1(���Թο�), 2(��������), 3(���Ǻ���)
		//long m_lDocFlag = 0;	//�������� = 2, ���Ǻ��� = 3 flag
		if( m_lDocFlag == 2 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "2");
		}
		else if( m_lDocFlag == 3 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "3");
		}
		else if( m_lDocFlag == 4 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "4");
		}
	
		//�ٵ� - ��������
		JSON_SetValue	(m_hBody	, 'C', "pmUsecontnum"		, m_stUsedata.INST_PLACE_NUM);  //<<--��ġ��ҹ�ȣ!!
		
		if( m_lDocFlag == 4 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmCustnum"			, ""); 	//<<--������ȣ!!
		}
		else
		{
			JSON_SetValue	(m_hBody	, 'C', "pmCustnum"			, m_stUsedata.USE_CONT_NUM); 	//<<--������ȣ!!
		}
		
		if( m_stUsedata.CUST_NUM[0] == '0' || m_lDocFlag == 4 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmName"			    , "");
			JSON_SetValue	(m_hBody	, 'C', "pmBirthdate"		, "");
			JSON_SetValue	(m_hBody	, 'C', "pmSex"				, "");
		}
		else
		{
			JSON_SetValue	(m_hBody	, 'C', "pmName"			    , m_stUsedata.CUST_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmBirthdate"		, m_stUsedata.SOC_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmSex"				, m_stUsedata.GENDER);
		}
		
		if( Str_Len(m_stUsedata.SAFE_KEY) > 0 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmSafekey"		    , "Y");
		}
		else
		{
			JSON_SetValue	(m_hBody	, 'C', "pmSafekey"		    , "");
		}
		
		if( Str_Len(m_stUsedata.NEW_ADDR_UNION) > 10 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmAddr"		, m_stUsedata.NEW_ADDR_UNION);
		}
		else
		{
			JSON_SetValue	(m_hBody	, 'C', "pmAddr"		, m_stUsedata.CURR_ADDR_UNION);
		}

		//��ȭ��ȣ �޺��ڽ� ��
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		SPRINT(szTmp," CODE_ID = 'A10110' AND C_VALUE = '2' ORDER BY SORT_ORDER ",0,0,0);
		JSON_SetValue	(m_hBody	, 'C', "pmTelcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));

		if( m_stUsedata.CUST_NUM[0] == '0' || m_lDocFlag == 4  )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , "");
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , "");
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , "");
		}
		else
		{
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stUsedata.OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stUsedata.OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stUsedata.OWNHOUSE_TEL_NUM);
		}

		SetMessageBoxText("30 % ó����...");
		
		//�޴��� �޺��ڽ� ��
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		SPRINT(szTmp," CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER",0,0,0);
		JSON_SetValue	(m_hBody	, 'C', "pmPhonecombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));

		if( m_stUsedata.CUST_NUM[0] == '0' || m_lDocFlag == 4 )
		{
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, "");
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, "");
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, "");
		}
		else
		{
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stUsedata.CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stUsedata.CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stUsedata.CP_NUM);
		}

		if( m_lDocFlag == 3 || m_lDocFlag == 4 )
		{
				JSON_SetValue	(m_hBody	, 'C', "pmBilling"			, "");
				
				JSON_SetValue	(m_hBody	, 'C', "pmLms1"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms2"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms3"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail1"			, "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail2"			, "");
		}
		else
		{
			if( Str_Cmp(m_stUsedata.BILING_METHOD, "70") == 0 )
			{
				JSON_SetValue	(m_hBody	, 'C', "pmBilling"			, "LMS");
	
				JSON_SetValue	(m_hBody	, 'C', "pmLms1"			    , m_stUsedata.LMS_TEL_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmLms2"			    , m_stUsedata.LMS_TEL_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmLms3"			    , m_stUsedata.LMS_TEL_NUM);
				JSON_SetValue	(m_hBody	, 'C', "pmEmail1"			, "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail2"			, "");
			}
			else if( Str_Cmp(m_stUsedata.BILING_METHOD, "40") == 0 )
			{
				JSON_SetValue	(m_hBody	, 'C', "pmBilling"			, "E-mail");
	
				JSON_SetValue	(m_hBody	, 'C', "pmLms1"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms2"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms3"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail1"			, m_stUsedata.EMAIL_REQ_ID);
				JSON_SetValue	(m_hBody	, 'C', "pmEmail2"			, m_stUsedata.EMAIL_REQ_ADDR);
			}
			else if ( Str_Cmp(m_stUsedata.BILING_METHOD, "10") == 0 )
			{
				JSON_SetValue	(m_hBody	, 'C', "pmBilling"			, "������");

				JSON_SetValue	(m_hBody	, 'C', "pmLms1"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms2"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms3"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail1"			, "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail2"			, "");
			}
			else
			{
				JSON_SetValue	(m_hBody	, 'C', "pmBilling"			, "");
				
				JSON_SetValue	(m_hBody	, 'C', "pmLms1"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms2"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmLms3"			    , "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail1"			, "");
				JSON_SetValue	(m_hBody	, 'C', "pmEmail2"			, "");
			}
		}
		
		SetMessageBoxText("40 % ó����...");

		//�̸��� �ּ� , @�� ���� �Ѱܾ���
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		SPRINT(szTmp," CODE_ID = 'A10140' ",0,0,0);
		JSON_SetValue	(m_hBody	, 'C', "pmEmailcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));
		
		SetMessageBoxText("50 % ó����...");

		//pmBankapply -> �ڵ���ü ��û, �̽�û ����� ���� (Y,N)
		//���ι�� ( 10 : �����ڵ���ü, 20 : ī���ڵ���ü, NULL : ���� )
		if(m_lDocFlag == 4)
		{
			JSON_SetValue	(m_hBody	, 'C', "pmBankapply"		, "N");
			JSON_SetValue	(m_hBody	, 'C', "pmBanktitle"		, "");
		}
		else
		{
			if( Str_Cmp(m_stUsedata.PAYMENT_METHOD, "20") == 0 )
			{
				JSON_SetValue	(m_hBody	, 'C', "pmBankapply"		, "Y");
				JSON_SetValue	(m_hBody	, 'C', "pmBanktitle"		, "����");
				
			}
			else if( Str_Cmp(m_stUsedata.PAYMENT_METHOD, "30") == 0 )
			{
				JSON_SetValue	(m_hBody	, 'C', "pmBankapply"		, "Y");
				JSON_SetValue	(m_hBody	, 'C', "pmBanktitle"		, "ī��");
			}
			else
			{
				JSON_SetValue	(m_hBody	, 'C', "pmBankapply"		, "N");
				JSON_SetValue	(m_hBody	, 'C', "pmBanktitle"		, "");
			}
		}
		
		//���� �޺�
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		SPRINT(szTmp," CODE_ID = 'C61999' ",0,0,0);
		JSON_SetValue	(m_hBody	, 'C', "pmBankcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));

		SetMessageBoxText("60 % ó����...");
		
		//ī�� �޺�
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		SPRINT(szTmp," CODE_ID = 'C61998' ",0,0,0);
		JSON_SetValue	(m_hBody	, 'C', "pmCardcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));
		
		SetMessageBoxText("70 % ó����...");
		
		//PRINT("70 Per m_stUsedata.BNK_BRANCH_NM:[%s]", m_stUsedata.BNK_BRANCH_NM, 0, 0);
		JSON_SetValue	(m_hBody	, 'C', "pmBank"				, m_stUsedata.BNK_BRANCH_NM);
		JSON_SetValue	(m_hBody	, 'C', "pmAcc"				, m_stUsedata.DEFRAY_ACCOUNT_NUM);
		JSON_SetValue	(m_hBody	, 'C', "pmAccname"			, m_stUsedata.DEPOSITOR_NM);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		if( Str_Len(m_stUsedata.DEPOSITOR_BIRTH_DATE) == 13 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)m_stUsedata.DEPOSITOR_BIRTH_DATE, 6);
		}
		else
		{
			Str_Cpy(szTmp, m_stUsedata.DEPOSITOR_BIRTH_DATE);
		}
		
		JSON_SetValue	(m_hBody	, 'C', "pmAccbirthdate"		, szTmp);
		
		JSON_SetValue	(m_hBody	, 'C', "pmAccphone1"		, m_stUsedata.DEPOSITOR_TEL_DDD);
		JSON_SetValue	(m_hBody	, 'C', "pmAccphone2"		, m_stUsedata.DEPOSITOR_TEL_EXN);
		JSON_SetValue	(m_hBody	, 'C', "pmAccphone3"		, m_stUsedata.DEPOSITOR_TEL_NUM);

		//�����ڿ� ���� �޺��ڽ� ��
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		SPRINT(szTmp," CODE_ID = 'C10004' ",0,0,0);
		JSON_SetValue	(m_hBody	, 'C', "pmAccrelationcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		SPRINT(szTmp," CODE_ID = 'C10004' AND CODE_ITEM = '%s'",m_stUsedata.DEPOSITOR_RELAT_CD,0,0);
		JSON_SetValue	(m_hBody	, 'C', "pmAccrelation"		, g_SetOzComboData(sql, szTmp, szComboData, 0));
		
		SetMessageBoxText("80 % ó����...");
		
		JSON_SetValue	(m_hBody	, 'C', "pmAgentname"		, m_stUsedata.REQ_NM);
		JSON_SetValue	(m_hBody	, 'C', "pmAgentphone1"		, m_stUsedata.REQ_TEL_DDD);
		JSON_SetValue	(m_hBody	, 'C', "pmAgentphone2"		, m_stUsedata.REQ_TEL_EXN);
		JSON_SetValue	(m_hBody	, 'C', "pmAgentphone3"		, m_stUsedata.REQ_TEL_NUM);

		JSON_SetValue	(m_hBody	, 'C', "pmCenter"				, stUserinfo.sznm_kor);

		return;
	}
	
//------------------------------------------------------------------
	void SetJsonArray_Bank(SQLITE sql)
	{
		long i = 0;
		long lCnt = 0;
		char szSql[256];
		char szTmp[128];
		char szRet_Cd[10];
		char szRet_Nm[128];
		handle hArray = NULL;
		bool sret = FALSE;
		handle hstmt = NULL;
		
		hArray = JSON_Create(JSON_Array);
		if( hArray == NULL  )
		{
			goto Finally;
		}
		
		//ī�� �޺� - 5��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' ORDER BY SORT_ORDER ", 0,  0, 0 );
		SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' ORDER BY SUBSTR(ITEM_KNAME,6,10)", 0,  0, 0 );
		
		PRINT("szSql:[%s]", szSql, 0, 0);
		hstmt = sql->CreateStatement( sql, szSql );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		sret = sql->Execute(sql);	
		if(sret == FALSE)
		{
			PRINT("::sql->Execute [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		//lCnt = 0;
		//g_Sql_RetInt("SELECT COUNT(*) FROM COMMONCODE WHERE CODE_ID = 'C61998'", &lCnt);
		
		//for( i = 0 ; i < lCnt ; i++ )
		while( sql->Next(sql) == TRUE )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			Mem_Set((byte*)szRet_Cd, 0x00, sizeof(szRet_Cd));	
			Mem_Set((byte*)szRet_Nm, 0x00, sizeof(szRet_Nm));	
			//SPRINT(szSql,"SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61998' LIMIT %d, 1",i,0,0);
			//g_Sql_RetStr(szSql, 10, szTmp);
			sql->GetValue( sql, 0, 'U', (long*)szTmp, sizeof(szTmp), DECRYPT );
			//PRINT("CM_USEDOC SetJsonArray_Bank 1 ITEM_KNAME:[%s]", szTmp, 0, 0);
			Mem_Cpy((byte *)szRet_Cd, (byte *)szTmp, 3);
			Mem_Cpy((byte *)szRet_Nm, (byte *)szTmp+5, Str_Len(szTmp)-5);

			JSON_AddArrayItem(hArray);
			JSON_SetArrayItem(hArray, 'C', "bnk_cd", szRet_Cd );
			JSON_SetArrayItem(hArray, 'C', "bnk_nm", szRet_Nm  );
		}
		
		sql->DeleteStatement(sql);
		
		//���� �޺� - 44��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' ORDER BY CAST(SORT_ORDER as int ) ASC ", 0,  0, 0 );
		PRINT("szSql:[%s]", szSql, 0, 0);
		hstmt = sql->CreateStatement( sql, szSql );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		sret = sql->Execute(sql);	
		if(sret == FALSE)
		{
			PRINT("::sql->Execute [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		//lCnt = 0;
		//g_Sql_RetInt("SELECT COUNT(*) FROM COMMONCODE WHERE CODE_ID = 'C61999'", &lCnt);
		
		//for( i=0 ; i < lCnt ; i++ )
		while( sql->Next(sql) == TRUE )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			Mem_Set((byte*)szRet_Cd, 0x00, sizeof(szRet_Cd));	
			Mem_Set((byte*)szRet_Nm, 0x00, sizeof(szRet_Nm));	
			//SPRINT(szSql,"SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C61999' LIMIT %d, 1",i,0,0);
			//g_Sql_RetStr(szSql, 10, szTmp);
			sql->GetValue( sql, 0, 'U', (long*)szTmp, sizeof(szTmp), DECRYPT );
			//PRINT("C6101_WINFO SetJsonArray_Bank 2 ITEM_KNAME:[%s]", szTmp, 0, 0);
			Mem_Cpy((byte *)szRet_Cd, (byte *)szTmp, 3);
			Mem_Cpy((byte *)szRet_Nm, (byte *)szTmp+5, Str_Len(szTmp)-5);

			JSON_AddArrayItem(hArray);
			JSON_SetArrayItem(hArray, 'C', "bnk_cd", szRet_Cd );
			JSON_SetArrayItem(hArray, 'C', "bnk_nm", szRet_Nm  );
		}

		JSON_Attach(m_hBody, "bnk_cd", hArray);

Finally:
	
		sql->DeleteStatement(sql);

		if (hArray)
		{
			JSON_Finalize(hArray);
		}	
		
		return;
	}
	
//------------------------------------------------------------------
	void SetJsonArray_Payment(void)
	{
		long i = 0;
		long lCnt = 0;
		char szSql[256];
		char szTmp[128];
		char szRet_Cd[10];
		char szRet_Nm[128];
		handle hArray = NULL;
		
		hArray = JSON_Create(JSON_Array);
		if( hArray == NULL  )
		{
			goto Finally;
		}
		
		JSON_AddArrayItem(hArray);
		JSON_SetArrayItem(hArray, 'C', "payment_cd", "10" );
		JSON_SetArrayItem(hArray, 'C', "payment_nm", "�����ڵ���ü"  );

		JSON_AddArrayItem(hArray);
		JSON_SetArrayItem(hArray, 'C', "payment_cd", "20" );
		JSON_SetArrayItem(hArray, 'C', "payment_nm", "ī���ڵ���ü"  );

		JSON_AddArrayItem(hArray);
		JSON_SetArrayItem(hArray, 'C', "payment_cd", "" );
		JSON_SetArrayItem(hArray, 'C', "payment_nm", "����"  );

		JSON_Attach(m_hBody, "payment_method", hArray);

Finally:

		if (hArray)
		{
			JSON_Finalize(hArray);
		}	
		
		return;
	}

//------------------------------------------------------------------
	long Snd_OzView(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		char* szfile;
		char* filedata;
		long nRet, filesize, fd;
		handle file;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822566, FALSE);

		if( m_lDocFlag == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "cust_num",              " "                            );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "cust_num",              m_stOzData.CUST_NUM            );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",              m_stOzData.USE_CONT_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd",                 m_stOzData.BRANCH_CD           );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",                 m_stOzData.CENTER_CD           );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",            m_stOzData.INST_PLACE_NUM      );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",                   szTmp                          );
//PRINT("m_stOzData.CUST_NM : %s ,, szTmp : %s",m_stOzData.CUST_NM,szTmp,0);
		JSON_SetValue( g_pjcomm, 'C', "chg_cust_type",             m_stOzData.CHG_CUST_TYPE       );
		JSON_SetValue( g_pjcomm, 'C', "data_col_type",             m_stOzData.DATA_COL_TYPE       );
		JSON_SetValue( g_pjcomm, 'C', "tran_flag",                 m_stOzData.TRAN_FLAG           );
		JSON_SetValue( g_pjcomm, 'C', "gender",                    m_stOzData.GENDER              );
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn",         m_stOzData.INFO_USE_AGREE_YN   );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn",               m_stOzData.INFO_USE_YN         );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn4",              m_stOzData.INFO_USE_YN4        );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn5",              m_stOzData.INFO_USE_YN5        );
		JSON_SetValue( g_pjcomm, 'C', "info_use_yn6",              m_stOzData.INFO_USE_YN6        );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.RMK );
		JSON_SetValue( g_pjcomm, 'C', "rmk",                       szTmp                          );
		
		//JSON_SetValue( g_pjcomm, 'C', "tran_req_ymd",              m_stOzData.TRAN_REQ_YMD        );
		JSON_SetValue( g_pjcomm, 'C', "trans_flag",                m_stOzData.TRANS_FLAG          );
		JSON_SetValue( g_pjcomm, 'C', "lms_tel_ddd",               m_stOzData.LMS_TEL_DDD         );
		JSON_SetValue( g_pjcomm, 'C', "lms_tel_exn",               m_stOzData.LMS_TEL_EXN         );
		JSON_SetValue( g_pjcomm, 'C', "lms_tel_num",               m_stOzData.LMS_TEL_NUM         );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.EMAIL_REQ_ADDR );
		JSON_SetValue( g_pjcomm, 'C', "email_req_addr",            szTmp                          );
		
		JSON_SetValue( g_pjcomm, 'C', "biling_method",             m_stOzData.BILING_METHOD       );
		JSON_SetValue( g_pjcomm, 'C', "payment_method",            m_stOzData.PAYMENT_METHOD      );
		JSON_SetValue( g_pjcomm, 'C', "pay_method_type",           m_stOzData.PAY_METHOD_TYPE     );
		JSON_SetValue( g_pjcomm, 'C', "bill_method_type",          m_stOzData.BILL_METHOD_TYPE    );
		JSON_SetValue( g_pjcomm, 'C', "bnk_cd",                    m_stOzData.BNK_CD              );
		
		//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		//SQL_ConvUcStr( szTmp, m_stOzData.BNK_BRANCH_NM );
		//JSON_SetValue( g_pjcomm, 'C', "bnk_branch_nm",             szTmp                          );

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.DEPOSITOR_NM );
		JSON_SetValue( g_pjcomm, 'C', "depositor_nm",              szTmp                          );

		JSON_SetValue( g_pjcomm, 'C', "depositor_tel_ddd",         m_stOzData.DEPOSITOR_TEL_DDD   );
		JSON_SetValue( g_pjcomm, 'C', "depositor_tel_exn",         m_stOzData.DEPOSITOR_TEL_EXN   );
		JSON_SetValue( g_pjcomm, 'C', "depositor_tel_num",         m_stOzData.DEPOSITOR_TEL_NUM   );
		JSON_SetValue( g_pjcomm, 'C', "defray_account_num",        m_stOzData.DEFRAY_ACCOUNT_NUM  );
		JSON_SetValue( g_pjcomm, 'C', "depositor_birth_date",      m_stOzData.DEPOSITOR_BIRTH_DATE);
		JSON_SetValue( g_pjcomm, 'C', "depositor_relat_cd",        m_stOzData.DEPOSITOR_RELAT_CD  );
		//JSON_SetValue( g_pjcomm, 'C', "cust_relat_cd",             m_stOzData.CUST_RELAT_CD       );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.REQ_NM );
		JSON_SetValue( g_pjcomm, 'C', "req_nm",                    szTmp                          );
		
		JSON_SetValue( g_pjcomm, 'C', "req_tel_ddd",               m_stOzData.REQ_TEL_DDD         );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_exn",               m_stOzData.REQ_TEL_EXN         );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_num",               m_stOzData.REQ_TEL_NUM         );
		JSON_SetValue( g_pjcomm, 'C', "oz_tran_req_flag",          m_stOzData.OZ_TRAN_REQ_FLAG    );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "addr_union",                szTmp                          );
		
		//JSON_SetValue( g_pjcomm, 'C', "birth_date",                m_stOzData.SOC_NUM          );

		//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		//Mem_Cpy((byte *)szTmp, (byte *)m_stOzData.BIRTH_DATE+2, Str_Len(m_stOzData.BIRTH_DATE)-2);
		JSON_SetValue( g_pjcomm, 'C', "soc_num",                   m_stOzData.SOC_NUM             );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_ddd",          m_stOzData.OWNHOUSE_TEL_DDD    );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_exn",          m_stOzData.OWNHOUSE_TEL_EXN    );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_num",          m_stOzData.OWNHOUSE_TEL_NUM    );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",                    m_stOzData.CP_DDD              );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",                    m_stOzData.CP_EXN              );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",                    m_stOzData.CP_NUM              );
		JSON_SetValue( g_pjcomm, 'C', "oz_email_req_flag",         m_stOzData.OZ_EMAIL_REQ_FLAG   );
		JSON_SetValue( g_pjcomm, 'C', "oz_lms_req_flag",           m_stOzData.OZ_LMS_REQ_FLAG     );
		
		//���� ����༭ ������(������ ���� �ʿ���)
		JSON_SetValue( g_pjcomm, 'C', "cancel_payment_method",     m_stCancelData.PAYMENT_METHOD     );
		JSON_SetValue( g_pjcomm, 'C', "cancel_bnk_cd",             m_stCancelData.BNK_CD             );
		JSON_SetValue( g_pjcomm, 'C', "cancel_defray_account_num", m_stCancelData.DEFRAY_ACCOUNT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_relat_cd", m_stCancelData.DEPOSITOR_RELAT_CD );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stCancelData.DEPOSITOR_NM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_nm",       szTmp );
		
		//13�ڸ��� �ֹι�ȣ -> ���� 6�ڸ���
		//�ƴ� ���� ����ڹ�ȣ -> ��� �ѱ��
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		if( Str_Len(m_stCancelData.DEPOSITOR_BIRTH_DATE) == 13 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)m_stCancelData.DEPOSITOR_BIRTH_DATE, 6);
		}
		else
		{
			Str_Cpy(szTmp, m_stCancelData.DEPOSITOR_BIRTH_DATE);
		}
		
		JSON_SetValue( g_pjcomm, 'C', "cancel_depositor_birth_date", szTmp );

		JSON_SetValue( g_pjcomm, 'C', "cancel_lms_tel_ddd", m_stCancelData.LMS_TEL_DDD );
		JSON_SetValue( g_pjcomm, 'C', "cancel_lms_tel_exn", m_stCancelData.LMS_TEL_EXN );
		JSON_SetValue( g_pjcomm, 'C', "cancel_lms_tel_num", m_stCancelData.LMS_TEL_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cancel_email_req_addr", m_stCancelData.EMAIL_REQ_ADDR);
		JSON_SetValue( g_pjcomm, 'C', "card_valid_period", m_stOzData.CARD_VALID_PERIOD );
		JSON_SetValue( g_pjcomm, 'C', "card_join_yn", m_stOzData.CARD_JOIN_YN );
//PRINT("SND_OZVIEW >>>>>>>>>>>>>>>>>>>>>>>> JSON_toString(g_pjcomm) : %s",JSON_toString(g_pjcomm),0,0);

		// 2017.11.14 �ű�ȣ �߰�
		if( Chk_chgUserInfo() > 0 )
		{	
			 Str_Cpy(m_stOzData.CHK_CHG_USERINFO_FLAG, "Y");
		}	
		else
		{
			Str_Cpy(m_stOzData.CHK_CHG_USERINFO_FLAG, "N");
		}
		
		JSON_SetValue( g_pjcomm, 'C', "chk_chg_userinfo_flag", m_stOzData.CHK_CHG_USERINFO_FLAG );
		
		filesize = FFS_GetSize( m_stOzData.PDFPATH );
		filedata = Mem_Alloc(filesize);
		
		fd = FFS_Open(m_stOzData.PDFPATH, FS_READ_MODE, FS_NORMAL_FLAG );
		FFS_Read ( fd, (byte*)filedata, filesize );
		FFS_Close(fd);

		file = BASE64_Create();
		BASE64_Encode(file, filedata, filesize );
		szfile = BASE64_GetResult(file);	
		
		JSON_SetValue( g_pjcomm, 'C', "oz_file",  szfile );

		sndbuf = JSON_toString(g_pjcomm);

		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR822566; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR822566_IN",  "FR822566" , sndbuf, szbuf );
		
		return 1;
	}
	
//------------------------------------------------------------------
	long TR822566(void)
	{
		long lRet = 0;
		long lJsonRet = 0;
		char szSql[350];
	
		//lJsonRet = g_Chk_Json(822566);
	
		if(g_Chk_Json(822566) >= 0)
		{
			//2017-05-18 Sanghyun Lee
			//OZ ������ ���� �� �������� �� ��� �޽��� ȣ�� �� OZ �����
			//if( lJsonRet == 822566 )
			//{
			//	lRet = SetData(822566);
			//	if( lRet == -2 )
			//	{
			//		OzView();
			//	}
			//}
			//else
			//{
			//	Card_Move("GM_CUSTINFO");
			//}
			Card_Prev();

			ON_DRAW();
			return 1;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "��Ͽ� �����Ͽ����ϴ�. �ٽ� �����Ͻðڽ��ϱ�?")  == MB_OK)
			{
				Snd_OzView();
				return 0;
			}
		
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	// 20171101 �ű�ȣ, ����ϻ���༭ �� ����
	long Chk_chgUserInfo(void)
	{
		char szBefore_SocNum[7];
		char szAfter_SocNUm[7];
		
		Mem_Set((byte*)szBefore_SocNum, 0x00, sizeof(szBefore_SocNum));
		Mem_Cpy((byte *)szBefore_SocNum, (byte *)m_stUsedata.SOC_NUM + 0, 6);
		
		Mem_Set((byte*)szAfter_SocNUm, 0x00, sizeof(szAfter_SocNUm));
		Mem_Cpy((byte *)szAfter_SocNUm, (byte *)m_stOzData.SOC_NUM + 0, 6);
	
		// ����
		if( Str_Cmp(m_stUsedata.CUST_NM, m_stOzData.CUST_NM) != 0 )
		{
			return 1;
		}
		// ����
		else if( Str_Cmp(m_stUsedata.GENDER, m_stOzData.GENDER) != 0 )
		{
			return 1;
		}
		// �������
		else if( Str_Cmp(szBefore_SocNum , szAfter_SocNUm) != 0 )
		{
			return 1;
		}

		return 0;
	}
}




