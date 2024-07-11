/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_RECEIPT
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
//검침 리스트
		DEF_BUTTON_ID ( BID_ADDR )			//지번 주소
		DEF_BUTTON_ID ( BID_NADDR )			//도로명 주소
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
//검침 리스트
		DEF_OBJECT_ID ( TXT_PAGE )			//페이지
		DEF_OBJECT_ID ( TXT_DATA1 )			
		DEF_OBJECT_ID ( TXT_DATA2 )			
		DEF_OBJECT_ID ( TXT_DATA3 )			
		DEF_OBJECT_ID ( TXT_DATA4 )			
		DEF_OBJECT_ID ( TXT_DATA5 )			
		DEF_OBJECT_ID ( TXT_DATA6 )			
		DEF_OBJECT_ID ( TXT_DATA7 )			

		DEF_OBJECT_ID ( ID_TBLLIST )		// 테이블 리스트
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6					// table의 행개수
	#define		COL 	    6					// table의 열개수
	#define		GRID_H		(CHT+32)			// table 행 높이
	#define		GRID_H_P	(CHT+48)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 	 			// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+255  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+180  	    //table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"구분",     	 					CWD*5,     EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"고객명",        	 				CWD*9+23,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"요금수납",     					CWD*15,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"일회성",     	 					CWD*10,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"USE_CONT_NUM", 					CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CUST_NUM",						CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
		//{"주소", 							CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		
	//	{"SUM(ACCOUNT)+SUM(ONCE_ACCOUNT)",  CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	//	{"SUM(ACCOUNT)", 					CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	//	{"SUM(ONCE_ACCOUNT)", 				CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_nActIndex = -1;		//선택된 row index
	long m_bFirst;		
	long m_lAddrFlag = 0;		
	char m_Title[30];
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szCobSel[20];

	void REDRAW(void);
	void AddrDraw(void);
	void SetStyle(void);
	void SetBtnImg(void);
	long FS_GetSrchTotCnt(void);
	
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
	
	// 메인 다이얼로그(리스트)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "수납내역"),
	
		DLG_BUTTON(STARTX,     STARTY+130, 250,125, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+500, STARTY+830, 250, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+830, 250, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		DLG_TEXT(STARTX,        STARTY+65, 350, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "사용계약번호"),
		DLG_TEXT(STARTX+350,    STARTY+65, 650, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+250,   STARTY+130, 750,125, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,       STARTY+760, 125, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "합계"),
		DLG_TEXT(STARTX+125,   STARTY+760, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+375,   STARTY+760, 375, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+750,   STARTY+760, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TEXT(STARTX,	   STARTY+830, 400, 69, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "수납내역"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY+30, 250,150, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+500, STARTY+830, 250, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+830, 250, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		DLG_TEXT(STARTX,	    STARTY-40, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "사용계약번호"),
		DLG_TEXT(STARTX+350,    STARTY-40, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+250,    STARTY+30, 750,150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,	   STARTY+760, 125, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "합계"),
		DLG_TEXT(STARTX+125,   STARTY+760, 248, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+373,   STARTY+760, 375, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+750,   STARTY+760, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TEXT(STARTX,	   STARTY+830, 373, 69, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		
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

//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		char szMsg[100];
		char szcmb[20];
		char sztmp[200];
		
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
					return;
				}
				else
				{
					m_nActIndex = index - 1;//선택된 INDEX 저장
				
					//처음 선택된 대상의 주소를 상단에 표시
					Str_Cpy(stReceipt.USE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)  , stReceipt.USE_CONT_NUM);
					
					Str_Cpy( stReceipt.CUST_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
					
					AddrDraw();
				}
			}
		}
	}
	
//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA3), TRUE, 2, EDITSEP_NONE );
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_ADDR:
				if( m_lAddrFlag == 0 )
				{
					m_lAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주소");
				}
				else
				{
					m_lAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
				}
				AddrDraw();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0)
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
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					if(m_lTotpage > 0)
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
				Card_Move("C6202_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}	

//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx, j;
		long k = ROW+1;
		long lProCnt = 0 , lNopayCnt = 0;
		long lTotPage;
		long lAccount = 0, lOnceAccount = 0, lTotAccount = 0;
		char sztmp[256];
		char szSumAcc[50];
		char szSumOnce[50];
		char szSumTot[50];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		/*
		g_Sql_RetInt( "SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y'\
UNION \
SELECT COUNT(*) from C6202_NOPAY_OBJ WHERE  ACCEPT_AMT > 0 ", &lTotPage );
*/
		g_Sql_RetInt("SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y'", &lProCnt);
		g_Sql_RetInt("SELECT COUNT(*) from C6202_NOPAY_OBJ WHERE  ACCEPT_AMT > 0", &lNopayCnt);

		lTotPage = lProCnt+lNopayCnt;
		
		m_lTotpage = lTotPage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PDA_DUTY_FLAG,CUST_NM,ACCOUNT,ONCE_ACCOUNT ,USE_CONT_NUM,CUST_NUM FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y' \
UNION \
SELECT '체납' AS  PDA_DUTY_FLAG, CUST_NM,ACCEPT_AMT AS  ACCOUNT, '' AS ONCE_ACCOUNT ,USE_CONT_NUM ,CUST_NUM FROM C6202_NOPAY_OBJ WHERE  ACCEPT_AMT > 0 LIMIT ?, ? ");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
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
				//DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				//DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				//DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
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
					//DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					//DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					//DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					continue;
				}
				
				j = 0;
				//구분
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, j++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//고객명
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, j++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//요금수납
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, j++, 'U', (long*)sztmp, 30, DECRYPT);
				if( Str_Len(sztmp) > 0 )
				{
					lAccount += Str_AtoI(sztmp);
				}
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//일회성
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, j++, 'U', (long*)sztmp, 30, DECRYPT);
				if( Str_Len(sztmp) > 0 )
				{
					lOnceAccount += Str_AtoI(sztmp);
				}
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//USE_CONT_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, j++, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//CUST_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, j++, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
			}
		}
		//총합계
		lTotAccount = lAccount+lOnceAccount;
		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			Mem_Set((byte*)&stReceipt, 0x00, sizeof(stReceipt));

			Str_Cpy(stReceipt.USE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2)  , stReceipt.USE_CONT_NUM);
			
			Str_Cpy( stReceipt.CUST_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			
			AddrDraw();


			//토탈 합계
			Str_ItoA(lTotAccount, stReceipt.TOT_ACCOUNT, 10);
			if( Str_Len(stReceipt.TOT_ACCOUNT) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)  , "0");
			}
			else
			{
				Str_Chg(stReceipt.TOT_ACCOUNT, STRCHG_INS_COMMA);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)  , stReceipt.TOT_ACCOUNT);
			}

			//요금수납합계
			Str_ItoA(lAccount, stReceipt.ACCOUNT, 10);
			if( Str_Len(stReceipt.ACCOUNT) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)  , "0");
			}
			else
			{
				Str_Chg(stReceipt.ACCOUNT, STRCHG_INS_COMMA);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)  , stReceipt.ACCOUNT);
			}
			
			//일회성 합계
			Str_ItoA(lOnceAccount, stReceipt.ONCE_ACCOUNT, 10);
			if( Str_Len(stReceipt.ONCE_ACCOUNT) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)  , "0");
			}
			else
			{
				Str_Chg(stReceipt.ONCE_ACCOUNT, STRCHG_INS_COMMA);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)  , stReceipt.ONCE_ACCOUNT);
			}

			

		}
/*		
		Mem_Set( (byte*)szSumAcc, 0x00, sizeof(szSumAcc) );
		g_Sql_RetStr( "SELECT SUM(ACCOUNT) AS ACCOUNT FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y' \
UNION \
SELECT SUM(ACCEPT_AMT) AS ACCOUNT FROM C6202_NOPAY_OBJ WHERE  ACCEPT_AMT > 0", 20, szSumAcc );
		if( Str_AtoI(szSumAcc) > 0 )
		{
			Str_Chg(szSumAcc,STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)  , szSumAcc);
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6)  , "0");
		}

		Mem_Set( (byte*)szSumOnce, 0x00, sizeof(szSumOnce) );
		g_Sql_RetStr( "SELECT SUM(ACCOUNT) AS ACCOUNT FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y' \
UNION \
SELECT SUM(ACCEPT_AMT) AS ACCOUNT FROM C6202_NOPAY_OBJ WHERE  ACCEPT_AMT > 0", 20, szSumOnce );
		if( Str_AtoI(szSumAcc) > 0 )
		{
			Str_Chg(szSumOnce,STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)  , szSumOnce);
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7)  , "0");
		}
		
		Str_Chg(szSumAcc,STRCHG_DEL_NONDIGIT);
		Str_Chg(szSumOnce,STRCHG_DEL_NONDIGIT);
		lSumTot = Str_AtoI(szSumAcc) + Str_AtoI(szSumOnce);
		
		Str_ItoA(lSumTot, szSumTot, 10);
		
		if( lSumTot > 0 )
		{
			Str_Chg(szSumTot,STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)  , szSumTot);
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5)  , "0");
		}
*/
		ON_DRAW();
		return;
	}
	
	
//------------------------------------------------------------------------------------------
	void AddrDraw(void)
	{
		long i, j;
		long lRet = -1;
		char szAddr[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT COUNTY AS AREA ,TOWN,VILLAGE_RI AS VILLAGE,ADDR1_M,ADDR1_S ,TRIM(VILLAGE) AS CO_LIVE_NM,BUILDING AS BLD_NM,HOUSE_CNT AS HOSU,ETC_ADDR AS DETAIL_FLOOR ,LAW_TOWN,NEW_ROAD_NM,NEW_ADDR_M,NEW_ADDR_S FROM C6101_PROMISE_ASSIGN WHERE (SEND_YN = 'S' OR SEND_YN = 'Y') AND USE_CONT_NUM = ? AND CUST_NUM = ? \
UNION \
SELECT AREA,TOWN,VILLAGE ,ADDR1_M,ADDR1_S ,TRIM(CO_LIVE_NM) ,TRIM(BLD_NM),HOSU,DETAIL_FLOOR,LAW_TOWN ,NEW_ROAD_NM,NEW_ADDR_M,NEW_ADDR_S FROM C6202_NOPAY_OBJ WHERE ACCEPT_AMT > 0 AND USE_CONT_NUM = ? AND CUST_NUM = ?"
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&stReceipt.USE_CONT_NUM , 20, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&stReceipt.CUST_NUM     , 20, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&stReceipt.USE_CONT_NUM , 20, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&stReceipt.CUST_NUM     , 20, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			j = 0;
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.AREA        , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.TOWN        , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.VILLAGE     , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.ADDR1_M     , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.ADDR1_S     , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.CO_LIVE_NM  , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.BLD_NM      , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.HOSU        , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.DETAIL_FLOOR, 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.LAW_TOWN    , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.NEW_ROAD_NM , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.NEW_ADDR_M  , 30, DECRYPT);
			sql->GetValue(sql, j++, 'U', (long*)stReceipt.NEW_ADDR_S  , 30, DECRYPT);
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}
		
		lRet = 1;

Finally:

//		sql->Commit(sql);
		DelSqLite(sql);
		
		if( lRet > 0 )
		{
			Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr) );
			if( g_nAddrFlag == 0 )
			{
				g_nAddrFlag = 1;
				
				Str_Cpy(szAddr, stReceipt.AREA);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.TOWN);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.VILLAGE);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.ADDR1_M);
				Str_Cat(szAddr, "-");
				Str_Cat(szAddr, stReceipt.ADDR1_S);
				Str_Cat(szAddr, " ");
			}
			else
			{
				g_nAddrFlag = 0;
	
				Str_Cpy(szAddr, stReceipt.NEW_ROAD_NM);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.NEW_ADDR_M);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.NEW_ADDR_S);
			}
			
			if( (Str_Len(stReceipt.CO_LIVE_NM)+ Str_Len(stReceipt.BLD_NM)) > 0 )
			{
				Str_Cat(szAddr, stReceipt.CO_LIVE_NM);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.BLD_NM);
				Str_Cat(szAddr, "-");
				Str_Cat(szAddr, stReceipt.HOSU);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.DETAIL_FLOOR);
			}
			else
			{
				Str_Cat(szAddr, stReceipt.HOSU);
				Str_Cat(szAddr, " ");
				Str_Cat(szAddr, stReceipt.DETAIL_FLOOR);
			}
	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)  , szAddr);
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3)  , "");
		}
		
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

}



