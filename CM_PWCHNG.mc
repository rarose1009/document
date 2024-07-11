/*----------------------------------------------------------------------------------
	Project Name: 
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.                          
   ----------------------------------------------------------------------------------*/
card CM_PWCHNG
{
	#include <include.h>
	#include "globalcard.h"

	//-----------------------------------------------------------------
	// 카드내에서 사용될 버튼 아이디 정의
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CHANGE )	// 변경
		DEF_BUTTON_ID ( BID_CANCEL )	// 취소
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료		
				
	END_BUTTON_ID()
	
	//-----------------------------------------------------------------
	// 카드내에서 사용될 콘트롤 아이디 정의
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_ORGPW )			// 기존 비밀번호
		DEF_OBJECT_ID ( TXT_EDTPW )			// 수정 비밀번호
		DEF_OBJECT_ID ( TXT_EDTPWCHK )		// 수정 비밀번호 확인
		
		DEF_OBJECT_ID ( EDT_ORGPW )			// 기존 비밀번호 입력
		DEF_OBJECT_ID ( EDT_EDTPW )			// 수정 비밀번호 입력
		DEF_OBJECT_ID ( EDT_EDTPWCHK )		// 수정 비밀번호 확인 입력
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	//-----------------------------------------------------------------
	// event message map
	//-----------------------------------------------------------------
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT
	#include "DefEvent.h"	

	#define INIT_MAIN	1
	
	#define m_PW_LEN	10
	
	// 현재커서가 있는 EDITCTRL의 INDEX
	long m_lEditCtrlIndex;
		
	void SetStyle(void);
	void SetBtnImg(void);

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
	//-----------------------------------------------------------------
	// 메인 다이얼로그(디폴트)
	//-----------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "비밀번호 변경"),
/*
		//화면 공통 메뉴
		DLG_BUTTON(STARTX,      5, 145, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "메뉴"),
		DLG_BUTTON(STARTX+290,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "자판"),
		DLG_BUTTON(STARTX+430,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "화면"),
		DLG_BUTTON(STARTX+570,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"공통"),
		DLG_BUTTON(STARTX+710,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "이전"),
		DLG_BUTTON(STARTX+850,  5, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "종료"),
*/
		DLG_BUTTON(105, 580, 780, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHANGE, "변 경"),
		DLG_BUTTON(105,	700, 780, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CANCEL, "취 소"),

		DLG_TEXT(105, 250, 400, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_ORGPW, "기존 비밀번호"),
		DLG_TEXT(105, 340, 400, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_EDTPW, "수정 비밀번호"),
		DLG_TEXT(105, 430, 400, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_EDTPWCHK, "비밀번호 확인"),
		
		DLG_EDIT(520, 250, 380, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_ORGPW, 10,  ""),
		DLG_EDIT(520, 340, 380, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_EDTPW, 10,  ""),
		DLG_EDIT(520, 430, 380, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_EDTPWCHK, 10,  ""),		
	};

	//-----------------------------------------------------------------
	// 다이얼로그 PDA
	//-----------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),

		DLG_BUTTON(105, 580, 780, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHANGE, "변 경"),
		DLG_BUTTON(105,	700, 780, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CANCEL, "취 소"),

		DLG_TEXT(105, 250, 400, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_ORGPW, "기존 비밀번호"),
		DLG_TEXT(105, 340, 400, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_EDTPW, "수정 비밀번호"),
		DLG_TEXT(105, 430, 400, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_EDTPWCHK, "비밀번호 확인"),
		
		DLG_EDIT(520, 250, 380, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_ORGPW, 10,  ""),
		DLG_EDIT(520, 340, 380, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_EDTPW, 10,  ""),
		DLG_EDIT(520, 430, 380, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_EDTPWCHK, 10,  ""),
	};
					
	//-----------------------------------------------------------------
	//	main entry map
	//-----------------------------------------------------------------
	CARD_ENTRY_MAP()

	//-----------------------------------------------------------------
	// call back event function
	//-----------------------------------------------------------------
	void	OnInit(char bFirst)
	{	
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						SetStyle();
						
						//기존 PDA 비밀번호 입력 창에 커서 위치.
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_ORGPW));
						m_lEditCtrlIndex = Get_iDlgCtrlByID(EDT_ORGPW);
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						SetBtnImg();
						SetStyle();
						//기존 PDA 비밀번호 입력 창에 커서 위치.
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_ORGPW));
						m_lEditCtrlIndex = Get_iDlgCtrlByID(EDT_ORGPW);
						break;		
				}
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
	
	//-----------------------------------------------------------------
	//입력 창에 길이(m_PW_LEN=10)에 맞게 입력하면, 다음 입력 창으로 커서 이동.
	void	OnChar(long nChar)
	{
		if ( Is_ActiveCtrlID (EDT_ORGPW)  )
		{
			if (EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_ORGPW)) == m_PW_LEN)
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_EDTPW));
				m_lEditCtrlIndex = Get_iDlgCtrlByID(EDT_EDTPW);
			}
		}

		if ( Is_ActiveCtrlID (EDT_EDTPW)  )
		{
			if (EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_EDTPW)) == m_PW_LEN)
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_EDTPWCHK));
				m_lEditCtrlIndex = Get_iDlgCtrlByID(EDT_EDTPWCHK);
			}
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ORGPW), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_EDTPW), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_EDTPWCHK), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_ORGPW), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_EDTPW), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_EDTPWCHK), EDITALIGN_MIDDLE);
	}		
	
	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{
		switch(ID)
		{
			case BID_CHANGE:
//				MessageBoxEx (CONFIRM_OK, "비밀번호가 변경되었습니다.");
				Card_Move("LOGIN");
				break;			
			case BID_CANCEL:
				Card_Move("LOGIN");
				break;
			case GID_HOME:
				break;
			case GID_MENU:
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
				Card_Move("LOGIN");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}	
}	

