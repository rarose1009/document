/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MENU
	Card Desc : 공통메뉴
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MENU
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
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		
		// 화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )			// 홈
		DEF_BUTTON_ID ( BID_MENU )			// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )		// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )		// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )		// 공통업무
		DEF_BUTTON_ID ( BID_PREV )			// 이전
		DEF_BUTTON_ID ( BID_EXIT )			// 종료
			
		// 하단 버튼 모음
		DEF_BUTTON_ID ( BID_CLOSE )			// 취소
		
		// 공통 메뉴
		DEF_BUTTON_ID ( BID_CMCDRECV )		// 공통 코드 수신
		DEF_BUTTON_ID ( BID_PAYMENU )		// 기타 결제
		DEF_BUTTON_ID ( BID_CHG_FONT )		// 폰트 변경
		DEF_BUTTON_ID ( BID_CHG_BARCODE )	// 바코드 변경
		DEF_BUTTON_ID ( BID_CHG_CENTER )	// 고객센터 변경
		
		// 폰트 변경
		DEF_BUTTON_ID ( BID_FONT_1 )		// 폰트변경_1
		DEF_BUTTON_ID ( BID_FONT_2 )		// 폰트변경_2
		DEF_BUTTON_ID ( BID_FONT_3 )		// 폰트변경_3
		DEF_BUTTON_ID ( BID_FONT_4 )		// 폰트변경_4
		DEF_BUTTON_ID ( BID_FONT_CLOSE )	// 폰트변경 취소
		DEF_BUTTON_ID ( BID_FONT_CHANGE )	// 폰트변경 저장
		
		// 바코드 종류 변경
		DEF_BUTTON_ID ( BID_BAR_CLOSE )		// 바코드 종류 변경 취소
		DEF_BUTTON_ID ( BID_BAR_CHANGE )	// 바코드 종류 변경 저장
		
		// 고객센터 변경
		DEF_BUTTON_ID ( BID_CENTER_CHANGE )	// 고객센터 변경
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		
		// 공통
		DEF_OBJECT_ID ( ICON_TITLE )		// 타이틀 아이콘
		DEF_OBJECT_ID ( TXT_TITLE )			// 타이틀	
		
		// 폰트 변경
		DEF_OBJECT_ID ( TXT_FONT_1 )		// 폰트변경_1
		DEF_OBJECT_ID ( TXT_FONT_2 )		// 폰트변경_2
		DEF_OBJECT_ID ( TXT_FONT_3 )		// 폰트변경_3
		DEF_OBJECT_ID ( TXT_FONT_4 )		// 폰트변경_4
		DEF_OBJECT_ID ( TXT_FONT_NOTICE )	// 폰트변경 공지
		
		// 바코드 종류 변경
		DEF_OBJECT_ID ( TXT_DATA1 )			// 바코드 종류 타이틀
		DEF_OBJECT_ID ( TXT_BAR_NOTICE )	// 바코드 종류 공지
		
		// 고객센터 변경
		DEF_OBJECT_ID ( TXT_DATA2 )			// 고객센터 변경 TXT
		
		// 라인
		DEF_OBJECT_ID ( LINE_DATA1 )		// 라인1
		
		// 콤보박스
		DEF_OBJECT_ID ( CMB_DATA1 )					// 바코드 종류 콤보박스
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )	// 고객센터 콤보박스
	
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	// 다이얼로그 Define
	#define INIT_MAIN	  	1
	#define INIT_CHGFONT  	2
	#define INIT_CHGBAR   	3
	#define INIT_CHGCENTER	4
	
	// 폰트 변경 RadioBox Define
	#define FONT_CHK_Y "▣ 가나다라마바"
	#define FONT_CHK_N "□ 가나다라마바"
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lFontSize = -1;
	long m_bFirst;					// 화면 Index
	long m_lActiveIndex;			// 현재 터치한 Index
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void Set_Menu(void);
	void RCV_CODE(void);
	
	long TR13131(void);
	long TR13132(void);
	long Rev13132(void);
	long TR13133(void);
	long Rev13133(void);
	long TR13134(void);
	long Rev13134(void);
	long TR13135(void);
	long Rev13135(void);
	long TR13136(void);
	long Rev13136(void);
	long TR13137(void);
	long Rev13137(void);
	long TR13138(void);
	long Rev13138(void);
	long TR13139(void);
	long Rev13139(void);
	long TR13140(void);
	long Rev13140(void);
	long TR685025(void);
	long Rev685025(void);	
	long TR685026(void);
	long Rev685026(void);
	long TR685027(void);
	long Rev685027(void);
	long TR685028(void);
	long Rev685028(void);
	
	void Font_Draw(void);
	void Chg_Font(void);
	
	void Barcode_Draw(void);
	void Chg_Bar(void);
	
	void Center_Chg_Draw(void);
	void Chg_Center(void);
	
	//---------------------------------------------------------------------------------------
	//	Global Button Style
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
	// Main 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공통업무 메뉴"),
		
		DLG_BUTTON(0,		     STARTY+65, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CMCDRECV, "공통 코드\n자료 수신"),
		DLG_BUTTON(STARTX+500,	 STARTY+65, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PAYMENU, "기타 결제"), 	  
		DLG_BUTTON(0,		    STARTY+345, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG_FONT, "글자 크기\n변경"),
		DLG_BUTTON(STARTX+500,	STARTY+345, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG_BARCODE, "바코드 종류\n변경"),	
		DLG_BUTTON(0,		    STARTY+625, 500, 274, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG_CENTER, "고객센터\n변경"),
	};	
	
	//---------------------------------------------------------------------------------------
	// 폰트 변경 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CHGFONT[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "글자크기 변경"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
			
		DLG_BUTTON(STARTX,     STARTY+450, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "닫 기"),
		DLG_BUTTON(STARTX+500, STARTY+450, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FONT_CHANGE, "변 경"),

		DLG_BUTTON(STARTX,     STARTY, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_1, ""),
		DLG_TEXT(STARTX,     STARTY, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_1, FONT_CHK_N),

		DLG_BUTTON(STARTX, STARTY+100, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_2, ""),
		DLG_TEXT(STARTX, STARTY+100, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_2, FONT_CHK_N),

		DLG_BUTTON(STARTX, STARTY+200, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_3, ""),
		DLG_TEXT(STARTX, STARTY+200, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_3, FONT_CHK_N),

		DLG_BUTTON(STARTX, STARTY+300, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_4, ""),
		DLG_TEXT(STARTX, STARTY+300, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_4, FONT_CHK_N),

		DLG_TEXT(STARTX, STARTY+600, 1000, 299, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_FONT_NOTICE, "**알 림**\n \n글자크기 변경 시 프로그램이 종료됩니다."),
	};	

	//---------------------------------------------------------------------------------------
	// 바코드 종류 변경 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CHGBAR[] = 
	{
		NORM_DLG( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "바코드 설정"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON( STARTX, 	STARTY+80, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR_CLOSE,  "닫 기"),	
		DLG_BUTTON( STARTX+500, STARTY+80, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR_CHANGE,  "변 경"),	
		
		DLG_TEXT(STARTX,     	STARTY-20, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "바코드 종류"),
		DLG_COMBO (STARTX+300,  STARTY-20, 700, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),

		DLG_TEXT(STARTX, STARTY+600, 1000, 299, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_BAR_NOTICE, "**알 림**\n \n바코드 변경 시 프로그램이 종료됩니다."),
	};
	
	//---------------------------------------------------------------------------------------
	// 고객센터 변경 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CHGCENTER[] = 
	{
		NORM_DLG( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객센터 설정"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     	STARTY -29,  300,  80,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "고객센터"),
		DLG_COMBO( STARTX +300, STARTY -29,  700, 80, 150, 80,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),
		
		DLG_LINE ( STARTX,      STARTY +55, 1000, STARTY +55, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_BUTTON(STARTX, 	    STARTY +60,  500,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "닫 기"),	
		DLG_BUTTON(STARTX +500, STARTY +60,  500,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CENTER_CHANGE,  "변 경"),	
		
	};
	
	//---------------------------------------------------------------------------------------
	//	main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
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
	void OnInit( char bFirst )
	{
		m_bFirst = bFirst;
		
		switch( bFirst )
		{
			long i;
			
			// 메인
			case INIT_MAIN:
			
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				g_FlagClear();
				SetBtnImg();
				
				Set_Menu();
				
				break;
			
			// 폰트 변경
			case INIT_CHGFONT:
			
				CREATE_DIALOG_OBJECT (DlgRes_CHGFONT, SIZEOF(DlgRes_CHGFONT));
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				Font_Draw();
				
				break;
			
			// 바코드 종류 변경
			case INIT_CHGBAR:
			
				CREATE_DIALOG_OBJECT (DlgRes_CHGBAR, SIZEOF(DlgRes_CHGBAR));
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				Barcode_Draw();
				
				break;
			
			// 고객센터 변경
			case INIT_CHGCENTER:
				
				CREATE_DIALOG_OBJECT (DlgRes_CHGCENTER, SIZEOF(DlgRes_CHGCENTER));
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				Center_Chg_Draw();
				
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
		char sztmp[100];
		char szPath[100];
		char szbuf[100];
		char szBack[100];
		long i;
		long fd;
		long nRet;
	
		switch(ID)
		{
			/********************************/
			/*  상단 공통 버튼              */
			/********************************/
			// 공통 메인 메뉴 이동 버튼
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				
				break;
			
			// 공통 부 메뉴 이동 버튼
			case GID_MENU:
				break;
			
			// 공통 키보드 버튼
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
				
			// 공통 화면 전환 버튼
			case GID_SCREEN:
				g_MOVE_DLG(400);
				break;
			
			// 공통 SOS버튼
			case GID_CMMNWK:
				break;
			
			// 공통 이번화면 버튼	
			case GID_PREV:
				Card_Move("MENU");
				break;
			
			// 공통 종료 버튼
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/********************************/
			/*  공통 버튼                   */
			/********************************/
			// 취소 버튼
			case BID_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			/********************************/
			/*  메인메뉴 버튼               */
			/********************************/
			// 공통 코드 수신 버튼
			case BID_CMCDRECV:
				RCV_CODE();
				break;
							
			// 기타 결제
			case BID_PAYMENU:
				Card_Move("C6101_PayMenu");
				break;
				
			// 폰트 변경 버튼
			case BID_CHG_FONT:
				ON_EXIT();
				OnInit(INIT_CHGFONT);
				break;
				
			// 바코드 종류 버튼
			case BID_CHG_BARCODE:
				ON_EXIT();
				OnInit(INIT_CHGBAR);
				break;
			
			// 고객센터 변경
			case BID_CHG_CENTER:
				ON_EXIT();
				OnInit(INIT_CHGCENTER);
				break;
			
			/********************************/
			/*  폰트 변경 버튼              */
			/********************************/
			// 폰트 변경_1 버튼
			case BID_FONT_1:
				m_lFontSize = 1;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			
			// 폰트 변경_2 버튼
			case BID_FONT_2:
				m_lFontSize = 2;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
				
			// 폰트 변경_3 버튼
			case BID_FONT_3:
				m_lFontSize = 3;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
				
			// 폰트 변경_4 버튼
			case BID_FONT_4:
				m_lFontSize = 4;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_Y );
				break;
			
			// 폰트 변경 취소
			case BID_FONT_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			// 폰트 변경 저장
			case BID_FONT_CHANGE:
				Chg_Font();
				break;
			
			/********************************/
			/*  바코드 종류 변경 버튼       */
			/********************************/
			// 바코드 종류 취소
			case BID_BAR_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			// 바코드 종류 저장
			case BID_BAR_CHANGE:
				Chg_Bar();
				break;
			
			/********************************/
			/*  고객센터 변경 버튼          */
			/********************************/
			// 고객센터 변경
			case BID_CENTER_CHANGE:
				Chg_Center();
				break;
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
		
		// 타이틀
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
		// 상단공통메뉴
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

	/*=======================================================================================
	함수명 : RCV_CODE
	기  능 : 공통자료 수신, FR13131
	Param  : 
	Return : 
	========================================================================================*/
	void RCV_CODE(void)
	{
		char szUrl[200];
		char szFilepath[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
	
		if( MessageBoxEx (CONFIRM_YESNO, "기초 코드를 수신 받으시겠습니까?") != MB_OK )
		{
			return;
		}
		
		MessageBoxEx(MESSAGE, "기존 자료 정리중 입니다.");
		
		g_Sql_DirectExecute("DELETE FROM commoncode");
		g_Sql_DirectExecute("DELETE FROM BATTERY_KIND");
		g_Sql_DirectExecute("DELETE FROM BO_INST");
		g_Sql_DirectExecute("DELETE FROM BURNER_KIND");
		g_Sql_DirectExecute("DELETE FROM MTR_MODEL");
		g_Sql_DirectExecute("DELETE FROM COMPENS_MODEL");
		g_Sql_DirectExecute("DELETE FROM GOV_MODEL");
		g_Sql_DirectExecute("DELETE FROM REGTR_MODEL");
		g_Sql_DirectExecute("DELETE FROM USE_MAKER");
		g_Sql_DirectExecute("DELETE FROM C6101_BIZ_TYPE");
		g_Sql_DirectExecute("DELETE FROM C6101_PROD");
		g_Sql_DirectExecute("DELETE FROM C6101_BIZ_PROD");
		g_Sql_DirectExecute("DELETE FROM C6101_BIZ_BURN");
			
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13131, FALSE);
				
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);

		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		HTTP_DownloadTR(ret, szUrl, 13131, sndbuf, szbuf);
	}
	
	/*=======================================================================================
	함수명 : TR13131
	기  능 : FR13131 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13131(void)
	{
		if( g_Chk_Json(13131) >= 0 )
		{
			Rev13132();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13132
	기  능 : FR13132
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13132(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13132, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13132, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13132
	기  능 : FR13132 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13132(void)
	{
		if( g_Chk_Json(13132) >= 0 )
		{
			Rev13133();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13133
	기  능 : FR13133
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13133(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13133, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13133, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13133
	기  능 : FR13133 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13133(void)
	{
		if( g_Chk_Json(13133) >= 0 )
		{
			Rev13134();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13134
	기  능 : FR13134
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13134(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13134, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13134, sndbuf, szbuf);

		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13134
	기  능 : FR13134 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13134(void)
	{
		if( g_Chk_Json(13134) >= 0 )
		{
			Rev13135();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13135
	기  능 : FR13135
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13135(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13135, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13135, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13135
	기  능 : FR13135 Callbak
	Param  : 
	Return : 
	========================================================================================*/
	long TR13135(void)
	{
		if( g_Chk_Json(13135) >= 0 )
		{
			Rev13136();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13136
	기  능 : FR13136
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13136(void)
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

		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13136, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13136, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13136
	기  능 : FR13136 Callbak
	Param  : 
	Return : 
	========================================================================================*/
	long TR13136(void)
	{
		if( g_Chk_Json(13136) >= 0 )
		{
			Rev13137();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13137
	기  능 : FR13137
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13137(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13137, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13137, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13137
	기  능 : FR13137 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13137(void)
	{
		if( g_Chk_Json(13137) >= 0 )
		{
			Rev13138();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}

	/*=======================================================================================
	함수명 : Rev13138
	기  능 : FR13138
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13138(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13138, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13138, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13138
	기  능 : FR13138 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13138(void)
	{
		if( g_Chk_Json(13138) >= 0 )
		{
			Rev13139();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13139
	기  능 : FR13139
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13139(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13139, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13139, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13139
	기  능 : FR13139 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13139(void)
	{
		if( g_Chk_Json(13139) >= 0 )
		{
			Rev13140();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev13140
	기  능 : FR13140
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13140(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13140, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13140, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR13140
	기  능 : FR13140 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13140(void)
	{
		if( g_Chk_Json(13140) >= 0 )
		{
			Rev685025();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev685025
	기  능 : FR685025
	Param  : 
	Return : 
	========================================================================================*/
	long Rev685025(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685025, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685025, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR685025
	기  능 : FR685025 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685025(void)
	{
		if( g_Chk_Json(685025) >= 0 )
		{
			Rev685026();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev685026
	기  능 : FR685026
	Param  : 
	Return : 
	========================================================================================*/
	long Rev685026(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685026, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685026, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR685026
	기  능 : FR685026 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685026(void)
	{
		if( g_Chk_Json(685026) >= 0 )
		{
			Rev685027();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev685027
	기  능 : FR685027
	Param  : 
	Return : 
	========================================================================================*/
	long Rev685027(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685027, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685027, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR685027
	기  능 : FR685027 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685027(void)
	{
		if( g_Chk_Json(685027) >= 0 )
		{
			Rev685028();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rev685028
	기  능 : FR685028
	Param  : 
	Return : 
	========================================================================================*/
	long Rev685028(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685028, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685028, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : TR685028
	기  능 : FR685028 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685028(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(685028) >= 0 )
		{
			MessageBoxEx (CONFIRM_OK, "수신이 완료되었습니다.");
			ON_DRAW();
			return 1;
		}
		
		CloseMessageBox();
		
		return 1;
	}

	/*=======================================================================================
	함수명 : Font_Draw
	기  능 : 폰트 변경 화면 Draw
	         theDevInfo.m_nFontSmallType = FONT_28; >> 1
			 theDevInfo.m_nFontType      = FONT_36; >> 2
			 theDevInfo.m_nFontLageType2 = FONT_52; >> 3
			 theDevInfo.m_nFontLageType  = FONT_64; >> 4
	Param  : 
	Return : 
	========================================================================================*/
	void Font_Draw(void)
	{
		long i = 0;
		char szFont[10];
	
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_FONT_NOTICE), TRUE, 2, EDITSEP_NONE );
	
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_1  ), FONT_32 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_2  ), FONT_36 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_3  ), FONT_38 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_4  ), FONT_40 );
		}
		else
		{
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_1  ), FONT_10 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_2  ), FONT_12 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_3  ), FONT_14 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_4  ), FONT_16 );
		}
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_1 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_2 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_3 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_4 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_NOTICE ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		Mem_Set( (byte*)szFont, 0x00, sizeof(szFont) );
		g_Sql_RetStr("SELECT FONT_SIZE FROM USER_INFO", 4, szFont);
		i = Str_AtoI(szFont);
		
		switch( i )
		{
			case 1:
				m_lFontSize = 1;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			case 2:
				m_lFontSize = 2;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			case 3:
				m_lFontSize = 3;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			case 4:
				m_lFontSize = 4;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_Y );
				break;
		}

		return;
	}
	
	/*=======================================================================================
	함수명 : Chg_Font
	기  능 : 폰트 변경 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Chg_Font(void)
	{
		char szSql[128];
		char szFont[10];
		
		if( MessageBoxEx (CONFIRM_YESNO, "글자크기를 변경하시겠습니까?")  != MB_OK )
		{
			return;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szFont, 0x00, sizeof(szFont) );
		Str_ItoA(m_lFontSize, szFont, 10);
		SPRINT(szSql, "UPDATE USER_INFO SET FONT_SIZE = '%s'",szFont,0,0);
		g_Sql_DirectExecute(szSql);
		
		//글자크기 변경 후 프로그램 종료
		//g_nWorkFlag = 698:민원 업무보고, 테이블 클리어.
		if( g_nWorkFlag == 698 )
		{
			g_Sql_DirectExecute("DELETE FROM C6101_WORK_REPORT");
			g_DirFS_Clear(PHOTO_WORK, "*");
		}
		
		//푸시 로그아웃 설정.
		g_SetPushLogout();
		
		g_Db_Backup();
		
		//배경이미지
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Barcode_Draw
	기  능 : 바코드 종류 화면 Draw
	Param  : 
	Return : 
	========================================================================================*/
	void Barcode_Draw(void)
	{
		char szBarFlag[10];
		
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_DATA1+2));
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "빔 바코드", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "카메라 바코드", 0, ICON_NONE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BAR_NOTICE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_BAR_NOTICE), TRUE, 2, EDITSEP_NONE );
		
		Mem_Set( (byte*)szBarFlag, 0x00, sizeof(szBarFlag) );
		g_Sql_RetStr("SELECT BARCODE_FLAG FROM USER_INFO", 5, szBarFlag);
		
		if( Str_Cmp(szBarFlag, "P") == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), "카메라 바코드" );
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), "빔 바코드" );
		}
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Chg_Bar
	기  능 : 바코드 종류 변경 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Chg_Bar(void)
	{
		char szSql[128];
		char szBarFlag[10];
	
		if( MessageBoxEx (CONFIRM_YESNO, "바코드를 변경하시겠습니까?")  != MB_OK )
		{
			return;
		}
		
		Mem_Set( (byte*)szBarFlag, 0x00, sizeof(szBarFlag) );
		if( Str_Cmp(EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1) ), "카메라 바코드") == 0 )
		{
			Str_Cpy(szBarFlag, "P");
		}
		else
		{
			Str_Cpy(szBarFlag, "B");
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE USER_INFO SET BARCODE_FLAG = '%s'",szBarFlag,0,0);
		g_Sql_DirectExecute(szSql);

		//바코드 변경 후 프로그램 종료
		//g_nWorkFlag = 698:민원 업무보고, 테이블 클리어.
		if( g_nWorkFlag == 698 )
		{
			g_Sql_DirectExecute("DELETE FROM C6101_WORK_REPORT");
			g_DirFS_Clear(PHOTO_WORK, "*");
		}
		
		//푸시 로그아웃 설정.
		g_SetPushLogout();
		
		g_Db_Backup();
		
		//배경이미지
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Center_Chg_Draw
	기  능 : 곻객센터 변경 화면 Draw
	Param  : 
	Return : 
	========================================================================================*/
	void Center_Chg_Draw(void)
	{
		long i;
		char szBarFlag[10];
		char sztmp[100];
		
		// style setting
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		// 콤보박스 세팅
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_DATA2+2));
		
		for ( i = 0 ;  CODE_CENTER[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), CODE_CENTER[i].Str, 0, ICON_NONE);
		}
		
		// 콤보박스 최초 값 세팅
		i = g_SearchCD( stUserinfo.szcenter_cd, CODE_CENTER );
		
		PRINT("@@@@@@ 1 @@@@@@@@ : %s",stUserinfo.szcenter_cd,0,0);
		PRINT("@@@@@@ 2 @@@@@@@@ : %d",i,0,0);
		PRINT("@@@@@@ 3 @@@@@@@@ : %s",CODE_CENTER[i].Str,0,0);
		
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), CODE_CENTER[i].Str);
		}
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Chg_Center
	기  능 : 고객센터 변경
	Param  : 
	Return : 
	========================================================================================*/
	void Chg_Center(void)
	{
		char sztmp[200];
		long i;
		
		if( MessageBoxEx (CONFIRM_YESNO, "고객센터를 변경하시겠습니까?") == MB_OK )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)stUserinfo.szcenter_cd, 0x00, sizeof(stUserinfo.szcenter_cd) );
			Mem_Set( (byte*)stUserinfo.szcenter_nm, 0x00, sizeof(stUserinfo.szcenter_nm) );
			
			Str_Cpy( stUserinfo.szcenter_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );
			
			Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2) ) );
			
			i = g_SearchStr( sztmp, CODE_CENTER );
				
			if (i == -1)
			{
				Str_Cpy(stUserinfo.szcenter_cd, "");
			}
			else
			{
				Str_Cpy(stUserinfo.szcenter_cd, CODE_CENTER[i].Code);
			}
			
			Card_Move("MENU");
		}
		else
		{
			return;
		}
	}
	
	/*=======================================================================================
	함수명 : Set_Menu
	기  능 : 메뉴 Setting
	Param  : 
	Return : 
	========================================================================================*/
	void Set_Menu(void)
	{
		char sztmp[200];
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		g_Sql_RetStr("SELECT CENTER_CD FROM USER_INFO", 10, sztmp);
		
		if( Str_Cmp( sztmp, "91" ) == 0 || 
		 	Str_Cmp( sztmp, "92" ) == 0 ||
		 	Str_Cmp( sztmp, "93" ) == 0 ||
		 	Str_Cmp( sztmp, "94" ) == 0 ||
		 	Str_Cmp( sztmp, "95" ) == 0 )
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHG_CENTER), TRUE );
		}
		else
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHG_CENTER), FALSE );		
		}
	}
}


