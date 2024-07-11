/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card CHK_BFDTL
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
	#define USE_ON_SELECT
	#define USE_ON_UART
	#define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_PREVPG )	//이전페이지
		DEF_BUTTON_ID ( BID_NEXTPG )	//다음페이지
		DEF_BUTTON_ID ( BID_OK     )	//확인
		DEF_BUTTON_ID ( BID_PHOTO  )	//사진
		DEF_BUTTON_ID ( BID_VIEW   )	//사진확인
		
		
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
		DEF_OBJECT_ID ( TXT_PAGE )		//총페이지

		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table의 행개수
	#define		COL 	    4					// table의 열개수
	#define		GRID_H		(CHT+24)			// table 행 높이
	#define		GRID_H_P	(CHT+32)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+125  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+30  	    // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"점검항목"    , CWD*33+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"부"          , CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"점검항목코드", 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{""            , 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	long m_lpage;
	long m_lTotpage;
	char m_szCnt_page[10];
	long m_lIdxFlag = 0;	// index 관련 flag
	long m_lActive = -1;
	char m_Title[30];
	char m_szfilenm[128];
	
	#define INIT_MAIN	1	
	
	CodeTable *m_CT;
	long m_nSec_cd;
	
	void SetStyle(void);
	void REDRAW(void);
	void Save_Row(long row, long col);
	bool Save_NotPassItem(char* szNOT_PASS_ITEM_CD, char* szNOT_PASS_ITEM_NM);
	void Shoto_Photo(void);
	void Photo_View(void);
	//void Save_Page( void );
	void SetBtnImg(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_Title),

		DLG_TEXT(STARTX,       STARTY+65, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지				
		DLG_BUTTON(STARTX+500, STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, " ▼"),				
		
		DLG_BUTTON(STARTX    , STARTY+830, 400, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "사진촬영"),
		DLG_BUTTON(STARTX+600, STARTY+830, 400, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "점 검"),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//화면캡쳐
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, m_Title),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(   STARTX,		STARTY-40, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지				
		DLG_BUTTON( STARTX+500,	STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, " ▲"),
		DLG_BUTTON( STARTX+750,	STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, " ▼"),				

		DLG_BUTTON(STARTX    , STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "사진촬영"),
		DLG_BUTTON(STARTX+600, STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "점 검"),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));	
						break;		
				}
				
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);		
		
		Str_Cpy(m_Title, stBfNogood.CHK_SEC_NM);
		Str_Cat(m_Title, " 점검");
		m_nSec_cd = Str_AtoI(stBfNogood.CHK_SEC_CD);
		
		switch(m_nSec_cd)
		{
			case 10: //보일러 위치점검
				m_lTotpage = sizeof(BF_BOILCHK)/sizeof( CodeTable )-1;
				m_CT = BF_BOILCHK;
				break;
			case 20: //급/환기구점검
				m_lTotpage = sizeof(BF_HWANCHK)/sizeof( CodeTable )-1;
				m_CT = BF_HWANCHK;
				break;
			case 30: //배기통/톱
				m_lTotpage = sizeof(BF_BEGICHK)/sizeof( CodeTable )-1;
				m_CT = BF_BEGICHK;
				break;
			case 90: //기타점검
				m_lTotpage = sizeof(BF_ETCCHK)/sizeof( CodeTable )-1;
				m_CT = BF_ETCCHK;
				break;
			}
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_PREVPG:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//REDRAW();
					break;
				}
				m_lActive = 0;
				REDRAW();
				break;			
			case BID_NEXTPG:
				m_lpage += ROW;
				if( m_lpage >= m_lTotpage )
				{
					m_lpage -= ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//REDRAW();
					break;
				}
				m_lActive = 0;
				REDRAW();
				break;	
			case BID_PHOTO:
				Shoto_Photo();
				break;
			case BID_VIEW:
				Photo_View();
				break;
			case BID_OK:
				if( g_nWorkChkFlag == 50 )
				{
					Card_Move("BF_BEFOBOILCHK");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");	
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "공급전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("BF_BEFOMENU");	
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
				if( g_nWorkChkFlag == 50 )
				{
					Card_Move("BF_BEFOBOILCHK");
				}
				break;	
			case GID_VMEXIT:
				g_Exit();	
				break;
		}
	}
	
	void	OnSelect(long Index)
	{
		long index = -1;
		long lpage;
		char sztmp[20];
		long lrow, lcol;
	
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			m_lActive = index;
			
			lrow = m_lActive/COL;
			lcol = m_lActive%COL;
			lrow--;

			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			if( lcol == 1 )
			{
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, lcol) );
				if( Str_Cmp( sztmp, CHKGOOD) == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), RED);
	
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-1 ), BLUE );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), BLUE );
				}
				
				Save_Row(lrow, lcol);
			}
			
			lpage = m_lpage + (index/COL);
			g_nChkIndex = index;
			SPRINT(m_szCnt_page, "%d/%d", lpage, m_lTotpage, 0);
			ON_DRAW();
		}
	}
	
	//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long lpage = 1;
		long k = ROW;
		long ret = -1;
		long lcol, lrow;
		char szSql[500];
		char szTmp[200];
		char szNOT_PASS_ITEM_CD[3];
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );

		if( m_lActive == -1 )
		{
			m_lActive = 0;
		}

		if( g_nPhotoFlag == 5 )
		{
			lpage = m_lpage + (g_nChkIndex / COL);
			m_lActive = g_nChkIndex;
		
			lrow = (m_lActive/COL) - 1;
			lcol = m_lActive%COL;

			g_nPhotoFlag = 0;
		}
		else
		{
			lpage = m_lpage;
		
			lrow = 0;
			lcol = 0;
		}

		SPRINT(m_szCnt_page, "%d/%d", lpage+1, m_lTotpage, 0);

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i = 0 ; i < ROW ; i++)
		{
			if( m_lpage+i+1 > m_lTotpage )//자료가 없을때 화면을 클리어 시킨다.
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, m_CT[m_lpage+i].Str );
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				SPRINT(szSql, " SELECT NOT_PASS_ITEM_CD FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBfNogood.CREATE_YMD, stBfNogood.CHK_SEC_CD, m_CT[m_lpage+i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' AND BURNER_NUM = '%s' ", stBfNogood.MTR_NUM, stBfNogood.BURNER_NUM, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );
				
				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
				}
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, m_CT[m_lpage+i].Code );
			}			
		}		
/*
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActive+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActive+1, TABLEACTIVE_COLOR);
		}
*/
		ON_DRAW();
		return;
	}
	
//-----------------------------------------------------------------------------------------
	void Save_Row(long row, long col)
	{
	char szNOT_PASS_ITEM_CD[3];
	char szNOT_PASS_ITEM_NM[33];
	char sztmp[100];
	char szSql[500];
	
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set((byte*)szNOT_PASS_ITEM_NM ,0x00, sizeof(szNOT_PASS_ITEM_NM) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
	
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, row, col) );
		Str_Cpy( szNOT_PASS_ITEM_NM, DlgTbl_GetStr( ID_TBLLIST, row, 0) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, row, 2) );
		
		//적합일 경우 항목 삭제
		if(Str_Cmp( sztmp, CHKGOOD) == 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			SPRINT(szSql, " DELETE FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBfNogood.CREATE_YMD, stBfNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
			SPRINT(sztmp, "AND MTR_NUM = '%s' AND BURNER_NUM = '%s' ", stBfNogood.MTR_NUM, stBfNogood.BURNER_NUM, 0);
			Str_Cat(szSql, sztmp);
			
			g_Sql_DirectExecute( szSql );
			
		}
		else // 부적합일 경우 항목 추가
		{
			Save_NotPassItem(szNOT_PASS_ITEM_CD, szNOT_PASS_ITEM_NM);
		}
		
		
	}
	
//-----------------------------------------------------------------------------------------
	bool Save_NotPassItem(char* szNOT_PASS_ITEM_CD, char* szNOT_PASS_ITEM_NM)
	{
	long idx;
	bool ret = TRUE;
	SQLITE sql = NewSqLite();
	long nDate;
	long BettePlanymd;
	char sztmp[20];	
	handle hdb = NULL;
	handle hstmt = NULL;
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		nDate = Time_GetDate();
		BettePlanymd = Time_DateUpDown(nDate, 15 );
		
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		if( g_nWorkFlag > 499 && g_nWorkFlag < 510 )
		{
			hstmt = sql->CreateStatement(sql,
"INSERT INTO BEFO_NOGOOD_DETAL \
( CREATE_YMD , MTR_NUM , BURNER_NUM , CHK_SEC_CD , NOT_PASS_ITEM_CD , VISIT_DTM  \
, CHK_SEC_NM , NOT_PASS_ITEM_NM ,  BETTER_PLAN_YMD , BETTER_YMD \
, BETTER_YN , MTR_ID_NUM , EMP_ID, CRT_EMPID , CRT_IP , SEND_YN ) \
VALUES ( ?, ?, ?, ?, ?,  ?, ?, ?, ?, ? \
, 'N', ?, ?, ?, ?, 'I' ) " 
			);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.CREATE_YMD      ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.MTR_NUM         ,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.BURNER_NUM      ,6 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.CHK_SEC_CD      ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_CD         ,2 ,DECRYPT);
			
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA( nDate, sztmp, 10);
			g_Str_TimeType(sztmp+8, Time_GetTime( ) );
			sql->Bind(sql, idx++, 'U', (long *)sztmp  , 14 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.CHK_SEC_NM      ,30,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_NM         ,50,DECRYPT);
			
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA( BettePlanymd, sztmp,10);
			sql->Bind(sql, idx++, 'U', (long *)sztmp , 8 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.BETTER_YMD      ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBf.MTR_ID_NUM            ,30,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,32,DECRYPT);
		}
		else
		{
			hstmt = sql->CreateStatement(sql,
"INSERT INTO BEFO_NOGOOD_DETAL \
( CREATE_YMD , MTR_NUM , BURNER_NUM , CHK_SEC_CD , NOT_PASS_ITEM_CD , VISIT_DTM  \
, CHK_SEC_NM , NOT_PASS_ITEM_NM ,  BETTER_PLAN_YMD , BETTER_YMD \
, BETTER_YN , MTR_ID_NUM , EMP_ID, CRT_EMPID , CRT_IP ) \
VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
, 'N', ?, ?, ?,  ? ) " 
			);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.CREATE_YMD      ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.MTR_NUM         ,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.BURNER_NUM      ,6 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.CHK_SEC_CD      ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_CD         ,2 ,DECRYPT);
			
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA( nDate, sztmp, 10);
			g_Str_TimeType(sztmp+8, Time_GetTime( ) );
			sql->Bind(sql, idx++, 'U', (long *)sztmp  , 14 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.CHK_SEC_NM      ,30,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_NM         ,50,DECRYPT);
			
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA( BettePlanymd, sztmp,10);
			sql->Bind(sql, idx++, 'U', (long *)sztmp , 8 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stBfNogood.BETTER_YMD      ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBf.MTR_ID_NUM            ,30,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,32,DECRYPT);
		}
		sql->Execute(sql);
		
Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//----------------------------------------------------------------------------------------------
	void Shoto_Photo(void)
	{
		char sztmp[256];
		char szScrPht[256];
		char szTgrPht[256];
		char szDirPath[256];
		char szNOT_PASS_ITEM_CD[3];
		char *pCamera;
		long nRet, idx;
		long lrow, lcol;
		handle h = NULL;
		handle hdata = NULL;

		lrow = m_lActive/COL;
		lcol = m_lActive%COL;
		lrow--;
		
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		if( m_lActive <= 0 )
		{
			MessageBoxEx (CONFIRM_OK, "항목을 선택하세요.");
			return;
		}
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, 1) );
		if( Str_Cmp( sztmp, CHKGOOD) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "선택한 열이 부적합이 아닙니다.");
			return;
		}

		//파일명
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, lrow, 2) );
		Str_Cpy(m_szfilenm , "1");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , stBfNogood.CREATE_YMD);
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(stBfNogood.MTR_NUM) > 0)
			Str_Cat(m_szfilenm , stBfNogood.MTR_NUM);
		else
			Str_Cat(m_szfilenm , "000000000");
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(stBfNogood.BURNER_NUM) > 0)
			Str_Cat(m_szfilenm , stBfNogood.BURNER_NUM);
		else
			Str_Cat(m_szfilenm , "000000");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , stBfNogood.CHK_SEC_CD);
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , szNOT_PASS_ITEM_CD);
		Str_Cat(m_szfilenm , ".jjp");
		
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_nPhotoFlag = 5;
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_BF,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//원본파일
			//Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_BF,  m_szfilenm, 0);
			//에뮬에서 확인시...
			//ShootPhoto ( 1, 0, m_szfilenm );

			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				//2017-08-18 Sanghyun Lee
				//카메라 화질 설정(photo_quality)	
				//"MEDIA_QUALITY_AUTO" ->> 에러 발생, 필요X
				//"MEDIA_QUALITY_LOWEST"
				//"MEDIA_QUALITY_LOW" ->> 선택되는 화질이 없음 , 필요X
				//"MEDIA_QUALITY_MEDIUM" ->> 현재 사용중인버전
				//"MEDIA_QUALITY_HIGH"
				//"MEDIA_QUALITY_HIGHEST"
				JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_MEDIUM");

				//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
				JSON_SetValue	(hdata	, 'C', "position_info"		, " ");
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
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		
		//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);
		CloseMessageBox();
		
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_CAMERA )
			{
				Mem_Set((byte*)szPhotopath, 0x00, sizeof(szPhotopath));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				szPath = (char*)System_GetResult((char*)&nRet);
				nLen = Str_Len(szPath);
				if( nLen > 19 )
				{
					Mem_Cpy((byte *)szTmp, (byte *)szPath+19, nLen-19);
					Str_Cpy(szPhotopath, "..");
					Str_Cat(szPhotopath, szTmp);
					//PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
					//원본파일 +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_BF,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					ON_DRAW();
					MessageBoxEx(MESSAGE, "사진을 저장중입니다.");
				}
			}
		}

		ON_DRAW();
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
	char szfilenm[256];
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				if( FFS_Exist(szfilenm)  )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h에 정의되어있음
					ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
				
					VmSleep(100);
					FFS_Delete( szfilenm );
				}
				
			}
		}
	}
	
//----------------------------------------------------------------------------------------------
	void Photo_View(void)
	{
	char sztmp[256];
	char szfilenm[256];
	char szNOT_PASS_ITEM_CD[3];
		
		Mem_Set((byte*)szfilenm ,0x00, sizeof(szfilenm) );

		//파일명
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2) );
		
		Str_Cpy(szfilenm , "1");
		Str_Cat(szfilenm , "_");
		Str_Cpy(szfilenm , stBfNogood.CREATE_YMD);
		Str_Cat(szfilenm , "_");
		if(Str_Len(stBfNogood.MTR_NUM) > 0)
			Str_Cat(szfilenm , stBfNogood.MTR_NUM);
		else
			Str_Cat(szfilenm , "000000000");
		Str_Cat(szfilenm , "_");
		if(Str_Len(stBfNogood.BURNER_NUM) > 0)
			Str_Cat(szfilenm , stBfNogood.BURNER_NUM);
		else
			Str_Cat(szfilenm , "000000");
		Str_Cat(szfilenm , "_");
		Str_Cat(szfilenm , stBfNogood.CHK_SEC_CD);
		Str_Cat(szfilenm , "_");
		Str_Cat(szfilenm , szNOT_PASS_ITEM_CD);
		Str_Cat(szfilenm , ".jjp");

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT (sztmp, "%s/%s",PHOTO_BF, szfilenm, 0);
		
		if(Str_Cmp(g_szDEVICE_NAME, "DS3") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 ) //PDA
		{
			if( FFS_Exist("\\windows\\iexplore.exe" ) )
			{
				RunApp( "iexplore.exe", szfilenm);
			}
			else if( FFS_Exist("\\windows\\iesample.exe" ) )
			{
				RunApp( "iesample.exe", szfilenm);
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "사진조회 프로그램이 없습니다.");
			}
			
		}
		else
		{		
			RunApp( "WEBVIEWER", sztmp);
		}
	}

}
