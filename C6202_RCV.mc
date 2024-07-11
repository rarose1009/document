/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_RCV
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
		DEF_BUTTON_ID ( BID_RCV )		//자료수신
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
		DEF_OBJECT_ID ( TXT_BORDER )
		DEF_OBJECT_ID ( TXT_DATA1 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 )
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
	
	char m_szNonpayManageZone[7];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void UPdate_Rcvlog(void);
	long Rcv_Addr(void);
	long TR83104(void);
	long Rcv_Data(void);
	long TR83102(void);
	long RCV83108(void);
	long TR83108(void);
	void DataDel(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "자료관리"),

		DLG_BUTTON(STARTX+600,    STARTY+200, 400, 80, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "자료수신"),

		DLG_TEXT(STARTX, 	   STARTY+65, 385, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "관리구역"),
		DLG_COMBO (STARTX+385, STARTY+65, 615, 200, 150, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "자료관리"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+600,    STARTY+200, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "자료수신"),

		DLG_TEXT(STARTX, 	   STARTY-40, 400, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "관리구역"),
		DLG_COMBO (STARTX+400, STARTY-40, 600, 200, 150, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
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
		long lCnt;
		
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
				SetStyle();
				Rcv_Addr();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[150];
		long lCnt;
		
		if( g_ChkDay() )
		{
			return;
		}
			
		switch(ID)
		{				
			case BID_RCV:
				Rcv_Data();
				break;	
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "체납 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6202_MENU");
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
				Card_Move("C6202_MENU");
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
		}
	}
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(CMB_DATA1), TRUE, 2, EDITSEP_NONE );
	}

//------------------------------------------------------------------	
	long Rcv_Addr(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 83104, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR83104; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR83104_IN",  "FR83104" , sndbuf, sztmp );
		return 0 ;
	}
	
//---------------------------------------------------------------------------------------------
	long TR83104(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(83104) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM RCV_ADDR", &ntotcnt);
			
			if(ntotcnt > 0 )
			{
				//AREA AS MANAGE_ZONE, TOWN AS AREA_DESC, COMPX_FLAG_NM AS TAKER_NM
				g_Sql_SetCombo("SELECT TOWN FROM RCV_ADDR", CMB_DATA1+2);
				MessageBoxEx (CONFIRM_OK, "관리 구역 조회를 완료 했습니다.");
				ON_DRAW();
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "관리 구역이 없습니다.\n확인해 주세요.");
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
		char szSql[250];
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
		long chk = 0, totcnt;
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "관리 구역을 선택해주세요.");
			return 0;
		}
		
		DataDel();

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		

		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 83102, FALSE);

		Mem_Set((byte*)m_szNonpayManageZone, 0x00, sizeof(m_szNonpayManageZone));
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT AREA FROM RCV_ADDR WHERE TOWN = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)), 0, 0 );
		g_Sql_RetStr(szSql, 6, m_szNonpayManageZone);

		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",     m_szNonpayManageZone );
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR83102; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR83102_IN",  "FR83102" , sndbuf, sztmp );

		return 0 ;
	}
	
//---------------------------------------------------------------------------------------------
	long TR83102(void)
	{
		if( g_Chk_Json(83102) >= 0)
		{
			RCV83108();
			return 1;
		}
		else
		{
			DataDel();
			g_Sock_Close();
			return -1;
		}
	}

//---------------------------------------------------------------------------------------------
	long RCV83108(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 83108, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",     m_szNonpayManageZone );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR83108; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR83108_IN",  "FR83108" , sndbuf, sztmp );
		return 0 ;
	}
	
//---------------------------------------------------------------------------------------------
	long TR83108(void)
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(83108) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM C6202_NOPAY_OBJ_LIST", &ntotcnt);
			
			if(ntotcnt > 0 )
			{
				UPdate_Rcvlog();
				MessageBoxEx (CONFIRM_OK, "자료수신을 완료하였습니다.");
				Card_Move("C6202_MENU");
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
			DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	

//---------------------------------------------------------------------------------------------
	void DataDel(void)
	{
		//기존 데이터 삭제
		g_Sql_DirectExecute("DELETE FROM C6202_NOPAY_OBJ_LIST");
		g_Sql_DirectExecute("DELETE FROM C6202_NOPAY_OBJ");
		g_Sql_DirectExecute("DELETE FROM C6202_STOP_OBJ");
		g_Sql_DirectExecute("DELETE FROM C6202_AUCTION");
		g_Sql_DirectExecute("DELETE FROM C6202_RELEASE");
		g_Sql_DirectExecute("DELETE FROM C6202_PAYCONFIRM");
	}

//---------------------------------------------------------------------------------------------
	void UPdate_Rcvlog(void)
	{
		long i=0, tot = 0, ret=0;
		long idx;
		char szSql[400];
		char szPARAM2[20];
		char szPARAM7[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*) szPARAM2, 0x00, sizeof( szPARAM2) );
		Mem_Set( (byte*) szPARAM7, 0x00, sizeof( szPARAM7) );

		//ManageZone
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT AREA FROM RCV_ADDR WHERE TOWN = '%s' ", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)), 0, 0 );
		g_Sql_RetStr(szSql, 10, szPARAM2);

		Str_ItoA(Time_GetDate(), szPARAM7, 10);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '9' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ," INSERT INTO RCV_LOG ( GUBUN, PARAM1, PARAM2, PARAM7, PARAM8, PARAM12, PARAM13 ) VALUES( '9', ?, ?, ?, 0, 0, 0 ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ," UPDATE RCV_LOG SET PARAM1 = ?, PARAM2 = ?, PARAM7 = ?, PARAM8 = 0, PARAM12 = 0, PARAM13 = 0 WHERE GUBUN = '9' ");
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szcenter_cd, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM2,  20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM7,  10, DECRYPT);
		
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
}



