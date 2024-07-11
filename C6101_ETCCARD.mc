/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_ETCCARD
	Card Desc : 민원 기타 카드 결제
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_ETCCARD
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

	#define USE_ON_TASK
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_APPRO )		// 카드승인/취소
		DEF_BUTTON_ID ( BID_CLOSE )				// 닫기
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// 카드내에서 사용될 콘트롤 아이디 정의
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* 타이틀        			    */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )				// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )			// 타이틀
		
		/********************************/
		/* 화면          			    */
		/********************************/
		DEF_OBJECT_ID ( ST_AMT )				// ST_결제금액
		DEF_OBJECT_ID ( ST_ALLOTMENT_MM  )      // ST_할부
		DEF_OBJECT_ID ( ST_APPRO_RSLT )			// ST 승인결과
		DEF_OBJECT_ID ( TXT_APPRO_RSLT )		// TXT 승인결과
		DEF_OBJECT_ID ( ST_APPRO_TIME )			// ST 승인시간
		DEF_OBJECT_ID ( TXT_APPRO_TIME )		// TXT 승인시간
		DEF_OBJECT_ID ( ST_APPRO_NUM )			// ST 승인번호
		DEF_OBJECT_ID ( TXT_APPRO_NUM )			// TXT 승인번호
		
		/********************************/
		/* 공통                         */
		/********************************/
		// 포인팅 자판
		DEF_OBJECT_ID ( TXT_KEY_ONE )			// 1
		DEF_OBJECT_ID ( TXT_KEY_TWO )			// 2
		DEF_OBJECT_ID ( TXT_KEY_THREE )			// 3 
		DEF_OBJECT_ID ( TXT_KEY_FOUR )			// 4
		DEF_OBJECT_ID ( TXT_KEY_FIVE )			// 5
		DEF_OBJECT_ID ( TXT_KEY_SIX )			// 6
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )			// 7
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )			// 8
		DEF_OBJECT_ID ( TXT_KEY_NINE )			// 9
		DEF_OBJECT_ID ( TXT_KEY_ZERO )			// 0
		DEF_OBJECT_ID ( TXT_KEY_DEL )			// <-
		DEF_OBJECT_ID ( TXT_KEY_EMPTY )			// 빈칸
		
		/********************************/
		/* LINE                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA1 )			// 라인1
		DEF_OBJECT_ID ( LINE_DATA2 )			// 라인2
		DEF_OBJECT_ID ( LINE_DATA3 )			// 라인3
		
		/********************************/
		/* EDIT                         */
		/********************************/
		DEF_OBJECT_ID ( EDT_AMT )				// EDT_결제금액
		
		/********************************/
		/* COMBO                        */
		/********************************/
		DEF_OBJECT_ID ( CMB_ALLOTMENT_MM  )     // CMB_할부콤보
		
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// 기본정의 DLG화면 정의
	//---------------------------------------------------------------
	
	#define INIT_MAIN		1
	
	long m_lAmt = 0;
	char m_sAllotment_mm[3];
	char m_sApproval_Num[50];
	
	void SetBtnImg(void);
	void SetCombo(void);
	void SetStyle(void);
	void setData(void);
	
	void Snd_CardHist_Pre(void);
	void Snd_CardHist_Rslt(void);
	
	void Rcv_Mcpay(void);
	long TR66707(void);
	long TR66708(void);

	void Run_Mcpay(void);
	void Rcv_CardData(char* szCardData);
	
	void Rcv_CardData_Test(void);
	void Set_Cmd_Allotment(void);
	
	bool setValidation(void);
	
	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "기타 카드 결제"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_TEXT ( STARTX,	    STARTY  -29,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_AMT, "결제금액"),
		DLG_EDIT ( STARTX +300, STARTY  -29,  700, 70, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_AMT, 30,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  +41,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_ALLOTMENT_MM , "할부개월"),
		DLG_COMBO( STARTX +300, STARTY  +41,  700, 70, 180, 70, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_ALLOTMENT_MM, 3),
		
		DLG_LINE ( STARTX,      STARTY +115, 1000, STARTY+115,  DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT ( STARTX,	    STARTY +120,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_APPRO_RSLT, "승인결과"),
		DLG_TEXT ( STARTX +300, STARTY +120,  700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPRO_RSLT, ""),
		DLG_TEXT ( STARTX,	    STARTY +190,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_APPRO_TIME, "승인시간"),
		DLG_TEXT ( STARTX +300, STARTY +190,  700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPRO_TIME, ""),
		DLG_TEXT ( STARTX,	    STARTY +260,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_APPRO_NUM, "승인번호"),
		DLG_TEXT ( STARTX +300, STARTY +260,  700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPRO_NUM, ""),
		
		DLG_LINE ( STARTX,      STARTY +334, 1000, STARTY+334,  DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_BUTTON(STARTX,      STARTY +339,  500, 75, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_APPRO,  "승인"),
		DLG_BUTTON(STARTX +500, STARTY +339,  500, 75, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "뒤로가기"),
		
		//숫자 자판
		DLG_LINE(STARTX, STARTY +535, 1000, STARTY+535, DARKSLATEBLUE, 10, LINE_DATA3),
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY, ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "←"),
	};

	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : OnInit
	기  능 : 최초 시작
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit(char bFirst)
	{
		CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
		SetBtnImg();
		SetStyle();
		SetCombo();
		setData();
	}
	
	/*=======================================================================================
	함수명 : OnTask
	기  능 : 외부 앱 연동
	Param  : 
	Return : 
	========================================================================================*/ 
	void OnTask(long nEvent, long nData)
	{
		char* szCardData;
		long nRet = 0;
	
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_IC_CARD )
			{
				//시스템콜
				szCardData = (char*)System_GetResult((char*)&nRet);
				
				//결과 저장
				Rcv_CardData(szCardData);
			}
		}
	}
	
	/*=======================================================================================
	함수명 : OnPointing
	기  능 : 화면 포인팅 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
			
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{	
			if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) )
			{	
				if( Get_iDlgCtrlByID(EDT_AMT) == lActiveIndex )
				{
					g_Dlgflag = 0;
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA3), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
				}
			}
			else
			{	
				if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '1' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '2' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '3' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '4' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '5' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '6' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '7' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '8' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '9' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_CHAR( '0' );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
				{
					if ( g_Dlgflag == 0 )
					{
						ON_KEY( 5 );
						VM_PlaySound(CLICKSOUND);
						Set_Cmd_Allotment();
					}
				}
				else
				{	
					g_Dlgflag = 1;
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA3), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
				}
			}
		}	
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{
		switch(ID)
		{
			// 뒤로가기
			case BID_CLOSE:
				
				Card_Move("C6101_PayMenu");
				break;
			
			// 승인
			case BID_APPRO:
				
				if( setValidation() )
				{
					Snd_CardHist_Pre();
				}
				
				break;
		}
	}
	
	//---------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	함수명 : SetCombo
	기  능 : 콤보박스 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i = 0;
		
		// 할부콤보 세팅
		for ( i = 0 ;  CK_CARDMM[i].Str[0] != 0 ; i++)
		{	
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ALLOTMENT_MM+2), CK_CARDMM[i].Str, 0, ICON_NONE);
		}
		
	}

	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER, COMBOBOX UI SETTING
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		long i;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AMT)          , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_ALLOTMENT_MM) , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_APPRO_RSLT)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPRO_RSLT)  , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_APPRO_TIME)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPRO_TIME)  , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_APPRO_NUM)    , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPRO_NUM)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), g_szOne_ApproRslt);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_APPRO_RSLT), TRUE, 3, EDITSEP_NONE );
		
		// 숫자판
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA3)   , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
		
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), FALSE );
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
	}
	
	/*=======================================================================================
	함수명 : setData
	기  능 : 첫 화면 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void setData(void)
	{
		long i;
		char szSql[200];
		char szTmp[100];
		
		Mem_Set((byte*)&stEtcCardinfo, 0x00, sizeof(stEtcCardinfo));
		
		g_Dlgflag = 0; // 자판 FLAG 
		
		// 할부 콤보박스
		i = g_SearchCD( "00", CK_CARDMM );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), CK_CARDMM[i].Str);
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : Snd_CardHist_Pre
	기  능 : 이력 테이블에 시도건 등록
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_CardHist_Pre(void)
	{
		char szTmp[500];
		char szUrl[300];
		char szbuf[300];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		long i = 0;
		char szUcovert[100];
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		
		g_SeverConnection();
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66707, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd" , stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "item_flag" , "10" );
		JSON_SetValue( g_pjcomm, 'C', "prcss_status", "0" );
		JSON_SetValue( g_pjcomm, 'C', "terminal_num", stUserinfo.szcard_term_id2 );
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) );
		i = g_SearchStr( szTmp, CK_CARDMM );
		
		if( i > -1 )
		{
			JSON_SetValue( g_pjcomm, 'C', "allotment_mm", CK_CARDMM[i].Code	);
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "allotment_mm", "00" );	
		}
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AMT)) );
	
		JSON_SetValue( g_pjcomm, 'C', "approval_amt", szTmp );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR66707;
		
		HTTP_DownloadData( szUrl, "FR66707_IN",  "FR66707" , sndbuf, szbuf );
	}
	
	
	/*=======================================================================================
	함수명 : TR66707
	기  능 : 카드 승인 전 hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR66707(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(66707) >= 0)
		{	
			Run_Mcpay();	
			//Rcv_CardData_Test();
			return 1;
		}
		else
		{
			ON_DRAW();	
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_CardHist_Rslt
	기  능 : 이력 테이블에 결과 등록
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_CardHist_Rslt(void)
	{
		char szTmp[300];
		char szUrl[300];
		char szbuf[300];
		char szUcovert[300];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		
		g_SeverConnection();
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66708, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd" 				, stUserinfo.szcenter_cd 		);
		JSON_SetValue( g_pjcomm, 'C', "item_flag"			   	, "10"			                );
		JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   	, "1"     						);	
		JSON_SetValue( g_pjcomm, 'C', "rslt_cd"			       	, "O"			   				);
		JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   	, stEtcCardinfo.szTerminal_num 	);
		JSON_SetValue( g_pjcomm, 'C', "allotment_mm"		   	, stEtcCardinfo.szAllotment_mm	);
		JSON_SetValue( g_pjcomm, 'C', "card_num"		       	, stEtcCardinfo.szCard_num		);
		JSON_SetValue( g_pjcomm, 'C', "valid_ym"			   	, stEtcCardinfo.szValid_ym		);
		JSON_SetValue( g_pjcomm, 'C', "approval_amt"		    , stEtcCardinfo.szApproval_amt	);
		JSON_SetValue( g_pjcomm, 'C', "approval_num"		   	, stEtcCardinfo.szApproval_num	);
		JSON_SetValue( g_pjcomm, 'C', "approval_time"		   	, stEtcCardinfo.szApproval_time	);
		
		JSON_SetValue( g_pjcomm, 'C', "card_com"		       	, stEtcCardinfo.szCard_com		);
		
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		SQL_ConvUcStr( szTmp, stEtcCardinfo.szCard_type_nm );
		JSON_SetValue( g_pjcomm, 'C', "card_type_nm"		   	, szTmp		   					);
		
		JSON_SetValue( g_pjcomm, 'C', "buying_comp"		       	, stEtcCardinfo.szBuying_comp	);
		
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		SQL_ConvUcStr( szTmp, stEtcCardinfo.szBuying_comp_nm );
		JSON_SetValue( g_pjcomm, 'C', "buying_comp_nm"		   	, szTmp		   					);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR66708;
		
		HTTP_DownloadData( szUrl, "FR66708_IN",  "FR66708" , sndbuf, szbuf );
	}
	
	
	/*=======================================================================================
	함수명 : TR66708
	기  능 : 카드 승인
	Param  : 
	Return : 
	========================================================================================*/
	long TR66708(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(66708) >= 0)
		{
			//Card_Move("C6101_PayMenu");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "승인 성공");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_TIME), stEtcCardinfo.szApproval_time);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_NUM), stEtcCardinfo.szApproval_num);
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_AMT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_AMT), TRUE );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_APPRO), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_APPRO), FALSE );
			
			ON_DRAW();
			return 1;
		}
		else
		{	
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Run_Mcpay
	기  능 : Run_Mcpay 활성화
	Param  : 
	Return : 
	========================================================================================*/
	void Run_Mcpay(void)
	{
		long ret = 0;
		long i = 0;
		char szSql[300];
		char szTmp[300];
		char receipt_YN[10];
		handle h = NULL;
		handle hdata = NULL;
		
		// 영수증 발급문의
		Mem_Set( (byte*)receipt_YN, 0x00, sizeof(receipt_YN) );
		
		if( MessageBoxEx (CONFIRM_YESNO, "카드 결제 간이영수증을\n발행하시겠습니까?")  == MB_OK)
		{						
			Str_Cpy(receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(receipt_YN, "N");		
		}
		
		h = JSON_Create( JSON_Object );
		
		if( h )
		{
			hdata = JSON_Create( JSON_Object );
			
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hdata	, 'C', "receiptyn"			, receipt_YN);
			JSON_SetValue	(hdata	, 'C', "call"				, "creditAppr");
			JSON_SetValue	(hdata	, 'C', "desc"				, "신용결제");
			JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
			JSON_SetValue	(hdata	, 'C', "type"				, "");

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AMT)) );
			
			JSON_SetValue	(hdata	, 'C', "totalprice"			, szTmp);
			
			JSON_SetValue	(hdata	, 'C', "tax"				, "0");
			JSON_SetValue	(hdata	, 'C', "svc"				, "0");

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) );
			i = g_SearchStr( szTmp, CK_CARDMM );
			
			if (i > -1)
			{
				JSON_SetValue	(hdata	, 'C', "inst"		    , CK_CARDMM[i].Code);
				
				Mem_Set((byte*)m_sAllotment_mm, 0x00, sizeof(m_sAllotment_mm));
				Str_Cpy(m_sAllotment_mm, CK_CARDMM[i].Code);
			}
			
			JSON_SetValue	(hdata	, 'C', "printdata"			, "");
			JSON_SetValue	(hdata	, 'C', "approvaldate"		, "");
			JSON_SetValue	(hdata	, 'C', "approvalno"			, "");
			JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
			JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
			JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
			JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
			JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id2);
			
			JSON_SetValue	(h		, 'C', "method"				, "IC_CardPay");
			JSON_Attach 	(h		, "data"					, hdata);
			
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hdata)
		{
			JSON_Finalize(hdata);
		}
		
		return;
	
	}
	
	/*=======================================================================================
	함수명 : Rcv_CardData
	기  능 : MCPAY RETRUN
	Param  : 
	Return : 
	========================================================================================*/ 
	void Rcv_CardData(char* szCardData)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lRet = 0;
		long lCnt = 0;
		char *szitem;
		char *szData;
		long *nCol;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 0;
		handle hItem = NULL;
		handle hData = NULL;
		
		long hist_rslt = 0;
		
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCardData ) ;

			Mem_Set((byte*)&stEtcCardinfo, 0x00, sizeof(stEtcCardinfo));
			
			// 성공
			if( Str_Cmp(JSON_GetValue (hItem, "resultcode",  		szType) , "null") == 0 )
			{
				Str_Cpy( stEtcCardinfo.szTerminal_num  		     , JSON_GetValue (hItem, "tid",   	szType) );
				Str_Cpy( stEtcCardinfo.szApproval_amt 			 , JSON_GetValue (hItem, "totalamount",    		szType) );
				
				// 할부
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) );
				
				i = g_SearchStr( szTmp, CK_CARDMM );
				
				if (i > -1)
				{
					Str_Cpy(stEtcCardinfo.szAllotment_mm, CK_CARDMM[i].Code);
				}
				
				Str_Cpy( stEtcCardinfo.szCard_num				 , JSON_GetValue (hItem, "cardno",    		szType) );
				Str_Cpy( stEtcCardinfo.szCard_type_nm			 , JSON_GetValue (hItem, "cardname",    	szType) );
				Str_Cpy( stEtcCardinfo.szValid_ym				 , "0000" 						 );
				Str_Cpy( stEtcCardinfo.szItem_flag 			 	 , "10" );
				Str_Cpy( stEtcCardinfo.szApproval_num			 , JSON_GetValue (hItem, "approvalno",    		szType) );
				Str_Cpy( stEtcCardinfo.szApproval_time			 , JSON_GetValue (hItem, "approvaldate",    	szType) );	
				Str_Cpy( stEtcCardinfo.szCard_com				 , JSON_GetValue (hItem, "code2",    	szType) 						 );	
				Str_Cpy( stEtcCardinfo.szBuying_comp			 , JSON_GetValue (hItem, "code1",    	szType)							 );
				Str_Cpy( stEtcCardinfo.szBuying_comp_nm		     , JSON_GetValue (hItem, "purchasename",    	szType) );
				
				hist_rslt = 1;
			}
			else
			{
				hist_rslt = 0;
				Card_Move("C6101_PayMenu");
			}
		}
	
		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
	
		g_Close_SubDlg();
		
		if( hist_rslt == 1 )
		{
			Snd_CardHist_Rslt();	
		}
		else
		{
			Card_Move("C6101_PayMenu");
		}
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Rcv_CardData_Test
	기  능 : MCPAY Test
	Param  : 
	Return : 
	========================================================================================*/ 
	void Rcv_CardData_Test(void)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lRet = 0;
		long lCnt = 0;
		char *szitem;
		char *szData;
		long *nCol;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 0;
		handle hItem = NULL;
		handle hData = NULL;
		
		long hist_rslt = 0;
			
		Mem_Set((byte*)&stEtcCardinfo, 0x00, sizeof(stEtcCardinfo));
			
		Str_Cpy( stEtcCardinfo.szTerminal_num, stUserinfo.szcard_term_id2 );
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AMT)) );
		Str_Cpy( stEtcCardinfo.szApproval_amt 			 , szTmp );
		
		// 할부
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) );
		
		i = g_SearchStr( szTmp, CK_CARDMM );
		
		if (i > -1)
		{
			Str_Cpy(stEtcCardinfo.szAllotment_mm, CK_CARDMM[i].Code);
		}
		
		Str_Cpy( stEtcCardinfo.szCard_num				 , "999999999999999" );
		Str_Cpy( stEtcCardinfo.szCard_type_nm			 , "테스트 카드" );
		Str_Cpy( stEtcCardinfo.szValid_ym				 , "0000" 						 );
		Str_Cpy( stEtcCardinfo.szItem_flag 			     , "10" );
		Str_Cpy( stEtcCardinfo.szApproval_num			 , "99999999" );
		Str_Cpy( stEtcCardinfo.szApproval_time			 , "191219999999" );	
		Str_Cpy( stEtcCardinfo.szCard_com				 , "99" 						 );	
		Str_Cpy( stEtcCardinfo.szBuying_comp			 , "99"						 );
		Str_Cpy( stEtcCardinfo.szBuying_comp_nm		     , "테스트 카드사" );
		
		hist_rslt = 1;
		
		g_Close_SubDlg();
		
		if( hist_rslt == 1 )
		{
			Snd_CardHist_Rslt();	
		}
		else
		{
			Card_Move("C6101_PayMenu");
		}
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Set_Cmd_Allotment
	기  능 : 할부 콤보박스 세팅
	Param  : 
	Return : 
	========================================================================================*/ 
	void Set_Cmd_Allotment(void)
	{
		char sztmp[300];
 		long amt = 0;
 		long i = 0;
 		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AMT)) );
		
		amt = Str_AtoI( sztmp );
		
		if( amt >= 50000 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
			
			i = g_SearchCD( "00", CK_CARDMM );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), CK_CARDMM[i].Str);
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : setValidation
	기  능 : 승인 검증 테이블
	Param  : 
	Return : 
	========================================================================================*/ 
	bool setValidation(void)
	{
		char szTmp[300];
		long szAmt = 0;
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_AMT)) );
		
		szAmt = Str_AtoI(szTmp);
		
		if( szAmt == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "0원을 결제 할 수 없습니다.");
			return FALSE;
		}
		else if( Str_Cmp( stEtcCardinfo.szApproval_num, "" ) != 0 )
		{
			return FALSE;
		}
		
		return TRUE;
	}
}
