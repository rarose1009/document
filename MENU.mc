/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card MENU
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
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_GMMENU )	//검침 
		DEF_BUTTON_ID ( BID_SCMENU )	//안전점검
		DEF_BUTTON_ID ( BID_BSMENU )	//특정점검
		DEF_BUTTON_ID ( BID_BFMENU )	//공급전
		DEF_BUTTON_ID ( BID_NOTICE )	//공지사항
		DEF_BUTTON_ID ( BID_MANAGE )	//공통관리
		DEF_BUTTON_ID ( BID_NPMENU ) //체납
		DEF_BUTTON_ID ( BID_MWMENU ) //민원
		DEF_BUTTON_ID ( BID_GCMENU ) //계량기교체
		DEF_BUTTON_ID ( BID_FEEVIEW ) // 요금조회
		
		DEF_BUTTON_ID ( BID_PEXIT )		//PDA종료버튼
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( TXT_DATA1 )
		
		DEF_OBJECT_ID ( PNG_IEXIT )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
		DEF_OBJECT_ID ( LINE_DATA4 )
		DEF_OBJECT_ID ( LINE_DATA5 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	char m_szNotice_Cnt[20];
	
	void SetBtnImg(void);

	long Rcv_Count(void);
	long TR12116(void);
	long CntDraw(long nservicenum);

	SysButCtrl SysButRes_MAIN[] =
	{
		  SYS_BUT_IMG (  BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, 0, 0, OBJ_BUT, GID_HOME,  0),
		  SYS_BUT_IMG (  BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, 0, 0, OBJ_BUT, GID_KEYBOARD,  0),
		  SYS_BUT_IMG (  BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0),
		  SYS_BUT_IMG (  BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, 0, 0, OBJ_BUT, GID_CMMNWK,  0),
		  SYS_BUT_IMG (  BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0),
		  SYS_BUT_IMG (  BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0),
		  SYS_BUT_IMG (  BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0),
	};
	 
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "메인 메뉴 개발계"),
		
		DLG_BUTTON(0,          STARTY+65 , BTNWH     , 167       , 70, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MWMENU, ""),	// 민원
		DLG_BUTTON(STARTX+495, STARTY+65 , BTNWH     , 167       , 70, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BFMENU, ""),	// 공급전점검
		
		DLG_LINE  (500       , STARTY+65 , 500       , STARTY+899, LINECTRLCOLOR, 2, LINE_DATA1),
		
		DLG_BUTTON(STARTX    , STARTY+232, BTNWH     , 167       , 50, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMMENU, ""),	// 검침
		DLG_BUTTON(STARTX+495, STARTY+232, BTNWH     , 167       , 60, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCMENU, ""),	// 안전점검
		
		DLG_LINE  (0         , STARTY+232, STARTX+995, STARTY+232, LINECTRLCOLOR, 2, LINE_DATA2),
		
		DLG_BUTTON(STARTX,     STARTY+399, BTNWH     , 167       , 60, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NPMENU, ""),	// 체납관리
		DLG_BUTTON(STARTX+495, STARTY+399, BTNWH     , 167       , 60, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BSMENU, ""),	// 특정점검
		
		DLG_LINE  (0         , STARTY+399, STARTY+995, STARTY+399, LINECTRLCOLOR, 2, LINE_DATA3),
		
		DLG_BUTTON(STARTX,     STARTY+566, BTNWH     , 167       , 60, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GCMENU, ""),	// 계량기교체
		DLG_BUTTON(STARTX+495, STARTY+566, BTNWH     , 167       , 60, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, ""),	// 요금조회
		DLG_LINE  (0         , STARTY+566, STARTX+995, STARTY+566, LINECTRLCOLOR, 2, LINE_DATA4),
		
		DLG_BUTTON(STARTX    , STARTY+733, BTNWH     , 167       , 60, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOTICE, ""),	// 공지사항
		DLG_TEXT  (STARTX+330, STARTY+847, 100       , 50        , 0 , 0 , EDITSTY_BORDER, EDITSTY_BOLD, RED, TXTINCTRLBK, TXT_DATA1, m_szNotice_Cnt),	// 공지사항
		
		DLG_BUTTON(STARTX+495, STARTY+733, BTNWH     , 167     , 70, 10, BUTSTY_BORDER, 0, BLACK, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MANAGE, ""),	// 공통관리
		
		DLG_LINE  (0         , STARTY+733, STARTY+995, STARTY+733, LINECTRLCOLOR, 2, LINE_DATA5)
	};	

	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "메인 메뉴"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_VMEXIT, ""),
	
/*
		DLG_BUTTON(STARTX,       STARTY-40, BTNWH, 187, 0, 10, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MWMENU, ""),
		DLG_BUTTON(STARTX+499,   STARTY-40, BTNWH, 187, 20, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BFMENU, ""),
		DLG_BUTTON(STARTX,      STARTY+147, BTNWH, 187, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMMENU, ""),
		DLG_BUTTON(STARTX+499,  STARTY+147, BTNWH, 187, 20, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCMENU, ""),
		DLG_BUTTON(STARTX,      STARTY+334, BTNWH, 187, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NPMENU, ""),
		DLG_BUTTON(STARTX+499,  STARTY+334, BTNWH, 187, 20, 10, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BSMENU, ""),
		DLG_BUTTON(STARTX,      STARTY+521, BTNWH, 187, 0, 5, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GCMENU, ""),

		DLG_BUTTON(STARTX+499,  STARTY+521, BTNWH, 187, 10, 5, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOTICE, ""),
		DLG_TEXT(STARTX+500,    STARTY+640,   140, 50, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, RED, TXTINCTRLBK, TXT_DATA1, m_szNotice_Cnt),

		DLG_BUTTON(STARTX,      STARTY+708, BTNWH, 187,  10, 10, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MANAGE, ""),
*/

		DLG_BUTTON(STARTX,       STARTY-40, BTNWH, 187, 0, 10, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MWMENU, "민 원"),
		DLG_BUTTON(STARTX+499,   STARTY-40, BTNWH, 187, 20, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BFMENU, "공급전점검"),
		DLG_BUTTON(STARTX,      STARTY+147, BTNWH, 187, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMMENU, "검 침"),
		DLG_BUTTON(STARTX+499,  STARTY+147, BTNWH, 187, 20, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCMENU, "안전점검"),
		DLG_BUTTON(STARTX,      STARTY+334, BTNWH, 187, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NPMENU, "체 납"),
		DLG_BUTTON(STARTX+499,  STARTY+334, BTNWH, 187, 20, 10, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BSMENU, "특정점검"),
		DLG_BUTTON(STARTX,      STARTY+521, BTNWH, 187, 0, 5, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GCMENU, "계량기교체"),

		DLG_BUTTON(STARTX+499,  STARTY+521, BTNWH, 187, 10, 5, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOTICE, "공지사항"),
		DLG_TEXT(STARTX+500,    STARTY+590,   140, 50, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, RED, BTNCTRLBKCOLOR, TXT_DATA1, m_szNotice_Cnt),

		DLG_BUTTON(STARTX,      STARTY+708, BTNWH, 187,  10, 10, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MANAGE, "공통사항"),


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
		char szSql[200];
	
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

/*
				//로그인확인(Y/N) 업그레이드
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "UPDATE USER_INFO SET LOGIN_CHK = 'N' ");
				g_Sql_DirectExecute( szSql );
*/

				g_FlagClear();
				SetBtnImg();

				//2017-06-15 Sanghyun Lee
				//현장테스트용 카드결제 관련 값 입력.(개통된 단말기는 필요없음)
				//g_Sql_DirectExecute("UPDATE USER_INFO SET CARD_TERM_ID1 = 'DPT0Z15477', CARD_TERM_ID2 = 'DPT0Z15631'");
				//Str_Cpy(stUserinfo.szcard_term_id1, "DPT0Z15477");
				//Str_Cpy(stUserinfo.szcard_term_id2, "DPT0Z15631");
				
				//공지사항, 고객의소리 합계 카운트 표시
				Rcv_Count();
				ON_DRAW();
/*
				if( g_lUpgradeChk == 0 )
				{
				M(1111111111111111111111);
					g_lUpgradeChk = 1;
					//2017-09-15 Sanghyun Lee
					//Push 업그레이드 설치 코드
					g_Push_GetValue("isDownloadedVm");
				M(2222222222222222222222);
				}
*/
				break;
		}
		
	}

	//──────────────────────────────────────────────
	void	OnTask(long nEvent, long nData)
	{
		char* szVm_Upgrade;
		long nRet = 0;
/*
		//2017-09-15 Sanghyun Lee
		//Push 업그레이드 설치 코드 - true일 경우 업그레이드 진행
		szVm_Upgrade = (char*)System_GetResult((char*)&nRet);
PRINT("OnTask szVm_Upgrade : %s , %d",szVm_Upgrade,Str_Len(szVm_Upgrade),0);

		if( Str_Cmp(szVm_Upgrade, "true") == 0 )
		{
			//2017-09-15 Sanghyun Lee
			//Push 업그레이드 설치 코드
			MDM_VmInstall();
			//g_Push_SetValue("isDownloadedVm", "false");
		}
*/
	}

//--------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	long ret, lCnt;

		if( g_ChkDay() )
			return;
		
		switch(ID)
		{					
			case BID_GMMENU:
				g_nWorkFlag = 100;
				g_nAddrFlag = 0;
				Card_Move("GM_MENU");
				break;				
			case BID_SCMENU:
				g_nWorkFlag = 200;
				g_nAddrFlag = 0;
				Card_Move("CM_IMGPOPUP");
				//Card_Move("SC_MENU");				
				break;			
			case BID_BSMENU:
				g_nWorkFlag = 300;
				g_nAddrFlag = 0;
				Card_Move("BS_MENU");						
				break;
			case BID_BFMENU:
				Card_Move("BF_BEFOMENU");
				break;
			case BID_MWMENU:
				g_nWorkFlag = 600;
				Card_Move("CM_IMGPOPUP");
				//Card_Move("C6101_MENU");
				break;
			case BID_NPMENU:
				if( Str_Cmp(stUserinfo.szNp_auth, "1") == 0 )
				{
					Card_Move("C6202_MENU");
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "체납 담당자만 이용 할 수 있습니다.");
				}
			
				Card_Move("C6202_MENU");
				break;
			case BID_GCMENU:
				//메인메뉴에 버튼 생기면 그쪽으로 이동.
				//미송신 자료 확인
				g_Sql_RetInt( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'S'" , &lCnt );
				if( lCnt > 0 )
				{
					MessageBoxEx(CONFIRM_OK, "미송신자료가 있습니다.\n송신 후 작업하세요.");
					ON_DRAW();
					Card_Move("C6301_SND");
				}
				else
				{
					Card_Move("C6301_MENU");
				}
				break;
			case BID_NOTICE:
				//Card_Move("C6101_MENU");
				//고객의소리 기본 주소 -> 도로명
				g_nAddrFlag = 1;
				Card_Move("C6501_NOTICE");
				return;
			case BID_MANAGE:
				g_nWorkFlag = 400;
				g_nAddrFlag = 0;
				Card_Move("CM_MENU");
				break;
			case GID_HOME:
				//Card_Move("C6501_NOTICE");
				break;
			case GID_MENU:
				//Card_Move("C6202_MENU");
				break;
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
			case GID_SCREEN:
				g_MOVE_DLG(400);
				break;
			case GID_CMMNWK:
		/*
				//메인메뉴에 버튼 생기면 그쪽으로 이동.
				//미송신 자료 확인
				g_Sql_RetInt( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN == 'S'" , &lCnt );
				if( lCnt > 0 )
				{
					MessageBoxEx(CONFIRM_OK, "미송신자료가 있습니다.\n송신 후 작업하세요.");
					ON_DRAW();
					Card_Move("C6301_SND");
				}
				else
				{
					Card_Move("C6301_MENU");
				}
		*/
				break;				
			case GID_PREV:
				g_Exit();
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
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
		}
	}
	

//----------------------------------------------------------------------
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

			//메뉴버튼
			h = Get_hDlgCtrlByID(BID_GMMENU);
			ButCtrl_SetImage( h,  g_pImgGm);
	
			h = Get_hDlgCtrlByID(BID_SCMENU);
			ButCtrl_SetImage( h,  g_pImgSc);
			
			h = Get_hDlgCtrlByID(BID_BSMENU);
			ButCtrl_SetImage( h,  g_pImgBs);
		
			h = Get_hDlgCtrlByID(BID_BFMENU);
			ButCtrl_SetImage( h,  g_pImgBf);
	
			h = Get_hDlgCtrlByID(BID_MWMENU);
			ButCtrl_SetImage( h,  g_pImgMw);
			
			h = Get_hDlgCtrlByID(BID_GCMENU);
			ButCtrl_SetImage( h,  g_pImgGc);
	  
			h = Get_hDlgCtrlByID(BID_NPMENU);
			ButCtrl_SetImage( h,  g_pImgNp);
	
			h = Get_hDlgCtrlByID(BID_MANAGE);
			ButCtrl_SetImage( h,  g_pImgCmm);
			
			h = Get_hDlgCtrlByID(BID_NOTICE);
			ButCtrl_SetImage( h,  g_pImgNotice);
			
			h = Get_hDlgCtrlByID(BID_FEEVIEW);
			ButCtrl_SetImage( h,  g_pImgFeeview);
		}
	}

//------------------------------------------------------------------
	long CntDraw(long nservicenum)
	{
	char szJsonpath[500];
	char szMsg[500];
	char szCol[128];
	char szDate[50];
	long *nCol;
	long nCnt = 0;
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		//MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
			  char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				ON_DRAW();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								//공지사항
								Mem_Set((byte*) m_szNotice_Cnt, 0x00, sizeof( m_szNotice_Cnt) );
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "sum_count", szType);
								nCnt = *nCol;
								Str_ItoA( nCnt, szCol, 10);
								
								if( Str_Cmp(szCol, "0") == 0 || Str_Cmp(szCol, "") == 0 )
								{
									Str_Cpy(m_szNotice_Cnt, "0");
								}
								else
								{
									Str_Cpy(m_szNotice_Cnt, szCol);
								}
								
								EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
								EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), m_szNotice_Cnt);
							}

							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
			}
		}
		else
		{
			ret = 0;
		}
		
Finally:		
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}
	
//------------------------------------------------------------------------------------------
	long Rcv_Count(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 12116, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        	stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "gubun",        		"3" );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR12116; //통신완료 후에 호출 함수

		ret = HTTP_DownloadData(szUrl, "FR12116_IN",  "FR12116" , sndbuf, sztmp );

		return 0 ;
	}
	
	
//------------------------------------------------------------------------------------------
	long TR12116(void)	
	{
		long ntotcnt = 0;

		if( g_Chk_Json(12116) >= 0)
		{
			CntDraw(12116);

			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}


}


