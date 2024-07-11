/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_DAYRCV
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
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_QUICK_CHK )
		DEF_BUTTON_ID ( BID_ALL )		//�ڷ����
		DEF_BUTTON_ID ( BID_RECV )		//�ڷ����
		DEF_BUTTON_ID ( BID_UP )
		DEF_BUTTON_ID ( BID_DOWN )
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
		
		DEF_OBJECT_ID ( ICON_TITLE)		//Ÿ��Ʋ

		DEF_OBJECT_ID ( ID_TBLLIST ) // ���̺� ����Ʈ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    11					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+20)			// table �� ����
	#define		GRID_H_P	(CHT+25)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+125  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+40  	        //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�׷��ּ�", CWD*25, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���", CWD*9 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"", CWD*5+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"county", 0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"town", 0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}

	};	
	
	long m_lpage = 0;			// ���� ������
	long m_lTotCnt = 0;
	long m_lTotpage = 0;
	char m_szCnt_page[10];
	long m_lActive;
	
	char m_szchk_type[3];
	char m_szcenter_cd[3];
	char m_szobj_ym[7];
	char m_szchkyear[5];
	char m_szchkorder[3];
	
	long mCnt411320 = 0;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Save_Row(long row);
	void Sel_All(void);
	
	long TR411320(void);
	void Rev411320(void);
	long TR411321(void);
	void Rev411321(void);
	long TR411322(void);
	void Rev411322(void);
	long TR411323(void);
	void Rev411323(void);
	long TR411324(void);
	void Rev411324(void);
	long TR411325(void);
	void Rev411325(void);
	long Add_Item(handle pj);	
	
	void Grid_CheckLst(void);
	void Grid_CheckRet(char* szRet);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�����ڷ� ����"),
		
		//DLG_TEXT(STARTX, STARTY+820, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		
		DLG_TEXT(STARTX,       STARTY+65, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������				
//		DLG_BUTTON(STARTX+250, STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_CHK, "üũ\n��ũ��"),
		DLG_BUTTON(STARTX+500, STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+750, STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),	
		
		DLG_BUTTON(STARTX,  	STARTY+840, 300, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ALL, "����������"),		
		DLG_BUTTON(STARTX+700,  STARTY+840, 300, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�������� �ڷ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		//DLG_TEXT(STARTX, STARTY+770, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		
		DLG_TEXT(   STARTX,     STARTY-40, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������				
		DLG_BUTTON( STARTX+500, STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON( STARTX+750, STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		DLG_BUTTON(STARTX,      STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ALL, "����������"),
		DLG_BUTTON(STARTX+600,  STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),
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
						SetBtnImg();
						REDRAW();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						SetBtnImg();
						REDRAW();
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				REDRAW();
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
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;
			case BID_ALL:
				Sel_All();
				REDRAW();
				break;
								
			case BID_RECV:
				Rev411320();
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
	
	//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		char sztmp[20];
	
		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
						
			// ���� �ε����� ���� �ε����� ���� �� ���
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, index-1, 2) );
			if( Str_Cmp( sztmp, CHKOFF) == 0 )
			{
				DlgTbl_SetStr ( ID_TBLLIST, index-1, 2, CHKON );
				EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, index-1, 2 ), RED);

			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, index-1, 2, CHKOFF );
				EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, index-1, 2 ), BLUE );
			}
			
			m_lActive = index - 1;
			Save_Row(m_lActive);
			ON_DRAW();
		}
		else
		{
			DlgTbl_SetActive(ID_TBLLIST, m_lActive+1);
			ON_DRAW();
		}
	}
	
	//��������������������������������������������������������������������������������������������
	void	OnTask(long nEvent, long nData)
	{
		char* szRet;
		long nRet = 0;

		if( nEvent == 1 )
		{
			szRet = (char*)System_GetResult((char*)&nRet);
			//PRINT("EVENT >>>>>>>>>>>>>>>>>>>>>>quick view ret : %s",szRet,0,0);		
			
			Grid_CheckRet(szRet);	
		}
	}
	
	//��������������������������������������������������������������������������������������������
	void REDRAW(void)
	{
	long i, idx;
	long k = ROW + 1;
	char sztmp[201];
	long ret = -1;	
	long lstartidx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		g_Sql_RetInt( "SELECT COUNT(*) FROM SPECIAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ", &m_lTotpage );
			
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT COUNTY||' '|| TOWN, CNT, CHK_YN, COUNTY, TOWN FROM SPECIAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL LIMIT ?, ? " );

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
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
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
					continue;
				}
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 60, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 8, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				if(sztmp[0] != '1')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKOFF );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKON );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), RED);
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 31, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 31, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
			}
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		ON_DRAW();
	}
	
	void Save_Row(long row)
	{
	char sztmp[20];
	char szSql[300];
	char szCOUNTY[31];
	char szTOWN[31];
	char szCHK[2];
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szCHK ,0x00, sizeof(szCHK) );
		Mem_Set((byte*)szCOUNTY ,0x00, sizeof(szCOUNTY) );
		Mem_Set((byte*)szTOWN ,0x00, sizeof(szTOWN) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		
		Str_Cpy( sztmp,    DlgTbl_GetStr( ID_TBLLIST, row, 2) );
		Str_Cpy( szCOUNTY, DlgTbl_GetStr( ID_TBLLIST, row, 3) );
		Str_Cpy( szTOWN,   DlgTbl_GetStr( ID_TBLLIST, row, 4) );
		//���õ� ���
		if(Str_Cmp( sztmp, CHKON ) == 0)
		{
			szCHK[0] = '1';
		}
		else
		{
			szCHK[0] = '0';
		}
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		
		SPRINT(szSql, " UPDATE SPECIAL_GROUP SET CHK_YN = '%s' WHERE COUNTY = '%s' AND TOWN= '%s' ", szCHK, szCOUNTY, szTOWN);
		
		g_Sql_DirectExecute( szSql );
	}
	
	void Sel_All(void)
	{
	long i, idx;
	char szSql[200];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	char sztmp[21];
	long ret = -1;			
	char szCOUNTY[31];
	char szTOWN[31];
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "UPDATE SPECIAL_GROUP SET CHK_YN = '1' WHERE COUNTY = ? AND TOWN= ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Begin(sql);
		
		for (i=0 ; i<ROW ; i++)
		{
			Mem_Set((byte*)szCOUNTY ,0x00, sizeof(szCOUNTY) );
			Mem_Set((byte*)szTOWN ,0x00, sizeof(szTOWN) );
			
			Str_Cpy( szCOUNTY,   DlgTbl_GetStr( ID_TBLLIST, i, 3) );
			Str_Cpy( szTOWN,     DlgTbl_GetStr( ID_TBLLIST, i, 4) );
			
			if( Str_Len(szCOUNTY) == 0 )
			{
				break;
			}
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szCOUNTY   ,12,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szTOWN     ,10,DECRYPT);
			
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
		}
Finally:
		DelSqLite(sql);
		return;
	}
	
	
	
	
	
	void Rev411320(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT count(*) FROM SPECIAL_GROUP WHERE CHK_YN = '1' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &ret);
		if(ret <= 0)
		{
			MessageBoxEx (CONFIRM_OK, "�ڷḦ ������ �ּ���.");
			return;
		}
	
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) m_szchk_type, 0x00, sizeof( m_szchk_type) );
		SPRINT( szSql, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 3, m_szchk_type);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) m_szcenter_cd, 0x00, sizeof( m_szcenter_cd) );
		SPRINT( szSql, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 3, m_szcenter_cd);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) m_szobj_ym, 0x00, sizeof( m_szobj_ym) );
		SPRINT( szSql, "SELECT PARAM3 FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 3, m_szobj_ym);
		
		Mem_Set( (byte*) m_szchkyear, 0x00, sizeof( m_szchkyear) );
		Mem_Cpy( (byte*)m_szchkyear, (byte*)m_szobj_ym, 4);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)m_szchkorder, 0x00, sizeof(m_szchkorder));
		Mem_Cpy( (byte*)sztmp, (byte*)m_szobj_ym+4, 2 );
		if( Str_AtoI(sztmp) < 7 )
		{
			Str_Cpy(m_szchkorder, "10");
		}
		else
		{
			Str_Cpy(m_szchkorder, "70");
		}
			
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411320, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",  m_szchk_type);
		JSON_SetValue( g_pjcomm, 'C', "center_cd", m_szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobj_ym);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411320; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411320_IN",  "FR411320" , sndbuf, sztmp );
		
	}
	
	long TR411320(void)
	{
		mCnt411320 = g_Chk_Json(411320);
		if( mCnt411320 >= 0)
		{
			Rev411321();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev411321(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411321, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",  m_szchk_type);
		JSON_SetValue( g_pjcomm, 'C', "center_cd", m_szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobj_ym);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411321; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411321_IN",  "FR411321" , sndbuf, sztmp );
		
	}
	
	long TR411321(void)
	{
		if(g_Chk_Json(411321) >= 0)
		{
			Rev411322();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev411322(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411322, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",  m_szchk_type);
		JSON_SetValue( g_pjcomm, 'C', "center_cd", m_szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobj_ym);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411322; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411322_IN",  "FR411322" , sndbuf, sztmp );
		
	}
	
	long TR411322(void)
	{
		if(g_Chk_Json(411322) >= 0)
		{
			Rev411323();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev411323(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411323, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",  m_szchk_type);
		JSON_SetValue( g_pjcomm, 'C', "center_cd", m_szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobj_ym);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411323; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411323_IN",  "FR411323" , sndbuf, sztmp );
		
	}
	
	long TR411323(void)
	{
		if(g_Chk_Json(411323) >= 0)
		{
			Rev411324();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev411324(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411324, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",  m_szchk_type);
		JSON_SetValue( g_pjcomm, 'C', "center_cd", m_szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobj_ym);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411324; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411324_IN",  "FR411324" , sndbuf, sztmp );
		
	}
	
	long TR411324(void)
	{
		if(g_Chk_Json(411324) >= 0)
		{
			Rev411325();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rev411325(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411325, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_year" , m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order", m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type" , m_szchk_type);
		JSON_SetValue( g_pjcomm, 'C', "center_cd", m_szcenter_cd);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411325; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR411325_IN",  "FR411325" , sndbuf, sztmp );
		
	}
	
	long TR411325(void)
	{
	char szSql[200];
	
		g_Sock_Close();
		
		if(g_Chk_Json(411325) >= 0)
		{
		
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE SPECIAL_GROUP SET SEND_YN = 'Y' WHERE CHK_YN = '1' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			if(mCnt411320 > 0)
				MessageBoxEx (CONFIRM_OK, "�ڷ������ �Ϸ� �߽��ϴ�.");
			else
				MessageBoxEx (CONFIRM_OK, "�ڷᰡ �����ϴ�. Ȯ���� �ּ���.");
				
			m_lpage = 0;
			REDRAW();
			ON_DRAW();
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	long Add_Item(handle pj)
	{
	char szSql[500];
	char sztmp[20];
	long ret = -1;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	handle js = NULL;
	char szcounty[31];
	char sztown[31];
	char szUcounty[62];
	char szUtown[62];
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT county, town FROM SPECIAL_GROUP WHERE CHK_YN = '1' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ");
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
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szcounty,0x00, sizeof(szcounty) );
			Mem_Set( (byte*)sztown,0x00, sizeof(sztown) );
			sql->GetValue(sql, 0, 'U', (long*)szcounty, 31, DECRYPT);
			sql->GetValue(sql, 1, 'U', (long*)sztown, 31, DECRYPT);
			Mem_Set( (byte*)szUcounty,0x00, sizeof(szUcounty) );
			Mem_Set( (byte*)szUtown,0x00, sizeof(szUtown) );
			SQL_ConvUcStr( szUcounty, szcounty );
			SQL_ConvUcStr( szUtown, sztown );
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "county",  szUcounty );
			JSON_SetArrayItem(js, 'C', "town",    szUtown );
			ret =1;
		}
		
		JSON_Attach(pj, "item", js);
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return ret;
	}
	
	//------------------------------------------------------------------------
	void Grid_CheckLst(void)
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
		
		char col_name[5][32] = {"�׷��ּ�", "���", "", "", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","1","1","0","0"};
		char col_align[5][10]  = {"left", "center", "center", "", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridCheckView");
			//�� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ����
			//true�� �� �־�� �Ѵ�.
			//���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ���
			//���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			//�ּҰ� ǥ�õǴ� �ʵ尡 �����ؼ� ���α��̰� �ڵ������� �ȵȴٸ� 
			//�Ϲ� ���丮��Ʈ�� ���� ���� ������ �ʿ��ҰŰ����ϴ�.
			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lActive;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query",
"SELECT IFNULL(COUNTY, '') ||' '|| IFNULL(TOWN), CNT, CHK_YN \
FROM SPECIAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL"
								);

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
			
			JSON_SetValue	(h		, 'C', "title"			, "�����ڷ����");
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

	//------------------------------------------------------------------------
	void Grid_CheckRet(char* szRet)
	{
		char szSql[3000];
		char szTmp[100];
		char szFile[10];
		long fd;
		long i = 0, k = 0, idx = 0;
		long lCnt = 0;
		long lRet = 0;
		long lRowid = 0;
		long *nCol;
		char *pStr;
		char *szitem;
		char szType[2] = {0,0};
		handle hitem = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hitem = JSON_Create( JSON_Array );
		
		if( hitem != NULL)
		{
			JSON_toJson(hitem, szRet ) ;
			lCnt = JSON_GetArrayCount( hitem );
			
			if( lCnt > 0 )
			{
				g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = '0'" );

				g_Sql_SaveSeq( "SELECT COUNT(*) FROM SPECIAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL", SREACH_FILE);
//WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL
				fd = FFS_Open( SREACH_FILE, FS_READ_MODE, FS_NORMAL_FLAG);
				if(fd == -1)
				{
					MessageBoxEx (ERROR_OK, "������ ã���� �����ϴ�.");
					FFS_Flush(fd);
					FFS_Close(fd);
					return;
				}
				
				if( m_lTotCnt != lCnt )
				{
					Mem_Set((byte*) szSql, 0x00, sizeof( szSql) );
					Str_Cpy(szSql, "UPDATE NORMAL_GROUP SET CHK_YN = '1' WHERE ROWID IN (");
					for(i=0 ; i<lCnt ; i++)
					{
						Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
						nCol = (long*)JSON_GetArrayItem ( hitem, i, "check", szType);
						lRet = *nCol;
						//lRet = lRet+1;
						//PRINT("lRet : %d",lRet,0,0);
						
						//lRowid = g_SREACHFILE_GetSeq(SREACH_FILE, lRet);
						Mem_Set((byte*)szFile, 0x00, sizeof(szFile));
						if(FREAD(fd, lRet*SRCH_FS_SIZE+SRCH_FS_INDEX_POS, szFile, 8) == FALSE)
						{
							PRINT("Grid_CheckRet >> FREAD ERROR",0,0,0);
						  	FFS_Flush(fd);
							FFS_Close(fd);
							return;
						}
						if(Str_Len(szFile) == 0)
						{
							PRINT("Grid_CheckRet >> FILE LENGTH",0,0,0);
						  	FFS_Flush(fd);
							FFS_Close(fd);
							return;
						}
						lRowid = Str_AtoI(szFile);

						if(i > 0)
						{
							Str_Cat(szSql, ",");
						}

						Str_ItoA( lRowid, szTmp, 10);
						Str_Cat(szSql, szTmp);
						
						//PRINT("RCV_GRID_CHECK >>>>>> i : %d , Ret_Row : %s",i,szTmp,0);
						
					}
					
					Str_Cat(szSql, ")");
					//PRINT(">>>>>>>>>>>>>> %d , %s",Str_Len(szSql),szSql,0);
					g_Sql_DirectExecute( szSql );
				}
				else
				{
					g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = '1'" );
					
				}
				
				FFS_Flush(fd);
				FFS_Close(fd);
			}
			else
			{
				g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = '0'" );

			}
		}
		else
		{
			g_Sql_DirectExecute( "UPDATE NORMAL_GROUP SET CHK_YN = '0'" );
		}
		
Finally:		
		
		if(hitem != NULL)
		{
			JSON_Finalize(hitem);
			hitem = NULL;
		}

		g_Close_SubDlg();
		
		REDRAW();
		EvtDraw();
		
		return ;
	}
	
}
