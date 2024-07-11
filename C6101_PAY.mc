/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_PAY
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
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_PREVPHOTO )		//교체계량기 사진촬영
		DEF_BUTTON_ID ( BID_PREVVIEW   )	//교체계량기 사진보기
		DEF_BUTTON_ID ( BID_AFTERPHOTO  )	//설치계량기 사진촬영
		DEF_BUTTON_ID ( BID_AFTERVIEW )		//설치계량기 사진보기
		DEF_BUTTON_ID ( BID_OK )

	//교체소요비용
		DEF_BUTTON_ID ( BID_PAYOK )
		DEF_BUTTON_ID ( BID_REMOTEOK )
		DEF_BUTTON_ID ( BID_WRITE3 )		//입력창 바코드번호

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

		DEF_OBJECT_ID ( TXT_DATA57 )
		DEF_OBJECT_ID ( TXT_DATA58 )
		DEF_OBJECT_ID ( TXT_DATA59 )
		DEF_OBJECT_ID ( TXT_DATA60 )
		DEF_OBJECT_ID ( TXT_DATA61 )
		DEF_OBJECT_ID ( TXT_DATA62 )
		DEF_OBJECT_ID ( TXT_DATA63 )
		DEF_OBJECT_ID ( TXT_DATA64 )
		DEF_OBJECT_ID ( TXT_DATA65 )
		DEF_OBJECT_ID ( TXT_DATA66 )
		DEF_OBJECT_ID ( TXT_DATA67 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

		DEF_OBJECT_ID ( CMB_DATA13  )
		DEF_OBJECT_ID ( CMB_DATA14 = CMB_DATA13+3 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1

	char m_szfilenm[50];	 
	char m_szSql[500];
	char m_szTmp[400];
	char m_Title[30];
	char m_szPrevTitle[30];
	char m_szNextTitle[30];

	void SetBtnImg(void);
	void SetCombo(void);
	void ReDraw(void);
	bool Save_Pay(void);

	
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
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_Title),
		DLG_BUTTON(STARTX+600, STARTY+350, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PAYOK , "확 인"),
		
		DLG_TEXT(STARTX, 		 STARTY+65,  230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA57 , " 항 목 "),
		// DLG_TEXT(STARTX+230, 	 STARTY+65,  350, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA43 , "철거 계량기"),
		DLG_TEXT(STARTX+230, 	 STARTY+65,  770, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA58 , "소요비용"),
		DLG_TEXT(STARTX, 		 STARTY+115, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA59 , "배터리"),
		DLG_TEXT(STARTX, 		 STARTY+165, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA60 , "지시부"),
		// DLG_TEXT(STARTX, 		 STARTY+215, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA61 , "기타비용"),
		// DLG_TEXT(STARTX+230,     STARTY+215, 760, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA48, ""),
		// DLG_EDIT(STARTX+230, 	 STARTY+215, 760, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_AF_MTR_ID_NUM2,9, ""),
		
		DLG_COMBO(STARTX+230,  STARTY+115, 770, 50, 80, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA13, 15),
		DLG_COMBO(STARTX+230,  STARTY+165, 770, 50, 80, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA14, 15),

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
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, m_Title),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,		STARTY+115, 490, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVVIEW, "사진 보기"),
		DLG_BUTTON(STARTX+490,	STARTY+115, 503, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPHOTO, "사진 촬영"),
		DLG_BUTTON(STARTX,		STARTY+360, 490, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERVIEW, "사진 보기"),
		DLG_BUTTON(STARTX+490,	STARTY+360, 503, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERPHOTO, "사진 촬영"),
		DLG_BUTTON(STARTX+593,	STARTY+450, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		DLG_TEXT(STARTX,			STARTY-25,  993, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1 , m_szPrevTitle),
		DLG_TEXT(STARTX,			STARTY+45,  490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2 , "사진 유무"),
		DLG_TEXT(STARTX+490,		STARTY+45,  503, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX,			STARTY+220,  993, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4 , m_szNextTitle),
		DLG_TEXT(STARTX,			STARTY+290,  490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5 , "사진 유무"),
		DLG_TEXT(STARTX+490, 	  	STARTY+290,  503, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6 , ""),
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
			long i;
		
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
				SetCombo();
				SetBtnImg();
				ReDraw();
				break;
		}
	}

	void SetCombo(void)
	{
		long i;
		long lRet, lDate, lYear, lMonth;
		char szSql[300];
		char szDate[30];
		char szYear[20];
		char szYear2[20];
		char szMonth[20];
		char sztmp[30];
		
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		g_Sql_SetCombo("SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U'", CMB_DATA13+2);

		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		g_Sql_SetCombo("SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U'", CMB_DATA14+2);

	}
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case GID_PREV:
				Card_Prev();
				break;
			case BID_PAYOK:
				if( Save_Pay() )
				{
					Card_Prev();
				}
				break;
				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_DirFS_Clear(PHOTO_MW, "*.jpg");
					g_Del_GcPhoto();
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "업무 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_DirFS_Clear(PHOTO_MW, "*.jpg");
					g_Del_GcPhoto();
					Card_Move("C6101_MENU");
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
			case GID_VMEXIT:
				g_DirFS_Clear(PHOTO_MW, "*.jpg");
				g_Exit_DelGcData();
				break;
		}
	}
	
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		char szfilenm[256];
		
		long lCnt = 0;
		long i;

        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA57 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA58 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA59 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA60 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA61 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA62 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA63 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA64 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA65 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA66 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA67 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        
        Str_Cpy(m_Title, "교체소요비용");
		
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM = '%s' ", stChgMtr.battery_yn, 0, 0 );
		g_Sql_RetStr( m_szSql, 20, m_szTmp );		

		
		if( Str_Cmp(m_szTmp, "") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA13)   , "미설치");	
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA13)   , m_szTmp);	
			}

		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM = '%s' ", stChgMtr.mtrdisplay_yn, 0, 0 );
		g_Sql_RetStr( m_szSql, 20, m_szTmp );		
		
		
		if( Str_Cmp(m_szTmp, "") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA14)   , "미설치");	
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA14)   , m_szTmp);	
			}
		
		
		ON_DRAW();
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		long size = 0;
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				
				if( FFS_Exist(szfilenm)  )
				{
					size = FFS_GetSize( szfilenm );
					
					if( size > 1048576 )
					{
						MessageBoxEx (CONFIRM_OK, "사진 용량을 초과하였습니다.\n카메라 설정 혹은 재촬영해주세요.");
					}
					else
					{
						MessageBoxEx( MESSAGE, "사진을 저장중입니다." );
					
						FFS_Copy( szfilenm, g_szphoto );
						
						VmSleep( 100 );
					}
					
					VmSleep( 100 );
					
					FFS_Delete( szfilenm );
					
					VmSleep(100);
					
					// 화면 REFRESH
					ReDraw();
				}
			}
		}
		
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
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
//					PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
					//원본파일 +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_MW,  m_szfilenm, 0);
	
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
				ReDraw();
			}
		}

		ON_DRAW();
		return;
	}

bool Save_Pay(void)
	{
		long idx;
		long i;
		bool lRet = TRUE;

		SQLITE sql = NewSqLite();

		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA13))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "특수계량기 배터리 유무를 선택해주세요.");
			lRet = FALSE;
			goto Finally;
		}
		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA14))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "특수계량기 지시부 유무를 선택해주세요.");
			lRet = FALSE;
			goto Finally;
		}

		// // 배터리
		// i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA13)), C6301_BATTERY_YN );
		// Str_Cpy(stMtrChg.BATTERY_YN, C6301_BATTERY_YN[i].Code);
		// PRINT("C6301_BATTERY_YN[i].Code : %s",C6301_BATTERY_YN[i].Code,0,0);

		// i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA14)), C6301_MTRDISPLAY_YN );
		// Str_Cpy(stMtrChg.MTRDISPLAY_YN, C6301_MTRDISPLAY_YN[i].Code);
		// PRINT("stMtrChg.MTRDISPLAY_YN222222222222 : %s",stMtrChg.MTRDISPLAY_YN,0,0);

		// ;
		
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA13)), 0, 0 );
		g_Sql_RetStr( m_szSql, 20, stChgMtr.battery_yn );

		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA14)), 0, 0 );
		g_Sql_RetStr( m_szSql, 20, stChgMtr.mtrdisplay_yn );




Finally:

		DelSqLite(sql);
		return lRet;
	}



//----------------------------------------------------------------------------------------------

}


