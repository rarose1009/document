/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_GRPLST
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_AUCTION )	//경매활동
		DEF_BUTTON_ID ( BID_STOP )		//중지활동
		DEF_BUTTON_ID ( BID_NORMAL )	//정상
		DEF_BUTTON_ID ( BID_HOME_USE )		//가정용
		DEF_BUTTON_ID ( BID_NON_HOME_USE )	//비가정용
		DEF_BUTTON_ID ( BID_TOGGLE )	//금액,체납월수
		DEF_BUTTON_ID ( BID_SEARCH )	//조회
		DEF_BUTTON_ID ( BID_RCV )		//개별수신
		DEF_BUTTON_ID ( BID_UP )		//윗 페이지
		DEF_BUTTON_ID ( BID_DOWN )		//아래 페이지
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//스크롤 호출
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
		DEF_OBJECT_ID ( TXT_PAGE ) 		//페이지
		DEF_OBJECT_ID ( EDT_DATA1 )
		
		DEF_OBJECT_ID ( ID_TBLLIST ) 	// 테이블 리스트
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+17)			// table 행 높이
	#define		GRID_H_P	(CHT+25)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 				// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+205  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+120  	    // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"읍/면/동", 	CWD*20+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"번지/단지", 	CWD*11 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"대상", 		CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ZIP_NO1", 	CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ZIP_NO2", 	CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	long	m_lIdxFlag = 0;
	long	m_lSubIndex = -1;
	long	m_lSubpage = 0;
	long	m_lActiveIndex = -1;
	long	m_ActIndex  = -1; 		// 현재 선택 ROW
	long 	m_lpage = 0;			// 현재 페이지
	long 	m_lTotpage = 0;			// 총 페이지
	long	m_bFirst;
	long	m_lToggleFlag = 0;		// 0 : 금액 , 1 : 체납월수
	long	m_nWorkFlag = 0;
	char 	m_szCnt_page[20];		// 페이지 표시 변수
	char	m_szAddr1_M[30];
	char	m_szZip_No1[5];
	char	m_szZip_No2[5];
	char	m_szQuickSql[500];
	
	long	FS_GetSrchTotCnt(void);
	bool	REDRAW(void);      //화면 DLSPLAY
	void	Get_Index(void); //데이터인덱스로 그룹 인덱스 찾기
	void	Set_Index(void); //그룹 인덱스 저장하기	
	void	SET_DTLINDEX(void);
	void	SetStyle(void);
	long	SQLITE_IDXBYGETGRPSEQ(char* szSql, long idx);
	void	SetBtnImg(void);

	void OnList(quad lParam);
	void Grid_QuickList(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납활동"),
			
		DLG_BUTTON(STARTX,	   STARTY+65 , 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AUCTION, "경매"),
		DLG_BUTTON(STARTX+150, STARTY+65 , 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "중지"),
		DLG_BUTTON(STARTX+300, STARTY+65 , 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NORMAL, "정상"),
		DLG_BUTTON(STARTX+450, STARTY+65 , 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HOME_USE, "가정"),
		DLG_BUTTON(STARTX+600, STARTY+65 , 160, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NON_HOME_USE, "비가정"),
		DLG_BUTTON(STARTX,	   STARTY+135, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TOGGLE, "금액"),
		DLG_BUTTON(STARTX+760, STARTY+135, 240, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, "조회"),
		DLG_BUTTON(STARTX,	   STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "▲"),
		DLG_BUTTON(STARTX+250, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "▼"),	
		DLG_BUTTON(STARTX+500, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "스크롤"),
		DLG_BUTTON(STARTX+750, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "개별수신"),
		
		DLG_TEXT(  STARTX+760, STARTY+65 , 240, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_EDIT(  STARTX+300, STARTY+135, 460, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1,30, ""),
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "체납활동"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,	    STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AUCTION, "경매활동"),
		DLG_BUTTON(STARTX+250,  STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "중지활동"),
		DLG_BUTTON(STARTX+500,  STARTY-40, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NORMAL, "정상"),
		DLG_BUTTON(STARTX,	    STARTY+40, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TOGGLE, "금액"),
		DLG_BUTTON(STARTX+700,  STARTY+40, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, "조회"),
		DLG_BUTTON(STARTX,	   STARTY+820, 250, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "▲"),
		DLG_BUTTON(STARTX+250, STARTY+820, 250, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "▼"),	
		DLG_BUTTON(STARTX+600, STARTY+820, 400, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "개별수신"),
			
		DLG_TEXT(STARTX+750,     STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), //현재페이지/총페이지
		DLG_EDIT(STARTX+300,	 STARTY+40, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1,30, ""),
		
		// 리스트
		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
		long i, k = 0, nRet = 0;
		char szTmp[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM C6202_NOPAY_OBJ GROUP BY ZIP_NO1, ZIP_NO2, ADDR1_M ORDER BY  TOWN, CAST(ADDR1_M AS INTEGER)", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				nRet = -1;
				goto Finally;
			}
		
			hstmt = sql->CreateStatement(sql, "SELECT ZIP_NO1, ZIP_NO2, ADDR1_M FROM C6202_NOPAY_OBJ WHERE ROWID = ? GROUP BY ZIP_NO1, ZIP_NO2, ADDR1_M ORDER BY  TOWN, CAST(ADDR1_M AS INTEGER)");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				nRet = -1;
				goto Finally;
			}

			sql->Bind(sql, 0, 'X', &g_lindex, 4, DECRYPT);

			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				nRet = -1;
				goto Finally;
			}

			if(sql->Next(sql) == TRUE )
			{	
				k = 0;
				Mem_Set( (byte*)m_szZip_No1, 0x00, sizeof(m_szZip_No1) );
				Mem_Set( (byte*)m_szZip_No2, 0x00, sizeof(m_szZip_No2) );
				Mem_Set( (byte*)m_szAddr1_M, 0x00, sizeof(m_szAddr1_M) );
				sql->GetValue(sql, k++, 'U', (long*)m_szZip_No1, 50, DECRYPT);
				sql->GetValue(sql, k++, 'U', (long*)m_szZip_No2, 50, DECRYPT);
				sql->GetValue(sql, k++, 'U', (long*)m_szAddr1_M, 50, DECRYPT);
				
				nRet = 1;
			}
			else
			{
				PRINT("::SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
				nRet = -1;
				goto Finally;
			}

Finally:
			DelSqLite(sql);

			if( nRet < 0 )
			{
				return;
			}

			g_nWorkFlag = 800;
			g_nGrpFlag = 0;
			
			Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
			Mem_Set( (byte*)g_szCntSql, 0x00, sizeof(g_szCntSql) );
			SPRINT(g_szSqlWhere, "WHERE ZIP_NO1 = '%s' AND ZIP_NO2 = '%s' AND ADDR1_M = '%s' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?", m_szZip_No1, m_szZip_No2, m_szAddr1_M);
			SPRINT(g_szCntSql, "SELECT ROWID FROM C6202_NOPAY_OBJ WHERE ZIP_NO1 = '%s' AND ZIP_NO2 = '%s' AND ADDR1_M = '%s' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU", m_szZip_No1, m_szZip_No2, m_szAddr1_M);
			//g_Sql_SaveSeq( g_szCntSql, SREACH_FILE);

			Set_Index();

			if( (m_lSubIndex != m_ActIndex) || (m_lSubpage != m_lpage) || (g_nWorkFlag != m_nWorkFlag) )
			{
				SET_DTLINDEX();
			}
			
			Card_Move("C6202_DETALLST");
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

				g_nGrpFlag = 0;
				g_szNpMonthFlag = 0;
				m_nWorkFlag = g_nWorkFlag;
				g_nHomeLstFlag = 0;
				
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		//상단공통메뉴
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_PAGE), TRUE, 2, EDITSEP_NONE );
	}

	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL에 ACTIVE시에 CTRLINDEX를 저장
		//키보드 BUTTONCTRL이 ACTIVE시에도 EDITCTRL에 커서를 두기위해서 INDEX를 저장
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				m_lActiveIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+310) && X < DMS_X(STARTX+675) && Y > DMS_Y(STARTY+145) && Y < DMS_Y(STARTY+215) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
				
				ON_DRAW();
			}
		}
	}

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		char szTmp[100];
		long lVal = 0;
		
		//숫자만 입력 가능
		if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
		{
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
	//PRINT("111 >> szTmp : %s",szTmp,0,0);
			Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
	//PRINT("222 >> szTmp : %s",szTmp,0,0);
			Str_Chg(szTmp, STRCHG_INS_COMMA);
	//PRINT("333 >> szTmp : %s",szTmp,0,0);
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szTmp);
		}

		ON_DRAW();
		return;
	}

	//------------------------------------------------------------------------
	void	OnKey(long nKey)
	{
		long i;
		char szTmp[100];
		
		if( nKey == 5 && Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
		{
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
	//PRINT("111 >> szTmp : %s",szTmp,0,0);
			Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
	//PRINT("222 >> szTmp : %s",szTmp,0,0);
			Str_Chg(szTmp, STRCHG_INS_COMMA);
	//PRINT("333 >> szTmp : %s",szTmp,0,0);
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szTmp);
		}
	}

//=======================================================================================
	void	OnSelect(long Index)
	{
		long index = -1;
		char szSql[700];
		
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			if ( index-1 == m_ActIndex )
			{
				g_nWorkFlag = 800;
				g_nGrpFlag = 0;
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
				Mem_Set( (byte*)g_szCntSql, 0x00, sizeof(g_szCntSql) );
				SPRINT(g_szSqlWhere, "WHERE ZIP_NO1 = '%s' AND ZIP_NO2 = '%s' AND ADDR1_M = '%s' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?", m_szZip_No1, m_szZip_No2, m_szAddr1_M);
				SPRINT(g_szCntSql, "SELECT ROWID FROM C6202_NOPAY_OBJ WHERE ZIP_NO1 = '%s' AND ZIP_NO2 = '%s' AND ADDR1_M = '%s' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU", m_szZip_No1, m_szZip_No2, m_szAddr1_M);
				
				g_nActIndex = m_lpage*ROW + m_ActIndex;
				
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				if( (m_lSubIndex != m_ActIndex) || (m_lSubpage != m_lpage) || (g_nWorkFlag != m_nWorkFlag) )
				{
					SET_DTLINDEX();
				}

				Card_Move("C6202_DETALLST");
				return;
			}
			else
			{
				m_ActIndex = index - 1;//선택된 INDEX 저장
				
				Mem_Set( (byte*)m_szAddr1_M, 0x00, sizeof(m_szAddr1_M) );
				Mem_Set( (byte*)m_szZip_No1, 0x00, sizeof(m_szZip_No1) );
				Mem_Set( (byte*)m_szZip_No2, 0x00, sizeof(m_szZip_No2) );
				Str_Cpy(m_szAddr1_M, DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 1));
				Str_Cpy(m_szZip_No1, DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 3));
				Str_Cpy(m_szZip_No2, DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 4));
			}
		}
	}


	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szTmp[256];
		long lVal;

		switch(ID)
		{
			case BID_QUICK_ADDR:
				Grid_QuickList();
				break;
				
			case BID_AUCTION:
				g_nWorkFlag = 801;
				
				Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
				Mem_Set( (byte*)g_szCntSql, 0x00, sizeof(g_szCntSql) );
				
				Str_Cpy(g_szSqlWhere, "WHERE NONPAY_OBJ_FLAG != '10' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?");
				SPRINT(g_szCntSql, "SELECT ROWID FROM C6202_NOPAY_OBJ WHERE NONPAY_OBJ_FLAG != '10' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU",0,0,0);
				
				if( (g_nWorkFlag != m_nWorkFlag) )
				{
					SET_DTLINDEX();
				}
				
				Card_Move("C6202_DETALLST");
				
				break;
				
			case BID_STOP:
				g_nWorkFlag = 802;
				
				Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
				Mem_Set( (byte*)g_szCntSql, 0x00, sizeof(g_szCntSql) );
				
				Str_Cpy(g_szSqlWhere, "WHERE STOP_FLAG = 'Y' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?");
				SPRINT(g_szCntSql, "SELECT ROWID FROM C6202_NOPAY_OBJ WHERE STOP_FLAG = 'Y' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU",0,0,0);
				
				if( (g_nWorkFlag != m_nWorkFlag) )
				{
					SET_DTLINDEX();
				}

				Card_Move("C6202_DETALLST");
				
				break;
			case BID_NORMAL:
				g_nWorkFlag = 803;
				
				Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
				Mem_Set( (byte*)g_szCntSql, 0x00, sizeof(g_szCntSql) );
				
				Str_Cpy(g_szSqlWhere, "WHERE CONT_STS_CD = '10' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?");
				SPRINT(g_szCntSql, "SELECT ROWID FROM C6202_NOPAY_OBJ WHERE CONT_STS_CD = '10' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU",0,0,0);
				
				if( (g_nWorkFlag != m_nWorkFlag) )
				{
					SET_DTLINDEX();
				}

				Card_Move("C6202_DETALLST");
				
				break;
				
			case BID_HOME_USE:
				g_nHomeLstFlag = 1;
				SET_DTLINDEX();
				Card_Move("C6202_HOMELST");
				
				break;
			case BID_NON_HOME_USE:
				g_nHomeLstFlag = 2;
				SET_DTLINDEX();
				Card_Move("C6202_HOMELST");
				
				break;
				
			case BID_TOGGLE:
				if( 0 == m_lToggleFlag )
				{
					m_lToggleFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TOGGLE), "체납월수");
				}
				else
				{
					m_lToggleFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TOGGLE), "금액");
				}
				
				if( m_lTotpage > 0 )
				{
					DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
					DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
				}
				
				break;
				
			case BID_SEARCH:
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				
				Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				
				lVal = Str_AtoI(szTmp);
				
				//금액
				if( 0 == m_lToggleFlag )
				{
					g_nWorkFlag = 804;
					
					Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
					Mem_Set( (byte*)g_szCntSql, 0x00, sizeof(g_szCntSql) );
					
					SPRINT(g_szSqlWhere, "WHERE UNPAY_AMT_SUM >= '%d' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?", lVal, 0, 0);
					SPRINT(g_szCntSql, "SELECT ROWID FROM C6202_NOPAY_OBJ WHERE UNPAY_AMT_SUM >= '%d' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU", lVal, 0, 0);

					if( (g_nWorkFlag != m_nWorkFlag) )
					{
						SET_DTLINDEX();
					}

					g_Sql_SaveSeq( g_szCntSql, SREACH_FILE);
				}
				//체납월수
				else
				{
					g_nWorkFlag = 805;
					
					Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
					Mem_Set( (byte*)g_szCntSql, 0x00, sizeof(g_szCntSql) );
					
					SPRINT(g_szSqlWhere, "WHERE NONPAY_MM_CNT >= '%d' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU LIMIT ?, ?", lVal, 0, 0);
					SPRINT(g_szCntSql, "SELECT ROWID FROM C6202_NOPAY_OBJ WHERE NONPAY_MM_CNT >= '%d' ORDER BY TOWN, ADDR1_M, ADDR1_S, CO_LIVE_NM, BLD_NM, HOSU", lVal, 0, 0);

					if( (g_nWorkFlag != m_nWorkFlag) )
					{
						SET_DTLINDEX();
					}

					g_Sql_SaveSeq( g_szCntSql, SREACH_FILE);
				}
				
				Card_Move("C6202_DETALLST");
				
				break;
				
			case BID_RCV:
				Card_Move("C6202_DETALRCV");
				
				break;
				
			case BID_UP:
				m_lpage--;
				
				if( m_lpage < 0)
				{
					m_lpage = 0;

					if(m_lTotpage > 0)
					{
						if( m_ActIndex == -1 )
						{
							m_ActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
					}
					
					break;
				}
				
				m_ActIndex = 0;
				REDRAW();
				
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
					
					if(m_lTotpage > 0)
					{
						if( m_ActIndex == -1 )
						{
							m_ActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);
					}
					
					break;
				}
				
				m_ActIndex = 0;
				REDRAW();
				
				break;
				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "체납 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6202_MENU");
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
				Card_Move("C6202_MENU");
				break;
				
			case GID_VMEXIT:
				g_Exit();
				break;
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
		long index;
		long lstartidx = 0;
		long lTotPage = 0;
		char sztmp[200];
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//그룹 리스트의 총 갯수
		g_Sql_SaveSeq( "SELECT COUNT(*) FROM C6202_NOPAY_OBJ GROUP BY ZIP_NO1, ZIP_NO2, ADDR1_M", GROUP_FILE);
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
		
		if( m_lIdxFlag == 0 )
		{
			Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d\n%d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT TOWN, ADDR1_M, COUNT(ADDR1_M), ZIP_NO1, ZIP_NO2 FROM C6202_NOPAY_OBJ GROUP BY ZIP_NO1, ZIP_NO2, ADDR1_M ORDER BY  TOWN, CAST(ADDR1_M AS INTEGER)  LIMIT ?, ?");

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
		
		for (i=0; i < ROW; i++)
		{
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
		}
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0; i < ROW; i++)
		{
			if(sql->Next(sql) == FALSE)
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				break;
			}

			idx = 0;
			//읍/면/동
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
			//번지/단지
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			//대상
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
			//ZIP_NO1
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			//ZIP_NO2
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
			DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
		}
		
Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lTotpage > 0)
		{
			if( m_ActIndex < 0 )
			{
				m_ActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_ActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_ActIndex+1, TABLEACTIVE_COLOR);

			Mem_Set( (byte*)m_szAddr1_M, 0x00, sizeof(m_szAddr1_M) );
			Mem_Set( (byte*)m_szZip_No1, 0x00, sizeof(m_szZip_No1) );
			Mem_Set( (byte*)m_szZip_No2, 0x00, sizeof(m_szZip_No2) );
			Str_Cpy(m_szAddr1_M, DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 1));
			Str_Cpy(m_szZip_No1, DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 3));
			Str_Cpy(m_szZip_No2, DlgTbl_GetStr( ID_TBLLIST, m_ActIndex, 4));
			
			m_lIdxFlag = 1;
		}

		ON_DRAW();
		return ret;
	}

//========================================================================================
//상세리스트 인덱스 초기화
	void SET_DTLINDEX(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 = '0' WHERE GUBUN = '9' ", 0, 0, 0);		
		g_Sql_DirectExecute(szSql);
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
		char sztmp[101];
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, " UPDATE RCV_LOG SET PARAM8= '%d'  WHERE GUBUN = '9' ", g_nActIndex, 0, 0);		

		g_Sql_DirectExecute(sztmp);
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
		char szSql[100];
		long lParam8 = 0;
		long lidx = 0;
	
		g_Sql_RetInt("SELECT PARAM8 FROM RCV_LOG WHERE GUBUN = '9'", &lParam8);
		
		g_nActIndex = lParam8;		
		m_lpage = g_nActIndex / ROW;
		m_ActIndex = (g_nActIndex % ROW);
		
		m_lSubpage = m_lpage;
	    m_lSubIndex = m_ActIndex;
	}
	
	
//=======================================================================================
//=======================================================================================
	long SQLITE_IDXBYGETGRPSEQ(char* szSql, long idx)
	{
		long ret = -1;
		long i = 0;
		char szBuf[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		sql->Begin(sql);

		i = 0;
		sql->Bind(sql, i++, 'X', &idx, 4, DECRYPT);
		sql->Bind(sql, i++, 'X', &idx, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		if(sql->Next(sql) == FALSE)
		{
			PRINT("::SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}
		else
		{
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'X', &ret, 4, DECRYPT );
		}

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		return ret;
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

		size = FFS_GetSize( GROUP_FILE );

		size = size/SRCH_FS_SIZE;

		return size;
	}

	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(void)
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
		
		char col_name[5][32] = {"읍/면/동", "번지/단지", "대상", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","2","1","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		Str_Cpy(m_szQuickSql, "SELECT TOWN, ADDR1_M, COUNT(ADDR1_M) \
FROM C6202_NOPAY_OBJ GROUP BY ZIP_NO1, ZIP_NO2, ADDR1_M ORDER BY TOWN, CAST(ADDR1_M AS INTEGER)");
	
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

			start_position = m_lpage*ROW + m_ActIndex;
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
			
			JSON_SetValue	(h		, 'C', "title"			, "체납활동");
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

