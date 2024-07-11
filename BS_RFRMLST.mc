/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_RFRMLST
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
		DEF_BUTTON_ID ( BID_ADDR )		//����
		DEF_BUTTON_ID ( BID_ADDR2 )		//���θ�
		DEF_BUTTON_ID ( BID_PREVPG )	//����������
		DEF_BUTTON_ID ( BID_NEXTPG )	//����������
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�����ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//���θ��ּ� ��ũ�� ȣ��
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
		DEF_OBJECT_ID ( TXT_PAGE )		//��������

		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    8					// table�� �ళ��
	#define		COL 	    4					// table�� ������
	#define		GRID_H		(CHT+37)			// table �� ����
	#define		GRID_H_P	(CHT+50)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+205  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+110  	    // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�/����",   CWD*25+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"����",        CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���",        CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���˽����ȣ",0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	long m_lpage;
	long m_lTotpage;
	char m_szCnt_page[20];
	long m_lActive = -1;
	long m_lDataCnt = 0;
		
	#define INIT_MAIN	1	
	
	void SetStyle(void);
	void REDRAW(void);
	void SetBtnImg(void);
	void OnList(quad lParam);
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	void SetClickData(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�����ǰ� ����Ʈ"),
		
		DLG_TEXT(STARTX,        STARTY+65, 500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		DLG_BUTTON(STARTX+750,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),
		
		DLG_BUTTON(STARTX,     STARTY+135, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+250, STARTY+135, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ�"),
		DLG_BUTTON(STARTX+500, STARTY+135, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+135, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, " ��"),				
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�����ǰ� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON( STARTX,     STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON( STARTX+250, STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ�"),
		
		DLG_TEXT(   STARTX,     STARTY+40, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������				
		DLG_BUTTON( STARTX+500, STARTY+40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, " ��"),
		DLG_BUTTON( STARTX+750, STARTY+40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, " ��"),				
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-25, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i;
		char szTmp[200];
		
		i = lParam;

		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM SPECIAL_NOGOOD", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "SELECT CHK_EXEC_NUM FROM SPECIAL_NOGOOD WHERE ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 12, g_szCHK_EXEC_NUM);
			
			SetClickData();			//�켱���� ���θ� ���� ������ ��
			
			/* 
			if( (Str_Cmp(stBs.PREUSE_CHK_WHY, "10") == 0 || Str_Cmp(stBs.PREUSE_CHK_WHY, "30") == 0)
			&& (Str_Cmp(stBs.SEND_YN, "Y") != 0 && Str_Cmp(stBs.SEND_YN, "S") != 0 ) )
			{
				MessageBoxEx (CONFIRM_OK, "�켱���� ����Դϴ�.\n������ ���� �������ּ���.");
				return;
			}
			*/
			
			g_nAddrFlag = 0;
			g_lMoveFlag = 1;
			Card_Move("BS_RFRMPRGRS");
		}
		
		return;
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
				
				g_nWorkFlag = 304;
				
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
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList(ID);
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;
				REDRAW();
				break;
			case BID_ADDR2:
				g_nAddrFlag = 1;
				REDRAW();
				break;
			case BID_PREVPG:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					
					break;
				}
				m_lActive = 0;
				REDRAW();
				break;			
			case BID_NEXTPG:
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
				m_lActive = 0;
				REDRAW();
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
				Card_Move("BS_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
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
			
			SetClickData();	

			// ���� �ε����� ���� �ε����� ���� �� ���
			if ( index-1 == m_lActive )
			{
				if( m_lDataCnt > 0 )
				{
				    /*
					if( Str_Cmp(stBs.SEND_YN, "Y") != 0 && Str_Cmp(stBs.SEND_YN, "S") != 0 )
					{
						MessageBoxEx (CONFIRM_OK, "�켱���� ����Դϴ�.\n������ ���� �������ּ���.");
						return;
					}
					*/
				}
				
				g_nAddrFlag = 0;
				g_lMoveFlag = 1;
				
				g_nActIndex = m_lpage*ROW + index - 1;
				Card_Move("BS_RFRMPRGRS");
				return;
			}
			else
			{
				m_lActive = index-1;
				
				Str_Cpy( g_szCHK_EXEC_NUM,  DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3) );
			}
		}
	}
	
	//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW + 1;
		long lTotpage;
		char sztmp[201];
		long ret = -1;	
		long lstartidx ;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_RetInt( " SELECT COUNT(*) FROM SPECIAL_NOGOOD ", &m_lTotpage );
		lTotpage = m_lTotpage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( g_lMoveFlag == 1 )
		{
			m_lpage = g_nActIndex / ROW;
			m_lActive = (g_nActIndex % ROW);
			
			g_lMoveFlag = 0;
		} 

		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotpage);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
			hstmt = sql->CreateStatement(sql, " SELECT ifnull(TOWN,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||'\n'|| ifnull(SECOND_ADDR,''), PRESS_FLAG, END_YN, CHK_EXEC_NUM FROM SPECIAL_NOGOOD ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ? ");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), FALSE );
			hstmt = sql->CreateStatement(sql, " SELECT ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||'\n'|| ifnull(SECOND_ADDR,''), PRESS_FLAG, END_YN, CHK_EXEC_NUM  FROM SPECIAL_NOGOOD ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2 LIMIT ?, ? ");
		}
				
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
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
					continue;
				}
				//�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				idx = 0;
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//�з�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				if(sztmp[0] == 'L')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "����" );
				else if(sztmp[0] == 'M')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�߾�");
				else if(sztmp[0] == 'R')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�߰���" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 1,  "");
				//���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				if(sztmp[0] == 'Y')
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "�Ϸ�" );
				else if(sztmp[0] == 'S')
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����");
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "�̰�");				
				
				//���˽����ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 13, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
	
		if( m_lTotpage > 0 )
		{
			if( m_lActive == -1 )
			{
				m_lActive = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_lActive+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActive+1, TABLEACTIVE_COLOR);
			
			Str_Cpy( g_szCHK_EXEC_NUM,  DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3) );
		}
		ON_DRAW();
		return;
	}
	
//---------------------------------------------------------------------------------------------------------------
	void QuickList(long nBtnID)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		//nAddrType = 0 ���� ,, nAddrType = 1 ���θ�
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "Ư������ �����ǰ���Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(TOWN,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||'\n'|| ifnull(SECOND_ADDR,''), ifnull(SPECIAL_NM, '') ||' / ����:'|| Case When PRESS_FLAG = 'L' Then '����' When PRESS_FLAG = 'M' Then '�߾�' When PRESS_FLAG = 'R' Then '�߰���' Else '' End ||' / ���:'|| Case When END_YN = 'Y' Then '�Ϸ�' When END_YN = 'S' Then '����' Else '����' End FROM SPECIAL_NOGOOD ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "Ư������ �����ǰ���Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||'\n'|| ifnull(SECOND_ADDR,''), ifnull(SPECIAL_NM, '') ||' / ����:'|| Case When PRESS_FLAG = 'L' Then '����' When PRESS_FLAG = 'M' Then '�߾�' When PRESS_FLAG = 'R' Then '�߰���' Else '' End ||' / ���:'|| Case When END_YN = 'Y' Then '�Ϸ�' When END_YN = 'S' Then '����' Else '����' End FROM SPECIAL_NOGOOD ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
		}

		sztmp = JSON_toString(js);
		
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
	}
	
	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(long nBtnID)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"�ּ�/����", "����", "���", "", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","1","1","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			//�� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ����
			//true�� �� �־�� �Ѵ�.
			//���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ���
			//���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lActive;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue	(hData	, 'C', "query", "SELECT \
ifnull(TOWN,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||'\n'|| ifnull(SECOND_ADDR,'') \
,Case When PRESS_FLAG = 'L' Then '����' When PRESS_FLAG = 'M' Then '�߾�' When PRESS_FLAG = 'R' \
 Then '�߰���' Else '' End \
,Case When END_YN = 'Y' Then '�Ϸ�' When END_YN = 'S' Then '����' Else '����' End \
FROM SPECIAL_NOGOOD ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
		}
		else
		{
			JSON_SetValue	(hData	, 'C', "query", "SELECT \
ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||'\n'|| ifnull(SECOND_ADDR,'') \
,Case When PRESS_FLAG = 'L' Then '����' When PRESS_FLAG = 'M' Then '�߾�' When PRESS_FLAG = 'R' \
 Then '�߰���' Else '' End \
,Case When END_YN = 'Y' Then '�Ϸ�' When END_YN = 'S' Then '����' Else '����' End \
FROM SPECIAL_NOGOOD ORDER BY TOWN, ADDR1_M, ADDR1_S, SECOND_ADDR, ZIP_NO1, ZIP_NO2");
		}
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "�����ǰ� ����Ʈ");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}
	
	//========================================================================================
	void SetClickData(void)
	{
		long i, idx;
		char szSql[500];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)&stBs, 0x00, sizeof(stBs));
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT SEND_YN, PREUSE_CHK_WHY FROM SPECIAL_DATA WHERE CHK_EXEC_NUM = ? ", 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCHK_EXEC_NUM, 12, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		//��� ���� ���� �ʱ�ȭ
		m_lDataCnt = 0;
		
		if(sql->Next(sql) == TRUE)
		{
			idx = 0;

			Mem_Set( (byte*)stBs.SEND_YN, 0x00, sizeof(stBs.SEND_YN) );
			sql->GetValue( sql, idx++, 'U', (long*) stBs.SEND_YN   , 1 + 1, DECRYPT );
			
			Mem_Set( (byte*)stBs.PREUSE_CHK_WHY, 0x00, sizeof(stBs.PREUSE_CHK_WHY) );
			sql->GetValue( sql, idx++, 'U', (long*) stBs.PREUSE_CHK_WHY   , 2 + 1, DECRYPT );
			
			m_lDataCnt = 1;
		}
		
Finally:

		DelSqLite(sql);
		return;
	}
	

}

