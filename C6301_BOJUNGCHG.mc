/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_BOJUNGCHG
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
		DEF_BUTTON_ID ( BID_CUST )			//고객
		DEF_BUTTON_ID ( BID_ADDR )			//주소
		DEF_BUTTON_ID ( BID_MEMO )			//메모
		DEF_BUTTON_ID ( BID_BARCODE )		//바코드
		DEF_BUTTON_ID ( BID_PHOTO )			//사진
		DEF_BUTTON_ID ( BID_IMPOSSIBLE )	//교체 불가사유입력
		DEF_BUTTON_ID ( BID_SAVE )			//완료
		DEF_BUTTON_ID ( BID_PREVPG )		//이전 대상
		DEF_BUTTON_ID ( BID_NEXTPG )		//다음 대상
//불가사유
		DEF_BUTTON_ID ( BID_IMPCANCEL )
		DEF_BUTTON_ID ( BID_IMPPHOTO )
		DEF_BUTTON_ID ( BID_IMPVIEW )
		DEF_BUTTON_ID ( BID_IMPOK )
//지침입력
		DEF_BUTTON_ID ( BID_VCCANCEL )
		DEF_BUTTON_ID ( BID_VCOK )
		
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
		DEF_OBJECT_ID ( TXT_BORDER )
		DEF_OBJECT_ID ( TXT_PAGE )
				
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
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
		DEF_OBJECT_ID ( TXT_DATA25 )
//불가사유
		DEF_OBJECT_ID ( TXT_DATA34 )
		DEF_OBJECT_ID ( TXT_DATA35 )
//지침입력
		DEF_OBJECT_ID ( TXT_DATA36 )
		DEF_OBJECT_ID ( TXT_DATA37 )
		DEF_OBJECT_ID ( TXT_DATA38 )
		DEF_OBJECT_ID ( TXT_DATA39 )
		DEF_OBJECT_ID ( TXT_DATA40 )
		DEF_OBJECT_ID ( TXT_DATA41 )

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
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )
		DEF_OBJECT_ID ( EDT_DATA8 )
		DEF_OBJECT_ID ( EDT_DATA9 )
		DEF_OBJECT_ID ( EDT_DATA10 )

//지침입력
		DEF_OBJECT_ID ( EDT_DATA11 )
		DEF_OBJECT_ID ( EDT_DATA12 )
		DEF_OBJECT_ID ( EDT_DATA13 )
		DEF_OBJECT_ID ( EDT_DATA14 )
		DEF_OBJECT_ID ( EDT_DATA15 )
		DEF_OBJECT_ID ( EDT_DATA16 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3)
//불가사유
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3)
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3)
	END_OBJECT_ID()
	
	#define INIT_MAIN		1
	#define INIT_IMPOSSIBLE	2
	#define INIT_VC			3
		
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
	
	char m_szTitle[50];
	char m_szSql[1100];
	char m_szTmp[400];
	char m_szBartmp[40];
	char m_szCnt_index[10];
	char m_szfilenm[50];
	char m_szMakernum[20];		//COMPENS_MODEL에 MAKER_NUM 저장

	
	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	long m_lPrev;
	long m_lTotCnt;
	long m_lSaveFlag = 0;	//0 : default, 1 : 불가사유 저장.
	long m_lBarLen = 0;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void SetData(void);
	void SetCombo(void);
	void Set_Index(void);
	void ReDraw(void);
	void AddrDraw(void);
	void InstMtrDraw(void);
	void ImpossibleDraw(void);
	void Prev_Mtr(void);
	void Next_Mtr(void);
	long FS_GetSrchTotCnt(void);
	void Barcode(void);
	void OnBarcodeRead(void);
	void Barcode_Func(void);
	void SaveInput(void);
	bool Save_Result(void);
	bool Validate(void);
	long Save_Float(void);
	long Chk_Float( char * szfloat );
	bool Save_Impossible(void);
	bool Save_Vc(void);
	void Shoto_Photo(void);
	void Photo_View(void);
	void Save_Cancle(long BtnId);
	void Imp_Cancle(void);
	void ClearData(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle),

		DLG_BUTTON(STARTX,          STARTY+65, 150, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CUST      , "고객"),
		DLG_BUTTON(STARTX,		   STARTY+120, 200, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR      , "지번"),
		//DLG_BUTTON(STARTX+800,     STARTY+770, 185, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO      , "메모"),
		
		DLG_BUTTON(STARTX,		   STARTY+789, 120, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG    , "◀"),
		DLG_BUTTON(STARTX+120,     STARTY+789, 120, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG    , "▶"),
		DLG_BUTTON(STARTX+240,     STARTY+789, 200, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, SANDYBROWN, CALL_FUNC , "", BID_BARCODE   , "바코드"),
		DLG_BUTTON(STARTX+440,     STARTY+789, 180, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, SANDYBROWN, CALL_FUNC , "", BID_PHOTO     , "사진"),
		DLG_BUTTON(STARTX+620,     STARTY+789, 180, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPOSSIBLE, "불가"),
		DLG_BUTTON(STARTX+800,     STARTY+789, 200, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE      , "완료"),
														  
		DLG_TEXT(STARTX+150, 	  STARTY+65,  350, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1 , ""),
		DLG_TEXT(STARTX+500,	  STARTY+65,  260, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+760,      STARTY+65,  240, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index), 
		DLG_TEXT(STARTX+200, 	 STARTY+120,  800,100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX, 		 STARTY+220,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4 , "항목"),
		DLG_TEXT(STARTX+200, 	 STARTY+220,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5 , "철거 보정기"),
		DLG_TEXT(STARTX+580, 	 STARTY+220,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6 , "설치 보정기"),
		DLG_TEXT(STARTX, 	 	 STARTY+270,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "모델"),
		DLG_TEXT(STARTX+200, 	 STARTY+270,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+580, 	 STARTY+270,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX, 		 STARTY+320,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "기물"),
		DLG_TEXT(STARTX+200, 	 STARTY+320,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_EDIT(STARTX+580,	 STARTY+320,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1,20, ""),
		DLG_TEXT(STARTX, 		 STARTY+370,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "유효"),
		DLG_TEXT(STARTX+200, 	 STARTY+370,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+420,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "Vc"),
		DLG_EDIT(STARTX+200,	 STARTY+420,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA2,9, ""),
		DLG_EDIT(STARTX+580,	 STARTY+420,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA3,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+470,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "Va"),
		DLG_EDIT(STARTX+200,	 STARTY+470,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA4,9, ""),
		DLG_EDIT(STARTX+580,	 STARTY+470,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA5,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+520,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "Vm"),
		DLG_EDIT(STARTX+200,	 STARTY+520,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA6,9, ""),
		DLG_EDIT(STARTX+580,	 STARTY+520,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA7,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+570,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "온도"),
		DLG_TEXT(STARTX+200, 	 STARTY+570,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_EDIT(STARTX+580,	 STARTY+570,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA8,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+620,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "압력"),
		DLG_TEXT(STARTX+200, 	 STARTY+620,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_EDIT(STARTX+580,	 STARTY+620,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA9,9, ""),
		DLG_TEXT(STARTX, 		 STARTY+670,  200, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "계수"),
		DLG_TEXT(STARTX+200, 	 STARTY+670,  380, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_EDIT(STARTX+580,	 STARTY+670,  420, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA10,9, ""),
        DLG_TEXT(STARTX, 	 	 STARTY+720,  300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+300,	 STARTY+720,  150, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "사유"),
		DLG_TEXT(STARTX+850, 	 STARTY+720,  150, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),

		DLG_COMBO(STARTX+580, STARTY+370, 420, 290, 100, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO(STARTX+450, STARTY+720, 400, 290, 130, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		
		//숫자 자판
		DLG_TEXT(0,   STARTY+1020, 333, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT(333, STARTY+1020, 333, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT(666, STARTY+1020, 334, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1090, 333, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT(333, STARTY+1090, 333, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT(666, STARTY+1090, 334, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT(0,   STARTY+1160, 333, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1160, 333, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1160, 334, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT(333, STARTY+1230, 333, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT(666, STARTY+1230, 334, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "←"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, m_szTitle),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,          STARTY-40, 150, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CUST      , "고객"),
		DLG_BUTTON(STARTX,		    STARTY+15, 200, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR      , "지번"),
		//DLG_BUTTON(STARTX+800,     STARTY+770, 185, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO      , "메모"),
		
		DLG_BUTTON(STARTX,		   STARTY+780, 140, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG    , "◀"),
		DLG_BUTTON(STARTX+140,     STARTY+780, 140, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG    , "▶"),
		DLG_BUTTON(STARTX+280,     STARTY+780, 180, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, SANDYBROWN, CALL_FUNC , "", BID_BARCODE   , "바코드"),
		DLG_BUTTON(STARTX+460,     STARTY+780, 180, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, SANDYBROWN, CALL_FUNC , "", BID_PHOTO     , "사진"),
		DLG_BUTTON(STARTX+640,     STARTY+780, 180, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPOSSIBLE, "불가"),
		DLG_BUTTON(STARTX+820,     STARTY+780, 180, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE      , "완료"),
														  
		DLG_TEXT(STARTX+150, 	  STARTY-40,  350, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1 , ""),
		DLG_TEXT(STARTX+500,	  STARTY-40,  260, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+760,      STARTY-40,  240, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index), 
		DLG_TEXT(STARTX+200, 	  STARTY+15,  800,110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX, 		 STARTY+125,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4 , "항목"),
		DLG_TEXT(STARTX+200, 	 STARTY+125,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5 , "철거 보정기"),
		DLG_TEXT(STARTX+580, 	 STARTY+125,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6 , "설치 보정기"),
		DLG_TEXT(STARTX, 	 	 STARTY+180,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "모델"),
		DLG_TEXT(STARTX+200, 	 STARTY+180,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+580, 	 STARTY+180,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX, 		 STARTY+235,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "기물"),
		DLG_TEXT(STARTX+200, 	 STARTY+235,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_EDIT(STARTX+580,	 STARTY+235,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1,20, ""),
		DLG_TEXT(STARTX, 		 STARTY+290,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "유효"),
		DLG_TEXT(STARTX+200, 	 STARTY+290,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+345,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "Vc"),
		DLG_EDIT(STARTX+200,	 STARTY+345,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA2,9, ""),
		DLG_EDIT(STARTX+580,	 STARTY+345,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA3,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+400,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "Va"),
		DLG_EDIT(STARTX+200,	 STARTY+400,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA4,9, ""),
		DLG_EDIT(STARTX+580,	 STARTY+400,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA5,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+455,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "Vm"),
		DLG_EDIT(STARTX+200,	 STARTY+455,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA6,9, ""),
		DLG_EDIT(STARTX+580,	 STARTY+455,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA7,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+510,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "온도"),
		DLG_TEXT(STARTX+200, 	 STARTY+510,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_EDIT(STARTX+580,	 STARTY+510,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA8,9, ""),
		DLG_TEXT(STARTX, 	 	 STARTY+565,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "압력"),
		DLG_TEXT(STARTX+200, 	 STARTY+565,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_EDIT(STARTX+580,	 STARTY+565,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA9,9, ""),
		DLG_TEXT(STARTX, 		 STARTY+620,  200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "계수"),
		DLG_TEXT(STARTX+200, 	 STARTY+620,  380, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_EDIT(STARTX+580,	 STARTY+620,  420, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA10,9, ""),
        DLG_TEXT(STARTX, 	 	 STARTY+675,  300, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+300,	 STARTY+675,  150, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "사유"),
		DLG_TEXT(STARTX+850, 	 STARTY+675,  150, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),

		DLG_COMBO(STARTX+580, STARTY+290, 420, 290, 150, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO(STARTX+450, STARTY+675, 400, 290, 150, 55, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};		

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_IMPOSSIBLE[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "불가사유등록"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_IMPCANCEL, ""),

		DLG_BUTTON(STARTX,     STARTY+150, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPPHOTO , "사진 촬영"),
		DLG_BUTTON(STARTX+500, STARTY+150, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPVIEW , "사진보기"),
		DLG_BUTTON(STARTX,     STARTY+250, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPCANCEL , "취 소"),
		DLG_BUTTON(STARTX+500, STARTY+250, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPOK , "확 인"),
		
		DLG_TEXT(STARTX, 	   STARTY-29,  300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, "방문일자"),
		DLG_TEXT(STARTX, 	   STARTY+41,  300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA35, "불가사유"),
		
		DLG_COMBO(STARTX+300,  STARTY-29, 700, 290, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 15),
		DLG_COMBO(STARTX+300,  STARTY+41, 700, 290, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_IMPOSSIBLE_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "불가사유등록"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_IMPCANCEL, ""),

		DLG_BUTTON(STARTX,     STARTY+180, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPPHOTO , "사진 촬영"),
		DLG_BUTTON(STARTX+495, STARTY+180, 498, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPVIEW , "사진보기"),
		DLG_BUTTON(STARTX,     STARTY+270, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPCANCEL , "취 소"),
		DLG_BUTTON(STARTX+495, STARTY+270, 498, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPOK , "확 인"),
		
		DLG_TEXT(STARTX, 	   STARTY+10,  300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, "방문일자"),
		DLG_TEXT(STARTX, 	   STARTY+80,  300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA35, "불가사유"),
		
		DLG_COMBO(STARTX+300,  STARTY+10, 685, 290, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 15),
		DLG_COMBO(STARTX+300,  STARTY+80, 685, 290, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
	};		

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_VC[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "지침입력"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VCCANCEL, ""),

		DLG_BUTTON(STARTX,     STARTY+310, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VCCANCEL , "취 소"),
		DLG_BUTTON(STARTX+735, STARTY+310, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VCOK , "확 인"),
		
		DLG_TEXT(STARTX, 	 	 STARTY+10,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA36, ""),
		DLG_TEXT(STARTX+250,     STARTY+10,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA37, "철거지침"),
		DLG_TEXT(STARTX+615, 	 STARTY+10,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA38, "설치지침"),
		DLG_TEXT(STARTX,		 STARTY+80,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA39, "Vc"),
		DLG_EDIT(STARTX+250,	 STARTY+80,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA4, 9, ""),
		DLG_EDIT(STARTX+615,	 STARTY+80,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA5, 9, ""),
		DLG_TEXT(STARTX, 	    STARTY+150,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA40, "Va"),
		DLG_EDIT(STARTX+250,	STARTY+150,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA6, 9, ""),
		DLG_EDIT(STARTX+615,	STARTY+150,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA7, 9, ""),
		DLG_TEXT(STARTX, 	   	STARTY+220,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA41, "Vm"),
		DLG_EDIT(STARTX+250,	STARTY+220,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA8, 9, ""),
		DLG_EDIT(STARTX+615,	STARTY+220,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA9, 9, ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_VC_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "불가사유등록"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VCCANCEL, ""),

		DLG_BUTTON(STARTX,     STARTY+310, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VCCANCEL , "취 소"),
		DLG_BUTTON(STARTX+735, STARTY+310, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VCOK , "확 인"),
		
		DLG_TEXT(STARTX, 	 	 STARTY+10,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA36, ""),
		DLG_TEXT(STARTX+250,     STARTY+10,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA37, "철거지침"),
		DLG_TEXT(STARTX+615, 	 STARTY+10,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA38, "설치지침"),
		DLG_TEXT(STARTX,		 STARTY+80,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA39, "Vc"),
		DLG_EDIT(STARTX+250,	 STARTY+80,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA4, 9, ""),
		DLG_EDIT(STARTX+615,	 STARTY+80,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA5, 9, ""),
		DLG_TEXT(STARTX, 	    STARTY+150,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA40, "Va"),
		DLG_EDIT(STARTX+250,	STARTY+150,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA6, 9, ""),
		DLG_EDIT(STARTX+615,	STARTY+150,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA7, 9, ""),
		DLG_TEXT(STARTX, 	   	STARTY+220,  250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA41, "Vm"),
		DLG_EDIT(STARTX+250,	STARTY+220,  365, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA8, 9, ""),
		DLG_EDIT(STARTX+615,	STARTY+220,  370, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA9, 9, ""),
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
		char szDate[15];
		
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
				
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				
				if( m_lSaveFlag == 1 )
				{
					m_lSaveFlag = 0;
					OnButton(BID_NEXTPG);
					break;
				}
				
				if( g_lDataflag == 0 && g_nBojungFlag == 2 )
				{
					SetData();
					ReDraw();
				}
				else
				{
					ReDraw();
				}
				
				SetCombo();

				Mem_Set( (byte*)m_szTitle, 0x00, sizeof(m_szTitle) );
				if( Str_Cmp(stMtrChg.REPL_OCCU_FLAG, "20") == 0 )
				{
					Str_Cpy(m_szTitle, "보정장치 민원교체");
				}
				else
				{
					Str_Cpy(m_szTitle, "보정장치 노후교체");
				}
				ON_DRAW();
				break;
			case INIT_IMPOSSIBLE:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_IMPOSSIBLE_P, SIZEOF(DlgRes_IMPOSSIBLE_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_IMPOSSIBLE, SIZEOF(DlgRes_IMPOSSIBLE));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				Str_ItoA(Time_GetDate(), m_szTmp, 10);
				g_Str_DateType( szDate, m_szTmp);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), szDate);
				
				ImpossibleDraw();
				
				ON_DRAW();
				break;
			case INIT_VC:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_VC_P, SIZEOF(DlgRes_VC_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_VC, SIZEOF(DlgRes_VC));
						break;		
				}
				SetBtnImg();
				SetStyle();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[150];
		long lCnt;
	
		switch(ID)
		{
			case BID_CUST:
				//g_lChgMtr_WorkFlag > = 0 가정용 계량기, = 1 대용량 계량기, = 2 보정기
				g_lChgMtr_WorkFlag = 2;

				g_lDataflag = 1;
				SaveInput();
				Set_Index();
				g_nPhotoFlag = 8;
				Card_Move("C6301_CUSTINFO");
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
				AddrDraw();
				break;
			case BID_BARCODE:
				m_lBarLen = Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				if( m_lBarLen > 9 && m_lBarLen < 17 )
				{
					Mem_Set( (byte*)m_szBartmp, 0x00, sizeof(m_szBartmp) );
					Str_Cpy(m_szBartmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
					Barcode_Func();
					ON_DRAW();
				}

				Barcode();
				break;
			case BID_PHOTO:
				Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
				Str_Cpy(g_szSqlWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA3)));

				//g_lChgMtr_WorkFlag > = 0 가정용 계량기, = 1 대용량 계량기, = 2 보정기
				g_lChgMtr_WorkFlag = 2;
				g_lDataflag = 1;
				g_nPhotoFlag = 8;
				SaveInput();
				Set_Index();
				Card_Move("C6301_PHOTO");
				break;
			case BID_IMPOSSIBLE:
/*
				if( Str_Len(stMtrChg.REPL_NOT_PERMIT_WHY) > 0 )
				{
					MessageBoxEx (CONFIRM_OK, "이미 불가 입력한 자료입니다.");
					break;
				}
				else if( Str_Cmp(stMtrChg.SEND_YN, "S") == 0 || Str_Cmp(stMtrChg.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "이미 교체 완료한 자료 입니다.");
					break;
				}
*/
				if( ( Str_Cmp(stMtrChg.SEND_YN, "S") == 0 || Str_Cmp(stMtrChg.SEND_YN, "Y") == 0 ) && Str_Len(stMtrChg.REPL_NOT_PERMIT_WHY) > 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "교체 불가를 정상으로 되돌리시겠습니까?")  == MB_OK)
					{
						Imp_Cancle();
						SetData();
						ReDraw();
						break;
					}
					else
					{
						break;
					}
				}
				else
				{
					g_lDataflag = 1;
					SaveInput();
					Set_Index();
					Mem_Set( (byte*)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere) );
					Str_Cpy(g_szSqlWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA3)));
				
					ON_EXIT();
					OnInit(INIT_IMPOSSIBLE);
				}
				break;
			case BID_SAVE:
				if( Str_Cmp(stMtrChg.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "이미 송신완료한 자료 입니다.");
				}
				else if( Str_Cmp(stMtrChg.SEND_YN, "S") == 0 && Str_Len(stMtrChg.REPL_NOT_PERMIT_WHY) == 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "완료를 취소하겠습니까?")  == MB_OK)
					{
						Save_Cancle(ID);
						SetData();
						ReDraw();
						Set_Index();
						break;
					}
					else
					{
						break;
					}
				}
				else
				{
					Set_Index();
					if( Validate() )
					{
						g_nPhotoYNFlag = 0;
						Card_Move("C6301_LST");
					}
				}
				
				break;
			case BID_PREVPG:
				g_lDataflag = 0;
				g_nPhotoYNFlag = 0;
				Prev_Mtr();
				break;
			case BID_NEXTPG:
				g_lDataflag = 0;
				g_nPhotoYNFlag = 0;
				Next_Mtr();
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Set_Index();
					g_Del_GcPhoto();
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "보정기교체 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Set_Index();
					g_Del_GcPhoto();
					Card_Move("C6301_MENU");
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
				
				g_nPhotoYNFlag = 0;
				Set_Index();
				g_Del_GcPhoto();
				Card_Move("C6301_LST");
				break;	
			case GID_VMEXIT:
				Set_Index();
				g_Exit_DelGcData();
				break;
				
//불가사유
			case BID_IMPOK:
				if( Save_Impossible() )
				{
					Save_Cancle(ID);
					m_lSaveFlag = 1;
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_IMPVIEW:
				Photo_View();
				break;
			case BID_IMPPHOTO:
				Shoto_Photo();
				break;
			case BID_IMPCANCEL:
				Imp_Cancle();
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
		}
	}		

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		if( m_bFirst == INIT_MAIN )
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA7) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}
			}
		}
		else if( m_bFirst == INIT_VC )
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA11) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA12) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA13) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA14) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA15) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA16) == m_lEditCtrlIndex  )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}
			}
		}
	}


	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL에 ACTIVE시에 CTRLINDEX를 저장
		//키보드 BUTTONCTRL이 ACTIVE시에도 EDITCTRL에 커서를 두기위해서 INDEX를 저장
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+580) && X < DMS_X(STARTX+985) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+370) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+200) && X < DMS_X(STARTX+580) && Y > DMS_Y(STARTY+420-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+470-(g_Dlgflag*400))
						  || X > DMS_X(STARTX+580) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+420-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+470-(g_Dlgflag*400))
						  || X > DMS_X(STARTX+200) && X < DMS_X(STARTX+580) && Y > DMS_Y(STARTY+470-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+520-(g_Dlgflag*400))
						  || X > DMS_X(STARTX+580) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+470-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+520-(g_Dlgflag*400))
						  || X > DMS_X(STARTX+200) && X < DMS_X(STARTX+580) && Y > DMS_Y(STARTY+520-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+570-(g_Dlgflag*400))
						  || X > DMS_X(STARTX+580) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+520-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+570-(g_Dlgflag*400)))
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex )	
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
					else if( X > DMS_X(STARTX+580) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+570-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+620-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+580) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+620-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+670-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA9) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+580) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+670-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+720-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA10) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex
						 || Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex )	
						{
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1020-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*400))  )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1020-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1020-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1160-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1160-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1160-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1160-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1230-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1160-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1230-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1160-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1230-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1230-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1230-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
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
						else
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
						}
					}
				}
				
				ON_DRAW();
			}
		}
		else if( m_bFirst == INIT_VC )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+565) && Y > DMS_Y(STARTY+80) && Y < DMS_Y(STARTY+150) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA11) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+565) && X < DMS_X(STARTX+985) && Y > DMS_Y(STARTY+80) && Y < DMS_Y(STARTY+150) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA12) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+565) && Y > DMS_Y(STARTY+150) && Y < DMS_Y(STARTY+220) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA13) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+565) && X < DMS_X(STARTX+985) && Y > DMS_Y(STARTY+150) && Y < DMS_Y(STARTY+220) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA14) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+565) && Y > DMS_Y(STARTY+220) && Y < DMS_Y(STARTY+290) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA15) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+565) && X < DMS_X(STARTX+985) && Y > DMS_Y(STARTY+220) && Y < DMS_Y(STARTY+290) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA16) == lActiveIndex )	
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

						g_Dlgflag = 1;
						g_MOVE_DLG(1);
					}
				}
				
				ON_DRAW();
			}
		}
	}

//------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		if( m_bFirst == INIT_MAIN )
		{
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30011' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), 0, 0   );
			g_Sql_RetStr( m_szSql, 30, stMtrChg.COMPENS_REPL_WHY );
		
			if( Str_Cmp(stMtrChg.COMPENS_REPL_WHY, "20") == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), "유상");
				Str_Cpy(stMtrChg.COMPENS_FEE_FREE_FLAG, "Y");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), "무상");
				Str_Cpy(stMtrChg.COMPENS_FEE_FREE_FLAG, "N");
			}
			
			ON_DRAW();
		}
		return;
	}	


//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
			if( theDevInfo.m_nType > FAMILY_PDA )
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}

	}
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9), EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA10), EDITALIGN_MIDDLE);

	        EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	        
	        EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA3), TRUE, 2, EDITSEP_NONE );

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
		else if( m_bFirst == INIT_IMPOSSIBLE )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_VC )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA11), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA12), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA13), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA14), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA15), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA16), EDITALIGN_MIDDLE);
		}
	}

//------------------------------------------------------------------
	void SetCombo(void)
	{
		long i;
		long lRet, lDate, lYear, lMonth;
		char szDate[30];
		char szYear[20];
		char szMonth[20];
		char szRet[30];
	
		if( m_bFirst == INIT_MAIN )
		{
			//유효
			Mem_Set( (byte*)szYear, 0x00, sizeof(szYear) );
			Mem_Set( (byte*)szMonth, 0x00, sizeof(szMonth) );
			
			// 1000등급 초과
			if( Str_AtoI(stMtrChg.MTR_GRD) > 1000 )
			{
				lYear = Time_GetYear();
				Str_ItoA(lYear, szYear, 10);
				
				lMonth = Time_GetMonth();
				
				if( lMonth < 10 )
				{
					Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
					Str_ItoA(lMonth, m_szTmp, 10);
					Str_Cpy(szMonth, "0");
					Str_Cat(szMonth, m_szTmp);
				}
				else
				{
					Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
					Str_ItoA(lMonth, m_szTmp, 10);
					Str_Cpy(szMonth, m_szTmp);
				}

				Str_Cat(szYear, szMonth);
				Str_Cat(szYear, "15");
				lDate = Str_AtoI(szYear) + 100000;		//10년
			
				for(i = 0 ; i < 6 ; i++)
				{
					lRet = Time_DateUpDown ( lDate, -(i*30) ); 
					Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
					Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
					Str_ItoA( lRet, szDate, 10);
					Mem_Cpy( (byte*)szRet, (byte*)szDate, 6);
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), szRet, 0, ICON_NONE);
				}
			}
			// 10등급
			else if( Str_AtoI(stMtrChg.MTR_GRD) == 10 )
			{
				lYear = Time_GetYear();
				Str_ItoA(lYear, szYear, 10);
				
				lMonth = Time_GetMonth();
				if( lMonth < 10 )
				{
					Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
					Str_ItoA(lMonth, m_szTmp, 10);
					Str_Cpy(szMonth, "0");
					Str_Cat(szMonth, m_szTmp);
				}
				else
				{
					Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
					Str_ItoA(lMonth, m_szTmp, 10);
					Str_Cpy(szMonth, m_szTmp);
				}
				
				Str_Cat(szYear, szMonth);
				Str_Cat(szYear, "15");
				lDate = Str_AtoI(szYear) + 50000;		//5년
			
				for(i = 0 ; i < 6 ; i++)
				{
					lRet = Time_DateUpDown ( lDate, -(i*30) ); 
					Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
					Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
					Str_ItoA( lRet, szDate, 10);
					Mem_Cpy( (byte*)szRet, (byte*)szDate, 6);
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), szRet, 0, ICON_NONE);
				}
			}
			// 11~1000등급
			else
			{
				lYear = Time_GetYear();
				Str_ItoA(lYear, szYear, 10);
				
				lMonth = Time_GetMonth();
				if( lMonth < 10 )
				{
					Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
					Str_ItoA(lMonth, m_szTmp, 10);
					Str_Cpy(szMonth, "0");
					Str_Cat(szMonth, m_szTmp);
				}
				else
				{
					Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
					Str_ItoA(lMonth, m_szTmp, 10);
					Str_Cpy(szMonth, m_szTmp);
				}

				Str_Cat(szYear, szMonth);
				Str_Cat(szYear, "15");
				lDate = Str_AtoI(szYear) + 80000;		//8년

				for(i = 0 ; i < 6 ; i++)
				{
					lRet = Time_DateUpDown ( lDate, -(i*30) ); 
					Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
					Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
					Str_ItoA( lRet, szDate, 10);
					Mem_Cpy( (byte*)szRet, (byte*)szDate, 6);
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), szRet, 0, ICON_NONE);
				}
			}

			//교체사유
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30011'", CMB_DATA2+2);	
		}
		else if( m_bFirst == INIT_IMPOSSIBLE )
		{
			//방문일자
			lDate = Time_GetDate();
			for(i = 0 ; i < 5 ; i++)
			{
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
				lRet = Time_DateUpDown ( lDate, -i ); 
				Str_ItoA(lRet, szRet, 10);
				g_Str_DateType( szDate, szRet);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), szDate, 0, ICON_NONE);
			}
			
			//불가사유
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30125'", CMB_DATA4+2);
		}
		return;
	}

//------------------------------------------------------------------
	void SetData(void)
	{
		long i;
		char szindex[5];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stMtrChg, 0x00, sizeof(stMtrChg));
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT \
ROWID, MTR_NUM, OBJ_CRT_YMD, REPL_OCCU_FLAG, CENTER_CD, PDA_REPL_JOB_ITEM, INST_PLACE_NUM, CITY, AREA, TOWN, VILLAGE \
, ADDR1_M, ADDR1_S, LOT_NUM_SECOND_ADDR, TRIM(CO_LIVE_NM), TRIM(HOUSE_CNT), BLD_NM, DETA_FLOOR, CUST_NUM, CUST_TYPE_CD, CUST_NM \
, FIRM_NM, BIZ_REGI_NUM, TRIM(SOC_NUM), REPRE_NM, CP_DDD, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM \
, FIRM_TEL_DDD, FIRM_TEL_EXN, FIRM_TEL_NUM, USE_CONT_NUM, PROD_NM, CONT_YMD, CNL_YMD, MTR_ID_NUM, MTR_MODEL_CD, MTR_GRD \
, MTR_FORM, MTR_TYPE, MTR_REMOTE_FLAG, MTR_KIND, MTR_FORM_APPRO_YN, MTR_DIGIT_CNT, MTR_NEW_FIX_FLAG, FIX_FIRM_NM_CD \
, MTR_VALID_YM, MTR_LOC_FLAG, MTR_DETA_LOC, COMPENS_NUM, COMPENS_ID_NUM, COMPENS_MODEL_CD, COMPENS_FLAG, COMPENS_VALID_YM \
, COMPENS_FORM_APPRO_YN, BEFO_INDI_VM, BEFO_INDI_VA, BEFO_INDI_VC, REPL_STS, ZIP_NO1, ZIP_NO2, MTR_FEE_FREE_FLAG, MTR_REPL_WHY \
, MTR_BAR, AFTER_MTR_ID_NUM, AFTER_MTR_MODEL_CD, AFTER_MTR_GRD, AFTER_MTR_FORM, AFTER_MTR_TYPE, AFTER_MTR_REMOTE_FLAG \
, AFTER_MTR_KIND, AFTER_MTR_DIGIT_CNT, AFTER_MTR_NEW_FIX_FLAG, AFTER_FIX_FIRM_NM_CD, AFTER_MTR_VALID_YM, COMPENS_FEE_FREE_FLAG \
, COMPENS_REPL_WHY, COMPENS_BAR, AFTER_COMPENS_NUM, AFTER_COMPENS_ID_NUM, AFTER_COMPENS_MODEL_CD, AFTER_COMPENS_VALID_YM \
, AFTER_COMPENS_PRESS, REMOVE_INDI_VM, REMOVE_INDI_VA, REMOVE_INDI_VC, REMOVE_MTR_FLAG, REPL_NOT_PERMIT_WHY, JOB_DTM \
, JOBER_EMPID, MTR_PHOTO, COMPENS_PHOTO, CUST_SIGN, SEND_YN, AFTER_MTR_APPRO_YN, AFTER_FORM_APPRO_YN, INST_INDI_VM, INST_INDI_VA \
, INST_INDI_VC, TEMPER, PRESS, REVIS_PARA, BEFO_TEMPER, BEFO_PRESS, BEFO_REVIS_PARA, UPD_DTM, UPD_EMPID, CRT_DTM, CRT_EMPID \
, PDA_NUM, TREAT_FLAG, REVIS_FLAG, MTR_SUPPLY_STS, TRIM(COMPENS_MAKER_NM), VISIT_YMD, MEMO, LAW_TOWN, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S, BACK_REPL_STS \
FROM C6301_CHANGEDATA WHERE ROWID = ?"
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		Mem_Set((byte*)&szindex, 0x00, sizeof(szindex));
		Str_ItoA(g_lindex,szindex,10);

		sql->Bind(sql, i++, 'U', (long*)&szindex , 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.ROWID                   , 3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_NUM                 , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.OBJ_CRT_YMD             , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REPL_OCCU_FLAG          , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CENTER_CD               , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.PDA_REPL_JOB_ITEM       , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.INST_PLACE_NUM          , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CITY                    , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AREA                    , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.TOWN                    , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.VILLAGE                 , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.ADDR1_M                 , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.ADDR1_S                 , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.LOT_NUM_SECOND_ADDR     , 100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CO_LIVE_NM              , 60 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.HOUSE_CNT               , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BLD_NM                  , 150+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.DETA_FLOOR              , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CUST_NUM                , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CUST_TYPE_CD            , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CUST_NM                 , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.FIRM_NM                 , 50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BIZ_REGI_NUM            , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.SOC_NUM                 , 13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REPRE_NM                , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CP_DDD                  , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CP_EXN                  , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CP_NUM                  , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.OWNHOUSE_TEL_DDD        , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.OWNHOUSE_TEL_EXN        , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.OWNHOUSE_TEL_NUM        , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.FIRM_TEL_DDD            , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.FIRM_TEL_EXN            , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.FIRM_TEL_NUM            , 4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.USE_CONT_NUM            , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.PROD_NM                 , 50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CONT_YMD                , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CNL_YMD                 , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_ID_NUM              , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_MODEL_CD            , 5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_GRD                 , 7  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_FORM                , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_TYPE                , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_REMOTE_FLAG         , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_KIND                , 3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_FORM_APPRO_YN       , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_DIGIT_CNT           , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_NEW_FIX_FLAG        , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.FIX_FIRM_NM_CD          , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_VALID_YM            , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_LOC_FLAG            , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_DETA_LOC            , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_NUM             , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_ID_NUM          , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_MODEL_CD        , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_FLAG            , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_VALID_YM        , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_FORM_APPRO_YN   , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BEFO_INDI_VM            , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BEFO_INDI_VA            , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BEFO_INDI_VC            , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REPL_STS                , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.ZIP_NO1                 , 3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.ZIP_NO2                 , 3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_FEE_FREE_FLAG       , 1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_REPL_WHY            , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_BAR                 , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_ID_NUM        , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_MODEL_CD      , 5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_GRD           , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_FORM          , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_TYPE          , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_REMOTE_FLAG   , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_KIND          , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_DIGIT_CNT     , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_NEW_FIX_FLAG  , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_FIX_FIRM_NM_CD    , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_VALID_YM      , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_FEE_FREE_FLAG   , 1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_REPL_WHY        , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_BAR             , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_COMPENS_NUM       , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_COMPENS_ID_NUM    , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_COMPENS_MODEL_CD  , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_COMPENS_VALID_YM  , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_COMPENS_PRESS     , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REMOVE_INDI_VM          , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REMOVE_INDI_VA          , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REMOVE_INDI_VC          , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REMOVE_MTR_FLAG         , 6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REPL_NOT_PERMIT_WHY     , 3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.JOB_DTM                 , 14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.JOBER_EMPID             , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_PHOTO               , 128+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_PHOTO           , 128+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CUST_SIGN               , 200+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.SEND_YN                 , 1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_MTR_APPRO_YN      , 1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.AFTER_FORM_APPRO_YN     , 1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.INST_INDI_VM            , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.INST_INDI_VA            , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.INST_INDI_VC            , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.TEMPER                  , 13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.PRESS                   , 7  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REVIS_PARA              , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BEFO_TEMPER             , 13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BEFO_PRESS              , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BEFO_REVIS_PARA         , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.UPD_DTM                 , 14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.UPD_EMPID               , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CRT_DTM                 , 14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.CRT_EMPID               , 9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.PDA_NUM                 , 1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.TREAT_FLAG              , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.REVIS_FLAG              , 2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MTR_SUPPLY_STS          , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.COMPENS_MAKER_NM        , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.VISIT_YMD               , 8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.MEMO                    , 100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.LAW_TOWN                , 30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.NEW_ROAD_NM             , 255+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.NEW_ADDR_M              , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.NEW_ADDR_S              , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stMtrChg.BACK_REPL_STS           , 2  +1, DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}


Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		return;

	}

	/*=======================================================================================
	함수명 : Prev_Mtr
	기  능 : 이전 버튼시 이전대상을 찾는다.
	Param  : 
	Return : 
	========================================================================================*/
	void Prev_Mtr(void)
	{
		char szPdaReplJobItem[20];
		char szMtrGrd[20];

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
		{	//검색 후, 첫번째 고객 메세지 박스 변수
			m_lPrev--;
		}

		if( g_lindex <= 0 || g_nActIndex < 0 )
		{
			g_nActIndex = 0;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			if( m_lPrev < 0 )
			{
				m_lPrev = 0;
				//MessageBoxEx (CONFIRM_OK, "첫번째 고객입니다.");
			}
			return;
		}
		
		g_nPhotoFlag = 8;
		g_Del_GcPhoto();
		
		Mem_Set((byte*)szPdaReplJobItem, 0x00, sizeof(szPdaReplJobItem));
		Mem_Set((byte*)m_szSql, 0x00, sizeof(m_szSql));
		SPRINT(m_szSql, "SELECT PDA_REPL_JOB_ITEM FROM C6301_CHANGEDATA WHERE ROWID = '%d'", g_lindex, 0, 0);
		g_Sql_RetStr( m_szSql, 20, szPdaReplJobItem );
		
		Mem_Set((byte*)szMtrGrd, 0x00, sizeof(szMtrGrd));
		Mem_Set((byte*)m_szSql, 0x00, sizeof(m_szSql));
		SPRINT(m_szSql, "SELECT MTR_GRD FROM C6301_CHANGEDATA WHERE ROWID = '%d'", g_lindex, 0, 0);
		g_Sql_RetStr( m_szSql, 20, szMtrGrd );

		//g_nBojungFlag;    //보정기 보정기기 유무 Flag , Flag = 0 보정기없음, Flag = 1 보정기있음, Flag = 2 단일보정기
		if( Str_Cmp(szPdaReplJobItem, "10") == 0 || Str_Cmp(szPdaReplJobItem, "30") == 0 )
		{
			if( Str_AtoI(szMtrGrd) >= 10 )
			{
				if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "10") == 0 )
				{
					g_nBojungFlag = 0;
				}
				else
				{
					g_nBojungFlag = 1;
				}
				Set_Index();
				Card_Move("C6301_BIGCHG");
			}
			else if( Str_AtoI(szMtrGrd) < 10 )
			{
				if( Str_Cmp(szPdaReplJobItem, "10") == 0 )
				{
					g_nBojungFlag = 0;
				}
				else
				{
					g_nBojungFlag = 1;
				}
				Set_Index();
				Card_Move("C6301_MTRCHG");
			}
		}
		else if( Str_Cmp(szPdaReplJobItem, "20") == 0 )
		{
			g_nBojungFlag = 2;
			Set_Index();
			ON_EXIT();
			OnInit(INIT_MAIN);
		}
		return;
	}
	
	/*=======================================================================================
	함수명 : Next_Mtr
	기  능 : 다운 버튼시 다음대상을 찾는다.
	Param  : 
	Return : 
	========================================================================================*/
	void Next_Mtr(void)
	{
		char szPdaReplJobItem[20];
		char szMtrGrd[20];

		m_lPrev = 0;

		g_nActIndex++;
		g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

		if( g_nActIndex > m_lTotCnt || g_lindex < 0 )
		{
			if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
			{
				g_nActIndex = g_nActIndex-1;
			}
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			//MessageBoxEx (CONFIRM_OK, "마지막 고객입니다.");
			//마지막 대상 점검 시 화면 리프레시
			SetData();
			ReDraw();

			return;
		}
		
		g_nPhotoFlag = 8;
		g_Del_GcPhoto();
		
		Mem_Set((byte*)szPdaReplJobItem, 0x00, sizeof(szPdaReplJobItem));
		Mem_Set((byte*)m_szSql, 0x00, sizeof(m_szSql));
		SPRINT(m_szSql, "SELECT PDA_REPL_JOB_ITEM FROM C6301_CHANGEDATA WHERE ROWID = '%d'", g_lindex, 0, 0);
		g_Sql_RetStr( m_szSql, 20, szPdaReplJobItem );
		
		Mem_Set((byte*)szMtrGrd, 0x00, sizeof(szMtrGrd));
		Mem_Set((byte*)m_szSql, 0x00, sizeof(m_szSql));
		SPRINT(m_szSql, "SELECT MTR_GRD FROM C6301_CHANGEDATA WHERE ROWID = '%d'", g_lindex, 0, 0);
		g_Sql_RetStr( m_szSql, 20, szMtrGrd );

		//g_nBojungFlag;    //보정기 보정기기 유무 Flag , Flag = 0 보정기없음, Flag = 1 보정기있음, Flag = 2 단일보정기
		if( Str_Cmp(szPdaReplJobItem, "10") == 0 || Str_Cmp(szPdaReplJobItem, "30") == 0 )
		{
			if( Str_AtoI(szMtrGrd) >= 10 )
			{
				if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "10") == 0 )
				{
					g_nBojungFlag = 0;
				}
				else
				{
					g_nBojungFlag = 1;
				}
				Set_Index();
				Card_Move("C6301_BIGCHG");
			}
			else if( Str_AtoI(szMtrGrd) < 10 )
			{
				if( Str_Cmp(szPdaReplJobItem, "10") == 0 )
				{
					g_nBojungFlag = 0;
				}
				else
				{
					g_nBojungFlag = 1;
				}
				Set_Index();
				Card_Move("C6301_MTRCHG");
			}
		}
		else if( Str_Cmp(szPdaReplJobItem, "20") == 0 )
		{
			g_nBojungFlag = 2;
			Set_Index();
			ON_EXIT();
			OnInit(INIT_MAIN);
		}
		return;
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

		if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
		}
		else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
		}
		else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM10 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
		}
		g_Sql_DirectExecute(szSql);
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


//------------------------------------------------------------------
	void AddrDraw(void)
	{
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );

		if( g_nAddrFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
			
			if( Str_Len(stMtrChg.CO_LIVE_NM) == 0 )
			{
				Str_Cpy( m_szTmp, stMtrChg.TOWN);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.VILLAGE);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_M);
				Str_Cat( m_szTmp, "-");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_S);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.HOUSE_CNT);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.LOT_NUM_SECOND_ADDR);
			}
			else
			{
				Str_Cpy( m_szTmp, stMtrChg.TOWN);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.VILLAGE);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_M);
				Str_Cat( m_szTmp, "-");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_S);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.CO_LIVE_NM);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.BLD_NM);
				Str_Cat( m_szTmp, "-");
				Str_Cat( m_szTmp, stMtrChg.HOUSE_CNT);
			}
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
			Str_Cpy( m_szTmp, stMtrChg.NEW_ROAD_NM);
			Str_Cat( m_szTmp, " ");
			Str_Cat( m_szTmp, stMtrChg.NEW_ADDR_M);
			Str_Cat( m_szTmp, "-");
			Str_Cat( m_szTmp, stMtrChg.NEW_ADDR_S);
			Str_Cat( m_szTmp, " ");
			Str_Cat( m_szTmp, stMtrChg.HOUSE_CNT);
			Str_Cat( m_szTmp, " ");
			Str_Cat( m_szTmp, stMtrChg.LOT_NUM_SECOND_ADDR);
		}
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), m_szTmp);
		
		return;
	}
	
//------------------------------------------------------------------
	void ReDraw(void)	
	{
		long lCnt = 0;
		long i;
		char szfilenm[256];
	
		m_lTotCnt = FS_GetSrchTotCnt();
		SPRINT(m_szCnt_index, "%d/%d", g_nActIndex+1, m_lTotCnt, 0);
	
		//주소 표시
		AddrDraw();

		//고객번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), stMtrChg.CUST_NUM);
		
		if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "10") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "계량기");
		}
		else if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "보정기");
		}
		else if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "30") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "계+보");
		}
		
		if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "30") == 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), TRUE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), FALSE );
		}

		//철거 보정기정보
		//모델
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT COMPENS_MODEL_NM FROM COMPENS_MODEL WHERE COMPENS_MODEL_CD = '%s'  ",stMtrChg.COMPENS_MODEL_CD, 0, 0   );
		g_Sql_RetStr( m_szSql, 20, m_szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8)   , m_szTmp);
		//기물번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), stMtrChg.COMPENS_ID_NUM);
		//유효
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), stMtrChg.COMPENS_VALID_YM);

		//철거Vc지침
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), stMtrChg.REMOVE_INDI_VC);

		//철거Va지침
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), stMtrChg.REMOVE_INDI_VA);

		//철거Vm지침
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), stMtrChg.REMOVE_INDI_VM);

		//온도, 압력, 계수
//PRINT("stMtrChg.BEFO_TEMPER : %s , stMtrChg.BEFO_PRESS : %s , stMtrChg.BEFO_REVIS_PARA : %s ",stMtrChg.BEFO_TEMPER,stMtrChg.BEFO_PRESS,stMtrChg.BEFO_REVIS_PARA);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), stMtrChg.BEFO_TEMPER);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), stMtrChg.BEFO_PRESS);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), stMtrChg.BEFO_REVIS_PARA);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), stMtrChg.COMPENS_MAKER_NM);
		

		//사유 
		//노후교체의 경우 default 노후 입력.
		if( g_lDataflag == 0 && ( Str_Cmp(stMtrChg.SEND_YN, "N") == 0 || Str_Cmp(stMtrChg.SEND_YN, "") == 0 ) && Str_Cmp(stMtrChg.REPL_OCCU_FLAG, "10") == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2)   , "노후");	
		}
		else
		{	
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
			SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30011'AND CODE_ITEM = '%s'",stMtrChg.COMPENS_REPL_WHY, 0, 0   );
			g_Sql_RetStr( m_szSql, 30, m_szTmp );
			
			if( Str_Cmp(m_szTmp, "") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2)   , "노후");	
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2)   , m_szTmp);	
			}
		}

		if( Str_Cmp(stMtrChg.COMPENS_REPL_WHY, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), "유상");
			Str_Cpy(stMtrChg.COMPENS_FEE_FREE_FLAG, "Y");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), "무상");
			Str_Cpy(stMtrChg.COMPENS_FEE_FREE_FLAG, "N");
		}
		
		if( Str_Len(EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2))) < 1 )
		{
			if( Str_Cmp(stMtrChg.REPL_OCCU_FLAG, "20") == 0 )
			{
				Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30011' AND CODE_ITEM = '40'", 0, 0, 0   );
				g_Sql_RetStr( m_szSql, 30, m_szTmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2)   , m_szTmp);
				
				ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_DATA2+2));
				Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30011' AND CODE_ITEM <> '10'", CMB_DATA2+2);	
			}
			else
			{
				Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30011' AND CODE_ITEM = '10'", 0, 0, 0   );
				g_Sql_RetStr( m_szSql, 30, m_szTmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2)   , m_szTmp);
			}
		}
		
		//사진유무
		//철거보정기
		lCnt = 0;
		
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Str_Cpy(szfilenm, "C");
		Str_Cat(szfilenm, "B");
		Str_Cat(szfilenm, "M");
		Str_Cat(szfilenm, "_");
		Str_Cat(szfilenm, stMtrChg.MTR_NUM);
		Str_Cat(szfilenm, ".jjp");

		Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
		SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);

		if(FFS_Exist(m_szTmp) <= 0)
		{
			lCnt++;
		}
		
		//설치보정기
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Str_Cpy(szfilenm, "C");
		Str_Cat(szfilenm, "A");
		Str_Cat(szfilenm, "M");
		Str_Cat(szfilenm, "_");
		Str_Cat(szfilenm, stMtrChg.MTR_NUM);
		Str_Cat(szfilenm, ".jjp");

		Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
		SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);

		if(FFS_Exist(m_szTmp) <= 0)
		{
			lCnt++;
		}

		if( lCnt == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), SANDYBROWN);
		}

		
		//설치보정기 정보
		InstMtrDraw();

		if( Str_Cmp(stMtrChg.SEND_YN, "S") == 0 || Str_Cmp(stMtrChg.SEND_YN, "Y") == 0 )
		{
			if( Str_Len(stMtrChg.COMPENS_BAR) > 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SAVE), RED);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), BTNCTRLBKCOLOR);
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNCTRLBKCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), RED);
			}
		}
		else
		{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNCTRLBKCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), BTNCTRLBKCOLOR);
		}

		//불가 대상 업무 버튼 비활성화(바코드, 사진, 완료)
		//교체 업무 완료 진행 시 업무 버튼 비활성화(바코드, 사진, 완료)
		if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "30") != 0 )
		{
			if( ( Str_Cmp(stMtrChg.SEND_YN, "S") == 0 || Str_Cmp(stMtrChg.SEND_YN, "Y") == 0 ) )
			{
				if( Str_Len(stMtrChg.REPL_NOT_PERMIT_WHY) > 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE );
		
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE );
		
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE );
		
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE );
		
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), TRUE );
				}
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE );
	
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE );
	
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
	
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_IMPOSSIBLE), FALSE );
			}
		}


		ON_DRAW();
		return;
	}
	
//-----------------------------------------------------------------
//설치보정기정보
	void InstMtrDraw(void)
	{
		long i, lCnt;
	
		//모델
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT COMPENS_MODEL_NM FROM COMPENS_MODEL WHERE COMPENS_MODEL_CD = '%s'",stMtrChg.AFTER_COMPENS_MODEL_CD, 0, 0);
		g_Sql_RetStr( m_szSql, 20, m_szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9)   , m_szTmp);
		//기물번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stMtrChg.AFTER_COMPENS_ID_NUM);

		//유효
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), stMtrChg.AFTER_COMPENS_VALID_YM);

		//Vc지침
		if( Str_Len(stMtrChg.INST_INDI_VC) > 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), stMtrChg.INST_INDI_VC);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "0");
		}
		//Va지침
		if( Str_Len(stMtrChg.INST_INDI_VA) > 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), stMtrChg.INST_INDI_VA);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "0");
		}
		//Vm지침
		if( Str_Len(stMtrChg.INST_INDI_VM) > 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), stMtrChg.INST_INDI_VM);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), "0");
		}
		
		//온도, 압력, 계수
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA8), stMtrChg.TEMPER);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA9), stMtrChg.PRESS);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA10), stMtrChg.REVIS_PARA);
				
		return;
	}

//-----------------------------------------------------------------	
//화면이동시 입력했던 데이터 저장.
	void SaveInput(void)
	{		
		char szTmp[50];
		long i, lCnt;
	
		//설치보정기 모델
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		SPRINT(m_szSql, "SELECT COMPENS_MODEL_CD FROM COMPENS_MODEL WHERE COMPENS_MODEL_NM = '%s' AND MAKER_NUM = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA9)), m_szMakernum, 0   );
		g_Sql_RetStr( m_szSql, 20, stMtrChg.AFTER_COMPENS_MODEL_CD );
		//설치보정기 기물
		Str_Cpy(stMtrChg.AFTER_COMPENS_ID_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		//설치보정기 유효
		Str_Cpy(stMtrChg.AFTER_COMPENS_VALID_YM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
		//철거보정기 Vc,Va,Vm
		Str_Cpy(stMtrChg.REMOVE_INDI_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cpy(stMtrChg.REMOVE_INDI_VA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cpy(stMtrChg.REMOVE_INDI_VM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
		//설치보정기 Vc,Va,Vm
		Str_Cpy(stMtrChg.INST_INDI_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cpy(stMtrChg.INST_INDI_VA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Cpy(stMtrChg.INST_INDI_VM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));

		//설치보정기 온도,압력,계수
		Str_Cpy(stMtrChg.TEMPER, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
		Str_Cpy(stMtrChg.PRESS, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
		Str_Cpy(stMtrChg.REVIS_PARA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
		
		//보정기번호
		Str_Cpy(stMtrChg.AFTER_COMPENS_NUM, stMtrChg.COMPENS_NUM);

		//교체사유
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30011' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), 0, 0 );
		g_Sql_RetStr( m_szSql, 20, stMtrChg.COMPENS_REPL_WHY );
		
		if( Str_Cmp(stMtrChg.COMPENS_REPL_WHY, "20") == 0 )
		{
			Str_Cpy(stMtrChg.COMPENS_FEE_FREE_FLAG, "Y");
		}
		else
		{
			Str_Cpy(stMtrChg.COMPENS_FEE_FREE_FLAG, "N");
		}
	}

//----------------------------------------------------------------------------------------------
	long Save_Float(void) 
	{
		char szTmp[10];
		long lRet = 0;
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)) );
		lRet = Chk_Float(szTmp);
		if( lRet == -1 )
		{
			MessageBoxEx (CONFIRM_OK, "온도의 입력한 내용을 확인하세요.");
		}
		else if( lRet == -2 )
		{
			MessageBoxEx (CONFIRM_OK, "정수는 4자리 이상일 수 없습니다.");
		}
		else if( lRet == -3 )
		{
			MessageBoxEx (CONFIRM_OK, "소수점 자릿수는 4자리까지만 입력해주세요.");
		}
		else if( lRet == -4 )
		{
			MessageBoxEx (CONFIRM_OK, "온도의 입력 데이터 형식이 잘못되었습니다. 다시 입력해 주세요.");
		}
		else if( lRet == -5 )
		{
			MessageBoxEx (CONFIRM_OK, "온도의 입력 데이터 형식이 잘못되었습니다. 다시 입력해 주세요.");
		}
		if( lRet < 0 )
		{	
			lRet = -1;
			goto Finally;
		}
		
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)) );
		lRet = Chk_Float(szTmp);
		if( lRet == -1 )
		{
			MessageBoxEx (CONFIRM_OK, "압력의 입력한 내용을 확인하세요.");
		}
		else if( lRet == -2 )
		{
			MessageBoxEx (CONFIRM_OK, "정수는 4자리 이상일 수 없습니다.");
		}
		else if( lRet == -3 )
		{
			MessageBoxEx (CONFIRM_OK, "소수점 자릿수는 4자리까지만 입력해주세요.");
		}
		else if( lRet == -4 )
		{
			MessageBoxEx (CONFIRM_OK, "압력의 입력 데이터 형식이 잘못되었습니다. 다시 입력해 주세요.");
		}
		else if( lRet == -5 )
		{
			MessageBoxEx (CONFIRM_OK, "압력의 입력 데이터 형식이 잘못되었습니다. 다시 입력해 주세요.");
		}
		if( lRet < 0 )
		{	
			goto Finally;
		}
		
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)) );
		lRet = Chk_Float(szTmp);
		if( lRet == -1 )
		{
			MessageBoxEx (CONFIRM_OK, "보정계수의 입력한 내용을 확인하세요.");
		}
		else if( lRet == -2 )
		{
			MessageBoxEx (CONFIRM_OK, "정수는 4자리 이상일 수 없습니다.");
		}
		else if( lRet == -3 )
		{
			MessageBoxEx (CONFIRM_OK, "소수점 자릿수는 4자리까지만 입력해주세요.");
		}
		else if( lRet == -4 )
		{
			MessageBoxEx (CONFIRM_OK, "보정계수의 입력 데이터 형식이 잘못되었습니다. 다시 입력해 주세요.");
		}
		else if( lRet == -5 )
		{
			MessageBoxEx (CONFIRM_OK, "보정계수의 입력 데이터 형식이 잘못되었습니다. 다시 입력해 주세요.");
		}
		if( lRet < 0 )
		{	
			goto Finally;
		}

Finally:

		return lRet;
	}

//----------------------------------------------------------------------------------------------
	long Chk_Float( char * szfloat )
	{
		char szTmp[10];
		char szTmp2[10];
		char szTmp3[10];
		long i, len;
		long chk=0;
		long ret = -1;
	
		len = Str_Len(szfloat);
		if(len > 9)
		{	
			ret = -1;
			goto Finally;
		}
		chk=0;
		for(i=0; i<len;i++)
		{
			if(szfloat[i] == '.')
			{
				chk = i+1;
				break;
			}
		}
		
		if( chk == 0 &&  len > 4 )
		{
			ret = -2;
			goto Finally;
		}
		
		//정수부분 길이체크
		if( chk-1 > 4 )
		{
			ret = -2;
			goto Finally;
		}
		
		//소수점부분 길이체크
		if(len-(chk) > 4)
		{
			ret = -3;
			goto Finally;
		}
		
		if( chk == 0 )
			chk = len+1;
		
		Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2) );
		Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3) );
		Mem_Cpy( (byte*)szTmp2, (byte*)szfloat, chk-1 );
		Mem_Cpy( (byte*)szTmp3, (byte*)szfloat, chk-1 );
		
		Str_Chg(szTmp3, STRCHG_DEL_NONDIGIT);
		Str_ItoA(Str_AtoI(szTmp2), szTmp3, 10 );
		
		if( Str_Cmp(szTmp2, szTmp3) != 0)
		{
			ret = -4;
			goto Finally;
		}
		
		if( chk < len && len-chk > 0)
		{
			Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2) );
			Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3) );
			Mem_Cpy( (byte*)szTmp2, (byte*)szfloat+chk, len-(chk) );
			Mem_Cpy( (byte*)szTmp3, (byte*)szfloat+chk, len-(chk) );
			
			Str_Chg(szTmp3, STRCHG_DEL_NONDIGIT);
			if( Str_Cmp(szTmp2, szTmp3) != 0)
			{
				ret = -5;
				goto Finally;
			}
		}
		ret = 1;
Finally:
		return ret;
	}


//-----------------------------------------------------------------
	bool Validate(void)
	{
		char szfilenm[256];
		long lCnt = 0;
		bool bRet = TRUE;
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA9))) == 0 ||
		    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "기물번호를 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA9))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "기물번호가 잘못되었습니다.");
			bRet = FALSE;
			goto Finally;
		}
				
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "보정기 유효년월을 선택하세요.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vc 설치지침을 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Va 설치지침을 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vm 설치지침을 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vc 철거지침을 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Va 철거지침을 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vm 철거지침을 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}
				
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "보정기 교체사유를 선택하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "온도를 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "압력을 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "보정계수를 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_AtoI(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10))) > 100 )
		{
			MessageBoxEx (CONFIRM_OK, "보정계수를 다시 입력하세요.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Save_Float() < 0 )
		{
			bRet = FALSE;
			goto Finally;
		}

/*
계량기교체		C31(업무구분) | M(계량기), C(보정기) | B(철거), A(설치) | M(계량기번호) | D( 생성날짜(SYSDATE : YYYYMMDDHHMMSS )
서버 저장 예시 : C31MBM302410422D20161129111620(계량기교체 철거 사진), C31CBM302410422D20161129111620(계량기교체 설치 사진)
클라이언트 저장 파일명 예시 : MBM302410422
*/
		//철거보정기
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Str_Cpy(szfilenm, "C");
		Str_Cat(szfilenm, "B");
		Str_Cat(szfilenm, "M");
		Str_Cat(szfilenm, "_");
		Str_Cat(szfilenm, stMtrChg.MTR_NUM);
		Str_Cat(szfilenm, ".jjp");

		Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
		SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);

		if(FFS_Exist(m_szTmp) <= 0)
		{
			lCnt++;
		}
		
		//설치보정기
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Str_Cpy(szfilenm, "C");
		Str_Cat(szfilenm, "A");
		Str_Cat(szfilenm, "M");
		Str_Cat(szfilenm, "_");
		Str_Cat(szfilenm, stMtrChg.MTR_NUM);
		Str_Cat(szfilenm, ".jjp");

		Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
		SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);

		if(FFS_Exist(m_szTmp) <= 0)
		{
			lCnt++;
		}

		if( lCnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "보정기 사진을 촬영하세요.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Cmp(stMtrChg.COMPENS_MAKER_NM, "RNF") == 0 && Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "20") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "RNF 보정기는 교체 불가입니다.");
			bRet = FALSE;
			goto Finally;
		}

		//입력된 데이터 스트럭쳐 저장
		SaveInput();
		
		bRet = Save_Result();

Finally:

		return bRet;
	}


//-----------------------------------------------------------------
	bool Save_Result(void)
	{
		long lSign, lSign_Len;
		long idx;
		bool bRet = TRUE;
		char* pRst;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//서명
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		lSign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명", SIGN_OPT_NONE );
		if( lSign == SIGN_RET_CANCEL || lSign == SIGN_RET_FAIL )
		{
			bRet = FALSE;
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

		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		Str_ItoA(Time_GetDate(), stMtrChg.JOB_DTM, 10);
		//Str_ItoA(Time_GetTime(), m_szTmp, 10);
		g_Str_TimeType( m_szTmp , Time_GetTime());
		Str_Chg(stMtrChg.JOB_DTM, STRCHG_DEL_NONDIGIT);
		Str_Chg(m_szTmp, STRCHG_DEL_NONDIGIT);
		Str_Cat(stMtrChg.JOB_DTM, m_szTmp);

		Str_ItoA(Time_GetDate(), stMtrChg.VISIT_YMD, 10);
		Str_Cpy(stMtrChg.AFTER_FORM_APPRO_YN, "Y");
		Str_Cpy(stMtrChg.SEND_YN, "S");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			bRet = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, 
"UPDATE C6301_CHANGEDATA SET \
MTR_FEE_FREE_FLAG = ? , MTR_REPL_WHY = ? , MTR_BAR = ? , AFTER_MTR_ID_NUM = ? \
, AFTER_MTR_MODEL_CD = ? , AFTER_MTR_GRD = ? , AFTER_MTR_FORM = ? , AFTER_MTR_TYPE = ? \
, AFTER_MTR_REMOTE_FLAG = ? , AFTER_MTR_KIND = ? , AFTER_MTR_DIGIT_CNT = ? \
, AFTER_MTR_NEW_FIX_FLAG = ? , AFTER_FIX_FIRM_NM_CD = ? , AFTER_MTR_VALID_YM = ? \
, AFTER_FORM_APPRO_YN = ? , COMPENS_FEE_FREE_FLAG = ? , COMPENS_REPL_WHY = ? \
, COMPENS_BAR = ? , AFTER_COMPENS_NUM = ? , AFTER_COMPENS_ID_NUM = ? , AFTER_COMPENS_MODEL_CD = ? \
, AFTER_COMPENS_VALID_YM = ? , AFTER_COMPENS_PRESS = ? , REMOVE_INDI_VM = ? , REMOVE_INDI_VA = ? \
, REMOVE_INDI_VC = ? , MTR_REMOTE_FLAG = ? , REPL_NOT_PERMIT_WHY = ? , JOB_DTM = ? , JOBER_EMPID = ? \
, CUST_SIGN = ? , SEND_YN = ? , TEMPER = ? , PRESS = ? , TREAT_FLAG = '10' , REVIS_PARA = ? \
, INST_INDI_VM = ? , INST_INDI_VA = ? , INST_INDI_VC = ? , CRT_EMPID = ?, PDA_NUM = ?, UPD_EMPID = ?, VISIT_YMD = ? \
WHERE MTR_NUM = ? AND OBJ_CRT_YMD = ? "
        );
        
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.MTR_FEE_FREE_FLAG     ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.MTR_REPL_WHY          ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.MTR_BAR               ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_ID_NUM      ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_MODEL_CD    ,5  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_GRD         ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_FORM        ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_TYPE        ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_REMOTE_FLAG ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_KIND        ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_DIGIT_CNT   ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_NEW_FIX_FLAG,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_FIX_FIRM_NM_CD  ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_MTR_VALID_YM    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_FORM_APPRO_YN   ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.COMPENS_FEE_FREE_FLAG ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.COMPENS_REPL_WHY      ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.COMPENS_BAR           ,30 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_COMPENS_NUM     ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_COMPENS_ID_NUM  ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_COMPENS_MODEL_CD,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_COMPENS_VALID_YM,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.AFTER_COMPENS_PRESS   ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REMOVE_INDI_VM        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REMOVE_INDI_VA        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REMOVE_INDI_VC        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.MTR_REMOTE_FLAG       ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REPL_NOT_PERMIT_WHY   ,3  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.JOB_DTM               ,14 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id		  ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)pRst							  ,Str_Len(pRst) ,DECRYPT);	//서명
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.SEND_YN               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.TEMPER                ,13  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.PRESS                 ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REVIS_PARA            ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.INST_INDI_VM          ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.INST_INDI_VA          ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.INST_INDI_VC          ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id		  ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      	  ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id		  ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.VISIT_YMD             ,8 ,DECRYPT);

		
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.MTR_NUM		          ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.OBJ_CRT_YMD			  ,8  ,DECRYPT);
				


		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		DelSqLite(sql);
		return bRet;
	}

	
//-----------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		
		if (nEvent == UART_BARCODE)
		{
			OnBarcodeRead();
		}
		else if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				if( FFS_Exist(szfilenm)  )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h에 정의되어있음
					ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
				
					//화면 REFRESH
					ImpossibleDraw();

					ON_DRAW();
					VmSleep(100);
					FFS_Delete( szfilenm );
				}
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
		char* ptr;
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
					PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
					//원본파일 +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_GC,  m_szfilenm, 0);
	
					if( FFS_Exist(szPhotopath) )
					{
						//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h에 정의되어있음
						//ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
						//ConvertImage(JPG, szfilenm, 240, 320, g_szphoto, 60*1000);
						FFS_Copy(szPhotopath, g_szphoto);
						FFS_Delete(szPhotopath);
					}
				}

				//화면 REFRESH
				ImpossibleDraw();
			}
			else if( nData == TASK_BARCODE )
			{
				//카메라 바코드 스캔 값
				Mem_Set( (byte*)m_szBartmp, 0x00, sizeof(m_szBartmp) );
				ptr = (char*)System_GetResult((char*)&nRet);
				Str_Cpy(m_szBartmp, ptr);

				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					OnBarcodeRead();
				}
			}
		}

		ON_DRAW();
		return;
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
		long lret = 0;
		
		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBartmp, 0x00, sizeof(m_szBartmp) );
			lret = Barcode_Read( m_szBartmp );
		}

		if( lret < 0 )
		{
			//MessageBoxEx (CONFIRM_OK, "바코드 읽기 실패");
			goto Finally;
		}
		else
		{
			if( Str_Cmp(m_szBartmp, "READ_FAIL") != 0 )
			{
				Barcode_Func();
			}
		}

Finally:

		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}
		
		Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
		
		ON_DRAW();
		return;
	}
	
	
	
//----------------------------------------------------------------------------------------------
	bool Save_Impossible(void)
	{
		long idx;
		bool lRet = TRUE;
		char szfilenm[256];
		char szTmp[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "방문일자를 입력하세요.");
			lRet = FALSE;
			goto Finally;
		}
		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "불가사유를 선택하세요.");
			lRet = FALSE;
			goto Finally;
		}

//2017-07-19 Sanghyun Lee
//신기호씨 요청으로 불가사유 입력시 사진 필수체크 제거
//		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
//		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
//		Str_Cpy(szfilenm, "CNM");				
//		Str_Cat(szfilenm, "_");
//		Str_Cat(szfilenm, stMtrChg.MTR_NUM);
//		Str_Cat(szfilenm, ".jjp");
//		SPRINT (szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);
//		if( FFS_Exist(szTmp) == 0 || FFS_Exist(szTmp) < 0 )
//		{
//			MessageBoxEx (CONFIRM_OK, "불가사유 사진을 촬영하세요.");
//			lRet = FALSE;
//			goto Finally;
//		}

		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		Str_ItoA(Time_GetDate(), stMtrChg.JOB_DTM, 10);
		
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		Str_Cpy(m_szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)));
		Str_Chg(m_szTmp, STRCHG_DEL_NONDIGIT);
		Str_Cpy(stMtrChg.VISIT_YMD, m_szTmp);
		
		Str_Cpy(stMtrChg.REPL_STS, "30");
		
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30125' AND ITEM_KNAME == '%s' ",EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)), 0, 0   );
		g_Sql_RetStr( m_szSql, 20, stMtrChg.REPL_NOT_PERMIT_WHY );
		
		Str_Cpy(stMtrChg.SEND_YN, "S");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			lRet = FALSE;
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "UPDATE C6301_CHANGEDATA SET \
REPL_STS = ?, REPL_NOT_PERMIT_WHY = ?, TREAT_FLAG = '30', VISIT_YMD = ? \
, JOB_DTM = ?, JOBER_EMPID = ?, UPD_EMPID = ?, SEND_YN = ? , CRT_EMPID = ?, PDA_NUM = ? \
WHERE MTR_NUM = ? AND OBJ_CRT_YMD = ?"
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			lRet = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REPL_STS				,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REPL_NOT_PERMIT_WHY		,3	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.VISIT_YMD				,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.JOB_DTM					,14	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	 		,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	 		,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.SEND_YN					,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id		  	,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      	  	,32,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.MTR_NUM					,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.OBJ_CRT_YMD				,8	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			lRet = FALSE;
			goto Finally;
		}
		
Finally:

		DelSqLite(sql);
		return lRet;
	}
	
	
//----------------------------------------------------------------------------------------------
	bool Save_Vc(void)
	{
		long idx;
		bool lRet = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vc 설치지침을 입력하세요.");
			lRet = FALSE;
			goto Finally;
		}
		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Va 설치지침을 입력하세요.");
			lRet = FALSE;
			goto Finally;
		}
		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA13))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vm 설치지침을 입력하세요.");
			lRet = FALSE;
			goto Finally;
		}
		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA14))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vc 철거지침을 입력하세요.");
			lRet = FALSE;
			goto Finally;
		}
		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA15))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Va 철거지침을 입력하세요.");
			lRet = FALSE;
			goto Finally;
		}
		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA16))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Vm 철거지침을 입력하세요.");
			lRet = FALSE;
			goto Finally;
		}


		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			lRet = FALSE;
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "UPDATE C6301_CHANGEDATA SET \
REPL_STS = ?, REPL_NOT_PERMIT_WHY = ?, TREAT_FLAG = '30', VISIT_YMD = ? \
, JOB_DTM = ?, JOBER_EMPID = ?, UPD_EMPID = ?, SEND_YN = ? \
WHERE MTR_NUM = ? AND OBJ_CRT_YMD = ?"
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			lRet = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REPL_STS				,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.REPL_NOT_PERMIT_WHY		,3	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.VISIT_YMD				,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.JOB_DTM					,14	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	 		,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	 		,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.SEND_YN					,1	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.MTR_NUM					,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMtrChg.OBJ_CRT_YMD				,8	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			lRet = FALSE;
			goto Finally;
		}
		
Finally:

		DelSqLite(sql);
		return lRet;
	}
	
//----------------------------------------------------------------------------------------------
/*
계량기교체		C31(업무구분) | M(계량기), C(보정기) | B(철거), A(설치), N(불가) | M(계량기번호) | D( 생성날짜(SYSDATE : YYYYMMDDHHMMSS )
점검		C31(업무구분) | M(계량기번호), R(조정기번호), E(점검시행번호), S(장치형 특정번호)  | M(계량기번호) | B(연소기 번호) | N(부적합), B(개선) | 점검부분코드 | 부적합항목코드 | D( 생성날짜(SYSDATE : YYYYMMDDHHMMSS )
민원		C50( 업무구분) | M(계량기) , I(장소) | C(민원접수번호) | T (처리순번) | D( 생성날짜(SYSDATE : YYYYMMDDHHMMSS )
*/
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;

		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Str_Cpy(m_szfilenm, "CNM");				
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stMtrChg.MTR_NUM);
		Str_Cat(m_szfilenm, ".jjp");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_GC,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//원본파일
		//	Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
		//	SPRINT (g_szphoto, "%s/%s", PHOTO_GC,  m_szfilenm, 0);
			//에뮬에서 확인시...
			//Str_Cpy(szScrPht, szfilenm);
		//	ShootPhoto ( 1, 0, m_szfilenm );
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
				JSON_SetValue	(hdata	, 'C', "position_info"		, g_szSqlWhere);
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

		return;
	}

//----------------------------------------------------------------------------------------------	
//촬영한 사진 삭제
	void Delete_Photo(void)
	{
		char *pCamera;
		char szFullpath[256];
		char szfilenm[100];
		long nRet;

		if( Str_Cmp(stMtrChg.SEND_YN, "S") != 0 && Str_Cmp(stMtrChg.SEND_YN, "Y") != 0 )
		{
			//철거전 계량기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
			Str_Cpy(szfilenm, "CBM");				
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
			SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
	
			if(FFS_Exist(szFullpath) > 0)
			{
				FFS_Delete( szFullpath );
			}
			
			Sleep(50);
	
			//설치전 계량기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
			Str_Cpy(szfilenm, "CAM");				
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
			SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
	
			if(FFS_Exist(szFullpath) > 0)
			{
				FFS_Delete( szFullpath );
			}
		}
		
		return;
	}



//----------------------------------------------------------------------------------------------	
	void Barcode_Func(void)
	{
		char szTmp[100];
		char szDate[20];
		char szMonth[4];
		char szYear[10];
		char szYear2[10];
		char szModelCd[20];
		char szModelNm[50];
		char szMtrNum1[30];
		char szMtrNum2[15];
		long lDate, lBarLen, lCnt;
		long lret = 0;
		long lFlag = -1;
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		Mem_Set( (byte*)szMonth, 0x00, sizeof(szMonth) );
		Mem_Set( (byte*)szYear, 0x00, sizeof(szYear) );
		Mem_Set( (byte*)szYear2, 0x00, sizeof(szYear2) );
		Mem_Set( (byte*)szModelCd, 0x00, sizeof(szModelCd) );
		Mem_Set( (byte*)szMtrNum1, 0x00, sizeof(szMtrNum1) );
		Mem_Set( (byte*)szMtrNum2, 0x00, sizeof(szMtrNum2) );

		m_lBarLen = Str_Len(m_szBartmp);
		if( m_lBarLen < 10 || m_lBarLen > 16 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  "");
			ClearData();
			goto Finally;
		}

		Mem_Cpy((byte *)szYear, (byte *)m_szBartmp, 2);
		
		Str_ItoA(Time_GetYear(), szDate, 10);
		Str_ItoA(Time_GetMonth(), szMonth, 10);
		Str_Cat(szDate, szMonth);
		lDate = Str_AtoI(szDate) - 5;
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		Str_ItoA(lDate, szDate, 10);
		Mem_Cpy((byte *)szYear2, (byte *)szDate+2, 2);
		
		Mem_Set( (byte*)szMonth, 0x00, sizeof(szMonth) );
		Str_ItoA(Time_GetDate(), szMonth, 10);
		Mem_Cpy((byte *)szTmp, (byte *)szMonth+2, 2);
		
		
		if( Str_AtoI(szYear) < Str_AtoI(szYear2) )
		{
			MessageBoxEx (CONFIRM_OK, "보정기 기물번호 년도가 잘못 되었습니다.");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  "");
			ClearData();
			
			Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
			m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			goto Finally;
		}
		else if( Str_AtoI(szYear) > Str_AtoI(szTmp) )
		{
			MessageBoxEx (CONFIRM_OK, "보정기 기물번호 년도가 잘못 되었습니다.");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  "");
			ClearData();
			
			Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
			m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			goto Finally;
		}

		//제조사 코드
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szBartmp+2, 1);
		if( Str_NCmp(szTmp, "1", 1) < 0 || Str_NCmp(szTmp, "9", 1) > 0 )
		{
			//해당되는 값이 아닌 문자가 들어왔을경우, 오류를 내기 위한 숫자 입력
			Str_Cpy(szTmp, "99");
		}
		i = Str_AtoI(szTmp);
		switch( i ) 
		{
			case 1:
				Str_Cpy(m_szMakernum, "10022");
				break;
			case 2:
				Str_Cpy(m_szMakernum, "10003");
				break;
			case 4:
				Str_Cpy(m_szMakernum, "10015");
				break;
			case 5:
				Str_Cpy(m_szMakernum, "10023");
				break;
			case 6:
				Str_Cpy(m_szMakernum, "10021");
				break;
			case 7:
				Str_Cpy(m_szMakernum, "10018");
				break;
			case 8:
				Str_Cpy(m_szMakernum, "10025");
				break;
			case 9:
			    Str_Cpy(m_szMakernum, "10033");
				break;
			default:
				MessageBoxEx (CONFIRM_OK, "기물번호 제작사가 잘못 되었습니다.");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  "");
				ClearData();
				goto Finally;
				break;
		}

		//모델
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szBartmp+3, 1);
		
		i = Str_AtoI(szTmp);
		
		/*
		switch( i ) 
		{
			case 1:
				Str_Cpy(szModelCd, "20000048");
				break;
			case 2:
				Str_Cpy(szModelCd, "20000010");
				break;
			case 4:
				Str_Cpy(szModelCd, "20000045");
				break;
			case 5:
				Str_Cpy(szModelCd, "20000049");
				break;
			case 6:
				Str_Cpy(szModelCd, "20000043");
				break;
			case 7:
				Str_Cpy(szModelCd, "20000037");
				break;
			case 8:
				Str_Cpy(szModelCd, "20000054");
				break;
			case 9:
				Str_Cpy(szModelCd, "20000076");
				break;				
			default:
				MessageBoxEx (CONFIRM_OK, "기물번호 모델이 잘못 되었습니다.");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  "");
				ClearData();
				goto Finally;
				break;
		}
		*/
		
		if( Str_Cmp(szTmp, "1") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000048");
		}
		else if( Str_Cmp(szTmp, "2") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000010");
		}
		else if( Str_Cmp(szTmp, "4") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000045");
		}
		else if( Str_Cmp(szTmp, "5") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000049");
		}
		else if( Str_Cmp(szTmp, "6") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000043");
		}
		else if( Str_Cmp(szTmp, "7") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000037");
		}
		else if( Str_Cmp(szTmp, "8") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000054");
		}
		else if( Str_Cmp(szTmp, "9") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000076");
		}
		else if( Str_Cmp(szTmp, "A") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000091");
		}
		else if( Str_Cmp(szTmp, "B") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000090");
		}
		else if( Str_Cmp(szTmp, "C") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000092");
		}
		else if( Str_Cmp(szTmp, "D") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000093");
		}
		else if( Str_Cmp(szTmp, "E") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000094");
		}
		else if( Str_Cmp(szTmp, "F") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000099");
		}
		else if( Str_Cmp(szTmp, "G") == 0 ) 
		{
			Str_Cpy(szModelCd, "20000096");
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "기물번호 모델이 잘못 되었습니다.");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  "");
			ClearData();
			goto Finally;
		}
		
		lFlag = 0;
		
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		Mem_Set( (byte*)szModelNm, 0x00, sizeof(szModelNm) );
		SPRINT(m_szSql, "SELECT COMPENS_MODEL_NM FROM COMPENS_MODEL WHERE COMPENS_MODEL_CD = '%s' AND MAKER_NUM = '%s'",szModelCd, m_szMakernum, 0   );
		g_Sql_RetStr( m_szSql, 20, szModelNm );

		Mem_Set( (byte*)szMtrNum1, 0x00, sizeof(szMtrNum1) );
		Mem_Set( (byte*)szMtrNum2, 0x00, sizeof(szMtrNum2) );
		Mem_Cpy((byte *)szMtrNum1, (byte *)m_szBartmp, 2);
		Mem_Cpy((byte *)szMtrNum2, (byte *)m_szBartmp+4, Str_Len(m_szBartmp)-2);
		Str_Cat(szMtrNum1, szMtrNum2);

		Str_Cpy(stMtrChg.COMPENS_BAR, m_szBartmp);
		Str_Cpy(stMtrChg.AFTER_COMPENS_ID_NUM, szMtrNum1);
		Str_Cpy(stMtrChg.AFTER_COMPENS_MODEL_CD, szModelCd);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),  szModelNm);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  stMtrChg.AFTER_COMPENS_ID_NUM);

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA9))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "모델 선택에 실패하였습니다.\n바코드를 확인하세요.");
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  "");
			ClearData();
		}

Finally:
		Barcode_Exit();
		
		ON_DRAW();
		return;
	}
	
//----------------------------------------------------------------------------------------------
	void ImpossibleDraw(void)
	{
		char szfilenm[100];
		char szFullpath[256];
		
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
		Str_Cpy(szfilenm, "CNM");				
		Str_Cat(szfilenm, "_");
		Str_Cat(szfilenm, stMtrChg.MTR_NUM);
		Str_Cat(szfilenm, ".jjp");
		
		SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
		if( FFS_Exist(szFullpath) > 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPPHOTO), RED);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPPHOTO), BTNCTRLBKCOLOR);
		}
	}


//----------------------------------------------------------------------------------------------
	void Save_Cancle(long BtnId)
	{
		char szFullpath[256];
		char szfilenm[100];
		long nRet;

		if( BtnId == BID_IMPOK )
		{
			//철거전 보정기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
			Str_Cpy(szfilenm, "CBM");				
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
			SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
	
			if(FFS_Exist(szFullpath) > 0)
			{
				FFS_Delete( szFullpath );
			}
			
			Sleep(50);
	
			//설치전 보정기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
			Str_Cpy(szfilenm, "CAM");				
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
			SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
	
			if(FFS_Exist(szFullpath) > 0)
			{
				FFS_Delete( szFullpath );
			}
		}
		else
		{
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			SPRINT(m_szSql, "UPDATE C6301_CHANGEDATA SET \
MTR_FEE_FREE_FLAG = '' , MTR_REPL_WHY = '' , MTR_BAR = '' , AFTER_MTR_ID_NUM = '' \
, AFTER_MTR_MODEL_CD = '' , AFTER_MTR_GRD = '' , AFTER_MTR_FORM = '' , AFTER_MTR_TYPE = '' \
, AFTER_MTR_REMOTE_FLAG = '' , AFTER_MTR_KIND = '' , AFTER_MTR_DIGIT_CNT = '' \
, AFTER_MTR_NEW_FIX_FLAG = '' , AFTER_FIX_FIRM_NM_CD = '' , AFTER_MTR_VALID_YM = '' \
, AFTER_FORM_APPRO_YN = '' , COMPENS_FEE_FREE_FLAG = '' , COMPENS_REPL_WHY = '' \
, COMPENS_BAR = '' , AFTER_COMPENS_NUM = '' , AFTER_COMPENS_ID_NUM = '' , AFTER_COMPENS_MODEL_CD = '' \
, AFTER_COMPENS_VALID_YM = '' , AFTER_COMPENS_PRESS = '' , REMOVE_INDI_VM = '' , REMOVE_INDI_VA = '' \
, REMOVE_INDI_VC = '' , REPL_NOT_PERMIT_WHY = '' , JOB_DTM = '' , JOBER_EMPID = '' \
, CUST_SIGN = '' , SEND_YN = '' , TEMPER = '' , PRESS = '' , TREAT_FLAG = '' , REVIS_PARA = '' \
, INST_INDI_VM = '' , INST_INDI_VA = '' , INST_INDI_VC = '', CRT_EMPID = '', PDA_NUM = '', UPD_EMPID = '', VISIT_YMD = '', SEND_YN = 'N' \
WHERE MTR_NUM = '%s' " , stMtrChg.MTR_NUM, 0, 0);
			g_Sql_DirectExecute(m_szSql);
	
			//철거전 보정기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
			Str_Cpy(szfilenm, "CBM");				
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
			SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
	
			if(FFS_Exist(szFullpath) > 0)
			{
				FFS_Delete( szFullpath );
			}
			
			Sleep(50);
	
			//설치전 보정기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
			Str_Cpy(szfilenm, "CAM");				
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
			SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
	
			if(FFS_Exist(szFullpath) > 0)
			{
				FFS_Delete( szFullpath );
			}
	
			//불가입력 보정기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
			Str_Cpy(szfilenm, "CNM");				
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
			SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
	
			if(FFS_Exist(szFullpath) > 0)
			{
				FFS_Delete( szFullpath );
			}
		}
	}
	
	
//----------------------------------------------------------------------------------------------
	void Imp_Cancle(void)
	{
		char szFullpath[256];
		char szfilenm[100];
		long nRet;

		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		SPRINT(m_szSql, "UPDATE C6301_CHANGEDATA SET SEND_YN = 'N', REPL_NOT_PERMIT_WHY = '', REPL_STS = '%s' WHERE MTR_NUM = '%s' ", stMtrChg.BACK_REPL_STS, stMtrChg.MTR_NUM, 0);
		g_Sql_DirectExecute(m_szSql);

		//불가입력 계량기
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
		Str_Cpy(szfilenm, "CNM");				
		Str_Cat(szfilenm, "_");
		Str_Cat(szfilenm, stMtrChg.MTR_NUM);
		Str_Cat(szfilenm, ".jjp");
		SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);

		if(FFS_Exist(szFullpath) > 0)
		{
			FFS_Delete( szFullpath );
		}
	}

//----------------------------------------------------------------------------------------------
//바코드 잘못된 대상 찍었을 경우, 로컬 데이터 클리어
	void ClearData(void)
	{
		Mem_Set( (byte*)stMtrChg.AFTER_COMPENS_MODEL_CD, 0x00, sizeof(stMtrChg.AFTER_COMPENS_MODEL_CD) );
		Mem_Set( (byte*)stMtrChg.AFTER_COMPENS_ID_NUM, 0x00, sizeof(stMtrChg.AFTER_COMPENS_ID_NUM) );
		Mem_Set( (byte*)stMtrChg.AFTER_COMPENS_VALID_YM, 0x00, sizeof(stMtrChg.AFTER_COMPENS_VALID_YM) );
		Mem_Set( (byte*)stMtrChg.REMOVE_INDI_VC, 0x00, sizeof(stMtrChg.REMOVE_INDI_VC) );
		Mem_Set( (byte*)stMtrChg.REMOVE_INDI_VA, 0x00, sizeof(stMtrChg.REMOVE_INDI_VA) );
		Mem_Set( (byte*)stMtrChg.REMOVE_INDI_VM, 0x00, sizeof(stMtrChg.REMOVE_INDI_VM) );
		Mem_Set( (byte*)stMtrChg.INST_INDI_VC, 0x00, sizeof(stMtrChg.INST_INDI_VC) );
		Mem_Set( (byte*)stMtrChg.INST_INDI_VA, 0x00, sizeof(stMtrChg.INST_INDI_VA) );
		Mem_Set( (byte*)stMtrChg.INST_INDI_VM, 0x00, sizeof(stMtrChg.INST_INDI_VM) );
		Mem_Set( (byte*)stMtrChg.TEMPER, 0x00, sizeof(stMtrChg.TEMPER) );
		Mem_Set( (byte*)stMtrChg.PRESS, 0x00, sizeof(stMtrChg.PRESS) );
		Mem_Set( (byte*)stMtrChg.REVIS_PARA, 0x00, sizeof(stMtrChg.REVIS_PARA) );
		Mem_Set( (byte*)stMtrChg.AFTER_COMPENS_NUM, 0x00, sizeof(stMtrChg.MTR_REPL_WHY) );
		Mem_Set( (byte*)stMtrChg.COMPENS_REPL_WHY, 0x00, sizeof(stMtrChg.COMPENS_REPL_WHY) );
		Mem_Set( (byte*)stMtrChg.COMPENS_FEE_FREE_FLAG, 0x00, sizeof(stMtrChg.COMPENS_FEE_FREE_FLAG) );
	}

//----------------------------------------------------------------------------------------------
	void Photo_View(void)
	{	
		char szTmp[256];
		char szViewnm[256];
		char szViewPath[256];
	
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Str_Cpy(m_szfilenm, "CNM");				
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stMtrChg.MTR_NUM);
		
		Str_Cpy(szViewnm, m_szfilenm);
		
		//사진 보기 용 JPG 파일명
		Str_Cat(szViewnm, ".jpg");
		//사진 저장 용 JJP 파일명
		Str_Cat(m_szfilenm, ".jjp");

		//사진 저장 용 JJP 파일명
		Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
		SPRINT (m_szTmp, "%s/%s",PHOTO_GC, m_szfilenm, 0);
		//사진 보기 용 JPG 파일명
		Mem_Set((byte*)szViewPath, 0x00, sizeof(szViewPath));
		SPRINT (szViewPath, "%s/%s",PHOTO_GC, szViewnm, 0);
		
		//원본(.jjp)을 .jpg 형식으로 복사.
		FFS_Copy( m_szTmp, szViewPath );

		//PDA
		if(Str_Cmp(g_szDEVICE_NAME, "DS3") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 )
		{
			if( FFS_Exist("\\windows\\iexplore.exe" ) )
			{
				RunApp( "iexplore.exe", m_szTmp);
			}
			else if( FFS_Exist("\\windows\\iesample.exe" ) )
			{
				RunApp( "iesample.exe", m_szTmp);
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "사진조회 프로그램이 없습니다.");
			}
		}
		else
		{	
			if(FFS_Exist(szViewPath) > 0)
			{
				//WEBVIEWER 호출 시 전체 경로를 다 써줘야함.
				//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				//Str_Cpy(szTmp, "/mnt/sdcard/Smart/");
				//Str_Cat(szTmp, szViewPath);
				RunApp( "WEBVIEWER", szViewPath );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "사진이 없습니다.");
			}
		}
		return;
	}


}
