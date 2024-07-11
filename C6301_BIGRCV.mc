/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_BIGRCV
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
		DEF_BUTTON_ID ( BID_OLD )		//노후교체
		DEF_BUTTON_ID ( BID_MINWON )	//민원교체
		DEF_BUTTON_ID ( BID_RCV )		//수신
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
		
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
				
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
				
		DEF_OBJECT_ID ( CMB_DATA1 ) 				//구
	END_OBJECT_ID()
	
	#define INIT_MAIN	1

	long m_nSelectData = 0;		//m_nSelectData = 0 노후교체 , m_nSelectData = 1 민원교체
	char m_szArea[100];
	
	void SetStyle(void);
	void SetBtnImg(void);
	long Sql_SetCombo(char* szSql, long CTRLID );
	void UPdate_Rcvlog(void);
	long Rcv_AddrData(void);
	long Rcv_Data(void);
	long TR75105(void);
	long TR75109(void);

	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "대용량 계량기교체 대상수신"),

		DLG_BUTTON(STARTX+300, STARTY+140, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OLD, "노후교체"),
		DLG_BUTTON(STARTX+300, STARTY+210, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MINWON, "민원교체"),
		DLG_BUTTON(STARTX+600, STARTY+410, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "수 신"),
		
		DLG_TEXT(STARTX,      STARTY+65, 300, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "구"),
		DLG_TEXT(STARTX,     STARTY+140, 300, 140, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "대상"),
		DLG_TEXT(STARTX,     STARTY+280, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "건수"),
		DLG_TEXT(STARTX+300, STARTY+280, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_COMBO (STARTX+300, STARTY+65, 700, 290, 150, 75, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "대용량 계량기교체 대상수신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+300,  STARTY+40, 700, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OLD, "노후교체"),
		DLG_BUTTON(STARTX+300, STARTY+120, 700, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MINWON, "민원교체"),
		DLG_BUTTON(STARTX+600, STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "수 신"),
		
		DLG_TEXT(STARTX,      STARTY-40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "구"),
		DLG_TEXT(STARTX,      STARTY+40, 300, 160, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "대상"),
		DLG_TEXT(STARTX,     STARTY+200, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "건수"),
		DLG_TEXT(STARTX+300, STARTY+200, 700, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_COMBO (STARTX+300, STARTY-40, 700, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
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
				Rcv_AddrData();
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		if( m_nSelectData == 0 )
		{
			m_nSelectData = 0;
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), TRUE );
		}
		else
		{
			m_nSelectData = 1;
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), FALSE );
		}
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long lCnt = 0;
		
		g_Sql_RetInt("SELECT COUNT(*) FROM RCV_ADDR", &lCnt);
	
		switch(ID)
		{					
			case BID_OLD:
				m_nSelectData = 0;
				
				if( m_nSelectData == 0 )
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), TRUE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
				}
				else
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), FALSE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
					
					if( lCnt > 0 )
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "전체");
					}
				}
				break;
			case BID_MINWON:
				m_nSelectData = 1;
			
				if( m_nSelectData == 0 )
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), TRUE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
				}
				else
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), FALSE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "전체");
				}
				break;
			case BID_RCV:
				Rcv_Data();
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "계량기교체 메뉴로\n나가시겠습니까?")  == MB_OK)
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
				ShowSip(FALSE);
				g_Sipflag = 0;
				Card_Move("C6301_DMMENU");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;
				g_Exit();
				break;
		}
	}


//---------------------------------------------------------------------------------------------
	long Rcv_AddrData(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_ADDR");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75107, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR75109; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR75109_IN",  "FR75109" , sndbuf, sztmp );
		return 0 ;
	}

//---------------------------------------------------------------------------------------------
	long TR75109(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(75109) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM RCV_ADDR", &ntotcnt);
			
			if(ntotcnt > 0 )
			{
				Sql_SetCombo("SELECT AREA FROM RCV_ADDR GROUP BY AREA", CMB_DATA1+2);

				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "전체");
				MessageBoxEx (CONFIRM_OK, "구, 동, 단지 자료수신 완료.");
				ON_DRAW();
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "오늘 생성된 자료가 없습니다.");
				ON_DRAW();
				return 1;	
			}
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
//---------------------------------------------------------------------------------------------
	long Rcv_Data(void)
	{
		char sztmp[32];
		char szUtmp[100];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_RetInt("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'S' ", &ntotcnt);
		
		if( ntotcnt > 0   )
		{
			MessageBoxEx (CONFIRM_OK, "미송신 자료가 있습니다, 송신 후 수신받으세요.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_DATA1) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "구를 선택하세요.");
			return -1;
		}

		if(  MessageBoxEx (CONFIRM_YESNO, "계량기교체 자료를\n수신받으시겠습니까?")  == MB_OK )
		{
			//m_nSelectData = 0 노후교체 , m_nSelectData = 1 민원교체
			if( m_nSelectData == 0 )
			{
				g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10'");
			}
			else
			{
				g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20'");
			}

			//보정기
			g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE PDA_REPL_JOB_ITEM = '20'");
			//가정용
			g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE PDA_REPL_JOB_ITEM != '20' AND CAST(MTR_GRD AS INTEGER) < 10");
		}
		else
		{
			return -1;
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75102, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		
		Mem_Set((byte*)m_szArea, 0x00, sizeof(m_szArea));
		Mem_Set((byte*)szUtmp, 0x00, sizeof(szUtmp));
		Str_Cpy( m_szArea, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)) );
		if( Str_Cmp(m_szArea, "전체") == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "area",    "%");
		}
		else
		{
			SQL_ConvUcStr( szUtmp, m_szArea );
			JSON_SetValue( g_pjcomm, 'C', "area",    szUtmp);
		}
		
		if( m_nSelectData == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "repl_occu_flag",    "10");
		}
		else
		{	
			JSON_SetValue( g_pjcomm, 'C', "repl_occu_flag",    "20");
		}
				
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR75105; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR75105_IN",  "FR75105" , sndbuf, sztmp );
		return 0 ;
	}
	
//---------------------------------------------------------------------------------------------
	long TR75105(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		char szTmp[10];
		
		g_Sock_Close();
		
		if(g_Chk_Json(75105) >= 0)
		{
			UPdate_Rcvlog();
		
			//g_Sql_RetInt("SELECT COUNT(*) FROM C6301_CHANGEDATA", &ntotcnt);
			if( m_nSelectData == 0 )
			{
				g_Sql_RetInt("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10'", &ntotcnt);
			}
			else
			{
				g_Sql_RetInt("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20'", &ntotcnt);
			}

			if(ntotcnt > 0 )
			{
				g_Sql_DirectExecute("UPDATE C6301_CHANGEDATA SET SEND_YN = 'N'");
				Mem_Set((byte*)szMsg ,0x00, sizeof(szMsg) );
				SPRINT(szMsg, " %d건 수신 받았습니다. ", ntotcnt, 0, 0);
				MessageBoxEx (CONFIRM_OK, szMsg);
				
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Str_ItoA(ntotcnt, szTmp, 10);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), szTmp);
				
				Card_Move("C6301_DMMENU");
				
				ON_DRAW();
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "자료가 없습니다.\n확인해 주세요.");
				ON_DRAW();
				return 1;	
			}
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}


//---------------------------------------------------------------------------------------------
	void UPdate_Rcvlog(void)
	{
		long i=0, tot = 0, ret=0;
		long idx;
		char szSql[400];
		char sztoday[9];
		char szPARAM1[20];
		char szPARAM2[20];
		char szPARAM3[20];
		char szPARAM4[5];
		char szPARAM7[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*) sztoday, 0x00, sizeof( sztoday) );
		Str_ItoA( Time_GetDate(), sztoday, 10);	

		Mem_Set( (byte*) szPARAM1, 0x00, sizeof( szPARAM1) );
		Mem_Set( (byte*) szPARAM2, 0x00, sizeof( szPARAM2) );
		Mem_Set( (byte*) szPARAM3, 0x00, sizeof( szPARAM3) );
		Mem_Set( (byte*) szPARAM4, 0x00, sizeof( szPARAM4) );
		Mem_Set( (byte*) szPARAM7, 0x00, sizeof( szPARAM7) );
		Str_Cpy( szPARAM1, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)) );      //구

		if( m_nSelectData == 0 )
		{
			Str_Cpy(szPARAM4, "10");
		}
		else
		{	
			Str_Cpy(szPARAM4, "20");
		}
		
		Str_ItoA(Time_GetDate(), szPARAM7, 10);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '8' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,PARAM7, PARAM8, PARAM9, PARAM10) VALUES ('8', ?, ?, ?, ?, ?, ?, 0, 0, 0) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1=?, PARAM2=?, PARAM3=?, PARAM4=?, PARAM5=?, PARAM7=?, PARAM8=0, PARAM9=0, PARAM10=0 WHERE GUBUN = '8' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)szPARAM1, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM2, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM3, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM4,  5, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szcenter_cd, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM7, 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)sztoday,   8, DECRYPT);
		
		sql->Begin(sql);

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

//---------------------------------------------------------------------------------------------
	long Sql_SetCombo(char* szSql, long CTRLID )
	{
	long ret = -1;
	char szBuf[101];
	long cnt  = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		sql->Begin(sql);
		
		ret = sql->Execute(sql);
		
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CTRLID), "전체", 0, ICON_NONE);
		cnt = 0;
		while(sql->Next(sql) == TRUE)
		{
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)szBuf, sizeof(szBuf), DECRYPT );
			ListCtrl_AddItem (Get_hDlgCtrlByID(CTRLID), szBuf, 0, ICON_NONE);
			cnt++;
			if(cnt == 100)
				break;
		}
		
Finally:
		if(sql != NULL)
			sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

}
