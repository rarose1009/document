/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_MENU
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
//	#define USE_ON_TIMER

	#include "DefEvent.h"

	#include "ArrayList.c"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_WRKLST )			//작업리스트
		DEF_BUTTON_ID ( BID_RECEIPT)			//수납자료현황
		DEF_BUTTON_ID ( BID_DAYRCV )			//일일자료수신
		DEF_BUTTON_ID ( BID_SND    )			//미처리송신
		DEF_BUTTON_ID ( BID_CARDLIST )			//카드승인목록(승인취소)
		DEF_BUTTON_ID ( BID_PRINTTEST )			//인쇄테스트
		DEF_BUTTON_ID ( BID_SILSA )				//현장실사
		DEF_BUTTON_ID ( BID_WORKREPORT )		//업무보고(현장용)
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
	bool Test_Print(void);
	bool Test_PrintEx(void);
	void* Test_GetList(void);
	long Test_Print_Result(void* p);
	
	CARRAYLIST m_pList = NULL;
	bool m_bPrintAgain = FALSE;
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "민 원 메 뉴"),

		//DLG_BUTTON(STARTX,     STARTY+180, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRKLST    , "작업리스트"),
		//DLG_BUTTON(STARTX+500, STARTY+180, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RECEIPT , "수납자료현황"),
		//DLG_BUTTON(STARTX,     STARTY+330, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DAYRCV  , "일일자료수신"),
		//DLG_BUTTON(STARTX+500, STARTY+330, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SND, "미처리송신"),
		//DLG_BUTTON(STARTX,     STARTY+480, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CARDLIST , "카드승인목록\n(승인취소)"),
		//DLG_BUTTON(STARTX+500, STARTY+480, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PRINTTEST   , "인쇄테스트"),
		//DLG_BUTTON(STARTX,     STARTY+630, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SILSA   , "현장실사"),
		//DLG_BUTTON(STARTX+500, STARTY+630, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WORKREPORT , "업무보고\n(현장용)"),

		DLG_BUTTON(STARTX,     STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRKLST    , ""),
		DLG_BUTTON(STARTX+495, STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RECEIPT , ""),
		DLG_BUTTON(STARTX,     STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DAYRCV  , ""),
		DLG_BUTTON(STARTX+495, STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SND, ""),
		DLG_BUTTON(STARTX,     STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CARDLIST , ""),
		DLG_BUTTON(STARTX+495, STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PRINTTEST   , ""),
		DLG_BUTTON(STARTX,     STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SILSA   , ""),
		DLG_BUTTON(STARTX+495, STARTY+65+(3*BTNHT), BTNWH, BTNHT, 60, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WORKREPORT , ""),
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "민 원 메 뉴"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-40, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WRKLST    , "작업리스트"),
		DLG_BUTTON(STARTX+500,  STARTY-40, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECEIPT , "수납자료현황"),
		DLG_BUTTON(STARTX,     STARTY+110, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DAYRCV  , "일일자료수신"),
		DLG_BUTTON(STARTX+500, STARTY+110, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SND, "미처리송신"),
		DLG_BUTTON(STARTX,     STARTY+260, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDLIST , "카드승인목록\n(승인취소)"),
		DLG_BUTTON(STARTX+500, STARTY+260, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINTTEST   , "인쇄테스트"),
		DLG_BUTTON(STARTX,     STARTY+410, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SILSA   , "현장실사"),
		DLG_BUTTON(STARTX+500, STARTY+410, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WORKREPORT , "업무보고\n(현장용)"),
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
				g_FlagClear();
				SetBtnImg();
				g_lindex = 0;
				g_lDataflag = 0;
				Mem_Set( (byte*)&stBill, 0x00, sizeof(stBill) );
				g_nCustFlag = 0;
				g_lNewBurFlag = 0;
				// 사용안함 2017.07.26 Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				g_lPAYFlag = 0;
				g_nStopReleFlag = 0;
				Mem_Set( (byte*)&stChgMtr, 0x00, sizeof(stChgMtr) );
				Mem_Set( (byte*)&stCardinfo, 0x00, sizeof(stCardinfo) );
				Mem_Set( (byte*)&stCashinfo, 0x00, sizeof(stCashinfo) );
				g_nPhotoFlag= 0;
				g_nPhotoYNFlag = 0;
				g_nActRow = 0;
				g_nGrpIndex = 0;
					
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	char szSql[200];
	char szDate[10];
	long nCnt = 0;
	
		switch(ID)
		{					
			case BID_WRKLST:
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Str_ItoA( Time_GetDate(), szDate, 10);
				SPRINT( szSql ,"SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN WHERE PROMISE_YMD <> '%s' ",szDate,0,0   );
				g_Sql_RetInt(szSql, &nCnt );
				if(nCnt > 0)
				{
					MessageBoxEx(ERROR_OK, "금일자료가 아닙니다.\n일일자료를 수신하세요.");
					return;
				}
				
				Card_Move("C6101_LST");
				break;
				
			case BID_RECEIPT:
				Card_Move("C6101_RECEIPT");
				break;
			case BID_DAYRCV:
				Card_Move("C6101_DAYRCV");
				break;
			case BID_SND:
				Card_Move("C6101_SND");
				break;
			case BID_CARDLIST:
				g_Sql_DirectExecute("DELETE FROM RCV_TMP ");
				Card_Move("C6101_CARDLST");
				break;
			case BID_PRINTTEST:
				Test_PrintEx();
				//Card_Move("C6101_PRINTTEST");
				break;
			case BID_SILSA:
				g_nWorkFlag = 699;
				Card_Move("C6101_SILSA");
				break;
			case BID_WORKREPORT:
				g_nAddrFlag = 1;
				g_nWorkFlag = 698;
				g_nScrollIndex = 0;
				Card_Move("C6101_WRKREPORT");
				break;
							
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
			h = Get_hDlgCtrlByID(BID_WRKLST);
			ButCtrl_SetImage( h,  g_pImgMw_Work);
			
			h = Get_hDlgCtrlByID(BID_RECEIPT);
			ButCtrl_SetImage( h,  g_pImgMw_Receipt);
			
			h = Get_hDlgCtrlByID(BID_DAYRCV);
			ButCtrl_SetImage( h,  g_pImgMw_Data);
			
			h = Get_hDlgCtrlByID(BID_SND);
			ButCtrl_SetImage( h,  g_pImgMw_Snd);
			
			h = Get_hDlgCtrlByID(BID_CARDLIST);
			ButCtrl_SetImage( h,  g_pImgMw_Card);
			
			h = Get_hDlgCtrlByID(BID_PRINTTEST);
			ButCtrl_SetImage( h,  g_pImgMw_Print);

			h = Get_hDlgCtrlByID(BID_SILSA);
			ButCtrl_SetImage( h,  g_pImgMw_Silsa);

			h = Get_hDlgCtrlByID(BID_WORKREPORT);
			ButCtrl_SetImage( h,  g_pImgMw_Report);
		}
	}

	//------------------------------------------------------------------
	long Test_Print_Result(void* p)
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
				Test_PrintEx();
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

	//#define __CLEAN_EARTH__
	//------------------------------------------------------------------
	bool Test_PrintEx(void)
	{
	
		if( g_IsCardReader() )
		{
			MessageBoxEx (CONFIRM_OK, "블루투스 연결설정을 확인하세요.");
			return FALSE;
		}
		
	
	PRINT("Test_PrintEx", 0,0,0);
	
		if (m_bPrintAgain == FALSE)
		{
      callBackfunc = NULL;
			
#ifdef __CLEAN_EARTH__
			
			m_pList = NewArrayList();
			
			//컴포지션이 아니라 엘레먼트가 상수라서 해제하면 오류 남.
			m_pList->addStr(m_pList, "프린터 테스트....__CLEAN_EARTH__");
			m_pList->addStr(m_pList, "\n\n\n");
		
#else

			m_pList = Test_GetList();

#endif // __CLEAN_EARTH__

		}
		
		g_Printer_Start(m_pList, (void*)Test_Print_Result);
		
		return TRUE;
	}
	
	//------------------------------------------------------------------
	void* Test_GetList(void)
	{
		char szBuf[50];
		char szMsg[50];
		char sztmp[100];
		CARRAYLIST list = NewArrayList();

		PRINT("Test_GetList", 0,0,0);

		if (list == NULL)
		{
			return NULL;
		}

		//상수로 입력할 경우, addStr는 포인터만 참조한다.
		//포인터를 clone 해야할 경우, append 매쏘드를 사용해야 함.
		//2017-08-23 Sanghyun Lee
		//프린트 테스트 내용 변경(신기호 요청)

		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		Str_Cat(sztmp, "발행일시 : ");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		g_Str_DateType(szMsg, szBuf);
		Str_Cat(sztmp, szMsg);
		Str_Cat(sztmp, " ");
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		g_Str_TimeType( szBuf , Time_GetTime());
		Str_Chg(szBuf, STRCHG_DEL_NONDIGIT);
		g_Str_TimeForm(szMsg, szBuf);
		Str_Cat(sztmp, szMsg);

		list->append(list, "                                ");
		list->append(list, "--------------------------------");
		list->append(list, "                                ");
		list->append(list, "        인쇄 테스트 성공        ");
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "                                ");
		list->append(list, "--------------------------------");
		list->append(list, "                                ");
		list->append(list, "                                ");
		
		return list;
	}
		
	//------------------------------------------------------------------
	bool Test_Print(void)
	{
	long ret, idx;
	char LineSpace[]={0x1b,0x20,0x00};
	char szBuf[300];
	char szMsg[300];
	char sztmp[300];
	bool bRet = FALSE;
		
		MessageBoxEx (MESSAGE, "영수증 출력 준비중입니다.");
		
		BT_Close_Printer();
		
		Sleep(10);
		
		//Str_Cpy( g_szPrintPort, "WOOSIM" );
		ret = BT_Init_Printer(g_szPrintPort, 57600, 1);
		
		Sleep(30);
		
		switch ( ret )
		{
			case 1 :
				break;
			case -1 :
				MessageBoxEx (ERROR_OK, "오픈 실패. PDA 리셋후 다시 시도해주세요.");
				return bRet;
			case -2 :
				MessageBoxEx (ERROR_OK, "오픈 실패. 프린터 상태를 확인해주세요.(-1)");
				return bRet;
			case -3 :
				MessageBoxEx (ERROR_OK, "오픈 실패(Unable to configure the serial port)");
				return bRet;
			case -4 :
				MessageBoxEx (ERROR_OK, "오픈 실패(Unable to set the timeout parameters)");
				return bRet;
			case -5 :
				MessageBoxEx (ERROR_OK, "오픈 실패. 프린터 상태를 확인해주세요.(5)");
				return bRet;
			case 0 :
				MessageBoxEx (ERROR_OK, "Print Manager를 실행하여 프린터를 등록하세요.");
				return bRet;
			default :
				MessageBoxEx (ERROR_OK, "오픈 실패. 프린터 상태를 확인해주세요.");
				return bRet;
		}
		
		BT_Save_Spool("                                ", 0, 0);
		BT_Save_Spool("      연결철거비(고 객 용)      ", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("       서울도시가스(주)        ", 0, 0);
		BT_Save_Spool("  강북1 고객센타\n", 0, 0);
		BT_Save_Spool("상  호  명  : 용산도시가스\n", 0, 0);
		BT_Save_Spool("사업자번호  : 106-86-62332 \n", 0, 0);
		BT_Save_Spool("대  표  자  : 탁운기\n", 0, 0);
		BT_Save_Spool("담  당  자  : 김성동\n", 0, 0);
		BT_Save_Spool("전 화 번 호 : 02-712-3834\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("고 객 명 : 이**자\n", 0, 0);
		BT_Save_Spool("고객번호 : 10014-03909\n", 0, 0);
		BT_Save_Spool("지번주소 : 서울 용산구 서계동\n", 0, 0);
		BT_Save_Spool("           262-1 2층\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("도로명주소 : 서울특별시 용산구\n", 0, 0);
		BT_Save_Spool("           　효창원로 278-10\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("검침일/납기 : 19일/10납기\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("    일반호수2M내     9,000원\n", 0, 0);
		BT_Save_Spool("          휴즈콕     6,000원\n", 0, 0);
		BT_Save_Spool("          출장비     8,000원\n", 0, 0);
		BT_Save_Spool("          시공비    13,000원\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("   공 급   가 액 :  32,728원\n", 0, 0);
		BT_Save_Spool("   부    가   세 :   3,272원\n", 0, 0);
		BT_Save_Spool("① 연결 철거비계 :  36,000원\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool(" [현 금] :  36,000원\n", 0, 0);
		BT_Save_Spool("총계(①) :  36,000원\n", 0, 0);
		BT_Save_Spool("수납금액 :  36,000원\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("[서비스 품질 보증기간]          ", 0, 0);
		BT_Save_Spool("1. 연소기 연결 시공 후 2년 이내 ", 0, 0);
		BT_Save_Spool("   제품이상 발생 시 (기존 사용  ", 0, 0);
		BT_Save_Spool("   제품은 해당 없음) 무상으로 재", 0, 0);
		BT_Save_Spool("   시공해 드립니다.             ", 0, 0);
		BT_Save_Spool("2. 소비자 부주의에 의한 품질 훼 ", 0, 0);
		BT_Save_Spool("   손 및 관리 잘못에 의한 변형, ", 0, 0);
		BT_Save_Spool("   제품 보증기간(2년)이 경과한  ", 0, 0);
		BT_Save_Spool("   신규제품은 보상의 책임을 지지", 0, 0);
		BT_Save_Spool("   않으며, 재 시공시 서비스 비용", 0, 0);
		BT_Save_Spool("   을 부담하셔야 합니다.        ", 0, 0);
		BT_Save_Spool("소비자상담실 : 02-712-3834\n", 0, 0);
		BT_Save_Spool("--------------------------------", 0, 0);
		BT_Save_Spool("실천하는자율점검정착되는안전문화", 0, 0);
		BT_Save_Spool("발행일시 : 2015/08/07 14:15:33 \n", 0, 0);
		
		BT_Print_Spool(TRUE);
		VmSleep(400);
		if(ret == -1)
		{
			BT_Close_Printer();
			bRet = TRUE;
			return bRet;
		}
		
		BT_Clear_Spool();
		BT_Close_Printer();

		CloseMessageBox();
		ON_DRAW();
		return bRet;
	}
}


