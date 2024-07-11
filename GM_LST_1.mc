/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_LST_1
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SEARCH )	//검색 
		DEF_BUTTON_ID ( BID_NADDR )		//주소 토글 
		DEF_BUTTON_ID ( BID_UP )		//윗 페이지
		DEF_BUTTON_ID ( BID_DOWN )		//아래 페이지
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
		DEF_OBJECT_ID ( TXT_PAGE )		//페이지
		DEF_OBJECT_ID ( TXT_ADDR1 )		//주소1
		DEF_OBJECT_ID ( TXT_ADDR2 )		//주소2
		
		DEF_OBJECT_ID ( CMB_SELECT )
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table의 행개수
	#define		COL 	    7					// table의 열개수
	#define		GRID_H		(CHT+20)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX+20 			// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+210  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"주소",     CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"D",        CWD*4,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"C",        CWD*4,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"지침",     CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"사용량",   CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소",	 CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};	
	
	#define INIT_MAIN			1
	
	long	m_ActIndex = -1; 		//현재 선택 ROW
	long 	m_lpage = 0;			// 현재 페이지
	long 	m_lTotpage = 0;			// 총 페이지
	char 	m_szCnt_page[10];		// 페이지 표시 변수
	char 	m_szAdrss[201];			// 상단 주소 표시

	bool REDRAW(void);    //화면 DLSPLAY
	void SET_INDEX(void); //선택한 대상 인덱스 저장
	void GET_INDEX(void); //선택된 대상 인덱스 읽기
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		
		//화면 공통 메뉴
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "메뉴"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "자판"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "화면"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"공통"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "이전"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "종료"),
		
		DLG_BUTTON(STARTX+550, STARTY, 420, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, " 검 색"),
		DLG_BUTTON(STARTX+330, STARTY, 210, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "새주소"),
		DLG_BUTTON(STARTX+550, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+770, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),		
		
		DLG_TEXT(STARTX+20,  STARTY, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		DLG_TEXT(STARTX+20,  STARTY+110, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),			//기본주소
		DLG_TEXT(STARTX+20,  STARTY+160, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),			//상세주소
		
		DLG_COMBO (STARTX+20, STARTY+55, 350, 200, 70, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),		//검침,미검침,전체 선택 콤보
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		
		//화면 공통 메뉴
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "메뉴"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "자판"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "화면"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"공통"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "이전"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "종료"),
		
		DLG_BUTTON(STARTX+550, STARTY, 420, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, " 검 색"),
		DLG_BUTTON(STARTX+330, STARTY, 210, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "새주소"),
		DLG_BUTTON(STARTX+550, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+770, STARTY+55, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),		
		
		DLG_TEXT(STARTX+20,  STARTY, 330, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		DLG_TEXT(STARTX+20,  STARTY+110, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),		//기본주소
		DLG_TEXT(STARTX+20,  STARTY+160, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		//상세주소
		
		DLG_COMBO (STARTX+20, STARTY+55, 350, 200, 70, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),		//검침,미검침,전체 선택 콤보
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
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
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "전체", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "검침", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "미검침", 0, ICON_NONE);
						SetStyle();
						
						//자료를 INDEX를 받아서 첫페이지를 대상자료가 있는 페이지로
						//보이게 하기 위해서.
						m_lpage = g_lindex;	
						REDRAW();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "전체", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "검침", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "미검침", 0, ICON_NONE);
						SetStyle();
						
						//자료를 INDEX를 받아서 첫페이지를 대상자료가 있는 페이지로
						//보이게 하기 위해서.
						m_lpage = g_lindex;	
						REDRAW();
						break;		
				}
				break;
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}	

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_SEARCH:
				break;
			case BID_NADDR:
				//g_nAddrFlag = 0 -> 구주소    g_nAddrFlag = 1 -> 신주소
				if( g_nAddrFlag == 0)
					g_nAddrFlag = 1;
				else
					g_nAddrFlag = 0;
				REDRAW();
				if(m_ActIndex >= 0)
				{
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 5));
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 6));
				}
				ON_DRAW();
				break;
			case BID_UP:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					g_lindex = m_lpage;
					MessageBoxEx (ERROR_OK, "첫번째 페이지 입니다.");
					REDRAW();
					ON_DRAW();
					return;
				}
				g_lindex = m_lpage;
				REDRAW();
				ON_DRAW();
				break;			
			case BID_DOWN:
				m_lpage += ROW ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					g_lindex = m_lpage;
					MessageBoxEx (ERROR_OK, "마지막 페이지 입니다.");
					REDRAW();
					ON_DRAW();
				}
				g_lindex = m_lpage;
				REDRAW();
				ON_DRAW();
				break;
			case BID_HOME:
				Card_Move("MENU");			
				break;
			case BID_MENU:
				Card_Move("GM_MENU");			
				break;
			case BID_KEYBOARD:
				Card_Move("GM_ENTRY");			
				break;
			case BID_SCREEN:
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
				Card_Move("GM_GRPLST");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}
	
	void	OnKey(long nKey)
	{
		//빽키
		if(nKey == KEY_LSOFT_K)
		{
			OnButton(BID_PREV);
			return;
		}
	}
	
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
				g_lindex = m_lpage+m_ActIndex;
				SET_INDEX();			
				Card_Move("GM_ENTRY");
				return;
			}
			else
			{
				//처음 선택된 대상의 주소를 상단에 표시
				Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
				Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, index-1, 6));

				SPRINT(m_szCnt_page, "%d/%d", m_lpage+index, m_lTotpage, 0);
				m_ActIndex = index - 1;//선택된 INDEX 저장
			}
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
	char sztmp[201];
	long ret = -1;	
	SQLITE sql = NewSqLite();
		
		m_lTotpage = FS_GetSrchTotCnt();
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		sql->Open(sql);
		if( sql->m_hdb == NULL )
		{
			DelSqLite(sql);
			return ret = -1;
		}
		
		if( g_nAddrFlag == 0)
			sql->CreateStatement(sql, "SELECT AREA, BASE_YMD, MTR_WORK_CODE, INDI_SET_VM, INDI_QTY, ifnull(TOWN,' ') ||' '|| ifnull(ADDR1_M,' ') ||' '|| ifnull(ADDR1_S,' '),  ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ')||'-'||ifnull(HOSU,' ') FROM GUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE LIMIT ?, ?");
		else
			sql->CreateStatement(sql, "SELECT AREA, BASE_YMD, MTR_WORK_CODE, INDI_SET_VM, INDI_QTY, ifnull(NEW_ROAD_NM,' ') ||' '|| ifnull(NEW_ADDR_M,' ') ||' '|| ifnull(NEW_ADDR_S,' '), ifnull(CO_LIVE_NM,' ') ||' '|| ifnull(BLD_NM,' ')||'-'||ifnull(HOSU,' ') FROM GUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE LIMIT ?, ?");
			
		if( sql->m_hdb == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			sql->Close(sql);
			return ret;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'X', &m_lpage, 4, DECRYPT);
		i = m_lpage+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		sql->Execute(sql);
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW ; i++)
		{
			if( m_lpage+i+1 > m_lTotpage )//자료가 없을때 화면을 클리어 시킨다.
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					continue;
				}
				//주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				idx = 0;
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//기준일자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//계량기작업코드
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//지침
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//사용량
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//기본주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				//상세주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
			}			
		}
		
		sql->DeleteStatement(sql);
		sql->Commit(sql);
		sql->Close(sql);
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : SET_INDEX
	기  능 : 최종 인덱스 저장한다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void SET_INDEX(void)
	{
		char sztmp[101];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "UPDATE GUMGROUP SET GM_INDEX= '%d' ", g_lindex, 0, 0);		
		g_Sql_DirectExecute(sztmp);
	}
	
	/*=======================================================================================
	함수명 : GET_INDEX
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void GET_INDEX(void)
	{
		char sztmp[101];
		char szbuf[10];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		Str_Cpy(sztmp, "SELECT GM_INDEX FROM GUMGROUP LIMIT 0, ?");	
			
		g_Sql_RetStr(sztmp, 4, szbuf);
		g_lindex = Str_AtoI(szbuf);
		if(g_lindex < 0)
			g_lindex = 0;
		if( g_lindex > 5000)
			g_lindex = 5000;
	}
	
	/*=======================================================================================
	함수명 : FS_GetSrchTotCnt
	기  능 : 검색인덱스파일의 레코드 수를 리턴한다.
	Param  : nPos:검색 인덱스 파일의 순번
 	Return : 레코드수
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;
		
		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}
}

