/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WCARD
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT
	#define USE_ON_USER
	#define USE_ON_UART
	#include "DefEvent.h"
	
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CLOSE )	    //
		DEF_BUTTON_ID ( BID_SCAN )      //
		DEF_BUTTON_ID ( BID_SIGN )	    //
		DEF_BUTTON_ID ( BID_CARDLIST )	//
		DEF_BUTTON_ID ( BID_SUBCLOSE )	//
		
		
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
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		DEF_OBJECT_ID ( TAB_COVER )		//타이틀
		DEF_OBJECT_ID ( TAB_LINE )		//타이틀
		
		DEF_OBJECT_ID ( TTL_TOT_AMT       )
		DEF_OBJECT_ID ( TTL_CARDGASPAY    )
		DEF_OBJECT_ID ( TXT_CARDGASPAY    )
		DEF_OBJECT_ID ( TTL_CARDONCEPAY   )
		DEF_OBJECT_ID ( TXT_CARDONCEPAY   )
		DEF_OBJECT_ID ( TTL_CARD_INFO     )
		DEF_OBJECT_ID ( TTL_CARD_NUM      )
		DEF_OBJECT_ID ( TXT_CARD_NUM      )
		DEF_OBJECT_ID ( TTL_CARD_YM       )
		DEF_OBJECT_ID ( TXT_CARD_YY       )
		DEF_OBJECT_ID ( TTL_CARD_YY       )
		DEF_OBJECT_ID ( TXT_CARD_MM       )
		DEF_OBJECT_ID ( TTL_CARD_MM       )
		DEF_OBJECT_ID ( TTL_ALLOTMENT_MM  )
		//DEF_OBJECT_ID ( TTL_APPROVAL      )
		//DEF_OBJECT_ID ( TTL_APPROVAL_DATE )
		//DEF_OBJECT_ID ( TXT_APPROVAL_DATE )
		//DEF_OBJECT_ID ( TTL_APPROVAL_NUM  )
		//DEF_OBJECT_ID ( TXT_APPROVAL_NUM  )
		DEF_OBJECT_ID ( TXT_STATUS  )
		DEF_OBJECT_ID ( CMB_ALLOTMENT_MM  )	// 
		
	END_OBJECT_ID()
	
	#define INIT_MAIN		  		1
	#define INIT_CARDLIST	  		2
	
	#define CARD_READ_EVENT   		5000
	#define CARD_READ_WAIT_TIME		60		//카드 읽기 대기시간(초)

	#define SYH						(CHT+25)
	#define Line(x)	    			(STARTY+SYH*(x-1))
	 
	long m_bFirst;
	long l_Dataflag = 0;
	char m_szScandata[128];
	
	long m_nTimerId = -1;
	long m_nTimerCnt = CARD_READ_WAIT_TIME; //초기값 정해 주자.
	char m_szBuf[32];
	
	bool m_bBtConnected = 0;
	bool m_bCardReading = 0;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void Scan_Data(void);
	
	bool Save_CardInfo(void);
	long Save_DB(void);
	void Load_CardData(void);
	
	void Snd_LastCardInfo(void);
	long Rcv_LastCardInfo(void);
	long Chk_Json_66704(void);
	long SearchStr( char *Str, CodeTable *CT);
	long SearchCD( char *CD, CodeTable *CT);
	
	//dkjung 2017-05-03
	//카드리더 제어
	long CardOpen	(void);
	void CardClose	(void);
	void CardClear	(void);
	void SetStatus  (char* pText);
	void Start_Timer(void);
	void Stop_Timer (void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "카드결제"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_TEXT( STARTX,     Line(1),  175, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_AMT, "결제\n금액"),
		DLG_TEXT( STARTX+175, Line(1),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CARDGASPAY, "가스요금"),
		DLG_TEXT( STARTX+390, Line(1),  610, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARDGASPAY, ""),
		DLG_TEXT( STARTX+175, Line(2),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CARDONCEPAY, "일회성"),
		DLG_TEXT( STARTX+390, Line(2),  610, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARDONCEPAY, ""),
		//DLG_BUTTON(STARTX+520,Line(3)+5, 450, SYH, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDLIST, "거래가능카드사"),

		DLG_TEXT( STARTX,     Line(4)-40,  300, SYH, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TTL_CARD_INFO, ">카드정보"),
		DLG_TEXT( STARTX,     Line(5)-40,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CARD_NUM, "카드번호"),
		DLG_TEXT( STARTX+240, Line(5)-40,  760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_NUM, ""),
		DLG_TEXT( STARTX,     Line(6)-40,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CARD_YM, "유효년월"),
		DLG_TEXT( STARTX+240, Line(6)-40,  190, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_YY, ""),
		DLG_TEXT( STARTX+430, Line(6)-40,  190, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CARD_YY, "년"),
		DLG_TEXT( STARTX+620, Line(6)-40,  190, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_MM, ""),
		DLG_TEXT( STARTX+810, Line(6)-40,  190, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CARD_MM, "월"),
		DLG_TEXT( STARTX,     Line(7)-40,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_ALLOTMENT_MM , "할부개월"),
		DLG_COMBO(STARTX+240, Line(7)-40,  760, SYH*5, 189, SYH, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_ALLOTMENT_MM, 3),
		/*
		DLG_TEXT( STARTX,     Line(8)-10,  400, SYH, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TTL_APPROVAL, ">이전승인정보"),
		DLG_TEXT( STARTX,     Line(9)-10,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_APPROVAL_DATE, "원승인일자"),
		DLG_TEXT( STARTX+300, Line(9)-10,  700, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPROVAL_DATE, ""),
		DLG_TEXT( STARTX,     Line(10)-10, 300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_APPROVAL_NUM, "원승인번호"),
		DLG_TEXT( STARTX+300, Line(10)-10, 700, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPROVAL_NUM, ""),
		*/
		DLG_TEXT( STARTX,     Line(11)+25, 1000, SYH+50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_STATUS, ""),
		
		
		DLG_BUTTON(STARTX,      Line(12)+102,  300, SYH+17, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCAN, "카드읽기"),
		DLG_BUTTON(STARTX+700,  Line(12)+102,  300, SYH+17, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서 명"),
	};	
	
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "카드결제"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_TEXT( STARTX+25,  Line(1),  150, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_TOT_AMT, "결제금액"),
		DLG_TEXT( STARTX+175, Line(1),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CARDGASPAY, "가스요금"),
		DLG_TEXT( STARTX+390, Line(1),  400, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARDGASPAY, ""),
		DLG_TEXT( STARTX+175, Line(2),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CARDONCEPAY, "일회성"),
		DLG_TEXT( STARTX+390, Line(2),  400, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARDONCEPAY, ""),
		//DLG_BUTTON(STARTX+520,Line(3)+5, 450, SYH, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDLIST, "거래가능카드사"),

		DLG_TEXT( STARTX+25,  Line(4),  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TTL_CARD_INFO, ">카드정보"),
		DLG_TEXT( STARTX+25,  Line(5),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CARD_NUM, "카드번호"),
		DLG_TEXT( STARTX+240, Line(5),  730, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_NUM, ""),
		DLG_TEXT( STARTX+25,  Line(6),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CARD_YM, "유효년월"),
		DLG_TEXT( STARTX+240, Line(6),  100, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_YY, ""),
		DLG_TEXT( STARTX+340, Line(6),  100, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CARD_YY, "년"),
		DLG_TEXT( STARTX+440, Line(6),  100, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_MM, ""),
		DLG_TEXT( STARTX+540, Line(6),  100, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CARD_MM, "월"),
		DLG_TEXT( STARTX+25,  Line(7),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_ALLOTMENT_MM , "할부개월"),
		DLG_COMBO(STARTX+240, Line(7),  350, SYH*5, 100, SYH, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_ALLOTMENT_MM, 3),
		/*
		DLG_TEXT( STARTX+25,  Line(8),  400, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TTL_APPROVAL, ">이전승인정보"),
		DLG_TEXT( STARTX+25,  Line(9),  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_APPROVAL_DATE, "원승인일자"),
		DLG_TEXT( STARTX+325, Line(9),  530, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPROVAL_DATE, ""),
		DLG_TEXT( STARTX+25,  Line(10), 300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_APPROVAL_NUM, "원승인번호"),
		DLG_TEXT( STARTX+325, Line(10), 530, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPROVAL_NUM, ""),
		*/
		DLG_TEXT( STARTX+25, Line(11), 945, SYH+50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_STATUS, ""),
		
		
		DLG_BUTTON(STARTX+25,  Line(12)+70,  300, SYH, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCAN, "카드읽기"),
		DLG_BUTTON(STARTX+670,  Line(12)+70,  300, SYH, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서 명"),
	};	

	// 납부방법
	//---------------------------------------------------------------
	DlgObject	DlgRes_CARDLIST[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "거래가능카드사"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_BUTTON( STARTX+730, STARTY+SYH*4, 240, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, "확 인"),
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
	void OnInit(char bFirst)
	{
	long lCnt;	
		m_bFirst = bFirst;
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}
				break;
			case INIT_CARDLIST:
				CREATE_DIALOG_OBJECT (DlgRes_CARDLIST, SIZEOF(DlgRes_CARDLIST));
				break;
		}

		SetBtnImg();
		SetStyle();
		ReDraw();
		
		if( bFirst == INIT_MAIN )
		{
			Scan_Data();
		}
	}

	//----------------------------------------------------------------------
	void OnButton(long ID)
	{	
		switch(ID)
		{
		
			case BID_SCAN:
				//OnUser(CARD_READ_EVENT , 0);
				Scan_Data();
				break;
			case BID_SIGN:
				if( Save_CardInfo() ) 
				{
					PRINT("Card_Move C6101_WSIGN start", 0, 0, 0);
					Card_Move("C6101_WSIGN");
					PRINT("Card_Move C6101_WSIGN end", 0, 0, 0);
				}
				break;
				
			case BID_CARDLIST:
				ON_EXIT();
				OnInit(INIT_CARDLIST);
				break;
				
			case BID_SUBCLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "업무 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6101_MENU");
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
				Card_Move("C6101_WPAY");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			case BID_CLOSE:
				Card_Move("C6101_WPAY");
				break;
		}
	}
	
	//----------------------------------------------------------------------
	void SetBtnImg(void)
	{
	long i;
	char sztmp[10];
	
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			for ( i = 0 ;  CK_CARDMM[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ALLOTMENT_MM+2), CK_CARDMM[i].Str, 0, ICON_NONE);
			}
		}
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}

	//----------------------------------------------------------------------
	void SetStyle(void)

	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TOT_AMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARDGASPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARDGASPAY), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARDONCEPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARDONCEPAY), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD_INFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARD_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD_YM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARD_YY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD_YY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARD_MM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD_MM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_ALLOTMENT_MM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_APPROVAL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_APPROVAL_DATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPROVAL_DATE), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_APPROVAL_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPROVAL_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STATUS), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_CARDLIST )
		{
			
		}
	}
	
	//----------------------------------------------------------------------
	void ReDraw(void)
	{
	char sztmp[128];
	long i, tknlen = 0;
	
		if( m_bFirst == INIT_MAIN )
		{
			if(Str_Len(stCardinfo.szCard_num) == 0)
			{
				//Load_CardData();
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, stMw.szCard_gaspay );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARDGASPAY), sztmp);
			
			if( stMw.szCard_onepay[0] == '2' )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, stMw.szOnce_account );
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARDONCEPAY), sztmp);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARDONCEPAY), "0" );
			}
			
			if( Str_Len( stCardinfo.szCard_num ) > 0 )
			{
				for( i = 0; i < Str_Len( stCardinfo.szCard_num ) ; i++)
				{
					if( stCardinfo.szCard_num[i] == '=' )
					{
						tknlen = i;
						break;
					}
				}
				Mem_Set((byte*)stCardinfo.szValid_ym, 0x00,sizeof(stCardinfo.szValid_ym) );
				Mem_Cpy((byte*)stCardinfo.szValid_ym, (byte*) stCardinfo.szCard_num+tknlen+1, 4 );
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Cpy( (byte*)sztmp, (byte*)stCardinfo.szCard_num,  4 );
			sztmp[4] = '-';
			Mem_Cpy( (byte*)sztmp+5, (byte*)stCardinfo.szCard_num+4,  4 );
			sztmp[9] = '-';
			Mem_Cpy( (byte*)sztmp+10, (byte*)"****",  4 );
			if( tknlen - 13 > 0)
			{
				sztmp[13] = '-';
				Mem_Cpy((byte*)sztmp+14, (byte*) stCardinfo.szCard_num+12, (tknlen-12) );
			}
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARD_NUM), sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Cpy( (byte*)sztmp, (byte*)stCardinfo.szValid_ym, 2);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARD_YY), sztmp);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Cpy( (byte*)sztmp, (byte*)stCardinfo.szValid_ym+2, 2);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARD_MM), sztmp);
			
			if( Str_Len(stCardinfo.szAllotment_mm) == 0 )
				Str_Cpy(stCardinfo.szAllotment_mm, "00");
			
			i = SearchCD( stCardinfo.szAllotment_mm, CK_CARDMM );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), CK_CARDMM[i].Str);
			/*
			if( Str_Len(stCardinfo.szApproval_num) > 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPROVAL_NUM),  stCardinfo.szApproval_num);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPROVAL_DATE), stCardinfo.szReq_ymd);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPROVAL_NUM),  "");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_APPROVAL_DATE), "");
			}
			
			if( l_Dataflag == 0 &&  Str_Len(stCardinfo.szApproval_num) == 0 )
			{
				l_Dataflag = 1;
				Snd_LastCardInfo();
				return;
			}
			*/
			ON_DRAW();
		}
		else if( m_bFirst == INIT_CARDLIST )
		{
			
		}
	}
	
	//----------------------------------------------------------------------
	bool Save_CardInfo(void)
	{
	long i = 0;
	char sztmp[32];
	long totamt = 0;
	
		PRINT("Save_CardInfo start", 0, 0, 0);
		
		if( Str_Len(stCardinfo.szCard_num) == 0)
		{
			MessageBoxEx (ERROR_OK, "카드번호를 정확히 입력하세요.");
			ON_DRAW();
			return FALSE;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_CARD_YY)) == 0 || EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_CARD_MM)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "유효년월을 정확히 입력하세요.");
			ON_DRAW();
			return FALSE;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "할부개월를 정확히 입력하세요.");
			ON_DRAW();
			return FALSE;
		}
		PRINT("Save_CardInfo step 1", 0, 0, 0);
		if( Str_Len(stCardinfo.szApproval_num) == 0 )
		{
			PRINT("Save_CardInfo step 2", 0, 0, 0);
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) );
			i = SearchStr( sztmp, CK_CARDMM );
			if (i > -1)
			{
				Str_Cpy(stCardinfo.szAllotment_mm, CK_CARDMM[i].Code);
			}
			
			Mem_Set( (byte*)stCardinfo.szReq_ymd, 0x00, sizeof(stCardinfo.szReq_ymd) );
			Str_ItoA( Time_GetDate(),  stCardinfo.szReq_ymd  , 10);
			
			Str_Cpy( stCardinfo.szPromise_assign_seq     , stMw.szPromise_assign_seq     );
			Str_Cpy( stCardinfo.szCivil_serv_receive_num , stMw.szCivil_serv_receive_num );
			Str_Cpy( stCardinfo.szTreat_seq              , stMw.szTreat_seq              );
			Str_Cpy( stCardinfo.szUse_cont_num           , stMw.szUse_cont_num           );
			Str_Cpy( stCardinfo.szRecev_seq              , "001"                         );
			
			PRINT("Save_CardInfo step 3", 0, 0, 0);
			if( stMw.szCard_onepay[0] == '2' && Str_AtoI(stMw.szCard_gaspay) > 0 )
			{
				Str_Cpy( stCardinfo.szItem_flag     , "10");
				totamt = Str_AtoI(stMw.szCard_gaspay) + Str_AtoI(stMw.szOnce_account);
				
				//아래의 테스트 코드 적용시 주석 처리 할 부분
				Str_Cpy( stCardinfo.szTerminal_num  , stUserinfo.szcard_term_id1);
			}
			else if (stMw.szCard_onepay[0] == '2' && Str_AtoI(stMw.szCard_gaspay) <= 0 )
			{
				Str_Cpy( stCardinfo.szItem_flag     , "20");
				totamt = Str_AtoI(stMw.szOnce_account);
				
				//아래의 테스트 코드 적용시 주석 처리 할 부분
				Str_Cpy( stCardinfo.szTerminal_num  , stUserinfo.szcard_term_id2);
			}
			else if( Str_AtoI(stMw.szCard_gaspay) > 0 )
			{
				Str_Cpy( stCardinfo.szItem_flag     , "10");
				totamt = Str_AtoI(stMw.szCard_gaspay);
				
				//아래의 테스트 코드 적용시 주석 처리 할 부분
				Str_Cpy( stCardinfo.szTerminal_num  , stUserinfo.szcard_term_id1);
			}
			else
			{
				totamt = 0;
				Str_Cpy( stCardinfo.szItem_flag    , "20");
				
				//아래의 테스트 코드 적용시 주석 처리 할 부분
				Str_Cpy( stCardinfo.szTerminal_num , stUserinfo.szcard_term_id2);
			}
			
			//카드결제 테스트 단말기 번호
			//Str_Cpy( stCardinfo.szTerminal_num         ,  "DPT0TEST03"    );

			Str_Cpy( stCardinfo.szData_flag            , "10" );
			Str_ItoA( totamt, stCardinfo.szApproval_amt, 10   );
		}
		PRINT("Save_CardInfo step 4", 0, 0, 0);
		if (Save_DB() == 0)
		{
			PRINT("Save_CardInfo ok end", 0, 0, 0);
			return TRUE;
		}
		else
		{
			PRINT("Save_CardInfo fail end", 0, 0, 0);
			return FALSE;
		}
		
	}
	
	//----------------------------------------------------------------------
	long Save_DB(void)
	{
	long Cnt, idx, rtn = -1;
	char szSql[300];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
		
		PRINT("Save_DB start", 0, 0, 0);
		Cnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT count(*) FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' ",g_szCHK_EXEC_NUM, 0,0   );
		g_Sql_RetInt(szSql, &Cnt );
		
		PRINT("Save_DB step 1", 0, 0, 0);
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( Cnt > 0 )
		{
			PRINT("Save_DB step 2", 0, 0, 0);
			hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_CARD SET \
REQ_YMD=? ,RECEV_SEQ=? ,TERMINAL_NUM=? ,CARD_NUM=? ,VALID_YM=?, ALLOTMENT_MM=?, DATA_FLAG=?, \
ITEM_FLAG = ?, APPROVAL_AMT = ? \
WHERE PROMISE_ASSIGN_SEQ = ? " );
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szReq_ymd       ,8  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szRecev_seq     ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTerminal_num  ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_num      ,128,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szValid_ym      ,4  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szAllotment_mm  ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szData_flag     ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szItem_flag     ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_amt  ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM           ,10 ,DECRYPT);
		}
		else
		{
			PRINT("Save_DB step 3", 0, 0, 0);
			hstmt = sql->CreateStatement(sql, "INSERT INTO C6101_PROMISE_CARD ( \
PROMISE_ASSIGN_SEQ, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, USE_CONT_NUM, ITEM_FLAG \
,REQ_YMD ,RECEV_SEQ, TERMINAL_NUM, CARD_NUM, VALID_YM, ALLOTMENT_MM, APPROVAL_AMT, DATA_FLAG \
) VALUES ( ?,?,?,?,?, ?,?,?,?,? ,?,?,? ) " );

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM                     ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCivil_serv_receive_num  ,14 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTreat_seq               ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szUse_cont_num            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szItem_flag               ,2  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szReq_ymd                 ,8  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szRecev_seq               ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTerminal_num            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_num                ,128,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szValid_ym                ,4  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szAllotment_mm            ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_amt            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szData_flag               ,2  ,DECRYPT);
			
		}
		PRINT("Save_DB step 4", 0, 0, 0);
		if(hstmt == NULL)
		{
			PRINT("Save_DB SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			PRINT("Save_DB PROMISE_ASSIGN_SEQ:[%s] , USE_CONT_NUM:[%s] , ITEM_FLAG:[%s]", g_szCHK_EXEC_NUM, stCardinfo.szUse_cont_num, stCardinfo.szItem_flag);
			PRINT("Save_DB REQ_YMD:[%s] , RECEV_SEQ:[%s] ", stCardinfo.szReq_ymd, stCardinfo.szRecev_seq, 0);
			MessageBoxEx (ERROR_OK, "카드결제정보 저장에 실패했습니다.");
			goto Finally;
		}
		else
		{
			PRINT("Save_DB step 4-1", 0, 0, 0);
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s], 카드결제정보 저장실패", sql->GetLastError(sql), 0, 0);
				PRINT("Save_DB PROMISE_ASSIGN_SEQ:[%s] , USE_CONT_NUM:[%s] , ITEM_FLAG:[%s]", g_szCHK_EXEC_NUM, stCardinfo.szUse_cont_num, stCardinfo.szItem_flag);
				PRINT("Save_DB REQ_YMD:[%s] , RECEV_SEQ:[%s] ", stCardinfo.szReq_ymd, stCardinfo.szRecev_seq, 0);
				MessageBoxEx (ERROR_OK, "카드결제정보 저장에 실패했습니다.");
				goto Finally;
			}
		}
		rtn = 0;
		PRINT("Save_DB step 5", 0, 0, 0);
Finally	:
		//sql->Commit(sql);
		DelSqLite(sql);
		PRINT("Save_DB end", 0, 0, 0);
		
		return rtn;
	}
	
	//----------------------------------------------------------------------
	void Snd_LastCardInfo(void)
	{
	char sztmp[128];
	char szUrl[200];
	char szbuf[128];
	char szMsg[351];
	char szUMsg[701];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szUMsg, 0x00, sizeof(szUMsg) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66704, TRUE);

		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq", stMw.szPromise_assign_seq );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_LastCardInfo; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR66704_IN",  "FR66704" , sndbuf, szbuf );
	}

	//----------------------------------------------------------------------
	long Rcv_LastCardInfo(void)
	{
	long ret= -1;
		
		g_Sock_Close();
		
		//2017-05-04 Sanghyun Lee
		//progress가 실행되면서 timer가 돌아가는데, 그것으로 인해 on_timer쪽이 동작됨		
		//Timer_Kill( m_nTimerId );
		//m_nTimerId = 0;
			
		if( Chk_Json_66704() >= 0)
		{
			ON_DRAW();
			return 1;
		}
		else
		{
			MessageBoxEx (ERROR_OK, "카드조회에 실패했습니다.");
			ON_DRAW();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------
	long Chk_Json_66704(void)
	{
	char szJsonpath[500];
	char szMsg[500];
	long fd, i, tot;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	long* ncol;
	long nCnt;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
	handle* sql;
	char * sqlstr = "";
			
		MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 66704, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 66704, 0 );
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
				EvtDraw();
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
							tot = JSON_GetArrayCount( hitem );
							if( tot > 0)
							{
								i = 0;
								
								szcode = (char*)JSON_GetArrayItem ( hitem, i, "approval_cancel_num", szType);
								Str_Cpy( stCardinfo.szApproval_cancel_num, szcode );
								if( Str_Len(stCardinfo.szApproval_cancel_num) == 0 )
								{
									//szcode = (char*)JSON_GetArrayItem ( hitem, i, "promise_assign_seq", szType);
									//Str_Cpy( stCardinfo.szPromise_assign_seq, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "rslt_cd", szType);
									Str_Cpy( stCardinfo.szRslt_cd, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "terminal_num", szType);
									Str_Cpy( stCardinfo.szTerminal_num, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "card_com", szType);
									Str_Cpy( stCardinfo.szCard_com, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "card_type_nm", szType);
									Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
									SQL_ConvMbStr( szMsg, szcode);
									Str_Cpy( stCardinfo.szCard_type_nm, szMsg );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "buying_comp", szType);
									Str_Cpy( stCardinfo.szBuying_comp, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "buying_comp_nm", szType);
									Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
									SQL_ConvMbStr( szMsg, szcode);
									Str_Cpy( stCardinfo.szBuying_comp_nm, szMsg );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "allotment_mm", szType);
									Str_Cpy( stCardinfo.szAllotment_mm, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "card_num", szType);
									Str_Cpy( stCardinfo.szCard_num, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "valid_ym", szType);
									Str_Cpy( stCardinfo.szValid_ym, szcode );
									
									ncol = (long*)JSON_GetArrayItem ( hitem, i, "approval_amt", szType);
									nCnt = *ncol;
									//PRINT("szApproval_amt = [%d]",nCnt,0,0);
									Str_ItoA( nCnt, stCardinfo.szApproval_amt, 10 );
									
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "approval_num", szType);
									Str_Cpy( stCardinfo.szApproval_num, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "approval_date", szType);
									Str_Cpy( stCardinfo.szApproval_time, szcode );
									
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "approval_cancel_date", szType);
									Str_Cpy( stCardinfo.szApproval_cancel_date, szcode );
								}
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
		ON_DRAW();
		return ret;
	}
	
	
	//----------------------------------------------------------------------
	void CardClear(void)
	{
		m_bCardReading = 0;
		
		CardReader_StopEvent();
		
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_SCAN), "카드읽기");
	}
	
	//----------------------------------------------------------------------
	long CardOpen(void)
	{
		if (m_bCardReading == 1)
			return 0;

		CardClear();
				
		if (m_bBtConnected == 0)
		{
			CardReader_Open( g_szPrintPort );
			m_bBtConnected = 1;
			
			//여긴 내부적으로 블루투스 연결 이벤트를 콜백해서
			//CardReader_StartEvent가 호출됨.
			if (g_IsCardReader())
			{
				CardReader_StartEvent( CARD_READ_EVENT );
			}
			
		}
		else
		{
			CardReader_StartEvent( CARD_READ_EVENT );
		}
		
		m_bCardReading = 1;
		
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_SCAN), "카드 대기중");
		
		return 1;
	}
	
	//----------------------------------------------------------------------
	void CardClose (void)
	{
		CardReader_Close();	
		m_bBtConnected = 0;
		//M( 카드 종료... );
	}
	
	//----------------------------------------------------------------------
	void SetStatus (char* pText)
	{
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), pText);
	}
	
	//----------------------------------------------------------------------
	void Start_Timer(void)
	{
		//타이머 초기화
		
		if(m_nTimerId == -1)
		{
			m_nTimerCnt = CARD_READ_WAIT_TIME;
			m_nTimerId = Timer_Set( 1000, 0 );
		}
		
		
		SetStatus( "카드 읽기 준비 중 입니다." );
		
		M( Start_Timer... );
	}

	//----------------------------------------------------------------------
	void Stop_Timer(void)
	{
		//M( Stop_Timer... );
		
		if(m_nTimerCnt == 0)
		{
			Timer_Kill( m_nTimerId );
			m_nTimerId = -1;
			
			CardClear();
			//카드읽기 실패는 블루투스 연결실패로 본다.
			CardClose();
			
			if( m_bFirst == INIT_MAIN )
			{
				SetStatus( "타임아웃: 카드 읽기를 실패했습니다.\n재 시도 바랍니다." );
				Mem_Set((byte*)m_szScandata, 0x00, sizeof(m_szScandata));
				Mem_Set((byte*)stCardinfo.szCard_num, 0x00, sizeof(stCardinfo.szCard_num));
				Mem_Set((byte*)stCardinfo.szValid_ym, 0x00, sizeof(stCardinfo.szValid_ym));
				ReDraw();
			}

			return;
		}
		
		Str_Printf(m_szBuf, "%d초 이내에 카드를 스캔하세요.", m_nTimerCnt,0,0);
		SetStatus( m_szBuf );
		
		m_nTimerCnt--;
		
		ON_DRAW();
	}
	
	//----------------------------------------------------------------------
	void OnTimer (long nTimerID)
	{
		if(m_nTimerId == nTimerID)
		{
			Stop_Timer();
		}
	}
	
	//----------------------------------------------------------------------
	void OnExit(void)
	{
		if(m_nTimerId != -1)
		{
			Timer_Kill( m_nTimerId);
			m_nTimerId = -1;
		}
		CardClear();
		CardClose();
	}
	
	//----------------------------------------------------------------------
	void Scan_Data(void)
	{
		long nRet = 0;
		
		nRet = CardOpen();
		
		if (nRet == 0)
		{
			return;
		}

		Mem_Set((byte*)m_szScandata, 0x00, sizeof(m_szScandata));
		Mem_Set((byte*)stCardinfo.szCard_num, 0x00, sizeof(stCardinfo.szCard_num));
		Mem_Set((byte*)stCardinfo.szValid_ym, 0x00, sizeof(stCardinfo.szValid_ym));
		ReDraw();
		
		//2017-08-08 Sanghyun Lee
		//이벤트(Uart) 받아서 처리하도록 수정
		//VM 업그레이드 진행 후 적용 예정
		//SetStatus( "블루투스 연결중입니다." );
		Start_Timer();
	}
	
	//----------------------------------------------------------------------
	void OnUart(long nEvent, long nData)
	{

		switch( nEvent )
		{
			case UART_PRINTER:
				CardReader_StartEvent( CARD_READ_EVENT );
				SetStatus( "카드를 리드해 주세요." );
/*
				//2017-08-09 Sanghyun Lee
				//블루투스 연결 성공/실패 구분하여 동작하도록 수정
				//VM 업그레이드 진행 후 적용 예정
				if( nData > 0 )
				{
					Start_Timer();

					CardReader_StartEvent( CARD_READ_EVENT );
					SetStatus( "카드를 리드해 주세요." );
				}
				else
				{
					m_nTimerCnt = 0;
					Timer_Kill( m_nTimerId );
					m_nTimerId = -1;
					
					CardClear();
					//카드읽기 실패는 블루투스 연결실패로 본다.
					CardClose();
					
					if( m_bFirst == INIT_MAIN )
					{
						SetStatus( "블루투스 연결에 실패하였습니다.\n재 시도 바랍니다." );
						Mem_Set((byte*)m_szScandata, 0x00, sizeof(m_szScandata));
						Mem_Set((byte*)stCardinfo.szCard_num, 0x00, sizeof(stCardinfo.szCard_num));
						Mem_Set((byte*)stCardinfo.szValid_ym, 0x00, sizeof(stCardinfo.szValid_ym));
						ReDraw();
					}
				}
*/
			
				ON_DRAW();
				break;
		}
	}
	
	//----------------------------------------------------------------------
	void OnUser(long nEvent, long nData)
	{
	long nTrack =2;
	char sztmp[30];
	long i=0, tknlen = 0;
	long len = 0;
	
		if(nEvent == CARD_READ_EVENT )
		{	
			Timer_Kill( m_nTimerId );
			m_nTimerId = -1;
			
			
			if (g_IsCardReader())
			{
				//PM80일 경우
				if (nData > 0)
				{
					long nRet = 0;
					
					//에러 상태
					char* ptr = (char*)System_GetResult((char*)&nRet);
					
					SetStatus( ptr );

					ButCtrl_SetText(Get_hDlgCtrlByID(BID_SCAN), "카드읽기");
					ON_DRAW();
					
					CardClear();
					return;
				}
			}
			
			Mem_Set((byte*)m_szScandata, 0x00, sizeof(m_szScandata));
			CardReader_ReadRawData( nTrack, m_szScandata, sizeof(m_szScandata) );
			
			//Str_Cpy(m_szScandata , "9411818005189427=19022013976702700089" );//일반+요금만
			//Str_Cpy(m_szScandata , "9411818005189427=19022013976702209889" );//일반+일회성포함.
			//Str_Cpy(m_szScandata , "4140030398601914=19102013976702209889" );//법인

			CardClear();
			
			if( m_bFirst == INIT_MAIN )
			{
				SetStatus( "스캔 완료." );
				ON_DRAW();
			}
			//PRINT("m_szScandata :%s, length:%d",m_szScandata,Str_Len(m_szScandata),0);
			
			if( Str_Len( m_szScandata ) > 0)
			{
				//연결철거비용(일회성요금-고객센터입금액)은 제휴카드로만 결제가능.
				len = Str_Len(m_szScandata);
				if( Str_NCmp( m_szScandata+(len-6), "2098", 4) != 0)
				{
					if( stMw.szCard_onepay[0] == '2' && Str_AtoI(stMw.szOnce_account) > 0 )
					{
						Mem_Set((byte*)m_szScandata, 0x00, sizeof(m_szScandata));
						MessageBoxEx (ERROR_OK, "서울가스 제휴카드가 아닙니다. 다시 읽어 주세요.");
						Scan_Data();
						return;
					}
				}

				for( i = 0; i < Str_Len( m_szScandata ) ; i++)
				{
					if( m_szScandata[i] == '=' )
					{
						tknlen = i;
						break;
					}
				}
				Mem_Set((byte*)stCardinfo.szCard_num, 0x00,sizeof(stCardinfo.szCard_num) );
				Str_Cpy( stCardinfo.szCard_num, m_szScandata );
				
				if( tknlen - 13 > 0)
				{
					Mem_Set((byte*)sztmp, 0x00,sizeof(sztmp) );
					Mem_Cpy((byte*)sztmp, (byte*) m_szScandata+12, (tknlen -12) );
				}
				
				Mem_Set((byte*)stCardinfo.szValid_ym, 0x00,sizeof(stCardinfo.szValid_ym) );
				Mem_Cpy((byte*)stCardinfo.szValid_ym, (byte*) m_szScandata+tknlen+1, 4 );
				
				
				if( m_bFirst == INIT_MAIN )
					ReDraw();
					
				ON_DRAW();
			}
		}
	}
	
	//----------------------------------------------------------------------
	//함수명 : SearchStr
	//기  능 : 스트링으로 코드인덱스를 찾는다.
	//Param  : 
	//Return : 코드인덱스, 없으면 -1
	//----------------------------------------------------------------------
	long SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	//----------------------------------------------------------------------
	//함수명 : SearchCD
	//기  능 : 코드값으로 코드인덱스를 찾는다.
	//Param  : 
	//Return : 코드인덱스, 없으면 -1
	//----------------------------------------------------------------------
	long SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
				return i;
		}
		return -1;
	}
	
	//----------------------------------------------------------------------
	void Load_CardData(void)
	{
	long i;
	char sztmp[10];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PROMISE_ASSIGN_SEQ,USE_CONT_NUM,ITEM_FLAG,REQ_YMD,RECEV_SEQ \
,DATA_FLAG,RSLT_CD,TERMINAL_GBN,TERMINAL_NUM,CARD_NUM \
,VALID_YM,CARD_COM,CARD_TYPE_NM,BUYING_COMP,BUYING_COMP_NM \
,APPROVAL_AMT,APPROVAL_NUM,ALLOTMENT_MM,APPROVAL_TIME \
,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ \
FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szItem_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szReq_ymd               ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRecev_seq             ,3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szData_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRslt_cd               ,1  +1, DECRYPT );
			Mem_Set((byte*)sztmp, 0x00,sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp                              ,2    , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTerminal_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_num              ,128+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szValid_ym              ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_com              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_type_nm          ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp_nm        ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_amt          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_num          ,12 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szAllotment_mm          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_time         ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTreat_seq             ,10 +1, DECRYPT );
		}
Finally:

		DelSqLite(sql);
		return;
	}

}



