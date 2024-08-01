/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_SND
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SEND )		//자료송신
		DEF_BUTTON_ID ( BID_DELETE )	//자료삭제
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
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_ITEM )			//항목
		DEF_OBJECT_ID ( TXT_OBJECT )		//대상
		DEF_OBJECT_ID ( TXT_SEND )			//송신
		DEF_OBJECT_ID ( TXT_NSEND )			//미송신
		DEF_OBJECT_ID ( TXT_BSRSLT )		//점검결과
		DEF_OBJECT_ID ( TXT_BSINFO )		//특정정보
		DEF_OBJECT_ID ( TXT_JOJUNG )		//정압/조정
		DEF_OBJECT_ID ( TXT_COMBUSTOR )		//연소기
		DEF_OBJECT_ID ( TXT_GUIDINFO )		//지침정보
		DEF_OBJECT_ID ( TXT_NFIT )			//부적합차수
		DEF_OBJECT_ID ( TXT_NFITITEM )		//부적합항목
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
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		
		DEF_OBJECT_ID ( ICON_TITLE)		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1

	char m_szScrPht[128];
	char m_szSession[128];
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void BS_DATADEL(void);
	long BS_DATASND(void);
	long SND_CHK(void);
	
	long SND_412301(void);
	long SND_412302(void);
	long SND_412303(void);
	long SND_412304(void);
	long SND_412305(void);
	long SND_412306(void);
	long SND_412307(void);
	long SND_412308(void);
	long SND_412309(void);
	long SND_412310(void);
	long Snd_412311(void);
	long SND_412312(void);
	
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "자료 송신"),
		
		DLG_BUTTON(STARTX    , STARTY+720, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "자료삭제"),
		DLG_BUTTON(STARTX+600, STARTY+720, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "자료송신"),
		
		DLG_TEXT(STARTX,	 STARTY+65, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEM, "항목"),
		DLG_TEXT(STARTX+300, STARTY+65, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "대상"),
		DLG_TEXT(STARTX+550, STARTY+65, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEND, "송신"),
		DLG_TEXT(STARTX+775, STARTY+65, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSEND, "미송신"),
		DLG_TEXT(STARTX,	 STARTY+135, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSRSLT, "점검결과"),
		DLG_TEXT(STARTX+300, STARTY+135, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY+135, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+775, STARTY+135, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,	 STARTY+205, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSINFO, "특정정보"),
		DLG_TEXT(STARTX+300, STARTY+205, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+550, STARTY+205, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+775, STARTY+205, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,	 STARTY+275, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JOJUNG, "정압/조정"),
		DLG_TEXT(STARTX+300, STARTY+275, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+550, STARTY+275, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+775, STARTY+275, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX,	 STARTY+345, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMBUSTOR, "연소기"),
		DLG_TEXT(STARTX+300, STARTY+345, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+550, STARTY+345, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+775, STARTY+345, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,	 STARTY+415, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDINFO, "지침정보"),
		DLG_TEXT(STARTX+300, STARTY+415, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+550, STARTY+415, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+775, STARTY+415, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX,	 STARTY+485, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFIT, "부적합차수"),
		DLG_TEXT(STARTX+300, STARTY+485, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+550, STARTY+485, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+775, STARTY+485, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX,	 STARTY+555, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFITITEM, "부적합항목"),
		DLG_TEXT(STARTX+300, STARTY+555, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+550, STARTY+555, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX+775, STARTY+555, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "자료 송신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX    , STARTY+700, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "자료삭제"),
		DLG_BUTTON(STARTX+600, STARTY+700, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "자료송신"),
		
		DLG_TEXT(STARTX,	  STARTY-40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEM, "항목"),
		DLG_TEXT(STARTX+300,  STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "대상"),
		DLG_TEXT(STARTX+550,  STARTY-40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEND, "송신"),
		DLG_TEXT(STARTX+775,  STARTY-40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSEND, "미송신"),
		DLG_TEXT(STARTX,	  STARTY+40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSRSLT, "점검결과"),
		DLG_TEXT(STARTX+300,  STARTY+40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550,  STARTY+40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+775,  STARTY+40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,	 STARTY+120, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSINFO, "특정정보"),
		DLG_TEXT(STARTX+300, STARTY+120, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+550, STARTY+120, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+775, STARTY+120, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,	 STARTY+200, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JOJUNG, "정압/조정"),
		DLG_TEXT(STARTX+300, STARTY+200, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+550, STARTY+200, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+775, STARTY+200, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX,	 STARTY+280, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMBUSTOR, "연소기"),
		DLG_TEXT(STARTX+300, STARTY+280, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+550, STARTY+280, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+775, STARTY+280, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,	 STARTY+360, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDINFO, "지침정보"),
		DLG_TEXT(STARTX+300, STARTY+360, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+550, STARTY+360, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+775, STARTY+360, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX,	 STARTY+440, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFIT, "부적합차수"),
		DLG_TEXT(STARTX+300, STARTY+440, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+550, STARTY+440, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+775, STARTY+440, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX,	 STARTY+520, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFITITEM, "부적합항목"),
		DLG_TEXT(STARTX+300, STARTY+520, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+550, STARTY+520, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX+775, STARTY+520, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
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
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ITEM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEND), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NSEND), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSRSLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JOJUNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMBUSTOR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUIDINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NFIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NFITITEM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_DELETE:
				BS_DATADEL();
				break;
			case BID_SEND:
				g_TRNUM = 0;
				if( SND_CHK() > 0)
				{
					BS_DATASND();
				}
				break;
				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "특정점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("BS_MENU");
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
				Card_Move("BS_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void BS_DATADEL(void)
	{
	char szSql[600];
	char sztmp[10]; 
	long chk = 0;
	long totcnt;

		if( MessageBoxEx (CONFIRM_YESNO, "자료를 삭제 하시겠습니까?") != MB_OK)
			return;
	
		chk = 0;
		g_Sql_RetInt(" select count(*) from SPECIAL_BUR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from SPECIAL_DATA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from SPECIAL_GOV_REG WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_MTR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD_CHA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_PIPE_CHK_DATA ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}

		if( chk > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "미송신 자료가 있습니다. 삭제하시겠습니까?") != MB_OK)
				return;
		}
		
		g_Sql_DirectExecute("DELETE FROM SPECIAL_BUR");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_DATA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_GOV_REG");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_GROUP");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_MTR");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD_CHA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD_DETAL");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_PIPE_CHK_DATA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_PREV_NO");

		//송신 완료 후 부적합사진 및 바코드 사진 삭제
		g_DirFS_Clear(PHOTO_BS, "*");
		g_DirFS_Clear(PHOTO_BSBAR, "*");
		
		MessageBoxEx (CONFIRM_OK, "자료 삭제가 완료되었습니다.");
		REDRAW();
	}
	
	void REDRAW(void)
	{
	char szToday[10];
	char sztmp[10]; 
	char szSql[200];
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), sztmp );


		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA WHERE INFO_FLAG = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA WHERE INFO_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), sztmp );
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_GOV_REG ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_BUR ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_BUR WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_BUR WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_MTR ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_MTR WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_MTR WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), sztmp );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_CHA ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_CHA WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_CHA WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), sztmp );
	}
	
	
	
	long SND_CHK(void)
	{
	long ret = 0;
	long nchk = 0;
	char szSql[600];
	char sztmp[10];
	char szyymm[10];
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"select count(*) from SPECIAL_BUR WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"select count(*) from SPECIAL_DATA WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
	
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"select count(*) from SPECIAL_GOV_REG WHERE SEND_YN = 'S'  ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
		
				
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," select count(*) from SPECIAL_MTR WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," select count(*) from SPECIAL_NOGOOD WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," select count(*) from SPECIAL_NOGOOD_CHA WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," select count(*) from SPECIAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," select count(*) from SPECIAL_PIPE_CHK_DATA ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
		if(ret <= 0)
		{
			MessageBoxEx (CONFIRM_OK, "송신할 자료가 없습니다.");
		}
		
		if(	ret > 0)
		{
			if( Str_Cmp(stUserinfo.szcenter_cd,"91") != 0 
		     && Str_Cmp(stUserinfo.szcenter_cd,"92") != 0 
	 	     && Str_Cmp(stUserinfo.szcenter_cd,"93") != 0 
		     && Str_Cmp(stUserinfo.szcenter_cd,"94") != 0 
		     && Str_Cmp(stUserinfo.szcenter_cd,"95") != 0 )
		    {
				Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szyymm, 0x00, sizeof( szyymm) );
				
				SPRINT( szSql, "SELECT PARAM7 FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
				
				g_Sql_RetStr(szSql, 8, sztmp);
				Str_ItoA( Time_GetDate(), szyymm, 10);
				
				if( Str_NCmp( sztmp, szyymm, 6) != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "이월된 미송신건은 전송할 수 없습니다.");
					return -1;
				}
		    }	
		}
		
		return ret;	
	}
	
	
	long BS_DATASND(void)
	{
	long ret = 1;
	long nchk = 0;
	char szSql[600];
	char sztmp[10]; 
	char szDirPath[128];
			
		if( g_TRNUM >  0 )
		{
			if(g_Chk_Json( g_TRNUM ) >= 0)
			{
				
				//송신성공하면 다음 FR로 넘어간다.
				if(g_TRNUM == 412310 || g_TRNUM == 412311 )
				{
					FFS_Delete(m_szScrPht);
				}
				else if(g_TRNUM == 412312)
				{				
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT( szSql ,"UPDATE SPECIAL_DATA SET BAR_RCV_YN = NULL where BAR_RCV_YN = 'Y' ",0,0,0   );
					g_Sql_DirectExecute( szSql );	
				}
				g_TRNUM++;
			}
			else
			{
				g_Sock_Close();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 412300)
		{
			g_SeverConnection();
			Mem_Set( (byte*)m_szSession, 0x00, sizeof(m_szSession) );
			if( g_StartSession( m_szSession ) < 0)
			{
				//세션 회득시에 송신종료한다.
				return ret; 
			}
		}
		
		if(  g_TRNUM <= 412301)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412301();
				return ret;
			}
		}
				
		if(  g_TRNUM <= 412302)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_MTR where SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412302();
				return ret;
			}
		}

		if(  g_TRNUM <= 412303)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_GOV_REG where SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412303();
				return ret;
			}
		}
			
		if(  g_TRNUM <= 412304)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA WHERE info_flag = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412304();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 412305)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_BUR where send_yn='S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412305();
				return ret;
			}
		}
			
		if(  g_TRNUM <= 412306)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_nogood where send_yn = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412306();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 412307)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_CHA where SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412307();
				return ret;
			}
		}
					
		if(  g_TRNUM <= 412308)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL where SEND_YN='S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412308();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 412309)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_PIPE_CHK_DATA ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_412309();
				return ret;
			}
		}
	
		if(  g_TRNUM <= 412310)
		{
			if( g_EndSession( m_szSession, "3") < 0)
			{
				g_Sock_Close();
				return ret;
			}
		}
		
		//부적합사진
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_BS );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			SND_412310();
			return ret;
		}

		//바코드 사진
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_BSBAR );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd_412311();
			return ret;
		}
		
		//임시 바코드 저장
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM SPECIAL_DATA WHERE BAR_RCV_YN = 'Y' AND SEND_YN NOT IN ('S','Y')",0 ,0 ,0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			SND_412312();
			return ret;
		}
		else
		{
			g_Sock_Close();
			
			ret = 1;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_DATA SET SEND_YN = 'Y'  WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_MTR SET SEND_YN = 'Y'  where SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_GOV_REG SET SEND_YN = 'Y'  where SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_DATA SET info_flag = 'Y' WHERE info_flag = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_BUR SET SEND_YN = 'Y'  where SEND_YN='S'",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_nogood SET SEND_YN = 'Y'  where SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_NOGOOD_CHA SET SEND_YN = 'Y' where SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE SPECIAL_NOGOOD_DETAL SET SEND_YN = 'Y' where SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"DELETE FROM  SPECIAL_PIPE_CHK_DATA ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			MessageBoxEx (CONFIRM_OK, "결과 송신완료하였습니다.");
			
			REDRAW();
			ON_DRAW();
		}
		return ret;
	}
	
	long SND_412301(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		


		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412301, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select chk_exec_num,PDA_IP AS client_id,chk_empid,chk_year,chk_order,special_num,chk_type,obj_ym,plan_ym \
,chker_nm,chk_ymd,chk_time_from,chk_time_to,chk_rslt,adv_dist_yn,sign_relat,sign \
,curr_bar as bar,bar_why,BEFO_HALF_MEMO as memo,BEFO_HALF_MEMO_WHY as memo_why,period_chk_ymd,heat_pump_yn, temp_inst_bar_photo_id \
from SPECIAL_DATA WHERE SEND_YN = 'S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412301;
		HTTP_UploadData  ( szUrl, "FR412301_IN",  "FR412301" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412302(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412302, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select mtr_num,chk_exec_num,PDA_IP as client_id,UPD_EMPID as user_id,visit_dtm \
,mtr_indi_cur,indi_va_cur,indi_vc_cur,compens_yn,chk_excep_why,chk_year,chk_order,special_num,chk_type,obj_ym,plan_ym, memo, faci_sts_cd, mtr_deta_loc, built_in_yn \
from SPECIAL_MTR where SEND_YN = 'S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412302;
		HTTP_UploadData  ( szUrl, "FR412302_IN",  "FR412302" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412303(void)
	{
		char szUrl[200];
		char szSql[600];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412303, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "SELECT CHK_EXEC_NUM, GOV_REGTR_FLAG, GOV_REGTR_NUM, PDA_IP AS CLIENT_ID, UPD_EMPID AS USER_ID \
                             , MAKER_NUM, MODEL_CD, NEW_DISJOINT_CHK_YMD AS DISJOINT_CHK_YMD, NEW_DISJOINT_CHK_FIRM_CD AS DISJOINT_CHK_FIRM_CD, CHK_YEAR, CHK_ORDER \
                             , SPECIAL_NUM, CHK_TYPE, OBJ_YM, PLAN_YM, INST_YMD, DETA_LOC ,NEW_FILTER_CLEAN_YMD AS FILTER_CLEAN_YMD,NEW_FILTER_CLEAN_FIRM_CD AS FILTER_CLEAN_FIRM_CD \
							 , REGTR_LOC_FLAG , REGTR_STD FROM SPECIAL_GOV_REG WHERE SEND_YN = 'S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412303;
		HTTP_UploadData  ( szUrl, "FR412303_IN",  "FR412303" , sndbuf, szDbpath, szSql);
		
		return ret;
	}
	
	long SND_412304(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412304, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select chk_exec_num,PDA_IP as client_id,UPD_EMPID as user_id \
,repre_tel_ddd,repre_tel_exn,repre_tel_num,repre_cp_ddd,repre_cp_exn,repre_cp_num\
,safe_manager_nm,manage_tel_ddd,manage_tel_exn,manage_tel_num,manage_cp_ddd,manage_cp_exn,manage_cp_num\
,repre_nm,chk_year,chk_order,special_num,chk_type,obj_ym,plan_ym,special_nm \
from SPECIAL_DATA WHERE info_flag = 'S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412304;
		HTTP_UploadData  ( szUrl, "FR412304_IN",  "FR412304" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412305(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412305, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select chk_exec_num, mtr_num,burner_num,UPD_IP as client_id,UPD_EMPID as user_id,special_num\
,chk_type,chk_year,chk_order,obj_ym,plan_ym,chg_flag \
,burner_class_cd,burner_kind_num,burner_model_nm,burner_capa,burner_capa_unit,burner_inst_ymd,burner_remov_ymd \
,maker_num,maker_nm,boiler_form,make_num,inst_loc,boiler_inst_firm_cd, deta_loc \
from SPECIAL_BUR where send_yn='S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412305;
		HTTP_UploadData  ( szUrl, "FR412305_IN",  "FR412305" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412306(void)
	{
	char szUrl[200];
	char szSql[800];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412306, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select chk_exec_num,PDA_IP as client_id,UPD_EMPID as user_id,obj_ym ,plan_ym ,special_num \
,chk_type,special_nm,chk_year,chk_order,center_cd \
,town,city,county,village,addr1_m,addr1_s,second_addr,bld_dong,hosu ,curr_addr_union,zip_no1,zip_no2 \
,new_hosu,new_addr_ungrnoud_yn,new_addr_union,law_town,new_road_nm,new_addr_m,new_addr_s \
,safe_manager_nm,manage_tel_ddd,manage_tel_exn,manage_tel_num,manage_cp_ddd,manage_cp_exn,manage_cp_num \
,press_flag,special_yn,compl_inspect_ymd,mm_use_plan_qty,ins_join_yn,UPD_EMPID as chk_empid \
from SPECIAL_nogood where send_yn = 'S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412306;
		HTTP_UploadData  ( szUrl, "FR412306_IN",  "FR412306" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412307(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412307, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select chk_exec_num,better_advice_degree,PDA_IP as client_id,UPD_EMPID as user_id \
,obj_ym,plan_ym,special_num,chk_type,better_advice_ymd,better_advice_expire \
,better_yn,better_end_ymd,supply_stop_ymd,not_permit_why,chk_year,chk_order \
from SPECIAL_NOGOOD_CHA where SEND_YN = 'S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412307;
		HTTP_UploadData  ( szUrl, "FR412307_IN",  "FR412307" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412308(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412308, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, " select chk_exec_num,chk_sec_cd,mtr_num,burner_num,not_pass_item_cd,PDA_IP as client_id,UPD_EMPID as user_id \
,obj_ym,plan_ym,chk_year,chk_order,special_num,chk_type,chk_sec_nm,not_pass_item_nm \
,visit_dtm,better_plan_ymd,better_yn,better_end_ymd,better_conf_empid,better_conf_nm,better_degree \
from SPECIAL_NOGOOD_DETAL where SEND_YN='S' "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412308;
		HTTP_UploadData  ( szUrl, "FR412308_IN",  "FR412308" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412309(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412309, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select chk_exec_num,chk_type,mtr_num,PIPE_FLAG as pipe_bury_hide_flag ,PDA_IP as client_id,UPD_EMPID as user_id \
,gas_damp_yn,multi_gas_mtr_yn,pipe_inspec_hole_yn,cutoff_inspec_hole_yn,pipe_loc_mark_yn \
from SPECIAL_PIPE_CHK_DATA "
        ,0 , 0, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412309;
		HTTP_UploadData  ( szUrl, "FR412309_IN",  "FR412309" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_412310(void)
	{
	char szUrl[200];
	char szDbpath[128];
	char szDirPath[128];
	char szfilenm[128];
	char szdata[20];
	char* sndbuf;
	char* szfile;
	char* filedata;
	long ret=0, nRet, filesize, fd;
	handle file;		
		
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_BS );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);

		if(nRet > 0)
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412310, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "gubun",       szdata );
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num",       szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 4, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "burner_num",      szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 5, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_sec_cd",   szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 6, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "not_pass_item_cd",   szdata );

			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			sndbuf = JSON_toString(g_pjcomm);
			
			//g_Save_JsonFile(sndbuf);
			callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
			g_TRNUM = 412310;				
			HTTP_DownloadData  ( szUrl, "FR412310_IN",  "FR412310" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		
		return 1;
	}

	long Snd_412311(void)
	{
	char szUrl[200];
	char szDbpath[128];
	char szDirPath[128];
	char szfilenm[128];
	char szdata[20];
	char* sndbuf;
	char* szfile;
	char* filedata;
	long ret=0, nRet, filesize, fd;
	handle file;		
		
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_BSBAR );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(nRet > 0)
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412311, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+13, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+13, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "special_num", szdata );

			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			sndbuf = JSON_toString(g_pjcomm);
			
			g_Save_JsonFile(sndbuf);
			callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
			g_TRNUM = 412311;				
			HTTP_DownloadData  ( szUrl, "FR412311_IN",  "FR412311" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		
		return 1;
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
			if(szSource[i] == '_' || szSource[i] == '.')
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
	
	long SND_412312(void)
	{
		char szUrl[200];
		char szSql[600];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
				
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 412312, FALSE);

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, SPECIAL_NUM, CURR_BAR, '%s' as client_id, '%s' as user_id FROM SPECIAL_DATA WHERE BAR_RCV_YN = 'Y' AND SEND_YN NOT IN ('S','Y') ", stUserinfo.szpda_ip, stUserinfo.szemployee_id, 0 );

		callBackfunc = BS_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 412312;
		HTTP_UploadData  ( szUrl, "FR412312_IN",  "FR412312" , sndbuf, szDbpath, szSql);
		return ret;
	}
}


