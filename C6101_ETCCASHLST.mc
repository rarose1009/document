/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_ETCCASHLST
	Card Desc : 현금 승인 목록
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_ETCCASHLST
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
		
		DEF_OBJECT_ID ( TTL_TIME )		// 승인시간
		DEF_OBJECT_ID ( TXT_TIME )		// 승인시간
		
		DEF_OBJECT_ID ( TTL_INFO)       // 고객정보
		DEF_OBJECT_ID ( TXT_INFO )		// 고객정보
		
		DEF_OBJECT_ID ( TTL_AMT )		// 금액
		DEF_OBJECT_ID ( TXT_AMT )		// 금액
			
		DEF_OBJECT_ID ( TTL_STATUS )	// 신분구분  
		DEF_OBJECT_ID ( TXT_STATUS )	// 신분구분 
		
		DEF_OBJECT_ID ( TTL_APPRONUM )	// 승인번호
		DEF_OBJECT_ID ( TXT_APPRONUM )	// 승인번호
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트	
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	//	Table정의에 관련된 내용들
	//---------------------------------------------------------------------------------------
	#define		ROW 	    4								// table의 행개수
	#define		COL 	    9								// table의 열개수
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
		{"승인시간"  		  	, CWD*14   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"고객정보"  		  	, CWD*15   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"금액"  		  		, CWD*12   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"RECEIVE_YMD"      	, 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"APPROVAL_DATA"       	, 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"APPROVAL_NUM"  	  	, 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"STATUS_FLAG"  	  	, 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"APPROVAL_AMT"  	  	, 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"APPROVAL_INFO"  	  	, 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
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
	
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void REDRAW(void);
	void SetStyle(void);
	void SetBtnImg(void);
	
	long TR66711(void);
	long Rev66711(void);

	void Run_Mcpay(void);
	void Rcv_CashData(char* szCashData);
	
	void Snd_Cash_Mcpay(void);
	void Snd_Cash_Hist(long flag);
	long TR66806_1(void);
	long TR66806_2(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "기타 현금승인 목록"),
		
		
		DLG_TABLE (GRID_X, GRID_Y-64, ROW, COL, 0, GRID_H-15, 1, GRID_H/2, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT  ( STARTX,     STARTY+560, 300, 64, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON( STARTX+300, STARTY+560, 350, 64, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON( STARTX+650, STARTY+560, 350, 64, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),		
		
		DLG_TEXT( STARTX,     Line(0)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TIME, "승인시간"),
		DLG_TEXT( STARTX+252, Line(0)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TIME, ""),
		DLG_TEXT( STARTX,     Line(1)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INFO, "고객정보"),
		DLG_TEXT( STARTX+252, Line(1)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INFO, ""),
		DLG_TEXT( STARTX,     Line(2)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_STATUS, "구분"),
		DLG_TEXT( STARTX+252, Line(2)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_STATUS, ""),
		DLG_TEXT( STARTX,     Line(3)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_APPRONUM, "승인번호"),
		DLG_TEXT( STARTX+252, Line(3)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPRONUM, ""),
		DLG_TEXT( STARTX,     Line(4)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_AMT, "승인금액"),
		DLG_TEXT( STARTX+252, Line(4)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AMT, ""),
		
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
				
				Rev66711();
				break;
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
					Snd_Cash_Hist(2);
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
		char* szCashData;
		long nRet = 0;
	
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_IC_CARD )
			{
				//시스템콜
				szCashData = (char*)System_GetResult((char*)&nRet);
				
				//결과 저장
				Rcv_CashData(szCashData);
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
		char szbuf[500];
		char sztmp[500];
		long n = 0;
		long amt = 0;
		long vat = 0;
				
		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_nActIndex = index-1;
				
				// 승인시간
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TIME),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
				
				// 고객정보
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INFO),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1));
				
				// 거래자구분
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
				n = 0;
				n = g_SearchCD( sztmp, CASH_GBN );
				Str_Cpy(szbuf, CASH_GBN[n].Str);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_STATUS), szbuf);
				
				// 승인번호
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPRONUM), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
				
				// 승인금액
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AMT),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2));
			
				Mem_Set((byte*)&stCashinfo, 0x00, sizeof(stCashinfo));
				
				// stCashinfo.szAmt
				Str_Cpy( stCashinfo.szAmt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );
				
				// stCashinfo.szAppronum
				Str_Cpy( stCashinfo.szAppronum, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5) );
				
				// stCashinfo.szVat
				amt = Str_AtoI( DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );
				vat = amt*10/110;
				Str_ItoA(vat, stCashinfo.szVat, 10);
			
				// stCashinfo.szApproymd
				Str_Cpy( stCashinfo.szApproymd, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3) );	
				
				// stCashinfo.szStatus_flag
				Str_Cpy( stCashinfo.szStatus_flag, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
				
				// stCashinfo.cust_info
				Str_Cpy( stCashinfo.szCust_info, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8) );
				
				// stCashinfo.szApprodate
				Str_Cpy( stCashinfo.szApprodate, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4) );
				
				ON_DRAW();
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
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TIME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_STATUS), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_AMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_APPRONUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INFO), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STATUS), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPRONUM), EDITALIGN_LEFT|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AMT), EDITALIGN_LEFT|EDITALIGN_MIDDLE);					
			}
		}
	}
	
	
	/*=======================================================================================
	함수명 : Rev66709
	기  능 : 최초 현금 승인 데이터 받아옴
	Param  : 
	Return : 
	========================================================================================*/
	long Rev66711(void)
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
		
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 66711, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR66711;
		
		ret = HTTP_DownloadData(szUrl, "FR66711_IN",  "FR66711" , sndbuf, szbuf );
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR66711
	기  능 : Rev66711 callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66711(void)
	{
		long ret = 0;

		g_Sock_Close();
		
		ret = g_Chk_Json(66711);
		
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
			Mem_Set((byte*)&stCashinfo, 0x00, sizeof(stCashinfo));
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TIME), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INFO), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_STATUS), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPRONUM), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AMT), "" );

			REDRAW();
			
			return -1;
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
		char szbuf2[500];
		char szmsg[500];
		long len = 0;
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		long vat = 0;
		long amt = 0;
		long ltmp = 0;
		
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
			                                        , PARAM4 \
			                                        , PARAM5 \
			                                        , PARAM2 \
			                                        , PARAM8 \
			                                        , PARAM3 \
			                                        , PARAM7 \
			                                        , PARAM5 \
			                                        , PARAM4 \
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
					continue;
				}
				
				idx = 0;
				
				// 1. 승인시간( 년월일 )
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				// 2. 고객정보
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				Mem_Set( (byte*)szmsg, 0x00, sizeof(szmsg) );
				
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				
				Mem_Cpy( (byte*)szmsg, (byte*)sztmp, 6 );
				
				len = Str_Len(sztmp);
				
				for( ltmp =  0 ; ltmp < len-6 ; ltmp++ )
				{
					Str_Cat(szmsg, "*");
				}
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, szmsg );
				
				// 3. 금액(원)			
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				Str_Cpy( szbuf, sztmp );	
				Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
				Str_Chg( szbuf, STRCHG_INS_COMMA );
				Str_Cat( szbuf,"원" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, szbuf );
				
				// 4. 송신 날짜
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				// 5. 승인시간
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
				// 6. 승인번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				
				// 7. 신분구분
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
				
				// 8. 금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
				
				// 9. 고객정보
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 300, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
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
			
			// 승인시간
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TIME),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			
			// 고객정보
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INFO),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1));
			
			// 거래자구분
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
			n = 0;
			n = g_SearchCD( sztmp, CASH_GBN );
			Str_Cpy(szbuf, CASH_GBN[n].Str);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_STATUS), szbuf);
			
			// 승인번호
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPRONUM), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			
			// 승인금액
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AMT),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2));
			
			Mem_Set((byte*)&stCashinfo, 0x00, sizeof(stCashinfo));
			
			// stCashinfo.szAmt
			Str_Cpy( stCashinfo.szAmt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );
			
			// stCashinfo.szAppronum
			Str_Cpy( stCashinfo.szAppronum, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5) );
			
			// stCashinfo.szVat
			amt = Str_AtoI( DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );
			vat = amt*10/110;
			Str_ItoA(vat, stCashinfo.szVat, 10);
		
			// stCashinfo.szApproymd
			Str_Cpy( stCashinfo.szApproymd, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3) );	
			
			// stCashinfo.szStatus_flag
			Str_Cpy( stCashinfo.szStatus_flag, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
			
			// stCashinfo.cust_info
			Str_Cpy( stCashinfo.szCust_info, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8) );
			
			// stCashinfo.szApprodate
			Str_Cpy( stCashinfo.szApprodate, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4) );
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : Snd_Cash_Hist
	기  능 : 현금영수증 mcpay 이력저장
	Param  : 2 = 취소시도, 3 = 취소완료
	Return : 
	========================================================================================*/
	void Snd_Cash_Hist(long flag)
	{
		char sztmp[128];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long amt = 0;
		long vat = 0;
		long i;
				
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66806, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd"          , stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq" , "999999999" );
		
		if(flag == 2)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "3" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , stCashinfo.szAppronum );
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", "" );
		}
		else if(flag == 3)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "4" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , stCashinfo.szAppro_cancel_num );
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stCashinfo.szAppro_cancel_date );
			JSON_SetValue( g_pjcomm, 'C', "appro_ori_num"      , stCashinfo.szAppronum );
			JSON_SetValue( g_pjcomm, 'C', "appro_ori_date"      , stCashinfo.szApprodate );
			
			JSON_SetValue( g_pjcomm, 'C', "resp_cd"            , stCashinfo.szResp_cd );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num"        , "" );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"             , "" );
		
		Mem_Set( (byte*) stCashinfo.szTreat_pda1, 0x00, sizeof(stCashinfo.szTreat_pda1)  );
		Mem_Set( (byte*) stCashinfo.szTreat_pda2, 0x00, sizeof(stCashinfo.szTreat_pda2)  );
		Mem_Set( (byte*) stCashinfo.szTreat_pda3, 0x00, sizeof(stCashinfo.szTreat_pda3)  );
		
		fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda1, 1, Str_Len(stUserinfo.szpda_ip) );
		fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda2, 2, Str_Len(stUserinfo.szpda_ip) );
		fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda3, 3, Str_Len(stUserinfo.szpda_ip) );
		
		JSON_SetValue( g_pjcomm, 'C', "treat_pda1"        	  , stCashinfo.szTreat_pda1 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda2"        	  , stCashinfo.szTreat_pda2 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda3"        	  , stCashinfo.szTreat_pda3 );
		
		JSON_SetValue( g_pjcomm, 'C', "status_flag"       	  , stCashinfo.szStatus_flag);
		JSON_SetValue( g_pjcomm, 'C', "cust_info"         	  , stCashinfo.szCust_info  );
		JSON_SetValue( g_pjcomm, 'C', "amt"               	  , stCashinfo.szAmt        );
		JSON_SetValue( g_pjcomm, 'C', "appro_sts"         	  , "2" );
		JSON_SetValue( g_pjcomm, 'C', "cert_cd"           	  , stUserinfo.szcard_term_id2 );
		
		JSON_SetValue( g_pjcomm, 'C', "receive_ymd"           , stCashinfo.szApproymd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		// 취소 전
		if(flag == 2)
		{
			callBackfunc = TR66806_1;
		}
		// 결과
		else
		{
			callBackfunc = TR66806_2;
		}
		
		ret = HTTP_DownloadData(szUrl, "FR66806_IN",  "FR66806" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : TR66806_1
	기  능 : 취소 전 이력 저장 후 callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_1(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(66806) >= 0)
		{
			Run_Mcpay();
			return 1;
		}
		else
		{
			Run_Mcpay();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : TR66806_2
	기  능 : 승인 후, 취소 후 이력 저장 후 callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_2(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(66806) >= 0)
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
	기  능 : Mcpay Run
	Param  : 
	Return : 
	========================================================================================*/
	void Run_Mcpay(void)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;
		char sztmp[50];
		char szDate[50];
		char receipt_YN[2];
		
		Mem_Set( (byte*)receipt_YN, 0x00, sizeof(receipt_YN) );
		
		// 영수증 발급문의
		if( MessageBoxEx (CONFIRM_YESNO, "간이영수증을\n발행하시겠습니까?")  == MB_OK)
		{						
			Str_Cpy(receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(receipt_YN, "N");		
		}
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*) szDate, 0x00, sizeof(szDate) );
		Str_Cpy( sztmp, stCashinfo.szApproymd );
		Str_Cpy(szDate, sztmp+2);				
		
		PRINT("#### bussno #### : %s",stUserinfo.szbiz_regi_num,0,0);
		PRINT("#### totalprice #### : %s",stCashinfo.szAmt,0,0);
		PRINT("#### tax #### : %s",stCashinfo.szVat,0,0);
		PRINT("#### cashtradetype #### : %s",stCashinfo.szStatus_flag,0,0);
		PRINT("#### cashtradeinfo #### : %s",stCashinfo.szCust_info,0,0);
		PRINT("#### approvaldate #### : %s",szDate,0,0);
		PRINT("#### approvalno #### : %s",stCashinfo.szAppronum,0,0);
		PRINT("#### vsno #### : %s",stUserinfo.szcard_term_id2,0,0);
		
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			
			if(hdata == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hdata	, 'C', "call"				, "cashVoid");
			JSON_SetValue	(hdata	, 'C', "desc"				, "현금취소");
			JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
			JSON_SetValue	(hdata	, 'C', "type"				, "");
			JSON_SetValue	(hdata	, 'C', "receiptyn"			, receipt_YN);
			JSON_SetValue	(hdata	, 'C', "totalprice"			, stCashinfo.szAmt);
			JSON_SetValue	(hdata	, 'C', "tax"				, stCashinfo.szVat);
			JSON_SetValue	(hdata	, 'C', "svc"				, "0");
			JSON_SetValue	(hdata	, 'C', "inst"				, "0");
			JSON_SetValue	(hdata	, 'C', "printdata"			, "");
			
			JSON_SetValue	(hdata	, 'C', "approvaldate"		, szDate);		
			JSON_SetValue	(hdata	, 'C', "approvalno"			, stCashinfo.szAppronum);	
			JSON_SetValue	(hdata	, 'C', "cashtradetype"		, stCashinfo.szStatus_flag);
			JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, stCashinfo.szCust_info);
			JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "1");
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
		
		//Rcv_CashData_test();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Rcv_CashData
	기  능 : Rcv Mcpay Result Data 
	Param  : szCashData : OnTask 함수를 통해 받은 결과 데이터
	Return : 
	========================================================================================*/
	void Rcv_CashData(char* szCashData)
	{
		char szTmp[300];
		char szType[2] = {0,0};
		handle hItem = NULL;
		handle hData = NULL;
		
		long hist_rslt = 0;
		
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCashData );
			
			if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "null") == 0 )
			{
				Mem_Set( (byte*)stCashinfo.szResp_cd, 0x00, sizeof(stCashinfo.szResp_cd) );
				Str_Cpy( stCashinfo.szResp_cd, "0000" );
				
			    Mem_Set( (byte*)stCashinfo.szAppro_cancel_num, 0x00, sizeof(stCashinfo.szAppro_cancel_num) );
				Str_Cpy( stCashinfo.szAppro_cancel_num, JSON_GetValue(hItem, "approvalno", szType) );
				
				Mem_Set( (byte*)stCashinfo.szAppro_cancel_date, 0x00, sizeof(stCashinfo.szAppro_cancel_date) );
				Str_Cpy( stCashinfo.szAppro_cancel_date, JSON_GetValue (hItem, "approvaldate", szType) );
				
				hist_rslt = 1;
			}
			else
			{	
				hist_rslt = 0;
				Card_Move("C6101_PayMenu");
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
			Snd_Cash_Hist(3);
		}
		else
		{
			Card_Move("C6101_PayMenu");
		}
		
		return;
	}
	
	void Rcv_CashData_test(void)
	{
		char szTmp[300];
		
		// 취소인경우
		Mem_Set( (byte*)stCashinfo.szResp_cd, 0x00, sizeof(stCashinfo.szResp_cd) );
		Str_Cpy( stCashinfo.szResp_cd, "0000" );
		
	    Mem_Set( (byte*)stMw.szAppro_num, 0x00, sizeof(stMw.szAppro_num) );
	    Mem_Set( (byte*)stMw.szAppro_tel, 0x00, sizeof(stMw.szAppro_tel) );
	    Mem_Set( (byte*)stMw.szAppro_gubun, 0x00, sizeof(stMw.szAppro_gubun) );
	    Mem_Set( (byte*)stMw.szAppro_status_flag, 0x00, sizeof(stMw.szAppro_status_flag) );
	    
	    Mem_Set( (byte*)stCashinfo.szAppronum, 0x00, sizeof(stCashinfo.szAppronum) );
		Str_Cpy( stCashinfo.szAppronum, "99999" );

	    Snd_Cash_Hist(3);
	}
	
	void fsgetitem(char* szSource, char* szTarget, int id, int len )
	{
		int i;
		int idx;
		int ids;
	
		idx =0;
		ids =1;
		
		for(i=0; i<len; i++)
		{
			if(szSource[i] == '-')
			{
				if(ids == id )
				{
					szTarget[idx] = 0x00;
					break;
				}
				
				idx = 0;
				ids++;
				continue;
			}
			
			if(ids == id )
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}
}



