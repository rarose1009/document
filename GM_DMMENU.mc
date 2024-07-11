/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : GM_DMMENU
	Card Desc : 검침 자료관리
	Card Hist :
----------------------------------------------------------------------------------*/
card GM_DMMENU
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
		
		// 일반 버튼
		DEF_BUTTON_ID ( BID_DEL )		// 자료 삭제
		DEF_BUTTON_ID ( BID_RECV )		// 자료 수신
		DEF_BUTTON_ID ( BID_SNDDEL )	// 자료 송신 및 삭제
		
		DEF_BUTTON_ID ( BID_REDEL )		// 재검 자료 삭제
		DEF_BUTTON_ID ( BID_RESNDDEL )	// 재검 자료 송신 및 삭제
			
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		
		// 타이틀
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		
		// SUB 타이틀
		DEF_OBJECT_ID ( TXT_SUBTITLE1 )	
		DEF_OBJECT_ID ( TXT_SUBTITLE2 )
		DEF_OBJECT_ID ( TXT_SUBTITLE3 )
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	1
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void Del_Gmdata(void);
	void Del_ReGmdata(void);
	
	//---------------------------------------------------------------------------------------
	// Common Button
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
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		// 타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "검 침 자 료 관 리"),
		
		DLG_TEXT  (STARTX,     STARTY+65, 			 1000,    70,      0,  0,  0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, DARKSLATEBLUE, TXT_SUBTITLE1, "자료 수신" ),
		DLG_BUTTON(STARTX+240, STARTY+135, 			 BTNMNWD, BTNHT,   25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RECV, ""),
		
		DLG_TEXT  (STARTX,     STARTY+135+(1*BTNHT), 1000,    70,      0,  0,  0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, DARKSLATEBLUE, TXT_SUBTITLE2, "정기검침 송신, 삭제" ),
		DLG_BUTTON(STARTX,     STARTY+210+(1*BTNHT), BTNMNWD, BTNHT,   25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SNDDEL, ""),
		DLG_BUTTON(STARTX+495, STARTY+210+(1*BTNHT), BTNMNWD, BTNHT,   25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DEL, ""),
		
		DLG_TEXT  (STARTX,     STARTY+210+(2*BTNHT), 1000,    70,      0,  0,  0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, DARKSLATEBLUE, TXT_SUBTITLE3, "재검, 조정에러 송신, 삭제" ),
		DLG_BUTTON(STARTX,     STARTY+280+(2*BTNHT), BTNMNWD, BTNHT-5, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RESNDDEL, ""),
		DLG_BUTTON(STARTX+495, STARTY+280+(2*BTNHT), BTNMNWD, BTNHT-5, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REDEL, ""),
		
	};	

	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		return TRUE;
	}

	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : OnInit
	기  능 : 최초 시작
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit( char bFirst )
	{
		switch ( bFirst )
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
					
				SetBtnImg();
				
				break;
		}
	}

	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton( long ID )
	{	
		char szSql[300];
		long lCnt = 0;
	
		switch(ID)
		{
			/*********************************/
			/* 공통                          */
			/*********************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "검침 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("GM_MENU");
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
				Card_Move("GM_MENU");
				break;
				
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/*********************************/
			/* 일반                          */
			/*********************************/
			case BID_RECV:
				/* 기존 로직
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA",0, 0, 0   );
					g_Sql_RetInt( szSql, &lCnt );
					
					if( lCnt > 0 )
					{
						MessageBoxEx(CONFIRM_OK, "검침자료가 있습니다. 자료삭제후 수신하세요.");
					}
					else
					{
						Card_Move("GM_RCV");
					}
				*/
				Card_Move("GM_RCV");
				
				break;
				
			case BID_SNDDEL:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "검침 대상을 수신하세요.");
				}
				else
				{
					Card_Move("GM_SND");
				}
				
				break;
				
			case BID_DEL:
				Del_Gmdata();
				break;
			
			case BID_RESNDDEL:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT( szSql, "SELECT COUNT(*) FROM REGUMDATA", 0, 0, 0 );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "검침 대상을 수신하세요.");
				}
				else
				{
					Card_Move("GM_RESND");
				}
				
				break;
				
			case BID_REDEL:
				Del_ReGmdata();
				break;	
		}
	}		

	//---------------------------------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/	
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUBTITLE1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUBTITLE2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUBTITLE3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		//상단공통메뉴
		h = GetSysButHandle(GID_HOME);
		ButCtrl_SetImage( h, g_pImgHomeI);
		ButCtrl_SetActiveImage( h, g_pImgHomeA);
		
		h = GetSysButHandle(GID_KEYBOARD);
		ButCtrl_SetImage( h, g_pImgKeybrdI);
		ButCtrl_SetActiveImage( h, g_pImgKeybrdA);
		
		h = GetSysButHandle(GID_SCREEN);
		ButCtrl_SetImage( h, g_pImgScreenI);
		ButCtrl_SetActiveImage( h, g_pImgScreenA);
		
		h = GetSysButHandle(GID_CMMNWK);
		ButCtrl_SetImage( h, g_pImgCmmnwrkI);
		ButCtrl_SetActiveImage( h, g_pImgCmmnwrkA);
		
		h = GetSysButHandle(GID_VMEXIT);
		ButCtrl_SetImage( h, g_pImgExitI);
		ButCtrl_SetActiveImage( h, g_pImgExitA);
		
		//메뉴버튼
		h = Get_hDlgCtrlByID(BID_RECV);
		ButCtrl_SetImage( h, g_pImgGm_DataRcv);
		
		h = Get_hDlgCtrlByID(BID_SNDDEL);
		ButCtrl_SetImage( h, g_pImgGm_DataSnd);

		h = Get_hDlgCtrlByID(BID_DEL);
		ButCtrl_SetImage( h, g_pImgGm_DataDel);
		
		
		h = Get_hDlgCtrlByID(BID_RESNDDEL);
		ButCtrl_SetImage( h, g_pImgGm_DataSnd);

		h = Get_hDlgCtrlByID(BID_REDEL);
		ButCtrl_SetImage( h, g_pImgGm_DataDel);
		
	}
	
	/*=======================================================================================
	함수명 : Del_Gmdata
	기  능 : 정기 검침 삭제
	Param  : 
	Return : 
	========================================================================================*/
	void Del_Gmdata(void)
	{
		long totcnt;
	
		g_Sql_RetInt(" select count(*) from GUMDATA WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'", &totcnt);
		
		if( totcnt > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "정기검침 [미송신] 자료가 있습니다.\n삭제하시겠습니까?") != MB_OK )
				return;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "[정기검침 자료]를\n삭제하시겠습니까?")  != MB_OK )
				return;
		}
		
		g_Sql_DirectExecute("DELETE FROM GUMGROUP");
		g_Sql_DirectExecute("DELETE FROM GUMDATA");
		g_Sql_DirectExecute("DELETE FROM GUM_COMPENS_REMOVE_REQ");
		// g_Sql_DirectExecute("DELETE FROM RCV_LOG WHERE GUBUN = '1'");
		g_Sql_DirectExecute("UPDATE RCV_LOG SET PARAM6 ='' WHERE GUBUN ='1'");
		
		g_DirFS_Clear(PHOTO_GM, "*");
		
		MessageBoxEx(CONFIRM_OK, "자료삭제을 완료 했습니다.");
	}
	
	/*=======================================================================================
	함수명 : Del_ReGmdata
	기  능 : 재검 검침 삭제
	Param  : 
	Return : 
	========================================================================================*/
	void Del_ReGmdata(void)
	{
		long totcnt;
	
		g_Sql_RetInt(" select count(*) from REGUMDATA WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'", &totcnt);
		
		if( totcnt > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "재검, 조정에러 [미송신] 자료가\n있습니다. 삭제하시겠습니까?") != MB_OK )
				return;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "[재검, 조정에러]자료를\n삭제하시겠습니까?")  != MB_OK )
				return;
		}

		g_Sql_DirectExecute("DELETE FROM REGUMDATA");
		
		MessageBoxEx(CONFIRM_OK, "자료삭제을 완료 했습니다.");
	}
}


