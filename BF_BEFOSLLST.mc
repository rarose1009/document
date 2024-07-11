/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_BEFOSLLST
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
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
//리스트
		DEF_BUTTON_ID ( BID_ADDR )		//주소
		DEF_BUTTON_ID ( BID_UP )		//이전페이지
		DEF_BUTTON_ID ( BID_DOWN )		//다음페이지
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//도로명주소 스크롤 호출
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//리스트
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//총페이지
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
//리스트
		DEF_OBJECT_ID ( CMB_SELECT )
//리스트
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+30)			// table 행 높이
	#define		GRID_H_P	(CHT+55)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+340  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+170  	    // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"번지-호수-층", CWD*15+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"기물번호",     CWD*16 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"적부",         CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상세주소",     CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"ROWID",        CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1	
	
	long m_lIdxFlag = 0;
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_nbuttonid = 0;		//m_nbuttonid = 0 나머지 검색 sql, m_nbuttonid = 1 기물번호 sql
	long m_nActIndex = -1;
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szAdrss[120];		// 상단 주소 표시
	char m_szSql[2][800];
	char m_szQuickSql[1000];
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	char m_szSqlFlag = 0;		//m_szSqlFlag = 0 - 기본리스트, m_szSqlFlag = 1 - 검색된 리스트
	char m_szCobSel[20];
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Cmb_Filter(void);
	void Cmb_Result(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//선택한 대상 인덱스 저장
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
	void SetComboIdx(void);
	void SetData(void);
	void OnList(quad lParam);
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공급전 안전점검(단독)"),
		
		DLG_BUTTON(STARTX+333, STARTY+65, 333, 60, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		
		DLG_TEXT(STARTX,       STARTY+65, 333, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		DLG_TEXT(STARTX,      STARTY+125, 185, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "대상"), 		//적합
		DLG_TEXT(STARTX+185,  STARTY+125, 150, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+335,  STARTY+125, 185, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "미검"), 	//부적합
		DLG_TEXT(STARTX+520,  STARTY+125, 150, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//
		DLG_TEXT(STARTX+670,  STARTY+125, 185, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "부적합"),	//미실시
		DLG_TEXT(STARTX+855,  STARTY+125, 145, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 		//					
		DLG_TEXT(STARTX,      STARTY+185, 1000, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//

		DLG_BUTTON(STARTX,     STARTY+275, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "▲"),
		DLG_BUTTON(STARTX+250, STARTY+275, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "▼"),
		DLG_BUTTON(STARTX+500, STARTY+275, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		DLG_BUTTON(STARTX+750, STARTY+275, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		
		DLG_COMBO (STARTX+666, STARTY+65, 334, 250, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "공급전 안전점검(단독)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+200, STARTY-40, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+400, STARTY-40, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+550, STARTY-40, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),				
		
		DLG_TEXT(STARTX,      STARTY-40, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지
		DLG_TEXT(STARTX,      STARTY+30, 185, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "대상"), 		//적합
		DLG_TEXT(STARTX+185,  STARTY+30, 150, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 		//
		DLG_TEXT(STARTX+335,  STARTY+30, 185, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "미검"), 	//부적합
		DLG_TEXT(STARTX+520,  STARTY+30, 150, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 		//
		DLG_TEXT(STARTX+670,  STARTY+30, 185, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "부적합"),	//미실시
		DLG_TEXT(STARTX+855,  STARTY+30, 145, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 		//					
		
		DLG_TEXT(STARTX,     STARTY+100, 1000, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""), 			//
		
		DLG_COMBO (STARTX+700,  STARTY-40, 300, 250, 120, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 10),	//
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			g_lDataflag = 0;	//점검화면 SaveInput() 적용/미적용 flag
			Set_Index();
			Mem_Set( (byte*)g_szINS_JOIN, 0x00, sizeof(g_szINS_JOIN) );
			Mem_Set( (byte*)g_szINS_EXPLA, 0x00, sizeof(g_szINS_EXPLA) );
			
			Card_Move("BF_BEFOCONFIRM");
		}
		
		return;
	}

	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "전체", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "미검", 0, ICON_NONE);

				g_Sql_SetCombo("SELECT TOWN FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' GROUP BY TOWN ORDER BY TOWN", CMB_SELECT+2);
				g_nAddrFlag = 0;

				SetBtnImg();
				SetStyle();
				if( g_nWorkFlag == 501 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "미검");
					Str_Cpy(m_szCobSel, "미검");							
				}
				else if( g_nWorkFlag == 503 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), g_szTown);
					Str_Cpy(m_szCobSel, g_szTown);							
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "전체");
					Str_Cpy(m_szCobSel, "전체");							
				}
				Cmb_Filter();
				REDRAW();
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		if( theDevInfo.m_nType > FAMILY_PDA )
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
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList(ID);
				break;
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
				}
				REDRAW();
				if(m_nActIndex >= 0)
				{					
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
				}
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//REDRAW();
					return;
				}
				m_nActIndex = 0;
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
				m_nActIndex = 0;
				REDRAW();
				break;		
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					if( g_nWorkFlag == 500 )
					{
						Set_Index();
					}
					else
					{
						SetComboIdx();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "공급전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					if( g_nWorkFlag == 500 )
					{
						Set_Index();
					}
					else
					{
						SetComboIdx();
					}
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
				if( g_nWorkFlag == 500 )
				{
					Set_Index();
				}
				else
				{
					SetComboIdx();
				}
				Card_Move("BF_BEFOMENU");
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

		if( INIT_MAIN == m_bFirst )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				if ( index-1 == m_nActIndex )
				{
					g_lDataflag = 0;	//점검화면 SaveInput() 적용/미적용 flag
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					
					Set_Index();
					//SetData();
					Mem_Set( (byte*)g_szINS_JOIN, 0x00, sizeof(g_szINS_JOIN) );
					Mem_Set( (byte*)g_szINS_EXPLA, 0x00, sizeof(g_szINS_EXPLA) );
					Card_Move("BF_BEFOCONFIRM");
					//Card_Move("BF_BEFOCONFIRM_list");
					return;
				}
				else
				{
					//처음 선택된 대상의 주소를 상단에 표시
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, index-1, 3));
					Str_Cpy(g_szROWID , DlgTbl_GetStr( ID_TBLLIST, index-1, 4));

					m_nActIndex = index - 1;//선택된 INDEX 저장
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//콤보박스 선택으로 리스트 목록 필터링.(검침,미검침,전체대상)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "미검" ) == 0 )
					g_nWorkFlag = 501;
				else if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
					g_nWorkFlag = 500;
				else if( Str_Cmp(m_szCobSel, szcmb) == 0 )
				{
					g_nWorkFlag = 503;
					Mem_Set((byte*)g_szTown, 0x00, sizeof(g_szTown));
					Str_Cpy(g_szTown, szcmb);
				}
				//페이지를 초기화시킨다.
				m_lpage = 0;
				m_nActIndex = 0;
				Cmb_Filter();
				REDRAW();
			}
		}
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		

		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SELECT), "전체");
	}

//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		char sztmp[301];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		m_lTotpage = FS_GetSrchTotCnt();
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0 )
		{
			//프로그램 시작 시 불러오는 인덱스
			Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		else
			hstmt = sql->CreateStatement(sql, m_szSql[1]);			
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
				//테이블 주소
				idx = 0;

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100 +1, DECRYPT);

				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//기물번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  20 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );		
				//결과(적부) , Decode(CHK_RSLT,'20','적합','21','부적합','미검')
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2 +1, DECRYPT);
				if( Str_Cmp(sztmp, "20") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "적합" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
				}
				else if( Str_Cmp(sztmp, "21") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "부적합" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "미검" );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
				}
				//상단 주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//ROWID
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4 + 1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			}
		}
		
		//sql->Commit(sql);
		
		if( m_nActIndex == -1 )
		{
			m_nActIndex =0;
		}

		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			Str_Cpy(g_szROWID , DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			
			m_lIdxFlag = 1;
			
			Cmb_Result();
		}
		
Finally:
		DelSqLite(sql);
		
		ON_DRAW();
		return;
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
	
	//-----------------------------------------------------------------------------------------------
	//콤보박스를 이용한 전체,점검,미점검 목록 필터m_szCobSel
	//-----------------------------------------------------------------------------------------------
	void Cmb_Filter(void)
	{
		char szRow[600];

		Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
		if( Str_Cmp(m_szCobSel, "미검") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND ( SEND_FLAG = 'N' OR SEND_FLAG IS NULL )  ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S");
			g_nWorkFlag = 501;
		}
		else if( Str_Cmp(m_szCobSel, "전체") == 0 )
		{
			Str_Cpy(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S");
			g_nWorkFlag = 500;
		}
		else
		{
			SPRINT(szRow, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND TOWN = '%s' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S", m_szCobSel, 0, 0 );
			g_nWorkFlag = 503;
		}

		g_Sql_SaveSeq( szRow, SREACH_FILE);

		if( Str_Cmp(m_szCobSel, "미검") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL ) ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(Trim(NEW_ADDR_M),'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL )  ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?");
		}
		else if( Str_Cmp(m_szCobSel, "전체") == 0 )
		{
			Str_Cpy( m_szSql[0], "SELECT ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10'  ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?");
			Str_Cpy( m_szSql[1], "SELECT ifnull(Trim(NEW_ADDR_M),'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10'  ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?");
		}
		else
		{
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND TOWN = '%s' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?", g_szTown, 0, 0 );
			//Str_Cpy( m_szSql[0], "SELECT ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),'') FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?");
			Str_Cpy( m_szSql[0], szRow);
			
			Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
			SPRINT(szRow, "SELECT ifnull(Trim(NEW_ADDR_M),'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND TOWN = '%s' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?", g_szTown, 0, 0 );
			//Str_Cpy( m_szSql[1], "SELECT ifnull(Trim(NEW_ADDR_M),'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), MTR_ID_NUM, CHK_RSLT, ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10'  ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ? , ?");
			Str_Cpy( m_szSql[1], szRow);
		}
	}
	
	//-----------------------------------------------------------------------------------------------
	//콤보박스를 이용한 전체,점검,미점검 목록 필터, 상단 대상 확인부분
	//-----------------------------------------------------------------------------------------------
	void Cmb_Result(void)
	{
	char sztmp[20];
	char szSql[300];
		
		if( Str_Cmp(m_szCobSel, "전체") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND CHK_RSLT = '21' ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), sztmp); 
		}
		else if( Str_Cmp(m_szCobSel, "미검") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND CHK_RSLT = '21' ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), sztmp); 
		}
		else
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND TOWN = '%s' ", g_szTown, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL) AND TOWN = '%s' ", g_szTown, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), sztmp); 
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) from BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' AND CHK_RSLT = '21' AND TOWN = '%s' ", g_szTown, 0, 0 );
			g_Sql_RetStr( szSql, 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), sztmp); 
		}
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
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '6' ", g_nActIndex, 0, 0);
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
		SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '6' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);		
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = (g_nActIndex % ROW);
	}
	
	
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetComboIdx(void)
	{
		long i, idx;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);

		lRow = Str_AtoI(g_szROWID);
		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '6' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);

		return;
	}
	
	
	void SetData(void)
	{
		long i;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stBf, 0x00, sizeof(stBf));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT ROWID, CREATE_YMD, MTR_NUM, BEFO_OBJ_YN, BLD_NUM, INST_PLACE_NUM, SINGLE_COLIVE_FLAG \
, CENTER_CD, ZONE_MANAGE_NUM, PDA_NUM, ZIP_NO1, ZIP_NO2, COUNTY, TOWN, VILLAGE, ADDR1_M \
, ADDR1_S, LOT_NUM_SECOND_ADDR, CO_LIVE_NM, HOUSE_CNT, BLD_NM, DETA_FLOOR, COMPX_FLAG_NM \
, CUST_NUM, CUST_TYPE_CD, CUST_NM, FIRM_NM, BIZ_REGI_NUM, SOC_NUM, REPRE_NM, CP_DDD \
, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, USE_CONT_NUM \
, PROD_NM, CONT_YMD, CNL_YMD, MTR_ID_NUM, MTR_MODEL_CD, MTR_GRD, CONT_STS_CD, INS_JOIN_YN \
, INS_EXPLA_YN, COMPENS_OBJ_YN, CHK_YMD, CHK_TIME_FROM, CHK_TIME_TO, CHK_EMPID, CHK_RSLT \
, SIGN, INDI_DTM, MTR_INDI, INDI_VA, INDI_VC, SEND_FLAG, CRT_EMPID, CRT_IP, LAW_TOWN \
, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S \
FROM BEFO_DATA WHERE ROWID = ?  "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'X', &g_lindex , 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stBf.ROWID              ,3 + 1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CREATE_YMD         ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.MTR_NUM            ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.BEFO_OBJ_YN        ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.BLD_NUM            ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.INST_PLACE_NUM     ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.SINGLE_COLIVE_FLAG ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CENTER_CD          ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.ZONE_MANAGE_NUM    ,5  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.PDA_NUM            ,5  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.ZIP_NO1            ,3  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.ZIP_NO2            ,3  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.COUNTY             ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.TOWN               ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.VILLAGE            ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.ADDR1_M            ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.ADDR1_S            ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.LOT_NUM_SECOND_ADDR,100+1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CO_LIVE_NM         ,60 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.HOUSE_CNT          ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.BLD_NM             ,100+1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.DETA_FLOOR         ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.COMPX_FLAG_NM      ,60 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CUST_NUM           ,10 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CUST_TYPE_CD       ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CUST_NM            ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.FIRM_NM            ,50 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.BIZ_REGI_NUM       ,10 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.SOC_NUM            ,13 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.REPRE_NM           ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CP_DDD             ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CP_EXN             ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CP_NUM             ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.OWNHOUSE_TEL_DDD   ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.OWNHOUSE_TEL_EXN   ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.OWNHOUSE_TEL_NUM   ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.USE_CONT_NUM       ,10 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.PROD_NM            ,50 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CONT_YMD           ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CNL_YMD            ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.MTR_ID_NUM         ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.MTR_MODEL_CD       ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.MTR_GRD            ,62 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CONT_STS_CD        ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.INS_JOIN_YN        ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.INS_EXPLA_YN       ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.COMPENS_OBJ_YN     ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CHK_YMD            ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CHK_TIME_FROM      ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CHK_TIME_TO        ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CHK_EMPID          ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CHK_RSLT           ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.SIGN               ,300+1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.INDI_DTM           ,14 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.MTR_INDI           ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.INDI_VA            ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.INDI_VC            ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.SEND_FLAG          ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CRT_EMPID          ,9  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.CRT_IP             ,32 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.LAW_TOWN           ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.NEW_ROAD_NM        ,100+1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.NEW_ADDR_M         ,10 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBf.NEW_ADDR_S         ,10 +1 , DECRYPT );
		}
		//sql->Commit(sql);
		
Finally:

		DelSqLite(sql);

		Str_Cpy(g_szCREATE_YMD, stBf.CREATE_YMD);
		Str_Cpy(g_szMTR_NUM, stBf.MTR_NUM);
		
		//점검시작시간
		g_Str_TimeType( stBf.CHK_TIME_FROM , Time_GetTime());
		
		return;
	}
	
	
//---------------------------------------------------------------------------------------------------------------
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
			JSON_SetValue ( js, 'C', "title", "공급전점검(단독) 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(COUNTY, '') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), ifnull(CUST_NM, '') ||' / 기물번호:'|| MTR_ID_NUM ||'\n적부:'|| Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' Else '미검' End FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10'  ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "공급전점검(단독) 리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "SELECT ifnull(COUNTY, '') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),''), ifnull(CUST_NM, '') ||' / 기물번호:'|| MTR_ID_NUM ||'\n적부:'|| Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' Else '미검' End FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10'  ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S");
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
	void Grid_QuickList(long nBtnID)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		char szTmp[128];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"번지-호수-층", "기물번호", "적부", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","2","1","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( nBtnID == BID_QUICK_ADDR )
		{
			Str_Cpy(m_szQuickSql, "SELECT \
 ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(Trim(LOT_NUM_SECOND_ADDR),'') \
 ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),'') \
 , MTR_ID_NUM , Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' Else '미검' End \
 FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ");
		}
		else
		{
			Str_Cpy(m_szQuickSql, "SELECT \
 ifnull(Trim(NEW_ADDR_M),'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| \
 ifnull(Trim(LOT_NUM_SECOND_ADDR),'') ||' '|| ifnull(Trim(BLD_NM),'') ||' '|| ifnull(Trim(HOUSE_CNT),'') \
 , MTR_ID_NUM , Case When CHK_RSLT = '20' Then '적합' When CHK_RSLT = '21' Then '부적합' Else '미검' End \
 FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ");
		}
		
		if( Str_Cmp(m_szCobSel, "전체" ) == 0 )
		{
			Str_Cat(m_szQuickSql, " ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S");
		}
		else if( Str_Cmp(m_szCobSel, "미검" ) == 0 )
		{
			Str_Cat(m_szQuickSql, "AND (SEND_FLAG = 'N' OR SEND_FLAG IS NULL ) ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S");
		}
		else //if( Str_Cmp(m_szCobSel, "단독주택명" ) == 0 )
		{
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szTmp, " AND TOWN = '%s' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S",g_szTown,0,0);
			Str_Cat(m_szQuickSql, szTmp);
		}
	
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
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szQuickSql);
			
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
			
			JSON_SetValue	(h		, 'C', "title"			, "공급전 안전점검(단독)");
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
