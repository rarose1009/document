/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card TEST_MENU
{
	#include <include.h>
	#include "globalcard.h"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_TESTGEAR )
		DEF_BUTTON_ID ( BID_LIST )
		DEF_BUTTON_ID ( BID_KEYBOARD )
		DEF_BUTTON_ID ( BID_BARCODE )
		DEF_BUTTON_ID ( BID_OZVIEW )
		DEF_BUTTON_ID ( BID_WEB )
		DEF_BUTTON_ID ( BID_TEST3 )
		DEF_BUTTON_ID ( BID_TEST4 )
		DEF_BUTTON_ID ( BID_TEST5 )
		DEF_BUTTON_ID ( BID_TEST6 )
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )
		
		DEF_OBJECT_ID ( PNG_IEXIT )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	void SetBtnImg(void);
	
	void 	test_WebView(void);
	void 	test_OzView(void);
	void 	test_BarcodeView(void);	

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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "테스트 메뉴"),

		DLG_BUTTON(STARTX,      STARTY+70, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_TESTGEAR, "테스트기어"),
		DLG_BUTTON(STARTX+500,  STARTY+70, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_LIST, "리스트뷰"),
		DLG_BUTTON(STARTX,     STARTY+220, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_KEYBOARD, "키보드"),
		DLG_BUTTON(STARTX+500, STARTY+220, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_BARCODE, "카메라\n바코드"),
		DLG_BUTTON(STARTX,     STARTY+370, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_OZVIEW, "OZ뷰어"),
		DLG_BUTTON(STARTX+500, STARTY+370, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_WEB, "WEB뷰어"),
		DLG_BUTTON(STARTX,     STARTY+520, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_TEST3, "미정"),
		DLG_BUTTON(STARTX+500, STARTY+520, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_TEST4, "미정"),
		DLG_BUTTON(STARTX,     STARTY+670, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_TEST5, "미정"),
		//DLG_BUTTON(STARTX+500, STARTY+670, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, THICKBLUE, CALL_FUNC , "", BID_TEST6, "미정"),
		DLG_BUTTON(STARTX+500, STARTY+670, 485, 200, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TEST6, ""),
	};	

	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "테스트 메뉴"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_VMEXIT, ""),

		DLG_BUTTON(STARTX+15,          70, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TESTGEAR, "테스트기어"),
		DLG_BUTTON(STARTX+505,         70, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_LIST, "리스트뷰"),
		DLG_BUTTON(STARTX+15,  STARTY+135, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "키보드"),
//		DLG_BUTTON(STARTX+505, STARTY+135, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TEST1, "미정"),
//		DLG_BUTTON(STARTX+15,  STARTY+300, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TEST2, "미정"),
		DLG_BUTTON(STARTX+505, STARTY+300, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BARCODE, "카메라\n바코드"),
		DLG_BUTTON(STARTX+15,  STARTY+465, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OZVIEW, "OZ뷰어"),
		DLG_BUTTON(STARTX+505, STARTY+465, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WEB, "WEB뷰어"),
		DLG_BUTTON(STARTX+15,  STARTY+630, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TEST3, "미정"),
		DLG_BUTTON(STARTX+505, STARTY+630, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TEST4, "미정"),
		DLG_BUTTON(STARTX+15,  STARTY+795, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TEST5, "미정"),
		DLG_BUTTON(STARTX+505, STARTY+795, 470, 150, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TEST6, "미정"),
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
		handle h = NULL;
		void * pImg = NULL;
	
		if(bFirst == 0)
		{
			bFirst = 1;
		}	
		
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
			
				//버튼 이미지 resize 적용 테스트
				h = Get_hDlgCtrlByID(BID_TEST6);
				//기존 버튼이미지 적용 코드
				ButCtrl_SetImage( h,  g_pImgBs_Normal);
	
				//GrDev_ResizePixels 를 이용하여 버튼이미지 적용하려는 예제 코드
				//syscall byte*	GrDev_ResizePixels			(byte* pImage, long X1, long Y1, long X2, long Y2);
				
				//m_pImg = GrDev_ResizePixels(g_pImgBs_Normal, 0, 0, 100, 100);
				//ButCtrl_SetImage( h,  m_pImg);
	
				ON_DRAW();
				break;
		}
	}
	
//--------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	long ret;

		switch(ID)
		{					
			case BID_TESTGEAR:
				Card_Move("TEST_GEAR");
				break;				
			case BID_LIST:
				Card_Move("TEST_LIST");
				break;			
			case BID_KEYBOARD:
				break;
				
			case BID_BARCODE:
				test_BarcodeView();
				break;
			case BID_OZVIEW:
				test_OzView();
				break;
			case BID_WEB:
				test_WebView();
				break;
				
			case BID_TEST3:
				break;
			case BID_TEST4:
				break;
			case BID_TEST5:
				break;
			case BID_TEST6:
				break;
			case GID_HOME:
				//g_Exit();
				Card_Move("MENU");
				break;
			case GID_MENU:
				g_Exit();
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
				g_Exit();
				break;	
			case GID_VMEXIT:
				g_Exit();
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
		
		ON_DRAW();
		return;
	}
	
	//=================================================================
	// 테스트 코드
	//=================================================================
	
	//-----------------------------------------------------------------
	void test_WebView(void)
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
			
			JSON_SetValue	(hdata	, 'C', "url"				, "web/test.html");
			
			// true : fullscreen mode, false : defult title mode
			JSON_SetValue	(hdata	, 'C', "title_flag"			, "true");
			JSON_SetValue	(hdata	, 'C', "title_text"			, "웹뷰호출 테스트");
			JSON_SetValue	(hdata	, 'C', "title_text_color"	, "#FFFFFF");
			JSON_SetValue	(hdata	, 'C', "title_bg_color"		, "#3F51B5");
									
			JSON_SetValue	(h		, 'C', "method"				, "WebViewActivity");
			
			JSON_Attach 	(h		, "data"					, hdata);
		
			//Native_System_Call > method 및 data 설정 필요(ex : Native_System_Call , 'TEST_MENU' 카드 확인
			//Native_System_Call이 아닌 System_Call > metod 및 data 설정 불필요(ex : ConvertJpegToPng , 'CM_BIZ' 카드 확인
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
	
	//-----------------------------------------------------------------
	void test_OzView(void)
	{
		handle h = NULL;
		handle header = NULL;
		handle body = NULL;
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			header = JSON_Create( JSON_Object );
			if(header == NULL)
			{
				goto Finally;
			}
			
			body = JSON_Create( JSON_Object );
			if(body == NULL)
			{
				goto Finally;
			}		
			
			//바디 입력
			//JSON_SetValue	(body	, 'C', "pmPatnm"			, "(주)밸류씨엠디");
			//JSON_SetValue	(body	, 'C', "pmAddr"				, "서울시 서초구 방배동 828-1 정동빌딩 3층");
			//JSON_SetValue	(body	, 'C', "pmJumin"			, "991231");
			//JSON_SetValue	(body	, 'C', "pmPhone"			, "010-1234-5678");
			//JSON_SetValue	(body	, 'C', "pmEmail"			, "webmaster@valuecmd.co.kr");
			//JSON_SetValue	(body	, 'C', "pmCurrentDate"		, "2017-02-23");
			
			//주소 입력 화면 기본 데이터
			JSON_SetValue( body, 'C', "url",          GET_URL(WAS_BASE_URL) );
			JSON_SetValue( body, 'C', "clientid",     stUserinfo.szpda_ip );
			JSON_SetValue( body, 'C', "userid",       stUserinfo.szemployee_id );
			JSON_SetValue( body, 'C', "workcd",       stUserinfo.szworkcd );
			JSON_SetValue( body, 'C', "vmversion",    stUserinfo.szver_num );
			JSON_SetValue( body, 'C', "appversion",   stUserinfo.szappversion );
	
			//헤더 입력
			JSON_SetValue	(header	, 'C', "Formcode"			, "00002");
			JSON_SetValue	(header	, 'C', "Ozserver"			, GET_URL(OZ_BASE_URL));
			JSON_Attach 	(header		 , "Paramdata"			, body);
			
			//시스템콜 요청
			// { "method" : "시스템콜 매쏘드명", "data" : "json object 스트링" }
			JSON_SetValue	(h		, 'C', "method"				, "OzViewActivity");
			JSON_Attach 	(h			 , "data"				, header);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (header)
		{
			JSON_Finalize(header);
		}
			
		if (body)
		{
			JSON_Finalize(body);
		}	
	}
		
	//-----------------------------------------------------------------
	void test_BarcodeView(void)
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
			
			JSON_SetValue	(hdata	, 'C', "desc"				, "카메라바코드");
			JSON_SetValue	(hdata	, 'C', "imgSaveEnabled"		, "false");						//{true, false}
			JSON_SetValue	(hdata	, 'C', "imgOutPath"			, "Barcode/barcode.jpg");		//Smart 하위 경로만 설정
			
			JSON_SetValue	(h		, 'C', "method"				, "BarcodeActivity");
			
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
	void OnTask(long nEvent, long nData)
	{
		long nRet = 0;

		if(nEvent == TASK_SYS_CALL)
		{
			//시스템콜
			char* ptr = (char*)System_GetResult((char*)&nRet);

			if( nData == TASK_BARCODE )
			{
				PRINT("OnTask >>>> nData : %d , ptr : %s", nData, ptr, 0);
			}
		}
	}
}


