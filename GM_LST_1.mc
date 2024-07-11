/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_LST_1
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SEARCH )	//�˻� 
		DEF_BUTTON_ID ( BID_NADDR )		//�ּ� ��� 
		DEF_BUTTON_ID ( BID_UP )		//�� ������
		DEF_BUTTON_ID ( BID_DOWN )		//�Ʒ� ������
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
		DEF_OBJECT_ID ( TXT_PAGE )		//������
		DEF_OBJECT_ID ( TXT_ADDR1 )		//�ּ�1
		DEF_OBJECT_ID ( TXT_ADDR2 )		//�ּ�2
		
		DEF_OBJECT_ID ( CMB_SELECT )
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    7					// table�� ������
	#define		GRID_H		(CHT+20)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX+20 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+210  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�",     CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"D",        CWD*4,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"C",        CWD*4,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ",     CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��뷮",   CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�",	 CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};	
	
	#define INIT_MAIN			1
	
	long	m_ActIndex = -1; 		//���� ���� ROW
	long 	m_lpage = 0;			// ���� ������
	long 	m_lTotpage = 0;			// �� ������
	char 	m_szCnt_page[10];		// ������ ǥ�� ����
	char 	m_szAdrss[201];			// ��� �ּ� ǥ��

	bool REDRAW(void);    //ȭ�� DLSPLAY
	void SET_INDEX(void); //������ ��� �ε��� ����
	void GET_INDEX(void); //���õ� ��� �ε��� �б�
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		
		//ȭ�� ���� �޴�
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "�޴�"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "����"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "ȭ��"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"����"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "����"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "����"),
		
		DLG_BUTTON(STARTX+550, STARTY, 420, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, " �� ��"),
		DLG_BUTTON(STARTX+330, STARTY, 210, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���ּ�"),
		DLG_BUTTON(STARTX+550, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+770, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),		
		
		DLG_TEXT(STARTX+20,  STARTY, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_TEXT(STARTX+20,  STARTY+110, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),			//�⺻�ּ�
		DLG_TEXT(STARTX+20,  STARTY+160, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),			//���ּ�
		
		DLG_COMBO (STARTX+20, STARTY+55, 350, 200, 70, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),		//��ħ,�̰�ħ,��ü ���� �޺�
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		
		//ȭ�� ���� �޴�
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "�޴�"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "����"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "ȭ��"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"����"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "����"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "����"),
		
		DLG_BUTTON(STARTX+550, STARTY, 420, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, " �� ��"),
		DLG_BUTTON(STARTX+330, STARTY, 210, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���ּ�"),
		DLG_BUTTON(STARTX+550, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+770, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),		
		
		DLG_TEXT(STARTX+20,  STARTY, 330, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_TEXT(STARTX+20,  STARTY+110, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),		//�⺻�ּ�
		DLG_TEXT(STARTX+20,  STARTY+160, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		//���ּ�
		
		DLG_COMBO (STARTX+20, STARTY+55, 350, 200, 70, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),		//��ħ,�̰�ħ,��ü ���� �޺�
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
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
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ü", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ħ", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "�̰�ħ", 0, ICON_NONE);
						SetStyle();
						
						//�ڷḦ INDEX�� �޾Ƽ� ù�������� ����ڷᰡ �ִ� ��������
						//���̰� �ϱ� ���ؼ�.
						m_lpage = g_lindex;	
						REDRAW();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ü", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ħ", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "�̰�ħ", 0, ICON_NONE);
						SetStyle();
						
						//�ڷḦ INDEX�� �޾Ƽ� ù�������� ����ڷᰡ �ִ� ��������
						//���̰� �ϱ� ���ؼ�.
						m_lpage = g_lindex;	
						REDRAW();
						break;		
				}
				break;
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}	

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_SEARCH:
				break;
			case BID_NADDR:
				//g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�
				if( g_nAddrFlag == 0)
					g_nAddrFlag = 1;
				else
					g_nAddrFlag = 0;
				REDRAW();
				if(m_ActIndex >= 0)
				{
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 5));
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 6));
				}
				ON_DRAW();
				break;
			case BID_UP:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					g_lindex = m_lpage;
					MessageBoxEx (ERROR_OK, "ù��° ������ �Դϴ�.");
					REDRAW();
					ON_DRAW();
					return;
				}
				g_lindex = m_lpage;
				REDRAW();
				ON_DRAW();
				break;			
			case BID_DOWN:
				m_lpage += ROW ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					g_lindex = m_lpage;
					MessageBoxEx (ERROR_OK, "������ ������ �Դϴ�.");
					REDRAW();
					ON_DRAW();
				}
				g_lindex = m_lpage;
				REDRAW();
				ON_DRAW();
				break;
			case BID_HOME:
				Card_Move("MENU");			
				break;
			case BID_MENU:
				Card_Move("GM_MENU");			
				break;
			case BID_KEYBOARD:
				Card_Move("GM_ENTRY");			
				break;
			case BID_SCREEN:
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
				Card_Move("GM_GRPLST");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}
	
	void	OnKey(long nKey)
	{
		//��Ű
		if(nKey == KEY_LSOFT_K)
		{
			OnButton(BID_PREV);
			return;
		}
	}
	
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
				g_lindex = m_lpage+m_ActIndex;
				SET_INDEX();			
				Card_Move("GM_ENTRY");
				return;
			}
			else
			{
				//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
				Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
				Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, index-1, 6));

				SPRINT(m_szCnt_page, "%d/%d", m_lpage+index, m_lTotpage, 0);
				m_ActIndex = index - 1;//���õ� INDEX ����
			}
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
	char sztmp[201];
	long ret = -1;	
	SQLITE sql = NewSqLite();
		
		m_lTotpage = FS_GetSrchTotCnt();
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		sql->Open(sql);
		if( sql->m_hdb == NULL )
		{
			DelSqLite(sql);
			return ret = -1;
		}
		
		if( g_nAddrFlag == 0)
			sql->CreateStatement(sql, "SELECT AREA, BASE_YMD, MTR_WORK_CODE, INDI_SET_VM, INDI_QTY, ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||' '|| ifnull(ADDR1_S,' '),  ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ')||'-'||ifnull(HOSU,' ') FROM GUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE LIMIT ?, ?");
		else
			sql->CreateStatement(sql, "SELECT AREA, BASE_YMD, MTR_WORK_CODE, INDI_SET_VM, INDI_QTY, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||' '|| ifnull(NEW_ADDR_S,' '), ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ')||'-'||ifnull(HOSU,' ') FROM GUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE LIMIT ?, ?");
			
		if( sql->m_hdb == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			sql->Close(sql);
			return ret;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'X', &m_lpage, 4, DECRYPT);
		i = m_lpage+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		sql->Execute(sql);
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW ; i++)
		{
			if( m_lpage+i+1 > m_lTotpage )//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					continue;
				}
				//�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				idx = 0;
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//��������
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//�跮���۾��ڵ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//��ħ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//��뷮
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//�⺻�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
			}			
		}
		
		sql->DeleteStatement(sql);
		sql->Commit(sql);
		sql->Close(sql);
		return TRUE;
	}
	
	/*=======================================================================================
	�Լ��� : SET_INDEX
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void SET_INDEX(void)
	{
		char sztmp[101];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "UPDATE GUMGROUP SET GM_INDEX= '%d' ", g_lindex, 0, 0);		
		g_Sql_DirectExecute(sztmp);
	}
	
	/*=======================================================================================
	�Լ��� : GET_INDEX
	��  �� : ���� �ε��� �о�´�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void GET_INDEX(void)
	{
		char sztmp[101];
		char szbuf[10];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		Str_Cpy(sztmp, "SELECT GM_INDEX FROM GUMGROUP LIMIT 0, ?");	
			
		g_Sql_RetStr(sztmp, 4, szbuf);
		g_lindex = Str_AtoI(szbuf);
		if(g_lindex < 0)
			g_lindex = 0;
		if( g_lindex > 5000)
			g_lindex = 5000;
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

