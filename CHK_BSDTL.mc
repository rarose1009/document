/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card CHK_BSDTL
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
		DEF_BUTTON_ID ( BID_DISJOINT )	//분해점검
		DEF_BUTTON_ID ( BID_FILTERCLEAN )	//분해점검
		
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
	#define		ROW 	    9					// table의 행개수
	#define		COL 	    6					// table의 열개수
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
		{"구분"        , CWD*7 , EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"점검항목"    , CWD*26+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"부"          , CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"점검항목코드", 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{""            , 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"우선점검여부", 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	long m_lpage;
	long m_lTotpage;
	char m_szCnt_page[10];
	long m_lIdxFlag = 0;	// index 관련 flag
	long m_lActive = -1;
	char m_Title[30];
	char m_szfilenm[128];
	long Chk_Photo(void);
	
	#define INIT_MAIN	1	
	
	CodeTable *m_CT;
	long m_nSec_cd;
	
	void SetStyle(void);
	void REDRAW(void);
	void Save_Row(long row, long col);
	bool Save_NotPassItem(char* szNOT_PASS_ITEM_CD, char* szNOT_PASS_ITEM_NM);
	bool Save_Result(void);
	void Shoto_Photo(void);
	void Photo_View(void);
	//void Save_Page( void );
	void SetBtnImg(void);
	void SetDisjointData(void);
	void SetFilterCleanData(void);
	
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
		
		DLG_BUTTON(STARTX    , STARTY+761, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DISJOINT, "분해점검"),
		DLG_BUTTON(STARTX    , STARTY+761, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FILTERCLEAN, "필터점검"),
		
		
		DLG_BUTTON(STARTX    , STARTY+830, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "사진촬영"),
		DLG_BUTTON(STARTX+500, STARTY+830, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "점 검"),
		
		
		
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

		DLG_TEXT(   STARTX,     STARTY-40, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지				
		DLG_BUTTON( STARTX+500, STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, " ▲"),
		DLG_BUTTON( STARTX+750, STARTY-40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, " ▼"),				

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
		char szSql[300];
		long lCount = 0;
		long lCount2 = 0;
		long lCnt;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		m_nSec_cd = Str_AtoI(stBsNogood.CHK_SEC_CD);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM ='%s' AND GOV_REGTR_FLAG ='10' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			if(m_nSec_cd == 21)
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), FALSE);
			}
			else if(m_nSec_cd == 23)
			{
				if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0)
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), TRUE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), FALSE);
				}
				else
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), FALSE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), FALSE);
				}
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), FALSE);
			}
			else 
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), FALSE);	
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), FALSE);
			}			
		}
		else
		{
			if(m_nSec_cd == 23)
			{
				if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0)
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), TRUE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), FALSE);
				}
				else
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), FALSE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), FALSE);
				}
				
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DISJOINT), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), FALSE);
			}
			
		}

		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
		// g_Sql_RetInt( szSql, &lCnt );

		// if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0 )
		// //조정기이면서 1인치가 아닌거
		// {
		// 	if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
		// 	{
		// 		DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), TRUE);
		// 	}
		// 	else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
		// 	{
		// 		DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), TRUE);
		// 	}
		// }
		// else
		// {
		// 	PRINT("222222222222222222",0,0,0);
		// 	DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_FILTERCLEAN), FALSE);
		// }
		
		Str_Cpy(m_Title, stBsNogood.CHK_SEC_NM);
		Str_Cat(m_Title, " 점검");
		// m_nSec_cd = Str_AtoI(stBsNogood.CHK_SEC_CD);
		
		switch(m_nSec_cd)
		{
			case 21: //정압기점검
				m_lTotpage = sizeof(SCHKGOV)/sizeof( CodeTable )-1;
				m_CT = SCHKGOV;
				break;
			case 23: //조정기점검
				m_lTotpage = sizeof(SCHKREGTR)/sizeof( CodeTable )-1;
				m_CT = SCHKREGTR;
				break;
			case 10: //배관점검
				m_lTotpage = sizeof(SCHKPIPE)/sizeof( CodeTable )-1;
				m_CT = SCHKPIPE;
				break;
			case 70: //배관외점검
				m_lTotpage = sizeof(SCHKPIPEEX)/sizeof( CodeTable )-1;
				m_CT = SCHKPIPEEX;
				break;
		}
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[401];
		long lCount = 0;
		
		switch(ID)
		{					
			case BID_PREVPG:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					//REDRAW();
					return;
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
				if ( !Save_Result() )
					break;
				
				if (Chk_Photo() > 0)
				{
					if( g_nWorkChkFlag == 40 )
					{
						
						Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
						SPRINT(szSql, " SELECT count(*) as cnt FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD,0);
						g_Sql_RetInt( szSql, &lCount );

						if (lCount > 1)
						{
					
							if( MessageBoxEx (CONFIRM_YESNO, "부적합항목이 두개 이상입니다.\n 화면을 나가시겠습니까?")  == MB_OK	)
							{
							g_lGovFlag = 1;
							Card_Move("BS_SPCLBDCHK");
							}
						}
						else
						{
							g_lGovFlag = 1;
							Card_Move("BS_SPCLBDCHK");
						}
					}
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "부적합항목 사진촬영을 해주세요.");
				}

				
				
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");	
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "특정점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
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
				if( Str_Cmp(stUserinfo.szcenter_cd,"91") == 0 
			  	 || Str_Cmp(stUserinfo.szcenter_cd,"92") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"93") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"94") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"95") == 0 )
				{
					g_lGovFlag = 1;
					Card_Move("BS_SPCLBDCHK");
				}
				else
				{
					if( g_nWorkChkFlag == 40 )
					{
						Card_Move("BS_SPCLBDCHK");
					}
				}
				
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
				
			case BID_DISJOINT:
				
				SetDisjointData();
				
			    break;

			case BID_FILTERCLEAN:

				SetFilterCleanData();
				
			    break;

		}
	}

//----------------------------------------------------------------------------	
	void	OnSelect(long Index)
	{
		long index = -1;
		long lpage = 0;
		long lrow, lcol;
		char sztmp[20];
	
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			m_lActive = index;
			
			lrow = m_lActive/COL;
			lcol = m_lActive%COL;
			lrow--;
			
			// PRINT("index **************** : %d" , index,0,0);
			// PRINT("m_lActive ************ : %d",m_lActive,0,0);
			// PRINT("lrow ****************** : %d",lrow,0,0);
			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, lrow, 5), "Y") != 0 )
			{	
				// PRINT("7777777777777777777",0,0,0);
				PRINT("DlgTbl_GetStr( ID_TBLLIST, lrow, 5)2222 : %s",DlgTbl_GetStr( ID_TBLLIST, lrow, 5),0,0);
				if( lcol == 2 )
				{
					// 선택 인덱스와 기존 인덱스가 동일 할 경우
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, 2) );
					if( Str_Cmp( sztmp, CHKGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-2 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-1 ), RED);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), RED);
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-2 ), BLUE );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-1 ), BLUE );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), BLUE );
					}
						
					Save_Row(lrow, lcol);
				}
			}
			else
			{	
				// MessageBoxEx (CONFIRM_OK, "우선점검 부적합 항목은\n제외 할 수 없습니다.");	
				PRINT("DlgTbl_GetStr( ID_TBLLIST, lrow, 5) : %s",DlgTbl_GetStr( ID_TBLLIST, lrow, 5),0,0);
				if( MessageBoxEx (CONFIRM_YESNO, "우선점검 부적합 항목은\n제외 할 수 없습니다. \n\n 개선권고 일자를 입력하시겠습니까?")  == MB_OK)
				{
					g_lGovBetterFlag = 1;
					Card_Move("BS_RFRMRSK");

				}

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
		long lrow, lcol;
		char szSql[401];
		char szTmp[200];
		char szNOT_PASS_ITEM_CD[3];
		char szPRE_CHK_OBJ_YN[3];
		long ret = -1;	
		long lCnt;
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );

		if( m_lActive == -1 )
		{
			m_lActive = 0;
		}
		
		if( g_nPhotoFlag == 4 )
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, m_CT[m_lpage+i].Str );
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				SPRINT(szSql, " SELECT NOT_PASS_ITEM_CD FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, m_CT[m_lpage+i].Code);
				
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );
				
				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szPRE_CHK_OBJ_YN ,0x00, sizeof(szPRE_CHK_OBJ_YN) );
				SPRINT(szSql, " SELECT PRE_CHK_OBJ_YN FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, m_CT[m_lpage+i].Code);
				g_Sql_RetStr( szSql, 3, szPRE_CHK_OBJ_YN );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, szPRE_CHK_OBJ_YN );
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, m_CT[m_lpage+i].title );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, m_CT[m_lpage+i].Code );
			}			
		}	

		ON_DRAW();
		return;
	}
	
	void Save_Row(long row, long col)
	{
	char szNOT_PASS_ITEM_CD[3];
	char szNOT_PASS_ITEM_NM[33];
	char sztmp[20];
	char szfilenm[256];
	char szfilepath[300];
	char szSql[300];
	
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set((byte*)szNOT_PASS_ITEM_NM ,0x00, sizeof(szNOT_PASS_ITEM_NM) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );

		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, row, col) );
		Str_Cpy( szNOT_PASS_ITEM_NM, DlgTbl_GetStr( ID_TBLLIST, row, 1) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, row, 3) );

		//적합일 경우 항목 삭제
		if(Str_Cmp( sztmp, CHKGOOD) == 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
			g_Sql_DirectExecute( szSql );


			//20220328 사진촬영 추가
			
			Str_Cpy(szfilenm , "1");
			Str_Cat(szfilenm , "_");
			Str_Cat(szfilenm , stBsNogood.CHK_EXEC_NUM);
			Str_Cat(szfilenm , "_");

			if(Str_Len(stBsNogood.MTR_NUM) > 0)
			{
				Str_Cat(szfilenm , stBsNogood.MTR_NUM);
			}
			else
			{
				Str_Cat(szfilenm , "000000000");
			}
			
			Str_Cat(szfilenm , "_");
			
			if(Str_Len(stBsNogood.BURNER_NUM) > 0)
			{
				Str_Cat(szfilenm , stBsNogood.BURNER_NUM);
			}
			else
			{
				Str_Cat(szfilenm , "000000");
			}
				
			Str_Cat(szfilenm , "_");
			Str_Cat(szfilenm , stBsNogood.CHK_SEC_CD);
			Str_Cat(szfilenm , "_");
			Str_Cat(szfilenm , szNOT_PASS_ITEM_CD);
			Str_Cat(szfilenm , ".jjp");

			Mem_Set((byte*)szfilepath ,0x00, sizeof(szfilepath) );
			SPRINT (szfilepath, "%s/%s", PHOTO_SC,  szfilenm, 0);
			if( FFS_Exist(szfilepath) )
			{
				FFS_Delete( szfilepath );

				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE NORMAL_NOGOOD_DETAL SET PHOTO = 'N' WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
				g_Sql_DirectExecute( szSql );
			}


		}
		else // 부적합일 경우 항목 추가
		{
			Save_NotPassItem(szNOT_PASS_ITEM_CD, szNOT_PASS_ITEM_NM);

			//부적합 선택시, 사진 호출
			Shoto_Photo();
		}
	}
	
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
		BettePlanymd = Time_DateUpDown(nDate, 30 );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}		
		hstmt = sql->CreateStatement(sql,
		"INSERT INTO SPECIAL_NOGOOD_DETAL \
		( CHK_EXEC_NUM     , CHK_SEC_CD       , MTR_NUM          , BURNER_NUM   , NOT_PASS_ITEM_CD \
		, OBJ_YM           , CHK_YEAR         , CHK_ORDER        , SPECIAL_NUM       \
		, CHK_TYPE         , CHK_SEC_NM       , NOT_PASS_ITEM_NM , VISIT_DTM         \
		, BETTER_PLAN_YMD  , BETTER_YN        , SEND_YN          , PHOTO             \
		, UPD_EMPID        , PDA_IP           , PLAN_YM) \
		VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
			 , ?, ?, ?, ?, 'N', 'S', ?, ?, ?, ? ) " 
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.CHK_EXEC_NUM    ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.CHK_SEC_CD      ,2 ,DECRYPT);
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "000000000");
		if(  Str_Len(stBsNogood.MTR_NUM) > 0  )
			sql->Bind(sql, idx++, 'U', (long *)stBsNogood.MTR_NUM         ,9 ,DECRYPT);
		else
			sql->Bind(sql, idx++, 'U', (long *)sztmp                      ,9 ,DECRYPT);

		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "000000");
		if(  Str_Len(stBsNogood.BURNER_NUM) > 0  )			
			sql->Bind(sql, idx++, 'U', (long *)stBsNogood.BURNER_NUM      ,6 ,DECRYPT);
		else
			sql->Bind(sql, idx++, 'U', (long *)sztmp                      ,6 ,DECRYPT);
			
		sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_CD         ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.OBJ_YM          	  ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_YEAR         	  ,4  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_ORDER        	  ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_NUM       	  ,7  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_TYPE        	  ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.CHK_SEC_NM  	  ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_NM         ,32 ,DECRYPT);
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA( nDate, sztmp, 10);
		g_Str_TimeType(sztmp+8, Time_GetTime( ) );
		sql->Bind(sql, idx++, 'U', (long *)sztmp  , 14 ,DECRYPT);
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA( BettePlanymd, sztmp,10);
		sql->Bind(sql, idx++, 'U', (long *)sztmp , 8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.PHOTO           ,300,DECRYPT);		//길이 임의값 설정
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,15 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PLAN_YM         	  ,6  ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
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
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, 2) );
		if( Str_Cmp( sztmp, CHKGOOD) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "선택한 열이 부적합이 아닙니다.");
			return;
		}
		
		//파일명
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, lrow, 3) );
		Str_Cpy(m_szfilenm , "1");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , stBsNogood.CHK_EXEC_NUM);
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(stBsNogood.MTR_NUM) > 0)
			Str_Cat(m_szfilenm , stBsNogood.MTR_NUM);
		else
			Str_Cat(m_szfilenm , "000000000");
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(stBsNogood.BURNER_NUM) > 0)
			Str_Cat(m_szfilenm , stBsNogood.BURNER_NUM);
		else
			Str_Cat(m_szfilenm , "000000");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , stBsNogood.CHK_SEC_CD);
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , szNOT_PASS_ITEM_CD);
		Str_Cat(m_szfilenm , ".jjp");
	
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_nPhotoFlag = 4;
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//원본파일
			//Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_BS, m_szfilenm,  0);
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

	bool Save_Result(void)
	{
		char szSql[300];
		long lCount;
		long lChk = 0;
		long idx;
		long i;
		bool ret = TRUE;
		long lCnt;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		switch(m_nSec_cd)
		{
			case 21: //정압기점검
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' "
								, g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt(szSql, &lCount);
				if( lCount > 0 )
				{
					Str_Cpy(stBs.GOV_RSLT, "N");
					lChk++;
				}
				else
					Str_Cpy(stBs.GOV_RSLT, "Y");
				
				break;
			case 23: //조정기점검
				//REG_RSLT
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N' "
								, g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt(szSql, &lCount);
				if( lCount > 0 )
				{
					Str_Cpy(stBs.REG_RSLT, "N");
					lChk++;
				}
				else
					Str_Cpy(stBs.REG_RSLT, "Y");

				break;
			case 10: //배관점검
				//PIPE_RSLT
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10'  AND BETTER_YN = 'N' "
								, g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt(szSql, &lCount);
				if( lCount > 0 )
				{
					Str_Cpy(stBs.PIPE_RSLT, "N");
					lChk++;
				}
				else
					Str_Cpy(stBs.PIPE_RSLT, "Y");

				break;
			case 70: //배관외점검
				//PIPEETC_RSLT
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70'  AND BETTER_YN = 'N' "
								, g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt(szSql, &lCount);
				if( lCount > 0 )
				{
					Str_Cpy(stBs.PIPEETC_RSLT, "N");
					lChk++;
				}
				else
					Str_Cpy(stBs.PIPEETC_RSLT, "Y");
				break;
		}		
 
		//부적합결과
		// if( lChk > 0 )
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "N");
		// else
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					GOV_RSLT = ?, REG_RSLT = ?, PIPE_RSLT = ?, PIPEETC_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.GOV_RSLT		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REG_RSLT		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PIPE_RSLT		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PIPEETC_RSLT	,1	,DECRYPT);
		// sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_RSLT	,1	,DECRYPT);
		

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		//PRINT("stGovinfo2.NEW_DISJOINT_CHK_YMD : %s",stGovinfo2.NEW_DISJOINT_CHK_YMD,0,0);
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );

		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0)
		{
			// PRINT("1231232132131231  : %d ",m_nSec_cd,0,0);
			if ( m_nSec_cd == 21)
			{	
				if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
				{	
					MessageBoxEx (CONFIRM_OK, "정압기 분해점검일을 확인하세요.\n(필수)");
					ret = FALSE;
					return ret;
				}
			}	
		}
		else if( m_nSec_cd == 23)
		{
			if( Str_Len(stGovinfo2.NEW_FILTER_CLEAN_YMD) == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0)
			{
				if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
				{
					if( MessageBoxEx (CONFIRM_OK, "조정기 필터청소를 확인하세요.\n(필수)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
				else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
				{
					if( MessageBoxEx (CONFIRM_OK, "조정기 필터청소를 확인하세요.\n(필수)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
			}	
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		long lrow = 0;
		char szNOT_PASS_ITEM_CD[10];
		char szResult[10];
		char szTmp[256];
		char szfilenm[256];
		char szMsg[150];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		long lcol ;
		lcol = m_lActive%COL;
		
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
					SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);

					lrow = m_lActive/COL;
					lrow--;
					Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
					Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, lrow, 3) );					
				
					Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
					SPRINT(szTmp, "UPDATE SPECIAL_NOGOOD_DETAL SET PHOTO = 'Y' WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
					g_Sql_DirectExecute( szTmp );

					Mem_Set((byte*)szResult ,0x00, sizeof(szResult) );
					// Str_Cat(szResult,szNOT_PASS_ITEM_CD);
					Str_Cat(szResult,"\n촬영O");

					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 0 ), GREEN);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 1 ), GREEN);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 2 ), GREEN);
					EditCtrl_SetStr(DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 0 ), szResult);	

					ON_DRAW();
					MessageBoxEx(MESSAGE, "사진이 저장된 항목은 \n 초록색으로 나타납니다.");
					
				}
				
			}
		}

		ON_DRAW();
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{

	long lrow;
	long lcol;
	char szfilenm[256];
	char szNOT_PASS_ITEM_CD[10];
	char szTmp[500];
	long size = 0;

	lcol = m_lActive%COL;
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				
				if( FFS_Exist(szfilenm)  )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h에 정의되어있음
					// ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
					
					size = FFS_GetSize( szfilenm );

					if( size > 1048576 )
					{
						MessageBoxEx (CONFIRM_OK, "사진 용량을 초과하였습니다.\n카메라 설정 혹은 재촬영해주세요.");
					}
					else
					{
						MessageBoxEx( MESSAGE, "사진을 저장중입니다." );
						
						FFS_Copy( szfilenm, g_szphoto );
						
						VmSleep( 100 );
						
						lrow = m_lActive/COL;
						lrow--;
						Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
						Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, lrow, 3) );
						
						Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
						SPRINT(szTmp, "UPDATE SPECIAL_NOGOOD_DETAL SET PHOTO = 'Y' WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
						g_Sql_DirectExecute( szTmp );

						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol-2 ), GREEN);
						
						VmSleep(100);
					}

					VmSleep(100);
					
					FFS_Delete( szfilenm );
					
					VmSleep(100);
					
				}
				
			}
		}
	}
	
	void Photo_View(void)
	{
	char sztmp[256];
	char szfilenm[256];
	char szNOT_PASS_ITEM_CD[3];
		
		Mem_Set((byte*)szfilenm ,0x00, sizeof(szfilenm) );

		//파일명
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3) );
		
		Str_Cpy(szfilenm , "1");
		Str_Cat(szfilenm , "_");
		Str_Cpy(szfilenm , stBsNogood.CHK_EXEC_NUM);
		Str_Cat(szfilenm , "_");
		if(Str_Len(stBsNogood.MTR_NUM) > 0)
			Str_Cat(szfilenm , stBsNogood.MTR_NUM);
		else
			Str_Cat(szfilenm , "000000000");
		Str_Cat(szfilenm , "_");
		if(Str_Len(stBsNogood.BURNER_NUM) > 0)
			Str_Cat(szfilenm , stBsNogood.BURNER_NUM);
		else
			Str_Cat(szfilenm , "000000");
		Str_Cat(szfilenm , "_");
		Str_Cat(szfilenm , stBsNogood.CHK_SEC_CD);
		Str_Cat(szfilenm , "_");
		Str_Cat(szfilenm , szNOT_PASS_ITEM_CD);
		Str_Cat(szfilenm , ".jjp");

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT (sztmp, "%s/%s",PHOTO_BS, szfilenm, 0);
		
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

	/*=======================================================================================
	함수명 : Chk_Photo
	기  능 : 부적합목록 사진파일 존재 여부 확인
	Param  : 
	Return : 
	========================================================================================*/
	long Chk_Photo(void)
	{
		long lNogoodCnt, lPhotoCnt = 0;
		long lPreNogoodCnt,lPrePhotoCnt = 0;
		long lCount = 0;
		long lRet = 0;
		char szSql[400];
		char strMsg[100];
 
		// if(Str_Cmp(szPRE_CHK_OBJ_YN, "Y") != 0)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		g_Sql_RetInt( szSql, &lNogoodCnt );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PHOTO = 'Y' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		g_Sql_RetInt( szSql, &lPhotoCnt );

		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
		// SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PRE_CHK_OBJ_YN = 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		// g_Sql_RetInt( szSql, &lPreNogoodCnt );

		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PHOTO = 'Y' AND PRE_CHK_OBJ_YN = 'Y'",stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, 0);
		// g_Sql_RetInt( szSql, &lPrePhotoCnt );
		
		if( lNogoodCnt == lPhotoCnt )
			{
					lRet = 1;
			}
			else
			{	
				lRet = 0;
			}

		return lRet;
	}
	
	
	/*=======================================================================================
	함수명 : SetDisjointData
	기  능 : 분해점검 데이터 세팅
	Param  : 
	Return : 
	========================================================================================*/	
	void SetDisjointData(void)
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
			   , NEW_DISJOINT_CHK_FIRM_CD, NEW_DISJOINT_CHK_FIRM_NM, CRT_DTM \
		    FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM = ? AND GOV_REGTR_FLAG = '10' "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)stBs.CHK_EXEC_NUM         , 12, DECRYPT);
		
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
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_FIRM_CD    , 3  +1, DECRYPT );
			
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DISJOINT_CHK_FIRM_NM    , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.SEND_YN                 , 1  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.INST_YMD                , 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DETA_LOC                , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_YMD    , 8  +1, DECRYPT );
			
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_FIRM_CD, 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM, 3  +1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.CRT_DTM                 , 30 +1, DECRYPT );	
		}

	Finally:
		DelSqLite(sql);
		g_lGovInflowPath = 1;
		Card_Move("BS_DISJOINTCHK");
		return;
	}
	/*=======================================================================================
	함수명 : SetFilterCleanData
	기  능 : 필터점검 데이터 세팅
	Param  : 
	Return : 
	========================================================================================*/	

	void SetFilterCleanData(void)
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
			   , MAKER_NM, MODEL_CD, MODEL_NM, TRIM(FILTER_CLEAN_YMD), FILTER_CLEAN_FIRM_CD \
			   , FILTER_CLEAN_FIRM_NM, SEND_YN, INST_YMD, DETA_LOC, TRIM(NEW_FILTER_CLEAN_YMD) \
			   , NEW_FILTER_CLEAN_FIRM_CD, NEW_FILTER_CLEAN_FIRM_NM, CRT_DTM ,REGTR_LOC_FLAG , REGTR_STD\
		    FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM = ? AND GOV_REGTR_FLAG = '20' "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)stBs.CHK_EXEC_NUM         , 12, DECRYPT);
		
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
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.FILTER_CLEAN_YMD        , 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.FILTER_CLEAN_FIRM_CD    , 3  +1, DECRYPT );
			
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.FILTER_CLEAN_FIRM_NM    , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.SEND_YN                 , 1  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.INST_YMD                , 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.DETA_LOC                , 30 +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_YMD    , 8  +1, DECRYPT );
			
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_FIRM_CD, 8  +1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM, 3  +1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.CRT_DTM                 , 30 +1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.REGTR_LOC_FLAG          , 2 +1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stGovinfo2.REGTR_STD               , 2 +1, DECRYPT );	

			
		}

	Finally:
		DelSqLite(sql);
		g_lGovInflowPath = 1;
		Card_Move("bs_filter_clean");
		return;
	}

}
