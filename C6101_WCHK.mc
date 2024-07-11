/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WCHK
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
		DEF_BUTTON_ID ( BID_WCUST )
		DEF_BUTTON_ID ( BID_WMTR )
		DEF_BUTTON_ID ( BID_WBUR )
		DEF_BUTTON_ID ( BID_WCHK )
		DEF_BUTTON_ID ( BID_WONE )
		DEF_BUTTON_ID ( BID_WSTOP )
		DEF_BUTTON_ID ( BID_WRELE )
		DEF_BUTTON_ID ( BID_WPAY )
		DEF_BUTTON_ID ( BID_CLOSE )
		
		DEF_BUTTON_ID ( BID_CHGMTR )
		DEF_BUTTON_ID ( BID_WRITE )
		DEF_BUTTON_ID ( BID_UP )
		DEF_BUTTON_ID ( BID_DOWN )
		
		DEF_BUTTON_ID ( BID_CAUSE_RMK )
		DEF_BUTTON_ID ( BID_LOC_RMK )
				
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )
		DEF_BUTTON_ID ( BID_MENU )
		DEF_BUTTON_ID ( BID_KEYBOARD )
		DEF_BUTTON_ID ( BID_SCREEN )
		DEF_BUTTON_ID ( BID_CMMNWORK )
		DEF_BUTTON_ID ( BID_PREV )
		DEF_BUTTON_ID ( BID_EXIT )
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		DEF_OBJECT_ID ( TAB_COVER )
		DEF_OBJECT_ID ( TAB_LINE )
		DEF_OBJECT_ID ( TXT_PAGE )
	
		DEF_OBJECT_ID ( TTL_CIVIL_SERV_CLASS_NM )
		DEF_OBJECT_ID ( TXT_CIVIL_SERV_CLASS_NM )
		DEF_OBJECT_ID ( TTL_PROMISE_ASSIGN_DESC )
		DEF_OBJECT_ID ( TXT_PROMISE_ASSIGN_DESC )
		DEF_OBJECT_ID ( TTL_MEMO )
		DEF_OBJECT_ID ( TXT_MEMO )
		
		DEF_OBJECT_ID ( TTL_ACCIDENT_ACT )    //조치결과
		DEF_OBJECT_ID ( TTL_ACCIDENT_CAUSE )  //발생원인
		DEF_OBJECT_ID ( TTL_ACCIDENT_LOC )    //발생위치
		DEF_OBJECT_ID ( TTL_CAUSE_RMK )    	  //기타_윈인
		DEF_OBJECT_ID ( TXT_CAUSE_RMK )		  //기타_원인
		DEF_OBJECT_ID ( TTL_LOC_RMK )    	  //기타_위치
		DEF_OBJECT_ID ( TXT_LOC_RMK )		  //기타_위치
		
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( CMB_ACCIDENT_ACT )    //조치결과
		DEF_OBJECT_ID ( CMB_ACCIDENT_CAUSE = CMB_ACCIDENT_ACT+3 ) //발생원인
		DEF_OBJECT_ID ( CMB_ACCIDENT_LOC1 = CMB_ACCIDENT_CAUSE+3 ) //발생위치_1	
		DEF_OBJECT_ID ( CMB_ACCIDENT_LOC2 = CMB_ACCIDENT_LOC1+3 ) //발생위치_2	
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1

	#define		W_MAIN		CWD*39+10
	#define		H_MAIN		CHT*21
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    2					// table의 행개수
	#define		COL 	    4					// table의 열개수
	#define		GRID_H		(CHT+15)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX	 			// table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+654	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	#define 	SYH			(CHT+20)
	#define 	Line(x)	    (STARTY+SYH*x)-18
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"기물번호"  , CWD*18,  	EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"설치위치"  , CWD*10, 		EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상품"      , CWD*11+23,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"계량기번호", CWD*0,   	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	 
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	long m_bFirst;
	long m_lpage;
	long m_lTotpage;
	
	char m_szCnt_index[11];     //인덱스 문자열(현재 페이지)
	char m_szComboLoc[30];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void Draw_Tb(void);
	void Save_Memo(void);
	void SetCombo(void);
	bool Save_Chk(void);
	void SetStruct(void);
	void Filter_Combo(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCUST, "고객"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "연소기"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "정산"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WONE, "일회성"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WPAY, "요금"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "중지"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "해제"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WCHK, "점검"),

		DLG_TEXT(  STARTX,     Line(1), 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CIVIL_SERV_CLASS_NM, "점검내용"),
		DLG_TEXT(  STARTX+215, Line(1), 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CIVIL_SERV_CLASS_NM, ""),
		DLG_TEXT(  STARTX,     Line(2), 215, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_PROMISE_ASSIGN_DESC, "접수내용"),
		DLG_TEXT(  STARTX+215, Line(2), 785, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PROMISE_ASSIGN_DESC, ""),
		
		DLG_TEXT(  STARTX,     Line(4), 215, SYH*7+14, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MEMO, "처리내용"),
		
		/* 누출 점검 */
		DLG_TEXT  ( STARTX+215, Line(4), 235, SYH,   0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, YELLOW, TTL_ACCIDENT_ACT, "조치결과"),
		DLG_COMBO ( STARTX+450, Line(4), 550, 200, 150, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ACCIDENT_ACT, 10),
		
		DLG_TEXT  ( STARTX+215, Line(5), 235, SYH,   0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, YELLOW, TTL_ACCIDENT_CAUSE, "발생원인"),
		DLG_COMBO ( STARTX+450, Line(5), 550, 200, 150, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ACCIDENT_CAUSE, 10),

		DLG_TEXT  ( STARTX+215, Line(6), 235, SYH+35, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, YELLOW, TTL_CAUSE_RMK, "원인기타"),
		DLG_BUTTON( STARTX+450, Line(6), 550, SYH+35, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CAUSE_RMK,  ""),
		DLG_EDIT  ( STARTX+450, Line(6), 550, SYH+35, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_CAUSE_RMK, 4, ""),
		
		DLG_TEXT  ( STARTX+215, Line(7)+35, 235, SYH*2,   0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, YELLOW, TTL_ACCIDENT_LOC, "발생위치"),
		DLG_COMBO ( STARTX+450, Line(7)+35, 550, 200, 150, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ACCIDENT_LOC1, 10),
		DLG_COMBO ( STARTX+450, Line(8)+35, 550, 200, 150, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ACCIDENT_LOC2, 10),

		DLG_TEXT  ( STARTX+215, Line(9)+36, 235, SYH+35, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, YELLOW, TTL_LOC_RMK, "위치기타"),
		DLG_BUTTON( STARTX+450, Line(9)+36, 550, SYH+35, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_LOC_RMK,  ""),
		DLG_EDIT  ( STARTX+450, Line(9)+36, 550, SYH+35, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_LOC_RMK, 4, ""),

		/* 일반 점검 */
		DLG_BUTTON(STARTX+215, Line(4), 785, SYH*7+12, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT(  STARTX+215, Line(4), 785, SYH*7+12, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_MEMO, ""),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_BUTTON(STARTX,     GRID_ENDY, 225, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+225, GRID_ENDY, 225, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_TEXT  (STARTX+450, GRID_ENDY, 250, SYH+20, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),
		DLG_BUTTON(STARTX+700, GRID_ENDY, 300, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGMTR,"계량기교체"),
	};	

	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WCUST, "고객"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "연소기"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "정산"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WONE, "일회성"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WPAY, "요금"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WSTOP, "중지"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WRELE, "해제"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC , "", BID_WCHK, "점검"),
		//DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		DLG_TEXT( STARTX+25,  Line(1),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CIVIL_SERV_CLASS_NM, "점검내용"),
		DLG_TEXT( STARTX+240, Line(1),  730, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CIVIL_SERV_CLASS_NM, ""),
		DLG_TEXT( STARTX+25,  Line(2),  215, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_PROMISE_ASSIGN_DESC, "접수내용"),
		DLG_TEXT( STARTX+240, Line(2),  730, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PROMISE_ASSIGN_DESC, ""),
		//DLG_TEXT( STARTX+25,  Line(4),  215, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_MEMO, "처리내용"),
		//DLG_BUTTON(STARTX+240, Line(4),  730, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		//DLG_TEXT( STARTX+240, Line(4),  730, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_MEMO, ""),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	

		DLG_BUTTON( STARTX+670, Line(11)+20, 300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGMTR,"계량기교체"),

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
	long lCnt;	
		m_bFirst = bFirst;
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						Draw_Tb();
						Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, 0, 3)  );
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						Draw_Tb();
						Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, 0, 3)  );
						break;		
				}
				break;
		
		}
		SetBtnImg();
		SetStyle();
		SetCombo();
		ReDraw();
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long nLen;
		char szMsg[100];
		
		switch(ID)
		{
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_MEMO), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MEMO)) );
				Save_Memo();
				break;	

			case BID_CHGMTR:
				if( !Save_Chk() )
				{
					break;
				}
				Save_Memo();
				if( stMw.szMtr_chg_yn[0] == 'Y')
				{
					MessageBoxEx (CONFIRM_OK, "이미 교체된 계량기입니다!");
					return;
				}
				Card_Move("C6101_WCHGMTR");
				break;
			case BID_WCUST:
				if( !Save_Chk() )
				{
					break;
				}
				Save_Memo();
				Card_Move("C6101_WCUST");
				break;
			case BID_WMTR:
				if( !Save_Chk() )
				{
					break;
				}
				Save_Memo();
				if(g_nWorkFlag == 650 || g_nWorkFlag == 660)
				{
					Card_Move("C6101_WMTR");	
				}
				//Card_Move("C6101_WMTR");
				break;
			case BID_WBUR:
				if( !Save_Chk() )
				{
					break;
				}
				Save_Memo();
				Card_Move("C6101_WBUR");
				break;
			case BID_WCHK:
				//Card_Move("C6101_WCHK");
				break;
			case BID_WONE:
				if( !Save_Chk() )
				{
					break;
				}
				Save_Memo();
				Card_Move("C6101_WONE");
				break;
			case BID_WSTOP:
				//Card_Move("C6101_WSTOP");
				break;
			case BID_WRELE:
				//Card_Move("C6101_WRELE");
				break;
			case BID_WPAY:
				if( !Save_Chk() )
				{
					break;
				}
				Save_Memo();
				Card_Move("C6101_WPAY");
				break;			
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Save_Chk();
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "업무 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					if( !Save_Chk() )
					{
						break;
					}
					Card_Move("C6101_MENU");
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
				if( !Save_Chk() )
				{
					break;
				}
				Card_Move("C6101_LST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			case BID_CLOSE:
				if( MessageBoxEx (CONFIRM_YESNO, "작업리스트 화면으로 나가시겠습니까?")  == MB_OK)
				{
					if( !Save_Chk() )
					{
						break;
					}
					Card_Move("C6101_LST");
				}
				break;
			case BID_CAUSE_RMK:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_CAUSE_RMK), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CAUSE_RMK)) );
				
				Mem_Set((byte*)stChk.szAcc_cause_rmk, 0x00, sizeof(stChk.szAcc_cause_rmk));
				Str_Cpy( stChk.szAcc_cause_rmk, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CAUSE_RMK)) );
				
				break;
			case BID_LOC_RMK:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_LOC_RMK), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_LOC_RMK)) );
				
				Mem_Set((byte*)stChk.szAcc_loc_rmk, 0x00, sizeof(stChk.szAcc_loc_rmk));
				Str_Cpy( stChk.szAcc_loc_rmk, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_LOC_RMK)) );

				break;
		}
	}
	
	void	OnSelect(long Index)
	{
		long index = -1;
		char szSql[200];
		//m_szComboLoc
		if( INIT_MAIN == m_bFirst )
		{
			// 현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, index-1, 3)  );
				SetStruct();
				Save_Chk();
				ReDraw();
			}
			else
			{
				Filter_Combo();
				SetStruct();
			}
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
{
	long sX[8], eX[8];
	long lenX;
	long i;
	long TABCNT;
	long starty, highty;
	
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
			Mem_Set((byte*)&sX , 0x00, sizeof(sX));
			Mem_Set((byte*)&eX , 0x00, sizeof(eX));
			//610:전입[고객, 연소기, 상품, 일회성, 요금 ]
			//620:전출[고객, 연소기, 정산,  일회성, 요금 ]
			//630:중지[고객, 정산, 중지, 일회성, 요금 ]
			//640:해제[고객, 해제, 일회성, 요금 ]
			//650:교체[고객, 연소기, 일회성, 요금 ]
			//660:점검[고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
			if(   g_nWorkFlag == 640 || g_nWorkFlag == 650 )
			{
				TABCNT = 4;
				//lenX = CWD*9+20;
				lenX = CWD*10;
				
				sX[0] = 0;
			}
			else if(g_nWorkFlag == 660)
			{
				PRINT("stMw.szCivil_serv_class_cd : %s",stMw.szCivil_serv_class_cd,0,0);
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
					TABCNT = 6;
					lenX = 166;
				}
				else{
					TABCNT = 5;
					lenX = 200;
				}
				
				sX[0] = 0;
			}
			else
			{
				TABCNT = 5;
				//lenX = CWD*7+19;
				lenX = CWD*8;
				
				sX[0] = 0;
			}
			
			//sX[0] = 20;
			for(i = 0 ; i < TABCNT ; i++)
			{
				//eX[i] = sX[i] + lenX+5;
				eX[i] = sX[i] + lenX;
				sX[i+1] = eX[i];
			}
			starty = STARTY-29;
			highty = STARTY+40;
			
			i = 0;
			//업무별공통 업무[고객, 계량기, 연소기]
			if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  "누설점검" );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  stMw.szPda_duty );
			}
			
			//각 업무에 따라 탭을 없앰.
			if( g_nWorkFlag == 610 )
			{
				//610:전입[고객, 연소기, 상품, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );
				
			}
			else if( g_nWorkFlag == 620 )
			{
				//620:전출[고객, 연소기, 정산,  일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST),sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "정산" );
			}
			else if( g_nWorkFlag == 630 )
			{
				//630:중지[고객, 정산, 중지, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// 연소기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WSTOP), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "정산" );
			}
			else if( g_nWorkFlag == 640 )
			{
				//640:해제[고객, 해제, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// 연소기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WRELE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
			}
			else if( g_nWorkFlag == 650 )
			{
				//650:교체[고객, 연소기, 계량기, 일회성, 요금 ]
				//650:교체[고객, 연소기, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );
			}
			else if( g_nWorkFlag == 660 )
			{
				//660:점검[고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0){
					BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
					i++;
				}
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCHK), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );
				//선택된 탭을 활성화된것처럼 보이게 함.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[2]+4, highty-5, eX[2]-4, highty+5 );
			}
		}
	}

//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_PAGE                    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_CIVIL_SERV_CLASS_NM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_CIVIL_SERV_CLASS_NM     ), EDITALIGN_MIDDLE                  );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_PROMISE_ASSIGN_DESC     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_PROMISE_ASSIGN_DESC     ), EDITALIGN_MIDDLE                  );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_MEMO                    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_MEMO                    ), EDITALIGN_MIDDLE                  );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_ACCIDENT_ACT            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_ACCIDENT_CAUSE          ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_ACCIDENT_LOC            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_CAUSE_RMK               ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_CAUSE_RMK               ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_LOC_RMK                 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_LOC_RMK                 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE );

			EditCtrl_SetMultiLine( Get_hDlgCtrlByID( TXT_PROMISE_ASSIGN_DESC  ), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID( TXT_MEMO                 ), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID( TXT_CAUSE_RMK            ), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine( Get_hDlgCtrlByID( TXT_LOC_RMK              ), TRUE, 2, EDITSEP_NONE );
			
			// 20180824, 누설점검인 경우 추가
			if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) == 0 )
			{
				
				// 메모
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_MEMO), FALSE);
				
				// 조치결과
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_ACCIDENT_ACT), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_ACT), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_ACT+1), TRUE);	
				
				// 발생원인
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_ACCIDENT_CAUSE), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), TRUE);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), TRUE );
				
				// 원인기타
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_CAUSE_RMK), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), TRUE);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), TRUE );
				
				// 발생위치
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_ACCIDENT_LOC), TRUE);
				// 발생위치1
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), TRUE);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), TRUE );
				// 발생위치2
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), TRUE);
					
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), TRUE );

				// 위치기타
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_LOC_RMK), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), TRUE);	
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), TRUE );
			}
			else
			{
				// 메모
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_MEMO), TRUE);
				
				// 조치결과
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_ACCIDENT_ACT), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_ACT), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_ACT+1), FALSE);	
				
				// 발생원인
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_ACCIDENT_CAUSE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), FALSE);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), FALSE );
				
				// 원인기타
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_CAUSE_RMK), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), FALSE);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), FALSE );
				
				// 발생위치
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_ACCIDENT_LOC), FALSE);
				// 발생위치1
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), FALSE);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), FALSE );
				// 발생위치2
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), FALSE);
					
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), FALSE );

				// 위치기타
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TTL_LOC_RMK), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), FALSE);	
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), FALSE );
			}
		}
	}
	
	void ReDraw(void)
	{
		char sztmp[200];
		char szSql[500];
		long i, n;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		
		SQLITE sql = NewSqLite();
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CIVIL_SERV_CLASS_NM ), stMw.szCivil_serv_class_nm );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_PROMISE_ASSIGN_DESC ), stMw.szPromise_assign_desc );
		
		if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) != 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MEMO ), stMw.szMemo );
			return;
		}
		
		Mem_Set((byte*)&stChk, 0x00, sizeof(stChk));
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT PROMISE_ASSIGN_SEQ, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, ACC_TAKE_ACT, ACC_CAUSE \
										        , ACC_CAUSE_RMK, ACC_LOC1, ACC_LOC2, ACC_LOC_RMK \
		                                     FROM C6101_PROMISE_CHK \
		                                    WHERE PROMISE_ASSIGN_SEQ = ? ");

		if( hstmt == NULL )
		{
		    PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
		    goto Finally;
		}	

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)stMw.szPromise_assign_seq, 10, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stChk.szPromise_assign_seq, 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChk.szCivil_serv_receive_num, 14+1, DECRYPT);
			sql->GetValue( sql, i++, 'U', (long*)stChk.szTreat_seq             , 10+1, DECRYPT);
			sql->GetValue( sql, i++, 'U', (long*)stChk.szAcc_take_act      , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChk.szAcc_cause         , 2  +1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*)stChk.szAcc_cause_rmk     , 50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChk.szAcc_loc1          , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChk.szAcc_loc2          , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChk.szAcc_loc_rmk       , 50 +1, DECRYPT );
		};
		
Finally:
		DelSqLite(sql);

		// 조치결과
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55001' AND CODE_ITEM = '%s'", stChk.szAcc_take_act, 0, 0   );
		g_Sql_RetStr( szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_ACT), sztmp );
		
		// 발생원인
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55002' AND CODE_ITEM = '%s'", stChk.szAcc_cause, 0, 0   );
		g_Sql_RetStr( szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_CAUSE), sztmp );
		
		// 원인기타
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CAUSE_RMK), stChk.szAcc_cause_rmk );
		
		// 발생위치1
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55003' AND CODE_ITEM = '%s'", stChk.szAcc_loc1, 0, 0   );
		g_Sql_RetStr( szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1), sztmp );
		
		// 발생위치2
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "가정용렌지") == 0 
		 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "업소용렌지") == 0 
		 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "기타연소기") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55004' AND CODE_ITEM = '%s'", stChk.szAcc_loc2, 0, 0   );
			g_Sql_RetStr( szSql, 10, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), sztmp );
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "보일러") == 0  )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55005' AND CODE_ITEM = '%s'", stChk.szAcc_loc2, 0, 0   );
			g_Sql_RetStr( szSql, 10, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), sztmp );
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "계량기") == 0  )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55006' AND CODE_ITEM = '%s'", stChk.szAcc_loc2, 0, 0   );
			g_Sql_RetStr( szSql, 10, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), sztmp );
		}
		
		// 위치기타
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_LOC_RMK), stChk.szAcc_loc_rmk );
		
		if( stMw.szMtr_chg_yn[0] == 'Y')
		{
			//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHGMTR), RED);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CHGMTR), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHGMTR), BTNMENUFRCOLOR);
		}
		else
		{
			//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHGMTR), BTNMENUFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CHGMTR), BTNCTRLBKCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHGMTR), BTNMENUFRCOLOR);
		}
		
		Filter_Combo();
	}
	
	void Draw_Tb(void)
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	char sztmp[100];
	char szSql[200];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, "SELECT MTR_ID_NUM, MTR_LOC_FLAG_NM, PROD_NM, MTR_NUM FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = ? ORDER BY MTR_ID_NUM LIMIT ?, ? " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
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
				k = i + 1;
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
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 26, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , 1 );
			DlgTbl_SetRowColor(ID_TBLLIST, 1, TABLEACTIVE_COLOR);
			
			Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, 0, 3)  );
			
		}
		
		
		ON_DRAW();
	}
	
	void Save_Memo(void)
	{
		Mem_Set( (byte*)stMw.szMemo, 0x00, sizeof(stMw.szMemo) );
		Str_Cpy(stMw.szMemo, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_MEMO )) );
	}
	
		
	void SetCombo(void)
	{
		char szSql[500];

		// 조치결과
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55001' ", CMB_ACCIDENT_ACT+2);

		return;
	}
	
	bool Save_Chk(void)
	{
		char szSql[650];
		char szToday[20];
		char szMsg[100];
		
		long idx;
		long i;
		long lCnt;
		long nLen;
		
		bool ret = TRUE;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) != 0 )
		{
			return TRUE;
		}
		
		/**** 조치결과 체크 ****/
		if( Str_Cmp( stChk.szAcc_take_act, "" ) == 0 )
		{
			return TRUE;
		}
		
		/**** 글자수 체크 ****/
		//1. TXT_CAUSE_RMK
		nLen = 0;
		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CAUSE_RMK)));
		
		if( nLen > 300 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "[원인기타 저장실패]\n글자수 100자 까지만\n입력가능합니다.", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			
			return FALSE;
		}
		
		//2. TXT_LOC_RMK
		nLen = 0;
		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_LOC_RMK)));
		
		if( nLen > 300 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "[위치기타 저장실패]\n글자수 100자 까지만\n입력가능합니다.", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			
			return FALSE;
		}
		
		SetStruct();
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(1) FROM C6101_PROMISE_CHK WHERE PROMISE_ASSIGN_SEQ = '%s' ", stMw.szPromise_assign_seq, 0, 0);
		g_Sql_RetInt(szSql, &lCnt);	
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		if( lCnt > 0 )
		{
			SPRINT(szSql, " UPDATE C6101_PROMISE_CHK \
			                   SET ACC_TAKE_ACT = ?, ACC_CAUSE = ?, ACC_CAUSE_RMK = ?, ACC_LOC1 = ?, ACC_LOC2 = ? \
			                     , ACC_LOC_RMK = ?, SEND_YN = 'S' \
			                 WHERE PROMISE_ASSIGN_SEQ = '%s' "
			      , stMw.szPromise_assign_seq, 0, 0);
		}
		else
		{
			SPRINT(szSql, " INSERT INTO C6101_PROMISE_CHK \
			                ( ACC_TAKE_ACT, ACC_CAUSE, ACC_CAUSE_RMK, ACC_LOC1, ACC_LOC2 \
			                , ACC_LOC_RMK, PROMISE_ASSIGN_SEQ, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, SEND_YN ) \
			                VALUES( ?, ?, ?, ?, ? \
					              , ?, ?, ?, ?, 'S' ) "
			      , 0, 0, 0);
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stChk.szAcc_take_act      , 2 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChk.szAcc_cause      	 , 2 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChk.szAcc_cause_rmk     , 50+1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChk.szAcc_loc1      	 , 2 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChk.szAcc_loc2      	 , 2 +1, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stChk.szAcc_loc_rmk          , 50+1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szPromise_assign_seq    , 10+1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCivil_serv_receive_num, 14+1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szTreat_seq             , 10+1, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		return TRUE;
	}
	
	void SetStruct(void)
	{
		char szSql[300];
		
		if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) != 0 )
		{
			return;
		}
		
		Mem_Set((byte*)&stChk, 0x00, sizeof(stChk));
		
		// PROMISE_ASSIGN_SEQ
		Str_Cpy( stChk.szPromise_assign_seq, stMw.szPromise_assign_seq );
		
		// CIVIL_SERV_RECEIVE_NUM
		Str_Cpy( stChk.szCivil_serv_receive_num, stMw.szCivil_serv_receive_num );
		
		// TREAT_SEQ
		Str_Cpy( stChk.szTreat_seq, stMw.szTreat_seq );
		
		// ACC_TAKE_ACT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C55001' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_ACT)), 0, 0);
		g_Sql_RetStr( szSql, 10, stChk.szAcc_take_act );
		
		// ACC_CAUSE
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C55002' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_CAUSE)), 0, 0);
		g_Sql_RetStr( szSql, 10, stChk.szAcc_cause );
		
		// ACC_CAUSE_RMK
		Str_Cpy( stChk.szAcc_cause_rmk, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_CAUSE_RMK)) );
		
		// ACC_LOC1
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C55003' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), 0, 0);
		g_Sql_RetStr( szSql, 10, stChk.szAcc_loc1 );
		
		// ACC_LOC2
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "가정용렌지") == 0 
		 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "업소용렌지") == 0 
		 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "기타연소기") == 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C55004' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2)), 0, 0   );
			g_Sql_RetStr( szSql, 10, stChk.szAcc_loc2 );

		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "보일러") == 0  )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C55005' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2)), 0, 0   );
			g_Sql_RetStr( szSql, 10, stChk.szAcc_loc2 );
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "계량기") == 0  )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C55006' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2)), 0, 0   );
			g_Sql_RetStr( szSql, 10, stChk.szAcc_loc2 );
		}
		
		// ACC_LOC_RMK
		Str_Cpy( stChk.szAcc_loc_rmk, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_LOC_RMK)) );
	}
	
	void Filter_Combo(void)
	{
		char szSql[500];
		
		if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) != 0 )
		{
			return;
		}
		
		// 조치결과
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_ACT)), "이상없음") != 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_ACT)), "") != 0)
		{
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_CAUSE+2 ) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55002' ", CMB_ACCIDENT_CAUSE+2);
				
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), FALSE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), FALSE );	
		}
		else
		{
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_CAUSE+2 ) );
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1+2 ) );
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_CAUSE), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CAUSE_RMK), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_LOC_RMK), "" );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_CAUSE+1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), TRUE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), TRUE );		
		}
		
		// 발생원인
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_CAUSE)), "") != 0 )
		{
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1+2 ) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55003' ", CMB_ACCIDENT_LOC1+2);
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1), FALSE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC1+1), FALSE );
			
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_CAUSE)), "기타") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), FALSE );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CAUSE_RMK), "" );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CAUSE_RMK), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_CAUSE_RMK), TRUE );
			}
		}
		else
		{
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1+2 ) );
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );

			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), "" );
		}
		
		// 발생위치1
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "기타") != 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "") != 0)
		{
			if( Str_Cmp(m_szComboLoc,"연소기") == 0 
			&& ( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "보일러") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "계량기") == 0 ) )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), "" );
			}
			else if( Str_Cmp(m_szComboLoc,"보일러") == 0 
			&& ( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "가정용렌지") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "업소용렌지") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "기타연소기") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "계량기") == 0) )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), "" );
			}
			else if( Str_Cmp(m_szComboLoc,"계량기") == 0 
			&& ( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "가정용렌지") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "업소용렌지") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "기타연소기") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "보일러") == 0) )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), "" );
			}

			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "가정용렌지") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "업소용렌지") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "기타연소기") == 0 )
			{
				Mem_Set( (byte*)m_szComboLoc, 0x00, sizeof(m_szComboLoc) );
				Str_Cpy(m_szComboLoc, "연소기");
				
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55004' ", CMB_ACCIDENT_LOC2+2);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "보일러") == 0 )
			{
				Mem_Set( (byte*)m_szComboLoc, 0x00, sizeof(m_szComboLoc) );
				Str_Cpy(m_szComboLoc, "보일러");
				
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55005' ", CMB_ACCIDENT_LOC2+2);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "계량기") == 0 )
			{
				Mem_Set( (byte*)m_szComboLoc, 0x00, sizeof(m_szComboLoc) );
				Str_Cpy(m_szComboLoc, "계량기");
				
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C55006' ", CMB_ACCIDENT_LOC2+2);
			}
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), FALSE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), FALSE );
		}
		else
		{
			Mem_Set( (byte*)m_szComboLoc, 0x00, sizeof(m_szComboLoc) );
			Str_Cpy(m_szComboLoc, "");
			
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2+2 ) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2), "" );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ACCIDENT_LOC2+1), TRUE );
		}
		
		// 발생위치2
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC1)), "기타") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ACCIDENT_LOC2)), "기타") == 0 )
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), FALSE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_LOC_RMK), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_LOC_RMK), TRUE );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_LOC_RMK), "" );
		}
	}
}



