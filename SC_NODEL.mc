/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_NODEL
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
	#define		COL 	    5						 // table�� ������
	#define		GRID_H	  	(CHT+30)				 // table �� ����
	#define		GRID_H_P  	(CHT+45)				 // table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   			 // table Ŭ���� color
	#define		GRID_X	  	STARTX 					 // table ����x��ǥ
	#define		MAXCHAR	  	51 			    		 // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y	  	STARTY-29    			 // table ����y��ǥ
	#define		GRID_Y_P  	STARTY-40    			 // table ����y��ǥ PDA
	#define		GRID_ENDY  	(GRID_Y+(ROW+1)*GRID_H)  // table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�⹰��ȣ",	CWD*15, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",	    CWD*15, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�뵵",        CWD*9+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�跮���ȣ",  CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���ұ��ȣ",  CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};

	#define INIT_MAIN	1
	
	long m_bFirst;
	long m_lSelIndex = -1;
	long m_lLstpage = 0;
	long m_ltotLstcnt = 0;
	char m_Title[30];
	char m_szLstCnt_page[10];
	
	void SetStyle(void);
	void SetBtnImg(void);
	void SetClickData(void);
	void SetTotCnt(void);
	void REDRAW(void);
	void NoDel_Bur(void);
	void Clear_Screen(void);
	long SearchCD( char *CD, CodeTable *CT);
	void Find_Burner_Class_Cd(void);
	void Chk_Prod_Cd_Alarm(char* burclscd);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_Title),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX+500, STARTY+320, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750, STARTY+320, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX,	   STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NODEL, "�������"),
		DLG_BUTTON(STARTX+600, STARTY+819, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY+320, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szLstCnt_page),
		DLG_TEXT(STARTX,     STARTY+390, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKERNM, "������"),
		DLG_TEXT(STARTX+240, STARTY+390, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+460, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKENUM, "������ȣ"),
		DLG_TEXT(STARTX+240, STARTY+460, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+530, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_FORM, "����"),
		DLG_TEXT(STARTX+240, STARTY+530, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,     STARTY+600, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSDT, "��ġ����"),
		DLG_TEXT(STARTX+240, STARTY+600, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+670, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_VOLUME, "�뷮"),
		DLG_TEXT(STARTX+240, STARTY+670, 435, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+675, STARTY+670, 325, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),		
		DLG_TEXT(STARTX,     STARTY+740, 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSPLACE, "��ġ��ġ"),
		DLG_TEXT(STARTX+240, STARTY+740, 760, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
		
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_Title),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX+500, STARTY+370, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750, STARTY+370, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX+400, STARTY+809, 300, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NODEL, "�������"),
		DLG_BUTTON(STARTX+700, STARTY+809, 300, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY+370, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szLstCnt_page),
		DLG_TEXT(STARTX,     STARTY+440, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKERNM, "������"),
		DLG_TEXT(STARTX+240, STARTY+440, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+500, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_MAKENUM, "������ȣ"),
		DLG_TEXT(STARTX+240, STARTY+500, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+560, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_FORM, "����"),
		DLG_TEXT(STARTX+240, STARTY+560, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,     STARTY+620, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSDT, "��ġ����"),
		DLG_TEXT(STARTX+240, STARTY+620, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+680, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_VOLUME, "�뷮"),
		DLG_TEXT(STARTX+240, STARTY+680, 435, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+675, STARTY+680, 325, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),		
		DLG_TEXT(STARTX,     STARTY+740, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_INSPLACE, "��ġ��ġ"),
		DLG_TEXT(STARTX+240, STARTY+740, 760, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
					Card_Prev();
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
		
		//���ұ� ������� , TXT_TITLE
		Mem_Set( (byte*)m_Title, 0x00, sizeof(m_Title) );
		if( g_lNewBurFlag == 1 )
		{
			Str_Cpy(m_Title, "���Ϸ� �������");
		}
		else
		{
			Str_Cpy(m_Title, "���ұ� �������");
		}
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
				Find_Burner_Class_Cd();
				
				break;
//�������
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

				Str_Cpy(stScBur.MTR_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
				Str_Cpy(stScBur.BURNER_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
				
				SetClickData();
				
				m_lSelIndex = index - 1;
				lPage = m_lLstpage + index;
				SPRINT(m_szLstCnt_page, "%d/%d", lPage, m_ltotLstcnt, 0);
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
		if( g_lSCMoveFlag == 2 )
		{
			SPRINT(szSql, "SELECT MAKER_NM, MAKE_NUM, BOILER_FORM, BURNER_INST_YMD, BURNER_CAPA, BURNER_CAPA_UNIT \
			, INST_LOC_NM FROM NORMAL_BUR WHERE CHK_EXEC_NUM = ? AND BURNER_NUM = ? AND BURNER_KIND_NUM IN ('201', '301') AND INST_FLAG = '30' "
		   , 0, 0, 0);
		}
		else
		{
			SPRINT(szSql, "SELECT MAKER_NM, MAKE_NUM, BOILER_FORM, BURNER_INST_YMD, BURNER_CAPA, BURNER_CAPA_UNIT \
		   , INST_LOC_NM FROM NORMAL_BUR WHERE CHK_EXEC_NUM = ? AND BURNER_NUM = ? AND BURNER_KIND_NUM NOT IN ('201', '301') AND INST_FLAG = '30' "
		   , 0, 0, 0);

		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM, 12, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stScBur.BURNER_NUM, 6, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		if(sql->Next(sql) == TRUE)
		{
			//SPRINT(szSql, "SELECT MAKER_NM, MAKE_NUM, BOILER_FORM, BURNER_INST_YMD, BURNER_CAPA, BURNER_CAPA_UNIT \
			//, INST_LOC_NM FROM NORMAL_BUR WHERE CHK_EXEC_NUM = ? AND BURNER_NUM = ? AND BURNER_KIND_NUM IN ('201', '301') AND INST_FLAG = '30' "

			idx = 0;
			//������
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.MAKER_NM       		, 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1)   , stScBur.MAKER_NM);
			//������ȣ
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.MAKE_NUM            , 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)   , stScBur.MAKE_NUM);
			//����
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BOILER_FORM         , 20+ 1, DECRYPT );
			n = SearchCD( stScBur.BOILER_FORM, SCBOIL_FORM );
			if( n == -1 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)   , "");
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)   , SCBOIL_FORM[n].Str);
			}
			//��ġ����
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_INST_YMD     , 8 + 1, DECRYPT );
			g_Str_DateType( szDate, stScBur.BURNER_INST_YMD);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4)   , szDate);
			//�뷮
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_CAPA         , 10+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)   , stScBur.BURNER_CAPA);
			//�뷮����
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_CAPA_UNIT    , 20+ 1, DECRYPT );
			n = SearchCD( stScBur.BURNER_CAPA_UNIT, SCBOIL_CAPA );
			if( n == -1 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)   , "");
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)   , SCBOIL_CAPA[n].Str);
			}
			//��ġ��ġ
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.INST_LOC_NM         , 20+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)   , stScBur.INST_LOC_NM);
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
		char sztmp[501];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)&stScBur, 0x00, sizeof(stScBur) );

		SPRINT(m_szLstCnt_page, "%d/%d", m_lLstpage+1, m_ltotLstcnt, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		if( g_lSCMoveFlag == 2 )
		{
/*			SPRINT(sztmp, "SELECT BURNER_NUM, BURNER_KIND_NM, BURNER_CAPA, MTR_NUM  \
		   FROM NORMAL_BUR WHERE CHK_EXEC_NUM = ? AND BURNER_KIND_NUM IN ('201', '301') AND INST_FLAG = '30' LIMIT ?, ? "
		   , 0, 0, 0);
*/
			SPRINT(sztmp, "SELECT MTR_ID_NUM, BURNER_KIND_NM, BURNER_CLASS_NM, MTR_NUM, BURNER_NUM \
		   FROM NORMAL_BUR WHERE CHK_EXEC_NUM = ? AND BURNER_KIND_NUM IN ('201', '301') AND INST_FLAG = '30' LIMIT ?, ? "
		   , 0, 0, 0);
		}
		else
		{
			SPRINT(sztmp, "SELECT MTR_ID_NUM, BURNER_KIND_NM, BURNER_CLASS_NM, MTR_NUM, BURNER_NUM \
		   FROM NORMAL_BUR WHERE CHK_EXEC_NUM = ? AND BURNER_KIND_NUM NOT IN ('201', '301') AND INST_FLAG = '30' LIMIT ?, ? "
		   , 0, 0, 0);
		}

		hstmt = sql->CreateStatement(sql, sztmp);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM	    ,12	,DECRYPT);
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
				//
				idx = 0;
				//�⹰��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//�뵵
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );					
				//�跮���ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 9 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//���ұ��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 6 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			}
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lSelIndex == -1 )
		{
			m_lSelIndex = 0;
		}
		
		if( m_ltotLstcnt > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
				
			Str_Cpy(stScBur.MTR_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 3));
			Str_Cpy(stScBur.BURNER_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
			
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
		char sztmp[10];
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql, "SELECT DATA_FLAG FROM NORMAL_BUR WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s' AND BURNER_NUM = '%s' ", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, stScBur.BURNER_NUM );
		g_Sql_RetStr( szSql, 3, sztmp);
		
		if( Str_Cmp( sztmp, "20") == 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_BUR \
			                  SET BURNER_REMOV_YMD='', INST_FLAG = '20', CHG_FLAG = '2', SEND_YN = 'S' \
			                WHERE CHK_EXEC_NUM = ? AND MTR_NUM = ? AND BURNER_NUM = ?"
						, 0, 0, 0 );
		}
		else
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_BUR \
			                  SET BURNER_REMOV_YMD='', INST_FLAG = '20', CHG_FLAG = '2', SEND_YN = 'N' \
			                WHERE CHK_EXEC_NUM = ? AND MTR_NUM = ? AND BURNER_NUM = ?"
						, 0, 0, 0 );
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM	    ,12	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_NUM	    ,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_NUM	,6	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "������� �Ǿ����ϴ�.");
			m_lLstpage = 0;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
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

//========================================================================================
	void SetTotCnt(void)
	{
		char szSql[300];
	
		if( g_lSCMoveFlag == 2 )
		{	//���Ϸ�
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_BUR  WHERE CHK_EXEC_NUM = '%s' AND BURNER_KIND_NUM IN ('201', '301') AND INST_FLAG = '30' ",g_szCHK_EXEC_NUM, 0, 0 );
			g_Sql_RetInt( szSql, &m_ltotLstcnt );
		}
		else
		{	//���ұ� g_lSCMoveFlag == 1
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_BUR  WHERE CHK_EXEC_NUM = '%s' AND BURNER_KIND_NUM NOT IN ('201', '301') AND INST_FLAG = '30' ",g_szCHK_EXEC_NUM, 0, 0 );
			g_Sql_RetInt( szSql, &m_ltotLstcnt );
		}
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
	
	void Find_Burner_Class_Cd(void)
	{	
		long i;
		char sztmp[8];
		char burclscd[8];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)burclscd, 0x00, sizeof(burclscd) );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT BURNER_CLASS_CD \
 										     FROM NORMAL_BUR \
										    WHERE (INST_FLAG <> '30' OR  INST_FLAG  IS NULL) \
											  AND CHK_EXEC_NUM= ? \
										    GROUP BY BURNER_CLASS_CD ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    ,8 +1, DECRYPT );
			Str_Cat(burclscd, sztmp);
		}
		
		Chk_Prod_Cd_Alarm(burclscd);

	Finally:
		DelSqLite(sql);
		return;	
	}
	
	void Chk_Prod_Cd_Alarm(char* burclscd)
	{
		long i;
		long chk_count = 0;
		
		char sztmp[8];

		char szSql[50];
		char szProd[5];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)szProd, 0x00, sizeof(szProd));
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		
		SPRINT(szSql, "SELECT PROD_CD FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0);

		g_Sql_RetStr(szSql, 10, szProd);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT PROD_CD FROM C6101_BIZ_BURN A WHERE BURNER_CLASS_CD = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)burclscd , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    , 8 +1, DECRYPT );

			if( Str_Cmp(sztmp, szProd) == 0 )
			{
				chk_count ++;
			}	
		}

		if( Str_Cmp(stSc.CENTER_CD, "41") == 0 || Str_Cmp(stSc.CENTER_CD, "42") == 0 || Str_Cmp(stSc.CENTER_CD, "43") == 0 || Str_Cmp(stSc.CENTER_CD, "44") == 0 || Str_Cmp(stSc.CENTER_CD, "45") == 0 || Str_Cmp(stSc.CONT_STS_CD, "30") == 0 )
		{
			Card_Prev();
		}
		else
		{
			if( Str_Cmp(szProd, "11") == 0 || Str_Cmp(szProd, "12") == 0 || Str_Cmp(szProd, "13") == 0 
			    || Str_Cmp(szProd, "81") == 0 || Str_Cmp(szProd, "82") == 0 || Str_Cmp(szProd, "83") == 0)
			{
				if(chk_count == 0)
				{
					MessageBoxEx (CONFIRM_OK, "��ǰ�� �������ּ���!");
		
					Card_Move("SC_PRODCHG");
				}
				else
				{
					Card_Prev();
				}
			}
			else
			{
				Card_Prev();
			}
		}

Finally:
		DelSqLite(sql);
		return;	
	}
}


