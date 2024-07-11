/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_NODEL
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
//���ұ� �������
		DEF_BUTTON_ID ( BID_NODEL )		//�������
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_PREVLST )	//
		DEF_BUTTON_ID ( BID_NEXTLST )	//
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
		DEF_OBJECT_ID ( TXT_PAGE )
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )

		DEF_OBJECT_ID ( ID_TBLLIST )		
		
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����(���ұ� �������)
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5						 // table�� �ళ��
	#define		COL 	    6						 // table�� ������
	#define		GRID_H	  	(CHT+35)					 // table �� ����
	#define		GRID_CLR	TRANSPARENT   			 // table Ŭ���� color
	#define		GRID_X	  	STARTX 					 // table ����x��ǥ
	#define		MAXCHAR	  	51 			    		 // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y	  	STARTY-29   			 // table ����y��ǥ
	#define		GRID_Y_P  	STARTY-40   			 // table ����y��ǥ
	#define		GRID_ENDY  	(GRID_Y+(ROW+1)*GRID_H)  // table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"������",	    CWD*13, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�𵨸�",	    CWD*16+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",        CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��ġ����",     CWD*0, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�뷮",         CWD*0, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���ұ��ȣ",   CWD*0, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};

	#define INIT_MAIN	1
	
	long m_bFirst;
	long m_lSelIndex = -1;
	long m_lLstpage = 0;
	long m_ltotLstcnt = 0;
	char m_szLstCnt_page[10];
	char m_szBurner_Num[10];
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void NoDel_Boil(void);
	void SetTotCnt(void);

	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� �������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,     STARTY+580, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+250, STARTY+580, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX+500, STARTY+580, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NODEL, "�������"),
		DLG_BUTTON(STARTX+750, STARTY+580, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "�� ��"),
		
		DLG_TEXT(STARTX,     STARTY+430, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��ġ����"),
		DLG_TEXT(STARTX+250, STARTY+430, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),		
		DLG_TEXT(STARTX+550, STARTY+430, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�뷮"),
		DLG_TEXT(STARTX+750, STARTY+430, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+500, 500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szLstCnt_page),

		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� �������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,	   STARTY+610, 250, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+250, STARTY+610, 250, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX+500, STARTY+610, 250, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NODEL, "�������"),
		DLG_BUTTON(STARTX+750, STARTY+610, 250, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "�� ��"),
		
		DLG_TEXT(STARTX,     STARTY+430, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��ġ����"),
		DLG_TEXT(STARTX+250, STARTY+430, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),		
		DLG_TEXT(STARTX+550, STARTY+430, 170, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�뷮"),
		DLG_TEXT(STARTX+720, STARTY+430, 280, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+520, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szLstCnt_page),

		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
		char sztmp[300];
		m_bFirst = bFirst;
	
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
				SetStyle();
				SetTotCnt();
				ON_DRAW();

				if( m_ltotLstcnt == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��������� ���ұⰡ �����ϴ�.");
					if( g_nWorkFlag > 499 && g_nWorkFlag < 510 )
					{
						Card_Move("BF_BEFOCONFIRM");
					}
					else
					{
						Card_Move("BF_TGTCONFIRM");
					}
					
					ON_DRAW();
					break;
				}

				REDRAW();
				break;
		}

	}

//------------------------------------------------------------------
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_PREVLST:
				m_lLstpage -= ROW;
				if(m_lLstpage < 0)
				{
					m_lLstpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;
			case BID_NEXTLST:
				m_lLstpage += ROW;
				if( m_lLstpage >= m_ltotLstcnt )
				{
					m_lLstpage -= ROW;
					if(m_lLstpage < 0)
					{
						m_lLstpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;
			case BID_NODEL:
				if(  MessageBoxEx (CONFIRM_YESNO, "���� ��� �Ͻðڽ��ϱ�?")  == MB_OK )
				{
					NoDel_Boil();
					SetTotCnt();
					REDRAW();
				}
				break;
			case BID_OK:
				if( g_nWorkFlag > 499 && g_nWorkFlag < 510 )
				{
					Card_Move("BF_BEFOCONFIRM");
				}
				else
				{
					Card_Move("BF_TGTCONFIRM");
				}
				break;
		}
	}
	
//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		char sztmp[200];
		char szSql[300];
		long index;
		long lPage;
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_lSelIndex = index - 1;

				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)   , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)   , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
				
				Mem_Set( (byte*)m_szBurner_Num, 0x00, sizeof(m_szBurner_Num) );
				Str_Cpy(m_szBurner_Num, DlgTbl_GetStr( ID_TBLLIST, 0, 5));
				
				lPage = m_lLstpage + index;
				SPRINT(m_szLstCnt_page, "%d/%d", lPage, m_ltotLstcnt, 0);
			}
		}
	}
	
//------------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lstartidx ;
		long nRet;
		char sztmp[401];
		char szDate[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		SPRINT(m_szLstCnt_page, "%d/%d", m_lLstpage+1, m_ltotLstcnt, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT MAKER_NM, BURNER_MODEL_NM, INST_FLAG, BURNER_INST_YMD, BURNER_CAPA, BURNER_NUM \
					   FROM BEFO_BO_DATA WHERE CREATE_YMD = ? AND MTR_NUM = ? AND CHG_FLAG == '30' LIMIT ?, ? "
					   , 0, 0, 0);

		hstmt = sql->CreateStatement(sql, sztmp);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCREATE_YMD, 8, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)g_szMTR_NUM, 9, DECRYPT);

		lstartidx = m_lLstpage;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lLstpage+ROW;
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					continue;
				}
				//
				idx = 0;
				//������
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 60 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//�𵨸�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//���� , Decode(INST_FLAG,'10','�ű�','��ü')
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  2 + 1, DECRYPT);
				if( Str_Cmp(sztmp, "10") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "�ű�" );
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "��ü" );
				}
				//��ġ����
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  8 + 1, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, szDate );
				//�뷮
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//���ұ��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  6 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
			}
		}		
		
		
Finally:

		//if()
		//if������ return���� üũ�Ͽ��� commit/rollback ����
		//{
		//	sql->Commit(sql);
		//}
		//else
		//{
			//�ѹ�
		//}
		
		DelSqLite(sql);
		
		if( m_ltotLstcnt > 0 )
		{
			if( m_lSelIndex == -1 )
			{
				m_lSelIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)   , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)   , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
			
			Mem_Set( (byte*)m_szBurner_Num, 0x00, sizeof(m_szBurner_Num) );
			Str_Cpy(m_szBurner_Num, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)   , "");
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)   , "");
		}
		
		ON_DRAW();
		return;
	}	
	
	
//------------------------------------------------------------------------------------------------
	void NoDel_Boil(void)
	{
		char szSql[300];
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();


		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE BEFO_BO_DATA SET \
					BURNER_REMOV_YMD = ' ', CHG_FLAG = '', SEND_FLAG = 'N' WHERE CREATE_YMD = ? AND MTR_NUM = ? AND BURNER_NUM = ? "
					, 0, 0, 0);		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szCREATE_YMD			    ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM			        ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szBurner_Num			    ,6 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "������� �Ǿ����ϴ�.");
			m_lLstpage = 0;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	
//========================================================================================
	void SetTotCnt(void)
	{
		char szSql[300];
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM BEFO_BO_DATA WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' AND CHG_FLAG = '30' "
		,g_szCREATE_YMD, g_szMTR_NUM, 0 );
		g_Sql_RetInt( szSql, &m_ltotLstcnt );
	}
}


