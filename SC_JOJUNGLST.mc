/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_JOJUNGLST
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
		DEF_BUTTON_ID ( BID_ADDR )		//지번 주소
		DEF_BUTTON_ID ( BID_ADDR2 )		//도로명 주소
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//도로명주소 스크롤 호출
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
		DEF_OBJECT_ID ( TXT_PAGE )		//페이지
		DEF_OBJECT_ID ( TXT_ADDR2 )
		DEF_OBJECT_ID ( TXT_ADDR3 )
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    8					// table의 행개수
	#define		COL 	    7					// table의 열개수
	#define		GRID_H		(CHT+27)			// table 행 높이
	#define		GRID_H_P	(CHT+45)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+235  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+130  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"주소",	 	 CWD*17+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"구분",     	 CWD*6,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"필터", 	 	 CWD*8,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"결과",     	 CWD*8,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"기본주소", 	 CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소",  	 CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"점검시행번호", CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};		
	
	#define INIT_MAIN	1
	
	long m_lIdxFlag = 0;		// index 관련 flag
	long m_lSelRow = -1;		// 선택된 row
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_lActIndex = -1;		//액티브된 인덱스
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szAdrss[120];		// 상단 주소 표시
		
	void SetStyle(void);
	void SetData(void);
	long FS_GetSrchTotCnt(void);
	void SetBtnImg(void);
	void Set_Index(void); 	//선택한 대상 인덱스 저장
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
	void OnList(quad lParam);
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	void OnList(quad lParam);

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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "조정기 리스트"),

		DLG_BUTTON(STARTX,     STARTY+165, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+250, STARTY+165, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명"),
		DLG_BUTTON(STARTX+500, STARTY+165, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		DLG_BUTTON(STARTX+750, STARTY+165, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		
		DLG_TEXT(STARTX,  STARTY+65, 1000, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		//DLG_TEXT(STARTX, STARTY+140, 975, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),

		DLG_TEXT(STARTX,       STARTY+833, 400, 66, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500, STARTY+833, 250, 66, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+833, 250, 66, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),
		
		// 리스트		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "조정기 리스트"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY+70, 400, 60, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번주소"),
		DLG_BUTTON(STARTX+400,  STARTY+70, 400, 60, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명주소"),
				
		DLG_TEXT(STARTX,        STARTY-40, 1000, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		
		DLG_TEXT(STARTX,       STARTY+839, 400, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500, STARTY+839, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+839, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),
		
		// 리스트		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-30, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i;
		char szTmp[200];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			g_lMoveFlag = 1;
			Set_Index();			
			
			Card_Move("SC_JOJUNGCHK");
		}
		
		return;
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
				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				SetData();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
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
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR3), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR2), TRUE, 2, EDITSEP_NONE );
	}	

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList(ID);
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;
				SetData();
				if(m_lActIndex >= 0)
				{
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					Str_Cpy(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
					Str_Cat(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), m_szAdrss);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
				}
				break;				
			case BID_ADDR2:
				g_nAddrFlag = 1;
				SetData();
				if(m_lActIndex >= 0)
				{
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					Str_Cpy(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
					Str_Cat(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), m_szAdrss);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
				}
				break;
			case BID_PREVPG:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//SetData();
					return;
				}
				m_lActIndex = 0;
				SetData();
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
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//SetData();
					break;
				}
				m_lActIndex = 0;
				SetData();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "조정기점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
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
				g_lMoveFlag = 0;
				Card_Move("SC_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		char szcmb[20];
		
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			if ( index-1 == m_lActIndex )
			{
				//선택된 파일의 위치 INDEX를 글로벌변수에 저장
				g_nActIndex = m_lpage*ROW + m_lActIndex;
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				g_lMoveFlag = 1;
				Set_Index();
				Card_Move("SC_JOJUNGCHK");
				return;
			}
			else
			{
				m_lActIndex = index - 1;//선택된 INDEX 저장
			
				//처음 선택된 대상의 주소를 상단에 표시
				Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
				Str_Cpy(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
				Str_Cat(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), m_szAdrss);
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
/*
				if( g_nAddrFlag == 0)
				{
					//처음 선택된 대상의 주소를 상단에 표시
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					Str_Cpy(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
					Str_Cat(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), m_szAdrss);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
				}
				else
				{
					//처음 선택된 대상의 주소를 상단에 표시
					Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
				}
*/
			}
		}
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

	
//-----------------------------------------------------------------
	void SetData(void)
	{
		char szSql[500];
		long i, idx;
		long k = ROW+1;	//i랑 겹치지 않는 숫자로 초기화
		long lTotpage;
		char sztmp[201];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(szSql, "SELECT ROWID FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S");
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		lTotpage = FS_GetSrchTotCnt();
		m_lTotpage = lTotpage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
/*
		if(g_lMoveFlag == 1)
		{
			m_lpage = g_nActIndex / ROW;
			m_lSelRow = (g_nActIndex % ROW) +1;
			//DlgTbl_SetActive 	( ID_TBLLIST, g_nActIndex );
			//DlgTbl_SetRowColor	( ID_TBLLIST, m_lSelRow, TABLEACTIVE_COLOR );
			g_lMoveFlag = 0;
		}
*/

		if( m_lIdxFlag == 0 )
		{
			//프로그램 시작 시 불러오는 인덱스
			Get_Index();
		}		
		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotpage);
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		//2016-02-23 Sanghyyn Lee
		//NOGOOD_RESULT -> REGTR_FILTER_FLAG 바꿔야함 ,, REGTR_FILTER_FLAG 어느 테이블????
		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
			hstmt = sql->CreateStatement(sql, "SELECT SINGLE_COLIVE_FLAG, ifnull(Trim(TOWN),'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM,''), ifnull(CO_LIVE_NM,'') ||'-'|| ifnull(BLD_NM,''), REGTR_FILTER_FLAG, CHK_RSLT, ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,''), REGTR_NUM  FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S LIMIT ?, ?");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), FALSE );
			hstmt = sql->CreateStatement(sql, "SELECT SINGLE_COLIVE_FLAG, ifnull(Trim(NEW_ROAD_NM),'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,''), REGTR_FILTER_FLAG, CHK_RSLT, ifnull(COUNTY,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), REGTR_NUM  FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S LIMIT ?, ?");
		}
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
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
					continue;
				}
				
				if( g_nAddrFlag == 0)
				{
					//주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					idx = 0;
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//구분 , SINGLE_COLIVE_FLAG(단독,공동)
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
					if( Str_Cmp( sztmp, "10") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "단독" );
					}
					else if( Str_Cmp( sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "공동" );
					}
					//필터
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					if( Str_Cmp(sztmp, "10") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "1 inch" );
					}
					else if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "2 inch" );
					}
					else if( Str_Cmp(sztmp, "30") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "3 inch" );
					}
					else if( Str_Cmp(sztmp, "40") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "4 inch" );
					}
					//결과
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "적합" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					else if( Str_Cmp(sztmp, "21") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "부적합" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
					}
					else if( Str_Cmp(sztmp, "40") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "제외" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "미검" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					//기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//조정기번호
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
				}
				else
				{
					//주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					idx = 0;
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
					//구분 , SINGLE_COLIVE_FLAG(단독,공동)
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
					if( Str_Cmp( sztmp, "10") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "단독" );
					}
					else if( Str_Cmp( sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 1, "공동" );
					}
					//필터
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
					if( Str_Cmp(sztmp, "10") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "1 inch" );
					}
					else if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "2 inch" );
					}
					else if( Str_Cmp(sztmp, "30") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "3 inch" );
					}
					else if( Str_Cmp(sztmp, "40") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "4 inch" );
					}
					//결과
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "적합" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					else if( Str_Cmp(sztmp, "21") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "부적합" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
					}
					else if( Str_Cmp(sztmp, "40") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "제외" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "미검" );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					//기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//상세주소
					//Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					//sql->GetValue(sql, 6, 'U', (long*)sztmp, 100, DECRYPT);
					//DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//조정기번호
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
				}
			}
		}
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			//처음 선택된 대상의 주소를 상단에 표시
			Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
			Str_Cpy(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
			Str_Cat(m_szAdrss, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), m_szAdrss);
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
/*
			if( g_nAddrFlag == 0)
			{
				//처음 선택된 대상의 주소를 상단에 표시
				Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
			}
			else
			{
				//처음 선택된 대상의 주소를 상단에 표시
				Mem_Set((byte*)m_szAdrss, 0x00, sizeof(m_szAdrss));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
			}
*/
			m_lIdxFlag = 1;
		}
		ON_DRAW();
		return;
	}
	

	/*=======================================================================================
	함수명 : Set_Index
	기  능 : 최종 인덱스 저장한다.
	Param  : 
	Return : TRUE :성공
			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '3' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

	/*=======================================================================================
	함수명 : Get_Index
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Get_Index(void)
	{
		char szSql[201];
		char szbuf[10];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '3' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);		
		m_lpage = g_nActIndex / ROW;
		m_lActIndex = (g_nActIndex % ROW);
	}
	
	//---------------------------------------------------------------------------------------------------------------
	//1차 퀵뷰
	void QuickList(long nBtnID)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		//nAddrType = 0 지번 ,, nAddrType = 1 도로명
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "조정기점검 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||'-'|| ifnull(BLD_NM,''), Case When SINGLE_COLIVE_FLAG = '10' Then '단독' When SINGLE_COLIVE_FLAG = '20' Then '공동' else '' End ||'  / 필터:'|| Case When REGTR_FILTER_FLAG = '10' Then '1 inch' When REGTR_FILTER_FLAG = '20' Then '2 inch' When REGTR_FILTER_FLAG = '30' Then '3 inch' When REGTR_FILTER_FLAG = '40' Then '4 inch' else '' End ||'  / 결과:'|| Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' Else '미검' End FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "조정기점검 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(COUNTY,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||'-'|| ifnull(BLD_NM,''), Case When SINGLE_COLIVE_FLAG = '10' Then '단독' When SINGLE_COLIVE_FLAG = '20' Then '공동' else '' End ||'  / 필터:'|| Case When REGTR_FILTER_FLAG = '10' Then '1 inch' When REGTR_FILTER_FLAG = '20' Then '2 inch' When REGTR_FILTER_FLAG = '30' Then '3 inch' When REGTR_FILTER_FLAG = '40' Then '4 inch' else '' End ||'  / 결과:'|| Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' Else '미검' End FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S");
		}

		sztmp = JSON_toString(js);
		
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
	}
	
	//---------------------------------------------------------------------------------------------------------------
	//2차 퀵뷰
	void Grid_QuickList(long nBtnID)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"주소", "구분", "필터", "결과", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"10","3","4","3","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			if( nBtnID == BID_QUICK_ADDR )
			{
				JSON_SetValue	(hData	, 'C', "query",
	"SELECT \
ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| \
ifnull(CO_LIVE_NM,'') ||'-'|| ifnull(BLD_NM,'') \
,Case When SINGLE_COLIVE_FLAG = '10' Then '단독' When SINGLE_COLIVE_FLAG = '20' Then '공동' else '' End \
,Case When REGTR_FILTER_FLAG = '10' Then '1 inch' When REGTR_FILTER_FLAG = '20' Then '2 inch' \
 When REGTR_FILTER_FLAG = '30' Then '3 inch' When REGTR_FILTER_FLAG = '40' Then '4 inch' else '' End \
,Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' Else '미검' End\
 FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S"
								);
			}
			else
			{
				JSON_SetValue	(hData	, 'C', "query",
	"SELECT \
ifnull(COUNTY,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| \
ifnull(CO_LIVE_NM,'') ||'-'|| ifnull(BLD_NM,'') \
,Case When SINGLE_COLIVE_FLAG = '10' Then '단독' When SINGLE_COLIVE_FLAG = '20' Then '공동' else '' End \
,Case When REGTR_FILTER_FLAG = '10' Then '1 inch' When REGTR_FILTER_FLAG = '20' Then '2 inch' \
 When REGTR_FILTER_FLAG = '30' Then '3 inch' When REGTR_FILTER_FLAG = '40' Then '4 inch' else '' End \
,Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' When CHK_RSLT = '40' Then '제외' Else '미검' End \
 FROM REGTR_DATA ORDER BY COUNTY, TOWN, ADDR1_M, ADDR1_S"
								);
			}
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "조정기점검 리스트");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}
}

