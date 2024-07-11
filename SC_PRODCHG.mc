/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_PRODCHG
	Card Desc : ��������_��ǰ����
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_PRODCHG
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
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_UP1 )
		DEF_BUTTON_ID ( BID_DOWN1 )
		DEF_BUTTON_ID ( BID_UP2 )
		DEF_BUTTON_ID ( BID_DOWN2 )
		DEF_BUTTON_ID ( BID_SAVEPROD )
		DEF_BUTTON_ID ( BID_SUBCLOSE )
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// ī�峻���� ���� ��Ʈ�� ���̵� ����
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		DEF_OBJECT_ID ( ID_TBLLIST )
		DEF_OBJECT_ID ( ID_TBLLIST2 )
		DEF_OBJECT_ID ( TXT_PAGE )
		DEF_OBJECT_ID ( TXT_PAGE2 )
		DEF_OBJECT_ID ( TXT_ORI_PROD )
		DEF_OBJECT_ID ( TXT_ORI_PROD_NM )
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// �⺻���� DLGȭ�� ����
	//---------------------------------------------------------------
	#define INIT_MAIN		1
	
	#define		ROW_B 	    4					// table�� �ళ��
	#define		COL_B 	    4					// table�� ������
	#define		GRID_H_B		(CHT+20)		// table �� ����	
	#define		GRID_X_B		STARTX 			// table ����x��ǥ
	#define		GRID_Y_B		STARTY+91  	    // table ����y��ǥ
	#define		GRID_ENDY_B   	(GRID_Y_B+(ROW_B+1)*GRID_H_B) //table������ row�� Y��
	
	#define		ROW_P 	    4					// table�� �ళ��
	#define		COL_P 	    3					// table�� ������
	
	#define		ROWP 	    13					// table�� �ళ��
	
	#define		GRID_ENDY_P   	(GRID_ENDY_B+SYH+55+(ROW_P+1)*GRID_H_B)
	#define		MAXCHAR		101 			    // table�� ���� �ִ� �ִ�  char ����
	#define 	SYH			(CHT+15)
	
	char	m_szTableBufbiz [COL_B*(ROW_B+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	char	m_szTableBufprod [COL_P*(ROW_P+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����

	Column m_stGridTitlebiz[] = 
	{
		{"�����з�", CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"������Ī", CWD*21+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code"    , 0, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code"    , 0, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};
	
	Column m_stGridTitleprod[] = 
	{
		{"�ڵ�", CWD*11, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ǰ", CWD*28+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code", 0, EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	long m_bFirst;
	char m_szBiz_type_cd[7];
	char m_szBiz_type_class_cd[3];
	char m_szProd_cd[3];
	char m_szProd_nm[51];

	char m_szCnt_index[11];
	char m_szCnt_index2[11]; 
	long m_lpage2;
	long m_lpage3;
	long m_lTotpage2;
	long m_lTotpage3;
	long m_lActRow = 0;
	long m_lActRow2 = 0;

	char m_mtr_grd[6];
	char m_before_prod_cd[5];
	char m_before_prod_nm[50];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void SetData(void);

	void Get_Burclasscd(char* key1, char* burclscd);
	void Draw_Biz(void);
	void Draw_Prod(void);
	bool Save_Prod(void);

	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ǰ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT(STARTX, 	 STARTY-13, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ORI_PROD, "���� ��ǰ"),
		DLG_TEXT(STARTX+250, STARTY-13, 750, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ORI_PROD_NM, ""),
		
		DLG_TABLE (GRID_X_B, GRID_Y_B,            ROW_B, COL_B, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitlebiz, ID_TBLLIST, m_szTableBufbiz),
		
		DLG_BUTTON(STARTX,   	GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP1, " ��"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN1, " ��"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),

		DLG_TABLE (GRID_X_B, GRID_ENDY_B+SYH+55, ROW_P, COL_P, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitleprod, ID_TBLLIST2, m_szTableBufprod),

		DLG_BUTTON(STARTX,   	GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP2, " ��"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN2, " ��"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE2, m_szCnt_index2),
		DLG_BUTTON( STARTX+750, GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVEPROD, "Ȯ ��"),
		
	};
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ǰ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT(STARTX, 	 STARTY-13, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ORI_PROD, "���� ��ǰ"),
		DLG_TEXT(STARTX+250, STARTY-13, 750, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ORI_PROD_NM, ""),
		
		DLG_TABLE (GRID_X_B, GRID_Y_B,            ROW_B, COL_B, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitlebiz, ID_TBLLIST, m_szTableBufbiz),
		
		DLG_BUTTON(STARTX,   	GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP1, " ��"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN1, " ��"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),

		DLG_TABLE (GRID_X_B, GRID_ENDY_B+SYH+55, ROW_P, COL_P, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitleprod, ID_TBLLIST2, m_szTableBufprod),

		DLG_BUTTON(STARTX,   	GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP2, " ��"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN2, " ��"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE2, m_szCnt_index2),
		DLG_BUTTON( STARTX+750, GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVEPROD, "Ȯ ��"),
	};

	//������������������������������������������������������������������������������
	//�� 				   ��	OnInit Function  ��  				              ��
	//������������������������������������������������������������������������������
	void OnInit(char bFirst)
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
				break;	
		}
		
		SetBtnImg();	
		SetStyle();
		SetData();
		
		m_lActRow = 0;
		m_lActRow2 = 0;
		m_lpage2 = 0;
		m_lpage3 = 0;
		
		Draw_Biz();
	}
	
	//---------------------------------------------------------------
	// OnButton() / ��ư �̺�Ʈ
	//---------------------------------------------------------------
	void OnButton(long ID)
	{
		switch(ID)
		{
			case BID_SUBCLOSE:
				ON_EXIT();
				
				if(g_nProdMoveFlag == 0)
				{
					Card_Move("SC_BOILCHK");
				}
				else if(g_nProdMoveFlag == 1)
				{
					Card_Move("SC_BNCHK");
				}
				break;
				
			case BID_SAVEPROD:
				if( !Save_Prod() )
				{
					break;
				}
				
				//MessageBoxEx (CONFIRM_OK, "��ǰ������ �Ϸ�Ǿ����ϴ�.");
						
				/* 20180423 ��ǰ������ �Ͼ�� �� �跮������ȭ�鿡 �����ư �����޶�� �˸������ ����, CS�� �豤�� ����� */
				if( Str_Cmp( m_before_prod_cd, m_szProd_cd ) != 0 )
				{	
					
					MessageBoxEx (CONFIRM_OK, "��ǰ������ �Ϸ�Ǿ����ϴ�.\n�跮�� ����ȭ�鿡��\n��ħ Ȯ�� �� [ ���� ]�� �� �����ּ���!");
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "Ȯ���߽��ϴ�.");
				}
				
				ON_EXIT();
				
				if(g_nProdMoveFlag == 0)
				{
					Card_Move("SC_BOILCHK");
				}
				else if(g_nProdMoveFlag == 1)
				{
					Card_Move("SC_BNCHK");
				}
				break;
				
			case BID_UP1:
				m_lpage2--;
				if(m_lpage2 < 0)
				{
					m_lpage2 = 0;
				}
				m_lActRow = 0;
				Draw_Biz();
				break;
						
			case BID_DOWN1:
				m_lpage2++;
				if( m_lpage2 > m_lTotpage2-1 )
				{
					m_lpage2 = m_lTotpage2-1;
				}
				m_lActRow = 0;
				Draw_Biz();
				break;

			case BID_UP2:
				m_lpage3--;
				if(m_lpage3 < 0)
				{
					m_lpage3 = 0;
				}
				m_lActRow = 0;
				Draw_Prod();
				break;
				
			case BID_DOWN2:
				m_lpage3++;
				if( m_lpage3 > m_lTotpage3-1 )
				{
					m_lpage3 = m_lTotpage3-1;
				}
				m_lActRow = 0;
				Draw_Prod();
				break;
		}
	}
	
	//---------------------------------------------------------------
	// OnSelect() / �׸��� Ŭ�� �̺�Ʈ
	//---------------------------------------------------------------
	void OnSelect(long Index)
	{
		long index = -1;
		
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			// ���� �ε����� ���� �ε����� ���� �� ���
			Mem_Set((byte*)m_szBiz_type_cd , 0x00, sizeof(m_szBiz_type_cd));
			Mem_Set((byte*)m_szBiz_type_class_cd , 0x00, sizeof(m_szBiz_type_class_cd));
			Str_Cpy( m_szBiz_type_cd ,       DlgTbl_GetStr( ID_TBLLIST, index-1, 2)  );
			Str_Cpy( m_szBiz_type_class_cd , DlgTbl_GetStr( ID_TBLLIST, index-1, 3)  );
			
			m_lActRow = index-1;
			m_lActRow2 = 0;
			Draw_Prod();
			ON_DRAW();
		}
		else if(DlgTbl_IsSelect(ID_TBLLIST2))
		{
			index = DlgTbl_GetActiveRow(ID_TBLLIST2);
			Mem_Set((byte*)m_szProd_cd , 0x00, sizeof(m_szProd_cd));
			Mem_Set((byte*)m_szProd_nm , 0x00, sizeof(m_szProd_nm));				
			Str_Cpy( m_szProd_cd , DlgTbl_GetStr( ID_TBLLIST2, index-1, 0)  );
			Str_Cpy( m_szProd_nm , DlgTbl_GetStr( ID_TBLLIST2, index-1, 1)  );
			
			m_lActRow2 = index-1;				
		}
	}
	
	//---------------------------------------------------------------
	// SetBtnImg() / ��ư �̹��� ����
	//---------------------------------------------------------------
	void SetBtnImg(void)
	{
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	//---------------------------------------------------------------
	// SetStyle() / ��Ÿ�� ����
	//---------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ORI_PROD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
		
	//---------------------------------------------------------------
	// SetData() / �ʱ� ������ ����
	//---------------------------------------------------------------
	void SetData(void)
	{
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT PROD_CD, PROD_NM, MTR_GRD FROM NORMAL_MTR WHERE CHK_EXEC_NUM = %s ", g_szCHK_EXEC_NUM, 0, 0 );
		
		hstmt = sql->CreateStatement(sql, szSql);
		
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

		if(sql->Next(sql) == TRUE)
		{
			Mem_Set( (byte*)m_before_prod_cd, 0x00, sizeof(m_before_prod_cd) );
			sql->GetValue( sql, 0, 'U', (long*) m_before_prod_cd, 5, DECRYPT );
			
			Mem_Set( (byte*)m_before_prod_nm, 0x00, sizeof(m_before_prod_nm) );
			sql->GetValue( sql, 1, 'U', (long*) m_before_prod_nm, 50, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ORI_PROD_NM)   , m_before_prod_nm);

			Mem_Set( (byte*)m_mtr_grd, 0x00, sizeof(m_mtr_grd) );
			sql->GetValue( sql, 2, 'U', (long*) m_mtr_grd, 6, DECRYPT );
		}
		
Finally:
		DelSqLite(sql);
		return;
	}
	
	//---------------------------------------------------------------
	// Draw_Biz() / �����з�, ������Ī �׸��� ����
	//---------------------------------------------------------------
	void Draw_Biz(void)
	{
		long i, idx;
		long k = ROWP+1;
		long lTotPage;
		long lstartidx;
		char sztmp[51];
		char szbuf[51];
		char szSql[200];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, " SELECT COUNT(*) FROM C6101_BIZ_TYPE WHERE BIZ_TYPE_CLASS_CD = '01' ", 0, 0, 0);

		g_Sql_RetInt(szSql, &m_lTotpage2);
		
		if( m_lTotpage2 % ROW_B > 0 )
		{
			m_lTotpage2 = (m_lTotpage2 / ROW_B) + 1;
		}
		else
		{
			m_lTotpage2 = m_lTotpage2 / ROW_B;
		}
		
		SPRINT(m_szCnt_index, "%d/%d", m_lpage2+1, m_lTotpage2,0);

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, " SELECT BIZ_TYPE_CLASS_NM \
											  	 , BIZ_TYPE_NM \
												 , BIZ_TYPE_CD \
												 , BIZ_TYPE_CLASS_CD \
											  FROM C6101_BIZ_TYPE \
											 WHERE BIZ_TYPE_CLASS_CD = '01' \
											 ORDER BY BIZ_TYPE_CLASS_CD, BIZ_TYPE_CD LIMIT ?, ? " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		
		lstartidx = m_lpage2*ROW_B;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		
		i = m_lpage2*ROW_B+ROW_B;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW_B ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				k = i + 1;
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
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}
		
Finally:
		DelSqLite(sql);
		
		if( m_lTotpage2 > 0 )
		{
			m_lActRow = 0;
			
			DlgTbl_SetActive(ID_TBLLIST , m_lActRow+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActRow+1, TABLEACTIVE_COLOR);
			
			Mem_Set((byte*)m_szBiz_type_cd , 0x00, sizeof(m_szBiz_type_cd));
			Mem_Set((byte*)m_szBiz_type_class_cd , 0x00, sizeof(m_szBiz_type_class_cd));
			Str_Cpy( m_szBiz_type_cd ,       DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 2)  );
			Str_Cpy( m_szBiz_type_class_cd , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
			
			m_lActRow2 = 0;
			Draw_Prod();
		}
		else
		{
			m_lActRow = -1;
			m_lActRow2 = -1;
			Mem_Set((byte*)m_szBiz_type_cd , 0x00, sizeof(m_szBiz_type_cd));
			Mem_Set((byte*)m_szBiz_type_class_cd , 0x00, sizeof(m_szBiz_type_class_cd));	
		}
		
		ON_DRAW();
	}

	//---------------------------------------------------------------
	// Draw_Prod() / �����з�,������Ī Ŭ�� �� �ڵ�, ��ǰ �׸��� ����
	//---------------------------------------------------------------
	void Draw_Prod(void)
	{
		long i, idx;
		long k = ROWP+1;
		long lTotPage;
		long lstartidx;
		char sztmp[51];
		char szbuf[51];
		char szSql[600];
		char szBiz_class_cd2[3];
		char szBurner_class_cd[10 ];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBiz_class_cd2, 0x00, sizeof(szBiz_class_cd2) );

		if(Str_Cmp(m_szBiz_type_cd, "090003" ) == 0 || Str_Cmp(m_szBiz_type_cd, "040006" ) == 0 || Str_Cmp(m_szBiz_type_cd, "040008" ) == 0)
		{	
			Str_Cpy(szBiz_class_cd2, "01");
		}
		else
		{
			Str_Cpy(szBiz_class_cd2, "");
		}
		
		Mem_Set( (byte*)szBurner_class_cd, 0x00, sizeof(szBurner_class_cd) );
		Get_Burclasscd(g_szCHK_EXEC_NUM, szBurner_class_cd );

		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, " SELECT COUNT(1) \
					  	  FROM C6101_BIZ_PROD A \
						 WHERE A.BIZ_TYPE_CLASS_CD IN ( '%s', '%s' ) \
						   AND A.PROD_CD IN (SELECT PROD_CD \
						                       FROM C6101_BIZ_BURN \
						                      WHERE BURNER_CLASS_CD ='%s' \
						                        AND PROD_CD <> '14' ) ", m_szBiz_type_class_cd, szBiz_class_cd2, szBurner_class_cd );

		g_Sql_RetInt(szSql, &m_lTotpage3);
		
		if( m_lTotpage3 % ROW_P > 0 )
		{
			m_lTotpage3 = (m_lTotpage3 / ROW_P) + 1;
		}
		else
		{
			m_lTotpage3 = m_lTotpage3 / ROW_P;
		}
		
		SPRINT(m_szCnt_index2, "%d/%d", m_lpage3+1, m_lTotpage3,0);
		
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT A.PROD_CD AS PROD_CD \
											    , (SELECT PROD_NM FROM C6101_PROD X WHERE X.PROD_CD = A.PROD_CD) AS PROD_NM \
											 FROM C6101_BIZ_PROD A \
											WHERE A.BIZ_TYPE_CLASS_CD IN ( ?, ? ) \
											  AND A.PROD_CD IN ( SELECT PROD_CD FROM C6101_BIZ_BURN WHERE BURNER_CLASS_CD = ? AND PROD_CD <> '14') \
											GROUP BY A.PROD_CD LIMIT ?, ? " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
			
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)m_szBiz_type_class_cd , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)szBiz_class_cd2 , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)szBurner_class_cd , 10, DECRYPT);
		
		lstartidx = m_lpage3*ROW_P;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage3*ROW_P+ROW_P;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW_P ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST2, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 1, "" );
				k = i + 1;
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST2, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 1, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 8, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 1, sztmp );				
			}
		}

Finally:

		DelSqLite(sql);
		
		if( m_lTotpage3 > 0 )
		{
			m_lActRow2 = 0;
			DlgTbl_SetActive(ID_TBLLIST2 , m_lActRow2+1 );
			DlgTbl_SetRowColor(ID_TBLLIST2, m_lActRow2+1, TABLEACTIVE_COLOR);
			Mem_Set((byte*)m_szProd_cd , 0x00, sizeof(m_szProd_cd));
			Mem_Set((byte*)m_szProd_nm , 0x00, sizeof(m_szProd_nm));			
			Str_Cpy( m_szProd_cd , DlgTbl_GetStr( ID_TBLLIST2, m_lActRow2, 0)  );
			Str_Cpy( m_szProd_nm , DlgTbl_GetStr( ID_TBLLIST2, m_lActRow2, 1)  );
		}
		else
		{
			m_lActRow2 = -1;
			Mem_Set((byte*)m_szProd_cd , 0x00, sizeof(m_szProd_cd));
			Mem_Set((byte*)m_szProd_nm , 0x00, sizeof(m_szProd_nm));
		}
		ON_DRAW();
	}	
		
	//---------------------------------------------------------------
	// Get_Burclasscd() / �ڵ�, ��ǰ ���� �� �ʿ��� ���ұ� Ŭ���� �ڵ� ����
	//---------------------------------------------------------------
	void Get_Burclasscd(char* key1, char* burclscd)
	{
		long i;
		char sztmp[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT BURNER_CLASS_CD \
 										     FROM NORMAL_BUR \
										    WHERE (INST_FLAG <> '30' OR  INST_FLAG  IS NULL) \
											  AND CHK_EXEC_NUM= ? \
											  AND BURNER_KIND_NUM <> '398' \
										    GROUP BY BURNER_CLASS_CD ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)key1 , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    ,10 +1, DECRYPT );
			Str_Cat(burclscd, sztmp);
		}

Finally:
		DelSqLite(sql);
		return;
	}

	//---------------------------------------------------------------
	// Save_Prod() / ��ǰ ���� ����
	//---------------------------------------------------------------
	bool Save_Prod(void)
	{
		char szSql[300];
		handle* sql;
		char * sqlstr = "";	

		if( Str_Len(m_szProd_cd) == 0  )
		{
			MessageBoxEx (ERROR_OK, "���ұ⸦ ����ϰ� ��ǰ�� �����ϼ���.");
			return FALSE;
		}

		if(m_lActRow2 == -1)
		{
			MessageBoxEx (ERROR_OK, "��ǰ�� �����ϼ���.");
			return FALSE;
		}
		
		// 20170915, 20180202�߰�����,  ������ ����� ��û, �ű�ȣ ���� : ��ǰ�ڵ� 14,16,24,26,34,37,41,45,47,51,52,53,54,55,56,58,59,79,88�� ������ 26�� ��쿡�� ����(����) ����
		if( Str_Cmp(stSc.DEADLINE_FLAG,"26") != 0 )
		{
			if( Str_Cmp(m_szProd_cd,"14") == 0 || Str_Cmp(m_szProd_cd,"16") == 0 || Str_Cmp(m_szProd_cd,"24") == 0 
			 || Str_Cmp(m_szProd_cd,"26") == 0 || Str_Cmp(m_szProd_cd,"34") == 0 || Str_Cmp(m_szProd_cd,"37") == 0 
			 || Str_Cmp(m_szProd_cd,"41") == 0 || Str_Cmp(m_szProd_cd,"45") == 0 || Str_Cmp(m_szProd_cd,"47") == 0 
			 || Str_Cmp(m_szProd_cd,"51") == 0 || Str_Cmp(m_szProd_cd,"52") == 0 || Str_Cmp(m_szProd_cd,"53") == 0
			 || Str_Cmp(m_szProd_cd,"54") == 0 || Str_Cmp(m_szProd_cd,"55") == 0 || Str_Cmp(m_szProd_cd,"56") == 0 
			 || Str_Cmp(m_szProd_cd,"58") == 0 || Str_Cmp(m_szProd_cd,"59") == 0 || Str_Cmp(m_szProd_cd,"79") == 0 
			 || Str_Cmp(m_szProd_cd,"88") == 0 )
			{
				MessageBoxEx (ERROR_OK, "�ش��ǰ�� 26���⸸\n����(����)�����մϴ�.");
				return FALSE;
			}
		}

		// 20171123 ������ ����� �߰���û, �ű�ȣ ���� : �跮���� 100��� �̸� �߾ӳ����ǰ ���úҰ�
		if( Str_AtoI(m_mtr_grd) < 100 && Str_Cmp(m_szProd_cd,"16") == 0 )
		{
			MessageBoxEx (ERROR_OK, "�跮���� 100��� �̸��� ���\n<�߾ӳ���>��ǰ���� �Ұ��մϴ�.");
			return FALSE;
		}

		// 20180202 ������ ����� �߰���û, �ű�ȣ ���� : ���δ� ��ǰ���� �Ϲݻ�ǰ ��ȯ�� �˸� �߰�
		if(( Str_Cmp(m_before_prod_cd, "36") == 0 || Str_Cmp(m_before_prod_cd,"37") == 0 || Str_Cmp(m_before_prod_cd,"39") == 0 || Str_Cmp(m_before_prod_cd,"81") == 0 || Str_Cmp(m_before_prod_cd,"82") == 0 || Str_Cmp(m_before_prod_cd,"83") == 0 || Str_Cmp(m_before_prod_cd,"84") == 0 || Str_Cmp(m_before_prod_cd,"86") == 0  ) 
		    && ( Str_Cmp(m_szProd_cd,"36") != 0 && Str_Cmp(m_szProd_cd,"37") != 0 && Str_Cmp(m_szProd_cd, "39") != 0 || Str_Cmp(m_before_prod_cd,"81") != 0 || Str_Cmp(m_before_prod_cd,"82") != 0 || Str_Cmp(m_before_prod_cd,"83") != 0 || Str_Cmp(m_before_prod_cd,"84") != 0 || Str_Cmp(m_before_prod_cd,"86") != 0 ))
		{
			if( MessageBoxEx(CONFIRM_YESNO, "������ǰ�� ���δ� ��ǰ�Դϴ�.\n�Ϲݻ�ǰ���� ����Ͻðڽ��ϱ�?") != MB_OK)
			{
				return FALSE;
			}
		}
		
		// 20180116 ������ ����� �߰���û, �ű�ȣ ���� : ���δ� ��ǰ�� ���δ����ڸ� �����ϵ��� �ڵ� �߰�
		if( Str_Cmp(m_szProd_cd, "36") == 0 || Str_Cmp(m_szProd_cd, "37") == 0 || Str_Cmp(m_szProd_cd, "39") == 0 
		   || Str_Cmp(m_szProd_cd, "81") == 0 || Str_Cmp(m_szProd_cd, "82") == 0 || Str_Cmp(m_szProd_cd, "83") == 0 || Str_Cmp(m_szProd_cd, "84") == 0 || Str_Cmp(m_szProd_cd, "86") == 0)
		{
			if( Str_Cmp(stMw.szGet_spc_tax_chk,"F") == 0 ) 
			{
		  		MessageBoxEx (ERROR_OK, "���δ� ��ǰ�� \n���δ� ����ڸ� \n���ð����մϴ�.");
		  		return FALSE;
			}
		}
		
		// 20190607 ������ ����� �߰���û, �ű�ȣ ���� : �Ϲ� ��ǰ�ڵ忡�� ����� ��ǰ�ڵ� 41, 47�� ���� �Ұ�
		if( ( Str_Cmp(m_before_prod_cd, "41") != 0 && Str_Cmp(m_before_prod_cd, "47") != 0 ) && ( Str_Cmp(m_szProd_cd, "41") == 0 || Str_Cmp(m_szProd_cd, "47") == 0 ) )
		{
	  		MessageBoxEx (ERROR_OK, "����� ��ǰ����\n����(����) �Ұ��մϴ�.");
	  		return FALSE;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );

		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," UPDATE NORMAL_MTR SET ");
		STRING_Append(sql," PROD_CD = '");
		STRING_Append(sql, m_szProd_cd );
		STRING_Append(sql,"' ,PROD_NM ='");
		STRING_Append(sql,  m_szProd_nm);
		STRING_Append(sql,"' WHERE CHK_EXEC_NUM = '");
		STRING_Append(sql, g_szCHK_EXEC_NUM);
		STRING_Append(sql,"' ");
		sqlstr = STRING_toString(sql);
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
		
		return TRUE;
	}
}
