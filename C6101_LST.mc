/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_LST
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "SQLdb.h"
	
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

		DEF_BUTTON_ID ( BID_ADD )			//추가받기
		DEF_BUTTON_ID ( BID_CHG )			//작업변경
		DEF_BUTTON_ID ( BID_ADDR )			//주소
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//퀵뷰 호출 & 페이지표시
		
		DEF_BUTTON_ID ( BID_CMPLT )			//
		DEF_BUTTON_ID ( BID_INCMPLT )		//
		DEF_BUTTON_ID ( BID_SMS )			//
			
		DEF_BUTTON_ID ( BID_SORTGUBUN )			//
		DEF_BUTTON_ID ( BID_SORTADDR )			//
		DEF_BUTTON_ID ( BID_SORTTIME )			//
		DEF_BUTTON_ID ( BID_SORTWRK )			//

	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( ICON_TITLE )	//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )		//타이틀
		DEF_OBJECT_ID ( TXT_CMPLT )		//타이틀
		DEF_OBJECT_ID ( TXT_INCMPLT )	//타이틀
		DEF_OBJECT_ID ( TXT_ADDR )		//타이틀
		DEF_OBJECT_ID ( TTL_SMS )		//타이틀
		
		DEF_OBJECT_ID ( CMB_CMPLT )		//전체
		DEF_OBJECT_ID ( CMB_SMS = CMB_CMPLT+3)
		DEF_OBJECT_ID ( ID_TBLLIST = CMB_SMS+3)	// 테이블 리스트
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    8					// table의 행개수
	#define		COL 	    6					// table의 열개수
	#define		GRID_H		(CHT+21)			// table 행 높이
	#define		GRID_H_P	(CHT+48)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+225  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    //table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (STARTY+780+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"구분", CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"주소", CWD*20+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"시간", CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"처리", CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"민원번호", 0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소2", 0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	#define INIT_MAIN	1
	
	#define RcvAssignseq	"RcvAssignseq.txt"
	#define RcvAssignseq_Len	10

	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	long m_nWhere = 0;
	char m_szCobstr[10];
	char m_szTmp[1000];
	long m_mincnt = 0;
	long m_nTotal = 5;
	long m_nCurr = 0;
	
	bool REDRAW(void);
	void SetBtnImg(void);
	char* make_sql(char*szsql, long nsort, long nwhere );

	void Snd_SMS(void);
	long Rcv_Sms(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	
	void RCV_DAYMIN(void);
	
	long Rev68402(long flag);
	long TR68402(void);
	long Save_Min(void);
	bool SetJsonToDB( DBInfo* info, SQLITE sql, handle json, long nCnt );
	bool Save_assignseq( handle json, long nCnt );
	
	long SND68404(void);
	long TR68404(void);
	long Add_Item(handle pj);
	void Set_grdtitle(void);
	void Update_sort(void);
	
	void Grid_QuickList(void);
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
	
	// 메인 다이얼로그(리스트)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "작업리스트"),
		
		//DLG_TEXT(          STARTX, STARTY+65, CWD*8, SYH+3, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX, STARTY+65, CWD*8, SYH+3, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, m_szCnt_page),
		
		DLG_BUTTON(  STARTX+CWD*8, STARTY+65, CWD*5, SYH+3, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CMPLT , "완료"),
		DLG_TEXT(   STARTX+CWD*13, STARTY+65, CWD*5, SYH+3, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CMPLT, ""),
		DLG_BUTTON( STARTX+CWD*18, STARTY+65, CWD*5, SYH+3, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INCMPLT, "미완"),
		DLG_TEXT(   STARTX+CWD*23, STARTY+65, CWD*5, SYH+3, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INCMPLT, ""),
		DLG_COMBO ( STARTX+CWD*28, STARTY+65, CWD*11+23, 290, 100, SYH+3, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CMPLT, 10),
		DLG_TEXT(   STARTX, STARTY+SYH+67, CWD*39+23, 105, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),
		
		DLG_BUTTON(    STARTX,        GRID_ENDY, 165,    SYH+6, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+165,        GRID_ENDY, 165,    SYH+6, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_TEXT(   STARTX+330,       GRID_ENDY, CWD*5,  SYH+6, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SMS, "SMS"),
		DLG_COMBO ( STARTX+330+CWD*5, GRID_ENDY, CWD*14-20, 290, 100, SYH+6, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SMS, 10),
		DLG_BUTTON( STARTX+310+CWD*19,GRID_ENDY, 216,    SYH+6, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "발송"),
				
		DLG_BUTTON( STARTX,     Line(1), 333, SYH+9, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON( STARTX+333, Line(1), 333, SYH+9, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADD, "추가받기"),
		DLG_BUTTON( STARTX+666, Line(1), 334, SYH+9, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG, "작업변경"),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		DLG_BUTTON( STARTX,           GRID_Y, CWD*7,  GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTGUBUN, "구분"),
		DLG_BUTTON( STARTX+CWD*7,     GRID_Y, CWD*20+23, GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTADDR, "주 소"),
		DLG_BUTTON( STARTX+CWD*27+23, GRID_Y, CWD*6, GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTTIME, "시간"),
		DLG_BUTTON( STARTX+CWD*33+23, GRID_Y, CWD*6, GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTWRK, "처리"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "작업리스트"),

		DLG_TEXT(          STARTX, STARTY+75, CWD*8, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		
		DLG_BUTTON(  STARTX+CWD*8, STARTY+75, CWD*5, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INCMPLT, "완료"),
		DLG_TEXT(   STARTX+CWD*13, STARTY+75, CWD*5, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CMPLT, ""),
		DLG_BUTTON( STARTX+CWD*18, STARTY+75, CWD*5, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CMPLT, "미완"),
		DLG_TEXT(   STARTX+CWD*23, STARTY+75, CWD*5, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INCMPLT, ""),
		DLG_COMBO ( STARTX+CWD*28, STARTY+75, CWD*11, 290, 100, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CMPLT, 10),
		DLG_TEXT(   STARTX,        STARTY+SYH+75, CWD*39, 95, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),
		
		DLG_BUTTON(    STARTX,        GRID_ENDY+5, 150,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+160,        GRID_ENDY+5, 150,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_TEXT(   STARTX+310,       GRID_ENDY+5, CWD*5,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_SMS, "SMS"),
		DLG_COMBO ( STARTX+310+CWD*5, GRID_ENDY+5, CWD*14, 290, 100, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SMS, 10),
		DLG_BUTTON( STARTX+310+CWD*19,GRID_ENDY+5, 200,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "발송"),
		
		DLG_BUTTON( STARTX,     Line(1), 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON( STARTX+350, Line(1), 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADD, "추가받기"),
		DLG_BUTTON( STARTX+730, Line(1), 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG, "작업변경"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		DLG_BUTTON( STARTX,       GRID_Y, CWD*6,  GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTGUBUN, "구분"),
		DLG_BUTTON( STARTX+CWD*6, GRID_Y, CWD*21, GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTADDR, "주 소"),
		DLG_BUTTON( STARTX+CWD*27, GRID_Y, CWD*6, GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTTIME, "시간"),
		DLG_BUTTON( STARTX+CWD*33, GRID_Y, CWD*6, GRID_H, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SORTWRK, "처리"),
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
						g_nActIndex = g_nActRow;
						m_lpage = g_nGrpIndex;
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						g_nActIndex = g_nActRow;
						m_lpage = g_nGrpIndex;	
						break;
				}
				SetBtnImg();
				Set_grdtitle();
				REDRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
	void* h;
	char sztmp[10];
	char szSql[100];
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		if( m_bFirst == INIT_MAIN )
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
		EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_ADDR), TRUE , 0, 0);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CMPLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CMPLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMPLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INCMPLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SMS), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SMS), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		Mem_Set( (byte*)m_szCobstr, 0x00, sizeof(m_szCobstr) );
		if( Str_Len(g_szCmb_Str) < 2 )
		{
			Str_Cpy(m_szCobstr, "전체");
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CMPLT), m_szCobstr);

			g_nActIndex = 0;
			m_lpage = 0;
		}
		else
		{
			Str_Cpy(m_szCobstr, g_szCmb_Str);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CMPLT), m_szCobstr);
			
			if( Str_Cmp(m_szCobstr, "전체") == 0  )
			{
				m_nWhere = 0;
			}
			else if( Str_Cmp(m_szCobstr, "미완료") == 0  )
			{
				m_nWhere = 1;
			}
			else if( Str_Cmp(m_szCobstr, "완료") == 0  )
			{
				m_nWhere = 2;
			}
		}

		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CMPLT+2), "전체", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CMPLT+2), "미완료", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CMPLT+2), "완료", 0, ICON_NONE);
		
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SMS+2), "10분", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SMS+2), "20분", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SMS+2), "30분", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SMS+2), "40분", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SMS+2), "50분", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SMS+2), "60분", 0, ICON_NONE);
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SMS), "10분");
	
				
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN where SEND_YN <> 'D' or SEND_YN is null ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		m_lTotpage =  Str_AtoI(sztmp);
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN where SEND_YN = 'S' or SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CMPLT),  sztmp);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is null ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INCMPLT),  sztmp);
		
	}
	
//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i;
		long lRowid = 0;
		char szWhere[128];
		char szSort[128];
		char szSql[500];
		
		i = lParam;
		//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			//make_sql(m_szTmp, g_lindex, m_nWhere );	
			Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
			if( m_nWhere == 0) //전체
			{
				Str_Cpy( szWhere , "where SEND_YN <> 'D' or SEND_YN is null ");
			}
			else if( m_nWhere == 1) //미완료
			{
				Str_Cpy( szWhere , "where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is null " );
			}
			else if( m_nWhere == 2) //완료
			{
				Str_Cpy( szWhere , "where SEND_YN = 'S' or SEND_YN = 'Y' " );
			}
			
			//PAY_CALU 사용하지 않는 필드를 추가받기용으로 정렬용으로 이용한다.
			Mem_Set( (byte*)szSort, 0x00, sizeof(szSort) );
			if( g_lindex == 0)
			{
				Str_Cpy( szSort , "ORDER BY PAY_CALU, PROMISE_TIME");
			}
			else if( g_lindex == 1)
			{
				Str_Cpy( szSort , "ORDER BY PDA_DUTY_FLAG, PROMISE_TIME");
			}
			else if( g_lindex == 2)
			{
				Str_Cpy( szSort , "ORDER BY PDA_DUTY_FLAG desc, PROMISE_TIME" );
			}
			else if( g_lindex == 3)
			{
				Str_Cpy( szSort , "ORDER BY CURR_ADDR_UNION" );	
			}
			else if( g_lindex == 4)
			{
				Str_Cpy( szSort , "ORDER BY CURR_ADDR_UNION desc" );	
			}
			else if( g_lindex == 5)
			{
				Str_Cpy( szSort , "ORDER BY PROMISE_TIME" );		
			}
			else if( g_lindex == 6)
			{
				Str_Cpy( szSort , "ORDER BY PROMISE_TIME desc" );	
			}
			else if( g_lindex == 7)
			{
				Str_Cpy( szSort , "ORDER BY SEND_YN, PAY_CALU, PROMISE_TIME" );		
			}
			else if( g_lindex == 8)
			{
				Str_Cpy( szSort , "ORDER BY SEND_YN desc, PAY_CALU, PROMISE_TIME" );	
			}

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Str_Cpy(szSql, "SELECT ROWID FROM C6101_PROMISE_ASSIGN ");
			Str_Cat(szSql, szWhere);
			Str_Cat(szSql, szSort);
			g_Sql_SaveSeq( szSql, SREACH_FILE);


/*
			Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
			Str_Cpy(g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, g_nActIndex, 4) );
			g_lDataflag = 0;
			Mem_Set( (byte*)g_history_yn, 0x00, sizeof(g_history_yn) );
			g_history_yn[0] = 'N'; // 상담이력 존재여부
			
			g_nActRow= g_nActIndex;
			g_nGrpIndex = m_lpage;

*/


			lRowid = g_SREACHFILE_GetSeq(SREACH_FILE, lParam);
			g_nActRow= (lParam % ROW);
			g_nGrpIndex = lParam / ROW;
			//PRINT(">>>>>>> %d , %d , %d",lRowid,g_nActRow,g_nGrpIndex);

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
			SPRINT( szSql, "SELECT PROMISE_ASSIGN_SEQ FROM C6101_PROMISE_ASSIGN WHERE ROWID = '%d'", lRowid, 0, 0 );
			g_Sql_RetStr(szSql, 13, g_szCHK_EXEC_NUM );
			//PRINT(">>>>>>>>g_szCHK_EXEC_NUM : %s",g_szCHK_EXEC_NUM,0,0);

			g_lDataflag = 0;
			Mem_Set( (byte*)g_history_yn, 0x00, sizeof(g_history_yn) );
			g_history_yn[0] = 'N'; // 상담이력 존재여부
			
			Mem_Set((byte*)g_szSERV_ADD_YN, 0x00, sizeof(g_szSERV_ADD_YN));	
			g_szSERV_ADD_YN[0] = 'N';
			
			Card_Move("C6101_WINFO");
		}
		
		return;
	}

	
//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
	char sztmp[10];
	long index;
	
		if( m_bFirst == INIT_MAIN )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy( sztmp , EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CMPLT) ) );
			if( Str_Cmp(m_szCobstr, sztmp) != 0  )
			{
				if( Str_Cmp(sztmp, "전체") == 0  )
				{
					m_nWhere = 0;
				}
				else if( Str_Cmp(sztmp, "미완료") == 0  )
				{
					m_nWhere = 1;
				}
				else if( Str_Cmp(sztmp, "완료") == 0  )
				{
					m_nWhere = 2;
				}
				g_nActIndex = 0;
				m_lpage = 0;
				REDRAW();
				ON_DRAW();
				Str_Cpy(m_szCobstr, sztmp);
				return;
			}
			
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				if(g_nActIndex == index-1	 )
				{
					Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
					Str_Cpy(g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, g_nActIndex, 4) );
					g_lDataflag = 0;
					Mem_Set( (byte*)g_history_yn, 0x00, sizeof(g_history_yn) );
					g_history_yn[0] = 'N'; // 상담이력 존재여부
					Mem_Set( (byte*)g_szCmb_Str, 0x00, sizeof(g_szCmb_Str) );
					Str_Cpy(g_szCmb_Str, m_szCobstr);
					
					g_nActRow= g_nActIndex;
					g_nGrpIndex = m_lpage;
					
					Mem_Set((byte*)g_szSERV_ADD_YN, 0x00, sizeof(g_szSERV_ADD_YN));	
					g_szSERV_ADD_YN[0] = 'N';
			
					Card_Move("C6101_WINFO");
				}
				
				g_nActIndex = index-1;
				Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
				Str_Cpy(g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, g_nActIndex, 4) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), DlgTbl_GetStr( ID_TBLLIST, g_nActIndex, 5)  );
				
				if(  Str_Cmp( DlgTbl_GetStr( ID_TBLLIST, g_nActIndex, 3), "완" ) == 0 )
				{
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_SMS), FALSE);
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
				}
				else
				{				
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_SMS), TRUE);
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
				}
				ON_DRAW();
			}
		}
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_QUICK_ADDR:
				Grid_QuickList();
				break;
			case BID_ADD:
				RCV_DAYMIN();
				break;
				
			case BID_CHG:
				//2017-05-03 Sanghyun Lee
				//작업변경 리스트 화면으로 이동했다가 돌아올 때 row 저장
				g_Sql_DirectExecute("UPDATE C6101_PROMISE_ASSIGN SET CHK = 'N' ");
				
				Mem_Set( (byte*)g_szCmb_Str, 0x00, sizeof(g_szCmb_Str) );
				Str_Cpy(g_szCmb_Str, m_szCobstr);
				
				g_nActRow= g_nActIndex;
				g_nGrpIndex = m_lpage;
				Card_Move("C6101_CHGLST");
				break;
			case BID_SMS:
				Snd_SMS();
				break;
			case BID_CMPLT:
				break;
			case BID_INCMPLT:
				break;

			case BID_SORTGUBUN:
				if(g_lindex == 0)
				{
					g_lindex = 1;
				}
				else
				{
					if(g_lindex == 1)
						g_lindex = 2 ;
					else if(g_lindex == 2)
						g_lindex = 0 ;
					else
						g_lindex = 1 ;
				}
				m_lpage= 0;
				g_nActIndex = 0;

				Set_grdtitle();
				REDRAW();
				break;
			case BID_SORTADDR:
				if(g_lindex == 0)
				{
					g_lindex = 3;
				}
				else
				{
					if(g_lindex == 3)
						g_lindex = 4 ;
					else if(g_lindex == 4)
						g_lindex = 0 ;
					else
						g_lindex = 3 ;
				}
				m_lpage= 0;
				g_nActIndex = 0;

				Set_grdtitle();
				REDRAW();
				break;
			case BID_SORTTIME:
				if(g_lindex == 0)
				{
					g_lindex = 5;
				}
				else
				{
					if(g_lindex == 5)
						g_lindex = 6 ;
					else if(g_lindex == 6)
						g_lindex = 0 ;
					else
						g_lindex = 5 ;
				}
				
				m_lpage= 0;
				g_nActIndex = 0;

				Set_grdtitle();
				REDRAW();
				break;
			case BID_SORTWRK:
				if(g_lindex == 0)
				{
					g_lindex = 7;
				}
				else
				{
					if(g_lindex == 7)
						g_lindex = 8 ;
					else if(g_lindex == 8)
						g_lindex = 0 ;
					else
						g_lindex = 7 ;
				}
				m_lpage= 0;
				g_nActIndex = 0;

				Set_grdtitle();			
				REDRAW();
				break;
		
			case BID_ADDR:
				if( g_nAddrFlag == 0 )
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				Set_grdtitle();
				g_nActIndex = 0;

				REDRAW();
				break;
				
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
					m_lpage = 0;
				g_nActIndex = 0;
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
					m_lpage = m_lTotpage-1;
				g_nActIndex = 0;
				REDRAW();
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
	
	void Set_grdtitle(void)
	{
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지 번");
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
		}

		switch(g_lindex)
		{
			case 0:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "시간");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "처리");
				break;
			case 1:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "▲구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "시간");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "처리");
				break;
			case 2:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "▼구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "시간");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "처리");
				break;
			case 3:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "▲주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "시간");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "처리");
				break;
			case 4:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "▼주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "시간");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "처리");
				break;
			case 5:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "▲시");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "처리");
				break;
			case 6:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "▼시");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "처리");
				break;
			case 7:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "시간");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "▲처");
				break;
			case 8:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTGUBUN), "구분");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTADDR), "주 소");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTTIME), "시간");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SORTWRK), "▼처");
				break;
		}	
	}
	
//------------------------------------------------------------------------------------------
	bool REDRAW(void)
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	char sztmp[500];
	char szbuf[101];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
		
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		make_sql(m_szTmp, g_lindex, m_nWhere );	

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage,0);
		
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql,m_szTmp );
		
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
				
				k = i + 1;
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
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				//idx = 0;
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);

				if( Str_Len(sztmp) > 6)
				{
					Mem_Cpy( (byte*)szbuf, (byte*)sztmp , 4);
					szbuf[4] = '\n';
					Mem_Cpy( (byte*)szbuf+5, (byte*)sztmp+4 , Str_Len(sztmp));
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, szbuf );
					
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				Mem_Cpy( (byte*)szbuf, (byte*)sztmp , 2);
				szbuf[2] = ':';
				Mem_Cpy( (byte*)szbuf+3, (byte*)sztmp+2 , 2);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, szbuf );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 1, DECRYPT);
				if(  Str_Len(sztmp) > 0 )
				{					
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 0 , RED);
				}
				else
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 0 , BLACK);
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 1, DECRYPT);
				if( Str_Cmp(sztmp, "060103") == 0 )
				{					
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 1 , DARKGREEN);
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 2 , DARKGREEN);
				}
				else
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 1 , BLACK);
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 2 , BLACK);
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 1, DECRYPT);
				if(sztmp[0] == 'S' ||  sztmp[0] == 'Y' )
				{					
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 3 , RED);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "완" );
				}
				else
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 3 , BLACK);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "미" );
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 5, 'U', (long*)sztmp, 4, DECRYPT);

				if( g_nAddrFlag == 0)
				{					
					if( Str_AtoI(sztmp) > 0 )
					{
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 6, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 7, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, "-");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 8, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 9, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					else
					{
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 10, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, "-");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 11, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 8, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 9, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				}
				else
				{
					if( Str_AtoI(sztmp) > 0 )
					{
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 6, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 7, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, "-");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 8, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					else
					{
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 13, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, "-");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 14, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 8, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 9, 'U', (long*)szbuf, 50, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				}
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 15, 'U', (long*)szbuf, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, szbuf );
				
				if( g_nAddrFlag == 0)
				{
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 16, 'U', (long*)szbuf, 100, DECRYPT);
				}
				else
				{
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 17, 'U', (long*)szbuf, 100, DECRYPT);
				}
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, szbuf );				
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		
		if( g_nActIndex == -1 )
		{
			g_nActIndex =0;
		}

		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , g_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, g_nActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
			Str_Cpy(g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, g_nActIndex, 4) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), DlgTbl_GetStr( ID_TBLLIST, g_nActIndex, 5)  );
//PRINT(">>>>>>>>>>>> g_szCHK_EXEC_NUM : %s",g_szCHK_EXEC_NUM,0,0);
		}
		else
		{
			g_nActIndex= 0;
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR), ""  );
		}
		ON_DRAW();
		
		
		if( g_nWorkChkFlag != 0)
		{
			Rev68402(2);//추가받기
			g_nWorkChkFlag = 0;
		}	
		return TRUE;
	}
	
	char* make_sql(char*szsql, long nsort, long nwhere )
	{
	char sql[1000];
	char sql2[1000];
	char sort[100];
	char where[100];
	char sztmp[50];
		
		Mem_Set( (byte*)sql, 0x00, sizeof(sql) );
		Mem_Set( (byte*)sql2, 0x00, sizeof(sql2) );
		Mem_Set( (byte*)sort, 0x00, sizeof(sort) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)where, 0x00, sizeof(where) );
		
		Str_Cpy(sql , " SELECT \
PDA_DUTY, PROMISE_TIME, SEND_YN, CIVIL_SERV_CLASS_CD, PROMISE_ASSIGN_DESC \
, Length(ifnull(Trim(VILLAGE),'') )+Length( ifnull(Trim(BUILDING),'') ) ,Trim(VILLAGE),Trim(BUILDING) \
, HOUSE_CNT, ETC_ADDR, ADDR1_M, ADDR1_S \
,NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S, PROMISE_ASSIGN_SEQ, CURR_ADDR_UNION, NEW_ADDR_UNION \
FROM C6101_PROMISE_ASSIGN  ");
		
		if( nwhere == 0) //전체
		{
			Str_Cpy( where , "where SEND_YN <> 'D' or SEND_YN is null");
		}
		else if( nwhere == 1) //미완료
		{
			Str_Cpy( where , "where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is null" );
		}
		else if( nwhere == 2) //완료
		{
			Str_Cpy( where , "where SEND_YN = 'S' or SEND_YN = 'Y' " );
		}
		
		//PAY_CALU 사용하지 않는 필드를 추가받기용으로 정렬용으로 이용한다.
		if( nsort == 0)
		{
			Str_Cpy( sort , "ORDER BY PAY_CALU, PROMISE_TIME LIMIT ?, ?" );
		}
		else if( nsort == 1)
		{
			Str_Cpy( sort , "ORDER BY PDA_DUTY_FLAG, PROMISE_TIME LIMIT ?, ?" );
		}
		else if( nsort == 2)
		{
			Str_Cpy( sort , "ORDER BY PDA_DUTY_FLAG desc, PROMISE_TIME LIMIT ?, ?" );
		}
		else if( nsort == 3)
		{
			Str_Cpy( sort , "ORDER BY CURR_ADDR_UNION  LIMIT ?, ?" );	
		}
		else if( nsort == 4)
		{
			Str_Cpy( sort , "ORDER BY CURR_ADDR_UNION desc LIMIT ?, ?" );	
		}
		else if( nsort == 5)
		{
			Str_Cpy( sort , "ORDER BY PROMISE_TIME  LIMIT ?, ?" );		
		}
		else if( nsort == 6)
		{
			Str_Cpy( sort , "ORDER BY PROMISE_TIME desc LIMIT ?, ?" );	
		}
		else if( nsort == 7)
		{
			Str_Cpy( sort , "ORDER BY SEND_YN, PAY_CALU, PROMISE_TIME LIMIT ?, ?" );		
		}
		else if( nsort == 8)
		{
			Str_Cpy( sort , "ORDER BY SEND_YN desc, PAY_CALU, PROMISE_TIME LIMIT ?, ?" );	
		}
		
		SPRINT( sql2, " %s %s ", " SELECT count(*) FROM C6101_PROMISE_ASSIGN  ", where, 0 );
		g_Sql_RetStr(sql2, 4, sztmp );
		m_lTotpage =  Str_AtoI(sztmp);
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT( szsql, "%s %s %s", sql, where, sort );
		return szsql;
	}
	
	
	void Snd_SMS(void)
	{
	char sztmp[128];
	char szUrl[200];
	char szbuf[128];
	char szMsg[351];
	char szUMsg[701];
	char tel_ddd[5];
	char tel_exn[5];
	char tel_num[5];
	char* sndbuf;
	long ret = 0, i;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
			
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set((byte*)szUMsg, 0x00, sizeof(szUMsg) );
		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		Mem_Set((byte*)tel_ddd, 0x00, sizeof(tel_ddd));	
		Mem_Set((byte*)tel_exn, 0x00, sizeof(tel_exn));	
		Mem_Set((byte*)tel_num, 0x00, sizeof(tel_num));
		
		Mem_Set((byte*)&stMw, 0x00, sizeof(stMw));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT REQ_CP_DDD,REQ_CP_EXN,REQ_CP_NUM ,CUST_NM, SEND_YN \
FROM C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_ddd            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_exn            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_num            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_nm               ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSend_yn               ,1  +1, DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		if( stMw.szSend_yn[0] == 'Y' || stMw.szSend_yn[0] == 'S')
		{
			return;
		}
		
		Str_Cpy( sztmp, stMw.szReq_cp_ddd);
		Str_Cat( sztmp, stMw.szReq_cp_exn);
		Str_Cat( sztmp, stMw.szReq_cp_num);
		
		if( Str_Len(sztmp) < 9 || !g_CheckPhoneNumberFormat(stMw.szReq_cp_exn, stMw.szReq_cp_num) )
		{
			MessageBoxEx (ERROR_OK, "고객님의 휴대폰번호가\n잘못되어 발송할 수 없습니다.");
			return;
		}
		
		if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_SMS)) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "지연 시간을 선택하세요.");
			return;
		}	
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp ,EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SMS)) );

		if( MessageBoxEx (CONFIRM_YESNO, "현재 선택된 고객님께\n메시지를 발송하시겠습니까?") != MB_OK)
			return;
		
		SPRINT(szMsg, "서울도시가스 %s고객센터 서비스 매니저 %s입니다. 금일(연결/철거) %s이내 방문예정이오니 부재중일 경우 사전 연락을 주시면 감사하겠습니다.",stUserinfo.szcenter_nm, stUserinfo.sznm_kor, sztmp);
		Str_Cat(szMsg , "(");
		Str_Cat(szMsg , stUserinfo.szpda_ip);
		Str_Cat(szMsg , ")");
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312315, FALSE);

		fsgetitem(stUserinfo.szpda_ip, tel_ddd, 1, Str_Len(stUserinfo.szpda_ip) );
		fsgetitem(stUserinfo.szpda_ip, tel_exn, 2, Str_Len(stUserinfo.szpda_ip) );
		fsgetitem(stUserinfo.szpda_ip, tel_num, 3, Str_Len(stUserinfo.szpda_ip) );
		
		JSON_SetValue( g_pjcomm, 'C', "send_tel_ddd",   tel_ddd );
		JSON_SetValue( g_pjcomm, 'C', "send_tel_exn",   tel_exn );
		JSON_SetValue( g_pjcomm, 'C', "send_tel_num",   tel_num );
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",   stMw.szReq_cp_ddd );
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",   stMw.szReq_cp_exn );
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",   stMw.szReq_cp_num );

		SQL_ConvUcStr( szUMsg, stMw.szCust_nm );
		JSON_SetValue( g_pjcomm, 'C', "receiver_nm",   szUMsg );
		
		Mem_Set((byte*)szUMsg, 0x00, sizeof(szUMsg) );
		SQL_ConvUcStr( szUMsg, szMsg );
		JSON_SetValue( g_pjcomm, 'C', "sms_desc", szUMsg );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_Sms; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR62402_IN",  "FR62402" , sndbuf, szbuf );
		
	}
	
	long Rcv_Sms(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(62402) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "SMS 전송이 완료 되었습니다.");
			ON_DRAW();
			return 1;
		}
		else
		{
			MessageBoxEx (ERROR_OK, "SMS 전송실패.");
			ON_DRAW();
			return -1;
		}
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
	
	void RCV_DAYMIN(void)
	{
		Rev68402(2);//추가받기
	}
	
	long Rev68402(long flag)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 68402, TRUE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Str_ItoA( Time_GetDate(),szbuf ,10);
		JSON_SetValue( g_pjcomm, 'C', "promise_ymd",   szbuf );
		if(flag == 1)
			JSON_SetValue( g_pjcomm, 'C', "gubun",   "1" );
		else
			JSON_SetValue( g_pjcomm, 'C', "gubun",   "2" );
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Str_Cpy(szbuf, "FR68402.JSON");

		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		callBackfunc = TR68402;
		//ret = HTTP_DownloadData(szUrl, "FR68402_IN",  "FR68402" , sndbuf, szbuf );
		HTTP_Url2File("POST", szUrl, sndbuf, szbuf);
		return 0;
	}
	
	long TR68402(void)
	{
		g_Sock_Close();
		
		if( Save_Min() > 0 )
		{
			SND68404();
			return 1;
		}
		
		CloseMessageBox();
		
		ON_DRAW();
		return 1;
	}
	
	void Update_sort(void)
	{
	char szSql[200];
	char sztmp[10];
	long cnt = 0;
	
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN  ",0,0,0   );
		g_Sql_RetInt(szSql, &cnt );
		if( cnt < 10 )
		{
			Str_Cpy(sztmp, "00" );
			Str_ItoA( cnt,sztmp+2 ,10 );
		}
		else if( cnt < 100 )
		{
			Str_Cpy(sztmp, "0" );
			Str_ItoA( cnt,sztmp+1 ,10 );
		}
		else
		{
			Str_Cpy(sztmp, "999" );
		}
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"UPDATE C6101_PROMISE_ASSIGN SET PAY_CALU = '%s'  WHERE PAY_CALU IS NULL",sztmp,0,0   );
		g_Sql_DirectExecute( szSql );
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"UPDATE C6101_PROMISE_BUR SET PDA_IP = '%s'  WHERE PDA_IP IS NULL",sztmp,0,0   );
		g_Sql_DirectExecute( szSql );
		
	}
	
	//----------------------------------------------------------------------------------
	// 기  능 : 전송 결과 파일을 검토한다.
	// 설  명 : 
	// 리턴값 : 1:정상적인 통신완료, 0: 에러응답or응답형식오류, -1: 알수없는 에러
	//----------------------------------------------------------------------------------

	
	long Save_Min(void)
	{
	char szJsonpath[500];
	char szMsg[500];
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr = NULL;
	char *szcode = NULL;
	char *szmessage = NULL;
	char *szitem = NULL;
	char szType[2] = {0,0};
	long ret = 0;
	handle hitem = NULL;
	handle hcnt = NULL;
	DBInfo assign;
	DBInfo mtr;
	DBInfo bur;
	DBInfo custinfo;
	DBInfo nonpay;
	handle hdb = NULL;
	SQLITE sql = NewSqLite();
			
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			DelSqLite(sql);
			MessageBoxEx(ERROR_OK, "데이터베이스 연결 오류.. \n리셋후 초기버젼을 재설치 해 주세요.");
			ret = FALSE;
			goto Finally;
		}
		assign.szTblnm=  "C6101_PROMISE_ASSIGN";
		assign.nKeyCnt=  AssignKeyCnt;
		assign.nUTotCnt=  AssignUCnt;
		assign.nITotCnt=  AssignICnt;
		assign.keyinfo=  m_stMwAssignKey;
		assign.Ufldinfo=  m_stMwAssignU;
		assign.Ifldinfo=  m_stMwAssignI;

		mtr.szTblnm=     "C6101_PROMISE_mtr";
		mtr.nKeyCnt=  MtrKeyCnt;
		mtr.nUTotCnt=  MtrUCnt;
		mtr.nITotCnt=  MtrICnt;
		mtr.keyinfo=  m_stMwMtrKey;
		mtr.Ufldinfo=  m_stMwMtrU;
		mtr.Ifldinfo=  m_stMwMtrI;

		bur.szTblnm=     "C6101_PROMISE_bur";
		bur.nKeyCnt=  BurKeyCnt;
		bur.nUTotCnt=  BurUCnt;
		bur.nITotCnt=  BurICnt;
		bur.keyinfo=  m_stMwBurKey;
		bur.Ufldinfo=  m_stMwBurU;
		bur.Ifldinfo=  m_stMwBurI;

		custinfo.szTblnm="C6101_Pre_cust_info";
		custinfo.nKeyCnt=  CustKeyCnt;
		custinfo.nUTotCnt=  CustUCnt;
		custinfo.nITotCnt=  CustICnt;
		custinfo.keyinfo=  m_stMwCustKey;
		custinfo.Ufldinfo=  m_stMwCustU;
		custinfo.Ifldinfo=  m_stMwCustI;

		nonpay.szTblnm=  "C6101_nonpay";
		nonpay.nKeyCnt=  NonpayKeyCnt;
		nonpay.nUTotCnt=  NonpayUCnt;
		nonpay.nITotCnt=  NonpayICnt;
		nonpay.keyinfo=  m_stMwNospayKey;
		nonpay.Ufldinfo=  m_stMwNospayU;
		nonpay.Ifldinfo=  m_stMwNospayI;


		MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR68402_Res.JSON",  SYSTEM_COMM, 0, 0 );
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR68402.JSON",  SYSTEM_COMM, 0, 0 );
		}
		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}

		pStr = Mem_Alloc(fsize);
		
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			Mem_Free((byte*)pStr);
			goto Finally;
		}
		
		FFS_Read(fd, (byte*)pStr, fsize);

		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);

		Mem_Free((byte*)pStr);
		
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
	
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}

		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
			  char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				EvtDraw();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "nonpay", szType);
				if( Str_Len(szitem) > 0 )
				{
					hitem = JSON_Create( JSON_Array );
					if( hitem != NULL)
					{
						JSON_toJson(hitem, szitem ) ;
						ret = JSON_GetArrayCount( hitem );
					}
				}
							
				if(ret > 0 )// DB 입력
				{				
					SetJsonToDB( &nonpay, sql, hitem, ret );
				}
				ret = 0;
				
				szitem =JSON_GetValue(g_pjcomm, "custinfo", szType);
				
				if( Str_Len(szitem) > 0 )
				{
					hitem = JSON_Create( JSON_Array );
					if( hitem != NULL)
					{
						JSON_toJson(hitem, szitem ) ;
						ret = JSON_GetArrayCount( hitem );
					}
				}
				
				if(ret > 0 )// DB 입력//json필드, 디비필드, 변수, 키필드, 순서, 테이블명,
				{
					if( hitem != NULL)
					{
						SetJsonToDB( &custinfo, sql, hitem, ret );
					}
				}
				
				ret = 0;

				szitem =JSON_GetValue(g_pjcomm, "mtr", szType);
				if( Str_Len(szitem) > 0 )
				{
					hitem = JSON_Create( JSON_Array );
					if( hitem != NULL)
					{
						JSON_toJson(hitem, szitem ) ;
						ret = JSON_GetArrayCount( hitem );
					}
				}
				
				if(ret > 0 )// DB 입력
				{
					SetJsonToDB( &mtr, sql, hitem, ret );
				}
						
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "bur", szType);
				
				if( Str_Len(szitem) > 0 )
				{
					hitem = JSON_Create( JSON_Array );
					if( hitem != NULL)
					{
						JSON_toJson(hitem, szitem ) ;
						ret = JSON_GetArrayCount( hitem );
					}
				}
				
				if(ret > 0 )// DB 입력
				{
					SetJsonToDB( &bur, sql, hitem, ret );
				}
				ret = 0;
			
				szitem =JSON_GetValue(g_pjcomm, "assign", szType);
				if( Str_Len(szitem) > 0 )
				{
					hitem = JSON_Create( JSON_Array );
					if( hitem != NULL)
					{
						JSON_toJson(hitem, szitem ) ;
						m_mincnt = JSON_GetArrayCount( hitem );
					}
				}
				
				if(m_mincnt > 0 )// DB 입력
				{
					SetJsonToDB( &assign, sql, hitem, m_mincnt );
					
					//수신업데이터용 민원접수번호 저장
					Save_assignseq(hitem, m_mincnt);
				}
				
				if(hitem != NULL )
				{
					JSON_Finalize(hitem);
					hitem = NULL;
				}
			}
		}
		else
		{
			ret = 0;
		}

Finally:	
		
		m_nCurr = 0;
		
		//sql->Commit(sql);
		//sql->Close(sql);
		DelSqLite(sql);
		
		//PRINT("DelSqLite END",0,0,0);
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		if(m_mincnt == 0)
		{
			MessageBoxEx (WARNING_OK, "추가로 받을 자료가 없습니다.");
		}

//2017-08-10 Sanghyun Lee
//무슨의미 메세지??????? 불필요해보임.
//		else
//		{
//			if(Str_Len(szcode) == 0)
//				MessageBoxEx (WARNING_OK, "오류: 서버응답이 없습니다.");
//		}
		
		ON_DRAW();
		return m_mincnt;
	}
	
	
	bool  Save_assignseq(handle hitem, long nTCnt)
	{
	long fd, i;
	char sztmp[32];
	long *Col;
	void *Sts_Cd = NULL;
	long nCol= 0;
	char szType[2] = {0,0};
	
		fd = FFS_Open (  RcvAssignseq, FS_WRITE_MODE , FS_CREATE_FLAG );
		
		for( i = 0 ; i < nTCnt ; i++ )
		{
			Sts_Cd = JSON_GetArrayItem ( hitem, i,"PROC_STS_CD",  szType);
			
			if( Str_Cmp(Sts_Cd , "10" ) == 0 )
			{			
				Col = JSON_GetArrayItem ( hitem, i,"promise_assign_seq",  szType);
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp )  );
				nCol = *Col;
				Str_ItoA(nCol,  sztmp, 10  );
				FFS_Write(fd, (byte*)sztmp, RcvAssignseq_Len   );
			}
		}
		
		FFS_Close(fd);
		return TRUE;
	}
	
	
	
	//----------------------------------------------------------------------
	//함수명: SQL_FSTODB
	//기  능: 파일정보와 테이블정보를 읽어서 파일에서 DB로 데이터를 넣는다.
	//Param : TBL 정보
	//Return: TRUE:성공, FALSE:실패
	//----------------------------------------------------------------------
	bool SetJsonToDB( DBInfo* info, SQLITE sql, handle hitem, long nTCnt )
	{
	long	ret = -1, idx = 0;
	bool	bret = FALSE;
	long 	i;
	char	sztmp[100];
	char	szSql[4000];
	char	szWhere[3000];
	char 	szType[2] = {0,0};
	void    *Col = NULL;
	long	nCnt = 0;
	
		MessageBoxEx(MESSAGE, "데이터를 확인중 입니다.");
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql )  );
		Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		
		for( idx = 0 ; idx < info->nKeyCnt ; idx++ )
		{
			if(idx != 0)
				Str_Cat( szWhere, " AND ");
			Str_Cat( szWhere, info->keyinfo[idx].colnm );
			Str_Cat( szWhere, " = ? ");
		}
		
		SPRINT(szSql, " SELECT COUNT(*) FROM %s WHERE %s", info->szTblnm,  szWhere, 0 );
		
		sql->CreateStatement(sql, szSql);
		if( sql->m_hStmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql )  );
		Mem_Set((byte*)szWhere, 0x00, sizeof(szWhere) );
		
		Str_Cpy( szSql, " INSERT INTO " );
		Str_Cat( szSql, info->szTblnm );
		Str_Cat( szSql, "(" );
		
		for( idx = 0 ; idx < info->nITotCnt ; idx++ )
		{
			if(idx != 0)
			{
				Str_Cat( szSql, ",");
				Str_Cat( szWhere, ",");
			}
			Str_Cat( szSql, info->Ifldinfo[idx].colnm );
			Str_Cat( szWhere, "?" );
		}
		
		Str_Cat( szSql, ") VALUES (" );
		Str_Cat( szSql, szWhere );
		Str_Cat( szSql, ")" );
		
		//PRINT(" INSERT [%d]", Str_Len(szSql), 0 , 0);
		
		sql->CreateStatementI(sql, szSql);
		if( sql->m_hIStmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		m_nCurr++;
		
		for( i = 0 ; i < nTCnt ; i++ )
		{
			long percent = (i * 100) / nTCnt;
			SPRINT(sztmp, "%d %% (%d/%d) 저장 중...", percent, m_nCurr, m_nTotal);
			SetMessageBoxText(sztmp);
		
			for(idx = 0; idx < info->nKeyCnt ; idx++)
			{
				Col = JSON_GetArrayItem ( hitem, i, info->keyinfo[idx].jsonnm, szType);				
				if(szType[0] == 'C')
				{
					sql->Bind(sql, idx, 'C', (long*)Col, Str_Len(Col), info->keyinfo[idx].encrypt );
				}
				else if(szType[0] == 'X')
				{
					sql->Bind(sql, idx, 'X', Col, 4, info->keyinfo[idx].encrypt );
				}
			}
			sql->Begin(sql);
			bret = sql->Execute(sql);
			if(bret == FALSE)
			{
				PRINT("::sql->Execut [%s]", sql->GetLastError(sql), 0, 0);
				ret = -1;
				goto Finally;
			}
			
			while( sql->Next(sql) == TRUE )
			{
				nCnt = 0;
				sql->GetValue( sql, 0, 'X', &nCnt, sizeof(nCnt), DECRYPT );
				//PRINT("count(*) [%d]", nCnt, 0, 0);
	
			}
			//자료의 존재여부 확인해서 인서트만 한다.
			if( nCnt == 0 )
			{	
				for(idx = 0; idx < info->nITotCnt ; idx++)
				{
				
					Col = JSON_GetArrayItem ( hitem, i, info->Ifldinfo[idx].jsonnm, szType);
//PRINT("szType=%s, %s",szType,info->Ifldinfo[idx].jsonnm,0);
					if(szType[0] == 'C')
					{
						sql->IBind(sql, idx, 'C', (long*)Col, Str_Len(Col), info->Ifldinfo[idx].encrypt );
					}
					else if(szType[0] == 'X')
					{
						sql->IBind(sql, idx, 'X', Col, 4, info->Ifldinfo[idx].encrypt );
					}
					else
					{
						//nCnt = 0;
						switch( info->Ifldinfo[idx].type )
						{
						case SQLITE_INT:
							//PRINT("SQLITE_INT NULL[%s],[%s] ",info->Ifldinfo[idx].jsonnm,info->Ifldinfo[idx].colnm,0);
							nCnt = 0;
							sql->IBind(sql, idx, 'X', &nCnt, 4, info->Ifldinfo[idx].encrypt );
							//PRINT("SetJsonToDB::[%d][%s][%d]", idx, info->Ifldinfo[idx].jsonnm, nCnt);
							break;
						case SQLITE_STR:
							//PRINT("SQLITE_STR NULL[%s],[%s]",info->Ifldinfo[idx].jsonnm,info->Ifldinfo[idx].colnm,0);
							Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));					
							sql->IBind(sql, idx, 'C', (long*)sztmp, Str_Len(sztmp), info->Ifldinfo[idx].encrypt );
							//PRINT("SetJsonToDB::[%d][%s][%s]", idx, info->Ifldinfo[idx].jsonnm, szCol);
							break;
						}
					}
				}
				sql->Begin(sql);
				bret = sql->ExecuteI(sql);
				
				if(bret == FALSE)
				{
					PRINT("::sql->ExecuteI [%s]", sql->GetLastError(sql), 0, 0);
					ret = -1;
					goto Finally;
				}
			}
			
			ret = TRUE;
		}
		
Finally:
		sql->DeleteStatement(sql);

		ON_DRAW();
		GrDev_Refresh();
		
		return ret;
	}
	
	long SND68404(void)
	{
	long ret = 0;
	char sztmp[100];
	char szbuf[200];
	char szUrl[200];
	char szDbpath[128];
	char* sndbuf;
	
		//송신
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68404, TRUE);
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Str_Cpy(szbuf, "FR68404.JSON");
		callBackfunc = TR68404;
		HTTP_Url2File("POST", szUrl, sndbuf, szbuf);
		return ret;
	}
	
	long Add_Item(handle pj)
	{
	char sztmp[20];
	long ret = -1;
	long fd, i, tot = 0;	
	handle js = NULL;
	char szPromise_assign_seq[11];
	SQLITE sql = NewSqLite();
		
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		tot = FFS_GetSize( RcvAssignseq );
		tot = tot /RcvAssignseq_Len;
				
		fd = FFS_Open (  RcvAssignseq, FS_READ_MODE , FS_NORMAL_FLAG );
		
		for( i = 0 ; i < tot ; i++ )
		{	
			Mem_Set( (byte*)szPromise_assign_seq, 0x00, sizeof(szPromise_assign_seq )  );
			FFS_Read(fd, (byte*)szPromise_assign_seq, RcvAssignseq_Len   );
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "promise_assign_seq", szPromise_assign_seq );
			ret =1;
		}
		
		FFS_Close(fd);
		
		JSON_Attach(pj, "item", js);
		
Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return ret;
	}
	
	long TR68404(void)
	{
	char szMsg[200];
		
		g_Sock_Close();
		
		if(g_Chk_Json(68404) >= 0)
		{
			if(  m_mincnt > 0  )
			{
				Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
				SPRINT(szMsg, "%d건이 추가되었습니다!",  m_mincnt, 0, 0 );
				MessageBoxEx (CONFIRM_OK, szMsg);
				Update_sort();
			}
			
			CloseMessageBox();
			
			//추가받기 후 상단 완료,미완료 카운트 새로고침
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			g_Sql_RetStr("SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN where SEND_YN = 'S' or SEND_YN = 'Y'", 10, szMsg );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CMPLT),  szMsg);
			
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			g_Sql_RetStr("SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is null ", 10, szMsg );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INCMPLT),  szMsg);
			
			REDRAW();
			ON_DRAW();
			return 1;
		}
		
		ON_DRAW();
		return -1;
	}
	
	void Grid_QuickList(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char szSql[1000];
		char szWhere[128];
		char szSort[128];
		char key[32];
		char val[32];
		long lLen = 0;
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"구분", "주소", "시간", "처리", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"4","8","5","3","0"};
		char col_align[5][10]  = {"center", "left", "center","center", ""};
	
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

			start_position = m_lpage*ROW + g_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			if( g_nAddrFlag == 0 )
			{
				Str_Cpy(szSql, "SELECT \
PDA_DUTY, CASE WHEN LENGTH(IFNULL(TRIM(VILLAGE),'') )+LENGTH( IFNULL(TRIM(BUILDING),'') ) > 0 \
THEN IFNULL(VILLAGE, '') ||' '|| IFNULL(BUILDING, '') ||'-'|| IFNULL(HOUSE_CNT, '') ||' '|| IFNULL(ETC_ADDR, '') \
ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOUSE_CNT, '') ||' '|| IFNULL(ETC_ADDR, '') END \
, SUBSTR(PROMISE_TIME, 1,2) ||':'|| SUBSTR(PROMISE_TIME, 3,2), SEND_YN \
FROM C6101_PROMISE_ASSIGN ");
			}
			else
			{
				Str_Cpy(szSql, "SELECT \
PDA_DUTY, CASE WHEN LENGTH(IFNULL(TRIM(VILLAGE),'') )+LENGTH( IFNULL(TRIM(BUILDING),'') ) > 0 \
THEN IFNULL(VILLAGE, '') ||' '|| IFNULL(BUILDING, '') ||'-'|| IFNULL(HOUSE_CNT, '') \
ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(ETC_ADDR, '') END \
, SUBSTR(PROMISE_TIME, 1,2) ||':'|| SUBSTR(PROMISE_TIME, 3,2), SEND_YN \
FROM C6101_PROMISE_ASSIGN ");
			}

			//콤보박스 필터링에 따른 조건
			Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
			if( m_nWhere == 0) //전체
			{
				Str_Cpy( szWhere , "where SEND_YN <> 'D' or SEND_YN is null ");
			}
			else if( m_nWhere == 1) //미완료
			{
				Str_Cpy( szWhere , "where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is null " );
			}
			else if( m_nWhere == 2) //완료
			{
				Str_Cpy( szWhere , "where SEND_YN = 'S' or SEND_YN = 'Y' " );
			}
			
			//정렬 조건
			Mem_Set( (byte*)szSort, 0x00, sizeof(szSort) );
			if( g_lindex == 0)
			{
				Str_Cpy( szSort , "ORDER BY PAY_CALU, PROMISE_TIME");
			}
			else if( g_lindex == 1)
			{
				Str_Cpy( szSort , "ORDER BY PDA_DUTY_FLAG");
			}
			else if( g_lindex == 2)
			{
				Str_Cpy( szSort , "ORDER BY PDA_DUTY_FLAG desc" );
			}
			else if( g_lindex == 3)
			{
				Str_Cpy( szSort , "ORDER BY CURR_ADDR_UNION" );	
			}
			else if( g_lindex == 4)
			{
				Str_Cpy( szSort , "ORDER BY CURR_ADDR_UNION desc" );	
			}
			else if( g_lindex == 5)
			{
				Str_Cpy( szSort , "ORDER BY PROMISE_TIME" );		
			}
			else if( g_lindex == 6)
			{
				Str_Cpy( szSort , "ORDER BY PROMISE_TIME desc" );	
			}
			else if( g_lindex == 7)
			{
				Str_Cpy( szSort , "ORDER BY PAY_CALU desc, SEND_YN" );		
			}
			else if( g_lindex == 8)
			{
				Str_Cpy( szSort , "ORDER BY SEND_YN desc" );	
			}
			
			Str_Cat(szSql, szWhere);
			Str_Cat(szSql, szSort);

			//PRINT("m_szTmp : %d , %s",Str_Len(m_szTmp),m_szTmp,0);
			JSON_SetValue	(hData	, 'C', "query", szSql);
			
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
			
			JSON_SetValue	(h		, 'C', "title"			, "작업리스트");
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





