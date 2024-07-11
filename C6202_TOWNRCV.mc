/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_TOWNRCV
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

	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_UP )			//����������
		DEF_BUTTON_ID ( BID_DOWN )			//����������
		DEF_BUTTON_ID ( BID_RECV )			//�ڷ����
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
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		DEF_OBJECT_ID ( TXT_PAGE )   // ������
		DEF_OBJECT_ID ( TXT_DATA1 )  // ���� �Ǽ�
		DEF_OBJECT_ID ( TXT_DATA2 )  // ��/��/��
		DEF_OBJECT_ID ( TXT_DATA3 )  // ���� �Ǽ�
		DEF_OBJECT_ID ( ID_TBLLIST ) // ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( CMB_AREA ) 	 // ��/��/��
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10						// table�� �ళ��
	#define		COL 	    4						// table�� ������
	#define		GRID_H		(CHT+21)				// table �� ����
	#define		GRID_CLR	TRANSPARENT   			// table Ŭ���� color
	#define		GRID_X		STARTX 			    	// table ����x��ǥ
	#define		MAXCHAR		201 			    	// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+185  	        // table ����y��ǥ
	#define		GRID_Y_P	STARTY+40  	            // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR];     // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	
	Column m_stGridTitle[] = {
		{"��/��/��", 	CWD*25, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���", 		CWD*11 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"", 			CWD*3+35, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"AREA", 	    CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;
	long m_lActive = -1;
	long m_lActiveIndex;
	long m_selectCnt = 0;
	
	char m_szCnt_page[10];
	char m_szCenterCd[30];
	char m_szNonPayManageZone[10];

	void SetBtnImg(void);
	void REDRAW(void);
	void Save_Row(long row);
	void SetCombo(void);

	void Rcv_Data(void);
	long TR81604(void);
	long Add_Item(handle pj);
	
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
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "ü����������"),
		
		DLG_TEXT(STARTX,        STARTY+65,  500, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500,  STARTY+65,  250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750,  STARTY+65,  250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),

		DLG_TEXT(STARTX,    STARTY+125, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "��/��/��"),
		
		DLG_COMBO (STARTX+300    ,  STARTY+125, 700, 60, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_AREA, 10),

		DLG_TEXT(STARTX,        STARTY+834, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "���� �Ǽ�"),
		DLG_TEXT(STARTX + 300,  STARTY+834, 325, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_BUTTON(STARTX+625,  STARTY+834, 375, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),	
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, 45, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "ü����������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_TEXT(STARTX,        STARTY+70, 350, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/��������				
		DLG_BUTTON(STARTX+450,  STARTY+70, 250, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+725,  STARTY+70, 250, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),	
		
		DLG_TEXT(STARTX,       STARTY+840, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
	
		DLG_BUTTON(STARTX+730, STARTY+840, 250, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),	
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, 45, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//----------------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void OnInit(char bFirst)
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
				SetBtnImg();
				SetCombo();
				EditCtrl_SetStr(Get_hDlgCtrlByID( TXT_DATA1 ), "0");
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ȭ�� ��Ÿ�� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AREA) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
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
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					//���õǾ��ִ� ��� ����
					g_Sql_DirectExecute( "UPDATE C6202_NOPAY_OBJ_LIST SET FLAG = 'N', CHK_FLAG = '0' WHERE FLAG = '1' AND CHK_FLAG = '1'" );
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "ü�� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					//���õǾ��ִ� ��� ����
					g_Sql_DirectExecute( "UPDATE C6202_NOPAY_OBJ_LIST SET FLAG = 'N', CHK_FLAG = '0' WHERE FLAG = '1' AND CHK_FLAG = '1'" );
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
				//���õǾ��ִ� ��� ����
				g_Sql_DirectExecute( "UPDATE C6202_NOPAY_OBJ_LIST SET FLAG = 'N', CHK_FLAG = '0' WHERE FLAG = '1' AND CHK_FLAG = '1'" );
				
				Card_Move("C6202_DETALRCV");
				break;	
			case GID_VMEXIT:
				if(MessageBoxEx (CONFIRM_YESNO, "���α׷��� �����Ͻðڽ��ϱ�?") != MB_OK)
				{
					return;
				}
				else
				{
					//���õǾ��ִ� ��� ����
					g_Sql_DirectExecute( "UPDATE C6202_NOPAY_OBJ_LIST SET FLAG = 'N', CHK_FLAG = '0' WHERE FLAG = '1' AND CHK_FLAG = '1'" );

					g_Db_Backup();
					
					//����̹���
					EvtExit();
					g_ImgFree();
					VM_AmEnd();
					return;
				}
				break;
			case BID_RECV:
				Rcv_Data();
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : ���̺� �� �޺��ڽ� Ŭ�� �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
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
			m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_AREA+1) )
			{
				m_selectCnt = 0;
				m_lpage = 0;
				EditCtrl_SetStr(Get_hDlgCtrlByID( TXT_DATA1 ), "0");
				g_Sql_DirectExecute( "UPDATE C6202_NOPAY_OBJ_LIST SET FLAG = 'N', CHK_FLAG = '0' WHERE FLAG = '1' AND CHK_FLAG = '1'" );
				REDRAW();
			}
			else
			{
				DlgTbl_SetActive(ID_TBLLIST, m_lActive+1);
			}
			ON_DRAW();
		}
	}

	/*=======================================================================================
	�Լ��� : Save_Row
	��  �� : ���̺� row Ŭ���� �޺��ڽ� �̺�Ʈ �� FLAG UPDATE
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Row(long row)
	{
		char sztmp[20];
		char szSql[300];
		char szSql2[200];
		char szTOWN[30];
		char szCNT[5];
		char szFLAG[4];
		char szAREA[30];

		Mem_Set((byte*)szTOWN ,0x00, sizeof(szTOWN) );
		Mem_Set((byte*)szCNT  ,0x00, sizeof(szCNT)  );
		Mem_Set((byte*)szFLAG ,0x00, sizeof(szFLAG) );
		Mem_Set((byte*)szAREA ,0x00, sizeof(szAREA) );
		
		Str_Cpy( szTOWN,          DlgTbl_GetStr( ID_TBLLIST, row, 0) );
		Str_Cpy( szCNT,   	      DlgTbl_GetStr( ID_TBLLIST, row, 1) );
		Str_Cpy( szFLAG,   	      DlgTbl_GetStr( ID_TBLLIST, row, 2) );
		Str_Cpy( szAREA,          DlgTbl_GetStr( ID_TBLLIST, row, 3) );

		//���õ� ���
		if(Str_Cmp( szFLAG, CHKON ) == 0)
		{
			Mem_Set((byte*)szFLAG ,0x00, sizeof(szFLAG) );
			szFLAG[0] = '1';
			
			//���� �Ǽ�
			m_selectCnt = m_selectCnt + Str_AtoI(szCNT);
			Str_ItoA(m_selectCnt, sztmp, 10 );
			EditCtrl_SetStr(Get_hDlgCtrlByID( TXT_DATA1 ), sztmp);
		}
		else
		{
			Mem_Set((byte*)szFLAG ,0x00, sizeof(szFLAG) );
			szFLAG[0] = 'N';
			
			//���� �Ǽ�
			m_selectCnt = m_selectCnt - Str_AtoI(szCNT);
			Str_ItoA(m_selectCnt, sztmp, 10 );
			EditCtrl_SetStr(Get_hDlgCtrlByID( TXT_DATA1 ), sztmp);
		}

		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)szSql2 ,0x00, sizeof(szSql2) );
		
		SPRINT(szSql, " UPDATE C6202_NOPAY_OBJ_LIST SET FLAG = '%s', CHK_FLAG = '1' ", szFLAG, 0, 0 );
		SPRINT(szSql2, " WHERE AREA = '%s' AND TOWN = '%s'", szAREA, szTOWN, 0);
		
		Str_Cat(szSql, szSql2);
		g_Sql_DirectExecute( szSql );
	}

	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ�� ���ΰ�ħ ( �޺��ڽ� ���� ���� ���̺� ������ ����� )
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW + 1;
		long ret = -1;	
		long lstartidx;
		
		char sztmp[201];
		char szSql[200];

		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		
		SPRINT(szSql, " SELECT COUNT(1) FROM (SELECT COUNT(*) FROM C6202_NOPAY_OBJ_LIST WHERE (CHK_FLAG <> '2' OR CHK_FLAG IS NULL) AND AREA = '%s' GROUP BY AREA, TOWN ) "
			 , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AREA)), 0, 0);

		g_Sql_RetInt(szSql, &m_lTotpage);

		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		//������
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT TOWN, SUM(CNT) AS CNT, FLAG, AREA FROM C6202_NOPAY_OBJ_LIST WHERE (CHK_FLAG <> '2' OR CHK_FLAG IS NULL) AND AREA = ? GROUP BY AREA, TOWN ORDER BY TOWN LIMIT ?, ? " );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		
		sql->Bind(sql, idx++, 'U', (long *)EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AREA))         ,30  ,DECRYPT);
		
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
				
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5, DECRYPT);
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
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
			}
		}		
Finally:

		DelSqLite(sql);

		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : �޺��ڽ� ������ ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		g_Sql_SetCombo("SELECT AREA FROM C6202_NOPAY_OBJ_LIST GROUP BY AREA ORDER BY AREA", CMB_AREA+2);
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_Data
	��  �� : �ڷ���� ( FR81604 )
	Param  : 
	Return : 
	========================================================================================*/
	void Rcv_Data(void)
	{
		char szGubun[4];
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char* sndbuf;
		long ret = 0;	
		
		g_Sql_RetInt("SELECT COUNT(*) FROM C6202_NOPAY_OBJ_LIST WHERE FLAG = '1' AND CHK_FLAG = '1'", &ret);	
		if( ret <= 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���õ� �ڷᰡ �����ϴ�.");
			return;
		}

		Mem_Set( (byte*) szGubun, 0x00, sizeof( szGubun) );
		Mem_Set( (byte*) m_szCenterCd, 0x00, sizeof( m_szCenterCd) );
		Mem_Set( (byte*) m_szNonPayManageZone, 0x00, sizeof( m_szNonPayManageZone) );
		
		//���� �� �������̽� ���� ����
		Str_Cpy(szGubun, "1");
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '9' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, m_szCenterCd);	
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '9' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, m_szNonPayManageZone);

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 81604, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "gubun",         		szGubun);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",         	m_szCenterCd);
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone", m_szNonPayManageZone);
		JSON_SetValue( g_pjcomm, 'C', "condition", 			"");
		JSON_SetValue( g_pjcomm, 'C', "area", 				"");
		JSON_SetValue( g_pjcomm, 'C', "town", 				"");
		JSON_SetValue( g_pjcomm, 'C', "addr1_s",  			"");
		JSON_SetValue( g_pjcomm, 'C', "co_live_nm",  		"");
		JSON_SetValue( g_pjcomm, 'C', "bld_nm",  			"");
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//�Ѱ��ִ� item������ Ȯ��
		g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR81604; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR81604_IN",  "FR81604" , sndbuf, sztmp );		
	}
	
	/*=======================================================================================
	�Լ��� : TR81604
	��  �� : �ڷ� ���� ��� �ݿ�
	Param  : 
	Return : 
	========================================================================================*/
	long TR81604(void)
	{
		if( g_Chk_Json(81604) >= 0)
		{
			//ü�� �׷� ��� flag ����
			g_Sql_DirectExecute( "UPDATE C6202_NOPAY_OBJ_LIST SET CHK_FLAG = '2' WHERE FLAG = '1' " );
			//ü�� ��� flag �ʱ� ����
			g_Sql_DirectExecute( "UPDATE C6202_NOPAY_OBJ SET CUST_FLAG = 'N', VISIT_FLAG = 'N', CUT_FLAG = 'N', AUTO_FLAG = 'N', RELE_FLAG = 'N', RCEI_FLAG = 'N' " );
			
			MessageBoxEx (CONFIRM_OK, "ü����� ������ �Ϸ��Ͽ����ϴ�.");
			m_lpage = 0;
			REDRAW();
			ON_DRAW();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Add_Item
	��  �� : �ڷ� ���� ������ ����
	Param  : 
	Return : 
	========================================================================================*/
	long Add_Item(handle pj)
	{
		char szSql[500];
		char sztmp[20];
		char szZipNo1[5];
		char szZipNo2[5];
		char szAddr1M[30];
		char szUaddr1M[60];
		
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		handle js = NULL;
		
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
	
		hstmt = sql->CreateStatement(sql, "SELECT ADDR1_M, ZIP_NO1, ZIP_NO2 FROM C6202_NOPAY_OBJ_LIST WHERE FLAG = '1' AND (CHK_FLAG <> '2' OR CHK_FLAG IS NULL)");

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
			Mem_Set( (byte*)szAddr1M,0x00, sizeof(szAddr1M) );
			Mem_Set( (byte*)szZipNo1,0x00, sizeof(szZipNo1) );
			Mem_Set( (byte*)szZipNo2,0x00, sizeof(szZipNo2) );

			sql->GetValue(sql, 0, 'U', (long*)szAddr1M, 30, DECRYPT);
			Mem_Set( (byte*)szUaddr1M,0x00, sizeof(szUaddr1M) );
			SQL_ConvUcStr( szUaddr1M, szAddr1M );

			sql->GetValue(sql, 1, 'U', (long*)szZipNo1, 5, DECRYPT);
			sql->GetValue(sql, 2, 'U', (long*)szZipNo2, 5, DECRYPT);
			
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "addr1_m",  			szUaddr1M );
			JSON_SetArrayItem(js, 'C', "zip_no1",        	szZipNo1 );
			JSON_SetArrayItem(js, 'C', "zip_no2",  			szZipNo2 );

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
}

