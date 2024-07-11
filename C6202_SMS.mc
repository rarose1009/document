/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6202_SMS
	Card Desc : 체납 문자 발송 기능
	Card Hist :
----------------------------------------------------------------------------------*/
card C6202_SMS
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
		DEF_BUTTON_ID ( BID_ADDR )		// 지번주소/도로명주소
		DEF_BUTTON_ID ( BID_REFSCHDL )	// 달력
		DEF_BUTTON_ID ( BID_UP )		// 그리드 UP
		DEF_BUTTON_ID ( BID_DOWN )		// 그리드 DOWN
		DEF_BUTTON_ID ( BID_SEND )		// 발송
		DEF_BUTTON_ID ( BID_CLOSE )		// 닫기
		DEF_BUTTON_ID ( BID_SMS_VIEW )  // SMS 내용 보기
		DEF_BUTTON_ID ( BID_NPCHK )		// 테이블 헤더 체크박스
		DEF_BUTTON_ID ( BID_VIEWCLOSE )
		DEF_BUTTON_ID ( BID_FEEPREV )
		DEF_BUTTON_ID ( BID_FEENEXT )
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// 카드내에서 사용될 콘트롤 아이디 정의
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )				// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )			// 타이틀
		
		DEF_OBJECT_ID ( ST_USE_CONT_NUM )		// ST 사용계약번호
		DEF_OBJECT_ID ( TXT_USE_CONT_NUM )		// TXT 사용계약번호
		
		DEF_OBJECT_ID ( TXT_ADDR )				// TXT 주소

		DEF_OBJECT_ID ( ST_PHONE_NUM )			// ST 전화번호
		DEF_OBJECT_ID ( TXT_PHONE_EXN )			// TXT 전화번호 EXN
		DEF_OBJECT_ID ( EDT_PHONE_EXN )			// EDT 전화번호 EXN
		DEF_OBJECT_ID ( TXT_PHONE_NUM )			// TXT 전화번호 NUM
		DEF_OBJECT_ID ( EDT_PHONE_NUM )			// EDT 전화번호 NUM
		
		DEF_OBJECT_ID ( ST_GUIDE_TYPE )			// ST 안내유형
		DEF_OBJECT_ID ( TXT_GUIDE_TYPE )		// TXT 안내유형
		
		DEF_OBJECT_ID ( ST_DUEDATE )			// ST 중지/등록 예정일
		DEF_OBJECT_ID ( TXT_DUEDATE )			// TXT 중지/등록 예정일 ""
		DEF_OBJECT_ID ( EDT_DUEDATE_YEAR )		// EDT 중지/등록 예정일 년도
		DEF_OBJECT_ID ( TXT_DUEDATE2 )			// TXT 중지/등록 예정일 .
		DEF_OBJECT_ID ( EDT_DUEDATE_MONTH )		// EDT 중지/등록 예정일 월
		DEF_OBJECT_ID ( TXT_DUEDATE3 )			// TXT 중지/등록 예정일 ""
		DEF_OBJECT_ID ( TXT_DUEDATE4 )			// TXT 중지/등록 예정일 .
		DEF_OBJECT_ID ( TXT_DUEDATE5 )			// TXT 중지/등록 예정일 ""
		DEF_OBJECT_ID ( EDT_DUEDATE_DATE )		// EDT 중지/등록 예정일 일
		
		DEF_OBJECT_ID ( ID_NPLIST )
		
		DEF_OBJECT_ID ( ST_SELECTNONPAY )
		DEF_OBJECT_ID ( TXT_SELECTNONPAY )
		DEF_OBJECT_ID ( TXT_PAGE )
		
		DEF_OBJECT_ID ( TXT_VIEW )	
		
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
		
		DEF_OBJECT_ID ( CMB_PHONE_DDD )						// CMB 국번
		DEF_OBJECT_ID ( CMB_GUIDE_TYPE = CMB_PHONE_DDD+3 )	// 안내유형	
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// 기본정의 DLG화면 정의
	//---------------------------------------------------------------
	
	#define INIT_MAIN 1
	#define INIT_VIEW 2
	
	long m_bFirst;
	long m_lPage = 0;
	long m_lTotpage = 0;
	long m_lNpChkFlag = 0;
	long m_lNpAct = -1;
	long m_lRedrawFlag = 0;
	long m_lViewPage = 0;
	char m_szMsg[3][1000];
	char m_szDtlMsg[1000];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void SetCombo(void);
	
	long Rcv_MtrReqym(void);
	long TR822021(void);
	long Rcv_Reqym(void);
	long TR822022(void);
	long Rcv_Account(void);
	long TR82211(void);
	
	void NonpayDraw(void);
	void Save_Row(long row, long col);
	void ChkClear(void);
	void SetData(void);
	void SaveData(void);
	void SetSmsMsg(char* val);
	bool Validation(void);
	
	long SearchStr( char *Str, CodeTable *CT);
	long SearchCD( char *CD, CodeTable *CT);
	
	void Snd_NopaySms(void);
	long Rcv_NopaySms(void);

	long Add_NopaySms(handle pj);
	long Add_NopaySmsHist(handle pj);
	long Add_NopayMan(handle pj);
	long Add_NopayDtl(handle pj); 

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4						// table의 행개수
	#define		COL 	    5						// table의 열개수
	#define		GRID_H		(CHT+23)				// table 행 높이
	#define		GRID_CLR	TRANSPARENT   			// table 클리어 color
	#define		GRID_X		STARTX 					// table 시작x좌표
	#define		MAXCHAR		31 			    		// table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+CHT*6+31	        // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table마지막 row의 Y값

	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	
	Column m_stGridTitle[] = {
		{""              , CWD*3 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"청구년월"      , CWD*9,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"제외"          , CWD*5 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상태"          , CWD*10 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"체납금액"      , CWD*12+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	typedef struct _NPSMS
	{
		char DDD[5];
		char EXN[5];
		char NUM[5];
		char GUIDETYPE[5];
		char YEAR[5];
		char MONTH[3];
		char DATE[3];
		char payYEAR[5];
		char payMONTH[3];
		char payDATE[3];
	}	_NPSMS;
	
	_NPSMS m_stNpSms;
	
	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// 메인 다이얼로그(체납문자발송관리)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납문자발송관리"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_TEXT ( STARTX,     STARTY- 29, 320,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , ST_USE_CONT_NUM , "사용계약번호"),
		DLG_TEXT ( STARTX+320, STARTY- 29, 680,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_USE_CONT_NUM, ""),

		DLG_BUTTON(STARTX,	   STARTY+ 31, 320, 120, 0, 0, 0, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, ""),
		DLG_TEXT ( STARTX+320, STARTY+ 31, 680, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK  , TXT_ADDR , ""),
	
		DLG_TEXT ( STARTX,	   STARTY+151, 320,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_GUIDE_TYPE, "안내유형"),
	
		DLG_TEXT ( STARTX,	   STARTY+211, 420,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_DUEDATE, "예정일"),
		
		DLG_TEXT ( STARTX+420, STARTY+211,  40,  60, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DUEDATE, ""),	
		DLG_EDIT ( STARTX+460, STARTY+211, 150,  60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DUEDATE_YEAR, 4,  ""),
		DLG_TEXT ( STARTX+610, STARTY+211,  20,  60, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DUEDATE2, "."),
		DLG_TEXT ( STARTX+630, STARTY+211,  20,  60, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DUEDATE3, ""),
		DLG_EDIT ( STARTX+650, STARTY+211,  90,  60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DUEDATE_MONTH, 2,  ""),
		DLG_TEXT ( STARTX+740, STARTY+211,  20,  60, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DUEDATE4, "."),
		DLG_TEXT ( STARTX+760, STARTY+211,  20,  60, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DUEDATE5, ""),
		DLG_EDIT ( STARTX+780, STARTY+211,  90,  60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DUEDATE_DATE, 2,  ""),
		
		DLG_BUTTON(STARTX+870, STARTY+211, 130,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_NPLIST, m_szTableBuf),
		DLG_BUTTON(STARTX,     STARTY+275,  74,  50, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TXTCTRLFRCOLOR, TABLETITLE_COLOR, CALL_FUNC , "", BID_NPCHK, CHKON),
		
		DLG_TEXT ( STARTX,	   STARTY+585, 420,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_SELECTNONPAY, "선택미납액"),
		DLG_TEXT ( STARTX+420, STARTY+585, 580,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SELECTNONPAY, ""),
	
		DLG_TEXT ( STARTX    , STARTY+645, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, ""),
		DLG_BUTTON(STARTX+300, STARTY+645, 350,  60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP,  "▲"),
		DLG_BUTTON(STARTX+650, STARTY+645, 350,  60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN,  "▼"),
		
		DLG_BUTTON(STARTX    , STARTY+705,1000,  65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS_VIEW, "SMS 내용 보기 "),
		
		DLG_TEXT ( STARTX,	   STARTY+770, 320,  63, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_PHONE_NUM, "전화번호"),
		DLG_TEXT ( STARTX+580, STARTY+770,  40,  63, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PHONE_EXN, "-"),
		DLG_EDIT ( STARTX+620, STARTY+770, 170,  63, 0, 0,    EDITSTY_BOLD  , EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+790, STARTY+770,  40,  63, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PHONE_NUM, "-"),
		DLG_EDIT ( STARTX+830, STARTY+770, 170,  63, 0, 0,    EDITSTY_BOLD  , EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_PHONE_NUM, 4,  ""),
		
		DLG_BUTTON(STARTX,	   STARTY+835, 500,  65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "닫기"),
		DLG_BUTTON(STARTX+500, STARTY+835, 500,  65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "발송"),
		
		DLG_COMBO( STARTX+320, STARTY+770, 260,  63, 100, 63, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_PHONE_DDD, 5),
		DLG_COMBO( STARTX+320, STARTY+151, 680,  60, 130, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GUIDE_TYPE, 30),	
		
		//숫자 자판
		DLG_TEXT(0,    STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT(333,  STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT(666,  STARTY+940, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT(333, STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT(666, STARTY+1030, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT(0,   STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1120, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT(333, STARTY+1210, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT(666, STARTY+1210, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "←"),
	};
	
	// 메인 다이얼로그(문자내용)
	//---------------------------------------------------------------
	DlgObject	DlgRes_View[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납문자내용확인"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VIEWCLOSE, ""),
		
		DLG_TEXT ( STARTX,	    STARTY-29, 1000, 800, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_VIEW, ""),
		
		DLG_BUTTON(STARTX,      STARTY+770, 500, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEEPREV, "이전"),
		DLG_BUTTON(STARTX+500,  STARTY+770, 500, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEENEXT, "다음"),
		DLG_BUTTON(STARTX    ,  STARTY+835, 1000, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEWCLOSE, "닫기"),
	};	
	
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
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				if( m_lRedrawFlag == 0 )
				{
					SetData();
					Rcv_MtrReqym();
				}
				else
				{
					NonpayDraw();
					ReDraw();
				}
				break;
			
			case INIT_VIEW:
				
				CREATE_DIALOG_OBJECT (DlgRes_View, SIZEOF(DlgRes_View));
				SetBtnImg();

				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VIEW), EDITALIGN_TOP);
				EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_VIEW), TRUE, 2, EDITSEP_NONE );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW), m_szMsg[0] );
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_USE_CONT_NUM)  , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR)         , EDITALIGN_MIDDLE|EDITALIGN_RIGHT  );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_PHONE_NUM)     , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_GUIDE_TYPE)    , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DUEDATE)       , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SELECTNONPAY)  , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE)         , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR)         , EDITALIGN_MIDDLE|EDITALIGN_LEFT   );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SELECTNONPAY) , EDITALIGN_MIDDLE|EDITALIGN_CENTER );

		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR), TRUE, 3, EDITSEP_NONE );
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PHONE_DDD)    , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GUIDE_TYPE)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		
		//숫자판
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
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
				Card_Move("C6202_VISIT");
				
				break;
			
			case BID_SEND:
				if( Validation() )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "SMS발송을 하시겠습니까?")  == MB_OK)
					{	
						Snd_NopaySms();	
					}
				}
			    break;
			
			case BID_UP:
				m_lPage--;
				if(m_lPage < 0)
				{
					m_lPage = 0;
					
					break;
				}
				NonpayDraw();
				break;
						
			case BID_DOWN:
				m_lPage++;
				if( m_lPage > m_lTotpage-1 )
				{
					m_lPage = m_lTotpage-1;
					
					break;
				}
				NonpayDraw();
				break;
				
			case BID_REFSCHDL:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DUEDATE_YEAR)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DUEDATE_MONTH)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DUEDATE_DATE)));
				
				k = Str_AtoI(szDate);
			
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Str_ItoA ( d, sztmp, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
					Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DUEDATE_YEAR), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DUEDATE_MONTH), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DUEDATE_DATE), szDay );					
				}
				
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
			
			case BID_NPCHK:
				if( m_lNpChkFlag == 0 )
				{
					m_lNpChkFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKON);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), RED);
					g_Sql_DirectExecute( "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '1'" );
				}
				else
				{
					m_lNpChkFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
					g_Sql_DirectExecute( "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '0'" );
				}
				
				NonpayDraw();
				
				break;
				
			case BID_VIEWCLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
			
			case BID_SMS_VIEW:
			
				if( Validation() )
				{
					m_lViewPage = 0;
					SaveData();
					SetSmsMsg(m_stNpSms.GUIDETYPE);
					ON_EXIT();
					OnInit(INIT_VIEW);
				}
				
				break;
				
			case BID_FEEPREV:
				m_lViewPage--;
				
				if( m_lViewPage <= 0 )
				{
					m_lViewPage = 0;
				}

				if( m_lViewPage == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW), m_szMsg[0] );
				}
				else if ( m_lViewPage == 1 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW), m_szMsg[1] );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW), m_szMsg[2] );
				}
				
				break;
				
			case BID_FEENEXT:
				m_lViewPage++;
				
				if( m_lViewPage > 2)
				{
					m_lViewPage = 2;
				}
				
				if( m_lViewPage == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW), m_szMsg[0] );
				}
				else if ( m_lViewPage == 1 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW), m_szMsg[1] );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_VIEW), m_szMsg[2] );
				}
				
				break;
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
					
						ShowSip(FALSE);
						g_Sipflag = 0;

						//ShowSip(TRUE);
						//g_Sipflag = 1;
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
	함수명 : OnSelect
	기  능 : 테이블 클릭 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long lCnt, lMaxCnt;
		long index = -1;
		long lpage = 0;
		long lrow, lcol;
		char sztmp[50];
		long i;
		
		if( m_bFirst == INIT_MAIN )
		{
			if( g_Dlgflag == 0)
			{
				if (DlgTbl_IsSelect(ID_NPLIST))
				{
					// 현재 선택된 인덱스
					index = DlgTbl_GetActiveRow(ID_NPLIST);
			
					m_lNpAct = index;
					
					lrow = m_lNpAct/COL;
					lcol = m_lNpAct%COL;
					
					lrow--;
			
					// 선택 인덱스와 기존 인덱스가 동일 할 경우
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_NPLIST, lrow, lcol) );
			
					if( lcol == 0 )
					{
						if( Str_Cmp( sztmp, CHKON) == 0 )
						{
							DlgTbl_SetStr ( ID_NPLIST, lrow, lcol, CHKOFF );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol ), BLACK);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol+4 ), BLACK);
						}
						else
						{
							DlgTbl_SetStr ( ID_NPLIST, lrow, lcol, CHKON );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol ), RED );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol+4 ), RED );
						}
						
						Save_Row(lrow, lcol);
						
						g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1' ", &lCnt );
						
						if( lCnt == 0 )
						{
							m_lNpChkFlag = 0;
							ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
						}
						else
						{
							g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &lMaxCnt );
							
							if( lMaxCnt == lCnt )
							{
								m_lNpChkFlag = 1;
								ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKON);
								ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), RED);
							}
							else if( lMaxCnt > lCnt )
							{
								m_lNpChkFlag = 0;
								ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
								ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
							}
						}
						ReDraw();
					}
				}
			}
		}
		
		ON_DRAW();
	}

	/*=======================================================================================
	함수명 : SearchStr
	기  능 : 스트링으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
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
	
	/*=======================================================================================
	함수명 : SearchCD
	기  능 : 코드값으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
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

		// 사용계약번호
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Mem_Cpy( (byte*)szTmp2, (byte*)stNoPayObj.USE_CONT_NUM , 5 );
		Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM+5 , 5 );
		Str_Cat(szTmp, szTmp2);
		Str_Cat(szTmp, "-");
		Str_Cat(szTmp, szBuf);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_USE_CONT_NUM), szTmp );
		
		// 전화번호
		if(Str_Len(m_stNpSms.DDD) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD),  m_stNpSms.DDD);
		}
		
		if(Str_Len(m_stNpSms.EXN) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN),  m_stNpSms.EXN);
		}
		
		if(Str_Len(m_stNpSms.NUM) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM),  m_stNpSms.NUM);
		}
		
		// 년도
		if(Str_Len(m_stNpSms.YEAR) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DUEDATE_YEAR), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DUEDATE_YEAR),  m_stNpSms.YEAR);
		}
		
		// 월
		if(Str_Len(m_stNpSms.MONTH) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DUEDATE_MONTH), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DUEDATE_MONTH),  m_stNpSms.MONTH);
		}
		
		// 일
		if(Str_Len(m_stNpSms.DATE) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DUEDATE_DATE), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DUEDATE_DATE),  m_stNpSms.DATE);
		}
		
		// 유형
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));

		if( Str_Cmp(m_stNpSms.GUIDETYPE,"") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_GUIDE_TYPE), "공급중지예고");
		}
		else
		{
			SPRINT(szTmp, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10421' AND CODE_ITEM = '%s'", m_stNpSms.GUIDETYPE, 0, 0 );
			g_Sql_RetStr( szTmp, 30, szTmp2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_GUIDE_TYPE), szTmp2);
		}
		
		// 주소
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

		
		// 선택미납액
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 50, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_SELECTNONPAY), "0원");
		}
		else
		{
			Str_Chg(szTmp, STRCHG_INS_COMMA);
			Str_Cat(szTmp, "원");
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_SELECTNONPAY), szTmp);
		}
		
		
		// 헤더 체크박스
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1' ", &lCnt );
		
		if( lCnt == 0 )
		{
			m_lNpChkFlag = 0;
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
		}
		else
		{
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &lMaxCnt );
			
			if( lMaxCnt == lCnt )
			{
				m_lNpChkFlag = 1;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKON);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), RED);
			}
			else if( lMaxCnt > lCnt )
			{
				m_lNpChkFlag = 0;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
			}
		}
		
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

		// 안내유형
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10421' AND CODE_ITEM IN ('C210', 'C220') ORDER BY CODE_ITEM", CMB_GUIDE_TYPE+2);
	}
	
	/*=======================================================================================
	함수명 : Rcv_MtrReqym
	기  능 : 월별 미납금액을 조회한다.
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_MtrReqym(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_NONPAY_MTRREQYM");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822021, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822021; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR822021_IN",  "FR822021" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR822021
	기  능 : FR822021 트렌젝션
	Param  : 
	Return : 
	========================================================================================*/
	long TR822021(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(822021) >= 0)
		{
			Rcv_Reqym();
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
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82211, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82211; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR82211_IN",  "FR82211" , sndbuf, sztmp );		
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR82211
	기  능 : FR82211 트렌젝션
	Param  : 
	Return : 
	========================================================================================*/
	long TR82211(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82211) >= 0)
		{
			m_lRedrawFlag = 1;
			// 체크박스 전부 체크를 위한 코드
			m_lNpChkFlag = 1;
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKON);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), RED);
			g_Sql_DirectExecute( "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '1'" );
			NonpayDraw();
			ReDraw();
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
	함수명 : NonpayDraw
	기  능 : 그리드 DRAW
	Param  : A.REQ_YM AS PARAM1
		   , A11.PKS_A1_FUNC_01.GET_CODE_ITEM_VALUE('C20081',A.REQ_MANAGE_STS) AS PARAM2
		   , A.REQ_EXCEPTION AS PARAM3
		   , A.UNPAY_AMT AS PARAM4
		   , B.MTR_ID_NUM AS PARAM5
		   , B.MTR_NUM AS PARAM6
		   , A.DEADLINE_FLAG AS PARAM7
		   , A.USE_CONT_NUM AS PARAM8
		   , '0' AS PARAM9
		   , (A.SET_QTY_BASE+A.SET_QTY_HEAT) AS PARAM10
		   , A.SALES_OWN_CTR AS PARAM11   
		   , C.INDI_COMPENS_STR_VC AS PARAM12
		   , C.INDI_COMPENS_THIS_MM_VC AS PARAM13
	Return : 
	========================================================================================*/
	void NonpayDraw(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[201];
		char szDate[50];
		char szSql[500];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &m_lTotpage );
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		//페이지
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "%d/%d", m_lPage+1, m_lTotpage, 0);
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_PAGE ), sztmp );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT PARAM9, PARAM1, PARAM3, PARAM2, PARAM4 FROM RCV_NONPAY_MTRREQYM WHERE PARAM8 = '%s' LIMIT ?, ? ", stNoPayObj.USE_CONT_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lPage * ROW;
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
				DlgTbl_SetStr ( ID_NPLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 4, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_NPLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 4, "" );
					continue;
				}
				
				idx = 0;
				//ㅁ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5, DECRYPT);
				if( Str_Cmp(sztmp, "1") == 0 )
				{
					DlgTbl_SetStr ( ID_NPLIST, i, 0, CHKON );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 4 ), RED);
				}
				else
				{
					DlgTbl_SetStr ( ID_NPLIST, i, 0, CHKOFF );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 0 ), BLACK);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 4 ), BLACK);
				}
				//청구년월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_NPLIST, i, 1, sztmp );
				//제외
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_NPLIST, i, 2, sztmp );
				//상태
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_NPLIST, i, 3, sztmp );
				//체납금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_NPLIST, i, 4, sztmp );
			}
		}	
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 50, sztmp);
		if( Str_Len(sztmp) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_SELECTNONPAY), "0원");
		}
		else
		{
			Str_Chg(sztmp, STRCHG_INS_COMMA);
			Str_Cat(sztmp, "원");
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_SELECTNONPAY), sztmp);
		}
		
		ON_DRAW();
			
	Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return;	
	}
	
	/*=======================================================================================
	함수명 : ChkClear
	기  능 : 전체 체크박스 Clear
	Param  : 
	Return : 
	========================================================================================*/
	void ChkClear(void)
	{
		m_lNpChkFlag = 0;
		g_Sql_DirectExecute("UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '0'");
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Save_Row
	기  능 : 선택 로우 ChkBox Update
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Row(long row, long col)
	{
		char szReqym[10];
		char sztmp[20];
		char szSql[300];
	
		Mem_Set((byte*)szReqym ,0x00, sizeof(szReqym) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );

		Str_Cpy( sztmp, DlgTbl_GetStr( ID_NPLIST, row, col) );
		Str_Cpy( szReqym, DlgTbl_GetStr( ID_NPLIST, row, 1) );		//청구년월

		if(Str_Cmp( sztmp, CHKON) == 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '1' WHERE PARAM1 = '%s'", szReqym, 0, 0);
			g_Sql_DirectExecute( szSql );
		}
		else
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '0' WHERE PARAM1 = '%s'", szReqym, 0, 0);
			g_Sql_DirectExecute( szSql );
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : SetData
	기  능 : m_stNpSms 초기화
	Param  : 
	Return : 
	========================================================================================*/
	void SetData(void)
	{
		Mem_Set((byte*)&m_stNpSms, 0x00, sizeof(m_stNpSms));
		
		Str_Cpy(m_stNpSms.DDD, stNoPayObj.CP_DDD);
		Str_Cpy(m_stNpSms.EXN, stNoPayObj.CP_EXN);
		Str_Cpy(m_stNpSms.NUM, stNoPayObj.CP_NUM);
	}

	/*=======================================================================================
	함수명 : SaveData
	기  능 : m_stNpSms 구조체에 데이터를 세팅한다.
	Param  : 
	Return : 
	========================================================================================*/
	void SaveData(void)
	{
		char sztmp[300];
		char szSql[300];
		long i ;
		long lDate, lChgDate;
		
		Mem_Set((byte*)&m_stNpSms, 0x00, sizeof(m_stNpSms));
		
		// 전화번호
		Mem_Set((byte*)m_stNpSms.DDD, 0x00, sizeof(m_stNpSms.DDD));
		Str_Cpy( m_stNpSms.DDD ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PHONE_DDD) ) );
		
		Mem_Set((byte*)m_stNpSms.EXN, 0x00, sizeof(m_stNpSms.EXN));
		Str_Cpy( m_stNpSms.EXN ,EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_PHONE_EXN) ) );
		
		Mem_Set((byte*)m_stNpSms.NUM, 0x00, sizeof(m_stNpSms.NUM));
		Str_Cpy( m_stNpSms.NUM ,EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_PHONE_NUM) ) );
		
		//유형
		Mem_Set((byte*)m_stNpSms.GUIDETYPE, 0x00, sizeof(m_stNpSms.GUIDETYPE));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'A10421' AND ITEM_KNAME = '%s'", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GUIDE_TYPE)), 0, 0   );
		g_Sql_RetStr( sztmp, 30, m_stNpSms.GUIDETYPE );
		
		// 예정년
		Mem_Set((byte*)m_stNpSms.YEAR, 0x00, sizeof(m_stNpSms.YEAR));
		Str_Cpy( m_stNpSms.YEAR ,EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DUEDATE_YEAR) ) );
		
		// 예정월 
		Mem_Set((byte*)m_stNpSms.MONTH, 0x00, sizeof(m_stNpSms.MONTH));
		Str_Cpy( m_stNpSms.MONTH ,EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DUEDATE_MONTH) ) );
		
		// 예정일
		Mem_Set((byte*)m_stNpSms.DATE, 0x00, sizeof(m_stNpSms.DATE));
		Str_Cpy( m_stNpSms.DATE ,EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DUEDATE_DATE) ) );
		
		// 납부년월일( 예정년월일 -3 )
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, m_stNpSms.YEAR);
		Str_Cat(sztmp, m_stNpSms.MONTH);
		Str_Cat(sztmp, m_stNpSms.DATE);
		
		lDate = Str_AtoI( sztmp );
		lChgDate = Time_DateUpDown ( lDate, -3 ); 
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_ItoA(lChgDate, sztmp, 10);
		
		// 납부년
		Mem_Set((byte*)m_stNpSms.payYEAR, 0x00, sizeof(m_stNpSms.payYEAR));
		Mem_Cpy( (byte*)m_stNpSms.payYEAR, (byte*)sztmp, 4 );
		
		// 납부월
		Mem_Set((byte*)m_stNpSms.payMONTH, 0x00, sizeof(m_stNpSms.payMONTH));
		Mem_Cpy( (byte*)m_stNpSms.payMONTH, (byte*)sztmp+4, 2 );
		
		// 납부일
		Mem_Set((byte*)m_stNpSms.payDATE, 0x00, sizeof(m_stNpSms.payDATE));
		Mem_Cpy( (byte*)m_stNpSms.payDATE, (byte*)sztmp+6, 2 );
	}
	
	/*=======================================================================================
	함수명 : SetSmsMsg
	기  능 : 메세지 Setting
	Param  : val(msg 분류 값)
	Return : 
	========================================================================================*/
	void SetSmsMsg(char* val)
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
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 100, szAmt);
							
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
		Str_Cpy( m_szMsg[0], "▣안녕하십니까\n서울도시가스입니다." );
		Str_Cat( m_szMsg[0], "\n--------------" );
		Str_Cat( m_szMsg[0], "\n▣도로명주소 : " );
		Str_Cat( m_szMsg[0], stNoPayObj.NEW_ADDR_UNION );
		Str_Cat( m_szMsg[0], "\n--------------" );
		Str_Cat( m_szMsg[0], "\n▣고객님사용계약번호 (" );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Mem_Cpy( (byte*)szTmp, (byte*)stNoPayObj.USE_CONT_NUM , 5 );
		Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM+5 , 5 );
		Str_Cat(m_szMsg[0], szTmp);
		Str_Cat(m_szMsg[0], "-");
		Str_Cat(m_szMsg[0], szBuf);
		Str_Cat(m_szMsg[0], ")" );
		
		// 20190107 서명곤 대리 - 이력 전화번호 추가
		Str_Cpy( m_szDtlMsg, m_stNpSms.DDD );
		Str_Cat( m_szDtlMsg, "-" );
		Str_Cat( m_szDtlMsg, m_stNpSms.EXN );
		Str_Cat( m_szDtlMsg, "-" );
		Str_Cat( m_szDtlMsg, m_stNpSms.NUM );
		Str_Cat( m_szDtlMsg, "\n" );
		
		// 납부안내
		if( Str_Cmp(val, "C210") == 0 )
		{
			Str_Cat( m_szMsg[0], "\n--------------" );
			Str_Cat( m_szMsg[0], "\n▣귀 댁(업소)에서 사용하시는 도시가스\n사용요금이 미납되어 안내드립니다." );
			Str_Cat( m_szMsg[0], "\n---------------" );
  			
  			// 법적소송및기타 금액이 없는 경우
  			if( Str_Cmp(szEtc, "0") == 0 )
  			{
	  			Str_Cat( m_szMsg[0], "\n◎");
	  			
	  			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
	  			g_Sql_RetStr("SELECT SUBSTR(MIN(PARAM1),1,4) || '년' || SUBSTR(MIN(PARAM1),5,2) || '월' FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 100, szTmp);
	 			Str_Cat( m_szMsg[0], szTmp );
	 			Str_Cat( m_szMsg[0], " ~ " );
	 			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
	  			g_Sql_RetStr("SELECT SUBSTR(MAX(PARAM1),1,4) || '년' || SUBSTR(MAX(PARAM1),5,2) || '월' FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 100, szTmp);
	 			Str_Cat( m_szMsg[0], szTmp );
	 			Str_Cat( m_szMsg[0], "까지 미납금 " );
	 			Str_Cat( m_szDtlMsg, "미납금 " );
				Str_Cat( m_szMsg[0], szAmt );
				Str_Cat( m_szDtlMsg, szAmt );
				Str_Cat( m_szMsg[0], "원을 " );
				Str_Cat( m_szDtlMsg, "원을 " );
				Str_Cat( m_szMsg[0], m_stNpSms.YEAR );
				Str_Cat( m_szDtlMsg, m_stNpSms.YEAR );
				Str_Cat( m_szMsg[0], "년 " );
				Str_Cat( m_szDtlMsg, "년 " );
				Str_Cat( m_szMsg[0], m_stNpSms.MONTH);
				Str_Cat( m_szDtlMsg, m_stNpSms.MONTH);
				Str_Cat( m_szMsg[0], "월 " );
				Str_Cat( m_szDtlMsg, "월 " );
				Str_Cat( m_szMsg[0], m_stNpSms.DATE);
				Str_Cat( m_szDtlMsg, m_stNpSms.DATE);
				Str_Cat( m_szMsg[0], "일까지" );
				Str_Cat( m_szDtlMsg, "일까지" );
  			}
  			// 법적소송및기타 금액이 있는 경우
  			else
  			{
				Str_Cat( m_szMsg[0], "\n◎현재 미납금 ");
				Str_Cat( m_szDtlMsg, "미납금 ");
				Str_Cat( m_szMsg[0], szAllAmt );
				Str_Cat( m_szDtlMsg, szAllAmt );
				Str_Cat( m_szMsg[0], "원을 ");
				Str_Cat( m_szDtlMsg, "원을 ");
				Str_Cat( m_szMsg[0], m_stNpSms.YEAR );
				Str_Cat( m_szDtlMsg, m_stNpSms.YEAR );
				Str_Cat( m_szMsg[0], "년 " );
				Str_Cat( m_szDtlMsg, "년 " );
				Str_Cat( m_szMsg[0], m_stNpSms.MONTH);
				Str_Cat( m_szDtlMsg, m_stNpSms.MONTH);
				Str_Cat( m_szMsg[0], "월 " );
				Str_Cat( m_szDtlMsg, "월 " );
				Str_Cat( m_szMsg[0], m_stNpSms.DATE);
				Str_Cat( m_szDtlMsg, m_stNpSms.DATE);
				Str_Cat( m_szMsg[0], "일까지" );
				Str_Cat( m_szDtlMsg, "일까지" );
				Str_Cat( m_szMsg[0], "\n※상기금액은 법적소송 및 기타비용 " );
				Str_Cat( m_szDtlMsg, "\n※상기금액은 법적소송 및 기타비용 " );
				Str_Cat( m_szMsg[0],  szEtc);
				Str_Cat( m_szDtlMsg,  szEtc);
				Str_Cat( m_szMsg[0], "원이 포함된 금액입니다." );
				Str_Cat( m_szDtlMsg, "원이 포함된 금액입니다." );
  			}

			Str_Cat( m_szMsg[0], "\n입금계좌 및 고지서로 납부하여 주시기 바랍니다.");
			Str_Cat( m_szDtlMsg, "\n입금계좌 및 고지서로 납부하여 주시기 바랍니다.");
			Str_Cat( m_szMsg[0], "\n---------------");	
			Str_Cat( m_szMsg[0], "\n▣고객님 입금전용 계좌 번호");
			Str_Cat( m_szMsg[0], "\n◎입금계좌 납부금액 : ");
			Str_Cat( m_szMsg[0], szAmt );
			Str_Cat( m_szMsg[0], "원");
			
			g_Sql_RetInt( "SELECT COUNT(1) FROM RCV_TMP", &accountCnt );
	
			for( i = 0 ; i < accountCnt ; i++)
			{
				sql = NewSqLite();
		
				hdb = sql->Open(sql);
				
				if( hdb == NULL )
				{
					goto Finally;
				}
				
				hstmt = sql->CreateStatement(sql, "SELECT PARAM2 || ' : ' || SUBSTR(PARAM1,1,4) || '-' || SUBSTR(PARAM1,5,4) || '-' || SUBSTR(PARAM1,9,4) || '-' || SUBSTR(PARAM1,13, length(PARAM1)+1 - 13 ) AS ACCOUNT \
													 FROM RCV_TMP LIMIT ?,?");
										
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
					
					Str_Cat( m_szMsg[0], "\n▷" );
					
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					sql->GetValue(sql, idx++, 'U', (long*)szTmp ,100, DECRYPT);
					Str_Cat( m_szMsg[0], szTmp);
	
				};		
	Finally:
				DelSqLite(sql);
		
			}
			
			Str_Cat( m_szMsg[1], "\n--------------" );
			Str_Cat( m_szMsg[1], "\n▣도시가스 요금 고지서로 미납요금을\n납부하신 경우 은행으로부터 납부사실이\n당사에 통보되기까지일정기간(3~7일)\n소요되므로 미납 안내문자가 발송될수 있으니\n양해하여 주시기 바랍니다." );
			Str_Cat( m_szMsg[1], "\n--------------" );
			Str_Cat( m_szMsg[1], "\n▣요금상세내역 및 고객정보가 상이할 경우 자세한 사항은\n서울도시가스(02-810-8021)연락 주시면 감사하겠습니다." );
			Str_Cat( m_szMsg[1], "\n--------------" );
			Str_Cat( m_szMsg[1], "\n■ 서울도시가스 모바일 가스앱을 이용하시면 요금청구서 및 납부서비스 등 더욱 유익하고 다양한 서비스를 편리하게 이용하실 수 있습니다." ); 
			Str_Cat( m_szMsg[1], "\n▣ 개선업무" );
			Str_Cat( m_szMsg[1], "\n  ▷실시간 요금조회 및 납부(계좌이체,신용카드결제)" );
			Str_Cat( m_szMsg[1], "\n  ▷자동이체/검침/경감신청" );
			Str_Cat( m_szMsg[1], "\n  ▷이사/점검 방문예약" ); 
			Str_Cat( m_szMsg[1], "\n  ▷24시간 민원상담 챗봇" ); 
			Str_Cat( m_szMsg[1], "\n  ▷가스 안전 신고" ); 
			Str_Cat( m_szMsg[2], "\n▣ 설치방법" ); 
			Str_Cat( m_szMsg[2], "\n  ▷http://bit.ly/3adhNwn" ); 
			Str_Cat( m_szMsg[2], "\n  ▷앱스토어(아이폰, 안드로이드)에서［가스앱］설치" );
		}
		
		// 공급중지예고
		else if ( Str_Cmp(val, "C220") == 0  )
		{
			Str_Cat( m_szMsg[0], "\n--------------" );
			Str_Cat( m_szMsg[0], "\n▣귀 댁(업소)에서 사용하시는 도시가스\n사용요금이 미납되어 공급중지 예고안내드립니다." );
			Str_Cat( m_szMsg[0], "\n---------------" );
  			
  			// 20190107 서명곤 대리 - 이력 전화번호 추가
			Str_Cpy( m_szDtlMsg, m_stNpSms.DDD );
			Str_Cat( m_szDtlMsg, "-" );
			Str_Cat( m_szDtlMsg, m_stNpSms.EXN );
			Str_Cat( m_szDtlMsg, "-" );
			Str_Cat( m_szDtlMsg, m_stNpSms.NUM );
			Str_Cat( m_szDtlMsg, "\n" );
			
  			Str_Cat( m_szMsg[0], "\n공급중지 예정일자 ");
  			Str_Cat( m_szDtlMsg, "공급중지 예정일자 ");
			Str_Cat( m_szMsg[0], m_stNpSms.YEAR );
			Str_Cat( m_szDtlMsg, m_stNpSms.YEAR );
			Str_Cat( m_szMsg[0], "년 " );
			Str_Cat( m_szDtlMsg, "년 " );
			Str_Cat( m_szMsg[0], m_stNpSms.MONTH);
			Str_Cat( m_szDtlMsg, m_stNpSms.MONTH);
			Str_Cat( m_szMsg[0], "월 " );
			Str_Cat( m_szDtlMsg, "월 " );
			Str_Cat( m_szMsg[0], m_stNpSms.DATE);
			Str_Cat( m_szDtlMsg, m_stNpSms.DATE);
			Str_Cat( m_szMsg[0], "일" );
			Str_Cat( m_szDtlMsg, "일" );
			
			// 법적소송및기타 금액이 없는 경우
  			if( Str_Cmp(szEtc, "0") == 0 )
  			{
	  			Str_Cat( m_szMsg[0], "\n◎");
	  			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
	  			g_Sql_RetStr("SELECT SUBSTR(MIN(PARAM1),1,4) || '년' || SUBSTR(MIN(PARAM1),5,2) || '월' FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 100, szTmp);
	 			Str_Cat( m_szMsg[0], szTmp );
	 			Str_Cat( m_szMsg[0], " ~ " );
	 			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
	  			g_Sql_RetStr("SELECT SUBSTR(MAX(PARAM1),1,4) || '년' || SUBSTR(MAX(PARAM1),5,2) || '월' FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 100, szTmp);
	 			Str_Cat( m_szMsg[0], szTmp );
	 			Str_Cat( m_szMsg[0], "까지 미납금 " );
				Str_Cat( m_szMsg[0], szAmt );
				Str_Cat( m_szMsg[0], "원을 " );
				Str_Cat( m_szMsg[0], m_stNpSms.payYEAR );
				Str_Cat( m_szMsg[0], "년 " );
				Str_Cat( m_szMsg[0], m_stNpSms.payMONTH);
				Str_Cat( m_szMsg[0], "월 " );
				Str_Cat( m_szMsg[0], m_stNpSms.payDATE);
				Str_Cat( m_szMsg[0], "일까지" );
  			}
  			// 법적소송및기타 금액이 있는 경우
  			else
  			{
				Str_Cat( m_szMsg[0], "\n◎현재 미납금 ");
				Str_Cat( m_szMsg[0], szAllAmt );
				Str_Cat( m_szMsg[0], "원을 ");
				Str_Cat( m_szMsg[0], m_stNpSms.payYEAR );
				Str_Cat( m_szMsg[0], "년 " );
				Str_Cat( m_szMsg[0], m_stNpSms.payMONTH);
				Str_Cat( m_szMsg[0], "월 " );
				Str_Cat( m_szMsg[0], m_stNpSms.payDATE);
				Str_Cat( m_szMsg[0], "일까지" );
				Str_Cat( m_szMsg[0], "\n※상기금액은 법적소송 및 기타비용 " );
				Str_Cat( m_szMsg[0],  szEtc);
				Str_Cat( m_szMsg[0], "원이 포함된 금액입니다." );
  			}
  			
  			Str_Cat( m_szMsg[0], "\n납부하지 않을경우 " );
			Str_Cat( m_szMsg[0], m_stNpSms.YEAR );
			Str_Cat( m_szMsg[0], "년 " );
			Str_Cat( m_szMsg[0], m_stNpSms.MONTH);
			Str_Cat( m_szMsg[0], "월 " );
			Str_Cat( m_szMsg[0], m_stNpSms.DATE);
			Str_Cat( m_szMsg[0], "일" );
			Str_Cat( m_szMsg[0], "\n도시가스 공급이 중단될 예정입니다." );
			Str_Cat( m_szMsg[0], "\n--------------" );
			Str_Cat( m_szMsg[0], "\n미납요금을 납부하지 않을경우 관련규정에\n(서울-도시가스 공급규정 제 28조,\n경기-도시가스 공급규정 제 32조)\n의거 도시가스 공급이 중단되오니 양지하여 주시기 바랍니다." );
			Str_Cat( m_szMsg[0], "\n---------------");	
			Str_Cat( m_szMsg[1], "\n▣고객님 입금전용 계좌 번호");
			Str_Cat( m_szMsg[1], "\n◎입금계좌 납부금액 : ");
			Str_Cat( m_szMsg[1], szAmt );
			Str_Cat( m_szMsg[1], "원");
			
			g_Sql_RetInt( "SELECT COUNT(1) FROM RCV_TMP", &accountCnt );
	
			for( i = 0 ; i < accountCnt ; i++)
			{
				sql = NewSqLite();
		
				hdb = sql->Open(sql);
				
				if( hdb == NULL )
				{
					goto Finally1;
				}
				
				hstmt = sql->CreateStatement(sql, "SELECT PARAM2 || ' : ' || SUBSTR(PARAM1,1,4) || '-' || SUBSTR(PARAM1,5,4) || '-' || SUBSTR(PARAM1,9,4) || '-' || SUBSTR(PARAM1,13, length(PARAM1)+1 - 13 ) AS ACCOUNT \
													 FROM RCV_TMP LIMIT ?,?");
										
				if( hstmt == NULL )
				{
					PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally1;
				}
				
				idx = 0;
				sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
				row = 1;
				sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
						
				if(sql->Execute(sql) == FALSE)
				{
					PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally1;
				}
				
				while( sql->Next(sql) )
				{
					idx = 0;
					
					Str_Cat( m_szMsg[1], "\n▷" );
					
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					sql->GetValue(sql, idx++, 'U', (long*)szTmp ,100, DECRYPT);
					Str_Cat( m_szMsg[1], szTmp);
	
				};		
	Finally1:
				DelSqLite(sql);
			}
			
			Str_Cat( m_szMsg[1], "\n--------------" );
			Str_Cat( m_szMsg[1], "\n▣도시가스 요금 고지서로 미납요금을\n납부하신 경우 은행으로부터 납부사실이\n당사에 통보되기까지일정기간(3~7일)\n소요되므로 미납 안내문자가 발송될수 있으니\n양해하여 주시기 바랍니다." );
			Str_Cat( m_szMsg[1], "\n--------------" );
			Str_Cat( m_szMsg[1], "\n▣요금상세내역 및 고객정보가 상이할 경우 자세한 사항은\n서울도시가스(02-810-8021)연락 주시면 감사하겠습니다." );
			Str_Cat( m_szMsg[1], "\n--------------" );
			Str_Cat( m_szMsg[2], "\n■ 서울도시가스 모바일 가스앱을 이용하시면 요금청구서 및 납부서비스 등 더욱 유익하고 다양한 서비스를 편리하게 이용하실 수 있습니다." ); 
			Str_Cat( m_szMsg[2], "\n▣ 개선업무" );
			Str_Cat( m_szMsg[2], "\n  ▷실시간 요금조회 및 납부(계좌이체,신용카드결제)" );
			Str_Cat( m_szMsg[2], "\n  ▷자동이체/검침/경감신청" );
			Str_Cat( m_szMsg[2], "\n  ▷이사/점검 방문예약" ); 
			Str_Cat( m_szMsg[2], "\n  ▷24시간 민원상담 챗봇" ); 
			Str_Cat( m_szMsg[2], "\n  ▷가스 안전 신고" ); 
			Str_Cat( m_szMsg[2], "\n▣ 설치방법" ); 
			Str_Cat( m_szMsg[2], "\n  ▷http://bit.ly/3adhNwn" ); 
			Str_Cat( m_szMsg[2], "\n  ▷앱스토어(아이폰, 안드로이드)에서［가스앱］설치" );
		}
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
		
		// 날짜 체크
		if( Str_Len( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DUEDATE_YEAR) ) ) == 0 && Str_Len( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DUEDATE_MONTH) ) ) == 0 && Str_Len( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DUEDATE_DATE) ) ) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "예정일을 작성/선택해주세요.");
			return FALSE;
		}
		
		// 선택미납액
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 100, sztmp);

		if( Str_Cmp(sztmp, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "미납액이 0원 입니다.");
			return FALSE;
		}
		
		// 전화번호
		if(!g_CheckPhoneNumberFormat( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)) ) )
		{
			MessageBoxEx (CONFIRM_OK, "전화번호 형식이 잘못되었습니다.");
			return FALSE;
		}

		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : Snd_NopaySms
	기  능 : FR84101 호출
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_NopaySms(void)
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
		
		// 구조체 세팅
		SaveData();
		// 문자내용 세팅
		SetSmsMsg(m_stNpSms.GUIDETYPE);
		
		Add_NopaySms(g_pjcomm);
		Add_NopaySmsHist(g_pjcomm);
		Add_NopayMan(g_pjcomm);
		Add_NopayDtl(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		g_SeverConnection();
		
		callBackfunc = Rcv_NopaySms; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR84101_IN",  "FR84101" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Rcv_NopaySms
	기  능 : FR84101 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_NopaySms(void)
	{
		char szSql[200];
	
		g_Sock_Close();

		if( g_Chk_Json(84101) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "SMS 발송을 완료하였습니다.");
			Card_Move("C6202_VISIT");
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
		}

		return 0;
	}
	
	/*=======================================================================================
	함수명 : Add_NopaySms
	기  능 : A1AT_SMS.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_NopaySms(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[1000];
		
		char sztmp[100];
		
		char szSms[3000];
		char szSms1[1000];
		char szSms2[1000];
		char szSms3[1000];
		
		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
		
		JSON_AddArrayItem(js);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp, m_stNpSms.GUIDETYPE );
		JSON_SetArrayItem(js, 'C',  "corres_flag"        , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "send_sts"  	     , "1");
		JSON_SetArrayItem(js, 'C',  "send_tel_ddd"  	 , "02");
		JSON_SetArrayItem(js, 'C',  "send_tel_exn"       , "810");
		JSON_SetArrayItem(js, 'C',  "send_tel_num"       , "8021");
		
		JSON_SetArrayItem(js, 'C',  "receiver_tel_ddd"   , m_stNpSms.DDD);
		JSON_SetArrayItem(js, 'C',  "receiver_tel_exn"   , m_stNpSms.EXN);
		JSON_SetArrayItem(js, 'C',  "receiver_tel_num"   , m_stNpSms.NUM);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp, stNoPayObj.CUST_NM );
		JSON_SetArrayItem(js, 'C',  "receiver_nm"        , sztmp);
		
		Mem_Set((byte*)szSms, 0x00, sizeof(szSms));
		Mem_Set((byte*)szSms1, 0x00, sizeof(szSms1));	
		Mem_Set((byte*)szSms2, 0x00, sizeof(szSms2));	
		Mem_Set((byte*)szSms3, 0x00, sizeof(szSms3));
		SQL_ConvUcStr( szSms1, m_szMsg[0] );
		SQL_ConvUcStr( szSms2, m_szMsg[1] );
		SQL_ConvUcStr( szSms3, m_szMsg[2] );
		Str_Cpy(szSms, szSms1);
		Str_Cat(szSms, szSms2);
		Str_Cat(szSms, szSms3);
		
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
	함수명 : Add_NopaySmsHist
	기  능 : C5BT_CIVIL_SERV_SMS_HIST.insert, C2FT_SMS_SEND.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_NopaySmsHist(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[1000];
		char sztmp[100];
		char szSms[3000];
		char szSms1[1000];
		char szSms2[1000];
		char szSms3[1000];
		
		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
	
		JSON_AddArrayItem(js);

		JSON_SetArrayItem(js, 'C',  "use_cont_num"   		, stNoPayObj.USE_CONT_NUM);    
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp, m_stNpSms.GUIDETYPE );
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
		JSON_SetArrayItem(js, 'C',  "receiver_tel_ddd"      , m_stNpSms.DDD);
		JSON_SetArrayItem(js, 'C',  "receiver_tel_exn"      , m_stNpSms.EXN);
		JSON_SetArrayItem(js, 'C',  "receiver_tel_num"      , m_stNpSms.NUM);
		JSON_SetArrayItem(js, 'C',  "bnk_cd"                , "");
		JSON_SetArrayItem(js, 'C',  "account_num"           , "");
		JSON_SetArrayItem(js, 'C',  "depositor_nm"          , "");
		
		// 납부금액
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 100, sztmp);
		JSON_SetArrayItem(js, 'C',  "guide_amt"             , sztmp);

	
		if( Str_Cmp(m_stNpSms.GUIDETYPE, "C210") == 0 )
		{
			JSON_SetArrayItem(js, 'C',  "act_guide_ymd"         , "");
		}
		else if( Str_Cmp(m_stNpSms.GUIDETYPE, "C220") == 0 )
		{
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cpy( sztmp, m_stNpSms.YEAR );
			Str_Cat( sztmp, m_stNpSms.MONTH);
			Str_Cat( sztmp, m_stNpSms.DATE);
			JSON_SetArrayItem(js, 'C',  "act_guide_ymd"         , sztmp);
		}
		
		Mem_Set((byte*)szSms, 0x00, sizeof(szSms));
		Mem_Set((byte*)szSms1, 0x00, sizeof(szSms1));	
		Mem_Set((byte*)szSms2, 0x00, sizeof(szSms2));	
		Mem_Set((byte*)szSms3, 0x00, sizeof(szSms3));
		SQL_ConvUcStr( szSms1, m_szMsg[0] );
		SQL_ConvUcStr( szSms2, m_szMsg[1] );
		SQL_ConvUcStr( szSms3, m_szMsg[2] );
		Str_Cpy(szSms, szSms1);
		Str_Cat(szSms, szSms2);
		Str_Cat(szSms, szSms3);
		JSON_SetArrayItem(js, 'C',  "sms_desc"              , szSms);
		
		JSON_SetArrayItem(js, 'C',  "guide_job_sts"         , "30");
		JSON_SetArrayItem(js, 'C',  "nonpay_center_cd"      , stUserinfo.szcenter_cd);
		JSON_SetArrayItem(js, 'C',  "rmk"                   , "");
		JSON_SetArrayItem(js, 'C',  "civil_serv_receive_num", "");
		JSON_SetArrayItem(js, 'C',  "treat_seq"             , "");
		JSON_SetArrayItem(js, 'C',  "send_plc_flag"         , "60");
		JSON_SetArrayItem(js, 'C',  "class_cd"              , "");
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_Cpy( sztmp, m_stNpSms.payYEAR );
		Str_Cat( sztmp, m_stNpSms.payMONTH);
		Str_Cat( sztmp, m_stNpSms.payDATE);
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
	함수명 : Add_NopayMan
	기  능 : C2FT_NOPAY_MAN.merge, C2FT_NOPAY_MAN.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/
	long Add_NopayMan(handle pj)
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
		
		if( Str_Cmp(m_stNpSms.GUIDETYPE, "C210") == 0 )
		{
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_ItoA( Time_GetDate(), sztmp, 10);	
			JSON_SetArrayItem(js, 'C',  "demand_ymd_sms", sztmp);
			
			
		}
		else if( Str_Cmp(m_stNpSms.GUIDETYPE, "C220") == 0 )
		{
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_ItoA( Time_GetDate(), sztmp, 10);	
			JSON_SetArrayItem(js, 'C',  "cut_guide_ymd" , sztmp );
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cpy( sztmp, m_stNpSms.YEAR );
			Str_Cat( sztmp, m_stNpSms.MONTH);
			Str_Cat( sztmp, m_stNpSms.DATE);
			JSON_SetArrayItem(js, 'C',  "cut_plan_ymd"  , sztmp );	
		}

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
	함수명 : Add_NopayDtl
	기  능 : C2FT_NOPAY_DTL.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_NopayDtl(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[100];
		
		char sztmp[100];
		char szSms1[2000];

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
		
		Mem_Set((byte*)szSms1, 0x00, sizeof(szSms1));
		SQL_ConvUcStr( szSms1, m_szDtlMsg );
		JSON_SetArrayItem(js, 'C',  "active_rslt_desc"    , szSms1);
		
		JSON_SetArrayItem(js, 'C',  "auction_act_yn"      , "");
		JSON_SetArrayItem(js, 'C',  "active_guide_ymd"    , "");
		JSON_SetArrayItem(js, 'C',  "pay_plan_ymd"        , "");
		JSON_SetArrayItem(js, 'C',  "cust_relat_cd"       , "");
		JSON_SetArrayItem(js, 'C',  "cust_nm"             , "");
		
		if( Str_Cmp(m_stNpSms.GUIDETYPE, "C210") == 0 )
		{
			JSON_SetArrayItem(js, 'C',  "visit_why_cd"        , "10");
		}
		else if( Str_Cmp(m_stNpSms.GUIDETYPE, "C220") == 0 )
		{
			JSON_SetArrayItem(js, 'C',  "visit_why_cd"        , "20");
		}
		
		JSON_SetArrayItem(js, 'C',  "nonpay_center_cd"    , stUserinfo.szcenter_cd);
		JSON_SetArrayItem(js, 'C',  "taker_nm"            , "");
		JSON_SetArrayItem(js, 'C',  "rmk"                 , "");
		JSON_SetArrayItem(js, 'C',  "pay_amt"             , "");
		JSON_SetArrayItem(js, 'C',  "receipt_seq"         , "");
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_Cpy( sztmp, m_stNpSms.YEAR );
		Str_Cat( sztmp, m_stNpSms.MONTH);
		Str_Cat( sztmp, m_stNpSms.DATE);
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
