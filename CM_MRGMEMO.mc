/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MRGMEMO
	Card Desc : 공통 메모
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MRGMEMO
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

	#define CHK_N1	   "□"
	#define CHK_N2	   "▣"
	

	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_WRITE )		// 입력
		DEF_BUTTON_ID ( BID_DEL )		// 메모삭제
		DEF_BUTTON_ID ( BID_CANCEL )	// 취소	
		DEF_BUTTON_ID ( BID_SAVE )		// 메모저장
		DEF_BUTTON_ID ( BID_VISIBLE_N )		// 메모저장
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE ) 	// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )	// 타이틀
		DEF_OBJECT_ID ( TXT_DATA1 ) 	// 점검메모내역
		DEF_OBJECT_ID ( TXT_DATA2 ) 	// 점검메모내역 타이틀
		DEF_OBJECT_ID ( TXT_DATA3 ) 	// 검침메모내역
		DEF_OBJECT_ID ( TXT_DATA4 ) 	// 검침메모내역 타이틀
		DEF_OBJECT_ID ( LINE_DATA_1 )	// 라인1
		DEF_OBJECT_ID ( LINE_DATA_2 )	// 라인2

		DEF_OBJECT_ID (TTL_VISIBLE_YN)// 메모 공개 비공개 여부
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	// 기본정의 CTRL위치의 기본정의
	#define 	SX		(STARTX*20)
	#define 	SY		(STARTY*2)
	#define 	SYH		(CHT*2)
	#define 	SXD		(CWD*33)
	#define 	SYD		(CHT*9)
	
	// 기본정의 DLG화면 정의
	#define 	INIT_MAIN		1
	
	//-----------------------------------------------------------------
	//	main entry map
	//-----------------------------------------------------------------
	CARD_ENTRY_MAP()

	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void SetData(void);	
	void REDRAW(void);
	void SAVE_MEMO(void);
	void Save_Gm_Memo(void);
	void Save_Sc_Memo(void);
	void Save_Visible(void);
	void Set_BarRadio(void);
	void Snd_Memo(void);
	long TR16010(void);


	//---------------------------------------------------------------------------------------
	// 기본 메모
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG  ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, "" ),
		DLG_ICON  ( POPTX, POPTY, ICON_TITLE, "" ),
		DLG_TEXT  ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "통합 메모 화면" ),
		DLG_BUTTON( BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC, "", BID_CANCEL, "" ),
		
		DLG_TEXT  ( STARTX,      STARTY  -29, 1000,  70, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "" ),
		DLG_TEXT  ( STARTX,      STARTY  +41, 1000, 350, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA2, "" ),

		DLG_LINE  ( STARTX,      STARTY +395, 1000, STARTY +395, DARKSLATEBLUE, 10, LINE_DATA_1 ),

		DLG_TEXT  ( STARTX,      STARTY +400, 650,  70, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "" ),
		DLG_TEXT  ( STARTX+650,  STARTY +400, 231, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VISIBLE_YN, "비공개"),
		DLG_BUTTON( STARTX+881,  STARTY +400,116, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VISIBLE_N,  CHK_N1),
		DLG_BUTTON( STARTX,      STARTY +470, 1000, 350, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC, "", BID_WRITE, "" ),
		DLG_TEXT  ( STARTX,      STARTY +470, 1000, 350, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA4, "" ),
		
		DLG_LINE  ( STARTX,      STARTY +824, 1000, STARTY +824, DARKSLATEBLUE, 10, LINE_DATA_2 ),

		DLG_BUTTON( STARTX,      STARTY +829,  333,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_DEL, "메모 삭제" ),
		DLG_BUTTON( STARTX +333, STARTY +829,  333,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CANCEL, "닫 기" ),
		DLG_BUTTON( STARTX +666, STARTY +829,  334,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SAVE, "저 장" ),
	};
	
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
		long i;
		char szTmp[200];

		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_DIALOG_OBJECT( DlgRes, SIZEOF(DlgRes) );
				SetBtnImg();
				SetStyle();
				REDRAW();

				break;
		}
	}

	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton( long ID )
	{	
		char szTmp[200];
		long nLen = 0;
	
		switch(ID)
		{
			//취소
			case BID_CANCEL:
				Card_Prev();
				break;

			//메모저장
			case BID_SAVE:
				if( Str_Len(Get_hDlgCtrlByID(TXT_DATA4)) > 0 )
				{
					// 검침	
					if( g_nMemoFlag == 1 )
					{
						nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)));
					
						if( nLen > 100 )
						{
							Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
							SPRINT(szTmp, "저장실패!\n(메모는 한글 33자,\n영문.숫자 100자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
							MessageBoxEx(CONFIRM_OK, szTmp);
							break;
						}
						else
						{
							//SAVE_MEMO();
							Snd_Memo();
							//Card_Prev();
						}
					}
					// 안전점검
					else if( g_nMemoFlag == 2 )
					{
						nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)));
					
						if( nLen > 200 )
						{
							Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
							SPRINT(szTmp, "저장실패!\n(메모는 한글 100자,\n영문.숫자 200자 까지만\n입력가능합니다.)\n[%d]", nLen, 0, 0);
							MessageBoxEx(CONFIRM_OK, szTmp);
							break;
						}
						else
						{
							Snd_Memo();
						}
					}
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "메모를 입력해 주세요.");
				}

				break;
				
			case BID_WRITE:
				if( Str_Cmp(stSc.UPD_EMPID,stUserinfo.szemployee_id ) == 0 )
				{
					g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DATA4), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)) );
				}
				else if(Str_Cmp(stSc.CHK_VISIBLE_YN, "N") != 0)
				{
					g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DATA4), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)) );
				}
				
				break;	

			//메모내용 삭제
			case BID_DEL:
				if( g_nMemoFlag == 1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "");
				}
				else if( g_nMemoFlag == 2 )
				{
					if(MessageBoxEx (CONFIRM_YESNO, "메모를 삭제하시겠습니까?") == MB_OK )
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "");
						Str_Cpy(stSc.CHK_VISIBLE_YN,"Y");
						Str_Cpy(stSc.UPD_EMPID,"");
						Snd_Memo();
					}
				}

				break;

			case BID_VISIBLE_N:		
				PRINT("stSc.CHK_VISIBLE_YN : %s",stSc.CHK_VISIBLE_YN,0,0);

				if(Str_Len(stSc.CHK_VISIBLE_YN) == 0)
				{
					Str_Cpy(stSc.CHK_VISIBLE_YN,"Y");		
				}
				
				//Y가 공개 N이 비공개
				if( Str_Cmp(stSc.CHK_VISIBLE_YN,"N" ) == 0 ){
					Str_Cpy(stSc.CHK_VISIBLE_YN,"Y");
					PRINT("88stSc.CHK_VISIBLE_YN: %s",stSc.CHK_VISIBLE_YN,0,0);
					Set_BarRadio();
					Save_Visible();
					// REDRAW();
				}else if(Str_Cmp(stSc.CHK_VISIBLE_YN,"Y" ) == 0 )
				// }else if(Str_Cmp(stSc.CHK_VISIBLE_YN,"Y" ) == 0 )
				{
					Str_Cpy(stSc.CHK_VISIBLE_YN,"N");
					PRINT("99stSc.CHK_VISIBLE_YN: %s",stSc.CHK_VISIBLE_YN,0,0);
					Set_BarRadio();
					Save_Visible();
					// REDRAW();

				}
				
				

				break;
		}
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
	void SetBtnImg(void)
	{
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );	
	}

	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_TOP);

		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA2), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetEditableMode( Get_hDlgCtrlByID(TXT_DATA2), EDITMODE_HANGUL );
		EditCtrl_SetMaxChar(Get_hDlgCtrlByID(TXT_DATA2),190);

		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), TRUE );
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_TOP);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA4), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetEditableMode( Get_hDlgCtrlByID(TXT_DATA4), EDITMODE_HANGUL );
		EditCtrl_SetMaxChar(Get_hDlgCtrlByID(TXT_DATA4),190);
	}

	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 DRAW
	Param  : g_nMemoFlag => 1:검침 , 2:안전점검, 3:조정기, 4:특정점검 메모, 5:특정점검 계량기 메모, 6:계량기교체 메모, 7:민원실사 메모(보여주기용?)
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i;
		char szMemo[100];
		char szEmployee_id[10];
		char szSql[300];
		char szMsg[150];

		PRINT("3333333333 : %s",stSc.CHK_VISIBLE_YN,0,0);
		PRINT("3333333333 : %s",stUserinfo.szemployee_id,0,0);
		PRINT("3333333333 : %s",stSc.UPD_EMPID,0,0);

		// 검침
		if( g_nMemoFlag == 1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), "점검 메모 내역");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), "검침 메모 내역");

			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stGm.CHK_MEMO );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stGm.RMK );
		}
		// 안전점검
		else if( g_nMemoFlag == 2 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), "검침 메모 내역");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), "점검 메모 내역");
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stSc.GUM_MEMO );


			//같은 유저일경우 
			if( Str_Cmp(stSc.UPD_EMPID,stUserinfo.szemployee_id ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stSc.CHK_MEMO );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIBLE_N), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIBLE_N), FALSE );

				if( Str_Cmp(stSc.CHK_VISIBLE_YN, "Y") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stSc.CHK_MEMO );
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_VISIBLE_N), CHK_N1);
				}
				else if(Str_Cmp(stSc.CHK_VISIBLE_YN, "N") == 0 )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_VISIBLE_N), CHK_N2);
				}
			}
			else
			{
				if (Str_Cmp(stSc.CHK_VISIBLE_YN, "Y") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stSc.CHK_MEMO );
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_VISIBLE_N), CHK_N1);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), FALSE );
				}
				else if (Str_Cmp(stSc.CHK_VISIBLE_YN, "N") == 0 )
				{	
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_VISIBLE_N), CHK_N2);
					SPRINT(szMsg, "현재 메모가 비공개 상태입니다. \n 메모를 보시려면 사원번호 : %s 에게 공개 요청이 필요합니다. ",stSc.UPD_EMPID , 0, 0);
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), szMsg );

					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE );
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_DEL), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DEL), TRUE );

					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stSc.CHK_MEMO );
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), FALSE );
				}
				//만약에 EPLOYEEID가 맞지않으면 해당 버튼을 누를수 없도록.
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIBLE_N), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIBLE_N), TRUE );
				
				
			}

			
			
			
			
			// DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_VISIBLE_Y), FALSE);// 중지
			// DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_VISIBLE_N), FALSE);// 중지


			
			
		}
	}

	void Set_BarRadio(void)
	{
		long n;
		char szFilenm[256];
		char * sqlstr = "";	
		handle* sql;
		

		handle* hsql;

		
		if(Str_Cmp( stSc.CHK_VISIBLE_YN , "Y") == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_VISIBLE_N), CHK_N1);	
			PRINT("11111111",0,0,0)	;
			// Str_Cpy(stSc.CHK_VISIBLE_YN,"Y");
			PRINT("stSc.CHK_VISIBLE_YN: %s",stSc.CHK_VISIBLE_YN,0,0);
			//CHK_N1 공개
			//CHK_N2 비공개
		}
		else if(Str_Cmp( stSc.CHK_VISIBLE_YN , "N") == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_VISIBLE_N), CHK_N2);				
			PRINT("22222222",0,0,0)	;
			// Str_Cpy(stSc.CHK_VISIBLE_YN,"Y");
			PRINT("stSc.CHK_VISIBLE_YN: %s",stSc.CHK_VISIBLE_YN,0,0);
		}
		
		

	}

	void Save_Visible(void)
	{
		handle* hsql;
		char * sqlstr = "";	
		char sztmp[51];
		char szSql[301];
		PRINT("#1",0,0,0);
		hsql = STRING_Create(sqlstr);
		PRINT("g_szCHK_EXEC_NUM %s",g_szCHK_EXEC_NUM,0,0);
		STRING_Empty(hsql);
		STRING_Append(hsql," UPDATE NORMAL_DATA SET ");
		STRING_Append(hsql," CHK_VISIBLE_YN ='");
		STRING_Append(hsql,  stSc.CHK_VISIBLE_YN);
		STRING_Append(hsql,"' WHERE CHK_EXEC_NUM = ");
		STRING_Append(hsql,  g_szCHK_EXEC_NUM);
		sqlstr = STRING_toString(hsql);
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(hsql);

		SPRINT(szSql, "SELECT CHK_VISIBLE_YN FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 50, sztmp );
		Str_Cpy( stSc.CHK_VISIBLE_YN, sztmp );

		PRINT("stSc.CHK_VISIBLE_YN7777 : %s",stSc.CHK_VISIBLE_YN,0,0);


	}

	/*=======================================================================================
	함수명 : Save_Gm_Memo
	기  능 : 검침 메모 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Gm_Memo(void)
	{
		char szSql[300];
		long idx, ret;

		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)stGm.RMK, 0x00, sizeof(stGm.RMK)  );
		Str_Cpy( stGm.RMK ,EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)) );
		
		hdb = sql->Open(sql);

		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " UPDATE GUMDATA SET RMK =? WHERE ROWID = '%s' ", stGm.ROWID, 0, 0 );
	   
	    hstmt = sql->CreateStatement(sql, szSql);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stGm.RMK, 200, DECRYPT);
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

	Finally:
		DelSqLite(sql);

		MessageBoxEx(CONFIRM_OK, "메모 등록 완료");
		Card_Prev();
		return;
	}
	
	/*=======================================================================================
	함수명 : Save_Sc_Memo
	기  능 : 안전점검 메모 저장
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Sc_Memo(void)
	{
		char szSql[300];
		long idx, ret;

		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)stSc.CHK_MEMO, 0x00, sizeof(stSc.CHK_MEMO)  );
		Str_Cpy( stSc.CHK_MEMO, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)) );

		hdb = sql->Open(sql);

		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " UPDATE NORMAL_DATA SET CHK_MEMO =? ,UPD_EMPID =?,CHK_VISIBLE_YN =? WHERE CHK_EXEC_NUM = ? ", 0, 0, 0 );

	    hstmt = sql->CreateStatement(sql, szSql);
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_MEMO   , 200, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   , 20, DECRYPT);
		// sql->Bind(sql, idx++, 'U', (long *)stSc.UPD_EMPID   , 20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_VISIBLE_YN , 1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM, 12 , DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
	Finally:
		DelSqLite(sql);
		
		MessageBoxEx(CONFIRM_OK, "메모 등록 완료");
		Card_Prev();
		return;
	}

	/*=======================================================================================
	함수명 : Snd_Memo
	기  능 : FR312315
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_Memo(void)
	{
		char szUrl[200];
		char szbuf[128];
		char szUMemo[601];
		char* sndbuf;
		long ret = 0;

		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));			
		Mem_Set((byte*)szUMemo, 0x00, sizeof(szUMemo));			
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}

		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 16010, FALSE);
		
		// 검침
		if( g_nMemoFlag == 1 )
		{			
			SQL_ConvUcStr( szUMemo, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)) );
			JSON_SetValue( g_pjcomm, 'C', "memo", szUMemo );			
			JSON_SetValue( g_pjcomm, 'C', "memo_flag", "10" );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  stGm.INST_PLACE_NUM );
			JSON_SetValue( g_pjcomm, 'C', "req_ym", stGm.REQ_YM );
			JSON_SetValue( g_pjcomm, 'C', "deadline_flag", stGm.DEADLINE_FLAG );
		}
		// 안전점검
		else if( g_nMemoFlag == 2 )
		{
			if(Str_Len(stSc.CHK_VISIBLE_YN) == 0)
				{
					Str_Cpy(stSc.CHK_VISIBLE_YN,"Y");		
					//PRINT("777777stSc.CHK_VISIBLE_YN : %s",stSc.CHK_VISIBLE_YN,0,0);
				}

			SQL_ConvUcStr( szUMemo, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA4)) );
			JSON_SetValue( g_pjcomm, 'C', "memo", szUMemo );
			JSON_SetValue( g_pjcomm, 'C', "memo_flag", "30" );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num", stSc.INST_PLACE_NUM );
			JSON_SetValue( g_pjcomm, 'C', "req_ym", "" );
			JSON_SetValue( g_pjcomm, 'C', "deadline_flag", "" );
			JSON_SetValue( g_pjcomm, 'C', "chk_visible_yn", stSc.CHK_VISIBLE_YN );
			// JSON_SetValue( g_pjcomm, 'C', "chk_visible_yn", stSc.CHK_VISIBLE_YN );
			//chk_visible
			

		}

		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR16010;
		ret = HTTP_DownloadData(szUrl, "FR16010_IN",  "FR16010" , sndbuf, szbuf );
		
		return;
	}

	/*=======================================================================================
	함수명 : TR16010
	기  능 : Callback FR16010
	Param  : 
	Return : 
	========================================================================================*/
	long TR16010(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(16010) >= 0 )
		{
			CloseMessageBox();

			// 검침
			if( g_nMemoFlag == 1 )
			{
				Save_Gm_Memo();
			}
			// 안전점검
			else if( g_nMemoFlag == 2 )
			{
				Save_Sc_Memo();
			}
	
			return 1;
		}
		else
		{
			CloseMessageBox();
			return -1;
		}
	}

	/*=======================================================================================
	함수명 : Snd_Memo
	기  능 : FR312315
	Param  : 
	Return : 
	========================================================================================*/
	void SAVE_MEMO(void)
	{
		//bool ret = TRUE;
		MessageBoxEx(CONFIRM_OK, "검침메모 func call Ok!");
		
		return;
	}

	/*=======================================================================================
	함수명 : SetData
	기  능 : Data Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetData(void)
	{
		long i;
		long lindex = 0;
		char szSql[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));

	}
}


