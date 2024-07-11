/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_CTRCV
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
		DEF_BUTTON_ID ( BID_RECV )			//�ڷ����
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
		DEF_OBJECT_ID ( TXT_GOOBOON )		//����
		DEF_OBJECT_ID ( TXT_CUSTOMCNTR )	//������
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( CMB_GOOBOON ) 	//���� �޺��ڽ�
	END_OBJECT_ID()
	
	#define INIT_MAIN	1

	char m_szSafechktype[3];
	char m_szzone_manage_num[6];
	
	
	void SetStyle(void);
	void SetBtnImg(void);
	void UPdate_Rcvlog(void);
	long Rcv_Data(void);
	long TR311319(void);


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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SCGS �ڷ����"),
		
		DLG_TEXT (STARTX,     STARTY+65, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "����"),
		DLG_COMBO(STARTX+400, STARTY+65, 600, 290, 120, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOOBOON, 10),	//���� �޺��ڽ�
		DLG_TEXT(STARTX,      STARTY+145, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "������"),
		DLG_TEXT(STARTX+400,  STARTY+145, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, "���������ַ����"),

		DLG_BUTTON(STARTX+500, STARTY+300, 500, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "SCGS �ڷ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		
		DLG_TEXT(STARTX,		 STARTY-40, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "����"),
		DLG_COMBO (STARTX+400,	 STARTY-40, 600, 290, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOOBOON, 10),	//���� �޺��ڽ�
		DLG_TEXT(STARTX,		 STARTY+60, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "������"),
		DLG_TEXT(STARTX+400,	 STARTY+60, 600, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, "���ð���"),
		
		DLG_BUTTON(STARTX+600,	STARTY+250, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				SetBtnImg();				
				SetStyle();
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

	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOOBOON), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUSTOMCNTR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOOBOON), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GOOBOON+2), "����������", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GOOBOON+2), "Ȯ������", 0, ICON_NONE);
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GOOBOON), "����������");
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
				if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("SC_MENU");
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
				Card_Move("SC_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	
	
	
	long Rcv_Data(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
	long chk = 0, totcnt;
		
		g_Sql_RetInt(" select count(*) from REGTR_DATA WHERE CHK_END_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from REGTR_MRT WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from REGTR_NOGOOD WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}

		if( chk > 0   )
		{
			MessageBoxEx (CONFIRM_OK, "�̼۽� �ڷᰡ �ֽ��ϴ�, �۽� �� ���Ź�������.");
			return -1;
		}
		
		
		if(  MessageBoxEx (CONFIRM_YESNO, "�����ڷḦ ���Ź����ðڽ��ϱ�?")  == MB_OK )
		{
			g_Sql_DirectExecute("DELETE FROM REGTR_DATA");
			g_Sql_DirectExecute("DELETE FROM REGTR_MRT");
			g_Sql_DirectExecute("DELETE FROM REGTR_NOGOOD");
			g_Sql_DirectExecute("DELETE FROM REGTR_GROUP");
		}
		else
		{
			return -1;
		}
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if( Str_Cmp ("����������", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GOOBOON)) ) == 0)
		{
			Str_Cpy( m_szSafechktype, "23");
		}
		else
		{
			Str_Cpy( m_szSafechktype, "18");
		}
		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311319, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "safe_chk_type",    m_szSafechktype);
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311319; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR311319_IN",  "FR311319" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311319(void)
	{
	long mCnt = 0;
	
		mCnt = g_Chk_Json(311319);
		
		if( mCnt >= 0 )
		{
			UPdate_Rcvlog();
			
			if( mCnt > 0 )
				MessageBoxEx (CONFIRM_OK, "��ü �׷��ڷ������ �Ϸ� �Ǿ����ϴ�. �����ڷḦ �����ϼ���.");
			else
			{
				MessageBoxEx (CONFIRM_OK, "�ڷᰡ �����ϴ�. �Է»����� Ȯ���� �ּ���.");
				return 1;
			}
			
			ON_DRAW();
			OnButton(GID_PREV);
			return 1;
		}
		else
		{
			g_Sock_Close();
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
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '3' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM7, PARAM8) VALUES ('3',?,?,0 ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM7 =?,PARAM8=0 WHERE GUBUN = '3' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)m_szSafechktype, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)sztoday, 8, DECRYPT);
		sql->Begin(sql);
		
		//ret = sql->Execute(sql);
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
	
	
}


