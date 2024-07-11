/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_CHGLST
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
		
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_TASK

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

		DEF_BUTTON_ID ( BID_CHGDATE )		//예약변경
		DEF_BUTTON_ID ( BID_TRANS )			//작업변경
		DEF_BUTTON_ID ( BID_ADDR )			//주소
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지
		DEF_BUTTON_ID ( BID_QUICK )			//페이지 표시 및 퀵뷰 호출
		
		DEF_BUTTON_ID ( BID_DATE )			//달력
		DEF_BUTTON_ID ( BID_SNDDATE )		//예약변경송신
		DEF_BUTTON_ID ( BID_DATECLOSE )		//예약변경닫기
		
		DEF_BUTTON_ID ( BID_SNDTRANS )		//작업변경송신
		DEF_BUTTON_ID ( BID_TRANSCLOSE )	//작업변경닫기
		DEF_BUTTON_ID ( BID_SORTGUBUN )			//
		DEF_BUTTON_ID ( BID_SORTADDR )			//
		DEF_BUTTON_ID ( BID_SORTTIME )			//
		DEF_BUTTON_ID ( BID_SORTWRK )			//
		DEF_BUTTON_ID ( BID_WRITE )			//
		
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( ICON_TITLE )	//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )		//타이틀
		
		DEF_OBJECT_ID ( TTL_DATE )	//예약일
		DEF_OBJECT_ID ( TXT_DATE )	//예약일
		DEF_OBJECT_ID ( TXT_YY )	//예약년
		DEF_OBJECT_ID ( TXT_MM )	//예약월
		DEF_OBJECT_ID ( TXT_DD )	//예약일
		
		DEF_OBJECT_ID ( TTL_HOUR )	//시간
		DEF_OBJECT_ID ( TTL_MEMO )	//약속메모
		DEF_OBJECT_ID ( TXT_MEMO )	//
		
		DEF_OBJECT_ID ( TTL_WRKMAN )	//민원기사
		DEF_OBJECT_ID ( CMB_WRKMAN )	//민원기사콤보
		DEF_OBJECT_ID ( CMB_HOUR = CMB_WRKMAN+3 )		//시간콤보
		DEF_OBJECT_ID ( CMB_MIN  = CMB_HOUR+3 )		//분콤보
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+60)			// table 행 높이
	#define		GRID_H_P	(CHT+48)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+130  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    //table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (STARTY+760+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"구분", CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"주소", CWD*20+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"시간", CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"처리", CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"민원번호", 0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	#define INIT_MAIN		1
	#define INIT_CHGDATE	2
	#define INIT_TRANS		3

	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lTotCnt = 0;			// 총 대상 수
	long m_nActRow = -1;		//선택된 row index
	long m_nActIndex = -1;		//선택된 active ctrl
	long m_chk=  0;
	long m_chkbtn = 0;
		
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	long m_ldataread = 0;
	
	long m_nSort = 0;			//초기정렬 시간순
	char m_szSql[3000];
	char m_szMemo[200];
	char m_szDate[10];
	char m_szTime[10];
	char m_szPromise_assign_seq[11];
	
	SQLITE m_sql = NULL;
	handle m_hdb = NULL;
	handle m_hstmt = NULL;

	bool REDRAW(void);
	void SetStyle(void);
	void SetBtnImg(void);
	void SetCombo(void);
	void Set_grdtitle(void);
	void Get_ActPage( char* szCHK_EXEC_NUM );
	
	long Sql_SetCombo(char* szSql, long CTRLID );
	char* make_sql(char*szsql, long nsort, long QuickFlag );
	void SET_CHGDATE(void);
	long Snd_trans(void);
	long TR61107(void);
	long Add_Item(handle pj);
	
	long Snd_date(void);
	long TR61104(void);

	void Grid_CheckLst(void);
	void Grid_CheckRet(char* szRet);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "작업변경"),
		
		//DLG_TEXT(STARTX,       STARTY+65, 300, SYH+10, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 

		DLG_BUTTON(STARTX,     STARTY+65, 300, SYH+10, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK, m_szCnt_page),
		DLG_BUTTON(STARTX+400, STARTY+65, 300, SYH+10, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+700, STARTY+65, 300, SYH+10, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
				
		DLG_BUTTON( STARTX,     Line(1)+18, 300, SYH+11, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON( STARTX+400, Line(1)+18, 300, SYH+11, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGDATE, "예약변경"),
		DLG_BUTTON( STARTX+700, Line(1)+18, 300, SYH+11, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TRANS, "작업이관"),

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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "작업변경"),
		
		DLG_BUTTON( STARTX,     Line(1), 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON( STARTX+460, Line(1), 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGDATE, "예약변경"),
		DLG_BUTTON( STARTX+730, Line(1), 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TRANS, "작업이관"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
				
	};
	
	//---------------------------------------------------------------
	DlgObject	DlgChgDate[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "예약변경"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATECLOSE, ""),

		DLG_TEXT(   STARTX,        STARTY-29, CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DATE, "예 약 일"),
		//DLG_TEXT(   STARTX+CWD*10, STARTY, CWD*25, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATE, ""),
		DLG_EDIT(  STARTX+250,  STARTY-29, 220, SYH, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_YY, 4,  ""),
		DLG_TEXT(  STARTX+470,   STARTY-8,  16,  30, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, 0, "."),
		DLG_EDIT(  STARTX+486,  STARTY-29, 160, SYH, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_MM, 2,  ""),
		DLG_TEXT(  STARTX+646,   STARTY-8,  16,  30, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, 0, "."),
		DLG_EDIT(  STARTX+662,  STARTY-29, 160, SYH, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DD, 2,  ""),
		DLG_BUTTON( STARTX+822, STARTY-29, 178, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATE, "▼"),
		
		DLG_TEXT(   STARTX,     STARTY+SYH-29, CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_HOUR, "예약시간"),
		DLG_COMBO ( STARTX+250, STARTY+SYH-29, CWD*15, 290, 165, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_HOUR, 10),
		DLG_COMBO ( STARTX+625, STARTY+SYH-29, CWD*15, 290, 172, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_MIN, 10),
		
		DLG_TEXT(        STARTX,   STARTY+SYH*2-29,     CWD*10, SYH*3, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MEMO, "약속메모"),
		DLG_TEXT( STARTX+CWD*10,   STARTY+SYH*2-29,  CWD*30, SYH*3, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_MEMO, ""),
		DLG_BUTTON( STARTX+CWD*10, STARTY+SYH*2-29,  CWD*30, SYH*3, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),	
		
		DLG_BUTTON( STARTX+700, STARTY+270, 300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SNDDATE, "변경"),
	};

	
	//---------------------------------------------------------------
	DlgObject	DlgTrans[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "작업이관"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TRANSCLOSE, ""),
		
		DLG_TEXT(         STARTX,  STARTY, CWD*11, SYH+20, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_WRKMAN, "민원기사"),
		DLG_COMBO ( STARTX+CWD*11, STARTY, CWD*29, 500, 150, SYH+20, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_WRKMAN, 10),
		
		DLG_BUTTON( STARTX+698, 300, 300, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SNDTRANS, "이 관"),
				
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
						SetBtnImg();
						Set_grdtitle();
						REDRAW();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						SetBtnImg();
						Set_grdtitle();
						REDRAW();
						break;
				}
				break;
			case INIT_CHGDATE:
				m_nActIndex = -1;
				CREATE_DIALOG_OBJECT (DlgChgDate, SIZEOF(DlgChgDate));
				SetBtnImg();
				SET_CHGDATE();
				break;
			case INIT_TRANS:
				CREATE_DIALOG_OBJECT (DlgTrans, SIZEOF(DlgTrans));
				SetBtnImg();
				break;			
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
	void* h;
	long i;
	char sztmp[10];
	char szYear[5];
	char szMonth[3];
	char szDay[3];
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE );			
		if( m_bFirst == INIT_MAIN )
		{
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
			
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			Mem_Set((byte*)m_szDate, 0x00, sizeof(m_szDate));
		}
		else if( m_bFirst == INIT_CHGDATE )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MEMO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_HOUR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MEMO), EDITALIGN_LEFT);
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID(TXT_MEMO), TRUE, 2, EDITSEP_NONE );
			
			for( i = 6 ; i < 23 ; i++ )//06~22
			{
				if( i > 9 )
					SPRINT(sztmp, "%d", i, 0, 0);
				else
					SPRINT(sztmp, "0%d", i, 0, 0);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_HOUR+2), sztmp, 0, ICON_NONE);
			}
			for( i = 0 ; i < 12 ; i++ )//00, 05
			{
				if( i*5 > 9 )
					SPRINT(sztmp, "%d", i*5, 0, 0);
				else
					SPRINT(sztmp, "0%d", i*5, 0, 0);
				
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_MIN+2), sztmp, 0, ICON_NONE);
			}
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_HOUR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_MIN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_YY), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DD), EDITALIGN_MIDDLE);
			
			if( Str_Len(m_szDate) == 0 )
			{
				Mem_Set((byte*)m_szDate, 0x00, sizeof(m_szDate));
				Str_ItoA(Time_GetDate(), m_szDate, 10);
			}
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Cpy((byte *)szYear, (byte *)m_szDate, 4);
			Mem_Cpy((byte *)szMonth, (byte *)m_szDate+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)m_szDate+6, 2);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_YY), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MM), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DD), szDay );
			
		}
		else if( m_bFirst == INIT_TRANS )
		{
			IconCtrl_SetImage( Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_WRKMAN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_WRKMAN), EDITALIGN_MIDDLE);
			SetCombo();
		}
	}

//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
	long index;
	char szSql[300];
				
	
		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				m_nActRow = index-1;
				
				Mem_Set( (byte*)m_szPromise_assign_seq, 0x00, sizeof(m_szPromise_assign_seq) );
				Str_Cpy(m_szPromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActRow, 4) );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				if( Str_Cmp( CHKON, DlgTbl_GetStr( ID_TBLLIST, m_nActRow, 3) ) == 0 )
				{
					SPRINT( szSql ,"UPDATE C6101_PROMISE_ASSIGN SET CHK = 'N' where Promise_assign_seq = '%s'",m_szPromise_assign_seq,0,0   );
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  m_nActRow, 3 , BLACK);
					DlgTbl_SetStr ( ID_TBLLIST, m_nActRow, 3, CHKOFF );
				}
				else
				{
					SPRINT( szSql ,"UPDATE C6101_PROMISE_ASSIGN SET CHK = 'Y' where Promise_assign_seq = '%s'",m_szPromise_assign_seq,0,0   );
					DlgTbl_SetStr ( ID_TBLLIST, m_nActRow, 3, CHKON );
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  m_nActRow, 3 , RED);
				}
				g_Sql_DirectExecute(szSql);

			}
		}
	}
	
	//──────────────────────────────────────────────
	void	OnChar(long nChar)
	{
	long nRet = 0;
	long nDate = 0;
	char szTmp[10];
		
		//숫자만 입력 가능
		if( m_bFirst == INIT_CHGDATE )
		{
			if(  (Get_iDlgCtrlByID(TXT_YY) == m_nActIndex
			|| Get_iDlgCtrlByID(TXT_MM) == m_nActIndex
			|| Get_iDlgCtrlByID(TXT_DD) == m_nActIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
	
			if( Get_iDlgCtrlByID(TXT_YY) == m_nActIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(TXT_YY)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(TXT_MM));
					m_nActIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(TXT_MM) == m_nActIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MM)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MM)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(TXT_MM)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(TXT_DD));
					m_nActIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(TXT_DD) == m_nActIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DD)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DD)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_YY)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MM)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DD)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_YY), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_MM), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DD), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(TXT_YY));
					m_nActIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
		}
		ON_DRAW();
		return;
	}
	
	//──────────────────────────────────────────────
	void	OnPointing(long nAction, long X, long Y)
	{
		if( m_bFirst == INIT_CHGDATE )
		{
			m_nActIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			
			if( POINTING_UP == nAction )
			{
				if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+826) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY-29+SYH) )
				{
					if( Get_iDlgCtrlByID(TXT_YY) == m_nActIndex  ||  Get_iDlgCtrlByID(TXT_MM) == m_nActIndex 
					 || Get_iDlgCtrlByID(TXT_DD) == m_nActIndex )	
					{
						g_Dlgflag = 0;
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
		}
	}
	
	//──────────────────────────────────────────────
	void	OnTask(long nEvent, long nData)
	{
		char* szRet;
		long nRet = 0;

		if( nEvent == 1 )
		{
			szRet = (char*)System_GetResult((char*)&nRet);
			//PRINT("EVENT >>>>>>>>>>>>>>>>>>>>>>quick view ret : %s",szRet,0,0);		
			
			Grid_CheckRet(szRet);	
		}
	}

	//──────────────────────────────────────────────
	void	OnButton(long ID)
	{
	long d, k;
	char szSql[300];
	char sztmp[10];
	char szYear[5];
	char szMonth[3];
	char szDay[3];	
	
		switch(ID)
		{
			case BID_QUICK:
				Grid_CheckLst();
				break;
			case BID_CHGDATE:
				if(m_nActRow < 0)
				{
					MessageBoxEx (WARNING_OK, "자료를 선택해주세요.");
					break;
				}
				Mem_Set( (byte*)m_szPromise_assign_seq, 0x00, sizeof(m_szPromise_assign_seq) );
				Str_Cpy(m_szPromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActRow, 4));

				//2017-05-03 Sanghyun Lee
				//여러 대상 선택 후 예약변경을 누르게 되면 마지막 대상을 제외한 나머지 대상의 체크박스 해제
				SPRINT( szSql ,"UPDATE C6101_PROMISE_ASSIGN SET CHK = 'N' where Promise_assign_seq <> '%s'",m_szPromise_assign_seq,0,0   );
				g_Sql_DirectExecute(szSql);

				ON_EXIT();
				OnInit(INIT_CHGDATE);
				break;
				
			case BID_DATE://달력
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_YY)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MM)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DD)));
				k = Str_AtoI(sztmp);
			
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					if( d < Time_GetDate() )
					{
						MessageBoxEx (CONFIRM_OK, "현재보다 이전으로의 예약변경은 불가합니다.");
						break;
					}
					Mem_Set((byte*)m_szDate, 0x00, sizeof(m_szDate));
					Str_ItoA ( d, m_szDate, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear,  (byte *)m_szDate, 4);
					Mem_Cpy((byte *)szMonth, (byte *)m_szDate+4, 2);
					Mem_Cpy((byte *)szDay,   (byte *)m_szDate+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_YY), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MM), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DD), szDay );
				}
				break;
				
			case BID_SNDDATE://예약변경송신
				if( Snd_date() > 0 )
				{
					break;
				}
				break;
				
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_MEMO), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MEMO)) );
				break;	
				
			case BID_TRANS:
				{
				char szSql[600];
				char sztmp[10]; 
				
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					SPRINT( szSql ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN  WHERE CHK = 'Y' ",0,0,0   );
					g_Sql_RetStr(szSql, 4, sztmp );
					if(Str_AtoI(sztmp) <= 0) 
					{
						MessageBoxEx (WARNING_OK, "자료를 선택해주세요.");
						DlgTbl_SetActive(ID_TBLLIST , m_nActRow+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActRow+1, TABLEACTIVE_COLOR);
						break;
					}
				}
				ON_EXIT();
				OnInit(INIT_TRANS);
				break;
			case BID_SNDTRANS://작업변경송신
				if( Snd_trans()  > 0 )
				{
					break;
				}
				break;
		
			case BID_DATECLOSE:
			case BID_TRANSCLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_SORTGUBUN:
				if(m_nSort == 0)
				{
					m_nSort = 1;
				}
				else
				{
					if(m_nSort == 1)
						m_nSort = 2 ;
					else if(m_nSort == 2)
						m_nSort = 0 ;
					else
						m_nSort = 1 ;
				}
				
				m_lpage = 0;
				Set_grdtitle();
				REDRAW();
				break;
			case BID_SORTADDR:
				if(m_nSort == 0)
				{
					m_nSort = 3;
				}
				else
				{
					if(m_nSort == 3)
						m_nSort = 4 ;
					else if(m_nSort == 4)
						m_nSort = 0 ;
					else
						m_nSort = 3 ;
				}
				
				m_lpage = 0;
				Set_grdtitle();
				REDRAW();
				break;
			case BID_SORTTIME:
				if(m_nSort == 0)
				{
					m_nSort = 5;
				}
				else
				{
					if(m_nSort == 5)
						m_nSort = 6 ;
					else if(m_nSort == 6)
						m_nSort = 0 ;
					else
						m_nSort = 5 ;
				}
				m_lpage = 0;
				Set_grdtitle();
				REDRAW();
				break;
			case BID_SORTWRK:
				if(m_nSort == 0)
				{
					m_nSort = 7;
				}
				else
				{
					if(m_nSort == 7)
						m_nSort = 8 ;
					else if(m_nSort == 8)
						m_nSort = 0 ;
					else
						m_nSort = 7 ;
				}
				
				m_lpage = 0;
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
				REDRAW();
				break;
			
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
					m_lpage = 0;
				m_nActRow =0;
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
					m_lpage = m_lTotpage-1;
				m_nActRow =0;
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
				Card_Move("C6101_LST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void Get_ActPage( char* szCHK_EXEC_NUM )
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	long lsetidx;
	char sztmp[1000];
	char szbuf[100];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
		
		lTotPage = 0;
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( sztmp ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN  where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is NULL ",0,0,0   );
		g_Sql_RetInt(sztmp, &lTotPage );
		
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		hstmt = sql->CreateStatement(sql, make_sql(sztmp, m_nSort, 0 ));
//PRINT( "%s", sztmp , 0, 0);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		lstartidx = 0;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = lTotPage;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		lsetidx = 0;
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		i=0;
		while (sql->Next(sql) )
		{
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			sql->GetValue(sql, 15, 'U', (long*)szbuf, 50, DECRYPT);
			if( Str_Cmp(szbuf, szCHK_EXEC_NUM) == 0 )
			{
				lsetidx =  i;
				break;
			}		
			i++;
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( lsetidx > 0  )
		{		
			m_lpage = lsetidx / ROW;
			m_nActRow = lsetidx % ROW;
		}
		else
		{
			m_nActRow = 0;
			m_lpage = 0;
		}
	}
	
	void Set_grdtitle(void)
	{
		if(m_ldataread == 0)
		{	
			if( g_lindex < 7 )
			{
				m_nSort = g_lindex;
			}
			
			Get_ActPage( g_szCHK_EXEC_NUM );
			
			m_ldataread=1;
		}
		
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지 번");
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
		}
		
		switch(m_nSort)
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
	char sztmp[1000];
	char szbuf[100];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;

		m_lTotpage = 0;
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( sztmp ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN  where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is NULL ",0,0,0   );
		g_Sql_RetInt(sztmp, &m_lTotpage );
		
		m_lTotCnt = m_lTotpage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage,0);
		
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		hstmt = sql->CreateStatement(sql, make_sql(sztmp, m_nSort, 0 ) );

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
				if( Str_Cmp(sztmp, "060013") == 0 )
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
				if( sztmp[0] == 'Y' )
				{					
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 3 , RED);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, CHKON );
				}
				else
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 3 , BLACK);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, CHKOFF );
				}
							
				if( g_nAddrFlag == 0)
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 4, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 5, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 6, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, "-");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 7, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 8, 'U', (long*)szbuf, 100, DECRYPT);
					
					if( Str_Len(szbuf) == 0 )
					{
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 9, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					else
					{
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 10, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
						
						Str_Cat( sztmp, "-");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 11, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				}
				else
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 12, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 13, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, "-");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 14, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				}
				
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 15, 'U', (long*)szbuf, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, szbuf );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			if(m_nActRow >= 0)
			{
				DlgTbl_SetActive(ID_TBLLIST , m_nActRow+1 );
				DlgTbl_SetRowColor(ID_TBLLIST, m_nActRow+1, TABLEACTIVE_COLOR);
			}
			
			Mem_Set( (byte*)m_szPromise_assign_seq, 0x00, sizeof(m_szPromise_assign_seq) );
			Str_Cpy(m_szPromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActRow, 4) );
		}
		else
		{
			m_nActRow = -1;
		}
		
		ON_DRAW();
		return TRUE;
	}
	
//------------------------------------------------------------------------------------------
	//QuickFlag = 0 기본 리스트 쿼리 , = 1 퀵뷰 리스트 쿼리 , = 2 퀵뷰 결과 쿼리
	char* make_sql(char*szsql, long nsort, long QuickFlag )
	{
	char sql[500];
	char sort[100];
	char where[100];
		
		Mem_Set( (byte*)sql, 0x00, sizeof(sql) );
		Mem_Set( (byte*)sort, 0x00, sizeof(sort) );
		Mem_Set( (byte*)where, 0x00, sizeof(where) );
		
		if( QuickFlag == 0 )
		{
			Str_Cpy(sql , "SELECT \
	PDA_DUTY, PROMISE_TIME, CHK, CIVIL_SERV_CLASS_CD \
	, Trim(TOWN) ,Trim(VILLAGE_RI),Trim(ADDR1_M) \
	, Trim(ADDR1_S), Trim(VILLAGE), ETC_ADDR, BUILDING, HOUSE_CNT \
	,NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S, PROMISE_ASSIGN_SEQ \
	FROM C6101_PROMISE_ASSIGN  ");
		}
		else if( QuickFlag == 1 )
		{
			if( g_nAddrFlag == 0 )
			{
			Str_Cpy(sql , "SELECT PDA_DUTY, \
ifnull(Trim(TOWN),'') ||' '|| ifnull(Trim(VILLAGE_RI),'') ||' '|| ifnull(Trim(ADDR1_M),'') ||'-'|| ifnull(Trim(ADDR1_S),'') \
||' '|| ifnull(Trim(VILLAGE),'') ||' '|| Case When Length(Trim(VILLAGE)) == 0 Then ifnull(ETC_ADDR,'') ELSE ifnull(BUILDING,'') ||' '|| ifnull(HOUSE_CNT,'') END \
,substr(PROMISE_TIME,1,2) ||':'|| substr(PROMISE_TIME,3,2), CHK \
FROM C6101_PROMISE_ASSIGN ");
			}
			else
			{
			Str_Cpy(sql , "SELECT PDA_DUTY, \
Trim(NEW_ROAD_NM) ||' '|| Trim(NEW_ADDR_M) ||'-'|| Trim(NEW_ADDR_S) \
,substr(PROMISE_TIME,1,2) ||':'|| substr(PROMISE_TIME,3,2), CHK \
FROM C6101_PROMISE_ASSIGN ");
			}

		}
		else if( QuickFlag == 2 )
		{
			//퀵뷰 체크 결과 쿼리
			Str_Cpy(sql , "SELECT ROWID FROM C6101_PROMISE_ASSIGN  ");
		}

		Str_Cpy( where , "where ( SEND_YN <> 'S' and SEND_YN <> 'Y' and SEND_YN <> 'D')  or SEND_YN is null" );
		
		if( QuickFlag == 0 )
		{
			if( nsort == 0)
			{
				Str_Cpy( sort , "ORDER BY PAY_CALU, PROMISE_TIME LIMIT ?, ? ");
			}
			else if( nsort == 1)
			{
				Str_Cpy( sort , "ORDER BY PDA_DUTY_FLAG  LIMIT ?, ?" );
			}
			else if( nsort == 2)
			{
				Str_Cpy( sort , "ORDER BY PDA_DUTY_FLAG desc LIMIT ?, ?" );
			}
			else if( nsort == 3)
			{
				Str_Cpy( sort , "ORDER BY CURR_ADDR_UNION LIMIT ?, ?" );	
			}
			else if( nsort == 4)
			{
				Str_Cpy( sort , "ORDER BY CURR_ADDR_UNION desc LIMIT ?, ?" );	
			}
			else if( nsort == 5)
			{
				Str_Cpy( sort , "ORDER BY PROMISE_TIME LIMIT ?, ?" );		
			}
			else if( nsort == 6)
			{
				Str_Cpy( sort , "ORDER BY PROMISE_TIME desc LIMIT ?, ?" );	
			}
			else if( nsort == 7)
			{
				Str_Cpy( sort , "ORDER BY CHK LIMIT ?, ?" );		
			}
			else if( nsort == 8)
			{
				Str_Cpy( sort , "ORDER BY CHK desc LIMIT ?, ?" );	
			}
		}
		else
		{
			if( nsort == 0)
			{
				Str_Cpy( sort , "ORDER BY PAY_CALU, PROMISE_TIME");
			}
			else if( nsort == 1)
			{
				Str_Cpy( sort , "ORDER BY PDA_DUTY_FLAG" );
			}
			else if( nsort == 2)
			{
				Str_Cpy( sort , "ORDER BY PDA_DUTY_FLAG desc" );
			}
			else if( nsort == 3)
			{
				Str_Cpy( sort , "ORDER BY CURR_ADDR_UNION" );	
			}
			else if( nsort == 4)
			{
				Str_Cpy( sort , "ORDER BY CURR_ADDR_UNION desc" );	
			}
			else if( nsort == 5)
			{
				Str_Cpy( sort , "ORDER BY PROMISE_TIME" );		
			}
			else if( nsort == 6)
			{
				Str_Cpy( sort , "ORDER BY PROMISE_TIME desc" );	
			}
			else if( nsort == 7)
			{
				Str_Cpy( sort , "ORDER BY CHK" );		
			}
			else if( nsort == 8)
			{
				Str_Cpy( sort , "ORDER BY CHK desc" );	
			}
		}
		
		SPRINT( szsql, "%s %s %s", sql, where, sort );
		//PRINT("szsql[%s]",szsql,0,0);
		return szsql;
	}
	
	void SetCombo(void)
	{	
		char szSql[300];
		char sztmp[100];
		long i;

		m_sql = NewSqLite();
		if (m_sql == NULL)
		{
			goto Finally;
		}

		m_hdb = m_sql->Open(m_sql);
		if( m_hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT EMPLOYEE_NM FROM C6101_EMPLOYEE WHERE EMPLOYEE_ID <> '%s' AND EMPLOYEE_ID <> '         ' ORDER BY EMPLOYEE_NM ",stUserinfo.szemployee_id, 0, 0);
		Sql_SetCombo(szSql, CMB_WRKMAN+2);
Finally:		
		DelSqLite(m_sql);
		return;
	}
	
	long Sql_SetCombo(char* szSql, long CTRLID )
	{
		long ret = -1;
		char szBuf[101];
		long cnt  = 0;
		SQLITE sql = m_sql;

		m_hstmt = sql->CreateStatement(sql, szSql);
		if( m_hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		sql->Begin(sql);

		ret = sql->Execute(sql);

		cnt = 0;
		while(sql->Next(sql) == TRUE)
		{
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)szBuf, sizeof(szBuf), DECRYPT );
			ListCtrl_AddItem (Get_hDlgCtrlByID(CTRLID), szBuf, 0, ICON_NONE);
			cnt++;
			if(cnt == 100)
				break;
		}
		
Finally:
		return ret;
	}
	
	
	void SET_CHGDATE(void)
	{
		long i;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		char sztime[5];
		char szdesc[501];
		char sztmp[10];
		
		
		Mem_Set((byte*)sztime, 0x00, sizeof(sztime) );
		Mem_Set((byte*)szdesc, 0x00, sizeof(szdesc) );
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement( sql, "SELECT PROMISE_TIME, PROMISE_ASSIGN_DESC FROM C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)m_szPromise_assign_seq , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) sztime        , sizeof(sztime) , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) szdesc        , sizeof(szdesc), DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		Mem_Cpy( (byte*)sztmp, (byte*)sztime, 2);
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_HOUR), sztmp);
		Mem_Cpy( (byte*)sztmp, (byte*)sztime+2, 2);
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_MIN), sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_MEMO), szdesc);
		return;
	}

	
	long Snd_trans(void)
	{
	long ret = 0;
	char sztmp[100];
	char szSql[600];
	char szUrl[200];
	char szDbpath[128];
	char* sndbuf;
	
		
		//입력체크
		if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_WRKMAN)) <= 0  )
		{
			MessageBoxEx (CONFIRM_OK, "민원기사를 선택하세요.");
			return ret;
		}
		//송신
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy( sztmp , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_WRKMAN)) );
		SPRINT(szSql, "SELECT EMPLOYEE_ID FROM C6101_EMPLOYEE  WHERE EMPLOYEE_NM = '%s' ",sztmp, 0, 0);
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Sql_RetStr(szSql, 9, sztmp );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 61107, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "chg_flag",      "12" );
		JSON_SetValue( g_pjcomm, 'C', "assign_sts_cd", "20" );
		JSON_SetValue( g_pjcomm, 'C', "chg_value",     sztmp );
		Add_Item(g_pjcomm);		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR61107; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR61107_IN",  "FR61107" , sndbuf, sztmp );
		
		return ret;
	}
	
	long Add_Item(handle pj)
	{
	char szSql[500];
	char sztmp[20];
	long ret = -1;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	handle js = NULL;
	char szbefo_value[11];
	char szPromise_assign_seq[11];
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT PROMISE_ASSIGN_SEQ, ASSIGN_EMPID FROM C6101_PROMISE_ASSIGN WHERE CHK = 'Y' ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szPromise_assign_seq,0x00, sizeof(szPromise_assign_seq) );
			Mem_Set( (byte*)szbefo_value,0x00, sizeof(szbefo_value) );
			
			sql->GetValue(sql, 0, 'U', (long*)szPromise_assign_seq, 11, DECRYPT);
			sql->GetValue(sql, 1, 'U', (long*)szbefo_value, 11, DECRYPT);
			
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "promise_assign_seq", szPromise_assign_seq );
			JSON_SetArrayItem(js, 'C', "befo_value",        szbefo_value );
			
			ret =1;
		}
		
		JSON_Attach(pj, "item", js);
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return ret;
	}
	
	long TR61107(void)
	{
	char szSql[200];
		
		g_Sock_Close();
		
		CloseMessageBox();
		
		if(g_Chk_Json(61107) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " DELETE FROM C6101_PROMISE_ASSIGN WHERE CHK = 'Y' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			MessageBoxEx (CONFIRM_OK, "이관 완료.");
			
			//2017-05-03 Sanghyun Lee
			//이관 완료 후 작업리스트로 이동
			//ON_EXIT();
			//OnInit(INIT_MAIN);
			Card_Move("C6101_LST");
			return 1;
		}
		CloseMessageBox();
		return -1;
	}
	
	long Snd_date(void)
	{
	long ret = 0;
	char sztmp[100];
	char szUrl[200];
	char szDbpath[128];
	char* sndbuf;
	char szpromise_assign_desc[200];
	char szDate_b[9];
	char szTime_b[9];
	char szUMemo[400];
	char szSql[500];
	
		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		Mem_Set((byte*)m_szTime, 0x00, sizeof(m_szTime));	
		Mem_Set((byte*)szDate_b, 0x00, sizeof(szDate_b));	
		Mem_Set((byte*)szTime_b, 0x00, sizeof(szTime_b));	
		Mem_Set((byte*)m_szMemo, 0x00, sizeof(m_szMemo));	
		Mem_Set((byte*)szUMemo, 0x00, sizeof(szUMemo));	
		Mem_Set((byte*)m_szDate, 0x00, sizeof(m_szDate));	
		
		Str_Cpy( m_szDate, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_YY) ));
		Str_Cat( m_szDate ,EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_MM) ));
		Str_Cat( m_szDate, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DD) ));
		Str_Chg(m_szDate, STRCHG_DEL_NONDIGIT);
		ret = Str_AtoI(m_szDate);
		ret = Time_ValidateDate(ret);
		if( ret == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
			return -1;
		}
		
		ret = Str_AtoI(m_szDate);
		if( ret < Time_GetDate() )
		{
			MessageBoxEx (CONFIRM_OK, "현재보다 이전으로의 예약변경은 불가합니다.");
			return -1;
		}
		
		//입력체크
		Str_Cpy( m_szTime , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_HOUR)) );
		Str_Cat( m_szTime , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_MIN)) );
		
		//중복체크
		if( Str_AtoI(m_szDate) == Time_GetDate() )
		{
			
			if( (Str_AtoI(m_szTime)*100) < Time_GetTime() )
			{
				MessageBoxEx (CONFIRM_OK, "현재보다 이전으로의 예약변경은 불가합니다.");
				return ret;
			}
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN  WHERE PROMISE_TIME = '%s' ",m_szTime,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				MessageBoxEx (WARNING_OK, "일정있음! 시간변경바람!");
				return ret;
			}
		}
		
		Str_Cpy( m_szMemo , EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MEMO)) );
		SQL_ConvUcStr( szUMemo, m_szMemo );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szDate_b, 0x00, sizeof(szDate_b) );
		SPRINT( szSql ,"SELECT PROMISE_YMD FROM C6101_PROMISE_ASSIGN  WHERE  Promise_assign_seq = '%s'",m_szPromise_assign_seq,0,0   );
		g_Sql_RetStr(szSql, 8, szDate_b );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTime_b, 0x00, sizeof(szTime_b) );
		SPRINT( szSql ,"SELECT PROMISE_TIME FROM C6101_PROMISE_ASSIGN  WHERE  Promise_assign_seq = '%s'",m_szPromise_assign_seq,0,0   );
		g_Sql_RetStr(szSql, 4, szTime_b );
		
		//송신
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 61104, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",  m_szPromise_assign_seq );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_desc",  szUMemo);
		JSON_SetValue( g_pjcomm, 'C', "chg_flag1",     "20" );
		JSON_SetValue( g_pjcomm, 'C', "chg_flag2",     "21" );
		JSON_SetValue( g_pjcomm, 'C', "assign_sts_cd", "20" );		
		JSON_SetValue( g_pjcomm, 'C', "promise_ymd",   m_szDate );
		JSON_SetValue( g_pjcomm, 'C', "promise_time",  m_szTime );
		JSON_SetValue( g_pjcomm, 'C', "promise_ymd_b",  szDate_b );
		JSON_SetValue( g_pjcomm, 'C', "promise_time_b", szTime_b );
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR61104; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR61104_IN",  "FR61104" , sndbuf, sztmp );
		
		return ret;	
	}
	
	long TR61104(void)
	{
	char szSql[200];
		
		g_Sock_Close();
		
		CloseMessageBox();
		
		if(g_Chk_Json(61104) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			if( Str_AtoI(m_szDate) != Time_GetDate() )
				SPRINT( szSql, " DELETE FROM C6101_PROMISE_ASSIGN where Promise_assign_seq = '%s'",m_szPromise_assign_seq, 0, 0 );
			else
				SPRINT( szSql, " UPDATE C6101_PROMISE_ASSIGN SET  PROMISE_TIME = '%s', PROMISE_ASSIGN_DESC = '%s' where Promise_assign_seq = '%s'",m_szTime, m_szMemo, m_szPromise_assign_seq );

			g_Sql_DirectExecute( szSql );
			
			MessageBoxEx (CONFIRM_OK, "예약일정 수정 완료.");
			
			
			m_nActRow = 0;
			m_lpage = 0;
			ON_EXIT();
			OnInit(INIT_MAIN);
			return 1;
		}
		
		return -1;
	}
	
	//------------------------------------------------------------------------
	void Grid_CheckLst(void)
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
		
		char col_name[5][32] = {"구분", "주소", "시간", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"2","3","2","1","0"};
		char col_align[5][10]  = {"center", "left", "center", "center", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridCheckView");
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			//주소가 표시되는 필드가 존재해서 세로길이가 자동조절이 안된다면 
			//일반 퀵뷰리스트와 같이 높이 조절이 필요할거같습니다.
			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActRow;
			if( start_position < 0 )
			{
				start_position = 0;
			}
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			Mem_Set( (byte*) m_szSql, 0x00, sizeof( m_szSql) );
			JSON_SetValue	(hData	, 'C', "query", make_sql(m_szSql, m_nSort, 1));

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
			
			JSON_SetValue	(h		, 'C', "title"			, "작업변경");
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

	//------------------------------------------------------------------------
	void Grid_CheckRet(char* szRet)
	{
		char szTmp[100];
		char szFile[10];
		long fd;
		long i = 0, k = 0, idx = 0;
		long lCnt = 0;
		long lRet = 0;
		long lRowid = 0;
		long *nCol;
		char *pStr;
		char *szitem;
		char szType[2] = {0,0};
		handle hitem = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hitem = JSON_Create( JSON_Array );
		
		if( hitem != NULL)
		{
			JSON_toJson(hitem, szRet ) ;
			lCnt = JSON_GetArrayCount( hitem );
			
			if( lCnt > 0 )
			{
				g_Sql_DirectExecute( "UPDATE C6101_PROMISE_ASSIGN SET CHK = 'N'" );

				Mem_Set((byte*) m_szSql, 0x00, sizeof( m_szSql) );
				g_Sql_SaveSeq( make_sql(m_szSql, m_nSort, 2), SREACH_FILE);

				fd = FFS_Open( SREACH_FILE, FS_READ_MODE, FS_NORMAL_FLAG);
				if(fd == -1)
				{
					MessageBoxEx (ERROR_OK, "파일을 찾을수 없습니다.");
					FFS_Flush(fd);
					FFS_Close(fd);
					return;
				}
				
				if( m_lTotCnt != lCnt )
				{
					Mem_Set((byte*) m_szSql, 0x00, sizeof( m_szSql) );
					Str_Cpy(m_szSql, "UPDATE C6101_PROMISE_ASSIGN SET CHK = 'Y' WHERE ROWID IN (");
					for(i=0 ; i<lCnt ; i++)
					{
						//복수세대 여부
						Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
						nCol = (long*)JSON_GetArrayItem ( hitem, i, "check", szType);
						lRet = *nCol;
						//lRet = lRet+1;

						//lRowid = g_SREACHFILE_GetSeq(SREACH_FILE, lRet);
						Mem_Set((byte*)szFile, 0x00, sizeof(szFile));
						if(FREAD(fd, lRet*SRCH_FS_SIZE+SRCH_FS_INDEX_POS, szFile, 8) == FALSE)
						{
						  	FFS_Flush(fd);
							FFS_Close(fd);
							return;
						}
						if(Str_Len(szFile) == 0)
						{
						  	FFS_Flush(fd);
							FFS_Close(fd);
							return;
						}
						lRowid = Str_AtoI(szFile);

						if(i > 0)
						{
							Str_Cat(m_szSql, ",");
						}

						Str_ItoA( lRowid, szTmp, 10);
						Str_Cat(m_szSql, szTmp);
						
						//PRINT("RCV_GRID_CHECK >>>>>> i : %d , Ret_Row : %s",i,szTmp,0);
						
					}
					
					Str_Cat(m_szSql, ")");
					//PRINT(">>>>>>>>>>>>>> %d",Str_Len(m_szSql),0,0);
					g_Sql_DirectExecute( m_szSql );
				}
				else
				{
					g_Sql_DirectExecute( "UPDATE C6101_PROMISE_ASSIGN SET CHK = 'Y'" );
					
				}
				
				FFS_Flush(fd);
				FFS_Close(fd);
			}
			else
			{
				g_Sql_DirectExecute( "UPDATE C6101_PROMISE_ASSIGN SET CHK = 'N'" );

			}
		}
		else
		{
			g_Sql_DirectExecute( "UPDATE C6101_PROMISE_ASSIGN SET CHK = 'N'" );
		}
		
Finally:		
		
		if(hitem != NULL)
		{
			JSON_Finalize(hitem);
			hitem = NULL;
		}

		g_Close_SubDlg();
		
		REDRAW();
		EvtDraw();
		
		return ;
	}
}




