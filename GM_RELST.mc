/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : GM_RELST
	Card Desc : ���, ���� ���� ����Ʈ
	Card Hist :
----------------------------------------------------------------------------------*/
card GM_RELST
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
//	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
	
		// ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )			// Ȩ
		DEF_BUTTON_ID ( BID_MENU )			// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )		// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )		// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )		// �������
		DEF_BUTTON_ID ( BID_PREV )			// ����
		DEF_BUTTON_ID ( BID_EXIT )			// ����
		
		// ��ħ ����Ʈ
		DEF_BUTTON_ID ( BID_NADDR )			// �ּ� ���
		DEF_BUTTON_ID ( BID_UP )			// ����������
		DEF_BUTTON_ID ( BID_DOWN )			// ����������
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	// �����ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	// ���θ��ּ� ��ũ�� ȣ��
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
	
		// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )	// Ÿ��Ʋ ������
		DEF_OBJECT_ID ( TXT_TITLE )		// Ÿ��Ʋ �ؽ�Ʈ
		
		// ��ħ ����Ʈ
		DEF_OBJECT_ID ( TXT_PAGE )		// ������
		DEF_OBJECT_ID ( TXT_ADDR1 )		// �ּ�
		DEF_OBJECT_ID ( TXT_ADDR2 )		// �ּ�
		DEF_OBJECT_ID ( TXT_DATA1 )		// �Ϸ�
		DEF_OBJECT_ID ( TXT_DATA2 )		// �Ϸ� ��� ��
		
		// ���̺�
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ

	END_OBJECT_ID()

	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����(�󼼸���Ʈ)
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6						// table�� �ళ��
	#define		COL 	    11						// table�� ������
	#define		GRID_H		(CHT+44)				// table �� ����
	#define		GRID_CLR	TRANSPARENT   			// table Ŭ���� color
	#define		GRID_X		STARTX 			    	// table ����x��ǥ
	#define		MAXCHAR		201 			    	// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+240  	    	// table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table������ row�� Y��
	char		m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"T",        		CWD*4,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�",     		CWD*17, 	EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"D",        		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"C",        		CWD*3,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ",     		CWD*8,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��뷮",   		CWD*8,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�",	 		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�", 		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ROWID",    		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"INST_PLACE_NUM",  CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"COUNS_HIST",  	CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	 1
	
	handle m_hGrid = NULL;
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nActIndex = -1;		// ���õ� row index
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szAdrss[120];		// ��� �ּ� ǥ��
	char m_szSql[2][800];
	char m_bFirst;				// INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	char m_szCobSel[20];		// �޺��ڽ�
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	bool REDRAW(void);
	void SetStyle(void);
	
	long FS_GetSrchTotCnt(void);
	void Set_Index(void);
	void Get_Index(void);
	
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	void OnList(quad lParam);
	
	void Rcv25012(void);
	long TR25012(void);
	
	SysButCtrl SysButRes_MAIN[] =
	{
		SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
		SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
	 	SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0 ),
		SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	
	//---------------------------------------------------------------------------------------
	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
				
		// Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��� �� ��������"),
		
		DLG_TEXT  (STARTX+550, STARTY+65,  200, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�Ϸ�"),
		DLG_TEXT  (STARTX+750, STARTY+65,  249, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_BUTTON(STARTX,     STARTY+65,  275, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		DLG_BUTTON(STARTX+275, STARTY+65,  275, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),
		
		// �⺻�ּ�
		DLG_TEXT  (STARTX,     STARTY+130, 1000, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		// �ϴ�
		DLG_TEXT ( STARTX,     STARTY+829, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+400, STARTY+829, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+600, STARTY+829, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		DLG_BUTTON(STARTX+800, STARTY+829, 199, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "�� ��"),
	};	

	//---------------------------------------------------------------------------------------
	//	main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
		
	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : OnInit
	��  �� : ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit(char bFirst)
	{
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
			
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
	
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : ����Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index = -1;
		char sztmp[20];
		char szAddr[200];
		
		if( INIT_MAIN == m_bFirst )
		{
			// ���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				// ���� �ε����� ���� �ε����� ���� �� ���
				if( index-1 == m_nActIndex )
				{
					// ���õ� ������ ��ġ INDEX�� �۷ι������� ����
					// g_nWorkFlag :  101 -> �˻� , 102 -> ��ħ&�۽� �Ϸ� + ��ħ�Ϸ� & �۽� �̿Ϸ� , 103 -> �̰�ħ
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					Set_Index();
					
					if( g_nWorkFlag == 101 ) // ���ð�ħ���� �̵��ϸ� 
					{
						g_nWorkFlag = 100;
					}
					
					Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
					
					Card_Move("GM_REENTRY");
					
					return;
				}
				else
				{
					m_nActIndex = index - 1; // ���õ� INDEX ����
				
					// ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr));
					Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					Str_Cat(szAddr, "  ");
					Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), szAddr);
				
					Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
					Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
					Mem_Set( (byte*)g_szINST_PLACE_NUM, 0x00, sizeof(g_szINST_PLACE_NUM));
					Str_Cpy( g_szINST_PLACE_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));	
				}
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnList
	��  �� : ����Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnList( quad lParam )
	{
		long i;
		
		i = lParam;
		
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM REGUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
			
			Card_Move("GM_REENTRY");
		}
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{
			/*****************************************/
			/* ���� ��ư                             */
			/*****************************************/
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
			
			/*****************************************/
			/* �Ϲ� ��ư                             */
			/*****************************************/
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				Grid_QuickList(ID);
				break;
			
			case BID_NADDR:
				// g_nAddrFlag = 0 -> ���ּ�, g_nAddrFlag = 1 -> ���ּ�
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
				
			case BID_UP:
			
				m_lpage--;
				
				if( m_lpage < 0 )
				{
					m_lpage = 0;
					
					if( m_lTotpage > 0 )
					{
						if( m_nActIndex < 0 )
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
				
				if( m_lpage > m_lTotpage - 1 )
				{
					m_lpage = m_lTotpage - 1;
					
					if( m_lpage < 0 )
					{
						m_lpage = 0;
					}
					
					if( m_lTotpage > 0 )
					{
						if( m_nActIndex < 0 )
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
				
		}
	}
	
	//---------------------------------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư �̹���
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
		
		// Ÿ��Ʋ
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		
		// ��ܰ���޴�
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

	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR1), TRUE, 2, EDITSEP_NONE );
		}
	}

	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ�� ���ΰ�ħ
	Param  : 
	Return : 
	========================================================================================*/
	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char szTitle[200];
		char sztmp[300];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/*****************************************/
		/* Ÿ��Ʋ                                */
		/*****************************************/
		Mem_Set((byte *)szTitle, 0x00, sizeof(szTitle));
		
		Str_Cpy(szTitle, "[");
		
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10'", 10, sztmp );
		
		Str_Cat(szTitle, sztmp);
		
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));		
		g_Sql_RetStr("SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10'", 5, sztmp );
		
		Str_Cat(szTitle, "/");
		Str_Cat(szTitle, sztmp);
		Str_Cat(szTitle, "] ��� �� ��������");
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_TITLE), szTitle);
		
		/*****************************************/
		/* ����Ʈ                                */
		/*****************************************/
		g_Sql_SaveSeq( "SELECT ROWID FROM REGUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", SREACH_FILE );

		lTotPage = FS_GetSrchTotCnt();
		
		m_lTotpage = lTotPage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0)
		{
			// ���α׷� ���� �� �ҷ����� �ε���
			Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, "SELECT GUM_TYPE, Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST FROM REGUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}
		else
		{
			hstmt = sql->CreateStatement(sql, "SELECT GUM_TYPE, Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST FROM REGUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}

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

		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for( i=0 ; i<ROW ; i++ )
		{
			// �ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
			}
			else
			{
				if( sql->Next(sql) == FALSE )
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				
				if( Str_Cmp(sztmp, "0") > 0 )
				{
					// Ÿ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
					
					if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "��" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "��" );
					}
					
					// �ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					
					// ��������
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					// �跮���۾��ڵ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					
					// ��ħ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					
					// ��뷮
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					
					// �⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					
					// ���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					
					// ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 11, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					
					// INST_PLACE_NUM
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 12, 'U', (long*)sztmp, 20, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					// COUNS_HIST
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
				}
				else
				{
					// Ÿ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
					
					if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "��" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "��" );
					}
					
					// �ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					
					// ��������
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					// �跮���۾��ڵ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					
					// ��ħ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					
					// ��뷮
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					
					// �⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					
					// ���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 10, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					
					// ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 11, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					
					// INST_PLACE_NUM
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 12, 'U', (long*)sztmp, 20, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					// COUNS_HIST
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
				}
			}
		}

	Finally:

		DelSqLite(sql);

		if( m_lTotpage > 0 )
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			// ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			Str_Cat(sztmp, "  ");
			Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), sztmp);
	
			Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
			Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
			Mem_Set( (byte*)g_szINST_PLACE_NUM, 0x00, sizeof(g_szINST_PLACE_NUM));
			Str_Cpy( g_szINST_PLACE_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10));

			m_lIdxFlag = 1;
			
			// ��ü
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) from REGUMDATA WHERE (SEND_YN = 'S' OR SEND_YN = 'Y') ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "0");
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
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '1' ", g_lindex, 0, 0);		
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
		
		// g_nGrpFlag = 0 > �׷츮��Ʈ->�󼼸���Ʈ �̵� //// g_nGrpFlag = 1 > ���˵��->�󼼸���Ʈ �̵�
		if( g_nGrpFlag == 0 )
		{
			// g_nActIndex = Str_AtoI(szbuf);
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = (g_nActIndex % ROW);
			
			g_nGrpFlag = 1;
		}
		else
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
			SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '1' ", 0, 0, 0);		
			g_Sql_RetStr(szSql, 4, szbuf);
		
			g_lindex = Str_AtoI(szbuf);
			g_nActIndex = g_Get_FsIndex(g_lindex, SREACH_FILE);
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = ((g_nActIndex) % ROW);
		}
	}
	
	/*=======================================================================================
	�Լ��� : Grid_QuickList
	��  �� : �� ��
	Param  : 
	Return : 
	========================================================================================*/
	void Grid_QuickList( long nBtnID )
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
		
		char col_name[5][32] = {"T", "�ּ�", "C", "��ħ", "��뷮"};
		char col_weight[5][10] = {"2", "5","2","3","3"};
		char col_align[5][10] = {"center", "center", "center","right", "right"};
	
		h = JSON_Create( JSON_Object );
		if( h )
		{
			hData = JSON_Create( JSON_Object );
			
			if( hData == NULL )
			{
				goto Finally;
			}

			JSON_SetValue( hData, 'C', "list_type", "GridListView" );
			// �� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ���� [true]�� �� �־�� �Ѵ�.
			// ���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ��� ���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�.
			JSON_SetValue( hData, 'C', "list_position_save", "true" );
			
			col_count = 5;
			JSON_SetValue( hData, 'X', "col_count", &col_count );

			col_height = 250;
			JSON_SetValue( hData, 'X', "col_height", &col_height );

			start_position = m_lpage * ROW + m_nActIndex;
			JSON_SetValue( hData, 'X', "start_position", &start_position );
			
			JSON_SetValue( hData, 'C', "bind_type", "query" );
			JSON_SetValue( hData, 'C', "dbname", "APP_DBF/SCGGAS.db" );
			
			if( nBtnID == BID_QUICK_ADDR )
			{
				JSON_SetValue( hData, 'C', "query", "SELECT CASE WHEN GUM_TYPE = '20' THEN '��' ELSE '��' END \
				                                          , CASE WHEN LENGTH(TRIM(CO_LIVE_NM)) + LENGTH(TRIM(BLD_NM)) > 0 THEN IFNULL(CO_LIVE_NM,'') ||' '|| IFNULL(BLD_NM,'') ||'-'|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') \
				                                                 ELSE IFNULL(ADDR1_M,'') ||'-'|| IFNULL(ADDR1_S,'') ||' '|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') END \
														  , IFNULL(MTR_WORK_CODE, '') \
														  , IFNULL(INDI_SET_VC, '') \
														  , IFNULL(INDI_QTY, '') \
													   FROM REGUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
							 );
			}
			else
			{
				JSON_SetValue( hData, 'C', "query", "SELECT CASE WHEN GUM_TYPE = '20' THEN '��' ELSE '��' END \
				                                          , CASE WHEN LENGTH(TRIM(CO_LIVE_NM)) + LENGTH(TRIM(BLD_NM)) > 0 THEN IFNULL(CO_LIVE_NM,'') ||' '|| IFNULL(BLD_NM,'') ||'-'|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') \
				                                                 ELSE IFNULL(NEW_ADDR_M,'') ||'-'|| IFNULL(NEW_ADDR_S,'') ||' '|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') END \
														  , IFNULL(MTR_WORK_CODE, '') \
														  , IFNULL(INDI_SET_VC, '') \
														  , IFNULL(INDI_QTY, '') \
													   FROM REGUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
							 );
			}
			
			hHead = JSON_Create( JSON_Array );
			
			if( hHead == NULL )
			{
				goto Finally;
			}		
	
			for ( i = 0; i < col_count; i++ )
			{
				JSON_AddArrayItem( hHead );
				JSON_SetArrayItem( hHead, 'C', "col_head", col_name[i] );
				JSON_SetArrayItem( hHead, 'C', "col_weight", col_weight[i] );
				JSON_SetArrayItem( hHead, 'C', "col_align", col_align[i] );
			}
			
			JSON_Attach( hData, "head", hHead );
			
			JSON_SetValue( h, 'C', "title", "��� �� ��������" );
			JSON_SetValue( h, 'C', "method", "ListViewActivity" );
			JSON_Attach( h, "data", hData );
		
			System_Call( "Native_System_Call", JSON_toString(h) );
		}
		
	Finally:
	
		if( h )
		{
			JSON_Finalize( h );
		}	
	
		if( hData )
		{
			JSON_Finalize( hData );
		}
			
		if( hHead )
		{
			JSON_Finalize( hHead );
		}	
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_Rcv25012
	��  �� : FR25012
	Param  : 
	Return : 
	========================================================================================*/	
	void Rcv25012(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char* sndbuf;
		char szReqym[20];
		char szDeadlineflag[20];
		long ret = 0;
		
		Mem_Set( (byte*)szReqym, 0x00, sizeof(szReqym) );
		g_Sql_RetStr( "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1'", 10, szReqym );
		
		Mem_Set( (byte*)szDeadlineflag, 0x00, sizeof(szDeadlineflag) );
		g_Sql_RetStr( "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1'", 5, szDeadlineflag );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25012, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",          szReqym );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",   szDeadlineflag );
		
		g_GM_Mtr_Add_Item(g_pjcomm);
		g_GM_Use_Cont_Num_Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25012;
		ret = HTTP_DownloadData( szUrl, "FR25012_IN",  "FR25012" , sndbuf, sztmp );
		
		return;		
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_TR25012
	��  �� : FR25012 CALLBACK
	Param  : 
	Return : 
	========================================================================================*/	
	long TR25012(void)
	{
		long lRet = -1;
		
		g_Sock_Close();
		
		if(g_Chk_Json(25012) >= 0)
		{
			lRet = g_GM_SetFR25012();
			
			MessageBoxEx (CONFIRM_OK, "��ħ �����͸� �ݿ� �Ϸ��߽��ϴ�.");
			REDRAW();
			return lRet;
		}
		else
		{
			return lRet;
		}
	}
}



