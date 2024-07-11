/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_BEFODETALST
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
	#define		ROW 	    7					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+28)			// table �� ����
	#define		GRID_H_P	(CHT+50)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+350  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    // table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"��-ȣ",        CWD*15+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"�⹰��ȣ",     CWD*16, EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"����",         CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���ּ�",     CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"ROWID",     CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1	
	
	long m_lCmbFlag = 0;
	long m_lIdxFlag = 0;
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nbuttonid = 0;		//m_nbuttonid = 0 ������ �˻� sql, m_nbuttonid = 1 �⹰��ȣ sql
	long m_nActIndex = -1;
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szAdrss[120];		// ��� �ּ� ǥ��
	char m_szSql[2][800];
	char m_szQuickSql[800];
	char m_bFirst;				//INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	char m_szSqlFlag = 0;		//m_szSqlFlag = 0 - �⺻����Ʈ, m_szSqlFlag = 1 - �˻��� ����Ʈ
	char m_szCobSel[20];
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Cmb_Filter(void);
	void Cmb_Result(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ��������(��������)"),
		
		DLG_BUTTON(STARTX+333, STARTY+65, 333, 60, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		
		DLG_TEXT(STARTX,        STARTY+65, 333, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������

		DLG_TEXT(STARTX,       STARTY+125, 185, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "���"), 		//����
		DLG_TEXT(STARTX+185,   STARTY+125, 150, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+335,   STARTY+125, 185, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "�̰�"), 	//������
		DLG_TEXT(STARTX+520,   STARTY+125, 150, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//
		DLG_TEXT(STARTX+670,   STARTY+125, 185, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "������"),	//�̽ǽ�
		DLG_TEXT(STARTX+855,   STARTY+125, 145, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 		//

		DLG_TEXT(STARTX,       STARTY+185, 1000, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//

		DLG_BUTTON(STARTX, 	   STARTY+285, 333, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+333, STARTY+285, 333, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),				
		DLG_BUTTON(STARTX+666, STARTY+285, 334, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		//DLG_BUTTON(STARTX+750, STARTY+285, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),
		
		DLG_COMBO (STARTX+666, STARTY+65, 334, 250, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "������ ��������(��������)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+200, STARTY-40, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+400, STARTY-40, 150, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+550, STARTY-40, 150, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),				
		
		DLG_TEXT(STARTX,      STARTY-40, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_TEXT(STARTX,      STARTY+40, 185, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "���"), 		//����
		DLG_TEXT(STARTX+185,  STARTY+40, 150, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+335,  STARTY+40, 185, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "�̰�"), 	//������
		DLG_TEXT(STARTX+520,  STARTY+40, 145, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//
		DLG_TEXT(STARTX+665,  STARTY+40, 185, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "������"),	//�̽ǽ�
		DLG_TEXT(STARTX+850,  STARTY+40, 150, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 		//					
		DLG_TEXT(STARTX,      STARTY+120, 1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//
		
		DLG_COMBO (STARTX+700, STARTY-40, 300, 250, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
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
		char szSql[250];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", g_szBLD_NUM, 0, 0 );
			g_Sql_SaveSeq( szSql, SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Set_Index();
			
			g_lDtlCmbFlag = g_nWorkFlag;
			Mem_Set( (byte*)g_szINS_JOIN, 0x00, sizeof(g_szINS_JOIN) );
			Mem_Set( (byte*)g_szINS_EXPLA, 0x00, sizeof(g_szINS_EXPLA) );
			
			Card_Move("BF_TGTCONFIRM");
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
				
				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				
				if( g_lDtlCmbFlag == 513 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "�̰�");
					Str_Cpy(m_szCobSel, "�̰�");							
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
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����");
				}
				REDRAW();
				if(m_nActIndex >= 0)
				{					
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
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
					if( g_lDtlCmbFlag == 512 )
					{
						Set_Index();
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
					if( g_lDtlCmbFlag == 512 )
					{
						Set_Index();
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
				if( g_lDtlCmbFlag == 512 )
				{
					Set_Index();
				}
				else
				{
					SetComboIdx();
				}
				g_lDtlCmbFlag = 0;
				Card_Move("BF_BEFOTGTLST");
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
					
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					
					Set_Index();
					
					g_lDtlCmbFlag = g_nWorkFlag;
					Mem_Set( (byte*)g_szINS_JOIN, 0x00, sizeof(g_szINS_JOIN) );
					Mem_Set( (byte*)g_szINS_EXPLA, 0x00, sizeof(g_szINS_EXPLA) );
					Card_Move("BF_TGTCONFIRM");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����
				
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
					Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID) );
					Str_Cpy(g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ħ,�̰�ħ,��ü���)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "�̰�" ) == 0 )
					g_nWorkFlag = 513;
				else if( Str_Cmp(m_szCobSel, "��ü" ) == 0 )
					g_nWorkFlag = 512;

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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ü", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "�̰�", 0, ICON_NONE);
		//g_Sql_SetCombo("SELECT TOWN FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' GROUP BY TOWN ORDER BY TOWN", CMB_SELECT+2);

		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SELECT), "��ü");
	}

//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		char sztmp[301];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		m_lTotpage = FS_GetSrchTotCnt();
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0 )
		{
			//���α׷� ���� �� �ҷ����� �ε���
			Get_Index();
		}

		if( m_nActIndex == -1 )
		{
			m_nActIndex = 0;
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		else
			hstmt = sql->CreateStatement(sql, m_szSql[1]);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
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
				//���̺� �ּ�
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//�⹰��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  20 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );		
				//���(����) , Decode(CHK_RSLT,'20','����','21','������','�̰�')
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2 +1, DECRYPT);
				if( Str_Cmp(sztmp, "20") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
				}
				else if( Str_Cmp(sztmp, "21") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "������" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "�̰�" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
				}
				//��� �ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//ROWID
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			}
		}
		//sql->Commit(sql);
			
Finally:
		DelSqLite(sql);
		
		Cmb_Result();
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
				
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID) );
			Str_Cpy(g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			
			m_lIdxFlag = 1;
		}
		
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
	
	//-----------------------------------------------------------------------------------------------
	//�޺��ڽ��� �̿��� ��ü,����,������ ��� ����m_szCobSel
	//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[800];

		Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
		if( Str_Cmp(m_szCobSel, "�̰�") == 0 )
		{
			SPRINT(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", g_szBLD_NUM, 0, 0 );
			g_nWorkFlag = 513;
		}
		else if( Str_Cmp(m_szCobSel, "��ü") == 0 )
		{
			SPRINT(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", g_szBLD_NUM, 0, 0 );
			g_nWorkFlag = 512;
		}
/*		else
		{
			SPRINT(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND TOWN = '%s'ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S", m_szCobSel, 0, 0 );
			g_nWorkFlag = 503;
		}
*/

		g_Sql_SaveSeq( szRow, SREACH_FILE);

		if( Str_Cmp(m_szCobSel, "�̰�") == 0 )
		{
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(BLD_NM, '') ||'-'|| ifnull(HOUSE_CNT, ''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(TOWN, '') ||' '|| ifnull(VILLAGE, '') ||' '|| ifnull(ADDR1_M, '') ||'-'|| ifnull(ADDR1_S, '') ||' '|| ifnull(CO_LIVE_NM, '') ||' '|| ifnull(BLD_NM, ''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM LIMIT ? , ?", g_szBLD_NUM, 0, 0 );
			Str_Cpy( m_szSql[0], szRow);
			
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(BLD_NM, '') ||'-'|| ifnull(HOUSE_CNT, ''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM, '') ||' '|| ifnull(NEW_ADDR_M, '') ||'-'|| ifnull(NEW_ADDR_S, ''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM LIMIT ? , ?", g_szBLD_NUM, 0, 0 );
			Str_Cpy( m_szSql[1], szRow);
		}
		else if( Str_Cmp(m_szCobSel, "��ü") == 0 )
		{
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(BLD_NM, '') ||'-'|| ifnull(HOUSE_CNT, ''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(TOWN, '') ||' '|| ifnull(VILLAGE, '') ||' '|| ifnull(ADDR1_M, '') ||'-'|| ifnull(ADDR1_S, '') ||' '|| ifnull(CO_LIVE_NM, '') ||' '|| ifnull(BLD_NM, ''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM LIMIT ? , ?", g_szBLD_NUM, 0, 0 );
			Str_Cpy( m_szSql[0], szRow);
			
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(BLD_NM, '') ||'-'|| ifnull(HOUSE_CNT, ''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM, '') ||' '|| ifnull(NEW_ADDR_M, '') ||'-'|| ifnull(NEW_ADDR_S, ''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM LIMIT ? , ?", g_szBLD_NUM, 0, 0 );
			Str_Cpy( m_szSql[1], szRow);
		}

		//�������� �ʱ�ȭ��Ų��.
		m_lpage = 0;
	}
	
	//-----------------------------------------------------------------------------------------------
	//�޺��ڽ��� �̿��� ��ü,����,������ ��� ����, ��� ��� Ȯ�κκ�
	//-----------------------------------------------------------------------------------------------
	void Cmb_Result(void)
	{
		char sztmp[20];
		char szSql[400];
		
		if( Str_Cmp(m_szCobSel, "��ü") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s'", g_szBLD_NUM, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) ", g_szBLD_NUM, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND CHK_RSLT = '21' AND BLD_NUM = '%s'", g_szBLD_NUM, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), sztmp); 
		}
		else if( Str_Cmp(m_szCobSel, "�̰�") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND BLD_NUM = '%s'", g_szBLD_NUM, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND BLD_NUM = '%s'", g_szBLD_NUM, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND CHK_RSLT = '21' AND BLD_NUM = '%s'", g_szBLD_NUM, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), sztmp); 
		}
		/*
		else
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND TOWN = '%s' ", m_szCobSel, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND SEND_FLAG = 'N' AND TOWN = '%s' ", m_szCobSel, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND CHK_RSLT = '21' AND TOWN = '%s' ", m_szCobSel, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), sztmp); 
		}
		*/
	}
	
	
	/*=======================================================================================
	�Լ��� : Set_Index
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM10 = %d WHERE GUBUN = '6' ", g_nActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);
	}
	
	/*=======================================================================================
	�Լ��� : Get_Index
	��  �� : ���� �ε��� �о�´�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Get_Index(void)
	{
		char szSql[201];
		char szbuf[10];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SPRINT(szSql, "SELECT PARAM10 FROM RCV_LOG  WHERE GUBUN = '6' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);

		m_lpage = g_nActIndex / ROW;
		m_nActIndex = g_nActIndex % ROW;
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
		SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM "
		, g_szBLD_NUM, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		lRow = Str_AtoI(g_szROWID);

		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM10 =%d WHERE GUBUN = '6' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);

		return;
	}

//---------------------------------------------------------------------------------------------------------------
	void QuickList(long nBtnID)
	{
		handle js = NULL;
		char szSql[600];
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		if( nBtnID == BID_QUICK_ADDR )
		{
			SPRINT(szSql, "SELECT ifnull(COUNTY, '') ||' '|| ifnull(TOWN, '') ||' '|| ifnull(VILLAGE, '') ||' '|| ifnull(ADDR1_M, '') ||'-'|| ifnull(ADDR1_S, '') ||' '|| ifnull(CO_LIVE_NM, '') ||' '|| ifnull(BLD_NM, ''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||' / �⹰��ȣ:'|| ifnull(MTR_ID_NUM, '') ||' / ����:'|| Case When CHK_RSLT = '20' Then '����' When CHK_RSLT = '21' Then '������' Else '�̰�' End From FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", g_szBLD_NUM, 0, 0);
		}
		else
		{
			SPRINT(szSql, "SELECT ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM, '') ||' '|| ifnull(NEW_ADDR_M, '') ||'-'|| ifnull(NEW_ADDR_S, ''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||' / �⹰��ȣ:'|| ifnull(MTR_ID_NUM, '') ||' / ����:'|| Case When CHK_RSLT = '20' Then '����' When CHK_RSLT = '21' Then '������' Else '�̰�' End From FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM", g_szBLD_NUM, 0, 0);
		}
		
		//nAddrType = 0 ���� ,, nAddrType = 1 ���θ�
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "����������(��������) ����Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			//JSON_SetValue ( js, 'C', "query", "SELECT  ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), ifnull(A.CO_LIVE_NM, '') ||' / ���:'|| COUNT(*) ||' / ����:'|| (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) ||' / ����:'|| (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
			JSON_SetValue ( js, 'C', "query", szSql);
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "����������(��������) ����Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			//JSON_SetValue ( js, 'C', "query", "SELECT  ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,''), ifnull(A.CO_LIVE_NM, '') ||' / ���:'|| COUNT(*) ||' / ����:'|| (SELECT COUNT(B.CHK_RSLT) FROM BEFO_DATA B WHERE (B.CHK_RSLT='20' OR B.CHK_RSLT='21') AND A.BLD_NUM = B.BLD_NUM ) ||' / ����:'|| (SELECT COUNT(D.CHK_RSLT) FROM BEFO_DATA D WHERE LENGTH(D.SIGN) > 0 AND A.BLD_NUM = D.BLD_NUM ) FROM BEFO_DATA A WHERE A.SINGLE_COLIVE_FLAG = '20' GROUP BY A.BLD_NUM, A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM ORDER BY A.COUNTY, A.TOWN, A.CO_LIVE_NM, A.BLD_NM");
			JSON_SetValue ( js, 'C', "query", szSql);
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
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"��-ȣ", "�⹰��ȣ", "����", "", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","2","1","0","0"};
		char col_align[5][10]  = {"left", "left", "center","", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		SPRINT(m_szQuickSql, "SELECT \
 ifnull(BLD_NM, '') ||'-'|| ifnull(HOUSE_CNT, ''), ifnull(MTR_ID_NUM, '') \
, Case When CHK_RSLT = '20' Then '����' When CHK_RSLT = '21' Then '������' Else '�̰�' End \
 FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '20' AND BLD_NUM = '%s' ",g_szBLD_NUM,0,0);

		if( Str_Cmp(m_szCobSel, "�̰�" ) == 0 )
		{
			Str_Cat(m_szQuickSql, " AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM");
		}
		else //if( Str_Cmp(m_szCobSel, "��ü" ) == 0 )
		{
			Str_Cat(m_szQuickSql, " ORDER BY COUNTY, TOWN, CO_LIVE_NM, BLD_NM");
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
			
			col_count = 3;
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
			
			JSON_SetValue	(h		, 'C', "title"			, "������ ��������(��������)");
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
