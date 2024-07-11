/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_MENU
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
		DEF_BUTTON_ID ( BID_GM )		//정상검침 
		DEF_BUTTON_ID ( BID_NOGM )		//순수미검침 
		DEF_BUTTON_ID ( BID_ABSNC )		//부재 
		DEF_BUTTON_ID ( BID_SLCT )		//지정검침 
		DEF_BUTTON_ID ( BID_GMGO )		//검침바로가기
		DEF_BUTTON_ID ( BID_DATA )		//자료관리
		DEF_BUTTON_ID ( BID_SMSGM )		//문자검침
		//DEF_BUTTON_ID ( BID_FEEVIEW )	//요금조회
		DEF_BUTTON_ID ( BID_REGM )		//재검
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
		DEF_OBJECT_ID ( TXT_BACK )
		DEF_OBJECT_ID ( TXT_BORDER )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
		DEF_OBJECT_ID ( LINE_DATA4 )
		DEF_OBJECT_ID ( LINE_DATA5 )		
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
	
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
	
	void SetBtnImg(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		
		//DLG_TEXT(0, 0, 1000, 1000, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, WHITE, DEEPBLUE, TXT_BACK, ""),

		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "검침 메뉴"),
/*
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, " 정 상 검 침"),
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, " 순 수 미 검 침"),
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, " 부 재 검 침"),
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, " 지 정 검 침"),
		DLG_BUTTON(STARTX+120, STARTY+320, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, " 검침바로가기"),
		DLG_BUTTON(STARTX+120, STARTY+470, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, " 자료 관리"),
*/
		//DLG_BUTTON(STARTX,     STARTY+180, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, "정 상 검 침"),
		//DLG_BUTTON(STARTX+500, STARTY+180, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, "순 수 미 검 침"),
		//DLG_BUTTON(STARTX,     STARTY+330, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, "부 재 검 침"),
		//DLG_BUTTON(STARTX+500, STARTY+330, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, "지 정 검 침"),
		//DLG_BUTTON(STARTX,     STARTY+480, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, "검침바로가기"),
		//DLG_BUTTON(STARTX+500, STARTY+480, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, "자 료 관 리"),
		//DLG_BUTTON(STARTX,     STARTY+630, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SMSGM, "문 자 검 침"),
		//DLG_BUTTON(STARTX+500, STARTY+630, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, "요 금 조 회"),
		
		DLG_BUTTON(STARTX,     STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, ""), // 정 상 검 침
		DLG_BUTTON(STARTX+495, STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, ""), // 순 수 미 검 침
		DLG_BUTTON(STARTX,     STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, ""), // 부 재 검 침
		DLG_BUTTON(STARTX+495, STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, ""), // 지 정 검 침
		DLG_BUTTON(STARTX,     STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, ""), // 검침바로가기
		//DLG_BUTTON(STARTX+495, STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""), // 자 료 관 리
		DLG_BUTTON(STARTX+495, STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REGM, ""),// 재검
		DLG_BUTTON(STARTX,     STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SMSGM, ""), // 문 자 검 침
		//DLG_BUTTON(STARTX+495, STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, ""), // 요 금 조 회
		DLG_BUTTON(STARTX+495, STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""),// 자료관리
		
		DLG_LINE(500, STARTY+65,        500, STARTY+899, LINECTRLCOLOR, 2, LINE_DATA1),
		DLG_LINE(0,  STARTY+65+(1*BTNHT), STARTX+995, STARTY+65+(1*BTNHT), LINECTRLCOLOR, 2, LINE_DATA2),
		DLG_LINE(0,  STARTY+65+(2*BTNHT), STARTY+995, STARTY+65+(2*BTNHT), LINECTRLCOLOR, 2, LINE_DATA3),
		DLG_LINE(0,  STARTY+65+(3*BTNHT), STARTX+995, STARTY+65+(3*BTNHT), LINECTRLCOLOR, 2, LINE_DATA4)
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "검침 메뉴"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
/*	
		DLG_BUTTON(STARTX+150,     STARTY, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, "정상 검침"),
		DLG_BUTTON(STARTX+150, STARTY+150, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, " 순 수 미 검 침"),
		DLG_BUTTON(STARTX+150, STARTY+300, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, " 부 재 검 침"),
		DLG_BUTTON(STARTX+150, STARTY+450, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, " 지 정 검 침"),
		DLG_BUTTON(STARTX+150, STARTY+600, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, "검침 바로가기"),
		DLG_BUTTON(STARTX+150, STARTY+750, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, "자료 관리"),
*/
		DLG_BUTTON(STARTX,     STARTY+140, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GM, "정 상 검 침"),
		DLG_BUTTON(STARTX+500, STARTY+140, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOGM, "순 수 미 검 침"),
		DLG_BUTTON(STARTX,     STARTY+290, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ABSNC, "부 재 검 침"),
		DLG_BUTTON(STARTX+500, STARTY+290, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SLCT, "지 정 검 침"),
		DLG_BUTTON(STARTX,     STARTY+440, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMGO, "검침바로가기"),
		DLG_BUTTON(STARTX+500, STARTY+440, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATA, "자 료 관 리"),
		DLG_BUTTON(STARTX,     STARTY+590, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMSGM, "문 자 검 침"),
		//DLG_BUTTON(STARTX+500, STARTY+590, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, "요 금 조 회"),
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
		char szSql[150];
	
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
				g_FlagClear();
				SetBtnImg();

				//순수미검침 FLAG 업데이트
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE GUMDATA SET SEND_YN = 'S' WHERE SEND_YN = 'I'", 0, 0, 0);		
				g_Sql_DirectExecute(szSql);

				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[300];
		long lCnt;
		
		if( g_ChkDay() )
			return;
	
		switch(ID)
		{					
			case BID_GM:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 100;
					Card_Move("GM_GRPLST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				break;	
			case BID_NOGM:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 103;
					Card_Move("GM_NOGMLST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				break;
			case BID_ABSNC:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 104;
					Card_Move("GM_ABSNCLST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				break;
			case BID_SLCT:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 101;
					Card_Move("GM_SLCTGM");
				}
				else
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				break;
			case BID_GMGO:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt > 0 )
				{	//파일에 데이터 셋
					g_nWorkFlag = 100;
					g_lMoveFlag = 1;
					
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Str_Cpy(szSql, "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE");
					g_Sql_SaveSeq( szSql, SREACH_FILE);
					Get_Index();				

					Card_Move("GM_ENTRY");
				}
				else
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				break;	
			case BID_DATA:
				Card_Move("GM_DMMENU");
				break;
			case BID_SMSGM:
				//해당 화면 주소 초기 상태 -> 도로명
				g_nAddrFlag = 1;
				g_nSmsFlag = 0;
				Card_Move("GM_SMSGM");
				break;
			case BID_REGM:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM REGUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 100;
					Card_Move("GM_RELST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				break;
				/*
			case BID_FEEVIEW:
				//해당 업무 수신 관련 테이블 클리어
				g_Sql_DirectExecute("DELETE FROM GUM_FEE_INFO");
				g_Sql_DirectExecute("DELETE FROM RCV_TMP");
				g_Sql_DirectExecute("DELETE FROM RCV_RELEASE");
				g_Sql_DirectExecute("DELETE FROM RCV_CALCUL");

				Mem_Set((byte*)&stFee_History, 0x00, sizeof(stFee_History));
				Mem_Set((byte*)&stFee_Calcul, 0x00, sizeof(stFee_Calcul));
				Mem_Set((byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
				Mem_Set((byte*)g_szUSE_CONT_NUM_Fee, 0x00, sizeof(g_szUSE_CONT_NUM_Fee));
				Mem_Set((byte*)g_szIndi_Cur, 0x00, sizeof(g_szIndi_Cur));
				g_lPAYFlag = 0;
				
				Card_Move("GM_FEEVIEW");
				break;
				*/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
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
				Card_Move("MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
					
		if( theDevInfo.m_nType > FAMILY_PDA )
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
			
			//메뉴버튼
			h = Get_hDlgCtrlByID(BID_GM);
			ButCtrl_SetImage( h,  g_pImgGm_Normal);
			
			h = Get_hDlgCtrlByID(BID_NOGM);
			ButCtrl_SetImage( h,  g_pImgGm_Nogm);
			
			h = Get_hDlgCtrlByID(BID_ABSNC);
			ButCtrl_SetImage( h,  g_pImgGm_Absnc);
			
			h = Get_hDlgCtrlByID(BID_SLCT);
			ButCtrl_SetImage( h,  g_pImgGm_Sel);
			
			h = Get_hDlgCtrlByID(BID_GMGO);
			ButCtrl_SetImage( h,  g_pImgGm_Go);
			
			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgGm_Data);
		
			h = Get_hDlgCtrlByID(BID_SMSGM);
			ButCtrl_SetImage( h,  g_pImgGm_Sms);
			
			//h = Get_hDlgCtrlByID(BID_FEEVIEW);
			//ButCtrl_SetImage( h,  g_pImgGm_Feeview);
			
			h = Get_hDlgCtrlByID(BID_REGM);
			ButCtrl_SetImage( h,  g_pImgGm_Regm);

/*
			h = Get_hDlgCtrlByID(BID_GM);
			ButCtrl_SetImage( h,  g_pImgGmBtn);
			
			h = Get_hDlgCtrlByID(BID_NOGM);
			ButCtrl_SetImage( h,  g_pImgNoGmBtn);
			
			h = Get_hDlgCtrlByID(BID_ABSNC);
			ButCtrl_SetImage( h,  g_pImgAbsncBtn);
			
			h = Get_hDlgCtrlByID(BID_SLCT);
			ButCtrl_SetImage( h,  g_pImgGmSlctBtn);
			
			h = Get_hDlgCtrlByID(BID_GMGO);
			ButCtrl_SetImage( h,  g_pImgGmgoBtn);

			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgGmDataBtn);
*/
		}
	}
	
	/*=======================================================================================
	함수명 : Get_Index
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Get_Index(void)
	{
		char szsql[101];
		char szbuf[10];
		long lret;
		
		Mem_Set((byte*)szsql, 0x00, sizeof(szsql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		Str_Cpy(szsql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '1'  ");	
		g_Sql_RetStr(szsql, 4, szbuf);
		
		lret = Str_AtoI(szbuf);
		
		if( lret == 0 )
		{
			g_nActIndex = lret;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		else
		{
			g_lindex = lret;
			g_nActIndex = g_Get_FsIndex(g_lindex, SREACH_FILE);
		}
	}
}


