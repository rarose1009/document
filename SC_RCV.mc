/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_RCV
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
		DEF_BUTTON_ID ( BID_NFITRCV )		//부적합수신
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
		DEF_OBJECT_ID ( TXT_SCDT )			//점검년월
		DEF_OBJECT_ID ( TXT_GOOBOON )		//구분
		DEF_OBJECT_ID ( TXT_CUSTOMCNTR )	//고객센터
		DEF_OBJECT_ID ( TXT_AREA )			//구역구분
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
				
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
				
		DEF_OBJECT_ID ( CMB_SCDT ) 					//점검년월 콤보박스
		DEF_OBJECT_ID ( CMB_GOOBOON = CMB_SCDT+3 ) 	//구분 콤보박스
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	char m_szchktype[3];
	char m_szobjym[7];
	char m_szchkyear[5];
	char m_szchkorder[3];
	char m_szzone_manage_num[6];
	char m_szSafechktype[3];
	long m_lActiveIndex = -1;
	long m_nCnt311301 = 0;
	long m_nCnt311302 = 0;
	long m_nCnt311308 = 0;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void Set_zone_manage_num(char *temp, long num );
	void UPdate_Rcvlog(void);
	void UPdate_Rcvlog2(void);
	long Rcv_Data(void);
	long Del_Data(void);
	
	long TR311317(void);
	long RCV311318(void);
	long TR311318(void);
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
	long RCV311325(void);
	long TR311325(void);
	long RCV311327(void);
	long TR311327(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "안전점검 자료수신"),

		//DLG_BUTTON(STARTX, STARTY+600, 400, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NFITRCV, "부적합수신"),
		DLG_BUTTON(STARTX+500, STARTY+450, 500, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		
		DLG_TEXT(STARTX,      STARTY+65, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCDT, "점검년월"),
		DLG_TEXT(STARTX,     STARTY+145, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "구분"),
		DLG_TEXT(STARTX,     STARTY+225, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "고객센터"),
		DLG_TEXT(STARTX+400, STARTY+225, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+305, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_AREA, "구역구분"),
		DLG_EDIT(STARTX+400, STARTY+305, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA2, 5,""),
		
		DLG_COMBO (STARTX+400,  STARTY+65, 600, 290, 120, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SCDT, 10),	//점검년월 콤보박스
		DLG_COMBO (STARTX+400, STARTY+145, 600, 290, 120, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOOBOON, 10),	//구분 콤보박스
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "안전점검 자료수신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		//DLG_BUTTON(STARTX, STARTY+600, 400, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NFITRCV, "부적합수신"),
		DLG_BUTTON(STARTX+600, STARTY+450, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		
		DLG_TEXT(STARTX, 	  STARTY-40, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCDT, "점검년월"),
		DLG_TEXT(STARTX, 	  STARTY+60, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "구분"),
		DLG_TEXT(STARTX, 	 STARTY+160, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "고객센터"),
		DLG_TEXT(STARTX+400, STARTY+160, 600, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX, 	 STARTY+260, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_AREA, "구역구분"),
		DLG_EDIT(STARTX+400, STARTY+260, 600, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA2, 5,""),
		
		DLG_COMBO (STARTX+400, STARTY-40, 600, 290, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SCDT, 10),	//점검년월 콤보박스
		DLG_COMBO (STARTX+400, STARTY+60, 600, 290, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOOBOON, 10),	//구분 콤보박스
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
	char sztmp[20];
	char szDp[20];
	long i;
	long chkmm;
	long date;
	
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
	
		chkmm = Time_GetDate()- Time_GetDay()+15;
		//테스트용 년월
		//ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SCDT+2), "201403", 0, ICON_NONE);
		//ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SCDT+2), "201406", 0, ICON_NONE);
		for(i = 0 ; i < 5 ; i++)
		{
			date = Time_DateUpDown ( chkmm, 30-(i*30) ); 
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
			
			Str_ItoA( date, sztmp, 10);
			Mem_Cpy( (byte*)szDp, (byte*)sztmp, 6);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SCDT+2), szDp, 0, ICON_NONE);
			if( i == 1)
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SCDT), szDp);
		}
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), stUserinfo.szcenter_nm);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SCDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOOBOON), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUSTOMCNTR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AREA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SCDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOOBOON), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GOOBOON+2), "정기점검", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GOOBOON+2), "확인점검", 0, ICON_NONE);
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GOOBOON), "정기점검");
}


//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+310) && Y < DMS_Y(STARTY+390) )
				{
					m_lActiveIndex = lActiveIndex;
					
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
					g_Dlgflag = 1;
					g_MOVE_DLG(1);
				
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
	char sztmp[128];
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
			MessageBoxEx (CONFIRM_OK, "조정기점검 미송신 자료가 있습니다, 전송후 수신하세요.");
			return -1;
		}
		
		
		chk = 0;
		g_Sql_RetInt(" select count(*) from NORMAL_ADDR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from NORMAL_BUR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from NORMAL_DATA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from NORMAL_INFO WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from NORMAL_MTR WHERE SEND_YN = 'S' and  length(UPD_EMPID) > 0 ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from NORMAL_NOGOOD WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from NORMAL_NOGOOD_CHA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from NORMAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from NORMAL_PIPE_CHK_DATA WHERE PIPE_FLAG = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from NORMAL_VISIT WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from CUST_PATT_COLL_INFO WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}

		if( chk > 0   )
		{
			MessageBoxEx (CONFIRM_OK, "일반점검 미송신 자료가 있습니다, 송신 후 수신받으세요.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_DATA2) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "관리구역을 입력하세요.");
			return -1;
		}
		
		if(  MessageBoxEx (CONFIRM_YESNO, "점검자료를 수신받으시겠습니까?")  == MB_OK )
		{
			Del_Data();
		}
		else
		{
			return -1;
		}
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if( Str_Cmp ("정기점검", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GOOBOON)) ) == 0)
		{
			Str_Cpy( m_szSafechktype, "23");
		}
		else
		{
			Str_Cpy( m_szSafechktype, "18");
		}
		Set_zone_manage_num(m_szzone_manage_num, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA2)) )  );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311317, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "safe_chk_type",    m_szSafechktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",   m_szzone_manage_num);
		
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
		if(g_Chk_Json(311317) >= 0)
		{
			RCV311318();
			return 1;
		}
		else
		{
			Del_Data();
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
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
		JSON_SetValue( g_pjcomm, 'C', "safe_chk_type",    m_szSafechktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",   m_szzone_manage_num);
		
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

			RCV311301();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}
		
	
	long RCV311301(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;	
		
		Mem_Set((byte*)m_szobjym, 0x00, sizeof(m_szobjym));
		Mem_Set((byte*)m_szchkyear, 0x00, sizeof(m_szchkyear));
		Str_Cpy( m_szobjym,  EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SCDT)) );
		Mem_Cpy( (byte*)m_szchkyear, (byte*)m_szobjym, 4);
		Mem_Cpy( (byte*)sztmp, (byte*)m_szobjym+4, 2 );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if( Str_Cmp ("정기점검", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GOOBOON)) ) == 0)
		{
			Str_Cpy( m_szchktype, "11");
		}
		else
		{
			Str_Cpy( m_szchktype, "18");
		}
		Set_zone_manage_num(m_szzone_manage_num, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA2)) )  );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy( (byte*)sztmp, (byte*)m_szobjym+4, 2 );
		if( Str_AtoI(sztmp) < 7 )
			Str_Cpy(m_szchkorder, "10");
		else
			Str_Cpy(m_szchkorder, "70");
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
		JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
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
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
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
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
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
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
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
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",            "10");		//10 : 일반점검 수신 , 20 : 검침-점검 업무이동 수신
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
	
	// 20171107 신기호 입상관점검 수신쿼리 추가
	long TR311310(void)
	{
		if(g_Chk_Json(311310) >= 0)
		{
			RCV311325();
			return 1;
		}
		else
		{
			Del_Data();
			g_Sock_Close();
			return -1;
		}
	}

	/* 20171107 신기호 입상관점검 수신쿼리 추가
	long TR311310(void)
	{
		long totcnt;
	
		g_Sock_Close();
		
		if(g_Chk_Json(311310) >= 0)
		{
			UPdate_Rcvlog();
			UPdate_Rcvlog2();

			if( m_nCnt311301 == 0 && m_nCnt311302 == 0 && m_nCnt311308 == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "일반점검대상 자료가 없습니다!");
				ON_DRAW();
				Del_Data();
				return 1;
			}

			if(m_nCnt311301 > 0)
			{
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다. 일일자료를 수신받으세요.");
			}
			else
			{			
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다.");
			}
			
			OnButton(GID_PREV);
			return 1;
		}
		else
		{
			Del_Data();
			return -1;
		}
	}
	*/
	// 20171107 신기호 입상관점검 수신쿼리 추가
	long RCV311325(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311325, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",        m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",           m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311325; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311325_IN",  "FR311325" , sndbuf, sztmp );
		
		return 0 ;
	}
	// 20171107 신기호 입상관점검 수신쿼리 추가
	long TR311325(void)
	{
		long totcnt;
	
		g_Sock_Close();
		
		if(g_Chk_Json(311325) >= 0)
		{
			UPdate_Rcvlog();
			UPdate_Rcvlog2();
			RCV311327();

			if( m_nCnt311301 == 0 && m_nCnt311302 == 0 && m_nCnt311308 == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "일반점검대상 자료가 없습니다!");
				ON_DRAW();
				Del_Data();
				return 1;
			}

			if(m_nCnt311301 > 0)
			{
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다. 일일자료를 수신받으세요.");
			}
			else
			{			
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다.");
			}
			
			OnButton(GID_PREV);
			return 1;
		}
		else
		{
			Del_Data();
			return -1;
		}
	}

	long RCV311327(void)
	{
		char sztmp[128];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		char szCnt[100];
		char szTown[20];
		char szAddr1_m[20];
		char szNew_road_nm[20];
		char szNew_addr_m[20];

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311327, FALSE);
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "SELECT SUM(CNT) FROM NORMAL_GROUP",0,0, 0);
		g_Sql_RetStr(sztmp, 10, szCnt);
		JSON_SetValue( g_pjcomm, 'C', "cnt", szCnt );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT TOWN FROM NORMAL_GROUP",0,0, 0);	
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szTown, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "town", szTown );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT ADDR1_M FROM NORMAL_GROUP",0,0, 0);		
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szAddr1_m, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "addr1_m",  szAddr1_m );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT NEW_ROAD_NM FROM NORMAL_GROUP",0,0, 0);		
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szNew_road_nm, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "new_road_nm",  szNew_road_nm );
		
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT NEW_ADDR_M FROM NORMAL_GROUP",0,0, 0);	
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szNew_addr_m, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_m",  szNew_addr_m );	

		JSON_SetValue( g_pjcomm, 'C', "crt_empid",  stUserinfo.szemployee_id);

		JSON_SetValue( g_pjcomm, 'C', "crt_ip",  stUserinfo.szpda_ip);

		JSON_SetValue( g_pjcomm, 'C', "chk_year",         m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",        m_szchkorder);
		JSON_SetValue( g_pjcomm, 'C', "chk_type",         m_szchktype);
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",           m_szobjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311327; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR311327_IN",  "FR311327" , sndbuf, sztmp );
		
		return 0 ;
	}

	long TR311327(void)
	{
		long totcnt;
	
		g_Sock_Close();

		
		if(g_Chk_Json(311325) >= 0)
		{
			
			if( m_nCnt311301 == 0 && m_nCnt311302 == 0 && m_nCnt311308 == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "일반점검대상 자료가 없습니다!");
				ON_DRAW();
				Del_Data();
				return 1;
			}

			if(m_nCnt311301 > 0)
			{
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다. 일일자료를 수신받으세요.");
			}
			else
			{			
				MessageBoxEx (CONFIRM_OK, "점검수신을 완료하였습니다.");
			}
			
			OnButton(GID_PREV);
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
	
	void UPdate_Rcvlog2(void)
	{
	long i=0, tot = 0, ret=0;
	char szSql[400];
	long idx;
	handle hdb = NULL;
	handle hstmt = NULL;
	char sztoday[9];
	SQLITE sql = NewSqLite();
	
		Mem_Set( (byte*) sztoday, 0x00, sizeof( sztoday) );
		Str_ItoA( Time_GetDate(), sztoday, 10);		
		
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
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM7, PARAM8) VALUES ('3',?,?,0 ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM7 =?,PARAM8=0 WHERE GUBUN = '3' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)m_szchkyear, 20, DECRYPT);
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
	
	
	long Del_Data(void)
	{
		g_Sql_DirectExecute("DELETE FROM REGTR_GROUP");
		g_Sql_DirectExecute("DELETE FROM REGTR_DATA");
		g_Sql_DirectExecute("DELETE FROM REGTR_MRT");
		g_Sql_DirectExecute("DELETE FROM REGTR_NOGOOD");
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
		return 1;
	}
}


