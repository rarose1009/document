/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_CMMRCV
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
		DEF_BUTTON_ID ( BID_RECV )		//자료수신
		DEF_BUTTON_ID ( BID_ALL )			//자료수신
		DEF_BUTTON_ID ( BID_UP )
		DEF_BUTTON_ID ( BID_DOWN )
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )
		DEF_OBJECT_ID ( ICON_TITLE)		//타이틀
		DEF_OBJECT_ID ( ID_TBLLIST ) // 테이블 리스트
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    9					// table의 행개수
	#define		COL 	    8					// table의 열개수
	#define		GRID_H		(CHT+31)			// table 행 높이
	#define		GRID_H_P	(CHT+40)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 		    	// table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+125  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+40    	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"그룹주소", CWD*28+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"대상",     CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"",         CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"TOWN",         0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ADDR1_M",      0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ADDR1_S",      0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CO_LIVE_NM",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"BLD_NM",       0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;
	char m_szCnt_page[10];
	long m_lActive;
	long mCnt511306 = 0;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void Save_Row(long row);
	void Sel_All(void);
	void REDRAW(void);
	long Add_Item(handle pj);
	void Rev511306(void);
	long TR511306(void);
	void Rev511307(void);
	long TR511307(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공동자료 수신"),
		
		DLG_TEXT(STARTX,        STARTY+65, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지				
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750,  STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),	
		
		DLG_BUTTON(STARTX,  	STARTY+830, 300, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ALL, "페이지선택"),
		DLG_BUTTON(STARTX+700,  STARTY+830, 300, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),		
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//화면캡쳐
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "공동자료 수신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_TEXT(   STARTX,    STARTY-40, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지				
		DLG_BUTTON(STARTX+500, STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),	

		DLG_BUTTON(STARTX,      STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ALL, "페이지선택"),
		DLG_BUTTON(STARTX+600,  STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
						
						SetBtnImg();
						REDRAW();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						SetBtnImg();
						REDRAW();
						break;		
				}
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
			case BID_ALL:
				Sel_All();
				REDRAW();
				break;
				
			case BID_RECV:
				Rev511306();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "공급전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("BF_BEFOMENU");
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
				Card_Move("BF_BEFODMMENU");
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
	
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
						
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
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
			DlgTbl_SetActive(ID_TBLLIST, m_lActive+1);
			ON_DRAW();
		}
	}
	
	
	
	void REDRAW(void)
	{
	long i, idx;
	long k = ROW + 1;
	char sztmp[201];
	long ret = -1;	
	long lstartidx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		g_Sql_RetInt( "SELECT COUNT(*) FROM BEFO_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ", &m_lTotpage );
			
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
		hstmt = sql->CreateStatement(sql, "SELECT TOWN||' '||ADDR1_M||'-'||ADDR1_S||' '||CO_LIVE_NM||' '|| BLD_NM, CNT, CHK_YN, TOWN, ADDR1_M,ADDR1_S,CO_LIVE_NM,BLD_NM FROM BEFO_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL LIMIT ?, ? " );
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
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 101, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
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
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 31, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 61, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 31, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
				
			}
		}
		//sql->Commit(sql);
		
Finally:
		DelSqLite(sql);

		ON_DRAW();
	}
	
	void Save_Row(long row)
	{
	char sztmp[20];
	char szTOWN[31];
	char szADDR1_M[31];
	char szADDR1_S[31];
	char szCO_LIVE_NM[61];
	char szBLD_NM[31];
	char szCHK[2];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	long idx;
	
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szCHK ,0x00, sizeof(szCHK) );
		Mem_Set((byte*)szTOWN ,0x00, sizeof(szTOWN) );
		Mem_Set((byte*)szADDR1_M ,0x00, sizeof(szADDR1_M) );
		Mem_Set((byte*)szADDR1_S ,0x00, sizeof(szADDR1_S) );
		Mem_Set((byte*)szCO_LIVE_NM ,0x00, sizeof(szCO_LIVE_NM) );
		Mem_Set((byte*)szBLD_NM ,0x00, sizeof(szBLD_NM) );		
		
		Str_Cpy( szTOWN, DlgTbl_GetStr( ID_TBLLIST, row, 3) );
		Str_Cpy( szADDR1_M,   DlgTbl_GetStr( ID_TBLLIST, row, 4) );
		Str_Cpy( szADDR1_S,    DlgTbl_GetStr( ID_TBLLIST, row, 5) );
		Str_Cpy( szCO_LIVE_NM,    DlgTbl_GetStr( ID_TBLLIST, row, 6) );
		Str_Cpy( szBLD_NM,    DlgTbl_GetStr( ID_TBLLIST, row, 7) );
		
		Str_Cpy( sztmp,    DlgTbl_GetStr( ID_TBLLIST, row, 2) );
		//선택된 경우
		if(Str_Cmp( sztmp, CHKON ) == 0)
		{
			szCHK[0] = '1';
		}
		else
		{
			szCHK[0] = '0';
		}		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "UPDATE BEFO_GROUP SET CHK_YN = ? WHERE TOWN= ? AND ADDR1_M=? AND ADDR1_S=? AND CO_LIVE_NM=? AND BLD_NM=? " );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)szCHK        ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szTOWN       ,30	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szADDR1_M    ,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szADDR1_S    ,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szCO_LIVE_NM ,60	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szBLD_NM    	,30	,DECRYPT);

		Str_Cpy( szTOWN,       DlgTbl_GetStr( ID_TBLLIST, row, 3) );
		Str_Cpy( szADDR1_M,    DlgTbl_GetStr( ID_TBLLIST, row, 4) );
		Str_Cpy( szADDR1_S,    DlgTbl_GetStr( ID_TBLLIST, row, 5) );
		Str_Cpy( szCO_LIVE_NM, DlgTbl_GetStr( ID_TBLLIST, row, 6) );
		Str_Cpy( szBLD_NM,     DlgTbl_GetStr( ID_TBLLIST, row, 7) );
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		//sql->Commit(sql);
Finally:
		DelSqLite(sql);
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
	char szTOWN[31];
	char szADDR1_M[31];
	char szADDR1_S[31];
	char szCO_LIVE_NM[61];
	char szBLD_NM[31];
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "UPDATE BEFO_GROUP SET CHK_YN ='1' WHERE TOWN= ? AND ADDR1_M=? AND ADDR1_S=? AND CO_LIVE_NM=? AND BLD_NM=?" );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		for (i=0 ; i<ROW ; i++)
		{
			Mem_Set((byte*)szTOWN ,0x00, sizeof(szTOWN) );
			Mem_Set((byte*)szADDR1_M ,0x00, sizeof(szADDR1_M) );
			Mem_Set((byte*)szADDR1_S ,0x00, sizeof(szADDR1_S) );
			Mem_Set((byte*)szCO_LIVE_NM ,0x00, sizeof(szCO_LIVE_NM) );
			Mem_Set((byte*)szBLD_NM ,0x00, sizeof(szBLD_NM) );
			
			Str_Cpy( szTOWN,       DlgTbl_GetStr( ID_TBLLIST, i, 3) );
			Str_Cpy( szADDR1_M,    DlgTbl_GetStr( ID_TBLLIST, i, 4) );
			Str_Cpy( szADDR1_S,    DlgTbl_GetStr( ID_TBLLIST, i, 5) );
			Str_Cpy( szCO_LIVE_NM, DlgTbl_GetStr( ID_TBLLIST, i, 6) );
			Str_Cpy( szBLD_NM,     DlgTbl_GetStr( ID_TBLLIST, i, 7) );
			
			if( Str_Len(szTOWN) == 0 )
			{
				break;
			}
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szTOWN       ,30	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szADDR1_M    ,10	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szADDR1_S    ,10	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szCO_LIVE_NM ,60	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szBLD_NM    	,30	,DECRYPT);
			
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
	

	void Rev511306(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT count(*) FROM BEFO_GROUP WHERE CHK_YN = '1' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &ret);	
		if( ret <= 0 )
		{
			MessageBoxEx (CONFIRM_OK, "선택된 자료가 없습니다.");
			return;
		}
	
	
		Mem_Set( (byte*) szUrl, 0x00, sizeof( szUrl ) );
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 511306, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR511306; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR511306_IN",  "FR511306" , sndbuf, sztmp );
		
	}
	
	long TR511306(void)
	{
		mCnt511306 = g_Chk_Json(511306);
		if( mCnt511306 >= 0)
		{
			Rev511307();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	
	void Rev511307(void)
	{
	char sztmp[32];
	char szUrl[256];
	char szSql[256];
	char* sndbuf;
	long ret;	
	
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 511307, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR511307; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR511307_IN",  "FR511307" , sndbuf, sztmp );
		
	}
	
	long TR511307(void)
	{
	char szSql[200];
		
		g_Sock_Close();
		
		if(g_Chk_Json(511307) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE BEFO_GROUP SET SEND_YN = 'Y' WHERE CHK_YN = '1' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			if( mCnt511306 > 0 ) 
				MessageBoxEx (CONFIRM_OK, "자료수신을 완료 했습니다.");
			else
				MessageBoxEx (CONFIRM_OK, "자료가 없습니다!");
			
			m_lpage = 0;
			REDRAW();
			
			return 1;
		}
		else
		{
			return -1;
		}
		
	}
	
	
	long Add_Item(handle pj)
	{
	char sztmp[20];
	long ret = -1;	
	handle hdb = NULL;
	handle hstmt = NULL;
	handle js = NULL;
	char sztown[31];
	char szaddr1_m[10];
	char szaddr1_s[10];
	char szco_live_nm[61];
	char szbld_nm[31];
	char szUtown[62];
	char szUaddr1_m[20];
	char szUaddr1_s[20];
	char szUco_live_nm[122];
	char szUbld_nm[62];
	SQLITE sql = NewSqLite();
			
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

		hstmt = sql->CreateStatement(sql, "SELECT TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM FROM BEFO_GROUP WHERE CHK_YN = '1' AND ( SEND_YN <> 'Y' OR SEND_YN IS NULL) ");
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
			Mem_Set( (byte*)sztown,0x00, sizeof(sztown) );
			Mem_Set( (byte*)szaddr1_m,0x00, sizeof(szaddr1_m) );
			Mem_Set( (byte*)szaddr1_s,0x00, sizeof(szaddr1_s) );
			Mem_Set( (byte*)szco_live_nm,0x00, sizeof(szco_live_nm) );
			Mem_Set( (byte*)szbld_nm,0x00, sizeof(szbld_nm) );
			sql->GetValue(sql, 0, 'U', (long*)sztown, 31, DECRYPT);
			sql->GetValue(sql, 1, 'U', (long*)szaddr1_m, 11, DECRYPT);
			sql->GetValue(sql, 2, 'U', (long*)szaddr1_s, 11, DECRYPT);
			sql->GetValue(sql, 3, 'U', (long*)szco_live_nm, 61, DECRYPT);
			sql->GetValue(sql, 4, 'U', (long*)szbld_nm, 31, DECRYPT);
			
			Mem_Set( (byte*)szUtown,0x00, sizeof(szUtown) );
			Mem_Set( (byte*)szUaddr1_m,0x00, sizeof(szUaddr1_m) );
			Mem_Set( (byte*)szUaddr1_s,0x00, sizeof(szUaddr1_s) );
			Mem_Set( (byte*)szUco_live_nm,0x00, sizeof(szUco_live_nm) );
			Mem_Set( (byte*)szUbld_nm,0x00, sizeof(szUbld_nm) );
			SQL_ConvUcStr( szUtown, sztown );
			SQL_ConvUcStr( szUaddr1_m, szaddr1_m );
			SQL_ConvUcStr( szUaddr1_s, szaddr1_s );
			SQL_ConvUcStr( szUco_live_nm, szco_live_nm );
			SQL_ConvUcStr( szUbld_nm, szbld_nm );

			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "town",      szUtown );
			JSON_SetArrayItem(js, 'C', "addr1_m",   szUaddr1_m );
			JSON_SetArrayItem(js, 'C', "addr1_s",   szUaddr1_s );
			JSON_SetArrayItem(js, 'C', "co_live_nm",szUco_live_nm );
			JSON_SetArrayItem(js, 'C', "bld_nm",    szUbld_nm );
			ret =1;
		}
		
		JSON_Attach(pj, "item", js);
		
		//sql->Commit(sql);
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		DelSqLite(sql);
		return ret;
	}
}
