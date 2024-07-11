/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_CUSTINFO
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_USER )		//사용자 체크
		DEF_BUTTON_ID ( BID_PAYER )		//납부자 체크
		DEF_BUTTON_ID ( BID_OWNER )		//집주인 체크
		DEF_BUTTON_ID ( BID_USERWRITE ) //사용자 이름
		DEF_BUTTON_ID ( BID_PAYERWRITE )//납부자 이름
		DEF_BUTTON_ID ( BID_OWNERWRITE )//집주인 이름
		DEF_BUTTON_ID ( BID_CHANGE )	//수정
		DEF_BUTTON_ID ( BID_OK )		//확인
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
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA29 )
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
		
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
		DEF_OBJECT_ID ( EDT_DATA11 )
		DEF_OBJECT_ID ( EDT_DATA12 )
		DEF_OBJECT_ID ( EDT_DATA13 )
		DEF_OBJECT_ID ( EDT_DATA14 )
		DEF_OBJECT_ID ( EDT_DATA15 )
		DEF_OBJECT_ID ( EDT_DATA16 )
		DEF_OBJECT_ID ( EDT_DATA17 )
		DEF_OBJECT_ID ( EDT_DATA18 )
		DEF_OBJECT_ID ( EDT_DATA19 )
		DEF_OBJECT_ID ( EDT_DATA20 )
		DEF_OBJECT_ID ( EDT_DATA21 )
		DEF_OBJECT_ID ( EDT_DATA22 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	typedef struct _CUSTINFO
	{
		char USER_FLAG[3];
		char USER_CUST_RELAT_CD[3];
		char USER_CUST_NM[30];
		char USER_TEL_DDD[6];
		char USER_TEL_EXN[6];
		char USER_TEL_NUM[6];
		char USER_SOC_NUM[20];
		char USER_CP_DDD[6];
		char USER_CP_EXN[6];
		char USER_CP_NUM[6];
		char PAYER_FLAG[3];
		char PAYER_CUST_RELAT_CD[3];
		char PAYER_CUST_NM[30];
		char PAYER_TEL_DDD[6];
		char PAYER_TEL_EXN[6];
		char PAYER_TEL_NUM[6];
		char PAYER_SOC_NUM[20];
		char PAYER_CP_DDD[6];
		char PAYER_CP_EXN[6];
		char PAYER_CP_NUM[6];
		char OWNER_FLAG[3];
		char OWNER_CUST_RELAT_CD[3];
		char OWNER_CUST_NM[30];
		char OWNER_TEL_DDD[6];
		char OWNER_TEL_EXN[6];
		char OWNER_TEL_NUM[6];
		char OWNER_SOC_NUM[20];
		char OWNER_CP_DDD[6];
		char OWNER_CP_EXN[6];
		char OWNER_CP_NUM[6];
	}	CUSTINFO;
	
	CUSTINFO	m_stCustInfo;
		
	long m_lUserFlag = 0;	//0 : 선택 안함 , 1 : 선택 
	long m_lPayerFlag = 0;	//0 : 선택 안함 , 1 : 선택 
	long m_lOwnerFlag = 0;	//0 : 선택 안함 , 1 : 선택 
	long m_lEditCtrlIndex = -1;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void Save_User(void);
	void Save_Payer(void);
	void Save_Owner(void);
	long Snd_Cust(void);
	long TR82220(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객정보"),
		
		DLG_BUTTON(STARTX,	  	STARTY+119,  80, 60, 0, 0, BUTSTY_BORDER, 0, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_USER, CHKOFF),
		DLG_BUTTON(STARTX,	 	STARTY+359,  80, 60, 0, 0, BUTSTY_BORDER, 0, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PAYER, CHKOFF),
		DLG_BUTTON(STARTX,	 	STARTY+599,  80, 60, 0, 0, BUTSTY_BORDER, 0, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OWNER, CHKOFF),
		DLG_BUTTON(STARTX,	 	STARTY+839, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "수정"),
		DLG_BUTTON(STARTX+500,	STARTY+839, 500, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		DLG_TEXT(STARTX,		STARTY+65, 230, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "고객번호"),
		DLG_TEXT(STARTX+230,	STARTY+65, 770, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
			
		DLG_TEXT(STARTX+80,		STARTY+119, 190, 60, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ">사용자"),
		DLG_TEXT(STARTX,		STARTY+179, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "성명"),
		DLG_BUTTON(STARTX+230,	STARTY+179, 350, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_USERWRITE, ""),
		DLG_TEXT(STARTX+230,	STARTY+179, 350, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, ""),
		DLG_TEXT(STARTX,		STARTY+239, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "자택번호"),
		DLG_EDIT(STARTX+230,	STARTY+239, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_TEXT(STARTX+445,	STARTY+239,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "-"),
		DLG_EDIT(STARTX+495,	STARTY+239, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+710,	STARTY+239,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+750,	STARTY+239, 250, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT(STARTX,		STARTY+299, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "핸드폰"),
		DLG_EDIT(STARTX+230,	STARTY+299, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_TEXT(STARTX+445,	STARTY+299,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+495,	STARTY+299, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		DLG_TEXT(STARTX+710,	STARTY+299,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, "-"),
		DLG_EDIT(STARTX+750,	STARTY+299, 250, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 4,  ""),
                                                   
		DLG_TEXT(STARTX+80,		STARTY+359, 190, 60, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ">납부자"),
		DLG_TEXT(STARTX,		STARTY+419, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "생년월일"),
		DLG_TEXT(STARTX+230,	STARTY+419, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+530,	STARTY+419, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "성명"),
		DLG_BUTTON(STARTX+730,	STARTY+419, 270, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PAYERWRITE, ""),
		DLG_TEXT(STARTX+730,	STARTY+419, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, ""),
		DLG_TEXT(STARTX,		STARTY+479, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "자택번호"),
		DLG_EDIT(STARTX+230,	STARTY+479, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 4,  ""),
		DLG_TEXT(STARTX+445,	STARTY+479,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "-"),
		DLG_EDIT(STARTX+495,	STARTY+479, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11, 4,  ""),
		DLG_TEXT(STARTX+710,	STARTY+479,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, "-"),
		DLG_EDIT(STARTX+750,	STARTY+479, 250, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA12, 4,  ""),
		DLG_TEXT(STARTX,		STARTY+539, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "핸드폰"),
		DLG_EDIT(STARTX+230,	STARTY+539, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA13, 4,  ""),
		DLG_TEXT(STARTX+445,	STARTY+539,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, "-"),
		DLG_EDIT(STARTX+495,	STARTY+539, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA14, 4,  ""),
		DLG_TEXT(STARTX+710,	STARTY+539,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, "-"),
		DLG_EDIT(STARTX+750,	STARTY+539, 250, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA15, 4,  ""),
                                                   
		DLG_TEXT(STARTX+80,		STARTY+599, 190, 60, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ">집주인"),
		DLG_TEXT(STARTX,		STARTY+659, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "생년월일"),
		DLG_TEXT(STARTX+230,	STARTY+659, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+530,	STARTY+659, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, "성명"),
		DLG_BUTTON(STARTX+730,	STARTY+659, 270, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OWNERWRITE, ""),
		DLG_TEXT(STARTX+730,	STARTY+659, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA16, ""),
		DLG_TEXT(STARTX,		STARTY+719, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "자택번호"),
		DLG_EDIT(STARTX+230,	STARTY+719, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA17, 4,  ""),
		DLG_TEXT(STARTX+445,	STARTY+719,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, "-"),
		DLG_EDIT(STARTX+495,	STARTY+719, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA18, 4,  ""),
		DLG_TEXT(STARTX+710,	STARTY+719,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA26, "-"),
		DLG_EDIT(STARTX+750,	STARTY+719, 250, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA19, 4,  ""),
		DLG_TEXT(STARTX,		STARTY+779, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, "핸드폰"),
		DLG_EDIT(STARTX+230,	STARTY+779, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA20, 4,  ""),
		DLG_TEXT(STARTX+445,	STARTY+779,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA28, "-"),
		DLG_EDIT(STARTX+495,	STARTY+779, 215, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA21, 4,  ""),
		DLG_TEXT(STARTX+710,	STARTY+779,  50, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, "-"),
		DLG_EDIT(STARTX+750,	STARTY+779, 250, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA22, 4,  ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "고객정보"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,	  	 STARTY-40, 100, 70, 0, 0, BUTSTY_BORDER, 0, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_USER, CHKOFF),
		DLG_BUTTON(STARTX,	 	STARTY+250, 100, 70, 0, 0, BUTSTY_BORDER, 0, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PAYER, CHKOFF),
		DLG_BUTTON(STARTX,	 	STARTY+540, 100, 70, 0, 0, BUTSTY_BORDER, 0, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OWNER, CHKOFF),
		DLG_BUTTON(STARTX,	 	STARTY+829, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "수정"),
		DLG_BUTTON(STARTX+600,	STARTY+829, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),

		DLG_TEXT(STARTX+100,	 STARTY-40, 200, 70, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ">사용자"),
		DLG_TEXT(STARTX,		 STARTY+30, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "성명"),
		DLG_EDIT(STARTX+230,	 STARTY+30, 350, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 50,  ""),
//		DLG_BUTTON(STARTX+230,	STARTY+130, 350, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_USERWRITE, ""),
//		DLG_TEXT(STARTX+230,	STARTY+130, 350, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, ""),
		//DLG_TEXT(STARTX+400,	STARTY+130, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "상호"),
		//DLG_EDIT(STARTX+600,	STARTY+130, 385, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX,		STARTY+100, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "자택번호"),
		DLG_EDIT(STARTX+230,	STARTY+100, 230, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_TEXT(STARTX+460,	STARTY+100,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "-"),
		DLG_EDIT(STARTX+510,	STARTY+100, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+730,	STARTY+100,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+780,	STARTY+100, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT(STARTX,		STARTY+170, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "핸드폰"),
		DLG_EDIT(STARTX+230,	STARTY+170, 230, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_TEXT(STARTX+460,	STARTY+170,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+510,	STARTY+170, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		DLG_TEXT(STARTX+730,	STARTY+170,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, "-"),
		DLG_EDIT(STARTX+780,	STARTY+170, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 4,  ""),
                                                   
		DLG_TEXT(STARTX+100,	STARTY+250, 200, 70, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ">납부자"),
		DLG_TEXT(STARTX,		STARTY+320, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "생년월일"),
		DLG_TEXT(STARTX+230,	STARTY+320, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+530,	STARTY+320, 200, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "성명"),
		DLG_EDIT(STARTX+730,	STARTY+320, 270, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 50,  ""),
//		DLG_BUTTON(STARTX+730,	STARTY+380, 255, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PAYERWRITE, ""),
//		DLG_TEXT(STARTX+730,	STARTY+380, 255, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, ""),
		DLG_TEXT(STARTX,		STARTY+390, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "자택번호"),
		DLG_EDIT(STARTX+230,	STARTY+390, 230, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 4,  ""),
		DLG_TEXT(STARTX+460,	STARTY+390,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "-"),
		DLG_EDIT(STARTX+510,	STARTY+390, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11, 4,  ""),
		DLG_TEXT(STARTX+730,	STARTY+390,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, "-"),
		DLG_EDIT(STARTX+780,	STARTY+390, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA12, 4,  ""),
		DLG_TEXT(STARTX,		STARTY+460, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "핸드폰"),
		DLG_EDIT(STARTX+230,	STARTY+460, 230, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA13, 4,  ""),
		DLG_TEXT(STARTX+460,	STARTY+460,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, "-"),
		DLG_EDIT(STARTX+510,	STARTY+460, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA14, 4,  ""),
		DLG_TEXT(STARTX+730,	STARTY+460,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, "-"),
		DLG_EDIT(STARTX+780,	STARTY+460, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA15, 4,  ""),
                                                   
		DLG_TEXT(STARTX+100,	STARTY+540, 200, 70, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ">집주인"),
		DLG_TEXT(STARTX,		STARTY+610, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "생년월일"),
		DLG_TEXT(STARTX+230,	STARTY+610, 300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+530,	STARTY+610, 200, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, "성명"),
		DLG_EDIT(STARTX+730,	STARTY+610, 270, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA16, 50,  ""),
//		DLG_BUTTON(STARTX+730,	STARTY+610, 255, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OWNERWRITE, ""),
//		DLG_TEXT(STARTX+730,	STARTY+610, 255, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA16, ""),
		DLG_TEXT(STARTX,		STARTY+680, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "자택번호"),
		DLG_EDIT(STARTX+230,	STARTY+680, 230, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA17, 4,  ""),
		DLG_TEXT(STARTX+460,	STARTY+680,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, "-"),
		DLG_EDIT(STARTX+510,	STARTY+680, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA18, 4,  ""),
		DLG_TEXT(STARTX+730,	STARTY+680,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA26, "-"),
		DLG_EDIT(STARTX+780,	STARTY+680, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA19, 4,  ""),
		DLG_TEXT(STARTX,		STARTY+750, 230, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, "핸드폰"),
		DLG_EDIT(STARTX+230,	STARTY+750, 230, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA20, 4,  ""),
		DLG_TEXT(STARTX+460,	STARTY+750,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA28, "-"),
		DLG_EDIT(STARTX+510,	STARTY+750, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA21, 4,  ""),
		DLG_TEXT(STARTX+730,	STARTY+750,  50, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, "-"),
		DLG_EDIT(STARTX+780,	STARTY+750, 220, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA22, 4,  ""),
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
				ReDraw();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_USER:
				if( m_lUserFlag == 0 )
				{
					m_lUserFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_USER), CHKON);
				}
				else
				{
					m_lUserFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_USER), CHKOFF);
				}
				break;
			case BID_PAYER:
				if( m_lPayerFlag == 0 )
				{
					m_lPayerFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_PAYER), CHKON);
				}
				else
				{
					m_lPayerFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_PAYER), CHKOFF);
				}
				break;
			case BID_OWNER:
				if( m_lOwnerFlag == 0 )
				{
					m_lOwnerFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_OWNER), CHKON);
				}
				else
				{
					m_lOwnerFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_OWNER), CHKOFF);
				}
				break;
			case BID_USERWRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;
			case BID_PAYERWRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA9), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)) );
				break;
			case BID_OWNERWRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA16), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA16)) );
				break;

			case BID_CHANGE:
				if( m_lUserFlag == 0 && m_lPayerFlag == 0 && m_lOwnerFlag == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "수정 할 대상을 선택하세요.");
					break;
				}

				if( MessageBoxEx (CONFIRM_YESNO, "정보를 수정하시겠습니까?")  == MB_OK)
				{
					Snd_Cust();
				}
				break;
			case BID_OK:
				Card_Move("C6202_NPACTIVE");
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
				Card_Move("C6202_NPACTIVE");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		//숫자만 입력 가능
		if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA7) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA8) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA10) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA11) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA12) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA13) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA14) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA15) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA17) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA18) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA19) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA20) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA21) == m_lEditCtrlIndex ||
		    Get_iDlgCtrlByID(EDT_DATA22) == m_lEditCtrlIndex )
		{
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
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
		
		if( POINTING_UP == nAction )
		{
			m_lEditCtrlIndex = lActiveIndex;
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+230) && X < DMS_X(STARTX+445) && Y > DMS_Y(STARTY+190) && Y < DMS_Y(STARTY+250) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+495) && X < DMS_X(STARTX+710) && Y > DMS_Y(STARTY+190) && Y < DMS_Y(STARTY+250) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+750) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+190) && Y < DMS_Y(STARTY+250) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex )
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+230) && X < DMS_X(STARTX+445) && Y > DMS_Y(STARTY+250) && Y < DMS_Y(STARTY+310) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex )
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+495) && X < DMS_X(STARTX+710) && Y > DMS_Y(STARTY+250) && Y < DMS_Y(STARTY+310) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex )
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+750) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+250) && Y < DMS_Y(STARTY+310) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex )
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+230) && X < DMS_X(STARTX+445) && Y > DMS_Y(STARTY+435-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+495-(g_Dlgflag*400)) )
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
				else if( X > DMS_X(STARTX+495) && X < DMS_X(STARTX+710) && Y > DMS_Y(STARTY+435-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+495-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA11) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+750) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+435-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+495-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA12) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+230) && X < DMS_X(STARTX+445) && Y > DMS_Y(STARTY+495-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+555-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA13) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+495) && X < DMS_X(STARTX+710) && Y > DMS_Y(STARTY+495-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+555-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA14) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+750) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+495-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+555-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA15) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+230) && X < DMS_X(STARTX+445) && Y > DMS_Y(STARTY+680-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA17) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+495) && X < DMS_X(STARTX+710) && Y > DMS_Y(STARTY+680-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA18) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+750) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+680-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA19) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+230) && X < DMS_X(STARTX+445) && Y > DMS_Y(STARTY+740-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA20) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+495) && X < DMS_X(STARTX+710) && Y > DMS_Y(STARTY+740-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA21) == lActiveIndex )	
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
				else if( X > DMS_X(STARTX+750) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+740-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA22) == lActiveIndex )	
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
					g_Dlgflag = 1;
					g_MOVE_DLG(1);
				
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
			}
			
			ON_DRAW();
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
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2 ), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1 ), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9 ), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA10), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA11), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA12), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA13), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA14), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA15), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA16), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA17), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA18), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA19), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA20), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA21), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA22), EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------
	void ReDraw(void)
	{
		char szTmp[100];
		char szTmp2[100];
		char szTel_Ddd[10];
	
		//>>>>>사용자
		//성명
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1),  stNoPayObj.CUST_NM);
		
		//상호
		//EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2),  stNoPayObj.FIRM_NM);
		
		//자택번호
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.OWNHOUSE_TEL_DDD);
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3),  szTmp);
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.OWNHOUSE_TEL_EXN);
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4),  szTmp);
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.OWNHOUSE_TEL_NUM);
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5),  szTmp);
		
		//핸드폰
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.CP_DDD);
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6),  szTmp);
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.CP_EXN);
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA7),  szTmp);
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.CP_NUM);
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA8),  szTmp);
		
		//>>>>>납부자
		//생년월일 , decode(PAY_SOC_NUM,'','',substr(PAY_SOC_NUM,0,6)
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_SOC_NUM, 6);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12),  szTmp);
		
		//성명
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA9),  stNoPayObj.PAY_CUST_NM);
		
		//자택번호_DDD
		Str_Chg(stNoPayObj.PAY_TEL_NUM, STRCHG_DEL_NONDIGIT);
		Mem_Set( (byte*)szTel_Ddd, 0x00, sizeof(szTel_Ddd) );
		Mem_Cpy((byte *)szTel_Ddd, (byte *)stNoPayObj.PAY_TEL_NUM, 2);		//국번 저장
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.PAY_TEL_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM, 2);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA10),  szTmp);
		
		
		//자택번호_EXN
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.PAY_TEL_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+4, 4);
		}
		else if( Str_Len(stNoPayObj.PAY_TEL_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+3, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			if( Str_Len(stNoPayObj.PAY_TEL_NUM) == 10 )
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+2, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+2, 3);
			}
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+3, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA11),  szTmp);
		
		
		//자택번호_NUM
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Cmp(szTel_Ddd, "02") == 0  )
		{
			if( Str_Len(stNoPayObj.PAY_TEL_NUM) == 10 )
			{
				
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+6, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+5, 4);
			}
		}
		else if( Str_Len(stNoPayObj.PAY_TEL_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+7, 4);
		}
		else if( Str_Len(stNoPayObj.PAY_TEL_NUM) == 10 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+6, 4);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_TEL_NUM+8, 4);
		}
		
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA12),  szTmp);
				
		//핸드폰
		//핸드폰_DDD
		Str_Chg(stNoPayObj.PAY_CP_NUM, STRCHG_DEL_NONDIGIT);
		Mem_Set( (byte*)szTel_Ddd, 0x00, sizeof(szTel_Ddd) );
		Mem_Cpy((byte *)szTel_Ddd, (byte *)stNoPayObj.PAY_CP_NUM, 2);		//국번 저장
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.PAY_CP_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM, 2);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA13),  szTmp);
		
		
		//핸드폰_EXN
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.PAY_CP_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+4, 4);
		}
		else if( Str_Len(stNoPayObj.PAY_CP_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+3, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			if( Str_Len(stNoPayObj.PAY_CP_NUM) == 10 )
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+2, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+2, 3);
			}
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+3, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA14),  szTmp);
		
		
		//핸드폰_NUM
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Cmp(szTel_Ddd, "02") == 0  )
		{
			if( Str_Len(stNoPayObj.PAY_CP_NUM) == 10 )
			{
				
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+6, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+5, 4);
			}
		}
		else if( Str_Len(stNoPayObj.PAY_CP_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+7, 4);
		}
		else if( Str_Len(stNoPayObj.PAY_CP_NUM) == 10 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+6, 4);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.PAY_CP_NUM+8, 4);
		}
		
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA15),  szTmp);
		
		
		//>>>>>집주인
		//생년월일
		//생년월일 , decode(PAY_SOC_NUM,'','',substr(PAY_SOC_NUM,0,6)
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_SOC_NUM, 6);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22),  szTmp);
		
		//성명
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA16),  stNoPayObj.OWNER_CUST_NM);
		
		//자택번호
		//자택번호_DDD
		Str_Chg(stNoPayObj.OWNER_TEL_NUM, STRCHG_DEL_NONDIGIT);
		Mem_Set( (byte*)szTel_Ddd, 0x00, sizeof(szTel_Ddd) );
		Mem_Cpy((byte *)szTel_Ddd, (byte *)stNoPayObj.OWNER_TEL_NUM, 2);		//국번 저장
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.OWNER_TEL_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM, 2);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA17),  szTmp);
		
		
		//자택번호_EXN
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.OWNER_TEL_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+4, 4);
		}
		else if( Str_Len(stNoPayObj.OWNER_TEL_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+3, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			if( Str_Len(stNoPayObj.OWNER_TEL_NUM) == 10 )
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+2, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+2, 3);
			}
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+3, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA18),  szTmp);
		
		
		//자택번호_NUM
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Cmp(szTel_Ddd, "02") == 0  )
		{
			if( Str_Len(stNoPayObj.OWNER_TEL_NUM) == 10 )
			{
				
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+6, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+5, 4);
			}
		}
		else if( Str_Len(stNoPayObj.OWNER_TEL_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+7, 4);
		}
		else if( Str_Len(stNoPayObj.OWNER_TEL_NUM) == 10 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+6, 4);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_TEL_NUM+8, 4);
		}
		
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA19),  szTmp);

	
		//핸드폰
		//핸드폰_DDD
		Str_Chg(stNoPayObj.OWNER_CP_NUM, STRCHG_DEL_NONDIGIT);
		Mem_Set( (byte*)szTel_Ddd, 0x00, sizeof(szTel_Ddd) );
		Mem_Cpy((byte *)szTel_Ddd, (byte *)stNoPayObj.OWNER_CP_NUM, 2);		//국번 저장
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.OWNER_CP_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM, 2);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA20),  szTmp);
		
		
		//핸드폰_EXN
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Len(stNoPayObj.OWNER_CP_NUM) > 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+4, 4);
		}
		else if( Str_Len(stNoPayObj.OWNER_CP_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+3, 4);
		}
		else if( Str_Cmp(szTel_Ddd, "02") == 0 )
		{
			if( Str_Len(stNoPayObj.OWNER_CP_NUM) == 10 )
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+2, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+2, 3);
			}
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+3, 3);
		}
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA21),  szTmp);
		
		
		//핸드폰_NUM
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		if( Str_Cmp(szTel_Ddd, "02") == 0  )
		{
			if( Str_Len(stNoPayObj.OWNER_CP_NUM) == 10 )
			{
				
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+6, 4);
			}
			else
			{
				Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+5, 4);
			}
		}
		else if( Str_Len(stNoPayObj.OWNER_CP_NUM) == 11 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+7, 4);
		}
		else if( Str_Len(stNoPayObj.OWNER_CP_NUM) == 10 )
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+6, 4);
		}
		else
		{
			Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.OWNER_CP_NUM+8, 4);
		}
		
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA22),  szTmp);
		
		//고객번호
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szTmp2, 0x00, sizeof(szTmp2) );
		
		Mem_Cpy((byte *)szTmp, (byte *)stNoPayObj.CUST_NUM, 5);
		Str_Cat(szTmp, "-");
		
		Mem_Cpy((byte *)szTmp2, (byte *)stNoPayObj.CUST_NUM+5, 5);
		Str_Cat(szTmp, szTmp2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA31),  szTmp);
		
		ON_DRAW();
		return;
	}
	

//------------------------------------------------------------------
	void Save_User(void)
	{
		char szSql[650];
		long idx;
		long i;
		long lCnt;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET \
		CUST_NM = ?, OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ?, OWNHOUSE_TEL_NUM = ?, CP_DDD = ?, CP_EXN = ?, CP_NUM = ? \
		WHERE USE_CONT_NUM = '%s' "
		, stNoPayObj.USE_CONT_NUM, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>> Str_Len(szSql) : %d",Str_Len(szSql),0,0);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.CUST_NM      	        ,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.OWNHOUSE_TEL_DDD      ,5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.OWNHOUSE_TEL_EXN      ,5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.OWNHOUSE_TEL_NUM      ,5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.CP_DDD      	        ,5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.CP_EXN 				,5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.CP_NUM 				,5 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ;
	}

//------------------------------------------------------------------
	void Save_Payer(void)
	{
		char szSql[650];
		long idx;
		long i;
		long lCnt;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET \
		PAY_CUST_NM = ?, PAY_TEL_NUM = ?, PAY_CP_NUM = ? \
		WHERE USE_CONT_NUM = '%s' "
		, stNoPayObj.USE_CONT_NUM, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>> Str_Len(szSql) : %d",Str_Len(szSql),0,0);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.PAY_CUST_NM      	 ,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.PAY_TEL_NUM        ,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.PAY_CP_NUM         ,30,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ;
	}


//------------------------------------------------------------------
	void Save_Owner(void)
	{
		char szSql[650];
		long idx;
		long i;
		long lCnt;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET \
		OWNER_CUST_NM = ?, OWNER_TEL_NUM = ?, OWNER_CP_NUM = ? \
		WHERE USE_CONT_NUM = '%s' "
		, stNoPayObj.USE_CONT_NUM, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>> Str_Len(szSql) : %d",Str_Len(szSql),0,0);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.OWNER_CUST_NM      ,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.OWNER_TEL_NUM      ,5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.OWNER_CP_NUM       ,5 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		return ;
	}


//------------------------------------------------------------------
/*
	long Snd_Cust(void)
	{
		char szUrl[200];
		char szSql[500];
		char szbuf[128];
		char szUser_Custnm[30];
		char szUser_Payernm[30];
		char szUser_Ownernm[30];
		char* sndbuf;
		long ret = 0;		
		
		Mem_Set((byte*)&m_stCustInfo, 0x00, sizeof(m_stCustInfo));
		Mem_Set( (byte*)szUser_Custnm, 0x00, sizeof(szUser_Custnm) );
		Mem_Set( (byte*)szUser_Payernm, 0x00, sizeof(szUser_Payernm) );
		Mem_Set( (byte*)szUser_Ownernm, 0x00, sizeof(szUser_Ownernm) );
		
		//사용자
		if( m_lUserFlag == 1 )
		{
			Str_Cpy( m_stCustInfo.USER_FLAG, "Y");
		}
		else
		{
			Str_Cpy( m_stCustInfo.USER_FLAG, "N");
		}
		Str_Cpy( m_stCustInfo.USER_CUST_RELAT_CD, "10" );
		
		Str_Cpy( szUser_Custnm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		SQL_ConvUcStr( m_stCustInfo.USER_CUST_NM, szUser_Custnm );
		
		Str_Cpy( m_stCustInfo.USER_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
		Str_Cpy( m_stCustInfo.USER_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );
		Str_Cpy( m_stCustInfo.USER_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)) );
		Str_Cpy( m_stCustInfo.USER_SOC_NUM, "0000000" );
		Str_Cpy( m_stCustInfo.USER_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );
		Str_Cpy( m_stCustInfo.USER_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)) );
		Str_Cpy( m_stCustInfo.USER_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)) );

		//납부자
		if( m_lPayerFlag == 1 )
		{
			Str_Cpy( m_stCustInfo.PAYER_FLAG, "Y");
		}
		else
		{
			Str_Cpy( m_stCustInfo.PAYER_FLAG, "N");
		}
		Str_Cpy( m_stCustInfo.PAYER_CUST_RELAT_CD, "20" );
		
		Str_Cpy( szUser_Payernm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)) );
		SQL_ConvUcStr( m_stCustInfo.PAYER_CUST_NM, szUser_Payernm );
		
		Str_Cpy( m_stCustInfo.PAYER_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)) );
		Str_Cpy( m_stCustInfo.PAYER_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)) );
		Str_Cpy( m_stCustInfo.PAYER_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12)) );
		Str_Cpy( m_stCustInfo.PAYER_SOC_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA12)) );
		Str_Cat( m_stCustInfo.PAYER_SOC_NUM, "0000000" );
		Str_Cpy( m_stCustInfo.PAYER_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA13)) );
		Str_Cpy( m_stCustInfo.PAYER_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA14)) );
		Str_Cpy( m_stCustInfo.PAYER_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA15)) );

		//집주인
		if( m_lOwnerFlag == 1 )
		{
			Str_Cpy( m_stCustInfo.OWNER_FLAG, "Y");
		}
		else
		{
			Str_Cpy( m_stCustInfo.OWNER_FLAG, "N");
		}
		Str_Cpy( m_stCustInfo.OWNER_CUST_RELAT_CD, "30" );

		Str_Cpy( szUser_Ownernm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA16)) );
		SQL_ConvUcStr( m_stCustInfo.OWNER_CUST_NM, szUser_Ownernm );

		Str_Cpy( m_stCustInfo.OWNER_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA17)) );
		Str_Cpy( m_stCustInfo.OWNER_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA18)) );
		Str_Cpy( m_stCustInfo.OWNER_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA19)) );
		Str_Cpy( m_stCustInfo.OWNER_SOC_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)) );
		Str_Cat( m_stCustInfo.OWNER_SOC_NUM, "0000000" );
		Str_Cpy( m_stCustInfo.OWNER_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA20)) );
		Str_Cpy( m_stCustInfo.OWNER_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA21)) );
		Str_Cpy( m_stCustInfo.OWNER_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA22)) );
		
		g_SeverConnection();
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82220, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",          stNoPayObj.USE_CONT_NUM          );
		JSON_SetValue( g_pjcomm, 'C', "user_flag",             m_stCustInfo.USER_FLAG           );
		JSON_SetValue( g_pjcomm, 'C', "user_cust_relat_cd",    m_stCustInfo.USER_CUST_RELAT_CD  );
		JSON_SetValue( g_pjcomm, 'C', "user_cust_nm",          m_stCustInfo.USER_CUST_NM        );
		JSON_SetValue( g_pjcomm, 'C', "user_tel_ddd",          m_stCustInfo.USER_TEL_DDD        );
		JSON_SetValue( g_pjcomm, 'C', "user_tel_exn",          m_stCustInfo.USER_TEL_EXN        );
		JSON_SetValue( g_pjcomm, 'C', "user_tel_num",          m_stCustInfo.USER_TEL_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "user_soc_num",          m_stCustInfo.USER_SOC_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "user_cp_ddd",           m_stCustInfo.USER_CP_DDD         );
		JSON_SetValue( g_pjcomm, 'C', "user_cp_exn",           m_stCustInfo.USER_CP_EXN         );
		JSON_SetValue( g_pjcomm, 'C', "user_cp_num",           m_stCustInfo.USER_CP_NUM         );
		JSON_SetValue( g_pjcomm, 'C', "payer_flag",            m_stCustInfo.PAYER_FLAG          );
		JSON_SetValue( g_pjcomm, 'C', "payer_cust_relat_cd",   m_stCustInfo.PAYER_CUST_RELAT_CD );
		JSON_SetValue( g_pjcomm, 'C', "payer_cust_nm",         m_stCustInfo.PAYER_CUST_NM       );
		JSON_SetValue( g_pjcomm, 'C', "payer_tel_ddd",         m_stCustInfo.PAYER_TEL_DDD       );
		JSON_SetValue( g_pjcomm, 'C', "payer_tel_exn",         m_stCustInfo.PAYER_TEL_EXN       );
		JSON_SetValue( g_pjcomm, 'C', "payer_tel_num",         m_stCustInfo.PAYER_TEL_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "payer_soc_num",         m_stCustInfo.PAYER_SOC_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "payer_cp_ddd",          m_stCustInfo.PAYER_CP_DDD        );
		JSON_SetValue( g_pjcomm, 'C', "payer_cp_exn",          m_stCustInfo.PAYER_CP_EXN        );
		JSON_SetValue( g_pjcomm, 'C', "payer_cp_num",          m_stCustInfo.PAYER_CP_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "owner_flag",            m_stCustInfo.OWNER_FLAG          );
		JSON_SetValue( g_pjcomm, 'C', "owner_cust_relat_cd",   m_stCustInfo.OWNER_CUST_RELAT_CD );
		JSON_SetValue( g_pjcomm, 'C', "owner_cust_nm",         m_stCustInfo.OWNER_CUST_NM       );
		JSON_SetValue( g_pjcomm, 'C', "owner_tel_ddd",         m_stCustInfo.OWNER_TEL_DDD       );
		JSON_SetValue( g_pjcomm, 'C', "owner_tel_exn",         m_stCustInfo.OWNER_TEL_EXN       );
		JSON_SetValue( g_pjcomm, 'C', "owner_tel_num",         m_stCustInfo.OWNER_TEL_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "owner_soc_num",         m_stCustInfo.OWNER_SOC_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "owner_cp_ddd",          m_stCustInfo.OWNER_CP_DDD        );
		JSON_SetValue( g_pjcomm, 'C', "owner_cp_exn",          m_stCustInfo.OWNER_CP_EXN        );
		JSON_SetValue( g_pjcomm, 'C', "owner_cp_num",          m_stCustInfo.OWNER_CP_NUM        );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR82220; //통신완료 후에 호출 함수
		HTTP_DownloadData( szUrl, "FR82220_IN",  "FR82220" , sndbuf, szbuf );
		return 1;
	}
*/
	long Snd_Cust(void)
	{
		char szUrl[200];
		char szSql[500];
		char szbuf[128];
		char szUser_Custnm[30];
		char szUser_Payernm[30];
		char szUser_Ownernm[30];
		char* sndbuf;
		long ret = 0;		
		
		Mem_Set((byte*)&m_stCustInfo, 0x00, sizeof(m_stCustInfo));
		
		Mem_Set( (byte*)szUser_Payernm, 0x00, sizeof(szUser_Payernm) );
		Mem_Set( (byte*)szUser_Ownernm, 0x00, sizeof(szUser_Ownernm) );
		
		//사용자
		if( m_lUserFlag == 1 )
		{
			Str_Cpy( m_stCustInfo.USER_FLAG, "Y");

			Mem_Set( (byte*)stNoPayObj.CUST_NM, 0x00, sizeof(stNoPayObj.CUST_NM) );
			Mem_Set( (byte*)szUser_Custnm, 0x00, sizeof(szUser_Custnm) );
			Str_Cpy( szUser_Custnm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
			Str_Cpy(stNoPayObj.CUST_NM, szUser_Custnm);
			SQL_ConvUcStr( m_stCustInfo.USER_CUST_NM, szUser_Custnm );
			
			Mem_Set( (byte*)stNoPayObj.OWNHOUSE_TEL_DDD, 0x00, sizeof(stNoPayObj.OWNHOUSE_TEL_DDD) );
			Mem_Set( (byte*)stNoPayObj.OWNHOUSE_TEL_EXN, 0x00, sizeof(stNoPayObj.OWNHOUSE_TEL_EXN) );
			Mem_Set( (byte*)stNoPayObj.OWNHOUSE_TEL_NUM, 0x00, sizeof(stNoPayObj.OWNHOUSE_TEL_NUM) );
			Str_Cpy( stNoPayObj.OWNHOUSE_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
			Str_Cpy( stNoPayObj.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );
			Str_Cpy( stNoPayObj.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)) );
			Str_Chg(stNoPayObj.OWNHOUSE_TEL_DDD, STRCHG_DEL_NONDIGIT);
			Str_Chg(stNoPayObj.OWNHOUSE_TEL_EXN, STRCHG_DEL_NONDIGIT);
			Str_Chg(stNoPayObj.OWNHOUSE_TEL_NUM, STRCHG_DEL_NONDIGIT);
	
			Str_Cpy( m_stCustInfo.USER_SOC_NUM, "0000000" );
	
			Mem_Set( (byte*)stNoPayObj.CP_DDD, 0x00, sizeof(stNoPayObj.CP_DDD) );
			Mem_Set( (byte*)stNoPayObj.CP_EXN, 0x00, sizeof(stNoPayObj.CP_EXN) );
			Mem_Set( (byte*)stNoPayObj.CP_NUM, 0x00, sizeof(stNoPayObj.CP_NUM) );
			Str_Cpy( stNoPayObj.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );
			Str_Cpy( stNoPayObj.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)) );
			Str_Cpy( stNoPayObj.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)) );
			Str_Chg(stNoPayObj.CP_DDD, STRCHG_DEL_NONDIGIT);
			Str_Chg(stNoPayObj.CP_EXN, STRCHG_DEL_NONDIGIT);
			Str_Chg(stNoPayObj.CP_NUM, STRCHG_DEL_NONDIGIT);
		}
		else
		{
			Str_Cpy( m_stCustInfo.USER_FLAG, "N");
		}
		Str_Cpy( m_stCustInfo.USER_CUST_RELAT_CD, "10" );
		

		//납부자
		if( m_lPayerFlag == 1 )
		{
			Str_Cpy( m_stCustInfo.PAYER_FLAG, "Y");

			Mem_Set( (byte*)stNoPayObj.PAY_CUST_NM, 0x00, sizeof(stNoPayObj.PAY_CUST_NM) );
			Str_Cpy( stNoPayObj.PAY_CUST_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)) );
			SQL_ConvUcStr( m_stCustInfo.PAYER_CUST_NM, stNoPayObj.PAY_CUST_NM );
			
			Str_Cpy( m_stCustInfo.PAYER_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)) );
			Str_Cpy( m_stCustInfo.PAYER_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)) );
			Str_Cpy( m_stCustInfo.PAYER_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12)) );
			Mem_Set( (byte*)stNoPayObj.PAY_TEL_NUM, 0x00, sizeof(stNoPayObj.PAY_TEL_NUM) );
			Str_Cpy(stNoPayObj.PAY_TEL_NUM, m_stCustInfo.PAYER_TEL_DDD);
			Str_Cat(stNoPayObj.PAY_TEL_NUM, m_stCustInfo.PAYER_TEL_EXN);
			Str_Cat(stNoPayObj.PAY_TEL_NUM, m_stCustInfo.PAYER_TEL_NUM);
			Str_Chg(stNoPayObj.PAY_TEL_NUM, STRCHG_DEL_NONDIGIT);
			
			Str_Cpy( m_stCustInfo.PAYER_SOC_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA12)) );
			Str_Cat( m_stCustInfo.PAYER_SOC_NUM, "0000000" );
			
			Str_Cpy( m_stCustInfo.PAYER_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA13)) );
			Str_Cpy( m_stCustInfo.PAYER_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA14)) );
			Str_Cpy( m_stCustInfo.PAYER_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA15)) );
			Mem_Set( (byte*)stNoPayObj.PAY_CP_NUM, 0x00, sizeof(stNoPayObj.PAY_CP_NUM) );
			Str_Cpy(stNoPayObj.PAY_CP_NUM, m_stCustInfo.PAYER_CP_DDD);
			Str_Cat(stNoPayObj.PAY_CP_NUM, m_stCustInfo.PAYER_CP_EXN);
			Str_Cat(stNoPayObj.PAY_CP_NUM, m_stCustInfo.PAYER_CP_NUM);
			Str_Chg(stNoPayObj.PAY_CP_NUM, STRCHG_DEL_NONDIGIT);
		}
		else
		{
			Str_Cpy( m_stCustInfo.PAYER_FLAG, "N");
		}
		Str_Cpy( m_stCustInfo.PAYER_CUST_RELAT_CD, "20" );
		
		//집주인
		if( m_lOwnerFlag == 1 )
		{
			Str_Cpy( m_stCustInfo.OWNER_FLAG, "Y");

			Mem_Set( (byte*)stNoPayObj.OWNER_CUST_NM, 0x00, sizeof(stNoPayObj.OWNER_CUST_NM) );
			Str_Cpy( stNoPayObj.OWNER_CUST_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA16)) );
			SQL_ConvUcStr( m_stCustInfo.OWNER_CUST_NM, stNoPayObj.OWNER_CUST_NM );
	
			Str_Cpy( m_stCustInfo.OWNER_TEL_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA17)) );
			Str_Cpy( m_stCustInfo.OWNER_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA18)) );
			Str_Cpy( m_stCustInfo.OWNER_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA19)) );
			Mem_Set( (byte*)stNoPayObj.OWNER_TEL_NUM, 0x00, sizeof(stNoPayObj.OWNER_TEL_NUM) );
			Str_Cpy(stNoPayObj.OWNER_TEL_NUM, m_stCustInfo.OWNER_TEL_DDD);
			Str_Cat(stNoPayObj.OWNER_TEL_NUM, m_stCustInfo.OWNER_TEL_EXN);
			Str_Cat(stNoPayObj.OWNER_TEL_NUM, m_stCustInfo.OWNER_TEL_NUM);
			Str_Chg(stNoPayObj.OWNER_TEL_NUM, STRCHG_DEL_NONDIGIT);
			
			Str_Cpy( m_stCustInfo.OWNER_SOC_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)) );
			Str_Cat( m_stCustInfo.OWNER_SOC_NUM, "0000000" );
			
			Str_Cpy( m_stCustInfo.OWNER_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA20)) );
			Str_Cpy( m_stCustInfo.OWNER_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA21)) );
			Str_Cpy( m_stCustInfo.OWNER_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA22)) );
			Mem_Set( (byte*)stNoPayObj.OWNER_CP_NUM, 0x00, sizeof(stNoPayObj.OWNER_CP_NUM) );
			Str_Cpy(stNoPayObj.OWNER_CP_NUM, m_stCustInfo.OWNER_CP_DDD);
			Str_Cat(stNoPayObj.OWNER_CP_NUM, m_stCustInfo.OWNER_CP_EXN);
			Str_Cat(stNoPayObj.OWNER_CP_NUM, m_stCustInfo.OWNER_CP_NUM);
			Str_Chg(stNoPayObj.OWNER_CP_NUM, STRCHG_DEL_NONDIGIT);
		}
		else
		{
			Str_Cpy( m_stCustInfo.OWNER_FLAG, "N");
		}
		Str_Cpy( m_stCustInfo.OWNER_CUST_RELAT_CD, "30" );

		g_SeverConnection();
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82220, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",          stNoPayObj.USE_CONT_NUM          );
		JSON_SetValue( g_pjcomm, 'C', "user_flag",             m_stCustInfo.USER_FLAG           );
		JSON_SetValue( g_pjcomm, 'C', "user_cust_relat_cd",    m_stCustInfo.USER_CUST_RELAT_CD  );
		JSON_SetValue( g_pjcomm, 'C', "user_cust_nm",          m_stCustInfo.USER_CUST_NM        );
		JSON_SetValue( g_pjcomm, 'C', "user_tel_ddd",          stNoPayObj.OWNHOUSE_TEL_DDD      );
		JSON_SetValue( g_pjcomm, 'C', "user_tel_exn",          stNoPayObj.OWNHOUSE_TEL_EXN      );
		JSON_SetValue( g_pjcomm, 'C', "user_tel_num",          stNoPayObj.OWNHOUSE_TEL_NUM      );
		JSON_SetValue( g_pjcomm, 'C', "user_soc_num",          m_stCustInfo.USER_SOC_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "user_cp_ddd",           stNoPayObj.CP_DDD                );
		JSON_SetValue( g_pjcomm, 'C', "user_cp_exn",           stNoPayObj.CP_EXN                );
		JSON_SetValue( g_pjcomm, 'C', "user_cp_num",           stNoPayObj.CP_NUM                );
		JSON_SetValue( g_pjcomm, 'C', "payer_flag",            m_stCustInfo.PAYER_FLAG          );
		JSON_SetValue( g_pjcomm, 'C', "payer_cust_relat_cd",   m_stCustInfo.PAYER_CUST_RELAT_CD );
		JSON_SetValue( g_pjcomm, 'C', "payer_cust_nm",         m_stCustInfo.PAYER_CUST_NM       );
		JSON_SetValue( g_pjcomm, 'C', "payer_tel_ddd",         m_stCustInfo.PAYER_TEL_DDD       );
		JSON_SetValue( g_pjcomm, 'C', "payer_tel_exn",         m_stCustInfo.PAYER_TEL_EXN       );
		JSON_SetValue( g_pjcomm, 'C', "payer_tel_num",         m_stCustInfo.PAYER_TEL_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "payer_soc_num",         m_stCustInfo.PAYER_SOC_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "payer_cp_ddd",          m_stCustInfo.PAYER_CP_DDD        );
		JSON_SetValue( g_pjcomm, 'C', "payer_cp_exn",          m_stCustInfo.PAYER_CP_EXN        );
		JSON_SetValue( g_pjcomm, 'C', "payer_cp_num",          m_stCustInfo.PAYER_CP_NUM        );
		JSON_SetValue( g_pjcomm, 'C', "owner_flag",            m_stCustInfo.OWNER_FLAG          );
		JSON_SetValue( g_pjcomm, 'C', "owner_cust_relat_cd",   m_stCustInfo.OWNER_CUST_RELAT_CD );
		JSON_SetValue( g_pjcomm, 'C', "owner_cust_nm",         m_stCustInfo.OWNER_CUST_NM       );
		JSON_SetValue( g_pjcomm, 'C', "owner_tel_ddd",         m_stCustInfo.OWNER_TEL_DDD       );
		JSON_SetValue( g_pjcomm, 'C', "owner_tel_exn",         m_stCustInfo.OWNER_TEL_EXN       );
		JSON_SetValue( g_pjcomm, 'C', "owner_tel_num",         m_stCustInfo.OWNER_TEL_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "owner_soc_num",         m_stCustInfo.OWNER_SOC_NUM       );
		JSON_SetValue( g_pjcomm, 'C', "owner_cp_ddd",          m_stCustInfo.OWNER_CP_DDD        );
		JSON_SetValue( g_pjcomm, 'C', "owner_cp_exn",          m_stCustInfo.OWNER_CP_EXN        );
		JSON_SetValue( g_pjcomm, 'C', "owner_cp_num",          m_stCustInfo.OWNER_CP_NUM        );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR82220; //통신완료 후에 호출 함수
		HTTP_DownloadData( szUrl, "FR82220_IN",  "FR82220" , sndbuf, szbuf );
		return 1;
	}

	
//------------------------------------------------------------------
	long TR82220(void)
	{
	//m_lUserFlag

		if(g_Chk_Json(82220) >= 0)
		{
			if( m_lUserFlag == 1 )
			{
				Save_User();
			}
			
			if( m_lPayerFlag == 1 )
			{
				Save_Payer();
			}
			
			if( m_lOwnerFlag == 1 )
			{
				Save_Owner();
			}

			MessageBoxEx (CONFIRM_OK, "저장되었습니다.");
			ON_DRAW();
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
}


