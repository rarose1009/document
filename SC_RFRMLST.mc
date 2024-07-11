/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_RFRMLST
	Card Desc : �����ǰ� ����Ʈ
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_RFRMLST
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
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/* ����                         */
		/********************************/
		DEF_BUTTON_ID ( BID_HOME )			// Ȩ
		DEF_BUTTON_ID ( BID_MENU )			// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )		// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )		// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )		// �������
		DEF_BUTTON_ID ( BID_PREV )			// ����
		DEF_BUTTON_ID ( BID_EXIT )			// ����
		
		/********************************/
		/* ����                         */
		/********************************/
		DEF_BUTTON_ID ( BID_ADDR )			// ���� 
		DEF_BUTTON_ID ( BID_UP )			// �� ������
		DEF_BUTTON_ID ( BID_DOWN )			// �Ʒ� ������
		DEF_BUTTON_ID ( BID_QUICK )			// ��ũ�� ȣ��
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* �̵�������_Ÿ��Ʋ          */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )		// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )	// Ÿ��Ʋ
		
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( TXT_PAGE )		// ������
		DEF_OBJECT_ID ( TXT_ADDR1 )		// �ּ�1
		DEF_OBJECT_ID ( TXT_ADDR2 )		// �ּ�2
		DEF_OBJECT_ID ( TXT_ADDR3 )		// �ּ�3
		
		/********************************/
		/* ���̺�                       */
		/********************************/
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
		
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA1 )	// ����1
		DEF_OBJECT_ID ( LINE_DATA2 )	// ����2
		
		/********************************/
		/* �޺��ڽ�                     */
		/********************************/
		DEF_OBJECT_ID ( CMB_FILTER )	// CMB_FILTER
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Table���ǿ� ���õ� �����
	//---------------------------------------------------------------------------------------
	#define		ROW 	    7							// table�� �ళ��
	#define		COL 	    6							// table�� ������
	#define		GRID_H_H	(CHT+18)					// table ��� �� ����
	#define		GRID_H		(CHT+38)					// table �� ����
	#define		GRID_H_P	(CHT+50)					// table �� ����
	#define		GRID_CLR	TRANSPARENT   				// table Ŭ���� color
	#define		GRID_X		STARTX 	    				// table ����x��ǥ
	#define		GRID_Y		STARTY+223  	    		// table ����y��ǥ
	#define		GRID_Y_P	STARTY+130  	    		// table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) 	// table������ row�� Y��
	#define		GRID_ENDY_P	(GRID_Y_P+(ROW+1)*GRID_H_P) // table������ row�� Y��
	#define		MAXCHAR		201 			    		// table�� ���� �ִ� �ִ� char ����
	
	char m_szTableBuf [COL*(ROW+1)*MAXCHAR]; 			// �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	
	Column m_stGridTitle[] = {
		{"�ּ�/����" , CWD*21+23, EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���"        , CWD*8,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ȭ��ȣ"    , CWD*10,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�⺻�ּ�"    , CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�"    , CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���˽����ȣ", CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	1	
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lstartidx = 0;
	long m_lActIndex = -1;
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lDataCnt = 0;		// ������ ��� ���� ���� ��� ���� ����
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szChk_Exec_Num[15];
	char m_szSql[2000];			// SQL
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void SetCombo(void);
	void SetClickData(void);
	
	void Redraw(void);
	void TableDraw(void);
	
	long FS_GetSrchTotCnt(void);
	void OnList(quad lParam);
	void Grid_QuickList(void);
	
	void SetTableDrawData(void);
	void SetComboFilter(void);
	
	//---------------------------------------------------------------------------------------
	// main button img
	//---------------------------------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] = {
		SYS_BUT_IMG (  BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME,  0),
		SYS_BUT_IMG (  BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD,  0),
		SYS_BUT_IMG (  BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0),
		SYS_BUT_IMG (  BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK,  0),
		SYS_BUT_IMG (  BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0),
		SYS_BUT_IMG (  BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0),
		SYS_BUT_IMG (  BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0),
	};
	
	//---------------------------------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�����ǰ� ����Ʈ"),

		DLG_BUTTON(STARTX,      STARTY  +65,  275, 70,   0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX +275, STARTY  +65,  275, 70,   0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK, "����\n��ũ��"),
		DLG_COMBO (STARTX +550, STARTY  +65,  450, 70, 150, 70,   TXTFRCOLOR, TXTINCTRLBK   , CALL_FUNC, "", CMB_FILTER, 5),
		
		DLG_LINE  (STARTX,      STARTY +139, 1000, STARTY+139, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT ( STARTX,      STARTY +144, 1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),

		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_LINE  (STARTX,      STARTY +825, 1000, STARTY+825, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_TEXT ( STARTX,      STARTY +830,  350, 69, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX +350, STARTY +830,  325, 69, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX +675, STARTY +830,  325, 69, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
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
	void OnInit( char bFirst )
	{
		switch (bFirst)
		{
			case INIT_MAIN:
				
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				Redraw();
				TableDraw();
				
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton( long ID )
	{	
		switch( ID )
		{
			/****************************/
			/* ����                     */
			/****************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("SC_MENU");
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
				g_nWorkFlag = 200;
				Card_Move("SC_MENU");
				
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				
				break;
			
			/****************************/
			/* ����                     */
			/****************************/
			case BID_QUICK:
				Grid_QuickList();
				
				break;
				
			case BID_ADDR:
				if( g_nAddrFlag == 0 )
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				
				Redraw();
				TableDraw();
				
				break;
			
			case BID_UP:
				m_lpage--;
				
				if(m_lpage < 0)
				{
					m_lpage = 0;
					
					break;
				}
				m_lActIndex = 0;
				TableDraw();
				
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

					break;
				}
				
				m_lActIndex = 0;
				TableDraw();
				
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index = -1;
		long lActiveIndex = -1;
		long i = 0;
		char szTmp[100];
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);			 
		
		//���� TBL�� ���õǾ������� Ȯ��
		if ( DlgTbl_IsSelect(ID_TBLLIST) )
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
		
			//���˽����ȣ ����
			Mem_Set((byte*)m_szChk_Exec_Num, 0x00, sizeof(m_szChk_Exec_Num));
			
			if( g_nAddrFlag == 0)
			{
				Str_Cpy( m_szChk_Exec_Num,  DlgTbl_GetStr( ID_TBLLIST, index-1, 4) );
			}
			else
			{
				Str_Cpy( m_szChk_Exec_Num,  DlgTbl_GetStr( ID_TBLLIST, index-1, 5) );
			}

			SetClickData();	// �켱���� ���θ� ���� ������ ��

			// ���� �ε����� ���� �ε����� ���� �� ���
			if ( index - 1 == m_lActIndex )
			{
				// m_lDataCnt = 0 ��� ���� ���� , m_lDataCnt > 0 ��� ���� ����
				
				if( m_lDataCnt > 0 )
				{
					if( Str_Cmp(stSc.SEND_YN, "Y") != 0 && Str_Cmp(stSc.SEND_YN, "S") != 0 )
					{
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_FILTER) ) );
						
						i = g_SearchStr( szTmp, RFRM_COMBO );
						// 1 =  ��ü , 2 = ������, 3 = ����
						if( i == -1 )
						{
							MessageBoxEx (CONFIRM_OK, "������ ���� �������ּ���.");
						}
						else if( Str_Cmp( RFRM_COMBO[i].Code, "1" ) == 0 )
						{
							MessageBoxEx (CONFIRM_OK, "������ ���� �������ּ���.");
						}
						else if( Str_Cmp( RFRM_COMBO[i].Code, "2" ) == 0 )
						{
							MessageBoxEx (CONFIRM_OK, "�켱���� ����Դϴ�.\n������ ���� �������ּ���.");
						}
						else if( Str_Cmp( RFRM_COMBO[i].Code, "3" ) == 0 )
						{
							MessageBoxEx (CONFIRM_OK, "������ ���� �������ּ���.");       
						}
						
						return;
					}
				}
				
				g_lMoveFlag = 1;
				
				g_nActIndex = m_lpage*ROW + index - 1;
				
				Card_Move("SC_RFRMPRGRS");
				
				return;
			}
			else
			{
				m_lActIndex = index - 1;
			
				//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
				if( g_nAddrFlag == 0)
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 3));
					Str_Cpy( g_szCHK_EXEC_NUM,  DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4) );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 3));
					Str_Cpy( g_szCHK_EXEC_NUM,  DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5) );
				}
			}
		}
		else if( lActiveIndex == Get_iDlgCtrlByID(CMB_FILTER+1) )
		{
			g_nActIndex = 0;
			m_lpage = 0;
			
			SetComboFilter();
			
			TableDraw();
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnList
	��  �� : ��ȸ ���� ���
	Param  : 
	Return : 
	========================================================================================*/
	void OnList(quad lParam)
	{
		long i;
		char szTmp[500];
		i = lParam;
		
		if( i > -1 )
		{
			// 1 =  ��ü , 2 = ������, 3 = �ǰ�
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_FILTER) ) );
			
			i = g_SearchStr( szTmp, RFRM_COMBO );
		
			Str_Cpy(szTmp, "SELECT CHK_EXEC_NUM FROM NORMAL_NOGOOD NG ");
			
			if( i == -1 )
			{
				Str_Cat(szTmp, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
			
			}
			else if( Str_Cmp( RFRM_COMBO[i].Code, "1" ) == 0 )
			{
				Str_Cat(szTmp, "");
			
			}
			else if( Str_Cmp( RFRM_COMBO[i].Code, "2" ) == 0 )
			{
				Str_Cat(szTmp, "WHERE ( CASE WHEN ('N') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
			
			}
			else if( Str_Cmp( RFRM_COMBO[i].Code, "3" ) == 0 )
			{
				Str_Cat(szTmp, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
			
			}
			
			g_Sql_SaveSeq( szTmp, SREACH_FILE);
			
			g_nActIndex = lParam;
			Str_ItoA(g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex), g_szCHK_EXEC_NUM, 10);
			
			Mem_Set((byte*)m_szChk_Exec_Num, 0x00, sizeof(m_szChk_Exec_Num));
			
			Str_Cpy(m_szChk_Exec_Num, g_szCHK_EXEC_NUM);
			
			SetClickData();
			
			if( m_lDataCnt > 0 )
			{
				if( Str_Cmp(stSc.SEND_YN, "Y") != 0 && Str_Cmp(stSc.SEND_YN, "S") != 0 )
				{
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_FILTER) ) );
					
					i = g_SearchStr( szTmp, RFRM_COMBO );
					// 1 =  ��ü , 2 = ������, 3 = ����
					if( i == -1 )
					{
						MessageBoxEx (CONFIRM_OK, "������ ���� �������ּ���.");
					}
					else if( Str_Cmp( RFRM_COMBO[i].Code, "1" ) == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "������ ���� �������ּ���.");
					}
					else if( Str_Cmp( RFRM_COMBO[i].Code, "2" ) == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "�켱���� ����Դϴ�.\n������ ���� �������ּ���.");
					}
					else if( Str_Cmp( RFRM_COMBO[i].Code, "3" ) == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "������ ���� �������ּ���.");
					}
					
					return;
				}
			}
			
			g_lMoveFlag = 1;			
			Card_Move("SC_RFRMPRGRS");
		}
		
		return;
	}
	
	//---------------------------------------------------------------------------------------	
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------	
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_MIDDLE);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR1), TRUE, 2, EDITSEP_NONE );
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_FILTER), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
	}
	
	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;
		
		ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_FILTER+2 ) );
		
		for ( i = 0 ;  RFRM_COMBO[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_FILTER+2), RFRM_COMBO[i].Str, 0, ICON_NONE);
		}
	}
	
	/*=======================================================================================
	�Լ��� : Redraw
	��  �� : ȭ���� �ٽ� �׸���.
	Param  : 
	Return : 
	========================================================================================*/
	void Redraw(void)
	{
		long i;
	
		// �ּ� ��ư
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����");
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�");
		}
		
		// ���� ��ư
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK), "����\n��ũ��");
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK), "���θ�\n��ũ��");
		}
		
		// �޺��ڽ�
		i = g_SearchCD( g_szRfrmComboFlag, RFRM_COMBO );
		
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTER), RFRM_COMBO[1].Str);	
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTER), RFRM_COMBO[i].Str);
		}
		
		// �޺��ڽ� ����
		SetComboFilter();
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : TableDraw
	��  �� : ���̺��� �׸���.
	Param  : 
	Return : 
	========================================================================================*/
	void TableDraw(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[201];
		char szRow[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/*********************/
		/* TableDraw Setting */
		/*********************/
		SetTableDrawData();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, m_szSql );
		
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 7, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 7, DECRYPT);
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		for( i=0 ; i<ROW ; i++ )
		{
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
				
				idx = 0;
				
				/*******************/
				/* ����            */
				/*******************/
				if( g_nAddrFlag == 0)
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 5, DECRYPT);
					
					if( Str_Len(sztmp) > 0 )
					{
						// �ּ�/����
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					}
					else
					{
						// �ּ�/����
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					}
					
					// ���
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					if(Str_Cmp(sztmp, "Y") == 0)
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�Ϸ�" );
					}
					else if(Str_Cmp(sztmp, "S") == 0)
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "����" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�̰�" );
					}
	
					// ��ȭ��ȣ üũ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					if( Str_Len(sztmp) > 0 )
					{
						// ��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					}
					else
					{
						// ��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					}
					
					// CO_LIVE_NM
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 5, DECRYPT);
					
					if( Str_Len(sztmp) == 0 )
					{
						// �⺻�ּ�
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 8, 'U', (long*)sztmp, 100, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					}
					else
					{
						// �⺻�ּ�
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 9, 'U', (long*)sztmp, 100, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					}
	
					// ���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 10, 'U', (long*)sztmp, 12, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					
					// ȭ��ǥ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 11, 'U', (long*)sztmp, 12, DECRYPT);
					
					if( Str_Cmp(sztmp, "Y") ==0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BROWN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BROWN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BROWN);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
					}
				}
				/*******************/
				/* ���θ�          */
				/*******************/
				else
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 5, DECRYPT);
					
					if( Str_Len(sztmp) > 0 )
					{
						// �ּ�/����
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					}
					else
					{
						// �ּ�/����
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					}
					
					
					// ���
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					if(Str_Cmp(sztmp, "Y") == 0)
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�Ϸ�" );
					}
					else if(Str_Cmp(sztmp, "S") == 0)
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "����" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "�̰�" );
					}
	
					// ��ȭ��ȣ üũ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					if( Str_Len(sztmp) > 0 )
					{
						// ��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					}
					else
					{
						// ��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					}
					
					// �⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);

					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					
					// ���˽����ȣ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 12, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					
					// ȭ��ǥ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 12, DECRYPT);
					
					if( Str_Cmp(sztmp, "Y") ==0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BROWN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BROWN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BROWN);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
					}
				}
			}
		}
		
Finally:

		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			if( m_lActIndex == -1 )
			{
				m_lActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);

			if( g_nAddrFlag == 0)
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 3));
				Str_Cpy( g_szCHK_EXEC_NUM,  DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4) );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 3));
				Str_Cpy( g_szCHK_EXEC_NUM,  DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5) );
			}
			
			g_lMoveFlag = 0;
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
	
	/*=======================================================================================
	�Լ��� : SetClickData
	��  �� : ���̺� Ŭ�� Data Setting
	Param  : 
 	Return : 
	========================================================================================*/
	void SetClickData(void)
	{
		long i, idx;
		char szSql[500];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)&stSc, 0x00, sizeof(stSc));
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT SEND_YN FROM NORMAL_DATA WHERE CHK_EXEC_NUM = ? ", 0, 0, 0);
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)&m_szChk_Exec_Num, 12, DECRYPT);

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
			
			// �۽ſ���
			Mem_Set( (byte*)stSc.SEND_YN, 0x00, sizeof(stSc.SEND_YN) );
			sql->GetValue( sql, idx++, 'U', (long*) stSc.SEND_YN   , 1 + 1, DECRYPT );
			
			m_lDataCnt = 1;
		}
		
Finally:
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Grid_QuickList
	��  �� : ����
	Param  : 
 	Return : 
	========================================================================================*/
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
		
		char col_name[5][32] = {"�ּ�/����", "���", "��ȭ��ȣ", "", ""};
		char col_weight[5][10] = {"3","1","2","0","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
		
		char szSql[2000];
		char szTmp[500];
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			
			/*
			 	�� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ���� [true]�� �� �־�� �Ѵ�.
			 	���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ�� �� ���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�. 
			*/
			
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");	// true, false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			/***************************/
			/* 1. ADDR & BASIC SETTING */
			/***************************/
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			
			// ����
			if( g_nAddrFlag == 0)
			{
				Str_Cpy(szSql, "SELECT IFNULL(TOWN,'') ||' '|| IFNULL(VILLAGE,'') ||' '|| IFNULL(ADDR1_M,'') ||'-'|| IFNULL(ADDR1_S,'') ||' '|| IFNULL(CO_LIVE_NM,'') ||' '|| IFNULL(BLD_NM,'') ||'-'|| IFNULL(HOUSE_CNT,'') ||' '|| IFNULL(LOT_NUM_SECOND_ADDR,'') ||'/'|| IFNULL(CUST_NM, '') \
								     , CASE WHEN END_YN = 'Y' THEN '�Ϸ�' \
									        WHEN END_YN = 'S' THEN '����' \
									        ELSE '�̰�' \
									    END \
								     , CASE WHEN LENGTH(OWNHOUSE_TEL_EXN) > 1 THEN IFNULL(OWNHOUSE_TEL_DDD,'') ||'-'|| IFNULL(OWNHOUSE_TEL_EXN,'') ||'-'|| IFNULL(OWNHOUSE_TEL_NUM,'') \
									   	    ELSE IFNULL(CP_DDD,'') ||'-'|| IFNULL(CP_EXN,'') ||'-'|| IFNULL(CP_NUM,'') \
								        END ");
			} 
			// ���θ�
			else
			{
				Str_Cpy(szSql, "SELECT IFNULL(TOWN,'') ||' '|| IFNULL(VILLAGE,'') ||' '|| IFNULL(NEW_ROAD_NM,'') ||' '|| IFNULL(NEW_ADDR_M,'') ||'-'|| IFNULL(NEW_ADDR_S,'') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOUSE_CNT, '') ||' '|| IFNULL(LOT_NUM_SECOND_ADDR,' ') ||'/'|| IFNULL(CUST_NM, '') \
									 , CASE WHEN END_YN = 'Y' THEN '�Ϸ�' \
									        WHEN END_YN = 'S' THEN '����' \
									        ELSE '�̰�' \
									    END \
									 , CASE WHEN LENGTH(OWNHOUSE_TEL_EXN) > 1 THEN IFNULL(OWNHOUSE_TEL_DDD,'') ||'-'|| IFNULL(OWNHOUSE_TEL_EXN,'') ||'-'|| IFNULL(OWNHOUSE_TEL_NUM,'') \
											ELSE IFNULL(CP_DDD,'') ||'-'|| IFNULL(CP_EXN,'') ||'-'|| IFNULL(CP_NUM,'') \
										END ");
			}  
			
			/**************************/
			/* 3. TABLE SETTING		  */
			/**************************/
			Str_Cat(szSql, "FROM NORMAL_NOGOOD NG ");
			
			/**************************/
			/* 4. COMBO FILTER		  */
			/**************************/
			// 1 =  ��ü , 2 = ������, 3 = �ǰ�
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_FILTER) ) );
			
			i = g_SearchStr( szTmp, RFRM_COMBO );
			
			if( i == -1 )
			{
				Str_Cat(szSql, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
			}
			else if( Str_Cmp( RFRM_COMBO[i].Code, "1" ) == 0 )
			{
				Str_Cat(szSql, "");
			}
			else if( Str_Cmp( RFRM_COMBO[i].Code, "2" ) == 0 )
			{
				Str_Cat(szSql, "WHERE ( CASE WHEN ('N') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
			}
			else if( Str_Cmp( RFRM_COMBO[i].Code, "3" ) == 0 )
			{
				Str_Cat(szSql, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y' ORDER BY TOWN DESC , VILLAGE DESC , ADDR1_M DESC , ADDR1_S DESC");
			}
			
			JSON_SetValue( hData, 'C', "query", szSql );
			
			hHead = JSON_Create( JSON_Array );
			
			if( hHead == NULL )
			{
				goto Finally;
			}		
	
			for( i = 0; i < col_count; i++ )
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
	
		if( h )
		{
			JSON_Finalize(h);
		}	
	
		if( hData )
		{
			JSON_Finalize(hData);
		}
			
		if( hHead )
		{
			JSON_Finalize(hHead);
		}	
	}
	
	/*=======================================================================================
	�Լ��� : SetTableDrawData
	��  �� : ����
	Param  : 
 	Return : 
	========================================================================================*/
	void SetTableDrawData(void)
	{
		char szTmp[500];
		long i = 0;
		long lTotpage;
		
		/**************************/
		/* SQL SETTING START      */
		/**************************/
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		
		/***************************/
		/* 1. ADDR & BASIC SETTING */
		/***************************/
		// ����
		if( g_nAddrFlag == 0)
		{
			Str_Cpy(m_szSql, "SELECT LENGTH(TRIM(CO_LIVE_NM) + TRIM(BLD_NM)) \
								   , IFNULL(CO_LIVE_NM, '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOUSE_CNT, '') ||'/'|| IFNULL(CUST_NM, '') \
								   , IFNULL(ADDR1_M,'') ||'-'|| IFNULL(ADDR1_S,'') ||' '|| IFNULL(HOUSE_CNT, '') ||' '|| IFNULL(LOT_NUM_SECOND_ADDR,'') ||'/ '|| IFNULL(CUST_NM, '') \
								   , END_YN \
								   , LENGTH(OWNHOUSE_TEL_EXN) \
								   , IFNULL(OWNHOUSE_TEL_DDD,'') ||'-'|| IFNULL(OWNHOUSE_TEL_EXN,'') ||'-'|| IFNULL(OWNHOUSE_TEL_NUM,'') \
								   , IFNULL(CP_DDD,'') ||'-'|| IFNULL(CP_EXN,'') ||'-'|| IFNULL(CP_NUM,'') \
								   , LENGTH(CO_LIVE_NM) \
								   , IFNULL(TOWN,'') ||' '|| IFNULL(VILLAGE,'') ||' '|| IFNULL(ADDR1_M,'') ||'-'|| IFNULL(ADDR1_S,'') ||' '|| IFNULL(HOUSE_CNT,'') ||' '|| IFNULL(LOT_NUM_SECOND_ADDR,'') \
								   , IFNULL(TOWN,'') ||' '|| IFNULL(VILLAGE,'') ||' '|| IFNULL(ADDR1_M,'') ||'-'|| IFNULL(ADDR1_S,'') ||' '|| IFNULL(CO_LIVE_NM,'') ||' '|| IFNULL(BLD_NM,'') ||'-'|| IFNULL(HOUSE_CNT,'') \
								   , CHK_EXEC_NUM ");
		} 
		// ���θ�
		else
		{
			Str_Cpy(m_szSql, "SELECT LENGTH(TRIM(CO_LIVE_NM) + TRIM(BLD_NM)) \
								   , IFNULL(CO_LIVE_NM, '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOUSE_CNT, '') ||'/'|| IFNULL(CUST_NM, '') \
								   , IFNULL(NEW_ADDR_M,'') ||'-'|| IFNULL(NEW_ADDR_S,'') ||' '|| IFNULL(HOUSE_CNT, '') ||' '|| IFNULL(LOT_NUM_SECOND_ADDR,' ') ||'/ '|| IFNULL(CUST_NM, '') \
								   , END_YN \
								   , LENGTH(OWNHOUSE_TEL_EXN) \
								   , IFNULL(OWNHOUSE_TEL_DDD,'') ||'-'|| IFNULL(OWNHOUSE_TEL_EXN,'') ||'-'|| IFNULL(OWNHOUSE_TEL_NUM,'') \
								   , IFNULL(CP_DDD,'') ||'-'|| IFNULL(CP_EXN,'') ||'-'|| IFNULL(CP_NUM,'') \
								   , IFNULL(NEW_ROAD_NM,'') ||' '|| IFNULL(NEW_ADDR_M,'') ||'-'|| IFNULL(NEW_ADDR_S,'') \
								   , CHK_EXEC_NUM ");
		}  
		
		/**************************/
		/* 2. TABLE COLOR SETTING */
		/**************************/
		Str_Cat(m_szSql, ", ( CASE WHEN ( SELECT COUNT(1) \
											FROM NORMAL_NOGOOD_DETAL \
									       WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM \
											 AND ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' \
												OR CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' \
												OR CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' \
												OR CHK_SEC_CD = '30' AND NOT_PASS_ITEM_CD = '28' \
												OR CHK_SEC_CD = '30' AND NOT_PASS_ITEM_CD = '29' \
												OR CHK_SEC_CD = '30' AND NOT_PASS_ITEM_CD = '13' ) ) > 0 THEN 'Y' \
								   ELSE 'N' \
							   END ) ");
	
	    /**************************/
		/* 3. TABLE SETTING		  */
		/**************************/
		Str_Cat(m_szSql, "FROM NORMAL_NOGOOD NG ");
		
		/**************************/
		/* 4. COMBO FILTER		  */
		/**************************/
		// 1 =  ��ü , 2 = ������, 3 = �ǰ�
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_FILTER) ) );
		
		i = g_SearchStr( szTmp, RFRM_COMBO );
		
		if( i == -1 )
		{
			Str_Cat(m_szSql, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y' LIMIT ?, ? ");
		}
		else if( Str_Cmp( RFRM_COMBO[i].Code, "1" ) == 0 )
		{
			Str_Cat(m_szSql, "LIMIT ?, ? ");
		}
		else if( Str_Cmp( RFRM_COMBO[i].Code, "2" ) == 0 )
		{
			Str_Cat(m_szSql, "WHERE ( CASE WHEN ('N') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y' LIMIT ?, ? ");
		}
		else if( Str_Cmp( RFRM_COMBO[i].Code, "3" ) == 0 )
		{
			Str_Cat(m_szSql, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y' ORDER BY TOWN DESC , VILLAGE DESC , ADDR1_M DESC , ADDR1_S DESC LIMIT ?, ? ");
		}
		
		/**************************/
		/* 5. PAGE SETTING		  */
		/**************************/
		// 1 =  ��ü , 2 = ������, 3 = �ǰ�
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy(szTmp, "SELECT ROWID FROM NORMAL_NOGOOD NG ");
		
		if( i == -1 )
		{
			Str_Cat(szTmp, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
		
		}
		else if( Str_Cmp( RFRM_COMBO[i].Code, "1" ) == 0 )
		{
			Str_Cat(szTmp, "");
		
		}
		else if( Str_Cmp( RFRM_COMBO[i].Code, "2" ) == 0 )
		{
			Str_Cat(szTmp, "WHERE ( CASE WHEN ('N') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
		
		}
		else if( Str_Cmp( RFRM_COMBO[i].Code, "3" ) == 0 )
		{
			Str_Cat(szTmp, "WHERE ( CASE WHEN ('Y') IN ( SELECT EXCEP_PREUSE_CHK FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = NG.CHK_EXEC_NUM ) THEN 'Y' ELSE 'N' END  ) = 'Y'");
		
		}
		
		g_Sql_SaveSeq( szTmp, SREACH_FILE );
		
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

		if( g_lMoveFlag == 1 )
		{
			m_lpage = g_nActIndex / ROW;
			m_lActIndex = (g_nActIndex % ROW);
		}

		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotpage);		
	}
	
	/*=======================================================================================
	�Լ��� : SetComboFilter
	��  �� : �޺��ڽ� Filter
	Param  : 
 	Return : 
	========================================================================================*/
	void SetComboFilter(void)
	{
		char szTmp[100];
		long i = 0;
				
		/*****************************/
		/* g_szRfrmComboFlag Setting */
		/*****************************/
		Mem_Set((byte*)g_szRfrmComboFlag, 0x00, sizeof(g_szRfrmComboFlag));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_FILTER) ) );
		
		i = g_SearchStr( szTmp, RFRM_COMBO );
		
		if (i == -1)
		{
			Str_Cpy(g_szRfrmComboFlag, "");
		}
		else
		{
			Str_Cpy(g_szRfrmComboFlag, RFRM_COMBO[i].Code);
		}
		
		/*****************************/
		/* Color                     */
		/*****************************/
		// 1 =  ��ü , 2 = ������, 3 = �ǰ�
		if( Str_Cmp( g_szRfrmComboFlag, "1" ) == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(CMB_FILTER), TXTINCTRLBK);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(CMB_FILTER+1), TXTINCTRLBK);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(CMB_FILTER), TXTFRCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(CMB_FILTER+1), TXTFRCOLOR);
		}
		else if( Str_Cmp( g_szRfrmComboFlag, "2" ) == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(CMB_FILTER), RED);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(CMB_FILTER+1), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(CMB_FILTER), BTNMENUFRCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(CMB_FILTER+1), BTNMENUFRCOLOR);
		}
		else if( Str_Cmp( g_szRfrmComboFlag, "3" ) == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(CMB_FILTER), YELLOW);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(CMB_FILTER+1), YELLOW);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(CMB_FILTER), TXTFRCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(CMB_FILTER+1), TXTFRCOLOR);
		}	
	}
}
