/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_RCV
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
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_RECV )			//수신하기
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
		DEF_OBJECT_ID ( TXT_TITLE )				//타이틀
		DEF_OBJECT_ID ( TXT_WORKDT )			//작업일자
		DEF_OBJECT_ID ( TXT_CHARGEDT )			//청구년월
		DEF_OBJECT_ID ( TXT_PERIODPAY )			//납기
		DEF_OBJECT_ID ( TXT_GMSTANDT )			//검침기준일
		DEF_OBJECT_ID ( TXT_CUSTOMCNTR )		//고객센터
		DEF_OBJECT_ID ( TXT_AREAMNGNUM )		//구역관리번호
		DEF_OBJECT_ID ( TXT_GMMETHOD )			//검침방법
		DEF_OBJECT_ID ( TXT_NOTIFY )			//참고문구
		
		DEF_OBJECT_ID ( EDT_WORKDT )			//작업일자 입력
		DEF_OBJECT_ID ( EDT_CUSTOMCNTR )		//고객센터 입력
		DEF_OBJECT_ID ( EDT_AREAMNGNUM )		//구역관리번호 입력
		
		DEF_OBJECT_ID ( ICON_TITLE )
				
		DEF_OBJECT_ID ( CMB_CHARGEDT ) 							//청구년월 콤보박스
		DEF_OBJECT_ID ( CMB_PERIODPAY = CMB_CHARGEDT+3 ) 		//납기 콤보박스
		DEF_OBJECT_ID ( CMB_GMSTANDT = CMB_PERIODPAY+3 ) 		//납기 콤보박스
		DEF_OBJECT_ID ( CMB_GMMETHOD = CMB_GMSTANDT+3 ) 		//검침방법 콤보박스
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	char m_szPERIODPAY[20];
	long m_lActiveIndex = -1;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void REDRAW(void);
	void Set_zone_manage_num(char *temp, long time );
	void UPdate_Rcvlog(void);
	void UPdate_Re_Rcvlog(void);
	long Rcv_Data(void);
	long TR21341(void);
	long RCV21342(void);
	long TR21342(void);
	long Re_Rcv_Data(void);
	long TR21343(void);
	long RCV21344(void);
	long TR21344(void);
	
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
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "자 료 수 신"),
		
		DLG_BUTTON(STARTX+250, STARTY+770, 500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "자 료 수 신"),
		
		DLG_TEXT(STARTX,  STARTY+65, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKDT, "작업일자"),
		DLG_TEXT(STARTX, STARTY+135, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CHARGEDT, "청구년월"),
		DLG_TEXT(STARTX, STARTY+205, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PERIODPAY, "납기"),
		DLG_TEXT(STARTX, STARTY+275, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GMSTANDT, "검침기준일"),
		DLG_TEXT(STARTX, STARTY+345, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "고객센터"),
		DLG_TEXT(STARTX, STARTY+415, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_AREAMNGNUM, "구역관리번호"),
		DLG_TEXT(STARTX, STARTY+485, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GMMETHOD, "검침방법"),
		DLG_TEXT(STARTX, STARTY+590, 1000, 150, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, RED, BRIGHTGRAY, TXT_NOTIFY, "청구년월, 납기, 구, 구역관리번호, \n 검침방법 등을 선택하세요."),
		
		DLG_TEXT(STARTX+400,  STARTY+65, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, EDT_WORKDT,  ""),
		DLG_TEXT(STARTX+400, STARTY+345, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, EDT_CUSTOMCNTR,   ""),
		DLG_EDIT(STARTX+400, STARTY+415, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_AREAMNGNUM, 5,  ""),
		
		DLG_COMBO (STARTX+400, STARTY+135, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CHARGEDT, 10),		//청구년월 콤보박스
		DLG_COMBO (STARTX+400, STARTY+205, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_PERIODPAY, 10),		//납기 콤보박스
		DLG_COMBO (STARTX+400, STARTY+275, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GMSTANDT, 10),		//검침기준일 콤보박스
		DLG_COMBO (STARTX+400, STARTY+485, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GMMETHOD, 10),		//검침방법 콤보박스
	};	
	
	//----------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		return TRUE;
	}
	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
	void OnInit(char bFirst)
	{
		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
						
				SetBtnImg();
				SetStyle();
				REDRAW();
				
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

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

	//-----------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHARGEDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PERIODPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMSTANDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUSTOMCNTR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AREAMNGNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMMETHOD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOTIFY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_WORKDT), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CUSTOMCNTR), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_AREAMNGNUM), EDITALIGN_MIDDLE);
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CHARGEDT), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PERIODPAY), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GMSTANDT), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GMMETHOD), EDITALIGN_MIDDLE);
	
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_NOTIFY), TRUE, 2, EDITSEP_NONE );		//신고내역
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "10납기", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "20납기", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "26납기", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "30납기", 0, ICON_NONE);
		
		// PRINT("stUserinfo.szcenter_cd : %s",stUserinfo.szcenter_cd,0,0);
		if( Str_Cmp(stUserinfo.szcenter_cd, "34" ) == 0 || Str_Cmp(stUserinfo.szcenter_cd, "35" ) == 0 )				
		{
			
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "정기", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "재검", 0, ICON_NONE);
		}
		else
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "정기", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "재검", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "조정에러", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "재검+조정에러", 0, ICON_NONE);
		}
	}

//-------------------------------------------------------------------------
	void OnPointing( long nAction, long X, long Y )
	{
		long lActiveIndex = -1;
		long lret;

		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		m_lActiveIndex = lActiveIndex;

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+415) && Y < DMS_Y(STARTY+485) )
				{
					if( Get_iDlgCtrlByID(EDT_AREAMNGNUM) == lActiveIndex )	
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
	void OnButton( long ID )
	{	
		switch(ID)
		{					
			case BID_RECV:
				if( Str_Cmp( "정기", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD) ) ) == 0 )
				{
					Rcv_Data();
				}
				else
				{
					Re_Rcv_Data();
				}
				
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
				
				if( MessageBoxEx (CONFIRM_YESNO, "검침 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("GM_MENU");
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
				
				Card_Move("GM_DMMENU");
				break;
					
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		
	
	void REDRAW(void)
	{
		char sztmp[20];
		char szDp[20];
		long i;
		long chkmm;
		long date;
	
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
		Str_ItoA( Time_GetDate(), sztmp, 10);
		//Str_ItoA( 20160310, sztmp, 10);
		g_Str_DateType(szDp, sztmp);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_WORKDT), szDp);
		
		chkmm = Time_GetDate()- Time_GetDay()+15;
		
		for(i = 0 ; i < 3 ; i++)
		{
			date = Time_DateUpDown ( chkmm, 30-(i*30) ); 
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
			
			Str_ItoA( date, sztmp, 10);
			Mem_Cpy( (byte*)szDp, (byte*)sztmp, 6);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CHARGEDT+2), szDp, 0, ICON_NONE);
			if( i == 0)
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CHARGEDT), szDp);
		}
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CUSTOMCNTR), stUserinfo.szcenter_nm);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMMETHOD), "정기");
		Str_Cpy( m_szPERIODPAY, "10납기" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_PERIODPAY), "10납기");
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMSTANDT), "전체");
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "전체", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "16", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "17", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "18", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "19", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "20", 0, ICON_NONE);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMMETHOD), "정기");

	}
	
	void	OnSelect(long Index)
	{
	char szcmb[20];
	
		Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
		Str_Cpy( szcmb , EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ) );
		//콤보박스 선택으로 리스트 목록 필터링.(검침,미검침,전체대상)
		if( Str_Cmp(m_szPERIODPAY, szcmb ) != 0 )
		{
			Str_Cpy(m_szPERIODPAY, szcmb);
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_GMSTANDT+2)) ;


			if( Str_Cmp(m_szPERIODPAY, "10납기" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "전체", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "16", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "17", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "18", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "19", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "20", 0, ICON_NONE);
			}
			else if( Str_Cmp(m_szPERIODPAY, "20납기" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "전체", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "26", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "27", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "28", 0, ICON_NONE);
				
			}
			else if( Str_Cmp(m_szPERIODPAY, "26납기" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "전체", 0, ICON_NONE);
			}
			else if( Str_Cmp(m_szPERIODPAY, "30납기" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "전체", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "06", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "07", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "08", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "09", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "10", 0, ICON_NONE);
			}
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMSTANDT), "전체");
			ON_DRAW();
			

			
		}
	}
	
	long Rcv_Data(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long totcnt;
		long lCnt = 0;
		
		/*******************/
		/* Validation      */
		/*******************/	
		g_Sql_RetInt(" SELECT COUNT(1) FROM GUMDATA", &lCnt);
	
		if( lCnt > 0 )
		{
			MessageBoxEx(CONFIRM_OK, "[정기검침]자료가 있습니다.\n자료삭제 후 수신 하세요.");
			return -1;
		}
		
		g_Sql_RetInt("SELECT COUNT(1) GUMDATA WHERE SEND_YN = 'S'", &totcnt);
	
		if( totcnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "[정기검침]미송신 자료가 있습니다.\n송신 후 수신 받으세요.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "관리구역을 입력하세요.");
			return -1;
		}
		
		/*******************/
		/* Start           */
		/*******************/	
		if( MessageBoxEx( CONFIRM_YESNO, "[정기검침]검침자료를\n수신 받으시겠습니까?" ) == MB_OK )
		{	
			g_Sql_DirectExecute("DELETE FROM GUMGROUP");
			g_Sql_DirectExecute("DELETE FROM GUMDATA");		
		}
		else
		{
			return -1;
		}
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead( g_pjcomm, szUrl, 21432, FALSE );
		
		// 1. req_ym
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT) ) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym", sztmp );
		
		// 2. deadline_flag
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag", sztmp );
		
		// 3. gmtr_base_day
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		if( Str_Cmp( "전체", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ) ) == 0)
		{	
			Str_Cpy( sztmp, "%" );
		}
		else
		{
			Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ), 2 );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "gmtr_base_day", sztmp );
		
		// 4. branch_cd
		JSON_SetValue( g_pjcomm, 'C', "branch_cd", stUserinfo.szbranch_cd);
		
		// 5. center_cd
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		
		// 6. zone_manage_num
		Set_zone_manage_num( sztmp, Str_AtoI( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) ) );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  sztmp);
		
		// 7. gmtr_meth
		JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "10");
		
		// 8. gmtr_nm
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SQL_ConvUcStr( sznm_kor, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_nm", sznm_kor );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );	
		GET_FILENM( sztmp, SQLITE_DB );
		
		callBackfunc = TR21341;
		ret = HTTP_DownloadData( szUrl, "FR21341_IN",  "FR21341" , sndbuf, sztmp );
	
		return 0 ;
	}
	
	long TR21341(void)
	{
		if(g_Chk_Json(21341) >= 0)
		{
			//검침배율을 저장한다.
			RCV21342();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV21342(void)
	{
	char sztmp[32];
	char szUrl[256];
	char sznm_kor[64];
	char* sndbuf;
	long ret;
		
		PROGRESS_DUMP("");
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21432, FALSE);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT)) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym",    sztmp);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_NCpy (sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY)), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",    sztmp);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		
		if(Str_Cmp("전체", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)) ) == 0)
		{	
			Str_Cpy (sztmp, "%" );
		}
		else
		{
			Str_NCpy (sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)), 2 );
		}
		JSON_SetValue( g_pjcomm, 'C', "gmtr_base_day",  sztmp );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd",  stUserinfo.szbranch_cd);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );

		Set_zone_manage_num(sztmp, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM)) )  );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    sztmp);
		
		if( Str_Cmp("정기", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0 )
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "10");
		else
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "20");
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SQL_ConvUcStr( sznm_kor, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_nm",          sznm_kor );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR21342;
		ret = HTTP_DownloadData(szUrl, "FR21342_IN",  "FR21342" , sndbuf, sztmp );
		
		return 0;
	}
	
	long TR21342(void)
	{
	long totcnt = 0;
	char szmag[128];
		g_Sock_Close();
		
		if(g_Chk_Json(21342) >= 0)
		{
			RCV21344();			
			return 1;
			
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	long Re_Rcv_Data(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long totcnt;
		long lCnt = 0;
		
		/*******************/
		/* Validation      */
		/*******************/	
		g_Sql_RetInt(" SELECT COUNT(1) FROM REGUMDATA", &lCnt);
	
		if( lCnt > 0 )
		{
			MessageBoxEx(CONFIRM_OK, "[재검 및 조정에러]자료가 있습니다.\n자료삭제 후 수신 하세요.");
			return -1;
		}
		
		g_Sql_RetInt("SELECT COUNT(1) REGUMDATA WHERE SEND_YN = 'S'", &totcnt);
	
		if( totcnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "[재검 및 조정에러]미송신 자료가 있습니다.\n송신 후 수신 받으세요.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "관리구역을 입력하세요.");
			return -1;
		}
		
		/*******************/
		/* Start           */
		/*******************/	
		if( MessageBoxEx( CONFIRM_YESNO, "[재검 및 조정에러]자료를\n수신 받으시겠습니까?" ) == MB_OK )
		{	
			g_Sql_DirectExecute("DELETE FROM REGUMDATA");		
		}
		else
		{
			return -1;
		}
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead( g_pjcomm, szUrl, 21343, FALSE );
		
		// 1. req_ym
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT) ) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym", sztmp );
		
		// 2. deadline_flag
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag", sztmp );
		
		// 3. gmtr_base_day
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		if( Str_Cmp( "전체", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ) ) == 0)
		{	
			Str_Cpy( sztmp, "%" );
		}
		else
		{
			Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ), 2 );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "gmtr_base_day", sztmp );
		
		// 4. branch_cd
		JSON_SetValue( g_pjcomm, 'C', "branch_cd", stUserinfo.szbranch_cd);
		
		// 5. center_cd
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		
		// 6. zone_manage_num
		Set_zone_manage_num( sztmp, Str_AtoI( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) ) );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  sztmp);
		
		// 7. gmtr_meth
		if( Str_Cmp("재검", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD) ) ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "20");
		}
		else if( Str_Cmp("조정에러", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD) ) ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "21");
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "22");
		}
		
		// 8. gmtr_nm
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SQL_ConvUcStr( sznm_kor, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_nm", sznm_kor );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );	
		GET_FILENM( sztmp, SQLITE_DB );
		
		callBackfunc = TR21343;
		ret = HTTP_DownloadData( szUrl, "FR21343_IN",  "FR21343" , sndbuf, sztmp );
	
		return 0 ;
	}
	
	
	long TR21343(void)
	{
		long totcnt = 0;
		char szmag[128];
		
		g_Sock_Close();
		
		if( g_Chk_Json(21343) >= 0 )
		{
			UPdate_Re_Rcvlog();
			g_Sql_RetInt("SELECT COUNT(1) FROM REGUMDATA ", &totcnt);
			
			Mem_Set((byte*)szmag ,0x00, sizeof(szmag) );
			SPRINT(szmag, "[재검 및 조정에러]자료\n%d건 수신 받았습니다.", totcnt, 0, 0);
			
			if( totcnt > 0 )
			{
				//검침 대상 수신 후 => 문자검침 대상 L 코드 입력 및 SEND_YN 업데이트
				g_Sql_DirectExecute("UPDATE REGUMDATA SET MTR_WORK_CODE ='L', SEND_YN = 'S' WHERE SMS_GMTR_MAN_YN = 'Y' AND BEFO_GMTR_SMS_YN IS NULL ");
			
				MessageBoxEx( CONFIRM_OK, szmag );
				ON_DRAW();
				
				OnButton(GID_PREV);
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "수신된 재 검침대상이 없습니다.");
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

	long RCV21344(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		char szCnt[100];
		char szTown[20];
		char szAddr1_m[20];
		char szNew_road_nm[20];
		char szNew_addr_m[20];
		
		PROGRESS_DUMP("");
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21344, FALSE);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT)) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym",    sztmp);

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "SELECT SUM(CNT) FROM GUMGROUP",0,0, 0);
		g_Sql_RetStr(sztmp, 10, szCnt);
		JSON_SetValue( g_pjcomm, 'C', "cnt", szCnt );		

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT TOWN FROM GUMGROUP",0,0, 0);	
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szTown, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "town", szTown );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT ADDR1_M FROM GUMGROUP",0,0, 0);		
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szAddr1_m, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "addr1_m",  szAddr1_m );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT NEW_ROAD_NM FROM GUMGROUP",0,0, 0);		
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szNew_road_nm, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "new_road_nm",  szNew_road_nm );
		
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT NEW_ADDR_M FROM GUMGROUP",0,0, 0);	
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szNew_addr_m, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_m",  szNew_addr_m );	
		
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_NCpy (sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY)), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",    sztmp);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );

		JSON_SetValue( g_pjcomm, 'C', "crt_empid",  stUserinfo.szemployee_id);

		JSON_SetValue( g_pjcomm, 'C', "crt_ip",  stUserinfo.szpda_ip);

		Set_zone_manage_num(sztmp, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM)) )  );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    sztmp);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR21344;
		ret = HTTP_DownloadData(szUrl, "FR21344_IN",  "FR21344" , sndbuf, sztmp );
		
		return 0;
	}

	long TR21344(void)
	{
	long totcnt = 0;
	char szmag[128];
		g_Sock_Close();
		
		if(g_Chk_Json(21342) >= 0)
		{
			UPdate_Rcvlog();
			g_Sql_RetInt(" select count(*) from GUMDATA ", &totcnt);
			Mem_Set((byte*)szmag ,0x00, sizeof(szmag) );
			SPRINT(szmag, " 검침 %d건 수신 받았습니다. ", totcnt, 0, 0);
			
			if(totcnt > 0 )
			{
				//검침 대상 수신 후 => 문자검침 대상 L 코드 입력 및 SEND_YN 업데이트
				g_Sql_DirectExecute("UPDATE GUMDATA SET MTR_WORK_CODE ='L', SEND_YN = 'S' WHERE SMS_GMTR_MAN_YN = 'Y' AND BEFO_GMTR_SMS_YN IS NULL ");
			
				MessageBoxEx (CONFIRM_OK, szmag);
				ON_DRAW();

				// RCV21344();

				//수신된 자료 서버로 전송
				OnButton(GID_PREV);
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "수신된 검침대상이 없습니다.");
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
	
	
	void UPdate_Rcvlog(void)
	{
	long i=0, tot = 0, ret=0;
	char szSql[400];
	long idx;
	char szPARAM1  [20+1];
	char szPARAM2  [20+1];
	char szPARAM3  [20+1];
	char szPARAM4  [20+1];
	char szPARAM5  [20+1];
	char szPARAM6  [20+1];
	char szPARAM7  [20+1];
	char* szPARAM9;
	char* szPARAM10;
	long nPARAM9;
	long nPARAM10;
	char sztmp[10];
	char szJsonpath[100];
	char szType[2];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		
		Mem_Set((byte*)szPARAM1, 0x00, sizeof(szPARAM1));
		Mem_Set((byte*)szPARAM2, 0x00, sizeof(szPARAM2));
		Mem_Set((byte*)szPARAM3, 0x00, sizeof(szPARAM3));
		Mem_Set((byte*)szPARAM4, 0x00, sizeof(szPARAM4));
		Mem_Set((byte*)szPARAM5, 0x00, sizeof(szPARAM5));
		Mem_Set((byte*)szPARAM6, 0x00, sizeof(szPARAM6));
		Mem_Set((byte*)szPARAM7, 0x00, sizeof(szPARAM7));
		Mem_Set((byte*)szType, 0x00, sizeof(szType));

		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 21341, 0 );
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			return;
		}
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szPARAM9 = JSON_GetValue (g_pjcomm, "gmtr_apply_rt", szType);
			nPARAM9 = Str_AtoI(szPARAM9);
			
			szPARAM10 = JSON_GetValue (g_pjcomm, "gmtr_apply_rt2", szType);
			nPARAM10 = Str_AtoI(szPARAM10);
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		Str_Cpy( szPARAM1, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT)) );      //req_ym
		Str_NCpy(szPARAM2, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY)), 2 );  //deadline_flag
		if(Str_Cmp("전체", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)) ) == 0)
		{
			
			Str_Cpy (szPARAM3, "%" );
		}
		else
		{
			Str_NCpy (szPARAM3, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)), 2 ); //gmtr_base_day
		}
		
		Str_Cpy( szPARAM4, stUserinfo.szbranch_cd); //branch_cd
		Str_Cpy( szPARAM5, stUserinfo.szcenter_cd );//center_cd
		
		Set_zone_manage_num(szPARAM6, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM)) )  ); // zone_manage_num

		if(  Str_Cmp("정기", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0  ) // gmtr_meth
		{
			Str_Cpy( szPARAM7,    "10");
		}
		else
		{
			Str_Cpy( szPARAM7,    "20");
		}
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,PARAM6,PARAM7,PARAM8,PARAM9,PARAM10) VALUES ('1',?,?,?,? ,?,?,?, 0, ?,? ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM2=?,PARAM3=?,PARAM4=?,PARAM5=?,PARAM6=?,PARAM7=?,PARAM8=0,PARAM9=?,PARAM10=?  WHERE GUBUN = '1' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)szPARAM1, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM2, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM3, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM4, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM5, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM6, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM7, 20, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM9,  4, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM10, 4, DECRYPT);
		
		//sql->Begin(sql);
		ret = sql->Execute(sql);
		
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
	
	void UPdate_Re_Rcvlog(void)
	{
		long i = 0;
		long tot = 0;
		long ret = 0;
		long idx;
		
		char sztmp[10];
		char szJsonpath[100];
		char szType[2];
		
		char szSql[400];
		char szPARAM1[20+1];
		char szPARAM2[20+1];
		char szPARAM3[20+1];
		char szPARAM4[20+1];
		char szPARAM5[20+1];
		char szPARAM6[20+1];
		char szPARAM7[20+1];
		char* szPARAM9;
		char* szPARAM10;
		long nPARAM9;
		long nPARAM10;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szPARAM1, 0x00, sizeof(szPARAM1));
		Mem_Set((byte*)szPARAM2, 0x00, sizeof(szPARAM2));
		Mem_Set((byte*)szPARAM3, 0x00, sizeof(szPARAM3));
		Mem_Set((byte*)szPARAM4, 0x00, sizeof(szPARAM4));
		Mem_Set((byte*)szPARAM5, 0x00, sizeof(szPARAM5));
		Mem_Set((byte*)szPARAM6, 0x00, sizeof(szPARAM6));
		Mem_Set((byte*)szPARAM7, 0x00, sizeof(szPARAM7));
		Mem_Set((byte*)szType, 0x00, sizeof(szType));

		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		
		SPRINT( szJsonpath, "%sFR%d.JSON", SYSTEM_COMM, 21343, 0 );
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		
		if( g_pjcomm == NULL )
		{
			return;
		}
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szPARAM9 = JSON_GetValue( g_pjcomm, "gmtr_apply_rt", szType );
			nPARAM9 = Str_AtoI( szPARAM9 );
			
			szPARAM10 = JSON_GetValue( g_pjcomm, "gmtr_apply_rt2", szType );
			nPARAM10 = Str_AtoI( szPARAM10 );
		}
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		Str_Cpy( szPARAM1, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT) ) ); // req_ym
		Str_NCpy( szPARAM2, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ), 2 ); // deadline_flag
		
		if( Str_Cmp( "전체", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ) ) == 0 )
		{
			Str_Cpy( szPARAM3, "%" );
		}
		else
		{
			Str_NCpy( szPARAM3, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ), 2 ); // gmtr_base_day
		}
		
		Str_Cpy( szPARAM4, stUserinfo.szbranch_cd ); // branch_cd
		Str_Cpy( szPARAM5, stUserinfo.szcenter_cd ); // center_cd
		
		Set_zone_manage_num( szPARAM6, Str_AtoI( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) ) ); // zone_manage_num

		if( Str_Cmp( "재검", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0  ) // gmtr_meth
		{
			Str_Cpy( szPARAM7, "20" );
		}
		else if( Str_Cmp( "조정에러", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0  )
		{
			Str_Cpy( szPARAM7, "21" );
		}
		else
		{
			Str_Cpy( szPARAM7, "22" );
		}
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '10'", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0 )
		{
			hstmt = sql->CreateStatement(sql, "INSERT INTO RCV_LOG ( GUBUN, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7, PARAM8, PARAM9, PARAM10 ) VALUES ( '10', ?, ?, ?, ?, ?, ?, ?, 0, ?, ? )");
		}
		else
		{
			hstmt = sql->CreateStatement(sql, "UPDATE RCV_LOG SET PARAM1 = ?, PARAM2 = ?, PARAM3 = ?, PARAM4 = ?, PARAM5 = ?, PARAM6 = ?, PARAM7 = ?, PARAM8 = 0, PARAM9 = ?, PARAM10 = ? WHERE GUBUN = '10' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)szPARAM1, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM2, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM3, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM4, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM5, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM6, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM7, 20, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM9,  4, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM10, 4, DECRYPT);
		
		ret = sql->Execute(sql);
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
	Finally:
		DelSqLite(sql);
		return;		
	}
}


