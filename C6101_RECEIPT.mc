/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_RECEIPT
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
	#include "ArrayList.c"
	
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
		
		
		DEF_BUTTON_ID ( BID_SUBCLOSE )		//확인
		
		
		DEF_BUTTON_ID ( BID_SND )			//승인취소 내역 송신
		DEF_BUTTON_ID ( BID_PRINT )			//영수증 재출력
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//타이틀
		
		DEF_OBJECT_ID ( TXT_ADDR     )
		DEF_OBJECT_ID ( TXT_ADDR2    )
		DEF_OBJECT_ID ( TTL_SUM      )
		DEF_OBJECT_ID ( TXT_TATOL    )
		DEF_OBJECT_ID ( TXT_GAS      )
		DEF_OBJECT_ID ( TXT_SUNAP    )
		DEF_OBJECT_ID ( TTL_CARD     )
		DEF_OBJECT_ID ( TXT_TOT_CARD )
		DEF_OBJECT_ID ( TXT_CARD_GAS )
		DEF_OBJECT_ID ( TXT_CARD_ONE )
		DEF_OBJECT_ID ( TTL_CASH     )
		DEF_OBJECT_ID ( TXT_TOT_CASH )
		DEF_OBJECT_ID ( TXT_CASH_GAS )
		DEF_OBJECT_ID ( TXT_CASH_ONE )
		DEF_OBJECT_ID ( TTL_BACK     )
		DEF_OBJECT_ID ( TXT_BACK     )
		
		DEF_OBJECT_ID ( TTL_DATA01  )
		DEF_OBJECT_ID ( TTL_DATA02  )
		DEF_OBJECT_ID ( TTL_DATA03  )
		DEF_OBJECT_ID ( TTL_DATA04  )
		
		DEF_OBJECT_ID ( TXT_DATA01  )
		DEF_OBJECT_ID ( TXT_DATA02  )
		DEF_OBJECT_ID ( TXT_DATA03  )
		DEF_OBJECT_ID ( TXT_DATA04  )
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6					// table의 행개수
	#define		COL 	    7					// table의 열개수
	#define		GRID_H		(CHT+20)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+175  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (STARTY+538+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"구분"    ,    CWD*8,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"고객명"  ,   CWD*10,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"요금수납",   CWD*12,  EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"일회성"  , CWD*9+23,  EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"민원번호",     	0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소",     		0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소2",     		0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};
	
	#define INIT_MAIN	1
	#define INIT_DETAIL	2

	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_nActIndex = -1;		//선택된 row index
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag
	CARRAYLIST m_pList = NULL;
	bool m_bPrintAgain = FALSE;

	void SetStyle(void);
	void SetBtnImg(void);
	bool TABLE_DRAW(void);
	bool REDRAW(void);
	
	long Load_Assign(char* assign_seq);
	void Load_CardData(char* assign_seq);

	void Bill_Pirnt(void);
	void* Bill_GetPirntData(void);
	long Bill_Print_Result(void* p);

	long SearchCD( char *CD, CodeTable *CT);
	long GetUtf8Size(char* str, long chklen);

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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "작 업 현 황 관 리"),
		
		DLG_TEXT( STARTX+680,    STARTY+65,      320, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		DLG_TEXT( STARTX,        STARTY+65,      680, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),
		DLG_TEXT( STARTX,        STARTY+65+SYH,  1000, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
	
		DLG_TEXT( STARTX,        Line(1),  CWD*8,     SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SUM, "합계"),
		DLG_TEXT( STARTX+CWD*8,  Line(1),  CWD*10,    SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TATOL, ""),
		DLG_TEXT( STARTX+CWD*18, Line(1),  CWD*12,    SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GAS, ""),
		DLG_TEXT( STARTX+CWD*30, Line(1),  CWD*9+23,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SUNAP, ""),
		
		DLG_TEXT( STARTX,        Line(2),  CWD*8,     SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CARD, "카드"),
		DLG_TEXT( STARTX+CWD*8,  Line(2),  CWD*10,    SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_CARD, ""),
		DLG_TEXT( STARTX+CWD*18, Line(2),  CWD*12,    SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_GAS, ""),
		DLG_TEXT( STARTX+CWD*30, Line(2),  CWD*9+23,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_ONE, ""),
		
		DLG_TEXT( STARTX,        Line(3),  CWD*8,     SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CASH, "현금"),
		DLG_TEXT( STARTX+CWD*8,  Line(3),  CWD*10,    SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_CASH, ""),
		DLG_TEXT( STARTX+CWD*18, Line(3),  CWD*12,    SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CASH_GAS, ""),
		DLG_TEXT( STARTX+CWD*30, Line(3),  CWD*9+23,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CASH_ONE, ""),
		
		DLG_TEXT( STARTX,        Line(4),  CWD*16,    SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BACK, "후불일회성"),
		DLG_TEXT( STARTX+CWD*16, Line(4),  CWD*23+23, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BACK, ""),

		DLG_BUTTON(    STARTX,  Line(5), 200, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+200,  Line(5), 200, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_BUTTON( STARTX+580, Line(5), 420, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "영수증 재출력"),

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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "작 업 현 황 관 리"),
		DLG_TEXT(   STARTX+680, STARTY+80, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		DLG_TEXT( STARTX,        STARTY+80,      670, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),
		DLG_TEXT( STARTX,        STARTY+85+SYH,  980, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
			
		DLG_TEXT( STARTX,        Line(1),  CWD*8,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_SUM, "합계"),
		DLG_TEXT( STARTX+CWD*8,  Line(1),  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TATOL, ""),
		DLG_TEXT( STARTX+CWD*18, Line(1),  CWD*12, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GAS, ""),
		DLG_TEXT( STARTX+CWD*30, Line(1),  CWD*9,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SUNAP, ""),
		
		DLG_TEXT( STARTX,        Line(2),  CWD*8,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CARD, "카드"),
		DLG_TEXT( STARTX+CWD*8,  Line(2),  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_CARD, ""),
		DLG_TEXT( STARTX+CWD*18, Line(2),  CWD*12, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_GAS, ""),
		DLG_TEXT( STARTX+CWD*30, Line(2),  CWD*9,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_ONE, ""),
		
		DLG_TEXT( STARTX,        Line(3),  CWD*8,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CASH, "현금"),
		DLG_TEXT( STARTX+CWD*8,  Line(3),  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_CASH, ""),
		DLG_TEXT( STARTX+CWD*18, Line(3),  CWD*12, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CASH_GAS, ""),
		DLG_TEXT( STARTX+CWD*30, Line(3),  CWD*9,  SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CASH_ONE, ""),
		
		DLG_TEXT( STARTX,        Line(4),  CWD*16, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_BACK, "후불일회성"),
		DLG_TEXT( STARTX+CWD*16, Line(4),  CWD*23, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BACK, ""),

		DLG_BUTTON(    STARTX,  Line(5)+20, 150,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+160,  Line(5)+20, 150,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_BUTTON( STARTX+580, Line(5)+20, 400, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "영수증 재출력"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};
	
	
	DlgObject	DlgRes_Detail[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "상세내역"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX+240, STARTY-29,        380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK,   TTL_DATA01, "카드"),
		DLG_TEXT( STARTX+620, STARTY-29,        380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK,   TTL_DATA02, "현금"),
		DLG_TEXT( STARTX,     STARTY+SYH-29,    240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK,   TTL_DATA03, "가스요금"),
		DLG_TEXT( STARTX+240, STARTY+SYH-29,    380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA01, ""),
		DLG_TEXT( STARTX+620, STARTY+SYH-29,    380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA02, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*2-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK,   TTL_DATA04, "일회성"),
		DLG_TEXT( STARTX+240, STARTY+SYH*2-29,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA03, ""),
		DLG_TEXT( STARTX+620, STARTY+SYH*2-29,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA04, ""),

		DLG_BUTTON( STARTX+620, STARTY+SYH*4, 380, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, "확 인"),
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
				//PRINT("OnInit INIT_MAIN start", 0, 0, 0);
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
				//PRINT("OnInit INIT_MAIN SetBtnImg end", 0, 0, 0);
				TABLE_DRAW();
				//PRINT("OnInit INIT_MAIN TABLE_DRAW end", 0, 0, 0);
				REDRAW();
				//PRINT("OnInit INIT_MAIN end", 0, 0, 0);
				break;
			case INIT_DETAIL:
				CREATE_DIALOG_OBJECT (DlgRes_Detail, SIZEOF(DlgRes_Detail));
				SetBtnImg();
				REDRAW();
				break;
		}
	}
	
	//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
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
		}
		else if( m_bFirst == INIT_DETAIL )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		}
	}

	//------------------------------------------------------------------
	void	OnSelect(long Index)
	{
	long index;
	
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			Str_Cpy( g_szCHK_EXEC_NUM , DlgTbl_GetStr( ID_TBLLIST, index-1, 4)  );
		
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR ), DlgTbl_GetStr( ID_TBLLIST, index-1, 5)  );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2 ), DlgTbl_GetStr( ID_TBLLIST, index-1, 6)  );
			
			if(m_nActIndex == index-1)
			{
				Load_Assign(g_szCHK_EXEC_NUM);
				
				ON_EXIT();
				OnInit(INIT_DETAIL);
			}
			m_nActIndex = index-1;
		}
	}

	//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	char szSql[200];
	
		switch(ID)
		{
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					break;
				}
				m_nActIndex = 0;
				TABLE_DRAW();
				break;			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					break;
				}
				m_nActIndex = 0;
				TABLE_DRAW();
				break;
				
			case BID_PRINT:
				if(m_nActIndex < 0 )
				{
					MessageBoxEx (ERROR_OK, "선택한 자료가 없습니다.");
					break;
				}
				
				if(Str_Len(g_szCHK_EXEC_NUM) > 0)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "영수증 출력을 하시겠습니까.") != MB_OK) 
						break;
					
					Load_Assign(g_szCHK_EXEC_NUM);
					Load_CardData(g_szCHK_EXEC_NUM);
					
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Mem_Set( (byte*)stMw.szOnce_account , 0x00, sizeof(stMw.szOnce_account ) );
					SPRINT(szSql, " SELECT SUM( A.ONCE_AMT ) FROM C6101_ONCE_INFO A WHERE  A.PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_RetStr( szSql, 10, stMw.szOnce_account );
					
					if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0 
					|| ( Str_AtoI(stMw.szCash_gaspay ) == 0 && Str_AtoI(stMw.szCard_gaspay ) == 0  &&  Str_AtoI(stMw.szAdj_alt_amt) > 0 )
					|| ( Str_AtoI(stMw.szOnce_account) > 0 && stMw.szAuto_yn[0] != 'Y'  &&  Str_Cmp (stMw.szPda_duty_flag, "20") != 0 ) 
					|| ( Str_Cmp (stMw.szPda_duty_flag, "20") == 0 )
					)
					{
						Bill_Pirnt();
					}
					else
					{
						 MessageBoxEx (CONFIRM_OK, "출력할 금액이 없습니다.");
					}
				}
				break;
			
			case BID_SUBCLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
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

	//------------------------------------------------------------------
	bool REDRAW(void)
	{
	char szSql[300];
	char sztmp[30];
	long ncash_one = 0;
	long ncard_one = 0;
	long ncard_pay = 0;
	long ncash_pay = 0;
		
	long npay = 0;
	long none = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
		
			//PRINT("REDRAW INIT_MAIN start", 0, 0, 0);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TATOL), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GAS), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUNAP), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TOT_CARD), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARD_GAS), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARD_ONE), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CASH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TOT_CASH), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CASH_GAS), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CASH_ONE), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BACK), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BACK), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT SUM(ONCE_ACCOUNT) FROM C6101_PROMISE_ASSIGN WHERE AUTO_YN <> 'Y'  AND CARD_ONEPAY = '1'  AND SEND_YN IN ('Y','S','D' ) ",  0, 0, 0 );
			g_Sql_RetStr(szSql, 15 ,sztmp );
			if( Str_Len(sztmp)  == 0)
			{
				Str_Cpy(sztmp, "0");
			}
			ncash_one = Str_AtoI( sztmp );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CASH_ONE ), sztmp );
	
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT SUM(ONCE_ACCOUNT) FROM C6101_PROMISE_ASSIGN WHERE AUTO_YN <> 'Y'  AND CARD_ONEPAY = '2' AND SEND_YN IN ('Y','S','D' ) ",  0, 0, 0 );
			g_Sql_RetStr(szSql, 15 ,sztmp );
			if( Str_Len(sztmp)  == 0)
			{
				Str_Cpy(sztmp, "0");
			}
			ncard_one = Str_AtoI( sztmp );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARD_ONE ), sztmp );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT SUM(CARD_GASPAY) FROM C6101_PROMISE_ASSIGN WHERE  SEND_YN IN ('Y','S','D' ) ",  0, 0, 0 );
			g_Sql_RetStr(szSql, 15 ,sztmp );
			if( Str_Len(sztmp)  == 0)
			{
				Str_Cpy(sztmp, "0");
			}
			ncard_pay = Str_AtoI( sztmp );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARD_GAS ), sztmp );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT SUM(CASH_GASPAY) FROM C6101_PROMISE_ASSIGN WHERE  SEND_YN IN ('Y','S','D' ) ",  0, 0, 0 );
			g_Sql_RetStr(szSql, 15 ,sztmp );
			if( Str_Len(sztmp)  == 0)
			{
				Str_Cpy(sztmp, "0");
			}
			ncash_pay = Str_AtoI( sztmp );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CASH_GAS ), sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA( (ncard_pay+ncard_one), sztmp, 10);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TOT_CARD ), sztmp );
	
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA( (ncash_pay+ncash_one), sztmp, 10);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TOT_CASH ), sztmp );
			
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT SUM(ACCOUNT) FROM C6101_PROMISE_ASSIGN WHERE SEND_YN IN ('Y','S','D' )  ",  0, 0, 0 );
			g_Sql_RetStr(szSql, 15 ,sztmp );
			if( Str_Len(sztmp)  == 0)
			{
				Str_Cpy(sztmp, "0");
			}
			npay = Str_AtoI(sztmp );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GAS ), sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT SUM(ONCE_ACCOUNT) FROM C6101_PROMISE_ASSIGN WHERE AUTO_YN <> 'Y' AND SEND_YN IN ('Y','S','D' ) ",  0, 0, 0 );
			g_Sql_RetStr(szSql, 15 ,sztmp );
			if( Str_Len(sztmp)  == 0)
			{
				Str_Cpy(sztmp, "0");
			}
			none = Str_AtoI(sztmp );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_SUNAP ), sztmp );
					
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			//Str_ItoA( (npay+ncard_pay+none), sztmp, 10);
			Str_ItoA( (npay+none), sztmp, 10);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TATOL ), sztmp );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT SUM(ONCE_ACCOUNT) FROM C6101_PROMISE_ASSIGN WHERE AUTO_YN='Y' AND SEND_YN IN ('Y','S','D' )  ",  0, 0, 0 );
			g_Sql_RetStr(szSql, 15 ,sztmp );
			if( Str_Len(sztmp)  == 0)
			{
				Str_Cpy(sztmp, "0");
			}
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BACK ),    sztmp );
			
			//PRINT("REDRAW INIT_MAIN end", 0, 0, 0);
		
		}
		else if( m_bFirst == INIT_DETAIL )
		{
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA01), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA02), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA03), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA04), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA01), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA02), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA03), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA04), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy( sztmp, stMw.szCard_gaspay);
			if (Str_Cmp(sztmp, "" ) == 0) {
				Str_Cpy(sztmp, "0" );
			}
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA01 ), sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy( sztmp, stMw.szCash_gaspay);
			if (Str_Cmp(sztmp, "" ) == 0) {
				Str_Cpy(sztmp, "0" );
			}
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA02 ), sztmp );			
			
			
			if(stMw.szCard_onepay[0] == '2')
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szOnce_account);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA03 ), sztmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA04 ), "0" );
			}
			else if(stMw.szCard_onepay[0] == '1')
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szOnce_account);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA04 ), sztmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA03 ), "0" );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA04 ), "0" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA03 ), "0" );	
			}			
		}
		return TRUE;
	}
	
	//------------------------------------------------------------------
	bool TABLE_DRAW(void)
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	char sztmp[201];
	char szbuf[201];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		//PRINT("TABLE_DRAW start", 0, 0, 0);
		//g_Sql_RetInt("SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y' OR SEND_YN = 'D'  ", &m_lTotpage);
		g_Sql_RetInt("SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y'  ", &m_lTotpage);

		//PRINT("TABLE_DRAW step 1", 0, 0, 0);
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		//PRINT("TABLE_DRAW step 2", 0, 0, 0);
		SPRINT(m_szCnt_page, " %d/%d ", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PDA_DUTY, SEND_YN, CUST_NM, ACCOUNT, ONCE_ACCOUNT, AUTO_YN, PROMISE_ASSIGN_SEQ \
			,COUNTY,TOWN,VILLAGE_RI,ADDR1_M,ADDR1_S,  length(Trim(VILLAGE)) + length(Trim(BUILDING)), Trim(VILLAGE), Trim(BUILDING), HOUSE_CNT, ETC_ADDR \
			FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y' LIMIT ?, ?");
		//hstmt = sql->CreateStatement(sql, "SELECT PDA_DUTY, SEND_YN, CUST_NM, ACCOUNT, ONCE_ACCOUNT, AUTO_YN, PROMISE_ASSIGN_SEQ \
			//,COUNTY,TOWN,VILLAGE_RI,ADDR1_M,ADDR1_S,  length(Trim(VILLAGE)) + length(Trim(BUILDING)), Trim(VILLAGE), Trim(BUILDING), HOUSE_CNT, ETC_ADDR \
			//FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' OR SEND_YN = 'Y' OR SEND_YN = 'D' LIMIT ?, ?");

		//PRINT("TABLE_DRAW step 3", 0, 0, 0);
		if( hstmt == NULL )
		{
			PRINT("::C6101_RECEIPT TABLE_DRAW SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
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
			PRINT("::C6101_RECEIPT TABLE_DRAW SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
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
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				if( sztmp[0] == 'S' )
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 0 , RED);
				}
				else
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 0 , BLACK);
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 50, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 50, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 5, 'U', (long*)sztmp, 50, DECRYPT);
				if( sztmp[0] == 'Y' )
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 3 , RED);
				}
				else
				{
					DlgTbl_SetCellColor(TBL_FRCOLOR, ID_TBLLIST,  i, 3 , BLACK);
				}

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 6, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );		

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 7, 'U', (long*)szbuf, 100, DECRYPT);
				Str_Cpy(sztmp, szbuf );
				Str_Cpy(sztmp, " " );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 8, 'U', (long*)szbuf, 100, DECRYPT);
				Str_Cat(sztmp, szbuf );
				Str_Cat(sztmp, " " );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 9, 'U', (long*)szbuf, 100, DECRYPT);
				Str_Cat(sztmp, szbuf );
				Str_Cat(sztmp, " " );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 10, 'U', (long*)szbuf, 100, DECRYPT);
				Str_Cat(sztmp, szbuf );
				Str_Cat(sztmp, "-" );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 11, 'U', (long*)szbuf, 100, DECRYPT);
				Str_Cat(sztmp, szbuf );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 12, 'U', (long*)szbuf, 100, DECRYPT);
				if( Str_AtoI(szbuf) > 0)
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 13, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cpy(sztmp, szbuf );
					Str_Cpy(sztmp, " " );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 14, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat(sztmp, szbuf );
					Str_Cat(sztmp, "-" );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 15, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat(sztmp, szbuf );
				
				}
				else
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 15, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat(sztmp, szbuf );
					Str_Cat(sztmp, " " );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 16, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat(sztmp, szbuf );
				}
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
			}
		}
		ret = TRUE;
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			if(m_nActIndex == -1)
				m_nActIndex = 0;
			
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
			Str_Cpy( g_szCHK_EXEC_NUM , DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4)  );
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR ), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5)  );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2 ), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6)  );			
		}
		else
		{
			m_nActIndex = -1;
			Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
		}
		
		ON_DRAW();
		
		//PRINT("TABLE_DRAW end", 0, 0, 0);
		return ret;
	}
	
	//------------------------------------------------------------------
	long Load_Assign(char* assign_seq)
	{
	long i;
	long ret = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	
		PRINT("Load_Assign start", 0, 0, 0);
		
		Mem_Set((byte*)&stMw, 0x00, sizeof(stMw));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PROMISE_ASSIGN_SEQ, REG_FLAG,BRANCH_CD,CENTER_CD,ASSIGN_EMPID \
,CUST_NUM,USE_CONT_NUM,INST_PLACE_NUM,ZIP_SEQ,ETC_ADDR \
,CIVIL_SERV_CLASS_CD,PROMISE_YMD,PROMISE_TIME,END_EXPECT_TIME,JOB_STR_DTM \
,JOB_END_DTM,PROMISE_ASSIGN_DESC,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ,PROC_STS_CD \
,PDA_NUM,ONCE_PAY,SEND_YN,CIVIL_SERV_CLASS_NM,PDA_DUTY \
,REQ_TEL_DDD,REQ_TEL_EXN,REQ_TEL_NUM,REQ_CP_DDD,REQ_CP_EXN,REQ_CP_NUM \
,TRANS_IN_CUST_NM,TRANS_IN_SOC_NUM,REQ_NM,REQ_SOC_NUM,RECEIVE_DTM,CUST_TYPE_CD \
,CUST_NM,FIRM_NM,SOC_NUM,BIZ_REGI_NUM,CP_DDD,CP_EXN \
,CP_NUM,OWNHOUSE_TEL_DDD,OWNHOUSE_TEL_EXN,OWNHOUSE_TEL_NUM,FIRM_TEL_DDD \
,FIRM_TEL_EXN,FIRM_TEL_NUM,SCG_RELAT_CD,EMAIL,FAMILY_CNT \
,CUST_TRND_CD,CHK,BUILT_IN_YN,SQUARE_METER,CURR_ADDR_UNION \
,BLD_FLOOR,HOUSE_CNT,PDA_DUTY_FLAG,PAY_CALU,PDA_TRANS_FLAG \
,REQ_INFO_NUM,TRANS_IN_CUST_NUM,CONT_STS_CD,PDA_READ_DTM,MEMO \
,AUTO_YN,CUST_YN,BUR_YN,PROD_YN,ONCE_YN \
,PRICE_YN,ZIP_NO1,ZIP_NO2,CITY,COUNTY \
,TOWN,VILLAGE_RI,VILLAGE,TRIM(BUILDING) AS BUILDING,ADDR1_M \
,ADDR1_S,ACCOUNT,ONCE_ACCOUNT,CHK_TIME_FROM \
,CHK_TIME_END,MTR_CHG_YN,INFO_USE_AGREE_YN,PAS_USE_CONT_NUM_YN,ADJ_ALT_AMT \
,PAS_DEFRAY_ACCOUNT_NUM,PAS_CUST_NUM,PAS_REQ_INFO_NUM,APPRO_NUM,APPRO_TEL,ADJ_CAUSE \
,DEADLINE_FLAG,GMTR_BASE_DAY,CARD_GASPAY,CARD_ONEPAY,CASH_GASPAY \
,INFO_USE_YN,USE_CONT_DOC_YN,PAY_METHOD,DEFRAY_ACCOUNT_NUM,DEPOSITOR_NM \
,BANK_NM,DEBT_AMT,LAW_ETC_AMT,LAW_TOWN,NEW_ROAD_NM \
,NEW_ADDR_M,NEW_ADDR_S,NEW_ADDR_UNION,BILL_GUBUN,TRANS_CONN_YN \
,CONN_YN,BAR_YN,BAR_GBN,BAR_WHY,CHK_YN,CONN_GBN \
FROM C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = ? AND ( SEND_YN = 'S' OR SEND_YN = 'Y' OR SEND_YN = 'D' ) ");
		
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
//		sql->Commit(sql);
		DelSqLite(sql);
		
		PRINT("Load_Assign end", 0, 0, 0);
		
		return ret;
	}
	
	//----------------------------------------------------------------------
	void Load_CardData(char* assign_seq)
	{
	long i;
	char sztmp[10];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PROMISE_ASSIGN_SEQ,USE_CONT_NUM,ITEM_FLAG,REQ_YMD,RECEV_SEQ \
,DATA_FLAG,RSLT_CD,TERMINAL_GBN,TERMINAL_NUM,CARD_NUM \
,VALID_YM,CARD_COM,CARD_TYPE_NM,BUYING_COMP,BUYING_COMP_NM \
,APPROVAL_AMT,APPROVAL_NUM,ALLOTMENT_MM,APPROVAL_TIME \
,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ \
FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)assign_seq , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szItem_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szReq_ymd               ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRecev_seq             ,3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szData_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRslt_cd               ,1  +1, DECRYPT );
			Mem_Set((byte*)sztmp, 0x00,sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp                              ,2    , DECRYPT );
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
		}
Finally:

		DelSqLite(sql);
		return;
	}

	//------------------------------------------------------------------
	long Bill_Print_Result(void* p)
	{
		long* pRet = (long*)p;
		long nRet = *pRet;
	
		PRINT("%s", g_Printer_GetLastError(nRet),0,0);
	
		if( MessageBoxEx (CONFIRM_YESNO, "영수증 발행이 잘되었습니까?") == MB_OK )
		{
			;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "재발행 하시겠습니까?") == MB_OK )
			{
				m_bPrintAgain = TRUE;
				
				//재발행
				Bill_Pirnt();
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

		return 0;
	}	

	//------------------------------------------------------------------
	void Bill_Pirnt(void)
	{
		if( g_IsCardReader() )
		{
			MessageBoxEx (CONFIRM_OK, "블루투스 연결설정을 확인하세요.");
			return ;
		}
		
		if (m_bPrintAgain == FALSE)
		{
		  callBackfunc = NULL;
			m_pList = Bill_GetPirntData();
		}
		
		g_Printer_Start(m_pList, (void*)Bill_Print_Result);
	}
		
	//------------------------------------------------------------------
	void* Bill_GetPirntData(void)
	{
	CARRAYLIST list = NULL;
	long ret, idx, row;
	char LineSpace[]={0x1b,0x20,0x00};
	char szBuf[300];
	char szMsg[300];
	char sztmp[300];
	char szBillPreiod[200];
	char szFirstNm[32];
	char szLastNm[32];
	char szMtrNum[32];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
	long mtrcnt;
	long i, tot, len;
	long onceamt, payamt, nonpayamt;

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}
		
		if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0 || Str_AtoI(stMw.szAdj_alt_amt) > 0 )
		{
			list->append(list, "--------------------------------");
			list->append(list, "       영 수 증 (고 객 용)      ");
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
			
			PRINT("stMw.szPda_duty_flag:[%s], stMw.szTrans_in_cust_nm:[%s]", stMw.szPda_duty_flag, stMw.szTrans_in_cust_nm, 0);
			PRINT("stMw.szCont_sts_cd:[%s], stMw.szCust_nm:[%s]", stMw.szCont_sts_cd, stMw.szCust_nm, 0);
			
			if(Str_Cmp (stMw.szPda_duty_flag, "10") == 0) // 전입
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
			}
			else
			{
				// 기존 PDA 로직에서 전출인 경우 추가함
				if( Str_Cmp (stMw.szPda_duty_flag, "20") == 0 || Str_Cmp(stMw.szCont_sts_cd, "30") != 0)
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
				}
			}
			
			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
			}
					
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
			PRINT("@@ stMw.szAddr1_m:[%s], stMw.szAddr1_s:[%s]", stMw.szAddr1_m, stMw.szAddr1_s, 0);
			PRINT("@@ stMw.szVillage:[%s], stMw.szBuilding:[%s]", stMw.szVillage, stMw.szBuilding, 0);
			//szBuilding query 에서 trim 필요
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
						Str_Cpy( szMsg, "             ");
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
			
				PRINT("@@@ stMw.szAddr1_m:[%s], stMw.szAddr1_s:[%s]", stMw.szAddr1_m, stMw.szAddr1_s, 0);
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
			
			//계량기 중간정산 내역을 출력후 월미납액출력
			mtrcnt = 0;

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(sztmp, "SELECT COUNT(*) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( sztmp, &mtrcnt );
			
			nonpayamt = 0;
			for( i = 0 ; i < mtrcnt ; i++)
			{
				sql = NewSqLite();
		
				hdb = sql->Open(sql);
				if( hdb == NULL )
				{
					goto Finally2;
				}
				
				hstmt = sql->CreateStatement(sql, "select MTR_NUM, MTR_ID_NUM, CHK_YN, INDI_VC, TOT_USE_QTY, TOT_REVIS_QTY, SUPPLY_UNIT_ENER, \
ACCOUNT, USE_PERIOD_STR, USE_PERIOD_END  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");

				if( hstmt == NULL )
				{
					PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally2;
				}
				
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
				sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
				row = 1;
				sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
						
				if(sql->Execute(sql) == FALSE)
				{
					PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally2;
				}
				
				Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
				
				while( sql->Next(sql) == TRUE )
				{
					idx = 0;
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "계량기번호 : ");
					Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
					sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);
					Str_Cat( sztmp,  szMtrNum );
					g_Line_Print(list,  sztmp, "", "", LEFT, 0);
					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, " 기물번호  : ");
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,26+1, DECRYPT);
					Str_Cat(sztmp, szBuf );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
					
					if(szBuf[0] == '1' )//수납으로 표시
					{
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "지    침 : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,10+1, DECRYPT);
						Str_Cat(sztmp,  szBuf);
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "사 용 량 : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						Str_Cat(sztmp, szBuf );
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "보 정 량 : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						Str_Cat(sztmp, szBuf );
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "단위열량 : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						Str_Cat(sztmp, szBuf );
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
							
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(szBillPreiod, "  이사정산액");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						nonpayamt +=  Str_AtoI( szBuf );
						Str_Chg( szBuf, STRCHG_INS_COMMA);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)szMsg, 0x20, 14 );
						len = Str_Len(szBuf);
						Mem_Cpy((byte*)szMsg+14-len, (byte*)szBuf, len  );
						Str_Cat(szBillPreiod, szMsg );
						Str_Cat(szBillPreiod, "원\n" );
						
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
						g_Str_DateType(szMsg, szBuf);
						Str_Cat(szBillPreiod, "사용기간 : " );
						Str_Cat(szBillPreiod, szMsg );
						Str_Cat(szBillPreiod, " \n" );
						
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
						g_Str_DateType(szMsg, szBuf);
						Str_Cat(szBillPreiod, "          ∼ " );
						Str_Cat(szBillPreiod, szMsg );
						Str_Cat(szBillPreiod, " \n" );
					}
				};
				
		Finally2:
				//sql->Commit(sql);
				DelSqLite(sql);
				
				
				sql = NewSqLite();
		
				hdb = sql->Open(sql);
				if( hdb == NULL )
				{
					goto Finally3;
				}
			
				hstmt = sql->CreateStatement(sql, "select CHK, REQ_YM, UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
				if( hstmt == NULL )
				{
					PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally3;
				}
				
				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);
						
				if(sql->Execute(sql) == FALSE)
				{
					PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally3;
				}

				while( sql->Next(sql) == TRUE )
				{
					idx = 0;
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
					if(szBuf[0] == '1' )//월별미납 수납으로 표시
					{
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "  ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
						Mem_Set( (byte*)szMsg, 0x20, 13 );
						len = Str_Len(szBuf);
						Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
						Str_Cat(sztmp, szMsg );
						
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);							
						nonpayamt +=  Str_AtoI( szBuf );
						Str_Chg( szBuf, STRCHG_INS_COMMA);
						Str_Cat(szMsg, "원" );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)szMsg, 0x20, 14 );
						len = Str_Len(szBuf);
						Mem_Cpy((byte*)szMsg+14-len, (byte*)szBuf, len  );
						Str_Cat(sztmp, szMsg );
						g_Line_Print(list, sztmp,"","",LEFT,0);
					}
				};
		Finally3:
				//sql->Commit(sql);
				DelSqLite(sql);				
				
				if(Str_Len( szBillPreiod) > 0 )
					list->append(list, szBillPreiod);
			}

			if( Str_AtoI(stMw.szAdj_alt_amt) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "소      계 :  ");
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_ItoA( nonpayamt,szBuf ,10);
				Str_Cat(sztmp,  szBuf);
				Str_Chg(szBuf, STRCHG_INS_COMMA);
				Str_Cat(sztmp, "원" );
				g_Line_Print(list, sztmp,"","",LEFT,0);
				list->append(list, "--------------------------------");
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "예수금대체 :     - ");
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_Cpy( szBuf, stMw.szAdj_alt_amt);
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(sztmp, szBuf );
				Str_Cat(sztmp, "원" );
				g_Line_Print(list, sztmp,"","",LEFT,0);
				list->append(list, "--------------------------------");
			}

			if( (Str_AtoI(stMw.szCard_gaspay) + Str_AtoI(stMw.szCash_gaspay) ) > 0  || Str_AtoI(stMw.szAdj_alt_amt) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "① 가스 사용료계 :  ");
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_ItoA( Str_AtoI(stMw.szCard_gaspay) + Str_AtoI(stMw.szCash_gaspay) , szBuf ,10);
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(sztmp, szBuf );
				Str_Cat(sztmp, "원" );
				g_Line_Print(list, sztmp,"","",LEFT,0);
				list->append(list, "--------------------------------");
			
				if( Str_AtoI(stMw.szCash_gaspay)  > 0   )
				{					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "[현 금] :  ");
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_Cpy(szBuf, stMw.szCash_gaspay);	
					Str_Chg( szBuf, STRCHG_INS_COMMA);
					Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 12 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg+12-len, (byte*)szBuf, len  );
					Str_Cat(sztmp, szMsg );
					Str_Cat(sztmp, "원" );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					//list->append(list, "--------------------------------");
					if(Str_Cmp (stMw.szPda_duty_flag, "30") == 0)
					{
						list->append(list, "--------------------------------");
						list->append(list, "※ 중지 후 요금청구 금액이      ");
						list->append(list, "   발생될 수 있으니 참고        ");
						list->append(list, "   하시길 바랍니다.             ");
						list->append(list, "--------------------------------");
					}
				}
		
				if(  Str_AtoI(stMw.szCard_gaspay) > 0 && Str_Len(stCardinfo.szApproval_num) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "[카 드] :  ");
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 12 );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Str_Cat( szBuf, stMw.szCard_gaspay);
					Str_Chg( szBuf, STRCHG_INS_COMMA );
					ret = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg+12-ret, (byte*)szBuf, ret  );
					Str_Cat(sztmp, szMsg);
					Str_Cat(sztmp, "원");
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
					if(Str_Cmp (stMw.szPda_duty_flag, "30") == 0)
					{
						list->append(list, "--------------------------------");
						list->append(list, "※ 중지 후 요금청구 금액이      ");
						list->append(list, "   발생될 수 있으니 참고        ");
						list->append(list, "   하시길 바랍니다.             ");
						list->append(list, "--------------------------------");
					}
				}
				
				if( Str_AtoI(stMw.szOnce_account) == 0 )
				{
					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "총계(①) :   ");
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_ItoA( Str_AtoI(stMw.szCard_gaspay) + Str_AtoI(stMw.szCash_gaspay) , szBuf ,10);
					Str_Chg( szBuf, STRCHG_INS_COMMA);
					Str_Cat(sztmp, szBuf );
					Str_Cat(sztmp, "원" );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "수납금액 :  ");
					Str_Cat(sztmp, szBuf );
					Str_Cat(sztmp, "원" );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "수납일자 :  ");
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_ItoA(Time_GetDate(), szBuf, 10);
					g_Str_DateType( szMsg, szBuf);
					Str_Cat(sztmp, szMsg );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					list->append(list, "--------------------------------");	
				}
			}
			BT_Print_Spool(TRUE);
			VmSleep(200);
			BT_Clear_Spool();		
		}
		
		//연결철거비
		if( Str_AtoI(stMw.szOnce_account) > 0 )
		{
			list->append(list, "                                ");
			list->append(list, "      연결철거비(고 객 용)      ");
			list->append(list, "--------------------------------");
			list->append(list, "        서울도시가스(주)        ");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "  ");
			Str_Cat(sztmp, stUserinfo.szcenter_nm );	
			Str_Cat(sztmp, " 고객센타");
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
							
			if( Str_Len(stMw.szAppro_num) > 0)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, "현금승인번호: ");
				Str_Cat(sztmp, stMw.szAppro_num );	
				g_Line_Print(list, sztmp,"","",LEFT,0);
			
				if( stMw.szOnce_yn[0] == '2' )
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Str_Cpy(sztmp,"              지출증빙");
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
				else
				{
					if(Str_Cmp( stMw.szAppro_tel,"0100001234") == 0)
					{
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Str_Cpy(sztmp, "  ");
						Str_Cat(sztmp, stMw.szAppro_tel );
						Str_Cat(sztmp, "소득공제[자진발급]" );
						g_Line_Print(list, sztmp,"","",LEFT,0);
					}
					else
					{
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Str_Cpy(szBuf, stMw.szAppro_tel );
						Mem_Cpy((byte*)szBuf+6, (byte*)"*****" , 5 );
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Str_Cpy(sztmp, "  ");
						Str_Cat(sztmp, szBuf );
						Str_Cat(sztmp, "소득공제" );
						g_Line_Print(list, sztmp,"","",LEFT,0);
					}
				}
			}
		
			list->append(list, "--------------------------------");
			Mem_Set( (byte*)szFirstNm, 0x00, sizeof(szFirstNm) );
			Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm));
			
			if(Str_Cmp (stMw.szPda_duty_flag, "10") == 0)
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
			}
			else
			{
				if(Str_Cmp(stMw.szCont_sts_cd, "30") != 0)
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
				}
			}
			
			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
			}
					
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
				Str_Cpy(sztmp, "             ");
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
						Str_Cpy( szMsg, "             ");
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

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "검침일/납기 : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "일/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "납기");
			g_Line_Print(list, sztmp,"","",LEFT,0);				
			//일회성항목 출력
		
			sql = NewSqLite();

			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally4;
			}
		
			hstmt = sql->CreateStatement(sql, "select B.ONCE_ITEM_NM, A.ONCE_AMT \
	FROM C6101_ONCE_INFO A , C6101_ONCE_ITEM B WHERE A.PROMISE_ASSIGN_SEQ = ? AND A.ONCE_ITEM_CD = B.ONCE_ITEM_CD AND A.ONCE_QTY > 0 ");
			
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}
			onceamt = 0;
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,50+1, DECRYPT);
				Str_Cpy(sztmp, "  ");						
				Mem_Set( (byte*)szMsg, 0x20, 18 );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg );
					
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);							
				onceamt +=  Str_AtoI( szBuf );
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(szBuf, "원" );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 9 );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+9-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg );
				g_Line_Print(list, sztmp,"","",LEFT,0);
			};
			
	Finally4:
			//sql->Commit(sql);
			DelSqLite(sql);	

			tot = Str_AtoI(stMw.szOnce_account);
			i = tot*10/110;
			tot = tot-i;
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "   공 급   가 액 :  ");
			Str_ItoA( tot, szBuf ,10 );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 7 );
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			len = Str_Len(szBuf);
			Mem_Cpy((byte*)szMsg+7-len, (byte*)szBuf, len  );
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "원");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "   부    가   세 :  ");
			Str_ItoA( i, szBuf ,10 );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 7 );
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			len = Str_Len(szBuf);
			Mem_Cpy((byte*)szMsg+7-len, (byte*)szBuf, len  );
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "원");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0 || Str_AtoI(stMw.szAdj_alt_amt) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "② 연결 철거비계 :  ");
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 7 );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+7-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				Str_Cat(sztmp, "원");
				g_Line_Print(list, sztmp,"","",LEFT,0);
							
			}
			else
			{									
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "① 연결 철거비계 :  ");
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 7 );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+7-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				Str_Cat(sztmp, "원");
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}

			list->append(list, "--------------------------------");

			if( stMw.szCard_onepay[0] == '1' )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "[현 금] :  ");
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 12 );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				ret = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+12-ret, (byte*)szBuf, ret  );
				Str_Cat(sztmp, szMsg);
				Str_Cat(sztmp, "원");
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			else if( stMw.szCard_onepay[0] == '2' )
			{					
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "[카 드] :  ");
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 12 );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				ret = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+12-ret, (byte*)szBuf, ret  );
				Str_Cat(sztmp, szMsg);
				Str_Cat(sztmp, "원");
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
			}
			
			if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0  || Str_AtoI(stMw.szAdj_alt_amt) > 0)
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cpy(sztmp, "총계(①+②) :  ");
				Str_ItoA(  Str_AtoI(stMw.szOnce_account) + Str_AtoI(stMw.szCash_gaspay ) +Str_AtoI(stMw.szCard_gaspay ), szBuf ,10 );
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(sztmp, szBuf);
				Str_Cat(sztmp, "원");
				g_Line_Print(list, sztmp,"","",LEFT,0);		
			}
			else
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cpy(sztmp, "총계(①) :  ");
				Str_ItoA(  Str_AtoI(stMw.szOnce_account), szBuf ,10 );
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(sztmp, szBuf);
				Str_Cat(sztmp, "원");
				g_Line_Print(list, sztmp,"","",LEFT,0);	
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "수납금액 :  ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "원");
			g_Line_Print(list, sztmp,"","",LEFT,0);	
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_Cat(sztmp, "수납일자 :  ");
			Str_ItoA(Time_GetDate(), szBuf, 10);
			g_Str_DateType( szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, " ");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");	
			
			list->append(list, "[서비스 품질 보증기간]          ");
			list->append(list, "1. 연소기 연결 시공 후 2년 이내 ");
			list->append(list, "   제품이상 발생 시 (기존 사용  ");
			list->append(list, "   제품은 해당 없음) 무상으로 재");
			list->append(list, "   시공해 드립니다.             ");
			list->append(list, "2. 소비자 부주의에 의한 품질 훼 ");
			list->append(list, "   손 및 관리 잘못에 의한 변형, ");
			list->append(list, "   제품 보증기간(2년)이 경과한  ");
			list->append(list, "   신규제품은 보상의 책임을 지지");
			list->append(list, "   않으며, 재 시공시 서비스 비용");
			list->append(list, "   을 부담하셔야 합니다.        ");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "소비자상담실 : ");
			Str_Cat(sztmp, stUserinfo.sztel );	
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
	
	//edit 한글체크
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
}



