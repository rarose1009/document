/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_CLEARLST
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

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )			//지번 주소
		DEF_BUTTON_ID ( BID_NADDR )			//도로명 주소
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//주소 스크롤 호출
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지
		DEF_BUTTON_ID ( BID_CLEARCANCEL )	//해제취소
		DEF_BUTTON_ID ( BID_RCV )			//자료수신
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
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//페이지
		DEF_OBJECT_ID ( TXT_DATA1 )			//주소

		DEF_OBJECT_ID ( ID_TBLLIST )		// 테이블 리스트
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table의 행개수
	#define		COL 	    10					// table의 열개수
	#define		GRID_H		(CHT+32)			// table 행 높이
	#define		GRID_H_P	(CHT+48)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX	 			// table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+255  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    //table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"주소",     	  CWD*16+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"개월",       	  CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"체납금액",      CWD*13, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상태",     	  CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상세주소",   	  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ROWID",	 	  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"GMTR_OBJ_FLAG", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"USE_CONT_NUM",  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"MTR_NUM",       CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"PROC",          CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index 관련 flag
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_lstartidx = 0;
	long m_nActIndex = -1;		//선택된 row index
	long m_bFirst;				
	char m_Title[30];
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_szCobSel[20];
	char m_szMtrNum[20];
	char m_szProc[10];
	char m_szQuickSql[1000];


	bool REDRAW(void);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//선택한 대상 인덱스 저장
	void Get_Index(void); 	//선택된 대상 인덱스 읽기
	void SetBtnImg(void);
	void SetData(void);
	long Rcv_Data(void);
	long TR83110(void);
	void OnList(quad lParam);
	void Grid_QuickList(void);
	
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
	
	// 메인 다이얼로그(리스트)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "해제활동 리스트"),
	
		DLG_BUTTON(STARTX,	 	STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+250,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "지번\n스크롤"),
		
		DLG_BUTTON(0, 		   STARTY+831, 300, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLEARCANCEL, "해제취소"),
		DLG_BUTTON(STARTX+300, STARTY+831, 200, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "▲"),
		DLG_BUTTON(STARTX+500, STARTY+831, 200, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "▼"),
		DLG_BUTTON(STARTX+700, STARTY+831, 300, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "자료수신"),
		
		DLG_TEXT(STARTX+750,    STARTY+65, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		DLG_TEXT(STARTX,	   STARTY+135, 1000, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//기본주소
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_COMBO_LIST (STARTX, 	   STARTY+255, 423, 290, 125, 71, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
	};	
	

	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "해제활동 리스트"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,	 	STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+220,  STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		
		DLG_BUTTON(0, 		   STARTY+825, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLEARCANCEL, "해제취소"),
		DLG_BUTTON(STARTX+310, STARTY+825, 180, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "▲"),
		DLG_BUTTON(STARTX+500, STARTY+825, 180, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "▼"),
		DLG_BUTTON(STARTX+690, STARTY+825, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "자료수신"),
		
		DLG_TEXT(STARTX,	   STARTY+150, 985, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//기본주소

		DLG_TEXT(STARTX+585,   STARTY+70, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_COMBO_LIST (STARTX, 	   STARTY+260, 400, 290, 125, 69, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
	};
	


	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);

		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i;
		char szTmp[200];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "SELECT MTR_NUM FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' AND ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 20, m_szMtrNum);
			
			SetData();
			if( Str_Cmp(stClear.CUT_JOB_FLAG, "10") == 0 )
			{
				Card_Move("C6202_NPSTOP");
			}
			else
			{
				Card_Move("C6202_CLEAR");
			}
		}
		
		return;
	}
	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
	void	OnInit(char bFirst)
	{
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}
				
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "주소", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "상호", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "성명", 0, ICON_NONE);

				g_nAddrFlag = 0;
				Mem_Set( (byte*)m_szCobSel, 0x00, sizeof(m_szCobSel));
				Str_Cpy(m_szCobSel, "주소");
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);
				
				g_nAddrFlag = 0;
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
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		
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

//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		char szMsg[100];
		char szcmb[20];
		char sztmp[200];
		
		if( INIT_MAIN == m_bFirst )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				if ( index-1 == m_nActIndex )
				{
					//선택된 파일의 위치 INDEX를 글로벌변수에 저장
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					SetData();
					
					if( Str_Cmp(stClear.CUT_JOB_FLAG, "10") == 0 )
					{
						Card_Move("C6202_NPSTOP");
					}
					else
					{
						Card_Move("C6202_CLEAR");
					}
					
					return;
				}
				else
				{
					m_nActIndex = index - 1;//선택된 INDEX 저장
				
					//처음 선택된 대상의 주소를 상단에 표시
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);

					Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
					Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));

					Mem_Set( (byte*)m_szMtrNum, 0x00, sizeof(m_szMtrNum));
					Str_Cpy( m_szMtrNum, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
					
					Mem_Set( (byte*)m_szProc, 0x00, sizeof(m_szProc));
					Str_Cpy( m_szProc, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
					if( Str_Cmp(m_szProc, "Y") == 0 )
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), TRUE );
					}
					else
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), FALSE );
					}
				}
			}
			else
			{
				Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
				Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1) ) );
				//콤보박스 선택으로 리스트 목록 필터링.(검침,미검침,전체대상)
				if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
				{
					Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
					SPRINT(szMsg, "항목을 %s로 변경하시겠습니까?", szcmb, 0, 0);
					if( MessageBoxEx (CONFIRM_YESNO, szMsg)  == MB_OK)
					{
						Str_Cpy(m_szCobSel, szcmb);
						
						REDRAW();
					}
					else
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);
					}
				}
				else
				{
					REDRAW();
				}
			}
		}
	}
	
//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA1), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_PAGE), TRUE, 2, EDITSEP_NONE );
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_QUICK_ADDR:
				Grid_QuickList();
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;
				REDRAW();
				break;
			case BID_NADDR:
				g_nAddrFlag = 1;
				REDRAW();
				break;
			case BID_CLEARCANCEL:
				if( m_nActIndex < 0 )
				{
					MessageBoxEx (CONFIRM_OK, "대상을 선택해주세요.");
				}
				else
				{
					SetData();
					Card_Move("C6202_CLEARCANCEL");
				}
				break;
			case BID_RCV:
				Rcv_Data();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0)
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex = 0;
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
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0 )
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;		
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "체납 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6202_MENU");
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
				Card_Move("C6202_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}	

//------------------------------------------------------------------------------------------
	void SetData(void)
	{
		long i;
		long lindex = 0;
		char szSql[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stClear, 0x00, sizeof(stClear));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql,
"SELECT \
MTR_NUM, PROD_CONT_SEQ, INDI_COMPENS_CUT_VA, INDI_COMPENS_CUT_VC, KEEPER_YN \
, CITY, TRIM(AREA), TRIM(TOWN), TRIM(VILLAGE), TRIM(ADDR1_M), TRIM(ADDR1_S), TRIM(CO_LIVE_NM), TRIM(DONG_NUM), TRIM(HOSU), TRIM(BLD_NM) \
, TRIM(DETAIL_FLOOR), NEW_ADDR_UNION, RMK, SEQ, USE_CONT_NUM, BASE_DTM, NONPAY_MM_CNT \
, NONPAY_AMT, WHY_CD, REQ_EMPID, TREAT_EMPID, CUT_YMD, CUT_TYPE_CD, GMTR_OBJ_FLAG \
, INDI_MTR_CUT, MTR_ID_NUM, PROC, CUT_JOB_FLAG, CURRENT_VA, CURRENT_VC \
, CURRENT_VM, SEALED_STS, CUT_CNL_FEE_EXEMPT_WHY, CUT_CNL_FEE_YN \
, NONPAY_ACTIVE_DEPT, NONPAY_MANAGE_ZONE, INST_PLACE_NUM, RSLT_NOTICE_YN \
, LAW_ETC_AMT, DEBT_AMT, DEBT_UNPAY_AMT, ALL_UNPAY, LAW_TOWN, TRIM(NEW_ROAD_NM) \
, TRIM(NEW_ADDR_M), TRIM(NEW_ADDR_S), CURR_ADDR_UNION, MTR_KIND, RELEASE_YN, STOP_YN \
FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' AND MTR_NUM = ?"
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&m_szMtrNum , 12, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stClear.MTR_NUM               , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.PROD_CONT_SEQ         , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.INDI_COMPENS_CUT_VA   , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.INDI_COMPENS_CUT_VC   , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.KEEPER_YN             , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CITY                  , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.AREA                  , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.TOWN                  , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.VILLAGE               , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.ADDR1_M               , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.ADDR1_S               , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CO_LIVE_NM            , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.DONG_NUM              , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.HOSU                  , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.BLD_NM                , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.DETAIL_FLOOR          , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NEW_ADDR_UNION        , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.RMK                   , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.SEQ                   , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.USE_CONT_NUM          , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.BASE_DTM              , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NONPAY_MM_CNT         , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NONPAY_AMT            , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.WHY_CD                , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.REQ_EMPID             , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.TREAT_EMPID           , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CUT_YMD               , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CUT_TYPE_CD           , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.GMTR_OBJ_FLAG         , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.INDI_MTR_CUT          , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.MTR_ID_NUM            , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.PROC                  , 1  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CUT_JOB_FLAG          , 2  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CURRENT_VA            , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CURRENT_VC            , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CURRENT_VM            , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.SEALED_STS            , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CUT_CNL_FEE_EXEMPT_WHY, 100, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CUT_CNL_FEE_YN        , 2  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NONPAY_ACTIVE_DEPT    , 4  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NONPAY_MANAGE_ZONE    , 6  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.INST_PLACE_NUM        , 9  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.RSLT_NOTICE_YN        , 1  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.LAW_ETC_AMT           , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.DEBT_AMT              , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.DEBT_UNPAY_AMT        , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.ALL_UNPAY             , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.LAW_TOWN              , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NEW_ROAD_NM           , 200, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NEW_ADDR_M            , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.NEW_ADDR_S            , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.CURR_ADDR_UNION       , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.MTR_KIND              , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.RELEASE_YN            , 2  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stClear.STOP_YN               , 2  , DECRYPT );
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		return;
	}

//------------------------------------------------------------------------------------------
	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char sztmp[256];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_SaveSeq( "SELECT ROWID FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M", SREACH_FILE);

		lTotPage = FS_GetSrchTotCnt();
		m_lTotpage = lTotPage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0)
		{
			//프로그램 시작 시 불러오는 인덱스
			//Get_Index();
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = (g_nActIndex % ROW);
			
			g_lMoveFlag = 0;
		}

		SPRINT(m_szCnt_page, "%d/%d,\n%d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "지번\n스크롤");

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, PROC, IFNULL(AREA, '') ||' '|| IFNULL(TOWN, '') ||' '|| IFNULL(VILLAGE, '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, ROWID, MTR_NUM, PAY_FIRM_NM, PAY_CUST_NM, PROC FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M LIMIT ?, ?");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "도로명\n스크롤");

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, PROC, IFNULL(NEW_ROAD_NM, '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, ROWID, MTR_NUM, PAY_FIRM_NM, PAY_CUST_NM, PROC FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M LIMIT ?, ?");
		}

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
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
					continue;
				}
				
				//주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "주소") == 0 )
				{
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "상호") == 0 )
				{
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "성명") == 0 )
				{
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 200, DECRYPT);
				}
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				//월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//체납금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//상태
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//상세주소
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//ROWID
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 5, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				//MTR_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 6, 'U', (long*)sztmp, 12, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
				//PROC
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 9, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//처음 선택된 대상의 주소를 상단에 표시
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			
			Mem_Set( (byte*)g_szROWID, 0x00, sizeof(g_szROWID));
			Str_Cpy( g_szROWID, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));

			Mem_Set( (byte*)m_szMtrNum, 0x00, sizeof(m_szMtrNum));
			Str_Cpy( m_szMtrNum, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));

			Mem_Set( (byte*)m_szProc, 0x00, sizeof(m_szProc));
			Str_Cpy( m_szProc, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
			if( Str_Cmp(m_szProc, "Y") == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), FALSE );
			}
			
			
		}
		else
		{
			m_nActIndex = -1;
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), "");
		
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLEARCANCEL), FALSE );
		}
		
		m_lIdxFlag = 1;
		
		ON_DRAW();		
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
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '9' ", g_lindex, 0, 0);		
		g_Sql_DirectExecute(szSql);
	}
	
	/*=======================================================================================
	함수명 : Get_Index
	기  능 : 최종 인덱스 읽어온다.
	Param  : 
 	Return : TRUE :성공
 			 FALSE:파일이 없을시에 실패
	========================================================================================*/
	void Get_Index(void)
	{
		long lParam9;
		
		g_Sql_RetInt("SELECT PARAM9 FROM RCV_LOG WHERE GUBUN = '9'", &lParam9);
		
		g_nActIndex = lParam9;		
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = (g_nActIndex % ROW);
	}
	
	
//------------------------------------------------------------------------------------------
	long Rcv_Data(void)
	{
		char szNonpayManageZone[200];
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;

		g_Sql_DirectExecute("DELETE FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20'");

		Mem_Set((byte*)szNonpayManageZone, 0x00, sizeof(szNonpayManageZone));	
		g_Sql_RetStr("SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '9'", 10, szNonpayManageZone);

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 83110, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",     szNonpayManageZone );
		JSON_SetValue( g_pjcomm, 'C', "cut_job_flag",           "20" );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR83110; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR83110_IN",  "FR83110" , sndbuf, sztmp );
		return 0 ;
	}
	
	
//------------------------------------------------------------------------------------------
	long TR83110(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(83110) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20'", &ntotcnt);
			
			if(ntotcnt > 0 )
			{
				MessageBoxEx (CONFIRM_OK, "자료수신을 완료하였습니다.");
				REDRAW();
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "자료가 없습니다.");
				REDRAW();
				ON_DRAW();
				return 1;	
			}
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}
	
	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(void)
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
		
		char col_name_Addr[5][32] = {"주소", "개월", "체납금액", "상태", ""};
		char col_name_Firm[5][32] = {"상호", "개월", "체납금액", "상태", ""};
		char col_name_Cust[5][32] = {"성명", "개월", "체납금액", "상태", ""};
		//필드 간격 조정
		char col_weight[5][10] = {"3","1","2","1","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "주소") == 0 )
		{
			if( g_nAddrFlag == 0 )
			{
				Str_Cpy(m_szQuickSql, "SELECT \
CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 \
THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END \
, NONPAY_MM_CNT, ALL_UNPAY, PROC \
FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M");
			}
			else
			{
				Str_Cpy(m_szQuickSql, "SELECT \
CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 \
THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END \
, NONPAY_MM_CNT, ALL_UNPAY, PROC \
FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M");
			}
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "상호") == 0 )
		{
			Str_Cpy(m_szQuickSql, "SELECT PAY_FIRM_NM, NONPAY_MM_CNT, ALL_UNPAY, PROC FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M");
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "성명") == 0 )
		{
			Str_Cpy(m_szQuickSql, "SELECT PAY_CUST_NM, NONPAY_MM_CNT, ALL_UNPAY, PROC FROM C6202_RELEASE WHERE CUT_JOB_FLAG = '20' ORDER BY TOWN, ADDR1_M");
		}

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
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szQuickSql);
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);

				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "주소") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Addr[i]);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "상호") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Firm[i]);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "성명") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Cust[i]);
				}

				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "해제활동 리스트");
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
}



