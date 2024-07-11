/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
//��ħ �׷츮��Ʈ �Ǿ�����. �������� �׷츮��Ʈ ���� �ڵ� ����.
card SC_GRPLST
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
		DEF_BUTTON_ID ( BID_NADDR )	//���ּ� 
		DEF_BUTTON_ID ( BID_UP )	//�� ������
		DEF_BUTTON_ID ( BID_DOWN )	//�Ʒ� ������
	//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )	//Ȩ
		DEF_BUTTON_ID ( BID_MENU )	//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )	//����
		DEF_BUTTON_ID ( BID_EXIT )	//����
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )		 //������

		DEF_OBJECT_ID ( ID_TBLLIST ) // ���̺� ����Ʈ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+20)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX+20 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+210  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"����", CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̰�", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}

	};	
	
	#define INIT_MAIN	1
	
	long	m_ActIndex  = -1; 		// ���� ���� ROW
	long 	m_lpage = 0;			// ���� ������
	long 	m_lTotpage = 0;			// �� ������
	char 	m_szCnt_page[10];		// ������ ǥ�� ����
	long 	m_lindex[ROW];			// �׷� ���� �ε��� 
	
	bool	REDRAW(void);      //ȭ�� DLSPLAY
	void	GET_HDINDEX(void); //�������ε����� �׷� �ε��� ã��
	void	SET_HDINDEX(void); //�׷� �ε��� �����ϱ�	
	void	SetStyle(void);
	long	SQLITE_IDXBYGETGRPSEQ(char* szSql, long idx);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_TITLE, "�� �� �� �� - �� �� �� �� Ʈ"),
		
		//ȭ�� ���� �޴�
		DLG_BUTTON(STARTX,      5, 145, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "�޴�"),
		DLG_BUTTON(STARTX+290,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "����"),
		DLG_BUTTON(STARTX+430,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "ȭ��"),
		DLG_BUTTON(STARTX+570,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"����"),
		DLG_BUTTON(STARTX+710,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "����"),
		DLG_BUTTON(STARTX+850,  5, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "����"),
		
		DLG_TEXT(STARTX+20, STARTY+70, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szTableBuf), //����������/��������
			
		DLG_BUTTON(STARTX+20,  STARTY+140, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, " ���ּ�"),
		DLG_BUTTON(STARTX+545, STARTY+140, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+765, STARTY+140, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
/*
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),

		DLG_TEXT(STARTX+20, STARTY+25, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), //����������/��������
			
		DLG_BUTTON(STARTX+20,  STARTY+120, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, " ���ּ�"),
		DLG_BUTTON(STARTX+545, STARTY+120, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+765, STARTY+120, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
*/
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),

		DLG_TEXT(STARTX+20, 30, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), //����������/��������
			
		DLG_BUTTON(STARTX+20,  STARTY+20, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, " ���ּ�"),
		DLG_BUTTON(STARTX+545, STARTY+20, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+765, STARTY+20, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		// ����Ʈ
		DLG_TABLE(GRID_X, STARTY+130, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
						SetStyle();
						//�ڷ� INDEX�� �޾Ƽ� ù�������� ����ڷᰡ �ִ� ��������
						//���̰� �ϱ� ���ؼ�.
						//�׷츮��Ʈ ȭ���� �� ȭ���� ����Ʈȭ��� �޴�ȭ�� �� ��� ������ Ȯ���ϱ� ���� �ε��� Ȯ��.
						if(g_lindex == -1)
							MessageBoxEx (CONFIRM_OK, "Family_PDA : ���� �� �׷��ε���");
//							GET_HDINDEX();//������ �� �׷��ε��� 
						else
						{
//							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT SEQ, (IDX+CNT) AS TOT FROM  GUMGROUP WHERE IDX <= ? AND TOT > ?",  g_lindex);
							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT CNT FROM  NORMAL_GROUP",  g_lindex);
							if( m_lpage % ROW >0 )
							{
								m_lpage = m_lpage / 10;
							}
							else
							{
								m_lpage = (m_lpage / 10) - 1;
							}
							if(m_lpage < 0)
							{
								m_lpage = 0;
							}
						}
						REDRAW();
						ON_DRAW();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
						SetStyle();
						//�ڷ� INDEX�� �޾Ƽ� ù�������� ����ڷᰡ �ִ� ��������
						//���̰� �ϱ� ���ؼ�.
						//�׷츮��Ʈ ȭ���� �� ȭ���� ����Ʈȭ��� �޴�ȭ�� �� ��� ������ Ȯ���ϱ� ���� �ε��� Ȯ��.
						if(g_lindex == -1)
							MessageBoxEx (CONFIRM_OK, "default : ���� �� �׷��ε���");
//							GET_HDINDEX();//������ �� �׷��ε��� 
						else
						{
//							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT SEQ, (IDX+CNT) AS TOT FROM  NORMAL_GROUP WHERE IDX <= ? AND TOT > ?",  g_lindex);
							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT CNT  FROM  NORMAL_GROUP WHERE CNT > ?",  g_lindex);
							if( m_lpage % ROW >0 )
							{
								m_lpage = m_lpage / 10;
							}
							else
							{
								m_lpage = (m_lpage / 10) - 1;
							}
							if(m_lpage < 0)
							{
								m_lpage = 0;
							}
						}
						REDRAW();
						ON_DRAW();
						break;
				}
				break;
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_NADDR:
				//g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�
				if( g_nAddrFlag == 0)
					g_nAddrFlag = 1;
				else
					g_nAddrFlag = 0;
				REDRAW();
				ON_DRAW();
				break;
			case BID_UP:
				m_lpage--;
				if( m_lpage < 0)
				{
					m_lpage = 0;
					MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					REDRAW();
					ON_DRAW();
					return;
				}
				REDRAW();
				ON_DRAW();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage - 1 )
				{
					m_lpage = m_lTotpage-1;
					if( m_lpage < 0)
					{
						m_lpage = 0;
					}
					MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					REDRAW();
					ON_DRAW();
					return;
				}
				REDRAW();
				ON_DRAW();
				break;
			case BID_HOME:
				Card_Move("MENU");
				break;
			case BID_MENU:
				Card_Move("SC_MENU");
				break;
			case BID_KEYBOARD:
				Card_Move("SC_LST");
				break;
			case BID_SCREEN:
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
				Card_Move("SC_MENU");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}
	
//=======================================================================================
//=======================================================================================
	void	OnSelect(long Index)
	{
		long index = -1;
		
		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			
			// ���� �ε����� ���� �ε����� ���� �� ���
			if ( index-1 == m_ActIndex )
			{
				//���õ� ������ ��ġ INDEX�� �۷ι������� ����
				g_lindex = m_lindex[m_ActIndex];
//				SET_HDINDEX();
				Card_Move("SC_LST");
				return;
			}
			m_ActIndex = index - 1;//���õ� INDEX ����
		}
	}
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ�� �ڷḦ ���÷����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	bool REDRAW(void)
	{
		long i, idx;
		long j = 0;
		char sztmp[200];
		bool ret = FALSE;
		long lstartidx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//�׷� ����Ʈ�� �� ����
		g_Sql_RetInt("SELECT COUNT(*) FROM NORMAL_GROUP", &m_lTotpage);
		
		if( m_lTotpage % 10 > 0 )
		{
			m_lTotpage = (m_lTotpage / 10) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / 10;
		}
		
		if( m_lpage > m_lTotpage )
		{
			m_lpage = m_lTotpage;
		}
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

    //���߿� Ȯ�� �� ���ּ� �߰� ����
//		if( g_nAddrFlag == 0)
    	hstmt = sql->CreateStatement(sql, "SELECT TOWN, ADDR1_M, CNT FROM NORMAL_GROUP ORDER BY ROWID LIMIT ?, ?");
//		else
//			sql->CreateStatement(sql, "SELECT NEW_ROAD_NM, NEW_ADDR_M, CNT, GMCNT, CNT-GMCNT, IDX FROM NORMAL_GROUP ORDER BY SEQ LIMIT ?, ?");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
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
			ret = FALSE;
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0; i < ROW; i++)
		{
			if(sql->Next(sql) == FALSE)
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
//				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
//				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				continue;
			}
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			//�������� ����
/*			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'C', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			//������ ����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'C', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
*/			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			//�ε��� ��
			ret = Str_AtoI(sztmp);
			m_lindex[i] = ret;
			
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : SET_HDINDEX
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void SET_HDINDEX(void)
	{
		char sztmp[101];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "UPDATE GUMGROUP SET GMGP_INDEX= '%d' ", m_lpage+m_ActIndex, 0, 0);		
		g_Sql_DirectExecute(sztmp);
	}
	
	/*=======================================================================================
	�Լ��� : GET_HDINDEX
	��  �� : ���� �ε��� �о�´�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void GET_HDINDEX(void)
	{
		char sztmp[101];
		char szbuf[10];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		Str_Cpy(sztmp, "SELECT GMGP_INDEX FROM GUMGROUP LIMIT 0, ? ");	
			
		g_Sql_RetStr(sztmp, 4, szbuf);
		m_lpage = Str_AtoI(szbuf);
		if(m_lpage < 0)
			m_lpage = 0;
		if( m_lpage > 5000)
			m_lpage = 5000;
	}
	
//=======================================================================================
//=======================================================================================
	long SQLITE_IDXBYGETGRPSEQ(char* szSql, long idx)
	{
		long ret = -1, i = 0;
		char szBuf[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		sql->Begin(sql);
		
		i = 0;
		sql->Bind(sql, i++, 'X', &idx, 4, DECRYPT);
		sql->Bind(sql, i++, 'X', &idx, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == FALSE)
		{
			PRINT("::SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)&ret, 8, DECRYPT );
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
}
