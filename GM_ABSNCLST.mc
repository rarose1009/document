/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	���縮��Ʈ
----------------------------------------------------------------------------------*/
card GM_ABSNCLST
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
//��ħ ����Ʈ
		DEF_BUTTON_ID ( BID_NADDR )			//�ּ� ���
		DEF_BUTTON_ID ( BID_UP )			//����������
		DEF_BUTTON_ID ( BID_DOWN )			//����������
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�����ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//���θ��ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_HISTORY )		//�̷�
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
//��ħ ����Ʈ
		DEF_OBJECT_ID ( TXT_PAGE )			//������
		DEF_OBJECT_ID ( TXT_ADDR1 )			//�ּ�
		DEF_OBJECT_ID ( TXT_ADDR2 )			//�ּ�
		DEF_OBJECT_ID ( TXT_DATA1 )			//�Ϸ�
		DEF_OBJECT_ID ( TXT_DATA2 )			//�Ϸ� ��� ��
//�˻�
		DEF_OBJECT_ID ( TXT_ALONE )			//�ܵ�(üũ�ڽ�)
		DEF_OBJECT_ID ( TXT_TOGETHER )		//����(üũ�ڽ�)
		DEF_OBJECT_ID ( TXT_OBJNUM )		//�⹰��ȣ
		DEF_OBJECT_ID ( TXT_ADDR)			//�ּ�
		DEF_OBJECT_ID ( TXT_GOO )			//��
		DEF_OBJECT_ID ( TXT_DONG )			//��
		DEF_OBJECT_ID ( TXT_BUNJI )			//����
		DEF_OBJECT_ID ( TXT_HOSOO )			//ȣ��
		DEF_OBJECT_ID ( TXT_TGTADDR)		//�ּ�
		DEF_OBJECT_ID ( TXT_TGTHBDNM )		//�������ø�
		DEF_OBJECT_ID ( TXT_BDNM )			//�ǹ���
		DEF_OBJECT_ID ( TXT_HO )			//ȣ
		DEF_OBJECT_ID ( TXT_NWADDR )		//���ּ�
		DEF_OBJECT_ID ( TXT_NWGOO )			//��
		DEF_OBJECT_ID ( TXT_STREET )		//���θ�
		DEF_OBJECT_ID ( TXT_BONBUN )		//����
		DEF_OBJECT_ID ( TXT_BOOBUN )		//�ι�
//�˻�
		DEF_OBJECT_ID ( EDT_OBJNUM )		//�⹰��ȣ �Է�
		DEF_OBJECT_ID ( EDT_BUNJI )			//���� �Է�
		DEF_OBJECT_ID ( EDT_HOSOO )			//ȣ�� �Է�
		DEF_OBJECT_ID ( EDT_HO )			//ȣ �Է�
		DEF_OBJECT_ID ( EDT_BONBUN )		//���� �Է�
		DEF_OBJECT_ID ( EDT_BOOBUN )		//�ι� �Է�
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE_Srch )		//Ÿ��Ʋ
//�˻�
		DEF_OBJECT_ID ( CMB_SELECT ) 	//����Ʈ ��� ����
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table�� �ళ��
	#define		COL 	    9					// table�� ������
	#define		GRID_H		(CHT+33)			// table �� ����
	#define		GRID_H_P	(CHT+51)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+245  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+180  	    //table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�",     CWD*18+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"D",        CWD*4,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"C",        CWD*3,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ",     CWD*7,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��뷮",   CWD*7,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�",	 CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�", CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ROWID",    CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"COUNS_HIST",  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nActIndex = -1;		//���õ� row index
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szAdrss[120];		// ��� �ּ� ǥ��
	char m_szSql[2][800];
	char m_bFirst;				//INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	char m_szCobSel[20];		//�޺��ڽ�

	bool REDRAW(void);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	void SetBtnImg(void);
	void SetComboIdx(void);
	void OnList(quad lParam);
	void Grid_QuickList(long nBtnID);
	
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
	
	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ��ħ ����Ʈ"),

		DLG_BUTTON(STARTX,   	STARTY+65, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "�� ��"),
		DLG_BUTTON(STARTX+333,  STARTY+65, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		DLG_BUTTON(STARTX+666,  STARTY+65, 334, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),

		DLG_TEXT(STARTX,    	STARTY+135, 850, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),			//�⺻�ּ�
		DLG_BUTTON(STARTX+850,  STARTY+135, 150, 110, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISTORY, "�̷�"),

		DLG_TEXT(STARTX,    	STARTY+827, 333, 72, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� 		
		DLG_BUTTON(STARTX+333,  STARTY+827, 333, 72, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+666,  STARTY+827, 334, 72, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),		
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ��ħ ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX,       STARTY-40, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������
		DLG_BUTTON(STARTX+250, STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "����"),
		
		DLG_TEXT(STARTX,       STARTY+30, 850, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),			//�⺻�ּ�
		DLG_BUTTON(STARTX+850, STARTY+30, 150, 150, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISTORY, "�̷�"),

		DLG_BUTTON(STARTX+500, STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750, STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
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
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM GUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			g_lMoveFlag = 1;
			Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
			
			Card_Move("GM_ENTRY");
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
				g_nTelFlag = 0;
				g_nNameFlag = 0;
				g_lDataflag = 0;
				
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
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		
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

//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		char szcmb[20];
		char sztmp[30];
		char szAddr[200];
		
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
					//���õ� ������ ��ġ INDEX�� �۷ι������� ����
					//g_nWorkFlag :  101 -> �˻� , 102 -> ��ħ&�۽� �Ϸ� + ��ħ�Ϸ� & �۽� �̿Ϸ� , 103 -> �̰�ħ
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					Set_Index();
					g_lMoveFlag = 1;
					Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
					
					Card_Move("GM_ENTRY");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����
				
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr));
					Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
					Str_Cat(szAddr, "  ");
					Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), szAddr);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));

					Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
		
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), RED);
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), BTNMENUFRCOLOR);
					}
				}
			}
		}
	}

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR1), TRUE, 2, EDITSEP_NONE );
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				Grid_QuickList(ID);
				break;
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
				break;
			case BID_HISTORY:
				if( m_nActIndex < 0 )
				{
					MessageBoxEx (CONFIRM_OK, "����� �������ּ���.");
				}
				else
				{
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					Card_Move("GM_HISTORY");
				}
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					if(m_lTotpage > 0)
					{
						if( m_nActIndex == -1 )
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
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
					
					if(m_lTotpage > 0)
					{
						if( m_nActIndex == -1 )
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;		
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "��ħ �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
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
				Card_Move("GM_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}	

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotpage;
		char sztmp[201];
		char szProd_cd[10];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();


		g_Sql_SaveSeq( "SELECT ROWID FROM GUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", SREACH_FILE);
		
		lTotpage = FS_GetSrchTotCnt();
		m_lTotpage = lTotpage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		//ȭ�� �̵� �� �ε���
		if( g_lMoveFlag == 1)
		{
			//���α׷� ���� �� �ҷ����� �ε���
			//Get_Index();
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = (g_nActIndex % ROW);
			
			g_lMoveFlag = 0;
		}

		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotpage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, COUNS_HIST , PROD_CD, DISC_CUST_YN FROM GUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		else
			hstmt = sql->CreateStatement(sql, "SELECT Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, COUNS_HIST, PROD_CD, DISC_CUST_YN FROM GUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
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
			ret = FALSE;
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					continue;
				}
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				//idx = 0;
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				if( Str_Cmp(sztmp, "0") > 0 )
				{
					//�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					//idx = 1;
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//��������
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					//�跮���۾��ڵ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					//��ħ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					//��뷮
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//�⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					//ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 10, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
				}
				else
				{
					//�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					//idx = 2;
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//��������
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					//�跮���۾��ڵ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					//��ħ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					//��뷮
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//�⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					//ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 10, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
				}
				
				//COUNS_HIST
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 11, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );

				//PROD_CD
				Mem_Set( (byte*)szProd_cd, 0x00, sizeof(szProd_cd) );
				sql->GetValue(sql, 12, 'U', (long*)szProd_cd, 10, DECRYPT);
				
				if( Str_Cmp(szProd_cd, "�������") == 0 || Str_Cmp(szProd_cd, "������") == 0 || Str_Cmp(szProd_cd, "��������") == 0 || Str_Cmp(szProd_cd, "�ó��������") == 0)
				{
					
					//DISC_CUST_YN
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 20, DECRYPT);

					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), LIGHTPINK);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), LIGHTPINK);	
					}
					else
					{
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), BTNMENUFRCOLOR);
						EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), BTNMENUFRCOLOR);
						
					}

				}
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lTotpage > 0)
		{
			if( m_nActIndex == -1 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);


			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			Str_Cat(sztmp, "  ");
			Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), sztmp);
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			
			Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
			if( Str_Cmp(sztmp, "Y") == 0 )
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), RED);
			}
			else
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_HISTORY), BTNMENUFRCOLOR);
			}

			//g_lMoveFlag = 0;
			m_lIdxFlag = 1;
		}

		ON_DRAW();		
		return TRUE;
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
	
	/*=======================================================================================
	�Լ��� : Set_Index
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[301];	

		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '1' ", g_lindex, 0, 0);		
		g_Sql_DirectExecute(szSql);
		
		return;
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
		SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '1' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = (g_nActIndex % ROW);
	}

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
		SPRINT(szSql, "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		lRow = Str_AtoI(g_szROWID);
		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '1' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);


		return;
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
		
		char col_name[5][32] = {"�ּ�", "D", "C", "��ħ", "��뷮"};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"5","2","2","3","3"};
		char col_align[5][10]  = {"left", "center", "center","right", "right"};
	
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
			
			col_count = 5;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			if( nBtnID == BID_QUICK_ADDR )
			{
				JSON_SetValue	(hData	, 'C', "query",
	"select CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN \
	 ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE  \
	 ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END \
	,ifnull(BASE_YMD, ''),ifnull(MTR_WORK_CODE, ''),ifnull(INDI_SET_VC, ''),ifnull(INDI_QTY, '') \
	from gumdata WHERE MTR_WORK_CODE = '2' ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
								);
			}
			else
			{
				JSON_SetValue	(hData	, 'C', "query",
	"select CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN \
	 ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE  \
	 ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END \
	,ifnull(BASE_YMD, ''),ifnull(MTR_WORK_CODE, ''),ifnull(INDI_SET_VC, ''),ifnull(INDI_QTY, '') \
	from gumdata WHERE MTR_WORK_CODE = '2' ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
								);
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
			
			JSON_SetValue	(h		, 'C', "title"			, "���� ��ħ ����Ʈ");
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



