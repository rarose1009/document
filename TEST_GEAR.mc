/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card TEST_GEAR
{
	#include <include.h>
	#include "globalcard.h"
	#include "CardRead.h"
	#include "Calendar.h"
	
	#define USE_ON_EXIT
	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
	#define USE_ON_TIMER
	#define USE_ON_POINTING
//	#define USE_ON_SELECT
	#define USE_ON_USER

//	#define USE_ON_PROGRESS
 	#define USE_ON_UART
//	#define USE_ON_SESSION
//	#define USE_ON_SENDTEXT
	#define USE_ON_TASK
//	#define USE_ON_TICKER
//	#define USE_ON_EDITCTRL


	#include "DefEvent.h"
	#include "SQL.lib"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_READ     )		//
		DEF_BUTTON_ID ( BID_PRINT     )		//
		DEF_BUTTON_ID ( BID_SCAN     )		//
		DEF_BUTTON_ID ( BID_PHOTO     )		//
		DEF_BUTTON_ID ( BID_VIEW     )		//
		DEF_BUTTON_ID ( BID_SIGN )
		DEF_BUTTON_ID ( BID_MEMO )
		DEF_BUTTON_ID ( BID_SMS )
		DEF_BUTTON_ID ( BID_MSGOPEN )
		DEF_BUTTON_ID ( BID_MSGCLOSE )
		DEF_BUTTON_ID ( BID_CALENDAL)
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
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )

		DEF_OBJECT_ID ( PNG_IEXIT )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

	END_OBJECT_ID()

	#define YCAP	50
	#define INIT_MAIN	1
	
	#define CARD_READ_EVENT	3000
	long	m_nTimerId = 0, m_nTimerCnt = 0;
	long    m_lEditCtrlIndex = -1;
	char 	m_szScandata[100];
	char    m_szfilenm[100];
	char    m_szBuf[32];
	
	bool	m_bBtConnected = 0;
	bool	m_bCardReading = 0;
	
	void SetStyle(void);
	void SetBtnImg(void);
	
	void Test_Print(void);
	void Test_barcode(void);
	void Test_Photo(void);
	void Test_PhotoNew(void);
	void Test_View(void);
	void Test_Sign(void);
	void OnBarcodeRead(void);
	void Load_photo(char* szpath, handle* Base64, char* pRst);
	bool Sms_Test(void);
	void TEST_CONVERT(void );
	void ebc_asc_conv(char *indata, char *outdata, int Byte);
	
	void Test_ListView(void);
	void Test_GridView(void);
	void Test_DbGridView(void);
	void Test_GridCheckView(void);

	void Test_DbCheckListView(void);
	
	void Grid_QuickList(long nBtnID);
	
	void Test_RemoveDir(void);


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
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "테스트 기어"),
			
		DLG_TEXT( STARTX,      STARTY+50+YCAP,  300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "바코드"),
		DLG_EDIT( STARTX,      STARTY+110+YCAP, 975, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA1, 30,  ""),
		DLG_BUTTON(STARTX+575, STARTY+50+YCAP,  400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCAN, "스캔"),
		
		DLG_TEXT(STARTX,       STARTY+160+YCAP*2, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "사진"),
		DLG_EDIT(STARTX,       STARTY+220+YCAP*2, 975, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA3, 30,  ""),
		DLG_BUTTON(STARTX+375, STARTY+160+YCAP*2, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "촬영"),
		DLG_BUTTON(STARTX+675, STARTY+160+YCAP*2, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW,  "사진확인"),

		DLG_TEXT(STARTX,       STARTY+280+YCAP*3, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "카드"),
		DLG_EDIT(STARTX,       STARTY+340+YCAP*3, 975, 120, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA2, 100,  ""),
		DLG_BUTTON(STARTX+575, STARTY+280+YCAP*3, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_READ, "읽기"),


		DLG_TEXT(STARTX,       STARTY+460+YCAP*4, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4, "인쇄"),
		DLG_BUTTON(STARTX+575, STARTY+460+YCAP*4, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "출력"),

		DLG_BUTTON(STARTX, STARTY+540+YCAP*4, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서명 테스트"),		
		DLG_BUTTON(STARTX+500, STARTY+540+YCAP*4, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "에디트 테스트"),		
		//DLG_BUTTON(STARTX, STARTY+YCAP, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "문자전송"),
		
		//DLG_BUTTON(STARTX, STARTY+YCAP, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MSGOPEN, "메세지 열기"),
		//DLG_BUTTON(STARTX+500, STARTY+610+YCAP*4, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MSGCLOSE, "메세지 닫기"),
		
		
		DLG_EDIT(STARTX,       STARTY+610+YCAP*4, 500, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA5, 15,  ""),
		DLG_BUTTON(STARTX+500, STARTY+610+YCAP*4, 200,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CALENDAL, "달력"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "테스트 기어"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_TEXT( STARTX,      STARTY+120, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "바코드"),
		DLG_EDIT( STARTX,  STARTY+180, 975, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA1, 30,  ""),
		DLG_BUTTON(STARTX+575, STARTY+120, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCAN, "스캔"),
		
		DLG_TEXT(STARTX,       STARTY+250, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "사진"),
		DLG_EDIT(STARTX,   STARTY+310, 975, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA3, 30,  ""),
		DLG_BUTTON(STARTX+375, STARTY+250, 300,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "촬영"),
		DLG_BUTTON(STARTX+675, STARTY+250, 300,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW,  "사진확인"),

		DLG_TEXT(STARTX,       STARTY+380, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "카드"),
		DLG_TEXT(STARTX,   STARTY+440, 975, 120, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, BLACK, TXTCTRLBK, EDT_DATA2,   ""),
		DLG_BUTTON(STARTX+575, STARTY+380, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_READ, "읽기"),


		DLG_TEXT(STARTX,       STARTY+570, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4, "인쇄"),
		DLG_BUTTON(STARTX+575, STARTY+570, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "출력"),
		
		DLG_BUTTON(STARTX, STARTY+650, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서명 테스트"),		
		DLG_BUTTON(STARTX+500, STARTY+650, 400,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "에디트 테스트"),		
		
	};		
	
	//카드리더 디바이스명 선택
	//#define DEVICE_NAME	"WOOSIM"
	#define DEVICE_NAME	"PM80"
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}

	//----------------------------------------------------------------------
	void CardClear(void)
	{
		m_bCardReading = 0;
		
		CardReader_StopEvent();
		//M( 카드 초기화... );
	}
	
	//----------------------------------------------------------------------
	long CardOpen(void)
	{
		if (m_bCardReading == 1)
			return 0;
	
		CardClear();
				
		if (m_bBtConnected == 0)
		{
			CardReader_Open( DEVICE_NAME );
			m_bBtConnected = 1;
			
			//M( 카드 오픈... );
			
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
		
		return 1;
	}
	
	//----------------------------------------------------------------------
	void CardClose(void)
	{
		CardReader_Close();	
		m_bBtConnected = 0;
		
		//M( 카드 종료... );
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
//MessageBox(MESSAGE, "메세지박스 테스트", 0, 0, 0, 0);
	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL에 ACTIVE시에 CTRLINDEX를 저장
		//키보드 BUTTONCTRL이 ACTIVE시에도 EDITCTRL에 커서를 두기위해서 INDEX를 저장
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
/*
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( Get_iDlgCtrlByID(BID_MSGOPEN) == lActiveIndex )	
				//if( X > DMS_X(STARTX) && X < DMS_X(STARTX+400) && Y > DMS_Y(STARTY+YCAP) && Y < DMS_Y(STARTY+YCAP+60) )
				{
					MessageBox(MESSAGE, "메세지박스 테스트", 0, 0, 0, 0);
				}
				else
				{
					CloseMessageBox();
				}
			}
*/

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX) && X < DMS_X(STARTX+500) && Y > DMS_Y(STARTY+610+YCAP*4-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+670+YCAP*4-(g_Dlgflag*400)) )
				{
					m_lEditCtrlIndex = lActiveIndex;
				
					g_Dlgflag = 0;
					g_MOVE_DLG(400);

					ShowSip(FALSE);
					g_Sipflag = 0;
					
					//SetKeyMode(KEYMODE_NUMBER);

					ShowSip(TRUE);
					g_Sipflag = 1;

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
				}
				else
				{
					g_Dlgflag = 1;
					g_MOVE_DLG(1);
				
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
				ON_DRAW();
			}
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{
	long nRet = 0;	
	long d, k, nTrack;
	char* pBuf;
	char szDate[15];
	char szTmp[15];
	
		switch(ID)
		{
			case BID_CALENDAL:
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Str_ItoA( d, szDate, 10);
					g_Str_DateType(szTmp, szDate);
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szTmp );
				}
				break;
		
			case BID_PRINT:
				Test_Print();
				break;

			case BID_READ:
			
			
//나중에 코딩 할 때, 버튼을 누르면 다른 작업(버튼 클릭 등)은 할 수 없도록 막아야한다.(ex: 공통 업무 버튼 클릭 등)

				nRet = CardOpen();
				
				if (nRet == 0)
				{
					break;
				}
				
				m_nTimerCnt = 15;
				m_nTimerId = Timer_Set( 1000, 0 );
				
				EditCtrl_SetStr(Get_hDlgCtrlByID( EDT_DATA2 ), "카드 읽기 준비 중 입니다." );
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_READ), "읽는 중...");
				
				ON_DRAW();
				break;
				
			case BID_SCAN:
PRINT("BID_SCAN : 버튼 클릭",0,0,0);
				Test_barcode();
				break;
				
			case BID_PHOTO:
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					//Test_Photo();
					//Test_PhotoNew();
					//Test_ListView();
					//Test_GridView();
					Test_DbGridView();
					//Test_DbCheckListView();
					//Test_GridCheckView();
					//Grid_QuickList(0);
				}
				else
				{
					Card_Move("CM_PHOTO");
				}
				break;
				
			case BID_VIEW:
				//Load_photo( "APP_PHOTO\\21498135_30_11.jjp",&g_pjcomm ,pBuf );
				Test_View();
				break;
			case BID_SIGN:
				Test_Sign();
				//TEST_CONVERT();
				break;
			case BID_MEMO:
				Card_Move("CM_MEMO");			
				break;
			case BID_SMS:
				if(Sms_Test())
				{
					MessageBoxEx (WARNING_OK, "성공");
				}
				else
				{
					MessageBoxEx (WARNING_OK, "실패");
				}
				break;
			//case BID_MSGOPEN:
			//	break;
			//case BID_MSGCLOSE:
			//	CloseMessageBox();
			//	break;
			case GID_HOME:
				Card_Move("TEST_MENU");
				break;
			case GID_MENU:
				Card_Move("TEST_MENU");
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
				Card_Move("TEST_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}

	//------------------------------------------------------------------------
	void OnTimer(long nTimerID)
	{
		if(m_nTimerId == nTimerID)
		{
			Str_Printf(m_szBuf, "%d초 이내에 카드를 스캔하세요.", m_nTimerCnt,0,0);
			EditCtrl_SetStr(Get_hDlgCtrlByID( EDT_DATA2 ), m_szBuf );
			
			if(m_nTimerCnt == 0)
			{
				Timer_Kill( m_nTimerId );
				m_nTimerId = -1;
				m_nTimerCnt=0;
				
				CardClear();
				
				//CardClose();

				EditCtrl_SetStr(Get_hDlgCtrlByID( EDT_DATA2 ), "타임아웃: 카드 읽기를 실패했습니다.\n재 시도 바랍니다." );
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_READ), "읽기");
			
				ON_DRAW();
				return;
			}
			
			m_nTimerCnt--;
			ON_DRAW();
		}
	}
	
	//------------------------------------------------------------------------
	void	OnKey(long nKey)
	{
		long i;
		char szMtr_Code[10];

//PRINT("nKey : %d",nKey,0,0);

		return;
	}
	
	//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		char szTmp[20];
		char szBuf[20];
		char szNum[5];
		char szZero[5];
		long i;

		//숫자만 입력 가능
		if( nChar > 47 &&  nChar < 58 )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			if( Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex )
			{
				Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				
				if( Str_Len(szTmp) == 4 )
				{
					Str_Cat(szTmp, "-");
				}
				
				if( Str_Len(szTmp) == 6)
				{
					if( nChar > 49 && nChar < 58 )
					{
						ON_KEY(5);
						return;
					}
				}
/*
				if( Str_Len(szTmp) == 7 )
				{
					Mem_Cpy((byte *)stSubCustInfo.EMAILADDR, (byte *)szTmp+(Str_Len(szTmp)-1), 1);
				}
*/
				if( Str_Len(szTmp) == 7 )
				{
					Str_Cat(szTmp, "-");
				}
				
				if( Str_Len(szTmp) == 9)
				{
					if( nChar > 51 && nChar < 58 )
					{
						ON_KEY(5);
						return;
					}
				}
				
				//g_Str_DateType(szBuf, szTmp);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), szTmp);
PRINT("1111EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)) : %s , szTmp : %s",EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)),szTmp,0);

			}
			return;
		}
	}

	void	OnUart(long nEvent, long nData)
	{
	char szfilenm[256];
	char szfilenm2[256];
	char szTmp[100];

		switch( nEvent )
		{
			case UART_BARCODE:
				OnBarcodeRead();
				break;
			case UART_CAMERA:
				if( nData == 1 )
				{
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
	
					//SPRINT (szfilenm, "%s",  FFS_GetWorkDir(),0, 0);
					Str_Cpy(szfilenm, "convert_test.jpg");
					
					//MessageBoxEx(CONFIRM_OK, szfilenm);
					
PRINT("OnUart : m_szfilenm = %s ",m_szfilenm,0,0);
					Mem_Set((byte*)szfilenm2, 0x00, sizeof(szfilenm2));
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					//Str_Cpy(szTmp, "camera/");
					SPRINT (szfilenm2, "camera/%s",  m_szfilenm, 0, 0);
		
PRINT("OnUart : szfilenm2 = %s ",szfilenm2,0,0);
PRINT("OnUart : convert_ szfilenm = %s ",szfilenm,0,0);
					if( ConvertImage(JPG, szfilenm2, 384, 512, szfilenm, 60*1000) != 0 )
					{
						PRINT("CAMERA SHOOT FALSE",0,0,0);
						//MessageBoxEx(CONFIRM_OK, "사진 실패12"); , 2400 3200
					}
					else
					{
						PRINT("CAMERA SHOOT OKOKOK",0,0,0);
						//MessageBoxEx(CONFIRM_OK, "사진 성공12");
					}
					//Camera_SetScreen(0, 0, 240, 180);
				}
				else if( nData == 2 )
				{
					PRINT("CAMERA SHOOT lParam = 2",0,0,0);
				}
				break;
			case UART_CARD:			
				break;
			case UART_PRINTER:
PRINT("OnUart : UART_PRINTER (%d)",UART_PRINTER,0,0);
				CardReader_StartEvent( CARD_READ_EVENT );
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
		}
	}

	//------------------------------------------------------------------------
	void Test_barcode(void)
	{
	long ret = 0;

		//스마트폰 -> Barcode_Init, Barcode_Exit 필요 ,, PDA -> Barcode_Init, Barcode_Exit 불필요 
		Barcode_Init();

		ret = Barcode_SendCommand( "start" );
	}

	//------------------------------------------------------------------------
	void OnBarcodeRead(void)
	{
	char sztmp[100];
	long ret = 0;

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );

		ret = Barcode_Read( sztmp );	

		if( ret < 0)
		{
			MessageBoxEx (ERROR_OK, "바코드 읽기 실패");
		}

		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), sztmp ) ;

		Barcode_Exit();
		ON_DRAW();
	}

	//------------------------------------------------------------------------
	void OnExit(void)
	{
		CardClose();
	}

	//------------------------------------------------------------------------
	void OnUser(long nEvent, long nData)
	{
	long nTrack =2;
	
		if(nEvent == CARD_READ_EVENT )
		{	
			Timer_Kill( m_nTimerId );
			m_nTimerId =-1;
			
			if (g_IsCardReader())
			{
				//PM80일 경우
				if (nData > 0)
				{
					long nRet = 0;
					
					//에러 상태
					char* ptr = (char*)System_GetResult((char*)&nRet);
					MessageBoxEx(ERROR_OK, ptr);
					
					EditCtrl_SetStr(Get_hDlgCtrlByID( EDT_DATA2 ), ptr );
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_READ), "읽기");
					ON_DRAW();
					
					CardClear();
					return;
				}
			}
			
			Mem_Set((byte*)m_szScandata, 0x00, sizeof(m_szScandata));
			CardReader_ReadRawData( nTrack, m_szScandata, 50 );
			EditCtrl_SetStr(Get_hDlgCtrlByID( EDT_DATA2 ), m_szScandata );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_READ), "읽기");
			
			PRINT("카드읽기 결과 = %s", m_szScandata,0,0);
			ON_DRAW();
			
			CardClear();
		}
	}
	
	//------------------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetMultiLine ( Get_hDlgCtrlByID(EDT_DATA2),TRUE, 10, 0 );
		//EditCtrl_SetMultiLine ( Get_hDlgCtrlByID(EDT_DATA4),TRUE, 10, 0 );

	}
	
	//------------------------------------------------------------------------
	void Test_Print(void)
	{
	long i, j, ret;
	char LineSpace[]={0x1b,0x20,0x00};
	char sztmp[101];
	char* temp[] = {	{"테스트용 데이터 입니다.         "},
//						{"12345678901234567890123456789012"},
//						{"ABCDEFGHIJKLNMOPQRSTUVWXYZ      "},
//						{"abcdefghijklnmopqrstuvwxyz      "},
//						{"가나다라마바사아카차바차타하    "},
//						{"                                "},
						};
		
//		for(i=0; i<100; i++)
//		{

//#define	BAR_X				DMS_X(500)
//#define	BAR_Y				DMS_Y(500)
//#define	BAR_WIDTH			DMS_X(170)
//#define	BAR_HEIGHT			DMS_Y(40)
		
//#define DRAW_PROGRESS(x, y, w, h, nCur, nMax) PROGRESS_DrawArc(x, y, w, h, LIGHTGREEN, theDevInfo.m_nFontType, nCur, nMax)

//			DRAW_PROGRESS(BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, i+1, 100);
			
//			VmSleep(100);
//		}
		
		MessageBoxEx (MESSAGE, "영수증 출력 준비중입니다.");							
		
		BT_Close_Printer();
		
		VmSleep(30);
		
		ret = BT_Init_Printer(g_szPrintPort, 57600, 1);
		
		VmSleep(10);
	
		switch ( ret )
		{
			case 1 :
				break;
			case -1 :
				MessageBoxEx (ERROR_OK, "오픈 실패. PDA 리셋후 다시 시도해주세요.");
				goto Finally;
			case -2 :
				MessageBoxEx (ERROR_OK, "오픈 실패. 프린터 상태를 확인해주세요.(-1)");
				goto Finally;
			case -3 :
				MessageBoxEx (ERROR_OK, "오픈 실패(Unable to configure the serial port)");
				goto Finally;
			case -4 :
				MessageBoxEx (ERROR_OK, "오픈 실패(Unable to set the timeout parameters)");
				goto Finally;
			case -5 :
				MessageBoxEx (ERROR_OK, "오픈 실패. 프린터 상태를 확인해주세요.(5)");
				goto Finally;
			case 0 :
				MessageBoxEx (ERROR_OK, "Print Manager를 실행하여 프린터를 등록하세요.");
				goto Finally;
			default :
				MessageBoxEx (ERROR_OK, "오픈 실패. 프린터 상태를 확인해주세요.");
				goto Finally;
		}
						
		BT_Clear_Spool();
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		for(i = 0 ; i < 6 ; i++)
		{
			ret = BT_Save_Spool( temp[i], 0, 0 );				
			if( ret == -1 )
			{				
			goto Finally;
			}	
		}
		
		BT_Print_Spool(TRUE);

		VmSleep(100);
		if(ret == -1)
		{
			goto Finally;
		}
		
Finally:

		CloseMessageBoxEx();
		BT_Close_Printer();
	}
	
	//------------------------------------------------------------------------
	void Test_Photo(void)
	{
	long ret;	
	char szfilenm[100];
	char sztmp[100];
	
		Mem_Set( (byte*)m_szfilenm, 0x00, sizeof(m_szfilenm) );
		Str_Cat(m_szfilenm, "test.jpg" );

		ret = ShootPhoto ( 1, 0, m_szfilenm );

		//MessageBoxEx (CONFIRM_OK, "사진이 촬영되었습니다.");
	}

	//------------------------------------------------------------------------
	void Test_PhotoNew(void)
	{
		handle h = NULL;
		handle hdata = NULL;
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			//JSON_SetValue	(hdata	, 'C', "desc"				, "../../Smart/test.jpg");
			JSON_SetValue	(hdata	, 'C', "position_info"		, "서울특별시 강서구 공항대로 607 서울도시가스 주식회사");
			JSON_SetValue	(h		, 'C', "method"				, "CameraActivity");
			
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
	}
	
	//------------------------------------------------------------------------
	//데이터베이스 로딩 예제
	/*
	void QuickList(long nBtnID)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		//nAddrType = 0 지번 ,, nAddrType = 1 도로명
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "검침 상세리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(AREA,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(CUST_NM, '') ||' / D:'|| ifnull(BASE_YMD, '') ||' / C:'|| ifnull(MTR_WORK_CODE, '') ||' / 지침:'|| ifnull(INDI_SET_VC, '') ||' / 사용량:'|| ifnull(INDI_QTY, '') from gumdata ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "검침 상세리스트");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(AREA,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||'  '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''), ifnull(CUST_NM, '') ||' / D:'|| ifnull(BASE_YMD, '') ||' / C:'|| ifnull(MTR_WORK_CODE, '') ||' / 지침:'|| ifnull(INDI_SET_VC, '') ||' / 사용량:'|| ifnull(INDI_QTY, '') from gumdata ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE");
		}

		sztmp = JSON_toString(js);
		
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
	}
	*/
	
	void Test_ListView(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		handle harr = NULL;
		char buf[32];
		long i;
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}

			harr = JSON_Create( JSON_Array );
			if(harr == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hdata	, 'C', "list_type"			, "BaseListView");
			
			//어레이 생성.
			//JSON_AddArrayItem(harr);
			//JSON_SetArrayItem(harr, 'C', "text"	, "키1");
			//JSON_SetArrayItem(harr, 'C', "value", "값1");
			
			//JSON_AddArrayItem(harr);
			//JSON_SetArrayItem(harr, 'C', "text"	, "키2");
			//JSON_SetArrayItem(harr, 'C', "value", "값2");

			for (i=0; i<100; i++)
			{
				JSON_AddArrayItem(harr);
				
				g_Sprintf(buf, "아이템 %d", i);
				JSON_SetArrayItem(harr, 'C', "text"	, buf);
				g_Sprintf(buf, "서브값 %d", i);
				JSON_SetArrayItem(harr, 'C', "value", buf);
			}
			
			JSON_Attach 	(hdata	, "body"					, harr);
			
			JSON_SetValue	(h		, 'C', "title"				, "리스트뷰 테스트");
			JSON_SetValue	(h		, 'C', "method"				, "ListViewActivity");
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
			
		if (harr)
		{
			JSON_Finalize(harr);
		}	
	}
	
	//------------------------------------------------------------------------
	void Test_GridView(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		handle hBody = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		
		//필드 간격 조정
		char col_weight[5][10] = {"1","3","1","0","0"};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			hBody = JSON_Create( JSON_Array );
			if(hBody == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			JSON_SetValue	(hData	, 'C', "bind_type"	, "json");		//json or query
			
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");			//true/false
								
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);
			//JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0, j=1; i<col_count; i++, j++)
			{
				JSON_AddArrayItem(hHead);
				g_Sprintf(val, "헤더_%d", j);
				JSON_SetArrayItem(hHead, 'C', "col_head", val);
				JSON_SetArrayItem(hHead, 'C', "col_weight", col_weight[i]);
			}
			
			for (i=0; i<100; i++)
			{
				j = 1;
				JSON_AddArrayItem(hBody);
				
				g_Sprintf(val, "%d_%d", i, j++);
				JSON_SetArrayItem(hBody, 'C', "col_1", val);
				g_Sprintf(val, "%d_%d", i, j++);
				JSON_SetArrayItem(hBody, 'C', "col_2", val);
				g_Sprintf(val, "%d_%d", i, j++);
				JSON_SetArrayItem(hBody, 'C', "col_3", val);
				
				if (col_count > 3)
				{
					g_Sprintf(val, "%d_%d", i, j++);
					JSON_SetArrayItem(hBody, 'C', "col_4", val);
				}
				
				if (col_count > 4)
				{
					g_Sprintf(val, "%d_%d", i, j++);
					JSON_SetArrayItem(hBody, 'C', "col_5", val);
				}
			}
			
			JSON_Attach 	(hData	, "head"					, hHead);
			JSON_Attach 	(hData	, "body"					, hBody);
			
			JSON_SetValue	(h		, 'C', "title"				, "그리드뷰 테스트");
			JSON_SetValue	(h		, 'C', "method"				, "ListViewActivity");
			JSON_Attach 	(h		, "data"					, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	

		if (hBody)
		{
			JSON_Finalize(hBody);
		}	
	}

	//------------------------------------------------------------------------
	void Test_DbGridView(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height = 200;
		long start_position = 30;
		
		char col_name[5][32] = {"번호", "이름", "플래그", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"1","3","1","0","0"};
		char col_align[5][10]  = {"left", "left", "right","", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			JSON_SetValue	(hData	, 'X', "start_position"	, &start_position);
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			JSON_SetValue	(hData	, 'C', "query",
								"select ifnull(MAKER_NUM,''), ifnull(MAKER_NM,''), ifnull(MAKER_FLAG, '') \
								FROM USE_MAKER"
							);
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "DB 그리드뷰 테스트");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}
	
	//------------------------------------------------------------------------
	void Test_GridCheckView(void)
	{
		handle h = NULL;
		handle hHead = NULL;
		handle hData = NULL;
		handle hBody = NULL;
		char buf[32];
		long i;
		char* check = NULL;
		long col_height = 100;
		long start_position = 30;
		long col_count;
	
		char col_name[5][32] = {"head_1", "head_2", "head_3", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"1","2","1","1","0"};
		char col_align[5][10]  = {"left", "center", "right","center", ""};
		
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			hBody = JSON_Create( JSON_Array );
			if(hBody == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hData	, 'C', "list_type"	, "GridCheckView");
			JSON_SetValue	(hData	, 'C', "bind_type"	, "json");				//json or query
			JSON_SetValue	(hData	, 'X', "start_position"	, &start_position);
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);
			
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);			

			for (i=0; i<100; i++)
			{
				JSON_AddArrayItem(hBody);
				
				if (i%2 == 0)
				{
					check = "Y";
				}
				else
				{
					check = "N";
				}
				
				g_Sprintf(buf, "%d_1", i);
				JSON_SetArrayItem(hBody, 'C', "col_1", buf);
				g_Sprintf(buf, "%d_2", i);
				JSON_SetArrayItem(hBody, 'C', "col_2", buf);
				g_Sprintf(buf, "%d_3", i);
				JSON_SetArrayItem(hBody, 'C', "col_3", buf);
				JSON_SetArrayItem(hBody, 'C', "check", check);
			}
			
			JSON_Attach 	(hData	, "body"			, hBody);
			
			JSON_SetValue	(h		, 'C', "title"		, "체크리스트뷰 테스트");
			JSON_SetValue	(h		, 'C', "method"		, "ListViewActivity");
			JSON_Attach 	(h		, "data"			, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}

		if (hData)
		{
			JSON_Finalize(hHead);
		}
			
		if (hBody)
		{
			JSON_Finalize(hBody);
		}	
	}
	
	//------------------------------------------------------------------------
	void Test_DbCheckListView(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hBody = NULL;
		char buf[32];
		long i;
		char* check = NULL;
		long start_position = 30;
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			hBody = JSON_Create( JSON_Array );
			if(hBody == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hData	, 'C', "list_type"	, "CheckListView");
			JSON_SetValue	(hData	, 'C', "bind_type"	, "json");				//json or query
			JSON_SetValue	(hData	, 'X', "start_position"	, &start_position);
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false

			for (i=0; i<100; i++)
			{
				JSON_AddArrayItem(hBody);
				
				if (i%2 == 0)
				{
					check = "Y";
				}
				else
				{
					check = "N";
				}
				
				JSON_SetArrayItem(hBody, 'C', "check", check);
				g_Sprintf(buf, "체크값을 테스트합니다. %d", i);
				JSON_SetArrayItem(hBody, 'C', "value", buf);
			}
			
			JSON_Attach 	(hData	, "body"			, hBody);
			
			JSON_SetValue	(h		, 'C', "title"		, "체크리스트뷰 테스트");
			JSON_SetValue	(h		, 'C', "method"		, "ListViewActivity");
			JSON_Attach 	(h		, "data"			, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hBody)
		{
			JSON_Finalize(hBody);
		}	
	}
	
	//------------------------------------------------------------------------
	void Grid_QuickList(long nBtnID)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"그룹주소", "대상", "체크박스", "", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","1","1","0","0"};
		char col_align[5][10]  = {"left", "center", "right", "", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridCheckView");
			//재 호출했을때, 이전 위치를 기억하고 있으려면 매 호출시 마다
			//true를 해 주어야 한다.
			//만약 종류가 다른 뷰를 호출할 경우, 문제가 되므로 반드시 매번 호출시
			//개별 판단하여 제어를 해야 한다.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			//주소가 표시되는 필드가 존재해서 세로길이가 자동조절이 안된다면 
			//일반 퀵뷰리스트와 같이 높이 조절이 필요할거같습니다.
			col_height = 200;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			//start_position = m_lpage*ROW + m_nActIndex-1;
			start_position = 0;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			

			JSON_SetValue	(hData	, 'C', "query",
							"SELECT COUNTY ||' '|| TOWN ||' '|| ADDR1_M ||'-'|| ADDR1_S ||' '|| CO_LIVE_NM , CNT \
							, CHK_YN FROM NORMAL_GROUP WHERE SEND_YN <> 'Y' OR SEND_YN IS NULL ORDER BY HOUSE_NUM_ORD,TOWN,ADDR1_M,ADDR1_S,BLD_NUM"
							);

			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "일일점검자료수신");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}

	//------------------------------------------------------------------------
	// 파일 폴더 전체 삭제(하위폴더 포함)
	//------------------------------------------------------------------------
	void Test_RemoveDir(void)
	{
		handle h = NULL;
		handle hdata = NULL;
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hdata	, 'C', "path"		, "Smart");
			JSON_SetValue	(h		, 'C', "method"		, "FileRemoveDir");
			
			JSON_Attach 	(h		, "data"			, hdata);
		
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
	}

	//------------------------------------------------------------------------
	void OnTask(long nEvent, long nData)
	{
		long nRet = 0;
		
		if(nEvent == TASK_SYS_CALL)
		{
			//시스템콜
			char* ptr = (char*)System_GetResult((char*)&nRet);
			
			if (nData == UART_CAMERA)
			{
				PRINT("TASK_SYS_CALL:: UART_CAMERA: path = %s, size = %d ", ptr, nRet, 0);
			}
		}
	}
	
	//------------------------------------------------------------------------
	void Test_View(void)
	{
	long ret;	
	char sztmp[128];

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT (sztmp, "%s/%s/%s", FFS_GetWorkDir() ,"camera","test.jpg");
		MessageBoxEx (CONFIRM_OK, sztmp);
		RunApp( "WEBVIEWER", sztmp);
		
	}
	
	//------------------------------------------------------------------------
	void Load_photo(char* szpath, handle* Base64, char* pRst)
	{
	handle g_Base64 = NULL;
	long size = 0;
	byte* pimg = NULL;
	byte* pBase = NULL;
	long fd,fd1;
	long ret;
	
	
		size = FFS_GetSize(szpath);
		Base64 = BASE64_Create();
		if(  Base64 == NULL )
		{
			goto Finally;
		}
	
		pimg = Mem_Alloc (size);
		if(pimg == NULL)
		{
			goto Finally;
		}
		
		fd = FFS_Open ( szpath, FS_READ_MODE, FS_NORMAL_FLAG );
		if(fd == -1)
		{
			goto Finally;
		}

		FFS_Read(fd, pimg, size);			
		ret = BASE64_Encode(Base64, pimg, size);
		pRst = BASE64_GetResult(Base64);
		
//		pBase, Str_Len((char*)pBase)
		
		fd1= FFS_Open ( "BASE64_Encode.txt", FS_WRITE_MODE , FS_CREATE_FLAG );
		FFS_Write(fd1, (byte*)pRst, Str_Len(pRst) );
		FFS_Close(fd1);
		
Finally:		
		
		if(pimg != NULL)
		{
			Mem_Free(pimg);
			pimg = NULL;
		}
		
		if(fd > 0)
			FFS_Close(fd);
	}
	
	//------------------------------------------------------------------------
	void Test_Sign(void)
	{
		char* pRst;
		char szSql[300];
		long lsign, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//서명
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명" );
		//SIGN_OPT_NONE : 필수로 입력해야하는 조건 , SIGN_OPT_CHECK : 입력하지 않아도 넘어갈수있는 조건
		//lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명", SIGN_OPT_NONE );
		
PRINT("lsign : %d ",lsign,0,0);
		
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			return;
		}
		else if( lsign == SIGN_RET_SUCCESS )
		{
/*
PRINT("Str_Len(g_SignBuf) : %d",Str_Len(g_SignBuf),0,0);
			if( Str_Len(g_SignBuf) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "사인을 입력해주세요.");
				goto Finally;
			}
*/		
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}

			g_pjcomm = BASE64_Create();
			lsign = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		return;
	}
	
	//------------------------------------------------------------------------
	bool Sms_Test(void)
	{
		long ret;
		long lTime = 100;
		char szCustTel[20];
		char szUserTel[20];
		char szMsg[100];
		char szMsg2[100];
		char szMsg3[100];
		
		Mem_Set((byte*)szCustTel, 0xff, sizeof(szCustTel));
		Mem_Set((byte*)szUserTel, 0xff, sizeof(szUserTel));
		Mem_Set((byte*)szMsg, 0xff, sizeof(szMsg));
		Mem_Set((byte*)szMsg2, 0xff, sizeof(szMsg2));
		Mem_Set((byte*)szMsg3, 0xff, sizeof(szMsg3));
		
		Str_Cpy(szCustTel, "01072018946");
		Str_Cpy(szUserTel, "01221599623");
		
		SPRINT(szMsg, "메세지발송 시간 메세지 발송 시간 : %d ",Time_GetTime(),0,0);
		
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg, Str_Len(szMsg) );
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "메시지 받을 전화 번호가 잘못되었습니다.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "응답을 받을 전화번호가 잘못되었습니다.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "내용이 비었습니다.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "내용이 너무 깁니다.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
					return FALSE;
			}
		}
		
		VmSleep(lTime);
		
		SPRINT(szMsg2, "2번째 메세지발송 시간 메세지 발송 시간 : %d ",Time_GetTime(),0,0);
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg2, Str_Len(szMsg2) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "메시지 받을 전화 번호가 잘못되었습니다.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "응답을 받을 전화번호가 잘못되었습니다.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "내용이 비었습니다.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "내용이 너무 깁니다.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
					return FALSE;
			}
		}
		
		VmSleep(lTime);
		
		SPRINT(szMsg3, "3번째 메세지발송 시간 메세지 발송 시간 : %d ",Time_GetTime(),0,0);
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg3, Str_Len(szMsg3) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "메시지 받을 전화 번호가 잘못되었습니다.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "응답을 받을 전화번호가 잘못되었습니다.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "내용이 비었습니다.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "내용이 너무 깁니다.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "메세지 전송에 실패했습니다.");
					return FALSE;
			}
		}
		
		
		VmSleep(lTime);
		
		Tapi_MakeCall((byte*)szCustTel);
		
		return TRUE;
	}
	
	//------------------------------------------------------------------------
	void ebc_asc_conv(char *indata, char *outdata, int Byte)
    {
        int EbcToAsc [] =
        {   0,   1,   2,   3, 156,   9, 134, 127, 151, 141, 142,  11,  12,  13,  14,  15,  16,  17,  18,  19,
          157, 133,   8, 135,  24,  25, 146, 143,  28,  29,  30,  31, 128, 129, 130, 131, 132,  10,  23,  27,
          136, 137, 138, 139, 140,   5,   6,   7, 144, 145,  22, 147, 148, 149, 150,   4, 152, 153, 154, 155,
           20,  21, 158,  26,  32, 160, 161, 162, 163, 164, 165, 166, 167, 168,  91,  46,  60,  40,  43,  33,
           38, 169, 170, 171, 172, 173, 174, 175, 176, 177,  93,  36,  42,  41,  59,  94,  45,  47, 178, 179,
          180, 181, 182, 183, 184, 185, 124,  44,  37,  95,  62,  63, 186, 187, 188, 189, 190, 191, 192, 193,
          194,  96,  58,  35,  64,  39,  61,  34, 195,  97,  98,  99, 100, 101, 102, 103, 104, 105, 196, 197,
          198, 199, 200, 201, 202, 106, 107, 108, 109, 110, 111, 112, 113, 114, 203, 204, 205, 206, 207, 208,
          209, 126, 115, 116, 117, 118, 119, 120, 121, 122, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
          220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 123,  65,  66,  67,  68,  69,  70,  71,
           72,  73, 232, 233, 234, 235, 236, 237, 125,  74,  75,  76,  77,  78,  79,  80,  81,  82, 238, 239,
          240, 241, 242, 243,  92, 159,  83,  84,  85,  86,  87,  88,  89,  90, 244, 245, 246, 247, 248, 249,
           48,  49,  50,  51,  52,  53,  54,  55,  56,  57, 250, 251, 252, 253, 254, 255 };
        int i;
        for (i = 0; i < Byte; i++)
        {
            *(outdata + i) = EbcToAsc[*(indata + i)];
        }
        return;
    } 
	
	//------------------------------------------------------------------------
	void TEST_CONVERT(void )
	{
		return;
	/*
	char sztmp[4] = { 0x91, 0xBC, 0xEF, 0};
	char sztmp1[4] = { 0x93, 0xBC, 0xEF, 0};
	char sztmp2[4] = { 0x94, 0xBC, 0xEF, 0};
	char szbuf[10];
	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf) );
		ebc_asc_conv( sztmp, szbuf, 3 );
		PRINT("ebc_asc_conv=%x",szbuf,0,0);
		Dump((byte*)szbuf , 10 , DUMP_ASCII );
		Dump((byte*)szbuf , 10 ,  DUMP_HEX  );
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf) );
		ebc_asc_conv( sztmp1, szbuf, 3 );
		PRINT("ebc_asc_conv=%x",szbuf,0,0);
		Dump((byte*)szbuf , 10 , DUMP_ASCII );
		Dump((byte*)szbuf , 10,  DUMP_HEX  );

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf) );
		ebc_asc_conv( sztmp2, szbuf, 4 );
		PRINT("ebc_asc_conv=%x",szbuf,0,0);
		Dump((byte*)szbuf , 10 , DUMP_ASCII );
		Dump((byte*)szbuf , 10 , DUMP_HEX  );
		*/
	}
	
}


