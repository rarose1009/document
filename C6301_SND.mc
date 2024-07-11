/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_SND
{
#include <include.h>
#include "globalcard.h"
#include "Calendar.h"
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
	DEF_BUTTON_ID(BID_SEND)		 //선택송신
	DEF_BUTTON_ID(BID_DAYEND)	 //일마감
	DEF_BUTTON_ID(BID_WORKSCHDL) //작업일자
								 //화면 상단 공통 메뉴 모음
	DEF_BUTTON_ID(BID_HOME)		 //홈
	DEF_BUTTON_ID(BID_MENU)		 //메뉴
	DEF_BUTTON_ID(BID_KEYBOARD)	 //키보드
	DEF_BUTTON_ID(BID_SCREEN)	 //화면 상하
	DEF_BUTTON_ID(BID_CMMNWORK)	 //공통업무
	DEF_BUTTON_ID(BID_PREV)		 //이전
	DEF_BUTTON_ID(BID_EXIT)		 //종료
	END_BUTTON_ID()

	BEGIN_OBJECT_ID()
	DEF_OBJECT_ID(TXT_TITLE) //타이틀
	DEF_OBJECT_ID(TXT_DATA1)
	DEF_OBJECT_ID(TXT_DATA2)
	DEF_OBJECT_ID(TXT_DATA3)
	DEF_OBJECT_ID(TXT_DATA4)
	DEF_OBJECT_ID(TXT_DATA5)
	DEF_OBJECT_ID(TXT_DATA6)
	DEF_OBJECT_ID(TXT_DATA7)
	DEF_OBJECT_ID(TXT_DATA8)
	DEF_OBJECT_ID(TXT_DATA9)
	DEF_OBJECT_ID(TXT_DATA10)
	DEF_OBJECT_ID(TXT_DATA11)
	DEF_OBJECT_ID(TXT_DATA12)
	DEF_OBJECT_ID(TXT_DATA13)
	DEF_OBJECT_ID(TXT_DATA14)
	DEF_OBJECT_ID(TXT_DATA15)
	DEF_OBJECT_ID(TXT_DATA16)
	DEF_OBJECT_ID(TXT_DATA17)
	DEF_OBJECT_ID(TXT_DATA18)
	DEF_OBJECT_ID(TXT_DATA19)
	DEF_OBJECT_ID(TXT_DATA20)
	DEF_OBJECT_ID(TXT_DATA21)

	DEF_OBJECT_ID(ICON_TITLE)
	END_OBJECT_ID()

#define INIT_MAIN 1

	char m_szScrPht[128];
	char m_szSession[128];

	long m_nstrt = 0;
	long m_lCnt = 0;

	long m_lPhotoSendCnt = 0;

#define SNDCNT 10

	void SetStyle(void);
	void REDRAW(void);
	void SetBtnImg(void);
	void Send_Data(void);
	void Send_Photo(void);
	long TR75302(void);
	long TR75304(void);
	void fsgetitem(char *szSource, char *szTarget, int id, int len);

	SysButCtrl SysButRes_MAIN[] =
		{
			SYS_BUT_IMG(BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_HOME, 0),
			SYS_BUT_IMG(BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0),
			SYS_BUT_IMG(BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_SCREEN, 0),
			SYS_BUT_IMG(BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0),
			SYS_BUT_IMG(BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0),
			SYS_BUT_IMG(BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD | BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0),
			SYS_BUT_IMG(BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD | BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0),
		};

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes[] =
		{
			NORM_DLG("", "", DLGSTY_HSCROLLBAR | DLGSTY_VSCROLLBAR | DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
			DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
			//타이틀
			DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "자 료 송 신"),

			DLG_BUTTON(STARTX + 600, STARTY + 800, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEND, "자 료 송 신"),

			DLG_TEXT(STARTX, STARTY + 65, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "수신일자"),
			DLG_TEXT(STARTX + 400, STARTY + 65, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
			DLG_TEXT(STARTX, STARTY + 150, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "구 분"),
			DLG_TEXT(STARTX + 600, STARTY + 150, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "실 적"),
			DLG_TEXT(STARTX, STARTY + 220, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "대 상"),
			DLG_TEXT(STARTX + 600, STARTY + 220, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
			DLG_TEXT(STARTX, STARTY + 290, 200, 210, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "완료"),
			DLG_TEXT(STARTX + 200, STARTY + 290, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "계량기"),
			DLG_TEXT(STARTX + 600, STARTY + 290, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
			DLG_TEXT(STARTX + 200, STARTY + 360, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "보정기"),
			DLG_TEXT(STARTX + 600, STARTY + 360, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
			DLG_TEXT(STARTX + 200, STARTY + 430, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "계량기/보정기"),
			DLG_TEXT(STARTX + 600, STARTY + 430, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
			DLG_TEXT(STARTX, STARTY + 500, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "미완료"),
			DLG_TEXT(STARTX + 600, STARTY + 500, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
			DLG_TEXT(STARTX, STARTY + 570, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "교체불가"),
			DLG_TEXT(STARTX + 600, STARTY + 570, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
			DLG_TEXT(STARTX, STARTY + 640, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "송 신"),
			DLG_TEXT(STARTX + 600, STARTY + 640, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
			DLG_TEXT(STARTX, STARTY + 710, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "미송신"),
			DLG_TEXT(STARTX + 600, STARTY + 710, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		};

	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject DlgRes_P[] =
		{
			NORM_DLG("", "", DLGSTY_HSCROLLBAR | DLGSTY_VSCROLLBAR | DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
			DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
			//타이틀
			DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "자료 송신"),
			DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC, "", GID_PREV, ""),

			DLG_BUTTON(STARTX + 600, STARTY + 770, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEND, "자 료 송 신"),

			DLG_TEXT(STARTX, STARTY - 40, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "수신일자"),
			DLG_TEXT(STARTX + 400, STARTY - 40, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
			DLG_TEXT(STARTX, STARTY + 100, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "구 분"),
			DLG_TEXT(STARTX + 600, STARTY + 100, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "실 적"),
			DLG_TEXT(STARTX, STARTY + 170, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "대 상"),
			DLG_TEXT(STARTX + 600, STARTY + 170, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
			DLG_TEXT(STARTX, STARTY + 240, 200, 210, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "완료"),
			DLG_TEXT(STARTX + 200, STARTY + 240, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "계량기"),
			DLG_TEXT(STARTX + 600, STARTY + 240, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
			DLG_TEXT(STARTX + 200, STARTY + 310, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "보정기"),
			DLG_TEXT(STARTX + 600, STARTY + 310, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
			DLG_TEXT(STARTX + 200, STARTY + 380, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "계량기/보정기"),
			DLG_TEXT(STARTX + 600, STARTY + 380, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
			DLG_TEXT(STARTX, STARTY + 450, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "미완료"),
			DLG_TEXT(STARTX + 600, STARTY + 450, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
			DLG_TEXT(STARTX, STARTY + 520, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "교체불가"),
			DLG_TEXT(STARTX + 600, STARTY + 520, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
			DLG_TEXT(STARTX, STARTY + 590, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "송 신"),
			DLG_TEXT(STARTX + 600, STARTY + 590, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
			DLG_TEXT(STARTX, STARTY + 660, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "미송신"),
			DLG_TEXT(STARTX + 600, STARTY + 660, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		};

	//----------------------------------------------------------------------
	bool main(quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER(MsgType, wParam, lParam);
		return TRUE;
	}

	//┌─────────────────────────────────────┐
	//│ 				   『	OnInit Function  』  				              │
	//└─────────────────────────────────────┘
	void OnInit(char bFirst)
	{
		char szSql[150];

		switch (bFirst)
		{
		case INIT_MAIN:
			switch (theDevInfo.m_nType)
			{
			case FAMILY_PDA:
				CREATE_DIALOG_OBJECT(DlgRes_P, SIZEOF(DlgRes_P));
				break;
			default:
				CREATE_GLOBAL_BUTTON(SysButRes_MAIN);
				CREATE_DIALOG_OBJECT(DlgRes, SIZEOF(DlgRes));
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
		void *h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl); //타이틀
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER | EDITALIGN_MIDDLE);

		if (theDevInfo.m_nType != FAMILY_PDA)
		{
			//상단공통메뉴
			h = GetSysButHandle(GID_HOME);
			ButCtrl_SetImage(h, g_pImgHomeI);
			ButCtrl_SetActiveImage(h, g_pImgHomeA);

			h = GetSysButHandle(GID_KEYBOARD);
			ButCtrl_SetImage(h, g_pImgKeybrdI);
			ButCtrl_SetActiveImage(h, g_pImgKeybrdA);

			h = GetSysButHandle(GID_SCREEN);
			ButCtrl_SetImage(h, g_pImgScreenI);
			ButCtrl_SetActiveImage(h, g_pImgScreenA);

			h = GetSysButHandle(GID_CMMNWK);
			ButCtrl_SetImage(h, g_pImgCmmnwrkI);
			ButCtrl_SetActiveImage(h, g_pImgCmmnwrkA);

			h = GetSysButHandle(GID_VMEXIT);
			ButCtrl_SetImage(h, g_pImgExitI);
			ButCtrl_SetActiveImage(h, g_pImgExitA);
		}
	}

	//-----------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER | EDITALIGN_MIDDLE);
	}

	//------------------------------------------------------------------
	void OnButton(long ID)
	{
		switch (ID)
		{
		case BID_SEND:
			Send_Data();
			//Send_Photo();
			break;
		case GID_HOME:
			if (MessageBoxEx(CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?") == MB_OK)
			{
				Card_Move("MENU");
			}
			break;
		case GID_MENU:
			if (MessageBoxEx(CONFIRM_YESNO, "계량기교체 메뉴로\n나가시겠습니까?") == MB_OK)
			{
				Card_Move("C6301_MENU");
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
			Card_Move("C6301_DMMENU");
			break;
		case GID_VMEXIT:
			g_Exit();
			break;
		}
	}

	//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szDate[20];
		char sztmp[10];
		char szSql[200];

		//수신일자
		Mem_Set((byte *)szDate, 0x00, sizeof(szDate));
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT PARAM7 FROM RCV_LOG WHERE GUBUN = '8' ", 8, sztmp);
		g_Str_DateType(szDate, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szDate);

		//대상
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA ", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp);

		//계량기 완료
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN = 'Y' OR SEND_YN = 'S') AND (PDA_REPL_JOB_ITEM = '10') AND (LENGTH(REPL_NOT_PERMIT_WHY) <= 0 OR REPL_NOT_PERMIT_WHY IS NULL)", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), sztmp);

		//보정기 완료
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN = 'Y' OR SEND_YN = 'S') AND (PDA_REPL_JOB_ITEM = '20') AND (LENGTH(REPL_NOT_PERMIT_WHY) <= 0 OR REPL_NOT_PERMIT_WHY IS NULL)", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), sztmp);

		//계량기+보정기 완료
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN = 'Y' OR SEND_YN = 'S') AND (PDA_REPL_JOB_ITEM = '30') AND (LENGTH(REPL_NOT_PERMIT_WHY) <= 0 OR REPL_NOT_PERMIT_WHY IS NULL)", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), sztmp);

		//미완료
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN = 'N' OR SEND_YN = '' OR SEND_YN IS NULL) ", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), sztmp);

		//교체불가 , (LENGTH(REPL_NOT_PERMIT_WHY) > 0)
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN = 'Y' OR SEND_YN = 'S') AND (LENGTH(REPL_NOT_PERMIT_WHY) > 0)", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), sztmp);

		//송신
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'Y' ", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), sztmp);

		//미송신
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'S' ", 5, sztmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), sztmp);

		ON_DRAW();
		return;
	}

	//------------------------------------------------------------------------------------------
	//계량기교체결과송신
	void Send_Data(void)
	{
		char szUrl[200];
		char szSql[1300];
		char szSql2[100];
		char szbuf[128];
		char *sndbuf;
		long ret = 0;

		g_SeverConnection();

		Mem_Set((byte *)szbuf, 0x00, sizeof(szbuf));
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'S' ", 4, szbuf);
		m_lCnt = Str_AtoI(szbuf);
		if (m_lCnt == 0)
		{
			MessageBoxEx(CONFIRM_OK, "송신할 자료가 없습니다.");
			return;
		}

		//PRINT("C6301_SND>>>>>>> Send_Data >>>>>>> START TIME : %d",Time_GetTime(),0,0);

		if (g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75302, FALSE);

		JSON_SetValue(g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd);

		sndbuf = JSON_toString(g_pjcomm);

		//송신정보 저장
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte *)szbuf, 0x00, sizeof(szbuf));
		GET_FILENM(szbuf, SQLITE_DB);

		Mem_Set((byte *)szSql, 0x00, sizeof(szSql));
 		SPRINT(szSql, "SELECT \
      mtr_num , visit_ymd as repl_treat_ymd , obj_crt_ymd , center_cd ,  pda_repl_job_item \
 , pda_num , inst_place_num , mtr_fee_free_flag , mtr_repl_why , mtr_bar , after_mtr_id_num \
 , after_mtr_model_cd , after_mtr_grd , after_mtr_form , after_mtr_type , after_mtr_remote_flag \
 , after_mtr_kind , after_mtr_digit_cnt , after_mtr_new_fix_flag , after_fix_firm_nm_cd \
 , after_mtr_valid_ym , after_mtr_appro_yn , compens_fee_free_flag , compens_repl_why \
 , compens_bar , after_compens_num , after_compens_id_num , after_compens_model_cd \
 , after_compens_valid_ym , after_compens_press , after_form_appro_yn , remove_indi_vm \
 , remove_indi_va , remove_indi_vc , inst_indi_vm , inst_indi_va , inst_indi_vc \
 , temper , press , revis_para , treat_flag , repl_not_permit_why , job_dtm , jober_empid \
 , mtr_photo , compens_photo , cust_sign , visit_ymd , memo, comm_num_24 as comm_num , comm_firm , inflow_flag  \
 , nobill_yn ,use_cont_num , prod_cont_seq , buld_center_cd , repl_treat_insti , no_bill_repl_why \
 , battery_yn, mtrdisplay_yn , other_price , remote_system , old_mtr_id_num , concent_inst_amt_yn \
   FROM C6301_CHANGEDATA WHERE SEND_YN = 'S' ",0, 0, 0);

		callBackfunc = TR75302; //통신완료 후에 호출 함수
		HTTP_UploadData(szUrl, "FR75302_IN", "FR75302", sndbuf, szbuf, szSql);
	}

	//------------------------------------------------------------------------------------------
	long TR75302(void)
	{
		char szTmp[200];

		if (g_Chk_Json(75302) >= 0)
		{
			//PRINT("C6301_SND>>>>>> Send_Data >>>>>>>> END TIME : %d",Time_GetTime(),0,0);

			//사진전송
			Send_Photo();

			/*
			g_Sql_DirectExecute( "UPDATE C6301_CHANGEDATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S'" );
			
			g_Sock_Close();
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SPRINT(szTmp, "%d건 전송완료.", m_lCnt, 0, 0);
			MessageBoxEx (CONFIRM_OK, szTmp);
			
			REDRAW();
*/
			return 1;
		}
		else
		{
			g_Sock_Close();

			CloseMessageBox();
			REDRAW();
			return -1;
		}
	}

	//------------------------------------------------------------------------------------------
	void Send_Photo(void)
	{
		char szTmp[50];
		char szbuf[128];
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char *sndbuf;
		char *szfile;
		char *filedata;
		long ret = 0, nRet, filesize, fd;
		handle file;
		
		//PRINT("C6301_SND>>>>>> Send_Photo >>>>>>>> START TIME : %d",Time_GetTime(),0,0);

		//		Mem_Set( (byte*) szbuf, 0x00, sizeof( szbuf) );
		//		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'S' ", 4, szbuf );
		//		m_lCnt = Str_AtoI(szbuf);

		Mem_Set((byte *)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte *)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_GC);

		nRet = g_FindFiles(szDirPath, "*.jjp", m_szScrPht);
		if (nRet > 0)
		{
			if (g_pjcomm != NULL)
			{
				JSON_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75304, FALSE);

			Mem_Set((byte *)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			Mem_Set((byte *)szdata, 0x00, sizeof(szdata));

			fsgetitem(m_szScrPht + 9, szdata, 1, Str_Len(m_szScrPht));
			JSON_SetValue(g_pjcomm, 'C', "gubun", szdata);
			Mem_Set((byte *)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht + 9, szdata, 2, Str_Len(m_szScrPht));
			JSON_SetValue(g_pjcomm, 'C', "mtr_num", szdata);
			fsgetitem(m_szScrPht + 9, szdata, 3, Str_Len(m_szScrPht));
			JSON_SetValue(g_pjcomm, 'C', "nobill_yn", szdata);

			filesize = FFS_GetSize(m_szScrPht);
			filedata = Mem_Alloc(filesize);

			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG);
			FFS_Read(fd, (byte *)filedata, filesize);
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize);
			szfile = BASE64_GetResult(file);

			//m_lPhotoSendCnt++;
			//PRINT("m_szScrPht : %s , m_lPhotoSendCnt : %d",m_szScrPht,m_lPhotoSendCnt,0);
			JSON_SetValue(g_pjcomm, 'C', "photo", szfile);

			free((byte *)filedata);
			sndbuf = JSON_toString(g_pjcomm);

			//g_Save_JsonFile(sndbuf);

			callBackfunc = TR75304; //통신완료 후에 호출 함수
			HTTP_DownloadData(szUrl, "FR75304_IN", "FR75304", sndbuf, szDbpath);

			if (file != NULL)
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			g_Sql_DirectExecute("UPDATE C6301_CHANGEDATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S'");

			g_Sock_Close();

			FFS_Delete(m_szScrPht);
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "%d건 전송완료.", m_lCnt, 0, 0);
			MessageBoxEx(CONFIRM_OK, szTmp);

			REDRAW();
		}

		return;
	}

	//------------------------------------------------------------------------------------------
	long TR75304(void)
	{
		long lRet;
		char szTmp[30];
		char szDirPath[200];

		if (g_Chk_Json(75304) >= 0)
		{
			FFS_Delete(m_szScrPht);

			Mem_Set((byte *)m_szScrPht, 0x00, sizeof(m_szScrPht));
			Mem_Set((byte *)szDirPath, 0x00, sizeof(szDirPath));
			Str_Cpy(szDirPath, PHOTO_GC);
			lRet = g_FindFiles(szDirPath, "*.jjp", m_szScrPht);
			
			if (lRet > 0)
			{
				Send_Photo();
				return 1;
			}
			else
			{
				g_Sql_DirectExecute("UPDATE C6301_CHANGEDATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S'");
				//사진파일 삭제
				//FFS_Delete(m_szScrPht);

				g_Sock_Close();
				//PRINT("C6301_SND>>>>>> Send_Photo >>>>>>>> END TIME : %d",Time_GetTime(),0,0);
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				SPRINT(szTmp, "%d건 전송완료.", m_lCnt, 0, 0);
				MessageBoxEx(CONFIRM_OK, szTmp);

				REDRAW();
				return 1;
			}
		}
		else
		{
			g_Sock_Close();

			CloseMessageBox();
			REDRAW();
			return -1;
		}
	}

	//------------------------------------------------------------------------------------------
	void fsgetitem(char *szSource, char *szTarget, int id, int len)
	{
		int i;
		int idx;
		int ids;

		idx = 0;
		ids = 1;
		for (i = 0; i < len; i++)
		{
			if (szSource[i] == '_' || szSource[i] == '.')
			{
				if (ids == id)
				{
					szTarget[idx] = 0x00;
					break;
				}
				idx = 0;
				ids++;
				continue;
			}
			if (ids == id)
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}
}
