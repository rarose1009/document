/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_NODEL
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
//���ұ� �������
		DEF_BUTTON_ID ( BID_NODEL )		//�������
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_PREVLST )	//
		DEF_BUTTON_ID ( BID_NEXTLST )	//
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
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_MAKERNM )	//������
		DEF_OBJECT_ID ( TXT_MODELNM )	//��
		DEF_OBJECT_ID ( TXT_VOLUME )	//�뷮
		DEF_OBJECT_ID ( TXT_INSDT )		//��ġ����
		DEF_OBJECT_ID ( TXT_INSPLACE )	//��ġ��ġ
		DEF_OBJECT_ID ( TXT_MAKENUM )	//������ȣ
		DEF_OBJECT_ID ( TXT_FORM )		//����
		DEF_OBJECT_ID ( TXT_INSTALL )	//��ġ����
		DEF_OBJECT_ID ( TXT_NO )		//NO
		DEF_OBJECT_ID ( TXT_BSITEM )	//�����׸�
		DEF_OBJECT_ID ( TXT_BOO )		//��

		DEF_OBJECT_ID ( ID_TBLLIST )		
		
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����(���ұ� �������)
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4						 // table�� �ళ��
	#define		COL 	    4						 // table�� ������
	#define		GRID_H	  	(CHT+30)				 // table �� ����
	#define		GRID_CLR	TRANSPARENT   			 // table Ŭ���� color
	#define		GRID_X	  	STARTX 					 // table ����x��ǥ
	#define		MAXCHAR	  	51 			    		 // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y	  	STARTY-29	 	    	 // table ����y��ǥ
	#define		GRID_Y_P  	STARTY-40	 	    	 // table ����y��ǥ PDA
	#define		GRID_ENDY  	(GRID_Y+(ROW+1)*GRID_H)  // table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"���ұ��ȣ",	CWD*13, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",	    CWD*16+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�뷮",        CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�跮���ȣ",  CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};

	#define INIT_MAIN	1
	
	long m_bFirst;
	long m_lSelIndex = -1;
	long m_lLstpage = 0;
	long m_ltotLstcnt = 0;
	char m_szLstCnt_page[10];
	
	void SetStyle(void);
	void SetBtnImg(void);
	void SetClickData(void);
	void SetTotCnt(void);
	void REDRAW(void);
	void NoDel_Bur(void);
	void Clear_Screen(void);

	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� �������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX+500, STARTY+320, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750, STARTY+320, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX,	   STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NODEL, "�������"),
		DLG_BUTTON(STARTX+600, STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "�� ��"),
		
		DLG_TEXT(STARTX,     STARTY+320, 400, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szLstCnt_page),
		DLG_TEXT(STARTX,     STARTY+400, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKERNM, "������"),
		DLG_TEXT(STARTX+240, STARTY+400, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+460, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MODELNM, "��"),
		DLG_TEXT(STARTX+240, STARTY+460, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),		
		DLG_TEXT(STARTX,     STARTY+520, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_VOLUME, "�뷮"),
		DLG_TEXT(STARTX+240, STARTY+520, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,	 STARTY+580, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSDT, "��ġ����"),
		DLG_TEXT(STARTX+240, STARTY+580, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+640, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSPLACE, "��ġ��ġ"),
		DLG_TEXT(STARTX+240, STARTY+640, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+700, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKENUM, "������ȣ"),
		DLG_TEXT(STARTX+240, STARTY+700, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+760, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_FORM, "����"),
		DLG_TEXT(STARTX+240, STARTY+760, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� �������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX+500, STARTY+305, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750, STARTY+305, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX,	   STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NODEL, "�������"),
		DLG_BUTTON(STARTX+600, STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "�� ��"),
		
		DLG_TEXT(STARTX,     STARTY+305, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szLstCnt_page),
		DLG_TEXT(STARTX,     STARTY+375, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKERNM, "������"),
		DLG_TEXT(STARTX+240, STARTY+375, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+445, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MODELNM, "��"),
		DLG_TEXT(STARTX+240, STARTY+445, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),		
		DLG_TEXT(STARTX,     STARTY+515, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_VOLUME, "�뷮"),
		DLG_TEXT(STARTX+240, STARTY+515, 220, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+460, STARTY+515, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSDT, "��ġ����"),
		DLG_TEXT(STARTX+700, STARTY+515, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+585, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSPLACE, "��ġ��ġ"),
		DLG_TEXT(STARTX+240, STARTY+585, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+655, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKENUM, "������ȣ"),
		DLG_TEXT(STARTX+240, STARTY+655, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+725, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_FORM, "����"),
		DLG_TEXT(STARTX+240, STARTY+725, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
		char sztmp[300];
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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				SetBtnImg();
				SetStyle();
				SetTotCnt();
				ON_DRAW();
				
				if( m_ltotLstcnt == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��������� �ڷᰡ �����ϴ�.");
					Card_Move("BS_MTRINFO");
					return;
				}
				
				REDRAW();
				break;
		}

	}

//------------------------------------------------------------------
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKERNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODELNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VOLUME),  EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INSDT),   EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INSPLACE),EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKENUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM),    EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_PREVLST:
				m_lLstpage -= ROW;
				if(m_lLstpage < 0)
				{
					m_lLstpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_lSelIndex = 0;
				REDRAW();
				break;
			case BID_NEXTLST:
				m_lLstpage += ROW;
				if( m_lLstpage >= m_ltotLstcnt )
				{
					m_lLstpage -= ROW;
					if(m_lLstpage < 0)
					{
						m_lLstpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				m_lSelIndex = 0;
				REDRAW();
				break;
			case BID_NODEL:
				if(  MessageBoxEx (CONFIRM_YESNO, "���� ��� �Ͻðڽ��ϱ�?")  == MB_OK )
				{
					NoDel_Bur();
					SetTotCnt();
					REDRAW();
				}
				break;
			case BID_OK:
				Card_Move("BS_MTRINFO");
				break;
		}
	}
	
//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		char sztmp[200];
		char szSql[300];
		long index;
		long lPage;
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);

				Str_Cpy(stBsBur.MTR_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
				Str_Cpy(stBsBur.BURNER_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
				
				m_lSelIndex = index-1;
				lPage = m_lLstpage + index;
				SPRINT(m_szLstCnt_page, "%d/%d", lPage, m_ltotLstcnt, 0);
				
				SetClickData();
			}
		}
	}

//------------------------------------------------------------------	
	void SetClickData(void)
	{
		long i, idx, j, n;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char szSql[800];
		char szDate[20];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MAKER_NM, BURNER_MODEL_NM, BURNER_CAPA, BURNER_INST_YMD, INST_LOC_NM, MAKE_NUM, BOILER_FORM \
					   FROM SPECIAL_BUR WHERE CHK_EXEC_NUM = ? AND MTR_NUM = '%s' AND BURNER_NUM = '%s' AND CHG_FLAG = '3' "
					   , stBsBur.MTR_NUM, stBsBur.BURNER_NUM, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCHK_EXEC_NUM, 12, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			Mem_Set( (byte*)stBsBur.MAKER_NM, 0x00, sizeof(stBsBur.MAKER_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsBur.MAKER_NM       		, 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1)   , stBsBur.MAKER_NM);
			
			Mem_Set( (byte*)stBsBur.BURNER_MODEL_NM, 0x00, sizeof(stBsBur.BURNER_MODEL_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsBur.BURNER_MODEL_NM     , 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)   , stBsBur.BURNER_MODEL_NM);
			
			Mem_Set( (byte*)stBsBur.BURNER_CAPA, 0x00, sizeof(stBsBur.BURNER_CAPA) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsBur.BURNER_CAPA         , 10+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)   , stBsBur.BURNER_CAPA);
			
			Mem_Set( (byte*)stBsBur.BURNER_INST_YMD, 0x00, sizeof(stBsBur.BURNER_INST_YMD) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsBur.BURNER_INST_YMD     , 8 + 1, DECRYPT );
			Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
			g_Str_DateType(szDate, stBsBur.BURNER_INST_YMD);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)   , szDate);
			
			Mem_Set( (byte*)stBsBur.INST_LOC_NM, 0x00, sizeof(stBsBur.INST_LOC_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsBur.INST_LOC_NM         , 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)   , stBsBur.INST_LOC_NM);
			
			Mem_Set( (byte*)stBsBur.MAKE_NUM, 0x00, sizeof(stBsBur.MAKE_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsBur.MAKE_NUM            , 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)   , stBsBur.MAKE_NUM);
			
			Mem_Set( (byte*)stBsBur.BOILER_FORM, 0x00, sizeof(stBsBur.BOILER_FORM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsBur.BOILER_FORM         , 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)   , stBsBur.BOILER_FORM);
		}
	
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
//------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lstartidx ;
		long lPage;
		char sztmp[401];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( m_lSelIndex == -1 )
		{
			m_lSelIndex = 0;
		}
		
		if( m_ltotLstcnt > 0 )
		{
			lPage = m_lLstpage + m_lSelIndex;
		}
		else
		{
			lPage = -1;
		}
		SPRINT(m_szLstCnt_page, "%d/%d", lPage+1, m_ltotLstcnt, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT BURNER_NUM, BURNER_KIND_NM, BURNER_CAPA, MTR_NUM  \
					   FROM SPECIAL_BUR WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND CHG_FLAG = '3' LIMIT ?, ? "
					   , g_szCHK_EXEC_NUM, stBsMtr.MTR_NUM, 0);

		hstmt = sql->CreateStatement(sql, sztmp);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lLstpage;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lLstpage+ROW;
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
				//
				idx = 0;
				//���ұ��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//�뷮
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );					
				//�跮���ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_ltotLstcnt > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
				
			Str_Cpy(stBsBur.BURNER_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
			Str_Cpy(stBsBur.MTR_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
			
			SetClickData();
		}
		else
		{
			Clear_Screen();
		}
		
		ON_DRAW();
		return;
	}
	
//------------------------------------------------------------------------------------------------
	void NoDel_Bur(void)
	{
		char szSql[300];
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)stBsBur.BURNER_REMOV_YMD, 0x00, sizeof(stBsBur.BURNER_REMOV_YMD) );
		//��ġ����  > ����(3)�� �۾Ƴ��� , decode(CHG_FLAG,'1','�ű�','2','����','3','����')
		Str_Cpy(stBsBur.CHG_FLAG, "2" );
		
		Str_Cpy(stBsBur.SEND_YN, "N" );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_BUR SET \
					CHG_FLAG = ?, BURNER_REMOV_YMD = ?, SEND_YN = ? \
					WHERE CHK_EXEC_NUM = ? AND BURNER_NUM = ? AND MTR_NUM = ? "
					, 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.CHG_FLAG	        ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_REMOV_YMD	,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.SEND_YN	        ,1	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM	        ,12	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.BURNER_NUM	    ,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsBur.MTR_NUM	        ,10	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���� ��� �Ǿ����ϴ�.");
			m_lLstpage = 0;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	
//========================================================================================
	void SetTotCnt(void)
	{
		char szSql[300];
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_BUR  WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND CHG_FLAG = '3' ",g_szCHK_EXEC_NUM, stBsMtr.MTR_NUM, 0   );
		g_Sql_RetInt( szSql, &m_ltotLstcnt );
	}
	
//========================================================================================
	void Clear_Screen(void)
	{
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)   , "");
	}
}


