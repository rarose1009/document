/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_ETCCARDLST
	Card Desc : 카드 승인 목록
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_ETCCARDLST
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
	#define USE_ON_TASK

	#include "DefEvent.h"
	#include "ArrayList.c"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		// 화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		// 홈
		DEF_BUTTON_ID ( BID_MENU )		// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )	// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	// 공통업무
		DEF_BUTTON_ID ( BID_PREV )		// 이전
		DEF_BUTTON_ID ( BID_EXIT )		// 종료
		
		// 화면 버튼 모음
		DEF_BUTTON_ID ( BID_CARDCL )	// 승인취소
		DEF_BUTTON_ID ( BID_UP )		// 다음페이지
		DEF_BUTTON_ID ( BID_DOWN )		// 이전페이지

	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )	// 타이틀
		
		DEF_OBJECT_ID ( TXT_PAGE )		// 테이블 PAGE
		
		DEF_OBJECT_ID ( TTL_GUBUN )		// 카드종류
		DEF_OBJECT_ID ( TXT_GUBUN )		// 카드종류
		
		DEF_OBJECT_ID ( TTL_NUM )		// 카드번호
		DEF_OBJECT_ID ( TXT_NUM )		// 카드번호
		
		DEF_OBJECT_ID ( TTL_MONTH )		// 할부개월
		DEF_OBJECT_ID ( TXT_MONTH )		// 할부개월	
			
		DEF_OBJECT_ID ( TTL_MONEY )		// 승인금액
		DEF_OBJECT_ID ( TXT_MONEY )		// 승인금액
		
		DEF_OBJECT_ID ( TTL_APPRONUM )	// 승인번호
		DEF_OBJECT_ID ( TXT_APPRONUM )	// 승인번호
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트	
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	//	Table정의에 관련된 내용들
	//---------------------------------------------------------------------------------------
	#define		ROW 	    4								// table의 행개수
	#define		COL 	    12								// table의 열개수
	#define		GRID_H		(CHT+83)						// table 행 높이
	#define		GRID_CLR	TRANSPARENT   					// table 클리어 color
	#define		GRID_X		STARTX 			    			// table 시작x좌표
	#define		MAXCHAR		101 			    			// table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+130  	    			// table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW)*GRID_H+GRID_H/2) 	// table마지막 row의 Y값
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (GRID_ENDY+SYH*(x-1))
	
	char		m_szTableBuf [COL*(ROW+1)*MAXCHAR]; 		// 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"승인시간"  		  , CWD*14   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"카드번호"  		  , CWD*15   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"승인금액"  		  , CWD*12   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"APPROVAL_DATE"      , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"APPROVAL_NUM"       , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CARD_TYPE_NM"       , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ALLOTMENT_MM"  	  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"REQ_YMD"  	  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"TERMINAL_NUM"  	  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CARD_COM"  	  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"BUYING_COMP"  	  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"APPROVAL_AMT"      , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	1
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_nActIndex = -1;		// 선택된 row index
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_bFirst;				// INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	
	char m_szApproval_amt[300];
	char m_szApproval_time[300];
	char m_szApproval_num[300];
    char m_szApproval_mm[300];
    char m_szReq_ymd[300];
	char m_szTerminal_num[300];
	char m_szCard_com[300];
	char m_szBuying_comp[300];
	
	char m_szApproval_cancel_num[300];
	char m_szApproval_cancel_date[300];
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void REDRAW(void);
	void SetStyle(void);
	void SetBtnImg(void);
	long TR66709(void);
	long Rev66709(void);
	
	void Rcv_Mcpay(void);
	long TR66707(void);
	long TR66710(void);

	void Run_Mcpay(void);
	void Rcv_CardData(char* szCardData);
	
	void Snd_CardHist_Rslt(void);
	void Snd_CardHist_Pre(void);
	void Rcv_CardData_Test(void);
	//---------------------------------------------------------------------------------------
	//	Global Btn Style
	//---------------------------------------------------------------------------------------
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
	
	//---------------------------------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "기타 카드승인 목록"),
		
		
		DLG_TABLE (GRID_X, GRID_Y-64, ROW, COL, 0, GRID_H-15, 1, GRID_H/2, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT  ( STARTX,     STARTY+560, 300, 64, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON( STARTX+300, STARTY+560, 350, 64, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON( STARTX+650, STARTY+560, 350, 64, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),		
		
		DLG_TEXT( STARTX,     Line(0)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GUBUN, "카드명"),
		DLG_TEXT( STARTX+252, Line(0)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GUBUN, ""),
		DLG_TEXT( STARTX,     Line(1)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_NUM, "카드번호"),
		DLG_TEXT( STARTX+252, Line(1)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NUM, ""),
		DLG_TEXT( STARTX,     Line(2)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MONTH, "할부개월"),
		DLG_TEXT( STARTX+252, Line(2)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONTH, ""),
		DLG_TEXT( STARTX,     Line(3)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_APPRONUM, "승인번호"),
		DLG_TEXT( STARTX+252, Line(3)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPRONUM, ""),
		DLG_TEXT( STARTX,     Line(4)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MONEY, "승인금액"),
		DLG_TEXT( STARTX+252, Line(4)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONEY, ""),
		
		DLG_BUTTON( STARTX+773, Line(3)-3, 227, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDCL, "승인\n취소"),
	};	
	
	
	//---------------------------------------------------------------------------------------
	//	main
	//---------------------------------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
	//---------------------------------------------------------------------------------------
	// SYSTEM FUNCTION
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
				
				SetBtnImg();
				
				Rev66709();
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnSelect
	기  능 : 테이블 선택 시 데이터 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index;
		char szbuf[500];
		char sztmp[500];
		long n = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_nActIndex = index-1;
				
				// 카드명
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GUBUN),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
				
				// 카드번호
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NUM),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1));
				
				// 할부개월
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
				n = 0;
				n = g_SearchCD( sztmp, CK_CARDMM );
				Str_Cpy(szbuf, CK_CARDMM[n].Str);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONTH), szbuf);
								
				// 승인번호
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPRONUM), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
				
				// 승인금액
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				Str_Cpy( szbuf, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2) );	
				Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
				Str_Chg( szbuf, STRCHG_INS_COMMA );
				Str_Cat( szbuf,"원" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), szbuf );
				
				// m_szApproval_amt
				Mem_Set( (byte*)m_szApproval_amt, 0x00, sizeof(m_szApproval_amt) );
				Str_Cpy(m_szApproval_amt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 11) );	
				
				// m_szApproval_time
				Mem_Set( (byte*)m_szApproval_time, 0x00, sizeof(m_szApproval_time) );
				Str_Cpy( m_szApproval_time, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3) );
				
				// m_szApproval_num
				Mem_Set( (byte*)m_szApproval_num, 0x00, sizeof(m_szApproval_num) );
				Str_Cpy( m_szApproval_num, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4) );
				
				// m_szApproval_mm
				Mem_Set( (byte*)m_szApproval_mm, 0x00, sizeof(m_szApproval_mm) );
				Str_Cpy( m_szApproval_mm, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
				
				// m_szReq_ymd
				Mem_Set( (byte*)m_szReq_ymd, 0x00, sizeof(m_szReq_ymd) );
				Str_Cpy( m_szReq_ymd, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );
				
				// m_szTerminal_num
				Mem_Set( (byte*)m_szTerminal_num, 0x00, sizeof(m_szTerminal_num) );
				Str_Cpy( m_szTerminal_num, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8) );
				
				// m_szCard_com
				Mem_Set( (byte*)m_szCard_com, 0x00, sizeof(m_szCard_com) );
				Str_Cpy( m_szCard_com, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9) );
				
				// m_szBuying_comp
				Mem_Set( (byte*)m_szBuying_comp, 0x00, sizeof(m_szBuying_comp) );
				Str_Cpy( m_szBuying_comp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10) );
				
				ON_DRAW();
			}
		}
	}

	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{
			/********************************/
			/* 공통           			    */
			/********************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "업무 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6101_MENU");
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
				Card_Move("C6101_PayMenu");
				break;
				
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/********************************/
			/* 일반          			    */
			/********************************/
			case BID_CARDCL:
				if(m_nActIndex < 0 )
				{
					MessageBoxEx (ERROR_OK, "승인취소할 자료를 선택하세요.");
					break;
				}
				
				if( MessageBoxEx (CONFIRM_YESNO, "승인취소 하시겠습니까?")  == MB_OK)
				{
					Snd_CardHist_Pre();
				}
				
				break;
				
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
					m_lpage = 0;
				
				m_nActIndex = 0;
				REDRAW();
				break;
			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
					m_lpage = m_lTotpage-1;
					
				m_nActIndex = 0;
				REDRAW();
				break;
		}
	}	
	
	/*=======================================================================================
	함수명 : OnTask
	기  능 : 외부 앱 연동
	Param  : 
	Return : 
	========================================================================================*/ 
	void OnTask(long nEvent, long nData)
	{
		char* szCardData;
		long nRet = 0;
	
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_IC_CARD )
			{
				//시스템콜
				szCardData = (char*)System_GetResult((char*)&nRet);
				
				//결과 저장
				Rcv_CardData(szCardData);
			}
		}
	}
	
	//---------------------------------------------------------------------------------------
	// 일반 FUNCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : 버튼 아이콘 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
			
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
				
				// 일반
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MONTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MONEY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_APPRONUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUBUN), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NUM), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MONTH), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPRONUM), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MONEY), EDITALIGN_LEFT|EDITALIGN_MIDDLE);					
			}
		}
	}

	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 세팅
	Param  : 
	Return :
	========================================================================================*/
	void REDRAW(void)
	{
		long i, idx, n, tknlen;
		long k = ROW+1;
		long lTotPage;
		long lstartidx;
		char sztmp[500];
		char szbuf[500];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetInt("SELECT COUNT(1) FROM RCV_TMP", &m_lTotpage);
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		sql = NewSqLite();
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, "SELECT PARAM1 \
			                                        , PARAM2 \
			                                        , PARAM3 \
			                                        , PARAM13 \
			                                        , PARAM6 \
			                                        , PARAM8 \
			                                        , PARAM5 \
			                                        , PARAM11 \
			                                        , PARAM12 \
			                                        , PARAM7 \
			                                        , PARAM9 \
			                                        , PARAM3 \
												 FROM RCV_TMP LIMIT ?, ?  ");
		}

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
		for ( i = 0 ; i < ROW ; i++ )
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
					continue;
				}
				
				idx = 0;
				
				// param1 승인시간
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				// param2 카드번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

				// param3 승인금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				Str_Cpy( szbuf, sztmp );	
				Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
				Str_Chg( szbuf, STRCHG_INS_COMMA );
				Str_Cat( szbuf,"원" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, szbuf );
				
				
				// 승인금액
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				Str_Cpy( szbuf, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2) );	
				Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
				Str_Chg( szbuf, STRCHG_INS_COMMA );
				Str_Cat( szbuf,"원" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), szbuf );
				
				// param4 APPROVAL_TIME
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				// param5 APPROVAL_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
				// param6 CARD_TYPE_NM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				
				// param7 할부
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
				
				// param8 req
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
				
				// param9 단말
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
				
				// param10 카드컴
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
				
				// param11 바잉
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
				
				// param12 금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 11, sztmp );
			}
		}

Finally:

		DelSqLite(sql);
		
		if( m_nActIndex == -1 )
		{			
			m_nActIndex = 0;		
		}
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
			
			// 카드명
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GUBUN),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			
			// 카드번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NUM),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1));
			
			// 할부개월
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
			n = 0;
			n = g_SearchCD( sztmp, CK_CARDMM );
			Str_Cpy(szbuf, CK_CARDMM[n].Str);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONTH), szbuf);
			
			// 승인번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPRONUM), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			
			// 승인금액
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Str_Cpy( szbuf, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2) );	
			Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
			Str_Chg( szbuf, STRCHG_INS_COMMA );
			Str_Cat( szbuf,"원" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), szbuf );
			
			// m_szApproval_amt
			Mem_Set( (byte*)m_szApproval_amt, 0x00, sizeof(m_szApproval_amt) );
			Str_Cpy(m_szApproval_amt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 11) );	
			
			// m_szApproval_time
			Mem_Set( (byte*)m_szApproval_time, 0x00, sizeof(m_szApproval_time) );
			Str_Cpy( m_szApproval_time, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3) );
			
			// m_szApproval_num
			Mem_Set( (byte*)m_szApproval_num, 0x00, sizeof(m_szApproval_num) );
			Str_Cpy( m_szApproval_num, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4) );
			
			// m_szApproval_mm
			Mem_Set( (byte*)m_szApproval_mm, 0x00, sizeof(m_szApproval_mm) );
			Str_Cpy( m_szApproval_mm, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
			
			// m_szReq_ymd
			Mem_Set( (byte*)m_szReq_ymd, 0x00, sizeof(m_szReq_ymd) );
			Str_Cpy( m_szReq_ymd, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );
			
			// m_szTerminal_num
			Mem_Set( (byte*)m_szTerminal_num, 0x00, sizeof(m_szTerminal_num) );
			Str_Cpy( m_szTerminal_num, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8) );
			
			// m_szCard_com
			Mem_Set( (byte*)m_szCard_com, 0x00, sizeof(m_szCard_com) );
			Str_Cpy( m_szCard_com, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9) );
			
			// m_szBuying_comp
			Mem_Set( (byte*)m_szBuying_comp, 0x00, sizeof(m_szBuying_comp) );
			Str_Cpy( m_szBuying_comp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10) );
		}
		
		ON_DRAW();	
	}
	
	/*=======================================================================================
	함수명 : Rev66709
	기  능 : 최초 카드 승인 데이터 받아옴
	Param  : 
	Return : 
	========================================================================================*/
	long Rev66709(void)
	{
		char szUrl[200];
		char szFilepath[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 66709, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR66709;
		
		ret = HTTP_DownloadData(szUrl, "FR66709_IN",  "FR66709" , sndbuf, szbuf );
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR66709
	기  능 : Rev68602 callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66709(void)
	{
		long ret = 0;

		g_Sock_Close();
		
		ret = g_Chk_Json(66709);
		
		if( ret > 0 )
		{
			REDRAW();
			
			return 1;
		}
		else if( ret == 0  )
		{
			MessageBoxEx (CONFIRM_OK, "승인 내역이 없습니다.") ;
			return 0;
		}
		else
		{
			Mem_Set( (byte*) m_szApproval_amt, 0x00, sizeof( m_szApproval_amt) );
			Mem_Set( (byte*) m_szApproval_time, 0x00, sizeof( m_szApproval_time) );
			Mem_Set( (byte*) m_szApproval_num, 0x00, sizeof( m_szApproval_num) );
			Mem_Set( (byte*) m_szApproval_mm, 0x00, sizeof( m_szApproval_mm) );
			Mem_Set( (byte*) m_szReq_ymd, 0x00, sizeof( m_szReq_ymd) );
			Mem_Set( (byte*) m_szTerminal_num, 0x00, sizeof( m_szTerminal_num) );
			Mem_Set( (byte*) m_szCard_com, 0x00, sizeof( m_szCard_com) );
			Mem_Set( (byte*) m_szBuying_comp, 0x00, sizeof( m_szBuying_comp) );
			Mem_Set( (byte*) m_szApproval_cancel_num, 0x00, sizeof( m_szApproval_cancel_num) );
			Mem_Set( (byte*) m_szApproval_cancel_date, 0x00, sizeof( m_szApproval_cancel_date) );
			
			// 카드명
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GUBUN), "" );
			
			// 카드번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NUM), "" );
			
			// 할부개월
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONTH), "" );
			
			// 승인번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPRONUM), "" );
			
			// 승인금액
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), "" );

			REDRAW();
			
			return -1;
		}
	}

	/*=======================================================================================
	함수명 : Snd_CardHist_Pre
	기  능 : 이력 테이블에 시도건 등록
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_CardHist_Pre(void)
	{
		char szTmp[500];
		char szUrl[300];
		char szbuf[300];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		long i = 0;
		char szUcovert[100];
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		
		g_SeverConnection();
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66707, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd" , stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "item_flag" , "10" );
		JSON_SetValue( g_pjcomm, 'C', "prcss_status", "2" );
		JSON_SetValue( g_pjcomm, 'C', "terminal_num", stUserinfo.szcard_term_id2 );
		JSON_SetValue( g_pjcomm, 'C', "allotment_mm", m_szApproval_mm	);
		JSON_SetValue( g_pjcomm, 'C', "approval_amt", m_szApproval_amt );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR66707;
		
		HTTP_DownloadData( szUrl, "FR66707_IN",  "FR66707" , sndbuf, szbuf );
	}
	
	
	/*=======================================================================================
	함수명 : TR66707
	기  능 : 카드 승인 전 hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR66707(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(66707) >= 0)
		{	
			Run_Mcpay();	
			// Rcv_CardData_Test();
			return 1;
		}
		else
		{
			ON_DRAW();	
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_CardHist_Rslt
	기  능 : 이력 테이블에 결과 등록
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_CardHist_Rslt(void)
	{
		char szTmp[300];
		char szUrl[300];
		char szbuf[300];
		char szUcovert[300];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		
		g_SeverConnection();
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66710, FALSE);
		
		
		JSON_SetValue( g_pjcomm, 'C', "approval_cancel_num"		, m_szApproval_cancel_num  );
		JSON_SetValue( g_pjcomm, 'C', "approval_cancel_date"	, m_szApproval_cancel_date );
		JSON_SetValue( g_pjcomm, 'C', "req_ymd"		   			, m_szReq_ymd  );
		
		
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		SQL_ConvUcStr( szTmp, stEtcCardinfo.szBuying_comp_nm );
		JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   	, m_szTerminal_num );
		
		
		JSON_SetValue( g_pjcomm, 'C', "card_com"		   		, m_szCard_com  );
		JSON_SetValue( g_pjcomm, 'C', "buying_comp"		   		, m_szBuying_comp );
		JSON_SetValue( g_pjcomm, 'C', "approval_num"		   	, m_szApproval_num  );
		JSON_SetValue( g_pjcomm, 'C', "approval_date"		   	, m_szApproval_time );
		JSON_SetValue( g_pjcomm, 'C', "center_cd" 				, stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "approval_amt" 			, m_szApproval_amt );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR66710;
		
		HTTP_DownloadData( szUrl, "FR66710_IN",  "FR66710" , sndbuf, szbuf );
	}
	
	
	/*=======================================================================================
	함수명 : TR66708
	기  능 : 카드 승인
	Param  : 
	Return : 
	========================================================================================*/
	long TR66710(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(66710) >= 0)
		{
			Card_Move("C6101_PayMenu");
			return 1;
		}
		else
		{	
			Card_Move("C6101_PayMenu");
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Run_Mcpay
	기  능 : Run_Mcpay 활성화
	Param  : 
	Return : 
	========================================================================================*/
	void Run_Mcpay(void)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;
	
		char szSql[100];
		char szTmp[100];
		
		char receipt_YN[2];

		Mem_Set( (byte*)receipt_YN, 0x00, sizeof(receipt_YN) );
		// 영수증 발급문의
		if( MessageBoxEx (CONFIRM_YESNO, "취소 영수증을 발행하시겠습니까?")  == MB_OK)
		{						
			Str_Cpy(receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(receipt_YN, "N");
		}
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hdata	, 'C', "receiptyn"			, receipt_YN);
			JSON_SetValue	(hdata	, 'C', "call"				, "creditVoid");
			JSON_SetValue	(hdata	, 'C', "desc"				, "신용취소");
			JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
			JSON_SetValue	(hdata	, 'C', "type"				, "");
			JSON_SetValue	(hdata	, 'C', "totalprice"			, m_szApproval_amt);
			JSON_SetValue	(hdata	, 'C', "tax"				, "0");
			JSON_SetValue	(hdata	, 'C', "svc"				, "0");
			JSON_SetValue	(hdata	, 'C', "inst"				, m_szApproval_mm);
			JSON_SetValue	(hdata	, 'C', "printdata"			, "");
	
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Cpy( (byte*)szTmp, (byte*)m_szApproval_time+2, 6 );
			JSON_SetValue	(hdata	, 'C', "approvaldate"		, szTmp);
			
			JSON_SetValue	(hdata	, 'C', "approvalno"			, m_szApproval_num);	
			JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
			JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
			JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
			JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
			JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id2);
			JSON_SetValue	(h		, 'C', "method"				, "IC_CardPay");
			
			JSON_Attach 	(h		, "data"					, hdata);

			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hdata)
		{
			JSON_Finalize(hdata);
		}	
		return;
	
	}
	
	/*=======================================================================================
	함수명 : Rcv_CardData
	기  능 : MCPAY RETRUN
	Param  : 
	Return : 
	========================================================================================*/ 
	void Rcv_CardData(char* szCardData)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lRet = 0;
		long lCnt = 0;
		char *szitem;
		char *szData;
		long *nCol;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 0;
		handle hItem = NULL;
		handle hData = NULL;
		
		long hist_rslt = 0;
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCardData ) ;

			Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));

			if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "null") == 0 )
			{
				
				Mem_Set( (byte*) m_szTerminal_num, 0x00, sizeof( m_szTerminal_num) );
				Mem_Set( (byte*) m_szApproval_amt, 0x00, sizeof( m_szApproval_amt) );
				Mem_Set( (byte*) m_szCard_com, 0x00, sizeof( m_szCard_com) );
				Mem_Set( (byte*) m_szBuying_comp, 0x00, sizeof( m_szBuying_comp) );
				Mem_Set( (byte*) m_szApproval_cancel_num, 0x00, sizeof( m_szApproval_cancel_num) );
				Mem_Set( (byte*) m_szApproval_cancel_date, 0x00, sizeof( m_szApproval_cancel_date) );
				
				Str_Cpy( m_szTerminal_num  		 		, JSON_GetValue (hItem, "tid", szType) );
				Str_Cpy( m_szApproval_amt 			 	, JSON_GetValue (hItem, "totalamount", szType) );
				Str_Cpy( m_szCard_com				 	, JSON_GetValue (hItem, "code2", szType) );	
				Str_Cpy( m_szBuying_comp			 	, JSON_GetValue (hItem, "code1", szType) );
				Str_Cpy( m_szApproval_cancel_num	 	, JSON_GetValue (hItem, "approvalno", szType) );
				Str_Cpy( m_szApproval_cancel_date	 	, JSON_GetValue (hItem, "approvaldate", szType) );
				
				hist_rslt = 1;
			}
			else
			{	
				Card_Move("C6101_PayMenu");
				hist_rslt = 0;
			}
		}
	
		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
	
		g_Close_SubDlg();
		
		if( hist_rslt == 1 )
		{
			Snd_CardHist_Rslt();	
		}
		else
		{
			Card_Move("C6101_PayMenu");
		}
		
		return;
	}
	
	
	/*=======================================================================================
	함수명 : Rcv_CardData_Test
	기  능 : MCPAY Test
	Param  : 
	Return : 
	========================================================================================*/ 
	void Rcv_CardData_Test(void)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lRet = 0;
		long lCnt = 0;
		char *szitem;
		char *szData;
		long *nCol;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 0;
		handle hItem = NULL;
		handle hData = NULL;
		
		long hist_rslt = 0;
			
		
		Mem_Set( (byte*)m_szApproval_cancel_num, 0x00, sizeof(m_szApproval_cancel_num) );
		Str_Cpy( m_szApproval_cancel_num, "324324234" );
		Mem_Set( (byte*)m_szApproval_cancel_date, 0x00, sizeof(m_szApproval_cancel_date) );
		Str_Cpy( m_szApproval_cancel_date, "191230123055" );
		
		hist_rslt = 1;
		
		g_Close_SubDlg();
		
		if( hist_rslt == 1 )
		{
			Snd_CardHist_Rslt();	
		}
		else
		{
			Card_Move("C6101_PayMenu");
		}
		
		return;
	}
}



