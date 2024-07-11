/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_MENU
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
		DEF_BUTTON_ID ( BID_SC )		//정상점검
		DEF_BUTTON_ID ( BID_RSRVSC )	//예약점검
		DEF_BUTTON_ID ( BID_PATTERN )	//선택점검 - 고객패턴 관련 list
		DEF_BUTTON_ID ( BID_REFORM )	//개선권고
		DEF_BUTTON_ID ( BID_RESULT )	//실적관리
		DEF_BUTTON_ID ( BID_SCGO )		//점검바로가기
		DEF_BUTTON_ID ( BID_SLCTSC )	//지정점검
		DEF_BUTTON_ID ( BID_FIRSTSC )	//우선점검
		DEF_BUTTON_ID ( BID_JOJUNGGI )	//조정기
		DEF_BUTTON_ID ( BID_DATA )		//자료관리
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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
		DEF_OBJECT_ID ( LINE_DATA4 )
		DEF_OBJECT_ID ( LINE_DATA5 )
		DEF_OBJECT_ID ( LINE_DATA6 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1

	//pda버튼 크기 원본
	//#define BTNWH 490
	//#define BTNHT 250
	#define BTNWH 499
	//#define BTNHT 165
	
	char m_szchktype[3];
	char m_szobjym[7];
	char m_szchkyear[5];
	char m_szchkorder[3];
	char m_szzone_manage_num[6];
	char m_szRcvDay[9];
	long m_nCnt311301 = 0;
	long m_nCnt311302 = 0;
	long m_nCnt311308 = 0;
	
	void UPdate_Rcvlog(void);	
	long Rcv_Data(void);
	long Del_Data(void);
	long RCV311301(void);
	long TR311301(void);
	long RCV311302(void);
	long TR311302(void);
	long RCV311303(void);
	long TR311303(void);
	long RCV311304(void);
	long TR311304(void);
	long RCV311305(void);
	long TR311305(void);
	long RCV311306(void);
	long TR311306(void);
	long RCV311307(void);
	long TR311307(void);
	long RCV311308(void);
	long TR311308(void);
	long RCV311309(void);
	long TR311309(void);
	long RCV311310(void);
	long TR311310(void);
	long RCV311322(void);
	long TR311322(void);	
	
	long Read_RcvLog (void);
	void SetBtnImg(void);
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
	long safe_chkdata(void);
	long DataCnt_Chk(void); //업무 대상수 체크
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "안전점검 메뉴"),

//		DLG_BUTTON(STARTX,     STARTY+100, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SC, "정기점검"),
//		DLG_BUTTON(STARTX+500, STARTY+100, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PATTERN, "선택점검"),
//		DLG_BUTTON(STARTX,     STARTY+250, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RSRVSC, "예약점검"),
//		DLG_BUTTON(STARTX+500, STARTY+250, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FIRSTSC, "우선점검"),
//		DLG_BUTTON(STARTX,     STARTY+400, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REFORM, "개선권고"),
//		DLG_BUTTON(STARTX+500, STARTY+400, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RESULT, "실적관리"),
//		DLG_BUTTON(STARTX,     STARTY+550, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCGO, "바로가기"),
//		DLG_BUTTON(STARTX+500, STARTY+550, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCTSC, "지정점검"),

//		DLG_TEXT(0, STARTY+700, 1000, 10, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TTLCTRLFR, DEEPBLUE, TXT_DATA1, ""),

//		DLG_BUTTON(STARTX,     STARTY+720, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_JOJUNGGI, "조정기점검"),
//		DLG_BUTTON(STARTX+500, STARTY+720, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, "자료관리"),

		DLG_BUTTON(STARTX,      STARTY+65,                BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SC, ""),
		DLG_BUTTON(STARTX+495,  STARTY+65,                BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PATTERN, ""),
		DLG_BUTTON(STARTX,      STARTY+65+(1*BTNHT_SC),   BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RSRVSC, ""),
		DLG_BUTTON(STARTX+495,  STARTY+65+(1*BTNHT_SC),   BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FIRSTSC, ""),
		DLG_BUTTON(STARTX,      STARTY+65+(2*BTNHT_SC),   BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REFORM, ""),
		DLG_BUTTON(STARTX+495,  STARTY+65+(2*BTNHT_SC),   BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RESULT, ""),
		DLG_BUTTON(STARTX,      STARTY+65+(3*BTNHT_SC),   BTNWH, BTNHT_SC, 50, 10, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCGO, ""),
		DLG_BUTTON(STARTX+495,  STARTY+65+(3*BTNHT_SC),   BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCTSC, ""),

		//DLG_TEXT(0, STARTY+700, 1000, 10, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TTLCTRLFR, DEEPBLUE, TXT_DATA1, ""),

		DLG_BUTTON(STARTX,     STARTY+65+(4*BTNHT_SC)+9, BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_JOJUNGGI, ""),
		DLG_BUTTON(STARTX+495, STARTY+65+(4*BTNHT_SC)+9, BTNWH, BTNHT_SC, 50, 1, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""),

		DLG_LINE(500,               STARTY+65,           500,             STARTY+899,   LINECTRLCOLOR, 2, LINE_DATA1),
		DLG_LINE(0,    STARTY+65+(1*BTNHT_SC),    STARTX+995, STARTY+65+(1*BTNHT_SC),   LINECTRLCOLOR, 2, LINE_DATA2),
		DLG_LINE(0,    STARTY+65+(2*BTNHT_SC),    STARTY+995, STARTY+65+(2*BTNHT_SC),   LINECTRLCOLOR, 2, LINE_DATA3),
		DLG_LINE(0,    STARTY+65+(3*BTNHT_SC),    STARTX+995, STARTY+65+(3*BTNHT_SC),   LINECTRLCOLOR, 2, LINE_DATA4),
		DLG_LINE(0,  STARTY+65+(4*BTNHT_SC)+2,    STARTY+995, STARTY+65+(4*BTNHT_SC)+2, LINECTRLCOLOR, 6, LINE_DATA5)
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "안전점검 메뉴"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+15,          70, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SC, "정기점검"),
		DLG_BUTTON(STARTX+505,         70, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PATTERN, "선택점검"),
		DLG_BUTTON(STARTX+15,  STARTY+135, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RSRVSC, "예약점검"),
		DLG_BUTTON(STARTX+505, STARTY+135, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FIRSTSC, "우선점검"),
		DLG_BUTTON(STARTX+15,  STARTY+300, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "개선권고"),
		DLG_BUTTON(STARTX+505, STARTY+300, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RESULT, "실적관리"),
		DLG_BUTTON(STARTX+15,  STARTY+465, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCGO, "바로가기"),
		DLG_BUTTON(STARTX+505, STARTY+465, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SLCTSC, "지정점검"),

		DLG_TEXT(0,            STARTY+650, 1000, 10, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TTLCTRLFR, DEEPBLUE, TXT_DATA1, ""),

		DLG_BUTTON(STARTX+15,  STARTY+700, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_JOJUNGGI, "조정기점검"),
		DLG_BUTTON(STARTX+505, STARTY+700, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATA, "자료관리"),
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
				
				g_FlagClear();				
				SetBtnImg();
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
			
			//업무메뉴 버튼
/*
			h = Get_hDlgCtrlByID(BID_SC);
			ButCtrl_SetImage( h,  g_pImgMnTop);
	
			h = Get_hDlgCtrlByID(BID_RSRVSC);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_PATTERN);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_FIRSTSC);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_SLCTSC);
			ButCtrl_SetImage( h,  g_pImgMnTop);
	
			h = Get_hDlgCtrlByID(BID_REFORM);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_RESULT);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_SCGO);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_JOJUNGGI);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgMnTop);
*/
			h = Get_hDlgCtrlByID(BID_SC);
			ButCtrl_SetImage( h,  g_pImgSc_Normal);
	
			h = Get_hDlgCtrlByID(BID_RSRVSC);
			ButCtrl_SetImage( h,  g_pImgSc_Reserve);
			
			h = Get_hDlgCtrlByID(BID_PATTERN);
			ButCtrl_SetImage( h,  g_pImgSc_Ptrn);
			
			h = Get_hDlgCtrlByID(BID_FIRSTSC);
			ButCtrl_SetImage( h,  g_pImgSc_First);
			
			h = Get_hDlgCtrlByID(BID_SLCTSC);
			ButCtrl_SetImage( h,  g_pImgSc_Sel);
	
			h = Get_hDlgCtrlByID(BID_REFORM);
			ButCtrl_SetImage( h,  g_pImgSc_Rfrm);
			
			h = Get_hDlgCtrlByID(BID_RESULT);
			ButCtrl_SetImage( h,  g_pImgSc_Result);
			
			h = Get_hDlgCtrlByID(BID_SCGO);
			ButCtrl_SetImage( h,  g_pImgSc_Go);
			
			h = Get_hDlgCtrlByID(BID_JOJUNGGI);
			ButCtrl_SetImage( h,  g_pImgSc_Jojung);
			
			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgSc_Data);

		}
	}

//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[300];
		long lCnt;
		
		if( g_ChkDay() )
			return;
		
		switch(ID)
		{					
			case BID_SC:
				if( safe_chkdata() >= 0)
					return;
				
				lCnt = DataCnt_Chk();
				if( lCnt > 0 )
				{
					g_nWorkFlag = 200;
					g_nAddrFlag = 0;
					Card_Move("SC_LST");
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				}
				break;
			case BID_PATTERN:
				if( safe_chkdata() >= 0)
					return;

				lCnt = DataCnt_Chk();
				if( lCnt > 0 )
				{
					g_nWorkFlag = 209;
					g_nAddrFlag = 0;
					Card_Move("SC_PTRNLST");
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				}
				break;
			case BID_RSRVSC:
				if( safe_chkdata() >= 0)
					return;

				lCnt = DataCnt_Chk();
				if( lCnt > 0 )
				{
					g_nWorkFlag = 204;
					g_nAddrFlag = 0;
					Card_Move("SC_RSRVLST");
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				}
				break;
			case BID_FIRSTSC:
				if( safe_chkdata() >= 0)
					return;

				lCnt = DataCnt_Chk();
				if( lCnt > 0 )
				{
					g_nWorkFlag = 208;
					g_nAddrFlag = 0;
					Card_Move("SC_FRSTLST");
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				}
				break;
			case BID_REFORM:
				if( safe_chkdata() >= 0)
					return;

				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt > 0 )
				{
					g_nWorkFlag = 202;
					g_nAddrFlag = 0;
					Card_Move("SC_RFRMLST");
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				}
				break;
			case BID_RESULT:
				if( safe_chkdata() >= 0)
					return;

				g_nWorkFlag = 201;
				Card_Move("SC_RSLTHSTR");
				break;
			case BID_SCGO:
				if( safe_chkdata() >= 0)
					return;

				
				lCnt = DataCnt_Chk();
				if( lCnt > 0 )
				{
					//파일에 데이터 셋
					g_nWorkFlag = 200;
					Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
					g_lMoveFlag = 1;
					g_nAddrFlag = 0;
					
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Str_Cpy(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ");
					g_Sql_SaveSeq( szSql, SREACH_FILE);
					Get_Index();

					Card_Move("SC_CONFIRM");
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				}
				break;
			case BID_SLCTSC:
				if( safe_chkdata() >= 0)
					return;

				g_nWorkFlag = 205;
				Card_Move("SC_SLCTSC");
				break;
				
				
			case BID_JOJUNGGI:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM REGTR_DATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt > 0 )
				{
					g_nWorkFlag = 203;
					g_nAddrFlag = 0;
					Card_Move("SC_JOJUNGLST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "대상을 수신하세요.");
				break;
			case BID_DATA:
				Card_Move("SC_DMMENU");			
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

//=======================================================================================
//업무 대상 수신 체크
	long DataCnt_Chk(void)
	{
		long nRet;
		char szSql[100];
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA",0, 0, 0   );
		g_Sql_RetInt( szSql, &nRet );
		
		return nRet;
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
		char sztmp[101];
		char szbuf[10];
		long lret;
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		Str_Cpy(sztmp, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '2'  ");	
			
		g_Sql_RetStr(sztmp, 4, szbuf);
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
	
//------------------------------------------------------------------------------------------
	long safe_chkdata(void)
	{
		char sztmp[101];
		char szSql[800];
		char szbuf[10];
		
		Read_RcvLog();
		
		if( Str_Len(m_szRcvDay) != 8 )
		{
			return -1;
		}
		
		if( Str_AtoI(m_szRcvDay) != Time_GetDate() )
		{
			//점검송신카운트 재수신 메세지 처리...>
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT SUM(C.CNT) AS CNT FROM \
(SELECT COUNT(SEND_YN) AS CNT  FROM NORMAL_INFO  WHERE SEND_YN = 'S' \
UNION ALL SELECT COUNT(SEND_YN) AS CNT  FROM NORMAL_NOGOOD  WHERE SEND_YN = 'S' \
UNION ALL SELECT COUNT(SEND_YN) AS CNT  FROM NORMAL_NOGOOD_CHA  WHERE SEND_YN = 'S' \
UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_NOGOOD_DETAL  WHERE SEND_YN = 'S' \
UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_VISIT  WHERE SEND_YN = 'S' \
UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_BUR  WHERE SEND_YN = 'S' \
UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_MTR  WHERE SEND_YN = 'S' and  length(UPD_EMPID) > 0 \
UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_DATA  WHERE SEND_YN = 'S') C "
            ,0,0,0   );

			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				MessageBoxEx(CONFIRM_OK, "점검자료가 금일자료가 아닙니다. 미전송 데이터 전송후 자료를 수신하세요!");
				Card_Move("SC_SND");
				return 0;
			}
			else
			{
				MessageBoxEx(CONFIRM_OK, "점검자료가 금일자료가 아닙니다. 점검자료 수신을 시작 합니다.");
				Del_Data();
				RCV311301();
				ON_DRAW();
				return 1;
			}
		}
		
		return -1;
	}
	
	
	long RCV311301(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;	
		
		m_nCnt311308 = 0;
		m_nCnt311308 = 0;
		m_nCnt311308 = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311301, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311301; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311301_IN",  "FR311301" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311301(void)
	{
		m_nCnt311301 = g_Chk_Json(311301);
		if( m_nCnt311301 >= 0)
		{
			RCV311302();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311302(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311302, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311302; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311302_IN",  "FR311302" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311302(void)
	{
		m_nCnt311302 = g_Chk_Json(311302);
		if(m_nCnt311302 >= 0)
		{
			RCV311303();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	
	long RCV311303(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311303, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311303; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311303_IN",  "FR311303" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311303(void)
	{
		if(g_Chk_Json(311303) >= 0)
		{
			RCV311304();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311304(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311304, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311304; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311304_IN",  "FR311304" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311304(void)
	{
		if(g_Chk_Json(311304) >= 0)
		{
			RCV311305();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	
	long RCV311305(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311305, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311305; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311305_IN",  "FR311305" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311305(void)
	{
	char szSql[256];
	
		if(g_Chk_Json(311305) >= 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE NORMAL_ADDR  SET BEFO_ADDR1_M = ADDR1_M, BEFO_ADDR1_S= ADDR1_S, BEFO_NEW_ADDR_M =NEW_ADDR_M, BEFO_NEW_ADDR_S =NEW_ADDR_S  ", 0, 0, 0);
			g_Sql_DirectExecute( szSql );
		
			RCV311306();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}

	long RCV311306(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311306, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",   m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311306; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311306_IN",  "FR311306" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311306(void)
	{
		if(g_Chk_Json(311306) >= 0)
		{
			RCV311307();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311307(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311307, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311307; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311307_IN",  "FR311307" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311307(void)
	{
		if(g_Chk_Json(311307) >= 0)
		{

			RCV311308();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311308(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311308, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",         m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311308; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311308_IN",  "FR311308" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311308(void)
	{
		m_nCnt311308 = g_Chk_Json(311308);
		if(m_nCnt311308 >= 0)
		{
			RCV311309();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311309(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311309, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",         m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311309; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311309_IN",  "FR311309" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311309(void)
	{
		if(g_Chk_Json(311309) >= 0)
		{
			RCV311322();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311322(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311322, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",         m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311322; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311322_IN",  "FR311322" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311322(void)
	{
		if(g_Chk_Json(311322) >= 0)
		{
			RCV311310();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311310(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311310, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",         m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311310; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311310_IN",  "FR311310" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311310(void)
	{
	long totcnt;
	
		g_Sock_Close();
		if(g_Chk_Json(311310) >= 0)
		{
			UPdate_Rcvlog();

			if( m_nCnt311301 == 0 && m_nCnt311302 == 0 && m_nCnt311308 == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "일반점검대상 자료가 없습니다!");
				Del_Data();
				ON_DRAW();
				return 1;
			}

			if(m_nCnt311301 > 0)
			{
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다. 일일자료를 수신받으세요.");
				Card_Move("SC_DAYRCV");
			}
			else
			{			
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다.");
				ON_DRAW();
			}
			return 1;
		}
		else
		{
			Del_Data();
			return -1;
		}
	}
	
	void UPdate_Rcvlog(void)
	{
	long i=0, tot = 0, ret=0;
	char szSql[400];
	char sztoday[9];
	long idx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) sztoday, 0x00, sizeof( sztoday) );
		Str_ItoA( Time_GetDate(), sztoday, 10);
		
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '2' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,PARAM6,PARAM7, PARAM8) VALUES ('2',?,?,?,? ,?,?,? ,0 ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM2=?,PARAM3=?,PARAM4=?,PARAM5=?,PARAM6=?,PARAM7=?,PARAM8=0 WHERE GUBUN = '2' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)m_szchkyear, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)m_szchkorder, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)m_szobjym, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)m_szchktype, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcenter_cd, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)m_szzone_manage_num, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)sztoday, 8, DECRYPT);
			
		sql->Begin(sql);
		
		//ret = sql->Execute(sql);
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;		
	}
	
	long Read_RcvLog (void)
	{
	long i;
	long ret= 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();


		Mem_Set( (byte*) m_szchktype, 0x00, sizeof( m_szchktype) );
		Mem_Set( (byte*) m_szobjym, 0x00, sizeof( m_szobjym) );
		Mem_Set( (byte*) m_szchkyear, 0x00, sizeof( m_szchkyear) );
		Mem_Set( (byte*) m_szchkorder, 0x00, sizeof( m_szchkorder) );
		Mem_Set( (byte*) m_szzone_manage_num, 0x00, sizeof( m_szzone_manage_num) );
		Mem_Set( (byte*) m_szRcvDay, 0x00, sizeof( m_szRcvDay) );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql,"SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM6, PARAM7 FROM RCV_LOG WHERE GUBUN = '2' "
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) m_szchkyear			, 4 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szchkorder			, 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szobjym				, 6 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szchktype			, 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szzone_manage_num	, 5 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szRcvDay	        , 8 + 1, DECRYPT );
			
			ret++;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	
	long Del_Data(void)
	{
		g_Sql_DirectExecute("DELETE FROM NORMAL_ADDR");
		g_Sql_DirectExecute("DELETE FROM NORMAL_BUR");
		g_Sql_DirectExecute("DELETE FROM NORMAL_DATA");
		g_Sql_DirectExecute("DELETE FROM NORMAL_GROUP");
		g_Sql_DirectExecute("DELETE FROM NORMAL_INFO");
		g_Sql_DirectExecute("DELETE FROM NORMAL_MTR");
		g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD");
		g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD_CHA");
		g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD_DETAL");
		g_Sql_DirectExecute("DELETE FROM NORMAL_PIPE_CHK_DATA");
		g_Sql_DirectExecute("DELETE FROM NORMAL_PREV_NO");
		g_Sql_DirectExecute("DELETE FROM NORMAL_VISIT");
		g_Sql_DirectExecute("DELETE FROM CUST_PATT_COLL_INFO");		
		g_Sql_DirectExecute("DELETE FROM NORMAL_STANDPIPE_CHK_RSLT");	

		g_DirFS_Clear(PHOTO_SC, "*");
		g_DirFS_Clear(PHOTO_SCMTR, "*");
		g_DirFS_Clear(PHOTO_SCBUR, "*");
		g_DirFS_Clear(PHOTO_SCBOIL, "*");
		g_DirFS_Clear(PHOTO_SCBAR, "*");

		return 1;
	}
	
}


