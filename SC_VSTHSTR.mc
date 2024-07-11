/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_VSTHSTR
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
		DEF_BUTTON_ID ( BID_OK )		//Ȯ��
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
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
		DEF_OBJECT_ID ( TXT_STOP ) 		//����
		DEF_OBJECT_ID ( TXT_NSTOPRSN )	//�����Ұ�����
		DEF_OBJECT_ID ( TXT_DATA1 ) 
		DEF_OBJECT_ID ( TXT_DATA2 ) 
		DEF_OBJECT_ID ( TXT_DATA3 ) 	//������
		
		DEF_OBJECT_ID ( ID_TBLLIST ) // ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+12)			// table �� ����
	#define		GRID_H_P	(CHT+21)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX	 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+130		  	//table ����y��ǥ
	#define		GRID_Y_P	STARTY+30		  	//table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�湮����", 	CWD*11+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����", 		CWD*18 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�湮��", 		CWD*10 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",	 	CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�����Ұ�����",CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}

	};	
	
	#define INIT_MAIN	1
	
	char m_szCnt_page[10];
	long m_lpage = 0;
	long m_lTotpage;
	long m_lSelIndex = -1;
	
	
	void SetStyle(void);
	void REDRAW(void);
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	void SetBtnImg(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�湮 �̷�"),

		DLG_BUTTON(STARTX+500,   STARTY+65, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+750,   STARTY+65, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+200,  STARTY+820, 600, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,		 STARTY+65, 500, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, m_szCnt_page), //������
		DLG_TEXT(STARTX,		STARTY+695, 400, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STOP, "����"),
		DLG_TEXT(STARTX+400,	STARTY+695, 600, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), //
		DLG_TEXT(STARTX,		STARTY+755, 400, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSTOPRSN, "�����Ұ�����"),
		DLG_TEXT(STARTX+400,	STARTY+755, 600, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), //
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�湮 �̷�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+500,   STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+750,   STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+200,  STARTY+829, 600, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,      STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, m_szCnt_page), //������
		DLG_TEXT(STARTX,     STARTY+680, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STOP, "����"),
		DLG_TEXT(STARTX+400, STARTY+680, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), //
		DLG_TEXT(STARTX,     STARTY+750, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSTOPRSN, "�����Ұ�����"),
		DLG_TEXT(STARTX+400, STARTY+750, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), //
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
	
//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		char sztmp[100];
	
		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			m_lSelIndex = DlgTbl_GetActiveRow(ID_TBLLIST);
			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex-1, 3));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex-1, 4));
		}
	}

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STOP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NSTOPRSN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_OK:
				Card_Move("SC_CONFIRM");
				break;
			case BID_PREVPG:
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
			case BID_NEXTPG:
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
					g_lDataflag = 0;
					g_lMoveFlag = 0;
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lDataflag = 0;
					g_lMoveFlag = 0;
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
				Card_Prev();
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
/*=======================================================================================
�Լ��� : REDRAW
��  �� : 
Param  : 
Return : 
========================================================================================*/
	void	REDRAW(void)
	{
	long i, idx;
	long j =0;
	long k = ROW+1;
	long lstartidx ;
	char szSql[400];
	char szVisit[10];
	char sztmp[20];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)&stScVisit, 0x00, sizeof(stScVisit));
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_VISIT  WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &m_lTotpage );

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
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szVisit, 0x00, sizeof(szVisit) );
		//�����˹湮 VISIT_FLAG => 20 ���� 
		Str_Cpy(szVisit, "20");
		
		SPRINT(szSql, "SELECT VISIT_YMD, NO_CHK_WHY, VISITOR_NM, SUPPLY_STOP_YMD, NOT_PERMIT_WHY \
						, VISIT_FLAG, VISIT_DEGREE, VISITOR_ID, SEND_YN, PDA_IP, UPD_EMPID, BLD_NUM, INST_PLACE_NUM \
						, CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM, PLAN_YM \
						FROM NORMAL_VISIT WHERE CHK_EXEC_NUM = '%s' AND VISIT_FLAG = '%s' ORDER BY VISIT_DEGREE DESC LIMIT ?, ? "
						, g_szCHK_EXEC_NUM, szVisit, 0);
		Str_Cpy(stScVisit.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		//ROW
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
				//�湮�Ͻ�
				idx = 0;
				Mem_Set( (byte*)stScVisit.VISIT_YMD, 0x00, sizeof(stScVisit.VISIT_YMD) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)stScVisit.VISIT_YMD, 8, DECRYPT);
				g_Str_DateType	(sztmp, stScVisit.VISIT_YMD);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//�����˻���
				Mem_Set( (byte*)stScVisit.NO_CHK_WHY, 0x00, sizeof(stScVisit.NO_CHK_WHY) );
				sql->GetValue(sql, idx++, 'U', (long*)stScVisit.NO_CHK_WHY, 30, DECRYPT);
				j = SearchCD( stScVisit.NO_CHK_WHY, SCNOCHK_WHY );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, SCNOCHK_WHY[j].Str );
				//�湮�ڸ�
				Mem_Set( (byte*)stScVisit.VISITOR_NM, 0x00, sizeof(stScVisit.VISITOR_NM) );
				sql->GetValue(sql, idx++, 'U', (long*)stScVisit.VISITOR_NM, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, stScVisit.VISITOR_NM );
				//�����ߴ��Ͻ�
				Mem_Set( (byte*)stScVisit.SUPPLY_STOP_YMD, 0x00, sizeof(stScVisit.SUPPLY_STOP_YMD) );
				sql->GetValue( sql, idx++, 'U', (long*)stScVisit.SUPPLY_STOP_YMD, 8, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, stScVisit.SUPPLY_STOP_YMD );
				//�ߴܺҰ�����
				Mem_Set( (byte*)stScVisit.NOT_PERMIT_WHY, 0x00, sizeof(stScVisit.NOT_PERMIT_WHY) );
				sql->GetValue( sql, idx++, 'U', (long*)stScVisit.NOT_PERMIT_WHY, 2, DECRYPT );
				j = SearchCD( stScVisit.NOT_PERMIT_WHY, SCNOSTOP_WHY );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, SCNOSTOP_WHY[j].Str );
				
				if( i == 0 )
				{
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.VISIT_FLAG      , 2 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.VISIT_DEGREE    , 2 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.VISITOR_ID      , 9 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.SEND_YN         , 1 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.PDA_IP          , 32+ 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.UPD_EMPID       , 20+ 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.BLD_NUM         , 9 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.INST_PLACE_NUM  , 9 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.CHK_TYPE        , 2 + 1, DECRYPT );	
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.CHK_YEAR        , 4 + 1, DECRYPT );	
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.CHK_ORDER       , 2 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.OBJ_YM          , 6 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'C', (long*) stScVisit.PLAN_YM         , 6 + 1, DECRYPT );
				}
			}
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		DlgTbl_SetActive(ID_TBLLIST , 1 );
		DlgTbl_SetRowColor(ID_TBLLIST, 1, TABLEACTIVE_COLOR);
			
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, 0, 3));
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_TBLLIST, 0, 4));
		
		m_lSelIndex = 1;
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SearchCD
	��  �� : �ڵ尪���� �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
				return i;
		}
		
		return -1;
	}

}

