/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : GM_RELST
	Card Desc : 재검, 조정 에러 리스트
	Card Hist :
----------------------------------------------------------------------------------*/
card GM_RELST
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
//	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
	
		// 화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )			// 홈
		DEF_BUTTON_ID ( BID_MENU )			// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )		// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )		// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )		// 공통업무
		DEF_BUTTON_ID ( BID_PREV )			// 이전
		DEF_BUTTON_ID ( BID_EXIT )			// 종료
		
		// 검침 리스트
		DEF_BUTTON_ID ( BID_NADDR )			// 주소 토글
		DEF_BUTTON_ID ( BID_UP )			// 다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			// 이전페이지
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	// 지번주소 스크롤 호출
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	// 도로명주소 스크롤 호출
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
	
		// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )	// 타이틀 아이콘
		DEF_OBJECT_ID ( TXT_TITLE )		// 타이틀 텍스트
		
		// 검침 리스트
		DEF_OBJECT_ID ( TXT_PAGE )		// 페이지
		DEF_OBJECT_ID ( TXT_ADDR1 )		// 주소
		DEF_OBJECT_ID ( TXT_ADDR2 )		// 주소
		DEF_OBJECT_ID ( TXT_DATA1 )		// 완료
		DEF_OBJECT_ID ( TXT_DATA2 )		// 완료 대상 수
		
		// 테이블
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트

	END_OBJECT_ID()

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(상세리스트)
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6						// table의 행개수
	#define		COL 	    11						// table의 열개수
	#define		GRID_H		(CHT+44)				// table 행 높이
	#define		GRID_CLR	TRANSPARENT   			// table 클리어 color
	#define		GRID_X		STARTX 			    	// table 시작x좌표
	#define		MAXCHAR		201 			    	// table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+240  	    	// table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table마지막 row의 Y값
	char		m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"T",        		CWD*4,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소",     		CWD*17, 	EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"D",        		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"C",        		CWD*3,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"지침",     		CWD*8,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"사용량",   		CWD*8,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소",	 		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소", 		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ROWID",    		CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"INST_PLACE_NUM",  CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"COUNS_HIST",  	CWD*0,  	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	 1
	
	handle m_hGrid = NULL;
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index 관련 flag
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_nActIndex = -1;		// 선택된 row index
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szAdrss[120];		// 상단 주소 표시
	char m_szSql[2][800];
	char m_bFirst;				// INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	char m_szCobSel[20];		// 콤보박스
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	bool REDRAW(void);
	void SetStyle(void);
	
	long FS_GetSrchTotCnt(void);
	void Set_Index(void);
	void Get_Index(void);
	
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	void OnList(quad lParam);
	
	void Rcv25012(void);
	long TR25012(void);
	
	SysButCtrl SysButRes_MAIN[] =
	{
		SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
		SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
	 	SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0 ),
		SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	
	//---------------------------------------------------------------------------------------
	// 메인 다이얼로그(리스트)
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
				
		// 타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "재검 및 조정에러"),
		
		DLG_TEXT  (STARTX+550, STARTY+65,  200, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "완료"),
		DLG_TEXT  (STARTX+750, STARTY+65,  249, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_BUTTON(STARTX,     STARTY+65,  275, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		DLG_BUTTON(STARTX+275, STARTY+65,  275, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "도로명\n스크롤"),
		
		// 기본주소
		DLG_TEXT  (STARTX,     STARTY+130, 1000, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		// 하단
		DLG_TEXT ( STARTX,     STARTY+829, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+400, STARTY+829, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+600, STARTY+829, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_BUTTON(STARTX+800, STARTY+829, 199, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "지 번"),
	};	

	//---------------------------------------------------------------------------------------
	//	main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
		
	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : OnInit
	기  능 : 최초 시작
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit(char bFirst)
	{
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
			
				g_nAddrFlag = 0;
				g_nTelFlag = 0;
				g_nNameFlag = 0;
				g_lDataflag = 0;
				
				SetBtnImg();
				SetStyle();
				REDRAW();
				
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnSelect
	기  능 : 리스트 선택
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index = -1;
		char sztmp[20];
		char szAddr[200];
		
		if( INIT_MAIN == m_bFirst )
		{
			// 현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				if( index-1 == m_nActIndex )
				{
					// 선택된 파일의 위치 INDEX를 글로벌변수에 저장
					// g_nWorkFlag :  101 -> 검색 , 102 -> 검침&송신 완료 + 검침완료 & 송신 미완료 , 103 -> 미검침
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					Set_Index();
					
					if( g_nWorkFlag == 101 ) // 선택검침으로 이동하면 
					{
						g_nWorkFlag = 100;
					}
					
					Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
					
					Card_Move("GM_REENTRY");
					
					return;
				}
				else
				{
					m_nActIndex = index - 1; // 선택된 INDEX 저장
				
					// 처음 선택된 대상의 주소를 상단에 표시
					Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr));
					Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					Str_Cat(szAddr, "  ");
					Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), szAddr);
				
					Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
					Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
					Mem_Set( (byte*)g_szINST_PLACE_NUM, 0x00, sizeof(g_szINST_PLACE_NUM));
					Str_Cpy( g_szINST_PLACE_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));	
				}
			}
		}
	}
	
	/*=======================================================================================
	함수명 : OnList
	기  능 : 리스트 선택
	Param  : 
	Return : 
	========================================================================================*/
	void OnList( quad lParam )
	{
		long i;
		
		i = lParam;
		
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM REGUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
			
			Card_Move("GM_REENTRY");
		}
		
		return;
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{
			/*****************************************/
			/* 공통 버튼                             */
			/*****************************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "검침 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("GM_MENU");
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
				Card_Move("GM_MENU");
				break;
				
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/*****************************************/
			/* 일반 버튼                             */
			/*****************************************/
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				Grid_QuickList(ID);
				break;
			
			case BID_NADDR:
				// g_nAddrFlag = 0 -> 구주소, g_nAddrFlag = 1 -> 신주소
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NADDR), "도로명");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NADDR), "지번");
				}

				REDRAW();
				
				break;
				
			case BID_UP:
			
				m_lpage--;
				
				if( m_lpage < 0 )
				{
					m_lpage = 0;
					
					if( m_lTotpage > 0 )
					{
						if( m_nActIndex < 0 )
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					
					break;
				}
				
				m_nActIndex = 0;
				
				REDRAW();
				
				break;
						
			case BID_DOWN:
			
				m_lpage++ ;
				
				if( m_lpage > m_lTotpage - 1 )
				{
					m_lpage = m_lTotpage - 1;
					
					if( m_lpage < 0 )
					{
						m_lpage = 0;
					}
					
					if( m_lTotpage > 0 )
					{
						if( m_nActIndex < 0 )
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					
					break;
				}
				
				m_nActIndex = 0;
				
				REDRAW();
				
				break;
				
		}
	}
	
	//---------------------------------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : 버튼 이미지
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
		
		// 타이틀
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		
		// 상단공통메뉴
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

	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR1), TRUE, 2, EDITSEP_NONE );
		}
	}

	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 새로고침
	Param  : 
	Return : 
	========================================================================================*/
	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char szTitle[200];
		char sztmp[300];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/*****************************************/
		/* 타이틀                                */
		/*****************************************/
		Mem_Set((byte *)szTitle, 0x00, sizeof(szTitle));
		
		Str_Cpy(szTitle, "[");
		
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10'", 10, sztmp );
		
		Str_Cat(szTitle, sztmp);
		
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));		
		g_Sql_RetStr("SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10'", 5, sztmp );
		
		Str_Cat(szTitle, "/");
		Str_Cat(szTitle, sztmp);
		Str_Cat(szTitle, "] 재검 및 조정에러");
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_TITLE), szTitle);
		
		/*****************************************/
		/* 리스트                                */
		/*****************************************/
		g_Sql_SaveSeq( "SELECT ROWID FROM REGUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", SREACH_FILE );

		lTotPage = FS_GetSrchTotCnt();
		
		m_lTotpage = lTotPage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0)
		{
			// 프로그램 시작 시 불러오는 인덱스
			Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, "SELECT GUM_TYPE, Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST FROM REGUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}
		else
		{
			hstmt = sql->CreateStatement(sql, "SELECT GUM_TYPE, Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY, ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,''), ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ROWID, INST_PLACE_NUM, COUNS_HIST FROM REGUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT ?, ?");
		}

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for( i=0 ; i<ROW ; i++ )
		{
			// 자료가 없을때 화면을 클리어 시킨다.
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
			}
			else
			{
				if( sql->Next(sql) == FALSE )
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				
				if( Str_Cmp(sztmp, "0") > 0 )
				{
					// 타입
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
					
					if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "재" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "조" );
					}
					
					// 주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					
					// 기준일자
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					// 계량기작업코드
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					
					// 지침
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					
					// 사용량
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					
					// 기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					
					// 상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					
					// ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 11, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					
					// INST_PLACE_NUM
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 12, 'U', (long*)sztmp, 20, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					// COUNS_HIST
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
				}
				else
				{
					// 타입
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
					
					if( Str_Cmp(sztmp, "20") == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "재" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 0, "조" );
					}
					
					// 주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					
					// 기준일자
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					// 계량기작업코드
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
					
					// 지침
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					
					// 사용량
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					
					// 기본주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					
					// 상세주소
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 10, 'U', (long*)sztmp, 100, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					
					// ROWID
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 11, 'U', (long*)sztmp, 5, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					
					// INST_PLACE_NUM
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 12, 'U', (long*)sztmp, 20, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					
					// COUNS_HIST
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 10, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
				}
			}
		}

	Finally:

		DelSqLite(sql);

		if( m_lTotpage > 0 )
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			// 처음 선택된 대상의 주소를 상단에 표시
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			Str_Cat(sztmp, "  ");
			Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR1), sztmp);
	
			Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
			Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
			Mem_Set( (byte*)g_szINST_PLACE_NUM, 0x00, sizeof(g_szINST_PLACE_NUM));
			Str_Cpy( g_szINST_PLACE_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10));

			m_lIdxFlag = 1;
			
			// 전체
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Sql_RetStr( "SELECT COUNT(*) from REGUMDATA WHERE (SEND_YN = 'S' OR SEND_YN = 'Y') ", 4 , sztmp );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "0");
		}
		
		ON_DRAW();	
			
		return TRUE;
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
	
	/*=======================================================================================
	함수명 : Set_Index
	기  능 : 최종 인덱스 저장한다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '1' ", g_lindex, 0, 0);		
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
		
		// g_nGrpFlag = 0 > 그룹리스트->상세리스트 이동 //// g_nGrpFlag = 1 > 점검등록->상세리스트 이동
		if( g_nGrpFlag == 0 )
		{
			// g_nActIndex = Str_AtoI(szbuf);
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = (g_nActIndex % ROW);
			
			g_nGrpFlag = 1;
		}
		else
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
			SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '1' ", 0, 0, 0);		
			g_Sql_RetStr(szSql, 4, szbuf);
		
			g_lindex = Str_AtoI(szbuf);
			g_nActIndex = g_Get_FsIndex(g_lindex, SREACH_FILE);
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = ((g_nActIndex) % ROW);
		}
	}
	
	/*=======================================================================================
	함수명 : Grid_QuickList
	기  능 : 퀵 뷰
	Param  : 
	Return : 
	========================================================================================*/
	void Grid_QuickList( long nBtnID )
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
		
		char col_name[5][32] = {"T", "주소", "C", "지침", "사용량"};
		char col_weight[5][10] = {"2", "5","2","3","3"};
		char col_align[5][10] = {"center", "center", "center","right", "right"};
	
		h = JSON_Create( JSON_Object );
		if( h )
		{
			hData = JSON_Create( JSON_Object );
			
			if( hData == NULL )
			{
				goto Finally;
			}

			JSON_SetValue( hData, 'C', "list_type", "GridListView" );
			// 재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다 [true]를 해 주어야 한다.
			// 만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시 개별 판단하여 제어를 해야 한다.
			JSON_SetValue( hData, 'C', "list_position_save", "true" );
			
			col_count = 5;
			JSON_SetValue( hData, 'X', "col_count", &col_count );

			col_height = 250;
			JSON_SetValue( hData, 'X', "col_height", &col_height );

			start_position = m_lpage * ROW + m_nActIndex;
			JSON_SetValue( hData, 'X', "start_position", &start_position );
			
			JSON_SetValue( hData, 'C', "bind_type", "query" );
			JSON_SetValue( hData, 'C', "dbname", "APP_DBF/SCGGAS.db" );
			
			if( nBtnID == BID_QUICK_ADDR )
			{
				JSON_SetValue( hData, 'C', "query", "SELECT CASE WHEN GUM_TYPE = '20' THEN '재' ELSE '에' END \
				                                          , CASE WHEN LENGTH(TRIM(CO_LIVE_NM)) + LENGTH(TRIM(BLD_NM)) > 0 THEN IFNULL(CO_LIVE_NM,'') ||' '|| IFNULL(BLD_NM,'') ||'-'|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') \
				                                                 ELSE IFNULL(ADDR1_M,'') ||'-'|| IFNULL(ADDR1_S,'') ||' '|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') END \
														  , IFNULL(MTR_WORK_CODE, '') \
														  , IFNULL(INDI_SET_VC, '') \
														  , IFNULL(INDI_QTY, '') \
													   FROM REGUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
							 );
			}
			else
			{
				JSON_SetValue( hData, 'C', "query", "SELECT CASE WHEN GUM_TYPE = '20' THEN '재' ELSE '에' END \
				                                          , CASE WHEN LENGTH(TRIM(CO_LIVE_NM)) + LENGTH(TRIM(BLD_NM)) > 0 THEN IFNULL(CO_LIVE_NM,'') ||' '|| IFNULL(BLD_NM,'') ||'-'|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') \
				                                                 ELSE IFNULL(NEW_ADDR_M,'') ||'-'|| IFNULL(NEW_ADDR_S,'') ||' '|| IFNULL(HOSU,'') ||' '|| IFNULL(DETA_FLOOR,'') END \
														  , IFNULL(MTR_WORK_CODE, '') \
														  , IFNULL(INDI_SET_VC, '') \
														  , IFNULL(INDI_QTY, '') \
													   FROM REGUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE"
							 );
			}
			
			hHead = JSON_Create( JSON_Array );
			
			if( hHead == NULL )
			{
				goto Finally;
			}		
	
			for ( i = 0; i < col_count; i++ )
			{
				JSON_AddArrayItem( hHead );
				JSON_SetArrayItem( hHead, 'C', "col_head", col_name[i] );
				JSON_SetArrayItem( hHead, 'C', "col_weight", col_weight[i] );
				JSON_SetArrayItem( hHead, 'C', "col_align", col_align[i] );
			}
			
			JSON_Attach( hData, "head", hHead );
			
			JSON_SetValue( h, 'C', "title", "재검 및 조정에러" );
			JSON_SetValue( h, 'C', "method", "ListViewActivity" );
			JSON_Attach( h, "data", hData );
		
			System_Call( "Native_System_Call", JSON_toString(h) );
		}
		
	Finally:
	
		if( h )
		{
			JSON_Finalize( h );
		}	
	
		if( hData )
		{
			JSON_Finalize( hData );
		}
			
		if( hHead )
		{
			JSON_Finalize( hHead );
		}	
	}
	
	/*=======================================================================================
	함수명 : g_GM_Rcv25012
	기  능 : FR25012
	Param  : 
	Return : 
	========================================================================================*/	
	void Rcv25012(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char* sndbuf;
		char szReqym[20];
		char szDeadlineflag[20];
		long ret = 0;
		
		Mem_Set( (byte*)szReqym, 0x00, sizeof(szReqym) );
		g_Sql_RetStr( "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1'", 10, szReqym );
		
		Mem_Set( (byte*)szDeadlineflag, 0x00, sizeof(szDeadlineflag) );
		g_Sql_RetStr( "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1'", 5, szDeadlineflag );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25012, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",          szReqym );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",   szDeadlineflag );
		
		g_GM_Mtr_Add_Item(g_pjcomm);
		g_GM_Use_Cont_Num_Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25012;
		ret = HTTP_DownloadData( szUrl, "FR25012_IN",  "FR25012" , sndbuf, sztmp );
		
		return;		
	}
	
	/*=======================================================================================
	함수명 : g_GM_TR25012
	기  능 : FR25012 CALLBACK
	Param  : 
	Return : 
	========================================================================================*/	
	long TR25012(void)
	{
		long lRet = -1;
		
		g_Sock_Close();
		
		if(g_Chk_Json(25012) >= 0)
		{
			lRet = g_GM_SetFR25012();
			
			MessageBoxEx (CONFIRM_OK, "검침 데이터를 반영 완료했습니다.");
			REDRAW();
			return lRet;
		}
		else
		{
			return lRet;
		}
	}
}



