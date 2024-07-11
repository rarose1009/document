/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_RCV
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
		DEF_BUTTON_ID ( BID_RECV )			//자료수신
		DEF_BUTTON_ID ( BID_RECV2 )			//자료수신2
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
		DEF_OBJECT_ID ( TXT_JISA )			//지사
		DEF_OBJECT_ID ( TXT_CUSTOMCNTR )	//고객센터
		DEF_OBJECT_ID ( TXT_BSTYPE )		//점검유형
		DEF_OBJECT_ID ( TXT_DATA1 )
		
		DEF_OBJECT_ID ( ICON_TITLE)		//타이틀
				
		DEF_OBJECT_ID ( CMB_YMD ) 						//지사 콤보박스
		DEF_OBJECT_ID ( CMB_BSTYPE = CMB_YMD+3 ) 		//점검유형 콤보박스
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	long m_nCnt411300 = 0;
	long m_Cnt411302 = 0;
	long m_Cnt411303 = 0;
	long m_Cnt411306 = 0;
	
	char m_szchkyear[5];
	char m_szchkorder[3];
	char m_szChktype[3];
	char m_szobj_ym[7];
	void UPdate_Rcvlog(void);
	void BS_DataDel(void);
	
	void SetStyle(void);
	void SetBtnImg(void);
	
	long Rcv_Data(void);
	long RCV411300(void);
	long TR411300(void);
	long TR411301(void);
	void RCV411302(void);
	long TR411302(void);
	void RCV411303(void);
	long TR411303(void);
	void RCV411304(void);
	long TR411304(void);
	void RCV411305(void);
	long TR411305(void);
	void RCV411306(void);
	long TR411306(void);
	void RCV411307(void);
	long TR411307(void);
	void RCV411308(void);
	long TR411308(void);
	void RCV411309(void);
	long TR411309(void);
	void RCV411310(void);
	long TR411310(void);
	void RCV411311(void);
	long TR411311(void);
	void RCV411312(void);
	long TR411312(void);
	void RCV411313(void);
	long TR411313(void);
	
	void RCV411326(void);
	long TR411326(void);
	void RCV411327(void);
	long TR411327(void);
	void RCV411328(void);
	long TR411328(void);
	void RCV411329(void);
	long TR411329(void);
	void RCV411330(void);
	long TR411330(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "전체자료 수신"),
			
		DLG_BUTTON(STARTX+600, STARTY+350, 400, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		
		DLG_TEXT(STARTX,		 STARTY+65, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JISA, "점검년월"),
		DLG_TEXT(STARTX,		STARTY+145, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "고객센터"),
		DLG_TEXT(STARTX+400,	STARTY+145, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),		
		DLG_TEXT(STARTX,		STARTY+225, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSTYPE, "점검유형"),
		
		DLG_COMBO (STARTX+400,	 STARTY+65, 600, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_YMD, 10),		//점검년월 콤보박스
		DLG_COMBO (STARTX+400,	STARTY+225, 600, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BSTYPE, 10),	//점검유형 콤보박스
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "전체자료 수신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+600, STARTY+300, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자료수신"),
		
		DLG_TEXT(STARTX,      STARTY-40, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JISA, "점검년월"),
		DLG_TEXT(STARTX,      STARTY+60, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "고객센터"),
		DLG_TEXT(STARTX+400,  STARTY+60, 600, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),		
		DLG_TEXT(STARTX,     STARTY+160, 400, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSTYPE, "점검유형"),
		
		DLG_COMBO (STARTX+400,  STARTY-40, 600, 290, 150, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_YMD, 10),		//점검년월 콤보박스
		DLG_COMBO (STARTX+400, STARTY+160, 600, 290, 150, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BSTYPE, 10),	//점검유형 콤보박스
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
						SetBtnImg();
						SetStyle();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						SetBtnImg();
						SetStyle();
						break;		
				}
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
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JISA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUSTOMCNTR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_YMD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BSTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
	Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );

	chkmm = Time_GetDate()- Time_GetDay()+15;

	for(i = 0 ; i < 4 ; i++)
	{
		date = Time_DateUpDown ( chkmm, 30-(i*30) ); 
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
		
		Str_ItoA( date, sztmp, 10);
		Mem_Cpy( (byte*)szDp, (byte*)sztmp, 6);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_YMD+2), szDp, 0, ICON_NONE);
		if( i == 1)
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_YMD), szDp);
	}
	ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BSTYPE+2), "특정점검", 0, ICON_NONE);
	ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BSTYPE+2), "특별점검", 0, ICON_NONE);
	EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), stUserinfo.szcenter_nm);
	
	
	/* 지사담당자는 점검유형이 "특별점검"으로 자동 셋팅될 수 있도록 기능 변경 2015.01.06 명훈이*/
	if( Str_Cmp(stUserinfo.szcenter_cd,"91") == 0 
	|| Str_Cmp(stUserinfo.szcenter_cd,"92") == 0 
	|| Str_Cmp(stUserinfo.szcenter_cd,"93") == 0 
	|| Str_Cmp(stUserinfo.szcenter_cd,"94") == 0 
	|| Str_Cmp(stUserinfo.szcenter_cd,"95") == 0 )
	{
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BSTYPE+1), FALSE );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_BSTYPE), "특별점검");
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BSTYPE+1), TRUE );
	}
	else
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_BSTYPE), "특정점검");
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_RECV:
				Rcv_Data();
				break;
			case BID_RECV2:
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "특정점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("BS_MENU");
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
				Card_Move("BS_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	long Rcv_Data(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	long chk = 0, totcnt;
		
		chk = 0;
		g_Sql_RetInt(" select count(*) from SPECIAL_BUR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from SPECIAL_DATA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		
		g_Sql_RetInt(" select count(*) from SPECIAL_GOV_REG WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_MTR WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD_CHA WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}
		g_Sql_RetInt(" select count(*) from SPECIAL_PIPE_CHK_DATA ", &totcnt);
		if(totcnt > 0)
		{
			chk++;
		}


		if( chk > 0   )
		{
			MessageBoxEx (CONFIRM_OK, "미송신 자료가 있습니다, 송신 후 수신받으세요.");
			return -1;
		}
		
		if(  MessageBoxEx (CONFIRM_YESNO, "점검자료를 수신받으시겠습니까?")  == MB_OK )
		{
			BS_DataDel();
		}
		else
		{
			return -1;
		}
		Mem_Set((byte*)m_szobj_ym, 0x00, sizeof(m_szobj_ym));
		Str_Cpy( m_szobj_ym,  EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_YMD)) );
		
		Mem_Set((byte*)m_szchkyear, 0x00, sizeof(m_szchkyear));
		Mem_Cpy( (byte*)m_szchkyear, (byte*)m_szobj_ym, 4);
		
		Mem_Set((byte*)m_szchkorder, 0x00, sizeof(m_szchkorder));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy( (byte*)sztmp, (byte*)m_szobj_ym+4, 2 );
		
		if( Str_AtoI(sztmp) < 7 )
		{
			Str_Cpy(m_szchkorder, "10");
		}
		else
		{
			Str_Cpy(m_szchkorder, "70");
		}

		if( Str_Cmp ("특정점검", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BSTYPE)) ) == 0)
		{
			Str_Cpy( m_szChktype, "21");
		}
		else
		{
			Str_Cpy( m_szChktype, "30");
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411301, FALSE);
			
		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		if(Str_Cmp(m_szChktype, "21") == 0 )
		{
			callBackfunc = TR411301; //통신완료 후에 호출 함수
			ret = HTTP_DownloadData(szUrl, "FR411301_IN",  "FR411301" , sndbuf, sztmp );			
		}
		else
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			RCV411303();
		}
		return 0 ;
	}
	
	long TR411301(void)
	{
		if(g_Chk_Json(411301) >= 0)
		{
			RCV411300();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}

	long RCV411300(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;	
		
		
		Mem_Set((byte*)m_szchkyear, 0x00, sizeof(m_szchkyear));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		
		if( Str_AtoI(sztmp) < 7 )
			Str_Cpy(m_szchkorder, "10");
		else
			Str_Cpy(m_szchkorder, "70");
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411300, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobj_ym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411300; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411300_IN",  "FR411300" , sndbuf, sztmp );
		return 0 ;
	}

	long TR411300(void)
	{
		m_nCnt411300 = g_Chk_Json(411300);
		if( m_nCnt411300 >= 0)
		{
			RCV411302();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411302(void)
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
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411302, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411302; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411302_IN",  "FR411302" , sndbuf, sztmp );		
		
	}
	
	long TR411302(void)
	{
		m_Cnt411302 = g_Chk_Json(411302);
		if( m_Cnt411302 >= 0)
		{
			RCV411326();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411303(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411303, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411303; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411303_IN",  "FR411303" , sndbuf, sztmp );		
		
	}
	
	long TR411303(void)
	{
		m_Cnt411303 = g_Chk_Json(411303);
		if(m_Cnt411303 >= 0)
		{
			RCV411304();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411304(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411304, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411304; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411304_IN",  "FR411304" , sndbuf, sztmp );		
		
	}
	
	long TR411304(void)
	{
		if(g_Chk_Json(411304) >= 0)
		{
			RCV411305();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	
	void RCV411305(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411305, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411305; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411305_IN",  "FR411305" , sndbuf, sztmp );		
		
	}
	
	long TR411305(void)
	{
		if(g_Chk_Json(411305) >= 0)
		{
			RCV411306();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411306(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411306, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411306; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411306_IN",  "FR411306" , sndbuf, sztmp );		
		
	}
	
	long TR411306(void)
	{
		m_Cnt411306 = g_Chk_Json(411306);
		if( m_Cnt411306  >= 0)
		{
			RCV411307();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411307(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411307, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411307; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411307_IN",  "FR411307" , sndbuf, sztmp );		
		
	}
	
	long TR411307(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(411307) >= 0)
		{
			UPdate_Rcvlog();
			/*
			if( m_Cnt411302 == 0 && m_Cnt411303 == 0 && m_Cnt411306 == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "자료가 없습니다. 확인해 주세요.");
				ON_DRAW();
				return 1;
			}
			*/
			if( m_Cnt411303 == 0 && m_Cnt411306 == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "자료가 없습니다. 확인해 주세요.");
				ON_DRAW();
				return 1;
			}
			else
			{
				if( m_Cnt411302 > 0)
					MessageBoxEx (CONFIRM_OK, "자료수신을 완료했습니다. 일일자료를 수신하세요.");
				else
					MessageBoxEx (CONFIRM_OK, "자료수신을 완료했습니다.");
					
				ON_DRAW();
				OnButton(GID_PREV);
			}
			return 1;
		}
		else
		{
			BS_DataDel();
			return -1;
		}
	}
	
	void RCV411308(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;

	Mem_Set((byte*)m_szchkyear, 0x00, sizeof(m_szchkyear));
	Mem_Cpy( (byte*)m_szchkyear, (byte*)m_szobj_ym, 4);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411308, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411308; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411308_IN",  "FR411308" , sndbuf, sztmp );		
		
	}
	
	long TR411308(void)
	{
		if(g_Chk_Json(411308) >= 0)
		{
			RCV411309();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411309(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411309, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411309; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411309_IN",  "FR411309" , sndbuf, sztmp );		
		
	}
	
	long TR411309(void)
	{
		if(g_Chk_Json(411309) >= 0)
		{
			RCV411310();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411310(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411310, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411310; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411310_IN",  "FR411310" , sndbuf, sztmp );		
		
	}
	
	long TR411310(void)
	{
	long totcnt;
		
		g_Sock_Close();
		
		if(g_Chk_Json(411310) >= 0)
		{
			UPdate_Rcvlog();
			
			if( m_Cnt411302 > 0)
			{
				MessageBoxEx (CONFIRM_OK, "수신을 완료하였습니다. 일일자료를 수신받으세요.");
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "수신을 완료하였습니다.");
			}
			
			OnButton(GID_PREV);
			return 1;
		}
		else
		{
			BS_DataDel();
		}
		return -1;
	}
	
	void RCV411326(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411326, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411326; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411326_IN",  "FR411326" , sndbuf, sztmp );		
		
	}
	
	long TR411326(void)
	{
		if(g_Chk_Json(411326) >= 0)
		{
			RCV411327();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411327(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411327, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411327; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411327_IN",  "FR411327" , sndbuf, sztmp );		
		
	}
	
	long TR411327(void)
	{
		if(g_Chk_Json(411327) >= 0)
		{
			RCV411328();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411328(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411328, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411328; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411328_IN",  "FR411328" , sndbuf, sztmp );		
		
	}
	
	long TR411328(void)
	{
		if(g_Chk_Json(411328) >= 0)
		{
			RCV411329();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411329(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411329, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411329; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411329_IN",  "FR411329" , sndbuf, sztmp );		
		
	}
	
	long TR411329(void)
	{
		if(g_Chk_Json(411329) >= 0)
		{
			RCV411330();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
			return -1;
		}
	}
	
	void RCV411330(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 411330, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szChktype);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szobj_ym);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR411330; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR411330_IN",  "FR411330" , sndbuf, sztmp );		
		
	}
	
	long TR411330(void)
	{
		if(g_Chk_Json(411330) >= 0)
		{
			RCV411308();
			return 1;
		}
		else
		{
			BS_DataDel();
			g_Sock_Close();
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
	char sztoday[9];
	SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*) sztoday, 0x00, sizeof( sztoday) );
		Str_ItoA( Time_GetDate(), sztoday, 10);	
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM3,PARAM7, PARAM8) VALUES ('5',?,?,?,? ,0 ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM2=?,PARAM3=?,PARAM7=?,PARAM8=0 WHERE GUBUN = '5' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)m_szChktype, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcenter_cd, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)m_szobj_ym, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)sztoday, 8, DECRYPT);
		
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
	
	void BS_DataDel(void)
	{
		g_Sql_DirectExecute("DELETE FROM SPECIAL_BUR");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_DATA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_GOV_REG");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_GROUP");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_MTR");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD_CHA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_NOGOOD_DETAL");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_PIPE_CHK_DATA");
		g_Sql_DirectExecute("DELETE FROM SPECIAL_PREV_NO");
	}
}


