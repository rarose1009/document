/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_RESULT
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
		DEF_BUTTON_ID ( BID_UP )		//����������
		DEF_BUTTON_ID ( BID_DOWN )		//����������
		DEF_BUTTON_ID ( BID_SEARCH )		//��ȸ
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
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( ID_TBLLIST )
	END_OBJECT_ID()

	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    12				// table�� �ళ��
	#define		COL 	    3				// table�� ������
	#define		GRID_H		(CHT+10)		// table �� ����
	#define		GRID_H_P	(CHT+20)		// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   	// table Ŭ���� color
	#define		GRID_X		STARTX 			// table ����x��ǥ
	#define		MAXCHAR		51 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+65  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY-40       // table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�跮�� ���",	CWD*20, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��ġ",		CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",		CWD*9+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};

	#define INIT_MAIN	1
	
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_nActIndex = -1;
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szTmp[300];

	void SetStyle(void);
	void SetBtnImg(void);
	void Rcv_Rslt(void);
	long TR75202(void);
	void Rcv_Draw(void);
	void ReDraw(void);
	long FS_GetSrchTotCnt(void);
	
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ȸ"),

		DLG_BUTTON(STARTX,     STARTY+835, 250, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+250, STARTY+835, 250, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),
		DLG_BUTTON(STARTX+500, STARTY+835, 500, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, "���Ͻ�����ȸ"),
		
		DLG_TEXT(STARTX,     STARTY+705, 500, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, m_szCnt_page),
		DLG_TEXT(STARTX+500, STARTY+705, 250, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "�Ѱ���"),
		DLG_TEXT(STARTX+750, STARTY+705, 250, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		
		DLG_TEXT(STARTX, 	 STARTY+770, 500, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "���ϱ�ü���"),
		DLG_TEXT(STARTX+500, STARTY+770, 500, 60, 0, 0, 0, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_DATA2, ""),

		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "������ȸ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,     STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+250, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),
		DLG_BUTTON(STARTX+500, STARTY+825, 500, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, "���Ͻ�����ȸ"),
		
		DLG_TEXT(STARTX,     STARTY+705, 500, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, m_szCnt_page),
		DLG_TEXT(STARTX+500, STARTY+705, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "�Ѱ���"),
		DLG_TEXT(STARTX+750, STARTY+705, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		
		DLG_TEXT(STARTX, 	 STARTY+765, 500, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "���ϱ�ü���"),
		DLG_TEXT(STARTX+500, STARTY+765, 500, 60, 0, 0, 0, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_DATA2, ""),

		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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
				ReDraw();
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					return;
				}
				m_nActIndex = 0;
				ReDraw();
				break;			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					break;
				}
				m_nActIndex = 0;
				ReDraw();
				break;
			case BID_SEARCH:
				Rcv_Rslt();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "�跮�ⱳü �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C6301_MENU");
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
				Card_Move("C6301_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	

//----------------------------------------------------------------------------------
	void Rcv_Rslt(void)
	{
		char szUrl[200];
		char szFilepath[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		
		g_Sql_DirectExecute("DELETE FROM RCV_COUNT");
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 75202, FALSE);
		
		//JSON_SetValue( g_pjcomm, 'C', "employee_id",  stUserinfo.szemployee_id );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR75202;
		ret = HTTP_DownloadData(szUrl, "FR75202_IN",  "FR75202" , sndbuf, szbuf );

		return;
	}

//----------------------------------------------------------------------------------	
	long TR75202(void)
	{
		g_Sock_Close();
		if(g_Chk_Json(75202) >= 0)
		{
			CloseMessageBox();
			Rcv_Draw();
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
//----------------------------------------------------------------------------------
	void Rcv_Draw(void)
	{
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		g_Sql_RetStr( "SELECT CNT FROM RCV_COUNT ", 4, m_szTmp );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), m_szTmp); 
		
		MessageBoxEx (CONFIRM_OK, "��ȸ�Ϸ�.");
		
		ON_DRAW();
		return;
	}
//----------------------------------------------------------------------------------
	void ReDraw(void)
	{
		long i, idx;
		long lstartidx = 0;
		long k = ROW+1;
		long ret = -1;	
		char szTmp[20];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_SaveSeq( "SELECT COUNT(*) FROM C6301_CHANGEDATA GROUP BY MTR_GRD ORDER BY MTR_GRD", SREACH_FILE);
		m_lTotpage = FS_GetSrchTotCnt();
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		//������ ����
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		//�跮�� �� ����
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA", 20, szTmp );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), szTmp); 
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT MTR_GRD, MTR_LOC_FLAG, COUNT(*) FROM C6301_CHANGEDATA GROUP BY MTR_GRD ORDER BY CAST(MTR_GRD AS NUMERIC) LIMIT ?,?" );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);		
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
			}
			else
			{

				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					continue;
				}

				idx = 0;
				//��ü���
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)m_szTmp, 7 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, m_szTmp );
				//��ġ
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)m_szTmp,  10 +1, DECRYPT);
				if( Str_Cmp(m_szTmp, "10") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "����" );
				}
				else if( Str_Cmp(m_szTmp, "20") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�ܺ�" );
				}
				
				//����
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)m_szTmp,  5 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, m_szTmp );		
			}
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : FS_GetSrchTotCnt
	��  �� : �˻��ε��������� ���ڵ� ���� �����Ѵ�.
	Param  : nPos:�˻� �ε��� ������ ����
 	Return : ���ڵ��
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;
		
		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}

}


