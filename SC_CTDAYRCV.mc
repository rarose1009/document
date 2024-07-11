/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_CTDAYRCV
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
		DEF_BUTTON_ID ( BID_RECV )	//자료수신
		DEF_BUTTON_ID ( BID_SEL )	//자료수신
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_UP )	//홈
		DEF_BUTTON_ID ( BID_DOWN )	//홈
		
		DEF_BUTTON_ID ( BID_HOME )	//홈
		DEF_BUTTON_ID ( BID_MENU )	//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )	//이전
		DEF_BUTTON_ID ( BID_EXIT )	//종료
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( EDT_DATA )
		DEF_OBJECT_ID ( ID_TBLLIST )
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		DEF_OBJECT_ID ( CMB_DATA )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    9					// table의 행개수
	#define		COL 	    7					// table의 열개수
	#define		GRID_H		(CHT+28)			// table 행 높이
	#define		GRID_H_P	(CHT+42)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 				// table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+135  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+30  	    	//table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"그룹주소", CWD*17+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"구분", CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"대상", CWD*10 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"county", 0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"town", 0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"flag", 0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};	
	
	char m_szSafechktype[3];
	char m_szCmb_Str[20];
	char m_szCnt_page[20];
	
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;
	long m_lActive;
	long mCnt311320 = 0;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Save_Row(long row);
	void Sel_All(void);
	long TR311320(void);
	void Rev311320(void);
	long TR311321(void);
	void Rev311321(void);
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
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SCGS 일일자료수신"),
		
		DLG_COMBO (STARTX, 		STARTY+65, 460, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA, 10),
		DLG_BUTTON( STARTX+460, STARTY+65, 270, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON( STARTX+730, STARTY+65, 270, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),	
		
		DLG_TEXT(STARTX,       STARTY+815, 460, 84, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, EDT_DATA,  m_szCnt_page),
		DLG_BUTTON(STARTX+460, STARTY+815, 270, 84, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEL, "페이지선택"),
		DLG_BUTTON(STARTX+730, STARTY+815, 270, 84, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),

	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "SCGS 일일자료수신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_COMBO (STARTX,		STARTY-40, 400, 200, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA, 10),
		
		DLG_BUTTON( STARTX+400, STARTY-40, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON( STARTX+700, STARTY-40, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),	
		
		DLG_TEXT(STARTX,       STARTY+829, 400, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA,  m_szCnt_page),
		DLG_BUTTON(STARTX+400, STARTY+829, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEL, "페이지선택"),
		DLG_BUTTON(STARTX+700, STARTY+829, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
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
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA+2), "단독", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA+2), "공동", 0, ICON_NONE);
		Str_Cpy( m_szCmb_Str, "공동" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA), m_szCmb_Str);
		
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			//상단공통메뉴
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
	
	
	
	//-----------------------------------------------------------------
	void SetStyle(void)
	{	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
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
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;
				
				
			case BID_SEL:
				Sel_All();
				REDRAW();
				break;
				
				
			case BID_RECV:
				Rev311320();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "안전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
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
				Card_Move("SC_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void	OnSelect(long Index)
	{
		long index = -1;
		char sztmp[20];
		char szcmb[20];
	
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
						
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, index-1, 3) );
			if( Str_Cmp( sztmp, CHKOFF) == 0 )
			{
				DlgTbl_SetStr ( ID_TBLLIST, index-1, 3, CHKON );
				EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, index-1, 3 ), RED);

			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, index-1, 3, CHKOFF );
				EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, index-1, 3 ), BLUE );
			}
			
			m_lActive = index - 1;
			
			ON_DRAW();
			Save_Row(m_lActive);
			ON_DRAW();
			
			
		}
		else
		{
			DlgTbl_SetActive(ID_TBLLIST, m_lActive+1);
			ON_DRAW();
		}
		Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
		Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA) ) );
		//콤보박스 선택으로 리스트 목록 필터링.(검침,미검침,전체대상)
		if( Str_Cmp(m_szCmb_Str, szcmb ) != 0 )
		{
			Str_Cpy(m_szCmb_Str, szcmb);
			m_lpage = 0;
			REDRAW();
		}
		
	}
	
	void REDRAW(void)
	{
	long i, idx;
	long k = ROW + 1;
	long lTotpage = 0;
	char sztmp[201];
	long ret = -1;	
	long lstartidx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
		{
			g_Sql_RetInt( "SELECT COUNT(*) FROM REGTR_GROUP WHERE SINGLE_COLIVE_FLAG = '10' AND SEND_YN <> 'Y' OR SEND_YN IS NULL ", &lTotpage );
		}
		else
		{
			g_Sql_RetInt( "SELECT COUNT(*) FROM REGTR_GROUP WHERE SINGLE_COLIVE_FLAG <> '10' AND SEND_YN <> 'Y' OR SEND_YN IS NULL ", &lTotpage );
		}
			
		if( lTotpage % ROW > 0 )
		{
			m_lTotpage = (lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = lTotpage / ROW;
		}

		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotpage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
			hstmt = sql->CreateStatement(sql, "SELECT COUNTY||' '|| TOWN, SINGLE_COLIVE_FLAG, CNT, CHK_YN, COUNTY, TOWN FROM REGTR_GROUP WHERE SINGLE_COLIVE_FLAG = '10' AND SEND_YN <> 'Y' OR SEND_YN IS NULL LIMIT ?, ? " );
		else
			hstmt = sql->CreateStatement(sql, "SELECT COUNTY||' '|| TOWN, SINGLE_COLIVE_FLAG, CNT, CHK_YN, COUNTY, TOWN FROM REGTR_GROUP WHERE SINGLE_COLIVE_FLAG <> '10' AND SEND_YN <> 'Y' OR SEND_YN IS NULL LIMIT ?, ? " );	
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
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

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
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
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 190, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				if( Str_Cmp(sztmp, "10") == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "단독" );
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "공동" );
				}
									
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5, DECRYPT);
				if(sztmp[0] != '1')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, CHKOFF );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 3 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, CHKON );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 3 ), RED);
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 101, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 101, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				
			}
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		ON_DRAW();
		return;
	}
	
	void Save_Row(long row)
	{
	char sztmp[20];
	char szSql[300];
	char szCOUNTY[31];
	char szTOWN[31];
	char szCHK[2];
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szCHK ,0x00, sizeof(szCHK) );
		Mem_Set((byte*)szCOUNTY ,0x00, sizeof(szCOUNTY) );
		Mem_Set((byte*)szTOWN ,0x00, sizeof(szTOWN) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		
		
		Str_Cpy( szCOUNTY, DlgTbl_GetStr( ID_TBLLIST, row, 4) );
		Str_Cpy( szTOWN,   DlgTbl_GetStr( ID_TBLLIST, row, 5) );
		Str_Cpy( sztmp,    DlgTbl_GetStr( ID_TBLLIST, row, 3) );
		//선택된 경우
		if(Str_Cmp( sztmp, CHKON ) == 0)
		{
			szCHK[0] = '1';
		}
		else
		{
			szCHK[0] = '0';
		}
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
			SPRINT(szSql, " UPDATE REGTR_GROUP SET CHK_YN = '%s' WHERE SINGLE_COLIVE_FLAG = '10' AND COUNTY = '%s' AND TOWN= '%s' ", szCHK, szCOUNTY, szTOWN);
		else
			SPRINT(szSql, " UPDATE REGTR_GROUP SET CHK_YN = '%s' WHERE SINGLE_COLIVE_FLAG <> '10' AND COUNTY = '%s' AND TOWN= '%s' ", szCHK, szCOUNTY, szTOWN);
		g_Sql_DirectExecute( szSql );
	}
	
	void Sel_All(void)
	{
	long i, idx;
	char szSql[200];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	char sztmp[21];
	long ret = -1;			
	char szCOUNTY[31];
	char szTOWN[31];
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
			SPRINT(szSql, " UPDATE REGTR_GROUP SET CHK_YN = '1' WHERE SINGLE_COLIVE_FLAG = '10' AND COUNTY = ? AND TOWN= ? ", 0, 0, 0);
		else
			SPRINT(szSql, " UPDATE REGTR_GROUP SET CHK_YN = '1' WHERE SINGLE_COLIVE_FLAG <> '10' AND COUNTY = ? AND TOWN= ? ", 0, 0, 0);
		
		hstmt = sql->CreateStatement(sql, szSql);
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		for (i=0 ; i<ROW ; i++)
		{
			Mem_Set((byte*)szCOUNTY ,0x00, sizeof(szCOUNTY) );
			Mem_Set((byte*)szTOWN ,0x00, sizeof(szTOWN) );
			
			Str_Cpy( szCOUNTY,  DlgTbl_GetStr( ID_TBLLIST, i, 4) );
			Str_Cpy( szTOWN,    DlgTbl_GetStr( ID_TBLLIST, i, 5) );
			
			if( Str_Len(szCOUNTY) == 0 )
			{
				break;
			}
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szCOUNTY     ,30,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szTOWN       ,30,DECRYPT);
			
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
		}
Finally:
		DelSqLite(sql);
		return;
	}
	
	
	void Rev311320(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;
	
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, "SELECT count(*) FROM REGTR_GROUP WHERE CHK_YN = '1' AND SINGLE_COLIVE_FLAG = '10' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL)", 0, 0, 0 );
			g_Sql_RetInt(szSql, &ret);	
			if( ret <= 0 )
			{
				MessageBoxEx (CONFIRM_OK, "선택된 자료가 없습니다.");
				return;
			}
		}
		else
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, "SELECT count(*) FROM REGTR_GROUP WHERE CHK_YN = '1' AND SINGLE_COLIVE_FLAG <> '10' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL)", 0, 0, 0 );
			g_Sql_RetInt(szSql, &ret);	
			if( ret <= 0 )
			{
				MessageBoxEx (CONFIRM_OK, "선택된 자료가 없습니다.");
				return;
			}
			
		}

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) m_szSafechktype, 0x00, sizeof( m_szSafechktype) );
		SPRINT( szSql, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '3' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 3, m_szSafechktype);	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311320, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "safe_chk_type", m_szSafechktype);
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
			JSON_SetValue( g_pjcomm, 'C', "single_colive_flag", "10");
		else
			JSON_SetValue( g_pjcomm, 'C', "single_colive_flag", "20");
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311320; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311320_IN",  "FR311320" , sndbuf, sztmp );
		
	}
	
	long TR311320(void)
	{
		mCnt311320 = g_Chk_Json(311320);
		if( mCnt311320 >= 0)
		{
			Rev311321();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
		
	}
	
	void Rev311321(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311321, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "safe_chk_type", m_szSafechktype);
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
			JSON_SetValue( g_pjcomm, 'C', "single_colive_flag", "10");
		else
			JSON_SetValue( g_pjcomm, 'C', "single_colive_flag", "20");
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311321; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311321_IN",  "FR311321" , sndbuf, sztmp );
	}
	
	long TR311321(void)
	{
	char szSql[200];
	
		if(g_Chk_Json(311321) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
				SPRINT( szSql, " UPDATE REGTR_GROUP SET SEND_YN = 'Y' WHERE SINGLE_COLIVE_FLAG = '10' AND CHK_YN = '1' ", 0, 0, 0 );
			else
				SPRINT( szSql, " UPDATE REGTR_GROUP SET SEND_YN = 'Y' WHERE SINGLE_COLIVE_FLAG <> '10' AND CHK_YN = '1' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			if( mCnt311320 > 0)
				MessageBoxEx (CONFIRM_OK, "자료수신을 완료 했습니다.");
			else
				MessageBoxEx (CONFIRM_OK, "조정기 점검대상 자료가 없습니다!");
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
	
	
	long Add_Item(handle pj)
	{
	char szSql[500];
	char sztmp[20];
	long ret = -1;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	handle js = NULL;
	char szcounty[31];
	char sztown[31];
	char szUcounty[62];
	char szUtown[62];
		
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
		if( Str_Cmp( m_szCmb_Str, "단독" ) == 0 )
			hstmt = sql->CreateStatement(sql, "SELECT county, town FROM REGTR_GROUP WHERE CHK_YN = '1' AND SINGLE_COLIVE_FLAG = '10' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ");
		else
			hstmt = sql->CreateStatement(sql, "SELECT county, town FROM REGTR_GROUP WHERE CHK_YN = '1' AND SINGLE_COLIVE_FLAG <> '10' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ");
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
			Mem_Set( (byte*)szcounty,0x00, sizeof(szcounty) );
			Mem_Set( (byte*)sztown,0x00, sizeof(sztown) );
			sql->GetValue(sql, 0, 'U', (long*)szcounty, 31, DECRYPT);
			sql->GetValue(sql, 1, 'U', (long*)sztown, 31, DECRYPT);
			Mem_Set( (byte*)szUcounty,0x00, sizeof(szUcounty) );
			Mem_Set( (byte*)szUtown,0x00, sizeof(szUtown) );
			SQL_ConvUcStr( szUcounty, szcounty );
			SQL_ConvUcStr( szUtown, sztown );
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "county",  szUcounty );
			JSON_SetArrayItem(js, 'C', "town",    szUtown );
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

