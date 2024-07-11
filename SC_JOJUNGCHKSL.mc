/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_JOJUNGCHKSL
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
		DEF_BUTTON_ID ( BID_CHECK )		//점검
		DEF_BUTTON_ID ( BID_BARCODE )	//바코드
		DEF_BUTTON_ID ( BID_PHOTO )	    //촬영
		DEF_BUTTON_ID ( BID_SIGN )		//서명
		DEF_BUTTON_ID ( BID_COMPLETE )	//완료
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
		DEF_OBJECT_ID ( TXT_JJGNUM )		//조정기번호
		DEF_OBJECT_ID ( TXT_JUNSOO )		//전수
		DEF_OBJECT_ID ( TXT_WORKTYPE )		//작업구분
		DEF_OBJECT_ID ( TXT_FORM )			//형태
		DEF_OBJECT_ID ( TXT_MODELNM )		//모델명
		DEF_OBJECT_ID ( TXT_JJGSN )			//조정기S/N
		DEF_OBJECT_ID ( TXT_NO )			//NO

		DEF_OBJECT_ID ( TXT_FILTERCHNG )	//필터교체유무
		DEF_OBJECT_ID ( TXT_ETC )			//특이사항
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )			
		DEF_OBJECT_ID ( TXT_DATA8 )

		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트

		DEF_OBJECT_ID ( CMB_FILTERCHNG ) 	
		DEF_OBJECT_ID ( CMB_ETC = CMB_FILTERCHNG+3 ) 			
		DEF_OBJECT_ID ( CMB_BARCODE = CMB_ETC+3 )
	END_OBJECT_ID()
	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+30)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		100 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+330  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+285  	    // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"점검항목"    , CWD*25+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"부"          , CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"조치"        , CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"점검항목코드", 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{""            , 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	#define INIT_JJCHK	2
	
	//체크박스 값 
	#define CHKYES 1
	#define CHKNO  0

	long m_bFirst;
	CodeTable *m_CT;
	long m_nSec_cd;
	long m_lpage = 0;
	long m_lTotpage= 0;
	char m_szCnt_page[10];
	long m_lIdxFlag = 0;	// index 관련 flag
	long m_lActive = -1;
	char m_Title[30];
	char m_szfilenm[128];
	char m_szBarcode_Value[20];	//바코드 스캔 결과
	
	void SetStyle(void);
	void SetCombo(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Tbl_Draw(void);
	void Save_Sign(void);
	bool Save_Result(void);
	void Del_Sc(void);
	bool Validate(void);
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	void Barcode(void);
	void OnBarcodeRead(void);
	void Save_Row(long row, long col);
	bool Save_NotPassItem(char* szREGTR_NOT_PASS_ITEM, char* szCHKGOODYN );
	void Shoto_Photo(void);

	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "조정기 점검(단독)"),
		
		DLG_TEXT(STARTX,       STARTY+65, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "조정기번호"), 
		DLG_TEXT(STARTX+300,   STARTY+65, 325, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+625,   STARTY+65, 200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "전수"),
		DLG_TEXT(STARTX+825,   STARTY+65, 175, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,      STARTY+120, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "작업구분"), 
		DLG_TEXT(STARTX+300,  STARTY+120, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,      STARTY+170, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "형태"), 
		DLG_TEXT(STARTX+300,  STARTY+170, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,      STARTY+220, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODELNM, "모델명"), 
		DLG_TEXT(STARTX+300,  STARTY+220, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,      STARTY+270, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "조정기S/N"),
		DLG_TEXT(STARTX+300,  STARTY+270, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(STARTX,      STARTY+690, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERCHNG, "필터교체유무"),
		DLG_COMBO (STARTX+350,STARTY+690, 650, 290, 150, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_FILTERCHNG, 10),
		DLG_TEXT(STARTX,      STARTY+750, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ETC, "특이사항"),
		DLG_COMBO (STARTX+350,STARTY+750, 650, 290, 150, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ETC, 10),
		
//		DLG_BUTTON(STARTX,    STARTY+570, 300, 140, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "바코드"),
//		DLG_TEXT(STARTX+300,  STARTY+570, 675,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
//		DLG_COMBO(STARTX+300, STARTY+640, 675, 290, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),
		
		DLG_BUTTON(STARTX    , STARTY+819, 333, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "사진촬영"),
		DLG_BUTTON(STARTX+333, STARTY+819, 333, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서명"),
		DLG_BUTTON(STARTX+666, STARTY+819, 334, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLETE, "완료"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "조정기 점검(단독)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX,  	   STARTY-40, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "조정기번호"), 
		DLG_TEXT(STARTX+300,   STARTY-40, 325, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+625,   STARTY-40, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "전수"),
		DLG_TEXT(STARTX+825,   STARTY-40, 175, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,  	   STARTY+25, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "작업구분"), 
		DLG_TEXT(STARTX+300,   STARTY+25, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,       STARTY+90, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "형태"), 
		DLG_TEXT(STARTX+300,   STARTY+90, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,  	  STARTY+155, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODELNM, "모델명"), 
		DLG_TEXT(STARTX+300,  STARTY+155, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,  	  STARTY+220, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "조정기S/N"),
		DLG_TEXT(STARTX+300,  STARTY+220, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		//DLG_BUTTON(STARTX,     STARTY+310, 350, 80, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK, "점검"),
		//DLG_TEXT(STARTX+350,   STARTY+310, 625, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(STARTX,  	   STARTY+640, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERCHNG, "필터교체유무"),
		DLG_COMBO (STARTX+350, STARTY+640, 650, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_FILTERCHNG, 10),
		DLG_TEXT(STARTX,  	   STARTY+720, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ETC, "특이사항"),
		DLG_COMBO (STARTX+350, STARTY+720, 650, 280, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ETC, 10),
		
//		DLG_BUTTON(STARTX,	   STARTY+560, 300, 160, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "바코드"),
//		DLG_TEXT(STARTX+300,   STARTY+560, 675, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
//		DLG_COMBO (STARTX+300, STARTY+640, 675, 160, 80, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),
		
		DLG_BUTTON(STARTX    , STARTY+810, 333, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "사진촬영"),
		DLG_BUTTON(STARTX+333, STARTY+810, 333, 89, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서명"),
		DLG_BUTTON(STARTX+666, STARTY+810, 334, 89, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLETE, "완료"),
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
				SetBtnImg();
				SetCombo();
				SetStyle();
				REDRAW();
				Tbl_Draw();
				break;
		}
	}
	
/*=======================================================================================
========================================================================================*/	
	void	OnSelect(long Index)
	{
		long i = 0;
		long index = -1;
		long lpage;
		char sztmp[20];
		long lrow, lcol;

		
		if( m_bFirst == INIT_MAIN )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				m_lActive = index;
				
				lrow = m_lActive/COL;
				lcol = m_lActive%COL;
				lrow--;

				if( lcol == 1 )
				{
				
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, lcol ) );
					if( Str_Cmp( sztmp, CHKGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), RED);
					}
					else if( Str_Cmp( sztmp, CHKNOGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), BLUE );
					}

					ON_DRAW();
					Save_Row( lrow, lcol );
				}
				else if( lcol == 2 )
				{
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, lcol ) );
					if( Str_Cmp( sztmp, CHKGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), BLUE);
		
					}
					else if( Str_Cmp( sztmp, CHKNOGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), RED );
					}
					
					ON_DRAW();
					Save_Row( lrow, lcol );
				}
				
				m_lActive = index;
		
				lpage = (index/COL);
				g_nChkIndex = index;
				SPRINT(m_szCnt_page, "%d/%d", lpage, m_lTotpage, 0);
				
				ON_DRAW();
			}

			//필터교체유무
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG)), SCFLTCHG );
			if (i == -1)
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "");
			else
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, SCFLTCHG[i].Code);
				PRINT("stScJjChk.FILTER_REPL_FLAG : %s",stScJjChk.FILTER_REPL_FLAG,0,0 );
			//특이사항
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC)), SCRMK );
			if (i == -1)
				Str_Cpy(stScJjChk.SPECIAL_ETC, "");
			else
				Str_Cpy(stScJjChk.SPECIAL_ETC, SCRMK[i].Code);
				
/*
			//바코드불가이유
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), SCBARWHY );
			if (i == -1)
				Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");
			else
				Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY[i].Code);
*/
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		if( m_bFirst == INIT_MAIN )
		{
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
		}
	}
	
	//-----------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JUNSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODELNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGSN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FILTERCHNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ETC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_FILTERCHNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ETC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BARCODE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			Str_Cpy( stScJjNogood.REGTR_NOT_PASS_FLAG, "10");
			m_nSec_cd = 10;
			m_lTotpage = sizeof(SCJJCHKSL)/sizeof( CodeTable )-1;
			m_CT = SCJJCHKSL;
			//Str_Cpy(m_Title, "단독 점검");
		}
	}
	
	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long i, lsign;
	
		switch(ID)
		{
			case BID_CHECK:
				g_lConfrimFlag = 1;
				g_nWorkChkFlag = 20;
				Str_Cpy( stScJjNogood.REGTR_NOT_PASS_FLAG, "10");
				Card_Move("CHK_JOJUNGDTL");
				break;
				
			//case BID_BARCODE:
			//	Barcode();
			//	break;
			case BID_PHOTO:
				Shoto_Photo();
				break;
			case BID_SIGN:
				Save_Sign();
				break;
			case BID_COMPLETE:
				if( Str_Cmp(stScJjChk.CHK_END_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "이미 송신 완료한 자료입니다.");
					break;
				}
				if( Save_Result() )
				{
					g_nBackFlag++;
					
					if( g_nBackFlag > 9)
					{
						g_Db_Backup();
						g_nBackFlag = 0;
					}
				
					if( g_nWorkFlag != 203 )
						Card_Move("SC_CONFIRM");
					else
						Card_Move("SC_JOJUNGLST");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					if( Str_Cmp(stScJjChk.CHK_RSLT, "20") == 0 || Str_Cmp(stScJjChk.CHK_RSLT, "21") == 0 )
					{
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
						Card_Move("MENU");
					}
					else
					{
						Del_Sc();
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
						Card_Move("MENU");
					}
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "조정기점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					if( Str_Cmp(stScJjChk.CHK_RSLT, "20") == 0 || Str_Cmp(stScJjChk.CHK_RSLT, "21") == 0 )
					{
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
						Card_Move("SC_MENU");
					}
					else
					{
						Del_Sc();
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
						Card_Move("SC_MENU");
					}
				}
				break;
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
			case GID_SCREEN:
				g_MOVE_DLG(400);
				break;
			case GID_CMMNWK:
				Card_Move("SC_JOJUNGCHK");
				break;				
			case GID_PREV:
				g_lConfrimFlag = 0;
				
				if( Str_Cmp(stScJjChk.CHK_RSLT, "20") == 0 || Str_Cmp(stScJjChk.CHK_RSLT, "21") == 0 )
				{
					Card_Move("SC_JOJUNGLST");
				}
				else
				{
					Del_Sc();
					Card_Move("SC_JOJUNGLST");
				}
				break;	
			case GID_VMEXIT:
				Del_Sc();
				g_Exit();
				break;
		}
	}		

	/*=======================================================================================
	함수명 : SearchStr
	기  능 : 스트링으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
	long	SearchStr( char *Str, CodeTable *CT)
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
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
			{
				return i;
			}
		}
		return -1;
	}

//-----------------------------------------------------------------	
	void SetCombo(void)
	{
		long i;

		//필터교체유무
		for ( i = 0 ;  SCFLTCHG[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_FILTERCHNG+2), SCFLTCHG[i].Str, 0, ICON_NONE);
		}
		
		//특이사항
		for ( i = 0 ;  SCRMK[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ETC+2), SCRMK[i].Str, 0, ICON_NONE);
		}
/*
		//바코드
		for ( i = 0 ;  SCBARWHY[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BARCODE+2), SCBARWHY[i].Str, 0, ICON_NONE);
		}
*/
	}

//-----------------------------------------------------------------	
	void REDRAW(void)
	{
		char szSql[300];
		char sztmp[50];
		long i;
	
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1 ), g_szREGTR_NUM);	//조정기 번호

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2 ), stScJjChk.MTRCNT);  //전수(계량기 갯수)
		
		//작업구분
		i = SearchCD( stScJjChk.GENER_REGTR_CHK_FLAG, SCWORK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), SCWORK[i].Str);
		
		//형태
		if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "10") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4 ), "단독");
		}
		else if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4 ), "공동");
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5 ), stScJjChk.REGTR_MODEL_NM);  //모델명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6 ), stScJjChk.REGTR_ID_NUM);	  //조정기S/N

/*
		//부적합결과
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT COUNT(*) FROM REGTR_NOGOOD WHERE REGTR_NUM = '%s' AND REGTR_NOT_PASS_FLAG = '10' AND (CORRECTION_FLAG = 'N' OR CORRECTION_FLAG IS NULL)",g_szREGTR_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 10, sztmp );
		if( Str_AtoI(sztmp) > 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7 ), "부적합");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA7 ), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7 ), "양호");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA7 ), TXTFRCOLOR);
		}
*/

		//필터교체유무
		i = SearchCD( stScJjChk.FILTER_REPL_FLAG, SCFLTCHG );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG), SCFLTCHG[1].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG), SCFLTCHG[i].Str);
		}
		
		//특이사항
		/*
		i = SearchCD( stScJjChk.SPECIAL_ETC, SCRMK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ETC), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ETC), SCRMK[i].Str);
		*/
/*
		//바코드
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), stScJjChk.CURR_BAR);
		
		//바코드 미점검 이유
		if(Str_Len(stScJjChk.BAR_NOT_PERMIT_WHY) == 0)
		{
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "10");
		}
		i = SearchCD( stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), SCBARWHY[i].Str);

*/
		//ON_DRAW();
	}

//-----------------------------------------------------------------
	void Tbl_Draw(void)
	{
		long i, idx;
		long k = ROW;
		long lpage = 1;
		long lrow, lcol;
		char szSql[512];
		char szWhere[128];
		char szNOT_PASS_ITEM_CD[3];
		char szCORRECTION_FLAG[3];
		long ret = -1;	
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );

/*
		if( m_lIdxFlag == 1 )
		{
			lpage = g_nChkIndex / COL;
			m_lActive = g_nChkIndex;
			
			lrow = (m_lActive/COL) - 1;
			lcol = m_lActive%COL;

			DlgTbl_SetActive(ID_TBLLIST , m_lActive );
			DlgTbl_SetCellColor(TBL_BKCOLOR, ID_TBLLIST, lrow, lcol, TABLEACTIVE_COLOR);
			
			ON_DRAW();

			m_lIdxFlag = 0;
		}
*/

		SPRINT(m_szCnt_page, "%d/%d", lpage, m_lTotpage, 0);
		
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
			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, m_CT[m_lpage+i].Str );
				
				//2017-10-16 Sanghyun Lee
				//부족한 키값 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				SPRINT(szSql, " SELECT REGTR_NOT_PASS_ITEM FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, "AND REGTR_NOT_PASS_FLAG ='%s' AND REGTR_NOT_PASS_ITEM = '%s' ", stScJjNogood.REGTR_NOT_PASS_FLAG, m_CT[m_lpage+i].Code,0);
				Str_Cat(szSql, szWhere);
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );
				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
				}
				
				//2017-10-16 Sanghyun Lee
				//부족한 키값 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				Mem_Set((byte*)szCORRECTION_FLAG ,0x00, sizeof(szCORRECTION_FLAG) );
				SPRINT(szSql, " SELECT CORRECTION_FLAG FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_FLAG ='%s' and REGTR_NOT_PASS_ITEM = '%s'", stScJjNogood.REGTR_NOT_PASS_FLAG, m_CT[m_lpage+i].Code, 0);
				Str_Cat(szSql, szWhere);
				g_Sql_RetStr( szSql, 3, szCORRECTION_FLAG );
				if( Str_Len(szCORRECTION_FLAG) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else if( Str_Cmp(szCORRECTION_FLAG, "N" ) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else 
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
				}
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, m_CT[m_lpage+i].Code );
			}			
		}
		
		ON_DRAW();
		return;
	}


//-----------------------------------------------------------------
	bool Validate(void)
	{
		if( Str_Cmp( stScJjChk.CHK_END_YN, "Y") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "이미 송신 완료한 자료입니다.");
			return FALSE;
		}
	
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "필터교체유무를 선택해주세요.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "특이사항을 선택해주세요.");
			return FALSE;
		}
		/*
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8))) == 0
		&&  Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "바코드를 스캔해 주세요.");
			return FALSE;
		}
		*/
		return TRUE;
	}

//-----------------------------------------------------------------
	void Save_Sign(void)
	{
		char szSql[500];
		char szToday[20];
		char szTime[7];
		long idx, i;
		long lCount;
		long lsign, lSign_Len;
		char* pRst;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( Str_Cmp( stScJjChk.CHK_END_YN, "Y") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "이미 송신 완료한 자료입니다.");
			goto Finally;
		}
		
		//서명
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		//lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명" );
		lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명", SIGN_OPT_NONE );
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			goto Finally;
		}
		else
		{
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}		

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE REGTR_DATA SET \
						CHK_SIGN_IMAGE = ? WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? and SAFE_CHK_TYPE = ? "
					, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)pRst			            ,Str_Len(pRst) ,DECRYPT);	//서명
		
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM		    ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM		    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	    ,2  ,DECRYPT);


		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}

//-----------------------------------------------------------------
	bool Save_Result(void)
	{
		char szSql[500];
		char szSign[10];
		long lCount;
		long idx;
		long i, lsign;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}

		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT LENGTH(CHK_SIGN_IMAGE) FROM REGTR_DATA WHERE REGTR_NUM = '%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s' "
					, g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		g_Sql_RetInt(szSql, &lsign);

		Str_ItoA(  Time_GetDate(), stScJjChk.CHK_END_DTM, 10 );
		Str_Cpy( stScJjChk.CHK_YMD,stScJjChk.CHK_END_DTM );
		g_Str_TimeType( stScJjChk.CHK_END_DTM+8 , Time_GetTime() );
		
		//필터교체유무
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG)), SCFLTCHG );
		if (i == -1)
			Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "");
		else
			Str_Cpy(stScJjChk.FILTER_REPL_FLAG, SCFLTCHG[i].Code);
		
		//특이사항
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC)), SCRMK );
		if (i == -1)
			Str_Cpy(stScJjChk.SPECIAL_ETC, "");
		else
			Str_Cpy(stScJjChk.SPECIAL_ETC, SCRMK[i].Code);

		//필터교체일자 (교체일때만 작업일자들어가도록)
		if( Str_Cmp( stScJjChk.FILTER_REPL_FLAG, "30") == 0)
			{
				// PRINT("필터교체진행",0,0,0);
				Str_ItoA(  Time_GetDate(), stScJjChk.NEW_FILTER_REPL_YMD, 10 );
				// PRINT("stScJjChk.NEW_FILTER_REPL_YMD : %s",stScJjChk.NEW_FILTER_REPL_YMD,0,0);
				// new_filter_repl_ymd
				//NEW_FILTER_REPL_YMD
			}
/*
		//바코드 
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), SCBARWHY );
		if (i == -1)
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");
		else
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY[i].Code);
		//바코드
		Str_Cpy( stScJjChk.CURR_BAR, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8)) );
*/

		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s'", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		g_Sql_RetInt(szSql, &lCount);
		
		Str_Cpy(stScJjChk.CHK_END_YN, "S");
		
		if( lCount > 0 )
			Str_Cpy(stScJjChk.CHK_RSLT, "21");
		else
			Str_Cpy(stScJjChk.CHK_RSLT, "20");
				
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( lsign > 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			// PRINT("222222222222222222",0,0,0);
/*			
			SPRINT(szSql, "UPDATE REGTR_DATA SET \
			CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ?, CURR_BAR = ? \
			, BAR_NOT_PERMIT_WHY = ?, CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ?, SPECIAL_ETC = ? \
			, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_EXCEP_WHY = ''  \
			, REG1_RSLT = '', REG2_RSLT = '', REG3_RSLT = '' WHERE REGTR_NUM = ? "
						, 0, 0, 0);
*/

			//2017-10-16 Sanghyun Lee
			//부족한 키값 추가
			SPRINT(szSql, "UPDATE REGTR_DATA SET \
			CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ? \
			, CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ?, SPECIAL_ETC = ? \
			, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_EXCEP_WHY = ''  \
			, REG1_RSLT = '', REG2_RSLT = '', REG3_RSLT = '',NEW_FILTER_REPL_YMD = ?  WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ? "
						, 0, 0, 0);
			hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_YN        ,1	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_STR_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,9	,DECRYPT);
			//sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CURR_BAR          ,20	,DECRYPT);
			//sql->Bind(sql, idx++, 'U', (long *)stScJjChk.BAR_NOT_PERMIT_WHY,6	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_YMD           ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.FILTER_REPL_FLAG  ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SECOND_PRESS      ,5	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SPECIAL_ETC       ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor         ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_RSLT          ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.NEW_FILTER_REPL_YMD          ,2	,DECRYPT);

			//2017-10-16 Sanghyun Lee
			//부족한 키값 추가
			sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM               ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM		       ,6  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	       ,2  ,DECRYPT);
		}
		else
		{
			// PRINT("33333333333333333333",0,0,0);
			//사인 값 null입력
			//Mem_Set( (byte*)szSign, 0x00, sizeof(szSign) );
		
			//2017-10-16 Sanghyun Lee
			//부족한 키값 추가
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE REGTR_DATA SET \
			CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ?  \
			, CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ?, SPECIAL_ETC = ? \
			, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_SIGN_IMAGE = '', CHK_EXCEP_WHY = ''  \
			, REG1_RSLT = '', REG2_RSLT = '', REG3_RSLT = '' ,NEW_FILTER_REPL_YMD = ? WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ? "
						, 0, 0, 0);
			hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_YN        ,1	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_STR_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,9	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CURR_BAR          ,20	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.BAR_NOT_PERMIT_WHY,6	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_YMD           ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.FILTER_REPL_FLAG  ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SECOND_PRESS      ,5	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SPECIAL_ETC       ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor         ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_RSLT          ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.NEW_FILTER_REPL_YMD          ,2	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)szSign			           ,Str_Len(szSign) ,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG1_RSLT         ,1	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG2_RSLT         ,1	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG3_RSLT         ,1	,DECRYPT);

			//2017-10-16 Sanghyun Lee
			//부족한 키값 추가
			sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM               ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM		       ,6  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	       ,2  ,DECRYPT);
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "점검이 완료되었습니다.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

//-----------------------------------------------------------------	
	void Barcode(void)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;

		//2017-08-22 Sanghyun Lee
		//카메라 바코드(스마트폰 전용) & 빔 바코드 구분 사용 추가(설정은 공통메뉴에서 진행)
		if( Str_Cmp(g_szBarcodeSet, PHOTO_BARCODE) == 0 && theDevInfo.m_nType > FAMILY_PDA )
		{
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
		else
		{
			//스마트폰 -> Barcode_Init, Barcode_Exit 필요 ,, PDA -> Barcode_Init, Barcode_Exit 불필요 
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				Barcode_Init();
			}

			ret = Barcode_SendCommand( "start" );
		}

		return;
	}
	
//-----------------------------------------------------------------	
	void OnBarcodeRead(void)
	{
	long ret = 0;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			ret = Barcode_Read( m_szBarcode_Value );	
			if( ret < 0)
			{
				MessageBoxEx (CONFIRM_OK, "바코드 읽기 실패");
			}
		}

		//바코드 정보
		Str_Cpy(stScJjChk.CURR_BAR, m_szBarcode_Value);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), m_szBarcode_Value ) ;
		
		//바코드 불가사유
		Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");	
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), TRUE );

		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}

		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	함수명 : Del_Sc
	기  능 : 점검취소
	Param  : 
	Return :
	========================================================================================*/
	void Del_Sc(void)
	{
		char szSql[300];

		//부적합사항
		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s' AND REGTR_NOT_PASS_FLAG ='10' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		g_Sql_DirectExecute( szSql );

		return;
	}
	
//----------------------------------------------------------------------------------------------
	void Save_Row(long row, long col)
	{
		char szSql[400];
		char sztmp[200];
		char szWhere[200];
		char szday[10];
		char szREGTR_NOT_PASS_ITEM[3];
	
		Mem_Set((byte*)szREGTR_NOT_PASS_ITEM ,0x00, sizeof(szREGTR_NOT_PASS_ITEM) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szday ,0x00, sizeof(szday) );
	
		Str_Cpy( szREGTR_NOT_PASS_ITEM, DlgTbl_GetStr( ID_TBLLIST, row, 3) );
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, row, col) );
		if( col == 1 )
		{
			//적합일 경우 항목 삭제
			if(Str_Cmp( sztmp, CHKGOOD) == 0)
			{
				//2017-10-16 Sanghyun Lee
				//부족한 키값 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				SPRINT(szSql, " DELETE FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s'  ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_FLAG ='%s' and REGTR_NOT_PASS_ITEM = '%s'", stScJjNogood.REGTR_NOT_PASS_FLAG, szREGTR_NOT_PASS_ITEM, 0);
				Str_Cat(szSql, szWhere);
				g_Sql_DirectExecute( szSql );
			}
			else // 부적합일 경우 항목 추가
			{	
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, row, 2) );
				Save_NotPassItem( szREGTR_NOT_PASS_ITEM, sztmp );
			}
		}
		else if( col == 2 )
		{
			if(Str_Cmp( sztmp, CHKGOOD) == 0)
			{
				//2017-10-16 Sanghyun Lee
				//부족한 키값 추가
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				SPRINT(szSql, " UPDATE REGTR_NOGOOD SET CORRECTION_FLAG ='N',NOT_PASS_BETTER_YMD='', SEND_YN='S'  WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_FLAG ='%s' AND REGTR_NOT_PASS_ITEM = '%s'", stScJjNogood.REGTR_NOT_PASS_FLAG, szREGTR_NOT_PASS_ITEM, 0);
				Str_Cat(szSql, szWhere);
				g_Sql_DirectExecute( szSql );
			}
			else
			{
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				
				//2017-10-16 Sanghyun Lee
				//부족한 키값 추가
				Str_ItoA( Time_GetDate(),szday,10 );
				SPRINT(szSql, " UPDATE REGTR_NOGOOD SET CORRECTION_FLAG ='Y',NOT_PASS_BETTER_YMD='%s', SEND_YN='S' WHERE REGTR_NUM ='%s' AND REGTR_NOT_PASS_FLAG ='%s' ",szday, g_szREGTR_NUM, stScJjNogood.REGTR_NOT_PASS_FLAG);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_ITEM = '%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s'", szREGTR_NOT_PASS_ITEM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				Str_Cat(szSql, szWhere);
				g_Sql_DirectExecute( szSql );
				
			}
		}
	}
	
//----------------------------------------------------------------------------------------------
	bool Save_NotPassItem(char* szREGTR_NOT_PASS_ITEM, char* szCHKGOODYN )
	{
	long idx, ret;
	SQLITE sql = NewSqLite();
	long nDate;
	char sztmp[20];	
		
		sql->Open(sql);
		if( sql->m_hdb == NULL )
		{
			goto Finally;
		}
		
		//2017-10-16 Sanghyun Lee
		//부족한 키값 추가
		sql->CreateStatement(sql,
"INSERT INTO REGTR_NOGOOD \
(REGTR_NUM          ,CHK_PLAN_YM ,SAFE_CHK_TYPE,REGTR_NOT_PASS_FLAG ,REGTR_NOT_PASS_ITEM,\
NOT_PASS_BETTER_YMD ,CORRECTION_FLAG  ,SEND_YN ,EMP_ID, UPD_EMPID ) \
VALUES(?, ?, ?, ?, ?,  ?, ?, 'S', ?, ? ) " 
		);
		if( sql->m_hdb == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM                    ,8,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_PLAN_YM            ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SAFE_CHK_TYPE          ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjNogood.REGTR_NOT_PASS_FLAG ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szREGTR_NOT_PASS_ITEM            ,2 ,DECRYPT);
		if(Str_Cmp(szCHKGOODYN, CHKNOGOOD) == 0 )//부적합시
		{
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA( Time_GetDate(), sztmp, 10);
			sql->Bind(sql, idx++, 'U', (long *)sztmp       ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)"Y"         ,2 ,DECRYPT);
		}
		else
		{
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			sql->Bind(sql, idx++, 'U', (long *)sztmp      ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)"N"        ,2 ,DECRYPT);
		}	
		
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,9 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

Finally:		
		DelSqLite(sql);

		return TRUE;
	}
	
//----------------------------------------------------------------------------------------------
	void Shoto_Photo(void)
	{
		char sztmp[256];
		char szScrPht[256];
		char szTgrPht[256];
		char szDirPath[256];
		char szREGTR_NOT_PASS_ITEM[3];
		char *pCamera;
		long nRet, lrow, lcol;
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
		Mem_Set((byte*)szREGTR_NOT_PASS_ITEM ,0x00, sizeof(szREGTR_NOT_PASS_ITEM) );
		Str_Cpy( szREGTR_NOT_PASS_ITEM, DlgTbl_GetStr( ID_TBLLIST, lrow, 3) );
		
		
		Str_Cpy(m_szfilenm, g_szREGTR_NUM);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stScJjChk.CHK_PLAN_YM);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stScJjChk.SAFE_CHK_TYPE);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stScJjNogood.REGTR_NOT_PASS_FLAG);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, szREGTR_NOT_PASS_ITEM);
		Str_Cat(m_szfilenm, ".jjp");
		
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_nPhotoFlag = 3;
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_JO,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//원본파일
			//Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_JO,  m_szfilenm, 0);
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

//-----------------------------------------------------------------------------------------------
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

//-----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		char* ptr;
		
		if(nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_BARCODE )
			{
				//카메라 바코드 스캔 값
				Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
				ptr = (char*)System_GetResult((char*)&nRet);
				Str_Cpy(m_szBarcode_Value, ptr);

				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					OnBarcodeRead();
				}
			}
			else if( nData == TASK_CAMERA )
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
					SPRINT (g_szphoto, "%s/%s", PHOTO_JO,  m_szfilenm, 0);
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
	}
}

