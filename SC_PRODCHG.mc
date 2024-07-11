/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_PRODCHG
	Card Desc : 안전점검_상품변경
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
	// 카드내에서 사용될 콘트롤 아이디 정의
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
	// 기본정의 DLG화면 정의
	//---------------------------------------------------------------
	#define INIT_MAIN		1
	
	#define		ROW_B 	    4					// table의 행개수
	#define		COL_B 	    4					// table의 열개수
	#define		GRID_H_B		(CHT+20)		// table 행 높이	
	#define		GRID_X_B		STARTX 			// table 시작x좌표
	#define		GRID_Y_B		STARTY+91  	    // table 시작y좌표
	#define		GRID_ENDY_B   	(GRID_Y_B+(ROW_B+1)*GRID_H_B) //table마지막 row의 Y값
	
	#define		ROW_P 	    4					// table의 행개수
	#define		COL_P 	    3					// table의 열개수
	
	#define		ROWP 	    13					// table의 행개수
	
	#define		GRID_ENDY_P   	(GRID_ENDY_B+SYH+55+(ROW_P+1)*GRID_H_B)
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define 	SYH			(CHT+15)
	
	char	m_szTableBufbiz [COL_B*(ROW_B+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	char	m_szTableBufprod [COL_P*(ROW_P+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼

	Column m_stGridTitlebiz[] = 
	{
		{"업종분류", CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"업종명칭", CWD*21+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code"    , 0, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code"    , 0, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};
	
	Column m_stGridTitleprod[] = 
	{
		{"코드", CWD*11, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상품", CWD*28+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
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
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "상품선택"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT(STARTX, 	 STARTY-13, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ORI_PROD, "기존 상품"),
		DLG_TEXT(STARTX+250, STARTY-13, 750, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ORI_PROD_NM, ""),
		
		DLG_TABLE (GRID_X_B, GRID_Y_B,            ROW_B, COL_B, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitlebiz, ID_TBLLIST, m_szTableBufbiz),
		
		DLG_BUTTON(STARTX,   	GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP1, " ▲"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN1, " ▼"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),

		DLG_TABLE (GRID_X_B, GRID_ENDY_B+SYH+55, ROW_P, COL_P, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitleprod, ID_TBLLIST2, m_szTableBufprod),

		DLG_BUTTON(STARTX,   	GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP2, " ▲"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN2, " ▼"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE2, m_szCnt_index2),
		DLG_BUTTON( STARTX+750, GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVEPROD, "확 인"),
		
	};
	
	//---------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "상품선택"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT(STARTX, 	 STARTY-13, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ORI_PROD, "기존 상품"),
		DLG_TEXT(STARTX+250, STARTY-13, 750, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ORI_PROD_NM, ""),
		
		DLG_TABLE (GRID_X_B, GRID_Y_B,            ROW_B, COL_B, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitlebiz, ID_TBLLIST, m_szTableBufbiz),
		
		DLG_BUTTON(STARTX,   	GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP1, " ▲"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN1, " ▼"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),

		DLG_TABLE (GRID_X_B, GRID_ENDY_B+SYH+55, ROW_P, COL_P, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitleprod, ID_TBLLIST2, m_szTableBufprod),

		DLG_BUTTON(STARTX,   	GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP2, " ▲"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN2, " ▼"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE2, m_szCnt_index2),
		DLG_BUTTON( STARTX+750, GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVEPROD, "확 인"),
	};

	//┌─────────────────────────────────────┐
	//│ 				   『	OnInit Function  』  				              │
	//└─────────────────────────────────────┘
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
	// OnButton() / 버튼 이벤트
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
				
				//MessageBoxEx (CONFIRM_OK, "상품변경이 완료되었습니다.");
						
				/* 20180423 상품변경이 일어났을 시 계량기점검화면에 저장버튼 눌러달라고 알림띄우기로 협의, CS팀 김광식 차장님 */
				if( Str_Cmp( m_before_prod_cd, m_szProd_cd ) != 0 )
				{	
					
					MessageBoxEx (CONFIRM_OK, "상품변경이 완료되었습니다.\n계량기 점검화면에서\n지침 확인 및 [ 저장 ]을 꼭 눌러주세요!");
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "확인했습니다.");
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
	// OnSelect() / 그리드 클릭 이벤트
	//---------------------------------------------------------------
	void OnSelect(long Index)
	{
		long index = -1;
		
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
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
	// SetBtnImg() / 버튼 이미지 세팅
	//---------------------------------------------------------------
	void SetBtnImg(void)
	{
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	//---------------------------------------------------------------
	// SetStyle() / 스타일 세팅
	//---------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ORI_PROD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
		
	//---------------------------------------------------------------
	// SetData() / 초기 데이터 세팅
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
	// Draw_Biz() / 업종분류, 업종명칭 그리드 세팅
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
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_B ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
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
	// Draw_Prod() / 업종분류,업종명칭 클릭 후 코드, 상품 그리드 세팅
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
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_P ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
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
	// Get_Burclasscd() / 코드, 상품 세팅 시 필요한 연소기 클레스 코드 세팅
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
	// Save_Prod() / 상품 저장 로직
	//---------------------------------------------------------------
	bool Save_Prod(void)
	{
		char szSql[300];
		handle* sql;
		char * sqlstr = "";	

		if( Str_Len(m_szProd_cd) == 0  )
		{
			MessageBoxEx (ERROR_OK, "연소기를 등록하고 상품을 선택하세요.");
			return FALSE;
		}

		if(m_lActRow2 == -1)
		{
			MessageBoxEx (ERROR_OK, "상품을 선택하세요.");
			return FALSE;
		}
		
		// 20170915, 20180202추가개발,  정진혁 차장님 요청, 신기호 개발 : 상품코드 14,16,24,26,34,37,41,45,47,51,52,53,54,55,56,58,59,79,88은 납기일 26인 경우에만 변경(선택) 가능
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
				MessageBoxEx (ERROR_OK, "해당상품은 26납기만\n변경(선택)가능합니다.");
				return FALSE;
			}
		}

		// 20171123 정진혁 차장님 추가요청, 신기호 개발 : 계량기등급 100등급 미만 중앙난방상품 선택불가
		if( Str_AtoI(m_mtr_grd) < 100 && Str_Cmp(m_szProd_cd,"16") == 0 )
		{
			MessageBoxEx (ERROR_OK, "계량기등급 100등급 미만인 경우\n<중앙난방>상품선택 불가합니다.");
			return FALSE;
		}

		// 20180202 정진혁 차장님 추가요청, 신기호 개발 : 군부대 상품에서 일반상품 전환시 알림 추가
		if(( Str_Cmp(m_before_prod_cd, "36") == 0 || Str_Cmp(m_before_prod_cd,"37") == 0 || Str_Cmp(m_before_prod_cd,"39") == 0 || Str_Cmp(m_before_prod_cd,"81") == 0 || Str_Cmp(m_before_prod_cd,"82") == 0 || Str_Cmp(m_before_prod_cd,"83") == 0 || Str_Cmp(m_before_prod_cd,"84") == 0 || Str_Cmp(m_before_prod_cd,"86") == 0  ) 
		    && ( Str_Cmp(m_szProd_cd,"36") != 0 && Str_Cmp(m_szProd_cd,"37") != 0 && Str_Cmp(m_szProd_cd, "39") != 0 || Str_Cmp(m_before_prod_cd,"81") != 0 || Str_Cmp(m_before_prod_cd,"82") != 0 || Str_Cmp(m_before_prod_cd,"83") != 0 || Str_Cmp(m_before_prod_cd,"84") != 0 || Str_Cmp(m_before_prod_cd,"86") != 0 ))
		{
			if( MessageBoxEx(CONFIRM_YESNO, "종전상품이 군부대 상품입니다.\n일반상품으로 계약하시겠습니까?") != MB_OK)
			{
				return FALSE;
			}
		}
		
		// 20180116 정진혁 차장님 추가요청, 신기호 개발 : 군부대 상품은 군부대사업자만 가능하도록 코드 추가
		if( Str_Cmp(m_szProd_cd, "36") == 0 || Str_Cmp(m_szProd_cd, "37") == 0 || Str_Cmp(m_szProd_cd, "39") == 0 
		   || Str_Cmp(m_szProd_cd, "81") == 0 || Str_Cmp(m_szProd_cd, "82") == 0 || Str_Cmp(m_szProd_cd, "83") == 0 || Str_Cmp(m_szProd_cd, "84") == 0 || Str_Cmp(m_szProd_cd, "86") == 0)
		{
			if( Str_Cmp(stMw.szGet_spc_tax_chk,"F") == 0 ) 
			{
		  		MessageBoxEx (ERROR_OK, "군부대 상품은 \n군부대 사업자만 \n선택가능합니다.");
		  		return FALSE;
			}
		}
		
		// 20190607 정진혁 차장님 추가요청, 신기호 개발 : 일반 상품코드에서 산업용 상품코드 41, 47로 변경 불가
		if( ( Str_Cmp(m_before_prod_cd, "41") != 0 && Str_Cmp(m_before_prod_cd, "47") != 0 ) && ( Str_Cmp(m_szProd_cd, "41") == 0 || Str_Cmp(m_szProd_cd, "47") == 0 ) )
		{
	  		MessageBoxEx (ERROR_OK, "산업용 상품으로\n변경(선택) 불가합니다.");
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
