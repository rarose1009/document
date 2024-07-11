/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6202_NPSTOP
	Card Desc : 체납 중지
	Card Hist :
----------------------------------------------------------------------------------*/
card C6202_NPSTOP
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
	#define USE_ON_UART
	#define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_STOP )
		//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
		DEF_BUTTON_ID ( BID_PHOTO )     //사진
		DEF_BUTTON_ID ( BID_SMS_STOP )  //문자
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
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
				
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )

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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2 + 3 )
	END_OBJECT_ID()
	
	//---------------------------------------------------------------
	// 상단 버튼
	//---------------------------------------------------------------		
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
	
	//---------------------------------------------------------------
	// struck 계량기상품
	//---------------------------------------------------------------
	typedef struct _MTRPROD
	{
		char CIVIL_SERV_RECEIVE_NUM[30];
		char TREAT_SEQ[10];
		char PDA_DUTY_FLAG[30];
		char REQ_INFO_NUM[20];
		char USE_CONT_NUM[20];
		char CONT_STS_CD[30];
		char CONT_FLAG_CD[30];
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
		char CUT_TYPE_CD[50];
		char CUT_WHY_CD[50];
		char CUT_CNL_WHY_CD[50];
		char CUT_CNL_FEE_YN[50];
		char CUT_CNL_FEE_EXEMPT_WHY[50];
		char GMTR_OBJ_FLAG[20];
		char CUT_JOB_FLAG[30];
		char NONPAY_MM_CNT[20];
		char NONPAY_AMT[30];
		char NONPAY_ACTIVE_DEPT[10];
		char NONPAY_MANAGE_ZONE[10];
		char NONPAY_ACTIVE_FLAG[10];
		char NONPAY_MANAGE_STS[50];
		char CUT_TREAT_YMD[20];
		char CUT_CNL_YMD[20];
		char ACTIVE_RSLT_DESC[300];
	} MTRPROD ;
	MTRPROD m_stMtrProd;
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN	1
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	long m_lActiveIndex = -1;
	long m_lChkFlag = 0;
	long m_lWorkFlag = 0; //m_lWorkFlag = 1 체납활동 중지업무, = 2 해제활동 중지업무
	char m_szRevisFlag[20];
	char m_szfilenm[256];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetBtnImg(void); 
	void SetStyle(void);
	void SetCombo(void);
	void SetStruct(void);
	void Shoto_Photo(void);
	long Snd_Stop(void);
	long TR81203(void);	//TR82214 -> TR81203 으로 통합
	void SetData(void);
	void ReDraw(void);
	long Status_BID_SMS_STOP(void);
	bool Snd_Stop_Validation(void);
	
	//---------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납중지"),
		
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_TEXT(STARTX,       STARTY- 29, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA7, "기물번호"),
		DLG_TEXT(STARTX+400,   STARTY- 29, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR,    TXTINCTRLBK, TXT_DATA8, ""),
		
		DLG_TEXT(STARTX,       STARTY+ 41, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA9, "체납액"),
		DLG_TEXT(STARTX+400,   STARTY+ 41, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR,    TXTINCTRLBK, TXT_DATA10, ""),
		
		DLG_TEXT(STARTX,       STARTY+111, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA11, "상태"),
		DLG_TEXT(STARTX+400,   STARTY+111, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR,    TXTINCTRLBK, TXT_DATA12, ""),
		
		DLG_TEXT(STARTX,       STARTY+221, 400,  70,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "안내장부착"),
		DLG_COMBO(STARTX+400,  STARTY+221, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
		
		DLG_TEXT(STARTX,       STARTY+291, 400,  70,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "키퍼도구"),
		DLG_COMBO(STARTX+400,  STARTY+291, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),
		
		DLG_TEXT(STARTX,       STARTY+361, 200, 210,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "지침"),
		DLG_TEXT(STARTX+200,   STARTY+361, 200,  70,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "Vc"),
		DLG_EDIT(STARTX+400,   STARTY+361, 600,  70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR,    EDTCTRLBK, EDT_DATA1, 20,  ""),
		DLG_TEXT(STARTX+200,   STARTY+431, 200,  70,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "Va"),
		DLG_EDIT(STARTX+400,   STARTY+431, 600,  70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR,    EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX+200,   STARTY+501, 200,  70,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "Vm"),
		DLG_EDIT(STARTX+400,   STARTY+501, 600,  70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR,    EDTCTRLBK, EDT_DATA3, 20,  ""),
		
		DLG_BUTTON(STARTX,       STARTY+621, 330, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "사진"),	
		DLG_BUTTON(STARTX+330,   STARTY+621, 330, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS_STOP, "문자"),
		DLG_BUTTON(STARTX+660,   STARTY+621, 340, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "확인"),
		
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
	
	//---------------------------------------------------------------
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납중지"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX+600,   STARTY+400, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "확인"),

		DLG_TEXT(STARTX,        STARTY-40, 200,240, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "지침"),
		DLG_TEXT(STARTX+200,    STARTY-40, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "Vc"),
		DLG_EDIT(STARTX+400,    STARTY-40, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 20,  ""),
		DLG_TEXT(STARTX+200,    STARTY+40, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "Va"),
		DLG_EDIT(STARTX+400,    STARTY+40, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT(STARTX+200,   STARTY+120, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "Vm"),
		DLG_EDIT(STARTX+400,   STARTY+120, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 20,  ""),
		DLG_TEXT(STARTX,       STARTY+200, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "안내장부착"),
		DLG_TEXT(STARTX,       STARTY+280, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "키퍼도구"),
		
		DLG_COMBO(STARTX+400,  STARTY+200, 600, 290, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
		DLG_COMBO(STARTX+400,  STARTY+280, 600, 290, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),
	};		
	
	//---------------------------------------------------------------
	// main
	//---------------------------------------------------------------
	bool main(quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// OnInit Function
	//---------------------------------------------------------------
	void OnInit(char bFirst)
	{
		//g_nWorkFlag == 820 -> 해제활동
		if( g_nWorkFlag == 820 )
		{
			m_lWorkFlag = 2;
		}
		else
		{
			m_lWorkFlag = 1;
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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				SetCombo();
				SetData();
				ReDraw();
				
				break;
		}
	}

	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{	
			/**********************************/
			/* 공통 버튼                      */
			/**********************************/
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
				if( m_lWorkFlag == 1 )
				{
					Card_Move("C6202_NPMANAGE");
				}
				else if( m_lWorkFlag == 2 )
				{
					Card_Move("C6202_CLEARLST");
				}
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				break;
				
			/**********************************/
			/* 일반 버튼                      */
			/**********************************/
			case BID_STOP:
				Snd_Stop();
				break;
				
			case BID_OK:
				if( m_lWorkFlag == 1 )
				{
					Card_Move("C6202_NPMANAGE");
				}
				else if( m_lWorkFlag == 2 )
				{
					Card_Move("C6202_CLEARLST");
				}
				break;
			
			case BID_PHOTO:
				Shoto_Photo();
				break;
				
			case BID_SMS_STOP:
				Card_Move("C6202_SMS_STOP");
			    break;
		}
	}		

	/*=======================================================================================
	함수명 : OnChar
	기  능 : 숫자만 입력
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		if( m_lWorkFlag == 1 )
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
					return;
				}
			}
			
			if( Str_Cmp(m_szRevisFlag, "10") != 0 )
			{
				//숫자만 입력 가능
				if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
				    Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
				}
			}
		}
		else
		{
			//숫자만 입력 가능
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
					return;
				}
			}
			
			if( Str_Cmp(stClear.GMTR_OBJ_FLAG, "10") != 0 )
			{
				//숫자만 입력 가능
				if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
				    Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
				}
			}
		}
		
		ON_DRAW();
		
		return;
	}

	/*=======================================================================================
	함수명 : OnPointing
	기  능 : 화면 포인팅 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				m_lActiveIndex = lActiveIndex;
			
				if( m_lWorkFlag == 1 )
				{
					if( Str_Cmp(m_szRevisFlag, "10") == 0 )
					{
						if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+361-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+431-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex	)
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(400);
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
						if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+361-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+431-(g_Dlgflag*400)) ||
						    X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+431-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+501-(g_Dlgflag*400)) ||
						    X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+501-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+571-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
							{
							
								g_Dlgflag = 0;
								g_MOVE_DLG(400);
							
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
				else if( m_lWorkFlag == 2 )
				{
					if( Str_Cmp(m_szRevisFlag, "10") == 0 )
					{
						if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+361-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+431-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex	)
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(400);
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
						if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+361-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+431-(g_Dlgflag*400)) ||
						    X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+431-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+501-(g_Dlgflag*400)) ||
						    X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+501-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+571-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
							{
							
								g_Dlgflag = 0;
								g_MOVE_DLG(400);
							
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
		
		return;
	}

	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	함수명 : SetCombo
	기  능 : 콤보박스 세팅
	Param  : 
	Return : 
	========================================================================================*/		
	void SetCombo(void)
	{
		//안내장부착
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20502'", CMB_DATA1+2);

		//키퍼도구
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30107'", CMB_DATA2+2);

		return;
	}
	
	/*=======================================================================================
	함수명 : SetData
	기  능 : Data Setting( 기물번호, 체납액, 상태 )
	Param  : 
	Return : 
	========================================================================================*/
	void SetData(void)
	{
		long i, idx;
		
		char tmp_mtr_id_num[100];
		char tmp_nonpay_amt[100];
		char tmp_mtr_sts[100];

		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PARAM4, PARAM2, PARAM1 \
								             FROM RCV_NONPAY_MTRINFO \
								            WHERE PARAM3 = ?"
								    );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szMTR_NUM, 9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			
			Mem_Set( (byte*)tmp_mtr_id_num, 0x00, sizeof(tmp_mtr_id_num) );
			sql->GetValue( sql, i++, 'U', (long*) tmp_mtr_id_num , 100, DECRYPT );
			
			Mem_Set( (byte*)tmp_nonpay_amt, 0x00, sizeof(tmp_nonpay_amt) );
			
			sql->GetValue( sql, i++, 'U', (long*) tmp_nonpay_amt , 100, DECRYPT );
			
			Mem_Set( (byte*)tmp_mtr_sts, 0x00, sizeof(tmp_mtr_sts) );
			sql->GetValue( sql, i++, 'U', (long*) tmp_mtr_sts    , 100, DECRYPT );
		}
		
		// 기물번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), tmp_mtr_id_num);
		
		// 체납액
		Str_Chg(tmp_nonpay_amt, STRCHG_INS_COMMA);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), tmp_nonpay_amt);
		
		// 상태
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), tmp_mtr_sts);
		
Finally:
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	함수명 : ReDraw
	기  능 : 화면
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{
		char szTmp[50];
		char szSql[300];
		char szDirPath[100];
		char szScrPht[128];
		char szToday[10];
		long nRet;
		
		/**************************************/
		/* 1. 지침 EDIT 활성화/비활성화       */
		/**************************************/
		// 일반
		if( m_lWorkFlag == 1 )
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			Mem_Set((byte*)m_szRevisFlag, 0x00, sizeof(m_szRevisFlag));
			SPRINT( szSql, "SELECT PARAM9 FROM RCV_NONPAY_MTRINFO WHERE PARAM3 = '%s'", g_szMTR_NUM, 0, 0 );
			g_Sql_RetStr(szSql, 10, m_szRevisFlag);
			
			if( Str_Cmp(m_szRevisFlag, "10") == 0 )
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
		}
		// 해제활동
		else if( m_lWorkFlag == 2 )
		{
			if( Str_Cmp(stClear.GMTR_OBJ_FLAG, "10") == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
			}
		}
		
		/**************************************/
		/* 2. 중지 문자 버튼 활성/비활성화    */
		/**************************************/
		if( Status_BID_SMS_STOP() == 1 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STOP), TRUE );
			DlgCtrl_SetGray(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STOP), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STOP), FALSE );
			DlgCtrl_SetGray(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STOP), TRUE );
		}
		
		/**************************************/
		/* 3. 중지 문자 발신 여부 색상        */
		/**************************************/
		if( Str_Cmp(stNoPayObj.STOP_SMS_YN, "Y") == 0 )
		{
			EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS_STOP), RED);
		}
		else
		{
			EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS_STOP), BTNCTRLBKCOLOR);
		}


		/********************************************/
		/* 사진 데이터 확인 1216진광언               */
		/********************************************/
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
		Mem_Set((byte *)szToday, 0x00, sizeof(szToday));
		Str_ItoA(Time_GetDate(), szToday, 10);
		
		Str_Cpy( szDirPath, PHOTO_NP );
		Str_Cpy( szTmp, stNoPayObj.USE_CONT_NUM );
		Str_Cat( szTmp, "_" );
		Str_Cat( szTmp, szToday );
		Str_Cat( szTmp, "*" );
		Str_Cat( szTmp, "_S.jpg" );
		
		nRet = g_FindFiles( szDirPath, szTmp , szScrPht);
		
		if(nRet > 0)
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : Status_BID_SMS_STOP
	기  능 : 중지 문자 버튼 상태
	Param  : 
	Return : 0 = 비활성화, 1 = 활성화
	========================================================================================*/
	long Status_BID_SMS_STOP(void)
	{
		char szTmp[50];
		
		// 1. 임시 사용 세대
		if( stNoPayObj.CUST_NUM[0] == '0' )
		{				
			return 0;
		}
		
		// 2. 전화 번호 없는 세대
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy( szTmp, stNoPayObj.CP_DDD );
		Str_Cat( szTmp, stNoPayObj.CP_EXN ); 
		Str_Cat( szTmp, stNoPayObj.CP_NUM );
		
		if( Str_Len(szTmp) < 10 )
		{
			return 0;
		}
		
		// 3. 실사용자 파악 요청 세대
		if( Str_Cmp(stNoPayObj.EXCEP_TEL_YN, "Y") == 0 )
		{
			return 0;
		}
		
		return 1;
	}
	
	/*=======================================================================================
	함수명 : Snd_Stop
	기  능 : 중지 처리, FR81203
	Param  : 
	Return : 
	========================================================================================*/		
	long Snd_Stop(void)
	{
		char szSql[500];
		char szUrl[200];
		char szbuf[128];
		char szDate[20];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		/******************************************/
		/* 중지 처리 Validation                   */
		/******************************************/
		if( !Snd_Stop_Validation() )
		{
			return -1;
		}
		
		/******************************************/
		/* 송신 데이터 스트럭쳐에 셋팅            */
		/******************************************/
		SetStruct();
		
		/******************************************/
		/* 전송데이터 확인                        */
		/******************************************/
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
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR81203; //통신완료 후에 호출 함수
		HTTP_DownloadData( szUrl, "FR81203_IN",  "FR81203" , sndbuf, szbuf );

		return 1;
	}
	
	/*=======================================================================================
	함수명 : TR81203
	기  능 : FR81203 Callback
	Param  : 
	Return : 
	========================================================================================*/	
	long TR81203(void)
	{
		char szSql[350];
	
		if( g_Chk_Json(81203) >= 0 )
		{
			if( m_lWorkFlag == 1 )
			{
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
				
				if( g_nWorkFlag == 830 )
				{
					SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET VISIT_FLAG = 'Y', RELEASE_YN = 'N', STOP_YN = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);	
				}
				else if( g_nWorkFlag == 810 )
				{
					SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET VISIT_FLAG = 'Y', RELEASE_YN = 'N', STOP_YN = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				else
				{
					SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET VISIT_FLAG = 'Y', RELEASE_YN = 'N', STOP_YN = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				
				g_Sql_DirectExecute(szSql);
				
				Mem_Set( (byte*)stNoPayObj.RELEASE_YN, 0x00, sizeof(stNoPayObj.RELEASE_YN) );	
				Str_Cpy(stNoPayObj.RELEASE_YN, "N");
				
				Mem_Set( (byte*)stNoPayObj.STOP_YN, 0x00, sizeof(stNoPayObj.STOP_YN) );
				Str_Cpy(stNoPayObj.STOP_YN, "Y");
					
				Mem_Set( (byte*)stNoPayObj.VISIT_FLAG, 0x00, sizeof(stNoPayObj.VISIT_FLAG) );
				Str_Cpy(stNoPayObj.VISIT_FLAG, "Y");
				
				Card_Move("C6202_NPACTIVE");
			}
			else if( m_lWorkFlag == 2 )
			{
				MessageBoxEx(CONFIRM_OK, "처리가 완료 되었습니다.");

				Card_Move("C6202_CLEARLST");
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
	
	/*=======================================================================================
	함수명 : SetStruct
	기  능 : m_stMtrProd SetStruct Setting
	Param  : 
	Return : 
	========================================================================================*/		
	void SetStruct(void)
	{
		char szSql[300];
		char szTmp[300];
		char szNum[100];
		char szDate[30];
		char szTime[30];
		
		/**************************************/
		/* 체납활동 -> 중지                   */
		/**************************************/
		if( m_lWorkFlag == 1 )
		{	
			// m_stMtrProd 초기화
			Mem_Set((byte*)&m_stMtrProd, 0x00, sizeof(m_stMtrProd));
			
			// 1. CIVIL_SERV_RECEIVE_NUM
			Mem_Set((byte*)szNum, 0x00, sizeof(szNum));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
			
			Str_ItoA(Time_GetDate(), szTmp, 10);
			
			Mem_Cpy( (byte*)szDate, (byte*)szTmp+1, 7);
			g_Str_TimeType( szTime , Time_GetTime());	
			Str_Chg(szTime, STRCHG_DEL_NONDIGIT);
			
			Str_Cpy(szNum, "N");
			Str_Cat(szNum, szDate);
			Str_Cat(szNum, szTime);
			Str_Cpy(m_stMtrProd.CIVIL_SERV_RECEIVE_NUM, szNum);
			
			// 2. TREAT_SEQ
			Str_Cpy(m_stMtrProd.TREAT_SEQ             , "1");
			
			// 3. PDA_DUTY_FLAG
			Str_Cpy(m_stMtrProd.PDA_DUTY_FLAG         , "30");
			
			// 4. REQ_INFO_NUM
			Str_Cpy(m_stMtrProd.REQ_INFO_NUM          , "");
			
			// 5. USE_CONT_NUM
			Str_Cpy(m_stMtrProd.USE_CONT_NUM          , stNoPayObj.USE_CONT_NUM);
			
			// 6. CONT_STS_CD
			Str_Cpy(m_stMtrProd.CONT_STS_CD           , "20");
			
			// 7. CONT_FLAG_CD
			Str_Cpy(m_stMtrProd.CONT_FLAG_CD          , "10");
			
			// 8. INST_PLACE_NUM
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SPRINT( szSql, "SELECT PARAM7 FROM RCV_NONPAY_MTRINFO WHERE PARAM3 = '%s'", g_szMTR_NUM, 0, 0 );
			g_Sql_RetStr(szSql, 20, m_stMtrProd.INST_PLACE_NUM);
			
			// 9. TREAT_YMD
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szDate, 10);
			Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
			Str_Cpy(m_stMtrProd.TREAT_YMD             , szDate);
			
			// 10. SMS_YN
			Str_Cpy(m_stMtrProd.SMS_YN                , stNoPayObj.RSLT_NOTICE_YN);
			
			// 11. MTR_NUM
			Str_Cpy(m_stMtrProd.MTR_NUM               , g_szMTR_NUM);
			
			// 12. PROD_CONT_SEQ
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SPRINT( szSql, "SELECT PARAM11 FROM RCV_NONPAY_MTRINFO WHERE PARAM3 = '%s'", g_szMTR_NUM, 0, 0 );
			g_Sql_RetStr(szSql, 20, m_stMtrProd.PROD_CONT_SEQ);
			
			// 13. PROD_STS_CD
			Str_Cpy(m_stMtrProd.PROD_STS_CD           , "20");
			
			// 14. INDI_TYPE_CD
			Str_Cpy(m_stMtrProd.INDI_TYPE_CD          , "11");
			
			// 15. KEEPER_YN
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30107' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), 0, 0);
			g_Sql_RetStr(szSql, 20, szTmp);
			Str_Cpy(m_stMtrProd.KEEPER_YN             , szTmp);
			
			// 16. ADVICE_YN
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C20502' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), 0, 0);
			g_Sql_RetStr(szSql, 20, szTmp);
			Str_Cpy(m_stMtrProd.ADVICE_YN             , szTmp);
			
			// 17. INDI_MANAGE_STS
			Str_Cpy(m_stMtrProd.INDI_MANAGE_STS       , "10");
			
			// 18. INDI_VC_AFTER
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			}
			
			// 19. INDI_VA_AFTER
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			
			// 20. INDI_VM_AFTER
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			
			// 21. CUT_TYPE_CD
			Str_Cpy(m_stMtrProd.CUT_TYPE_CD           , "30");
			
			// 22. CUT_WHY_CD
			Str_Cpy(m_stMtrProd.CUT_WHY_CD            , "10");
			
			// 23. CUT_CNL_WHY_CD
			Str_Cpy(m_stMtrProd.CUT_CNL_WHY_CD        , "");
			
			// 24. CUT_CNL_FEE_YN
			Str_Cpy(m_stMtrProd.CUT_CNL_FEE_YN        , "");
			
			// 25. CUT_CNL_FEE_EXEMPT_WHY
			Str_Cpy(m_stMtrProd.CUT_CNL_FEE_EXEMPT_WHY, "");
			
			// 26. GMTR_OBJ_FLAG
			if( Str_Cmp(m_szRevisFlag, "10") == 0 )
			{
				Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "10");
			}
			else
			{
				Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG, "30");
			}
			
			// 27. CUT_JOB_FLAG
			Str_Cpy(m_stMtrProd.CUT_JOB_FLAG          , "10");
			
			// 28. NONPAY_MM_CNT
			Str_Cpy(m_stMtrProd.NONPAY_MM_CNT         , stNoPayObj.NONPAY_MM_CNT);
			
			// 29. NONPAY_AMT
			Str_Cpy(m_stMtrProd.NONPAY_AMT            , stNoPayObj.UNPAY_AMT_SUM);
			
			// 30. NONPAY_ACTIVE_DEPT
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_DEPT    , stNoPayObj.NONPAY_ACTIVE_DEPT);
			
			// 31. NONPAY_MANAGE_ZONE
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_ZONE    , stNoPayObj.NONPAY_MANAGE_ZONE);
			
			// 32. NONPAY_ACTIVE_FLAG
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_FLAG    , "320");
			
			// 33. NONPAY_MANAGE_STS
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_STS     , "32");
			
			// 34. CUT_TREAT_YMD
			Str_Cpy(m_stMtrProd.CUT_TREAT_YMD         , szDate);
			
			// 35. CUT_CNL_YMD
			Str_Cpy(m_stMtrProd.CUT_CNL_YMD           , "");
			
			// 36. ACTIVE_RSLT_DESC
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "지침(VC=%s, VA=%s, VM=%s),",m_stMtrProd.INDI_VC_AFTER,m_stMtrProd.INDI_VA_AFTER,m_stMtrProd.INDI_VM_AFTER);
			SPRINT(szTmp, "%s, 안내장부착(%s),처리자=%s", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) , stUserinfo.sznm_kor);
			Str_Cat(szSql, szTmp);
			SQL_ConvUcStr( m_stMtrProd.ACTIVE_RSLT_DESC, szSql );
		}
		/**************************************/
		/* 해제활동 -> 중지                   */
		/**************************************/
		else if( m_lWorkFlag == 2 )
		{
			// m_stMtrProd 초기화
			Mem_Set((byte*)&m_stMtrProd, 0x00, sizeof(m_stMtrProd));
			
			// 1. CIVIL_SERV_RECEIVE_NUM
			Mem_Set((byte*)szNum, 0x00, sizeof(szNum));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
			
			Str_ItoA(Time_GetDate(), szTmp, 10);
			Mem_Cpy( (byte*)szDate, (byte*)szTmp+1, 7);
			g_Str_TimeType( szTime , Time_GetTime());
			Str_Chg(szTime, STRCHG_DEL_NONDIGIT);
			
			Str_Cpy(szNum, "N");
			Str_Cat(szNum, szDate);
			Str_Cat(szNum, szTime);
			Str_Cpy(m_stMtrProd.CIVIL_SERV_RECEIVE_NUM, szNum);
			
			// 2. TREAT_SEQ
			Str_Cpy(m_stMtrProd.TREAT_SEQ             , "1");
			
			// 3. PDA_DUTY_FLAG
			Str_Cpy(m_stMtrProd.PDA_DUTY_FLAG         , "30");
			
			// 4. REQ_INFO_NUM
			Str_Cpy(m_stMtrProd.REQ_INFO_NUM          , "");
			
			// 5. USE_CONT_NUM
			Str_Cpy(m_stMtrProd.USE_CONT_NUM          , stClear.USE_CONT_NUM);
			
			// 6. CONT_STS_CD
			Str_Cpy(m_stMtrProd.CONT_STS_CD           , "20");
			
			// 7. CONT_FLAG_CD
			Str_Cpy(m_stMtrProd.CONT_FLAG_CD          , "10");
			
			// 8. INST_PLACE_NUM
			Str_Cpy(m_stMtrProd.INST_PLACE_NUM        , stClear.INST_PLACE_NUM);
			
			// 9. TREAT_YMD
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Str_ItoA(Time_GetDate(), szDate, 10);
			Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
			Str_Cpy(m_stMtrProd.TREAT_YMD             , szDate);
			
			// 10. SMS_YN
			Str_Cpy(m_stMtrProd.SMS_YN                , stClear.RSLT_NOTICE_YN);
			
			// 11. MTR_NUM
			Str_Cpy(m_stMtrProd.MTR_NUM               , stClear.MTR_NUM);
			
			// 12. PROD_CONT_SEQ
			Str_Cpy(m_stMtrProd.PROD_CONT_SEQ         , stClear.PROD_CONT_SEQ);
			
			// 13. PROD_STS_CD
			Str_Cpy(m_stMtrProd.PROD_STS_CD           , "20");
			
			// 14. INDI_TYPE_CD
			Str_Cpy(m_stMtrProd.INDI_TYPE_CD          , "11");
			
			// 15. KEEPER_YN
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30107' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), 0, 0);
			g_Sql_RetStr(szSql, 20, szTmp);
			Str_Cpy(m_stMtrProd.KEEPER_YN             , szTmp);
			
			// 16. ADVICE_YN
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C20502' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), 0, 0);
			g_Sql_RetStr(szSql, 20, szTmp);
			Str_Cpy(m_stMtrProd.ADVICE_YN             , szTmp);
			
			// 17. INDI_MANAGE_STS
			Str_Cpy(m_stMtrProd.INDI_MANAGE_STS       , "10");
			
			// 18. INDI_VC_AFTER
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VC_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			}
			
			// 19. INDI_VA_AFTER
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VA_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			
			// 20. INDI_VM_AFTER
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , "0");
			}
			else
			{
				Str_Cpy(m_stMtrProd.INDI_VM_AFTER         , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			
			// 21. CUT_TYPE_CD
			Str_Cpy(m_stMtrProd.CUT_TYPE_CD           , "30");
			
			// 22. CUT_WHY_CD
			Str_Cpy(m_stMtrProd.CUT_WHY_CD            , "10");
			
			// 23. CUT_CNL_WHY_CD
			Str_Cpy(m_stMtrProd.CUT_CNL_WHY_CD        , "");
			
			// 24. CUT_CNL_FEE_YN
			Str_Cpy(m_stMtrProd.CUT_CNL_FEE_YN        , "");
			
			// 25. CUT_CNL_FEE_EXEMPT_WHY
			Str_Cpy(m_stMtrProd.CUT_CNL_FEE_EXEMPT_WHY, "");
			
			// 26. GMTR_OBJ_FLAG
			Str_Cpy(m_stMtrProd.GMTR_OBJ_FLAG         , stClear.GMTR_OBJ_FLAG);
			
			// 27. CUT_JOB_FLAG	
			Str_Cpy(m_stMtrProd.CUT_JOB_FLAG          , "10");
			
			// 28. NONPAY_MM_CNT
			Str_Cpy(m_stMtrProd.NONPAY_MM_CNT         , stClear.NONPAY_MM_CNT);
			
			// 29. NONPAY_AMT
			Str_Cpy(m_stMtrProd.NONPAY_AMT            , "");
			
			// 30. NONPAY_ACTIVE_DEPT
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_DEPT    , stClear.NONPAY_ACTIVE_DEPT);
			
			// 31. NONPAY_MANAGE_ZONE
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_ZONE    , stClear.NONPAY_MANAGE_ZONE);
			
			// 32. NONPAY_ACTIVE_FLAG
			Str_Cpy(m_stMtrProd.NONPAY_ACTIVE_FLAG    , "320");
			
			// 33. NONPAY_MANAGE_STS
			Str_Cpy(m_stMtrProd.NONPAY_MANAGE_STS     , "32");
			
			// 34. CUT_TREAT_YMD
			Str_Cpy(m_stMtrProd.CUT_TREAT_YMD         , szDate);
			
			// 35. CUT_CNL_YMD
			Str_Cpy(m_stMtrProd.CUT_CNL_YMD           , "");
			
			// 36. ACTIVE_RSLT_DESC
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szSql, "지침(VC=%s, VA=%s, VM=%s),",m_stMtrProd.INDI_VC_AFTER,m_stMtrProd.INDI_VA_AFTER,m_stMtrProd.INDI_VM_AFTER);
			SPRINT(szTmp, "%s, 안내장부착(%s),처리자=%s", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) , stUserinfo.sznm_kor);
			Str_Cat(szSql, szTmp);
			SQL_ConvUcStr( m_stMtrProd.ACTIVE_RSLT_DESC, szSql );
		}
	}
	
	/*=======================================================================================
	함수명 : Snd_Stop_Validation
	기  능 : 중지 Validaion
	         체크 항목: 지침입력, 안내장부착, 키퍼, 중지문자
	Param  : 
	Return : TRUE, FALSE
	========================================================================================*/
	bool Snd_Stop_Validation(void)
	{
		// 1. 지침입력
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "Vc 지침을 입력해주세요.");
			return FALSE;
		}
		
		if( Str_Cmp(m_szRevisFlag, "10") != 0 )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "Va 지침을 입력해주세요.");
				return FALSE;
			}
	
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "Vm 지침을 입력해주세요.");
				return FALSE;
			}
		}
		
		// 2. 안내장부착
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "안내장부착을 선택해주세요.");
			return FALSE;
		}
		
		// 3. 키퍼
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "") == 0 || Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "키퍼를 선택해주세요.");
			return FALSE;
		}
		
		// 4. 문자 전송 여부
		if( Status_BID_SMS_STOP() == 1 && Str_Cmp(stNoPayObj.STOP_SMS_YN, "Y") != 0 )
		{
			MessageBoxEx(CONFIRM_OK, "[ 필수사항 ]\n문자 메시지 전송");
			return FALSE;
		}
		
		// 5. 최종 처리 여부
		if( MessageBoxEx (CONFIRM_YESNO, "중지처리 하시겠습니까?")  != MB_OK)
		{
			return FALSE;
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : OnTask
	기  능 : 카메라
	Param  : 
	Return : 
	========================================================================================*/
	void OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;

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

					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_NP,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					MessageBoxEx(MESSAGE, "사진을 저장중입니다.");
					return;
				}
			}
		}

		ON_DRAW();
		return;
	}

	/*=======================================================================================
	함수명 : OnUart
	기  능 : 카메라
	Param  : 
	Return : 
	========================================================================================*/
	void OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		int size = 0;
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				
				if( FFS_Exist(szfilenm) )
				{
					FFS_Copy(szfilenm, g_szphoto);

					MessageBoxEx(MESSAGE, "사진을 저장중입니다.");
					
					FFS_Delete( szfilenm );

					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
					
					ON_DRAW();
				}
			}
		}
	}
	
	/*=======================================================================================
	함수명 : Shoto_Photo
	기  능 : 사진촬영 준비
	Param  : 
	Return : 
	========================================================================================*/
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;
		char szToday[10];
		char szTime[10];
		
 		// 사용계약번호 | _ | 생성날짜(SYSDATE : YYYYMMDDHHMMSS ) | _ | S(중지)/V(방문) 
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
		Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
		
		Str_Cpy(m_szfilenm, stNoPayObj.USE_CONT_NUM);				
		Str_Cat(m_szfilenm, "_");		

		Str_ItoA(Time_GetDate(), szToday, 10);
		Str_Cat(m_szfilenm, szToday);
		
		g_Str_TimeType( szTime , Time_GetTime());

		Str_Cat(m_szfilenm, szTime);
		Str_Cat(m_szfilenm, "_");		
		Str_Cat(m_szfilenm, "S");
		Str_Cat(m_szfilenm, ".jpg");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_NP,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;	
		}
		else
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_NP,  m_szfilenm, 0);
			ShootPhoto ( 1, 0, m_szfilenm );
		}

		return;
	}	
}



