/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_GRPLST
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
		DEF_BUTTON_ID ( BID_NADDR )		//���ּ� 
		DEF_BUTTON_ID ( BID_UP )		//�� ������
		DEF_BUTTON_ID ( BID_DOWN )		//�Ʒ� ������
		
		DEF_BUTTON_ID ( BID_REFLESH )
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
		DEF_OBJECT_ID ( TXT_PAGE ) 		//������
		
		DEF_OBJECT_ID ( ID_TBLLIST ) 	// ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+23)			// table �� ����
	#define		GRID_H_P	(CHT+30)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 				// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+135  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+110  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	#define		GRID_ENDY_P	(GRID_Y_P+(ROW+1)*GRID_H_P) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"����", CWD*15, 	EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����", CWD*7 , 	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���", CWD*6 , 	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ", CWD*6 , 	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̰�", CWD*5+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	long    m_lSubIndex = -1;
	long    m_lSubpage = 0;
	long	m_ActIndex  = -1; 		// ���� ���� ROW
	long 	m_lpage = 0;			// ���� ������
	long 	m_lTotpage = 0;			// �� ������
	long 	m_lindex[ROW];			// �׷� ���� �ε���
	long    m_lIdxFlag = 0; 
	char 	m_szCnt_page[10];		// ������ ǥ�� ����
	
	bool	REDRAW(void);      //ȭ�� DLSPLAY
	void	GET_HDINDEX(void); //�������ε����� �׷� �ε��� ã��
	void	SET_HDINDEX(void); //�׷� �ε��� �����ϱ�	(���x)
	void	SetStyle(void);
	void	SetBtnImg(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�׷� ����Ʈ"),
		
		DLG_BUTTON(STARTX+735,   STARTY+5, 90, 50, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REFLESH, ""),
		
		DLG_BUTTON(STARTX,  	 STARTY+65, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "����"),
		
		DLG_TEXT(STARTX,    	STARTY+824, 350, 75, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), //����������/��������
		DLG_BUTTON(STARTX+500,  STARTY+824, 250, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+750,  STARTY+824, 250, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),	
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�׷� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX,       STARTY-40, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), //����������/��������
		DLG_BUTTON(STARTX,	   STARTY+30, 350, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "����"),
		DLG_BUTTON(STARTX+500, STARTY+30, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+750, STARTY+30, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),			
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
				g_nGrpFlag = 0;
				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				REDRAW();
				ON_DRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		//��ܰ���޴�
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
			
			
			h = Get_hDlgCtrlByID(BID_REFLESH);
			ButCtrl_SetImage( h,  g_pImgCm_Reflesh);
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
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NADDR), "���θ�");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NADDR), "����");
				}
				REDRAW();
				ON_DRAW();
				break;
			case BID_UP:
				m_lpage--;
				if( m_lpage < 0)
				{
					m_lpage = 0;

					if(m_lTotpage > 0)
					{
						if( m_ActIndex == -1 )
						{
							m_ActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_ActIndex = 0;
				REDRAW();
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
					
					if(m_lTotpage > 0)
					{
						if( m_ActIndex == -1 )
						{
							m_ActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_ActIndex = 0;
				REDRAW();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "��ħ �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					Card_Move("GM_MENU");
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
				g_lMoveFlag = 0;
				Card_Move("GM_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			
			case BID_REFLESH:
			
				if( MessageBoxEx (CONFIRM_YESNO, "�ڷḦ ���Źްڽ��ϱ�?")  == MB_OK)
				{
					g_GM_Rcv25012();
				}
				
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
				g_nWorkFlag = 100;
				g_nGrpFlag = 0;
				g_nActIndex = m_lindex[m_ActIndex];
				//SET_HDINDEX();
				Card_Move("GM_LST");
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
		long index;
		long lstartidx = 0;
		char sztmp[200];
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//�׷� ����Ʈ�� �� ����
		g_Sql_RetInt("SELECT COUNT(*) FROM GUMGROUP", &m_lTotpage);
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		//if( m_lpage > m_lTotpage )
		//{
		//	m_lpage = m_lTotpage;
		//}
		
		if( m_lIdxFlag == 0 )
		{
			GET_HDINDEX();
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, "SELECT TOWN, ADDR1_M, CNT, GMCNT, CNT-GMCNT, IDX FROM GUMGROUP ORDER BY SEQ LIMIT ?, ?");
		else
			hstmt = sql->CreateStatement(sql, "SELECT NEW_ROAD_NM, NEW_ADDR_M, CNT, GMCNT, CNT-GMCNT, IDX FROM GUMGROUP ORDER BY SEQ LIMIT ?, ?");

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
		
		for (i=0; i < ROW; i++)
		{
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
		}
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0; i < ROW; i++)
		{
			if(sql->Next(sql) == FALSE)
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				break;
			}

			idx = 0;
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			//��ħ����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			//��ħ�Ϸ����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			//�̰�ħ����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			//�ε��� ��			
			index = Str_AtoI(sztmp);
			m_lindex[i] = index;
		}
		
Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lTotpage > 0)
		{
			if( m_ActIndex < 0 )
			{
				m_ActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
			
			m_lIdxFlag = 1;
		}
		
		ON_DRAW();
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
		SPRINT(sztmp, " UPDATE RCV_LOG SET PARAM8= '%d'  WHERE GUBUN = '1' ", g_nActIndex, 0, 0);		

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
		char szSql[100];
		long lParam8 = 0;
		long lidx = 0;
	
		g_Sql_RetInt("SELECT PARAM8 FROM RCV_LOG WHERE GUBUN = '1'", &lParam8);
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT SEQ, (IDX+CNT) AS TOT FROM  GUMGROUP WHERE IDX <= %d AND TOT > %d ",lParam8, lParam8, 0   );
		g_Sql_RetInt(szSql, &lidx);

		m_lpage = (lidx-1)/ROW;
		m_ActIndex = (lidx-1)%ROW;
		
	    m_lSubIndex = m_ActIndex;
	    m_lSubpage = m_lpage;
		
		//g_lMoveFlag = 0;
	}
	
}
