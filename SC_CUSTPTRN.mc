/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_CUSTPTRN
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_MEMO )		
		DEF_BUTTON_ID ( BID_ENTRY )
		DEF_BUTTON_ID ( BID_CLOSE )	
		DEF_BUTTON_ID ( BID_SCHDL )	
		DEF_BUTTON_ID ( BID_BOX1 )
		DEF_BUTTON_ID ( BID_BOX2 )
		DEF_BUTTON_ID ( BID_BOX3 )
		//DEF_BUTTON_ID ( BID_BOX4 )
		//DEF_BUTTON_ID ( BID_BOX5 )
		DEF_BUTTON_ID ( BID_BOX6 )
		DEF_BUTTON_ID ( BID_BOX7 )
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
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		//DEF_OBJECT_ID ( TXT_DATA11 ) //인덕션
		//DEF_OBJECT_ID ( TXT_DATA12 ) //인덕션
		//DEF_OBJECT_ID ( TXT_DATA13 ) //인덕션
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		DEF_OBJECT_ID ( TXT_DATA22 )
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		
		DEF_OBJECT_ID ( ICON_TITLE )
		
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2 + 3 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	long m_bFirst;
	long m_lSelIndex = -1;
	long m_lLstpage = 0;
	long m_ltotLstcnt = 0;
	char m_Title[30];
	char m_szLstCnt_page[10];
	char m_szOutPlanYmd[20];
	
	void SetStyle(void);
	void SetBtnImg(void);
	void SetCustPtrn(void);
	void REDRAW(void);
	bool Save_Pattern(void);
	void SaveInput(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.


	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객패턴수집"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,      STARTY+770, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO,  "메모"),
		DLG_BUTTON(STARTX+600,  STARTY+770, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ENTRY, "등록"),
		
		DLG_TEXT ( STARTX,	    STARTY-20, 1000, 70, 0,0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, "◎고객 희망 점검방문 정보"),
		
		DLG_TEXT ( STARTX,	     STARTY+60, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "희망요일"),
		DLG_TEXT ( STARTX,	    STARTY+130, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "희망시간"),
		
		DLG_TEXT ( STARTX,	    STARTY+200, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "방문구분"),
		DLG_BUTTON(STARTX,      STARTY+270, 170, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1, CHKOFF),
		DLG_TEXT ( STARTX+170,	STARTY+270, 160, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "전화"),
		DLG_BUTTON(STARTX+330,  STARTY+270, 170, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2, CHKOFF),
		DLG_TEXT ( STARTX+500,	STARTY+270, 160, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "문자"),
		DLG_BUTTON(STARTX+660,  STARTY+270, 170, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3, CHKOFF),
		DLG_TEXT ( STARTX+830,	STARTY+270, 170, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "미약속"),
		
		DLG_TEXT ( STARTX,  	STARTY+340, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "비상연락"),
		DLG_TEXT ( STARTX+525,	STARTY+340,  50, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, "-"),
		DLG_EDIT ( STARTX+575,  STARTY+340, 180, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT ( STARTX+755,	STARTY+340,  50, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, "-"),
		DLG_EDIT ( STARTX+805,  STARTY+340, 195, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		/*
		DLG_TEXT ( STARTX,	    STARTY+410, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "인덕션"),
		DLG_BUTTON(STARTX+250,  STARTY+410, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4, CHKOFF),
		DLG_TEXT ( STARTX+350,	STARTY+410,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, "Y"),
		DLG_BUTTON(STARTX+430,  STARTY+410, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX5, CHKOFF),
		DLG_TEXT ( STARTX+530,	STARTY+410,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, "N"),
		*/
		DLG_TEXT ( STARTX,	    STARTY+480, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "전출예정"),
		DLG_BUTTON(STARTX+250,  STARTY+480, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX6, CHKOFF),
		DLG_TEXT ( STARTX+350,	STARTY+480,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "Y"),
		DLG_BUTTON(STARTX+430,  STARTY+480, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX7, CHKOFF),
		DLG_TEXT ( STARTX+530,	STARTY+480,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, "N"),
		DLG_TEXT ( STARTX+620,	STARTY+480, 255, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_BUTTON(STARTX+875,  STARTY+480, 125, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),
		
		DLG_TEXT ( STARTX,	    STARTY+560, 975, 70, 0,0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, "◎이전 수집정보"),
		
		DLG_TEXT ( STARTX,	    STARTY+640, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "수집일자"),
		DLG_TEXT ( STARTX+250,	STARTY+640, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT ( STARTX+550,	STARTY+640, 200, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "수집자"),
		DLG_TEXT ( STARTX+750,	STARTY+640, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		
		DLG_COMBO (STARTX+250,   STARTY+60, 750, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+250,  STARTY+130, 750, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		DLG_COMBO (STARTX+250,  STARTY+340, 275, 200, 120, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
	};

	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객패턴수집"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,      STARTY+750, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO,  "메모"),
		DLG_BUTTON(STARTX+600,  STARTY+750, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ENTRY, "등록"),
		
		DLG_TEXT ( STARTX,	     STARTY-40, 1000, 70, 0,0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, "◎고객 희망 점검방문 정보"),
		
		DLG_TEXT ( STARTX,	     STARTY+30, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "희망요일"),
		DLG_TEXT ( STARTX,	    STARTY+100, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "희망시간"),
		
		DLG_TEXT ( STARTX,	    STARTY+170, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "방문구분"),
		DLG_BUTTON(STARTX,      STARTY+240, 160, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1, CHKOFF),
		DLG_TEXT ( STARTX+160,	STARTY+240, 170, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "전화"),
		DLG_BUTTON(STARTX+330,  STARTY+240, 160, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2, CHKOFF),
		DLG_TEXT ( STARTX+490,	STARTY+240, 170, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "문자"),
		DLG_BUTTON(STARTX+660,  STARTY+240, 170, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3, CHKOFF),
		DLG_TEXT ( STARTX+830,	STARTY+240, 170, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "미약속"),
		
		DLG_TEXT ( STARTX,  	STARTY+310, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "비상연락"),
		DLG_TEXT ( STARTX+550,	STARTY+310,  50, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, "-"),
		DLG_EDIT ( STARTX+600,  STARTY+310, 175, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT ( STARTX+775,	STARTY+310,  50, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, "-"),
		DLG_EDIT ( STARTX+825,  STARTY+310, 175, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		/*
		DLG_TEXT ( STARTX,	    STARTY+380, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "인덕션"),
		DLG_BUTTON(STARTX+250,  STARTY+380, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4, CHKOFF),
		DLG_TEXT ( STARTX+350,	STARTY+380,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, "Y"),
		DLG_BUTTON(STARTX+430,  STARTY+380, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX5, CHKOFF),
		DLG_TEXT ( STARTX+530,	STARTY+380,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, "N"),
		*/
		DLG_TEXT ( STARTX,	    STARTY+450, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "전출예정"),
		DLG_BUTTON(STARTX+250,  STARTY+450, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX6, CHKOFF),
		DLG_TEXT ( STARTX+350,	STARTY+450,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "Y"),
		DLG_BUTTON(STARTX+430,  STARTY+450, 100, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX7, CHKOFF),
		DLG_TEXT ( STARTX+530,	STARTY+450,  80, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, "N"),
		DLG_TEXT ( STARTX+610,	STARTY+450, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_BUTTON(STARTX+860,  STARTY+450, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "▼"),
		
		DLG_TEXT ( STARTX,	    STARTY+550, 1000, 70, 0,0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, "◎이전 수집정보"),
		
		DLG_TEXT ( STARTX,	    STARTY+620, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "수집일자"),
		DLG_TEXT ( STARTX+250,	STARTY+620, 275, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT ( STARTX+525,	STARTY+620, 200, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "수집자"),
		DLG_TEXT ( STARTX+725,	STARTY+620, 275, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		
		DLG_COMBO (STARTX+250,   STARTY+30, 750, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+250,  STARTY+100, 750, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		DLG_COMBO (STARTX+250,  STARTY+310, 300, 200, 120, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
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
		char szSql[400];
	
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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				
				SetBtnImg();
				SetStyle();

				if( g_nMemoFlag == 2 )
				{
					REDRAW();
					g_nMemoFlag = 0;
				}
				else
				{
					SetCustPtrn();
					REDRAW();
				}
				break;
		}
	}

//------------------------------------------------------------------
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);	
	}

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		//숫자만 입력 가능
		if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
		{
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
				return;
			}
		}
	}

//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		m_lActiveIndex = lActiveIndex;

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+575) && X < DMS_X(STARTX+755) && Y > DMS_Y(STARTY+340) && Y < DMS_Y(STARTY+410) ||
				    X > DMS_X(STARTX+805) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+340) && Y < DMS_Y(STARTY+410) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )	
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
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char szTmp[20];
		char szDay[20];
	
		switch(ID)
		{
			case BID_ENTRY:
				if( Save_Pattern() )
				{
					if( g_lPtrnFlag == 1 )
					{
						g_lPtrnFlag = 0;
						Card_Move("SC_CONFIRM");
					}
					else if( g_lPtrnFlag == 2 )
					{
						g_lPtrnFlag = 0;
						Card_Move("SC_CUSTINFO");
					}
				}
				break;
			case BID_MEMO:
				g_nMemoFlag = 2;
				SaveInput();
				Card_Move("CM_MRGMEMO");
				break;
			case BID_CLOSE:
				if( g_lPtrnFlag == 1 )
				{
					g_lPtrnFlag = 0;
					Card_Move("SC_CONFIRM");
				}
				else if( g_lPtrnFlag == 2 )
				{
					g_lPtrnFlag = 0;
					Card_Move("SC_CUSTINFO");
				}
				break;
			case BID_SCHDL:
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
					Str_ItoA( d, szTmp, 10);
					g_Str_DateType(szDay, szTmp);
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), szDay );
				}
				break;
			case BID_BOX1:
				Str_Cpy(stCustPtrn.CHK_VISIT_GBN, "1");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				break;
			case BID_BOX2:
				Str_Cpy(stCustPtrn.CHK_VISIT_GBN, "2");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				break;
			case BID_BOX3:
				Str_Cpy(stCustPtrn.CHK_VISIT_GBN, "3");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKON);
				break;
			//인덕션
			/*
			case BID_BOX4:
				Str_Cpy(stCustPtrn.INDU_YN, "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKOFF);
				break;
			case BID_BOX5:
				Str_Cpy(stCustPtrn.INDU_YN, "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKON);
				break;
			*/
			//전출예정
			case BID_BOX6:
				Str_Cpy(stCustPtrn.OUT_PLAN_YN, "Y");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKOFF);
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA17), TRUE);
				break;
			case BID_BOX7:
				Str_Cpy(stCustPtrn.OUT_PLAN_YN, "N");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKON);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), "" );
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA17), FALSE);
				break;
		}
	}

	/*=======================================================================================
	함수명 : SearchStr
	기  능 : 스트링으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
	long	SearchStr( char *Str, CodeTable *CT)
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


//-------------------------------------------------------------------------------------------------------	
	void SetCustPtrn(void)
	{
		long i, idx;
		char szSql[500];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stCustPtrn, 0x00, sizeof(stCustPtrn));
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
SPRINT(szSql, "SELECT CHK_YEAR, CHK_ORDER, CHK_TYPE, BLD_NUM, INST_PLACE_NUM, UPD_EMPID, UPD_IP, CUST_NUM \
, USE_CONT_NUM, CHK_VISIT_GBN, CHK_WISH_WEEK, CHK_WISH_TIME, EMR_DDD, EMR_EXN, EMR_NUM \
, OUT_PLAN_YN, OUT_PLAN_YMD, COLL_YMD, COLL_EMPID, COLL_EMPNM, SEND_YN \
FROM CUST_PATT_COLL_INFO WHERE BLD_NUM = ? AND INST_PLACE_NUM = ? "
, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stSc.BLD_NUM , 9, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stSc.INST_PLACE_NUM , 9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.CHK_YEAR      	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.CHK_ORDER     	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.CHK_TYPE      	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.BLD_NUM       	, 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.INST_PLACE_NUM	, 29 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.UPD_EMPID     	, 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.UPD_IP        	, 232+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.CUST_NUM      	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.USE_CONT_NUM  	, 210+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.CHK_VISIT_GBN 	, 21 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.CHK_WISH_WEEK 	, 21 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.CHK_WISH_TIME 	, 21 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.EMR_DDD       	, 24 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.EMR_EXN       	, 24 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.EMR_NUM       	, 24 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.OUT_PLAN_YN   	, 21 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.OUT_PLAN_YMD  	, 28 + 1, DECRYPT );
			//sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.INDU_YN       	, 21 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.COLL_YMD      	, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.COLL_EMPID    	, 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.COLL_EMPNM    	, 220+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stCustPtrn.SEND_YN       	, 1  + 1, DECRYPT );
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}

//------------------------------------------------------------------
	void REDRAW(void)
	{
		long i;
		char szDay[20];

		//요일
		for ( i = 0 ;  PTRN_DAY[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), PTRN_DAY[i].Str, 0, ICON_NONE);
		}
		//시간
		for ( i = 0 ;  PTRN_TIME[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), PTRN_TIME[i].Str, 0, ICON_NONE);
		}
		//비상연락망
		for ( i = 0 ;  SCSMSTEL[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCSMSTEL[i].Str, 0, ICON_NONE);
		}

		//희망요일
		i = SearchCD( stCustPtrn.CHK_WISH_WEEK, PTRN_DAY );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), PTRN_DAY[i].Str);		
		}
		
		//희망시간
		i = SearchCD( stCustPtrn.CHK_WISH_TIME, PTRN_TIME );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), PTRN_TIME[i].Str);		
		}
		
		//방문구분
		if( Str_Cmp(stCustPtrn.CHK_VISIT_GBN, "1") == 0 )
		{
			OnButton(BID_BOX1);
		}
		else if( Str_Cmp(stCustPtrn.CHK_VISIT_GBN, "2") == 0 )
		{
			OnButton(BID_BOX2);
		}
		else if( Str_Cmp(stCustPtrn.CHK_VISIT_GBN, "3") == 0 )
		{
			OnButton(BID_BOX3);
		}
		//비상연락망
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA3), stCustPtrn.EMR_DDD );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), stCustPtrn.EMR_EXN );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), stCustPtrn.EMR_NUM );

		/*
		//인덕션
		if( Str_Cmp(stCustPtrn.INDU_YN, "Y") == 0 )
		{
			OnButton(BID_BOX4);
		}
		else if( Str_Cmp(stCustPtrn.INDU_YN, "N") == 0 )
		{
			OnButton(BID_BOX5);
		}
		*/
		//전출예정
		if( Str_Cmp(stCustPtrn.OUT_PLAN_YN, "Y") == 0 )
		{
			OnButton(BID_BOX6);
		}
		else //if( Str_Cmp(stCustPtrn.OUT_PLAN_YN, "N") == 0 )
		{
			OnButton(BID_BOX7);
		}
		//전출예정일
		if( Str_Len(stCustPtrn.OUT_PLAN_YMD) > 0 )
		{
			Mem_Set((byte*)m_szOutPlanYmd, 0x00, sizeof(m_szOutPlanYmd));
			g_Str_DateType(m_szOutPlanYmd, stCustPtrn.OUT_PLAN_YMD);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), m_szOutPlanYmd );
		}
		//수집일자
		if( Str_Len(stCustPtrn.COLL_YMD) > 0 )
		{
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			g_Str_DateType(szDay, stCustPtrn.COLL_YMD);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), szDay );
		}
		//수집자
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), stCustPtrn.COLL_EMPNM );
		
		return;
	}
	
//----------------------------------------------------------------------------------------
	bool Save_Pattern(void)
	{
		bool ret = TRUE;
		long idx, i;
		long lCnt = 0;
		char szSql[700];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
/*
		//희망요일, 시간 필수 입력
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "희망요일을 입력해주세요.");
			ret = FALSE;
			goto Finally2;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "희망시간을 입력해주세요.");
			ret = FALSE;
			goto Finally2;
		}
*/
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 && 
		    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 && 
		    Str_Len(stCustPtrn.CHK_VISIT_GBN) == 0 && 
		    Str_Len(stCustPtrn.INDU_YN) == 0
		  )
		{
			MessageBoxEx (CONFIRM_OK, "입력된 정보가 없습니다.");
			ret = FALSE;
			goto Finally2;
		}

		if( MessageBoxEx (CONFIRM_YESNO, "등록하시겠습니까?") == MB_OK)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM CUST_PATT_COLL_INFO WHERE BLD_NUM = '%s' AND INST_PLACE_NUM = '%s' ", stSc.BLD_NUM, stSc.INST_PLACE_NUM, 0);
			g_Sql_RetInt(szSql, &lCnt);	

			//희망요일
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), PTRN_DAY );
			if (i == -1)
			{
				Str_Cpy(stCustPtrn.CHK_WISH_WEEK, "");
			}
			else
			{
				Str_Cpy(stCustPtrn.CHK_WISH_WEEK, PTRN_DAY[i].Code);
			}

			//희망시간
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), PTRN_TIME );
			if (i == -1)
			{
				Str_Cpy(stCustPtrn.CHK_WISH_TIME, "");
			}
			else
			{
				Str_Cpy(stCustPtrn.CHK_WISH_TIME, PTRN_TIME[i].Code);
			}

			//비상연락망
			Str_Cpy(stCustPtrn.EMR_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)));
			Str_Cpy(stCustPtrn.EMR_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cpy(stCustPtrn.EMR_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			
			//전출예정일
			Str_Cpy(m_szOutPlanYmd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA17)));
			Str_Chg(m_szOutPlanYmd, STRCHG_DEL_NONDIGIT);
			Str_Cpy(stCustPtrn.OUT_PLAN_YMD, m_szOutPlanYmd);
			
			//수집일자
			Str_ItoA(Time_GetDate(), stCustPtrn.COLL_YMD, 10);
			
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				ret = FALSE;
				goto Finally;
			}

			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Str_Cpy(szSql, "UPDATE CUST_PATT_COLL_INFO SET \
UPD_EMPID = ?, UPD_IP = ?, CUST_NUM = ?, USE_CONT_NUM = ?, CHK_VISIT_GBN = ? \
, CHK_WISH_WEEK = ?, CHK_WISH_TIME = ?, EMR_DDD = ?, EMR_EXN = ?, EMR_NUM = ? \
, OUT_PLAN_YN = ?, OUT_PLAN_YMD = ?, COLL_YMD = ?, COLL_EMPID = ?, COLL_EMPNM = ?, SEND_YN = 'S' \
 WHERE BLD_NUM = ? AND INST_PLACE_NUM = ? "
                        );
			}
			else
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO CUST_PATT_COLL_INFO \
( UPD_EMPID, UPD_IP, CUST_NUM, USE_CONT_NUM, CHK_VISIT_GBN, CHK_WISH_WEEK, CHK_WISH_TIME \
, EMR_DDD, EMR_EXN, EMR_NUM, OUT_PLAN_YN, OUT_PLAN_YMD, COLL_YMD, COLL_EMPID \
, COLL_EMPNM, SEND_YN, BLD_NUM, INST_PLACE_NUM, CHK_YEAR, CHK_ORDER, CHK_TYPE ) \
VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ? \
      , ?, ?, ?, ?, ?, ?, 'S', ?, ?, ? \
      , ?, ? ) "
                       );
			}
			
			hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id     ,9  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip		    ,32 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CUST_NUM                ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.USE_CONT_NUM    	    ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.CHK_VISIT_GBN 	,1  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.CHK_WISH_WEEK 	,1  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.CHK_WISH_TIME 	,1  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.EMR_DDD       	,4  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.EMR_EXN       	,4  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.EMR_NUM       	,4  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.OUT_PLAN_YN   	,1  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.OUT_PLAN_YMD  	,8  ,DECRYPT);
			//sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.INDU_YN       	,1  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCustPtrn.COLL_YMD      	,8  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id     ,9  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor          ,20 ,DECRYPT );

			sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       	        ,9  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM	        ,9  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      	        ,4  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     	        ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      	        ,2  ,DECRYPT);

			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "등록이 완료되었습니다.");
			}
		}
		else
		{
			ret = FALSE;
			goto Finally2;
		}
		
Finally:
		DelSqLite(sql);

Finally2:
		return ret;
	}
	
	
//----------------------------------------------------------------------------------------
	void SaveInput(void)
	{
		long i;
	
		//희망요일
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), PTRN_DAY );
		if (i == -1)
		{
			Str_Cpy(stCustPtrn.CHK_WISH_WEEK, "");
		}
		else
		{
			Str_Cpy(stCustPtrn.CHK_WISH_WEEK, PTRN_DAY[i].Code);
		}

		//희망시간
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), PTRN_TIME );
		if (i == -1)
		{
			Str_Cpy(stCustPtrn.CHK_WISH_TIME, "");
		}
		else
		{
			Str_Cpy(stCustPtrn.CHK_WISH_TIME, PTRN_TIME[i].Code);
		}

		//비상연락망
		Str_Cpy(stCustPtrn.EMR_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)));
		Str_Cpy(stCustPtrn.EMR_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cpy(stCustPtrn.EMR_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		//전출예정일
		Str_Cpy(m_szOutPlanYmd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA17)));
		Str_Chg(m_szOutPlanYmd, STRCHG_DEL_NONDIGIT);
		Str_Cpy(stCustPtrn.OUT_PLAN_YMD, m_szOutPlanYmd);
	}
}


