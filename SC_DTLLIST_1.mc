/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_DTLLIST_1
{
	#include <include.h>
	#include "globalcard.h"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR1 )		//지번 주소
		DEF_BUTTON_ID ( BID_ADDR2 )		//도로명 주소
		DEF_BUTTON_ID ( BID_CALL )		//전화 방문
		DEF_BUTTON_ID ( BID_SMS )		//SMS 발송
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
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
		DEF_OBJECT_ID ( TXT_DAY )		//요일
		DEF_OBJECT_ID ( TXT_TIME )		//시간
		DEF_OBJECT_ID ( TXT_ADDR )		//
		DEF_OBJECT_ID ( TXT_ADDR2 )		//
		DEF_OBJECT_ID ( TXT_ADDR3 )		//
		DEF_OBJECT_ID ( TXT_PAGE )		//페이지
		
		DEF_OBJECT_ID ( CMB_DAY )		//요일 콤보박스
		DEF_OBJECT_ID ( CMB_TIME = CMB_DAY+3 )		//시간 콤보박스
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table의 행개수
	#define		COL 	    4					// table의 열개수
	#define		GRID_H		(CHT+10)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+330  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"주소",	 CWD*18, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"요일",     CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"시간",     CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"전화번호", CWD*9,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};		
	
	#define INIT_MAIN	1
	
	void SetStyle(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		
		//화면 공통 메뉴
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "메뉴"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "자판"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "화면"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"공통"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "이전"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "종료"),
		
		DLG_BUTTON(STARTX+555, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+775, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),		
		DLG_BUTTON(STARTX, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR1, "지번주소"),
		DLG_BUTTON(STARTX+235, STARTY+260, 270, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명주소"),
		DLG_BUTTON(STARTX+510, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CALL, "전화방문"),
		DLG_BUTTON(STARTX+745, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS발송"),
		
		DLG_TEXT(STARTX, STARTY, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""), 		
		DLG_TEXT(STARTX+175, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DAY, "요일"),		
		DLG_TEXT(STARTX+575, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TIME, "시간"),	
		DLG_TEXT(STARTX, STARTY+60, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		
		DLG_TEXT(STARTX, STARTY+120, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		DLG_TEXT(STARTX, STARTY+190, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, " 1/10 "),
		
		DLG_COMBO (STARTX+325, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DAY, 10),	//요일
		DLG_COMBO (STARTX+725, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_TIME, 10),	//시간
		
		// 리스트		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		
		//화면 공통 메뉴
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "메뉴"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "자판"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "화면"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"공통"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "이전"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "종료"),
		
		DLG_BUTTON(STARTX+555, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "▲"),
		DLG_BUTTON(STARTX+775, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▼"),		
		DLG_BUTTON(STARTX, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR1, "지번주소"),
		DLG_BUTTON(STARTX+235, STARTY+260, 270, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명주소"),
		DLG_BUTTON(STARTX+510, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CALL, "전화방문"),
		DLG_BUTTON(STARTX+745, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS발송"),
		
		DLG_TEXT(STARTX, STARTY, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""), 		
		DLG_TEXT(STARTX+175, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DAY, "요일"),		
		DLG_TEXT(STARTX+575, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TIME, "시간"),	
		DLG_TEXT(STARTX, STARTY+60, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		
		DLG_TEXT(STARTX, STARTY+120, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		DLG_TEXT(STARTX, STARTY+190, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, " 1/10 "),
		
		DLG_COMBO (STARTX+325, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DAY, 10),	//요일
		DLG_COMBO (STARTX+725, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_TIME, 10),	//시간
		
		// 리스트		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),

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
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:	
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "화요일", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "수요일", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME+2), "17시", 0, ICON_NONE);
						SetStyle();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "화요일", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "수요일", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME+2), "17시", 0, ICON_NONE);
						SetStyle();
						break;		
				}
				break;
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}	

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_ADDR1:
//				g_nWorkFlag = ;
//				Card_Move("");				
				break;				
			case BID_ADDR2:
				break;			
			case BID_CALL:
				break;
			case BID_SMS:
				break;
			case BID_HOME:
//				g_nWorkFlag = ;
				Card_Move("MENU");			
				break;
			case BID_MENU:
//				g_nWorkFlag = ;
				Card_Move("SC_MENU");				
				break;
			case BID_KEYBOARD:
				Card_Move("SC_ENTRY");
				break;
			case BID_SCREEN:
				Card_Move("SC_APPOINTSC");
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
//				g_nWorkFlag = ;
				Card_Move("SC_GRPLIST");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}		
}


