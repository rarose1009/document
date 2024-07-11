/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_RSLTHSTR
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
		DEF_BUTTON_ID ( BID_CHECK )		//��ȸ(Ȯ��)
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
		DEF_OBJECT_ID ( TXT_LIST )		//���
		DEF_OBJECT_ID ( TXT_OBJECT )	//���
		DEF_OBJECT_ID ( TXT_TOTAL )		//����
		DEF_OBJECT_ID ( TXT_TODAY )		//����
		DEF_OBJECT_ID ( TXT_SCRSLT )	//���˰��
		DEF_OBJECT_ID ( TXT_FIT )		//����
		DEF_OBJECT_ID ( TXT_NOFIT )		//������
		DEF_OBJECT_ID ( TXT_OUT )		//����
		DEF_OBJECT_ID ( TXT_NOFIT2 )	//������
		DEF_OBJECT_ID ( TXT_IMPROVE )	//����
		DEF_OBJECT_ID ( TXT_NIMPROVE )	//�̰���
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	void SetStyle(void);
	void SetBtnImg(void);
	void Rcv_ScRslt(void);
	long TR312310(void);
	void REDRAW(void);
	
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ����"),

		DLG_BUTTON(STARTX+200, STARTY+600, 600, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK, "�� ȸ"),
		
		DLG_TEXT(STARTX, 	  STARTY+65, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LIST, "���"),
		DLG_TEXT(STARTX+300,  STARTY+65, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "���"),
		DLG_TEXT(STARTX+550,  STARTY+65, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TOTAL, "����"),
		DLG_TEXT(STARTX+775,  STARTY+65, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TODAY, "����"),
		DLG_TEXT(STARTX, 	 STARTY+135, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCRSLT, "���˰��"),
		DLG_TEXT(STARTX+300, STARTY+135, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY+135, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+775, STARTY+135, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX, 	 STARTY+205, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIT, "����"),
		DLG_TEXT(STARTX+300, STARTY+205, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX, 	 STARTY+275, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT, "������"),
		DLG_TEXT(STARTX+300, STARTY+275, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX, 	 STARTY+345, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OUT, "����"),
		DLG_TEXT(STARTX+300, STARTY+345, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX, 	 STARTY+415, 300, 140, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT2, "������"),
		DLG_TEXT(STARTX+300, STARTY+415, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_IMPROVE, "����"),
		DLG_TEXT(STARTX+550, STARTY+415, 450, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+300, STARTY+485, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NIMPROVE, "�̰���"),
		DLG_TEXT(STARTX+550, STARTY+485, 450, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+600, STARTY+730, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK, "�� ȸ"),
		
		DLG_TEXT(STARTX,      STARTY-40, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LIST, "���"),
		DLG_TEXT(STARTX+300,  STARTY-40, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "���"),
		DLG_TEXT(STARTX+550,  STARTY-40, 200, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TOTAL, "����"),
		DLG_TEXT(STARTX+750,  STARTY-40, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TODAY, "����"),
		DLG_TEXT(STARTX,      STARTY+60, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCRSLT, "���˰��"),
		DLG_TEXT(STARTX+300,  STARTY+60, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550,  STARTY+60, 200, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+750,  STARTY+60, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,     STARTY+160, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIT, "����"),
		DLG_TEXT(STARTX+300, STARTY+160, 700, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+260, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT, "������"),
		DLG_TEXT(STARTX+300, STARTY+260, 700, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+360, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OUT, "����"),
		DLG_TEXT(STARTX+300, STARTY+360, 700, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+460, 300, 200, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NOFIT2, "������"),
		DLG_TEXT(STARTX+300, STARTY+460, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_IMPROVE, "����"),
		DLG_TEXT(STARTX+550, STARTY+460, 450, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+300, STARTY+560, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NIMPROVE, "�̰���"),
		DLG_TEXT(STARTX+550, STARTY+560, 450, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
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
				//Rcv_ScRslt();
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
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LIST), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TOTAL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TODAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SCRSLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOFIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OUT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOFIT2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_IMPROVE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NIMPROVE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	
	EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), RED);
	
	/*
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), "0" );
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "0" );
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), "0" );
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "0" );
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "0" );
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "0" );
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), "0" );
	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "0" );
	*/
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_CHECK:
				Rcv_ScRslt();
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
				Card_Move("SC_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void Rcv_ScRslt(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		
		g_Sql_DirectExecute(" DELETE FROM NORMAL_RSLT ");
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 312310, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR312310;
		ret = HTTP_DownloadData(szUrl, "FR312310_IN",  "FR312310" , sndbuf, szbuf );

		return;
	}
	
	long TR312310(void)
	{
		g_Sock_Close();
		if(g_Chk_Json(312310) >= 0)
		{
			CloseMessageBox();
			REDRAW();
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	void REDRAW(void)
	{
	long i, idx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	char szgubun[10];
	char szcnt[10];

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT Gubun, CNT FROM NORMAL_RSLT ORDER BY GUBUN " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		while(sql->Next(sql) )
		{
			idx = 0;
			Mem_Set( (byte*)szgubun, 0x00, sizeof(szgubun) );
			sql->GetValue(sql, idx++, 'U', (long*)szgubun, 10, DECRYPT);
			
			Mem_Set( (byte*)szcnt, 0x00, sizeof(szcnt) );
			sql->GetValue(sql, idx++, 'U', (long*)szcnt, 10, DECRYPT);
			
			if( szgubun[0] == '6' ) //���˴��
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), szcnt );
			}
			else if( szgubun[0] == '2' )//���˿Ϸ� ����
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szcnt );
			}
			else if( szgubun[0] == '1' )//���� ���˼�
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szcnt );
			}
			else if( szgubun[0] == '3' )//���� ���˼�
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), szcnt );
			}
			else if( szgubun[0] == '4' )//������ ���˼�
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), szcnt );
			}
			else if( szgubun[0] == '5' )//�������� ���˼�
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), szcnt );
			}
			else if( szgubun[0] == '8' )// ������ ������
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), szcnt );
			}
			else if( szgubun[0] == '7' )//������ �̰�����
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), szcnt );
			}
		}
		
		MessageBoxEx (CONFIRM_OK, "��ȸ�Ϸ�.");
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
	}
	
}


