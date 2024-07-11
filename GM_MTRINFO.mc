/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : GM_MTRINFO
	Card Desc : 검침 계량기정보
	Card Hist :
----------------------------------------------------------------------------------*/
card GM_MTRINFO
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
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()

		// 화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		// 홈
		DEF_BUTTON_ID ( BID_MENU )		// 메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	// 키보드
		DEF_BUTTON_ID ( BID_SCREEN )	// 화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	// 공통업무
		DEF_BUTTON_ID ( BID_PREV )		// 이전
		DEF_BUTTON_ID ( BID_EXIT )		// 종료
		
		DEF_BUTTON_ID ( BID_OK )		// 확인
		DEF_BUTTON_ID ( BID_PHOTO )		// 사진촬영
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
	
		DEF_OBJECT_ID ( TXT_TITLE )		// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )	// 타이틀
		
		DEF_OBJECT_ID ( TXT_GRNUM )		// 계량기번호
		DEF_OBJECT_ID ( TXT_OBJNUM )	// 기물번호
		DEF_OBJECT_ID ( TXT_SUPSTATE )	// 공급상태
		DEF_OBJECT_ID ( TXT_GRADE )		// 등급
		DEF_OBJECT_ID ( TXT_FORM )		// 형식
		DEF_OBJECT_ID ( TXT_LOCATION )	// 위치
		DEF_OBJECT_ID ( TXT_GRCHNG )	// ◎계량기교체
		DEF_OBJECT_ID ( TXT_CHNGDATE )	// 교체일자
		DEF_OBJECT_ID ( TXT_CHNGGUID )	// 교체지침
		DEF_OBJECT_ID ( TXT_CHNGRSN )	// 교체사유
		
		DEF_OBJECT_ID ( TXT_DATA1 )		// 계량기번호
		DEF_OBJECT_ID ( TXT_DATA2 )		// 기물번호
		DEF_OBJECT_ID ( TXT_DATA3 )		// 공급상태
		DEF_OBJECT_ID ( TXT_DATA4 )		// 등급
		DEF_OBJECT_ID ( TXT_DATA5 )		// 형식
		DEF_OBJECT_ID ( TXT_DATA6 )		// 위치
		DEF_OBJECT_ID ( TXT_DATA7 )		// 교체일자
		DEF_OBJECT_ID ( TXT_DATA8 )		// 교체지침
		DEF_OBJECT_ID ( TXT_DATA9 )		// 교체사유
		
		DEF_OBJECT_ID ( LINE_DATA_1 )	// 라인_1
		DEF_OBJECT_ID ( LINE_DATA_2 )	// 라인_2
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	1 // Main
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_bFirst;
	char m_szfilenm[200];
	
	//---------------------------------------------------------------------------------------
	// Globla Function
	//---------------------------------------------------------------------------------------
	void SetStyle( void );
	void SetData( void );
	void REDRAW( void );
	void SetBtnImg( void );
	void Shoto_Photo( void );
	void FR26001( void );
	long TR26001( void );
	
	//---------------------------------------------------------------------------------------
	// Global Button
	//---------------------------------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] =
 	{
		SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD              , 0, 0          , 0          , OBJ_BUT, GID_HOME    , 0),
		SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD              , 0, 0          , 0          , OBJ_BUT, GID_KEYBOARD, 0),
		SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD              , 0, 0          , 0          , OBJ_BUT, GID_SCREEN  , 0),
		SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD              , 0, 0          , 0          , OBJ_BUT, GID_CMMNWK  , 0),
		SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD              , 0, 0          , 0          , OBJ_BUT, GID_VMEXIT  , 0),
		SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU    , 0),
		SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV    , 0),
	};
	
	//---------------------------------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),		
		DLG_ICON ( 0, BTNY_2, ICON_TITLE, "" ),
		DLG_TEXT ( TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "계량기 정보" ),
		
		DLG_TEXT ( STARTX     , STARTY +65 , 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GRNUM, "계량기번호" ),
		DLG_TEXT ( STARTX +300, STARTY +65 , 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, "" ),
		
		DLG_TEXT ( STARTX     , STARTY +125, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "기물번호" ),
		DLG_TEXT ( STARTX +300, STARTY +125, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, "" ),
		
		DLG_TEXT ( STARTX     , STARTY +185, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SUPSTATE, "공급상태" ),		
		DLG_TEXT ( STARTX +300, STARTY +185, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, "" ),
		
		DLG_TEXT ( STARTX     , STARTY +245, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GRADE, "등급" ),
		DLG_TEXT ( STARTX +300, STARTY +245, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, "" ),
		
		DLG_TEXT ( STARTX     , STARTY +305, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "형식" ),
		DLG_TEXT ( STARTX +300, STARTY +305, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		
		DLG_TEXT ( STARTX     , STARTY +365, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LOCATION, "위치" ),
		DLG_TEXT ( STARTX +300, STARTY +365, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "" ),
		
		DLG_LINE ( STARTX     , STARTY +429, 1000, STARTY +429, DARKSLATEBLUE, 10, LINE_DATA_1 ),
		
		DLG_TEXT ( STARTX     , STARTY +434, 350, 60, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_GRCHNG, "◎계량기교체" ),
		DLG_TEXT ( STARTX     , STARTY +494, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CHNGDATE, "교체일자" ),
		DLG_TEXT ( STARTX +300, STARTY +494, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "" ),
		
		DLG_TEXT ( STARTX     , STARTY +554, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CHNGGUID, "교체지침" ),
		DLG_TEXT ( STARTX +300, STARTY +554, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "" ),
		
		DLG_TEXT ( STARTX     , STARTY +614, 300, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CHNGRSN, "교체사유" ),
		DLG_TEXT ( STARTX +300, STARTY +614, 700, 60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, "" ),
		
		DLG_LINE ( STARTX     , STARTY +678, 1000, STARTY +678, DARKSLATEBLUE, 10, LINE_DATA_2 ),
		
		DLG_BUTTON(STARTX     , STARTY +683, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, YELLOW, CALL_FUNC , "", BID_PHOTO, "촬 영" ),
		DLG_BUTTON(STARTX +500, STARTY +683, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확 인" ),
	};	
	
	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : OnInit
	기  능 : 최초 시작
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit( char bFirst )
	{
		m_bFirst = bFirst;
		
		switch( bFirst )
		{
			case INIT_MAIN:
				
				CREATE_GLOBAL_BUTTON( SysButRes_MAIN );
				CREATE_DIALOG_OBJECT( DlgRes, SIZEOF(DlgRes) );
				
				SetBtnImg();
				SetStyle();
				REDRAW();
				
				break;
		}
		
		return;
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton( long ID )
	{	
		switch( ID )
		{					
			/******************************/
			/* 공통                       */
			/******************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					g_lDataflag = 0;
					Card_Move("MENU");
				}
				
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "검침 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					g_lDataflag = 0;
					Card_Move("GM_MENU");
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
				if( g_nGmType == 1 )
				{
					Card_Move("GM_REENTRY");
				}
				else
				{
					Card_Move("GM_ENTRY");
				}
								
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				
				break;
			
			/******************************/
			/* 일반                       */
			/******************************/
			// 확인
			case BID_OK:
				if( g_nGmType == 1 )
				{
					Card_Move("GM_REENTRY");
				}
				else
				{
					Card_Move("GM_ENTRY");
				}
				
				break;
			
			// 사진 촬영
			
			case BID_PHOTO:
				if( MessageBoxEx( CONFIRM_YESNO, "계량기 사진촬영을 하시겠습니까?" )  == MB_OK )
				{
					Shoto_Photo();
				}
				
				break;
			
		}
	}
	
	/*=======================================================================================
	함수명 : OnUart
	기  능 : 카메라
	Param  : 
	Return : 
	========================================================================================*/
	void OnUart( long nEvent, long nData )
	{
		char szfilenm[256];
		char szTmp[200];
		
		if( m_bFirst == INIT_MAIN )
		{
			if( nEvent == UART_CAMERA )
			{
				if( nData == 1 )
				{
					Mem_Set( (byte*)szfilenm, 0x00, sizeof(szfilenm) );
					SPRINT( szfilenm, "Camera/%s",  m_szfilenm,0, 0 );
					
					if( FFS_Exist(szfilenm) )
					{
						MessageBoxEx( MESSAGE, "사진을 저장중입니다." );
						
						FFS_Copy( szfilenm, g_szphoto );
						
						VmSleep( 100 );
						
						Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
						SPRINT( szTmp, "UPDATE GUMDATA SET PHOTO_MTR_YN = 'S' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
						g_Sql_DirectExecute( szTmp );
						
						Mem_Set( (byte*)stGm.PHOTO_MTR_YN, 0x00, sizeof(stGm.PHOTO_MTR_YN) );
						Str_Cpy( stGm.PHOTO_MTR_YN, "S" );
						
						FFS_Delete( szfilenm );
						
						VmSleep( 100 );
						
						FR26001();
					}
				}
			}
		}
		
		return;
	}
	
	//---------------------------------------------------------------------------------------
	// 일반 FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	함수명 : SetBtnImg
	기  능 : 버튼 이미지
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg( void )
	{
		void* h;
	
		IconCtrl_SetImage( Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			// 상단공통메뉴
			h = GetSysButHandle( GID_HOME );
			ButCtrl_SetImage( h, g_pImgHomeI );
			ButCtrl_SetActiveImage( h, g_pImgHomeA );
			
			h = GetSysButHandle( GID_KEYBOARD );
			ButCtrl_SetImage( h, g_pImgKeybrdI );
			ButCtrl_SetActiveImage( h, g_pImgKeybrdA );
			
			h = GetSysButHandle( GID_SCREEN );
			ButCtrl_SetImage( h, g_pImgScreenI );
			ButCtrl_SetActiveImage( h, g_pImgScreenA );
			
			h = GetSysButHandle( GID_CMMNWK );
			ButCtrl_SetImage( h, g_pImgCmmnwrkI );
			ButCtrl_SetActiveImage( h, g_pImgCmmnwrkA );
			
			h = GetSysButHandle( GID_VMEXIT );
			ButCtrl_SetImage( h, g_pImgExitI ) ;
			ButCtrl_SetActiveImage( h, g_pImgExitA );
		}
		
		return;
	}

	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle( void )
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GRNUM)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUPSTATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GRADE)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM)    , EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LOCATION), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GRCHNG)  , EDITALIGN_LEFT  |EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHNGDATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHNGGUID), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHNGRSN) , EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8)   , EDITALIGN_MIDDLE );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9)   , EDITALIGN_MIDDLE );
		
		return;
	}

	/*=======================================================================================
	함수명 : SetData
	기  능 : Data Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetData( void )
	{
		long i;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)&stGm, 0x00, sizeof(stGm) );

		sql->Open( sql );
		
		hdb = sql->Open( sql );
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nGmType == 1 )
		{
			hstmt = sql->CreateStatement( sql,
			" SELECT MTR_NUM, MTR_ID_NUM, SUPPLY_STS_CD, GRD_TITLE, MTR_FORM \
			       , MTR_LOC_FLAG, MTR_CHG_YMD, INDI_COMPENS_CIVIL_SERV_VC, MTR_REPL_WHY \
			    FROM REGUMDATA \
			   WHERE ROWID = ? \
			   ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE "
			);
 		}
 		else
 		{
 			hstmt = sql->CreateStatement( sql,
			" SELECT MTR_NUM, MTR_ID_NUM, SUPPLY_STS_CD, GRD_TITLE, MTR_FORM \
			       , MTR_LOC_FLAG, MTR_CHG_YMD, INDI_COMPENS_CIVIL_SERV_VC, MTR_REPL_WHY \
			    FROM GUMDATA \
			   WHERE ROWID = ? \
			   ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE "
			);
 		}
 		
		if( hstmt == NULL )
		{
			PRINT( "::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0 );
			goto Finally;
		}

		i = 0;

		sql->Bind( sql, i++, 'X', &g_lindex, 4, DECRYPT );

		if( sql->Execute(sql) == FALSE )
		{
			PRINT( "::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0 );
			goto Finally;
		}

		if( sql->Next(sql) == TRUE )
		{		
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_NUM   	 				, 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_ID_NUM      				, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SUPPLY_STS_CD   				, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.GRD_TITLE       				, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_FORM      				, 20 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_LOC_FLAG    				, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_CHG_YMD     				, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_COMPENS_CIVIL_SERV_VC   , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_REPL_WHY            		, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.HOUSE_NUM_ORD   				, 40 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.DONG_ORD        				, 40 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_COURSE      				, 5  + 1, DECRYPT );
		}
		
Finally:
		DelSqLite( sql );
		return;
	}
	
	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 새로고침
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW( void )
	{
		long i;
		char szDate[20];
		char szTmp[20];
		char szMtr_Num[10];
		
		// 계량기번호
		Mem_Set( (byte*)szMtr_Num, 0x00, sizeof(szMtr_Num) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		
		Mem_Cpy( (byte *)szMtr_Num, (byte *)stGm.MTR_NUM, 5 );
		Mem_Cpy( (byte *)szTmp, (byte *)stGm.MTR_NUM+5, 4 ) ;
		Str_Cat( szMtr_Num, "-" );
		Str_Cat( szMtr_Num, szTmp );
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), szMtr_Num );			
		
		// 기물번호  
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), stGm.MTR_ID_NUM );		
		
		// 공급상태
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), stGm.SUPPLY_STS_CD );
			
		// 등급
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), stGm.GRD_TITLE );
				     
		// 형식    
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), stGm.MTR_FORM );
		
		// 위치
		if( Str_Cmp(stGm.MTR_LOC_FLAG, "10") == 0 )  
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), "내부" ); 
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), "외부" );   
		}
		
		// 교체일자  
		if( Str_Cmp(stGm.MTR_CHG_YMD, "99991231") == 0 || Str_Cmp(stGm.MTR_CHG_YMD, "00000000") == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), "" );
		}
		else
		{
			Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
			g_Str_DateType( szDate, stGm.MTR_CHG_YMD );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), szDate );
		}
		
		// 교체지침
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), stGm.INDI_COMPENS_CIVIL_SERV_VC );
		
		// 교체사유
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), stGm.MTR_REPL_WHY );
		
		
		// 사진버튼
		if( Str_Cmp(stGm.PHOTO_MTR_YN, "Y") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO), RED );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR );
		}
		else if( Str_Cmp(stGm.PHOTO_MTR_YN, "S") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO), GREEN );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR );
		}
		else
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO), YELLOW );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO), TXTFRCOLOR );
		}
		
		
		return;
	}
	
	/*=======================================================================================
	함수명 : Shoto_Photo
	기  능 : 사진촬영
	Param  : 
	Return : 
	========================================================================================*/
	void Shoto_Photo( void )
	{
		char *pCamera;
		char sztmp[100];
		char sztmp2[100];
		char szDate[100];
		long nRet;
		
		handle h = NULL;
		handle hdata = NULL;
	
		// C47(코드) | M(계량기번호) | R(청구년월) | D(납기) | D(생성날짜(SYSDATE : YYYYMMDDHHMMSS))
		Mem_Set( (byte*)m_szfilenm, 0x00, sizeof(m_szfilenm) );
		Str_Cpy( m_szfilenm, stGm.MTR_NUM );
		Str_Cat( m_szfilenm, "_" );
		Str_Cat( m_szfilenm, stGm.REQ_YM );
		Str_Cat( m_szfilenm, "_" );
		Str_Cat( m_szfilenm, stGm.DEADLINE_FLAG );
		Str_Cat( m_szfilenm, ".jjp" );
		
		Mem_Set( (byte*)g_szphoto, 0x00, sizeof(g_szphoto) );
		SPRINT( g_szphoto, "%s/%s", PHOTO_GMMTR, m_szfilenm, 0 );
		
		ShootPhoto( 1, 0, m_szfilenm );

		// h = JSON_Create( JSON_Object );
		// 	if (h)
		// 	{
		// 		hdata = JSON_Create( JSON_Object );
		// 		if(hdata == NULL)
		// 		{
		// 			goto Finally;
		// 		}
				
		// 		//2017-08-18 Sanghyun Lee
		// 		//카메라 화질 설정(photo_quality)	
		// 		//"MEDIA_QUALITY_AUTO" ->> 에러 발생, 필요X
		// 		//"MEDIA_QUALITY_LOWEST"
		// 		//"MEDIA_QUALITY_LOW" ->> 선택되는 화질이 없음 , 필요X
		// 		//"MEDIA_QUALITY_MEDIUM" ->> 현재 사용중인버전
		// 		//"MEDIA_QUALITY_HIGH"
		// 		//"MEDIA_QUALITY_HIGHEST"
		// 		JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_HIGH");

		// 		//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
		// 		JSON_SetValue	(hdata	, 'C', "position_info"		, " ");
		// 		JSON_SetValue	(h		, 'C', "method"				, "CameraActivity");
				
		// 		JSON_Attach 	(h		, "data"					, hdata);
			
		// 		System_Call		("Native_System_Call" , JSON_toString(h));
		// 	}
			
		// 	Finally:
		
		// 	if (h)
		// 	{
		// 		JSON_Finalize(h);
		// 	}	
		
		// 	if (hdata)
		// 	{
		// 		JSON_Finalize(hdata);
		// 	}
		
		return;
	}
	
	/*=======================================================================================
	함수명 : FR26001
	기  능 : 사진 전송
	Param  : 
	Return : 
	========================================================================================*/
	void FR26001( void )
	{
		char szUrl[200];
		char szbuf[200];
		char sztmp[200];
		char szSql[200];
		char szScrPht[200];
		char* sndbuf;
		char* szfile = NULL;
		
		long filesize = 0;
		long ret = 0;
		long i, idx, fd;
		
		byte* signimg = NULL;
		
		handle file;
			
		// SERVER CONNECTION
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		// Json Setting
		g_pjcomm = g_CreateJsonHead( g_pjcomm, szUrl, 26001, FALSE );
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd"       , stUserinfo.szcenter_cd 	);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"	, stGm.USE_CONT_NUM 		);
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num"  , stGm.INST_PLACE_NUM		);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num"   		, stGm.MTR_NUM 				);
		JSON_SetValue( g_pjcomm, 'C', "req_ym"   		, stGm.REQ_YM 				);
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag"   , stGm.DEADLINE_FLAG 		);
		JSON_SetValue( g_pjcomm, 'C', "mtr_id_num"      , stGm.MTR_ID_NUM 			); 
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		
		SPRINT( szSql, "SELECT PARAM6 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 5, sztmp);

		if( Str_Cmp(sztmp, "" ) == 0 )
		{
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, "SELECT ZONE_MANAGE_NUM FROM GUMDATA LIMIT 1 ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 5, sztmp);
		}

		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num" , sztmp );

		// FILE Setting
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp, stGm.MTR_NUM );
		Str_Cat( sztmp, "_" );
		Str_Cat( sztmp, stGm.REQ_YM );
		Str_Cat( sztmp, "_" );
		Str_Cat( sztmp, stGm.DEADLINE_FLAG );
		Str_Cat( sztmp, ".jjp" );
		
		Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
		SPRINT( szScrPht, "%s/%s", PHOTO_GMMTR, sztmp, 0 );
		filesize = FFS_GetSize( szScrPht );
		
		if( filesize > 0 )
		{
			signimg = Mem_Alloc( filesize );
			
			fd = FFS_Open( szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)signimg, filesize );
			FFS_Close( fd );
	
			file = BASE64_Create();
			BASE64_Encode( file, signimg, filesize );
			szfile = BASE64_GetResult( file );	
			JSON_SetValue( g_pjcomm, 'C', "photo_mtr"   ,szfile );
			free( (byte*)signimg );
			BASE64_Finalize( file );
			file = NULL;
		}
		
		sndbuf = JSON_toString( g_pjcomm );
		
		g_SeverConnection();
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM( szbuf, SQLITE_DB );
		
		callBackfunc = TR26001;
		ret = HTTP_DownloadData( szUrl, "FR26001_IN", "FR26001", sndbuf, szbuf );
		
		return;
	}
	
	/*=======================================================================================
	함수명 : TR26001
	기  능 : FR26001 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR26001( void )
	{
		char szTmp[300];
		
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(26001) >= 0 )
		{	
			VmSleep( 100 );
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT( szTmp, "UPDATE GUMDATA SET PHOTO_MTR_YN = 'Y' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
			g_Sql_DirectExecute( szTmp ); 
			
			Mem_Set( (byte*)stGm.PHOTO_MTR_YN, 0x00, sizeof(stGm.PHOTO_MTR_YN) );
			Str_Cpy( stGm.PHOTO_MTR_YN, "Y" );
			
			FFS_Delete( g_szphoto );
			
			VmSleep( 100 );
			
			REDRAW();
			return 1;
		}
		else
		{
			REDRAW();
			return -1;
		}
	}
}
