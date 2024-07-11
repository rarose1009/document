/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_MTRCHK
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_UART
	#define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CAMERA )	//촬영
		DEF_BUTTON_ID ( BID_CAMERA2 )	//촬영
		DEF_BUTTON_ID ( BID_PIPE )		//배관점검
		DEF_BUTTON_ID ( BID_OK )		//확인
	 	DEF_BUTTON_ID ( BID_DETA_LOC )  //상세위치

	 	DEF_BUTTON_ID ( BID_UP )
		DEF_BUTTON_ID ( BID_DOWN )
		
		//대용량
		DEF_BUTTON_ID ( BID_OK2 )
		DEF_BUTTON_ID ( BID_CAMERA3 )
		
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
		DEF_OBJECT_ID ( TXT_GR )			//계량기점검
		DEF_OBJECT_ID ( TXT_NO )			//NO
		DEF_OBJECT_ID ( TXT_ITEM )			//점검항목
		DEF_OBJECT_ID ( TXT_BOO )			//부
		DEF_OBJECT_ID ( TXT_BLOCK )			//차단장치
		DEF_OBJECT_ID ( TXT_NO2 )			//NO
		DEF_OBJECT_ID ( TXT_ITEM2 )			//점검항목
		DEF_OBJECT_ID ( TXT_BOO2 )			//부
		DEF_OBJECT_ID ( TXT_LTGUIDE )		//전월지침
		DEF_OBJECT_ID ( TXT_THGUIDE )		//현지침
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_PAGE )
		
//대용량계량기
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )

		
		
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
		
		DEF_OBJECT_ID ( EDT_DATA1 )
//대용량
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		
		DEF_OBJECT_ID ( ID_MTRLIST )
		DEF_OBJECT_ID ( ID_EXCEPLIST )
		DEF_OBJECT_ID ( ID_BIGLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )
		
	    DEF_OBJECT_ID ( TXT_DETA_LOC )
		DEF_OBJECT_ID ( EDT_DETA_LOC )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(계량기점검)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_M	    3					// table의 행개수
	#define		COL_M	    4					// table의 열개수
	#define		GRID_H_M	(CHT+20)			// table 행 높이
	#define		GRID_H_M_P	(CHT+25)			// table 행 높이 PDA
	#define		GRID_CLR_M	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_M	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_M	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_M	STARTY+130  	    // table 시작y좌표
	#define		GRID_Y_M_P  STARTY+30  	    // table 시작y좌표
	#define		GRID_ENDY_M	(GRID_Y_M+(ROW_M+1)*GRID_H_M) //table마지막 row의 Y값
	
	char	m_szTableBuf_M [COL_M*(ROW_M+1)*MAXCHAR_M]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_M[] = {
		{"NO"          , CWD*7 , EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"점검항목"    , CWD*26+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"부"          , CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"우선점검여부", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(차단장치 점검)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_E 	    2					// table의 행개수
	#define		COL_E 	    4					// table의 열개수
	#define		GRID_H_E	(CHT+20)			// table 행 높이
	#define		GRID_H_E_P	(CHT+25)			// table 행 높이 PDA
	#define		GRID_CLR_E	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_E	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_E	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_E	STARTY+515  	    // table 시작y좌표
	#define		GRID_Y_E_P  STARTY+460  	    // table 시작y좌표
	#define		GRID_ENDY_E	(GRID_Y_E+(ROW_E+1)*GRID_H_E) //table마지막 row의 Y값
	char		m_szTableBuf_E [COL_E*(ROW_E+1)*MAXCHAR_E]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_E[] = {
		{"NO"          , CWD*7 , EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"점검항목"    , CWD*26+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"부"          , CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"우선점검여부", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(대용량 계량기 점검)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_B	    5					// table의 행개수
	#define		COL_B 	    5					// table의 열개수
	#define		GRID_H_B	(CHT+20)			// table 행 높이
	#define		GRID_H_B_P	(CHT+30)			// table 행 높이 PDA
	#define		GRID_CLR_B	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_B	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_B	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_B	STARTY-29   	    // table 시작y좌표
	#define		GRID_Y_B_P	STARTY-40	        // table 시작y좌표
	#define		GRID_ENDY_B	(GRID_Y_B+(ROW_B+1)*GRID_H_B) //table마지막 row의 Y값
	char		m_szTableBuf_B [COL_B*(ROW_B+1)*MAXCHAR_B]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_B[] = {
		{"NO"          , CWD*7 , EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"점검항목"    , CWD*26+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"부"          , CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"점검항목코드", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"우선점검여부", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};

	#define INIT_MAIN	1
	#define INIT_BIGMTR 2
	
	CodeTable *m_CT_M;
	CodeTable *m_CT_E;
	CodeTable *m_CT_B;
	
	long m_bFirst;
	long m_lTblAct = -1;
	long m_lMtrAct = -1;
	long m_lExcAct = -1;
	long m_lBigAct = -1;
	long m_lActiveIndex = -1;
	char m_szSec_cd_M[30];		//계량기
	char m_szSec_cd_E[30];		//차단장치
	char m_szSec_cd_B[30];		//보정기(대용량계량기)
	char m_szSec_nm_M[10];		//계량기
	char m_szSec_nm_E[10];		//차단장치
	char m_szSec_nm_B[10];		//보정기(대용량계량기)
	char m_szfilenm[128];
	
	char m_szCnt_page[10];
	long m_lpage;
	long m_lpage_text;
	long m_lTotpage;
	long m_lActive = -1;
	long m_nChkIndex; 
	
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void MTR_DRAW(void);
	void EXC_DRAW(void);
	void BIG_DRAW(void);
	void Save_Row(long row, long col);
	bool Save_NotPassItem(char* szNOT_PASS_ITEM_CD, char* szNOT_PASS_ITEM_NM);
	bool Save_Chk(void);
	bool Save_Result(void);
	void Chk_MtrNogood(void);
	void Del_PipeData(void);
	void Shoto_Photo(long nButtonId);
	void Photo_View(void);
	long Chk_Photo(void);
	long Chk_BigPhoto(void);
	

	
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
		NORM_DLG  ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON  (0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT  (TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "계량기 점검"),
		
		DLG_TEXT  (STARTX,     STARTY+65, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GR, "계량기점검"),
		DLG_BUTTON(STARTX+700, STARTY+65, 300, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA, "사진"),
		DLG_TABLE (GRID_X_M,   GRID_Y_M, ROW_M, COL_M, 0, GRID_H_M, 1, GRID_H_M, SEL_COL, MAXCHAR_M, m_stGridTitle_M, ID_MTRLIST, m_szTableBuf_M),
		
		DLG_TEXT  (STARTX,     STARTY+370, 500, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500, STARTY+370, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750, STARTY+370, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		
		DLG_TEXT  (STARTX,     STARTY+450, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BLOCK, "차단장치"),
		DLG_BUTTON(STARTX+700, STARTY+450, 300, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA2, "사진"),
		DLG_TABLE (GRID_X_E,   GRID_Y_E, ROW_E, COL_E, 0, GRID_H_E, 1, GRID_H_E, SEL_COL, MAXCHAR_E, m_stGridTitle_E, ID_EXCEPLIST, m_szTableBuf_E),
		
		DLG_TEXT  (STARTX,     STARTY+709, 270, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTGUIDE, "전월지침"),
		DLG_TEXT  (STARTX+270, STARTY+709, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT  (STARTX+520, STARTY+709, 210, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_THGUIDE, "현지침"),
		DLG_EDIT  (STARTX+730, STARTY+709, 270, 60, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 10,  ""),
		
		DLG_TEXT  (STARTX,     STARTY+769, 270, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DETA_LOC, "상세위치"),
		DLG_BUTTON(STARTX+270, STARTY+769, 730, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DETA_LOC,  ""),	
		DLG_EDIT  (STARTX+270, STARTY+769, 730, 60, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DETA_LOC, 20,  ""),
		
		DLG_BUTTON(STARTX,	   STARTY+829, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PIPE, "배관점검"),
		DLG_BUTTON(STARTX+500, STARTY+829, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		//숫자 자판
		DLG_TEXT(0,   STARTY+940,  333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT(333, STARTY+940,  333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT(666, STARTY+940,  334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT(333, STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT(666, STARTY+1030, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT(0,   STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1120, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT(333, STARTY+1210, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT(666, STARTY+1210, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "←"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//화면캡쳐
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "계량기 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+700,  STARTY-40, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA, "촬영"),
		DLG_BUTTON(STARTX+700, STARTY+390, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA2, "촬영"),
		DLG_BUTTON(STARTX,	   STARTY+770, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PIPE, "배관점검"),
		DLG_BUTTON(STARTX+600, STARTY+770, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		DLG_TEXT(STARTX,      STARTY-40, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GR, "계량기점검"),
		DLG_TEXT(STARTX,     STARTY+390, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BLOCK, "차단장치"),
		DLG_TEXT(STARTX,     STARTY+655, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTGUIDE, "전월지침"),
		DLG_TEXT(STARTX+300, STARTY+655, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY+655, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_THGUIDE, "현지침"),
		DLG_EDIT(STARTX+775, STARTY+655, 225, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 10,  ""),
		
		// 리스트
		DLG_TABLE (GRID_X_M, GRID_Y_M_P, ROW_M, COL_M, 0, GRID_H_M_P, 1, GRID_H_M_P, SEL_COL, MAXCHAR_M, m_stGridTitle_M, ID_MTRLIST, m_szTableBuf_M),
		DLG_TABLE (GRID_X_E, GRID_Y_E_P, ROW_E, COL_E, 0, GRID_H_M_P, 1, GRID_H_M_P, SEL_COL, MAXCHAR_E, m_stGridTitle_E, ID_EXCEPLIST, m_szTableBuf_E),
	};
	
	// 대용량 계량기
	//---------------------------------------------------------------
	DlgObject	DlgRes_BIGMTR[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "대용량계량기 점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK2, ""),
			
		DLG_BUTTON(STARTX,     STARTY+600, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA3, "사진"),
		DLG_BUTTON(STARTX+600, STARTY+600, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2, "확인"),
		
		DLG_TEXT(STARTX,     STARTY+360, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "보정후(VC)"),
		DLG_EDIT(STARTX+350, STARTY+360, 650, 60, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_TEXT(STARTX,     STARTY+420, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "보정전(VA)"),
		DLG_EDIT(STARTX+350, STARTY+420, 650, 60, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 10,  ""),
		DLG_TEXT(STARTX,     STARTY+480, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "계량기(VM)"),
		DLG_TEXT(STARTX+350, STARTY+480, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+540, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "    상세위치"),
		DLG_TEXT(STARTX+350, STARTY+540, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		
		// 리스트
		DLG_TABLE (GRID_X_B, GRID_Y_B, ROW_B, COL_B, 0, GRID_H_B, 1, GRID_H_B, SEL_COL, MAXCHAR_B, m_stGridTitle_B, ID_BIGLIST, m_szTableBuf_B),
	};	
	
	// 대용량 계량기 PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_BIGMTR_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "대용량계량기 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK2, ""),
	
		DLG_BUTTON(STARTX,     STARTY+650, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERA3, "사진"),
		DLG_BUTTON(STARTX+600, STARTY+650, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2, "확인"),
		
		DLG_TEXT(STARTX,     STARTY+380, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "보정후(VC)"),
		DLG_EDIT(STARTX+350, STARTY+380, 650, 80, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_TEXT(STARTX,     STARTY+460, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "보정전(VA)"),
		DLG_EDIT(STARTX+350, STARTY+460, 650, 80, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 10,  ""),
		DLG_TEXT(STARTX,     STARTY+540, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "계량기(VM)"),
		DLG_TEXT(STARTX+350, STARTY+540, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+540, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "상세위치"),
		DLG_TEXT(STARTX+350, STARTY+540, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		// 리스트
		DLG_TABLE (GRID_X_B, GRID_Y_B_P, ROW_B, COL_B, 0, GRID_H_B_P, 1, GRID_H_B_P, SEL_COL, MAXCHAR_B, m_stGridTitle_B, ID_BIGLIST, m_szTableBuf_B),
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
				SetStyle();
				REDRAW();
				MTR_DRAW();
				EXC_DRAW();
				break;
			case INIT_BIGMTR:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_BIGMTR_P, SIZEOF(DlgRes_BIGMTR_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_BIGMTR, SIZEOF(DlgRes_BIGMTR));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				BIG_DRAW();
				break;
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
		else if( m_bFirst == INIT_BIGMTR )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BLOCK), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LTGUIDE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_THGUIDE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DETA_LOC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
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
		}
		else if( m_bFirst == INIT_BIGMTR )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
		}
	}

	//-------------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				//숫자만 입력 가능
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY(5);
					return;
				}
			}
		}
		else if( m_bFirst == INIT_BIGMTR )
		{
			if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex)
			{
				//숫자만 입력 가능
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY(5);
					return;
				}
			}
		}
	}
	
	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				m_lActiveIndex = lActiveIndex;

				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+730) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+710-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+760-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);

							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);

						//	ShowSip(TRUE);
						//	g_Sipflag = 1;
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
					
					ON_DRAW();
				}
			}
		}
		else if( m_bFirst == INIT_BIGMTR )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+360) && Y < DMS_Y(STARTY+420) ||
					    X > DMS_X(STARTX+350) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+420) && Y < DMS_Y(STARTY+480) ||
					    X > DMS_X(STARTX+350) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+480) && Y < DMS_Y(STARTY+540) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_DATA5) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
					
					ON_DRAW();
				}
			}
		}
		
		return;
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long cnt;
		char szMsg[150];
		switch(ID)
		{					
			case BID_CAMERA:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				Shoto_Photo(ID);
				break;
			case BID_CAMERA2:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				Shoto_Photo(ID);
				break;
			case BID_PIPE:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				Mem_Set( (byte*)stBsMtr.MTR_DETA_LOC, 0x00, sizeof(stBsMtr.MTR_DETA_LOC) );
				Str_Cpy(stBsMtr.MTR_DETA_LOC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC)));
				
				Str_Cpy(g_szIndi_Cur, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				
				Card_Move("BS_PIPECHK");
				break;
			case BID_OK:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if (Chk_Photo() < 2)
				{
					MessageBoxEx (CONFIRM_OK, "부적합항목 사진촬영을 해주세요.");
					break;
				}

				if( Save_Chk() )
				{
					Mem_Set((byte*)g_szIndi_Cur ,0x00, sizeof(g_szIndi_Cur) );
					Card_Move("BS_MTRINFO");
				}

				
				break;
			
			case BID_UP:
			
				m_lpage -= ROW_M;
				m_lpage_text--;
				
				if(m_lpage < 0)
				{
					m_lpage = 0;
					m_lpage_text = 0;
					break;
				}
				
				MTR_DRAW();
				break;
				
			case BID_DOWN:
				m_lpage += ROW_M;
				
				m_lpage_text++;
				
				if( m_lpage_text > m_lTotpage-1 )
				{
					m_lpage_text = m_lTotpage-1;
				}
				
				if( m_lpage >= m_lTotpage )
				{
					m_lpage -= ROW_M;
					
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					
					break;
				}
				
				MTR_DRAW();
				break;	
			
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					g_lDataflag = 0;
					Mem_Set((byte*)g_szIndi_Cur ,0x00, sizeof(g_szIndi_Cur) );
					if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
					{
						Del_PipeData();
					}
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "특정점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					g_lDataflag = 0;
					Mem_Set((byte*)g_szIndi_Cur ,0x00, sizeof(g_szIndi_Cur) );
					if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
					{
						Del_PipeData();
					}
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
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
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( Str_Len(stBs.MRT_RSLT) > 0 )
				{
					MessageBoxEx (CONFIRM_OK, "이미 점검한 자료는 취소가 불가합니다.");
				}
				else
				{
					Mem_Set((byte*)g_szIndi_Cur ,0x00, sizeof(g_szIndi_Cur) );
					g_lSCMoveFlag = 2;		//0보다 큰 임의 값 셋팅

					if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
					{
						g_lDataflag = 0;
						Del_PipeData();
						
					}

					Card_Move("BS_MTRINFO");
				}
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 )
				{
					Del_PipeData();
				}
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Exit_DelBsData();
					return;
				}
				g_Exit();
				return;
//대용량 계량기
			case BID_OK2:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if (Chk_BigPhoto() < 1)
				{
					MessageBoxEx (CONFIRM_OK, "부적합항목 사진촬영을 해주세요.");
					break;
				}
				
				if( Save_Result() )
				{
					Mem_Set((byte*)g_szIndi_Cur ,0x00, sizeof(g_szIndi_Cur) );
					Card_Move("BS_MTRINFO");
				}
				break;
			case BID_CAMERA3:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				Shoto_Photo(ID);
				break;
			
			case BID_DETA_LOC:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DETA_LOC), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC)) );
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

		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_MTRLIST))
				m_lTblAct = 1;
			else if(DlgTbl_IsSelect(ID_EXCEPLIST))
				m_lTblAct = 2;
	
			//계량기점검
			if( m_lTblAct == 1 )
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_MTRLIST);
				m_lMtrAct = index;
				
				lrow = m_lMtrAct/COL_M;
				lcol = m_lMtrAct%COL_M;
				lrow--;

				if( Str_Cmp(DlgTbl_GetStr( ID_MTRLIST, lrow, 3), "Y") != 0 )
				{	
					if( lcol == 2 )
					{
						// 선택 인덱스와 기존 인덱스가 동일 할 경우
						Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
						Str_Cpy( sztmp, DlgTbl_GetStr( ID_MTRLIST, lrow, lcol) );

						if( Str_Cmp( sztmp, CHKGOOD) == 0 )
						{
							DlgTbl_SetStr ( ID_MTRLIST, lrow, lcol, CHKNOGOOD );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, lcol-2 ), RED);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, lcol-1 ), RED);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, lcol ), RED);
						}
						else
						{
							DlgTbl_SetStr ( ID_MTRLIST, lrow, lcol, CHKGOOD );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, lcol-2 ), BLUE );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, lcol-1 ), BLUE );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, lcol ), BLUE );
						}
						
						Save_Row(lrow, lcol);
					}
				}
				else
				{
					// MessageBoxEx (CONFIRM_OK, "우선점검 부적합 항목은\n제외 할 수 없습니다.");	

					if( MessageBoxEx (CONFIRM_YESNO, "우선점검 부적합 항목은\n제외 할 수 없습니다. \n\n 개선권고 일자를 입력하시겠습니까?")  == MB_OK)
					{
						g_lGovBetterFlag = 3;
						Card_Move("BS_RFRMRSK");

					}

				}
				
				lpage = m_lpage + (index/COL_M);
				m_nChkIndex = index;
				SPRINT(m_szCnt_page, "%d/%d", lpage, m_lTotpage, 0);
				ON_DRAW();
			}
			else if (m_lTblAct == 2 )
			{
				if( g_Dlgflag > 0 )
				{
					return;
				}
			
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_EXCEPLIST);
				m_lExcAct = index;

				lrow = m_lExcAct/COL_E;
				lcol = m_lExcAct%COL_E;
				lrow--;
				
				if( Str_Cmp(DlgTbl_GetStr( ID_EXCEPLIST, lrow, 3), "Y") != 0 )
				{
					if( lcol == 2 )
					{
						// 선택 인덱스와 기존 인덱스가 동일 할 경우
						Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
						Str_Cpy( sztmp, DlgTbl_GetStr( ID_EXCEPLIST, lrow, lcol) );
						
						if( Str_Cmp( sztmp, CHKGOOD) == 0 )
						{
							DlgTbl_SetStr ( ID_EXCEPLIST, lrow, lcol, CHKNOGOOD );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, lcol-2 ), RED);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, lcol-1 ), RED);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, lcol ), RED);
						}
						else
						{
							DlgTbl_SetStr ( ID_EXCEPLIST, lrow, 2, CHKGOOD );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, lcol-2 ), BLUE );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, lcol-1 ), BLUE );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, lcol ), BLUE );
						}
						
						Save_Row(lrow, lcol);
						ON_DRAW();
					}
				}
				else
				{
					// MessageBoxEx (CONFIRM_OK, "우선점검 부적합 항목은\n제외 할 수 없습니다.");	
					if( MessageBoxEx (CONFIRM_YESNO, "우선점검 부적합 항목은\n제외 할 수 없습니다. \n\n 개선권고 일자를 입력하시겠습니까?")  == MB_OK)
					{
						g_lGovBetterFlag = 3;
						Card_Move("BS_RFRMRSK");

					}
				}
			}
		}
		else if( m_bFirst == INIT_BIGMTR )
		{
			if(DlgTbl_IsSelect(ID_BIGLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_BIGLIST);
				m_lBigAct = index;
				
				lrow = m_lBigAct/COL_B;
				lcol = m_lBigAct%COL_B;
				lrow--;
				
				if( Str_Cmp(DlgTbl_GetStr( ID_BIGLIST, lrow, 4), "Y") != 0 )
				{
					if( lcol == 2 )
					{
						// 선택 인덱스와 기존 인덱스가 동일 할 경우
						Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
						Str_Cpy( sztmp, DlgTbl_GetStr( ID_BIGLIST, lrow, lcol) );
						
						if( Str_Cmp( sztmp, CHKGOOD) == 0 )
						{
							DlgTbl_SetStr ( ID_BIGLIST, lrow, lcol, CHKNOGOOD );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, lrow, lcol-2 ), RED);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, lrow, lcol-1 ), RED);
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, lrow, lcol ), RED);
						}
						else
						{
							DlgTbl_SetStr ( ID_BIGLIST, lrow, lcol, CHKGOOD );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, lrow, lcol-2 ), BLUE );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, lrow, lcol-1 ), BLUE );
							EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, lrow, lcol ), BLUE );
						}
						
						Save_Row(lrow, lcol);
						ON_DRAW();
					}
				}
			}
		}
	}
	

//------------------------------------------------------------------------------------------	
	void REDRAW(void)
	{
		if( Str_Cmp(stBsMtr.COMPENS_YN, "Y") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), stBsMtr.MTR_INDI );
			
			if( Str_Len(g_szIndi_Cur) > 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), g_szIndi_Cur );
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stBsMtr.MTR_INDI_CUR );
			}
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), stBsMtr.INDI_VC );
			
			if( Str_Len(g_szIndi_Cur) > 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), g_szIndi_Cur );
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stBsMtr.INDI_VC_CUR );
			}
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DETA_LOC), stBsMtr.MTR_DETA_LOC );
		
		if( g_lDataflag == 1 )
		//if( Str_Len(stBsMtr.MRT_RSLT) > 0 )
		//if( Str_Len(g_Pipe_Bury_Yn) > 0 && Str_Len(g_Pipe_Hide_Yn) > 0 )
		{
			//DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PIPE), FALSE );
			//DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PIPE), TRUE );

			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PIPE), RED);
		}
		else
		{
			//DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PIPE), TRUE );
			//DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PIPE), FALSE );

			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PIPE), BTNMENUFRCOLOR);
		}
	}
	
//------------------------------------------------------------------------------------------
	void MTR_DRAW(void)
	{
		long i, k;
		long lTotCnt;
		long lpage = 1;
		char szSql[401];
		char szTmp[200];
		char szNOT_PASS_ITEM_CD[3];
		char szPRE_CHK_OBJ_YN[2];
		long ret = -1;	
		long lrow, lcol;
		long m_lTotpage_2;

		Mem_Set((byte*)m_szSec_nm_M ,0x00, sizeof(m_szSec_nm_M) );
		Mem_Set((byte*)m_szSec_cd_M ,0x00, sizeof(m_szSec_cd_M) );
		
		Str_Cpy(m_szSec_nm_M, "계량기");
		Str_Cpy(m_szSec_cd_M, "22");
		
		lTotCnt = sizeof(SCHKGM)/sizeof( CodeTable )-1;
		m_CT_M = SCHKGM;
		
		m_lTotpage = lTotCnt;

		if( m_lTotpage % ROW_M > 0 )
		{
			m_lTotpage_2 = (m_lTotpage / ROW_M) + 1;
		}
		else
		{
			m_lTotpage_2 = m_lTotpage / ROW_M;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage_text+1, m_lTotpage_2,0);
		
		//계량기점검, 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i = 0 ; i < ROW_M ; i++)
		{
			if( m_lpage+i+1 > m_lTotpage )//자료가 없을때 화면을 클리어 시킨다.
			{
				DlgTbl_SetStr ( ID_MTRLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 3, "" );
			}
			else
			{
				DlgTbl_SetStr ( ID_MTRLIST, i, 1, m_CT_M[m_lpage+i].Str );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				
				SPRINT(szSql, " SELECT NOT_PASS_ITEM_CD FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, m_szSec_cd_M, m_CT_M[m_lpage+i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' ", stBsNogood.MTR_NUM, 0, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szPRE_CHK_OBJ_YN ,0x00, sizeof(szPRE_CHK_OBJ_YN) );
				
				SPRINT(szSql, " SELECT PRE_CHK_OBJ_YN FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, m_szSec_cd_M, m_CT_M[m_lpage+i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' ", stBsNogood.MTR_NUM, 0, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 2, szPRE_CHK_OBJ_YN );
				
				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_MTRLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, i, 0 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, i, 1 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, i, 2 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_MTRLIST, i, 2, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, i, 1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, i, 2 ), RED);
				}
				DlgTbl_SetStr ( ID_MTRLIST, i, 0, m_CT_M[m_lpage+i].Code );
				DlgTbl_SetStr ( ID_MTRLIST, i, 3, szPRE_CHK_OBJ_YN );
			}			
		}	
				
		return;
	}
	
//------------------------------------------------------------------------------------------
	void EXC_DRAW(void)
	{
		long i, idx;
		long k = ROW_E+1;
		long lTotCnt;
		char szSql[401];
		char szTmp[200];
		char szNOT_PASS_ITEM_CD[3];
		char szPRE_CHK_OBJ_YN[2];
		long ret = -1;	

		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );

		Str_Cpy(m_szSec_nm_E, "차단장치");
		Str_Cpy(m_szSec_cd_E, "24");
		lTotCnt = sizeof(SCHKGASALARM)/sizeof( CodeTable )-1;
		m_CT_E = SCHKGASALARM;
		
		//계량기점검, 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i = 0 ; i < ROW_E ; i++)
		{
			if( i+1 > lTotCnt )//자료가 없을때 화면을 클리어 시킨다.
			{
				DlgTbl_SetStr ( ID_EXCEPLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_EXCEPLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_EXCEPLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_EXCEPLIST, i, 3, "" );
			}
			else
			{
				DlgTbl_SetStr ( ID_EXCEPLIST, i, 1, m_CT_E[i].Str );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				
				SPRINT(szSql, " SELECT NOT_PASS_ITEM_CD FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, m_szSec_cd_E, m_CT_E[i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' ", stBsNogood.MTR_NUM, 0, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szPRE_CHK_OBJ_YN ,0x00, sizeof(szPRE_CHK_OBJ_YN) );
				
				SPRINT(szSql, " SELECT PRE_CHK_OBJ_YN FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, m_szSec_cd_E, m_CT_E[i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' ", stBsNogood.MTR_NUM, 0, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 2, szPRE_CHK_OBJ_YN );
				
				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_EXCEPLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, i, 0 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, i, 1 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, i, 2 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_EXCEPLIST, i, 2, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, i, 1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, i, 2 ), RED);
				}
				DlgTbl_SetStr ( ID_EXCEPLIST, i, 0, m_CT_E[i].Code );
				DlgTbl_SetStr ( ID_EXCEPLIST, i, 3, szPRE_CHK_OBJ_YN );
			}			
		}	
				
		return;
	}

//------------------------------------------------------------------------------------------
	void BIG_DRAW(void)
	{
		long i, idx;
		long k = ROW_B+1;
		long lTotCnt;
		char szSql[401];
		char szTmp[200];
		char szNOT_PASS_ITEM_CD[3];
		char szPRE_CHK_OBJ_YN[2];
		long ret = -1;	

		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), stBsMtr.INDI_VC_CUR );
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), stBsMtr.INDI_VA_CUR );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), stBsMtr.MTR_INDI_CUR );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), stBsMtr.MTR_DETA_LOC );


		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
		
		Str_Cpy(m_szSec_nm_B, "대용량 계량기 점검");
		Str_Cpy(m_szSec_cd_B, "60");
		
		lTotCnt = sizeof(SCHKCOMPENS)/sizeof( CodeTable )-1;
		m_CT_B = SCHKCOMPENS;
		
		//계량기점검, 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i = 0 ; i < ROW_B ; i++)
		{
			if( i+1 > lTotCnt )//자료가 없을때 화면을 클리어 시킨다.
			{
				DlgTbl_SetStr ( ID_BIGLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_BIGLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_BIGLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_BIGLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_BIGLIST, i, 4, "" );
			}
			else
			{
				DlgTbl_SetStr ( ID_BIGLIST, i, 1, m_CT_B[i].Str );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				
				SPRINT(szSql, " SELECT NOT_PASS_ITEM_CD FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, m_szSec_cd_B, m_CT_B[i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' ", stBsNogood.MTR_NUM, 0, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );
				
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Mem_Set((byte*)szPRE_CHK_OBJ_YN ,0x00, sizeof(szPRE_CHK_OBJ_YN) );
				
				SPRINT(szSql, " SELECT PRE_CHK_OBJ_YN FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' AND BETTER_YN = 'N' ", stBsNogood.CHK_EXEC_NUM, m_szSec_cd_B, m_CT_B[i].Code);
				SPRINT(szTmp, "AND MTR_NUM = '%s' ", stBsNogood.MTR_NUM, 0, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_RetStr( szSql, 2, szPRE_CHK_OBJ_YN );

				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_BIGLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, i, 0 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, i, 1 ), BLUE);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, i, 2 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_BIGLIST, i, 2, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, i, 1 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_BIGLIST, i, 2 ), RED);
				}
				//DlgTbl_SetStr ( ID_BIGLIST, i, 0, m_CT_B[i].title );
				DlgTbl_SetStr ( ID_BIGLIST, i, 0, m_CT_B[i].Code );
				DlgTbl_SetStr ( ID_BIGLIST, i, 3, m_CT_B[i].Code );
				DlgTbl_SetStr ( ID_BIGLIST, i, 4, szPRE_CHK_OBJ_YN );
			}			
		}	
				
		ON_DRAW();
		return;
	}
	
//----------------------------------------------------------------------------------
	void Save_Row(long row, long col)
	{
	char szNOT_PASS_ITEM_CD[3];
	char szNOT_PASS_ITEM_NM[33];
	char sztmp[200];
	char szSql[300];

		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set((byte*)szNOT_PASS_ITEM_NM ,0x00, sizeof(szNOT_PASS_ITEM_NM) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
	
		if( m_bFirst == INIT_MAIN )
		{
			if( m_lTblAct == 1 )
			{
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_MTRLIST, row, col) );
				Str_Cpy( szNOT_PASS_ITEM_NM, DlgTbl_GetStr( ID_MTRLIST, row, 1) );
				Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_MTRLIST, row, 0) );
				Str_Cpy(stBsNogood.CHK_SEC_CD, m_szSec_cd_M);
				Str_Cpy(stBsNogood.CHK_SEC_NM, m_szSec_nm_M);
			}
			else if( m_lTblAct == 2 )
			{
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_EXCEPLIST, row, col) );
				Str_Cpy( szNOT_PASS_ITEM_NM, DlgTbl_GetStr( ID_EXCEPLIST, row, 1) );
				Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_EXCEPLIST, row, 0) );
				Str_Cpy(stBsNogood.CHK_SEC_CD, m_szSec_cd_E);
				Str_Cpy(stBsNogood.CHK_SEC_NM, m_szSec_nm_E);
			}
		}
		else if( m_bFirst == INIT_BIGMTR )
		{
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_BIGLIST, row, col) );
			Str_Cpy( szNOT_PASS_ITEM_NM, DlgTbl_GetStr( ID_BIGLIST, row, 1) );
			Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_BIGLIST, row, 3) );
			Str_Cpy(stBsNogood.CHK_SEC_CD, m_szSec_cd_B);
			Str_Cpy(stBsNogood.CHK_SEC_NM, m_szSec_nm_B);
		}

		//적합일 경우 항목 삭제
		if(Str_Cmp( sztmp, CHKGOOD) == 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			SPRINT(szSql, " DELETE FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
			SPRINT(sztmp, "AND MTR_NUM = '%s' ", stBsNogood.MTR_NUM, 0, 0);
			Str_Cat(szSql, sztmp);
			
			g_Sql_DirectExecute( szSql );
			
		}
		else // 부적합일 경우 항목 추가
		{
			Save_NotPassItem(szNOT_PASS_ITEM_CD, szNOT_PASS_ITEM_NM);

			if(m_lTblAct == 1)
			{
				Shoto_Photo(1);
			}
			else if(m_lTblAct == 2)
			{
				Shoto_Photo(2);
			}
		}
	}
	
//----------------------------------------------------------------------------
	bool Save_NotPassItem(char* szNOT_PASS_ITEM_CD, char* szNOT_PASS_ITEM_NM)
	{
	long idx;
	bool ret = TRUE;
	long nDate;
	long BettePlanymd;
	char sztmp[20];	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

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
		, BETTER_PLAN_YMD  , BETTER_YN        , SEND_YN                              \
		, UPD_EMPID        , PDA_IP           , PLAN_YM) \
		VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
			 , ?, ?, ?, ?, 'N', 'S', ?, ?, ? ) " 
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
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,15 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PLAN_YM         	  ,6  ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

//-----------------------------------------------------------------------------
	bool Save_Chk(void)
	{
		bool ret = TRUE;
		long nLen;
		long pLen ,qlen;

		char strMsg[100];
		char strLen[100];
		char strNlen[100];

		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC)));
		PRINT("SSSS == %d" ,nLen,0,0);
	
		if( Str_Cmp(stUserinfo.szcenter_cd, "91") == 0 || Str_Cmp(stUserinfo.szcenter_cd, "92") == 0 || Str_Cmp(stUserinfo.szcenter_cd, "93") == 0
		||  Str_Cmp(stUserinfo.szcenter_cd, "94") == 0 || Str_Cmp(stUserinfo.szcenter_cd, "95") == 0 )
		{
			Str_Cpy(stBsMtr.INDI_VC_CUR, "0");
			Str_Cpy(stBsMtr.INDI_VA_CUR, "0");
			Str_Cpy(stBsMtr.MTR_INDI_CUR, "0");
			
			Chk_MtrNogood();
			ret = Save_Result();
		}
		else
		{

			if(nLen > 30)
			{
				pLen = (nLen - 30) / 3;
				qlen = (nLen - 30);
				// PRINT("OOOO == %d" ,pLen,0,0);
				
				Mem_Set((byte *)strMsg      , 0x00, sizeof(strMsg));
				Mem_Set((byte *)strLen      , 0x00, sizeof(strLen));
				Mem_Set((byte *)strNlen      , 0x00, sizeof(strNlen));
				Str_ItoA(pLen,strLen,10);
				Str_ItoA(qlen,strNlen,10);

				
				Str_Cat(strMsg, "상세위치 입력값이 너무 큽니다.\n\n ");
				Str_Cat(strMsg, "한글은 최대 10글자 ");
				Str_Cat(strMsg, "\n 그 외는 ");
				Str_Cat(strMsg, "30 글자로 \n 입력해주세요");
				
				MessageBoxEx(ERROR_OK, strMsg);

				ret = FALSE;
				return ret;
				
			}

			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "현지침을 입력해주세요.");
				ret = FALSE;
				return ret;
			}

			//if( Str_Len(stBs.PIPE_BURY_YN) == 0 || Str_Len(stBs.PIPE_HIDE_YN) == 0 )

			if( g_lDataflag == 0 && (Str_Cmp(stBsMtr.MRT_RSLT, "Y") != 0 && Str_Cmp(stBsMtr.MRT_RSLT, "N") != 0 ) )
			//if( Str_Len(stBsMtr.MRT_RSLT) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관점검을 진행해주세요.");
				ret = FALSE;
				return ret;
			}

			if( Str_Cmp(stBsMtr.COMPENS_YN, "Y") == 0 )
			{
				Str_Cpy(stBsMtr.MTR_INDI_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cpy(stBsMtr.MTR_DETA_LOC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC)));
				Chk_MtrNogood();
				
				//대용량 팝업 띄우는거 추가
				ON_EXIT();
				OnInit(INIT_BIGMTR);
				
				ret = FALSE;
			}
			else
			{
				Str_Cpy(stBsMtr.INDI_VC_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cpy(stBsMtr.INDI_VA_CUR, "0");
				Str_Cpy(stBsMtr.MTR_INDI_CUR, "0");
				
				Chk_MtrNogood();
				ret = Save_Result();
			}
		}
		
		return ret;
	}

//--------------------------------------------------------------------------------	
	bool Save_Result(void)
	{
		char szSql[500];
		long idx;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		if( m_bFirst == INIT_BIGMTR )
		{
			if( Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "VC 지침을 입력하세요!!");
				ret = FALSE;
				return ret;
			}
			if( Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "VA 지침을 입력하세요!!");
				ret = FALSE;
				return ret;
			}

			Str_Cpy(stBsMtr.INDI_VC_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(stBsMtr.INDI_VA_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		}
		else
		{
			Mem_Set( (byte*)stBsMtr.MTR_DETA_LOC, 0x00, sizeof(stBsMtr.MTR_DETA_LOC) );
			Str_Cpy(stBsMtr.MTR_DETA_LOC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC)));
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		//2017-08-09 Sanghyun Lee
		//SEND_YN 저장 시점 변경 > 계량기정보 화면 '완료'버튼 누를 시 저장
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_MTR SET \
					INDI_VC_CUR = ?, INDI_VA_CUR = ?, MTR_INDI_CUR = ?, MRT_RSLT = ?, MTR_DETA_LOC = ?  \
					WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s'"
					, g_szCHK_EXEC_NUM, stBsMtr.MTR_NUM, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBsMtr.INDI_VC_CUR		,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsMtr.INDI_VA_CUR		,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsMtr.MTR_INDI_CUR		,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsMtr.MRT_RSLT		    ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsMtr.MTR_DETA_LOC		,30	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//--------------------------------------------------------------------------------
	void Chk_MtrNogood(void)
	{
		char szSql[300];
		long lMtrCnt = 0;
		long lExcCnt = 0;
		long lBigCnt = 0;
	
		//계량기 부적합
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='22' \
						AND MTR_NUM = '%s' AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, stBsNogood.MTR_NUM, 0);
		g_Sql_RetInt(szSql, &lMtrCnt);
		
		//차단장치 부적합
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='24' \
						AND MTR_NUM = '%s' AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, stBsNogood.MTR_NUM, 0);
		g_Sql_RetInt(szSql, &lExcCnt);
		
		//보정기(대용량) 부적합
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='60' \
						AND MTR_NUM = '%s' AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, stBsNogood.MTR_NUM, 0);
		g_Sql_RetInt(szSql, &lBigCnt);

		if( lMtrCnt > 0 || lExcCnt > 0 || lBigCnt > 0 )
		{
			Str_Cpy(stBsMtr.MRT_RSLT, "N");
		}
		else
		{
			Str_Cpy(stBsMtr.MRT_RSLT, "Y");
		}
	}
	
	
//----------------------------------------------------------------------------------------------	
	void Shoto_Photo(long nButtonId)
	{
		char sztmp[256];
		char szScrPht[256];
		char szTgrPht[256];
		char szDirPath[256];
		char szNOT_PASS_ITEM_CD[3];
		char *pCamera;
		char *pRst;
		long nRet, idx;
		long lrow, lcol;
		handle h = NULL;
		handle hdata = NULL;

		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if( m_bFirst == INIT_MAIN )
		{
			Str_Cpy(g_szIndi_Cur, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		
			// if( m_lTblAct == 1 && nButtonId == BID_CAMERA )
			if( m_lTblAct == 1  )
			{
				lrow = m_lMtrAct/COL_M;
				lcol = m_lMtrAct%COL_M;
				lrow--;

				Str_Cpy( sztmp, DlgTbl_GetStr( ID_MTRLIST, lrow, 2) );

				if( Str_Cmp( sztmp, CHKGOOD) == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "부적합 항목을 선택하세요.");
					return;
				}
				
				//파일명
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				//Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 3) );
				Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_MTRLIST, lrow, 0) );
			}
			// else if( m_lTblAct == 2 && nButtonId == BID_CAMERA2 )
			else if( m_lTblAct == 2  )
			{
				lrow = m_lExcAct/COL_E;
				lcol = m_lExcAct%COL_E;
				lrow--;
			
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_EXCEPLIST, lrow, 2) );
				
				if( Str_Cmp( sztmp, CHKGOOD) == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "부적합 항목을 선택하세요.");
					return;
				}
				
				//파일명
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				//Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_EXCEPLIST, m_lExcAct, 3) );
				Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_EXCEPLIST, lrow, 0) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "항목을 선택하세요.");
				return;
			}
		}
		else if( m_bFirst == INIT_BIGMTR )
		{
			lrow = m_lBigAct/COL_B;
			lcol = m_lBigAct%COL_B;
			lrow--;
		
			if( m_lBigAct < 0 )
			{
				MessageBoxEx (CONFIRM_OK, "항목을 선택하세요.");
				return;
			}
				
			Str_Cpy( sztmp, DlgTbl_GetStr( ID_BIGLIST, lrow, 2) );
			if( Str_Cmp( sztmp, CHKGOOD) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "부적합 항목을 선택하세요.");
				return;
			}
			
			//파일명
			Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
			Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_BIGLIST, lrow, 3) );
		}

		Str_Cpy(m_szfilenm, "1");
		Str_Cat(m_szfilenm, "_");
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
			//SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
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
		long lrow = 0;
		char szNOT_PASS_ITEM_CD[10];
		char szResult[10];
		char szTmp[256];
		char szfilenm[256];
		char szMsg[150];
		char szPhotopath[256];
		char* szPath = NULL;
		char szSql[300];
		long nRet = 0;
		long nLen = 0;
		long lcol ;
		
		
		//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);
		CloseMessageBox();
		
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_CAMERA )
			{
				Mem_Set((byte*)szPhotopath, 0x00, sizeof(szPhotopath));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				szPath = (char*)System_GetResult((char*)&nRet);

				// Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				// Str_Cpy(szMsg, m_lTblAct);
				// MessageBoxEx(ERROR_OK, szMsg);
				
				
		
				
				nLen = Str_Len(szPath);
				if( nLen > 19 )
				{
					Mem_Cpy((byte *)szTmp, (byte *)szPath+19, nLen-19);
					Str_Cpy(szPhotopath, "..");
					Str_Cat(szPhotopath, szTmp);
					//PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
					if( m_lTblAct == 1 )
					{
						lrow = m_lMtrAct/COL_M;
						lcol = m_lMtrAct%COL_M;
						lrow--;
						Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_MTRLIST, lrow, 0) );
						// MessageBoxEx(ERROR_OK, "11111111111");
					}
					else if( m_lTblAct == 2)
					{
						lrow = m_lExcAct/COL_E;
						lcol = m_lExcAct%COL_E;
						lrow--;
						// Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_EXCEPLIST, m_lExcAct, 3) );
						Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_EXCEPLIST, lrow, 0) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						// MessageBoxEx(ERROR_OK, "2222222222222");
					}
					//원본파일 +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);

					// lrow = m_lActive/COL;
					// lrow--;
					Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
					SPRINT(szTmp, "UPDATE SPECIAL_NOGOOD_DETAL SET PHOTO = 'Y' WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='%s' and NOT_PASS_ITEM_CD = '%s' ", stBsNogood.CHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, szNOT_PASS_ITEM_CD);
					g_Sql_DirectExecute( szTmp );

					Mem_Set((byte*)szResult ,0x00, sizeof(szResult) );
					// Str_Cat(szResult,szNOT_PASS_ITEM_CD);
					Str_Cat(szResult,"\n촬영O");

					if( m_lTblAct == 1 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, 0 ), GREEN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, 1 ), GREEN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_MTRLIST, lrow, 2 ), GREEN);
						EditCtrl_SetStr(DlgTbl_GetHandle 	( ID_MTRLIST, lrow, 0 ), szResult);
					}
					else if( m_lTblAct == 2 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, 0 ), GREEN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, 1 ), GREEN);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, 2 ), GREEN);
						EditCtrl_SetStr(DlgTbl_GetHandle 	( ID_EXCEPLIST, lrow, 0 ), szResult);	
					}

					// EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 0 ), GREEN);
					// EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 2 ), GREEN);
					// EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, 1 ), GREEN);
					

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

		if( m_lTblAct == 1 )
			Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 3) );
		else if( m_lTblAct == 2)
			Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_EXCEPLIST, m_lExcAct, 3) );
		
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
	
	
//----------------------------------------------------------------------------------
	void Del_PipeData(void)
	{
		char szSql[300];
	
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '10' "
						, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
		g_Sql_DirectExecute( szSql );
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND PIPE_FLAG = '20' "
						, g_szCHK_EXEC_NUM, g_szMTR_NUM, 0);
		g_Sql_DirectExecute( szSql );
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
		long lMet = 0;
		long lNet = 0;
		char szSql[400];
		char strMsg[100];
 
		// if(Str_Cmp(szPRE_CHK_OBJ_YN, "Y") != 0)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, m_szSec_cd_M, 0);
		g_Sql_RetInt( szSql, &lNogoodCnt );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PHOTO = 'Y' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, m_szSec_cd_M, 0);
		g_Sql_RetInt( szSql, &lPhotoCnt );
		
		
		if( lNogoodCnt == lPhotoCnt )
			{	
			lMet = 1;				
			}
		else
			{	
			lMet = 0;
			}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, m_szSec_cd_E, 0);
		g_Sql_RetInt( szSql, &lNogoodCnt );
		// PRINT("888888888 : %s",stBsNogood.CHK_SEC_CD,0,0);
		// PRINT("444444444 : %s",szSql,0,0);
		// PRINT("555555555 : %d",lNogoodCnt,0,0);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PHOTO = 'Y' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, m_szSec_cd_E, 0);
		g_Sql_RetInt( szSql, &lPhotoCnt );
		// PRINT("666666666 : %d",lPhotoCnt,0,0);

		if( lNogoodCnt == lPhotoCnt )
			{	
				lNet = 1;				
			}
		else
			{	
				lNet = 0;
			}

		lRet = lMet + lNet;

		PRINT("123456789 : %d",lRet,0,0);

		return lRet;
	}

	long Chk_BigPhoto(void)
	{
		long lNogoodCnt, lPhotoCnt = 0;
		long lPreNogoodCnt,lPrePhotoCnt = 0;
		long lCount = 0;
		long lRet = 0;
		char szSql[400];
		char strMsg[100];
 
		// if(Str_Cmp(szPRE_CHK_OBJ_YN, "Y") != 0)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, m_szSec_cd_B, 0);
		g_Sql_RetInt( szSql, &lNogoodCnt );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '%s' AND PHOTO = 'Y' AND IFNULL(PRE_CHK_OBJ_YN,'N') <> 'Y' AND BETTER_YN ='N'",stBsNogood.CHK_EXEC_NUM, m_szSec_cd_B, 0);
		g_Sql_RetInt( szSql, &lPhotoCnt );
		
		if( lNogoodCnt == lPhotoCnt )
			{	
			lRet = 1;				
			}
		else
			{	
			lRet = 0;
			}


		PRINT("123456789 : %d",lRet,0,0);

		return lRet;
	}
}


