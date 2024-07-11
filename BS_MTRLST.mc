/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_MTRLST
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
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
	//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
//����Ʈ
		DEF_BUTTON_ID ( BID_PREVLST )		//����������
		DEF_BUTTON_ID ( BID_NEXTLST )		//����������
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//����Ʈ
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )			//��������

		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6					// table�� �ళ��
	#define		COL 	    3					// table�� ������
	#define		GRID_H		(CHT+68)			// table �� ����
	#define		GRID_H_P	(CHT+93)			// table �� ���� , PDA ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+135  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+40  	    // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�跮��"    , CWD*33+23, EDITALIGN_LEFT|EDITALIGN_TOP,    TABLE_TEXT, 0},
		{"���"      , CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"�跮���ȣ", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1	
	
	long m_lpage = 0;			// ���� ���ô��
	long m_lTotpage = 0;		// �� ������
	long m_lActIndex = -1;
	long m_lstartidx = 0;
	long m_lChk = -1;
	char m_szCnt_page[10];		// ������ ǥ�� ����
	char m_bFirst;				//INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	
	void REDRAW(void);
	void SetStyle(void);
	void SetBtnImg(void);
	bool Chk_Result(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�� ����Ʈ"),
		
		DLG_BUTTON(STARTX+500, STARTY+65, 250, 70, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+65, 250, 70, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, " ��"),				
		
		DLG_TEXT(STARTX,      STARTY+65, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
				
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�跮�� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
				
		DLG_BUTTON(STARTX+500,	STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, " ��"),
		DLG_BUTTON(STARTX+750,	STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, " ��"),
		
		DLG_TEXT(STARTX,		STARTY-40, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-70, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
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
				m_bFirst = bFirst;
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
				REDRAW();
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
	void	OnButton(long ID)
	{	
		switch(ID)
		{	
			case BID_PREVLST:
				g_nObjIndex = 0;
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_lActIndex = 0;
				REDRAW();
				break;
			case BID_NEXTLST:
				g_nObjIndex = 0;
				m_lpage += ROW;
				if( m_lpage >= m_lTotpage )
				{
					m_lpage -= ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_lActIndex = 0;
				REDRAW();
				break;		
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "Ư������ �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
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
				if( Chk_Result() )
				Card_Move("BS_START");
				break;	
			case GID_VMEXIT:
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Exit_DelBsData();
					return;
				}
				g_Exit();
				return;
		}
	}
	
//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		long lPage;
		char szcmb[20];

		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_lActIndex )
				{
					Str_Cpy(g_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 2));
					
					//g_nObjIndex = m_lpage*ROW + m_lActIndex;
					g_nObjIndex = m_lpage + m_lActIndex;

					Card_Move("BS_MTRINFO");
					return;
				}
				m_lActIndex = index - 1;
				g_nObjIndex = m_lpage*ROW + m_lActIndex;
				
				lPage = m_lpage + index;
				SPRINT(m_szCnt_page, "%d/%d", lPage, m_lTotpage, 0);
				
				Str_Cpy(g_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 2));
			}
		}
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lPage = 0;
		char sztmp[300];
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_MTR WHERE CHK_EXEC_NUM ='%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &m_lTotpage );

		if( g_nObjIndex > 0 )
		{
			m_lpage = (g_nObjIndex/ROW)*ROW;
			m_lActIndex = (g_nObjIndex%ROW);
		}
		if( m_lActIndex == -1 )
		{
			m_lActIndex = 0;
		}

		lPage = m_lpage + m_lActIndex;
		SPRINT(m_szCnt_page, "%d/%d", lPage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT ifnull(Trim(ADDR1_S),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),'') \
		 ||' '|| ifnull(Trim(DETA_FLOOR),'') ||'\n'|| ifnull(MTR_ID_NUM,'') ||'-'|| ifnull(MTR_GRD,'') ||'-'|| ifnull(FIRM_NM, '') \
		 , CHK_RSLT, MTR_NUM FROM SPECIAL_MTR WHERE CHK_EXEC_NUM = ? LIMIT ?, ?"
							);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 12, DECRYPT);
		m_lstartidx = m_lpage;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
		i = m_lpage+ROW;
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
				//�跮��(�ּ�+�跮���ȣ+���+��ȣ��)
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				idx = 0;
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 1 + 1  , DECRYPT);
				if(sztmp[0] == 'N')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "��" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle ( ID_TBLLIST, i, 1 ), RED);
					m_lChk = 1;
				}
				else if(sztmp[0] == 'Y')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "��");
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle ( ID_TBLLIST, i, 1 ), BLACK);
					m_lChk = 0;
				}
				else if(sztmp[0] == 'E')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "��" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle ( ID_TBLLIST, i, 1 ), BLACK);
					m_lChk = 0;
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1,  "��");
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle ( ID_TBLLIST, i, 1 ), BLACK);
				}
				
				//�跮��⹰��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			}
		}		

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		if( m_lTotpage > 0 )
		{
			SPRINT(szSql, "SELECT ROWID FROM SPECIAL_MTR WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0,0 );
			g_Sql_SaveSeq( szSql, BSMTRLST_FILE);
			
			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			Str_Cpy(g_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 2));
		}
		
		ON_DRAW();
		
		return;
	}
	
//------------------------------------------------------------------------------------------------------
	bool Chk_Result(void)
	{
		char szSql[300];
		char szTmp[10];
		long i,j = 0;
		long lChk = 0;
		long lNogood = 0;
		long idx;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		for( i=0 ; i < m_lTotpage ; i++)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
			SPRINT(szSql, " SELECT CHK_RSLT FROM SPECIAL_MTR WHERE CHK_EXEC_NUM = '%s' LIMIT '%d', '1' "
			, g_szCHK_EXEC_NUM, i, 0);
			g_Sql_RetStr( szSql, 5, szTmp );
			
			//if( Str_Cmp(szTmp, "") == 0 )
			if(szTmp[0] == '')
			{
				lChk++;
			}
		}
		
		if( lChk == 0 )
		{
			for( i=0 ; i < m_lTotpage ; i++)
			{
				j = i+1;
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				SPRINT(szSql, " SELECT CHK_RSLT FROM SPECIAL_MTR WHERE CHK_EXEC_NUM = '%s' LIMIT '%d', '%d' "
				, g_szCHK_EXEC_NUM, i, j);
				g_Sql_RetStr( szSql, 5, szTmp );
				
				//if( Str_Cmp(szTmp, "N") == 0 )
				if(szTmp[0] == 'N')
				{
					lNogood++;
				}
			}
		}
		else
		{
			Str_Cpy(stBs.MRT_RSLT, "");

			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				ret = FALSE;
				goto Finally;
			}
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
						MRT_RSLT = ? \
						WHERE CHK_EXEC_NUM = '%s' "
						, g_szCHK_EXEC_NUM, 0, 0);
			
			hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stBs.MRT_RSLT	,2	,DECRYPT);
			
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}

			goto Finally;
		}

		if( lNogood > 0 )
		{
			Str_Cpy(stBs.MRT_RSLT, "N");
			Str_Cpy(stBs.NOGOOD_RSLT, "N");
		}
		else
		{
			Str_Cpy(stBs.MRT_RSLT, "Y");
		}

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					MRT_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.MRT_RSLT	,2	,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

	Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
}

