/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_CLEAR
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_WRITE1 )
		DEF_BUTTON_ID ( BID_ADDR )		//
		DEF_BUTTON_ID ( BID_CHECK )
		DEF_BUTTON_ID ( BID_SAVE )
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
		DEF_BUTTON_ID ( BID_VISITHIST )
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_BORDER )
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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	 1
	#define INIT_NPCLEAR 2
	
	//-------------------------------------------------------------------------------------------------	
	//	버튼 시간 설정
	//-------------------------------------------------------------------------------------------------
	#define	BTN_START_TIME "090000"
	#define	BTN_END_TIME   "190000"
	
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

	typedef struct _MTRINFO
	{
		char CUT_YMD[30];
		char KEEPER_YN[50];
		char INDI_CUT_VC_AFTER[50];
		char INDI_CUT_VA_AFTER[50];
		char INDI_CUT_VM_AFTER[50];
		char REVIS_FLAG[30];
		char INST_PLACE_NUM[30];
		char PROD_CONT_SEQ[20];
	}	MTRINFO;
	
	typedef struct _MTRPROD
	{
		char CIVIL_SERV_RECEIVE_NUM[30];
		char TREAT_SEQ[20];
		char PDA_DUTY_FLAG[20];
		char REQ_INFO_NUM[20];
		char USE_CONT_NUM[20];
		char CONT_STS_CD[20];
		char CONT_FLAG_CD[20];
		char INST_PLACE_NUM[20];
		char TREAT_YMD[20];
		char SMS_YN[10];
		char MTR_NUM[20];
		char PROD_CONT_SEQ[20];
		char PROD_STS_CD[20];
		char INDI_TYPE_CD[20];
		char KEEPER_YN[50];
		char ADVICE_YN[50];
		char INDI_MANAGE_STS[50];
		char INDI_VC_AFTER[50];
		char INDI_VA_AFTER[50];
		char INDI_VM_AFTER[50];
		char CUT_TYPE_CD[30];
		char CUT_WHY_CD[30];
		char CUT_CNL_WHY_CD[30];
		char CUT_CNL_FEE_YN[30];
		char CUT_CNL_FEE_EXEMPT_WHY[30];
		char GMTR_OBJ_FLAG[30];
		char CUT_JOB_FLAG[20];
		char NONPAY_MM_CNT[30];
		char NONPAY_AMT[20];
		char NONPAY_ACTIVE_DEPT[10];
		char NONPAY_MANAGE_ZONE[10];
		char NONPAY_ACTIVE_FLAG[30];
		char NONPAY_MANAGE_STS[30];
		char CUT_TREAT_YMD[20];
		char CUT_CNL_YMD[20];
		char ACTIVE_RSLT_DESC[300];
	}	MTRPROD;

	MTRINFO m_stMtrInfo;
	MTRPROD m_stMtrProd;

	long m_lChkFlag = 0;
	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void NpClearDraw(void);
	void AddrDraw(void);
	void SetStruct(void);
	long Snd_Clear(void);
	long TR81203(void);
	
	long Snd_Clear_sms(void);
	long TR84103(void);
	long Add_StopSms(handle pj);
	long Add_StopSmsHist(handle pj);

	// 메인 다이얼로그(해제활동리스트)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납 해제"),

		DLG_BUTTON(STARTX,	   STARTY+120, 300, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+600, STARTY+440, 400, 50, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK, CHKOFF),
		
		DLG_TEXT(STARTX,         STARTY+65, 400, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1 , "사용계약번호"),
		DLG_TEXT(STARTX+400,     STARTY+65, 600, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2 , ""),
		DLG_TEXT(STARTX+300,    STARTY+120, 700, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		
		DLG_TEXT(STARTX,        STARTY+220, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4 , "해제내용"),
		DLG_TEXT(STARTX+300,    STARTY+220, 700, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5 , ""),
		
		DLG_TEXT(STARTX,        STARTY+290, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6 , "기물번호"),
		DLG_TEXT(STARTX+300,    STARTY+290, 700, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7 , ""),
		DLG_TEXT(STARTX,        STARTY+340, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8 , "계기종류"),
		DLG_TEXT(STARTX+300,    STARTY+340, 700, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9 , ""),
		DLG_TEXT(STARTX,        STARTY+390, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "중지내용"),
		DLG_TEXT(STARTX+300,    STARTY+390, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX,             STARTY+440, 600, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "해제 수수료 면제"),
		
		DLG_TEXT(STARTX,        STARTY+490, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "면제사유"),
		DLG_BUTTON( STARTX+300, STARTY+490, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),
		DLG_TEXT(STARTX+300,    STARTY+490, 700, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),

		DLG_TEXT(STARTX,        STARTY+560, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "구분"),
		DLG_TEXT(STARTX+300,    STARTY+560, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "중지지침"),
		DLG_TEXT(STARTX+650,    STARTY+560, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "해제지침"),
		DLG_TEXT(STARTX,        STARTY+610, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "Vc"),
		DLG_TEXT(STARTX+300,    STARTY+610, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_EDIT(STARTX+650,	STARTY+610, 350, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 20,  ""),
		DLG_TEXT(STARTX,        STARTY+660, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "Va"),
		DLG_TEXT(STARTX+300,    STARTY+660, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_EDIT(STARTX+650,	STARTY+660, 350, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,        STARTY+710, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "Vm"),
		DLG_TEXT(STARTX+300,    STARTY+710, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_EDIT(STARTX+650,	STARTY+710, 350, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),
		
		DLG_BUTTON(STARTX,     STARTY+795, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VISITHIST, "이력"),
		DLG_BUTTON(STARTX+500, STARTY+795, 500, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "확인"),
		
		
		DLG_COMBO (STARTX+600, STARTY+390, 400, 200, 110, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),

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
	
	// PDA 다이얼로그(해제활동리스트)
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "체납 해제"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(0,	       STARTY+120, 300, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번\n주소"),
		DLG_BUTTON(STARTX+595, STARTY+440, 398, 50, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK, CHKOFF),
		DLG_BUTTON(STARTX+595, STARTY+795, 398, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "확인"),
		
		DLG_TEXT(0,              STARTY+70, 400, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1 , "사용계약번호"),
		DLG_TEXT(STARTX+395,     STARTY+70, 598, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2 , ""),
		DLG_TEXT(STARTX+295,    STARTY+120, 698, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		
		DLG_TEXT(0,             STARTY+220, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4 , "해제내용"),
		DLG_TEXT(STARTX+295,    STARTY+220, 698, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5 , ""),
		
		DLG_TEXT(0,             STARTY+290, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA6 , "기물번호"),
		DLG_TEXT(STARTX+295,    STARTY+290, 698, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7 , ""),
		DLG_TEXT(0,             STARTY+340, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA8 , "계기종류"),
		DLG_TEXT(STARTX+295,    STARTY+340, 698, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9 , ""),
		DLG_TEXT(0,             STARTY+390, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA10, "중지내용"),
		DLG_TEXT(STARTX+295,    STARTY+390, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(0,             STARTY+440, 600, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA12, "해제 수수료 면제"),
		
		DLG_TEXT(0,             STARTY+490, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA13, "면제사유"),
		DLG_BUTTON( STARTX+295, STARTY+490, 698, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),
		DLG_TEXT(STARTX+295,    STARTY+490, 698, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),

		DLG_TEXT(0,             STARTY+560, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA15, "구분"),
		DLG_TEXT(STARTX+295,    STARTY+560, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA16, "중지지침"),
		DLG_TEXT(STARTX+645,    STARTY+560, 348, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA17, "해제지침"),
		DLG_TEXT(0,             STARTY+610, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA18, "Vc"),
		DLG_TEXT(STARTX+295,    STARTY+610, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_EDIT(STARTX+645,	STARTY+610, 348, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 20,  ""),
		DLG_TEXT(0,             STARTY+660, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA20, "Va"),
		DLG_TEXT(STARTX+295,    STARTY+660, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_EDIT(STARTX+645,	STARTY+660, 348, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(0,             STARTY+710, 300, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA22, "Vm"),
		DLG_TEXT(STARTX+295,    STARTY+710, 350, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_EDIT(STARTX+645,	STARTY+710, 348, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),
		
		DLG_COMBO (STARTX+595, STARTY+390, 398, 200, 110, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),
	};		
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_NpClear[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납 해제"),

		DLG_BUTTON(STARTX+600, STARTY+340, 400, 60, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK, CHKOFF),
		DLG_BUTTON(STARTX+600, STARTY+780, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "확인"),
		
		DLG_TEXT(STARTX,         STARTY+70, 400, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1 , "> 중지내역"),
		DLG_TEXT(STARTX,        STARTY+140, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2 , "중지일자"),
		DLG_TEXT(STARTX+300,    STARTY+140, 700, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX,        STARTY+200, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4 , "키퍼도구"),
		DLG_TEXT(STARTX+300,    STARTY+200, 700, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5 , ""),
		
		DLG_TEXT(STARTX,        STARTY+270, 400, 60, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6 , "> 중지해제"),
		DLG_TEXT(STARTX,        STARTY+340, 600, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "해제 수수료 면제"),
		DLG_TEXT(STARTX,        STARTY+400, 300, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "면제사유"),
		DLG_BUTTON( STARTX+300, STARTY+400, 700, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),
		DLG_TEXT(STARTX+300,    STARTY+400, 700, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),

		DLG_TEXT(STARTX,        STARTY+480, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "구분"),
		DLG_TEXT(STARTX+300,    STARTY+480, 350, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "중지지침"),
		DLG_TEXT(STARTX+650,    STARTY+480, 350, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "해제지침"),
		DLG_TEXT(STARTX,        STARTY+540, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "Vc"),
		DLG_TEXT(STARTX+300,    STARTY+540, 350, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_EDIT(STARTX+650,	STARTY+540, 350, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 20,  ""),
		DLG_TEXT(STARTX,        STARTY+600, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "Va"),
		DLG_TEXT(STARTX+300,    STARTY+600, 350, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_EDIT(STARTX+650,	STARTY+600, 350, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,        STARTY+660, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "Vm"),
		DLG_TEXT(STARTX+300,    STARTY+660, 350, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_EDIT(STARTX+650,	STARTY+660, 350, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),

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
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_NpClear_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "체납 해제"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+600, STARTY+260, 400, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK, CHKOFF),
		DLG_BUTTON(STARTX+600, STARTY+799, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "확인"),
		
		DLG_TEXT(STARTX,         STARTY-40, 500, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1 , "> 중지내역"),
		DLG_TEXT(STARTX,         STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2 , "중지일자"),
		DLG_TEXT(STARTX+300,     STARTY+30, 700, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX,        STARTY+100, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4 , "키퍼도구"),
		DLG_TEXT(STARTX+300,    STARTY+100, 700, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5 , ""),
		
		DLG_TEXT(STARTX,        STARTY+190, 400, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6 , "> 중지해제"),
		DLG_TEXT(STARTX,        STARTY+260, 600, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "해제 수수료 면제"),
		DLG_TEXT(STARTX,        STARTY+330, 300, 150, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "면제사유"),
		DLG_EDIT(STARTX+300,	STARTY+330, 700, 150, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, 300,  ""),
		DLG_TEXT(STARTX,        STARTY+480, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "구분"),
		DLG_TEXT(STARTX+300,    STARTY+480, 350, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "중지지침"),
		DLG_TEXT(STARTX+650,    STARTY+480, 350, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "해제지침"),
		DLG_TEXT(STARTX,        STARTY+550, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "Vc"),
		DLG_TEXT(STARTX+300,    STARTY+550, 350, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_EDIT(STARTX+650,	STARTY+550, 350, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 20,  ""),
		DLG_TEXT(STARTX,        STARTY+620, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "Va"),
		DLG_TEXT(STARTX+300,    STARTY+620, 350, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_EDIT(STARTX+650,	STARTY+620, 350, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,        STARTY+690, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "Vm"),
		DLG_TEXT(STARTX+300,    STARTY+690, 350, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_EDIT(STARTX+650,	STARTY+690, 350, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),
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
		PRINT("AAAAAAAAAAAAAAAAAAAAAAAA",0,0,0);
		PRINT("g_nWorkFlag : %d",g_nWorkFlag,0,0);
		//g_nWorkFlag == 820 -> 해제활동
		if( g_nWorkFlag == 820 )
		{
			PRINT("BBBBBBBBBBBBBBBBBBBB",0,0,0);
			m_bFirst = INIT_MAIN;
			bFirst = m_bFirst;
		}
		else
		{
			PRINT("CCCCCCCCCCCCCCCCCCCC",0,0,0);
			m_bFirst = INIT_NPCLEAR;
			bFirst = m_bFirst;
		}
		
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
				ReDraw();
				break;
			case INIT_NPCLEAR:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_NpClear_P, SIZEOF(DlgRes_NpClear_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_NpClear, SIZEOF(DlgRes_NpClear));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				NpClearDraw();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_ADDR:
				if( g_nAddrFlag == 0 )
				{
					g_nAddrFlag = 1;
				}
				else if( g_nAddrFlag == 1 )
				{
					g_nAddrFlag = 0;
				}
				AddrDraw();
				ON_DRAW();
				break;
			case BID_CHECK:
				if( m_lChkFlag == 0 )
				{
					m_lChkFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK), CHKON);
				}
				else
				{
					m_lChkFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK), CHKOFF);
				}
				break;
			case BID_SAVE:
				if( g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
				{	
					Snd_Clear();
				}
				
				break;
			case BID_WRITE1:
				if( g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
				{
					g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DATA14), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA14)) );
				}
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
				if( m_bFirst == INIT_MAIN )
				{
					Card_Move("C6202_CLEARLST");
				}
				else
				{
					Card_Move("C6202_NPMANAGE");
				}
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			case BID_VISITHIST:
			    Card_Move("C6202_VISITHIST");
			    break;
		}
	}		

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		if( m_bFirst == INIT_MAIN )
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}
				
			}
			
			if( Str_Cmp(stClear.GMTR_OBJ_FLAG, "10") != 0 )
			{
				//숫자만 입력 가능
				if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex ||
				    Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
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
		else if( m_bFirst == INIT_NPCLEAR )
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}
			}
			
			if( Str_Cmp(m_stMtrInfo.REVIS_FLAG, "10") != 0 )
			{
				//숫자만 입력 가능
				if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex ||
				    Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
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
		
		ON_DRAW()
		return;
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
					if( Str_Cmp(stClear.GMTR_OBJ_FLAG, "10") == 0 )
					{
						if( X > DMS_X(STARTX+645) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+610-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+660-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
							{
								// 입력시간 체크
								if( !g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
								{
									return;
								}
								
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
					}
					else
					{
						if( X > DMS_X(STARTX+645) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+610-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+660-(g_Dlgflag*400)) ||
							X > DMS_X(STARTX+645) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+660-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+710-(g_Dlgflag*400)) ||
							X > DMS_X(STARTX+645) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+710-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+760-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
								Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
								Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
							{
								// 입력시간 체크
								if( !g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
								{
									return;
								}
								
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
					}
				}
				
				ON_DRAW();
			}
		}
		else
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( Str_Cmp(m_stMtrInfo.REVIS_FLAG, "10") == 0 )
					{
						if( X > DMS_X(STARTX+650) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+540-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+600-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
							{
								// 입력시간 체크
								if( !g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
								{
									return;
								}
								
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
					}
					else
					{
						if( X > DMS_X(STARTX+650) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+540-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+600-(g_Dlgflag*400)) ||
							X > DMS_X(STARTX+650) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+600-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+660-(g_Dlgflag*400)) ||
							X > DMS_X(STARTX+650) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+660-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+720-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
								Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
								Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
							{
								// 입력시간 체크
								if( !g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
								{
									return;
								}
								
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
					}
				}
				
				ON_DRAW();
			}
		}
	}

	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

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
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA3), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA5), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA14), TRUE, 2, EDITSEP_NONE );
			
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA1+2 ) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30107' ", CMB_DATA1+2);
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
		}
		else if( m_bFirst == INIT_NPCLEAR )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1 ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6 ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA14), TRUE, 2, EDITSEP_NONE );

			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		}

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
		
		return;
	}

//------------------------------------------------------------------	
	void AddrDraw(void)
	{
		char szTmp[400];
	
		//주소
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번\n주소");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stClear.AREA);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stClear.TOWN);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stClear.VILLAGE);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stClear.ADDR1_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stClear.ADDR1_S);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명\n주소");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stClear.NEW_ROAD_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stClear.NEW_ADDR_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stClear.NEW_ADDR_S);
		}
		
		if( ( Str_Len(stClear.CO_LIVE_NM) + Str_Len(stClear.BLD_NM) ) > 0 )
		{
			Str_Cat(szTmp, "\n");
			Str_Cat(szTmp, stClear.CO_LIVE_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stClear.BLD_NM);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stClear.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stClear.DETAIL_FLOOR);
		}
		else
		{
			Str_Cat(szTmp, "\n");
			Str_Cat(szTmp, stClear.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stClear.DETAIL_FLOOR);
		}
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3),  szTmp);

		return;
	}

//------------------------------------------------------------------
	void ReDraw(void)
	{
		char szSql[400];
		char szTmp[30];

		//사용계약번호
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), stClear.USE_CONT_NUM);
		
		//주소
		AddrDraw();
		
		//해제내용
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), stClear.RMK );
		
		//기물번호
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), stClear.MTR_ID_NUM );
		
		//계기종류
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), stClear.MTR_KIND );
		if( Str_Cmp(stClear.MTR_KIND, "다기능") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA9), RED);
		}

		//중지내용
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		g_Str_DateType( szTmp, stClear.CUT_YMD);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), szTmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30107' AND CODE_ITEM = '%s'", stClear.KEEPER_YN, 0, 0   );
		g_Sql_RetStr( szSql, 10, szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), szTmp );
		
		//면제사유
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), szCnt );
		
		//VC
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19), stClear.INDI_COMPENS_CUT_VC );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), stClear.CURRENT_VC );
		
		//VA
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), stClear.INDI_COMPENS_CUT_VA );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), stClear.CURRENT_VA );
		
		//VM
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA23), stClear.INDI_MTR_CUT );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), stClear.CURRENT_VM );
		
		
		if( Str_Cmp(stClear.PROC, "Y") == 0 && Str_Cmp(stClear.RELEASE_YN, "Y") == 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), TRUE );
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), TRUE );
			}
						
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), FALSE );

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), FALSE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), FALSE );
			}

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
		}

		if( Str_Cmp(stClear.GMTR_OBJ_FLAG, "10") == 0 )
		{
			Mem_Set( (byte*)m_stMtrProd.GMTR_OBJ_FLAG, 0x00, sizeof(m_stMtrProd.GMTR_OBJ_FLAG) );
			Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "10");
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
		}
		else
		{
			Mem_Set( (byte*)m_stMtrProd.GMTR_OBJ_FLAG, 0x00, sizeof(m_stMtrProd.GMTR_OBJ_FLAG) );
			Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "30");
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
		}

	
		ON_DRAW();
		return;
	}
	

//------------------------------------------------------------------	
	void SetStruct(void)
	{
		char szSql[300];
		char szTmp[300];
		char szNum[100];
		char szDate[30];
		char szTime[30];
	
		if( m_bFirst == INIT_MAIN )
		{
			//해제활동 -> 해제
			//m_stMtrProd
			Mem_Set((byte*)&m_stMtrProd, 0x00, sizeof(m_stMtrProd));
			Mem_Set((byte*)szNum, 0x00, sizeof(szNum));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
			
			Str_ItoA(Time_GetDate(), szTmp, 10);
			Mem_Cpy( (byte*)szDate, (byte*)szTmp+1, 7);
			//Str_ItoA(Time_GetTime(), szTime, 10);
            g_Str_TimeType( szTime , Time_GetTime());
            Str_Chg(szTime, STRCHG_DEL_NONDIGIT);

			Str_Cpy(szNum, "N");
			Str_Cat(szNum, szDate);
			Str_Cat(szNum, szTime);
			//Str_Chg(szNum, STRCHG_DEL_NONDIGIT);
			
			Str_Cpy(m_stMtrProd.CIVIL_SERV_RECEIVE_NUM, szNum);
			Str_Cpy(m_stMtrProd.TREAT_SEQ             , "1");
			Str_Cpy(m_stMtrProd.PDA_DUTY_FLAG         , "40");
			Str_Cpy(m_stMtrProd.REQ_INFO_NUM          , "");
			Str_Cpy(m_stMtrProd.USE_CONT_NUM          , stClear.USE_CONT_NUM);
			Str_Cpy(m_stMtrProd.CONT_STS_CD           , "10");
			Str_Cpy(m_stMtrProd.CONT_FLAG_CD          , "10");
			Str_Cpy(m_stMtrProd.INST_PLACE_NUM        , stClear.INST_PLACE_NUM);
			
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szDate, 10);
			Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
			Str_Cpy(m_stMtrProd.TREAT_YMD             , szDate);
			
			Str_Cpy(m_stMtrProd.SMS_YN                , stClear.RSLT_NOTICE_YN);
			Str_Cpy(m_stMtrProd.MTR_NUM               , stClear.MTR_NUM);
			Str_Cpy(m_stMtrProd.PROD_CONT_SEQ         , stClear.PROD_CONT_SEQ);
			Str_Cpy(m_stMtrProd.PROD_STS_CD           , "10");
			Str_Cpy(m_stMtrProd.INDI_TYPE_CD          , "12");
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30107' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), 0, 0);
			g_Sql_RetStr(szSql, 20, szTmp);
			Str_Cpy(m_stMtrProd.KEEPER_YN             , szTmp);
			
			Str_Cpy(m_stMtrProd.ADVICE_YN             , "");
			Str_Cpy(m_stMtrProd.INDI_MANAGE_STS       , "10");
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			}
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			
			Str_Cpy(m_stMtrProd.CUT_TYPE_CD           , "");
			Str_Cpy(m_stMtrProd.CUT_WHY_CD            , "");
			Str_Cpy(m_stMtrProd.CUT_CNL_WHY_CD        , "20");
			
			if( m_lChkFlag == 0 )
			{
				Str_Cpy(m_stMtrProd.CUT_CNL_FEE_YN        , "N");
			}
			else
			{
				Str_Cpy(m_stMtrProd.CUT_CNL_FEE_YN        , "Y");
			}
			
			SQL_ConvUcStr( m_stMtrProd.CUT_CNL_FEE_EXEMPT_WHY, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA14)) );

			if( Str_Cmp(stClear.GMTR_OBJ_FLAG, "10") == 0 )
			{
				Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "10");
			}
			else
			{
				Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "30");
			}

			Str_Cpy(m_stMtrProd.CUT_JOB_FLAG          , "20");
			Str_Cpy(m_stMtrProd.NONPAY_MM_CNT         , stClear.NONPAY_MM_CNT);
			Str_Cpy(m_stMtrProd.NONPAY_AMT            , stClear.NONPAY_AMT);
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_DEPT    , stClear.NONPAY_ACTIVE_DEPT);
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_ZONE    , stClear.NONPAY_MANAGE_ZONE);
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_FLAG    , "330");
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_STS     , "33");
			Str_Cpy(m_stMtrProd.CUT_TREAT_YMD         , "");
			Str_Cpy(m_stMtrProd.CUT_CNL_YMD           , szDate);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "지침(VC=%s, VA=%s, VM=%s),",m_stMtrProd.INDI_VC_AFTER,m_stMtrProd.INDI_VA_AFTER,m_stMtrProd.INDI_VM_AFTER);
			SPRINT(szTmp, "%s, 처리자=%s", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), stUserinfo.sznm_kor, 0);
			Str_Cat(szSql, szTmp);
			SQL_ConvUcStr( m_stMtrProd.ACTIVE_RSLT_DESC, szSql );
		}
		else if( m_bFirst == INIT_NPCLEAR )
		{
			//체납활동 -> 해제
			//m_stMtrProd
			Mem_Set((byte*)&m_stMtrProd, 0x00, sizeof(m_stMtrProd));
			Mem_Set((byte*)szNum, 0x00, sizeof(szNum));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
			
			Str_ItoA(Time_GetDate(), szTmp, 10);
			Mem_Cpy( (byte*)szDate, (byte*)szTmp+1, 7);
			//Str_ItoA(Time_GetTime(), szTime, 10);
			g_Str_TimeType( szTime , Time_GetTime());
			Str_Chg(szTime, STRCHG_DEL_NONDIGIT);

			Str_Cpy(szNum, "N");
			Str_Cat(szNum, szDate);
			Str_Cat(szNum, szTime);
			//Str_Chg(szNum, STRCHG_DEL_NONDIGIT);

			Str_Cpy(m_stMtrProd.CIVIL_SERV_RECEIVE_NUM, szNum);
			Str_Cpy(m_stMtrProd.TREAT_SEQ             , "1");
			Str_Cpy(m_stMtrProd.PDA_DUTY_FLAG         , "40");
			Str_Cpy(m_stMtrProd.REQ_INFO_NUM          , "");
			Str_Cpy(m_stMtrProd.USE_CONT_NUM          , stNoPayObj.USE_CONT_NUM);
			Str_Cpy(m_stMtrProd.CONT_STS_CD           , "10");
			Str_Cpy(m_stMtrProd.CONT_FLAG_CD          , "10");
			Str_Cpy(m_stMtrProd.INST_PLACE_NUM        , m_stMtrInfo.INST_PLACE_NUM);
			
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szDate, 10);
			Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
			Str_Cpy(m_stMtrProd.TREAT_YMD             , szDate);
			
			Str_Cpy(m_stMtrProd.SMS_YN                , stNoPayObj.RSLT_NOTICE_YN);
			Str_Cpy(m_stMtrProd.MTR_NUM               , g_szMTR_NUM);
			Str_Cpy(m_stMtrProd.PROD_CONT_SEQ         , m_stMtrInfo.PROD_CONT_SEQ);
			Str_Cpy(m_stMtrProd.PROD_STS_CD           , "10");
			Str_Cpy(m_stMtrProd.INDI_TYPE_CD          , "12");
			Str_Cpy(m_stMtrProd.KEEPER_YN             , "");
			Str_Cpy(m_stMtrProd.ADVICE_YN             , "");
			Str_Cpy(m_stMtrProd.INDI_MANAGE_STS       , "10");

			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			}
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			
			Str_Cpy(m_stMtrProd.CUT_TYPE_CD           , "");
			Str_Cpy(m_stMtrProd.CUT_WHY_CD            , "");
			Str_Cpy(m_stMtrProd.CUT_CNL_WHY_CD        , "20");
			
			if( m_lChkFlag == 0 )
			{
				Str_Cpy(m_stMtrProd.CUT_CNL_FEE_YN        , "N");
			}
			else
			{
				Str_Cpy(m_stMtrProd.CUT_CNL_FEE_YN        , "Y");
			}
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA14))) > 0 )
			{
				SQL_ConvUcStr( m_stMtrProd.CUT_CNL_FEE_EXEMPT_WHY, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA14)) );
			}
			else
			{
				Str_Cpy(m_stMtrProd.CUT_CNL_FEE_EXEMPT_WHY, "");
			}
			
			if( Str_Cmp(stClear.GMTR_OBJ_FLAG, "10") == 0 )
			{
				Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "10");
			}
			else
			{
				Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "30");
			}
			
			Str_Cpy(m_stMtrProd.CUT_JOB_FLAG          , "20");
			Str_Cpy(m_stMtrProd.NONPAY_MM_CNT         , stNoPayObj.NONPAY_MM_CNT);
			Str_Cpy(m_stMtrProd.NONPAY_AMT            , stNoPayObj.UNPAY_AMT_SUM);
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_DEPT    , stNoPayObj.NONPAY_ACTIVE_DEPT);
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_ZONE    , stNoPayObj.NONPAY_MANAGE_ZONE);
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_FLAG    , "330");
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_STS     , "33");
			Str_Cpy(m_stMtrProd.CUT_TREAT_YMD         , "");
			Str_Cpy(m_stMtrProd.CUT_CNL_YMD           , szDate);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "지침(VC=%s, VA=%s, VM=%s),",m_stMtrProd.INDI_VC_AFTER,m_stMtrProd.INDI_VA_AFTER,m_stMtrProd.INDI_VM_AFTER);
			SPRINT(szTmp, "%s, 처리자=%s", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA5)), stUserinfo.sznm_kor, 0);
			Str_Cat(szSql, szTmp);
			SQL_ConvUcStr( m_stMtrProd.ACTIVE_RSLT_DESC, szSql );
		}
	}

	
//------------------------------------------------------------------	
	long Snd_Clear(void)
	{
		char szSql[500];
		char szUrl[200];
		char szbuf[128];
		char szDate[20];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;

		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "Vc 지침을 입력해주세요.");
			return -1;
		}
		
		
		if( Str_Cmp(m_stMtrProd.GMTR_OBJ_FLAG, "10") != 0 )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "Va 지침을 입력해주세요.");
				return -1;
			}
	
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "Vm 지침을 입력해주세요.");
				return -1;
			}
		}

		if( MessageBoxEx (CONFIRM_YESNO, "해제처리 하시겠습니까?")  != MB_OK)
		{
			return -1;
		}

		//데이터 셋팅
		SetStruct();

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 81203, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		      stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num",       m_stMtrProd.CIVIL_SERV_RECEIVE_NUM);
		JSON_SetValue( g_pjcomm, 'C', "treat_seq",                    m_stMtrProd.TREAT_SEQ             );
		JSON_SetValue( g_pjcomm, 'C', "pda_duty_flag",                m_stMtrProd.PDA_DUTY_FLAG         );
		JSON_SetValue( g_pjcomm, 'C', "req_info_num",                 m_stMtrProd.REQ_INFO_NUM          );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",                 m_stMtrProd.USE_CONT_NUM          );
		JSON_SetValue( g_pjcomm, 'C', "cont_sts_cd",                  m_stMtrProd.CONT_STS_CD           );
		JSON_SetValue( g_pjcomm, 'C', "cont_flag_cd",                 m_stMtrProd.CONT_FLAG_CD          );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",               m_stMtrProd.INST_PLACE_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "treat_ymd",                    m_stMtrProd.TREAT_YMD             );
		JSON_SetValue( g_pjcomm, 'C', "sms_yn",                       m_stMtrProd.SMS_YN                );
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",                      m_stMtrProd.MTR_NUM               );
		JSON_SetValue( g_pjcomm, 'C', "prod_cont_seq",                m_stMtrProd.PROD_CONT_SEQ         );
		JSON_SetValue( g_pjcomm, 'C', "prod_sts_cd",                  m_stMtrProd.PROD_STS_CD           );
		JSON_SetValue( g_pjcomm, 'C', "indi_type_cd",                 m_stMtrProd.INDI_TYPE_CD          );
		JSON_SetValue( g_pjcomm, 'C', "keeper_yn",                    m_stMtrProd.KEEPER_YN             );
		JSON_SetValue( g_pjcomm, 'C', "advice_yn",                    m_stMtrProd.ADVICE_YN             );
		JSON_SetValue( g_pjcomm, 'C', "indi_manage_sts",              m_stMtrProd.INDI_MANAGE_STS       );
		JSON_SetValue( g_pjcomm, 'C', "indi_vc_after",                m_stMtrProd.INDI_VC_AFTER         );
		JSON_SetValue( g_pjcomm, 'C', "indi_va_after",                m_stMtrProd.INDI_VA_AFTER         );
		JSON_SetValue( g_pjcomm, 'C', "indi_vm_after",                m_stMtrProd.INDI_VM_AFTER         );
		JSON_SetValue( g_pjcomm, 'C', "cut_type_cd",                  m_stMtrProd.CUT_TYPE_CD           );
		JSON_SetValue( g_pjcomm, 'C', "cut_why_cd",                   m_stMtrProd.CUT_WHY_CD            );
		JSON_SetValue( g_pjcomm, 'C', "cut_cnl_why_cd",               m_stMtrProd.CUT_CNL_WHY_CD        );
		JSON_SetValue( g_pjcomm, 'C', "cut_cnl_fee_yn",               m_stMtrProd.CUT_CNL_FEE_YN        );
		JSON_SetValue( g_pjcomm, 'C', "cut_cnl_fee_exempt_why",       m_stMtrProd.CUT_CNL_FEE_EXEMPT_WHY);
		JSON_SetValue( g_pjcomm, 'C', "gmtr_obj_flag",                m_stMtrProd.GMTR_OBJ_FLAG         );
		JSON_SetValue( g_pjcomm, 'C', "cut_job_flag",                 m_stMtrProd.CUT_JOB_FLAG          );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_mm_cnt",                m_stMtrProd.NONPAY_MM_CNT         );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_amt",                   m_stMtrProd.NONPAY_AMT            );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_dept",           m_stMtrProd.NONPAY_ACTIVE_DEPT    );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",           m_stMtrProd.NONPAY_MANAGE_ZONE    );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_flag",           m_stMtrProd.NONPAY_ACTIVE_FLAG    );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_sts",            m_stMtrProd.NONPAY_MANAGE_STS     );
		JSON_SetValue( g_pjcomm, 'C', "cut_treat_ymd",                m_stMtrProd.CUT_TREAT_YMD         );
		JSON_SetValue( g_pjcomm, 'C', "cut_cnl_ymd",                  m_stMtrProd.CUT_CNL_YMD           );
		JSON_SetValue( g_pjcomm, 'C', "active_rslt_desc",             m_stMtrProd.ACTIVE_RSLT_DESC      );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//전송데이터 확인
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR81203; //통신완료 후에 호출 함수
		HTTP_DownloadData( szUrl, "FR81203_IN",  "FR81203" , sndbuf, szbuf );

		return 1;
	}
	
//------------------------------------------------------------------
	long TR81203(void)
	{
		char szSql[350];
	
		if(g_Chk_Json(81203) >= 0)
		{
			if( m_bFirst == INIT_MAIN )
			{
				SPRINT(szSql, "UPDATE C6202_RELEASE SET PROC = 'Y', RELEASE_YN = 'Y', STOP_YN = 'N' WHERE MTR_NUM = '%s'", stClear.MTR_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else
			{
				//g_nWorkFlag = 830 중지리스트
				if( g_nWorkFlag == 830 )
				{
					SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET VISIT_FLAG = 'Y', RELEASE_YN = 'Y', STOP_YN = 'N' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
					g_Sql_DirectExecute(szSql);
				}
				else if( g_nWorkFlag == 810 )
				{
					//개별활동 대상
					SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET VISIT_FLAG = 'Y', RELEASE_YN = 'Y', STOP_YN = 'N' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
					g_Sql_DirectExecute(szSql);
				}
				else
				{
					SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET VISIT_FLAG = 'Y', RELEASE_YN = 'Y', STOP_YN = 'N' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
					g_Sql_DirectExecute(szSql);
				}
			}
			PRINT("0000000000000000000000",0,0,0);
			if( m_bFirst == INIT_MAIN )
			{
				PRINT("11111111111111111111",0,0,0);
				Snd_Clear_sms();
			}
			else
			{
				PRINT("222222222222222222",0,0,0);
				MessageBoxEx(CONFIRM_OK, "처리가 완료 되었습니다.");
				
				Str_Cpy(stNoPayObj.VISIT_FLAG, "Y");
				Str_Cpy(stNoPayObj.RELEASE_YN, "Y");
				Str_Cpy(stNoPayObj.STOP_YN, "N");
				
				Card_Move("C6202_NPACTIVE");
			}
			
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	
//------------------------------------------------------------------
	void NpClearDraw(void)
	{
		long i;
		char szindex[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&m_stMtrInfo, 0x00, sizeof(m_stMtrInfo));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PARAM14, PARAM8, PARAM18, PARAM19, PARAM20, PARAM9, PARAM7, PARAM11 \
		FROM RCV_NONPAY_MTRINFO WHERE PARAM3 = ?");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szMTR_NUM , 13, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.CUT_YMD               , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.KEEPER_YN             , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.INDI_CUT_VC_AFTER     , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.INDI_CUT_VA_AFTER     , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.INDI_CUT_VM_AFTER     , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.REVIS_FLAG            , 10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.INST_PLACE_NUM        , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stMtrInfo.PROD_CONT_SEQ         , 10 +1, DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}
		
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), m_stMtrInfo.CUT_YMD );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), m_stMtrInfo.KEEPER_YN );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19), m_stMtrInfo.INDI_CUT_VC_AFTER );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), m_stMtrInfo.INDI_CUT_VA_AFTER );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA23), m_stMtrInfo.INDI_CUT_VM_AFTER );
		
		if( Str_Cmp(stNoPayObj.VISIT_FLAG, "Y") == 0 && Str_Cmp(stNoPayObj.RELEASE_YN, "Y") == 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), TRUE );

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), TRUE );
			}

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK), FALSE );

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE1), FALSE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), FALSE );
			}

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
		}
		
		if( Str_Cmp(m_stMtrInfo.REVIS_FLAG, "10") == 0 )
		{
			Mem_Set( (byte*)m_stMtrProd.GMTR_OBJ_FLAG, 0x00, sizeof(m_stMtrProd.GMTR_OBJ_FLAG) );
			Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "10");
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
		}
		else
		{
			Mem_Set( (byte*)m_stMtrProd.GMTR_OBJ_FLAG, 0x00, sizeof(m_stMtrProd.GMTR_OBJ_FLAG) );
			Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "30");
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
		}



Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		ON_DRAW();
		return;
	}

	/*=======================================================================================
	함수명 : Snd_Clear_sms
	기  능 : FR84103 / 해제 후 문자 보냄
	Param  : 
	Return : 
	========================================================================================*/	
	long Snd_Clear_sms(void)
	{
		char szSql[500];
		char szUrl[200];
		char szbuf[128];
		char szDate[20];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 84103, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stClear.USE_CONT_NUM );
			
		Add_StopSms(g_pjcomm);
		Add_StopSmsHist(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		g_SeverConnection();

		callBackfunc = TR84103;
		HTTP_DownloadData( szUrl, "FR84103_IN",  "FR84103" , sndbuf, szbuf );

		return 1;
	}
		
	/*=======================================================================================
	함수명 : TR84103
	기  능 : FR84103 Callback
	Param  : 
	Return : 
	========================================================================================*/	
	long TR84103(void)
	{
		char szSql[350];
	
		if(g_Chk_Json(84103) >= 0)
		{
			MessageBoxEx(CONFIRM_OK, "처리가 완료 되었습니다.");
			Card_Move("C6202_CLEARLST");
			
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Add_StopSms
	기  능 : A1AT_SMS.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_StopSms(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[3000];	
		char sztmp[100];
		char szSms[3000];
		
		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
		
		JSON_AddArrayItem(js);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp,"C232" );
		JSON_SetArrayItem(js, 'C',  "corres_flag"        , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "send_sts"  	     , "1");
		JSON_SetArrayItem(js, 'C',  "send_tel_ddd"  	 , "02");
		JSON_SetArrayItem(js, 'C',  "send_tel_exn"       , "810");
		JSON_SetArrayItem(js, 'C',  "send_tel_num"       , "8021");
		
		JSON_SetArrayItem(js, 'C',  "receiver_tel_ddd"   , "");
		JSON_SetArrayItem(js, 'C',  "receiver_tel_exn"   , "");
		JSON_SetArrayItem(js, 'C',  "receiver_tel_num"   , "");
		JSON_SetArrayItem(js, 'C',  "receiver_nm"        , "");
		JSON_SetArrayItem(js, 'C',  "sms_desc"           , "");
		
		JSON_SetArrayItem(js, 'C',  "send_plc_flag"      , "60");
		JSON_SetArrayItem(js, 'C',  "cust_num"           , "");
		JSON_SetArrayItem(js, 'C',  "use_cont_num"       , stClear.USE_CONT_NUM);
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
	함수명 : Add_StopSmsHist
	기  능 : C5BT_CIVIL_SERV_SMS_HIST.insert, C2FT_SMS_SEND.insert에 필요한 ArrayList
	Param  : pj
	Return : 
	========================================================================================*/	
	long Add_StopSmsHist(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[3000];
		char sztmp[100];
		char szSms[3000];
		
		handle js = NULL;

		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
	
		JSON_AddArrayItem(js);
		
		JSON_SetArrayItem(js, 'C',  "use_cont_num"   		, stClear.USE_CONT_NUM);    
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		SQL_ConvUcStr( sztmp, "C232" );
		JSON_SetArrayItem(js, 'C',  "corres_flag"           , sztmp);
		JSON_SetArrayItem(js, 'C',  "msg_item"              , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "cust_num"              , "");
		JSON_SetArrayItem(js, 'C',  "cust_type_cd"          , "");
		JSON_SetArrayItem(js, 'C',  "cust_nm"               , "");
		JSON_SetArrayItem(js, 'C',  "receiver_nm"           , "");
		JSON_SetArrayItem(js, 'C',  "receiver_tel_ddd"   	, "");
		JSON_SetArrayItem(js, 'C',  "receiver_tel_exn"   	, "");
		JSON_SetArrayItem(js, 'C',  "receiver_tel_num"   	, "");
		
		JSON_SetArrayItem(js, 'C',  "cp_ddd"                , "");
		JSON_SetArrayItem(js, 'C',  "cp_exn"                , "");
		JSON_SetArrayItem(js, 'C',  "cp_num"                , "");
		
		JSON_SetArrayItem(js, 'C',  "bnk_cd"                , "");
		JSON_SetArrayItem(js, 'C',  "account_num"           , "");
		JSON_SetArrayItem(js, 'C',  "depositor_nm"          , "");
		
		JSON_SetArrayItem(js, 'C',  "guide_amt"             , "");
		
		// 조치날짜
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_ItoA(Time_GetDate(), sztmp, 10);
		JSON_SetArrayItem(js, 'C',  "act_guide_ymd"         , sztmp);
		
		JSON_SetArrayItem(js, 'C',  "sms_desc"              , "");
		
		JSON_SetArrayItem(js, 'C',  "guide_job_sts"         , "30");
		JSON_SetArrayItem(js, 'C',  "nonpay_center_cd"      , stUserinfo.szcenter_cd);
		JSON_SetArrayItem(js, 'C',  "rmk"                   , "");
		JSON_SetArrayItem(js, 'C',  "civil_serv_receive_num", "");
		JSON_SetArrayItem(js, 'C',  "treat_seq"             , "");
		JSON_SetArrayItem(js, 'C',  "send_plc_flag"         , "60");
		JSON_SetArrayItem(js, 'C',  "class_cd"              , "");
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Str_ItoA( Time_GetDate(), sztmp, 10);	
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

}


