/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_CARDLST
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
		DEF_BUTTON_ID ( BID_ADDR )		// 주소
		DEF_BUTTON_ID ( BID_ADDR2 )		// 주소
		DEF_BUTTON_ID ( BID_UP )		// 다음페이지
		DEF_BUTTON_ID ( BID_DOWN )		// 이전페이지
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )	// 타이틀
		DEF_OBJECT_ID ( TXT_PAGE )		// 타이틀

		DEF_OBJECT_ID ( TTL_GUBUN )		// 카드종류
		DEF_OBJECT_ID ( TXT_GUBUN )		// 카드종류
		DEF_OBJECT_ID ( TTL_NUM )		// 카드번호
		DEF_OBJECT_ID ( TXT_NUM )		// 카드번호
		DEF_OBJECT_ID ( TTL_MONTH )		// 할부개월
		DEF_OBJECT_ID ( TXT_MONTH )		// 할부개월		
		DEF_OBJECT_ID ( TTL_MONEY )		// 승인금액
		DEF_OBJECT_ID ( TXT_MONEY )		// 승인금액
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트	
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table의 행개수
	#define		COL 	    11					// table의 열개수
	#define		GRID_H		(CHT+83)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+130  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    // table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW)*GRID_H+GRID_H/2) // table마지막 row의 Y값
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (GRID_ENDY+SYH*(x-1))
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"구분"      		  , CWD*5    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"항목"      		  , CWD*5    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소"      		  , CWD*21   , EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"승/취시간"  		  , CWD*9    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"카드명"    		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"카드번호"  		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"할부개월"  		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"승인금액"  		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"승인번호"           , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"PROMISE_ASSIGN_SEQ" , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},	
		{"APPROVAL_TIME"      , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};
	
	#define INIT_MAIN	1

	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_nActIndex = -1;		// 선택된 row index
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_bFirst;				// INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	
	char m_szPromise_assign_seq[100];
	char m_szApproval_amt[100];
	char m_szApproval_time[100];
	
	CARRAYLIST m_pList = NULL;
	bool m_bPrintAgain = FALSE;
		
	void REDRAW(void);
	void SetStyle(void);
	void SetBtnImg(void);
	long TR68602(void);
	long Rev68602(void);
	void Rcv_Mcpay(void);
	long TR67061(void);
	long TR67062(void);
	
	bool Load_CardData(char* szPromise_assign_seq, char* szApproval_amt, char* szApproval_time );
	long Load_Assign(char* assign_seq, char* szApproval_amt);
	
	void Snd_ApproCancelCard(void);
	long Rcv_ApproCancelCard(void);
	long Chk_Json_68604(void);	
	long GetUtf8Size(char* str, long chklen);
	long SearchCD( char *CD, CodeTable *CT);
	long SearchStr( char *Str, CodeTable *CT);
	void Snd_CardHist(long flag);
	
	void Card_CancelPirnt(void);
	void* Card_GetPrintData(void);
	long Card_Print_Result(void* p);
	void Snd_Card_Appro_H(void);
	long TR68606(void);
	
	void Run_Mcpay(void);
	void Rcv_CardData(char* szCardData);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "카드승인목록"),
		
		DLG_BUTTON( STARTX,     STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON( STARTX+200, STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명"),
		DLG_TEXT  ( STARTX+400, STARTY+65, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON( STARTX+600, STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON( STARTX+800, STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		DLG_TEXT( STARTX,     Line(1)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GUBUN, "카드종류"),
		DLG_TEXT( STARTX+252, Line(1)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GUBUN, ""),
		DLG_TEXT( STARTX,     Line(2)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_NUM, "카드번호"),
		DLG_TEXT( STARTX+252, Line(2)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NUM, ""),
		DLG_TEXT( STARTX,     Line(3)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MONTH, "할부개월"),
		DLG_TEXT( STARTX+252, Line(3)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONTH, ""),
		DLG_TEXT( STARTX,     Line(4)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MONEY, "승인금액"),
		DLG_TEXT( STARTX+252, Line(4)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONEY, ""),
		
		DLG_BUTTON( STARTX+773, Line(3)-3, 227, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDCL, "승인\n취소"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H/2, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "카드승인목록"),
		
		DLG_BUTTON( STARTX,     STARTY+80, 180, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON( STARTX+190, STARTY+80, 180, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명"),
		DLG_TEXT(   STARTX+380, STARTY+80, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+660, STARTY+80, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+820, STARTY+80, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_TEXT( STARTX,     Line(1),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_GUBUN, "카드종류"),
		DLG_TEXT( STARTX+350, Line(1),  620, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GUBUN, ""),
		DLG_TEXT( STARTX,     Line(2),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_NUM, "카드번호"),
		DLG_TEXT( STARTX+350, Line(2),  620, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NUM, ""),
		DLG_TEXT( STARTX,     Line(3),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_MONTH, "할부개월"),
		DLG_TEXT( STARTX+350, Line(3),  330, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONTH, ""),
		DLG_TEXT( STARTX,     Line(4),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_MONEY, "승인금액"),
		DLG_TEXT( STARTX+350, Line(4),  330, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONEY, ""),

		DLG_BUTTON( STARTX+670, Line(3), 300, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDCL, "승인\n취소"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H/2, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};
	
	//----------------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
	void OnInit(char bFirst)
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
				Rev68602();
				break;
		}
	}
	
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
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MONTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MONEY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MONTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MONEY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				
				// 지번, 도로명 주소 세팅
				if( g_nAddrFlag == 0 )
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
				}
				else
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
				}				
			}
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
		char szbuf[50];
		
		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_nActIndex = index-1;
				
				// 카드종류
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GUBUN), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));	
				
				//카드번호
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NUM),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
				
				//할부개월
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONTH), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
				
				// 승인금액
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				Str_Cpy(szbuf, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
				Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
				Str_Chg( szbuf, STRCHG_INS_COMMA );
				Str_Cat( szbuf,"원");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), szbuf);
				
				// m_szApproval_amt
				Mem_Set( (byte*)m_szApproval_amt, 0x00, sizeof(m_szApproval_amt) );
				Str_Cpy(m_szApproval_amt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
				
				// m_szPromise_assign_seq
				Mem_Set( (byte*)m_szPromise_assign_seq, 0x00, sizeof(m_szPromise_assign_seq) );
				Str_Cpy( m_szPromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9) );				

				// m_szApproval_time
				Mem_Set( (byte*)m_szApproval_time, 0x00, sizeof(m_szApproval_time) );
				Str_Cpy( m_szApproval_time, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10) );
				
				if( Load_CardData(m_szPromise_assign_seq, m_szApproval_amt, m_szApproval_time) == FALSE )
				{
					MessageBoxEx (CONFIRM_OK, "카드정보에 이상이 있습니다.");
					return;
				}
				
				Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);
				
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
			case BID_ADDR:
				g_nAddrFlag = 0;
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
				REDRAW();
				break;
			
			case BID_ADDR2:
				g_nAddrFlag = 1;
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), FALSE );
				REDRAW();
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
			
			case BID_CARDCL:
				if(m_nActIndex < 0 )
				{
					MessageBoxEx (ERROR_OK, "승인취소할 자료를 선택하세요.");
					break;
				}
				
				if( Str_Cmp( DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 0), "승인" ) != 0)
				{
					MessageBoxEx (ERROR_OK, "승인된 내역만 취소 할 수 있습니다.");
					break;
				}
				
				if( MessageBoxEx (CONFIRM_YESNO, "승인취소 하시겠습니까?")  == MB_OK)
				{
					//	Snd_ApproCancelCard();
					Snd_CardHist(4);
				}
				
				break;
				
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
				Card_Move("C6101_MENU");
				break;
				
			case GID_VMEXIT:
				g_Exit();
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
				
				//아래 주석을 풀면 결과 데이터를 json 파일로 저장 할 수 있음(저장위치 : smart/SND.json)
				//g_Save_JsonFile(szCardData);
		
				//결과 저장
				Rcv_CardData(szCardData);
			}
		}
	}
	
	//----------------------------------------------------------------------
	//함수명 : SearchStr
	//기  능 : 스트링으로 코드인덱스를 찾는다.
	//Param  : 
	//Return : 코드인덱스, 없으면 -1
	//----------------------------------------------------------------------
	long SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	/*=======================================================================================
	함수명 : SearchCD
	기  능 : 코드값으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
				return i;
		}
		return -1;
	}
	
	/*=======================================================================================
	함수명 : GetUtf8Size
	기  능 : 한글 체크
	Param  : 
	Return : 
	========================================================================================*/
	long GetUtf8Size(char* str, long chklen)
	{
		long nSize = 0;
		long nLen = 0;
		long i = 0;
		
		nSize = Str_Len(str);
		
		for(i=0 ; i < nSize ; )
		{
			if ( str[i] & 0x80 )	//한글
				i+=2;			//2글자
			else
				i++;
				
			if( i >= chklen )
				break;
		}
		nLen = i;
		return nLen;
	}
	
	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 세팅
	Param  :  
	         PARAM1	 : PROMISE_ASSIGN_SEQ    
			 PARAM2	 : CIVIL_SERV_RECEIVE_NUM
			 PARAM3	 : TREAT_SEQ             
			 PARAM4	 : ITEM_FLAG
			 PARAM5	 : TERMINAL_NUM
			 PARAM6	 : CARD_COM
			 PARAM7	 : CARD_TYPE_NM
			 PARAM8	 : BUYING_COMP
			 PARAM9	 : BUYING_COMP_NM
			 PARAM10 : ALLOTMENT_MM
			 PARAM11 : CARD_NUM
			 PARAM12 : VALID_YM 
			 PARAM13 : APPROVAL_AMT
			 PARAM14 : APPROVAL_NUM
			 PARAM15 : APPROVAL_DATE
			 PARAM16 : CUST_NUM
			 PARAM17 : CUST_NM
			 PARAM18 : USE_CONT_NUM
			 PARAM19 : CURR_ADDR_UNION
			 PARAM20 : NEW_ADDR_UNION
			 PARAM21 : PRCSS_STATUS 
			 PARAM22 : APPROVAL_CANCEL_DATE 
	Return :
	========================================================================================*/
	void REDRAW(void)
	{
		long i, idx, n, tknlen;
		long k = ROW+1;
		long lTotPage;
		long lstartidx;
		char sztmp[301];
		char szbuf[50];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetInt("SELECT COUNT(1) FROM RCV_TMP A, C6101_PROMISE_ASSIGN B WHERE A.param1 = B.PROMISE_ASSIGN_SEQ  AND B.SEND_YN IN ('Y','S','N') ", &m_lTotpage);
		
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
			hstmt = sql->CreateStatement(sql, "SELECT A.PARAM21 \
													, A.PARAM4 \
													, A.PARAM19 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
														   ELSE A.PARAM15 \
													   END AS PARAM15 \
													, A.PARAM7 \
													, A.PARAM11 \
													, A.PARAM10 \
													, A.PARAM13 \
													, A.PARAM14 \
													, A.PARAM1 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
													   	   ELSE A.PARAM15 \
													   END AS PARAM15 \
												 FROM RCV_TMP A \
													, C6101_PROMISE_ASSIGN B \
												WHERE A.PARAM1 = B.PROMISE_ASSIGN_SEQ \
												  AND B.SEND_YN IN ('Y','S','N') LIMIT ?, ? ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql, "SELECT A.PARAM21 \
													, A.PARAM4 \
													, A.PARAM20 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
														   ELSE A.PARAM15 \
													   END AS PARAM15 \
													, A.PARAM7 \
													, A.PARAM11 \
													, A.PARAM10 \
													, A.PARAM13 \
													, A.PARAM14 \
													, A.PARAM1 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
													   	   ELSE A.PARAM15 \
													   END AS PARAM15 \
												 FROM RCV_TMP A \
												    , C6101_PROMISE_ASSIGN B \
												WHERE A.PARAM1 = B.PROMISE_ASSIGN_SEQ \
												  AND B.SEND_YN IN ('Y','S','N') LIMIT ?, ? ");
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
					continue;
				}
				
				idx = 0;

				// param21 구분
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT); 
				
				if(sztmp[0] == '2')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "승인" );
				}
				else // 3
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "취소" );
				}

				// param4 항목
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);

				if( Str_Cmp(sztmp,"10") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "가스" );
				}
				else // 20
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "일회성" );
				} 

				// param19 주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				// param15 승인시간
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				
				Mem_Cpy( (byte*)szbuf, (byte*)sztmp+8, 2 );
				szbuf[2] = ':';
				Mem_Cpy( (byte*)szbuf+3, (byte*)sztmp+10, 2 );
				szbuf[5] = ':';
				Mem_Cpy( (byte*)szbuf+6, (byte*)sztmp+12, 2 );
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, szbuf );

				// param7 카드명
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
				// param11 카드번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );

				// param6 할부
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				n = 0;
				n = SearchCD( sztmp, CK_CARDMM );
				Str_Cpy(szbuf, CK_CARDMM[n].Str);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, szbuf );

				// param10 승인금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );

				// param14 승인번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );

				// param1 assign_seq
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
				
				// APPROVAL_TIME
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_nActIndex == -1 )
		{			
			m_nActIndex = 0;		
		}
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
				
			// 카드종류
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GUBUN), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));	
			
			// 카드번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NUM),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			
			// 할부개월
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONTH), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			
			// 승인금액
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Str_Cpy( szbuf, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
			Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
			Str_Chg( szbuf, STRCHG_INS_COMMA );
			Str_Cat( szbuf,"원" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), szbuf );
			
			// m_szApproval_amt
			Mem_Set( (byte*)m_szApproval_amt, 0x00, sizeof(m_szApproval_amt) );
			Str_Cpy(m_szApproval_amt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
			
			// m_szPromise_assign_seq
			Mem_Set( (byte*)m_szPromise_assign_seq, 0x00, sizeof(m_szPromise_assign_seq) );
			Str_Cpy(m_szPromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9) );	
			
			// m_szApproval_time
			Mem_Set( (byte*)m_szApproval_time, 0x00, sizeof(m_szApproval_time) );
			Str_Cpy( m_szApproval_time, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10) );
			
			if( Load_CardData(m_szPromise_assign_seq, m_szApproval_amt, m_szApproval_time) == FALSE )
			{
				MessageBoxEx (CONFIRM_OK, "카드정보에 이상이 있습니다.");
				return;
			}
			
			Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);
			
		}
		
		ON_DRAW();
		
	}
	
	/*=======================================================================================
	함수명 : Rev68602
	기  능 : 최초 카드 승인 데이터 받아옴
	Param  : 
	Return : 
	========================================================================================*/
	long Rev68602(void)
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
		
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 68602, FALSE);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR68602;
		ret = HTTP_DownloadData(szUrl, "FR68602_IN",  "FR68602" , sndbuf, szbuf );
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR68602
	기  능 : Rev68602 callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR68602(void)
	{
		long ret = 0;

		g_Sock_Close();
		
		ret = g_Chk_Json(68602);
		
		if( ret > 0 )
		{
			REDRAW();
			return 1;
		}
		else if( ret == 0  )
		{
			MessageBoxEx (CONFIRM_OK, "카드승인 내역이 없습니다.") ;
			return 0;
		}
		else if( ret < 0  )
		{
			OnButton(GID_PREV);
			return -1;
		}
		
		return -1;
	}

	void Snd_CardHist(long flag)
	{
		char szTmp[100];
		char szUrl[200];
		char szbuf[128];
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66706, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"     , stMw.szPromise_assign_seq    	   );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num" , stMw.szCivil_serv_receive_num     );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"			   , stMw.szTreat_seq  		   		   );
		
		JSON_SetValue( g_pjcomm, 'C', "item_flag"			   , stCardinfo.szItem_flag			   	   );
		JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   , stCardinfo.szTerminal_num		   	   );
		JSON_SetValue( g_pjcomm, 'C', "approval_amt"		   , stCardinfo.szApproval_amt		  	   );
		JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "20"	 );	
		
		// 승인 전
		if( flag == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , "*"     			           	   );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "4"     );	
		}
		// 승인 후
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , stCardinfo.szCard_num			    );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "3"                                );	
			JSON_SetValue( g_pjcomm, 'C', "rslt_cd"			       , "O"			   				    );
			JSON_SetValue( g_pjcomm, 'C', "valid_ym"			   , stCardinfo.szValid_ym			    );
			JSON_SetValue( g_pjcomm, 'C', "allotment_mm"		   , stCardinfo.szAllotment_mm		    );
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_num"	   , stCardinfo.szApproval_cancel_num   );	
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_date"   , stCardinfo.szApproval_cancel_date  );	

			JSON_SetValue( g_pjcomm, 'C', "card_com"		       , stCardinfo.szCard_com 		   		);
			JSON_SetValue( g_pjcomm, 'C', "buying_comp"		       ,stCardinfo.szBuying_comp 		    );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szCard_type_nm );
			JSON_SetValue( g_pjcomm, 'C', "card_type_nm"		   , szTmp		   );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szBuying_comp_nm );
			JSON_SetValue( g_pjcomm, 'C', "buying_comp_nm"		   , szTmp		   );
		}
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		// 취소 완료
		if( flag == 3 )
		{
			callBackfunc = TR67061;
		}
		// 취소 시도
		else
		{
			callBackfunc = TR67062;
		}

		HTTP_DownloadData( szUrl, "FR66706_IN",  "FR66706" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Load_CardData
	기  능 : 화면 세팅
	Param  : szPromise_assign_seq, szApproval_amt, szApproval_time
	         PARAM1	 : PROMISE_ASSIGN_SEQ    
			 PARAM2	 : CIVIL_SERV_RECEIVE_NUM
			 PARAM3	 : TREAT_SEQ             
			 PARAM4	 : ITEM_FLAG
			 PARAM5	 : TERMINAL_NUM
			 PARAM6	 : CARD_COM
			 PARAM7	 : CARD_TYPE_NM
			 PARAM8	 : BUYING_COMP
			 PARAM9	 : BUYING_COMP_NM
			 PARAM10 : ALLOTMENT_MM
			 PARAM11 : CARD_NUM
			 PARAM12 : VALID_YM 
			 PARAM13 : APPROVAL_AMT
			 PARAM14 : APPROVAL_NUM
			 PARAM15 : APPROVAL_DATE
			 PARAM16 : CUST_NUM
			 PARAM17 : CUST_NM
			 PARAM18 : USE_CONT_NUM
			 PARAM19 : CURR_ADDR_UNION
			 PARAM20 : NEW_ADDR_UNION
			 PARAM21 : PRCSS_STATUS
			 PARAM22 : APPROVAL_CANCEL_DATE
	Return :
	========================================================================================*/
	bool Load_CardData( char* szPromise_assign_seq, char* szApproval_amt, char* szApproval_time )
	{
		long i;
		char sztmp[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		bool bret =FALSE;
		
		Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			bret =FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PARAM1, PARAM18, PARAM4, '1', 'O', PARAM5 \
											   , PARAM11, PARAM12, PARAM6, PARAM7, PARAM8 \
											   , PARAM9, PARAM13, PARAM14, PARAM10, PARAM15 \
											   , PARAM2, PARAM3 \
											FROM RCV_TMP \
										   WHERE PARAM1 = ? AND PARAM13 = ? AND ( PARAM15 = ? OR PARAM22 = ? )");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bret =FALSE;
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)szPromise_assign_seq, 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szApproval_amt, 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szApproval_time, 14, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szApproval_time, 14, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bret =FALSE;
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szItem_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRecev_seq             ,3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRslt_cd               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTerminal_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_num              ,128+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szValid_ym              ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_com              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_type_nm          ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp_nm        ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_amt          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_num          ,12 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szAllotment_mm          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_time         ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTreat_seq             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szReq_ymd               ,8  +1, DECRYPT );
			
			bret =TRUE;
		}
Finally:

		DelSqLite(sql);
		return bret;
	}
	
	/*=======================================================================================
	함수명 : TR67061
	기  능 : 카드 승인 후 hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67061(void)
	{
		if(g_Chk_Json(66706) >= 0)
		{
			g_Sock_Close();
			CloseMessageBox();
			Snd_Card_Appro_H();
			
			//Rcv_ApproCancelCard();
			//g_Sock_Close();
			//CloseMessageBox();
			//ON_DRAW();
			//REDRAW();
			
			return 1;
		}
		else
		{	
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : TR67061
	기  능 : 카드 승인 전 hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67062(void)
	{
		char szSql[350];

		if(g_Chk_Json(66706) >= 0)
		{
			Rcv_Mcpay();
			
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			
			return -1;
		}	
		
	}
	/*=======================================================================================
	함수명 : Rcv_Mcpay
	기  능 : Mcpay 작동 function
	Param  : 
	Return : 
	========================================================================================*/
	void Rcv_Mcpay(void)
	{
		/*
		if( MessageBoxEx (CONFIRM_YESNO, "[ MCPAY가 동작했음 ]\n카드취소 중...\n \n취소성공-> [예]\n취소실패-> [아니오]") == MB_OK )
		{
			Snd_CardHist(3);
		}
		else
		{
			MessageBoxEx (ERROR_OK, "승인 취소 실패 : err_code_9999");
		}
		*/
		Run_Mcpay();

		REDRAW();
	}
	
	/*=======================================================================================
	함수명 : Rcv_ApproCancelCard
	기  능 : 승인 취소 후 로컬 db업데이트
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_ApproCancelCard(void)
	{
		char sql[500];
		
		//Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);
		
		//완료처리 되기 전에 취소 가능하도록 로직 변경함.
		if( Str_AtoI(stCardinfo.szApproval_amt) > 0 ) 
		{ 
			//Card_CancelPirnt();	
		}
		
		// 카드결제 이력 업데이트
		
		Mem_Set( (byte*)sql, 0x00, sizeof(sql) );	

		Str_Cpy(sql, " DELETE FROM C6101_PROMISE_CARD ");
		Str_Cat(sql, " WHERE PROMISE_ASSIGN_SEQ = ");
		Str_Cat(sql,  stCardinfo.szPromise_assign_seq );
		Str_Cat(sql, " AND APPROVAL_AMT = ");
		Str_Cat(sql,  m_szApproval_amt );
		Str_Cat(sql, " AND ITEM_FLAG = ");
		Str_Cat(sql,  stCardinfo.szItem_flag );

		if ( g_Sql_DirectExecute(sql) == 0 )
		{
			// 민원정보 결제금액 업데이트
			Mem_Set( (byte*)sql, 0x00, sizeof(sql) );	
			
			// 가스 카드 결제
			if( Str_Cmp(stCardinfo.szItem_flag, "10") == 0 )
			{
				Str_Cpy(sql, " UPDATE C6101_PROMISE_ASSIGN SET CARD_GASPAY='' ");
				Str_Cat(sql," ,UPD_EMPID = '");
				Str_Cat(sql,  stUserinfo.szemployee_id);
				Str_Cat(sql,"',PDA_IP = '");
				Str_Cat(sql,  stUserinfo.szpda_ip);
				Str_Cat(sql,"' WHERE PROMISE_ASSIGN_SEQ = ");
				Str_Cat(sql,  stCardinfo.szPromise_assign_seq );
				Str_Cat(sql," AND CARD_GASPAY = ");
				Str_Cat(sql,  m_szApproval_amt );
			}
			//일회성 카드 결제
			else
			{
				Str_Cpy(sql, " UPDATE C6101_PROMISE_ASSIGN SET CARD_ONEPAY ='' ");
				Str_Cat(sql," ,UPD_EMPID = '");
				Str_Cat(sql,  stUserinfo.szemployee_id);
				Str_Cat(sql,"',PDA_IP = '");
				Str_Cat(sql,  stUserinfo.szpda_ip);
				Str_Cat(sql,"' WHERE PROMISE_ASSIGN_SEQ = ");
				Str_Cat(sql,  stCardinfo.szPromise_assign_seq );
				Str_Cat(sql," AND CARD_ONEPAY = ");
				Str_Cat(sql,  m_szApproval_amt );
			}
			
			// 데이터 새로 불러옴
			if ( g_Sql_DirectExecute(sql) == 0 )
			{
				Rev68602();
				return 1;
			}
			else
			{
				MessageBoxEx (ERROR_OK, "카드취소 데이터 저장에 실패하였습니다.");
				ON_DRAW();
				return -1;
			}
		}
		else
		{
			MessageBoxEx (ERROR_OK, "카드취소 데이터 저장에 실패하였습니다.");
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Load_Assign
	기  능 : 로컬 db C6101_PROMISE_ASSIGN 가져옴
	Param  : 
	Return : 
	========================================================================================*/
	long Load_Assign(char* assign_seq, char* szApproval_amt)
	{
		long i;
		long ret = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stMw, 0x00, sizeof(stMw));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PROMISE_ASSIGN_SEQ, REG_FLAG, BRANCH_CD, CENTER_CD, ASSIGN_EMPID \
											    , CUST_NUM, USE_CONT_NUM, INST_PLACE_NUM, ZIP_SEQ, ETC_ADDR \
											    , CIVIL_SERV_CLASS_CD, PROMISE_YMD, PROMISE_TIME, END_EXPECT_TIME, JOB_STR_DTM \
											    , JOB_END_DTM,  PROMISE_ASSIGN_DESC, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, PROC_STS_CD \
											    , PDA_NUM, ONCE_PAY, SEND_YN, CIVIL_SERV_CLASS_NM, PDA_DUTY \
											    , REQ_TEL_DDD, REQ_TEL_EXN, REQ_TEL_NUM, REQ_CP_DDD, REQ_CP_EXN, REQ_CP_NUM \
											    , TRANS_IN_CUST_NM, TRANS_IN_SOC_NUM, REQ_NM, REQ_SOC_NUM, RECEIVE_DTM, CUST_TYPE_CD \
											    , CUST_NM, FIRM_NM, SOC_NUM, BIZ_REGI_NUM, CP_DDD, CP_EXN \
											    , CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, FIRM_TEL_DDD \
											    , FIRM_TEL_EXN, FIRM_TEL_NUM, SCG_RELAT_CD, EMAIL, FAMILY_CNT \
											    , CUST_TRND_CD, CHK, BUILT_IN_YN, SQUARE_METER, CURR_ADDR_UNION \
											    , BLD_FLOOR, HOUSE_CNT, PDA_DUTY_FLAG, PAY_CALU, PDA_TRANS_FLAG \
											    , REQ_INFO_NUM, TRANS_IN_CUST_NUM, CONT_STS_CD, PDA_READ_DTM, MEMO \
											    , AUTO_YN, CUST_YN, BUR_YN, PROD_YN, ONCE_YN \
											    , PRICE_YN, ZIP_NO1, ZIP_NO2, CITY, COUNTY \
											    , TOWN, VILLAGE_RI, VILLAGE, BUILDING, ADDR1_M \
											    , ADDR1_S, ACCOUNT, ONCE_ACCOUNT, CHK_TIME_FROM \
											    , CHK_TIME_END, MTR_CHG_YN, INFO_USE_AGREE_YN, PAS_USE_CONT_NUM_YN, ADJ_ALT_AMT \
											    , PAS_DEFRAY_ACCOUNT_NUM, PAS_CUST_NUM, PAS_REQ_INFO_NUM, APPRO_NUM, APPRO_TEL, ADJ_CAUSE \
											    , DEADLINE_FLAG, GMTR_BASE_DAY, CARD_GASPAY, CARD_ONEPAY, CASH_GASPAY \
											    , INFO_USE_YN, USE_CONT_DOC_YN, PAY_METHOD, DEFRAY_ACCOUNT_NUM, DEPOSITOR_NM \
											    , BANK_NM, DEBT_AMT, LAW_ETC_AMT, LAW_TOWN, NEW_ROAD_NM \
											    , NEW_ADDR_M, NEW_ADDR_S, NEW_ADDR_UNION, BILL_GUBUN, TRANS_CONN_YN \
											    , CONN_YN, BAR_YN, BAR_GBN, BAR_WHY, CHK_YN, CONN_GBN \
											 FROM C6101_PROMISE_ASSIGN \
											WHERE PROMISE_ASSIGN_SEQ = ? AND SEND_YN IN ('Y', 'S', 'N') ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)assign_seq , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		while(sql->Next(sql) )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReg_flag              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBranch_cd             ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCenter_cd             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAssign_empid          ,9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_num              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInst_place_num        ,9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_seq               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEtc_addr              ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_class_cd   ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_ymd           ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_time          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEnd_expect_time       ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szJob_str_dtm           ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szJob_end_dtm           ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_assign_desc   ,500+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTreat_seq             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szProc_sts_cd           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_num               ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_pay              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSend_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_class_nm   ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_duty              ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_ddd           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_exn           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_num           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_ddd            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_exn            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_num            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_cust_nm      ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_soc_num      ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_nm                ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_soc_num           ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReceive_dtm           ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_type_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_nm               ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_nm               ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSoc_num               ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBiz_regi_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_ddd                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_exn                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_num                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_ddd      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_exn      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_num      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_ddd          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_exn          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_num          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szScg_relat_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEmail                 ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFamily_cnt            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_trnd_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk                   ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBuilt_in_yn           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSquare_meter          ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCurr_addr_union       ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBld_floor             ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szHouse_cnt             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_duty_flag         ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPay_calu              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_trans_flag        ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_info_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_cust_num     ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCont_sts_cd           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_read_dtm          ,15 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szMemo                  ,500+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAuto_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBur_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szProd_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPrice_yn              ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_no1               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_no2               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCity                  ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCounty                ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTown                  ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szVillage_ri            ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szVillage               ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBuilding              ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAddr1_m               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAddr1_s               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAccount               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_account          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_time_from         ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_time_end          ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szMtr_chg_yn            ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInfo_use_agree_yn     ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_use_cont_num_yn   ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAdj_alt_amt           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_defray_account_num,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_cust_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_req_info_num      ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_num             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_tel             ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAdj_cause             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDeadline_flag         ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szGmtr_base_day         ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCard_gaspay           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCard_onepay           ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCash_gaspay           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInfo_use_yn           ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szUse_cont_doc_yn       ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPay_method            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDefray_account_num    ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDepositor_nm          ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBank_nm               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDebt_amt              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szLaw_etc_amt           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szLaw_town              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_road_nm           ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_m            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_s            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_union        ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBill_gubun            ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_conn_yn         ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szConn_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_gbn               ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_why               ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szConn_gbn              ,2  +1, DECRYPT );
			ret = 1;
		}
Finally:
		DelSqLite(sql);
		
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Card_GetPrintData
	기  능 : 카드 승인 취소 영수증 프린트
	Param  : 
	Return : 
	========================================================================================*/
	void Card_CancelPirnt(void)
	{
		if( g_IsCardReader() )
		{
			return;
		}

		if(m_bPrintAgain == FALSE)
		{
		  	callBackfunc = NULL;
		  
			m_pList = Card_GetPrintData();
		}
		
		g_Printer_Start(m_pList, (void*)Card_Print_Result);
	}
	
	/*=======================================================================================
	함수명 : Card_GetPrintData
	기  능 : 실제 카드승인 취소 영수증 프린트
	Param  : 
	Return : 
	========================================================================================*/
	void* Card_GetPrintData(void)
	{
		CARRAYLIST list = NULL;
		long ret, idx;
		char LineSpace[]={0x1b,0x20,0x00};
		char szBuf[300];
		char szMsg[300];
		char sztmp[300];
		char szFirstNm[32];
		char szLastNm[32];

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}
		
		// 완료처리전 결제취소 하는 경우도 포함
		if( ( Str_AtoI(stCardinfo.szApproval_amt) > 0 || Str_AtoI(stMw.szCard_gaspay) > 0 ) && stMw.szCard_onepay[0] != '2' ) 
		{
			list->append(list, "--------------------------------");
			list->append(list, "   승인취소 영수증 (고 객 용)   ");
			list->append(list, "--------------------------------");
			list->append(list, "       서울도시가스(주)         ");
			list->append(list, "서울시 강서구 염창동 281\n");
			list->append(list, "사업자 번호: 109-81-31605\n");
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp ,"대표이사 : " );
			Str_Cat(sztmp ,stUserinfo.szScg_repre_nm );
			g_Line_Print(list, sztmp,"","",LEFT,0);	
					
			list->append(list, "전화번호 : 1588-5788            ");
			list->append(list, "--------------------------------");		
			
			Mem_Set( (byte*)szFirstNm, 0x00, sizeof(szFirstNm) );
			Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm));
				
			if( g_nWorkFlag == 610 )
			{
				if( Str_Len(stMw.szTrans_in_cust_nm) < 6 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 4 && Str_Len(stMw.szTrans_in_cust_nm) < 8)
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+4, 2);
					
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 6 && Str_Len(stMw.szTrans_in_cust_nm) < 10 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+6, 2);
		
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 8 && Str_Len(stMw.szTrans_in_cust_nm) < 12 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+8, 2);
		
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
			}
			else
			{
				if( Str_Len(stMw.szCust_nm) < 6 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);
					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
			Str_Cpy(sztmp, "고객번호 : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
			Str_Cpy(sztmp, "계약번호 : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "지번주소 : ");
			Str_Cat(sztmp, stMw.szCity);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szCounty);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szTown);
			if( Str_Len(stMw.szVillage_ri) > 0)
			{
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szVillage_ri);
			}

			if( Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );

					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+31 );

					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{	
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );

					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+32 );

					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			
			if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szVillage);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szBuilding);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szHouse_cnt);

				if( Str_Len(sztmp) > 32 )
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg,"           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{	
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szAddr1_m);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szAddr1_s);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szHouse_cnt);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szEtc_addr);

				if(Str_Len(sztmp) > 32)
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{	
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			
			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "도로명주소 : ");
				Str_Cat(sztmp, stMw.szCity);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szCounty );
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_road_nm);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_addr_m );
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szNew_addr_s);
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			
			list->append(list, "--------------------------------");
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "검침일/납기 : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "일/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "납기");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			
			if (Str_Cmp(stCardinfo.szApproval_amt, stMw.szCard_gaspay) == 0)
			{
				// 다른 금액으로 두 번 결제 한 경우는 이전 금액을 알수 없어서 취소 영수증에 출력하지 않기로 함
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "가스 사용료 : ");
				
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szCard_gaspay );
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat( szBuf, "원" );
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 18 );

				ret = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+18-ret, (byte*)szBuf, ret  );
				
				Str_Cat(sztmp, szMsg);

				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				list->append(list, "--------------------------------");
			}
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "[ 카  드 ]:  ");
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Str_Cat( szBuf, stMw.szCard_gaspay);
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			Str_Cat( szBuf, "원");
			ret = Str_Len(szBuf);
			
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 19 );
			Mem_Cpy((byte*)szMsg+19-ret, (byte*)szBuf, ret  );
			Str_Cat(sztmp, szMsg);
			
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " 카드번호 :  ");
			Mem_Cpy((byte*)szBuf, (byte*)stCardinfo.szCard_num , 4);
			szBuf[4] = '-';
			Mem_Cpy( (byte*)szBuf+5, (byte*)stCardinfo.szCard_num+4,  4 );
			szBuf[9] = '-';
			Str_Cat( szBuf, "****-****");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " 거래구분 :  ");
			idx = 0;
			idx = SearchCD( stCardinfo.szAllotment_mm, CK_CARDMM );
			Str_Cpy(szBuf, CK_CARDMM[idx].Str);
			Str_Cat(sztmp, szBuf );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " 승인번호 :  ");
			Str_Cat(sztmp, stCardinfo.szApproval_num );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, " 취소일자 :  ");
			Str_ItoA(Time_GetDate(), szBuf, 10);
			g_Str_DateType(szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
		}
		
		if( stMw.szCard_onepay[0] == '2' )
		{
			list->append(list, "--------------------------------");
			list->append(list, " 승인취소  연결철거비(고 객 용) ");
			list->append(list, "--------------------------------");
			list->append(list, "        서울도시가스(주)        ");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cat(sztmp, stUserinfo.szcenter_nm );	
			Str_Cat(sztmp, " 고객센터");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "상  호  명  : ");
			Str_Cat(sztmp, stUserinfo.szcom_name );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "사업자번호  : ");
			Mem_Cpy( (byte*)szMsg, (byte*)stUserinfo.szbiz_regi_num, 3 );
			Mem_Cpy( (byte*)szBuf, (byte*)stUserinfo.szbiz_regi_num+3, 2 );
			Str_Cat(sztmp, szMsg );
			Str_Cat(sztmp, "-" );
			Str_Cat(sztmp, szBuf );
			Str_Cat(sztmp, "-" );
			Mem_Cpy( (byte*)szBuf, (byte*)stUserinfo.szbiz_regi_num+5, 5 );
			Str_Cat(sztmp, szBuf );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "대  표  자  : ");
			Str_Cat(sztmp, stUserinfo.szrepre_nm );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "담  당  자  : ");
			Str_Cat(sztmp, stUserinfo.sznm_kor );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "전 화 번 호 : ");
			Str_Cat(sztmp, stUserinfo.sztel );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "검침일/납기 : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "일/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "납기");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
			
			if (Str_Cmp(stCardinfo.szApproval_amt, stMw.szOnce_account) == 0)
			{
				// 다른 금액으로 두 번 결제 한 경우는 이전 금액을 알수 없어서 취소 영수증에 출력하지 않기로 함
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "연결 철거비 : ");
				
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat(szBuf, "원");
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 18 );
				
				ret = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+18-ret, (byte*)szBuf, ret  );
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				list->append(list, "--------------------------------");
			}
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "[ 카  드 ]:  ");
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Str_Cat( szBuf, stMw.szOnce_account);
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			Str_Cat( szBuf, "원");
			ret = Str_Len(szBuf);
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 19 );
			Mem_Cpy((byte*)szMsg+19-ret, (byte*)szBuf, ret  );
			Str_Cat(sztmp, szMsg);
			
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " 카드번호 :  ");
			Mem_Cpy((byte*)szBuf, (byte*)stCardinfo.szCard_num , 4);
			szBuf[4] = '-';
			Mem_Cpy( (byte*)szBuf+5, (byte*)stCardinfo.szCard_num+4,  4 );
			szBuf[9] = '-';
			Str_Cat( szBuf, "****-****");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " 거래구분 :  ");
			idx = 0;
			idx = SearchCD( stCardinfo.szAllotment_mm, CK_CARDMM );
			Str_Cpy(szBuf, CK_CARDMM[idx].Str);
			Str_Cat(sztmp, szBuf );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " 승인번호 :  ");
			Str_Cat(sztmp, stCardinfo.szApproval_num );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "취소일자 :  ");
			Str_ItoA(Time_GetDate(), szBuf, 10);
			g_Str_DateType(szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
		}
		
		list->append(list, "실천하는자율점검정착되는안전문화");
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		Str_Cat(sztmp, "발행일시 : ");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		g_Str_DateType( szMsg, szBuf);
		Str_Cat(sztmp, szMsg);
		Str_Cat(sztmp, " ");

		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		g_Str_TimeType( szBuf , Time_GetTime());
		Str_Chg(szBuf, STRCHG_DEL_NONDIGIT);
		g_Str_TimeForm(szMsg, szBuf);
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "                                ");
		list->append(list, "                                ");
		
		return list;
	}
	
	/*=======================================================================================
	함수명 : Card_Print_Result
	기  능 : 영수증 프린트 확인
	Param  : 
	Return : 
	========================================================================================*/
	long Card_Print_Result(void* p)
	{
		long* pRet = (long*)p;
		long nRet = *pRet;
		
		if( MessageBoxEx (CONFIRM_YESNO, "취소 영수증 발행이 잘되었습니까?") == MB_OK )
		{
			;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "재발행 하시겠습니까?") == MB_OK )
			{
				m_bPrintAgain = TRUE;
				
				//재발행
				Card_CancelPirnt();
				return 0;
			}
		}	
		
		m_bPrintAgain = FALSE;
		
		if (m_pList)
		{
			DelArrayList(m_pList);
			m_pList = NULL;
			g_printerCallBack = NULL;
		}
		
		Rev68602();
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : Snd_Card_Appro_H
	기  능 : 기간계 카드 H 테이블에 취소 데이터 update
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_Card_Appro_H(void)
	{
		char szTmp[100];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);

		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68606, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"     		, stMw.szUse_cont_num   	  );
		JSON_SetValue( g_pjcomm, 'C', "approval_num"			, stCardinfo.szApproval_cancel_num   );
		JSON_SetValue( g_pjcomm, 'C', "terminal_num"			, stCardinfo.szTerminal_num   );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		Mem_Cpy( (byte*)szTmp, (byte*)stCardinfo.szApproval_cancel_date + 8, 6 );
		JSON_SetValue( g_pjcomm, 'C', "approval_cancel_time"	, szTmp	  );

		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR68606;

		HTTP_DownloadData( szUrl, "FR68606_IN",  "FR68606" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : TR68606
	기  능 : callback FR68606
	Param  : 
	Return : 
	========================================================================================*/
	long TR68606(void)
	{
		if(g_Chk_Json(68606) >= 0)
		{
			Rcv_ApproCancelCard();
			
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			REDRAW();
			return 1;
		}
		else
		{	
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
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
		
		char card_receipt_YN[2];

		Mem_Set( (byte*)card_receipt_YN, 0x00, sizeof(card_receipt_YN) );
		// 영수증 발급문의
		if( MessageBoxEx (CONFIRM_YESNO, "취소 영수증을 발행하시겠습니까?")  == MB_OK)
		{						
			Str_Cpy(card_receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(card_receipt_YN, "N");		
		}
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hdata	, 'C', "receiptyn"			, card_receipt_YN);
			JSON_SetValue	(hdata	, 'C', "call"				, "creditVoid");
			JSON_SetValue	(hdata	, 'C', "desc"				, "신용취소");
			
			if( Str_Cmp(stCardinfo.szItem_flag, "10") == 0 )
			{
				JSON_SetValue	(hdata	, 'C', "bussno"				, "1098131605");
			}
			else
			{
				JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
			}

			JSON_SetValue	(hdata	, 'C', "type"				, "");
			JSON_SetValue	(hdata	, 'C', "totalprice"			, stCardinfo.szApproval_amt);
			JSON_SetValue	(hdata	, 'C', "tax"				, "0");
			JSON_SetValue	(hdata	, 'C', "svc"				, "0");
			JSON_SetValue	(hdata	, 'C', "inst"				, stCardinfo.szAllotment_mm);
			JSON_SetValue	(hdata	, 'C', "printdata"			, "");
	
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Cpy( (byte*)szTmp, (byte*)stCardinfo.szApproval_time+2, 6 );
			JSON_SetValue	(hdata	, 'C', "approvaldate"		, szTmp);
			
			JSON_SetValue	(hdata	, 'C', "approvalno"			, stCardinfo.szApproval_num);	
			JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
			JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
			JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
			JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
			JSON_SetValue	(hdata	, 'C', "vsno"				, stCardinfo.szTerminal_num);
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
	
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCardData ) ;

			Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));

			if( Str_Cmp(JSON_GetValue (hItem, "resultcode",  		szType), "null") == 0 )
			{
				Str_ItoA( Time_GetDate(),  stCardinfo.szReq_ymd  , 10);
				Str_Cpy( stCardinfo.szPromise_assign_seq     , stMw.szPromise_assign_seq     );
				Str_Cpy( stCardinfo.szCivil_serv_receive_num , stMw.szCivil_serv_receive_num );
				Str_Cpy( stCardinfo.szTreat_seq              , stMw.szTreat_seq              );
				Str_Cpy( stCardinfo.szUse_cont_num           , stMw.szUse_cont_num           );
				Str_Cpy( stCardinfo.szRecev_seq              , "001"                         );
				
				// ITEM_FLAG 타입
				if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1), "가스" ) == 0 )
				{
					Str_Cpy( stCardinfo.szItem_flag     		 , "10"							 );
				}
				else
				{
					Str_Cpy( stCardinfo.szItem_flag     		 , "20"							 );
				}
				
				Str_Cpy( stCardinfo.szTerminal_num  		 , JSON_GetValue (hItem, "tid",   	szType) );
				Str_Cpy( stCardinfo.szApproval_amt 			 , JSON_GetValue (hItem, "totalamount",    		szType) );
				
				// 할부
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
				i = SearchStr( szTmp, CK_CARDMM );
				if (i > -1)
				{
					Str_Cpy( stCardinfo.szAllotment_mm 			 , CK_CARDMM[i].Code );	
				}
				
				Str_Cpy( stCardinfo.szApproval_amt 			 , JSON_GetValue (hItem, "totalamount",    		szType) );
				Str_Cpy( stCardinfo.szCard_num				 , JSON_GetValue (hItem, "cardno",    		szType) );
				Str_Cpy( stCardinfo.szCard_type_nm			 , JSON_GetValue (hItem, "cardname",    	szType) );
				Str_Cpy( stCardinfo.szValid_ym				 , "0000" 						 );
				Str_Cpy( stCardinfo.szData_flag 			 , "20" );
				Str_Cpy( stCardinfo.szApproval_cancel_num	 ,  JSON_GetValue (hItem, "approvalno",    	szType) );
				Str_Cpy( stCardinfo.szApproval_cancel_date	 ,  JSON_GetValue (hItem, "approvaldate",    szType) );

				Str_Cpy( stCardinfo.szCard_com				 , JSON_GetValue (hItem, "code2",    	szType) );	
				Str_Cpy( stCardinfo.szBuying_comp			 , JSON_GetValue (hItem, "code1",    	szType) );
				Str_Cpy( stCardinfo.szBuying_comp_nm		 , JSON_GetValue (hItem, "purchasename",    	szType) );
				
				Snd_CardHist(3);
			}
			else
			{	
				if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "M016") == 0 )
				{
					Card_Move("C6101_MENU");
					return;	
				}
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp, "[ 승인 취소 실패 ]" );
				Str_Cat( szTmp, "\nERR_CODE : ");
				Str_Cat( szTmp, JSON_GetValue (hItem, "resultcode",  		szType));
				Str_Cat( szTmp, "\nERR_MSG : ");
				Str_Cat( szTmp, JSON_GetValue (hItem, "resultmsg",  		szType));
				
				MessageBoxEx (ERROR_OK, szTmp);
			}
		}
	
		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
	
		g_Close_SubDlg();
	
		ON_DRAW();
		return;
	}
}



