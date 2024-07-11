/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_JOJUNGSND
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SEND )		//자료송신
		DEF_BUTTON_ID ( BID_DEL )		//자료송신
		
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
		DEF_OBJECT_ID ( TXT_LIST )			//목록
		DEF_OBJECT_ID ( TXT_OBJECT )		//대상
		DEF_OBJECT_ID ( TXT_SEND )			//송신
		DEF_OBJECT_ID ( TXT_NSEND )			//미송신
		DEF_OBJECT_ID ( TXT_SCRSLT )		//점검결과
		DEF_OBJECT_ID ( TXT_CHNGINFO )		//변경정보
		DEF_OBJECT_ID ( TXT_JUNSOO )		//전수정보
		DEF_OBJECT_ID ( TXT_NFITITEM )		//부적합항목
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
		DEF_OBJECT_ID ( TXT_DATA11)
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	char m_szScrPht[256];
	char m_szSession[128];
	
	void SetStyle(void);
	void REDRAW(void);
	void SetBtnImg(void);
	void Del_Data(void);
	long JO_DATASND(void);
	long SND_CHK(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	
	long Snd312311(void);
	long Snd312312(void);
	long Snd312313(void);
	long Snd312319(void);
	long Snd312320(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "조정기 자료송신"),
		
		DLG_TEXT(STARTX, 	  STARTY+65, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LIST, "목록"),
		DLG_TEXT(STARTX+300,  STARTY+65, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "대상"),
		DLG_TEXT(STARTX+550,  STARTY+65, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEND, "송신"),
		DLG_TEXT(STARTX+775,  STARTY+65, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSEND, "미송신"),
		DLG_TEXT(STARTX, 	 STARTY+165, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCRSLT, "점검결과"),
		DLG_TEXT(STARTX+300, STARTY+165, 250, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY+165, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+775, STARTY+165, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX, 	 STARTY+265, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CHNGINFO, "변경정보"),
		DLG_TEXT(STARTX+550, STARTY+265, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+775, STARTY+265, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX, 	 STARTY+365, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "전수정보"),
		DLG_TEXT(STARTX+300, STARTY+365, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+550, STARTY+365, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+775, STARTY+365, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX, 	 STARTY+465, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFITITEM, "부적합항목"),
		DLG_TEXT(STARTX+300, STARTY+465, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX+550, STARTY+465, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+775, STARTY+465, 225, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),

		DLG_BUTTON(STARTX,     STARTY+630, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "자료 삭제"),
		DLG_BUTTON(STARTX+600, STARTY+630, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "자료 송신"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "조정기 자료송신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_TEXT(STARTX,		 STARTY-40, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LIST, "목록"),
		DLG_TEXT(STARTX+300,	 STARTY-40, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "대상"),
		DLG_TEXT(STARTX+550,	 STARTY-40, 200, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEND, "송신"),
		DLG_TEXT(STARTX+750,	 STARTY-40, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSEND, "미송신"),
		DLG_TEXT(STARTX,		 STARTY+60, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCRSLT, "점검결과"),
		DLG_TEXT(STARTX+300,	 STARTY+60, 250, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550,	 STARTY+60, 200, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+750,	 STARTY+60, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,		STARTY+160, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CHNGINFO, "변경정보"),
		DLG_TEXT(STARTX+550,	STARTY+160, 200, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+750,	STARTY+160, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,		STARTY+260, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "전수정보"),
		DLG_TEXT(STARTX+300,	STARTY+260, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+550,	STARTY+260, 200, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+750,	STARTY+260, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,		STARTY+360, 300, 100, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFITITEM, "부적합항목"),
		DLG_TEXT(STARTX+300,	STARTY+360, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX+550,	STARTY+360, 200, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+750,	STARTY+360, 250, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),	

		DLG_BUTTON(STARTX,     STARTY+550, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "자료 삭제"),
		DLG_BUTTON(STARTX+600, STARTY+550, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "자료 송신"),
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
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LIST), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEND), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NSEND), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SCRSLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHNGINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JUNSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NFITITEM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
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
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_DEL:
				Del_Data();
				break;
			case BID_SEND:
				g_TRNUM = 0;
				if( SND_CHK() > 0)
				{
					JO_DATASND();
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "안전점검 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
					Card_Move("SC_MENU");
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
				Card_Move("SC_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void REDRAW(void)
	{
	char sztmp[10]; 
	char szSql[200];
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp );
				
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE CHK_END_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE CHK_END_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE INFO_FLAG = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE INFO_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_MRT ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), sztmp );
				
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_MRT WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_MRT WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_NOGOOD ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), sztmp );
				
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_NOGOOD WHERE SEND_YN = 'Y' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_NOGOOD WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), sztmp );
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
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE CHK_END_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE INFO_FLAG = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
	
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_MRT WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			ret++;
		}
		
				
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_NOGOOD WHERE SEND_YN = 'S' ",0,0,0   );
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
			SPRINT( szSql, "SELECT PARAM7 FROM RCV_LOG WHERE GUBUN = '3' ", 0, 0, 0 );
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
	
	
	void Del_Data(void)
	{
	char sztmp[10]; 
	char szSql[200];
	long cnt = 0, chk = 0;
		
		if( MessageBoxEx(CONFIRM_YESNO, "자료를 삭제하시겠습니까?") != MB_OK )
		{
			return;
		}		
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE CHK_END_YN = 'S' ",0,0,0   );
		cnt = 0;
		g_Sql_RetInt(szSql, &cnt );
		if(cnt > 0 )
		{
			chk++;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_DATA WHERE INFO_FLAG = 'S' ",0,0,0   );
		cnt = 0;
		g_Sql_RetInt(szSql, &cnt );
		if(cnt > 0 )
		{
			chk++;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_MRT WHERE SEND_YN = 'S' ",0,0,0   );
		cnt = 0;
		g_Sql_RetInt(szSql, &cnt );
		if(cnt > 0 )
		{
			chk++;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGTR_NOGOOD WHERE SEND_YN = 'S' ",0,0,0   );
		cnt = 0;
		g_Sql_RetInt(szSql, &cnt );
		if(cnt > 0 )
		{
			chk++;
		}

		if(chk > 0)
		{
			if( MessageBoxEx(CONFIRM_YESNO, "미송신 자료가 있습니다. 삭제하시겠습니까?") != MB_OK )
			{
				return;
			}
		}
		
		g_Sql_DirectExecute("DELETE FROM REGTR_GROUP");
		g_Sql_DirectExecute("DELETE FROM REGTR_DATA");
		g_Sql_DirectExecute("DELETE FROM REGTR_MRT");
		g_Sql_DirectExecute("DELETE FROM REGTR_NOGOOD");
		
		MessageBoxEx(CONFIRM_OK, "자료 삭제가 완료되었습니다.");
		
		REDRAW();
	}	
	
	
	long JO_DATASND(void)
	{
	long ret = 1;
	long nchk = 0;
	char szSql[600];
	char sztmp[10]; 
	char szDirPath[128];
	
		if( g_TRNUM >  0 )
		{
			if(g_Chk_Json( g_TRNUM ) >= 0)
			{
				if(g_TRNUM == 312320 )
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
		
		
		if(  g_TRNUM <= 312310 )
		{
			g_SeverConnection();
			Mem_Set( (byte*)m_szSession, 0x00, sizeof(m_szSession) );
			if( g_StartSession( m_szSession ) < 0)
			{
				//세션 회득시에 송신종료한다.
				return ret; 
			}
		}
		
		
		if(  g_TRNUM <= 312311 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM regtr_data WHERE INFO_FLAG = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312311();
				return ret;
			}
		}
				
		if(  g_TRNUM <= 312312 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM regtr_data WHERE CHK_END_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312312();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 312313 )
		{
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM regtr_nogood WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312313();
				return ret;
			}
		}			
			
		if(  g_TRNUM <= 312319 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT COUNT(*) FROM regtr_mrt WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312319();
				return ret;
			}
		}
		
		if(  g_TRNUM <= 312320)
		{
			if( g_EndSession( m_szSession, "2") < 0)
			{	
				g_Sock_Close();
				return ret;
			}		
		}
		
		
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_JO );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312320();
			return ret;
		}
		else
		{
			g_Sock_Close();
			ret = 1;
			MessageBoxEx (CONFIRM_OK, "결과 송신완료하였습니다.");
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ," UPDATE regtr_data SET INFO_FLAG = 'Y' WHERE INFO_FLAG = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ," UPDATE regtr_data SET CHK_END_YN = 'Y' WHERE CHK_END_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ," UPDATE regtr_nogood SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ," UPDATE regtr_mrt SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ",0,0,0   );
			g_Sql_DirectExecute( szSql );
					
			REDRAW();
			ON_DRAW();
		}
		return ret;
	}
	
	
	
	long Snd312311(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312311, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);

		SPRINT( szSql, "select regtr_num,chk_plan_ym,safe_chk_type,maker_num,regtr_model_cd \
,regtr_type, regtr_id_num, single_colive_flag, CHK_EMPID as user_id,'%s' as client_id  from regtr_data where INFO_FLAG = 'S' "
, stUserinfo.szpda_ip, 0 , 0 );
			
		callBackfunc = JO_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 312311;				
		HTTP_UploadData  ( szUrl, "FR312311_IN",  "FR312311" , sndbuf, szDbpath, szSql);
		return 1;
	}
	
	long Snd312312(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312312, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);

		SPRINT( szSql, "select regtr_num,chk_plan_ym,safe_chk_type,filter_repl_flag,new_filter_repl_ymd as filter_repl_ymd \
,curr_bar as bar,bar_not_permit_why,chk_empid,chk_ymd,chk_rslt \
,chk_excep_why,second_press, chk_sign_image, FHALF_MEMO as memo,FHALF_MEMO_FLAG as memo_flag \
,chk_str_dtm,chk_end_dtm,single_colive_flag,gener_regtr_chk_flag \
,branch_cd,center_cd,special_etc, CHK_EMPID as user_id,'%s' as client_id from regtr_data where CHK_END_YN = 'S' "
, stUserinfo.szpda_ip , 0, 0 );

		callBackfunc = JO_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 312312;
		HTTP_UploadData  ( szUrl, "FR312312_IN",  "FR312312" , sndbuf, szDbpath, szSql);
		return 1;
	}
	
		
	long Snd312313(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312313, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);

		SPRINT( szSql, "select regtr_num,chk_plan_ym,safe_chk_type,regtr_not_pass_flag,regtr_not_pass_item \
,not_pass_photo_image,not_pass_better_ymd,correction_flag,EMP_ID AS user_id,'%s' AS client_id from regtr_nogood where SEND_YN = 'S' "
, stUserinfo.szpda_ip , 0, 0 );

		callBackfunc = JO_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 312313;			
		HTTP_UploadData  ( szUrl, "FR312313_IN",  "FR312313" , sndbuf, szDbpath, szSql);
		return 1;
	}
	
	
	long Snd312319(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312319, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);

		SPRINT( szSql, "select regtr_num,chk_plan_ym,safe_chk_type,mtr_id_num\
,mtr_num,regtr_resou_chg_sts,EMP_ID AS user_id,'%s' AS client_id from regtr_mrt where SEND_YN = 'S' "
,stUserinfo.szpda_ip , 0, 0 );

		callBackfunc = JO_DATASND; //통신완료 후에 호출 함수
		g_TRNUM = 312319;
		HTTP_UploadData  ( szUrl, "FR312319_IN",  "FR312319" , sndbuf, szDbpath, szSql);
		return 1;	
	}
	
	
	long Snd312320(void)
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
		Str_Cpy(szDirPath, PHOTO_JO );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);

		if(nRet > 0)
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312320, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "regtr_num", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_plan_ym", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "safe_chk_type", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 4, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "regtr_not_pass_flag", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 5, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "regtr_not_pass_item", szdata );
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));

				
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
			callBackfunc = JO_DATASND; //통신완료 후에 호출 함수
			g_TRNUM = 312320;				
			HTTP_DownloadData  ( szUrl, "FR312320_IN",  "FR312320" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "안전점검 결과 송신완료하였습니다.");
			REDRAW();
			ON_DRAW();
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



