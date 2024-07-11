/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6202_SMS_STOP
	Card Desc : 체납 중지 문자 발송 기능
	Card Hist :
----------------------------------------------------------------------------------*/
card C6202_SMS_STOP
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"

//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
//  #define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		 // 지번주소/도로명주소
		DEF_BUTTON_ID ( BID_PREVLST )	 // 그리드 UP
		DEF_BUTTON_ID ( BID_NEXTLST )	 // 그리드 DOWN
		DEF_BUTTON_ID ( BID_SEND )		 // 발송
		DEF_BUTTON_ID ( BID_CLOSE )		 // 닫기
		DEF_BUTTON_ID ( BID_TXTVIEW )	 // 이력 상세 버튼
		DEF_BUTTON_ID ( BID_VIEW_CLOSE ) // 이력 상세 뒤로 가기
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )				// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )			// 타이틀
		DEF_OBJECT_ID ( ST_USE_CONT_NUM )		// ST 사용계약번호
		DEF_OBJECT_ID ( TXT_USE_CONT_NUM )		// TXT 사용계약번호
		DEF_OBJECT_ID ( TXT_ADDR )				// TXT 주소
		DEF_OBJECT_ID ( ST_GUIDE_TYPE )			// ST 안내유형
		DEF_OBJECT_ID ( TXT_GUIDE_TYPE )		// TXT 안내유형
		DEF_OBJECT_ID ( ST_STOPDAY )		    // ST 중단일
		DEF_OBJECT_ID ( TXT_STOPDAY )			// TXT 중단일
		DEF_OBJECT_ID ( ST_NOPAY )				// ST 미납요금
		DEF_OBJECT_ID ( TXT_NOPAY )				// TXT 미납요금
		DEF_OBJECT_ID ( ST_ACTHIST )			// ST 활동이력
		DEF_OBJECT_ID ( TXT_ACTHIST )			// TXT 활동이력
		DEF_OBJECT_ID ( TXT_PAGE )				// PAGE
		DEF_OBJECT_ID ( ST_PHONE_NUM )			// ST 전화번호
		DEF_OBJECT_ID ( TXT_PHONE_EXN )			// TXT 전화번호 EXN
		DEF_OBJECT_ID ( EDT_PHONE_EXN )			// EDT 전화번호 EXN
		DEF_OBJECT_ID ( TXT_PHONE_NUM )			// TXT 전화번호 NUM
		DEF_OBJECT_ID ( EDT_PHONE_NUM )			// EDT 전화번호 NUM
		DEF_OBJECT_ID ( TXT_VIEW_ACTHIST )
		DEF_OBJECT_ID ( ID_ACTHISTLIST )		// 이력HIST LIST
		
		//포인팅 자판
		DEF_OBJECT_ID ( TXT_KEY_ONE )
		DEF_OBJECT_ID ( TXT_KEY_TWO )
		DEF_OBJECT_ID ( TXT_KEY_THREE )
		DEF_OBJECT_ID ( TXT_KEY_FOUR )
		DEF_OBJECT_ID ( TXT_KEY_FIVE )
		DEF_OBJECT_ID ( TXT_KEY_SIX )
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )
		DEF_OBJECT_ID ( TXT_KEY_NINE )
		DEF_OBJECT_ID ( TXT_KEY_ZERO )
		DEF_OBJECT_ID ( TXT_KEY_DEL )
		
		DEF_OBJECT_ID ( CMB_PHONE_DDD )			// CMB 국번
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN 1
	#define INIT_VIEW 2
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	long m_bFirst;
	long m_lActIndex = -1;
	long m_lTotpage = 0;
	long m_lPage = 0;
	long m_lRedrawFlag = 0;
	char m_szCnt_page[10];
	char m_szView[1200];
	char m_szMsg[3000];
	char m_szDtlMsg[3000];
	char m_szDDD[5];
	char m_szEXN[5];
	char m_szNUM[5];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void SetCombo(void);
	void SaveData(void);
	
	long Rcv_Visit(void);
	long TR82226(void);
	long Rcv_Reqym(void);
	long TR822022(void);
	long Rcv_Account(void);
	long TR822023(void);
	
	void VisitDraw(void);
	void SetSmsMsg(void);
	bool Validation(void);
	
	void Snd_StopSms(void);
	long Rcv_StopSms(void);

	long Add_StopSms(handle pj);
	long Add_StopSmsHist(handle pj);
	long Add_StopMan(handle pj);
	long Add_StopDtl(handle pj); 

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3						// table의 행개수
	#define		COL 	    8						// table의 열개수
	#define		GRID_H		(CHT+23)				// table 행 높이
	#define		GRID_CLR	TRANSPARENT   			// table 클리어 color
	#define		GRID_X		STARTX 					// table 시작x좌표
	#define		MAXCHAR		1200 			    	// table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+CHT*11+19	    // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table마지막 row의 Y값

	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	
	Column m_stGridTitle[] = {
		{"일자"         , CWD*15  , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"여부"         , CWD*7   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"관계"         , CWD*8+13, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"처리자"       , CWD*9+10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"이력내용"     , CWD*0   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"사유"         , CWD*0   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"VISIT_WHY_CD" , CWD*0   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"VISIT_WHY_CD2", CWD*0   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// 메인 다이얼로그(체납중지문자발송관리)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납중지 문자발송관리"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_TEXT ( STARTX,     STARTY- 29, 320,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_USE_CONT_NUM , "사용계약번호"),
		DLG_TEXT ( STARTX+320, STARTY- 29, 680,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_USE_CONT_NUM, ""),

		DLG_BUTTON(STARTX,	   STARTY+ 31, 320, 120, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC       , "", BID_ADDR, ""),
		DLG_TEXT ( STARTX+320, STARTY+ 31, 680, 120, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_ADDR        , ""),
	
		DLG_TEXT ( STARTX,	   STARTY+151, 320,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_GUIDE_TYPE   , "안내유형"),
		DLG_TEXT ( STARTX+320, STARTY+151, 680,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_GUIDE_TYPE  , "공급중단안내"),
		
		DLG_TEXT ( STARTX,	   STARTY+211, 320,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_STOPDAY      , "중단일"),
		DLG_TEXT ( STARTX+320, STARTY+211, 680,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_STOPDAY     , ""),
		
		DLG_TEXT ( STARTX,	   STARTY+271, 320,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_NOPAY        , "미납요금"),
		DLG_TEXT ( STARTX+320, STARTY+271, 680,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_NOPAY       , ""),
		
		DLG_TEXT ( STARTX,	   STARTY+331, 320, 127, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_ACTHIST      , "활동이력"),
		
		DLG_BUTTON(STARTX+320, STARTY+331, 680, 127, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TXTVIEW, ""),
		DLG_TEXT ( STARTX+320, STARTY+331, 680, 127, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_ACTHIST     , ""),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_ACTHISTLIST, m_szTableBuf),	
		
		DLG_TEXT ( STARTX    , STARTY+710, 320,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR	 , TXTINCTRLBK	 , TXT_PAGE		   , m_szCnt_page),
		DLG_BUTTON(STARTX+320, STARTY+710, 340,  60, 0, 0, 0, BUTSTY_BORDER				 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC       , "", BID_PREVLST,  "▲"),
		DLG_BUTTON(STARTX+660, STARTY+710, 340,  60, 0, 0, 0, BUTSTY_BORDER				 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC       , "", BID_NEXTLST,  "▼"),
		
		DLG_TEXT ( STARTX,	   STARTY+770, 320,  63, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK	 , ST_PHONE_NUM	   , "전화번호"),
		DLG_TEXT ( STARTX+580, STARTY+770,  40,  63, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR	 , TXTINCTRLBK	 , TXT_PHONE_EXN   , "-"),
		DLG_EDIT ( STARTX+620, STARTY+770, 170,  63, 0, 0,    EDITSTY_BOLD               , EDITSTY_BORDER, TXTFRCOLOR	 , PDAEDTCTRLBK    , EDT_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+790, STARTY+770,  40,  63, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK	 , TXT_PHONE_NUM   , "-"),
		DLG_EDIT ( STARTX+830, STARTY+770, 170,  63, 0, 0,    EDITSTY_BOLD               , EDITSTY_BORDER, TXTFRCOLOR	 , PDAEDTCTRLBK    , EDT_PHONE_NUM, 4,  ""),
		
		DLG_BUTTON(STARTX,	   STARTY+835, 500,  65, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC       , "", BID_CLOSE, "닫기"),
		DLG_BUTTON(STARTX+500, STARTY+835, 500,  65, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC       , "", BID_SEND , "발송"),
		
		//전화번호 콤보
		DLG_COMBO( STARTX+320, STARTY+770, 260,  63, 100, 63, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_PHONE_DDD, 5),
		
		//숫자 자판
		DLG_TEXT(0,    STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333,  STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666,  STARTY+940, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+1030, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1120, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(333, STARTY+1210, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+1210, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "←"),
	};
	
	//---------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_View[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "이력내용"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+580, 829, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, "닫기"),

		DLG_TEXT(STARTX,     STARTY-29, 1000, 800, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_VIEW_ACTHIST, ""),
	};	
	
	//---------------------------------------------------------------
	// OnInit Function
	//---------------------------------------------------------------	
	void OnInit(char bFirst)
	{
		long lCnt;
		
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				if( m_lRedrawFlag == 0 )
				{
					Rcv_Reqym();
				}
				else
				{
					VisitDraw();
				}
				
				ReDraw();
				break;
			case INIT_VIEW:
				CREATE_DIALOG_OBJECT (DlgRes_View, SIZEOF(DlgRes_View));
				SetBtnImg();	
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VIEW_ACTHIST), EDITALIGN_TOP);
				EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_VIEW_ACTHIST), TRUE, 2, EDITSEP_NONE );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW_ACTHIST), m_szView );
				break;
		}
	}

	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_USE_CONT_NUM) , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USE_CONT_NUM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR)        , EDITALIGN_MIDDLE|EDITALIGN_RIGHT  );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_GUIDE_TYPE)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUIDE_TYPE)  , EDITALIGN_MIDDLE|EDITALIGN_CENTER );	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_STOPDAY)      , EDITALIGN_MIDDLE|EDITALIGN_CENTER );	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STOPDAY)     , EDITALIGN_MIDDLE|EDITALIGN_CENTER );	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_NOPAY)        , EDITALIGN_MIDDLE|EDITALIGN_CENTER );	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOPAY)       , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_ACTHIST)      , EDITALIGN_MIDDLE|EDITALIGN_CENTER );	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ACTHIST)     , EDITALIGN_MIDDLE|EDITALIGN_CENTER );	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE)        , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR)        , EDITALIGN_MIDDLE|EDITALIGN_LEFT   );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_PHONE_NUM)    , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PHONE_DDD)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ACTHIST), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR), TRUE, 3, EDITSEP_NONE );
		
		//숫자판
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
	}

	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{
		long d, k;
		char sztmp[15];
		char szToday[15];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		
		switch(ID)
		{
			case BID_CLOSE:
				Card_Move("C6202_NPSTOP");
				break;
			
			case BID_SEND:
				if( Validation() )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "SMS발송을 하시겠습니까?")  == MB_OK)
					{	
						Snd_StopSms();	
					}
				}
			    break;
			
			case BID_PREVLST:
				m_lPage--;
				if(m_lPage < 0)
				{
					m_lPage = 0;
					break;
				}
				m_lActIndex = 0;
				VisitDraw();
				break;
						
			case BID_NEXTLST:
				m_lPage++ ;
				if( m_lPage > m_lTotpage-1 )
				{
					m_lPage = m_lTotpage-1;
					if(m_lPage < 0)
					{
						m_lPage = 0;
					}
					break;
				}
				m_lActIndex = 0;
				VisitDraw();
				break;
				
			case BID_ADDR:
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				
				ReDraw();
				break;
				
			case BID_TXTVIEW:
				SaveData();
				m_lRedrawFlag = 1;
				ON_EXIT();
				OnInit(INIT_VIEW);
				break;
				
			case BID_VIEW_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnSelect
	기  능 : 테이블 클릭 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index;
		
		if( m_bFirst == INIT_MAIN )
		{
			if( g_Dlgflag == 0)
			{
				//현재 TBL이 선택되었는지를 확인
				if (DlgTbl_IsSelect(ID_ACTHISTLIST))
				{
					// 현재 선택된 인덱스
					index = DlgTbl_GetActiveRow(ID_ACTHISTLIST);
					m_lActIndex = index - 1;
		
					Mem_Set( (byte*)m_szView, 0x00, sizeof(m_szView) );
					Str_Cpy(m_szView, DlgTbl_GetStr( ID_ACTHISTLIST, m_lActIndex, 4));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ACTHIST), m_szView );
				}
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

		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				if( X > DMS_X(STARTX+620) && X < DMS_X(STARTX+790) && Y > DMS_Y(STARTY+770-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+833-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+830) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+770-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+833-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_PHONE_EXN) == lActiveIndex || Get_iDlgCtrlByID(EDT_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						g_MOVE_DLG(400);
					
						//ShowSip(FALSE);
						//g_Sipflag = 0;
					}
				}
				else
				{
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400))  )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
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
		
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	함수명 : ReDraw
	기  능 : 화면을 다시 그린다.
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{	
		char szTmp[300];
		char szTmp2[100];
		char szBuf[100];
		long lCnt, lMaxCnt,i;
		long lAllAmt = 0, lDebtAmt = 0, lLawEtcAmt = 0;
		
		/********* 사용계약번호 *********/
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Mem_Cpy( (byte*)szTmp2, (byte*)stNoPayObj.USE_CONT_NUM , 5 );
		Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM+5 , 5 );
		
		Str_Cat(szTmp, szTmp2);
		Str_Cat(szTmp, "-");
		Str_Cat(szTmp, szBuf);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_USE_CONT_NUM), szTmp );
		
		/********* 주소 *********/
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
		
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR),  stNoPayObj.CURR_ADDR_UNION);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주소");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR),  stNoPayObj.NEW_ADDR_UNION);
		}
		
		/********* 중단일 *********/
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szTmp2, 0x00, sizeof(szTmp2) );
		Str_ItoA(Time_GetDate(), szTmp, 10);
		g_Str_DateType( szTmp2, szTmp);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_STOPDAY), szTmp2 );
		
		/********* 미납요금 *********/
		
		// 대손금
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		g_Sql_RetStr("SELECT PARAM14 FROM RCV_NONPAY_REQYM", 50, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			lDebtAmt = 0;
		}
		else
		{
			lDebtAmt = Str_AtoI(szTmp);
		}
		
		// 법적및기타
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		g_Sql_RetStr("SELECT PARAM12 FROM RCV_NONPAY_REQYM", 50, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			lLawEtcAmt = 0;
		}
		else
		{
			lLawEtcAmt = Str_AtoI(szTmp);
		}
		
		// 체납금액
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set( (byte*) szTmp2, 0x00, sizeof( szTmp2) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_REQYM", 50, szTmp);
		lAllAmt = Str_AtoI(szTmp);
		lAllAmt = lAllAmt + lDebtAmt + lLawEtcAmt;
		Str_ItoA(lAllAmt, szTmp2, 10);
		if( Str_Len(szTmp2) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NOPAY), "0");
		}
		else
		{
			Str_Chg(szTmp2, STRCHG_INS_COMMA);
			Str_Cat(szTmp2, "원");
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NOPAY), szTmp2);
		}
		
		/********* 전화번호 *********/
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD),  m_szDDD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN),  m_szEXN);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM),  m_szNUM);
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : SetCombo
	기  능 : 콤보박스 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		// 전화번호
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_PHONE_DDD+2);
	}
	
	/*=======================================================================================
	함수명 : Rcv_Reqym
	기  능 : 금액을 조회한다.
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Reqym(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_NONPAY_REQYM");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822022, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822022; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR822022_IN",  "FR822022" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR822022
	기  능 : FR822022 트렌젝션
	Param  : 
	Return : 
	========================================================================================*/
	long TR822022(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(822022) >= 0)
		{
			Rcv_Account();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rcv_Account
	기  능 : 계좌를 조회한다.
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Account(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_NONPAY_ACCOUNT");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822023, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822023; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR822023_IN",  "FR822023" , sndbuf, sztmp );		
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR822023
	기  능 : FR822023 트렌젝션
	Param  : 
	Return : 
	========================================================================================*/
	long TR822023(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(822023) >= 0)
		{
			Rcv_Visit();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Rcv_Visit
	기  능 : 방문이력 수신_FR82226
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Visit(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82226, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
					
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82226; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR82226_IN",  "FR82226" , sndbuf, sztmp );
		
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR82226
	기  능 : Callback_TR82226
	Param  : 
	Return : 
	========================================================================================*/
	long TR82226(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82226) >= 0)
		{
			VisitDraw();
			ReDraw();
			return 1;
		}
		else
		{
			CloseMessageBox();
			MessageBoxEx (ERROR_OK, "중지 SMS 발송에 실패했습니다.");
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : VisitDraw
	기  능 : 그리드 DRAW
	Param  : 
	Return : 
	========================================================================================*/
	void VisitDraw(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[1200];
		char szDate[50];
		char szSql[300];
		char szWhy[50];
		char szVisitWhyCd[5];
		char szVisitWhyCd2[5];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(1) FROM RCV_TMP", &m_lTotpage );

		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		//페이지
		SPRINT(m_szCnt_page, "%d/%d", m_lPage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM102, PARAM5 FROM RCV_TMP LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lPage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lPage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 7, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_ACTHISTLIST, i, 7, "" );
					continue;
				}
				
				idx = 0;
				//일자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				g_Str_DateType( szDate, sztmp);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 0, szDate );
				
				//여부
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 1, sztmp );
				
				//관계
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 2, sztmp );
				
				//처리자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 3, sztmp );
				
				//이력내용
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 800, DECRYPT);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 4, sztmp );
				
				//사유
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 5, sztmp );
				
				//VISIT_WHY_CD
				Mem_Set( (byte*)szVisitWhyCd, 0x00, sizeof(szVisitWhyCd) );
				sql->GetValue(sql, idx++, 'U', (long*)szVisitWhyCd, 10, DECRYPT);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 6, szVisitWhyCd );
				
				//VISIT_WHY_CD2
				Mem_Set( (byte*)szVisitWhyCd2, 0x00, sizeof(szVisitWhyCd2) );
				sql->GetValue(sql, idx++, 'U', (long*)szVisitWhyCd2, 10, DECRYPT);
				DlgTbl_SetStr ( ID_ACTHISTLIST, i, 7, szVisitWhyCd2 );
				
				if( Str_Cmp(szVisitWhyCd, "82") == 0 || Str_Cmp(szVisitWhyCd, "60") == 0 ||
				    Str_Cmp(szVisitWhyCd2, "82") == 0 || Str_Cmp(szVisitWhyCd2, "60") == 0  )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 2 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 3 ), RED);
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 0 ), TXTCTRLFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 1 ), TXTCTRLFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 2 ), TXTCTRLFRCOLOR);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_ACTHISTLIST, i, 3 ), TXTCTRLFRCOLOR);
				}
			}
		}		

Finally:

		if(m_lTotpage > 0)
		{
			if( m_lActIndex == -1 )
			{
				m_lActIndex = 0;
			}
			
			DlgTbl_SetActive(ID_ACTHISTLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_ACTHISTLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)m_szView, 0x00, sizeof(m_szView) );
			Str_Cpy(m_szView, DlgTbl_GetStr( ID_ACTHISTLIST, m_lActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ACTHIST), m_szView );
		}

		DelSqLite(sql);
		
		return;
	}
	
	/*=======================================================================================
	함수명 : SaveData
	기  능 : Data Save
	Param  : 
	Return : 
	========================================================================================*/
	void SaveData(void)
	{
		// 전화번호
		Mem_Set( (byte*) m_szDDD, 0x00, sizeof( m_szDDD) );
		Mem_Set( (byte*) m_szEXN, 0x00, sizeof( m_szEXN) );
		Mem_Set( (byte*) m_szNUM, 0x00, sizeof( m_szNUM) );
		
		Str_Cpy( m_szDDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD)) ); 
		Str_Cpy( m_szEXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)) );
		Str_Cpy( m_szNUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)) );
	}
	
	/*=======================================================================================
	함수명 : SetSmsMsg
	기  능 : 메세지 Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetSmsMsg(void)
	{
		char szTmp[300];
		char szBuf[300];
		char szAmt[100];
		char szEtc[100];
		char szAllAmt[100];
		long i, row, idx, accountCnt, len;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		Mem_Set((byte*)m_szMsg, 0x00, sizeof(m_szMsg));
		Mem_Set((byte*)m_szDtlMsg, 0x00, sizeof(m_szDtlMsg));
		
		// 납부금액
		Mem_Set( (byte*) szAmt, 0x00, sizeof( szAmt) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_REQYM", 100, szAmt);
							
		// 법적및기타
		Mem_Set( (byte*) szEtc, 0x00, sizeof( szEtc) );
		g_Sql_RetStr("SELECT PARAM12 FROM RCV_NONPAY_REQYM", 100, szEtc);

		// 총금액
		Mem_Set((byte*)szAllAmt, 0x00, sizeof(szAllAmt));
		Str_ItoA( Str_AtoI( szAmt ) + Str_AtoI( szEtc ), szAllAmt, 10 );
		
		Str_Chg( szAmt, STRCHG_INS_COMMA );
		Str_Chg( szEtc, STRCHG_INS_COMMA );
		Str_Chg( szAllAmt, STRCHG_INS_COMMA );
		
		// 공통
		Str_Cpy( m_szMsg, "▣안녕하십니까\n서울도시가스입니다." );
		Str_Cat( m_szMsg, "\n--------------" );
		Str_Cat( m_szMsg, "\n▣도시가스 공급중지 일자 : " );
		Str_Cat( m_szDtlMsg, "\n도시가스 공급중지 일자 : " );
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Str_ItoA(Time_GetDate(), szTmp, 10);
		Mem_Cpy( (byte*)szBuf, (byte*)szTmp, 4 );
		Str_Cat( szBuf , "년");
		Mem_Cpy( (byte*)szBuf+6, (byte*)szTmp+4, 2 );
		Str_Cat( szBuf , "월");
		Mem_Cpy( (byte*)szBuf+10, (byte*)szTmp+6, 2 );
		Str_Cat( szBuf , "일");
		
		Str_Cat( m_szMsg, szBuf );	
		Str_Cat( m_szDtlMsg, szBuf );
		
		Str_Cat( m_szMsg, "\n▣" );
		
		Str_Cat( m_szMsg, stNoPayObj.NEW_ADDR_UNION );
		Str_Cat( m_szDtlMsg, stNoPayObj.NEW_ADDR_UNION );
		
		Str_Cat( m_szMsg, "에서 사용하는 도시가스요금이 미납되어 부득이 금일 가스 공급이 중단되었습니다.");
		Str_Cat( m_szMsg, " 미납요금 전액을 납부 하신 후 재공급 요청시 가스공급이 가능합니다.");
		Str_Cat( m_szMsg, "\n--------------" );
		
		Str_Cat( m_szMsg, "\n▣고객님 입금전용 계좌 번호");
		
		// 법적소송및기타 금액이 없는 경우
		if( Str_Cmp(szEtc, "0") == 0 )
		{
  			Str_Cat( m_szMsg, "\n◎입금계좌 납부금액 : " );
  			Str_Cat( m_szMsg, szAmt );
  			Str_Cat( m_szMsg, "원");
		}
		// 법적소송및기타 금액이 있는 경우
		else
		{
			Str_Cat( m_szMsg, "\n◎현재 미납금 : " );
			Str_Cat( m_szMsg, szAllAmt );
			Str_Cat( m_szMsg, "\n※상기금액은 법적소송 및 기타비용 " );
			Str_Cat( m_szMsg,  szEtc);
			Str_Cat( m_szMsg, "원이 포함된 금액입니다." );
			Str_Cat( m_szMsg, "\n◎입금계좌 납부금액 : " );
  			Str_Cat( m_szMsg, szAmt );
  			Str_Cat( m_szMsg, "원");
		}
		
		// 계좌
		g_Sql_RetInt( "SELECT COUNT(1) FROM RCV_NONPAY_ACCOUNT", &accountCnt );

		for( i = 0 ; i < accountCnt ; i++)
		{
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			
			if( hdb == NULL )
			{
				goto Finally;
			}
			
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2 || ' : ' || SUBSTR(PARAM1,1,4) || '-' || SUBSTR(PARAM1,5,4) || '-' || SUBSTR(PARAM1,9,4) || '-' || SUBSTR(PARAM1,13, length(PARAM1)+1 - 13 ) AS ACCOUNT \
												 FROM RCV_NONPAY_ACCOUNT LIMIT ?,?");
									
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
			row = 1;
			sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			while( sql->Next(sql) )
			{
				idx = 0;
				
				Str_Cat( m_szMsg, "\n▷" );
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				sql->GetValue(sql, idx++, 'U', (long*)szTmp ,100, DECRYPT);
				Str_Cat( m_szMsg, szTmp);

			};		
Finally:
			DelSqLite(sql);
	
		}
		
		Str_Cat( m_szMsg, "\n--------------" );
		Str_Cat( m_szMsg, "\n▣도시가스 요금 고지서로 미납요금을\n납부하신 경우 은행으로부터 납부사실이\n당사에 통보되기까지일정기간(3~7일)\n소요되므로 미납 안내문자가 발송될수 있으니\n양해하여 주시기 바랍니다." );
		Str_Cat( m_szMsg, "\n--------------" );
		Str_Cat( m_szMsg, "\n▣요금상세내역 및 고객정보가 상이할 경우 자세한 사항은\n서울도시가스(02-810-8021)연락 주시면 감사하겠습니다." );
	}
	
	/*=======================================================================================
	함수명 : Validation
	기  능 : Validation
	Param  : 
	Return : 
	========================================================================================*/
	bool Validation(void)
	{
		char sztmp[100];
		
		// 전화번호
		if(!g_CheckPhoneNumberFormat( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)) ) )
		{
			MessageBoxEx (CONFIRM_OK, "전화번호 형식이 잘못되었습니다.");
			return FALSE;
		}

		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Snd_StopSms
	기  능 : FR84101 호출
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_StopSms(void)
	{
		char szUrl[200];
		char szbuf[128];
		char sztmp[128];
		char szScrPht[128];
		char szUcovert[1000];
		char* sndbuf;
		long ret = 0;
		long i, idx, fd;
		byte* signimg = NULL;
		char* szfile =  NULL;
		long filesize = 0;
		handle file;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 84101, FALSE);
		
		// 문자내용 세팅
		SetSmsMsg();
		
		Add_StopSms(g_pjcomm);
		Add_StopSmsHist(g_pjcomm);
		Add_StopMan(g_pjcomm);
		Add_StopDtl(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		g_SeverConnection();
		
		callBackfunc = Rcv_StopSms; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR84101_IN",  "FR84101" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Rcv_StopSms
	기  능 : FR84101 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_StopSms(void)
	{
		char szSql[200];
		
		g_Sock_Close();

		if( g_Chk_Json(84101) >= 0)
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
				
			if( g_nWorkFlag == 830 )
			{
				SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET STOP_SMS_YN = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);	
			}
			else if( g_nWorkFlag == 810 )
			{
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET STOP_SMS_YN = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
			}
			else
			{
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET STOP_SMS_YN = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
			}
			
			g_Sql_DirectExecute(szSql);
			
			Mem_Set( (byte*)stNoPayObj.STOP_SMS_YN, 0x00, sizeof(stNoPayObj.STOP_SMS_YN) );	
			Str_Cpy(stNoPayObj.STOP_SMS_YN, "Y");
			
			MessageBoxEx (CONFIRM_OK, "SMS 발송을 완료하였습니다.");
			Card_Move("C6202_NPSTOP");
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
		}

		return 0;
	}
	
	/*=======================================================================================
	함수명 : Add_StopSms
	기  능 : A1AT_SMS.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_StopSms(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[3000];	
		char sztmp[100];
		char szSms[3000];
		
		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
		
		JSON_AddArrayItem(js);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp,"C232" );
		JSON_SetArrayItem(js, 'C',  "corres_flag"        , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "send_sts"  	     , "1");
		JSON_SetArrayItem(js, 'C',  "send_tel_ddd"  	 , "02");
		JSON_SetArrayItem(js, 'C',  "send_tel_exn"       , "810");
		JSON_SetArrayItem(js, 'C',  "send_tel_num"       , "8021");
		
		JSON_SetArrayItem(js, 'C',  "receiver_tel_ddd"   , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD)));
		JSON_SetArrayItem(js, 'C',  "receiver_tel_exn"   , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)));
		JSON_SetArrayItem(js, 'C',  "receiver_tel_num"   , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)));
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp, stNoPayObj.CUST_NM );
		JSON_SetArrayItem(js, 'C',  "receiver_nm"        , sztmp);
		
		Mem_Set((byte*)szSms, 0x00, sizeof(szSms));
		SQL_ConvUcStr( szSms, m_szMsg );
		JSON_SetArrayItem(js, 'C',  "sms_desc"           , szSms);
		
		JSON_SetArrayItem(js, 'C',  "send_plc_flag"      , "60");
		JSON_SetArrayItem(js, 'C',  "cust_num"           , stNoPayObj.CUST_NUM);
		JSON_SetArrayItem(js, 'C',  "use_cont_num"       , stNoPayObj.USE_CONT_NUM);
		JSON_SetArrayItem(js, 'C',  "center_cd"          , stUserinfo.szcenter_cd);
		
		JSON_Attach(pj, "nopaySms", js);
		
	Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Add_StopSmsHist
	기  능 : C5BT_CIVIL_SERV_SMS_HIST.insert, C2FT_SMS_SEND.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_StopSmsHist(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[3000];
		char sztmp[100];
		char szSms[3000];
		
		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
	
		JSON_AddArrayItem(js);
		
		JSON_SetArrayItem(js, 'C',  "use_cont_num"   		, stNoPayObj.USE_CONT_NUM);    
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp, "C232" );
		JSON_SetArrayItem(js, 'C',  "corres_flag"           , sztmp);
		JSON_SetArrayItem(js, 'C',  "msg_item"              , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "cust_num"              , stNoPayObj.CUST_NUM);
		
		JSON_SetArrayItem(js, 'C',  "cust_type_cd"          , stNoPayObj.CUST_TYPE_CD);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp, stNoPayObj.CUST_NM );
		JSON_SetArrayItem(js, 'C',  "cust_nm"               , sztmp);
		JSON_SetArrayItem(js, 'C',  "receiver_nm"           , sztmp);

		JSON_SetArrayItem(js, 'C',  "cp_ddd"                , stNoPayObj.CP_DDD);
		JSON_SetArrayItem(js, 'C',  "cp_exn"                , stNoPayObj.CP_EXN);
		JSON_SetArrayItem(js, 'C',  "cp_num"                , stNoPayObj.CP_NUM);
		JSON_SetArrayItem(js, 'C',  "receiver_tel_ddd"   	, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD)));
		JSON_SetArrayItem(js, 'C',  "receiver_tel_exn"   	, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)));
		JSON_SetArrayItem(js, 'C',  "receiver_tel_num"   	, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)));
		JSON_SetArrayItem(js, 'C',  "bnk_cd"                , "");
		JSON_SetArrayItem(js, 'C',  "account_num"           , "");
		JSON_SetArrayItem(js, 'C',  "depositor_nm"          , "");
		
		// 납부금액
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_REQYM", 100, sztmp);
		JSON_SetArrayItem(js, 'C',  "guide_amt"             , sztmp);
		
		// 조치날짜
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_ItoA(Time_GetDate(), sztmp, 10);
		JSON_SetArrayItem(js, 'C',  "act_guide_ymd"         , sztmp);
	
		Mem_Set((byte*)szSms, 0x00, sizeof(szSms));
		SQL_ConvUcStr( szSms, m_szMsg );
		JSON_SetArrayItem(js, 'C',  "sms_desc"              , szSms);
		
		JSON_SetArrayItem(js, 'C',  "guide_job_sts"         , "30");
		JSON_SetArrayItem(js, 'C',  "nonpay_center_cd"      , stUserinfo.szcenter_cd);
		JSON_SetArrayItem(js, 'C',  "rmk"                   , "");
		JSON_SetArrayItem(js, 'C',  "civil_serv_receive_num", "");
		JSON_SetArrayItem(js, 'C',  "treat_seq"             , "");
		JSON_SetArrayItem(js, 'C',  "send_plc_flag"         , "60");
		JSON_SetArrayItem(js, 'C',  "class_cd"              , "");
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_ItoA( Time_GetDate(), sztmp, 10);	
		JSON_SetArrayItem(js, 'C',  "pay_cls_ymd"           , sztmp);
		
		JSON_Attach(pj, "nopaySmsHist", js);

	Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Add_StopMan
	기  능 : C2FT_NOPAY_MAN.merge, C2FT_NOPAY_MAN.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/
	long Add_StopMan(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;	
		char sztmp[100];
		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
	
		JSON_AddArrayItem(js);

		JSON_SetArrayItem(js, 'C',  "use_cont_num"    , stNoPayObj.USE_CONT_NUM );

		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_ItoA( Time_GetDate(), sztmp, 10);	
		JSON_SetArrayItem(js, 'C',  "cut_guide_ymd" , sztmp );
		JSON_SetArrayItem(js, 'C',  "cut_plan_ymd"  , sztmp );	
		JSON_SetArrayItem(js, 'C',  "cut_treat_ymd" , sztmp );	
		
		JSON_Attach(pj, "nopayMan", js);

	Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Add_StopDtl
	기  능 : C2FT_NOPAY_DTL.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_StopDtl(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[3000];
		
		char sztmp[100];
		char szSms[3000];

		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
	
		JSON_AddArrayItem(js);
		
		JSON_SetArrayItem(js, 'C',  "use_cont_num"        , stNoPayObj.USE_CONT_NUM);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_ItoA( Time_GetDate(), sztmp, 10);	
		JSON_SetArrayItem(js, 'C',  "nonpay_active_ymd"   , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "nonpay_active_flag"  , "220");
		JSON_SetArrayItem(js, 'C',  "active_success_yn"   , "");
		
		Mem_Set((byte*)szSms, 0x00, sizeof(szSms));
		SQL_ConvUcStr( szSms, m_szDtlMsg );
		JSON_SetArrayItem(js, 'C',  "active_rslt_desc"    , szSms);
		
		JSON_SetArrayItem(js, 'C',  "auction_act_yn"      , "");
		JSON_SetArrayItem(js, 'C',  "active_guide_ymd"    , "");
		JSON_SetArrayItem(js, 'C',  "pay_plan_ymd"        , "");
		JSON_SetArrayItem(js, 'C',  "cust_relat_cd"       , "");
		JSON_SetArrayItem(js, 'C',  "cust_nm"             , "");
	
		JSON_SetArrayItem(js, 'C',  "visit_why_cd"        , "50");
		JSON_SetArrayItem(js, 'C',  "nonpay_center_cd"    , stUserinfo.szcenter_cd);
		JSON_SetArrayItem(js, 'C',  "taker_nm"            , "");
		JSON_SetArrayItem(js, 'C',  "rmk"                 , "");
		JSON_SetArrayItem(js, 'C',  "pay_amt"             , "");
		JSON_SetArrayItem(js, 'C',  "receipt_seq"         , "");
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_ItoA( Time_GetDate(), sztmp, 10);	
		JSON_SetArrayItem(js, 'C',  "cut_hope_ymd"        , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "tel_ddd"             , "");
		JSON_SetArrayItem(js, 'C',  "tel_exn"             , "");
		JSON_SetArrayItem(js, 'C',  "tel_num"             , "");
		JSON_SetArrayItem(js, 'C',  "soc_num"             , "");
		JSON_SetArrayItem(js, 'C',  "cp_ddd"              , "");
		JSON_SetArrayItem(js, 'C',  "cp_exn"              , "");
		JSON_SetArrayItem(js, 'C',  "cp_num"              , "");
		JSON_SetArrayItem(js, 'C',  "refer_job_ymd"       , "");
		JSON_SetArrayItem(js, 'C',  "refer_job_seq"       , "");
		JSON_SetArrayItem(js, 'C',  "active_success_yn_2" , "");
		JSON_SetArrayItem(js, 'C',  "visit_why_cd_2"      , "");

		JSON_Attach(pj, "nopayDtl", js);
		
	Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return ret;
	}
}
