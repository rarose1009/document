/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_SFWRKRCV
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

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_RECV )		//�ڷ����
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
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_JISA )		//����
		DEF_OBJECT_ID ( TXT_BSTYPE )	//��������
		DEF_OBJECT_ID ( TXT_DATA1 )
				
		DEF_OBJECT_ID ( ICON_TITLE)		//Ÿ��Ʋ
				
		DEF_OBJECT_ID ( CMB_JISA ) 		//���� �޺��ڽ�
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	char m_szChktype[3];
	char m_szJisacode[7];
	long m_Cnt411311 = 0;
	
	void UPdate_Rcvlog(void);
	void BS_DataDel(void);	
	
	long Rcv_Data(void);
	long TR411311(void);
	void RCV411312(void);
	long TR411312(void);
	void RCV411313(void);
	long TR411313(void);
	
	void SetStyle(void);
	void SetBtnImg(void);
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	
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
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� �ڷ����"),
			
		DLG_BUTTON(STARTX+600, STARTY+350, 400, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),
		
		DLG_TEXT(STARTX,		STARTY+65, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JISA, "����"),
		DLG_TEXT(STARTX,		STARTY+145, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSTYPE, "��������"),
		DLG_TEXT(STARTX+400,	STARTY+145, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, "��������"),
		
		DLG_COMBO (STARTX+400, STARTY+65, 600, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_JISA, 10),	//���� �޺��ڽ�
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�������� �ڷ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+600, STARTY+250, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),
		
		DLG_TEXT(STARTX,     STARTY-40, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JISA, "����"),
		DLG_TEXT(STARTX,     STARTY+60, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSTYPE, "��������"),
		DLG_TEXT(STARTX+400, STARTY+60, 600, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, "��������"),
		
		DLG_COMBO (STARTX+400, STARTY-40, 600, 290, 150, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_JISA, 10),	//���� �޺��ڽ�
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
						SetBtnImg();
						SetStyle();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						SetBtnImg();
						SetStyle();
						break;		
				}
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			//��ܰ���޴�
			h = GetSysButHandle(GID_HOME);
			ButCtrl_SetImage( h,  g_pImgHomeI);
			ButCtrl_SetActiveImage( h,  g_pImgHomeA);
			
			h = GetSysButHandle(GID_KEYBOARD);
			ButCtrl_SetImage( h,  g_pImgKeybrdI);
			ButCtrl_SetActiveImage( h,  g_pImgKeybrdA);
			
			h = GetSysButHandle(GID_SCREEN);
			ButCtrl_SetImage( h,  g_pImgScreenI);
			ButCtrl_SetActiveImage( h,  g_pImgScreenA);
			
			h = GetSysButHandle(GID_CMMNWK);
			ButCtrl_SetImage( h,  g_pImgCmmnwrkI);
			ButCtrl_SetActiveImage( h,  g_pImgCmmnwrkA);
			
			h = GetSysButHandle(GID_VMEXIT);
			ButCtrl_SetImage( h,  g_pImgExitI);
			ButCtrl_SetActiveImage( h,  g_pImgExitA);
		}
	}

//-----------------------------------------------------------------
void	SetStyle(void)
{
	long i;

	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JISA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_JISA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_JISA), stUserinfo.szbranch_nm);

	for ( i = 0 ;  JISA_CD[i].Str[0] != 0 ; i++)
	{
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_JISA+2), JISA_CD[i].Str, 0, ICON_NONE);
	}
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_RECV:
				Rcv_Data();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "Ư������ �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("BS_MENU");
				}
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
				Card_Move("BS_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : SearchStr
	��  �� : ��Ʈ������ �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long	SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; CT[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	/*=======================================================================================
	�Լ��� : SearchCD
	��  �� : �ڵ尪���� �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
				return i;
		}
		
		return -1;
	}
	
	
	long Rcv_Data(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	long chk = 0, totcnt;
		
		chk = 0;
		g_Sql_RetInt(" select count(*) from SPECIAL_BUR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from SPECIAL_DATA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from SPECIAL_GOV_REG WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_MTR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD_CHA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_PIPE_CHK_DATA ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}


		if( chk > 0   )
		{
			MessageBoxEx (CONFIRM_OK, "�̼۽� �ڷᰡ �ֽ��ϴ�, �۽� �� ���Ź�������.");
			return -1;
		}

		BS_DataDel();

		Mem_Set((byte*)m_szChktype, 0x00, sizeof(m_szChktype));	
		Str_Cpy( m_szChktype, "14");
		chk = 0;
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_JISA) ) );
		chk = SearchStr(sztmp, JISA_CD );
		Str_Cpy( m_szJisacode, JISA_CD[chk].Code);
		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411311, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",    m_szJisacode);
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411311; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411311_IN",  "FR411311" , sndbuf, sztmp );			
		
		return 0 ;
	}
	
	long TR411311(void)
	{
		m_Cnt411311 = g_Chk_Json(411311);
		if( m_Cnt411311 >= 0)
		{
			RCV411312();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411312(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411312, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",    m_szJisacode);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411312; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411312_IN",  "FR411312" , sndbuf, sztmp );		
		
	}
	
	long TR411312(void)
	{
		if(g_Chk_Json(411312) >= 0)
		{
			RCV411313();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411313(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411313, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",    m_szJisacode);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411313; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411313_IN",  "FR411313" , sndbuf, sztmp );		
		
	}
	
	long TR411313(void)
	{
		g_Sock_Close();
		if(g_Chk_Json(411313) >= 0)
		{
			UPdate_Rcvlog();
			if(m_Cnt411311 > 0 ) 
				MessageBoxEx (CONFIRM_OK, "�ڷ������ �Ϸ��߽��ϴ�.");
			else
			{
				MessageBoxEx (CONFIRM_OK, "�ڷᰡ �����ϴ�. Ȯ���� �ּ���.");
				return 1;
			}
			OnButton(GID_PREV);
			ON_DRAW();
			return 1;
		}
		else
		{
			BS_DataDel();
			return -1;
		}
	}
	
	void UPdate_Rcvlog(void)
	{
	long i=0, tot = 0, ret=0;
	char szSql[400];
	long idx;
	handle hdb = NULL;
	handle hstmt = NULL;
	char sztoday[9];
	SQLITE sql = NewSqLite();
	
		Mem_Set( (byte*) sztoday, 0x00, sizeof( sztoday) );
		Str_ItoA( Time_GetDate(), sztoday, 10);	
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM7, PARAM8) VALUES ('5' ,? ,?,? ,0 ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM2=?,PARAM7=?,PARAM8=0 WHERE GUBUN = '5' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)m_szChktype, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)m_szJisacode, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)sztoday, 8, DECRYPT);
		
		sql->Begin(sql);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;		
	}
	
	void BS_DataDel(void)
	{

		g_Sql_DirectExecute("DELETE FROM SPECIAL_BUR");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_DATA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_GOV_REG");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_GROUP");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_MTR");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD_CHA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD_DETAL");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_PIPE_CHK_DATA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_PREV_NO");
		
	}
}


