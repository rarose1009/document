/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_BEFOTGTLST
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
		DEF_BUTTON_ID ( BID_SIGN )
		DEF_BUTTON_ID ( BID_ADDR )		//�ּ�
		DEF_BUTTON_ID ( BID_UP )		//����������
		DEF_BUTTON_ID ( BID_DOWN )		//����������
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�����ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//���θ��ּ� ��ũ�� ȣ��
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//����Ʈ
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )			//��������
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
//����Ʈ
		DEF_OBJECT_ID ( CMB_SELECT )
//����Ʈ
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    8					// table�� �ళ��
	#define		COL 	    7					// table�� ������
	#define		GRID_H		(CHT+28)			// table �� ����
	#define		GRID_H_P	(CHT+40)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+285  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    // table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�������ø�", CWD*21+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"���",       CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"����",       CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"����",       CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���ּ�",   CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"�ǹ���ȣ",   CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"ROWID",      CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1	
	
	long m_lIdxFlag = 0;
	long m_lSubIndex = -1;
	long m_lSubpage = 0;
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nbuttonid = 0;		//m_nbuttonid = 0 ������ �˻� sql, m_nbuttonid = 1 �⹰��ȣ sql
	long m_nActIndex = -1;
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szAdrss[120];		// ��� �ּ� ǥ��
	char m_szSql[2][1000];
	char m_szQuickSql[1200];
	char m_bFirst;				//INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	char m_szSqlFlag = 0;		//m_szSqlFlag = 0 - �⺻����Ʈ, m_szSqlFlag = 1 - �˻��� ����Ʈ
	char m_szCobSel[20];
	
	void REDRAW(void);
	void Cmb_Filter(void);
	void SetStyle(void);
	bool Save_TotSign(void);
	bool Update_Nogood(void);
	void SetBtnImg(void);
	void SET_HDINDEX(void);
	void GET_HDINDEX(void);
	void SET_DTLINDEX(void);	//�󼼸���Ʈ �ε���
	void SetComboIdx(void);
	void OnList(quad lParam);
	void QuickList(long nBtnID);
	void Grid_QuickList(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ��������(����)"),
		
		DLG_BUTTON(STARTX+666,  STARTY+65, 334, 60, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "�ϰ�����"),
		
		DLG_BUTTON(STARTX    , STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+250, STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
//		DLG_BUTTON(STARTX+420, STARTY+200, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),
		DLG_BUTTON(STARTX+500, STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+220, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),				
		
		DLG_TEXT(STARTX,      STARTY+65,   333, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_TEXT(STARTX,      STARTY+125,  1000, 95, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//
		
		DLG_COMBO (STARTX+333, STARTY+65, 333, 250, 130, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "������ ��������(����)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
				
		DLG_BUTTON(STARTX+600,  STARTY-40, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "�ϰ�����"),
		DLG_BUTTON(STARTX    , STARTY+120, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+500, STARTY+120, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+120, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),				
		
		DLG_TEXT(STARTX,      STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_TEXT(STARTX,      STARTY+40, 1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//
		
		DLG_COMBO (STARTX+250, STARTY-40, 380, 350, 130, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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
		char szTmp[150];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Mem_Set((byte*)g_szROWID, 0x00, sizeof(g_szROWID));
			Str_ItoA(g_lindex, g_szROWID, 10);

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)g_szBLD_NUM, 0x00, sizeof(g_szBLD_NUM));
			SPRINT(szTmp, "SELECT BLD_NUM FROM BEFO_DATA WHERE  ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 10, g_szBLD_NUM);

			g_lDataflag = 0;
			g_lGrpCmbFlag = g_nWorkFlag;
			SET_HDINDEX();
			
			Card_Move("BF_BEFODETALST");
		}
		
		return;
	}

	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void	OnInit(char bFirst)
	{
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}
				
				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				
				if( g_lGrpCmbFlag == 511 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), g_szTown);
					Str_Cpy(m_szCobSel, g_szTown);							
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "��ü");
					Str_Cpy(m_szCobSel, "��ü");							
				}

				Cmb_Filter();
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
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList();
				break;
			case BID_SIGN:
				if( Save_TotSign() )
				{
					Cmb_Filter();
					REDRAW();
				}
				break;
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�");
					//ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "���θ�\n��ũ��");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����");
					//ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "����\n��ũ��");
				}

				REDRAW();
				if(m_nActIndex >= 0)
				{					
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
				}
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					return;
				}
				m_nActIndex = 0;
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
				m_nActIndex = 0;
				REDRAW();
				break;		
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( g_lGrpCmbFlag == 510 )
					{
						SET_HDINDEX();
					}
					else
					{
						SetComboIdx();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( g_lGrpCmbFlag == 510 )
					{
						SET_HDINDEX();
					}
					else
					{
						SetComboIdx();
					}
					Card_Move("BF_BEFOMENU");
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
				if( g_lGrpCmbFlag == 510 )
				{
					SET_HDINDEX();
				}
				else
				{
					SetComboIdx();
				}
				Card_Move("BF_BEFOMENU");
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
		char szcmb[20];

		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_nActIndex )
				{
					g_lDataflag = 0;	//����ȭ�� SaveInput() ����/������ flag
					
					g_nGrpIndex = m_lpage*ROW + index - 1;
					
					if( (m_lSubIndex != m_nActIndex) || (m_lSubpage != m_lpage) )
					{
						SET_DTLINDEX();
					}
					
					SET_HDINDEX();
					
					g_lGrpCmbFlag = g_nWorkFlag;
					
					Card_Move("BF_BEFODETALST");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����
				
					Mem_Set( (byte*)g_szBLD_NUM, 0x00, sizeof(g_szBLD_NUM) );
					Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID) );
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
					Str_Cpy(g_szBLD_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
					Str_Cpy(g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					
					return;
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ħ,�̰�ħ,��ü���)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				//�������� �ʱ�ȭ��Ų��.
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "��ü" ) == 0 )
					g_nWorkFlag = 510;
				else if( Str_Cmp(m_szCobSel, szcmb) == 0 )
				{
					g_nWorkFlag = 511;
					Mem_Set((byte*)g_szTown, 0x00, sizeof(g_szTown));
					Str_Cpy(g_szTown, szcmb);
				}
				
				m_lpage = 0;
				m_nActIndex = 0;
				Cmb_Filter();
				REDRAW();
			}
		}
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ü", 0, ICON_NONE);
		g_Sql_SetCombo("SELECT TOWN FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY TOWN ORDER BY TOWN", CMB_SELECT+2);

		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SELECT), "��ü");
		
		m_lpage = g_nGrpIndex/ROW;
		m_nActIndex = g_nGrpIndex% ROW+1;
	}

/*=======================================================================================
�Լ��� : REDRAW
��  �� : ȭ�� �ڷḦ ���÷����Ѵ�.
Param  : 
Return : TRUE :����
		 FALSE:������ �����ÿ� ����
========================================================================================*/
	void REDRAW(void)
	{
		long i, idx;
		long j = 0;
		long index;
		long lstartidx = 0;
		char sztmp[256];
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//�׷� ����Ʈ�� �� ����
		g_Sql_RetInt("select count(A.BLD_NUM) from (SELECT  BLD_NUM FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM) A", &m_lTotpage);

		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
/*
		if( m_lpage > m_lTotpage )
		{
			m_lpage = m_lTotpage;
		}
*/
		if( m_lIdxFlag == 0 )
		{
			GET_HDINDEX();
		}

		if( m_nActIndex == -1 )
		{
			m_nActIndex = 0;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		}
		else
		{
			hstmt = sql->CreateStatement(sql, m_szSql[1]);
		}

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
			goto Finally;
		}
		
		for (i=0; i < ROW; i++)
		{
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				break;
			}

			idx = 0;
			//�������ø�
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
			//����
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5   +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			//���˼�
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5   +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			//����Ϸ��
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5   +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			//�� �ּ�
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			//�ǹ���ȣ
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30  +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
			//ROWID
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5  +1, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
		}
		//sql->Commit(sql);
		
Finally:
		DelSqLite(sql);

		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)g_szBLD_NUM, 0x00, sizeof(g_szBLD_NUM) );
			Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID) );
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			Str_Cpy(g_szBLD_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			Str_Cpy(g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			
			m_lIdxFlag = 1;
		}

		return;
	}
	
	//-----------------------------------------------------------------------------------------------
	//�޺��ڽ��� �̿��� ��ü,����,������ ��� ����m_szCobSel
	//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[600];

		Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		if( Str_Cmp(m_szCobSel, "��ü") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM");
			g_nWorkFlag = 510;
		}
		else
		{
			SPRINT(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND TOWN = '%s' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", g_szTown, 0, 0 );
			g_nWorkFlag = 511;
		}

		g_Sql_SaveSeq( szRow, SREACH_FILE);

		if( Str_Cmp(m_szCobSel, "��ü") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ");
			Str_Cpy( m_szSql[1], "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ");
		}
		else
		{
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' AND TOWN = '%s' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ", g_szTown, 0, 0 );
			Str_Cpy( m_szSql[0], szRow);
			
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), COUNT(*), (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ), (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ), ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.CO_LIVE_NM,''), A.BLD_NUM, A.ROWID FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' AND TOWN = '%s' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM LIMIT ?, ? ", g_szTown, 0, 0 );
			Str_Cpy( m_szSql[1], szRow);
		}


	}
	
	
//-----------------------------------------------------------------------------------------------
	bool Save_TotSign(void)
	{
		bool ret = TRUE;
		char szSql[500];
		long idx, i;
		long lCount;
		long lsign, lSign_Len;
		char* pRst;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		
		//������ ���˿Ϸ����� ��	
		if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2)) != 0 )
		{
			MessageBoxEx (CONFIRM_OK, "������ �Ϸ��� �ϰ����� �ϼ���.");
			ret = FALSE;
			goto Finally;
		}
		
		//����
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		//lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��" );
		lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��", SIGN_OPT_NONE );
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			ret = FALSE;
			goto Finally;
		}
		else
		{
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}		

		//���������� �۽��÷��� ������Ʈ
		Update_Nogood();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE BEFO_DATA SET \
						CHK_EMPID = ?, CRT_EMPID = ?, CRT_IP = ?, SEND_FLAG = 'S', SIGN = ? \
						WHERE BLD_NUM = ? AND SINGLE_COLIVE_FLAG = '20' AND (CHK_RSLT='20' OR CHK_RSLT='21') \
						AND (SIGN IS NULL OR SIGN = '') "
					, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)pRst			 ,Str_Len(pRst) ,DECRYPT);	//����

		sql->Bind(sql, idx++, 'U', (long *)g_szBLD_NUM		        ,9  ,DECRYPT);


		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "�ϰ� ������ �Ϸ� �Ͽ����ϴ�.");
		}
		//sql->Commit(sql);
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		DelSqLite(sql);
		return ret;
	}
	
//--------------------------------------------------------------------------------------
	bool Update_Nogood(void)
	{
		char szSql[400];
		char szRow[10];
		char szCreate[10];
		char szMtr[10];
		long i, lCnt, Row;
		long ret;
//UPSIGNDATA_FILE
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM BEFO_DATA WHERE BLD_NUM = '%s' AND SINGLE_COLIVE_FLAG = '20' AND CHK_RSLT='21' ",g_szBLD_NUM, 0, 0   );
		ret = g_Sql_RetInt( szSql, &lCnt );
/*		if( ret != 1 )
		{
			return FALSE;
		}*/
		

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE BLD_NUM = '%s' AND SINGLE_COLIVE_FLAG = '20' AND \
		CHK_RSLT='21' AND (SIGN IS NULL OR SIGN = '') ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM "
		,g_szBLD_NUM, 0, 0 );		
		g_Sql_SaveSeq( szSql, UPSIGNDATA_FILE);

		for(i=0 ; i<lCnt ; i++)
		{
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			Mem_Set( (byte*)szCreate, 0x00, sizeof(szCreate) );
			Mem_Set( (byte*)szMtr, 0x00, sizeof(szMtr) );
			
			Str_ItoA(g_SREACHFILE_GetSeq(UPSIGNDATA_FILE, i), szRow, 10);

			//MTR_NUM , 
			SPRINT(szSql, "SELECT MTR_NUM FROM BEFO_DATA WHERE BLD_NUM = '%s' AND ROWID = '%s' AND SINGLE_COLIVE_FLAG = '20' AND \
			CHK_RSLT='21' AND (SIGN IS NULL OR SIGN = '') ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM "
			,g_szBLD_NUM, szRow, 0 );
			ret = g_Sql_RetStr( szSql, 10, szMtr );
/*			if( ret != 1 )
			{
				return FALSE;
			}*/
			
			//CREATE_YMD , CHK_RSLT='21' AND 
			SPRINT(szSql, "SELECT CREATE_YMD FROM BEFO_DATA WHERE BLD_NUM = '%s' AND ROWID = '%s' AND SINGLE_COLIVE_FLAG = '20' AND \
			CHK_RSLT='21' AND (SIGN IS NULL OR SIGN = '') ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM "
			,g_szBLD_NUM, szRow, 0 );
			ret = g_Sql_RetStr( szSql, 10, szCreate );
/*			if( ret != 1 )
			{
				return FALSE;
			}*/

			//���������� �۽��÷��� ������Ʈ
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE BEFO_NOGOOD_MAIN SET SEND_YN = 'S' WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s'  "
			, szCreate, szMtr, 0 );
			ret = g_Sql_DirectExecute( szSql );
/*			if( ret != 0 )
			{
				return FALSE;
			}*/
	
			//���������� �۽��÷��� ������Ʈ
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE BEFO_NOGOOD_DETAL SET SEND_YN = 'S' WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' "
			, szCreate, szMtr, 0 );
			ret = g_Sql_DirectExecute( szSql );
/*			if( ret != 0 )
			{
				return FALSE;
			}*/
		}

		return TRUE;
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
		
		//������ ���� GUBUN = 6 , PARAM9 -> �׷츮��Ʈ index , PARAM10 -> �󼼸���Ʈ index
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));

		SPRINT(sztmp, " UPDATE RCV_LOG SET PARAM9= '%d'  WHERE GUBUN = '6' ", g_nGrpIndex, 0, 0);		

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
		long lParam9 = 0;
		long lidx = 0;
	
		g_Sql_RetInt("SELECT PARAM9 FROM RCV_LOG WHERE GUBUN = '6'", &lParam9);

		m_lpage = (lParam9)/ROW;
		m_nActIndex = (lParam9)%ROW;
		
	    m_lSubIndex = m_nActIndex;
	    m_lSubpage = m_lpage;
	}
	
	
//========================================================================================
//�󼼸���Ʈ �ε��� �ʱ�ȭ
	void SET_DTLINDEX(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM10 = '0' WHERE GUBUN = '6' ", 0, 0, 0);		
		g_Sql_DirectExecute(szSql);
	}

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetComboIdx(void)
	{
		long i, idx;
		long k = ROW+1;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' GROUP BY BLD_NUM, COUNTY, TOWN, CO_LIVE_NM, BLD_NM ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		lRow = Str_AtoI(g_szROWID);
		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '6' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);


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
			JSON_SetValue ( js, 'C', "title", "����������(����) ����Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT  ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), ifnull(A.CO_LIVE_NM, '') ||' / ���:'|| COUNT(*) ||' / ����:'|| (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) ||' / ����:'|| (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "����������(����) ����Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT  ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), ifnull(A.CO_LIVE_NM, '') ||' / ���:'|| COUNT(*) ||' / ����:'|| (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) ||' / ����:'|| (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
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
	void Grid_QuickList(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		char szTmp[128];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"�������ø�", "���", "����", "����", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","1","1","1","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		Str_Cpy(m_szQuickSql, "SELECT \
 ifnull(A.CO_LIVE_NM, '') ||' '|| ifnull(A.BLD_NM,''),COUNT(*) \
 ,(SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) \
 ,(SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) \
 FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' ");

		if( Str_Cmp(m_szCobSel, "��ü" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
		}
		else //if( Str_Cmp(m_szCobSel, "�������ø�" ) == 0 )
		{
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szTmp, "AND TOWN = '%s'",g_szTown,0,0);
			
			Str_Cat(m_szQuickSql, szTmp);
			Str_Cat(m_szQuickSql, " GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
		}
	
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
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szQuickSql);
			
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
			
			JSON_SetValue	(h		, 'C', "title"			, "������ ��������(����)");
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

}
