/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_DETALLST
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

		DEF_BUTTON_ID ( BID_ADDR )			//���� �ּ�
		DEF_BUTTON_ID ( BID_NADDR )			//���θ� �ּ�
		DEF_BUTTON_ID ( BID_UP )			//����������
		DEF_BUTTON_ID ( BID_DOWN )			//����������
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//��ũ�� ȣ��
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
//��ħ ����Ʈ
		DEF_OBJECT_ID ( TXT_PAGE )			//������
		DEF_OBJECT_ID ( TXT_DATA1 )			//�ּ�
		DEF_OBJECT_ID ( TXT_DATA2 )			//��
		DEF_OBJECT_ID ( ID_TBLLIST )		//���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_DATA1 )			//����Ʈ �޺�
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )	//�� �޺�
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table�� �ళ��
	#define		COL 	    6					// table�� ������
	#define		GRID_H		(CHT+32)			// table �� ����
	#define		GRID_H_P	(CHT+44)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX	 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+255  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+190  	    //table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�",     	 CWD*17+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��",        	 CWD*4,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ü���ݾ�",     CWD*13, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",     	 CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�",   	 CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"USE_CONT_NUM", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nActIndex = -1;		//���õ� row index
	long m_bFirst;				
	char m_Title[30];
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szCobSel[20];
	char m_szSql[1000];
	char m_szQuickSql[1200];
	
	char m_szSqlWhere[1200];
	
	bool REDRAW(void);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	void SetBtnImg(void);

	void OnList(quad lParam);
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
	
	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_Title),
	
		DLG_BUTTON(STARTX,	 	STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+250,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		
		DLG_BUTTON(STARTX,     STARTY+830, 220, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		DLG_BUTTON(STARTX+550, STARTY+830, 225, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+775, STARTY+830, 225, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		DLG_TEXT(STARTX,	   STARTY+135, 1000, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+500,   STARTY+65, 500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_COMBO_LIST (STARTX, 	   STARTY+255, 448, 290, 125, 71, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),

		DLG_TEXT (STARTX+221,  STARTY+830, 78, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "��"),
		DLG_COMBO(STARTX+299,  STARTY+830, 248, 69, 120, 69, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),
	};	
	

	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, m_Title),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,	 	STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+250,  STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+500, STARTY+830, 250, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+830, 250, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		DLG_TEXT(STARTX,	   STARTY+40, 1000, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+500,   STARTY-40, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-15, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_COMBO_LIST (STARTX, STARTY+190, 448, 290, 125, GRID_H_P-15, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
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
		char szSql[512];
		char szTmp[128];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( g_szCntSql, SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Mem_Set((byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql));
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set((byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));

			Str_Cpy(m_szQuickSql, "SELECT USE_CONT_NUM FROM C6202_NOPAY_OBJ ");
			Mem_Cpy((byte *)szSql, (byte *)g_szSqlWhere, Str_Len(g_szSqlWhere)-68);
			SPRINT(szTmp, " AND ROWID = '%d'" ,g_lindex,0,0);
			Str_Cat(m_szQuickSql, szSql);
			Str_Cat(m_szQuickSql, szTmp);
			g_Sql_RetStr(m_szQuickSql, 15, g_szUSE_CONT_NUM);

			Set_Index();
			g_lDataflag = 0;
			g_lNpMemoChkFlag = 0;
			
			Card_Move("C6202_NPACTIVE");
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
				
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "�ּ�", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "��ȣ", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "����", 0, ICON_NONE);
				
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "�⺻", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "��������", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "��������", 0, ICON_NONE);
				//EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2), "�⺻");
				
				if( g_szNpMonthFlag == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2), "�⺻");
				}
				else if( g_szNpMonthFlag == 1 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2), "��������");
					Mem_Set( (byte*)m_szSqlWhere, 0x00, sizeof(m_szSqlWhere) );
					Mem_Cpy((byte *)m_szSqlWhere, (byte *)g_szSqlWhere, Str_Len(g_szSqlWhere)-68);
					Str_Cat(m_szSqlWhere, "ORDER BY NONPAY_MM_CNT ASC, TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?");	
				}
				else if( g_szNpMonthFlag == 2 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2), "��������");
					Mem_Set( (byte*)m_szSqlWhere, 0x00, sizeof(m_szSqlWhere) );
					Mem_Cpy((byte *)m_szSqlWhere, (byte *)g_szSqlWhere, Str_Len(g_szSqlWhere)-68);
					Str_Cat(m_szSqlWhere, "ORDER BY NONPAY_MM_CNT DESC, TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?");
				}
				
				g_nAddrFlag = 0;
				Mem_Set( (byte*)m_szCobSel, 0x00, sizeof(m_szCobSel));
				Str_Cpy(m_szCobSel, "�ּ�");
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);
			
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
		char szMsg[100];
		char szcmb[20];
		char sztmp[200];
		char szSql[1000];
		
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
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					Set_Index();
					g_lDataflag = 0;
					g_lNpMemoChkFlag = 0;
					Card_Move("C6202_NPACTIVE");
					return;
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����
				
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
					Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
					Str_Cpy( g_szUSE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
				}
			}
			else
			{
				m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				
				if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_DATA1+1) )
				{
					Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
					Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1) ) );
					//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ħ,�̰�ħ,��ü���)
					if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
					{
						Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
						SPRINT(szMsg, "�׸��� %s�� �����Ͻðڽ��ϱ�?", szcmb, 0, 0);
						if( MessageBoxEx (CONFIRM_YESNO, szMsg)  == MB_OK)
						{
							Str_Cpy(m_szCobSel, szcmb);
							
							REDRAW();
						}
						else
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);
						}
					}
					else
					{
						REDRAW();
					}
				}
				else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_DATA2+1) )
				{
					Mem_Set((byte*)m_szSqlWhere, 0x00, sizeof(m_szSqlWhere));
					
					if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "��������") == 0 )
					{
						Mem_Set( (byte*)m_szSqlWhere, 0x00, sizeof(m_szSqlWhere) );
						Mem_Cpy((byte *)m_szSqlWhere, (byte *)g_szSqlWhere, Str_Len(g_szSqlWhere)-68);
						Str_Cat(m_szSqlWhere, "ORDER BY NONPAY_MM_CNT ASC, TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?");	
						g_szNpMonthFlag = 1;
					}
					else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "��������") == 0 )
					{
						Mem_Set( (byte*)m_szSqlWhere, 0x00, sizeof(m_szSqlWhere) );
						Mem_Cpy((byte *)m_szSqlWhere, (byte *)g_szSqlWhere, Str_Len(g_szSqlWhere)-68);
						Str_Cat(m_szSqlWhere, "ORDER BY NONPAY_MM_CNT DESC, TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?");
						g_szNpMonthFlag = 2;
					}
					else
					{
						g_szNpMonthFlag = 0;
					}

					REDRAW();
				}
			}
		}
	}
	
//-----------------------------------------------------------------
/*
g_nWorkFlag = 800		ü�� �⺻ �󼼸���Ʈ(���̺� ����Ŭ��)
g_nWorkFlag = 801		ü�� ���Ȱ�� �󼼸���Ʈ
g_nWorkFlag = 802		ü�� ����Ȱ�� �󼼸���Ʈ
g_nWorkFlag = 803		ü�� ���� �󼼸���Ʈ
g_nWorkFlag = 804		ü�� �ݾ� �󼼸���Ʈ
g_nWorkFlag = 805		ü�� ü������ �󼼸���Ʈ

g_nWorkFlag = 860		ü�� ������ �󼼸���Ʈ
g_nWorkFlag = 861		ü�� ������ �ݾ� �󼼸���Ʈ
g_nWorkFlag = 862		ü�� ������ ü������ �󼼸���Ʈ

g_nWorkFlag = 870		ü�� ������ �󼼸���Ʈ
g_nWorkFlag = 871		ü�� ������ �ݾ� �󼼸���Ʈ
g_nWorkFlag = 872		ü�� ������ ü������ �󼼸���Ʈ
*/

	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA1), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(CMB_DATA2), TRUE, 2, EDITSEP_NONE );
		
		if( g_nWorkFlag == 800 )
		{
			Str_Cpy(m_Title, "Ȱ�� ����Ʈ");
		}
		else if( g_nWorkFlag == 801 )
		{
			Str_Cpy(m_Title, "��� ����Ʈ");
		}
		else if( g_nWorkFlag == 802 )
		{
			Str_Cpy(m_Title, "�����Ƿ� ����Ʈ");
		}
		else if( g_nWorkFlag == 803 )
		{
			Str_Cpy(m_Title, "���� ����Ʈ");
		}
		else if( g_nWorkFlag == 804 )
		{
			Str_Cpy(m_Title, "�ݾ� ����Ʈ");
		}
		else if( g_nWorkFlag == 805 )
		{
			Str_Cpy(m_Title, "ü������ ����Ʈ");
		}
		else if( g_nWorkFlag == 860 )
		{
			Str_Cpy(m_Title, "������ Ȱ�� ����Ʈ");
		}
		else if( g_nWorkFlag == 861 )
		{
			Str_Cpy(m_Title, "������ �ݾ� ����Ʈ");
		}
		else if( g_nWorkFlag == 862 )
		{
			Str_Cpy(m_Title, "������ ü������ ����Ʈ");
		}
		else if( g_nWorkFlag == 870 )
		{
			Str_Cpy(m_Title, "������ Ȱ�� ����Ʈ");
		}
		else if( g_nWorkFlag == 871 )
		{
			Str_Cpy(m_Title, "������ �ݾ� ����Ʈ");
		}
		else if( g_nWorkFlag == 872 )
		{
			Str_Cpy(m_Title, "������ ü������ ����Ʈ");
		}
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_QUICK_ADDR:
				Grid_QuickList();
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;
				REDRAW();
				break;
			case BID_NADDR:
				g_nAddrFlag = 1;
				REDRAW();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0)
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
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "ü�� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C6202_MENU");
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
				if( g_nHomeLstFlag != 0 )
				{
					Card_Move("C6202_HOMELST");
				}
				else
				{
					Card_Move("C6202_GRPLST");
				}
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
		long lTotPage;
		char sztmp[256];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_SaveSeq( g_szCntSql, SREACH_FILE);
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
			//���α׷� ���� �� �ҷ����� �ε���
			Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "����\n��ũ��");
			}

			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "�⺻") == 0 )
			{
				SPRINT(m_szSql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG, IFNULL(AREA, '') ||' '|| IFNULL(TOWN, '') ||' '|| IFNULL(VILLAGE, '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_NOPAY_OBJ %s" \
					   , g_szSqlWhere, 0, 0);
			}
			else
			{
				SPRINT(m_szSql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG, IFNULL(AREA, '') ||' '|| IFNULL(TOWN, '') ||' '|| IFNULL(VILLAGE, '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_NOPAY_OBJ %s" \
					   , m_szSqlWhere, 0, 0);
			}
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "���θ�\n��ũ��");
			}
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "�⺻") == 0 )
			{
				SPRINT(m_szSql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG, IFNULL(NEW_ROAD_NM, '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_NOPAY_OBJ %s" \
					   , g_szSqlWhere, 0, 0);
		  	}
		  	else
		  	{
		  		SPRINT(m_szSql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG, IFNULL(NEW_ROAD_NM, '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_NOPAY_OBJ %s" \
					   , m_szSqlWhere, 0, 0);
		  	}
		}
		
		hstmt = sql->CreateStatement(sql, m_szSql);
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
				
				//�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );				
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�ּ�") == 0 )
				{
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
				{
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
				{
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 200, DECRYPT);
				}
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				//��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//ü���ݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//USE_CONT_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 5, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);


		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
			Str_Cpy( g_szUSE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			
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
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '9' ", g_lindex, 0, 0);		
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
		long lParam9;
		
		g_Sql_RetInt("SELECT PARAM9 FROM RCV_LOG WHERE GUBUN = '9'", &lParam9);
		
		g_nActIndex = lParam9;		
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = (g_nActIndex % ROW);
	}
	
	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		char szSql[512];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name_Addr[5][32] = {"�ּ�", "��", "ü���ݾ�", "����", ""};
		char col_name_Firm[5][32] = {"��ȣ", "��", "ü���ݾ�", "����", ""};
		char col_name_Cust[5][32] = {"����", "��", "ü���ݾ�", "����", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","1","2","1","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�ּ�") == 0 )
		{
			if( g_nAddrFlag == 0 )
			{
				Str_Cpy(m_szQuickSql, " SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(TRIM(CO_LIVE_NM), '') \
											  			||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
											  	    ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
											    END \
											 , NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG \
									      FROM C6202_NOPAY_OBJ ");
			}
			else
			{
				Str_Cpy(m_szQuickSql, " SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(TRIM(CO_LIVE_NM), '') \
														||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
											        ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
											    END \
											 , NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG \
										  FROM C6202_NOPAY_OBJ ");
			}
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
		{
			Str_Cpy(m_szQuickSql, " SELECT FIRM_NM, NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG FROM C6202_NOPAY_OBJ ");
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
		{
			Str_Cpy(m_szQuickSql, " SELECT CUST_NM, NONPAY_MM_CNT, ALL_UNPAY, VISIT_FLAG FROM C6202_NOPAY_OBJ ");
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );

		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "�⺻") == 0 )
		{
			Mem_Cpy((byte *)szSql, (byte *)g_szSqlWhere, Str_Len(g_szSqlWhere)-10);
		}
		else
		{	
			Mem_Cpy((byte *)szSql, (byte *)m_szSqlWhere, Str_Len(m_szSqlWhere)-10);		
		}

		Str_Cat(m_szQuickSql, szSql);
		
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

				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�ּ�") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Addr[i]);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Firm[i]);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Cust[i]);
				}
	
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, m_Title);
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



