/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
//특정 시설 점검
card BF_BEFOBOILCHK
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
//특정시설점검
		DEF_BUTTON_ID ( BID_CHECK1 )
		DEF_BUTTON_ID ( BID_CHECK2 )
		DEF_BUTTON_ID ( BID_CHECK3 )
		DEF_BUTTON_ID ( BID_CHECK4 )
		DEF_BUTTON_ID ( BID_CLOSE )
		DEF_BUTTON_ID ( BID_OK )
	END_BUTTON_ID()
	
	// 카드내에서 사용될 콘트롤 아이디 정의
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )
//특정시설
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()

	//기본정의 DLG화면 정의
	#define INIT_MAIN		1
	
	long m_bFirst;
	
	void REDRAW(void);
	void SetStyle(void);
	void SetNogoodData(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	void SetBtnImg(void);
	bool Save_Result(void);
	
	//-----------------------------------------------------------------
	//	main entry map
	//-----------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	//  다이얼로그:특정시설점검
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공급전 보일러점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+780,	 STARTY-29, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "점검"),
		DLG_BUTTON(STARTX+780,	 STARTY+41, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "점검"),
		DLG_BUTTON(STARTX+780,	STARTY+111, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "점검"),
		DLG_BUTTON(STARTX+780,	STARTY+181, 220, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "점검"),
		
		DLG_BUTTON(STARTX,		STARTY+300, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "닫기"),
		DLG_BUTTON(STARTX+500,	STARTY+300, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "확인"),
		
		DLG_TEXT ( STARTX,	     STARTY-29, 370, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "보일러위치"),
		DLG_TEXT ( STARTX+370,	 STARTY-29, 410, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT ( STARTX,  	 STARTY+41, 370, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "급환기구"),
		DLG_TEXT ( STARTX+370,	 STARTY+41, 410, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,  	STARTY+111, 370, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "배기통톱"),
		DLG_TEXT ( STARTX+370,	STARTY+111, 410, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,  	STARTY+181, 370, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "기타"),
		DLG_TEXT ( STARTX+370,	STARTY+181, 410, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
	};
	
	//---------------------------------------------------------------
	//  다이얼로그:특정시설점검 PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "공급전 보일러점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+780,	 STARTY-40, 220, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "점검"),
		DLG_BUTTON(STARTX+780,	 STARTY+40, 220, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "점검"),
		DLG_BUTTON(STARTX+780,	STARTY+120, 220, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "점검"),
		DLG_BUTTON(STARTX+780,	STARTY+200, 220, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "점검"),
		DLG_BUTTON(STARTX,		STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "닫기"),
		DLG_BUTTON(STARTX+600,	STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "확인"),
		
		DLG_TEXT ( STARTX,	     STARTY-40, 370, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "보일러위치"),
		DLG_TEXT ( STARTX+370,	 STARTY-40, 410, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT ( STARTX,  	 STARTY+40, 370, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "급환기구"),
		DLG_TEXT ( STARTX+370,	 STARTY+40, 410, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,  	STARTY+120, 370, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "배기통톱"),
		DLG_TEXT ( STARTX+370,	STARTY+120, 410, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,  	STARTY+200, 370, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "기타"),
		DLG_TEXT ( STARTX+370,	STARTY+200, 410, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
	};
	
	//----------------------------------------------------------------------
	void	OnInit(char bFirst)
	{
		long i;
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			//초기 카드 로드시
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
				SetNogoodData();
				REDRAW();
				break;
		}		
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	//----------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_CHECK1:		//정압기
				g_nWorkChkFlag = 50;
				Str_Cpy(stBfNogood.CREATE_YMD, g_szCREATE_YMD);
				Str_Cpy(stBfNogood.CHK_SEC_CD, "10");
				Str_Cpy(stBfNogood.MTR_NUM, g_szMTR_NUM);
				Str_Cpy(stBfNogood.BURNER_NUM, g_szBURNER_NUM);
				Str_Cpy(stBfNogood.CHK_SEC_NM, "보일러 위치");
				Card_Move("CHK_BFDTL");
				break;
			case BID_CHECK2:		//조정기
				g_nWorkChkFlag = 50;
				Str_Cpy(stBfNogood.CREATE_YMD, g_szCREATE_YMD);
				Str_Cpy(stBfNogood.CHK_SEC_CD, "20");
				Str_Cpy(stBfNogood.MTR_NUM, g_szMTR_NUM);
				Str_Cpy(stBfNogood.BURNER_NUM, g_szBURNER_NUM);
				Str_Cpy(stBfNogood.CHK_SEC_NM, "급환기구");
				Card_Move("CHK_BFDTL");
				break;
			case BID_CHECK3:		//배관점검
				g_nWorkChkFlag = 50;
				Str_Cpy(stBfNogood.CREATE_YMD, g_szCREATE_YMD);
				Str_Cpy(stBfNogood.CHK_SEC_CD, "30");
				Str_Cpy(stBfNogood.MTR_NUM, g_szMTR_NUM);
				Str_Cpy(stBfNogood.BURNER_NUM, g_szBURNER_NUM);
				Str_Cpy(stBfNogood.CHK_SEC_NM, "배기통톱");
				Card_Move("CHK_BFDTL");
				break;
			case BID_CHECK4:		//배관외점검
				g_nWorkChkFlag = 50;
				Str_Cpy(stBfNogood.CREATE_YMD, g_szCREATE_YMD);
				Str_Cpy(stBfNogood.CHK_SEC_CD, "90");
				Str_Cpy(stBfNogood.MTR_NUM, g_szMTR_NUM);
				Str_Cpy(stBfNogood.BURNER_NUM, g_szBURNER_NUM);
				Str_Cpy(stBfNogood.CHK_SEC_NM, "기타");
				Card_Move("CHK_BFDTL");
				break;
				
			case BID_OK:
				if( Save_Result() )
				{
					if( g_nWorkFlag > 499 && g_nWorkFlag < 510 )
					{
						Card_Move("BF_BEFOCONFIRM");
					}
					else
					{
						Card_Move("BF_TGTCONFIRM");
					}
				}
				break;
			case BID_CLOSE:
				if( g_nWorkFlag > 499 && g_nWorkFlag < 510 )
				{
					Card_Move("BF_BEFOCONFIRM");
				}
				else
				{
					Card_Move("BF_TGTCONFIRM");
				}
				break;
				
		}
	}

//=======================================================================================
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
	}
	
//=======================================================================================	
	void REDRAW(void)
	{
		char szSql[400];
		long lCount;
	
		//보일러 위치
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='10' ", g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "부적합");	
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "적합");	
		}
		
		//급환기구
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='20' ", g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA4), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "부적합");	
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA4), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "적합");	
		}
		
		//배기통톱
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='30' ", g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "부적합");	
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "적합");	
		}
		
		//기타
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='90' ", g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "부적합");	
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "적합");	
		}
	}
	
//----------------------------------------------------------------------------
	bool Save_Result(void)
	{
		char szSql[300];
		long lCount;
		long lChk = 0;
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//BO1_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='10' "
						, g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			Str_Cpy(stBfBoil.BO1_RSLT, "N");
			lChk++;
		}
		else
		{
			Str_Cpy(stBfBoil.BO1_RSLT, "Y");
		}

		//BO2_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='20' "
						, g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			Str_Cpy(stBfBoil.BO2_RSLT, "N");
			lChk++;
		}
		else
		{
			Str_Cpy(stBfBoil.BO2_RSLT, "Y");
		}
			
		//BO3_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='30' "
						, g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			Str_Cpy(stBfBoil.BO3_RSLT, "N");
			lChk++;
		}
		else
		{
			Str_Cpy(stBfBoil.BO3_RSLT, "Y");
		}
			
		//BO4_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_DETAL WHERE CREATE_YMD ='%s' AND MTR_NUM ='%s' AND BURNER_NUM ='%s' AND CHK_SEC_CD ='90' "
						, g_szCREATE_YMD, g_szMTR_NUM, g_szBURNER_NUM);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			Str_Cpy(stBfBoil.BO4_RSLT, "N");
			lChk++;
		}
		else
		{
			Str_Cpy(stBfBoil.BO4_RSLT, "Y");
		}


		//부적합결과
		if( lChk > 0 )
		{
			Str_Cpy(stBfBoil.CHK_RSLT, "N");
		}
		else
		{
			Str_Cpy(stBfBoil.CHK_RSLT, "Y");
		}


		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE BEFO_BO_DATA SET \
					BO1_RSLT = ?, BO2_RSLT = ?, BO3_RSLT = ?, BO4_RSLT = ?, CHK_RSLT = ? \
					WHERE CREATE_YMD = ? AND MTR_NUM = ? AND BURNER_NUM = ? "
					, 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BO1_RSLT		,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BO2_RSLT		,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BO3_RSLT		,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BO4_RSLT	    ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.CHK_RSLT	    ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCREATE_YMD	        ,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM	            ,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szBURNER_NUM	        ,6	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
//		sql->Commit(sql);
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	
//---------------------------------------------------------------------------------------------------------
	void SetNogoodData(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stBfNogood, 0x00, sizeof(stBfNogood));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT CREATE_YMD, MTR_NUM, BLD_NUM, INST_PLACE_NUM, SINGLE_COLIVE_FLAG, CENTER_CD \
, ZONE_MANAGE_NUM, ZIP_NO1, ZIP_NO2, CITY, AREA, TOWN, VILLAGE, ADDR1_M, ADDR1_S \
, LOT_NUM_SECOND_ADDR, CO_LIVE_NM, HOUSE_CNT, BLD_NM, DETA_FLOOR, COMPX_FLAG_NM \
, CUST_NUM, CUST_TYPE_CD, CUST_NM, FIRM_NM, BIZ_REGI_NUM, SOC_NUM, REPRE_NM, CP_DDD \
, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, END_YN, SEND_YN \
, CRT_EMPID, CRT_IP, LAW_TOWN, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S \
FROM BEFO_NOGOOD_MAIN WHERE CREATE_YMD = ? AND MTR_NUM = ? "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCREATE_YMD , 8, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szMTR_NUM ,    9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			idx = 0;
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CREATE_YMD         , 8  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.MTR_NUM            , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.BLD_NUM            , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.INST_PLACE_NUM     , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.SINGLE_COLIVE_FLAG , 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CENTER_CD          , 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ZONE_MANAGE_NUM    , 5  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ZIP_NO1            , 3  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ZIP_NO2            , 3  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CITY               , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.AREA               , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.TOWN               , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.VILLAGE            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ADDR1_M            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ADDR1_S            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.LOT_NUM_SECOND_ADDR, 100+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CO_LIVE_NM         , 60 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.HOUSE_CNT          , 6  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.BLD_NM             , 150+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.DETA_FLOOR         , 6  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.COMPX_FLAG_NM      , 60 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CUST_NUM           , 10 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CUST_TYPE_CD       , 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CUST_NM            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.FIRM_NM            , 50 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.BIZ_REGI_NUM       , 10 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.SOC_NUM            , 13 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.REPRE_NM           , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CP_DDD             , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CP_EXN             , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CP_NUM             , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.OWNHOUSE_TEL_DDD   , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.OWNHOUSE_TEL_EXN   , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.OWNHOUSE_TEL_NUM   , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.END_YN             , 1  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.SEND_YN            , 1  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CRT_EMPID          , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CRT_IP             , 32 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.LAW_TOWN           , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.NEW_ROAD_NM        , 100+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.NEW_ADDR_M         , 10 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.NEW_ADDR_S         , 10 + 1, DECRYPT );
		}
		//sql->Commit(sql);
		
Finally:
		DelSqLite(sql);
		
		return;
	}
}


