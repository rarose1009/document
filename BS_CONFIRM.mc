/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : BS_CONFIRM
	Card Desc : 특정점검
	Card Hist :
----------------------------------------------------------------------------------*/
card BS_CONFIRM
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
//	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		// 화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		// 홈
		DEF_BUTTON_ID ( BID_MENU )		// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )	// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	// 공통업무
		DEF_BUTTON_ID ( BID_PREV )		// 이전
		DEF_BUTTON_ID ( BID_EXIT )		// 종료
		
		// 메인화면
		DEF_BUTTON_ID ( BID_ADDR )		// 지번 주소
		DEF_BUTTON_ID ( BID_JEONBAN )	// 전반기
		DEF_BUTTON_ID ( BID_PREVPG )	// ◀
		DEF_BUTTON_ID ( BID_NEXTPG )	// ▶
		DEF_BUTTON_ID ( BID_BS )		// 점검시작
		DEF_BUTTON_ID ( BID_MEMO )		// 메모
		DEF_BUTTON_ID ( BID_UP )		// 이전페이지
		DEF_BUTTON_ID ( BID_DOWN )		// 다음페이지
		DEF_BUTTON_ID ( BID_MANAGETEL ) // 관리자번호
		DEF_BUTTON_ID ( BID_PHONETEL )	// 휴대폰번호
		DEF_BUTTON_ID ( BID_TEL )	    // 전화전환
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		// 메인
		DEF_OBJECT_ID ( ICON_TITLE )	// 타이틀
		DEF_OBJECT_ID ( TXT_TITLE )		// 타이틀
		DEF_OBJECT_ID ( TXT_DATA1 )		// page
		DEF_OBJECT_ID ( TXT_DATA29 )	// page
		DEF_OBJECT_ID ( TXT_BSNAME )	// 특정명
		DEF_OBJECT_ID ( TXT_DATA2 )		// 특정명 
		DEF_OBJECT_ID ( TXT_BSNUM )		// 특정번호
		DEF_OBJECT_ID ( TXT_DATA3 )		// 특정번호
		DEF_OBJECT_ID ( TXT_DATA4 )		// 중간압
		DEF_OBJECT_ID ( TXT_DATA5 )		// 주소
		DEF_OBJECT_ID ( TXT_SAFEMNG )	// 안전,대표자
		DEF_OBJECT_ID ( TXT_CMPLTCHK )	// 완성검사
		DEF_OBJECT_ID ( TXT_SCHEDULE)	// 예정량
		DEF_OBJECT_ID ( TXT_HYUNBAN )	// 현반기
		DEF_OBJECT_ID ( TXT_DATA7 )		// 안전 전화번호
		DEF_OBJECT_ID ( TXT_DATA8 )		// 대표 전화번호
		DEF_OBJECT_ID ( TXT_DATA11 )	// 완성검사
		DEF_OBJECT_ID ( TXT_DATA12 )	// 예정량
		DEF_OBJECT_ID ( TXT_DATA13 )	// 전반기1
		DEF_OBJECT_ID ( TXT_DATA14 )	// 전반기2
		DEF_OBJECT_ID ( TXT_DATA15 )	// 전반기3
		DEF_OBJECT_ID ( TXT_DATA16 )	// 현반기1
		DEF_OBJECT_ID ( TXT_DATA17 )	// 현반기2
		DEF_OBJECT_ID ( TXT_DATA18 )	// 현반기3
		DEF_OBJECT_ID ( TXT_DATA24 )	// table page

		// 리스트
		DEF_OBJECT_ID ( ID_TBLLIST )	// 정압기/조정기 리스트
		
		// 라인
		DEF_OBJECT_ID ( LINE_DATA1 )	// 라인1
		DEF_OBJECT_ID ( LINE_DATA2 )	// 라인2
		DEF_OBJECT_ID ( LINE_DATA3 )	// 라인2

	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	  1

	//---------------------------------------------------------------------------------------
	// Table정의에 관련된 내용들
	//---------------------------------------------------------------------------------------
	#define		ROW 	    2						// table의 행개수
	#define		COL 	    12						// table의 열개수
	#define		GRID_H		(CHT+10)				// table 행 높이
	#define		GRID_H_P	(CHT+15)				// table 행 높이
	#define		GRID_CLR	TRANSPARENT   			// table 클리어 color
	#define		MAXCHAR		51 			    		// table에 들어갈수 있는 최대 char 길이
	#define		GRID_X		STARTX 			    	// table 시작x좌표
	#define		GRID_Y		STARTY+485  	    	// table 시작y좌표
	#define		GRID_Y_P	STARTY+465  	    	// table 시작y좌표
	char		m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	long 		m_lpage = 0;
	long 		m_lTotpage;
	Column m_stGridTitle[] = 
	{
		{"구"            , CWD*3    , EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"제작사"        , CWD*12   , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"모델명"        , CWD*12+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"분해일"        , CWD*12   , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"점검시행번호"  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"기기구분"      , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"제작사구분"    , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"제작사코드"    , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"모델코드"      , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"분해점검사"    , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"분해점검사코드", 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"송신여부"      , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
	};	
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	char m_szCnt_index[10];
	char m_szLst_index[10];
	char m_szManageTel[20];
	char m_szRepreTel[20];
	
	long m_lSelIndex = -1;
	long m_ltotcnt;
	long m_bFirst;
	long m_lPrev;
	long m_lIdxFlag = 0;
	long m_lTelFalg = 0; // 0 = 핸드폰번호, 1 = 전화번호
	
	//GOVINFO stGovinfo2;
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetStyle(void);
	void SetStruct(void);
	void SetData(void);
	void SetDataNogood(void);	// 개선권고 정보(nogood + nogood_detail)
	void SetClickData(void);
	void REDRAW(void);
	void PRESSCHG_DRAW(void);
	void Prev_Bs(void);
	void Next_Bs(void);
	bool CHECK(void);			// 대상의 점검결과 및 입력사항 체크
	bool Save_PRESSCHG(void);
	void SetBtnImg(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void);
	void SetComboIdx(void);
	void Clear_Flag(void);
	bool Compare_Data(void);
	void Call_Tel(long nButtonID);
	
	//---------------------------------------------------------------------------------------
	// Global Button
	//---------------------------------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] =
	{
		SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
	    SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
		SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0 ),
		SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	 
	//---------------------------------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "점검 등록"),					// 타이틀
		
		DLG_TEXT(  STARTX,      STARTY  +65, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, m_szCnt_index),		// PAGE
		DLG_TEXT(  STARTX +240, STARTY  +65, 760,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""), 				// 우선점검
	
		DLG_TEXT(  STARTX,      STARTY +115, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSNAME, "특정명"), 		// 특정명
		DLG_TEXT(  STARTX +240, STARTY +115, 760,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), 		 		// 특정명 TXT
		
		DLG_TEXT(  STARTX,      STARTY +165, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSNUM, "특정번호"), 		// 특정번호
		DLG_TEXT(  STARTX +240, STARTY +165, 480,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 				// 특정번호 TXT
		DLG_TEXT(  STARTX +720, STARTY +165, 280,  50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "중간압"), 		// 중간압
		
		DLG_BUTTON(STARTX,      STARTY +215, 240, 110, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_TEXT(  STARTX +240, STARTY +215, 760, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 				// 주소 TXT1
		
		DLG_TEXT(  STARTX,      STARTY +325, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SAFEMNG, "안전/대표"), 	// 안전,대표
		DLG_TEXT(  STARTX +240, STARTY +325, 380,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 				// 안전,대표 TXT1
		DLG_TEXT(  STARTX +620, STARTY +325, 380,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 				// 안전,대표 TXT2
		
		DLG_BUTTON(STARTX     , STARTY +375, 240,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TEL, ""),
		DLG_BUTTON(STARTX +240, STARTY +375, 380,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MANAGETEL, ""),
		DLG_BUTTON(STARTX +620, STARTY +375, 380,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHONETEL, ""),
		
		DLG_LINE ( STARTX,      STARTY +429, 1000, STARTY+429, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT(  STARTX,      STARTY +434, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPLTCHK, "완성검사"), 	// 완성검사
		DLG_TEXT(  STARTX +240, STARTY +434, 300,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""), 				// 완성검사 TXT
		DLG_TEXT(  STARTX +540, STARTY +434, 180,  50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCHEDULE, "예정량"), 		// 예정량
		DLG_TEXT(  STARTX +720, STARTY +434, 280,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""), 				// 예정량 TXT
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(  STARTX,      STARTY +635, 377,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, m_szLst_index), 	// TABLE PAGE
		DLG_BUTTON(STARTX +377, STARTY +635, 320,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX +697, STARTY +635, 303,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),	
		
		DLG_LINE ( STARTX,      STARTY +689, 1000, STARTY+689, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_BUTTON(STARTX,      STARTY +693, 240,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_JEONBAN, "전반기"),
		DLG_TEXT(  STARTX +240, STARTY +693, 295,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""), 				// 전반기 TXT
		DLG_TEXT(  STARTX +535, STARTY +693, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""), 				// 전반기 TXT2
		DLG_TEXT(  STARTX +775, STARTY +693, 225,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""), 				// 전반기 TXT3
		
		DLG_TEXT(  STARTX,      STARTY +743, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HYUNBAN, "현반기"), 		// 현반기
		DLG_TEXT(  STARTX +240, STARTY +743, 295,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""), 				// 현반기 TXT1
		DLG_TEXT(  STARTX +535, STARTY +743, 240,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""), 				// 현반기 TXT2
		DLG_TEXT(  STARTX +775, STARTY +743, 225,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""), 				// 현반기 TXT3
		
		DLG_LINE ( STARTX,      STARTY +797, 1000, STARTY+797, DARKSLATEBLUE, 10, LINE_DATA3),
		
		DLG_BUTTON(STARTX,      STARTY +802, 250,  97, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "◀"),
		DLG_BUTTON(STARTX +250, STARTY +802, 250,  97, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "▶"),
		DLG_BUTTON(STARTX +500, STARTY +802, 250,  97, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BS, "점검시작"),
		DLG_BUTTON(STARTX +750, STARTY +802, 250,  97, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "메모"),
	};

	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
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
		m_bFirst = bFirst;
	
		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				
				if( g_lSCMoveFlag == 1 )
				{
					g_lSCMoveFlag = 0;
					m_lIdxFlag = 1;
				}
				
				SetData();
				SetDataNogood();
				SetStyle();
				REDRAW();
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		long d,k;
		char szDate[20];
		char szToday[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szMsg[150];
		long cnt;
		char szSql[300];
		
		switch(ID)
		{
			/********************************/
			/* 공통 버튼                    */
			/********************************/				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 || g_nWorkFlag == 306  )
					{
						SetComboIdx();
					}
					else
					{
						Set_Index();
					}
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "특정점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 || g_nWorkFlag == 306  )
					{
						SetComboIdx();
					}
					else
					{
						Set_Index();
					}
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
				if( ( Str_Cmp(stBs.PREUSE_CHK_WHY, "10") == 0 || Str_Cmp(stBs.PREUSE_CHK_WHY, "30") == 0 ) && g_nWorkFlag == 304 )
				{
					Card_Move("BS_FRSTLST");
				}
				else
				{
					Set_Index();
					if( g_nWorkFlag == 305 || g_nWorkFlag == 306 )
					{
						Card_Move("BS_FRSTLST");
					}
					else
					{
						Card_Move("BS_BDLST");
					}
				}
				
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/********************************/
			/* 메인 버튼                    */
			/********************************/	
			case BID_ADDR:
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				REDRAW();
				break;
			
			case BID_MANAGETEL:
			case BID_PHONETEL:
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				if( ID == BID_PHONETEL )
				{
					SPRINT(szMsg, "전화하시겠습니까?\n(TEL : %s)", m_szRepreTel,0,0);	
				}
				else
				{
					SPRINT(szMsg, "전화하시겠습니까?\n(TEL : %s)", m_szManageTel,0,0);
				}
				
				if( MessageBoxEx(CONFIRM_YESNO, szMsg) == MB_OK)
				{
					Call_Tel(ID);
				}
				break;
				
			case BID_PREVPG:
				Prev_Bs();
				break;
				
			case BID_NEXTPG:
				Next_Bs();
				break;
				
			case BID_UP:
				m_lpage--;
				
				if(m_lpage < 0)
				{
					m_lpage = 0;
					REDRAW();
					return;
				}
				
				m_lSelIndex = 0;
				REDRAW();
				break;	
						
			case BID_DOWN:
				m_lpage++ ;
				
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					
					REDRAW();
					break;
				}
				
				m_lSelIndex = 0;
				REDRAW();
				break;	
					
			case BID_JEONBAN:
				if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 || g_nWorkFlag == 306 )
				{
					SetComboIdx();
				}
				else
				{
					Set_Index();
				}
				
				g_lSCMoveFlag = 1;
				Card_Move("BS_PRVRSKCHK");
				break;	
						
			case BID_BS:
				if( ( Str_Cmp(stBs.PREUSE_CHK_WHY, "10") == 0 || Str_Cmp(stBs.PREUSE_CHK_WHY, "30") == 0 )
				 && ( Str_Cmp(stBs.END_YN, "Y") != 0 && Str_Cmp(stBs.END_YN, "S") != 0 ) )
				{
					Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
					SPRINT(szSql, " SELECT COUNT(1) FROM SPECIAL_NOGOOD WHERE CHK_EXEC_NUM = '%s' ", stBs.CHK_EXEC_NUM, 0, 0 );
					g_Sql_RetInt( szSql, &cnt );
					
					if( cnt > 0 )
					{
						MessageBoxEx (CONFIRM_OK, "우선점검 대상입니다.\n개선권고관리를 먼저 진행해주세요.");
						return;
					}
				}
				
				if( g_nWorkFlag == 301 || g_nWorkFlag == 302  || g_nWorkFlag == 306  )
				{
					SetComboIdx();
				}
				else
				{
					Set_Index();
				}
				
				// 점검시작시간 셋팅
				g_Str_TimeType( stBs.CHK_TIME_FROM , Time_GetTime());
					
				if( CHECK() )
				{	
					g_lMoveFlag = 0;
					g_lGovFlag = 0;
					Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
					Card_Move("BS_START");
				}
				break;
				
			case BID_MEMO:
				if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 || g_nWorkFlag == 306  )
				{
					SetComboIdx();
				}
				else
				{
					Set_Index();
				}
				
				g_nMemoFlag = 4;
				g_lSCMoveFlag = 1;
				Card_Move("CM_MEMO");
				break;
				
			case BID_TEL:
				if( m_lTelFalg == 0 )
				{
					m_lTelFalg = 1;
					REDRAW();
				}
				else
				{
					m_lTelFalg = 0;
					REDRAW();
				}
				
				break;
		}
	}		

	/*=======================================================================================
	함수명 : OnSelect
	기  능 : 콤보박스
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long i;
		long index = -1;
		char sztmp[51];
		char szMaker_Num[6];
		char szSql[100];
		long lCnt;

	
		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				if( m_lSelIndex == index-1 )
				{
					g_lGovInflowPath = 0;
					//20220216 점검시작시간 생성
					g_Str_TimeType( stBs.CHK_TIME_FROM , Time_GetTime());
					if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 )
					{
						Card_Move("BS_DISJOINTCHK");
					}
					else if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 )
					{
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
						g_Sql_RetInt( szSql, &lCnt );
						if(Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0 )
						{
							if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
							{
								Card_Move("bs_filter_clean");
							}
							else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
							{
								Card_Move("bs_filter_clean");
							}
						}
						
					}
					
					return;
				}
				else
				{
					if(Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "정") == 0 )
					{
						Str_Cpy(stGovinfo2.GOV_REGTR_FLAG, "10");
					}
					else
					{
						Str_Cpy(stGovinfo2.GOV_REGTR_FLAG, "20");
					}
					
					Str_Cpy(stGovinfo2.GOV_REGTR_NUM, DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					
					m_lSelIndex = index-1;
					g_nActRow = m_lpage*ROW + m_lSelIndex;
					
					SetClickData();
				}
			}
		}
	}
	
	//---------------------------------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : 버튼 이미지
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
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
	
	/*=======================================================================================
	함수명 : SetStyle
	기  능 : 스타일
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSNAME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SAFEMNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMPLTCHK), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SCHEDULE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HYUNBAN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA5), TRUE, 2, EDITSEP_NONE );
	}
	
	/*=======================================================================================
	함수명 : Prev_Gm
	기  능 : 이전 버튼시 이전대상을 찾는다.
	Param  : 
	Return : 
	========================================================================================*/
	void Prev_Bs(void)
	{
		if( g_nActIndex > 0 )
		{
			g_nActIndex--;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		else
		{
			g_nActIndex = -1;
		}
		
		if( g_nActIndex < 2 )
		{
			m_lPrev--;
		}

		if( g_lindex <= 0 || g_nActIndex < 0 )
		{
			g_nActIndex = 0;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			if( m_lPrev < 0 )
			{
				m_lPrev = 0;
			}
			return;
		}
	
		Clear_Flag();
		SetData();
		REDRAW();
		Set_Index();
		return;
	}
	
	/*=======================================================================================
	함수명 : Next_Gm
	기  능 : 다운 버튼시 다음대상을 찾는다.
	Param  : 
	Return : 
	========================================================================================*/
	void Next_Bs(void)
	{
		m_lPrev = 0;

		g_nActIndex++;
		g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

		if( g_nActIndex > m_ltotcnt || g_lindex < 0 )
		{
			if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
			{
				g_nActIndex = g_nActIndex-1;
			}
			
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			return;
		}
		
		Clear_Flag();
		SetData();
		REDRAW();
		Set_Index();
		return;
	}
	
	/*=======================================================================================
	함수명 : SetData
	기  능 : 데이터 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void SetData(void)
	{
		long i;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stBs, 0x00, sizeof(stBs));

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
			" SELECT A.ROWID, A.CHK_EXEC_NUM, A.ADDR1_M, A.ADDR1_S, A.SECOND_ADDR \
				   , A.BLD_DONG, A.HOSU, A.ZIP_NO1, A.ZIP_NO2, A.NEW_HOSU \
				   , A.NEW_ADDR_UNGRNOUD_YN, A.NEW_ADDR_UNION, A.CHK_YEAR, A.CHK_ORDER, A.SPECIAL_NUM \
				   , A.CHK_TYPE, A.OBJ_YM, A.PLAN_YM, A.SPECIAL_NM, A.CENTER_CD \
				   , A.ZONE_MANAGE_NUM, A.PDA_NUM, A.BEFO_HALF_CHK_RSLT, A.BEFO_HALF_CHK_YMD, A.BEFO_HALF_CHKER_NM \
				   , TRIM(A.BEFO_HALF_MEMO), A.BEFO_HALF_MEMO_WHY, A.BAR, A.REPRE_NM, A.REPRE_TEL_DDD \
				   , A.REPRE_TEL_EXN, A.REPRE_TEL_NUM, A.REPRE_CP_DDD, A.REPRE_CP_EXN, A.REPRE_CP_NUM \
				   , A.SAFE_MANAGER_NM,A. MANAGE_TEL_DDD, A.MANAGE_TEL_EXN, A.MANAGE_TEL_NUM, A.MANAGE_CP_DDD \
				   , A.MANAGE_CP_EXN, A.MANAGE_CP_NUM, A.PRESS_FLAG, A.MULTI_USE_FACI_KIND, A.SPECIAL_YN \
				   , A.COMPL_INSPECT_YMD, A.MM_USE_PLAN_QTY, A.INS_JOIN_YN, A.INS_JOIN_YMD, A.CHK_EMPID \
				   , A.CHKER_NM, A.CHK_YMD, A.CHK_TIME_FROM, A.CHK_TIME_TO, TRIM(A.CHK_RSLT) \
				   , A.ADV_DIST_YN, A.SIGN_RELAT, A.CURR_BAR, A.BAR_WHY, A.INFO_FLAG \
				   , TRIM(A.GOV_RSLT), TRIM(A.REG_RSLT), TRIM(A.PIPE_RSLT), TRIM(A.PIPEETC_RSLT), TRIM(A.SPECIAL_RSLT) \
				   , A.MRT_RSLT, A.SEND_YN, A.CITY, A.COUNTY, A.TOWN \
				   , A.VILLAGE, TRIM(A.NOGOOD_RSLT), A.UPD_EMPID, A.PDA_IP, ''  , A.PERIOD_CHK_YMD\
				   , A.LAW_TOWN, A.NEW_ROAD_NM, A.NEW_ADDR_M, A.NEW_ADDR_S, TRIM(A.HEAT_PUMP_YN) \
				   , TRIM(A.PIPE_BURY_YN), TRIM(A.PIPE_HIDE_YN), A.INST_BAR_PHOTO_YN, A.TEMP_INST_BAR_PHOTO_ID, A.TEMP_INST_BAR_PHOTO_YN \
				   , A.PREUSE_CHK_WHY, B.END_YN , A.INFO_YN \
			    FROM SPECIAL_DATA A \
			    LEFT OUTER JOIN SPECIAL_NOGOOD B \
                             ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
			   WHERE A.ROWID = ? \
			   ORDER BY A.ZIP_NO1, A.ZIP_NO2, A.ADDR1_M "
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;

		sql->Bind(sql, i++, 'X', &g_lindex , 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{		
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stBs.ROWID               ,5 + 1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_EXEC_NUM        ,12 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.ADDR1_M             ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.ADDR1_S             ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.SECOND_ADDR         ,100+1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.BLD_DONG            ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.HOSU                ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.ZIP_NO1             ,3  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.ZIP_NO2             ,3  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.NEW_HOSU            ,4  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.NEW_ADDR_UNGRNOUD_YN,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.NEW_ADDR_UNION      ,300+1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_YEAR            ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_ORDER           ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.SPECIAL_NUM         ,7  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_TYPE            ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.OBJ_YM              ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PLAN_YM             ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.SPECIAL_NM          ,50 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CENTER_CD           ,6  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.ZONE_MANAGE_NUM     ,5  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PDA_NUM             ,5  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.BEFO_HALF_CHK_RSLT  ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.BEFO_HALF_CHK_YMD   ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.BEFO_HALF_CHKER_NM  ,12 +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.BEFO_HALF_MEMO      ,100+1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.BEFO_HALF_MEMO_WHY  ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.BAR                 ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.REPRE_NM            ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.REPRE_TEL_DDD       ,4  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.REPRE_TEL_EXN       ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.REPRE_TEL_NUM       ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.REPRE_CP_DDD        ,4  +1 , DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stBs.REPRE_CP_EXN        ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.REPRE_CP_NUM        ,4  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.SAFE_MANAGER_NM     ,32 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.MANAGE_TEL_DDD      ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.MANAGE_TEL_EXN      ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.MANAGE_TEL_NUM      ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.MANAGE_CP_DDD       ,4  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.MANAGE_CP_EXN       ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.MANAGE_CP_NUM       ,4  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PRESS_FLAG          ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.MULTI_USE_FACI_KIND ,3  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.SPECIAL_YN          ,1  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.COMPL_INSPECT_YMD   ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.MM_USE_PLAN_QTY     ,10 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.INS_JOIN_YN         ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.INS_JOIN_YMD        ,8  +1 , DECRYPT );		
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_EMPID           ,9  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHKER_NM            ,12 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_YMD             ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_TIME_FROM       ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_TIME_TO         ,6  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CHK_RSLT            ,2  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.ADV_DIST_YN         ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.SIGN_RELAT          ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CURR_BAR            ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.BAR_WHY             ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.INFO_FLAG           ,1  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.GOV_RSLT            ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.REG_RSLT            ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PIPE_RSLT           ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PIPEETC_RSLT        ,1  +1 , DECRYPT );		
			sql->GetValue( sql, i++, 'U', (long*) stBs.SPECIAL_RSLT        ,2  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.MRT_RSLT            ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.SEND_YN             ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.CITY                ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.COUNTY              ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.TOWN                ,20 +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.VILLAGE             ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.NOGOOD_RSLT         ,1  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.UPD_EMPID           ,20 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PDA_IP              ,15 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PERIOD_CHK_YMD      ,8  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.BEFO_PERIOD_YMD     ,8  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.LAW_TOWN            ,30 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.NEW_ROAD_NM         ,100+1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.NEW_ADDR_M          ,10 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.NEW_ADDR_S          ,10 +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.HEAT_PUMP_YN        ,2  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.PIPE_BURY_YN        ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.PIPE_HIDE_YN        ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.INST_BAR_PHOTO_YN   ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.TEMP_INST_BAR_PHOTO_ID  ,30  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.TEMP_INST_BAR_PHOTO_YN  ,2  +1 , DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBs.PREUSE_CHK_WHY      ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.END_YN              ,2  +1 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBs.INFO_YN              ,2  +1 , DECRYPT );
		}
		
	Finally:
		DelSqLite(sql);
		
		Str_Cpy(g_szCHK_EXEC_NUM, stBs.CHK_EXEC_NUM);
		return;
	}
	
	/*=======================================================================================
	함수명 : SetDataNogood
	기  능 : 부적합 정보
	Param  : 
	Return : 
	========================================================================================*/	
	void SetDataNogood(void)
	{
		long i;
		char szSql[1100];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stBsNogood, 0x00, sizeof(stBsNogood));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CHK_EXEC_NUM, OBJ_YM, SPECIAL_NUM, CHK_TYPE, SPECIAL_NM \
		                    , CHK_YEAR, CHK_ORDER, CENTER_CD, ZONE_MANAGE_NUM, PDA_NUM \
					        , CITY, COUNTY, TOWN, VILLAGE, ADDR1_M \
					        , ADDR1_S, SECOND_ADDR, BLD_DONG, HOSU, CURR_ADDR_UNION \
					        , ZIP_NO1, ZIP_NO2, NEW_HOSU, NEW_ADDR_UNGRNOUD_YN, NEW_ADDR_UNION \
					        , SAFE_MANAGER_NM, MANAGE_TEL_DDD, MANAGE_TEL_EXN, MANAGE_TEL_NUM, MANAGE_CP_DDD \
					        , MANAGE_CP_EXN, MANAGE_CP_NUM, PRESS_FLAG, SPECIAL_YN, COMPL_INSPECT_YMD \
					        , MM_USE_PLAN_QTY, INS_JOIN_YN, INS_JOIN_YMD, END_YN, SEND_YN \
					        , EMP_ID, UPD_EMPID, PDA_IP, LAW_TOWN, NEW_ROAD_NM \
					        , NEW_ADDR_M, NEW_ADDR_S \
					     FROM SPECIAL_NOGOOD WHERE CHK_EXEC_NUM = ? "
					, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 12, DECRYPT);

		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.CHK_EXEC_NUM        	, 12 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.OBJ_YM              	, 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.SPECIAL_NUM         	, 7  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.CHK_TYPE            	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.SPECIAL_NM          	, 50 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.CHK_YEAR            	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.CHK_ORDER           	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.CENTER_CD           	, 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.ZONE_MANAGE_NUM     	, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.PDA_NUM             	, 5  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.CITY                	, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.COUNTY              	, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.TOWN                	, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.VILLAGE             	, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.ADDR1_M             	, 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.ADDR1_S             	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.SECOND_ADDR         	, 100+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.BLD_DONG            	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.HOSU                	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.CURR_ADDR_UNION     	, 300+ 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.ZIP_NO1             	, 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.ZIP_NO2             	, 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.NEW_HOSU            	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.NEW_ADDR_UNGRNOUD_YN	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.NEW_ADDR_UNION      	, 300+ 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.SAFE_MANAGER_NM     	, 32 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.MANAGE_TEL_DDD      	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.MANAGE_TEL_EXN      	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.MANAGE_TEL_NUM      	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.MANAGE_CP_DDD       	, 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.MANAGE_CP_EXN       	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.MANAGE_CP_NUM       	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.PRESS_FLAG          	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.SPECIAL_YN          	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.COMPL_INSPECT_YMD   	, 8  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.MM_USE_PLAN_QTY     	, 7  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.INS_JOIN_YN         	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.INS_JOIN_YMD        	, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.END_YN              	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.SEND_YN             	, 1  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.EMP_ID              	, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.UPD_EMPID           	, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.PDA_IP              	, 15 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.LAW_TOWN            	, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.NEW_ROAD_NM         	, 100+ 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.NEW_ADDR_M          	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stBsNogood.NEW_ADDR_S          	, 10 + 1, DECRYPT );
		}
		
	Finally:
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	함수명 : SetClickData
	기  능 : 계량기를 선택했을때 데이터 새로 셋팅
	Param  : 
	Return : 
	========================================================================================*/	
	void SetClickData(void)
	{
		long i, idx, j;
		long lstartidx;
		long lindex = 0;
		char szSql[500];
		char sztmp[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
		" SELECT CHK_EXEC_NUM, GOV_REGTR_FLAG, GOV_REGTR_NUM, MAKER_FLAG, MAKER_NUM \
			   , MAKER_NM, MODEL_CD, MODEL_NM, TRIM(DISJOINT_CHK_YMD), DISJOINT_CHK_FIRM_CD \
			   , DISJOINT_CHK_FIRM_NM, SEND_YN, INST_YMD, DETA_LOC, TRIM(NEW_DISJOINT_CHK_YMD) \
			   , NEW_DISJOINT_CHK_FIRM_CD, NEW_DISJOINT_CHK_FIRM_NM, CRT_DTM,SET_YMD , TRIM(FILTER_CLEAN_YMD) , FILTER_CLEAN_FIRM_CD , TRIM(FILTER_CLEAN_FIRM_NM) AS FILTER_CLEAN_FIRM_NM \
			   , TRIM(NEW_FILTER_CLEAN_YMD) AS NEW_FILTER_CLEAN_YMD , NEW_FILTER_CLEAN_FIRM_CD , NEW_FILTER_CLEAN_FIRM_NM , REGTR_LOC_FLAG , REGTR_STD \
		    FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM = ? AND GOV_REGTR_FLAG = ? AND GOV_REGTR_NUM = ? "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)stBs.CHK_EXEC_NUM         , 12, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stGovinfo2.GOV_REGTR_FLAG ,  2, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stGovinfo2.GOV_REGTR_NUM  ,  9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		Mem_Set( (byte*)&stGovinfo2, 0x00, sizeof(stGovinfo2) );
		idx = 0;
		
		if(sql->Next(sql) == TRUE)
		{
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.CHK_EXEC_NUM        	   , 12 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.GOV_REGTR_FLAG      	   , 2  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.GOV_REGTR_NUM       	   , 9  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MAKER_FLAG          	   , 2  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MAKER_NUM           	   , 5  +1, DECRYPT );
			
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MAKER_NM            	   , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MODEL_CD            	   , 5  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MODEL_NM            	   , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_YMD        , 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_FIRM_CD    , 10  +1, DECRYPT );
			
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_FIRM_NM    , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.SEND_YN                 , 1  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.INST_YMD                , 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DETA_LOC                , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_YMD    , 8  +1, DECRYPT );
			
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_FIRM_CD, 10 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM, 30 +1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.CRT_DTM                 , 30 +1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.SET_YMD                 , 1 +1, DECRYPT );

			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.FILTER_CLEAN_YMD        , 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.FILTER_CLEAN_FIRM_CD    , 10  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.FILTER_CLEAN_FIRM_NM    , 30 +1, DECRYPT );

			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_YMD      , 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_FIRM_CD  , 10  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM  , 30 +1, DECRYPT );

			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.REGTR_LOC_FLAG    		, 2 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.REGTR_STD    			, 2 +1, DECRYPT );

			   
		}

	Finally:
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 검침 자료를 읽어와서 화면에 설정한다.
	Param  : 
	Return : 
	========================================================================================*/	
	void REDRAW(void)
	{
		long i, k;
		long lstartidx, lendidx, idx;
		long lCnt;
		char szSql[300];
		char szDate[15];
		char szNum[3];
		handle hdb = NULL;
		handle hstmt = NULL;
		char szAddr[200];
		SQLITE sql = NewSqLite();

		// PAGE
		m_ltotcnt = FS_GetSrchTotCnt();
		SPRINT(m_szCnt_index, "%d/%d", g_nActIndex+1, m_ltotcnt, 0);
		
		// 특정명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stBs.SPECIAL_NM);
		
		// 특정번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), stBs.SPECIAL_NUM);
		
		// 압력
		if(stBs.PRESS_FLAG[0] == 'L')
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4),"저압" );
		}
		else if(stBs.PRESS_FLAG[0] == 'M')
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4),"중압");
		}
		else if(stBs.PRESS_FLAG[0] == 'R')
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4),"중간압" );
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4),"");
		}
		
		// 주소
		Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr) );
		
		if( g_nAddrFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
			Str_Cpy( szAddr, stBs.COUNTY);
			Str_Cat( szAddr, " ");
			Str_Cat( szAddr, stBs.TOWN);
			Str_Cat( szAddr, " ");
			Str_Cat( szAddr, stBs.ADDR1_M);
			Str_Cat( szAddr, "-");
			Str_Cat( szAddr, stBs.ADDR1_S);	
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주소");
			Str_Cpy( szAddr, stBs.COUNTY);
			Str_Cat( szAddr, " ");
			Str_Cat( szAddr, stBs.NEW_ROAD_NM);
			Str_Cat( szAddr, " ");
			Str_Cat( szAddr, stBs.NEW_ADDR_M);
			Str_Cat( szAddr, "-");
			Str_Cat( szAddr, stBs.NEW_ADDR_S);	
		}
		
		Str_Cat(szAddr, " / ");
		Str_Cat(szAddr, stBs.SPECIAL_NM);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), szAddr);		
		
		// 안전관리자 성명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), stBs.SAFE_MANAGER_NM);
		
		// 대표자 성명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), stBs.REPRE_NM);

		// 0 = 핸드폰번호, 1 = 전화번호
		Mem_Set( (byte*)m_szManageTel, 0x00, sizeof(m_szManageTel) );
		Mem_Set( (byte*)m_szRepreTel, 0x00, sizeof(m_szRepreTel) );
		
		if( m_lTelFalg == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TEL), "HP");
			
			// 안전관리자 전화번호
			Str_Cpy(m_szManageTel, stBs.MANAGE_CP_DDD);
			Str_Cat(m_szManageTel, "-");
			Str_Cat(m_szManageTel, stBs.MANAGE_CP_EXN);
			Str_Cat(m_szManageTel, "-");
			Str_Cat(m_szManageTel, stBs.MANAGE_CP_NUM);
			
			// 대표자 전화번호
			Str_Cpy(m_szRepreTel, stBs.REPRE_CP_DDD);
			Str_Cat(m_szRepreTel, "-");
			Str_Cat(m_szRepreTel, stBs.REPRE_CP_EXN);
			Str_Cat(m_szRepreTel, "-");
			Str_Cat(m_szRepreTel, stBs.REPRE_CP_NUM);
		}
		else 
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TEL), "TEL");
			
			// 안전관리자 전화번호
			Str_Cpy(m_szManageTel, stBs.MANAGE_TEL_DDD);
			Str_Cat(m_szManageTel, "-");
			Str_Cat(m_szManageTel, stBs.MANAGE_TEL_EXN);
			Str_Cat(m_szManageTel, "-");
			Str_Cat(m_szManageTel, stBs.MANAGE_TEL_NUM);
			
			// 대표자 전화번호
			Str_Cpy(m_szRepreTel, stBs.REPRE_TEL_DDD);
			Str_Cat(m_szRepreTel, "-");
			Str_Cat(m_szRepreTel, stBs.REPRE_TEL_EXN);
			Str_Cat(m_szRepreTel, "-");
			Str_Cat(m_szRepreTel, stBs.REPRE_TEL_NUM);
		}
		
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_MANAGETEL), m_szManageTel);
		
		if( Str_Len(m_szManageTel) > 10)
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_MANAGETEL), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MANAGETEL), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_MANAGETEL), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MANAGETEL), TRUE );
		}

		ButCtrl_SetText(Get_hDlgCtrlByID(BID_PHONETEL), m_szRepreTel);
		
		if( Str_Len(m_szRepreTel) > 10)
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), TRUE );
		}
		
		// 완성검사 
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		g_Str_DateType(szDate, stBs.COMPL_INSPECT_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), szDate);
		
		// 예정량
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), stBs.MM_USE_PLAN_QTY);
		
		// 전반기
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_PREV_NO  WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );
		
		if( lCnt == 0 )
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_JEONBAN), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_JEONBAN), TRUE );
		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_JEONBAN), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_JEONBAN), FALSE );
		}
		
		// 전반기 버튼
		if( Str_Cmp(stBs.BEFO_HALF_CHK_RSLT, "21") == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_JEONBAN), RED);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_JEONBAN), BTNCTRLBKCOLOR);
		}
		
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		g_Str_DateType(szDate, stBs.BEFO_HALF_CHK_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), szDate);
		
		if(Str_Cmp(stBs.BEFO_HALF_CHK_RSLT, "20") == 0)
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA14), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "적합" );
		}
		else if(Str_Cmp(stBs.BEFO_HALF_CHK_RSLT, "21") == 0)
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA14), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "부적합");
		}
		else if(Str_Cmp(stBs.BEFO_HALF_CHK_RSLT, "40") == 0)
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA14), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "제외" );
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA14), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "");	
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), stBs.BEFO_HALF_CHKER_NM);
		
		// 현반기
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		g_Str_DateType(szDate, stBs.CHK_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), szDate);
		
		if(Str_Cmp(stBs.CHK_RSLT, "20") == 0)
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA17), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "적합" );
		}
		else if(Str_Cmp(stBs.CHK_RSLT, "21") == 0)
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA17), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "부적합");
		}
		else if(Str_Cmp(stBs.CHK_RSLT, "40") == 0)
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA17), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "제외" );
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA17), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "");	
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), stBs.CHKER_NM);

		// 메모 버튼
		if( Str_Len(stBs.BEFO_HALF_MEMO) > 0 )
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNMENUFRCOLOR);
		}
		
		// 점검시작 버튼
		if( Str_Cmp(stBs.CHK_RSLT, "20") == 0 || Str_Cmp(stBs.CHK_RSLT, "21") == 0 )
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BS), RED);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BS), "점검완료");
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BS), BTNMENUFRCOLOR);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BS), "점검시작");
		}
		
		// 우선
		if( Str_Len(stBs.PREUSE_CHK_WHY) > 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA29), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA29), "우선특정점검");
		}
		else
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA29), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA29), "");
		}
		
		// 정압기, 조정기리스트
		SPRINT(szAddr, "  SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM = '%s' ", stBs.CHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szAddr, &m_lTotpage );
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		if( m_lSelIndex == -1 )
		{
			m_lSelIndex = 0;
		}
		
		if(m_lIdxFlag == 1)
		{
			m_lpage = g_nActRow / ROW;
			m_lSelIndex = (g_nActRow % ROW);
			
			m_lIdxFlag = 0;
		}

		SPRINT(m_szLst_index, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		Mem_Set( (byte*)&stGovinfo2, 0x00, sizeof(stGovinfo2) );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
		" SELECT CHK_EXEC_NUM, GOV_REGTR_FLAG, GOV_REGTR_NUM, MAKER_FLAG, MAKER_NUM \
			   , MAKER_NM, MODEL_CD, MODEL_NM, TRIM(DISJOINT_CHK_YMD), DISJOINT_CHK_FIRM_CD \
			   , DISJOINT_CHK_FIRM_NM, SEND_YN, TRIM(NEW_DISJOINT_CHK_YMD), NEW_DISJOINT_CHK_FIRM_CD, NEW_DISJOINT_CHK_FIRM_NM \
			   , CRT_DTM, SET_YMD , TRIM(NEW_FILTER_CLEAN_YMD), NEW_FILTER_CLEAN_FIRM_CD, NEW_FILTER_CLEAN_FIRM_NM\
		    FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM = ? ORDER BY GOV_REGTR_FLAG , REGTR_STD DESC  LIMIT ?, ?  "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)stBs.CHK_EXEC_NUM , 12, DECRYPT);
		
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, i++, 'X', &lstartidx, 4, DECRYPT);
		
		lendidx = m_lpage*ROW+ROW;
		sql->Bind(sql, i++, 'X', &lendidx, 4, DECRYPT);

		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		k = -1;
		for( i=0; i < ROW; i++ )
		{
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
					continue;
				}

				idx = 0;
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.CHK_EXEC_NUM        , 12+1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.GOV_REGTR_FLAG      , 2 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.GOV_REGTR_NUM       , 9 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MAKER_FLAG          , 2 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MAKER_NUM           , 5 +1, DECRYPT );

				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MAKER_NM            , 30+1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MODEL_CD            , 5 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.MODEL_NM            , 30+1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_YMD    , 8 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_FIRM_CD, 10+1, DECRYPT );

				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_FIRM_NM, 30+1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.SEND_YN             , 1 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_YMD    , 8  +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_FIRM_CD, 10 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM, 30 +1, DECRYPT );
				
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.CRT_DTM                 , 30 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.SET_YMD                 , 1 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_YMD    , 8  +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_FIRM_CD, 10 +1, DECRYPT );
				sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM, 30 +1, DECRYPT );
				
				if(Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "정" );
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "조" );
				} 
					
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, stGovinfo2.MAKER_NM );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, stGovinfo2.MODEL_NM );
				
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				if(Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 )
				{
					g_Str_DateType( szDate, stGovinfo2.NEW_DISJOINT_CHK_YMD);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, szDate );
				}
				else if(Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 )
				{
					if(Str_Cmp(stGovinfo2.NEW_FILTER_CLEAN_YMD, "11111111") == 0 )
					{
						// g_Str_DateType( szDate, "확인불가");
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "확인불가" );
					}
					else
					{
						g_Str_DateType( szDate, stGovinfo2.NEW_FILTER_CLEAN_YMD);
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, szDate );
					}
				}
				
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, stGovinfo2.CHK_EXEC_NUM );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, stGovinfo2.GOV_REGTR_NUM );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, stGovinfo2.MAKER_FLAG );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, stGovinfo2.MAKER_NUM );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, stGovinfo2.MODEL_CD );	
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, stGovinfo2.DISJOINT_CHK_FIRM_CD );	
				DlgTbl_SetStr ( ID_TBLLIST, i,10, stGovinfo2.DISJOINT_CHK_FIRM_NM );	
				DlgTbl_SetStr ( ID_TBLLIST, i,11, stGovinfo2.SEND_YN );	
			}
		}		

	Finally:
		DelSqLite(sql);

		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
	
			if(Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0), "정") == 0 )
			{
				Str_Cpy(stGovinfo2.GOV_REGTR_FLAG, "10");
			}
			else
			{
				Str_Cpy(stGovinfo2.GOV_REGTR_FLAG, "20");
			}
	
			Str_Cpy(stGovinfo2.GOV_REGTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
	
			SetClickData();
		}
		

		ON_DRAW();
		return;
	}	
	
	/*=======================================================================================
	함수명 : CHECK
	기  능 : 대상 점검결과 및 입력사항 체크
	Param  : 
	Return : 
	========================================================================================*/	
	bool CHECK(void)
	{
		bool ret = TRUE;
		char szDate[10];
		char szYear[10];
		char szChkDate[10];
		char szSql[600];
		long lCnt;

		if( stBs.SEND_YN[0] == 'Y' )
		{
			MessageBoxEx (CONFIRM_OK, "이미 송신 완료한 자료입니다.");
			ret = FALSE;
			return ret;
		}
		
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szChkDate, 0x00, sizeof(szChkDate));
		
		Str_ItoA(Time_GetDate(), szDate, 10);
		Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
		Mem_Cpy((byte *)szChkDate, (byte *)stGovinfo2.NEW_DISJOINT_CHK_YMD, 4);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );
		
		PRINT("lcnt :%d",lCnt,0,0);

		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0)
		{
			if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
			{	
				if( MessageBoxEx (CONFIRM_YESNO, "정압기 분해점검일을 확인하세요.\n(필수)\n진행하시겠습니까?") == MB_OK)
				{	
					g_lGovInflowPath = 0;
					Card_Move("BS_DISJOINTCHK");
					return FALSE;
				}
			}	
			/* 20200604 고객시설팀 강병훈 차장님 요청 : 분해점검일 3년 이전 날짜 입력 불가 로직 삭제
			else if( Str_AtoI(szYear) - 3 > Str_AtoI(szChkDate) )
			{
				MessageBoxEx(CONFIRM_OK, "정압기 분해점검일을 확인하세요.\n(필수)");
				ON_EXIT();
				OnInit(INIT_PRESSCHG);
				return FALSE;
			}
			*/
		}
		else if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0 )
		//조정기이면서 1인치가 아닌거
		{
			if( Str_Len(stGovinfo2.NEW_FILTER_CLEAN_YMD) == 0 )
			{
				if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "조정기 필터청소를 확인하세요.\n(필수)\n진행하시겠습니까?") == MB_OK)
					{	
						g_lGovInflowPath = 0;
						Card_Move("bs_filter_clean");
						return FALSE;
					}
				}
				else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "조정기 필터청소를 확인하세요.\n(필수)\n진행하시겠습니까?") == MB_OK)
					{	
						g_lGovInflowPath = 0;
						Card_Move("bs_filter_clean");
						return FALSE;
					}
				}

			}
			

		}

		
		return TRUE;	
	}

	/*=======================================================================================
	함수명 : FS_GetSrchTotCnt
	기  능 : 검색인덱스파일의 레코드 수를 리턴한다.
	Param  : nPos:검색 인덱스 파일의 순번
 	Return : 레코드수
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;
		
		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}
	
	/*=======================================================================================
	함수명 : Set_Index
	기  능 : 최종 인덱스 저장한다.
	Param  : 
	Return : TRUE :성공
			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		
		if( g_nWorkFlag == 305 || g_nWorkFlag == 306 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '5' ", g_nActIndex, 0, 0);
		}
		else
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '5' ", g_nActIndex, 0, 0);
		}
		
		g_Sql_DirectExecute(szSql);
	}

	/*=======================================================================================
	함수명 : SetComboIdx
	기  능 : rowid 저장
	Param  : 
	Return : 
	========================================================================================*/
	void SetComboIdx(void)
	{
		long i, idx;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA ORDER BY ZIP_NO1, ZIP_NO2, ADDR1_M ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, CMBFILTER_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY ZIP_NO1, ZIP_NO2, ADDR1_M ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szSql, &lRow );

		lActIndex = g_Get_FsIndex(lRow, CMBFILTER_FILE);
			
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		if( g_nWorkFlag == 305 || g_nWorkFlag == 306 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '5' ", lActIndex, 0, 0);		
		}
		else
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '5' ", lActIndex, 0, 0);		
		}

		g_Sql_DirectExecute(szSql);

		return;
	}

	/*=======================================================================================
	함수명 : Clear_Flag
	기  능 : 해당 업무 관련 flag 초기화
	Param  : 
	Return : 
	========================================================================================*/	
	void Clear_Flag(void)
	{
		g_nAddrFlag = 0;
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
		
		m_lpage = 0;
		m_lSelIndex = 0;
		m_lIdxFlag = 0;
	}

	/*=======================================================================================
	함수명 : Call_Tel
	기  능 : 전화걸기
	Param  : 
	Return : 
	========================================================================================*/
	void Call_Tel(long nButtonID)
	{
		char szNum[15];
		Mem_Set( (byte*)szNum, 0x00, sizeof(szNum) );

		if( BID_MANAGETEL == nButtonID )
		{
			Str_Cpy(szNum, m_szManageTel);
			Str_Chg(szNum, STRCHG_DEL_NONDIGIT );
		}
		else if( BID_PHONETEL == nButtonID )
		{
			Str_Cpy(szNum, m_szRepreTel);
			Str_Chg(szNum, STRCHG_DEL_NONDIGIT );
		}

		if( Str_Len(szNum) > 8 )
		{
			Tapi_MakeCall((byte*)szNum);
		}
	}
}
