/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_VISITHIST
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
//	#define USE_ON_UART
//	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_REFSCHDL )
		DEF_BUTTON_ID ( BID_STOPREQ )
		DEF_BUTTON_ID ( BID_TXTVIEW )
	//�̷� ����
		DEF_BUTTON_ID ( BID_VIEW_CLOSE )
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
	// �湮�̷�
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( TXT_BORDER )
		DEF_OBJECT_ID ( TXT_PAGE )
		DEF_OBJECT_ID ( TXT_DATA1 )		//Ȱ���̷�TXT
		DEF_OBJECT_ID ( TXT_DATA2 )		//����TXT
		DEF_OBJECT_ID ( TXT_DATA3 )		//������
		DEF_OBJECT_ID ( TXT_DATA4 )		//Ȱ���̷�
	// Ȱ���̷�
		DEF_OBJECT_ID ( TXT_DATA5 )		//Ȱ���̷³���
		DEF_OBJECT_ID ( ICON_TITLE )	//Ÿ��Ʋ	
		
		DEF_OBJECT_ID ( ID_TBLLIST ) 	//���̺� ����Ʈ
		
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()
	
	#define INIT_MAIN 1
	#define INIT_VIEW 2

	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    8					// table�� ������
	#define		GRID_H		(CHT+16)			// table �� ����
	#define		GRID_H_P	(CHT+15)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 				// table ����x��ǥ
	#define		MAXCHAR		1200 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+216  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+620  	    //table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"����", 		  CWD*15,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", 		  CWD*7,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", 		  CWD*8+13, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ó����", 		  CWD*9+10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̷³���", 	  CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", 		  CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"VISIT_WHY_CD",  CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"VISIT_WHY_CD2", CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
		
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

	long m_bFirst;
	long m_lActIndex = -1;
	long m_lTotpage = 0;
	long m_lPage = 0;
	long m_lViewFlag = 0;		//m_lViewFlag = 0 default , = 1 �湮�̷� ȭ�� ��ȸ
	long m_lRcvFlag = 0;		//m_lRcvFlag = 0 default , = 1 �湮�̷� ����
	char m_szCnt_page[10];
	char m_szView[1200];

	void SetBtnImg(void);
	void SetStyle(void);
	void VisitDraw(void);
	long Rcv_Visit(void);
	long TR82226(void);

	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�湮�̷�"),
		
		DLG_TEXT  (STARTX,     STARTY+65 , 220, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "Ȱ���̷�"),
		DLG_BUTTON(STARTX+220, STARTY+65 , 780, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TXTVIEW, ""),
		DLG_TEXT  (STARTX+220, STARTY+65 , 780, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT  (STARTX,     STARTY+165, 220, 50 , 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "����"),
		
		DLG_TEXT  (STARTX,     STARTY+828, 377, 71 , 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, m_szCnt_page),
		DLG_BUTTON(STARTX+378, STARTY+828, 311, 71 , 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+689, STARTY+828, 311, 71 , 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),

		//����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	

		DLG_COMBO(STARTX+220, STARTY+165, 780, 290, 110, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),
	};	

	//---------------------------------------------------------------
	// Ȱ���̷� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_View[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�̷³���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+580, 829, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, "�ݱ�"),

		DLG_TEXT(STARTX,     STARTY-29, 1000, 800, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
	};

	//----------------------------------------------------------------------
	// ����
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
		long lCnt;
		
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));

				SetBtnImg();	
				SetStyle();

				if( m_lViewFlag == 1 )
				{
					m_lViewFlag = 0;
					VisitDraw();
				}
				else
				{
					Rcv_Visit();
				}

				break;
				
			case INIT_VIEW:
				CREATE_DIALOG_OBJECT (DlgRes_View, SIZEOF(DlgRes_View));
				
				SetBtnImg();
				
				m_lViewFlag = 1;
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_TOP);
				EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA5), TRUE, 2, EDITSEP_NONE );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), m_szView );
				
				break;
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
		long d, k;
		char sztmp[15];
		char szToday[15];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		
		if( g_ChkDay() )
		{
			return;
		}
			
		switch(ID)
		{
			case BID_PREVLST:
				m_lPage--;
				if(m_lPage < 0)
				{
					m_lPage = 0;
					break;
				}
				m_lActIndex = 0;
				VisitDraw();
				break;
						
			case BID_NEXTLST:
				m_lPage++ ;
				if( m_lPage > m_lTotpage-1 )
				{
					m_lPage = m_lTotpage-1;
					if(m_lPage < 0)
					{
						m_lPage = 0;
					}
					break;
				}
				m_lActIndex = 0;
				VisitDraw();
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
				Card_Move("C6202_CLEAR");
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				break;
				
			case BID_TXTVIEW:
				if( m_lRcvFlag == 1 )
				{
					ON_EXIT();
					OnInit(INIT_VIEW);
				}
				break;
				
			case BID_VIEW_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
		}
	}
			
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : ���̺� Ŭ�� �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index;
		char szSql[500];
		char szTmp[50];

		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			m_lActIndex = index - 1;
			
			Mem_Set( (byte*)m_szView, 0x00, sizeof(m_szView) );
			Str_Cpy(m_szView, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), m_szView );
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			
			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 1), "Y") == 0 )
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20371' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			else
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20372' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			
			g_Sql_RetStr(szSql, 50, szTmp);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), szTmp);
		}
	}	

	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ������ ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;

		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
						
			if( theDevInfo.m_nType > FAMILY_PDA )
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : ��Ÿ�� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA4), TRUE, 2, EDITSEP_NONE );
		
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
	}
	
	/*=======================================================================================
	�Լ��� : VisitDraw
	��  �� : �湮�̷� Draw
	Param  : 
	Return : 
	========================================================================================*/
	void VisitDraw(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[1200];
		char szDate[50];
		char szSql[300];
		char szWhy[50];
		char szVisitWhyCd[5];
		char szVisitWhyCd2[5];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lTotpage );

		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		//������
		SPRINT(m_szCnt_page, "%d/%d", m_lPage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM102, PARAM5 FROM RCV_TMP LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lPage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lPage*ROW+ROW;
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
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
					continue;
				}
				
				idx = 0;
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				g_Str_DateType( szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, szDate );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//ó����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//�̷³���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 490, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				//VISIT_WHY_CD
				Mem_Set( (byte*)szVisitWhyCd, 0x00, sizeof(szVisitWhyCd) );
				sql->GetValue(sql, idx++, 'U', (long*)szVisitWhyCd, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, szVisitWhyCd );
				//VISIT_WHY_CD2
				Mem_Set( (byte*)szVisitWhyCd2, 0x00, sizeof(szVisitWhyCd2) );
				sql->GetValue(sql, idx++, 'U', (long*)szVisitWhyCd2, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, szVisitWhyCd2 );
				
				if( Str_Cmp(szVisitWhyCd, "82") == 0 || Str_Cmp(szVisitWhyCd, "60") == 0 ||
				    Str_Cmp(szVisitWhyCd2, "82") == 0 || Str_Cmp(szVisitWhyCd2, "60") == 0  )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), TXTCTRLFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTCTRLFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTCTRLFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTCTRLFRCOLOR);
				}
			}
		}		

Finally:

		if(m_lTotpage > 0)
		{
			if( m_lActIndex == -1 )
			{
				m_lActIndex = 0;
			}

			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)m_szView, 0x00, sizeof(m_szView) );
			Str_Cpy(m_szView, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), m_szView );
		
			Mem_Set( (byte*)szWhy, 0x00, sizeof(szWhy) );
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			
			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 1), "Y") == 0 )
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20371' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			else
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20372' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			
			g_Sql_RetStr(szSql, 50, szWhy);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), szWhy);
		}

		DelSqLite(sql);

		return;
	}
		
	/*=======================================================================================
	�Լ��� : Rcv_Visit
	��  �� : �湮�̷� ����_FR82226
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Visit(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82226, FALSE);
		
		//JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stClear.USE_CONT_NUM );	
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82226; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR82226_IN",  "FR82226" , sndbuf, sztmp );
		
		return 0 ;
	}
	
	/*=======================================================================================
	�Լ��� : TR82226
	��  �� : Callback_TR82226
	Param  : 
	Return : 
	========================================================================================*/
	long TR82226(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82226) >= 0)
		{
			m_lRcvFlag = 1;
			VisitDraw();
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
}


