/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_RFRMPRGRS
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		//지번주소
		DEF_BUTTON_ID ( BID_PREVLST )	//▲
		DEF_BUTTON_ID ( BID_NEXTLST )	//▼
		DEF_BUTTON_ID ( BID_NOFIT )		//부적합상세
		DEF_BUTTON_ID ( BID_ISSUE )		//발행
		DEF_BUTTON_ID ( BID_OK )		//확인
//개선권고발행
		DEF_BUTTON_ID ( BID_STOP )
		DEF_BUTTON_ID ( BID_CANCEL )
		DEF_BUTTON_ID ( BID_OK2 )
		DEF_BUTTON_ID ( BID_REFSCHDL )	//개선권고일자
		DEF_BUTTON_ID ( BID_REFSCHDL2 )	//개선권고기한
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
		DEF_OBJECT_ID ( TXT_PAGE )			//리스트페이지
		DEF_OBJECT_ID ( TXT_BSDT )			//점검년월
		DEF_OBJECT_ID ( TXT_DIVISION )		//구분
		DEF_OBJECT_ID ( TXT_BSNM )			//특정명
		DEF_OBJECT_ID ( TXT_MANAGER )		//안전관리자
		DEF_OBJECT_ID ( TXT_HPNUM )			//전화번호
		DEF_OBJECT_ID ( TXT_SUPSTOP )		//공급중지일
		DEF_OBJECT_ID ( TXT_CMPLTDT )		//완료일자
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
//개선권고발행
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		DEF_OBJECT_ID ( TXT_DATA22 )
		DEF_OBJECT_ID ( TXT_DATA23 )
		DEF_OBJECT_ID ( TXT_DATA24 )

		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )
		
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table의 행개수
	#define		COL 	    6					// table의 열개수
	#define		GRID_H		(CHT+10)			// table 행 높이
	#define		GRID_H_P	(CHT+20)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+430  	    // table 시작y좌표
	#define		GRID_Y_P	STARTY+420  	    // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"차수",        CWD*5, EDITALIGN_CENTER|EDITALIGN_MIDDLE,      TABLE_TEXT, 0},
		{"개선권고",    CWD*12 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"개선권고기한",CWD*14 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"여부",        CWD*8+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"공급중지일자",0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"완료일자",    0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
	};
	
	#define INIT_MAIN	1
	#define INIT_RFRMISSU 2
	
	char m_szCnt_page[10];
	char m_szAdvice[20];
	char m_szExpire[20];
	char m_szDegree[5];
	long m_lpage;
	long m_lTotpage;
	long m_lActive = -1;
	long m_bFirst;
	long m_lDegree;
	long m_lEditCtrlIndex = -1;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void SetNogoodCha(void);
	void REDRAW(void);
	void TBL_DRAW(void);
	void ISSUE_DRAW(void);
	bool Save_Issue(void);
	bool Chk_Issue(void);
	void Save_Result(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	void Set_Index(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개선권고 진행"),
			
		DLG_BUTTON(STARTX,     STARTY+170, 200, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+500, STARTY+370, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+370, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "▼"),
		DLG_BUTTON(STARTX,     STARTY+829, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOFIT, "부적합상세"),
		DLG_BUTTON(STARTX+333, STARTY+829, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ISSUE, "개선권고발행"),
		DLG_BUTTON(STARTX+666, STARTY+829, 334, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),	
		
		DLG_TEXT(STARTX,     STARTY+65, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSDT, "점검년월"),
		DLG_TEXT(STARTX+300, STARTY+65, 250, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY+65, 200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DIVISION, "구분"),
		DLG_TEXT(STARTX+750, STARTY+65, 250, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+120, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSNM, "특정명"),
		DLG_TEXT(STARTX+300, STARTY+120, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		
		DLG_TEXT(STARTX+200, STARTY+170, 800, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		//DLG_TEXT(STARTX+200, STARTY+220, 775, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		
		DLG_TEXT(STARTX,     STARTY+270, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MANAGER, "안전관리자"),
		DLG_TEXT(STARTX+300, STARTY+270, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+320, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HPNUM, "전화번호"),
		DLG_TEXT(STARTX+300, STARTY+320, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		DLG_TEXT(STARTX,     STARTY+370, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(STARTX,     STARTY+700, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SUPSTOP, "공급중지일"),
		DLG_TEXT(STARTX+300, STARTY+700, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 
		DLG_TEXT(STARTX,     STARTY+760, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPLTDT, "완료일자"), 
		DLG_TEXT(STARTX+300, STARTY+760, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "개선권고 진행"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX,     STARTY+100, 200, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+500, STARTY+350, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+350, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "▼"),
		DLG_BUTTON(STARTX,     STARTY+835, 333, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOFIT, "부적합상세"),
		DLG_BUTTON(STARTX+333, STARTY+835, 333, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ISSUE, "개선권고발행"),
		DLG_BUTTON(STARTX+666, STARTY+835, 334, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),	
		
		DLG_TEXT(STARTX,     STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSDT, "점검년월"),
		DLG_TEXT(STARTX+300, STARTY-40, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY-40, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DIVISION, "구분"),
		DLG_TEXT(STARTX+750, STARTY-40, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSNM, "특정명"),
		DLG_TEXT(STARTX+300, STARTY+30, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+200, STARTY+100, 800, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		//DLG_TEXT(STARTX+200, STARTY+150, 775, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+210, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MANAGER, "안전관리자"),
		DLG_TEXT(STARTX+300, STARTY+210, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+280, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HPNUM, "전화번호"),
		DLG_TEXT(STARTX+300, STARTY+280, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		DLG_TEXT(STARTX,     STARTY+350, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(STARTX,     STARTY+715, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SUPSTOP, "공급중지일"),
		DLG_TEXT(STARTX+300, STARTY+715, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 
		DLG_TEXT(STARTX,     STARTY+775, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPLTDT, "완료일자"), 
		DLG_TEXT(STARTX+300, STARTY+775, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
	};		
	
	//  다이얼로그:개선권고발행
	//---------------------------------------------------------------
	DlgObject	DlgRes_RFRMISSU[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개선권고 발행"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),
		
		DLG_BUTTON(STARTX,	    STARTY+360, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "취소"),
		DLG_BUTTON(STARTX+600,	STARTY+360, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "발행"),
		
		DLG_TEXT(STARTX,	   STARTY-29, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "개선권고일자"),
		DLG_EDIT(STARTX+350,   STARTY-29, 170, 70, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+520,   STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+520,   STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, "."),
		DLG_EDIT(STARTX+540,   STARTY-29, 140, 70, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+680,   STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+680,   STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA20, "."),
		DLG_EDIT(STARTX+700,   STARTY-29, 140, 70, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+840, STARTY-29, 160, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		//DLG_TEXT( STARTX+350, 	STARTY, 490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		//DLG_BUTTON(STARTX+840,	STARTY, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		
		DLG_TEXT( STARTX,	   STARTY+41, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "개선권고기한"),
		DLG_EDIT(STARTX+350,   STARTY+41, 170, 70, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+520,   STARTY+41,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+520,   STARTY+81,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA22, "."),
		DLG_EDIT(STARTX+540,   STARTY+41, 140, 70, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA5, 2,  ""),
		DLG_TEXT(STARTX+680,   STARTY+41,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+680,   STARTY+81,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA24, "."),
		DLG_EDIT(STARTX+700,   STARTY+41, 140, 70, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_BUTTON(STARTX+840, STARTY+41, 160, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL2, "▼"),
		//DLG_TEXT( STARTX+350,   STARTY+70, 490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		//DLG_BUTTON(STARTX+840,  STARTY+70, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL2, "▼"),
		
		DLG_TEXT ( STARTX,	    STARTY+111, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "공급중지"),
		DLG_TEXT ( STARTX+350,	STARTY+111, 490, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_BUTTON(STARTX+840,	STARTY+111, 170, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP,  "중지"),
		
		DLG_TEXT ( STARTX,	    STARTY+181, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "중지불가사유"),
		DLG_COMBO (STARTX+350,  STARTY+181, 650, 200, 170, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
	};

	//  다이얼로그:개선권고발행
	//---------------------------------------------------------------
	DlgObject	DlgRes_RFRMISSU_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "개선권고 발행"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),
		
		DLG_BUTTON(STARTX,	    STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "취소"),
		DLG_BUTTON(STARTX+600,	STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "발행"),
		
		DLG_TEXT( STARTX,	    STARTY-40, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "개선권고일자"),
		DLG_EDIT(STARTX+350,    STARTY-40, 170, 80, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+520,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+520,	   STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, "."),
		DLG_EDIT(STARTX+540,    STARTY-40, 140, 80, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+680,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+680,	   STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA20, "."),
		DLG_EDIT(STARTX+700,    STARTY-40, 140, 80, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+840,  STARTY-40, 160, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		//DLG_TEXT( STARTX+350, 	STARTY, 490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		//DLG_BUTTON(STARTX+840,	STARTY, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL, "▼"),
		
		DLG_TEXT( STARTX,	   STARTY+40, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "개선권고기한"),
		DLG_EDIT(STARTX+350,   STARTY+40, 170, 80, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+520,   STARTY+40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX+520,   STARTY+80,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA22, "."),
		DLG_EDIT(STARTX+540,   STARTY+40, 140, 80, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA5, 2,  ""),
		DLG_TEXT(STARTX+680,   STARTY+40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+680,   STARTY+80,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA24, "."),
		DLG_EDIT(STARTX+700,   STARTY+40, 140, 80, 0, 0, EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_BUTTON(STARTX+840, STARTY+40, 160, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL2, "▼"),
		//DLG_TEXT( STARTX+350,   STARTY+70, 490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		//DLG_BUTTON(STARTX+840,  STARTY+70, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL2, "▼"),
		
		DLG_TEXT ( STARTX,	    STARTY+120, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "공급중지"),
		DLG_TEXT ( STARTX+350,	STARTY+120, 490, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_BUTTON(STARTX+840,	STARTY+120, 160, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP,  "중지"),
		
		DLG_TEXT ( STARTX,	    STARTY+200, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "중지불가사유"),
		DLG_COMBO (STARTX+350,  STARTY+200, 650, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
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
				SetNogoodCha();
				REDRAW();
				TBL_DRAW();
				break;
			case INIT_RFRMISSU:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:	
						CREATE_DIALOG_OBJECT (DlgRes_RFRMISSU_P, SIZEOF(DlgRes_RFRMISSU_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_RFRMISSU, SIZEOF(DlgRes_RFRMISSU));
						break;
				}

				SetBtnImg();
				SetStyle();
				ISSUE_DRAW();
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
		}
	}

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		long i;
	
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DIVISION), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MANAGER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HPNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUPSTOP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMPLTDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA4), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_RFRMISSU )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
			
			if( (m_lDegree+1)  == 3 )
			{
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
	
				for ( i = 0 ;  SCNOSTOP_WHY[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), SCNOSTOP_WHY[i].Str, 0, ICON_NONE);
				}
			}
		}
	}

	//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		long d,k;
		long lRow;
		char szSql[500];
		char sztmp[500];
		
		switch(ID)
		{					
			case BID_ADDR:
				if( g_nAddrFlag == 0 )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주소");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
				}
				REDRAW();
				break;
			case BID_PREVLST:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "첫번째 페이지 입니다.");
					REDRAW();
					TBL_DRAW();
					return;
				}
				m_lActive = 0;
				REDRAW();
				TBL_DRAW();
				break;
			case BID_NEXTLST:
				m_lpage += ROW ;
				if( m_lpage >= m_lTotpage )
				{
					m_lpage -= ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "마지막 페이지 입니다.");
					//REDRAW();
					//TBL_DRAW();
					break;
				}
				m_lActive = 0;
				REDRAW();
				TBL_DRAW();
				break;
			case BID_NOFIT:
				g_lGovBetterFlag = 0;
				Card_Move("BS_RFRMRSK");
				break;
			case BID_ISSUE:
				if( Chk_Issue() )
				{
					ON_EXIT();
					OnInit(INIT_RFRMISSU);
				}
				break;
			case BID_OK:
				Save_Result();
					
				g_nBackFlag++;
				
				if( g_nBackFlag > 4 )
				{
					g_Db_Backup();
					g_nBackFlag = 0;
				}
				
				if( Str_Cmp(stBs.PREUSE_CHK_WHY, "10") == 0 || Str_Cmp(stBs.PREUSE_CHK_WHY, "30") == 0)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "우선 점검화면으로\n이동하시겠습니까?")  == MB_OK)
					{
						Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY ZIP_NO1, ZIP_NO2, ADDR1_M", 0, 0, 0 );
						g_Sql_SaveSeq( szSql, SREACH_FILE);
						
						
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 AND CHK_EXEC_NUM = %s ORDER BY ZIP_NO1, ZIP_NO2, ADDR1_M", g_szCHK_EXEC_NUM, 0, 0 );
						g_Sql_RetInt( szSql, &lRow );

						g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);

						g_lindex = lRow;
						
						Set_Index();
						
						Card_Move("BS_CONFIRM");
					}
					else
					{
						Card_Move("BS_RFRMLST");
					}
				}
				else
				{	
					Card_Move("BS_RFRMLST");
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
					
				Card_Move("BS_RFRMLST");
				
				break;		
			case GID_VMEXIT:
				g_Exit();
				break;
//개선권고 발행
			case BID_REFSCHDL:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>szDate : %s",szDate,0,0);
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
					Mem_Set( (byte*)m_szAdvice, 0x00, sizeof(m_szAdvice) );
					Str_ItoA ( d, m_szAdvice, 10);

					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)m_szAdvice, 4);
					Mem_Cpy((byte *)szMonth, (byte *)m_szAdvice+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)m_szAdvice+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );
				//	g_Str_DateType(szDate, m_szAdvice);
				//	EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), szDate );
				}
				break;
			case BID_REFSCHDL2:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>szDate : %s",szDate,0,0);
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
					Mem_Set( (byte*)m_szExpire, 0x00, sizeof(m_szExpire) );
					Str_ItoA ( d, m_szExpire, 10);
					if( Str_AtoI(m_szAdvice) <= Str_AtoI(m_szExpire) )
					{
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte *)szYear, (byte *)m_szExpire, 4);
						Mem_Cpy((byte *)szMonth, (byte *)m_szExpire+4, 2);
						Mem_Cpy((byte *)szDay, (byte *)m_szExpire+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szDay );
						//g_Str_DateType(szDate, m_szExpire);
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), szDate );
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "개선권고기한이 잘못 설정되었습니다.\n 다시 설정해주세요.");
					}
				}
				break;
			case BID_STOP:
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Str_ItoA(Time_GetDate(), stBsNogoodCha.SUPPLY_STOP_YMD, 10);
				g_Str_DateType(szDate, stBsNogoodCha.SUPPLY_STOP_YMD);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), szDate );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), "" );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
				break;
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_OK2:
				if( Save_Issue() )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
		}
	}

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];

		//숫자만 입력 가능
		if( m_bFirst == INIT_RFRMISSU )
		{
			if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex 
			|| Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				ON_KEY( 5 );
				return;
			}
			
			//개선권고일자
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
	
			//개선권고기한
			if( Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA5)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					
					ON_DRAW();
					return;
				}
				else
				{
					Mem_Set((byte *)m_szAdvice, 0x00, sizeof(m_szAdvice));
					Str_Cpy(m_szAdvice, szTmp);
				}
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					
					ON_DRAW();
					return;
				}
				else
				{
					Mem_Set((byte *)m_szExpire, 0x00, sizeof(m_szExpire));
					Str_Cpy(m_szExpire, szTmp);
					
					if( Str_AtoI(m_szAdvice) > Str_AtoI(m_szExpire) )
					{
						MessageBoxEx (CONFIRM_OK, "개선권고기한이 잘못\n설정되었습니다.\n 다시 설정해주세요.");
						Mem_Set((byte *)m_szExpire, 0x00, sizeof(m_szExpire));
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
						
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
						m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
				}
			}

			ON_DRAW();
			return;
		}
	}

	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL에 ACTIVE시에 CTRLINDEX를 저장
		//키보드 BUTTONCTRL이 ACTIVE시에도 EDITCTRL에 커서를 두기위해서 INDEX를 저장
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( m_bFirst == INIT_RFRMISSU )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+520) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+540) && X < DMS_X(STARTX+680) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+700) && X < DMS_X(STARTX+840) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+350) && X < DMS_X(STARTX+520) && Y > DMS_Y(STARTY+41) && Y < DMS_Y(STARTY+111) ||
						X > DMS_X(STARTX+540) && X < DMS_X(STARTX+680) && Y > DMS_Y(STARTY+41) && Y < DMS_Y(STARTY+111) ||
						X > DMS_X(STARTX+700) && X < DMS_X(STARTX+840) && Y > DMS_Y(STARTY+41) && Y < DMS_Y(STARTY+111) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex )	
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
				}
			}
			
			ON_DRAW();
		}
		return;
	}

//------------------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long index = -1;
		long lPage;

		if( INIT_MAIN == m_bFirst )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);

				m_lActive = index - 1;
				lPage = m_lpage + index;
				SPRINT(m_szCnt_page, "%d/%d", lPage, m_lTotpage, 0);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
			}
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

//------------------------------------------------------------------------------------------------	
	void SetNogoodCha(void)
	{
		long i, idx;
		char sztmp[600];
		char szSql[200];
		long lstartidx ;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)&stBsNogoodCha, 0x00, sizeof(stBsNogoodCha) );
		
		Mem_Set( (byte*)m_szDegree, 0x00, sizeof(m_szDegree) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MAX(BETTER_ADVICE_DEGREE) FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 5, m_szDegree );
		m_lDegree = Str_AtoI(m_szDegree);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( m_lDegree > 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(sztmp, "SELECT CHK_EXEC_NUM, BETTER_ADVICE_DEGREE, BETTER_ADVICE_YMD, BETTER_ADVICE_EXPIRE, BETTER_YN \
							, BETTER_END_YMD, OBJ_YM, SPECIAL_NUM, CHK_TYPE, SUPPLY_STOP_YMD, NOT_PERMIT_WHY \
							, SEND_YN, CHK_YEAR, CHK_ORDER, PDA_IP, UPD_EMPID  \
							FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = ? AND BETTER_ADVICE_DEGREE = ? "
							, 0, 0, 0);
		}
		else
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(sztmp, "SELECT CHK_EXEC_NUM, BETTER_ADVICE_DEGREE, BETTER_ADVICE_YMD, BETTER_ADVICE_EXPIRE, BETTER_YN \
							, BETTER_END_YMD, OBJ_YM, SPECIAL_NUM, CHK_TYPE, SUPPLY_STOP_YMD, NOT_PERMIT_WHY \
							, SEND_YN, CHK_YEAR, CHK_ORDER, PDA_IP, UPD_EMPID  \
							FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = ? "
							, 0, 0, 0);
		}
		hstmt = sql->CreateStatement(sql, sztmp);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0; 
		if( m_lDegree > 0 )
		{
			sql->Bind(sql, i++, 'U', (long*)&g_szCHK_EXEC_NUM , 12, DECRYPT);
			sql->Bind(sql, i++, 'U', (long*)&m_szDegree , 1, DECRYPT);
		}
		else
		{
			sql->Bind(sql, i++, 'U', (long*)&g_szCHK_EXEC_NUM , 12, DECRYPT);
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}		
		
		if(sql->Next(sql) == TRUE)
		{		
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_EXEC_NUM		  , 12+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_ADVICE_DEGREE  , 1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_ADVICE_YMD	  , 8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_ADVICE_EXPIRE  , 8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_YN	   		  , 1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_END_YMD 		  , 8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.OBJ_YM         		  , 6 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.SPECIAL_NUM       	  , 7 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_TYPE       		  , 2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.SUPPLY_STOP_YMD		  , 8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.NOT_PERMIT_WHY 		  , 2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.SEND_YN        		  , 1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_YEAR       		  , 4 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_ORDER      		  , 2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.PDA_IP         		  , 15+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBsNogoodCha.UPD_EMPID	   		  , 20+1, DECRYPT);
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
//------------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		char sztmp[500];
		long ret = -1;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nAddrFlag == 0 )
			hstmt = sql->CreateStatement(sql, " SELECT OBJ_YM, PRESS_FLAG, SPECIAL_NM, ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(SECOND_ADDR,''), SAFE_MANAGER_NM, ifnull(MANAGE_TEL_DDD,'') ||'-'|| ifnull(MANAGE_TEL_EXN,'') ||'-'|| ifnull(MANAGE_TEL_NUM,''), END_YN FROM SPECIAL_NOGOOD WHERE CHK_EXEC_NUM = ? ");
		else
			hstmt = sql->CreateStatement(sql, " SELECT OBJ_YM, PRESS_FLAG, SPECIAL_NM, ifnull(COUNTY,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' ' || ifnull(NEW_ADDR_M,'') || '-' || ifnull(NEW_ADDR_S,'') ||' '|| ifnull(SECOND_ADDR,''), SAFE_MANAGER_NM, ifnull(MANAGE_TEL_DDD,'') ||'-'|| ifnull(MANAGE_TEL_EXN,'') ||'-'|| ifnull(MANAGE_TEL_NUM,''), END_YN FROM SPECIAL_NOGOOD WHERE CHK_EXEC_NUM = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 12, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if( sql->Next(sql) == TRUE )
		{
			idx = 0;
			//점검년월
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 7, DECRYPT);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			
			//압력구분, Decode(PRESS_FLAG,'L','저압','M','중압','중저압')
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
			if( Str_Cmp(sztmp, "L") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), "저압");
			else if( Str_Cmp(sztmp, "M") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), "중압");
			else
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), "중저압");
			
			//특정명
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 33, DECRYPT);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), sztmp);
			
			//주소_1
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 500, DECRYPT);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), sztmp);
			
			//주소_2
	/*		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), sztmp);
	*/
			//안전관리자
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 13, DECRYPT);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), sztmp);
			//전화번호
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 13, DECRYPT);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), sztmp);
			
			//개선결과 END_YN
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
			/*
			if( Str_Cmp(sztmp, "Y") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_OK), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OK), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_OK), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OK), FALSE );
			}
			*/
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		return;
	}
	
//------------------------------------------------------------------------------------------
	void TBL_DRAW(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[401];
		char szDate[20];
		long ret = -1;	
		long lstartidx ;
		long lpage;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM SPECIAL_NOGOOD_CHA  WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( sztmp, &m_lTotpage );

		if( m_lActive == -1 )
		{
			m_lActive = 0;
		}

		lpage = m_lpage + m_lActive;
		SPRINT(m_szCnt_page, "%d/%d", lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, " SELECT BETTER_ADVICE_DEGREE, BETTER_ADVICE_YMD, BETTER_ADVICE_EXPIRE, BETTER_YN, SUPPLY_STOP_YMD, BETTER_END_YMD \
						FROM SPECIAL_NOGOOD_CHA WHERE  CHK_EXEC_NUM = '%s' ORDER BY BETTER_ADVICE_DEGREE LIMIT ?, ? "
						,g_szCHK_EXEC_NUM, 0, 0   );
		hstmt = sql->CreateStatement(sql, sztmp);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		lstartidx = m_lpage;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage+ROW;
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
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
					continue;
				}
				//차수
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//개선권고
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, szDate );
				//개선권고기한
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, szDate );			
				//여부
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 13, DECRYPT);
				if(sztmp[0] == 'Y')
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "개선" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 3,  "미개선");	
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 9, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, szDate );			
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 9, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, szDate );			

			}
		}		

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActive+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActive+1, TABLEACTIVE_COLOR);
				
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));		
		}
		
		ON_DRAW();
		return;
	}
	
//-------------------------------------------------------------------------------------------------
	void ISSUE_DRAW(void)
	{
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szTmp[20];
		long lDate;
		
		//개선권고일자
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		lDate = Time_GetDate();
		Str_ItoA(lDate, m_szAdvice, 10);
		
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)m_szAdvice, 4);
		Mem_Cpy((byte *)szMonth, (byte *)m_szAdvice+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)m_szAdvice+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );	
		//g_Str_DateType(szDate, m_szAdvice);
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), szDate );
		
		//개선권고기한
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		lDate = Time_DateUpDown(lDate, 30);
		Str_ItoA(lDate, m_szExpire, 10);
		
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)m_szExpire, 4);
		Mem_Cpy((byte *)szMonth, (byte *)m_szExpire+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)m_szExpire+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szDay );
		//g_Str_DateType( szDate, m_szExpire);
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), szDate);		//개선권고기한
		
		if( (m_lDegree+1) == 3 )
		{
			//중지
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), TRUE);
			//중지불가사유
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA16), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE);
			
			//중지
			if( Str_Cmp(stBsNogoodCha.BETTER_ADVICE_YMD, "") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), "공급중");
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), "중지");
			}
		}
		else
		{
			//중지
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), FALSE);
			//중지불가사유
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA16), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE);
		}
	}
	
//-------------------------------------------------------------------------------------------------
	bool Save_Issue(void)
	{
		char szSql[200];
		long idx;
		long i;
		long lDegree = 0;
		long lCount;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL) "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount == 0 )
		{
			MessageBoxEx (WARNING_OK, "부적합 사항이 존재하지 않습니다.\n 발행 할 수 없습니다.");
			ret = FALSE;
			goto Finally;
		}

		Str_Cpy(stBsNogoodCha.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		
		//차수증가
		m_lDegree = m_lDegree+1;
		Str_ItoA(m_lDegree, stBsNogoodCha.BETTER_ADVICE_DEGREE, 10);
		
		//개선권고일자
		Str_Cpy(stBsNogoodCha.BETTER_ADVICE_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(stBsNogoodCha.BETTER_ADVICE_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(stBsNogoodCha.BETTER_ADVICE_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Chg(stBsNogoodCha.BETTER_ADVICE_YMD, STRCHG_DEL_NONDIGIT);
		//Str_Cpy(stBsNogoodCha.BETTER_ADVICE_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA11)));
		//Str_Chg(stBsNogoodCha.BETTER_ADVICE_YMD, STRCHG_DEL_NONDIGIT);
		
		//개선권고기한
		Str_Cpy(stBsNogoodCha.BETTER_ADVICE_EXPIRE, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cat(stBsNogoodCha.BETTER_ADVICE_EXPIRE, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Cat(stBsNogoodCha.BETTER_ADVICE_EXPIRE, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
		Str_Chg(stBsNogoodCha.BETTER_ADVICE_EXPIRE, STRCHG_DEL_NONDIGIT);
		//Str_Cpy( stBsNogoodCha.BETTER_ADVICE_EXPIRE, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA13)));
		//Str_Chg( stBsNogoodCha.BETTER_ADVICE_EXPIRE, STRCHG_DEL_NONDIGIT);
		
		//중지일자,중지불가사유
		if( m_lDegree == 3 )
		{
			Str_Cpy( stBsNogoodCha.SUPPLY_STOP_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA15)));
			Str_Chg( stBsNogoodCha.SUPPLY_STOP_YMD, STRCHG_DEL_NONDIGIT);
			
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SCNOSTOP_WHY );
			if (i == -1)
			{
				Str_Cpy(stBsNogoodCha.NOT_PERMIT_WHY, "");
			}
			else
			{
				Str_Cpy(stBsNogoodCha.NOT_PERMIT_WHY, SCNOSTOP_WHY[i].Code);
			}
		}
		else
		{
			Str_Cpy( stBsNogoodCha.SUPPLY_STOP_YMD, "");
			Str_Cpy( stBsNogoodCha.NOT_PERMIT_WHY, "");
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			m_lDegree = m_lDegree-1;
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
		"INSERT INTO SPECIAL_NOGOOD_CHA \
		( CHK_EXEC_NUM, BETTER_ADVICE_DEGREE, BETTER_ADVICE_YMD, BETTER_ADVICE_EXPIRE, BETTER_YN \
		, BETTER_END_YMD, OBJ_YM, SPECIAL_NUM, CHK_TYPE, SUPPLY_STOP_YMD, NOT_PERMIT_WHY \
		, SEND_YN, CHK_YEAR, CHK_ORDER, PDA_IP, UPD_EMPID ) \
		VALUES(?, ?, ?, ?, 'N', ?, ?, ?, ?, ? \
			 , ?, 'S', ?, ?, ?, ? )" 
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			m_lDegree = m_lDegree-1;
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_EXEC_NUM		  , 12, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_ADVICE_DEGREE  , 1 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_ADVICE_YMD	  , 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_ADVICE_EXPIRE  , 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.BETTER_END_YMD 		  , 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.OBJ_YM         		  , 6 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.SPECIAL_NUM       	  , 7 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_TYPE       		  , 2 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.SUPPLY_STOP_YMD		  , 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.NOT_PERMIT_WHY 		  , 2 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_YEAR       		  , 4 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBsNogoodCha.CHK_ORDER      		  , 2 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		          , 15,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id            , 20,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			m_lDegree = m_lDegree-1;
			ret = FALSE;
			goto Finally;
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//-------------------------------------------------------------------------------------------------
	void Save_Result(void)
	{
		char szSql[300];
		char szDegree[10];
		char szTmp[10];
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szDegree, 0x00, sizeof(szDegree) );
		SPRINT(szSql, "SELECT MAX(BETTER_ADVICE_DEGREE) FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 5, szDegree );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT BETTER_YN FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' AND BETTER_ADVICE_DEGREE = '%s' ", g_szCHK_EXEC_NUM, szDegree, 0   );
		g_Sql_RetStr( szSql, 5, szTmp );		

		if( Str_Cmp(szTmp, "Y") == 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE SPECIAL_NOGOOD SET END_YN = 'Y' WHERE CHK_EXEC_NUM = '%s' "
			,g_szCHK_EXEC_NUM, 0, 0   );
			
			g_Sql_DirectExecute( szSql );
		}
		else
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE SPECIAL_NOGOOD SET END_YN = 'S' WHERE CHK_EXEC_NUM = '%s' "
			,g_szCHK_EXEC_NUM, 0, 0   );
			
			g_Sql_DirectExecute( szSql );
		}
		
		return;
	}
	
	
//-------------------------------------------------------------------------------------------------
	bool Chk_Issue(void)
	{
		bool ret = TRUE;
		char szSql[300];
		char szDate[15];
		char szTmp[10];
		long lCnt;
	
		//금일 부적합차수 발행 확인
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_ItoA (Time_GetDate(), szDate, 10 );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_NOGOOD_CHA  WHERE CHK_EXEC_NUM = '%s' AND BETTER_ADVICE_YMD = '%s' ", g_szCHK_EXEC_NUM, szDate, 0   );
		g_Sql_RetInt( szSql, &lCnt );
		
		if( lCnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "개선권고는 하루에 2회 발급 불가능 합니다.");
			ret = FALSE;
			return ret;
		}
	
		//개선권고부적합 결과 확인
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT BETTER_YN FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' AND BETTER_ADVICE_DEGREE = '%s' "
		, g_szCHK_EXEC_NUM, m_szDegree, 0   );
		g_Sql_RetStr( szSql, 5, szTmp );
		if( Str_Cmp(szTmp, "Y") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "개선이 완료되었습니다.\n확인버튼을 눌러주세요!");
			ret = FALSE;
			return ret;
		}
		
		return ret;
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
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '5' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}
}
