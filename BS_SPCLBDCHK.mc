/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
//특정 시설 점검
card BS_SPCLBDCHK
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
	#define USE_ON_SELECT
	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
//특정시설점검
		DEF_BUTTON_ID ( BID_CHECK1 )
		DEF_BUTTON_ID ( BID_CHECK2 )
		DEF_BUTTON_ID ( BID_CHECK3 )
		DEF_BUTTON_ID ( BID_CHECK4 )
		DEF_BUTTON_ID ( BID_OK1 )
		DEF_BUTTON_ID ( BID_BACK )
		
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
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 ) 
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 

	END_OBJECT_ID()

	//기본정의 DLG화면 정의
	#define INIT_MAIN		1
	
	long m_bFirst;
	
	void REDRAW(void);
	void SetStyle(void);
	void SetCombo(void);
	bool Save_Result(void);
	bool Validate(void);
	bool Save_Result_Back(void);
	
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	void SetBtnImg(void);
	
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
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "특정시설 점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX+825,	 STARTY-29, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "점검"),
		DLG_BUTTON(STARTX+825,	 STARTY+41, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "점검"),
		DLG_BUTTON(STARTX+825,	STARTY+111, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "점검"),
		DLG_BUTTON(STARTX+825,	STARTY+181, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "점검"),
		DLG_BUTTON(STARTX+600,	STARTY+450, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "확인"),
		
		DLG_TEXT ( STARTX,	    STARTY-29, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "정압기"),
		DLG_TEXT ( STARTX+300,	STARTY-29, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT ( STARTX,	    STARTY+41, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "조정기"),
		DLG_TEXT ( STARTX+300,  STARTY+41, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	   STARTY+111, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "배관점검"),
		DLG_TEXT ( STARTX+300, STARTY+111, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	   STARTY+181, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "배관외점검"),
		DLG_TEXT ( STARTX+300, STARTY+181, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT ( STARTX,	   STARTY+251, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "홍보물"),
		DLG_TEXT ( STARTX,	   STARTY+321, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "히트펌프"),
		
		DLG_COMBO (STARTX+300,  STARTY+251, 700, 200, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+300,  STARTY+321, 700, 200, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	//  다이얼로그:특정시설점검
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "특정시설 점검"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX+825,	 STARTY-40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "점검"),
		DLG_BUTTON(STARTX+825,	 STARTY+40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "점검"),
		DLG_BUTTON(STARTX+825,	STARTY+120, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "점검"),
		DLG_BUTTON(STARTX+825,	STARTY+200, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "점검"),
		DLG_BUTTON(STARTX+600,	STARTY+500, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "확인"),
		
		DLG_TEXT ( STARTX,	    STARTY-40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "정압기"),
		DLG_TEXT ( STARTX+300,	STARTY-40, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT ( STARTX,	    STARTY+40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "조정기"),
		DLG_TEXT ( STARTX+300,  STARTY+40, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	   STARTY+120, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "배관점검"),
		DLG_TEXT ( STARTX+300, STARTY+120, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	   STARTY+200, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "배관외점검"),
		DLG_TEXT ( STARTX+300, STARTY+200, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT ( STARTX,	   STARTY+280, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "홍보물"),
		DLG_TEXT ( STARTX,	   STARTY+360, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "히트펌프"),
		
		DLG_COMBO (STARTX+300,  STARTY+280, 700, 200, 175, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+300,  STARTY+360, 700, 200, 175, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};
	
	//----------------------------------------------------------------------
	void	OnInit(char bFirst)
	{
		long i;
		long lCount = 0;
		char szSql[300];
		
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
				
				if(g_lSCMoveFlag == 1)
				{
					Card_Load("BS_START");
					return;
				}

				//홍보물
				for ( i = 0 ;  SCADV[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), SCADV[i].Str, 0, ICON_NONE);
				}
				
				//히트펌프
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "미설치", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "설치", 0, ICON_NONE);

				SetBtnImg();
				
				REDRAW();
				
				if( Str_Cmp(stUserinfo.szcenter_cd,"91") == 0 
			  	 || Str_Cmp(stUserinfo.szcenter_cd,"92") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"93") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"94") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"95") == 0 )
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM ='%s' AND GOV_REGTR_FLAG ='10' ", g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_RetInt(szSql, &lCount);
					
					if( lCount > 0 )
					{
						if( g_lGovFlag == 0 )
						{
							g_nWorkChkFlag = 40;
							Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
							Str_Cpy(stBsNogood.CHK_SEC_CD, "21");
							Str_Cpy(stBsNogood.MTR_NUM, "");
							Str_Cpy(stBsNogood.BURNER_NUM, "");
							Str_Cpy(stBsNogood.CHK_SEC_NM, "정압기");
							Card_Move("CHK_BSDTL");
							return;
						}
					}
				}
				
				break;
		}		
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		
		
	}

	//----------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_CHECK1:		//정압기
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "21");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "정압기");
				Card_Move("CHK_BSDTL");
				break;
			case BID_CHECK2:		//조정기
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "23");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "조정기");
				Card_Move("CHK_BSDTL");
				break;
			case BID_CHECK3:		//배관점검
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "10");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "배관");
				Card_Move("CHK_BSDTL");
				break;
			case BID_CHECK4:		//배관외점검
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "70");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "배관외");
				Card_Move("CHK_BSDTL");
				break;
			case BID_OK1:
				if( !Validate() )
					break;

				// if( Save_Result() )
				Card_Move("BS_START");
				break;
			case BID_BACK:
				// if( !Validate() )
				// 	break;
				// if( Save_Result_Back() )
				Card_Move("BS_START");
				break;
		}
	}
	
//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		char szSql[400];
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{	
			//홍보물
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "미배포") == 0 )
				Str_Cpy(stBs.ADV_DIST_YN, "N");
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "배포") == 0 )
				Str_Cpy(stBs.ADV_DIST_YN, "Y");
				
			//히트펌프
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "미설치") == 0 )
				Str_Cpy(stBs.HEAT_PUMP_YN, "N");
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "설치") == 0 )
				Str_Cpy(stBs.HEAT_PUMP_YN, "Y");
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
	}
	
	/*=======================================================================================
	함수명 : SearchStr
	기  능 : 스트링으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
	long	SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	/*=======================================================================================
	함수명 : SearchCD
	기  능 : 코드값으로 코드인덱스를 찾는다.
	Param  : 
	Return : 코드인덱스, 없으면 -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
				return i;
		}
		
		return -1;
	}
	
//----------------------------------------------------------------------------
//------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szSql[300];
		long lCount;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		//기본 조정기,정압기 점검 버튼 FALSE 셋팅. 대상의 정보 확인 후 버튼 활성화 결정
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
	
		//대상의 조정기 갯수확인
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM ='%s' AND GOV_REGTR_FLAG ='10' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
		}
		else
		{
			Str_Cpy(stBs.GOV_RSLT, "Y");
		}
		//대상의 정압기 갯수확인
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM ='%s' AND GOV_REGTR_FLAG ='20' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
		}	
		else
		{
			Str_Cpy(stBs.REG_RSLT, "Y");
		}	
	
		//정압기 점검
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "부적합");	
		}
		else
		{
			if( stBs.GOV_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "미점검");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "적합");	
			}
		}
		
		//조정기 점검
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N'  ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA4), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "부적합");	
		}
		else
		{	

			if( stBs.REG_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "미점검");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA4), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "적합");	
			}	
		}
		
		//배관 점검
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10' AND BETTER_YN = 'N'  ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "부적합");	
		}
		else
		{
			if( stBs.PIPE_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "미점검");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "적합");	
			}
			
		}
		
		//배관외 점검
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70' AND BETTER_YN = 'N'  ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "부적합");	
		}

		
		else
		{
			if( stBs.PIPEETC_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "미점검");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "적합");	
			}
		}
		
		//홍보물
		if( Str_Cmp(stBs.ADV_DIST_YN, "N") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "미배포");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "배포");
		}
		
		//히트펌프
		if( Str_Cmp(stBs.HEAT_PUMP_YN, "N") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "미설치");
		}
		else if( Str_Cmp(stBs.HEAT_PUMP_YN, "Y") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "설치");
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
		long lCnt;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//GOV_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.GOV_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.GOV_RSLT, "Y");

		// // //REG_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.REG_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.REG_RSLT, "Y");
			
		// // //PIPE_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPE_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPE_RSLT, "Y");
			
		// // //PIPEETC_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "Y");
 
		//부적합결과
		// if( lChk > 0 )
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "N");
		// else
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					ADV_DIST_YN = ?, HEAT_PUMP_YN = ?, SPECIAL_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.ADV_DIST_YN		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.HEAT_PUMP_YN	,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_RSLT	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );

		//PRINT("stGovinfo2.NEW_DISJOINT_CHK_YMD : %s",stGovinfo2.NEW_DISJOINT_CHK_YMD,0,0);

		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0) //정압기에 중압이면 필수.
		{
			if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
			{	
				MessageBoxEx (CONFIRM_OK, "정압기 분해점검일을 확인하세요.\n(필수)");
				ret = FALSE;
				return ret;
			}
		}
		else if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0 )
		//조정기이면서 1인치가 아닌거
		{
			if( Str_Len(stGovinfo2.NEW_FILTER_CLEAN_YMD) == 0 )
			{
				if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "조정기 필터청소를 확인하세요.\n(필수)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
				else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "조정기 필터청소를 확인하세요.\n(필수)") == MB_OK)
					{	
						ret = FALSE;
				return ret;
					}
				}
			}
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

	bool Save_Result_Back(void)
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
		
		//GOV_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.GOV_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.GOV_RSLT, "Y");

		// // //REG_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.REG_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.REG_RSLT, "Y");
			
		// // //PIPE_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPE_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPE_RSLT, "Y");
			
		// // //PIPEETC_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "Y");

		// //부적합결과
		// if( lChk > 0 )
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "N");
		// else
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					ADV_DIST_YN = ?, HEAT_PUMP_YN = ?, SPECIAL_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.ADV_DIST_YN		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.HEAT_PUMP_YN	,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_RSLT	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		//PRINT("stGovinfo2.NEW_DISJOINT_CHK_YMD : %s",stGovinfo2.NEW_DISJOINT_CHK_YMD,0,0);

		// if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 )
		// {
		// 	if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
		// 	{	
		// 		MessageBoxEx (CONFIRM_OK, "정압기 분해점검일을 확인하세요.\n(필수)");
		// 		ret = FALSE;
		// 		return ret;
		// 	}
		// }
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

	bool Validate(void)
	{
		char szSql[300];
		char szTmp[256];
		char szfilenm[256];
		char szDate[256];
		char szYear[256];
		char szChkDate[256];
		long idx;
		bool ret = TRUE;
		long lChk = 0;
		long lCount;
		long lCnt;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szChkDate, 0x00, sizeof(szChkDate));
		
		Str_ItoA(Time_GetDate(), szDate, 10);
		Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
		Mem_Cpy((byte *)szChkDate, (byte *)stGovinfo2.NEW_DISJOINT_CHK_YMD, 4);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );

		
		if( Str_Cmp(stBs.GOV_RSLT, "") == 0 || Str_Cmp(stBs.REG_RSLT, "") == 0 || Str_Cmp(stBs.PIPE_RSLT, "") == 0 || Str_Cmp(stBs.PIPEETC_RSLT, "") == 0)
		{
			MessageBoxEx (CONFIRM_OK, "미점검항목을 확인하세요.");
			ret = FALSE;
			return ret;
		}

		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0)
		{
			if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
			{	
				MessageBoxEx (CONFIRM_OK, "정압기 분해점검일을 확인하세요.\n(필수)");
				ret = FALSE;
				return ret;
			}
		}
		else if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0 )
		//조정기이면서 1인치가 아닌거
		{
			if( Str_Len(stGovinfo2.NEW_FILTER_CLEAN_YMD) == 0 )
			{
				if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
				{
					if( MessageBoxEx (CONFIRM_OK, "조정기 필터청소를 확인하세요.\n(필수)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
				else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
				{
					if( MessageBoxEx (CONFIRM_OK, "조정기 필터청소를 확인하세요.\n(필수)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
			}
		}

		//GOV_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{	
			lChk++;
		}
		

		// // //REG_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			lChk++;
		}
		
			
		// // //PIPE_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10'  AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			lChk++;
		}
		
			
		// // //PIPEETC_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70'  AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			// Str_Cpy(stBs.PIPEETC_RSLT, "N");
			lChk++;
		}
		
 
		//부적합결과
		if( lChk > 0 )
			Str_Cpy(stBs.SPECIAL_RSLT, "N");
		else
			Str_Cpy(stBs.SPECIAL_RSLT, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					ADV_DIST_YN = ?, HEAT_PUMP_YN = ?, SPECIAL_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.ADV_DIST_YN		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.HEAT_PUMP_YN	,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_RSLT	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
}


