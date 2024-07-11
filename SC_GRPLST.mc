/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
//검침 그룹리스트 되어있음. 안전점검 그룹리스트 관련 코딩 안함.
card SC_GRPLST
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
		DEF_BUTTON_ID ( BID_NADDR )	//새주소 
		DEF_BUTTON_ID ( BID_UP )	//윗 페이지
		DEF_BUTTON_ID ( BID_DOWN )	//아래 페이지
	//화면 상단 공통 메뉴 모음
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
		DEF_OBJECT_ID ( TXT_PAGE )		 //페이지

		DEF_OBJECT_ID ( ID_TBLLIST ) // 테이블 리스트
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+20)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX+20 			// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+210  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"동명", CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"번지", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"대상", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"점검", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"미검", CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}

	};	
	
	#define INIT_MAIN	1
	
	long	m_ActIndex  = -1; 		// 현재 선택 ROW
	long 	m_lpage = 0;			// 현재 페이지
	long 	m_lTotpage = 0;			// 총 페이지
	char 	m_szCnt_page[10];		// 페이지 표시 변수
	long 	m_lindex[ROW];			// 그룹 시작 인덱스 
	
	bool	REDRAW(void);      //화면 DLSPLAY
	void	GET_HDINDEX(void); //데이터인덱스로 그룹 인덱스 찾기
	void	SET_HDINDEX(void); //그룹 인덱스 저장하기	
	void	SetStyle(void);
	long	SQLITE_IDXBYGETGRPSEQ(char* szSql, long idx);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_TITLE, "안 전 점 검 - 그 룹 리 스 트"),
		
		//화면 공통 메뉴
		DLG_BUTTON(STARTX,      5, 145, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "메뉴"),
		DLG_BUTTON(STARTX+290,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "자판"),
		DLG_BUTTON(STARTX+430,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "화면"),
		DLG_BUTTON(STARTX+570,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"공통"),
		DLG_BUTTON(STARTX+710,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "이전"),
		DLG_BUTTON(STARTX+850,  5, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "종료"),
		
		DLG_TEXT(STARTX+20, STARTY+70, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szTableBuf), //현재페이지/총페이지
			
		DLG_BUTTON(STARTX+20,  STARTY+140, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, " 새주소"),
		DLG_BUTTON(STARTX+545, STARTY+140, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+765, STARTY+140, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
/*
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),

		DLG_TEXT(STARTX+20, STARTY+25, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), //현재페이지/총페이지
			
		DLG_BUTTON(STARTX+20,  STARTY+120, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, " 새주소"),
		DLG_BUTTON(STARTX+545, STARTY+120, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+765, STARTY+120, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
*/
		//화면캡쳐
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),

		DLG_TEXT(STARTX+20, 30, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), //현재페이지/총페이지
			
		DLG_BUTTON(STARTX+20,  STARTY+20, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, " 새주소"),
		DLG_BUTTON(STARTX+545, STARTY+20, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+765, STARTY+20, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		// 리스트
		DLG_TABLE(GRID_X, STARTY+130, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
						SetStyle();
						//자료 INDEX를 받아서 첫페이지를 대상자료가 있는 페이지로
						//보이게 하기 위해서.
						//그룹리스트 화면의 전 화면이 리스트화면과 메뉴화면 중 어느 것인지 확인하기 위한 인덱스 확인.
						if(g_lindex == -1)
							MessageBoxEx (CONFIRM_OK, "Family_PDA : 전에 본 그룹인덱스");
//							GET_HDINDEX();//이전에 본 그룹인덱스 
						else
						{
//							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT SEQ, (IDX+CNT) AS TOT FROM  GUMGROUP WHERE IDX <= ? AND TOT > ?",  g_lindex);
							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT CNT FROM  NORMAL_GROUP",  g_lindex);
							if( m_lpage % ROW >0 )
							{
								m_lpage = m_lpage / 10;
							}
							else
							{
								m_lpage = (m_lpage / 10) - 1;
							}
							if(m_lpage < 0)
							{
								m_lpage = 0;
							}
						}
						REDRAW();
						ON_DRAW();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
						SetStyle();
						//자료 INDEX를 받아서 첫페이지를 대상자료가 있는 페이지로
						//보이게 하기 위해서.
						//그룹리스트 화면의 전 화면이 리스트화면과 메뉴화면 중 어느 것인지 확인하기 위한 인덱스 확인.
						if(g_lindex == -1)
							MessageBoxEx (CONFIRM_OK, "default : 전에 본 그룹인덱스");
//							GET_HDINDEX();//이전에 본 그룹인덱스 
						else
						{
//							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT SEQ, (IDX+CNT) AS TOT FROM  NORMAL_GROUP WHERE IDX <= ? AND TOT > ?",  g_lindex);
							m_lpage = SQLITE_IDXBYGETGRPSEQ( "SELECT CNT  FROM  NORMAL_GROUP WHERE CNT > ?",  g_lindex);
							if( m_lpage % ROW >0 )
							{
								m_lpage = m_lpage / 10;
							}
							else
							{
								m_lpage = (m_lpage / 10) - 1;
							}
							if(m_lpage < 0)
							{
								m_lpage = 0;
							}
						}
						REDRAW();
						ON_DRAW();
						break;
				}
				break;
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_NADDR:
				//g_nAddrFlag = 0 -> 구주소    g_nAddrFlag = 1 -> 신주소
				if( g_nAddrFlag == 0)
					g_nAddrFlag = 1;
				else
					g_nAddrFlag = 0;
				REDRAW();
				ON_DRAW();
				break;
			case BID_UP:
				m_lpage--;
				if( m_lpage < 0)
				{
					m_lpage = 0;
					MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					REDRAW();
					ON_DRAW();
					return;
				}
				REDRAW();
				ON_DRAW();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage - 1 )
				{
					m_lpage = m_lTotpage-1;
					if( m_lpage < 0)
					{
						m_lpage = 0;
					}
					MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					REDRAW();
					ON_DRAW();
					return;
				}
				REDRAW();
				ON_DRAW();
				break;
			case BID_HOME:
				Card_Move("MENU");
				break;
			case BID_MENU:
				Card_Move("SC_MENU");
				break;
			case BID_KEYBOARD:
				Card_Move("SC_LST");
				break;
			case BID_SCREEN:
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
				Card_Move("SC_MENU");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}
	
//=======================================================================================
//=======================================================================================
	void	OnSelect(long Index)
	{
		long index = -1;
		
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			if ( index-1 == m_ActIndex )
			{
				//선택된 파일의 위치 INDEX를 글로벌변수에 저장
				g_lindex = m_lindex[m_ActIndex];
//				SET_HDINDEX();
				Card_Move("SC_LST");
				return;
			}
			m_ActIndex = index - 1;//선택된 INDEX 저장
		}
	}
	
	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 자료를 디스플레이한다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	bool REDRAW(void)
	{
		long i, idx;
		long j = 0;
		char sztmp[200];
		bool ret = FALSE;
		long lstartidx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//그룹 리스트의 총 갯수
		g_Sql_RetInt("SELECT COUNT(*) FROM NORMAL_GROUP", &m_lTotpage);
		
		if( m_lTotpage % 10 > 0 )
		{
			m_lTotpage = (m_lTotpage / 10) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / 10;
		}
		
		if( m_lpage > m_lTotpage )
		{
			m_lpage = m_lTotpage;
		}
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

    //나중에 확인 후 새주소 추가 예정
//		if( g_nAddrFlag == 0)
    	hstmt = sql->CreateStatement(sql, "SELECT TOWN, ADDR1_M, CNT FROM NORMAL_GROUP ORDER BY ROWID LIMIT ?, ?");
//		else
//			sql->CreateStatement(sql, "SELECT NEW_ROAD_NM, NEW_ADDR_M, CNT, GMCNT, CNT-GMCNT, IDX FROM NORMAL_GROUP ORDER BY SEQ LIMIT ?, ?");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
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
			ret = FALSE;
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0; i < ROW; i++)
		{
			if(sql->Next(sql) == FALSE)
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
//				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
//				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				continue;
			}
			//동명
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
			//번지
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			//대상수
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			//안전점검 대상수
/*			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'C', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			//미점검 갯수
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'C', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
*/			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			//인덱스 값
			ret = Str_AtoI(sztmp);
			m_lindex[i] = ret;
			
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : SET_HDINDEX
	기  능 : 최종 인덱스 저장한다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void SET_HDINDEX(void)
	{
		char sztmp[101];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "UPDATE GUMGROUP SET GMGP_INDEX= '%d' ", m_lpage+m_ActIndex, 0, 0);		
		g_Sql_DirectExecute(sztmp);
	}
	
	/*=======================================================================================
	함수명 : GET_HDINDEX
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void GET_HDINDEX(void)
	{
		char sztmp[101];
		char szbuf[10];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		Str_Cpy(sztmp, "SELECT GMGP_INDEX FROM GUMGROUP LIMIT 0, ? ");	
			
		g_Sql_RetStr(sztmp, 4, szbuf);
		m_lpage = Str_AtoI(szbuf);
		if(m_lpage < 0)
			m_lpage = 0;
		if( m_lpage > 5000)
			m_lpage = 5000;
	}
	
//=======================================================================================
//=======================================================================================
	long SQLITE_IDXBYGETGRPSEQ(char* szSql, long idx)
	{
		long ret = -1, i = 0;
		char szBuf[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		sql->Begin(sql);
		
		i = 0;
		sql->Bind(sql, i++, 'X', &idx, 4, DECRYPT);
		sql->Bind(sql, i++, 'X', &idx, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == FALSE)
		{
			PRINT("::SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)&ret, 8, DECRYPT );
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
}
