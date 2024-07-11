/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_DATARCV
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
//	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		//지번
		DEF_BUTTON_ID ( BID_NADDR )		//도로명
		DEF_BUTTON_ID ( BID_DANJI )		//지번 단지
		DEF_BUTTON_ID ( BID_NEWROADNM )	//도로명
		DEF_BUTTON_ID ( BID_OLD )		//노후교체
		DEF_BUTTON_ID ( BID_MINWON )	//민원교체
		DEF_BUTTON_ID ( BID_REMARK )	//무전표교체
		DEF_BUTTON_ID ( BID_RCV )		//수신
	//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료
		DEF_BUTTON_ID ( BID_FROM )		
		DEF_BUTTON_ID ( BID_TO )		
		
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		
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



		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )

		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
				
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
				
		DEF_OBJECT_ID ( CMB_DATA1 ) 				//구
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 	//동
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 ) 	//단지
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 ) 	//도로명
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_NEW    2
	

	long m_lRcvFlag = 0;		//m_lRcvFlag = 0 데이터 모두 삭제 , m_lRcvFlag = 1 일부 데이터만 삭제
	long m_nSelectData = 0;		//m_nSelectData = 0 노후교체 , m_nSelectData = 1 민원교체
	long m_lQuickFlag = 0;		//m_lQuickFlag = 0 지번 단지, m_lQuickFlag = 1 도로명
	long m_lEditCtrlIndex = -1;

	char m_bFirst;
	char m_CmdArea[51];
	char m_CmdTown[51];
	
	char m_szArea[50];
	char m_szTown[50];
	char m_szCompxflagnm[50];
	char m_szNewroadnm[50];

	char m_szFromYmd[10];
	char m_szToYmd[10];

	long Sql_SetCombo(char* szSql, long CTRLID );
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void UPdate_Rcvlog(void);
	long Rcv_AddrData(void);
	long Rcv_Data(void);
	long TR75102(void);
	long TR75107(void);
	long RCV75108(void);
	long TR75108(void);
	void OnList(quad lParam);
	void QuickList(long nBtnID);

	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "계량기교체 대상수신"),

		DLG_BUTTON(STARTX,      STARTY+65, 300, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+300,  STARTY+65, 300, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+300, STARTY+500, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OLD, "노후교체"),
		DLG_BUTTON(STARTX+300, STARTY+570, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MINWON, "민원교체"),
		DLG_BUTTON(STARTX+300, STARTY+640, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REMARK, "무전표교체"),
		DLG_BUTTON(STARTX+600, STARTY+800, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "수 신"),
		
		DLG_TEXT(STARTX,     STARTY+140, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "구"),
		DLG_TEXT(STARTX,     STARTY+210, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "동"),
		DLG_TEXT(STARTX,     STARTY+280, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "단지"),
		DLG_TEXT(STARTX,     STARTY+210, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "도로명"),
		
		DLG_TEXT(STARTX,     STARTY+360, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "FROM"),
		DLG_EDIT(STARTX +300,STARTY+360, 185, 60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX +465,STARTY+360, 20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX +465,STARTY+370, 20,  40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, "."),
		DLG_EDIT(STARTX +485,STARTY+360, 155, 60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),		
		DLG_TEXT(STARTX +620,STARTY+360, 20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX +620,STARTY+370, 20,  40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, "."),
		DLG_EDIT(STARTX +640,STARTY+360, 135, 60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX +775, STARTY +360, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_FROM, "▼"),
		
		DLG_TEXT(STARTX,     STARTY+420, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "TO"),
		DLG_EDIT(STARTX +300,STARTY+420, 185, 60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX +465,STARTY+420, 20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX +465,STARTY+430, 20,  40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, "."),
		DLG_EDIT(STARTX +485,STARTY+420, 155, 60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 2,  ""),		
		DLG_TEXT(STARTX +620,STARTY+420, 20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX +620,STARTY+430, 20,  40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA19, "."),
		DLG_EDIT(STARTX +640,STARTY+420, 135,  60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_BUTTON(STARTX +775, STARTY +420, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_TO, "▼"),
		DLG_TEXT(STARTX,     STARTY+500, 300, 210, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "대상"),
		DLG_TEXT(STARTX,     STARTY+700, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "건수"),
		DLG_TEXT(STARTX+300, STARTY+700, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		DLG_COMBO (STARTX+300, STARTY+140, 700, 290, 145, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
		DLG_COMBO (STARTX+300, STARTY+210, 700, 290, 145, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),
		//DLG_COMBO (STARTX+300, STARTY+290, 675, 290, 120, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 30),
		//DLG_COMBO (STARTX+300, STARTY+220, 675, 290, 120, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
		
		DLG_TEXT(STARTX+300,   STARTY+280, 555, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_BUTTON(STARTX+855, STARTY+280, 145, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC , "", BID_DANJI, "▼"),

		DLG_TEXT(STARTX+300,   STARTY+210, 555, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_BUTTON(STARTX+855, STARTY+210, 145, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC , "", BID_NEWROADNM, "▼"),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "계량기교체 대상수신"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-40, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_BUTTON(STARTX+300,  STARTY-40, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "도로명"),
		DLG_BUTTON(STARTX+300, STARTY+280, 700, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OLD, "노후교체"),
		DLG_BUTTON(STARTX+300, STARTY+360, 700, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MINWON, "민원교체"),
		DLG_BUTTON(STARTX+600, STARTY+600, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "수 신"),
		
		DLG_TEXT(STARTX,      STARTY+40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "구"),
		DLG_TEXT(STARTX,     STARTY+120, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "동"),
		DLG_TEXT(STARTX,     STARTY+200, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "단지"),
		DLG_TEXT(STARTX,     STARTY+120, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "도로명"),
		DLG_TEXT(STARTX,     STARTY+280, 300, 160, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "대상"),
		DLG_TEXT(STARTX,     STARTY+440, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "건수"),
		DLG_TEXT(STARTX+300, STARTY+440, 700, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		DLG_COMBO (STARTX+300,  STARTY+40, 700, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
		DLG_COMBO (STARTX+300, STARTY+120, 700, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 30),
		DLG_COMBO (STARTX+300, STARTY+200, 700, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 30),
		DLG_COMBO (STARTX+300, STARTY+120, 700, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),
	};
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i, j;
		long lRowid;
		char szSql[150];
		char szRet[100];
		
		i = lParam;
		
		if( i >= 0 )
		{
			if( m_lQuickFlag == 0 )
			{
				j = lParam - 1;
			
				if( i == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), "전체" );
				}
				else
				{
					lRowid = g_SREACHFILE_GetSeq(SREACH_FILE, j);
					
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
					SPRINT(szSql, "SELECT COMPX_FLAG_NM FROM RCV_ADDR WHERE ROWID = '%d' GROUP BY COMPX_FLAG_NM", lRowid, 0, 0 );
					g_Sql_RetStr( szSql, 20, szRet );
					
					//PRINT("szRet : %s , lRowid : %d",szRet,lRowid,0);
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), szRet );
				}
			}
			else if( m_lQuickFlag == 1 )
			{
				j = lParam;
			
				lRowid = g_SREACHFILE_GetSeq(SREACH_FILE, j);

				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
				SPRINT(szSql, "SELECT NEW_ROAD_NM FROM RCV_ADDR WHERE ROWID = '%d' GROUP BY NEW_ROAD_NM", lRowid, 0, 0   );
				g_Sql_RetStr( szSql, 20, szRet );
				
				//PRINT("szRet : %s , lRowid : %d",szRet,lRowid,0);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), szRet );
			}
		}
		
		ON_DRAW();
		return;
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
				
				Mem_Set( (byte*)m_CmdArea, 0x00, sizeof(m_CmdArea) );
				Mem_Set( (byte*)m_CmdTown, 0x00, sizeof(m_CmdTown) );
				g_nAddrFlag = 0;
				SetBtnImg();				
				SetStyle();
				REDRAW();
				Rcv_AddrData();
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
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
		
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}


		if( m_nSelectData == 0 )
		{
			m_nSelectData = 0;
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REMARK), TRUE );
		}
		else if(m_nSelectData == 1 )
		{
			m_nSelectData = 1;
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REMARK), TRUE );
		}
		else if (m_nSelectData == 2)
		{
			m_nSelectData = 2;
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REMARK), FALSE );
		}
		
	}


//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long i;
		long index = -1;
		char szArea[51];
		char szTown[51];
		char szSql[256];

		if( g_nAddrFlag == 0 )
		{
			Mem_Set( (byte*)szArea, 0x00, sizeof(szArea) );
			Str_Cpy(szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
			Str_Cpy(szTown, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );

			if( Str_Cmp(m_CmdArea,  szArea ) != 0 )
			{
				ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA2+2));
				Mem_Set( (byte*)m_CmdArea, 0x00, sizeof(m_CmdArea) );
				Str_Cpy(m_CmdArea, szArea);
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT TOWN FROM RCV_ADDR WHERE AREA = '%s' AND RCV_YN = 'N' GROUP BY TOWN", m_CmdArea, 0, 0   );
				g_Sql_SetCombo(szSql, CMB_DATA2+2);

				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), "");
			}
			else if( Str_Cmp(m_CmdTown,  szTown ) != 0 )
			{
				if( theDevInfo.m_nType == FAMILY_PDA )
				{
					ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA3+2));
					Mem_Set( (byte*)m_CmdTown, 0x00, sizeof(m_CmdTown) );
					Str_Cpy(m_CmdTown, szTown);
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "SELECT COMPX_FLAG_NM FROM RCV_ADDR WHERE AREA = '%s' AND TOWN = '%s' AND RCV_YN = 'N' GROUP BY COMPX_FLAG_NM", m_CmdArea, m_CmdTown, 0   );
					Sql_SetCombo(szSql, CMB_DATA3+2);
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), "");
				}
				else
				{
					Mem_Set( (byte*)m_CmdTown, 0x00, sizeof(m_CmdTown) );
					Str_Cpy(m_CmdTown, szTown);
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "");
				}
			}
		}
		else
		{
			Mem_Set( (byte*)szArea, 0x00, sizeof(szArea) );
			Str_Cpy(szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
			if( Str_Cmp(m_CmdArea,  szArea ) != 0 )
			{
				if( theDevInfo.m_nType == FAMILY_PDA )
				{
					ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA4+2));
					Mem_Set( (byte*)m_CmdArea, 0x00, sizeof(m_CmdArea) );
					Str_Cpy(m_CmdArea, szArea);
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "SELECT NEW_ROAD_NM FROM RCV_ADDR WHERE AREA = '%s' AND RCV_YN = 'N' GROUP BY NEW_ROAD_NM", m_CmdArea, 0, 0   );
					g_Sql_SetCombo(szSql, CMB_DATA4+2);
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
				}
				else
				{
					Mem_Set( (byte*)m_CmdArea, 0x00, sizeof(m_CmdArea) );
					Str_Cpy(m_CmdArea, szArea);
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "");
				}
			}
		}
	}
			
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szFromDate[20];
		char szToDate[20];
		char szFromYear[5];
		char szFromMonth[3];
		char szFromDay[3];
		char szToYear[5];
		char szToMonth[3];
		char szToDay[3];
		long i, d,k;
		switch(ID)
		{	
			case BID_DANJI:
			case BID_NEWROADNM:
				QuickList(ID);
				break;						
			case BID_ADDR:
				if( g_nAddrFlag != 0 )
				{
					g_nAddrFlag = 0;
					REDRAW();
				}
				break;
			case BID_NADDR:
				if( g_nAddrFlag != 1 )
				{
					g_nAddrFlag = 1;
					REDRAW();
				}
				break;
			case BID_OLD:
				m_nSelectData = 0;
				
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REMARK), TRUE );
				REDRAW();
				break;
			case BID_MINWON:
				m_nSelectData = 1;
			
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REMARK), TRUE );
				REDRAW();
				break;

			case BID_REMARK:
			    m_nSelectData = 2;
			
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_OLD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MINWON), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REMARK), FALSE );
				REDRAW();
				break;

			case BID_RCV:
				Rcv_Data();
				break;

			case BID_FROM:
				
				Mem_Set((byte*)szFromDate, 0x00, sizeof(szFromDate));		
				Str_Cpy(szFromDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(szFromDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(szFromDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
				//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>szDate : %s",szDate,0,0);
				k = Str_AtoI(szFromDate);

				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{	
					Mem_Set((byte*)szFromDate, 0x00, sizeof(szFromDate));
					Str_ItoA(d,m_szFromYmd, 10);
					// PRINT("m_szFromYmd : %s",m_szFromYmd,0,0);
					Mem_Set((byte*)szFromYear, 0x00, sizeof(szFromYear));
					Mem_Set((byte*)szFromMonth, 0x00, sizeof(szFromMonth));
					Mem_Set((byte*)szFromDay, 0x00, sizeof(szFromDay));

					Mem_Cpy((byte *)szFromYear, (byte *)m_szFromYmd, 4);
					Mem_Cpy((byte *)szFromMonth, (byte *)m_szFromYmd+4, 2);
					Mem_Cpy((byte *)szFromDay, (byte *)m_szFromYmd+6, 2);
					
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szFromYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szFromMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szFromDay );
					
					//Str_Cpy(stBs.PERIOD_CHK_YMD, szDate);
					//g_Str_DateType(szDate, szDate);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), szDate );
				}
				break;
			case BID_TO:

				Mem_Set((byte*)szToDate, 0x00, sizeof(szToDate));		
				Str_Cpy(szToDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
				Str_Cat(szToDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				Str_Cat(szToDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
				//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>szDate : %s",szDate,0,0);
				k = Str_AtoI(szToDate);

				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{	
					Mem_Set((byte*)szToDate, 0x00, sizeof(szToDate));
					Str_ItoA(d,m_szToYmd, 10);
					// PRINT("m_szToYmd : %s",m_szToYmd,0,0);
					// PRINT("m_szFromYmdCCCCCCCCCCCCCCCCC : %s",m_szFromYmd,0,0);
					Mem_Set((byte*)szToYear, 0x00, sizeof(szToYear));
					Mem_Set((byte*)szToMonth, 0x00, sizeof(szToMonth));
					Mem_Set((byte*)szToDay, 0x00, sizeof(szToDay));
					Mem_Cpy((byte *)szToYear, (byte *)m_szToYmd, 4);
					Mem_Cpy((byte *)szToMonth, (byte *)m_szToYmd+4, 2);
					Mem_Cpy((byte *)szToDay, (byte *)m_szToYmd+6, 2);
					
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szToYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szToMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szToDay );
					
					//Str_Cpy(stBs.PERIOD_CHK_YMD, szDate);
					//g_Str_DateType(szDate, szDate);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), szDate );
				}
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "계량기교체 메뉴로\n나가시겠습니까?")  == MB_OK)
				{
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
				Card_Move("C6301_DMMENU");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;
				g_Exit();
				break;
		}
	}

void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];

		//숫자만 입력 가능
		if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex 
		|| Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex
		|| Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
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
			}
			else
			{
				Str_Cpy(m_szFromYmd, szTmp);
			}
		}

		ON_DRAW();
		return;
	}
//---------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szDate[15];
		char szFromYear[5];
		char szFromMonth[3];
		char szFromDay[3];
		char szToYear[5];
		char szToMonth[3];
		char szToDay[3];

		if( g_nAddrFlag == 0 )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );

			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA3), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), FALSE);

			ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA2+2));
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");

			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA3+2));
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), "");
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), FALSE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "");
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA8), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DANJI), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA9), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_NEWROADNM), FALSE);
			}
		
			//민원교체 선택 시 , 입력 버튼 비활성화
			if( m_nSelectData == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), FALSE );

				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_FROM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_FROM), FALSE );
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TO), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TO), FALSE );

	
				if( theDevInfo.m_nType == FAMILY_PDA )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), FALSE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DANJI), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DANJI), FALSE );
				}
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), TRUE );
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_FROM), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_FROM), TRUE );
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TO), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TO), TRUE );
				
				
	
				if( theDevInfo.m_nType == FAMILY_PDA )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), TRUE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DANJI), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DANJI), TRUE );
				}
			}

		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "");
		
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );

			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA3), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE);

			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA4+2));
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), TRUE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "");
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA8), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_DANJI), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA9), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_NEWROADNM), TRUE);
			}

			//민원교체 선택 시 , 입력 버튼 비활성화
			if( m_nSelectData == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
	
				if( theDevInfo.m_nType == FAMILY_PDA )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), FALSE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_NEWROADNM), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NEWROADNM), FALSE );
				}
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA1+1), TRUE );
	
				if( theDevInfo.m_nType == FAMILY_PDA )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), TRUE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_NEWROADNM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NEWROADNM), TRUE );
				}
			}
		}

		Mem_Set((byte*)szFromYear, 0x00, sizeof(szFromYear));
		Mem_Set((byte*)szFromMonth, 0x00, sizeof(szFromMonth));
		Mem_Set((byte*)szFromDay, 0x00, sizeof(szFromDay));
		Mem_Cpy((byte *)szFromYear, (byte *)m_szFromYmd, 4);
		Mem_Cpy((byte *)szFromMonth, (byte *)m_szFromYmd+4, 2);
		Mem_Cpy((byte *)szFromDay, (byte *)m_szFromYmd+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szFromYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szFromMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szFromDay );	

		Mem_Set((byte*)szToYear, 0x00, sizeof(szToYear));
		Mem_Set((byte*)szToMonth, 0x00, sizeof(szToMonth));
		Mem_Set((byte*)szToDay, 0x00, sizeof(szToDay));
		Mem_Cpy((byte *)szToYear, (byte *)m_szToYmd, 4);
		Mem_Cpy((byte *)szToMonth, (byte *)m_szToYmd+4, 2);
		Mem_Cpy((byte *)szToDay, (byte *)m_szToYmd+6, 2);

		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szToYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szToMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szToDay );	
		
		ON_DRAW();
		return;
	}
	
//---------------------------------------------------------------------------------------------
	long Rcv_AddrData(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_ADDR");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75107, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR75107; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR75107_IN",  "FR75107" , sndbuf, sztmp );
		return 0 ;
	}

//---------------------------------------------------------------------------------------------
	long TR75107(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(75107) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM RCV_ADDR", &ntotcnt);
			
			if(ntotcnt > 0 )
			{
				g_Sql_DirectExecute("UPDATE RCV_ADDR SET RCV_YN = 'N'");

				ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA1+2));
				g_Sql_SetCombo("SELECT AREA FROM RCV_ADDR GROUP BY AREA", CMB_DATA1+2);
				MessageBoxEx (CONFIRM_OK, "구, 동, 단지 자료수신 완료.");
				ON_DRAW();
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "오늘 생성된 자료가 없습니다.");
				ON_DRAW();
				return 1;	
			}
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
//---------------------------------------------------------------------------------------------
	long Rcv_Data(void)
	{
		char sztmp[32];
		char szUarea[50];
		char szUtown[50];
		char szUcompxflagnm[50];
		char szNewroadnm[50];
		char szUrl[256];
		char szSql[256];
		char szFromYmd[10];
		char szToYmd[10];
		char* sndbuf;
		long ret;
		long ntotcnt = 0;
		long nSndcnt = 0;
		
		g_Sql_RetInt("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'S' ", &ntotcnt);
		
		if( ntotcnt > 0   )
		{
			MessageBoxEx (CONFIRM_OK, "미송신 자료가 있습니다, 송신 후 수신받으세요.");
			return -1;
		}
		
		//m_nSelectData = 0 노후교체 , m_nSelectData = 1 민원교체 , m_nSelectData = 2 무전표 교체	
		//g_nAddrFlag = 0 지번, g_nAddrFlag = 1 도로명
		if( m_nSelectData == 0 )
		{
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_DATA1) ) == 0)
			{
				MessageBoxEx (CONFIRM_OK, "구를 선택하세요.");
				return -1;
			}
			
			if( g_nAddrFlag == 0 )
			{
				if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_DATA2) ) == 0)
				{
					MessageBoxEx (CONFIRM_OK, "동을 선택하세요.");
					return -1;
				}
			}
			else
			{
				if( theDevInfo.m_nType == FAMILY_PDA )
				{

					if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_DATA4) ) == 0)
					{
						MessageBoxEx (CONFIRM_OK, "도로명을 선택하세요.");
						return -1;
					}
				}
				else
				{
					if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_DATA9) ) == 0)
					{
						MessageBoxEx (CONFIRM_OK, "도로명을 선택하세요.");
						return -1;
					}
				}
			}
			// PRINT("m_szToYmd111111 :%s",m_szToYmd,0,0 );
			// PRINT("m_szFromYmd2222 :%s",m_szFromYmd,0,0 );
			
		}
		
		//구
		Mem_Set((byte*)m_szArea, 0x00, sizeof(m_szArea));
		Mem_Set((byte*)szUarea, 0x00, sizeof(szUarea));
		Str_Cpy( m_szArea, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)) );
		SQL_ConvUcStr( szUarea, m_szArea );

		//동
		Mem_Set((byte*)m_szTown, 0x00, sizeof(m_szTown));
		Mem_Set((byte*)szUtown, 0x00, sizeof(szUtown));
		Str_Cpy( m_szTown, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2)) );
		SQL_ConvUcStr( szUtown, m_szTown );

		//단지
		Mem_Set((byte*)m_szCompxflagnm, 0x00, sizeof(m_szCompxflagnm));
		Mem_Set((byte*)szUcompxflagnm, 0x00, sizeof(szUcompxflagnm));
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Str_Cpy( m_szCompxflagnm, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA3)) );
		}
		else
		{
			Str_Cpy( m_szCompxflagnm, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA8)) );
		}
		SQL_ConvUcStr( szUcompxflagnm, m_szCompxflagnm );


		//도로명
		Mem_Set((byte*)m_szNewroadnm, 0x00, sizeof(m_szNewroadnm));
		Mem_Set((byte*)szNewroadnm, 0x00, sizeof(szNewroadnm));
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Str_Cpy( m_szNewroadnm, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA4)) );
		}
		else
		{
			Str_Cpy( m_szNewroadnm, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA9)) );
		}
		SQL_ConvUcStr( szNewroadnm, m_szNewroadnm );

		//FROM 
		Mem_Set((byte*)m_szFromYmd, 0x00, sizeof(m_szFromYmd));
		Mem_Set((byte*)szFromYmd, 0x00, sizeof(szFromYmd));
		
		Str_Cpy( m_szFromYmd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA1)) );
		Str_Cat( m_szFromYmd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA2)) );
		// Str_Cat( m_szFromYmd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA3)) );
		
		SQL_ConvUcStr( szFromYmd, m_szFromYmd );

		// PRINT("3333333333333333333333 :%s",m_szFromYmd,0,0);
		// PRINT("AAAAAAAAAAAAAAAAAAAAAA :%s",szFromYmd,0,0);

		//TO
		// Mem_Set((byte*)m_szToYmd, 0x00, sizeof(m_szToYmd));
		// Mem_Set((byte*)szToYmd, 0x00, sizeof(szToYmd));
		// SQL_ConvUcStr( szToYmd, m_szToYmd );

		Mem_Set((byte*)m_szToYmd, 0x00, sizeof(m_szToYmd));
		Mem_Set((byte*)szToYmd, 0x00, sizeof(szToYmd));

		Str_Cpy( m_szToYmd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA4)) );
		Str_Cat( m_szToYmd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA5)) );
		// Str_Cat( m_szToYmd, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_DATA6)) );
		SQL_ConvUcStr( szToYmd, m_szToYmd );

		// if( szFromYmd > szToYmd)
		// {	
		// 	PRINT("m_szToYmd333333 :%s",szFromYmd,0,0 );
		// 	PRINT("m_szFromYmd4444 :%s",szToYmd,0,0 );
		// 	MessageBoxEx (CONFIRM_OK, "날짜 설정이 잘못되었습니다.");
		// 	return -1;
		// }

		if(  MessageBoxEx (CONFIRM_YESNO, "계량기교체 자료를\n수신받으시겠습니까?")  == MB_OK )
		{
			if( m_lRcvFlag == 0 )
			{
				// = 0 민원/노후 데이터 모두 삭제, = 1 주소 데이터 연속 수신 가능?? 덮어쓰기 가능??
				m_lRcvFlag = 1;
				
				if( m_nSelectData == 0 )
				{
					g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10'");
					g_Sql_DirectExecute("DELETE FROM C6301_OLDMTRIDNUM");
				}
				//민원교체 1
				else if(m_nSelectData == 1)
				{
					g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND NOBILL_YN ='N'");
					g_Sql_DirectExecute("DELETE FROM C6301_OLDMTRIDNUM");
				}
				//무전표교체 2
				else if(m_nSelectData == 2)
				{
					g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND NOBILL_YN ='Y'");
					g_Sql_DirectExecute("DELETE FROM C6301_OLDMTRIDNUM");
				}
				//무전표 교체 2 추가해야함.
			}
			else
			{
				//수신 받기전 데이터 삭제
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_ItoA(Time_GetDate(), sztmp, 10);
				SPRINT(szSql,"SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'Y' OR OBJ_CRT_YMD != '%s'",sztmp,0,0);
				g_Sql_RetInt(szSql, &nSndcnt);
				
				if( nSndcnt > 0 )
				{
					if( m_nSelectData == 0 )
					{
						g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10'");
					}
					//민원교체 1
					else if(m_nSelectData == 1)
					{
						g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20'");
					}
					else if(m_nSelectData == 2)
					{
						g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '30'");
					}
					//무전표 교체 2 추가해야함.
				}
			}

			//보정기
			g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE PDA_REPL_JOB_ITEM = '20'");
			//대용량
			g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA WHERE PDA_REPL_JOB_ITEM != '20' AND CAST(MTR_GRD AS INTEGER) >= 10");
		}
		else
		{
			return -1;
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75102, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "area",    szUarea);
		JSON_SetValue( g_pjcomm, 'C', "town",    szUtown);
		JSON_SetValue( g_pjcomm, 'C', "fromYmd",    szFromYmd);
		JSON_SetValue( g_pjcomm, 'C', "toYmd"  ,    szToYmd);
		
		if( Str_Cmp(m_szCompxflagnm, "전체") == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "compx_flag_nm",    "");
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "compx_flag_nm",    szUcompxflagnm);
		}
		
		JSON_SetValue( g_pjcomm, 'C', "new_road_nm",    szNewroadnm);
		
		if( m_nSelectData == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "repl_occu_flag",    "10");
		}
		else if(m_nSelectData == 1)//민원교체
		{	
			JSON_SetValue( g_pjcomm, 'C', "repl_occu_flag",    "20");
		}
		else if(m_nSelectData == 2)//무전표교체
		{
			JSON_SetValue( g_pjcomm, 'C', "repl_occu_flag",    "30");
		}
		//무전표 교체
				
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR75102; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR75102_IN",  "FR75102" , sndbuf, sztmp );
		return 0 ;
	}
	
//---------------------------------------------------------------------------------------------
	long TR75102(void)
	{
		long ntotcnt = 0;
		char szSql[500];
		char szMsg[128];
		char szTmp[10];
		
		g_Sock_Close();
		ntotcnt = g_Chk_Json(75102);
		
		if(ntotcnt >= 0)
		{
			UPdate_Rcvlog();
			// PRINT("44444444444444444444",0,0,0);
			// RCV75108();

			if(ntotcnt > 0 )
			{
				g_Sql_DirectExecute("UPDATE C6301_CHANGEDATA SET SEND_YN = 'N'");

				if( g_nAddrFlag == 0 )
				{
					if( Str_Len(m_szCompxflagnm) == 0 || Str_Cmp(m_szCompxflagnm, "전체") == 0 )
					{
						Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
						SPRINT(szSql, "UPDATE RCV_ADDR SET RCV_YN = 'Y' WHERE AREA = '%s' AND TOWN = '%s'",m_szArea,m_szTown,0);
						g_Sql_DirectExecute(szSql);		//N : 수신 안 받음, Y : 수신 받음
					}
					else
					{
						Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
						SPRINT(szSql, "UPDATE RCV_ADDR SET RCV_YN = 'Y' WHERE AREA = '%s' AND TOWN = '%s' AND COMPX_FLAG_NM = '%s'",m_szArea,m_szTown,m_szCompxflagnm);
						g_Sql_DirectExecute(szSql);		//N : 수신 안 받음, Y : 수신 받음
					}
					
					ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA1+2));
					g_Sql_SetCombo("SELECT AREA FROM RCV_ADDR WHERE RCV_YN = 'N' GROUP BY AREA", CMB_DATA1+2);
					
					ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA2+2));
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "SELECT TOWN FROM RCV_ADDR WHERE AREA = '%s' AND RCV_YN = 'N' GROUP BY TOWN", m_szArea, 0, 0   );
					g_Sql_SetCombo(szSql, CMB_DATA2+2);
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
					
					if( theDevInfo.m_nType == FAMILY_PDA )
					{
						ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA3+2));
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						SPRINT(szSql, "SELECT COMPX_FLAG_NM FROM RCV_ADDR WHERE AREA = '%s' AND TOWN = '%s' AND RCV_YN = 'N' GROUP BY COMPX_FLAG_NM", m_szArea, m_szTown, 0   );
						Sql_SetCombo(szSql, CMB_DATA3+2);
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), "");
					}
					else
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "");
					}
				}
				else
				{
					Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
					SPRINT(szSql, "UPDATE RCV_ADDR SET RCV_YN = 'Y' WHERE AREA = '%s' AND NEW_ROAD_NM = '%s'",m_szArea,m_szNewroadnm,0);
					g_Sql_DirectExecute(szSql);		//N : 수신 안 받음, Y : 수신 받음

					if( theDevInfo.m_nType == FAMILY_PDA )
					{
						ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA4+2));
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						SPRINT(szSql, "SELECT NEW_ROAD_NM FROM RCV_ADDR WHERE AREA = '%s' AND RCV_YN = 'N' GROUP BY NEW_ROAD_NM", m_szArea, 0, 0   );
						g_Sql_SetCombo(szSql, CMB_DATA4+2);
						
						EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
					}
					else
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "");
					}
				}

				Mem_Set((byte*)szMsg ,0x00, sizeof(szMsg) );
				SPRINT(szMsg, " %d건 수신 받았습니다. ", ntotcnt, 0, 0);
				MessageBoxEx (CONFIRM_OK, szMsg);
				
				Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
				Str_ItoA(ntotcnt, szTmp, 10);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), szTmp);
				
				ON_DRAW();
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "자료가 없습니다.\n확인해 주세요.");
				ON_DRAW();
				return 1;	
			}
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

	long RCV75108(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75108, FALSE);
		
		// JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		// JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		// JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		// JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
		// JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		// JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		// callBackfunc = TR75108; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR75108_IN",  "FR75108" , sndbuf, sztmp );
		return 0 ;
	}


//---------------------------------------------------------------------------------------------
	void UPdate_Rcvlog(void)
	{
		long i=0, tot = 0, ret=0;
		long idx;
		char szSql[400];
		char sztoday[9];
		char szPARAM1[20];
		char szPARAM2[20];
		char szPARAM3[20];
		char szPARAM4[5];
		char szPARAM7[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*) sztoday, 0x00, sizeof( sztoday) );
		Str_ItoA( Time_GetDate(), sztoday, 10);	

		Mem_Set( (byte*) szPARAM1, 0x00, sizeof( szPARAM1) );
		Mem_Set( (byte*) szPARAM2, 0x00, sizeof( szPARAM2) );
		Mem_Set( (byte*) szPARAM3, 0x00, sizeof( szPARAM3) );
		Mem_Set( (byte*) szPARAM4, 0x00, sizeof( szPARAM4) );
		Mem_Set( (byte*) szPARAM7, 0x00, sizeof( szPARAM7) );
		Str_Cpy( szPARAM1, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1)) );      //구
		
		if( g_nAddrFlag == 0 )
		{
			Str_Cpy( szPARAM2, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2)) );      //동
			//단지
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				if(Str_Cmp("전체", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA3)) ) == 0)
				{
					
					Str_Cpy (szPARAM3, "%" );
				}
				else
				{
					Str_Cpy (szPARAM3, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA3)) ); //gmtr_base_day
				}
			}
			else
			{
				if(Str_Cmp("전체", EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA8)) ) == 0)
				{
					
					Str_Cpy (szPARAM3, "%" );
				}
				else
				{
					Str_Cpy (szPARAM3, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA8)) ); //gmtr_base_day
				}
			}
		}
		else
		{
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				Str_Cpy( szPARAM2, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA4)) );      //도로명
			}
			else
			{
				Str_Cpy( szPARAM2, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA9)) );      //도로명
			}
		}

		if( m_nSelectData == 0 )
		{
			Str_Cpy(szPARAM4, "10");
		}
		else if (m_nSelectData == 1)
		{	
			Str_Cpy(szPARAM4, "20");
		}
		else if (m_nSelectData == 2)
		{
			Str_Cpy(szPARAM4, "30");
		}
		
		Str_ItoA(Time_GetDate(), szPARAM7, 10);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '8' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,PARAM7, PARAM8, PARAM9, PARAM10, PARAM11) VALUES ('8', ?, ?, ?, ?, ?, ?, 0, 0, 0, 0) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1=?, PARAM2=?, PARAM3=?, PARAM4=?, PARAM5=?, PARAM7=?, PARAM8=0, PARAM9=0, PARAM10=0, PARAM11=0 WHERE GUBUN = '8' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)szPARAM1, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM2, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM3, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM4,  5, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szcenter_cd, 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szPARAM7,  10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)sztoday,   8, DECRYPT);
		
		sql->Begin(sql);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;		
	}

//---------------------------------------------------------------------------------------------
	long Sql_SetCombo(char* szSql, long CTRLID )
	{
	long ret = -1;
	char szBuf[101];
	long cnt  = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		sql->Begin(sql);
		
		ret = sql->Execute(sql);
		
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CTRLID), "전체", 0, ICON_NONE);
		cnt = 0;
		while(sql->Next(sql) == TRUE)
		{
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)szBuf, sizeof(szBuf), DECRYPT );
			ListCtrl_AddItem (Get_hDlgCtrlByID(CTRLID), szBuf, 0, ICON_NONE);
			cnt++;
			if(cnt == 100)
				break;
		}
		
Finally:
		if(sql != NULL)
			sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//---------------------------------------------------------------------------------------------------------------
	void QuickList(long nBtnID)
	{
		handle js = NULL;
		char szTitle[50];
		char szSql[500];
		char szSqlSeq[500];
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}

		Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set((byte*)szTitle, 0x00, sizeof(szTitle) );
		if( nBtnID == BID_DANJI )
		{
			m_lQuickFlag = 0;
			Str_Cpy(szTitle, "지번 단지");
			
			Mem_Set((byte*)m_szArea, 0x00, sizeof(m_szArea) );
			Mem_Set((byte*)m_szTown, 0x00, sizeof(m_szTown) );
			Str_Cpy(m_szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
			Str_Cpy(m_szTown, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );

			Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT  COMPX_FLAG_NM1 AS COMPX_FLAG_NM, COMPX_FLAG_NM2 AS COMPX_FLAG_NM \
							FROM ( \
							SELECT '1' AS SORT, '전체' AS COMPX_FLAG_NM1,'전체' AS COMPX_FLAG_NM2 \
							UNION \
							SELECT '2' AS SORT, COMPX_FLAG_NM AS COMPX_FLAG_NM1 , COMPX_FLAG_NM AS COMPX_FLAG_NM2 \
							FROM RCV_ADDR \
							WHERE AREA = '%s' AND TOWN = '%s' AND RCV_YN = 'N' \
							GROUP BY SORT, COMPX_FLAG_NM ) "
							, m_szArea, m_szTown, 0);
			
			Mem_Set((byte*)szSqlSeq, 0x00, sizeof(szSqlSeq) );
			SPRINT(szSqlSeq, "SELECT ROWID FROM RCV_ADDR WHERE AREA = '%s' AND TOWN = '%s' AND RCV_YN = 'N' GROUP BY COMPX_FLAG_NM", m_szArea, m_szTown, 0);
			g_Sql_SaveSeq( szSqlSeq, SREACH_FILE);
		}
		else if( nBtnID == BID_NEWROADNM )
		{
			m_lQuickFlag = 1;
			Str_Cpy(szTitle, "도로명");
			
			Mem_Set((byte*)m_szArea, 0x00, sizeof(m_szArea) );
			Str_Cpy(m_szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
			SPRINT(szSql, "SELECT NEW_ROAD_NM,NEW_ROAD_NM FROM RCV_ADDR WHERE AREA = '%s' AND RCV_YN = 'N' GROUP BY NEW_ROAD_NM", m_szArea, 0, 0);
/*
			SPRINT(szSql, "SELECT  NEW_ROAD_NM1 AS NEW_ROAD_NM, NEW_ROAD_NM2 AS NEW_ROAD_NM \
							FROM ( \
							SELECT '1' AS SORT, '전체' AS NEW_ROAD_NM1,'전체' AS NEW_ROAD_NM2 \
							UNION \
							SELECT '2' AS SORT, NEW_ROAD_NM AS NEW_ROAD_NM1 , NEW_ROAD_NM AS NEW_ROAD_NM2 \
							FROM RCV_ADDR \
							WHERE AREA = '%s' \
							GROUP BY SORT, NEW_ROAD_NM ) "
							, m_szArea, 0, 0);
*/
			Mem_Set((byte*)szSqlSeq, 0x00, sizeof(szSqlSeq) );
			SPRINT(szSqlSeq, "SELECT ROWID FROM RCV_ADDR WHERE AREA = '%s' AND RCV_YN = 'N' GROUP BY NEW_ROAD_NM", m_szArea, 0, 0);
			g_Sql_SaveSeq( szSqlSeq, SREACH_FILE);
		}

		JSON_SetValue ( js, 'C', "title", szTitle);
		JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
		JSON_SetValue ( js, 'C', "query", szSql);

		sztmp = JSON_toString(js);
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return;
	}
}
