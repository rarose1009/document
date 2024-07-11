/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_PHOTO
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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_BOJUNG		2

	char m_szfilenm[50];	 
	char m_szSql[500];
	char m_szTmp[400];
	char m_Title[30];
	char m_szPrevTitle[30];
	char m_szNextTitle[30];

	void SetBtnImg(void);
	void ReDraw(void);
	bool Validate(void);
	void Shoto_Photo(long ID);
	void Photo_View(long ID);
	void Delete_Photo(void);

	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_Title),
			
		DLG_BUTTON(STARTX,		STARTY+215, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVVIEW, "사진 보기"),
		DLG_BUTTON(STARTX+500,	STARTY+215, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPHOTO, "사진 촬영"),
		DLG_BUTTON(STARTX,		STARTY+495, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERVIEW, "사진 보기"),
		DLG_BUTTON(STARTX+500,	STARTY+495, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERPHOTO, "사진 촬영"),
		DLG_BUTTON(STARTX+600,	STARTY+600, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		DLG_TEXT(STARTX,			 STARTY+65, 1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1 , m_szPrevTitle),
		DLG_TEXT(STARTX,			STARTY+145,  500, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2 , "사진 유무"),
		DLG_TEXT(STARTX+500,		STARTY+145,  495, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX,			STARTY+350, 1000, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4 , m_szNextTitle),
		DLG_TEXT(STARTX,			STARTY+425,  500, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5 , "사진 유무"),
		DLG_TEXT(STARTX+500, 	  	STARTY+425,  495, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6 , ""),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, m_Title),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,		STARTY+120, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVVIEW, "사진 보기"),
		DLG_BUTTON(STARTX+500,	STARTY+120, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPHOTO, "사진 촬영"),
		DLG_BUTTON(STARTX,		STARTY+410, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERVIEW, "사진 보기"),
		DLG_BUTTON(STARTX+500,	STARTY+410, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERPHOTO, "사진 촬영"),
		DLG_BUTTON(STARTX+600,	STARTY+550, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),
		
		DLG_TEXT(STARTX,			 STARTY-40, 1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1 , m_szPrevTitle),
		DLG_TEXT(STARTX,			 STARTY+40, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2 , "사진 유무"),
		DLG_TEXT(STARTX+500,		 STARTY+40, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX,			STARTY+250, 1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4 , m_szNextTitle),
		DLG_TEXT(STARTX,			STARTY+330, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5 , "사진 유무"),
		DLG_TEXT(STARTX+500, 	  	STARTY+330, 500, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6 , ""),
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				
				SetBtnImg();
				ReDraw();
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

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_PREVPHOTO:
			case BID_AFTERPHOTO:
				Shoto_Photo(ID);
				break;
			case BID_PREVVIEW:
			case BID_AFTERVIEW:
				Photo_View(ID);
				break;
			case GID_PREV:
			case BID_OK:
//				2017-07-06 Sanghyun Lee
//				솔루션즈(현업) 요청으로 체크로직 제거. 교체 화면에서 '저장'버튼 누를시에만 체크 하도록.
//				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA3)), "N") == 0 &&
//				    Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA6)), "N") == 0 )
//				{
//					Card_Prev();
//				}
//				else if( Validate() )
//				{
//					g_DirFS_Clear(PHOTO_GC, "*.jpg");
//					Card_Prev();
//				}

				g_DirFS_Clear(PHOTO_GC, "*.jpg");
				
				//g_lChgMtr_WorkFlag > = 0 가정용 계량기, = 1 대용량 계량기, = 2 보정기
				if( g_lChgMtr_WorkFlag == 0 )
				{
					Card_Move("C6301_MTRCHG");
				}
				else if( g_lChgMtr_WorkFlag == 1 )
				{
					Card_Move("C6301_BIGCHG");
				}
				else if( g_lChgMtr_WorkFlag == 2 )
				{
					Card_Move("C6301_BOJUNGCHG");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_DirFS_Clear(PHOTO_GC, "*.jpg");
					g_Del_GcPhoto();
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_DirFS_Clear(PHOTO_GC, "*.jpg");
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
			case GID_VMEXIT:
				g_DirFS_Clear(PHOTO_GC, "*.jpg");
				g_Exit_DelGcData();
				break;
		}
	}
	
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		char szfilenm[256];

        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        
        if( g_nPhotoFlag == 7 )
        {
        	Str_Cpy(m_Title, "계량기 사진");
        	Str_Cpy(m_szPrevTitle, "철거 계량기");
        	Str_Cpy(m_szNextTitle, "설치 계량기");
        }
        else if( g_nPhotoFlag == 8 )
        {
        	Str_Cpy(m_Title, "보정기 사진");
        	
        	Str_Cpy(m_szPrevTitle, "철거 보정기");
        	Str_Cpy(m_szNextTitle, "설치 보정기");
        }
        
        //사진여부 확인해서 Y/N표시
		if( g_nPhotoFlag == 7 )
		{
			//철거계량기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "M");
			Str_Cat(szfilenm, "B");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.NOBILL_YN);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), BLUE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), RED);
			}
			
			//설치계량기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "M");
			Str_Cat(szfilenm, "A");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.NOBILL_YN);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), BLUE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), RED);
			}
		}
		else if( g_nPhotoFlag == 8 )
		{
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "C");
			Str_Cat(szfilenm, "B");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), BLUE);				
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), RED);
			}
			
			//설치계량기
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "C");
			Str_Cat(szfilenm, "A");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, "_");
			Str_Cat(szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), BLUE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), RED);
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
				
					//화면 REFRESH
					ReDraw();
				
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
					//PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
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
				ReDraw();
			}
		}

		ON_DRAW();
		return;
	}

//----------------------------------------------------------------------------------------------
/*
계량기교체		C31(업무구분) | M(계량기), C(보정기) | B(철거), A(설치) | M(계량기번호) | Y,N (무전표교체 유무)  | D( 생성날짜(SYSDATE : YYYYMMDDHHMMSS ) 
서버 저장 예시 : C31MBM302410422D20161129111620(계량기교체 철거 사진), C31CBM302410422D20161129111620(계량기교체 설치 사진)
클라이언트 저장 파일명 예시 : MBM302410422
*/
	void Shoto_Photo(long ID)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;

		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		if( g_nPhotoFlag == 7 )
		{
			Str_Cpy(m_szfilenm, "M");
		}
		else if( g_nPhotoFlag == 8 )
		{
			Str_Cpy(m_szfilenm, "C");
		}
		
		if( ID == BID_PREVPHOTO )
		{
			Str_Cat(m_szfilenm, "B");
		}
		else if( ID == BID_AFTERPHOTO )
		{
			Str_Cat(m_szfilenm, "A");
		}

		if( g_nPhotoFlag == 7 )
		{
			Str_Cat(m_szfilenm, "M");
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stMtrChg.NOBILL_YN);
			Str_Cat(m_szfilenm, ".jjp");
		}
		else if (g_nPhotoFlag == 8 )
		{
			Str_Cat(m_szfilenm, "M");
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(m_szfilenm, ".jjp");

		}

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
		//	//에뮬에서 확인시...
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
				
				//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
				
				//2017-08-18 Sanghyun Lee
				//카메라 화질 설정(photo_quality)	
				//"MEDIA_QUALITY_AUTO" ->> 에러 발생, 필요X
				//"MEDIA_QUALITY_LOWEST"
				//"MEDIA_QUALITY_LOW" ->> 선택되는 화질이 없음 , 필요X
				//"MEDIA_QUALITY_MEDIUM" ->> 현재 사용중인버전
				//"MEDIA_QUALITY_HIGH"
				//"MEDIA_QUALITY_HIGHEST"
				JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_MEDIUM");

				//g_szSqlWhere -> 사진에 주소 표시
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
	void Photo_View(long ID)
	{	
		char szTmp[256];
		char szViewnm[256];
		char szViewPath[256];
	
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)szViewnm, 0x00, sizeof(szViewnm));
		if( g_nPhotoFlag == 7 )
		{
			Str_Cat(m_szfilenm, "M");
		}
		else if( g_nPhotoFlag == 8 )
		{
			Str_Cat(m_szfilenm, "C");
		}
		
		if( ID == BID_PREVVIEW )
		{
			Str_Cat(m_szfilenm, "B");
		}
		else if( ID == BID_AFTERVIEW )
		{
			Str_Cat(m_szfilenm, "A");
		}
		if( g_nPhotoFlag == 7 )
		{
			Str_Cat(m_szfilenm, "M");
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stMtrChg.MTR_NUM);
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stMtrChg.NOBILL_YN);
		}
		else if (g_nPhotoFlag == 8 )
		{
			Str_Cat(m_szfilenm, "M");
			Str_Cat(m_szfilenm, "_");
			Str_Cat(m_szfilenm, stMtrChg.MTR_NUM);

		}
		
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


//----------------------------------------------------------------------------------------------
	bool Validate(void)
	{
		char szfilenm[128];
	
/*
계량기교체		C31(업무구분) | M(계량기), C(보정기) | B(철거), A(설치) | M(계량기번호) | D( 생성날짜(SYSDATE : YYYYMMDDHHMMSS )
서버 저장 예시 : C31MBM302410422D20161129111620(계량기교체 철거 사진), C31CBM302410422D20161129111620(계량기교체 설치 사진)
클라이언트 저장 파일명 예시 : MBM302410422
*/
		if( g_nPhotoFlag == 7 )
		{
			if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "10") == 0 || Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "30") == 0 )
			{
				//철거계량기
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "M");
				Str_Cat(szfilenm, "B");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.NOBILL_YN);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "계량기 사진을 촬영하세요.");
					return FALSE;
				}
	
				//설치계량기
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "M");
				Str_Cat(szfilenm, "A");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.NOBILL_YN);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_GC, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "계량기 사진을 촬영하세요.");
					return FALSE;
				}
			}
		}
		else if ( g_nPhotoFlag == 8 )
		{
			if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "30") == 0 )
			{
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
					MessageBoxEx (CONFIRM_OK, "보정기 사진을 촬영하세요.");
					return FALSE;
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
					MessageBoxEx (CONFIRM_OK, "보정기 사진을 촬영하세요.");
					return FALSE;
				}
			}
			else if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "20") == 0 )
			{
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
					MessageBoxEx (CONFIRM_OK, "보정기 사진을 촬영하세요.");
					return FALSE;
				}
	
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
					MessageBoxEx (CONFIRM_OK, "보정기 사진을 촬영하세요.");
					return FALSE;
				}
			}
		}


		return TRUE;
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
			if( g_nPhotoFlag == 7 )
			{
				//철거전 계량기
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "MBM");
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.NOBILL_YN);
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
				Str_Cpy(szfilenm, "MAM");				
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.NOBILL_YN);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
			}
			else if( g_nPhotoFlag == 8 )
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
		}
		
		return;
	}

}


