/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_SND
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQl.lib"
		
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SEND )		//자료송신
		DEF_BUTTON_ID ( BID_DELETE )	//자료삭제
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
		DEF_OBJECT_ID ( TXT_DATA1 )			//구분       
		DEF_OBJECT_ID ( TXT_DATA2 )			//전체       
		DEF_OBJECT_ID ( TXT_DATA3 )			//송신       
		DEF_OBJECT_ID ( TXT_DATA4 )			//미송신     
		DEF_OBJECT_ID ( TXT_DATA5 )			//점검결과   
		DEF_OBJECT_ID ( TXT_DATA6 )			//보일러정보 
		DEF_OBJECT_ID ( TXT_DATA7 )			//부적합대상 
		DEF_OBJECT_ID ( TXT_DATA8 )			//부적합항목 
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
		
		DEF_OBJECT_ID ( ICON_TITLE)		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1

	char m_szScrPht[128];
	char m_szSession[128];
		
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void BF_DATADEL(void);
	long SND_CHK(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );

	long BF_DATASND(void);
	long SND_512301(void);
	long SND_512302(void);
	long SND_512303(void);
	long SND_512304(void);
	long SND_512305(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "자료 송신"),
		
		DLG_BUTTON(STARTX    , STARTY+450, 350, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "자료삭제"),
		DLG_BUTTON(STARTX+650, STARTY+450, 350, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "자료송신"),
		
		DLG_TEXT(STARTX,      STARTY+65, 300, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "구분"),
		DLG_TEXT(STARTX+300,  STARTY+65, 250, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "전체"),
		DLG_TEXT(STARTX+550,  STARTY+65, 225, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "송신"),
		DLG_TEXT(STARTX+775,  STARTY+65, 225, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "미송신"),
		DLG_TEXT(STARTX,     STARTY+140, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "점검결과"),
		DLG_TEXT(STARTX+300, STARTY+140, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+550, STARTY+140, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+775, STARTY+140, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,     STARTY+210, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "보일러정보"),
		DLG_TEXT(STARTX+300, STARTY+210, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+550, STARTY+210, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+775, STARTY+210, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,     STARTY+280, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "부적합대상"),
		DLG_TEXT(STARTX+300, STARTY+280, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+550, STARTY+280, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+775, STARTY+280, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+350, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "부적합항목"),
		DLG_TEXT(STARTX+300, STARTY+350, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+550, STARTY+350, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+775, STARTY+350, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "자료 송신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX    , STARTY+400, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "자료삭제"),
		DLG_BUTTON(STARTX+600, STARTY+400, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "자료송신"),
		
		DLG_TEXT(STARTX,      STARTY-40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "구분"),
		DLG_TEXT(STARTX+300,  STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "전체"),
		DLG_TEXT(STARTX+550,  STARTY-40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "송신"),
		DLG_TEXT(STARTX+775,  STARTY-40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "미송신"),
		DLG_TEXT(STARTX,      STARTY+40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "점검결과"),
		DLG_TEXT(STARTX+300,  STARTY+40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+550,  STARTY+40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+775,  STARTY+40, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,     STARTY+120, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "보일러정보"),
		DLG_TEXT(STARTX+300, STARTY+120, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+550, STARTY+120, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+775, STARTY+120, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,     STARTY+200, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "부적합대상"),
		DLG_TEXT(STARTX+300, STARTY+200, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+550, STARTY+200, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+775, STARTY+200, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+280, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "부적합항목"),
		DLG_TEXT(STARTX+300, STARTY+280, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+550, STARTY+280, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+775, STARTY+280, 225, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
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
						SetBtnImg();
						SetStyle();
						REDRAW();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						SetBtnImg();
						SetStyle();
						REDRAW();
						break;		
				}
				break;
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

//-----------------------------------------------------------------
void	SetStyle(void)
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
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_DELETE:
				BF_DATADEL();
				break;
				
			case BID_SEND:
				g_TRNUM = 0;
				if( SND_CHK() > 0)
				{
					BF_DATASND();
				}
				break;
				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "공급전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("BF_BEFOMENU");
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
				Card_Move("BF_BEFODMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void REDRAW(void)
	{
	char szToday[10];
	char sztmp[10]; 
	char szSql[200];
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_DATA ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_DATA WHERE SEND_FLAG = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_BO_DATA ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_BO_DATA WHERE SEND_FLAG = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_BO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_MAIN WHERE SEND_YN <> 'I' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_MAIN WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_MAIN WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE SEND_YN <> 'I' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), sztmp );
		g_TRNUM = 0;
	}
	
	
	void BF_DATADEL(void)
	{
	char szSql[600];
	char sztmp[10]; 
	long nchk = 0;

		if( MessageBoxEx (CONFIRM_YESNO, "자료를 삭제 하시겠습니까?") != MB_OK)
			return;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
			nchk++;
			
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_BO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
			nchk++;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL  WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
			nchk++;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_MAIN  WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
			nchk++;
		
		if( nchk > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "미송신 자료가 있습니다. 삭제하시겠습니까?") != MB_OK)
				return;
		}
		
		g_Sql_DirectExecute("DELETE FROM BEFO_BO_DATA");
		g_Sql_DirectExecute("DELETE FROM BEFO_DATA");
		g_Sql_DirectExecute("DELETE FROM BEFO_GROUP");
		g_Sql_DirectExecute("DELETE FROM BEFO_NOGOOD_DETAL");
		g_Sql_DirectExecute("DELETE FROM BEFO_NOGOOD_MAIN");
		
		MessageBoxEx (CONFIRM_OK, "자료 삭제가 완료되었습니다.");
		REDRAW();
	}
	
	long SND_CHK(void)
	{
	long ret = 0;
	long nchk = 0;
	char szSql[600];
	char sztmp[10];
	char szyymm[10];
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_BO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
	
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_MAIN WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
		
				
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
		if(ret <= 0)
		{
			MessageBoxEx (CONFIRM_OK, "송신할 자료가 없습니다.");
		}
		if(	ret > 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szyymm, 0x00, sizeof( szyymm) );
			SPRINT( szSql, "SELECT PARAM7 FROM RCV_LOG WHERE GUBUN = '6' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 8, sztmp);
			Str_ItoA( Time_GetDate(), szyymm, 10);
			if( Str_NCmp( sztmp, szyymm, 6) != 0 )
			{
				MessageBoxEx (CONFIRM_OK, "이월된 미송신건은 전송할 수 없습니다.");
				return -1;
			}
		}
		
		return ret;	
	}
	
	
	long BF_DATASND(void)
	{
	long ret = -1;
	long nchk = 0;
	char szSql[600];
	char sztmp[10]; 
	char szDirPath[128];
	
		//최초에 들어오면 송신결과를 확인하지 않는다.
		if( g_TRNUM >  0 )
		{			
			if(g_Chk_Json( g_TRNUM ) >= 0)
			{
				//송신성공하면 다음 FR로 넘어간다.
				if(g_TRNUM == 512305 )
				{
					FFS_Delete(m_szScrPht);
				}
				g_TRNUM++;
			}
			else
			{
				g_Sock_Close();
				return ret;
			}
			
		}
		
		if(  g_TRNUM <= 512300)
		{
			g_SeverConnection();
			Mem_Set( (byte*)m_szSession, 0x00, sizeof(m_szSession) );
			if( g_StartSession( m_szSession ) < 0)
			{
				//세션 회득시에 송신종료한다.
				return ret; 
			}
		}
		
		if(  g_TRNUM <= 512301)
		{

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_512301();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 512302)
		{		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_BO_DATA WHERE SEND_FLAG = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_512302();
				return ret;
			}
		}
		if(  g_TRNUM <= 512303)
		{		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_MAIN WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_512303();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 512304)
		{		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				SND_512304();
				return ret;
			}
		}		
		
		if(  g_TRNUM <= 512305)
		{
			if( g_EndSession( m_szSession, "4") < 0)
			{
				return ret;
			}
		}
		
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_BF );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			SND_512305();
			return ret;
		}
		else
		{
			ret = 1;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE BEFO_DATA SET SEND_FLAG = 'Y' WHERE SEND_FLAG = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE BEFO_BO_DATA SET SEND_FLAG = 'Y' WHERE SEND_FLAG = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE BEFO_NOGOOD_MAIN SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE BEFO_NOGOOD_DETAL SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
	
			g_Sock_Close();
					
			MessageBoxEx (CONFIRM_OK, "결과 송신완료하였습니다.");
			
			REDRAW();
			
			ON_DRAW();
		}
		return ret;
	}
	
	long SND_512301(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 512301, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select create_ymd,mtr_num,ins_join_yn,ins_expla_yn,chk_ymd \
,chk_time_from,chk_time_to,chk_ymd as chk_end_ymd,chk_rslt,sign \
,indi_dtm,mtr_indi,indi_va,indi_vc,center_cd,zone_manage_num \
,pda_num ,CRT_IP as client_id,CRT_EMPID as user_id FROM befo_data WHERE SEND_FLAG = 'S' "
        ,0 , 0, 0 );

		callBackfunc = BF_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 512301;
		HTTP_UploadData  ( szUrl, "FR512301_IN",  "FR512301" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_512302(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 512302, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select burner_num,create_ymd,mtr_num,crt_ip as client_id,CRT_EMPID as user_id,chg_flag \
,burner_model_cd,burner_class_cd,burner_kind_num,burner_capa,burner_capa_unit \
,burner_inst_ymd,burner_remov_ymd,burner_model_nm,maker_flag,maker_num \
,maker_nm,boiler_form,make_num,work_docu_receive_ymd,inst_flag \
,inst_loc,boiler_inst_firm_cd FROM befo_bo_data WHERE SEND_FLAG = 'S' ",0 , 0, 0 );

		callBackfunc = BF_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 512302;
		HTTP_UploadData  ( szUrl, "FR512302_IN",  "FR512302" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_512303(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 512303, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select create_ymd,mtr_num,CRT_IP as client_id,CRT_EMPID as user_id,bld_num,inst_place_num,\
single_colive_flag,center_cd,zone_manage_num,zip_no1,zip_no2,city,area,town,village,addr1_m,addr1_s \
,lot_num_second_addr,co_live_nm,house_cnt,bld_nm,deta_floor,law_town,new_road_nm,new_addr_m,new_addr_s \
,compx_flag_nm,cust_num,cust_type_cd,cust_nm,firm_nm,biz_regi_num,soc_num,repre_nm \
,cp_ddd,cp_exn,cp_num,ownhouse_tel_ddd,ownhouse_tel_exn,ownhouse_tel_num,end_yn \
FROM BEFO_NOGOOD_MAIN where SEND_YN = 'S' ",0 , 0, 0 );

		callBackfunc = BF_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 512303;
		HTTP_UploadData  ( szUrl, "FR512303_IN",  "FR512303" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_512304(void)
	{
	char szUrl[200];
	char szSql[600];
	char szDbpath[128];
	char* sndbuf;
	long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 512304, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		SPRINT( szSql, "select create_ymd,mtr_num,burner_num,chk_sec_cd,not_pass_item_cd \
,CRT_IP as client_id,CRT_EMPID as user_id,visit_dtm,chk_sec_nm,not_pass_item_nm \
,better_plan_ymd,better_conf_empid,better_ymd,better_yn ,mtr_id_num \
from BEFO_NOGOOD_DETAL where SEND_YN = 'S' ",0 , 0, 0 );

		callBackfunc = BF_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 512304;
		HTTP_UploadData  ( szUrl, "FR512304_IN",  "FR512304" , sndbuf, szDbpath, szSql);
		return ret;
	}
	
	long SND_512305(void)
	{
	char szUrl[200];
	char szDbpath[128];
	char szDirPath[128];
	char szfilenm[128];
	char szdata[20];
	char* sndbuf;
	char* szfile;
	char* filedata;
	long ret=0, nRet, filesize, fd;
	handle file;		
		
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_BF );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(nRet > 0)
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 512305, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "create_ymd", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num",      szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 4, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "burner_num",   szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 5, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_sec_cd",   szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 6, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "not_pass_item_cd",  szdata );
				
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			sndbuf = JSON_toString(g_pjcomm);
			
			//g_Save_JsonFile(sndbuf);
			callBackfunc = BF_DATASND; //통신완료 후에 호출 함수
			g_TRNUM = 512305;		
			HTTP_DownloadData  ( szUrl, "FR512305_IN",  "FR512305" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}

		return 1;
	}
	
	void fsgetitem(char* szSource, char* szTarget, int id, int len )
	{
	int i;
	int idx;
	int ids;
	
		idx =0;
		ids =1;
		for(i=0; i<len; i++)
		{
			if(szSource[i] == '_' || szSource[i] == '.')
			{
				if(ids == id )
				{
					szTarget[idx] = 0x00;
					break;
				}
				idx = 0;
				ids++;
				continue;
			}
			if(ids == id )
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}
}


