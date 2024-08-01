/*----------------------------------------------------------------------------------
	Project Name: 
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.                          
   ----------------------------------------------------------------------------------*/
card LOGIN
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"

	//-----------------------------------------------------------------
	//__USE_RELEASE__ -> 운영 버전업그레이드 주소   |||  __USE_RELEASE__ 주석처리 -> 테스트 버전업그레이드 주소
	//__USE_VM_UPGRADE__ -> VM업그레이드 사용  || __USE_VM_UPGRADE__ 주석처리 -> VM 업그레이드 제거(컴퓨터 테스트시 업그레이드 안하도록)
	//-----------------------------------------------------------------

	//로그인 카드에서만 사용(원본은 DefType.h에 있음.)
	//운영 : 둘다 풀어야함
	//#define __USE_VM_UPGRADE__
	
	//-----------------------------------------------------------------
	//-----------------------------------------------------------------
	//로그인 없이 테스트 할 겅우
	//사용하지 않을 경우는 그냥 비 활성화 시키시오.
	//DefType.h에 릴리즈가 선언될 경우, 자동으로 비활성화 됨.
	//-----------------------------------------------------------------
	//-----------------------------------------------------------------
	//#define __USE_DEV_CARD__
	
	//릴리즈시 반드시 선언 및 제거 되어야 하는 것들 정의
	#ifdef VER_RELEASE
	
		//로컬 릴리즈 선언 활성화
		#ifndef __USE_RELEASE__
		
			#define __USE_RELEASE__
			
		#endif //__USE_RELEASE__
		
		//업그레이드 활성화
		//#ifndef __USE_VM_UPGRADE__
		//로컬에서 운영으로 붙을때 막아야함
			//#define __USE_VM_UPGRADE__
			
		//#endif //__USE_VM_UPGRADE__
		
		//카드 개발 호출 비활성화 
		#ifdef __USE_DEV_CARD__
		
			#undef __USE_DEV_CARD__
		
		#endif //__USE_DEV_CARD__
	
	#endif // VER_RELEASE
	
	//카드 테스터 dkjung 2017-05-12
	#ifdef 	__USE_DEV_CARD__
	
		//#define TEST_CARD	"C6101_MENU"
		#define TEST_CARD	"C6301_LST"
		
		#define CALL_DEV_CARD()	{Card_Move(TEST_CARD);return TRUE;}
		
	#else

		#define CALL_DEV_CARD()

	#endif //__USE_DEV_CARD__
	
	//-----------------------------------------------------------------
	//디바이스 테스트용 화면 전용	
	//-----------------------------------------------------------------
	//2016-07-14 Sanghyun Lee
	//Backdoor ID/PW 생각후 결정할것, 지금 적힌것은 테스트용 , iloveyou
	#define DEV_LOGIN_USER "iloveyou"
	#define DEV_LOGIN_PASS "qwer"
	
	//2016-07-14 Sanghyun Lee
	//TEST_MENU -> 기능 테스트를 위한 숨겨진 메뉴
	#define DEV_LOGIN_MENU "TEST_MENU"
	
	//-----------------------------------------------------------------
	// 카드내에서 사용될 버튼 아이디 정의
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_LOGIN )		 // 인증
		DEF_BUTTON_ID ( BID_VPN )		 // VPN 인증
		DEF_BUTTON_ID ( BID_VPNRCV )	 // VPN 인증번호 받기
		DEF_BUTTON_ID ( BID_VPN_LOGOUT ) // VPN 로그아웃
		DEF_BUTTON_ID ( BID_REMOVE )	 // 수동 설치(Smart 폴더 삭제)
		DEF_BUTTON_ID ( BID_EXIT )		 // 닫기
		DEF_BUTTON_ID ( BID_CHANGE )	 // PDA번호변경
		DEF_BUTTON_ID ( BID_VMUPGRADE )
	END_BUTTON_ID()
	
	//-----------------------------------------------------------------
	// 카드내에서 사용될 콘트롤 아이디 정의
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_VERSION )
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_REMOVE )
		
		DEF_OBJECT_ID ( EDT_ID )		// 로그인ID
		DEF_OBJECT_ID ( EDT_PW )		// 비밀번호
		DEF_OBJECT_ID ( EDT_PW_PDA )	// 비밀번호_PDA
		DEF_OBJECT_ID ( EDT_MODE )		// MODE
		
		DEF_OBJECT_ID ( ICON_LOGO )		// 로고
		DEF_OBJECT_ID ( PNG_LOGO )		//로고 이미지
	END_OBJECT_ID()

#define BUILDTM_YEAR (\
    __DATE__[7] == '?' ? 1900 \
    : (((__DATE__[7] - '0') * 1000 ) \
    + (__DATE__[8] - '0') * 100 \
    + (__DATE__[9] - '0') * 10 \
    + __DATE__[10] - '0'))

#define BUILDTM_MONTH (\
    __DATE__ [2] == '?' ? 1 \
    : __DATE__ [2] == 'n' ? (__DATE__ [1] == 'a' ? 1 : 6) \
    : __DATE__ [2] == 'b' ? 2 \
    : __DATE__ [2] == 'r' ? (__DATE__ [0] == 'M' ? 3 : 4) \
    : __DATE__ [2] == 'y' ? 5 \
    : __DATE__ [2] == 'l' ? 7 \
    : __DATE__ [2] == 'g' ? 8 \
    : __DATE__ [2] == 'p' ? 9 \
    : __DATE__ [2] == 't' ? 10 \
    : __DATE__ [2] == 'v' ? 11 \
    : 12)

#define BUILDTM_DAY (\
    __DATE__[4] == '?' ? 1 \
    : ((__DATE__[4] == ' ' ? 0 : \
    ((__DATE__[4] - '0') * 10)) + __DATE__[5] - '0'))


	#define SY   5 //CTRL시작위치
	#define GAP  5 //CTRL간의 간격

	#define INIT_MAIN	1
	
	#define m_ID_LEN 	   15
	#define m_PW_LEN	   30
	
	//-----------------------------------------------------------------
	// event message map
	//-----------------------------------------------------------------
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
//	#define USE_ON_SELECT
//	#define USE_ON_USER

	#include "DefEvent.h"
	
	VM_AppInfo m_stAppinfo;
	VM_Info m_stVminfo;
	
	char m_szText[50];
	char m_szID[20];
	char m_szPW[20];
	long m_lActiveIndex = -1;
	long m_lEditCtrlIndex;	// 현재커서가 있는 EDITCTRL의 INDEX
	long m_lChkCnt = 0;

	void SetStyle(void);
	void REDRAW(void);
	
	void LOGIN_PROS(void);
	void UPdate_Login(void);
	long UPGRADE(void);
	long VM_UPGRADE(void);
	void Alter_Table(void);
	void Table_Add(void);
	bool DB_Check(void);
	void UPGRADE_DBBACK(void);	//업그레이드 진행 시 DB 백업
	long BackDB_Check(void); 
	void RemoveDir(void);

	long TR11131(void);
	long TR13131(void);
	long Rev13131(void);
	long TR13132(void);
	long Rev13132(void);
	long TR13133(void);
	long Rev13133(void);
	long TR13134(void);
	long Rev13134(void);
	long TR13135(void);
	long Rev13135(void);
	long TR13136(void);
	long Rev13136(void);
	long TR13137(void);
	long Rev13137(void);
	long TR13138(void);
	long Rev13138(void);
	long TR13139(void);
	long Rev13139(void);
	long TR13140(void);
	long Rev13140(void);
	
	long TR685025(void);
	long Rev685025(void);	
	long TR685026(void);
	long Rev685026(void);
	long TR685027(void);
	long Rev685027(void);
	long TR685028(void);
	long Rev685028(void);

	bool CardUnitTester(void);
	void Table_Regum_Add(void);
	void Table_OldMtr_Add(void);
	void Table_C6101_CHK_BULD_CENTER_CD(void);
	
	//-----------------------------------------------------------------
	// 메인 다이얼로그(디폴트)
	//-----------------------------------------------------------------
	BEGIN_DIALOG_MAP(DlgRes)
	
		MAIN_DLG ("LOGIN", "MENU", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, WHITE, BLACK, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, 0, ICON_LOGO, ""),		//로고 이미지
/*		
		DLG_TEXT(STARTX+300, 2, 580, 50, 0, 0, EDITSTY_BORDER, 0, RED, TRANSPARENT, TXT_VERSION, ""),

		DLG_BUTTON(STARTX+103, STARTY+220, 780, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BLUE, CALL_FUNC, "", BID_LOGIN, "인 증"), //BTN_LOGINBK
		DLG_TEXT(STARTX+300,            2, 580, 50, 0, 0, EDITSTY_BORDER, 0, RED, TRANSPARENT, TXT_DATA1, ""),
		DLG_EDIT(STARTX+495,    STARTY+65, 368, 54, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_ID, m_ID_LEN,  ""),
		DLG_EDIT(STARTX+495,   STARTY+135, 370, 55, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_PW, m_PW_LEN,  ""),
		
		DLG_BUTTON(STARTX+795, STARTY+810, 150, 70, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC, "", BID_EXIT, ""),
*/

//시안 테스트
		DLG_TEXT(STARTX+400,   STARTY+22, 105, 80, 0, 0, EDITSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, TXT_REMOVE, ""),
		DLG_BUTTON(STARTX+65, STARTY+500, 860, 70, 0, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, BTNMENUFRCOLOR, RED, CALL_FUNC, "", BID_REMOVE, "수 동 설 치"), 

		DLG_TEXT(STARTX+320, 25, 580, 50, 0, 0, EDITSTY_BORDER, 0, RED, TRANSPARENT, TXT_VERSION, ""),

		DLG_BUTTON(STARTX+65, STARTY+410, 860, 70, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, TRANSPARENT, CALL_FUNC, "", BID_LOGIN, ""), //BTN_LOGINBK
	//	DLG_TEXT(STARTX+300,            2, 580, 50, 0, 0, EDITSTY_BORDER, 0, RED, TRANSPARENT, TXT_DATA1, ""),
		DLG_EDIT(STARTX+450,    STARTY+208, 470, 74, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, TRANSPARENT, EDT_ID, m_ID_LEN,  ""),
		DLG_EDIT(STARTX+450,   STARTY+306, 470, 74, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, TRANSPARENT, EDT_PW, m_PW_LEN,  ""),
		
		DLG_BUTTON(STARTX+760, STARTY+760, 180, 100, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC, "", BID_EXIT, ""), 

		//PNG 로드하기(경로를 정확히 적어야 한다.).
		CTR_PNG(PNG_LOGO,  PNG_COLOR_NORMAL, "main_bg"),
		
	END_DIALOG_MAP()

	//-----------------------------------------------------------------
	// 다이얼로그 PDA
	//-----------------------------------------------------------------
	BEGIN_DIALOG_MAP(DlgRes_P) 

		MAIN_DLG ("LOGIN", "MENU", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, WHITE, BLACK, BLUE, TITLE_HEIGHT, 0),

		DLG_ICON(0, 0, ICON_LOGO, ""),		//로고 이미지

		DLG_TEXT(STARTX+300, 10, 580, 50, 0, 0, EDITSTY_BORDER, 0, RED, TRANSPARENT, TXT_VERSION, ""),

		DLG_BUTTON(STARTX+70,	STARTY+420, 860, 75, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, TRANSPARENT, CALL_FUNC, "", BID_LOGIN, ""),
		DLG_BUTTON(STARTX+770,	STARTY+780, 175, 100, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC, "", BID_EXIT, ""),
		
		DLG_EDIT(STARTX+450,	STARTY+215, 450, 70, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, TRANSPARENT, EDT_ID, m_ID_LEN,  ""),
		DLG_EDIT(STARTX+450,	STARTY+315, 450, 70, 0, 0, EDITSTY_BORDER, 0, TXTFRCOLOR, TRANSPARENT, EDT_PW, m_PW_LEN,  ""),

		//PNG 로드하기(경로를 정확히 적어야 한다.).
		CTR_PNG(PNG_LOGO,    PNG_COLOR_NORMAL, "main_bg"),
		
	END_DIALOG_MAP()
	
	//-----------------------------------------------------------------
	//	main entry map
	//-----------------------------------------------------------------
	CARD_ENTRY_MAP()

	//-----------------------------------------------------------------
	bool CardUnitTester(void)
	{
		//카드 단위 테스터
		//리턴값을 TRUE 로 넘기면 그냥 로그인 된다.
		CALL_DEV_CARD();
				
	/*  //메신저 프로그램 호출 테스트 코드
		//PRINT("ndroid.mms com.android.mms.ui.Cndroid.mms com.android.mms.ui.Cndroid.mms com.android.mms.ui.C",0,0,0);
		//RunApp("com.android.mms com.android.mms.ui.ConversationList", "address 01122224444 sms_body test");
		
		//RunApp("com.google.android.apps.messaging com.google.android.apps.messaging.ui.ConversationListActivity", "");
		//RunApp("com.google.android.apps.messaging com.google.android.apps.messaging.ui.ConversationListActivity", "address 01122224444");
	*/
		//Card_Move("MENU");
		//return -1;
		
		return FALSE;
	}	

	//-----------------------------------------------------------------
	// call back event function
	//-----------------------------------------------------------------
	void	OnInit(char bFirst)
	{	
		long nRet;
		long i = 0;
		char szFont[10];
		char szBarFlag[10];
		
		//PRINT ("g_pExtLoadModule = 0x%x",g_pExtLoadModule,0,0);
		
		//반드시 최초로 실행된 모듈에 대한 콜백을 설정해야 한다.
		SetExtLoadModule(g_LoadGlobal);
		
		LoadCardGui();

		//2017-09-15 Sanghyun Lee
		//Push 업그레이드 설치 코드
		//g_Push_GetValue("isDownloadedVm");
		//g_lUpgradeChk = 0;
		
		g_nBackFlag = 0;
		
		//theDevInfo.m_nFontType     = FONT_36

		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			//2017-08-22 Sanghyun Lee
			//추후 글자크기 & 설정바코드 변경 적용 일정 협의 후 배포
			Mem_Set( (byte*)szFont, 0x00, sizeof(szFont) );
			g_Sql_RetStr("SELECT FONT_SIZE FROM USER_INFO", 4, szFont);
			i = Str_AtoI(szFont);
			//PRINT("FONT >>>>>>>>>>>>>> i : %d",i,0,0);
			switch(i)
			{
				case 1:
					theDevInfo.m_nFontType     = FONT_30;
					break;
				case 2:
					theDevInfo.m_nFontType     = FONT_32;
					break;
				case 3:
					theDevInfo.m_nFontType     = FONT_34;
					break;
				case 4:
					if (theDevInfo.m_nType >= FAMILY_MIDDLE)
					{
						theDevInfo.m_nFontType = FONT_54;
					}
					else
					{
						theDevInfo.m_nFontType = FONT_36;
					}
					break;
				default:
					theDevInfo.m_nFontType     = FONT_36;
					break;
			}
	
			//2017-08-22 Sanghyun Lee
			//바코드 셋팅 관련(#define CHG_OPTION , globalcard.h 확인)
			Mem_Set( (byte*)g_szBarcodeSet, 0x00, sizeof(g_szBarcodeSet) );
			g_Sql_RetStr("SELECT BARCODE_FLAG FROM USER_INFO", 4, g_szBarcodeSet);
		}
		else
		{
			//2017-08-22 Sanghyun Lee
			//추후 글자크기 & 설정바코드 변경 적용 일정 협의 후 배포
			Mem_Set( (byte*)szFont, 0x00, sizeof(szFont) );
			g_Sql_RetStr("SELECT FONT_SIZE FROM USER_INFO", 4, szFont);
			i = Str_AtoI(szFont);
			//PRINT("FONT >>>>>>>>>>>>>> i : %d",i,0,0);
			switch(i)
			{
				case 1:
					theDevInfo.m_nFontType     = FONT_8;
					break;
				case 2:
					theDevInfo.m_nFontType     = FONT_10;
					break;
				case 3:
					theDevInfo.m_nFontType     = FONT_12;
					break;
				case 4:
					theDevInfo.m_nFontType     = FONT_14;
					break;
				default:
					theDevInfo.m_nFontType     = FONT_14;
					break;
			}
		}
		
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG (DlgRes_P);			
						break;
					default:
						CREATE_DIALOG (DlgRes);
						break;
				}
				
				//VM 및 APP 버전 정보 스트럭쳐 셋팅
				VM_GetAppInfo(&m_stAppinfo);
				VM_GetVersion(&m_stVminfo);

				if( DB_Check() )
				{
					REDRAW();
					
					//SetStyle 함수 기능 -> 1.text 및 edit 텍스트정렬 , 2.build 날짜 설정
					SetStyle();

					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_ID), stUserinfo.szemployee_id);
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_PW));
					
					if( theDevInfo.m_nType > FAMILY_PDA )
					{
						DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_REMOVE), FALSE);
					}
				}

				ON_DRAW();
				break;
		}
	}

	//-------------------------------------------------------------------
	void	OnKey(long nKey)
	{
		long i;

		//PRINT(">>>>>>>>>>>>>>>>>>>nKey : %d",nKey,0,0);

		return;
	}
	
	//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long i;
		
		//PRINT(">>>>>>>>>>>>>>>>>>>nChar : %d",nChar,0,0);
		
		return;
	}

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{	
		char szVer[15];
		char szDay[30];
		char szVerDay[10];
		char szVerMonth[10];
		char szbuf[30];
		long nRet;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_LOGO), 0, Get_hSlfCtrlFromID(PNG_LOGO));
		//ButCtrl_SetImage( Get_hDlgCtrlByID(BID_EXIT),  g_pImgMainExit);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VERSION), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_ID), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_PW), EDITALIGN_MIDDLE);
		EditCtrl_ModifyStyle( Get_hDlgCtrlByID(EDT_PW), 0, EDITSTY_HIDDEN);

		//2016-05-24 Sanghyun Lee , 버전업데이트시 빌드한 날짜가 찍히도록 변경.
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Mem_Set( (byte*)szVerMonth, 0x00, sizeof(szVerMonth) );
		if( BUILDTM_MONTH < 10 && BUILDTM_MONTH > 0 )
		{
			Str_ItoA(BUILDTM_MONTH, szbuf, 10);
			Str_Cpy(szVerMonth, "0");
			Str_Cat(szVerMonth, szbuf);
		}
		else
		{
			Str_ItoA(BUILDTM_MONTH, szVerMonth, 10);
		}

		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Mem_Set( (byte*)szVerDay, 0x00, sizeof(szVerDay) );
		if( BUILDTM_DAY < 10 && BUILDTM_DAY > 0 )
		{
			Str_ItoA(BUILDTM_DAY, szbuf, 10);
			Str_Cpy(szVerDay, "0");
			Str_Cat(szVerDay, szbuf);
		}
		else
		{
			Str_ItoA(BUILDTM_DAY, szVerDay, 10);
		}

		Mem_Set( (byte*)szVer, 0x00, sizeof(szVer) );
		Mem_Set( (byte*)szDay, 0x00, sizeof(szDay) );
		SPRINT(szDay, "%d%s%s.", BUILDTM_YEAR, szVerMonth, szVerDay);
		Str_ItoA(m_stAppinfo.wAppVersion, szVer, 10);
		Str_Cat(szDay, szVer);

		EditCtrl_SetFont(Get_hDlgCtrlByID(TXT_VERSION), theDevInfo.m_nFontSmallType);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VERSION), szDay);
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VERSION), "개발");
		
		g_nWorkFlag = 0;
	}		

	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		char szTmp[100];
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			//pointing up되는 좌표로 판단해서 올리면.
			if( POINTING_UP == nAction )
			{
				//if( X > DMS_X(500) && X < DMS_X(869) && Y > DMS_Y(165) && Y < DMS_Y(219) )
				if(  X > DMS_X(STARTX+400) && X < DMS_X(STARTX+505) && Y > DMS_Y(STARTY+22) && Y < DMS_Y(STARTY+102) )
				{
					m_lChkCnt++;
	
					if( m_lChkCnt > 2 )
					{
						DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_REMOVE), TRUE);
						
						m_lChkCnt = -999;
					}
				}
				else if( X > DMS_X(STARTX+450) && X < DMS_X(STARTX+920) && Y > DMS_Y(STARTY+208) && Y < DMS_Y(STARTY+282) )
				{
					m_lActiveIndex = lActiveIndex;
					if( Get_iDlgCtrlByID(EDT_ID) == lActiveIndex )			
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					
						//SetKeyMode(KEYMODE_NUMBER);
						
						//lret = GetKeyMode();
	
						ShowSip(TRUE);
						g_Sipflag = 1;
						
						m_lChkCnt = 0;
					}
				}  
				else if( X > DMS_X(STARTX+450) && X < DMS_X(STARTX+920) && Y > DMS_Y(STARTY+306) && Y < DMS_Y(STARTY+380) )
				{
					m_lActiveIndex = lActiveIndex;
					if( Get_iDlgCtrlByID(EDT_PW) == lActiveIndex )
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					
						//SetKeyMode(KEYMODE_ENGLISH);
						
						//lret = GetKeyMode();
	
						ShowSip(TRUE);
						g_Sipflag = 1;
						
						m_lChkCnt = 0;
					}
				}
				else
				{
					m_lChkCnt = 0;
					
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
			}
		}
		
		ON_DRAW();
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{
		long nRet;
		char szTmp[256];
		char szKey[15];
		char* pBuf;

		switch(ID)
		{
			case BID_LOGIN:

				if (CardUnitTester() == TRUE)
				{
					M();
					M([경고!]카드테스터가 실행되었습니다.);
					M();
					return;
				}
				
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_ID)), DEV_LOGIN_USER) == 0 )
				{
					if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PW)), DEV_LOGIN_PASS) == 0 )
					{
						Card_Move( DEV_LOGIN_MENU );
						return;
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "사원번호 또는 비밀번호를\n확인해 주세요.");
						return;
					}
				}
				else
				{
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
					g_Sql_RetStr("SELECT LOCK_YN FROM USER_INFO", 4, szTmp);
					if( Str_Cmp(szTmp, "Y") == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "원격잠금상태입니다.\n전산실에 문의하세요.");
					}
					else
					{
						LOGIN_PROS();
					}
				
					//LOGIN_PROS();

					/*
					//인터넷안될때 로그인 코드
					Str_ItoA( Time_GetDate(), stUserinfo.szloginday, 10);
					SPRINT(szTmp, "update user_info set loginday = '%s'", stUserinfo.szloginday,0,0);
					g_Sql_DirectExecute(szTmp);
					//Card_Move("C6202_AUCTIONLST");
					Card_Move("MENU");
					*/
				}
				break;			
			case BID_CHANGE:
				//브라우저를 통한 apk 다이렉트 다운 주소
				//RunApp( "WEBVIEWER", "https://smartver.seoulgas.co.kr/static/files/engine/7874731598.apk" );
				//RunApp( "WEBVIEWER", "file://mnt/sdcard/Smart/www/index.html" );

				//Webview Test 코드(코르도바)
				//WebView_LoadUrl("file://mnt/sdcard/Smart/www/index.html");
				break; 
			case BID_REMOVE:
				if( MessageBoxEx (CONFIRM_YESNO, "시스템을 재설치 합니다.\n[주의!]현재 작업중인 데이터는\n모두 삭제됩니다.\n그래도 하시겠습니까?")  == MB_OK)
				{
					RunApp("WEBVIEWER","file://mnt/sdcard/install.html");
					
					RemoveDir();
					
					VM_AmEnd();
				}
				break;
			case BID_EXIT:
				VM_AmEnd();
				break;
		}
	}
	
	//---------------------------------------------------------------------------------------
	bool DB_Check(void)
	{
		bool ret = TRUE;
		char szRet[128];
		char szbuf[256];
		long nUserinfo, nTblRegist;
		long nBackDbChk = 0;
		handle hdb = NULL;
		SQLITE sql = NULL;
		
		if(FFS_Exist("APP_DBF") <= 0)
		{
			FFS_CreateDir(DIR_DBF);
		}

		//업무용폴더생성
		FFS_CreateDir(PHOTO_GM);
		FFS_CreateDir(PHOTO_SC);
		FFS_CreateDir(PHOTO_SCMTR);
		FFS_CreateDir(PHOTO_SCBUR);
		FFS_CreateDir(PHOTO_SCBOIL);
		FFS_CreateDir(PHOTO_SCBAR);
		FFS_CreateDir(PHOTO_SCREFUSE);
		FFS_CreateDir(PHOTO_SCABSENCE);
		FFS_CreateDir(PHOTO_JO);
		FFS_CreateDir(PHOTO_BS);
		FFS_CreateDir(PHOTO_BSBAR);
		FFS_CreateDir(PHOTO_BF);
		FFS_CreateDir(PHOTO_MW);
		FFS_CreateDir(PHOTO_GC);
		FFS_CreateDir(PHOTO_NP);
		FFS_CreateDir(PHOTO_BIZ);
		FFS_CreateDir(PHOTO_WORK);
		FFS_CreateDir(OZ_FILE);
		FFS_CreateDir(PHOTO_GMMTR);
		FFS_CreateDir(PHOTO_GMCOMPENS);
		
		//DB백업용 폴더생성 , DIR_BACKDBF : 클라이언트 백업 , UP_BACKDBF : VM업그레이드시 백업
		FFS_CreateDir(DIR_BACKDBF);
		FFS_CreateDir(UP_BACKDBF);
		
		//업무용 데이터베이스 확인
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		if( FFS_Exist(szbuf) )
		{
			sql = NewSqLite();
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				DelSqLite(sql);
				
				MessageBoxEx (CONFIRM_OK, "잘못된 데이터베이스입니다.\n프로그램을 재설치 하세요.");

				EvtExit();
				g_ImgFree();
				VM_AmEnd();
				ret = FALSE;
				return ret;
			}
			else
			{
				DelSqLite(sql);
				
				//DB확인, USER_INFO && TBL_REGIST 확인
				nUserinfo = 0;
				nTblRegist = 0;

				g_Sql_RetInt( "SELECT COUNT(*) FROM USER_INFO", &nUserinfo );
				g_Sql_RetInt( "SELECT COUNT(*) FROM TBL_REGIST", &nTblRegist );

				if( nUserinfo <= 0 || nTblRegist <= 0 )
				{
					//백업폴더의 DB 확인하여 정상적인 DB인지 체크
					nBackDbChk = BackDB_Check();
					
					if( nBackDbChk > 0 )
					{
						//업무DB가 이상하고 백업DB가 정상이라면 백업된 DB로 복원
						if( FFS_Exist("APP_DBF/SCGGAS.db") )
						{
							FFS_Delete("APP_DBF/SCGGAS.db");
						}
					
						//2016-06-29 Sanghyun Lee
						//2010000 버전으로 업데이트 시 BackDB_Check함수도 체크하여 복원DB 경로 수정해야함
						//VM 업그레이드시 백업되는 DB 복원하는 코드
						//FFS_Copy("DBF_BAK/SCGGAS.db", "APP_DBF/SCGGAS.db");
						
						//상시 백업되는 DB로 복원하는 코드
						FFS_Copy("APP_BACKDB/SCGGAS.db", "APP_DBF/SCGGAS.db");
					}
				}
			}
		}
		else
		{	
			
			//INIT_DBF에 깡통 DB가 존재하므로 그것을 복사해서 이와같은 상황이 발생되지 않도록 코딩 해야함.
			//VM에서 'INIT_DBF'라는 폴더를 생성해서 DB를 넣어줌
			FFS_Copy("INIT_DBF/SCGGAS.db", "APP_DBF/SCGGAS.db");
			
			VmSleep(200);
			
			/*
			//2016-09-05 INIT_DBF폴더의 깡통DB 복사 코드 추가
			ret = FALSE;
			
			MessageBoxEx (CONFIRM_OK, "데이터베이스가 존재하지않습니다.\n프로그램을 재설치 하세요.");

			if( g_nTimerID != 0 )
				Timer_Kill(g_nTimerID);
			
			//배경이미지
			EvtExit();
			g_ImgFree();
			VM_AmEnd();
			
			return ret;
			*/
			
		}
		
		if(FFS_Exist("SCGGAS/install.html") > 0)
		{
			Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
			Mem_Set((byte*)szRet, 0x00, sizeof(szRet));	
			Str_Cpy(szbuf, "SCGGAS/install.html");
			Str_Cpy(szRet, "../install.html");
			
			if( FFS_Exist(szRet) > 0 )
			{
				FFS_Delete(szRet);
				
				VmSleep(50);
			}
			
			FFS_Copy(szbuf, szRet);
		}
		
		Alter_Table();
		return ret;
	}

	//---------------------------------------------------------------------------------------
	//DB 테이블 관련 수정 함수
	void Alter_Table(void)
	{
		char szSql[1000];
		char szBackPath[200];
		char szPath[200];
		char szBuf[200];
		long nRet = 0;
		long nSqlRet = 0;
		
		long nCopyRet_1 = -1;
		long nCopyRet_2 = -1;
		long nCopyRet_3 = -1;
		long nCopyRet_4 = -1;
		long nCopyRet_5 = -1;
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Str_Cpy(szSql, "SELECT MAX(SEQ) FROM TBL_REGIST");	
		g_Sql_RetInt( szSql, &nRet );
		//PRINT("nRet : %d",nRet,0,0);

		switch(nRet)
		{
			case 0:
				//TBL_REGIST , '1', '20160601', '특정점검 계량기 메모 컬럼 추가'
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_MTR ADD COLUMN [MEMO] VARCHAR(100)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(1, '20160601', '특정점검 계량기 메모 컬럼 추가')");
				g_Sql_DirectExecute( szSql );
		
				nRet++;
			case 1:
				//TBL_REGIST , '2', '20160624', '1.VPN 적용 2.DB 백업&롤백 시점 수정' 3.UPGRADE 여부 확인 필드 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE USER_INFO ADD COLUMN [LOGIN_CHK] VARCHAR(5)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(2, '20160629', '1.VPN 적용 2.로그인확인 필드 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );
					
				nRet++;

			case 2:
				//Client 45 버전 -> 1.보일러 & 연소기 제조사 정렬 필드 추가 2.달력 년 단위 이동 버튼 추가
				//TBL_REGIST , '3', '20161007', '1.보일러 및 연소기 제조사(USE_MAKER) 정렬 컬럼 추가
				//BOILER_SEQ -> 보일러 , BURNER_SEQ -> 연소기
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE USE_MAKER ADD COLUMN [BOILER_SEQ] NUMBER(3)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE USE_MAKER ADD COLUMN [BURNER_SEQ] NUMBER(3)");
				nSqlRet = g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(3, '20161007', '보일러 및 연소기 제조사(USE_MAKER) 정렬 컬럼 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			
			case 3:
				//Client 56 버전 -> 1.체납 중지대상 리스트 컬럼 추가.
				//TBL_REGIST , '4', '20170711', '1.체납 중지대상 리스트 컬럼 추가.
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6202_STOP_OBJ ADD COLUMN [PAYCONFIRM_FLAG] VARCHAR(5)");
				g_Sql_DirectExecute( szSql );
			
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(4, '20170711', '체납 중지대상 리스트 컬럼(PAYCONFIRM_FLAG) 추가.')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;

			case 4:
				//Client 59 버전 -> 1.VM Ver 2014001 & Client 59 배포 2.전 고객센터 배포 3.DB 교체
				//TBL_REGIST , '4', '20170711', '1.체납 중지대상 리스트 컬럼 추가.
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(5, '20170723', '1.VM Ver 2014001 & Client 59 배포 2.전 고객센터 배포 3.DB 교체')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				//DB 테이블 및 컬럼 추가!!
				Table_Add();

				nRet++;

			case 5:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_BUR ADD COLUMN [PLUG_NOGOOD_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				//Client 63 버전 -> 1.안전점검 연소기점검 '플러그마감미비' 점검 관련 flag 추가
				//TBL_REGIST , '5', '20170804', 1.안전점검 연소기점검 '플러그마감미비' 점검 관련 flag 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(6, '20170804', '1.안전점검 연소기점검 플러그마감미비 점검 관련 flag 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 6:
				//안전점검 입상관점검 테이블
				g_Sql_DirectExecute("CREATE TABLE IF NOT EXISTS [NORMAL_STANDPIPE_CHK_RSLT] ( \
									[CHK_YEAR]	CHAR(4) NOT NULL, \
									[CHK_ORDER]	CHAR(2) NOT NULL, \
									[CHK_TYPE]	CHAR(2) NOT NULL, \
									[BLD_NUM]	CHAR(9) NOT NULL, \
									[CHK_EMPID]	CHAR(9), \
									[CHKER_NM]	VARCHAR2(12), \
									[CHK_YMD]	CHAR(8), \
									[CHK_TIME]	CHAR(6), \
									[GAS_LK]	CHAR(2), \
									[PIPE_RUST]	CHAR(2), \
									[STAND_PIPE_PROTE_INST]	CHAR(2), \
									[PIPE_CNT]	NUMERIC, \
									[SEND_YN]	CHAR(2), \
									PRIMARY KEY([CHK_YEAR],[CHK_ORDER],[CHK_TYPE],[BLD_NUM])) "
									);
				
				//안전점검 대상테이블 입상관점검 컬럼 추가
				g_Sql_DirectExecute( "ALTER TABLE NORMAL_DATA ADD COLUMN [PIPE_NUM] VARCHAR(12)" );


				//Client 67 버전 -> 1.안전점검 입상관점검 테이블 추가 2.안전점검 대상테이블 입상관점검 컬럼 추가
				//TBL_REGIST , '7', '20170921', 1.안전점검 입상관점검 테이블 추가 2.안전점검 대상테이블 입상관점검 컬럼 추가
				nSqlRet = g_Sql_DirectExecute( "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(7, '20170921', '1.안전점검 입상관점검 테이블 추가 2.안전점검 대상테이블 입상관점검 컬럼 추가')" );

				nRet++;
			case 7:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [COMPENS_REMOVE_ALARM] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				//Client 74 버전 -> 1.검침 보정기철거 알림 flag 추가
				//TBL_REGIST , '8', '20171102', 1.검침 보정기철거 알림 flag 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(8, '20171102', '1.검침 보정기철거 알림 flag 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 8:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_MTR ADD COLUMN [INSIDE_MTR_PHOTO_ID] NUMERIC(30)");
				g_Sql_DirectExecute( szSql );

				//Client 75 버전 -> 1.안전점검 계량기 내부 사진 ID 컬럼 추가
				//TBL_REGIST , '9', '20171120', 1.안전점검 계량기 내부 사진 ID 컬럼 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(9, '20171120', '1.안전점검 계량기 내부 사진 ID 컬럼 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 9:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [SPECIAL_TAX_EXEMP_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [ZERO_TAX_RT_APPLY_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				//Client 76 버전 -> 1.민원 특소세면제여부 컬럼 추가 2.민원 영세율적용여부 컬럼 추가
				//TBL_REGIST , '10', '20171129', 1.민원 특소세면제여부 컬럼 추가 2.민원 영세율적용여부 컬럼 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(10, '20171129', '1.민원 특소세면제여부 컬럼 추가 2.민원 영세율적용여부 컬럼 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 10:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE USER_INFO ADD COLUMN [FONT_SIZE] VARCHAR(5)");
				g_Sql_DirectExecute( szSql );
		
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE USER_INFO ADD COLUMN [BARCODE_FLAG] VARCHAR(5)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE RCV_LOG ADD COLUMN [PARAM11] INT");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [GET_SPC_TAX_CHK] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				//Client 80 버전 -> 1.폰트 사이즈 저장 컬럼 추가
				//TBL_REGIST , '11', '20180118', 1.폰트 사이즈 저장 컬럼 추가 2.셋팅 바코드 저장 3.군부대 사업자 체크
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(11, '20180118', '1.폰트 사이즈 저장 컬럼 추가 2.셋팅 바코드 저장 3.군부대 사업자 체크')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				//글자크기 및 바코드 기본 값 셋팅
				if( theDevInfo.m_nType != FAMILY_PDA )
				{	
					g_Sql_DirectExecute("UPDATE USER_INFO SET FONT_SIZE = '4', BARCODE_FLAG = 'B'");
				}
				else
				{
					g_Sql_DirectExecute("UPDATE USER_INFO SET FONT_SIZE = '2', BARCODE_FLAG = 'B'");
				}

				nRet++;
			case 11:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [MTR_DIGIT_CNT] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				//Client 81 버전 -> 1. 검침 계량기 자릿수 추가
				//TBL_REGIST , '12', '20180125', 1. 검침 계량기 자릿수 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(12, '20180125', '1. 검침 계량기 자릿수 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 12:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE USER_INFO ADD COLUMN [COMMON_VER_NUM] VARCHAR(12)");
				g_Sql_DirectExecute( szSql );

				//Client 84 버전 -> 1.공통코드버전 컬럼 추가
				//TBL_REGIST , '13', '20180313', 1.공통코드버전 컬럼 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(13, '20180313', '1.공통코드버전 컬럼 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 13:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [BILL_SEND_METHOD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [BILL_SEND_CP_DDD] VARCHAR(4)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [BILL_SEND_CP_EXN] VARCHAR(4)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [BILL_SEND_CP_NUM] VARCHAR(4)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [BILL_SEND_EMAIL] VARCHAR(50)");
				g_Sql_DirectExecute( szSql );
				
				//Client 85 버전 -> 1.청구방법코드, 핸드폰번호, 이메일 추가
				//TBL_REGIST , '14', '20180328', 1.청구방법코드, 핸드폰번호, 이메일 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(14, '20180328', '1.청구방법코드, 핸드폰번호, 이메일 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 14:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [MTR_PHOTO_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [PLACE_PHOTO_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [INDUCTION_INST_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [SOCIAL_WELF_FACI_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [DEADLINE_FLAG] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_INFO ADD COLUMN [INDUCTION_INST_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_INFO ADD COLUMN [FACI_STS_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_INFO ADD COLUMN [CHK_YMD] VARCHAR(9)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_MTR ADD COLUMN [SOCIAL_WELF_FACI_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
			
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_MTR ADD COLUMN [FACI_STS_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				//Client 94 버전 -> 1.청구방법코드, 핸드폰번호, 이메일 추가
				//TBL_REGIST , '15', '20180709', 1. 민원 실시간 관련 2. 안전점검 관련
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(15, '20180706', '1. 민원 실시간 관련 2. 안전점검 관련')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 15:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_NONPAY ADD COLUMN [CARD_LIST_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_MTR ADD COLUMN [CARD_LIST_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE USER_INFO ADD COLUMN [ONECARD_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(16, '20180716', '1. 카드리스트 YN 2. 일회성요금 YN')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 16:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_DATA ADD COLUMN [TEMP_INST_BAR_PHOTO_ID] NUMBER(30)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_DATA ADD COLUMN [TEMP_INST_BAR_PHOTO_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_DATA ADD COLUMN [BAR_RCV_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(17, '20180731', '1. 특정 바코드 사진 ID 2. 바코드 송신여부')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 17:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [SOCIAL_WELF_DISC_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE NORMAL_MTR ADD COLUMN [RCV_PROD_CD] VARCHAR(5)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(18, '20180820', '1. 약속배정 사회복지 3. 수신상품코드')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 18:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_DATA ADD COLUMN [PREUSE_CHK_WHY] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_NOGOOD_DETAL ADD COLUMN [PRE_CHK_OBJ_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(19, '20180821', '1. 우선특정점검')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 19:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [SELF_GMTR_STR_YMD] VARCHAR(8)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [SELF_GMTR_END_YMD] VARCHAR(8)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [BEFO_GMTR_SMS_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(20, '20180905', '1. 자가검침')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 20:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [GMTR_MANAGE_STS] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(21, '20180918', '1. 검침관리상태')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 21:
				g_Sql_DirectExecute("CREATE TABLE IF NOT EXISTS [C6101_PROMISE_CHK] ( \
									[PROMISE_ASSIGN_SEQ]	 NUMERIC(10) NOT NULL, \
									[CIVIL_SERV_RECEIVE_NUM] VARCHAR(14), \
									[TREAT_SEQ]				 NUMERIC(10), \
									[ACC_TAKE_ACT]			CHAR(2), \
									[ACC_CAUSE]				CHAR(2), \
									[ACC_CAUSE_RMK]			VARCHAR2(50), \
									[ACC_LOC1]				CHAR(2), \
									[ACC_LOC2]				CHAR(2), \
									[ACC_LOC_RMK]			VARCHAR2(50), \
									[SEND_YN]				VARCHAR(1), \
									PRIMARY KEY([PROMISE_ASSIGN_SEQ]))"
								   );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(22, '20181001', '1. 민원 가스누출')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			case 22:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [PHOTO_BUR_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [APPRO_STATUS_FLAG] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [APPRO_GUBUN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(23, '20181011', '1. 연소기사진FLAG 2. 현금영수증')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 23:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE NORMAL_NOGOOD ADD COLUMN [CONT_STS_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(24, '20181029', '1. 개선권고 계약상태')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 24:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_NOPAY_OBJ ADD COLUMN [USE_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_NOPAY_OBJ_PART ADD COLUMN [USE_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_STOP_OBJ ADD COLUMN [USE_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE RCV_LOG ADD COLUMN [PARAM12] CHAR(20)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE RCV_LOG ADD COLUMN [PARAM13] CHAR(20)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(25, '20181121', '1. 체납')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 25:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE NORMAL_BUR ADD COLUMN [BUR_RSLT] VARCHAR(1)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(26, '20181203', '1. 안전점검')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 26:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_NOPAY_OBJ ADD COLUMN [EXCEP_TEL_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_NOPAY_OBJ ADD COLUMN [STOP_SMS_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_NOPAY_OBJ_PART ADD COLUMN [EXCEP_TEL_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_NOPAY_OBJ_PART ADD COLUMN [STOP_SMS_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_STOP_OBJ ADD COLUMN [EXCEP_TEL_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6202_STOP_OBJ ADD COLUMN [STOP_SMS_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(27, '20190102', '1. 체납문자송신제한 2.체납중지문자')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;	
			case 27:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [PHOTO_BOIL_YN1] VARCHAR(1)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [PHOTO_BOIL_YN2] VARCHAR(1)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [OLD_BOILER_YN] VARCHAR(1)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(28, '20190108', '1. 안전점검 보일러 사진')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 28:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [PHOTO_BAR_YN] VARCHAR(1)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(29, '20190115', '1. 안전점검 바코드 사진')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 29:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [DEADLINE_CHG_YN] VARCHAR(1)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [COMPENS_REMOVE_ALARM_2] VARCHAR(1)");
				g_Sql_DirectExecute( szSql );
				
				g_Sql_DirectExecute("CREATE TABLE IF NOT EXISTS [GUM_COMPENS_REMOVE_REQ] ( \
									[REQ_YM]	 		VARCHAR(6) NOT NULL, \
									[DEADLINE_FLAG] 	VARCHAR(2) NOT NULL, \
									[MTR_NUM]			VARCHAR(9) NOT NULL, \
									[USE_CONT_NUM]		VARCHAR(10), \
									[REMOVE_REQ_YMD]	VARCHAR(2), \
									[REMOVE_REQ_TIME]	VARCHAR(8), \
									[REMOVE_REQ_EMPID]	VARCHAR(9), \
									[CONF_NM]         	VARCHAR(30), \
									[SIGN]				TEXT, \
									[SEND_YN]			VARCHAR(1), \
									PRIMARY KEY ([REQ_YM], [DEADLINE_FLAG], [MTR_NUM]))"
								   );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(30, '20190304', '1. 검침 납기변경여부, 2.보정기삭제알림 ')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 30:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE USER_INFO ADD COLUMN [RECOMMENDER_ID] VARCHAR(9)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(31, '20190421', '1. 추천인코드')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 31:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [OLD_COMPENS_REMOVE_ALARM_2] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(32, '20190430', '1. 보정기고장서명전달')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 32:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [INFO_TRANS_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [SEND_INFO_TRANS_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );


				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(33, '20190521', '1. 민원 이관여부YN')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 33:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE RCV_TMP ADD COLUMN [PARAM101] VARCHAR(3000)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(34, '20190527', '1. 사진')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			case 34:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE NORMAL_NOGOOD_DETAL ADD COLUMN [EXCEP_PREUSE_CHK] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(35, '20190620', '1. 우선점검제외')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
				
			case 35:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE BO_INST ADD COLUMN [SEQ] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(36, '20191004', '1. 보일러시공순서')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			
			case 36:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE NORMAL_VISIT ADD COLUMN [VISIT_TIME] VARCHAR(6)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(37, '20191226', '1. 방문시간')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
				
			case 37:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [PHOTO_MTR_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [PHOTO_COMPENS_VC_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [PHOTO_COMPENS_VA_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [PHOTO_COMPENS_VM_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
					
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(38, '20200213', '1. 계량기, 보정기 사진')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			
			case 38:
				Table_Regum_Add();
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(39, '20200612', '1. 검침')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
				
			case 39:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [USE_CONT_STS_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [CONT_STS_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6501_NOTICE ADD COLUMN [NOTICE_DESC2] VARCHAR(3000)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(40, '20200812', '1. 검침')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			
			case 40:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE REGUMDATA ADD COLUMN [USE_CONT_STS_CD] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(41, '20200901', '1. 재검')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
					
			case 41:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [CO_ALARM_INST_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [KIT_AUTO_EXTINGU_INST_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(42, '20201012', '1. 설치장소점검')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
				
			case 42:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [REMOTE_MTR_ERR_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(43, '20210204', '1. sms_view')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
				
			case 43:	
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE REGUMDATA ADD COLUMN [REMOTE_MTR_ERR_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(44, '20210312', '1. 검침')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
				
			case 44:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_MTR ADD COLUMN [MTR_DETA_LOC] VARCHAR(30)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_BUR ADD COLUMN [DETA_LOC] VARCHAR(30)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [CRT_DTM] VARCHAR(30)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [INST_YMD] VARCHAR(8)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [DETA_LOC] VARCHAR(30)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [NEW_DISJOINT_CHK_YMD] VARCHAR(8)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [NEW_DISJOINT_CHK_FIRM_CD] VARCHAR(3)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [NEW_DISJOINT_CHK_FIRM_NM] VARCHAR(30)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(45, '20210604', '1. 특정')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			
			case 45:	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE SPECIAL_NOGOOD_DETAL ADD COLUMN [MTR_ID_NUM] VARCHAR(20)");
				g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(46, '20210709', '1. 특정부적합')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;

			case 46:
               Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			   Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [COMM_NUM] VARCHAR(16)");
  			   g_Sql_DirectExecute( szSql );

			   Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			   Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [COMM_FIRM] VARCHAR(2)");
  			   g_Sql_DirectExecute( szSql );				 
						
			   Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			   Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [INFLOW_FLAG] VARCHAR(2)");
  			   g_Sql_DirectExecute( szSql );				 					

			   Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			   Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(47, '20211201', '1. AMI계량기')");
    		   nSqlRet = g_Sql_DirectExecute( szSql );
				
			   nRet++;	

			case 47:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_BUR ADD COLUMN [INDUCTION_INST_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );			

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_ASSIGN ADD COLUMN [PROD_CHG] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(48, '20220121', '1. 상품계약변경추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 48:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [CRT_EMPID] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(49, '20220124', '1. 메모 공개여부')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 49:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [CHK_VISIBLE_YN] VARCHAR(1)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(50, '20220126', '1. 메모 공개여부')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 50:	

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );			
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_MTR ADD COLUMN [PROD_CHG] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(51, '20220209', '1. 상품계약변경추가 (PROD_CHG)')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 51:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_NOGOOD_DETAL ADD COLUMN [BETTER_PHOTO] TEXT");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(52, '20220415', '1. 특정점검 개선사진')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					  			   

			case 52:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [GMTR_JOB_YMD_END] VARCHAR(8)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(53, '20220427', '1. 자가검침 계량기내부 점검')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					  			      

			case 53:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [CHK_REJECT] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(54, '20220627', '1. 거부 및 부재 체크')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					  			      

			case 54:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [ZONE_MANAGE_NUM] VARCHAR(5)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(55, '20220908', '1. 구역관리번호번호 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					  			      

			case 55:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [REMOTE_GMTR_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(56, '20220916', '1. 원격검침 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					  			      

			case 56:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [RECENT_INDI_MTR_MM_VC] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(57, '20220919', '1. 원격검침지침 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 57:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE GUMDATA ADD COLUMN [RECENT_GMTR_JOB_YMD] VARCHAR(8)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(58, '20220920', '1. 원격검침일자 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 58:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE REGUMDATA ADD COLUMN [RECENT_INDI_MTR_MM_VC] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(59, '20220929', '1. 원격검침지침 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 59:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE REGUMDATA ADD COLUMN [RECENT_GMTR_JOB_YMD] VARCHAR(8)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(60, '20220929', '1. 원격검침일자 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 60:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE REGUMDATA ADD COLUMN [REMOTE_GMTR_YN] VARCHAR(2)");
				g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(61, '20220929', '1. 원격검침 추가')");
				nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		

			case 61:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE REGUMDATA ADD COLUMN [ZONE_MANAGE_NUM] VARCHAR(5)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(62, '20220929', '1. 구역관리번호번호 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	
			case 62:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_BUR ADD COLUMN [INST_FLAG_NM] VARCHAR(20)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(63, '20221021', '1. 설치구분명 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					

			case 63:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [SET_YMD] VARCHAR(1)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(64, '20221025', '1. 분해점검일 4년경과 컬럼명')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;			

			case 64:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_DATA ADD COLUMN [INFO_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(65, '20221031', '1. 특정정보 확인Flag 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	


			case 65:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_BUR ADD COLUMN [WORK_YMD] VARCHAR(8)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(66, '20221101', '1. 서류접수일')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	


			case 66:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_BUR ADD COLUMN [WORK_FIRM] VARCHAR(50)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(67, '20221101', '1. 시공사')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;			

			case 67:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_MTR ADD COLUMN [REMOTE_MTR_YN] VARCHAR(1)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(68, '20221208', '1. AMI계량기')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 68:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [NOBILL_YN] VARCHAR(1)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(69, '20221220', '1. 무전표계량기')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					

			case 69:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [PROD_CONT_SEQ] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(70, '20221229', '1. 무전표계량기 상품순번')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					

			case 70:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [BULD_CENTER_CD] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(71, '20221230', '1. 건물센터코드')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 71:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [REPL_TREAT_INSTI] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(72, '20230104', '1. 교체처리기관')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 72:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [NO_BILL_REPL_WHY] VARCHAR(9)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(73, '20230104', '1. 무전표교체사유')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 73:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [COMM_NUM_24] VARCHAR(24)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(74, '20230309', '1. 통신번호 24자리수로 늘임 ')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 74:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [NON_PAY_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(75, '20230517', '1. 체납세대 확인')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;		
			
			case 75:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_BUR ADD COLUMN [SPECIAL_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );			

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(76, '20230704', '1. 특정계량기여부')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
			
			case 76:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [MTR_REMOTE_AMI] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );			

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(77, '20230712', '1. 계량기 원격구분')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;

			case 77:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [USAGE_CD] VARCHAR(6)");
  			    g_Sql_DirectExecute( szSql );			

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(78, '20230728', '1. 용도코드')");
				nSqlRet = g_Sql_DirectExecute( szSql );
				nRet++;
			
			case 78:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE NORMAL_DATA ADD COLUMN [BILL_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );			

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(79, '20230731', '1.사용계약서 작성여부')");
				
				nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;
				
			case 79:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [OTHER_PRICE] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(80, '20230523', '1. 기타부품 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					  			      								
				
			case 80:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [BATTERY_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(81, '20230523', '1. 배터리유무 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;					  			      								

			case 81:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [MTRDISPLAY_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(82, '20230523', '1. 지시부유무 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	
				
			case 82:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [CHK_BULD_CENTER_CD] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(83, '20230621', '1. 건물센터코드(특수계량기)')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			
			case 83:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [REMOTE_SYSTEM] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(84, '20230816', '1. 정산재고반영')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			
			case 84:
				Table_OldMtr_Add();
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(85, '20230824', '1. C6301_OLDMTRIDNUM 테이블 생성')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
				
			case 85:
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6301_CHANGEDATA ADD COLUMN [OLD_MTR_ID_NUM] VARCHAR(25)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(86, '20230825', '1. OLD_MTR_ID_NUM 컬럼 생성')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
				
			case 86: 
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_MTR ADD COLUMN [CHK_BULD_CENTER_CD] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );	
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(87, '20230831', '1. 건물센터코드(특수계량기)')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
				
			case 87:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_MTR ADD COLUMN [BATTERY_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(88, '20230831', '1. 배터리유무 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
				
			case 88:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_MTR ADD COLUMN [MTRDISPLAY_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(89, '20230831', '1. 지시부유무 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
			
			case 89:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_PROMISE_MTR ADD COLUMN [OTHER_PRICE] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(90, '20230831', '1. 기타부품 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	
				
			case 90:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_CHG_MTR_INFO ADD COLUMN [OTHER_PRICE] VARCHAR(10)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(91, '20230831', '1. 기타부품 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	
				
			case 91:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_CHG_MTR_INFO ADD COLUMN [BATTERY_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(92, '20230831', '1. 배터리유무 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	
				
			case 92:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_CHG_MTR_INFO ADD COLUMN [MTRDISPLAY_YN] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(93, '20230831', '1. 지시부유무 컬럼 추가')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 93:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_CHG_MTR_INFO ADD COLUMN [REMOTE_SYSTEM] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(94, '20230816', '1. 정산재고반영')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	

			case 94:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE C6101_CHG_MTR_INFO ADD COLUMN [OLD_MTR_ID_NUM] VARCHAR(25)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(95, '20230831', '1. OLD_MTR_ID_NUM 컬럼 생성')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;
				
			case 95:
				Table_C6101_CHK_BULD_CENTER_CD();
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(96, '20230905', '1. C6101_CHK_BULD_CENTER_CD 테이블 생성')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;

			case 96:
			    Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [FILTER_CLEAN_YMD] VARCHAR(8)");
  			    g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [FILTER_CLEAN_FIRM_CD] VARCHAR(3)");
  			    g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [FILTER_CLEAN_FIRM_NM] VARCHAR(30)");
  			    g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [NEW_FILTER_CLEAN_YMD] VARCHAR(8)");
  			    g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [NEW_FILTER_CLEAN_FIRM_CD] VARCHAR(3)");
  			    g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [NEW_FILTER_CLEAN_FIRM_NM] VARCHAR(30)");
  			    g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [REGTR_LOC_FLAG] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "ALTER TABLE SPECIAL_GOV_REG ADD COLUMN [REGTR_STD] VARCHAR(2)");
  			    g_Sql_DirectExecute( szSql );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(97, '20231030', '1. 조정기 필터청소')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );

				nRet++;	
			case 97:
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );				
				Str_Cpy(szSql, "ALTER TABLE RCV_TMP ADD COLUMN [PARAM102] VARCHAR(3000)");
				g_Sql_DirectExecute( szSql );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			    Str_Cpy(szSql, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(98, '20240312', '1. 활동결과내역(ACTIVE_RSLT_DESC) 컬럼사이즈 1200 으로 변경')");
    		    nSqlRet = g_Sql_DirectExecute( szSql );
				
				nRet++;	
				
			default:
				break;
		}
	}
	
	//----------------------------------------------------------------------------------------
	void Table_Add(void)
	{
		handle hdb = NULL;
		SQLITE sql = NewSqLite();

//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Start : %d",Time_GetSecond(),0,0);
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		sql->Begin(sql);
		
		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_AUTO_TRANS] ( \
[CIVIL_SERV_RECEIVE_NUM] varchar(14), \
[TREAT_SEQ] NUMERIC(10), \
[CUST_NUM] varchar(10), \
[USE_CONT_NUM] varchar(10), \
[TRANS_REQ_FLAG] varchar(2), \
[SOC_BIZ_NUM] varchar(13), \
[BNK_CD] varchar(3), \
[ACCOUNT_NUM] varchar(10), \
[DEPOSITOR_NM] varchar(50), \
[CUST_RELAT_CD] varchar(2), \
[DEPOSITOR_TEL_DDD] varchar(4), \
[DEPOSITOR_TEL_EXN] varchar(4), \
[DEPOSITOR_TEL_NUM] varchar(4), \
[REQ_NM] varchar(30), \
[REQ_TEL_DDD] varchar(4), \
[REQ_TEL_EXN] varchar(4), \
[REQ_TEL_NUM] varchar(4), \
[REQ_SOC_NUM] varchar(13), \
[SEND_YN] VARCHAR(1), \
[PROMISE_ASSIGN_SEQ] NUMERIC(10), \
[PDA_CONF_DTM] VARCHAR(16), \
[UPD_EMPID] VARCHAR(30), \
[PDA_IP] VARCHAR(20), \
[BANK_CD] VARCHAR(10))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_BIZ_BURN] ( \
[BURNER_CLASS_CD] varchar(8), \
[PROD_CD] varchar(5), \
PRIMARY KEY ([BURNER_CLASS_CD],[PROD_CD]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_BIZ_PROD] ( \
[BIZ_TYPE_CLASS_CD] varchar(2)  NULL, \
[PROD_CD] varchar(5)  NULL, \
PRIMARY KEY ([BIZ_TYPE_CLASS_CD],[PROD_CD]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_BIZ_TYPE] ( \
[BIZ_TYPE_CD] varchar(6)  PRIMARY KEY NULL, \
[BIZ_TYPE_CLASS_CD] varchar(2)  NULL, \
[BIZ_TYPE_NM] varchar(50)  NULL, \
[BIZ_TYPE_CLASS_NM] VARCHAR(50)  NULL)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_BNK] ( \
[CUST_SUPT_USE_CD] VARCHAR(3)  NULL, \
[BNK_BRANCH_NM] VARCHAR(50)  NULL)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_CARD_INFO] ( \
[cd_type] varchar(8)  NOT NULL, \
[cd_name] NUMERIC(50)  NULL, \
[cdco_code] varchar(8)  NULL, \
[cdco_name] varchar(50)  NULL)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_CARDASSIGN_INFO] ( \
[PROMISE_ASSIGN_SEQ] NUMERIC(10)  NOT NULL, \
[cardno] varchar(16)  NULL, \
[cardname] varchar(50)  NULL, \
[cardmm] varchar(2)  NULL, \
[cardyy] VARCHAR(2)  NULL, \
[cardhalbu] VARCHAR(2)  NULL, \
[cardhalbu_nm] VARCHAR(20)  NULL, \
[cardmsr] varchar(2)  NULL, \
[cardgaspay] varchar(10)  NULL, \
[cardonepay] varchar(10)  NULL, \
[cashgaspay] varchar(10)  NULL, \
[cashonepay] varchar(10)  NULL, \
[cardassigngasno] varchar(12)  NULL, \
[cardassigngasdate] varchar(6)  NULL, \
[cardassigngascancelno] varchar(12)  NULL, \
[cardassigngascanceldate] varchar(6)  NULL, \
[cardmsrflag] VARCHAR(2)  NULL, \
[cardassignoneno] varchar(12)  NULL, \
[cardassignonedate] varchar(6)  NULL, \
[cardassignonecancelno] VARCHAR(12)  NULL, \
[cardassignonecanceldate] VARCHAR(6)  NULL, \
[cardassigntype] VARCHAR(2)  NULL, \
[SEND_YN] VARCHAR(1)  NULL)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_CHG_MTR_INFO] ( \
[MTR_NUM] VARCHAR(9) NOT NULL, \
[REPL_TREAT_YMD] VARCHAR(8) NOT NULL, \
[PROMISE_ASSIGN_SEQ] VARCHAR(9), \
[INST_PLACE_NUM] VARCHAR(9), \
[CENTER_CD] VARCHAR(2), \
[MTR_FEE_FREE_FLAG] VARCHAR(1), \
[MTR_REPL_WHY] VARCHAR(3), \
[MTR_BAR] VARCHAR(20), \
[AFTER_MTR_ID_NUM] VARCHAR(20), \
[AFTER_MTR_MODEL_CD] VARCHAR(5), \
[AFTER_MTR_GRD] VARCHAR(8), \
[AFTER_MTR_TYPE] VARCHAR(2), \
[AFTER_MTR_REMOTE_FLAG] VARCHAR(2), \
[AFTER_MTR_KIND] VARCHAR(2), \
[AFTER_MTR_DIGIT_CNT] VARCHAR(2), \
[AFTER_MTR_NEW_FIX_FLAG] VARCHAR(2), \
[AFTER_FIX_FIRM_NM_CD] VARCHAR(2), \
[AFTER_MTR_VALID_YM] VARCHAR(6), \
[AFTER_FORM_APPRO_YN] VARCHAR(1), \
[BEFO_MTR_ID_NUM] VARCHAR(20), \
[BEFO_MTR_MODEL_CD] VARCHAR(5), \
[BEFO_MTR_GRD] VARCHAR(8), \
[BEFO_MTR_TYPE] VARCHAR(2), \
[BEFO_MTR_REMOTE_FLAG] VARCHAR(2), \
[BEFO_MTR_KIND] VARCHAR(2), \
[BEFO_MTR_DIGIT_CNT] VARCHAR(2), \
[BEFO_MTR_NEW_FIX_FLAG] VARCHAR(2), \
[BEFO_FIX_FIRM_NM_CD] VARCHAR(2), \
[BEFO_MTR_VALID_YM] VARCHAR(6), \
[BEFO_MTR_APPRO_YN] VARCHAR(1), \
[REMOVE_INDI_VM] VARCHAR(9), \
[REMOVE_INDI_VA] VARCHAR(9), \
[REMOVE_INDI_VC] VARCHAR(9), \
[MTR_PHOTO] TEXT, \
[INST_INDI_VM] VARCHAR(9), \
[INST_INDI_VA] VARCHAR(9), \
[INST_INDI_VC] VARCHAR(9), \
[CUST_SIGN] TEXT, \
[SEND_YN] VARCHAR(1), \
[JOB_DTM] VARCHAR(15), \
[UPD_EMPID] VARCHAR(20), \
[PDA_IP] VARCHAR(20), \
CONSTRAINT [sqlite_autoindex_C6101_CHG_MTR_INFO_1] PRIMARY KEY ([MTR_NUM], [REPL_TREAT_YMD], [PROMISE_ASSIGN_SEQ]))"
);


		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_CIVIL_CLASS] ( \
[CIVIL_SERV_CLASS_CD] varchar(6)  NULL PRIMARY KEY, \
[CIVIL_SERV_CLASS_NM] varchar(50)  NULL, \
[PDA_DUTY_FLAG] varchar(2)  NULL, \
[PDA_DUTY_FLAG_NM] varchar(50)  NULL)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_EMPLOYEE] ( \
[EMPLOYEE_ID] varchar(9)  NULL, \
[EMPLOYEE_NM] varchar(10)  NULL, \
PRIMARY KEY ([EMPLOYEE_ID]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_NONPAY] ( \
[PROMISE_ASSIGN_SEQ] NUMERIC(10), \
[CIVIL_SERV_RECEIVE_NUM] varchar(14), \
[TREAT_SEQ] NUMERIC(10), \
[USE_CONT_NUM] varchar(10), \
[MTR_NUM] varchar(9), \
[REQ_YM] varchar(6), \
[PROD_CONT_SEQ] VARCHAR(3), \
[DEADLINE_FLAG] varchar(2), \
[USE_QTY] NUMERIC(15), \
[INDI_COMPENS_VC] NUMERIC(10), \
[SUBTR_REQ_AMT] NUMERIC(10), \
[UNPAY_AMT] NUMERIC(10), \
[CENTER_CD] VARCHAR(4), \
[UPD_EMPID] VARCHAR(20), \
[PDA_IP] VARCHAR(15), \
[REQ_MANAGE_STS] varchar(20), \
[PAY_YMD] VARCHAR(8), \
[USE_PERIOD_STR] VARCHAR(8), \
[USE_PERIOD_END] VARCHAR(8), \
[CHK] VARCHAR(1), \
[SEND_YN] VARCHAR(1), \
[CARD_YN] VARCHAR(1), \
[TOT_ENER_QTY] VARCHAR(10), \
[TOT_REVIS_QTY] VARCHAR(10), \
[SUPPLY_UNIT_ENER] VARCHAR(10), \
[LAST_STATUS] CHAR(1), \
CONSTRAINT [sqlite_autoindex_C6101_NONPAY_1] PRIMARY KEY ([PROMISE_ASSIGN_SEQ], [CIVIL_SERV_RECEIVE_NUM], [TREAT_SEQ], [USE_CONT_NUM], [MTR_NUM], [REQ_YM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_ONCE_INFO] ( \
[CIVIL_SERV_RECEIVE_NUM] varchar(14)  NULL, \
[TREAT_SEQ] varchar(2)  NULL, \
[USE_CONT_NUM] varchar(10)  NULL, \
[ONCE_ITEM_CD] varchar(6)  NULL, \
[CENTER_CD] varchar(2)  NULL, \
[STR_APPLY_YMD] varchar(8)  NULL, \
[ONCE_OCCU_WHY] varchar(2)  NULL, \
[ONCE_UNIT_PRC] varchar(12)  NULL, \
[ONCE_QTY] varchar(5)  NULL, \
[ONCE_AMT] varchar(12)  NULL, \
[UPD_EMPID] varchar(20)  NULL, \
[TREAT_YMD] varchar(8)  NULL, \
[SEND_YN] varchar(1)  NULL, \
[PDA_IP] VARCHAR(12)  NULL, \
[PROMISE_ASSIGN_SEQ] VARCHAR(11)  NULL, \
[EXCEPT_YN] VARCHAR(1)  NULL, \
[PAY_PROMISE_YN] VARCHAR(1)  NULL, \
[BUILT_IN_YN] VARCHAR(1)  NULL, \
PRIMARY KEY ([CIVIL_SERV_RECEIVE_NUM],[TREAT_SEQ],[USE_CONT_NUM],[ONCE_ITEM_CD],[PROMISE_ASSIGN_SEQ]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_ONCE_ITEM] ( \
[CENTER_CD] varchar(2)  NULL, \
[ONCE_ITEM_CD] varchar(6)  NULL, \
[ONCE_ITEM_NM] varchar(50)  NULL, \
[STR_APPLY_YMD] VARCHAR(8)  NULL, \
[APPLY_UNIT_PRC] NUMERIC(10)  NULL, \
[ONCE_QTY] VARCHAR(5)  NULL, \
[ONCE_AMT] VARCHAR(12)  NULL, \
[SEND_YN] VARCHAR(1)  NULL, \
[SORT_SEQ] NUMERIC(2)  NULL, \
PRIMARY KEY ([CENTER_CD],[ONCE_ITEM_CD],[APPLY_UNIT_PRC]))"
);

	g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_PRE_CUST_INFO] ( \
[PROMISE_ASSIGN_SEQ] NUMERIC(10), \
[CIVIL_SERV_RECEIVE_NUM] varchar(14), \
[TREAT_SEQ] NUMERIC(10), \
[USE_CONT_NUM] varchar(10), \
[CNT] NUMERIC(10), \
[UNPAY_AMT] NUMERIC(10), \
[CUST_NUM] varchar(10), \
[CUST_TYPE_CD] varchar(2), \
[CUST_NM] varchar(30), \
[FIRM_NM] varchar(50), \
[SOC_NUM] varchar(13), \
[BIZ_REGI_NUM] varchar(10), \
[CP_DDD] varchar(4), \
[CP_EXN] varchar(4), \
[CP_NUM] varchar(4), \
[OWNHOUSE_TEL_DDD] varchar(4), \
[OWNHOUSE_TEL_EXN] varchar(4), \
[OWNHOUSE_TEL_NUM] varchar(4), \
[FIRM_TEL_DDD] varchar(4), \
[FIRM_TEL_EXN] varchar(4), \
[FIRM_TEL_NUM] varchar(4), \
[SCG_RELAT_CD] varchar(2), \
[EMAIL] varchar(50), \
[FAMILY_CNT] NUMERIC(10), \
[CUST_TRND_CD] varchar(2), \
[DEFRAY_ACCOUNT_NUM] VARCHAR(20), \
[REQ_INFO_NUM] VARCHAR(10), \
[DEPOSITOR_NM] VARCHAR(20), \
[BANK_NM] VARCHAR(50), \
[LAST_STATUS] CHAR(1), \
CONSTRAINT [sqlite_autoindex_C6101_PRE_CUST_INFO_1] PRIMARY KEY ([PROMISE_ASSIGN_SEQ]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_PROD] ( \
[PROD_CD] varchar(5)  NULL PRIMARY KEY, \
[USE_STR_YMD] varchar(8)  NULL, \
[PROD_NM] varchar(60)  NULL, \
[UNIT_PRC_FLAG] varchar(2)  NULL, \
[USAGE_CD] varchar(6)  NULL, \
[PROD_CLASS_CD] varchar(2)  NULL, \
[USE_END_YMD] varchar(8)  NULL)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_PROMISE_ASSIGN] ( \
[PROMISE_ASSIGN_SEQ] NUMERIC(10) NOT NULL, \
[PDA_IP] varchar(15), \
[UPD_EMPID] varchar(20), \
[REG_FLAG] varchar(2), \
[BRANCH_CD] varchar(6), \
[CENTER_CD] varchar(2), \
[ASSIGN_EMPID] varchar(9), \
[CUST_NUM] varchar(10), \
[USE_CONT_NUM] varchar(10), \
[INST_PLACE_NUM] varchar(9), \
[ZIP_SEQ] varchar(10), \
[ETC_ADDR] varchar(100), \
[CIVIL_SERV_CLASS_CD] varchar(6), \
[PROMISE_YMD] varchar(8), \
[PROMISE_TIME] varchar(4), \
[END_EXPECT_TIME] varchar(4), \
[JOB_STR_DTM] varchar(14), \
[JOB_END_DTM] varchar(14), \
[PROMISE_ASSIGN_DESC] varchar(500), \
[CIVIL_SERV_RECEIVE_NUM] varchar(14), \
[TREAT_SEQ] NUMERIC(10), \
[PROC_STS_CD] varchar(2), \
[PDA_NUM] varchar(5), \
[ONCE_PAY] varchar(10), \
[SEND_YN] VARCHAR(1), \
[CIVIL_SERV_CLASS_NM] varchar(50), \
[PDA_DUTY] varchar(20), \
[REQ_TEL_DDD] varchar(4), \
[REQ_TEL_EXN] varchar(4), \
[REQ_TEL_NUM] varchar(4), \
[REQ_CP_DDD] varchar(4), \
[REQ_CP_EXN] VARCHAR(4), \
[REQ_CP_NUM] varchar(4), \
[TRANS_IN_CUST_NM] varchar(50), \
[TRANS_IN_SOC_NUM] varchar(13), \
[REQ_NM] varchar(50), \
[REQ_SOC_NUM] varchar(13), \
[RECEIVE_DTM] VARCHAR(20), \
[CUST_TYPE_CD] varchar(2), \
[CUST_NM] varchar(30), \
[FIRM_NM] varchar(50), \
[SOC_NUM] varchar(13), \
[BIZ_REGI_NUM] varchar(10), \
[CP_DDD] VARCHAR(4), \
[CP_EXN] varchar(4), \
[CP_NUM] varchar(4), \
[OWNHOUSE_TEL_DDD] varchar(4), \
[OWNHOUSE_TEL_EXN] varchar(4), \
[OWNHOUSE_TEL_NUM] varchar(4), \
[FIRM_TEL_DDD] VARCHAR(4), \
[FIRM_TEL_EXN] varchar(4), \
[FIRM_TEL_NUM] varchar(4), \
[SCG_RELAT_CD] varchar(2), \
[EMAIL] varchar(50), \
[FAMILY_CNT] NUMERIC(10), \
[CUST_TRND_CD] VARCHAR(2), \
[CHK] VARCHAR(1), \
[BUILT_IN_YN] VARCHAR(2), \
[SQUARE_METER] VARCHAR(5), \
[CURR_ADDR_UNION] VARCHAR(50), \
[BLD_FLOOR] VARCHAR(20), \
[HOUSE_CNT] NUMERIC(10), \
[PDA_DUTY_FLAG] VARCHAR(10), \
[PAY_CALU] VARCHAR(10), \
[PDA_TRANS_FLAG] VARCHAR(5), \
[REQ_INFO_NUM] VARCHAR(10), \
[TRANS_IN_CUST_NUM] VARCHAR(10), \
[CONT_STS_CD] VARCHAR(2), \
[PDA_READ_DTM] VARCHAR(15), \
[MEMO] VARCHAR(500), \
[AUTO_YN] VARCHAR(1), \
[CUST_YN] VARCHAR(1), \
[BUR_YN] VARCHAR(1), \
[PROD_YN] VARCHAR(1), \
[ONCE_YN] VARCHAR(1), \
[PRICE_YN] VARCHAR(1), \
[ZIP_NO1] VARCHAR(10), \
[ZIP_NO2] VARCHAR(10), \
[CITY] VARCHAR(20), \
[COUNTY] VARCHAR(20), \
[TOWN] VARCHAR(20), \
[VILLAGE_RI] VARCHAR(20), \
[VILLAGE] VARCHAR(30), \
[BUILDING] VARCHAR(20), \
[ADDR1_M] VARCHAR(10), \
[ADDR1_S] VARCHAR(10), \
[CUST_CONF_SIGN] TEXT, \
[ACCOUNT] NUMERIC(10), \
[ONCE_ACCOUNT] NUMERIC(10), \
[CHK_TIME_FROM] VARCHAR(16), \
[CHK_TIME_END] VARCHAR(16), \
[MTR_CHG_YN] VARCHAR(1), \
[INFO_USE_AGREE_YN] VARCHAR(2), \
[PAS_USE_CONT_NUM_YN] VARCHAR(1), \
[ADJ_ALT_AMT] VARCHAR(10), \
[PAS_DEFRAY_ACCOUNT_NUM] VARCHAR(20), \
[PAS_CUST_NUM] VARCHAR(10), \
[PAS_REQ_INFO_NUM] VARCHAR(10), \
[APPRO_NUM] VARCHAR(10), \
[APPRO_TEL] VARCHAR(20), \
[ADJ_CAUSE] VARCHAR(2), \
[DEADLINE_FLAG] VARCHAR(2), \
[GMTR_BASE_DAY] VARCHAR(2), \
[CARD_GASPAY] NUMERIC(10), \
[CARD_ONEPAY] VARCHAR(1), \
[CASH_GASPAY] NUMERIC(10), \
[INFO_USE_YN] VARCHAR(1), \
[USE_CONT_DOC_YN] VARCHAR(1), \
[PAY_METHOD] VARCHAR(10), \
[DEFRAY_ACCOUNT_NUM] VARCHAR(20), \
[DEPOSITOR_NM] VARCHAR(16), \
[BANK_NM] VARCHAR(10), \
[DEBT_AMT] NUMERIC(10), \
[LAW_ETC_AMT] NUMERIC(10), \
[LAW_TOWN] VARCHAR(10), \
[NEW_ROAD_NM] VARCHAR(30), \
[NEW_ADDR_M] VARCHAR(10), \
[NEW_ADDR_S] VARCHAR(10), \
[NEW_ADDR_UNION] VARCHAR(50), \
[BILL_GUBUN] VARCHAR(2), \
[TRANS_CONN_YN] VARCHAR2(1), \
[CONN_YN] VARCHAR2(1), \
[BAR_YN] VARCHAR2(1), \
[BAR_GBN] VARCHAR2(2), \
[BAR_WHY] VARCHAR2(2), \
[CHK_YN] VARCHAR2(1), \
[CONN_GBN] VARCHAR2(2), \
[NEW_ADDR_BLD_SEQ] VARCHAR2(20), \
[LAST_STATUS] CHAR(1), \
CONSTRAINT [sqlite_autoindex_C6101_PROMISE_ASSIGN_1] PRIMARY KEY ([PROMISE_ASSIGN_SEQ]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_PROMISE_BUR] ( \
[PROMISE_ASSIGN_SEQ] NUMERIC(10) NOT NULL, \
[MTR_NUM] varchar(10) NOT NULL, \
[BURNER_NUM] varchar(10) NOT NULL, \
[PDA_IP] varchar(15), \
[UPD_EMPID] varchar(20), \
[CIVIL_SERV_RECEIVE_NUM] varchar(2), \
[TREAT_SEQ] NUMERIC(10), \
[INST_PLACE_NUM] varchar(20), \
[BURNER_CLASS_CD] varchar(20), \
[BURNER_KIND_NUM] varchar(20), \
[BURNER_KIND_NM] varchar(20), \
[BURNER_MODEL_CD] varchar(20), \
[BURNER_CAPA] NUMERIC(10), \
[BURNER_CAPA_UNIT] varchar(20), \
[BURNER_CAPA_UNIT_NM] varchar(20), \
[BURNER_INST_YMD] varchar(8), \
[BURNER_REMOV_YMD] varchar(8), \
[BURNER_MODEL_NM] varchar(20), \
[BURNER_QTY] NUMERIC(10), \
[MAKER_NM] varchar(20), \
[BOILER_FORM] varchar(20), \
[BOILER_FORM_NM] varchar(20), \
[MAKE_NUM] varchar(30), \
[MAKE_YMD] varchar(8), \
[WORK_DOCU_RECEIVE_YMD] varchar(8), \
[INST_FLAG] varchar(20), \
[INST_LOC] varchar(20), \
[INST_LOC_NM] varchar(20), \
[BOILER_INST_FIRM_CD] varchar(20), \
[BOILER_INST_FIRM_NM] varchar(20), \
[DATA_FLAG] VARCHAR(2), \
[MTR_ID_NUM] VARCHAR(15), \
[SEND_YN] VARCHAR(1), \
[MAKER_NUM] VARCHAR(8), \
[LAST_STATUS] CHAR(1), \
CONSTRAINT [sqlite_autoindex_C6101_PROMISE_BUR_1] PRIMARY KEY ([PROMISE_ASSIGN_SEQ], [MTR_NUM], [BURNER_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_PROMISE_CARD] ( \
[PROMISE_ASSIGN_SEQ] NUMERIC(10)  NOT NULL, \
[USE_CONT_NUM] varchar(10)  NOT NULL, \
[ITEM_FLAG] varchar(2)  NOT NULL, \
[REQ_YMD] varchar(8)  NOT NULL, \
[RECEV_SEQ] NUMERIC(3)  NOT NULL, \
[UPD_IP] varchar(15)  NULL, \
[UPD_EMPID] varchar(20)  NULL, \
[DATA_FLAG] varchar(2)  NULL, \
[RSLT_CD] varchar(1)  NULL, \
[TERMINAL_GBN] varchar(1)  NULL, \
[TERMINAL_NUM] varchar(10)  NULL, \
[CARD_NUM] varchar(16)  NULL, \
[VALID_YM] varchar(4)  NULL, \
[CARD_COM] varchar(2)  NULL, \
[CARD_TYPE_NM] VARCHAR(50)  NULL, \
[BUYING_COMP] varchar(2)  NULL, \
[BUYING_COMP_NM] varchar(50)  NULL, \
[APPROVAL_AMT] NUMERIC(10)  NULL, \
[APPROVAL_NUM] VARCHAR(12)  NULL, \
[ALLOTMENT_MM] VARCHAR(2)  NULL, \
[APPROVAL_TIME] VARCHAR(6)  NULL, \
[APPROVAL_EMPID] VARCHAR(9)  NULL, \
[CIVIL_SERV_RECEIVE_NUM] VARCHAR(14)  NULL, \
[TREAT_SEQ] NUMERIC(10)  NULL, \
[SEND_YN] VARCHAR(1)  NULL, \
PRIMARY KEY ([PROMISE_ASSIGN_SEQ],[USE_CONT_NUM],[ITEM_FLAG],[REQ_YMD],[RECEV_SEQ]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_PROMISE_MTR] ( \
[PROMISE_ASSIGN_SEQ] NUMERIC(10) NOT NULL, \
[MTR_NUM] varchar(9) NOT NULL, \
[PDA_IP] varchar(15), \
[UPD_EMPID] varchar(20), \
[CIVIL_SERV_RECEIVE_NUM] varchar(15), \
[TREAT_SEQ] NUMERIC(10), \
[INST_PLACE_NUM] varchar(9), \
[USE_CONT_NUM] varchar(10), \
[MTR_ID_NUM] varchar(20), \
[MTR_GRD] NUMERIC(7), \
[MTR_FORM] varchar(2), \
[MTR_FORM_NM] varchar(50), \
[MTR_TYPE] varchar(2), \
[MTR_TYPE_NM] varchar(50), \
[MTR_REMOTE_FLAG] varchar(2), \
[MTR_REMOTE_FLAG_NM] varchar(50), \
[MTR_KIND] varchar(2), \
[MTR_KIND_NM] varchar(50), \
[MTR_DIGIT_CNT] NUMERIC(10), \
[MTR_NEW_FIX_FLAG] varchar(2), \
[MTR_VALID_YM] varchar(6), \
[MTR_APPRO_YN] varchar(1), \
[SEALED_YMD] varchar(8), \
[SEALED_STS] varchar(2), \
[CHK_BAR_ADHERE_YMD] varchar(8), \
[CHK_BAR_ADHERE_STS] varchar(2), \
[MTR_DETA_LOC] varchar(30), \
[KEEPER_YN] varchar(2), \
[REVIS_FLAG] varchar(2), \
[MTR_LOC_FLAG] varchar(2), \
[MTR_LOC_FLAG_NM] varchar(50), \
[MTR_INST_HEIGHT] varchar(20), \
[MTR_RESOU_FLAG] varchar(2), \
[MTR_SUPPLY_STS] varchar(2), \
[MTR_SUPPLY_STS_NM] varchar(50), \
[MTR_MODEL_CD] varchar(5), \
[MTR_MODEL_NM] varchar(50), \
[COMPENS_MODEL_NM] varchar(50), \
[PROD_CONT_SEQ] varchar(3), \
[PROD_CONT_YMD] varchar(8), \
[BIZ_TYPE_CD] varchar(6), \
[PROD_CD] varchar(5), \
[PROD_NM] varchar(50), \
[PROD_AREA_FLAG] varchar(2), \
[CONT_FLAG_CD] varchar(2), \
[PROD_STS_CD] varchar(2), \
[CONT_REVIS_PARA] NUMERIC(10), \
[CUT_YMD] varchar(8), \
[CUT_TYPE_CD] varchar(2), \
[CUT_TREAT_EMPID] varchar(9), \
[CUT_WHY_CD] varchar(2), \
[CUT_CNL_YMD] varchar(8), \
[INDI_CUT_VC_AFTER] NUMERIC(10), \
[INDI_CUT_VA_AFTER] NUMERIC(10), \
[INDI_CUT_VM_AFTER] NUMERIC(10), \
[INDI_CUT_YMD] varchar(8), \
[INDI_TYPE_CD] varchar(2), \
[INDI_TYPE_NM] varchar(50), \
[INDI_VC_AFTER] NUMERIC(10), \
[INDI_VA_AFTER] NUMERIC(10), \
[INDI_VM_AFTER] NUMERIC(10), \
[INDI_VC] NUMERIC(10), \
[INDI_VA] NUMERIC(10), \
[INDI_VM] NUMERIC(10), \
[NONPAY] VARCHAR(10), \
[ACCOUNT] NUMERIC(9), \
[TOTALCOUNT] NUMERIC(9), \
[SEND_YN] VARCHAR(1), \
[ADJ_CHK] VARCHAR(1), \
[CNL_WHY_CD] VARCHAR(2), \
[CUT_CNL_FEE_YN] VARCHAR(1), \
[CUT_CNL_FEE_EXEMPT_WHY] VARCHAR(2), \
[ADJ_ALT_AMT] NUMERIC(9), \
[TOT_USE_QTY] NUMERIC(9), \
[REQ_YM] VARCHAR(6), \
[DEADLINE_FLAG] VARCHAR(2), \
[CHK_YN] VARCHAR(1), \
[ADJ_YMD] VARCHAR(8), \
[USE_PERIOD_STR] VARCHAR(8), \
[USE_PERIOD_END] VARCHAR(8), \
[CARD_YN] VARCHAR(1), \
[TOT_ENER_QTY] VARCHAR(10), \
[TOT_REVIS_QTY] VARCHAR(10), \
[SUPPLY_UNIT_ENER] VARCHAR(10), \
[BILL_GUBUN] VARCHAR(2), \
[FIX_FIRM_NM_CD] VARCHAR2(2), \
[LAST_STATUS] CHAR(1), \
CONSTRAINT [sqlite_autoindex_C6101_PROMISE_MTR_1] PRIMARY KEY ([PROMISE_ASSIGN_SEQ], [MTR_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_SILSA] ( \
[PARAM1] VARCHAR(100), \
[PARAM2] VARCHAR(100), \
[PARAM3] VARCHAR(100), \
[PARAM4] VARCHAR(100), \
[PARAM5] VARCHAR(100), \
[PARAM6] VARCHAR(100), \
[PARAM7] VARCHAR(100), \
[PARAM8] VARCHAR(100), \
[PARAM9] VARCHAR(100), \
[PARAM10] VARCHAR(100), \
[PARAM11] VARCHAR(100), \
[PARAM12] VARCHAR(100), \
[PARAM13] VARCHAR(100), \
[PARAM14] VARCHAR(100), \
[PARAM15] VARCHAR(100), \
[PARAM16] VARCHAR(100), \
[PARAM17] VARCHAR(100), \
[PARAM18] VARCHAR(100), \
[PARAM19] VARCHAR(100), \
[PARAM20] VARCHAR(100), \
[PARAM21] VARCHAR(100), \
[PARAM22] VARCHAR(100), \
[PARAM23] VARCHAR(100), \
[PARAM24] VARCHAR(100), \
[PARAM25] VARCHAR(100), \
[PARAM26] VARCHAR(100), \
[PARAM27] VARCHAR(100), \
[PARAM28] VARCHAR(100), \
[PARAM29] VARCHAR(100), \
[PARAM30] VARCHAR(100), \
[PARAM31] VARCHAR(100), \
[PARAM32] VARCHAR(100), \
[PARAM33] VARCHAR(100), \
[PARAM34] VARCHAR(100), \
[PARAM35] VARCHAR(100), \
[PARAM36] VARCHAR(100), \
[PARAM37] VARCHAR(100), \
[PARAM38] VARCHAR(100), \
[PARAM39] VARCHAR(100), \
[PARAM40] VARCHAR(100), \
[PARAM41] VARCHAR(100), \
[PARAM42] VARCHAR(100), \
[PARAM43] VARCHAR(100), \
[PARAM44] VARCHAR(100), \
[PARAM45] VARCHAR(100), \
[PARAM46] VARCHAR(100), \
[PARAM47] VARCHAR(100), \
[PARAM48] VARCHAR(100), \
[PARAM49] VARCHAR(100), \
[PARAM50] VARCHAR(100), \
[PARAM51] VARCHAR(100), \
[PARAM52] VARCHAR(100), \
[PARAM53] VARCHAR(100), \
[PARAM54] VARCHAR(100), \
[PARAM55] VARCHAR(100), \
[PARAM56] VARCHAR(100), \
[PARAM57] VARCHAR(100), \
[PARAM58] VARCHAR(100), \
[PARAM59] VARCHAR(100), \
[PARAM60] VARCHAR(100), \
[PARAM61] VARCHAR(100), \
[PARAM62] VARCHAR(100), \
[PARAM63] VARCHAR(100), \
[PARAM64] VARCHAR(100), \
[PARAM65] VARCHAR(100), \
[PARAM66] VARCHAR(100), \
[PARAM67] VARCHAR(100), \
[PARAM68] VARCHAR(100), \
[PARAM69] VARCHAR(100), \
[PARAM70] VARCHAR(100), \
[PARAM71] VARCHAR(100), \
[PARAM72] VARCHAR(100), \
[PARAM73] VARCHAR(100), \
[PARAM74] VARCHAR(100), \
[PARAM75] VARCHAR(100), \
[PARAM76] VARCHAR(100), \
[PARAM77] VARCHAR(100), \
[PARAM78] VARCHAR(100), \
[PARAM79] VARCHAR(100), \
[PARAM80] VARCHAR(100), \
[PARAM81] VARCHAR(100), \
[PARAM82] VARCHAR(100), \
[PARAM83] VARCHAR(100), \
[PARAM84] VARCHAR(100), \
[PARAM85] VARCHAR(100), \
[PARAM86] VARCHAR(100), \
[PARAM87] VARCHAR(100), \
[PARAM88] VARCHAR(100), \
[PARAM89] VARCHAR(100), \
[PARAM90] VARCHAR(100), \
[PARAM91] VARCHAR(100), \
[PARAM92] VARCHAR(100), \
[PARAM93] VARCHAR(100), \
[PARAM94] VARCHAR(100), \
[PARAM95] VARCHAR(100), \
[PARAM96] VARCHAR(100), \
[PARAM97] VARCHAR(100), \
[PARAM98] VARCHAR(100), \
[PARAM99] VARCHAR(100), \
[PARAM100] VARCHAR(100), \
[PARAM101] VARCHAR(100), \
[PARAM102] VARCHAR(100), \
[PARAM103] VARCHAR(100), \
[PARAM104] VARCHAR(100), \
[PARAM105] VARCHAR(100), \
[PARAM106] VARCHAR(100), \
[PARAM107] VARCHAR(100), \
[PARAM108] VARCHAR(100), \
[PARAM109] VARCHAR(100))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_WARR_OCCU_BASE] ( \
[MTR_GRD] NUMERIC(6, 2)  NULL, \
[PROD_CLASS_CD] varchar(2)  NULL, \
[APPLY_STR_YMD] varchar(8)  NULL, \
[OCCU_AMT] NUMERIC(12)  NULL, \
[APPLY_END_YMD] varchar(8)  NULL, \
PRIMARY KEY ([MTR_GRD],[PROD_CLASS_CD],[APPLY_STR_YMD]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_WORK_REPORT] ( \
[REQ_DOC_NUM] VARCHAR(30), \
[USE_CONT_NUM] VARCHAR(20), \
[MTR_NUM] VARCHAR(20), \
[REG_YMD] VARCHAR(20), \
[DUTY_FLAG] VARCHAR(10), \
[TAKER_EMPID] VARCHAR(20), \
[CUST_NUM] VARCHAR(30), \
[CUST_NM] VARCHAR(50), \
[TREAT_STS] VARCHAR(20), \
[CURR_ADDR_UNION] VARCHAR(300), \
[NEW_ADDR_UNION] VARCHAR(300), \
[FIRM_NM] VARCHAR(100), \
[TREAT_YMD] VARCHAR(30), \
[CENTER_CD] VARCHAR(10), \
[TITLE] VARCHAR(100), \
[REQ_DESC] VARCHAR(1000), \
[FILE_SEQ] VARCHAR(100), \
[FILE_ID] VARCHAR(100), \
[ORG_FILE_NAME] VARCHAR(200), \
[FILE_PATH] VARCHAR(300), \
[PHOTO] VARCHAR(1000), \
[PHOTO_LENGTH] INTEGER)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_AUCTION] ( \
[USE_CONT_NUM] VARCHAR(10) NOT NULL, \
[NONPAY_OBJ_FLAG] VARCHAR(2) NOT NULL, \
[NONPAY_MANAGE_AMT] NUMERIC(15), \
[NONPAY_MM_CNT] NUMERIC(3), \
[CITY] VARCHAR(30), \
[AREA] VARCHAR(30), \
[TOWN] VARCHAR(30), \
[VILLAGE] VARCHAR(30), \
[ADDR1_M] VARCHAR(30), \
[ADDR1_S] VARCHAR(30), \
[CO_LIVE_NM] VARCHAR(60), \
[DONG_NUM] VARCHAR(20), \
[HOSU] VARCHAR(20), \
[BLD_NM] VARCHAR(60), \
[DETAIL_FLOOR] VARCHAR(20), \
[NEW_ADDR_UNION] VARCHAR(300), \
[LAW_ETC_AMT] VARCHAR(10), \
[DEBT_AMT] VARCHAR(10), \
[DEBT_UNPAY_AMT] VARCHAR(10), \
[ALL_UNPAY] NUMERIC(10), \
[LAW_TOWN] VARCHAR(30), \
[NEW_ROAD_NM] VARCHAR(200), \
[NEW_ADDR_M] VARCHAR(5), \
[NEW_ADDR_S] VARCHAR(5), \
[CURR_ADDR_UNION] VARCHAR(300), \
[ENER_VOUCH_YN] VARCHAR(1), \
[EARLY_ALAM_YN] VARCHAR(1), \
[VISIT_REG_YN] VARCHAR(1), \
[WARR_YN] VARCHAR(1), \
[CUST_NM] VARCHAR(30), \
[FIRM_NM] VARCHAR(50))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_BNK] ( \
[BNK_CD] VARCHAR(3)  NOT NULL, \
[VIRT_ACCOUNT_NUM] VARCHAR(20)  NOT NULL, \
[USE_CONT_NUM] VARCHAR(10)  NULL, \
[BNK_NM] VARCHAR(10)  NULL, \
PRIMARY KEY ([BNK_CD],[VIRT_ACCOUNT_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_NOPAY_OBJ] ( \
[USE_CONT_NUM] VARCHAR(10) NOT NULL, \
[BASE_YMD] VARCHAR(8), \
[CONT_YMD] VARCHAR(8), \
[CNL_YMD] VARCHAR(8), \
[PAY_METHOD] VARCHAR(2), \
[DEADLINE_FLAG] VARCHAR(20), \
[CONT_STS_CD] VARCHAR(2), \
[NONPAY_OBJ_FLAG] VARCHAR(2), \
[NONPAY_MANAGE_FLAG] VARCHAR(2), \
[NONPAY_MANAGE_AMT] NUMERIC(10), \
[WARR_AMT_SUM] NUMERIC(10), \
[UNPAY_AMT_SUM] NUMERIC(10), \
[NONPAY_MM_CNT] NUMERIC(10), \
[ZIP_NO1] VARCHAR(3), \
[ZIP_NO2] VARCHAR(3), \
[CITY] VARCHAR(30), \
[AREA] VARCHAR(30), \
[TOWN] VARCHAR(30), \
[VILLAGE] VARCHAR(30), \
[ADDR1_M] VARCHAR(30), \
[ADDR1_S] VARCHAR(30), \
[CO_LIVE_NM] VARCHAR(60), \
[DONG_NUM] VARCHAR(20), \
[HOSU] VARCHAR(20), \
[BLD_NM] VARCHAR(60), \
[DETAIL_FLOOR] VARCHAR(20), \
[NEW_ADDR_UNION] VARCHAR(300), \
[CUST_NUM] VARCHAR(10), \
[CUST_TYPE_CD] VARCHAR(2), \
[CUST_NM] VARCHAR(30), \
[FIRM_NM] VARCHAR(50), \
[BIZ_REGI_NUM] VARCHAR(10), \
[SOC_NUM] VARCHAR(13), \
[REPRE_NM] VARCHAR(30), \
[CP_DDD] VARCHAR(4), \
[CP_EXN] VARCHAR(4), \
[CP_NUM] VARCHAR(4), \
[OWNHOUSE_TEL_DDD] VARCHAR(4), \
[OWNHOUSE_TEL_EXN] VARCHAR(4), \
[OWNHOUSE_TEL_NUM] VARCHAR(4), \
[PAY_CUST_NUM] VARCHAR(10), \
[PAY_CUST_TYPE_CD] VARCHAR(2), \
[PAY_CUST_NM] VARCHAR(30), \
[PAY_FIRM_NM] VARCHAR(50), \
[PAY_BIZ_REGI_NUM] VARCHAR(10), \
[PAY_SOC_NUM] VARCHAR(13), \
[PAY_REPRE_NM] VARCHAR(30), \
[PAY_CP_NUM] VARCHAR(20), \
[PAY_TEL_NUM] VARCHAR(20), \
[OWNER_CUST_NUM] VARCHAR(10), \
[OWNER_CUST_TYPE_CD] VARCHAR(2), \
[OWNER_CUST_NM] VARCHAR(30), \
[OWNER_FIRM_NM] VARCHAR(50), \
[OWNER_BIZ_REGI_NUM] VARCHAR(10), \
[OWNER_SOC_NUM] VARCHAR(13), \
[OWNER_REPRE_NM] VARCHAR(30), \
[OWNER_CP_NUM] VARCHAR(20), \
[OWNER_TEL_NUM] VARCHAR(20), \
[NONPAY_ACTIVE_DEPT] VARCHAR(4), \
[NONPAY_MANAGE_ZONE] VARCHAR(6), \
[TAKER_NM] VARCHAR(30), \
[RMK] VARCHAR(300), \
[STOP_FLAG] VARCHAR(2), \
[CUST_FLAG] VARCHAR(1), \
[ACCEPT_AMT] NUMERIC, \
[SEL_M_CNT] NUMERIC, \
[VISIT_FLAG] VARCHAR(1), \
[CUT_FLAG] VARCHAR(1), \
[AUTO_FLAG] VARCHAR(1), \
[RELE_FLAG] VARCHAR(1), \
[RCEI_FLAG] VARCHAR(1), \
[RSLT_NOTICE_YN] VARCHAR(1), \
[OBJ_PERS_SOC_NUM] VARCHAR(15), \
[LAW_ETC_AMT] VARCHAR(10), \
[DEBT_AMT] VARCHAR(10), \
[DEBT_UNPAY_AMT] VARCHAR(10), \
[ALL_UNPAY] NUMERIC(10), \
[LAW_TOWN] VARCHAR(30), \
[NEW_ROAD_NM] VARCHAR(200), \
[NEW_ADDR_M] VARCHAR(5), \
[NEW_ADDR_S] VARCHAR(5), \
[CURR_ADDR_UNION] VARCHAR(300), \
[ENER_VOUCH_YN] VARCHAR(1), \
[EARLY_ALAM_YN] VARCHAR(1), \
[VISIT_REG_YN] VARCHAR(1), \
[WARR_YN] VARCHAR(1), \
[READ_MEMO_YN] VARCHAR(1), \
[INST_PLACE_NUM] VARCHAR(9), \
[REAL_NM_CONF_YN] VARCHAR(2), \
[SAFE_KEY_YN] VARCHAR(2), \
[RELEASE_YN] VARCHAR(2), \
[STOP_YN] VARCHAR(2), \
[PAYCONFIRM_FLAG] VARCHAR(5), \
CONSTRAINT [sqlite_autoindex_C6202_NOPAY_OBJ_1] PRIMARY KEY ([USE_CONT_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_NOPAY_OBJ_LIST] ( \
[ZIP_NO1] VARCHAR(3)  NOT NULL, \
[ZIP_NO2] VARCHAR(3)  NOT NULL, \
[AREA] VARCHAR(30)  NULL, \
[TOWN] VARCHAR(30)  NULL, \
[ADDR1_M] VARCHAR(30)  NULL, \
[CNT] NUMERIC(5)  NULL, \
[FLAG] VARCHAR(1)  NULL, \
[CHK_FLAG] VARCHAR(2)  NULL, \
PRIMARY KEY ([ZIP_NO1],[ZIP_NO2],[ADDR1_M]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_NOPAY_OBJ_PART] ( \
[USE_CONT_NUM] VARCHAR(10) NOT NULL, \
[BASE_YMD] VARCHAR(8), \
[CONT_YMD] VARCHAR(8), \
[CNL_YMD] VARCHAR(8), \
[PAY_METHOD] VARCHAR(2), \
[DEADLINE_FLAG] VARCHAR(20), \
[CONT_STS_CD] VARCHAR(2), \
[NONPAY_OBJ_FLAG] VARCHAR(2), \
[NONPAY_MANAGE_FLAG] VARCHAR(2), \
[NONPAY_MANAGE_AMT] NUMERIC(10), \
[WARR_AMT_SUM] NUMERIC(10), \
[UNPAY_AMT_SUM] NUMERIC(10), \
[NONPAY_MM_CNT] NUMERIC(10), \
[ZIP_NO1] VARCHAR(3), \
[ZIP_NO2] VARCHAR(3), \
[CITY] VARCHAR(30), \
[AREA] VARCHAR(30), \
[TOWN] VARCHAR(30), \
[VILLAGE] VARCHAR(30), \
[ADDR1_M] VARCHAR(30), \
[ADDR1_S] VARCHAR(30), \
[CO_LIVE_NM] VARCHAR(60), \
[DONG_NUM] VARCHAR(20), \
[HOSU] VARCHAR(20), \
[BLD_NM] VARCHAR(60), \
[DETAIL_FLOOR] VARCHAR(20), \
[NEW_ADDR_UNION] VARCHAR(300), \
[CUST_NUM] VARCHAR(10), \
[CUST_TYPE_CD] VARCHAR(2), \
[CUST_NM] VARCHAR(30), \
[FIRM_NM] VARCHAR(50), \
[BIZ_REGI_NUM] VARCHAR(10), \
[SOC_NUM] VARCHAR(13), \
[REPRE_NM] VARCHAR(30), \
[CP_DDD] VARCHAR(4), \
[CP_EXN] VARCHAR(4), \
[CP_NUM] VARCHAR(4), \
[OWNHOUSE_TEL_DDD] VARCHAR(4), \
[OWNHOUSE_TEL_EXN] VARCHAR(4), \
[OWNHOUSE_TEL_NUM] VARCHAR(4), \
[PAY_CUST_NUM] VARCHAR(10), \
[PAY_CUST_TYPE_CD] VARCHAR(2), \
[PAY_CUST_NM] VARCHAR(30), \
[PAY_FIRM_NM] VARCHAR(50), \
[PAY_BIZ_REGI_NUM] VARCHAR(10), \
[PAY_SOC_NUM] VARCHAR(13), \
[PAY_REPRE_NM] VARCHAR(30), \
[PAY_CP_NUM] VARCHAR(20), \
[PAY_TEL_NUM] VARCHAR(20), \
[OWNER_CUST_NUM] VARCHAR(10), \
[OWNER_CUST_TYPE_CD] VARCHAR(2), \
[OWNER_CUST_NM] VARCHAR(30), \
[OWNER_FIRM_NM] VARCHAR(50), \
[OWNER_BIZ_REGI_NUM] VARCHAR(10), \
[OWNER_SOC_NUM] VARCHAR(13), \
[OWNER_REPRE_NM] VARCHAR(30), \
[OWNER_CP_NUM] VARCHAR(20), \
[OWNER_TEL_NUM] VARCHAR(20), \
[NONPAY_ACTIVE_DEPT] VARCHAR(4), \
[NONPAY_MANAGE_ZONE] VARCHAR(6), \
[TAKER_NM] VARCHAR(30), \
[RMK] VARCHAR(300), \
[STOP_FLAG] VARCHAR(2), \
[CUST_FLAG] VARCHAR(1), \
[ACCEPT_AMT] NUMERIC, \
[SEL_M_CNT] NUMERIC, \
[VISIT_FLAG] VARCHAR(1), \
[CUT_FLAG] VARCHAR(1), \
[AUTO_FLAG] VARCHAR(1), \
[RELE_FLAG] VARCHAR(1), \
[RCEI_FLAG] VARCHAR(1), \
[RSLT_NOTICE_YN] VARCHAR(1), \
[OBJ_PERS_SOC_NUM] VARCHAR(15), \
[LAW_ETC_AMT] VARCHAR(10), \
[DEBT_AMT] VARCHAR(10), \
[DEBT_UNPAY_AMT] VARCHAR(10), \
[ALL_UNPAY] NUMERIC(10), \
[LAW_TOWN] VARCHAR(30), \
[NEW_ROAD_NM] VARCHAR(200), \
[NEW_ADDR_M] VARCHAR(5), \
[NEW_ADDR_S] VARCHAR(5), \
[CURR_ADDR_UNION] VARCHAR(300), \
[ENER_VOUCH_YN] VARCHAR(1), \
[EARLY_ALAM_YN] VARCHAR(1), \
[VISIT_REG_YN] VARCHAR(1), \
[WARR_YN] VARCHAR(1), \
[READ_MEMO_YN] VARCHAR(1), \
[INST_PLACE_NUM] VARCHAR(9), \
[REAL_NM_CONF_YN] VARCHAR(2), \
[SAFE_KEY_YN] VARCHAR(2), \
[RELEASE_YN] VARCHAR(2), \
[STOP_YN] VARCHAR(2), \
[PAYCONFIRM_FLAG] VARCHAR(5), \
CONSTRAINT [sqlite_autoindex_C6202_NOPAY_OBJ_PART_1] PRIMARY KEY ([USE_CONT_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_PAYCONFIRM] ( \
[USE_CONT_NUM] VARCHAR(10) NOT NULL, \
[PROMISE_ASSIGN_SEQ] VARCHAR(20) NOT NULL, \
[SEQ] NUMBER(20) NOT NULL, \
[ZIP_NO1] VARCHAR(3), \
[ZIP_NO2] VARCHAR(3), \
[ZIP_NO3] VARCHAR(3), \
[CITY] VARCHAR(30), \
[COUNTY] VARCHAR(30), \
[TOWN] VARCHAR(30), \
[VILLAGE] VARCHAR(30), \
[LAW_TOWN] VARCHAR(30), \
[ETC_ADDR] VARCHAR(100), \
[CO_LIVE_NM] VARCHAR(60), \
[BLD_NM] VARCHAR(60), \
[HOSU] VARCHAR(20), \
[ADDR1_M] VARCHAR(30), \
[ADDR1_S] VARCHAR(30), \
[DETAIL_FLOOR] VARCHAR(20), \
[NEW_ROAD_NM] VARCHAR(200), \
[NEW_ADDR_M] VARCHAR(5), \
[NEW_ADDR_S] VARCHAR(5), \
[CURR_ADDR_UNION] VARCHAR(300), \
[NEW_ADDR_UNION] VARCHAR(300), \
[CUST_NM] VARCHAR(50), \
[PROMISE_CUST_NM] VARCHAR(50), \
[FIRM_NM] VARCHAR(50), \
[PROMISE_FIRM_NM] VARCHAR(50), \
[PROMISE_TOT_AMT] VARCHAR(100), \
[VISIT_FLAG] VARCHAR(1))"
);

g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_RELEASE] ( \
[MTR_NUM] VARCHAR(10) NOT NULL, \
[PROD_CONT_SEQ] VARCHAR(30), \
[INDI_COMPENS_CUT_VA] NUMERIC(9), \
[INDI_COMPENS_CUT_VC] NUMERIC(9), \
[KEEPER_YN] VARCHAR(30), \
[CITY] VARCHAR(30), \
[AREA] VARCHAR(30), \
[TOWN] VARCHAR(30), \
[VILLAGE] VARCHAR(30), \
[ADDR1_M] VARCHAR(30), \
[ADDR1_S] VARCHAR(30), \
[CO_LIVE_NM] VARCHAR(30), \
[DONG_NUM] VARCHAR(30), \
[HOSU] VARCHAR(30), \
[BLD_NM] VARCHAR(30), \
[DETAIL_FLOOR] VARCHAR(30), \
[NEW_ADDR_UNION] VARCHAR(30), \
[RMK] VARCHAR(100), \
[SEQ] NUMERIC(9), \
[USE_CONT_NUM] VARCHAR(30), \
[BASE_DTM] VARCHAR(30), \
[NONPAY_MM_CNT] NUMERIC(9), \
[NONPAY_AMT] NUMERIC(10), \
[WHY_CD] VARCHAR(30), \
[REQ_EMPID] VARCHAR(30), \
[TREAT_EMPID] VARCHAR(30), \
[CUT_YMD] VARCHAR(30), \
[CUT_TYPE_CD] VARCHAR(30), \
[GMTR_OBJ_FLAG] VARCHAR(30), \
[INDI_MTR_CUT] NUMERIC(9), \
[MTR_ID_NUM] VARCHAR(30), \
[PROC] VARCHAR(1), \
[CUT_JOB_FLAG] VARCHAR(2), \
[CURRENT_VA] VARCHAR(9), \
[CURRENT_VC] VARCHAR(9), \
[CURRENT_VM] VARCHAR(9), \
[SEALED_STS] VARCHAR(10), \
[CUT_CNL_FEE_EXEMPT_WHY] VARCHAR(100), \
[CUT_CNL_FEE_YN] VARCHAR(2), \
[NONPAY_ACTIVE_DEPT] VARCHAR(4), \
[NONPAY_MANAGE_ZONE] VARCHAR(6), \
[INST_PLACE_NUM] VARCHAR(9), \
[RSLT_NOTICE_YN] VARCHAR(1), \
[LAW_ETC_AMT] VARCHAR(10), \
[DEBT_AMT] VARCHAR(10), \
[DEBT_UNPAY_AMT] VARCHAR(10), \
[ALL_UNPAY] NUMERIC(10), \
[LAW_TOWN] VARCHAR(30), \
[NEW_ROAD_NM] VARCHAR(200), \
[NEW_ADDR_M] VARCHAR(5), \
[NEW_ADDR_S] VARCHAR(5), \
[CURR_ADDR_UNION] VARCHAR(300), \
[MTR_KIND] VARCHAR2(50), \
[PAY_CUST_NM] VARCHAR(50), \
[PAY_FIRM_NM] VARCHAR(50), \
[RELEASE_YN] VARCHAR(2), \
[STOP_YN] VARCHAR(2), \
CONSTRAINT [sqlite_autoindex_C6202_RELEASE_1] PRIMARY KEY ([MTR_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_STOP_OBJ] ( \
[USE_CONT_NUM] VARCHAR(10) NOT NULL, \
[BASE_YMD] VARCHAR(8), \
[CONT_YMD] VARCHAR(8), \
[CNL_YMD] VARCHAR(8), \
[PAY_METHOD] VARCHAR(2), \
[DEADLINE_FLAG] VARCHAR(20), \
[CONT_STS_CD] VARCHAR(2), \
[NONPAY_OBJ_FLAG] VARCHAR(2), \
[NONPAY_MANAGE_FLAG] VARCHAR(2), \
[NONPAY_MANAGE_AMT] NUMERIC(10), \
[WARR_AMT_SUM] NUMERIC(10), \
[UNPAY_AMT_SUM] NUMERIC(10), \
[NONPAY_MM_CNT] NUMERIC(10), \
[ZIP_NO1] VARCHAR(3), \
[ZIP_NO2] VARCHAR(3), \
[CITY] VARCHAR(30), \
[AREA] VARCHAR(30), \
[TOWN] VARCHAR(30), \
[VILLAGE] VARCHAR(30), \
[ADDR1_M] VARCHAR(30), \
[ADDR1_S] VARCHAR(30), \
[CO_LIVE_NM] VARCHAR(60), \
[DONG_NUM] VARCHAR(20), \
[HOSU] VARCHAR(20), \
[BLD_NM] VARCHAR(60), \
[DETAIL_FLOOR] VARCHAR(20), \
[NEW_ADDR_UNION] VARCHAR(300), \
[CUST_NUM] VARCHAR(10), \
[CUST_TYPE_CD] VARCHAR(2), \
[CUST_NM] VARCHAR(30), \
[FIRM_NM] VARCHAR(50), \
[BIZ_REGI_NUM] VARCHAR(10), \
[SOC_NUM] VARCHAR(13), \
[REPRE_NM] VARCHAR(30), \
[CP_DDD] VARCHAR(4), \
[CP_EXN] VARCHAR(4), \
[CP_NUM] VARCHAR(4), \
[OWNHOUSE_TEL_DDD] VARCHAR(4), \
[OWNHOUSE_TEL_EXN] VARCHAR(4), \
[OWNHOUSE_TEL_NUM] VARCHAR(4), \
[PAY_CUST_NUM] VARCHAR(10), \
[PAY_CUST_TYPE_CD] VARCHAR(2), \
[PAY_CUST_NM] VARCHAR(30), \
[PAY_FIRM_NM] VARCHAR(50), \
[PAY_BIZ_REGI_NUM] VARCHAR(10), \
[PAY_SOC_NUM] VARCHAR(13), \
[PAY_REPRE_NM] VARCHAR(30), \
[PAY_CP_NUM] VARCHAR(20), \
[PAY_TEL_NUM] VARCHAR(20), \
[OWNER_CUST_NUM] VARCHAR(10), \
[OWNER_CUST_TYPE_CD] VARCHAR(2), \
[OWNER_CUST_NM] VARCHAR(30), \
[OWNER_FIRM_NM] VARCHAR(50), \
[OWNER_BIZ_REGI_NUM] VARCHAR(10), \
[OWNER_SOC_NUM] VARCHAR(13), \
[OWNER_REPRE_NM] VARCHAR(30), \
[OWNER_CP_NUM] VARCHAR(20), \
[OWNER_TEL_NUM] VARCHAR(20), \
[NONPAY_ACTIVE_DEPT] VARCHAR(4), \
[NONPAY_MANAGE_ZONE] VARCHAR(6), \
[TAKER_NM] VARCHAR(30), \
[RMK] VARCHAR(300), \
[STOP_FLAG] VARCHAR(2), \
[CUST_FLAG] VARCHAR(1), \
[ACCEPT_AMT] NUMERIC, \
[SEL_M_CNT] NUMERIC, \
[VISIT_FLAG] VARCHAR(1), \
[CUT_FLAG] VARCHAR(1), \
[AUTO_FLAG] VARCHAR(1), \
[RELE_FLAG] VARCHAR(1), \
[RCEI_FLAG] VARCHAR(1), \
[RSLT_NOTICE_YN] VARCHAR(1), \
[OBJ_PERS_SOC_NUM] VARCHAR2(20), \
[LAW_ETC_AMT] VARCHAR(10), \
[DEBT_AMT] VARCHAR(10), \
[DEBT_UNPAY_AMT] VARCHAR(10), \
[ALL_UNPAY] NUMERIC(10), \
[LAW_TOWN] VARCHAR(30), \
[NEW_ROAD_NM] VARCHAR(200), \
[NEW_ADDR_M] VARCHAR(5), \
[NEW_ADDR_S] VARCHAR(5), \
[CURR_ADDR_UNION] VARCHAR(300), \
[ENER_VOUCH_YN] VARCHAR(1), \
[EARLY_ALAM_YN] VARCHAR(1), \
[VISIT_REG_YN] VARCHAR(1), \
[WARR_YN] VARCHAR(1), \
[READ_MEMO_YN] VARCHAR(1), \
[INST_PLACE_NUM] VARCHAR(9), \
[REAL_NM_CONF_YN] VARCHAR(2), \
[SAFE_KEY_YN] VARCHAR(2), \
[RELEASE_YN] VARCHAR(2), \
[STOP_YN] VARCHAR(2), [PAYCONFIRM_FLAG] VARCHAR(5), \
CONSTRAINT [sqlite_autoindex_C6202_STOP_OBJ_1] PRIMARY KEY ([USE_CONT_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6202_VISITREG] ( \
[JOB_DTM] DATE  NULL, \
[NONPAY_ACTIVE_YMD] VARCHAR(8)  NULL, \
[ACTIVE_SUCCESS_YN] VARCHAR(1)  NULL, \
[CUST_RELAT_CD] VARCHAR(2)  NULL, \
[TAKER_NM] VARCHAR(30)  NULL, \
[RMK] VARCHAR(300)  NULL, \
[VISIT_WHY_CD] VARCHAR(2)  NULL, \
[CRT_EMPID] VARCHAR(9)  NULL, \
[CRT_IP] VARCHAR(32)  NULL, \
[USE_CONT_NUM] VARCHAR(10)  NULL, \
PRIMARY KEY ([JOB_DTM],[USE_CONT_NUM]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6301_CHANGEDATA] ( \
[MTR_NUM] VARCHAR2(9) NOT NULL, \
[OBJ_CRT_YMD] VARCHAR2(8) NOT NULL, \
[REPL_OCCU_FLAG] VARCHAR2(2), \
[CENTER_CD] VARCHAR2(2), \
[PDA_REPL_JOB_ITEM] VARCHAR2(2), \
[INST_PLACE_NUM] VARCHAR2(9), \
[CITY] VARCHAR2(30), \
[AREA] VARCHAR2(30), \
[TOWN] VARCHAR2(30), \
[VILLAGE] VARCHAR2(30), \
[ADDR1_M] VARCHAR2(30), \
[ADDR1_S] VARCHAR2(30), \
[LOT_NUM_SECOND_ADDR] VARCHAR2(100), \
[CO_LIVE_NM] VARCHAR2(60), \
[HOUSE_CNT] VARCHAR2(6), \
[BLD_NM] VARCHAR2(150), \
[DETA_FLOOR] VARCHAR2(6), \
[CUST_NUM] VARCHAR2(10), \
[CUST_TYPE_CD] VARCHAR2(2), \
[CUST_NM] VARCHAR2(30), \
[FIRM_NM] VARCHAR2(50), \
[BIZ_REGI_NUM] VARCHAR2(10), \
[SOC_NUM] VARCHAR2(13), \
[REPRE_NM] VARCHAR2(30), \
[CP_DDD] VARCHAR2(4), \
[CP_EXN] VARCHAR2(4), \
[CP_NUM] VARCHAR2(4), \
[OWNHOUSE_TEL_DDD] VARCHAR2(4), \
[OWNHOUSE_TEL_EXN] VARCHAR2(4), \
[OWNHOUSE_TEL_NUM] VARCHAR2(4), \
[FIRM_TEL_DDD] VARCHAR2(4), \
[FIRM_TEL_EXN] VARCHAR2(4), \
[FIRM_TEL_NUM] VARCHAR2(4), \
[USE_CONT_NUM] VARCHAR2(10), \
[PROD_NM] VARCHAR2(50), \
[CONT_YMD] VARCHAR2(8), \
[CNL_YMD] VARCHAR2(8), \
[MTR_ID_NUM] VARCHAR2(20), \
[MTR_MODEL_CD] VARCHAR2(5), \
[MTR_GRD] VARCHAR2(8), \
[MTR_FORM] VARCHAR2(2), \
[MTR_TYPE] VARCHAR2(2), \
[MTR_REMOTE_FLAG] VARCHAR2(2), \
[MTR_KIND] VARCHAR2(1), \
[MTR_FORM_APPRO_YN] VARCHAR2(6), \
[MTR_DIGIT_CNT] NUMERIC(2), \
[MTR_NEW_FIX_FLAG] VARCHAR2(2), \
[FIX_FIRM_NM_CD] VARCHAR2(2), \
[MTR_VALID_YM] VARCHAR2(6), \
[MTR_LOC_FLAG] VARCHAR2(2), \
[MTR_DETA_LOC] VARCHAR2(30), \
[COMPENS_NUM] VARCHAR2(8), \
[COMPENS_ID_NUM] VARCHAR2(8), \
[COMPENS_MODEL_CD] VARCHAR2(8), \
[COMPENS_FLAG] VARCHAR2(2), \
[COMPENS_VALID_YM] VARCHAR2(6), \
[COMPENS_FORM_APPRO_YN] VARCHAR2(6), \
[BEFO_INDI_VM] NUMERIC(9), \
[BEFO_INDI_VA] NUMERIC(9), \
[BEFO_INDI_VC] NUMERIC(9), \
[REPL_STS] VARCHAR2(2), \
[ZIP_NO1] VARCHAR2(3), \
[ZIP_NO2] VARCHAR2(3), \
[MTR_FEE_FREE_FLAG] VARCHAR2(1), \
[MTR_REPL_WHY] VARCHAR2(6), \
[MTR_BAR] VARCHAR2(20), \
[AFTER_MTR_ID_NUM] VARCHAR2(9), \
[AFTER_MTR_MODEL_CD] VARCHAR2(5), \
[AFTER_MTR_GRD] VARCHAR2(6), \
[AFTER_MTR_FORM] VARCHAR2(2), \
[AFTER_MTR_TYPE] VARCHAR2(2), \
[AFTER_MTR_REMOTE_FLAG] VARCHAR2(2), \
[AFTER_MTR_KIND] VARCHAR2(2), \
[AFTER_MTR_DIGIT_CNT] VARCHAR2(2), \
[AFTER_MTR_NEW_FIX_FLAG] VARCHAR2(2), \
[AFTER_FIX_FIRM_NM_CD] VARCHAR2(2), \
[AFTER_MTR_VALID_YM] VARCHAR2(6), \
[COMPENS_FEE_FREE_FLAG] VARCHAR2(1), \
[COMPENS_REPL_WHY] VARCHAR2(2), \
[COMPENS_BAR] VARCHAR2(30), \
[AFTER_COMPENS_NUM] VARCHAR2(9), \
[AFTER_COMPENS_ID_NUM] VARCHAR2(8), \
[AFTER_COMPENS_MODEL_CD] VARCHAR2(8), \
[AFTER_COMPENS_VALID_YM] VARCHAR2(6), \
[AFTER_COMPENS_PRESS] VARCHAR2(6), \
[REMOVE_INDI_VM] VARCHAR2(9), \
[REMOVE_INDI_VA] VARCHAR2(9), \
[REMOVE_INDI_VC] VARCHAR2(9), \
[REMOVE_MTR_FLAG] VARCHAR2(6), \
[REPL_NOT_PERMIT_WHY] VARCHAR2(3), \
[JOB_DTM] VARCHAR2(14), \
[JOBER_EMPID] VARCHAR2(9), \
[MTR_PHOTO] TEXT, \
[COMPENS_PHOTO] TEXT, \
[CUST_SIGN] TEXT, \
[SEND_YN] VARCHAR2(1), \
[AFTER_MTR_APPRO_YN] VARCHAR(1), \
[AFTER_FORM_APPRO_YN] VARCHAR(1), \
[INST_INDI_VM] VARCHAR(9), \
[INST_INDI_VA] VARCHAR(9), \
[INST_INDI_VC] VARCHAR(9), \
[TEMPER] VARCHAR2(12), \
[PRESS] VARCHAR2(8), \
[REVIS_PARA] VARCHAR2(10), \
[BEFO_TEMPER] VARCHAR2(13), \
[BEFO_PRESS] VARCHAR2(8), \
[BEFO_REVIS_PARA] VARCHAR2(10), \
[UPD_DTM] VARCHAR(14), \
[UPD_EMPID] VARCHAR(9), \
[CRT_DTM] VARCHAR(14), \
[CRT_EMPID] VARCHAR(9), \
[PDA_NUM] VARCHAR(1), \
[TREAT_FLAG] VARCHAR(2), \
[REVIS_FLAG] VARCHAR(2), \
[MTR_SUPPLY_STS] VARCHAR(20), \
[COMPENS_MAKER_NM] VARCHAR(30), \
[VISIT_YMD] VARCHAR2(8), \
[MEMO] VARCHAR2(100), \
[LAW_TOWN] VARCHAR2(30), \
[NEW_ROAD_NM] VARCHAR2(255), \
[NEW_ADDR_M] VARCHAR2(10), \
[NEW_ADDR_S] VARCHAR2(10), \
[BACK_REPL_STS] VARCHAR2(2), \
CONSTRAINT [sqlite_autoindex_C6301_CHANGEDATA_1] PRIMARY KEY ([MTR_NUM], [OBJ_CRT_YMD]))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6501_COMPLAIN] ( \
[PROMISE_ASSIGN_SEQ] VARCHAR(10), \
[CIVIL_SERV_RECEIVE_NUM] VARCHAR(20), \
[TREAT_SEQ] VARCHAR(10), \
[USE_CONT_NUM] VARCHAR(20), \
[PROMISE_YMD] VARCHAR(20), \
[PROMISE_TIME] VARCHAR(20), \
[CIVIL_SERV_CLASS_CD] VARCHAR2(10), \
[CIVIL_SERV_CLASS_NM] VARCHAR(50), \
[CURR_ADDR_UNION] VARCHAR(300), \
[NEW_ADDR_UNION] VARCHAR(300), \
[BLD_FLOOR] VARCHAR(30), \
[HOUSE_CNT] VARCHAR(30), \
[ETC_ADDR] VARCHAR(100), \
[ZIP_SEQ] VARCHAR(50), \
[ZIP_NO1] VARCHAR(10), \
[ZIP_NO2] VARCHAR(10), \
[CITY] VARCHAR(30), \
[COUNTY] VARCHAR(30), \
[TOWN] VARCHAR(30), \
[VILLAGE_RI] VARCHAR(50), \
[VILLAGE] VARCHAR(50), \
[BUILDING] VARCHAR(50), \
[ADDR1_M] VARCHAR(20), \
[ADDR1_S] VARCHAR(20), \
[LAW_TOWN] VARCHAR(50), \
[NEW_ROAD_NM] VARCHAR(50), \
[NEW_ADDR_M] VARCHAR(20), \
[NEW_ADDR_S] VARCHAR(20), \
[CIVIL_SERV_DESC] VARCHAR(200), \
[PROMISE_ASSIGN_DESC] VARCHAR(200), \
[TREAT_END_DESC] VARCHAR(200), \
[REQ_NM] VARCHAR(50), \
[REQ_TEL_DDD] VARCHAR(5), \
[REQ_TEL_EXN] VARCHAR(5), \
[REQ_TEL_NUM] VARCHAR(5), \
[REQ_CP_DDD] VARCHAR(5), \
[REQ_CP_EXN] VARCHAR(5), \
[REQ_CP_NUM] VARCHAR(5), \
[CUST_NOTICE_CHK_YN] VARCHAR(5), \
[PROC_STS] VARCHAR(30))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6501_NOTICE] ( \
[NOTICE_SEQ] NUMBUER(10) NULL, \
[DUTY_FLAG] NUMBUER(10) NULL, \
[CENTER_NM] VARCHAR2(50)  NULL, \
[WRITE_NM] VARCHAR(50)  NULL, \
[NOTICE_TIME] VARCHAR(30)  NULL, \
[NOTICE_TITLE] CHAR(300) NULL, \
[NOTICE_DESC] VARCHAR2(3000) NULL, \
[NOTICE_FLAG] VARCHAR(2) NULL, \
[CHK_YN] VARCHAR(2)  NULL)"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [GUM_FEE_INFO] ( \
[USE_CONT_NUM] VARCHAR(20), \
[CUST_NM] VARCHAR(50), \
[FIRM_NM] VARCHAR(100), \
[CURR_ADDR_UNION] VARCHAR(300), \
[NEW_ADDR_UNION] VARCHAR(300), \
[REQ_YM] VARCHAR(15), \
[INDI_COMPENS_VC] VARCHAR(30), \
[USE_QTY] VARCHAR(30), \
[USE_AMT] VARCHAR(30), \
[PAY_YN] VARCHAR(30), \
[CP_DDD] VARCHAR(6), \
[CP_EXN] VARCHAR(6), \
[CP_NUM] VARCHAR(6), \
[TOT_UNPAY_AMT] VARCHAR(30), \
[FLAG] VARCHAR(5), \
[CUST_NUM] VARCHAR(20))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [GUM_SMS_TARGET] ( \
[ZIP_NO1] VARCHAR(10), \
[ZIP_NO2] VARCHAR(10), \
[CITY] VARCHAR(50), \
[COUNTY] VARCHAR(50), \
[TOWN] VARCHAR(50), \
[VILLAGE] VARCHAR(50), \
[ISLANDS] VARCHAR(100), \
[HILL] VARCHAR(50), \
[ADDR1_M] VARCHAR(20), \
[ADDR1_S] VARCHAR(20), \
[CO_LIVE_NM] VARCHAR(100), \
[BLD_NM] VARCHAR(100), \
[HOSU] VARCHAR(20), \
[DETA_FLOOR] VARCHAR(100), \
[CURR_ADDR_UNION] VARCHAR(350), \
[NEW_ADDR_UNION] VARCHAR(350), \
[LAW_TOWN] VARCHAR(100), \
[NEW_ROAD_NM] VARCHAR(100), \
[NEW_ADDR_M] VARCHAR(30), \
[NEW_ADDR_S] VARCHAR(30), \
[RECEIVER_TEL_DDD] VARCHAR(6), \
[RECEIVER_TEL_EXN] VARCHAR(6), \
[RECEIVER_TEL_NUM] VARCHAR(6), \
[PLAN_DTM] VARCHAR(30), \
[SEND_DTM] VARCHAR(30), \
[GMTR_SEND_FLAG] VARCHAR(10), \
[GMTR_SEND_STS] VARCHAR(10), \
[SMS_DESC] VARCHAR(350), \
[RECEIVE_DTM] VARCHAR(30), \
[RCV_SMS_DESC] VARCHAR(350), \
[RCV_SMS_VC] VARCHAR(100), \
[RCV_SMS_CHR] VARCHAR(300), \
[GMTR_APPLY_YMD] VARCHAR(30), \
[GMTR_APPLY_YN] VARCHAR(10), \
[STS_VERIFY_CD] VARCHAR(20), \
[RCV_STS_VERIFY_CD] VARCHAR(20), \
[SMS_SEND_AGREE_YN] VARCHAR(20), \
[CHK_YN] VARCHAR(5), \
[SEND_PLC_FLAG] VARCHAR(5), \
[SMS_SEND_FLAG] VARCHAR(5), \
[USE_CONT_NUM] VARCHAR(20), \
[CUST_NUM] VARCHAR(20), \
[CUST_NM] VARCHAR(50), \
[NONPAY_MANAGE_SEC] VARCHAR(20), \
[SMS_NUM] VARCHAR(20), \
[SERVER_DTM] VARCHAR(30), \
[MTR_ID_NUM] VARCHAR(30))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_ADDR] ( \
[AREA] VARCHAR2(30) NOT NULL, \
[TOWN] VARCHAR2(30), \
[COMPX_FLAG_NM] VARCHAR2(60), \
[NEW_ROAD_NM] VARCHAR2(255), \
[RCV_YN] VARCHAR(5))"
);

g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_CALCUL] ( \
[PARAM1] VARCHAR(100), \
[PARAM2] VARCHAR(100), \
[PARAM3] VARCHAR(100), \
[PARAM4] VARCHAR(100), \
[PARAM5] VARCHAR(100), \
[PARAM6] VARCHAR(100), \
[PARAM7] VARCHAR(100), \
[PARAM8] VARCHAR(100), \
[PARAM9] VARCHAR(100), \
[PARAM10] VARCHAR(100), \
[PARAM11] VARCHAR(100), \
[PARAM12] VARCHAR(100), \
[PARAM13] VARCHAR(100), \
[PARAM14] VARCHAR(100), \
[PARAM15] VARCHAR(100), \
[PARAM16] VARCHAR(100), \
[PARAM17] VARCHAR(100), \
[PARAM18] VARCHAR(100), \
[PARAM19] VARCHAR(100), \
[PARAM20] VARCHAR(100), \
[PARAM21] VARCHAR(100), \
[PARAM22] VARCHAR(100), \
[PARAM23] VARCHAR(100), \
[PARAM24] VARCHAR(100), \
[PARAM25] VARCHAR(100), \
[PARAM26] VARCHAR(100), \
[PARAM27] VARCHAR(100), \
[PARAM28] VARCHAR(100), \
[PARAM29] VARCHAR(100), \
[PARAM30] VARCHAR(100), \
[PARAM31] VARCHAR(100), \
[PARAM32] VARCHAR(100), \
[PARAM33] VARCHAR(100), \
[PARAM34] VARCHAR(100), \
[PARAM35] VARCHAR(100), \
[PARAM36] VARCHAR(100), \
[PARAM37] VARCHAR(100), \
[PARAM38] VARCHAR(100), \
[PARAM39] VARCHAR(100), \
[PARAM40] VARCHAR(100), \
[PARAM41] VARCHAR(100), \
[PARAM42] VARCHAR(100), \
[PARAM43] VARCHAR(100), \
[PARAM44] VARCHAR(100), \
[PARAM45] VARCHAR(100), \
[PARAM46] VARCHAR(100), \
[PARAM47] VARCHAR(100), \
[PARAM48] VARCHAR(100), \
[PARAM49] VARCHAR(100), \
[PARAM50] VARCHAR(100), \
[PARAM51] VARCHAR(100), \
[PARAM52] VARCHAR(100), \
[PARAM53] VARCHAR(100), \
[PARAM54] VARCHAR(100), \
[PARAM55] VARCHAR(100), \
[PARAM56] VARCHAR(100), \
[PARAM57] VARCHAR(100), \
[PARAM58] VARCHAR(100), \
[PARAM59] VARCHAR(100), \
[PARAM60] VARCHAR(100), \
[PARAM61] VARCHAR(100), \
[PARAM62] VARCHAR(100), \
[PARAM63] VARCHAR(100), \
[PARAM64] VARCHAR(100), \
[PARAM65] VARCHAR(100), \
[PARAM66] VARCHAR(100), \
[PARAM67] VARCHAR(100), \
[PARAM68] VARCHAR(100), \
[PARAM69] VARCHAR(100), \
[PARAM70] VARCHAR(100), \
[PARAM71] VARCHAR(100), \
[PARAM72] VARCHAR(100), \
[PARAM73] VARCHAR(100), \
[PARAM74] VARCHAR(100), \
[PARAM75] VARCHAR(100), \
[PARAM76] VARCHAR(100), \
[PARAM77] VARCHAR(100), \
[PARAM78] VARCHAR(100), \
[PARAM79] VARCHAR(100), \
[PARAM80] VARCHAR(100), \
[PARAM81] VARCHAR(100), \
[PARAM82] VARCHAR(100), \
[PARAM83] VARCHAR(100), \
[PARAM84] VARCHAR(100), \
[PARAM85] VARCHAR(100), \
[PARAM86] VARCHAR(100), \
[PARAM87] VARCHAR(100), \
[PARAM88] VARCHAR(100), \
[PARAM89] VARCHAR(100), \
[PARAM90] VARCHAR(100), \
[PARAM91] VARCHAR(100), \
[PARAM92] VARCHAR(100), \
[PARAM93] VARCHAR(100), \
[PARAM94] VARCHAR(100), \
[PARAM95] VARCHAR(100), \
[PARAM96] VARCHAR(100), \
[PARAM97] VARCHAR(100), \
[PARAM98] VARCHAR(100), \
[PARAM99] VARCHAR(100), \
[PARAM100] VARCHAR(100))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS RCV_COUNT ( \
[GUBUN] VARCHAR2(1), \
[CNT] VARCHAR2(3))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_NONPAY_ACCOUNT] ( \
[PARAM1] VARCHAR(100), \
[PARAM2] VARCHAR(100), \
[PARAM3] VARCHAR(100), \
[PARAM4] VARCHAR(100), \
[PARAM5] VARCHAR(100), \
[PARAM6] VARCHAR(100), \
[PARAM7] VARCHAR(100), \
[PARAM8] VARCHAR(100), \
[PARAM9] VARCHAR(100), \
[PARAM10] VARCHAR(100), \
[PARAM11] VARCHAR(100), \
[PARAM12] VARCHAR(100), \
[PARAM13] VARCHAR(100), \
[PARAM14] VARCHAR(100), \
[PARAM15] VARCHAR(100), \
[PARAM16] VARCHAR(100), \
[PARAM17] VARCHAR(100), \
[PARAM18] VARCHAR(100), \
[PARAM19] VARCHAR(100), \
[PARAM20] VARCHAR(100), \
[PARAM21] VARCHAR(100), \
[PARAM22] VARCHAR(100), \
[PARAM23] VARCHAR(100), \
[PARAM24] VARCHAR(100), \
[PARAM25] VARCHAR(100))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_NONPAY_MTRINFO] ( \
[PARAM1] VARCHAR(100), \
[PARAM2] VARCHAR(100), \
[PARAM3] VARCHAR(100), \
[PARAM4] VARCHAR(100), \
[PARAM5] VARCHAR(100), \
[PARAM6] VARCHAR(100), \
[PARAM7] VARCHAR(100), \
[PARAM8] VARCHAR(100), \
[PARAM9] VARCHAR(100), \
[PARAM10] VARCHAR(100), \
[PARAM11] VARCHAR(100), \
[PARAM12] VARCHAR(100), \
[PARAM13] VARCHAR(100), \
[PARAM14] VARCHAR(100), \
[PARAM15] VARCHAR(100), \
[PARAM16] VARCHAR(100), \
[PARAM17] VARCHAR(100), \
[PARAM18] VARCHAR(100), \
[PARAM19] VARCHAR(100), \
[PARAM20] VARCHAR(100), \
[PARAM21] VARCHAR(100), \
[PARAM22] VARCHAR(100), \
[PARAM23] VARCHAR(100), \
[PARAM24] VARCHAR(100), \
[PARAM25] VARCHAR(100))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_NONPAY_MTRREQYM] ( \
[PARAM1] VARCHAR(100), \
[PARAM2] VARCHAR(100), \
[PARAM3] VARCHAR(100), \
[PARAM4] VARCHAR(100), \
[PARAM5] VARCHAR(100), \
[PARAM6] VARCHAR(100), \
[PARAM7] VARCHAR(100), \
[PARAM8] VARCHAR(100), \
[PARAM9] VARCHAR(100), \
[PARAM10] VARCHAR(100), \
[PARAM11] VARCHAR(100), \
[PARAM12] VARCHAR(100), \
[PARAM13] VARCHAR(100), \
[PARAM14] VARCHAR(100), \
[PARAM15] VARCHAR(100), \
[PARAM16] VARCHAR(100), \
[PARAM17] VARCHAR(100), \
[PARAM18] VARCHAR(100), \
[PARAM19] VARCHAR(100), \
[PARAM20] VARCHAR(100), \
[PARAM21] VARCHAR(100), \
[PARAM22] VARCHAR(100), \
[PARAM23] VARCHAR(100), \
[PARAM24] VARCHAR(100), \
[PARAM25] VARCHAR(100))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_NONPAY_REQYM] ( \
[PARAM1] VARCHAR(100), \
[PARAM2] VARCHAR(100), \
[PARAM3] VARCHAR(100), \
[PARAM4] VARCHAR(100), \
[PARAM5] VARCHAR(100), \
[PARAM6] VARCHAR(100), \
[PARAM7] VARCHAR(100), \
[PARAM8] VARCHAR(100), \
[PARAM9] VARCHAR(100), \
[PARAM10] VARCHAR(100), \
[PARAM11] VARCHAR(100), \
[PARAM12] VARCHAR(100), \
[PARAM13] VARCHAR(100), \
[PARAM14] VARCHAR(100), \
[PARAM15] VARCHAR(100), \
[PARAM16] VARCHAR(100), \
[PARAM17] VARCHAR(100), \
[PARAM18] VARCHAR(100), \
[PARAM19] VARCHAR(100), \
[PARAM20] VARCHAR(100), \
[PARAM21] VARCHAR(100), \
[PARAM22] VARCHAR(100), \
[PARAM23] VARCHAR(100), \
[PARAM24] VARCHAR(100), \
[PARAM25] VARCHAR(100))"
);

		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_RELEASE] ( \
[PARAM1] VARCHAR(200), \
[PARAM2] VARCHAR(200), \
[PARAM3] VARCHAR(200), \
[PARAM4] VARCHAR(200), \
[PARAM5] VARCHAR(200), \
[PARAM6] VARCHAR(200), \
[PARAM7] VARCHAR(200), \
[PARAM8] VARCHAR(200), \
[PARAM9] VARCHAR(200), \
[PARAM10] VARCHAR(200), \
[PARAM11] VARCHAR(200), \
[PARAM12] VARCHAR(200), \
[PARAM13] VARCHAR(200), \
[PARAM14] VARCHAR(200), \
[PARAM15] VARCHAR(200), \
[PARAM16] VARCHAR(200), \
[PARAM17] VARCHAR(200), \
[PARAM18] VARCHAR(200), \
[PARAM19] VARCHAR(200), \
[PARAM20] VARCHAR(200), \
[PARAM21] VARCHAR(200), \
[PARAM22] VARCHAR(200), \
[PARAM23] VARCHAR(200), \
[PARAM24] VARCHAR(200), \
[PARAM25] VARCHAR(200))"
);

g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [RCV_TMP] ( \
[PARAM1] VARCHAR(100), \
[PARAM2] VARCHAR(100), \
[PARAM3] VARCHAR(100), \
[PARAM4] VARCHAR(100), \
[PARAM5] VARCHAR(100), \
[PARAM6] VARCHAR(100), \
[PARAM7] VARCHAR(100), \
[PARAM8] VARCHAR(100), \
[PARAM9] VARCHAR(100), \
[PARAM10] VARCHAR(100), \
[PARAM11] VARCHAR(100), \
[PARAM12] VARCHAR(100), \
[PARAM13] VARCHAR(100), \
[PARAM14] VARCHAR(100), \
[PARAM15] VARCHAR(100), \
[PARAM16] VARCHAR(100), \
[PARAM17] VARCHAR(100), \
[PARAM18] VARCHAR(100), \
[PARAM19] VARCHAR(100), \
[PARAM20] VARCHAR(100), \
[PARAM21] VARCHAR(100), \
[PARAM22] VARCHAR(100), \
[PARAM23] VARCHAR(100), \
[PARAM24] VARCHAR(100), \
[PARAM25] VARCHAR(100), \
[PARAM26] VARCHAR(100), \
[PARAM27] VARCHAR(100), \
[PARAM28] VARCHAR(100), \
[PARAM29] VARCHAR(100), \
[PARAM30] VARCHAR(100), \
[PARAM31] VARCHAR(100), \
[PARAM32] VARCHAR(100), \
[PARAM33] VARCHAR(100), \
[PARAM34] VARCHAR(100), \
[PARAM35] VARCHAR(100), \
[PARAM36] VARCHAR(100), \
[PARAM37] VARCHAR(100), \
[PARAM38] VARCHAR(100), \
[PARAM39] VARCHAR(100), \
[PARAM40] VARCHAR(100), \
[PARAM41] VARCHAR(100), \
[PARAM42] VARCHAR(100), \
[PARAM43] VARCHAR(100), \
[PARAM44] VARCHAR(100), \
[PARAM45] VARCHAR(100), \
[PARAM46] VARCHAR(100), \
[PARAM47] VARCHAR(100), \
[PARAM48] VARCHAR(100), \
[PARAM49] VARCHAR(100), \
[PARAM50] VARCHAR(100), \
[PARAM51] VARCHAR(100), \
[PARAM52] VARCHAR(100), \
[PARAM53] VARCHAR(100), \
[PARAM54] VARCHAR(100), \
[PARAM55] VARCHAR(100), \
[PARAM56] VARCHAR(100), \
[PARAM57] VARCHAR(100), \
[PARAM58] VARCHAR(100), \
[PARAM59] VARCHAR(100), \
[PARAM60] VARCHAR(100), \
[PARAM61] VARCHAR(100), \
[PARAM62] VARCHAR(100), \
[PARAM63] VARCHAR(100), \
[PARAM64] VARCHAR(100), \
[PARAM65] VARCHAR(100), \
[PARAM66] VARCHAR(100), \
[PARAM67] VARCHAR(100), \
[PARAM68] VARCHAR(100), \
[PARAM69] VARCHAR(100), \
[PARAM70] VARCHAR(100), \
[PARAM71] VARCHAR(100), \
[PARAM72] VARCHAR(100), \
[PARAM73] VARCHAR(100), \
[PARAM74] VARCHAR(100), \
[PARAM75] VARCHAR(100), \
[PARAM76] VARCHAR(100), \
[PARAM77] VARCHAR(100), \
[PARAM78] VARCHAR(100), \
[PARAM79] VARCHAR(100), \
[PARAM80] VARCHAR(100), \
[PARAM81] VARCHAR(100), \
[PARAM82] VARCHAR(100), \
[PARAM83] VARCHAR(100), \
[PARAM84] VARCHAR(100), \
[PARAM85] VARCHAR(100), \
[PARAM86] VARCHAR(100), \
[PARAM87] VARCHAR(100), \
[PARAM88] VARCHAR(100), \
[PARAM89] VARCHAR(100), \
[PARAM90] VARCHAR(100), \
[PARAM91] VARCHAR(100), \
[PARAM92] VARCHAR(100), \
[PARAM93] VARCHAR(100), \
[PARAM94] VARCHAR(100), \
[PARAM95] VARCHAR(100), \
[PARAM96] VARCHAR(100), \
[PARAM97] VARCHAR(100), \
[PARAM98] VARCHAR(100), \
[PARAM99] VARCHAR(100), \
[PARAM100] VARCHAR(100))"
);

		//공통코드
		g_Sql_DirectExecute2(sql, "ALTER TABLE COMMONCODE ADD COLUMN [C_VALUE] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE COMMONCODE ADD COLUMN [SORT_ORDER] VARCHAR(10)");

		//검침
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [BLD_NUM] VARCHAR(20)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INSP_YN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INSP_MEMO] VARCHAR(300)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INDI_INSP_VM] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INDI_INSP_VA] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INDI_INSP_VC] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INSP_YMD] VARCHAR(20)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INSP_SAVE_YN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [SMS_GMTR_MAN_YN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [SMS_SEND_AGREE_YN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [NONPAY_MANAGE_SEC] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [SMS_CP_DDD] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [SMS_CP_EXN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [SMS_CP_NUM] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [INST_PLACE_NUM] VARCHAR(20)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE GUMDATA ADD COLUMN [COUNS_HIST] VARCHAR(10)");

		//안전점검 연소기
		g_Sql_DirectExecute2(sql, "ALTER TABLE NORMAL_BUR ADD COLUMN [TIMER_COCK_INST_YN] VARCHAR(1)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE NORMAL_BUR ADD COLUMN [FUSE_COCK_INST_YN] VARCHAR(1)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE NORMAL_BUR ADD COLUMN [GAS_RSLT] VARCHAR(1)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE NORMAL_BUR ADD COLUMN [HOSE_RSLT] VARCHAR(1)");

		//안전점검 그룹주소
		g_Sql_DirectExecute2(sql, "ALTER TABLE NORMAL_GROUP ADD COLUMN [NEW_ROAD_NM] VARCHAR(100)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE NORMAL_GROUP ADD COLUMN [NEW_ADDR_M] VARCHAR(30)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE NORMAL_GROUP ADD COLUMN [NEW_ADDR_S] VARCHAR(30)");

		//특정점검 바코드 사진
		g_Sql_DirectExecute2(sql, "ALTER TABLE SPECIAL_DATA ADD COLUMN [INST_BAR_PHOTO_YN] VARCHAR(2)");

		//사용자정보
		g_Sql_DirectExecute2(sql, "ALTER TABLE USER_INFO ADD COLUMN [LOCK_YN] VARCHAR(1)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE USER_INFO ADD COLUMN [NP_WORK_YN] VARCHAR(2)");

Finally:

		sql->m_bTranFlag = TRUE;
		
		DelSqLite(sql);
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> End : %d",Time_GetSecond(),0,0);

		return;
	}
	
	void Table_Regum_Add(void)
	{
		handle hdb = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		sql->Begin(sql);
		
		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [REGUMDATA] ( \
                                [REQ_YM] varchar(6) NOT NULL, \
								[DEADLINE_FLAG] varchar(2) NOT NULL, \
								[MTR_NUM] varchar(9) NOT NULL, \
								[GUM_TYPE] varchar(2) NOT NULL, \
								[GMTR_APPLY_YMD] varchar(8), \
								[GMTR_OBJ_FLAG] varchar(2), \
								[SUPPLY_STS_CD] varchar(20), \
								[SUPPLY_STS_WHY] varchar(20), \
								[STR_IND_APPLY_YMD] VARCHAR(8), \
								[BASE_YMD] varchar(8), \
								[MTR_ID_NUM] varchar(20), \
								[MTR_LOC_FLAG] varchar(2), \
								[MTR_RESOU_FLAG] varchar(2), \
								[GRD_TITLE] varchar(30), \
								[USAGE_TITLE] varchar(30), \
								[HOUSE_NUM_ORD] varchar(40), \
								[DONG_ORD] varchar(40), \
								[MTR_COURSE] varchar(5), \
								[USE_CONT_NUM] varchar(10), \
								[PROD_CD] varchar(30), \
								[CONT_YMD] varchar(8), \
								[CNL_YMD] varchar(8), \
								[PAY_METHOD] varchar(20), \
								[NONPAY_EXIST_YN] varchar(1), \
								[ZIP_NO1] varchar(3), \
								[ZIP_NO2] varchar(3), \
								[AREA] varchar(30), \
								[TOWN] varchar(30), \
								[VILLAGE] varchar(30), \
								[ADDR1_M] varchar(30), \
								[ADDR1_S] varchar(30), \
								[CO_LIVE_NM] varchar(60), \
								[DONG_NUM] varchar(20), \
								[HOSU] varchar(20), \
								[BLD_NM] varchar(60), \
								[BLD_NUM] VARCHAR(20), \
								[DETA_FLOOR] varchar(100), \
								[NEW_ADDR_UNION] varchar(100), \
								[CUST_NUM] varchar(10), \
								[CUST_TYPE_CD] varchar(2), \
								[CUST_NM] varchar(30), \
								[FIRM_NM] varchar(50), \
								[BIZ_REGI_NUM] varchar(10), \
								[SOC_NUM] varchar(13), \
								[REPRE_NM] varchar(30), \
								[CP_DDD] varchar(4), \
								[CP_EXN] varchar(4), \
								[CP_NUM] varchar(4), \
								[OWNHOUSE_TEL_DDD] varchar(4), \
								[OWNHOUSE_TEL_EXN] varchar(4), \
								[OWNHOUSE_TEL_NUM] varchar(4), \
								[BEFO_GMTR_CD_1] varchar(10), \
								[BEFO_MM_INDI_MTR_1] NUMERIC(10), \
								[BEFO_MM_INDI_COMPENS_VA_1] NUMERIC(10), \
								[BEFO_MM_INDI_COMPENS_VC_1] NUMERIC(10), \
								[BEFO_GMTR_CD_2] varchar(10), \
								[BEFO_MM_INDI_MTR_2] NUMERIC(10), \
								[BEFO_MM_INDI_COMPENS_VA_2] NUMERIC(10), \
								[BEFO_MM_INDI_COMPENS_VC_2] NUMERIC(10), \
								[BEFO_GMTR_CD_3] varchar(10), \
								[BEFO_MM_INDI_MTR_3] NUMERIC(10), \
								[BEFO_MM_INDI_COMPENS_VA_3] NUMERIC(10), \
								[BEFO_MM_INDI_COMPENS_VC_3] NUMERIC(10), \
								[BEFO_YY_GMTR_CD] varchar(10), \
								[BEFO_YY_MTR] NUMERIC(10), \
								[BEFO_YY_COMPENS_VA] NUMERIC(10), \
								[BEFO_YY_COMPENS_VC] NUMERIC(10), \
								[BEFO_MM_USE_QTY_1] NUMERIC(10), \
								[BEFO_MM_USE_QTY_2] NUMERIC(10), \
								[BEFO_MM_USE_QTY_3] NUMERIC(10), \
								[BEFO_YM_USE_QTY] NUMERIC(10), \
								[MTR_CHG_YMD] varchar(8), \
								[MTR_REPL_WHY] varchar(20), \
								[MTR_INDI_CUST] NUMERIC(10), \
								[INDI_COMPENS_CIVIL_SERV_VA] NUMERIC(10), \
								[INDI_COMPENS_CIVIL_SERV_VC] NUMERIC(10), \
								[RMK] varchar(200), \
								[MTR_WORK_CODE] varchar(2), \
								[INDI_SET_VM] varchar(10), \
								[INDI_SET_VA] varchar(10), \
								[INDI_SET_VC] varchar(10), \
								[INDI_DATE] varchar(16), \
								[CUSTOM_SIGN] TEXT, \
								[SEND_YN] varchar(1), \
								[INDI_QTY] NUMERIC(9), \
								[COMPENS_FLAG] varchar(2), \
								[GCHK_FLAG] varchar(2), \
								[GMTR_YM_FLAG] varchar(2), \
								[EBPP_FLAG] varchar(1), \
								[MTR_YN] VARCHAR(1), \
								[MONITOR_FLAG] VARCHAR(2), \
								[CUST_TRND_YN] VARCHAR(1), \
								[GMETER_SEND_YN] VARCHAR(1), \
								[CURR_TEMPER] VARCHAR(10), \
								[CURR_PRES] VARCHAR(10), \
								[CURR_REVIS_PARA] VARCHAR(10), \
								[MAX_GMTR_QTY] VARCHAR(10), \
								[LAW_TOWN] VARCHAR(30), \
								[NEW_ROAD_NM] VARCHAR(200), \
								[NEW_ADDR_M] VARCHAR(30), \
								[NEW_ADDR_S] VARCHAR(30), \
								[BIZ_TYPE_YN] VARCHAR(1), \
								[SAME_GMTR_YN] VARCHAR(1), \
								[SELF_GMTR_YN] VARCHAR2(2), \
								[MTR_FORM] VARCHAR2(20), \
								[CHK_MEMO] VARCHAR2(200), \
								[INSP_YN] VARCHAR(5), \
								[INSP_MEMO] VARCHAR(300), \
								CONSTRAINT [sqlite_autoindex_REGUMDATA_1] PRIMARY KEY ([REQ_YM], [DEADLINE_FLAG], [MTR_NUM], [GUM_TYPE]))"
							);
							
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [INDI_INSP_VM] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [INDI_INSP_VA] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [INDI_INSP_VC] VARCHAR(10)");	
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [INSP_YMD] VARCHAR(20)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [INSP_SAVE_YN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [SMS_GMTR_MAN_YN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [SMS_SEND_AGREE_YN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [NONPAY_MANAGE_SEC] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [SMS_CP_DDD] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [SMS_CP_EXN] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [SMS_CP_NUM] VARCHAR(5)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [INST_PLACE_NUM] VARCHAR(20)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [COUNS_HIST] VARCHAR(10)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [COMPENS_REMOVE_ALARM] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [MTR_DIGIT_CNT] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [SELF_GMTR_STR_YMD] VARCHAR(8)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [SELF_GMTR_END_YMD] VARCHAR(8)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [BEFO_GMTR_SMS_YN] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [GMTR_MANAGE_STS] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [DEADLINE_CHG_YN] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [COMPENS_REMOVE_ALARM_2] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [OLD_COMPENS_REMOVE_ALARM_2] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [PHOTO_MTR_YN] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [PHOTO_COMPENS_VC_YN] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [PHOTO_COMPENS_VA_YN] VARCHAR(2)");
		g_Sql_DirectExecute2(sql, "ALTER TABLE REGUMDATA ADD COLUMN [PHOTO_COMPENS_VM_YN] VARCHAR(2)");
							
	Finally:
		sql->m_bTranFlag = TRUE;
		DelSqLite(sql);
		
		return;
	}
	
	void Table_OldMtr_Add(void)
	{
		handle hdb = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
			
		sql->Begin(sql);
		
		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6301_OLDMTRIDNUM] ( \
                                [MTR_ID_NUM] varchar(20) NOT NULL )"
							);
							
	Finally:
		sql->m_bTranFlag = TRUE;
		DelSqLite(sql);
		
		return;
	}
	
		void Table_C6101_CHK_BULD_CENTER_CD(void)
	{
		handle hdb = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
			
		sql->Begin(sql);
		
		g_Sql_DirectExecute2(sql, "CREATE TABLE IF NOT EXISTS [C6101_CHK_BULD_CENTER_CD] ( \
                                [BULD_CENTER_CD] varchar(2) NOT NULL, \
								[MTR_NUM]	VARCHAR2(9))"
							);
							
	Finally:
		sql->m_bTranFlag = TRUE;
		DelSqLite(sql);
		
		return;
	}

	//----------------------------------------------------------------------------------------
	//마지막 로그인 성공된 아이디를 보여준다.
	void REDRAW(void)
	{
		long i;
		long nRet = 0;
		char szpath[128];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql," SELECT LOGINDAY, EMPLOYEE_ID, PASSWORD, NM_KOR \
												, CENTER_CD, CENTER_NM, BRANCH_CD, BRANCH_NM, BIZ_REGI_NUM, REPRE_NM, TEL, CELLPHONE \
												, CERT_CD, COM_NAME, DUTY_APPRO_STS_CD, ONCE_ACCOUNT_NUM, ONCE_BNK_NM, ONCE_DEPOSITOR_NM \
												, CARD_TERM_ID1, CARD_TERM_ID2, MENU_FLAG, ADDR_SUM, LOGINTIME, SOS_TELNUM, SOS_SMSNUM1, SOS_SMSNUM2, SOS_SMSNUM3, COMMON_VER_NUM, ONECARD_YN, RECOMMENDER_ID \
										     FROM USER_INFO" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		sql->Begin(sql);
		
		sql->Execute(sql);
		
		//stUserinfo 로그인정보에 디바이스 정보가 포함되어 있음.
		//스트럭쳐를 클리어 하면 안됨.
		if(sql->Next(sql) == TRUE )
		{
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szloginday         ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szemployee_id      ,9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szpassword         ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.sznm_kor           ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szcenter_cd        ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szcenter_nm        ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szbranch_cd        ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szbranch_nm        ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szbiz_regi_num     ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szrepre_nm         ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.sztel              ,15 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szcellphone        ,15 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szcert_cd          ,15 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szcom_name         ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szduty_appro_sts_cd,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szonce_account_num ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szonce_bnk_nm      ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szonce_depositor_nm,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szcard_term_id1    ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szcard_term_id2    ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szmenu_flag        ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szaddr_sum         ,300+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szlogintime        ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szSos_TelNum       ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szSos_SmsNum1      ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szSos_SmsNum2      ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szSos_SmsNum3      ,30 +1, DECRYPT );
			//sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szLogin_Chk        ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szOld_common_ver_num ,12 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szOneCard_yn ,1 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stUserinfo.szRecommender_id ,9 +1, DECRYPT );
		}		
		//sql->Commit(sql);
Finally:
		DelSqLite(sql);
	}
	
	//---------------------------------------------------------------------------------------------------------
	void UPdate_Login(void)
	{
	long i=0, tot = 0, ret=0;
	char szJsonpath[128];
	char szSql[400];
	long idx;
	void* json;
	char* szemployee_id      ;
	char* szpassword         ;
	char* sznm_kor           ;
	char* szpda_ip           ;
	char* szcenter_cd        ;
	char* szcenter_nm        ;
	char* szbranch_cd        ;
	char* szbranch_nm        ;
	char* szbiz_regi_num     ;
	char* szrepre_nm         ;
	char* sztel              ;
	char* szcellphone        ;
	char* szcert_cd          ;
	char* szcom_name         ;
	char* szduty_appro_sts_cd;
	char* szonce_account_num ;
	char* szonce_bnk_nm      ;
	char* szonce_depositor_nm;
	char* szcard_term_id1    ;
	char* szcard_term_id2    ;
	char* szmenu_flag        ;
	char* szaddr_sum         ;
	char* szlogintime        ;
	char* szloginday         ;
	char* szsos_telnum       ;
	char* szsos_smsnum1      ;
	char* szsos_smsnum2      ;
	char* szsos_smsnum3      ;
	char* sznp_auth          ;
	char* szlock_yn          ;
	char* szscg_repre_nm     ;
	char* szcommon_ver_num   ;
	char* szonecard_yn;
	char* szrecommender_id;
	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d.JSON", SYSTEM_COMM, 11131, 0 );
		
		g_pjcomm = JSON_Create( JSON_Object );
		if( g_pjcomm == NULL)
		{
			goto Finally;
		}
		
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0  )
		{
			szcenter_cd         = JSON_GetValue ( g_pjcomm ,"center_cd"                 ,"C");			
			szcenter_nm         = JSON_GetValue ( g_pjcomm ,"center_nm"                 ,"C");
			szrepre_nm          = JSON_GetValue ( g_pjcomm ,"repre_nm"                  ,"C");
			szbiz_regi_num      = JSON_GetValue ( g_pjcomm ,"biz_regi_num"              ,"C");
			szbranch_cd         = JSON_GetValue ( g_pjcomm ,"branch_cd"                 ,"C");
			szbranch_nm         = JSON_GetValue ( g_pjcomm ,"branch_nm"                 ,"C");
			szaddr_sum          = JSON_GetValue ( g_pjcomm ,"addr_sum"                  ,"C");
			sztel               = JSON_GetValue ( g_pjcomm ,"tel"                       ,"C");
			szcellphone         = JSON_GetValue ( g_pjcomm ,"cellphone"                 ,"C");
			sznm_kor            = JSON_GetValue ( g_pjcomm ,"nm_kor"                    ,"C");
			szloginday          = JSON_GetValue ( g_pjcomm ,"loginday"                  ,"C");
			szlogintime         = JSON_GetValue ( g_pjcomm ,"logintime"                 ,"C");
			szcert_cd           = JSON_GetValue ( g_pjcomm ,"cert_cd"                   ,"C");
			szcom_name          = JSON_GetValue ( g_pjcomm ,"com_name"                  ,"C");
			szonce_bnk_nm       = JSON_GetValue ( g_pjcomm ,"once_bnk_nm"               ,"C");
			szonce_depositor_nm = JSON_GetValue ( g_pjcomm ,"once_depositor_nm"         ,"C");
			szonce_account_num  = JSON_GetValue ( g_pjcomm ,"once_account_num"          ,"C");
			
			szcard_term_id1     = JSON_GetValue ( g_pjcomm ,"card_term_id1"          ,"C");
			szcard_term_id2     = JSON_GetValue ( g_pjcomm ,"card_term_id2"          ,"C");

			szsos_telnum  = JSON_GetValue ( g_pjcomm  ,"sos_telnum"                ,"C");
			szsos_smsnum1  = JSON_GetValue ( g_pjcomm ,"sos_smsnum1"               ,"C");
			szsos_smsnum2  = JSON_GetValue ( g_pjcomm ,"sos_smsnum2"               ,"C");
			szsos_smsnum3  = JSON_GetValue ( g_pjcomm ,"sos_smsnum3"               ,"C");
			sznp_auth      = JSON_GetValue ( g_pjcomm ,"np_auth"                 ,"C");
			szlock_yn      = JSON_GetValue ( g_pjcomm ,"lock_yn"                 ,"C");
			szscg_repre_nm = JSON_GetValue ( g_pjcomm ,"scg_repre_nm"            ,"C");
			
			szcommon_ver_num = JSON_GetValue ( g_pjcomm ,"common_ver_num"            ,"C");

			szonecard_yn = JSON_GetValue ( g_pjcomm ,"onecard_yn"            ,"C");
			
			szrecommender_id = JSON_GetValue ( g_pjcomm ,"recommender_id"            ,"C");
			
			Str_Cpy( stUserinfo.szloginday         , szloginday);
			Str_Cpy( stUserinfo.sznm_kor           , sznm_kor);
			Str_Cpy( stUserinfo.szcenter_cd        , szcenter_cd);
			Str_Cpy( stUserinfo.szcenter_nm        , szcenter_nm);
			Str_Cpy( stUserinfo.szbranch_cd        , szbranch_cd);
			Str_Cpy( stUserinfo.szbranch_nm        , szbranch_nm);
			Str_Cpy( stUserinfo.szbiz_regi_num     , szbiz_regi_num);
			Str_Cpy( stUserinfo.szrepre_nm         , szrepre_nm);
			Str_Cpy( stUserinfo.sztel              , sztel);
			Str_Cpy( stUserinfo.szcellphone        , szcellphone);
			Str_Cpy( stUserinfo.szcert_cd          , szcert_cd);
			Str_Cpy( stUserinfo.szcom_name         , szcom_name);
			Str_Cpy( stUserinfo.szonce_account_num , szonce_account_num);
			Str_Cpy( stUserinfo.szonce_bnk_nm      , szonce_bnk_nm);
			Str_Cpy( stUserinfo.szonce_depositor_nm, szonce_depositor_nm);
			Str_Cpy( stUserinfo.szaddr_sum         , szaddr_sum);
			Str_Cpy( stUserinfo.szlogintime        , szlogintime);
			
			Str_Cpy( stUserinfo.szcard_term_id1    , szcard_term_id1);
			Str_Cpy( stUserinfo.szcard_term_id2    , szcard_term_id2);
			
			Str_Cpy( stUserinfo.szSos_TelNum       , szsos_telnum);
			Str_Cpy( stUserinfo.szSos_SmsNum1      , szsos_smsnum1);
			Str_Cpy( stUserinfo.szSos_SmsNum2      , szsos_smsnum2);
			Str_Cpy( stUserinfo.szSos_SmsNum3      , szsos_smsnum3);
			Str_Cpy( stUserinfo.szNp_auth          , sznp_auth);
			Str_Cpy( stUserinfo.szLock_yn          , szlock_yn);
			SQL_ConvMbStr( stUserinfo.szScg_repre_nm, szscg_repre_nm);
			

			Str_Cpy ( stUserinfo.szemployee_id,    EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_ID) ));
			Str_Cpy ( stUserinfo.szpassword,       EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_PW) ));
			
			// 20180305 공통코드 버전 관리 추가
			Str_Cpy( stUserinfo.szNew_common_ver_num          , szcommon_ver_num);
			
			Str_Cpy( stUserinfo.szOneCard_yn       , szonecard_yn );
			Str_Cpy( stUserinfo.szRecommender_id       , szrecommender_id );
			
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, "SELECT COUNT(*) FROM USER_INFO ", 0, 0, 0 );
			g_Sql_RetInt(szSql, &tot);
			
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally;
			}
			
			if( tot <= 0)
			{
				
				hstmt = sql->CreateStatement(sql ,"INSERT INTO USER_INFO ( LOGINDAY,EMPLOYEE_ID,PASSWORD,NM_KOR,PDA_IP \
,CENTER_CD,CENTER_NM,BRANCH_CD,BRANCH_NM,BIZ_REGI_NUM,REPRE_NM \
,TEL,CELLPHONE,CERT_CD,COM_NAME,ONCE_ACCOUNT_NUM \
,ONCE_BNK_NM,ONCE_DEPOSITOR_NM, CARD_TERM_ID1, CARD_TERM_ID2,ADDR_SUM,LOGINTIME,SOS_TELNUM,SOS_SMSNUM1,SOS_SMSNUM2,SOS_SMSNUM3, ONECARD_YN, RECOMMENDER_ID ) \
VALUES (?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?,?,?) ");
			}
			else
			{
				hstmt = sql->CreateStatement(sql ,"UPDATE USER_INFO SET LOGINDAY =?,EMPLOYEE_ID=?,PASSWORD=?,NM_KOR=?,PDA_IP=?\
,CENTER_CD=?,CENTER_NM=?,BRANCH_CD=?,BRANCH_NM=?,BIZ_REGI_NUM=?,REPRE_NM=?\
,TEL=?,CELLPHONE=?,CERT_CD=?,COM_NAME=?,ONCE_ACCOUNT_NUM=?\
,ONCE_BNK_NM=?,ONCE_DEPOSITOR_NM=?,CARD_TERM_ID1=?, CARD_TERM_ID2=?,ADDR_SUM=?,LOGINTIME=?,SOS_TELNUM=?,SOS_SMSNUM1=?,SOS_SMSNUM2=?,SOS_SMSNUM3=?, ONECARD_YN=?,RECOMMENDER_ID=? ");
			}
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szloginday,           8, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szemployee_id,        9, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szpassword,           20, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.sznm_kor,             30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szpda_ip,             15, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcenter_cd,          2 , DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcenter_nm,          30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szbranch_cd,          6, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szbranch_nm,          30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szbiz_regi_num,       30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szrepre_nm,           30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.sztel,                15, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcellphone,          15, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcert_cd,            15, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcom_name,           30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szonce_account_num,   30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szonce_bnk_nm,        30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szonce_depositor_nm,  30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcard_term_id1,      30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szcard_term_id2,      30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szaddr_sum,          300, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szlogintime,           6, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szSos_TelNum,         30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szSos_SmsNum1,        30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szSos_SmsNum2,        30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szSos_SmsNum3,        30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szOneCard_yn,        30, DECRYPT);
			sql->Bind(sql, idx++, 'C', (long *)stUserinfo.szRecommender_id,        9+1, DECRYPT);
			
			sql->Begin(sql);
			ret = sql->Execute(sql);
			PRINT("::Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			sql->Commit(sql);
		}
		
Finally:
		DelSqLite(sql);
		JSON_Finalize ( g_pjcomm );
		g_pjcomm = NULL;
	}
	
	void LOGIN_PROS(void)
	{
	char szUrl[200];
	char szbuf[128];
	char szid[20];
	char szpass[128];
	char* sndbuf;
	long ret = 0;
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_ID) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "사번을 입력하세요.");
			return;
		}
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_ID) ) > 9)
		{
			MessageBoxEx (CONFIRM_OK, "사원번호는 9자리로 입력하세요.");
			return;
		}
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_ID) ) < 9)
		{
			MessageBoxEx (CONFIRM_OK, "사원번호는 9자리로 입력하세요.");
			return;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_PW) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "비밀번호를 입력하세요.");
			return;
		}
				
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		Mem_Set((byte*)szid, 0x00, sizeof(szid));
		Mem_Set((byte*)szpass, 0x00, sizeof(szpass));
		Str_Cpy ( szid,    EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_ID) ));
		Str_Cpy ( szbuf,    EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_PW) ));

		g_pjcomm = g_CreateJsonHead_Login(g_pjcomm, szUrl, szid, 11131, FALSE);

		Str_Cpy(szpass, CRYPT_Get ((byte*)szbuf, CRYPT_SHA256 ) );

		JSON_SetValue( g_pjcomm, 'C', "password",   szpass );		

		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		g_SeverConnection();
		
		//callBackfunc = TR11131; //통신완료 후에 호출 함수
		//ret = HTTP_DownloadData( szUrl, "FR11131_IN",  "FR11131" , sndbuf, szbuf );
		
		HTTP_DownloadTR(ret, szUrl, 11131, sndbuf, szbuf);
	}
	
	//
	long TR11131(void)
	{
	char szSql[200];
	long tot;

		g_Sock_Close();
		
		if(g_Chk_Json(11131) >= 0)
		{
			//로그인 정보 업데이트
			UPdate_Login();
			REDRAW();
		}
		else
		{
			return -1;
		}
		
		//푸시 초기화.
		g_InitPush();

		//기초데이터확인
		Mem_Set((byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM commoncode ", 0, 0, 0);
		g_Sql_RetInt(szSql, &tot);

		// 20180305 공통코드 버전 관리 추가
		//if( tot <= 0 )
		if( tot <= 0 || Str_Cmp(stUserinfo.szOld_common_ver_num, stUserinfo.szNew_common_ver_num ) != 0 )
		{
			g_Sql_DirectExecute("DELETE FROM commoncode");
			//g_Sql_DirectExecute("DELETE FROM BANK_CD");
			g_Sql_DirectExecute("DELETE FROM BATTERY_KIND");
			g_Sql_DirectExecute("DELETE FROM BO_INST");
			g_Sql_DirectExecute("DELETE FROM BURNER_KIND");
			g_Sql_DirectExecute("DELETE FROM MTR_MODEL");
			g_Sql_DirectExecute("DELETE FROM COMPENS_MODEL");
			g_Sql_DirectExecute("DELETE FROM GOV_MODEL");
			g_Sql_DirectExecute("DELETE FROM REGTR_MODEL");
			g_Sql_DirectExecute("DELETE FROM USE_MAKER");
			
			g_Sql_DirectExecute(" DELETE FROM C6101_BIZ_TYPE ");
			g_Sql_DirectExecute(" DELETE FROM C6101_PROD ");
			g_Sql_DirectExecute(" DELETE FROM C6101_BIZ_PROD ");
			g_Sql_DirectExecute(" DELETE FROM C6101_BIZ_BURN ");
			
			Rev13131();
		}
		else
		{
			ShowSip(FALSE);
			g_Sipflag = 0;
			
			//로그인 시 업데이트 내용 표시
			//MessageBoxEx (CONFIRM_OK, "-2016.06.08 업데이트 내용-\n1.검침&점검 주소표시칸 확장\n2.업무 리스트 총갯수 표시");
			
			//업그레이드 기능 잠시 제거
			if( UPGRADE() == 0 )
			{
				PRINT("카드결제 가스요금 단말기번호(stUserinfo.szcard_term_id1):[%s]", stUserinfo.szcard_term_id1, 0, 0);
				PRINT("카드결제 일회성요금 단말기번호(stUserinfo.szcard_term_id2):[%s]", stUserinfo.szcard_term_id2, 0, 0);
				PRINT("현금영수증 단말기번호(stUserinfo.szcert_cd):[%s]", stUserinfo.szcert_cd, 0, 0);
				Card_Move("MENU");
			}
			else
			{
				PRINT("UPGRADE FAIL.", 0, 0, 0);
				//VM_AmEnd();
				//return 0;
			}
		}
		return 0;
	}
	
	
	long Rev13131(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13131, FALSE);
				
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);

		sndbuf = JSON_toString(g_pjcomm);
		
		callBackfunc = TR13131;
		ret = HTTP_DownloadData(szUrl, "FR13131_IN",  "FR13131" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13131(void)
	{
		if(g_Chk_Json(13131) >= 0)
		{
			Rev13132();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13132(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13132, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		callBackfunc = TR13132;
		ret = HTTP_DownloadData(szUrl, "FR13132_IN",  "FR13132" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13132(void)
	{
		if(g_Chk_Json(13132) >= 0)
		{
			Rev13133();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	
	long Rev13133(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13133, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13133;
		ret = HTTP_DownloadData(szUrl, "FR13133_IN",  "FR13133" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13133(void)
	{
		if(g_Chk_Json(13133) >= 0)
		{
			Rev13134();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13134(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13134, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13134;
		ret = HTTP_DownloadData(szUrl, "FR13134_IN",  "FR13134" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13134(void)
	{
		if(g_Chk_Json(13134) >= 0)
		{
			Rev13135();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13135(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13135, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13135;
		ret = HTTP_DownloadData(szUrl, "FR13135_IN",  "FR13135" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13135(void)
	{
		if(g_Chk_Json(13135) >= 0)
		{
			Rev13136();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13136(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13136, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13136;
		ret = HTTP_DownloadData(szUrl, "FR13136_IN",  "FR13136" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13136(void)
	{
		if(g_Chk_Json(13136) >= 0)
		{
			Rev13137();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13137(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13137, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13137;
		ret = HTTP_DownloadData(szUrl, "FR13137_IN",  "FR13137" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13137(void)
	{
		if(g_Chk_Json(13137) >= 0)
		{
			Rev13138();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13138(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13138, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13138;
		ret = HTTP_DownloadData(szUrl, "FR13138_IN",  "FR13138" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13138(void)
	{
		if(g_Chk_Json(13138) >= 0)
		{
			Rev13139();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13139(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13139, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13139;
		ret = HTTP_DownloadData(szUrl, "FR13139_IN",  "FR13139" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13139(void)
	{
		if(g_Chk_Json(13139) >= 0)
		{
			Rev13140();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev13140(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 13140, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR13140;
		ret = HTTP_DownloadData(szUrl, "FR13140_IN",  "FR13140" , sndbuf, szbuf );

		return 0;
	}
	
	long TR13140(void)
	{
		if(g_Chk_Json(13140) >= 0)
		{
			Rev685025();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	
	long Rev685025(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685025, FALSE);
				
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
	
		sndbuf = JSON_toString(g_pjcomm);
		
		callBackfunc = TR685025;
		ret = HTTP_DownloadData(szUrl, "FR685025_IN",  "FR685025" , sndbuf, szbuf );
	
		return 0;
	}
	
	
	long TR685025(void)
	{
		if(g_Chk_Json(685025) >= 0)
		{
			Rev685026();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev685026(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685026, FALSE);
				
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
	
		sndbuf = JSON_toString(g_pjcomm);
		
		callBackfunc = TR685026;
		ret = HTTP_DownloadData(szUrl, "FR685026_IN",  "FR685026" , sndbuf, szbuf );
	
		return 0;
	}
	
	long TR685026(void)
	{
		if(g_Chk_Json(685026) >= 0)
		{
			Rev685027();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev685027(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685027, FALSE);
				
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
	
		sndbuf = JSON_toString(g_pjcomm);
		
		callBackfunc = TR685027;
		ret = HTTP_DownloadData(szUrl, "FR685027_IN",  "FR685027" , sndbuf, szbuf );
	
		return 0;
	}
	
	long TR685027(void)
	{
		if(g_Chk_Json(685027) >= 0)
		{
			Rev685028();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long Rev685028(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685028, FALSE);
				
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
	
		sndbuf = JSON_toString(g_pjcomm);
		
		callBackfunc = TR685028;
		ret = HTTP_DownloadData(szUrl, "FR685028_IN",  "FR685028" , sndbuf, szbuf );
	
		return 0;
	}
	
	long TR685028(void)
	{
		char szSql[100];
		
		g_Sock_Close();
		
		CloseMessageBox();

		if(g_Chk_Json(685028) >= 0)
		{
			// 20180305 공통코드 버전 관리 추가
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE USER_INFO SET COMMON_VER_NUM = '%s' ", stUserinfo.szNew_common_ver_num , 0, 0 );
			g_Sql_DirectExecute(szSql);

			if( UPGRADE() == 0 )
			{
				PRINT("카드결제 가스요금 단말기번호(stUserinfo.szcard_term_id1):[%s]", stUserinfo.szcard_term_id1, 0, 0);
				PRINT("카드결제 일회성요금 단말기번호(stUserinfo.szcard_term_id2):[%s]", stUserinfo.szcard_term_id2, 0, 0);
				PRINT("현금영수증 단말기번호(stUserinfo.szcert_cd):[%s]", stUserinfo.szcert_cd, 0, 0);
				
				Card_Move("MENU");
			}
			return 1;
		}
		return 1;
	}
	
	/*
	long TR13140(void)
	{
		char szSql[100];
		
		g_Sock_Close();
		
		CloseMessageBox();

		if(g_Chk_Json(13140) >= 0)
		{
			// 20180305 공통코드 버전 관리 추가
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE USER_INFO SET COMMON_VER_NUM = '%s' ", stUserinfo.szNew_common_ver_num , 0, 0 );
			g_Sql_DirectExecute(szSql);

			if( UPGRADE() == 0 )
			{
				PRINT("카드결제 가스요금 단말기번호(stUserinfo.szcard_term_id1):[%s]", stUserinfo.szcard_term_id1, 0, 0);
				PRINT("카드결제 일회성요금 단말기번호(stUserinfo.szcard_term_id2):[%s]", stUserinfo.szcard_term_id2, 0, 0);
				PRINT("현금영수증 단말기번호(stUserinfo.szcert_cd):[%s]", stUserinfo.szcert_cd, 0, 0);
				
				Card_Move("MENU");
			}
			return 1;
		}
		return 1;
	}
	*/
	/*
	//=============================================================================
	//	MDM API
	//=============================================================================
	syscall char*	MDM_GetAppGuid			(void);							//GUID를 얻어옴.
	syscall long	MDM_IsNewAppVer			(char* pszAppName, char* url);	//POP 업그레이드 진행 여부 확인
	syscall long	MDM_GetAppVerPatch		(char* pszAppName);				//POP 업그레이드
	syscall void	MDM_VmUpgrade			(void);							//VM 업그레이드
	*/
	//**** VM & POP파일 VERSION 업데이트 확인
	long UPGRADE(void)
	{
		char szSql[200];
		bool bRet = FALSE;
		long lVmUpgradeRet = 0;
		long lCnt;

//PRINT(" >>>>>>>>>>>>>> m_stVminfo.szDeviceType : %s", m_stVminfo.szDeviceType, 0,0);
//  pda vm 업그레이드 시 사용할 코드
		if (g_Upgrade_flag == 1)
		{
			MessageBoxEx (MESSAGE, "업그레이드 종료 후\n프로그램이 종료됩니다.");
			return 1;
		}

#ifdef __USE_VM_UPGRADE__
		//VM 업그레이드 관련
		lVmUpgradeRet = VM_UPGRADE();
		if( lVmUpgradeRet > 0 )
		{
			/*
			//로그인확인(Y/N) 업그레이드
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			Str_Cpy(szSql, "UPDATE USER_INFO SET LOGIN_CHK = 'Y' ");
			g_Sql_DirectExecute( szSql );
			*/

			MessageBoxEx (MESSAGE, "업그레이드 종료 후\n프로그램이 종료됩니다.");
			return 1;
		}
		
#endif //__USE_VM_UPGRADE__

		Str_Cpy(g_szAppName, (char*)m_stAppinfo.aAppName);
//PRINT("UPGRADE  g_szAppName: %s, aAppName : %s",g_szAppName,m_stAppinfo.aAppName,0);
//PRINT("UPGRADE  _VM_AppInfo.wAppVersion : %d",m_stAppinfo.wAppVersion,0,0);
//PRINT("MDM_GetAppGuid() : %s", MDM_GetAppGuid(), 0,0);

		if ( lVmUpgradeRet > -1 ) 
		{
			bRet = MDM_IsNewAppVer( g_szAppName, GET_URL(MDM_BASE_URL) );
	
	//PRINT("bRet : %d",bRet,0,0);
	//PRINT("MDM_IsNewAppVer: %d, aAppName : %s",bRet,m_stAppinfo.aAppName,0);
			
			//CARD 업그레이드 관련
			if( bRet )
			{
				SET_UPGRADE_FLAG(TRUE);
				
				MessageBoxEx (CONFIRM_OK, "어플리케이션 버전 업그레이드를 시작합니다.");
	
				ON_DRAW();
			
				MDM_GetAppVerPatch(g_szAppName);
	
				g_Upgrade_flag =1;
	
	/*
				//로그인확인(Y/N) 업그레이드
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Str_Cpy(szSql, "UPDATE USER_INFO SET LOGIN_CHK = 'Y' ");
				g_Sql_DirectExecute( szSql );
	*/
	
				return 1;
			}
			else
			{
	//PRINT("UPGRADE FALSE",0,0,0);
				return 0;	// APP 업그레이드 대상 없음
			}
			
	//#endif //__USE_VM_UPGRADE__
		}
		else
		{
			return -1;	// VM 업그레이드 실패
		}

		//return 0;
	}
	
	//-------------------------------------------------------------------------------------------------	
	
	/* {"jsonrpc": "2.0", "method": "getMaxVmVerWithUrl", "params": {"device_type_nm" : "pm80_android"}, "id": 2}
	long    JSONRPC_Query( char* url, char* method, char* params, long   id, char* pBuf ) 
	<<Parameters: 
	url         웹서비스 url 
	method      jsonrpc method 
	params      jsonrpc prameter 
	id      	jsonrpc request id 
	pBub        jsonrpc response buffer pointer 
	
	*/
	long VM_UPGRADE(void)
	{
		char pBuf[200];
		char szSql[200];
		char szNewVer[15];
		long nRet = -1;
		long length = 0;
		long i;
		long nNewVer;		//최신 버전(서버)
		long nVmVer;		//현재 버전
		char PhoneNum[16];
		char param[80];
		
		//getMaxVmVerWithUrl
		Mem_Set( (byte*)pBuf, 0x00, sizeof(pBuf) );
		Mem_Set( (byte*)param, 0x00, sizeof(param) );

//PRINT(" >>>>>>>>>>>>>> m_stVminfo.szDeviceType : %s", m_stVminfo.szDeviceType, 0,0);
			
		Mem_Set( (byte*)PhoneNum, 0x00, sizeof(PhoneNum) );
		Tapi_GetPhoneNum ( (byte*)PhoneNum, 0 );
		
		if( theDevInfo.m_nType != FAMILY_PDA )
		{			
			//스마트폰
			Str_Cpy(param, "{\"device_type_nm\" : \"pm80_android\", \"device_nm\" : \"");
		}
		else
		{
			//dsic_ds3
			if( Str_Cmp(m_stVminfo.szDeviceType, "dsic_ds3") == 0 )
			{
				Str_Cpy(param, "{\"device_type_nm\" : \"dsic_ds3\", \"device_nm\" : \"");
				//JSONRPC_Query(GET_URL(MDM_BASE_URL), "getMaxVmVerWithUrl", "{\"device_type_nm\" : \"dsic_ds3\"}", 2, pBuf);
			}
			else if( Str_Cmp(m_stVminfo.szDeviceType, "m3plus") == 0 )
			{
				//m3plus
				Str_Cpy(param, "{\"device_type_nm\" : \"m3plus\", \"device_nm\" : \"");
				//JSONRPC_Query(GET_URL(MDM_BASE_URL), "getMaxVmVerWithUrl", "{\"device_type_nm\" : \"m3plus\"}", 2, pBuf);
			}
			else if( Str_Cmp(m_stVminfo.szDeviceType, "M3_green") == 0 )
			{
				//M3_green
				Str_Cpy(param, "{\"device_type_nm\" : \"M3_green\", \"device_nm\" : \"");
				//JSONRPC_Query(GET_URL(MDM_BASE_URL), "getMaxVmVerWithUrl", "{\"device_type_nm\" : \"M3_green\"}", 2, pBuf);
			}
		}
	
		Str_Cat(param, PhoneNum);
		Str_Cat(param, "\"}");
//		PRINT("param : %s",param,0,0);
		JSONRPC_Query( GET_URL(MDM_BASE_URL), "getMaxVmVerWithUrl", param, 2, pBuf);

//		PRINT("pBuf : %s",pBuf,0,0);

		length = Str_Len(pBuf);
		if( length > 0 )
		{
			for( i=0 ; length ; i++)
			{
				if( pBuf[i] == '{' && pBuf[i+1] == '"' && pBuf[i+2] == 'l')
				{
					break;
				}
			}

			Mem_Set( (byte*)szNewVer, 0x00, sizeof(szNewVer) );
			Mem_Cpy((byte *)szNewVer, (byte *)pBuf+(i+15), 7);
			//PRINT(">>>>>>>>szNewVer : %s",szNewVer,0,0);
		}

		nNewVer = Str_AtoI(szNewVer);
		nVmVer = (long)m_stVminfo.nVmVersion;
PRINT("VM_UPGRADE >>>>>>>>>>>>> nNewVer : %d ,,,,, nVmVer : %d, szNewVer:[%s]",nNewVer,nVmVer,szNewVer);

		//2016-06-23 Sanghyun Lee
		//VM 업그레이드가 필요한 경우 POP 파일 업그레이드가 되지 않도록 해야함.		
		//m_stVminfo.nVmVersion :현재 Vm버전
		if( theDevInfo.m_nType != FAMILY_PDA )
		{
			//2016-12-22 Sanghyun Lee
			//2013000 버전 패치 후 -> vpn 제거, 버그 패치 후 원래 업그레이드 방식으로 복원.
			if (nNewVer == -1) 
			{
				MessageBoxEx (CONFIRM_OK, "많은 사용자가 접속중입니다. 잠시 후에 프로그램 버전 업그레이드를 시도하세요!!");
				//g_Upgrade_flag =0; // ?
				
				nRet = -1;
			}
			else if( nNewVer > nVmVer )
			{
				SET_UPGRADE_FLAG(TRUE);
			
				MessageBoxEx (CONFIRM_OK, "프로그램 버전 업그레이드를 시작합니다!!");
			
				//MDM_VmUpgrade();
				MDM_VmUpgradeUrl(GET_URL(MDM_BASE_URL), "");
				
				g_Upgrade_flag =1;
				
				nRet = 1;
			}
			else
			{
				nRet = 0;
			}
			
		/*
			//2016-12-22 Sanghyun Lee
			//2013000 버전 패치 전 -> vpn으로 인한 vm 업그레이드 오류 발생으로 인해 html 사용했던 소스
			if( nVmVer <= 2010000 )
			{
				MessageBoxEx (CONFIRM_OK, "프로그램 버전 업그레이드를 시작합니다!!!");
				
				RunApp( "WEBVIEWER", "/mnt/sdcard/Smart/SCGGAS/Upgrade.html" );
				
				nRet = 1;
			}
			else if( nNewVer > nVmVer )
			{
				MessageBoxEx (CONFIRM_OK, "프로그램 버전 업그레이드를 시작합니다!!");
			
				MDM_VmUpgrade();
				
				g_Upgrade_flag =1;
				
				nRet = 1;
			}
		*/
		}
		else
		{
			//2011-11-01 Sanghyun Lee , PDA 업그레이드 테스트
			//MDM_VmUpgradeUrl		(char* check_url, char* download_url);
			if (nNewVer == -1) 
			{
				MessageBoxEx (CONFIRM_OK, "많은 사용자가 접속중입니다. 잠시 후에 프로그램 버전 업그레이드를 시도하세요!!");
				//g_Upgrade_flag =0; // ?
				
				nRet = -1;
			}
			else if( nNewVer > nVmVer )
			{
				MessageBoxEx (CONFIRM_OK, "프로그램 버전 업그레이드를 시작합니다!!!");
			
				MDM_VmUpgradeUrl(GET_URL(MDM_BASE_URL), "");
				g_Upgrade_flag =1;
				
				nRet = 1;
			}
			else
			{
				nRet = 0;
			}
		}

		//ON_DRAW();
		return nRet;
	}
	
	//-------------------------------------------------------------------------------------------------
	/*
	//업무용 데이터 폴더 생성 및 경로만들기
	#define DIR_DBF		"APP_DBF"    //업무용 DB 폴더
	#define DIR_BACKDBF "APP_BACKDB" //상시 백업DB 저장 폴더
	#define UP_BACKDBF  "DBF_BAK"    //VM 업그레이드시 DB백업 폴더
	#define PHOTO_SC	"PHOTO_SC"   //안전점검사진폴더
	#define PHOTO_JO	"PHOTO_JO"   //조정기사진폴더
	#define PHOTO_BS	"PHOTO_BS"   //특정점검 사진폴더
	#define PHOTO_BF	"PHOTO_BF"   //공급전안전점검 사진폴더
	*/
	void UPGRADE_DBBACK(void)
	{
		char szSql[50];
		char szPath[50];
		char szBackPath[50];
		long lCnt = 0;
	
		Mem_Set( (byte*)szPath, 0x00, sizeof(szPath) );
		Mem_Set( (byte*)szBackPath, 0x00, sizeof(szBackPath) );
		//업무폴더 DB
		SPRINT (szPath, "%s/SCGGAS.db",  DIR_DBF, 0, 0);

		//상시 백업폴더 DB
		//SPRINT (szBackPath, "%s/SCGGAS.db",  UP_BACKDBF, 0, 0);

		//VM업그레이드 시 DB 백업폴더
		//Client에서 업그레이드 진행시 DB의 이름을 변경하여 Back Up
		SPRINT (szBackPath, "%s/SCGGAS_UPBACK.db",  DIR_BACKDBF, 0, 0);

		if( FFS_Exist(szPath) )
		{
			if( FFS_Exist(szBackPath) )
			{
				FFS_Delete(szBackPath);
			}
		
			FFS_Copy(szPath, szBackPath);
		}

		return;
	}
	
	//-------------------------------------------------------------------------------------------------
	//백업된 DB가 정상적인 DB 파일인지 확인
	//		g_Sql_RetInt( "SELECT COUNT(*) FROM USER_INFO", &nUserinfo );
	//		g_Sql_RetInt( "SELECT COUNT(*) FROM TBL_REGIST", &nTblRegist );
	
	long BackDB_Check(void)
	{
		long nRet = -1;
		long i;
		long nUserCnt = 0;
		long nRegistCnt = 0;
		//SQLITE pThis = (SQLITE) p;
		SQLITE sql = NewSqLite();
		handle hdb = NULL;
		handle hStmt = NULL;
		
		//if( FFS_Exist("DBF_BAK/SCGGAS.db") )
		
		if( FFS_Exist("APP_BACKDB/SCGGAS.db") )
		{
			//hdb = SQL_Open("DBF_BAK/SCGGAS.db");
			hdb = SQL_Open("APP_BACKDB/SCGGAS.db");
			
			if( hdb == NULL )
			{
				goto Finally;
			}
			
			//USER_INFO 확인
			hStmt = SQL_CreateStatement( hdb, "SELECT COUNT(*) FROM USER_INFO");
			if( hStmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", SQL_GetLastError(hdb), 0, 0);
				SQL_Close(hdb);
				goto Finally;
			}
			
			SQL_Begin(hdb);
			
			SQL_Execute(hStmt);
			
			if(SQL_Next(hStmt) == TRUE )
			{
				i = 0;
				SQL_GetValue( hStmt, i++, 'X', &nUserCnt);
			}
			else
			{
				goto Finally;
			}
			
			SQL_Commit(hdb);
			
			
			//TBL_REGIST 확인
			hStmt = SQL_CreateStatement( hdb, "SELECT COUNT(*) FROM TBL_REGIST");
			if( hStmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", SQL_GetLastError(hdb), 0, 0);
				SQL_Close(hdb);
				goto Finally;
			}
			
			SQL_Begin(hdb);
			
			SQL_Execute(hStmt);
			
			if(SQL_Next(hStmt) == TRUE )
			{
				i = 0;
				SQL_GetValue( hStmt, i++, 'X', &nRegistCnt);
			}
			else
			{
				goto Finally;
			}
			
			SQL_Commit(hdb);

//PRINT("nUserCnt : %d, nRegistCnt : %d",nUserCnt,nRegistCnt,0);
			if( nUserCnt > 0 && nRegistCnt > 0 )
			{
				nRet = 1;
			}
			else
			{
				nRet = -1;
			}
		}
		else
		{
			nRet = -1;
		}

Finally:

		SQL_DeleteStatement(hStmt);
		SQL_Close(hdb);

		return nRet;
	}

	//──────────────────────────────────────────────
	void RemoveDir(void)
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
}	
