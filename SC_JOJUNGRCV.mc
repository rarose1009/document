/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_JOJUNGRCV
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_RECV )			//자료수신
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
		DEF_OBJECT_ID ( TXT_GOOBOON )		//구분
		DEF_OBJECT_ID ( TXT_CUSTOMCNTR )	//고객센터
		DEF_OBJECT_ID ( TXT_AREA )			//구역구분
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
				
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
				
		DEF_OBJECT_ID ( CMB_GOOBOON ) 	//구분 콤보박스
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	long m_nCnt311317 = 0;
	long m_lActiveIndex = -1;
	
	char m_szSafechktype[3];
	char m_szZone_manage_num[6];
	void SetStyle(void);
	void SetBtnImg(void);
	void Set_zone_manage_num(char *temp, long num );
	void UPdate_Rcvlog(void);
	long Rcv_Data(void);
	long TR311317(void);
	long RCV311318(void);
	long TR311318(void);	
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "조정기 자료수신(고객센터)"),
		
		DLG_TEXT(STARTX,        STARTY+65, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "구분"),
		DLG_COMBO (STARTX+400,  STARTY+65, 600, 290, 120, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOOBOON, 10),	//구분 콤보박스
		DLG_TEXT(STARTX,       STARTY+145, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "고객센터"),
		DLG_TEXT(STARTX+400,   STARTY+145, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,       STARTY+225, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_AREA, "구역구분"),
		DLG_EDIT(STARTX+400,   STARTY+225, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA2, 5,""),
		DLG_BUTTON(STARTX+500, STARTY+400, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "조정기 자료수신(고객센터)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX,        STARTY-40, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "구분"),
		DLG_COMBO (STARTX+400,  STARTY-40, 600, 290, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOOBOON, 10),	//구분 콤보박스
		DLG_TEXT(STARTX,        STARTY+60, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "고객센터"),
		DLG_TEXT(STARTX+400,    STARTY+60, 600, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,       STARTY+160, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_AREA, "구역구분"),
		DLG_EDIT(STARTX+400,   STARTY+160, 600, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA2, 5,""),

		DLG_BUTTON(STARTX+600, STARTY+300, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),

		
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
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), stUserinfo.szcenter_nm);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOOBOON), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUSTOMCNTR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AREA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOOBOON), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GOOBOON+2), "조정기점검", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GOOBOON+2), "확인점검", 0, ICON_NONE);
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GOOBOON), "조정기점검");
}

//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		m_lActiveIndex = lActiveIndex;

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{	
				if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+290) )
				{
					if( Get_iDlgCtrlByID(TXT_DATA2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
			}
		}
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_RECV:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
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
				
				if( MessageBoxEx (CONFIRM_YESNO, "안전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("SC_MENU");
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
				
				Card_Move("SC_DMMENU");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				g_Exit();
				break;
		}
	}
	
	
	/*=======================================================================================
	함수명 : Set_zone_manage_num
	기  능 : 구역 데이터 변환한다.
	Param  : temp: 대상 문자열 포인터
			 time: 원본 long형
	Return : TRUE : 성공
			 FALSE : 실패
	========================================================================================*/
	void Set_zone_manage_num(char *temp, long num )
	{
	char buffer[10];
	char buffer1[10];
	long i;
	
		Str_ItoA(num, buffer1, 10);
		Mem_Set((byte*)buffer,'0', sizeof(buffer));
		
		i = Str_Len(buffer1);
		Mem_Cpy((byte*)temp, (byte*)buffer, 5-i);
		Mem_Cpy((byte*)temp+5-i, (byte*)buffer1, i);
		temp[5] = 0;
		
	}
	
	long Rcv_Data(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
	long chk = 0, totcnt;
		
		g_Sql_RetInt(" select count(*) from REGTR_DATA WHERE CHK_END_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from REGTR_MRT WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from REGTR_NOGOOD WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}

		if( chk > 0   )
		{
			MessageBoxEx (CONFIRM_OK, "미송신 자료가 있습니다, 송신 후 수신받으세요.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_DATA2) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "관리구역을 입력하세요.");
			return -1;
		}
		
		if(  MessageBoxEx (CONFIRM_YESNO, "점검자료를 수신받으시겠습니까?")  != MB_OK )
		{
			return -1;
		}
		
		g_Sql_DirectExecute("DELETE FROM REGTR_DATA");
		g_Sql_DirectExecute("DELETE FROM REGTR_MRT");
		g_Sql_DirectExecute("DELETE FROM REGTR_NOGOOD");
		g_Sql_DirectExecute("DELETE FROM REGTR_GROUP");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if( Str_Cmp ("조정기점검", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GOOBOON)) ) == 0)
		{
			Str_Cpy( m_szSafechktype, "23");
		}
		else
		{
			Str_Cpy( m_szSafechktype, "18");
		}
		Set_zone_manage_num(m_szZone_manage_num, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA2)) )  );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311317, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "safe_chk_type",    m_szSafechktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",   m_szZone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311317; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311317_IN",  "FR311317" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311317(void)
	{
		m_nCnt311317 = g_Chk_Json(311317);
		if( m_nCnt311317 >= 0)
		{
			RCV311318();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV311318(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311318, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "safe_chk_type",    m_szSafechktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",   m_szZone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311318; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311318_IN",  "FR311318" , sndbuf, sztmp );
		return 0 ;
	}
	
	long TR311318(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(311318) >= 0)
		{
			UPdate_Rcvlog();
			if(m_nCnt311317 > 0)
				MessageBoxEx (CONFIRM_OK, "PDA 자료 저장 성공");
			else
			{
				MessageBoxEx (CONFIRM_OK, "자료가 없습니다. 입력사항을 확인해 주세요.");
				ON_DRAW();
				return 1;
			}	
			ON_DRAW();
			OnButton(GID_PREV);
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	
	
	void UPdate_Rcvlog(void)
	{
	long i=0, tot = 0, ret=0;
	char szSql[400];
	long idx;
	handle hdb = NULL;
	handle hstmt = NULL;
		
	SQLITE sql = NewSqLite();
		
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '3' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM3, PARAM8) VALUES ('3',?,?,? ,0 ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM2=?,PARAM3=?,PARAM8=0 WHERE GUBUN = '3' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)m_szSafechktype, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcenter_cd, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)m_szZone_manage_num, 20, DECRYPT);
			
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
}


