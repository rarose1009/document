/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_STANDPIPECHK
	Card Desc : 안전점검시_입상관점검
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_STANDPIPECHK
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"

//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CHECK1 )
		DEF_BUTTON_ID ( BID_CHECK2 )
		DEF_BUTTON_ID ( BID_CHECK3 )
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_CLOSE )
		DEF_BUTTON_ID ( BID_CANCEL )
		DEF_BUTTON_ID ( BID_ADDR )

	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// 카드내에서 사용될 콘트롤 아이디 정의
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )

		//DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		//DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀

		//포인팅 자판
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
		
		DEF_OBJECT_ID ( CMB_DATA1 ) 
		//DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 
		//DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 )
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA1+3 )
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// 기본정의 DLG화면 정의
	//---------------------------------------------------------------
	
	#define INIT_MAIN		1

	long m_bFirst;
	long m_lActiveIndex;
	
	char m_szAddr[200];
	
	void SetData(void);
	void REDRAW(void);
	void SetStyle(void);
	void SetCombo(void);
	bool Save_Result(void);
	bool Validate(void);
	long SearchStr(char *Str, CodeTable *CT);	//코드 값을 찾는다.
	long SearchCD(char *CD, CodeTable *CT);	//코드 값을 찾는다.
	void SetBtnImg(void);
	
	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "입상관 안전점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,      STARTY+10, 200, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지번"),
		DLG_TEXT ( STARTX+200, STARTY+10, 800, 100, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_TEXT ( STARTX,	   STARTY+130, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "건물번호"),
		DLG_TEXT ( STARTX+400, STARTY+130, 600, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_TEXT ( STARTX,	  STARTY+200, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5, "공동주택명"),
		DLG_TEXT ( STARTX+400, STARTY+200, 600, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT ( STARTX,	  STARTY+270, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA7, "건물명"),
		DLG_TEXT ( STARTX+400, STARTY+270, 600, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		
		DLG_TEXT ( STARTX,	  STARTY+430, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "가스누출"),
		DLG_COMBO (STARTX+400,  STARTY+430, 600, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
	
		DLG_TEXT ( STARTX,    STARTY+500, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA11, "입상관보호대"),
		DLG_COMBO (STARTX+400,  STARTY+500, 600, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),

		DLG_TEXT ( STARTX,    STARTY+570, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA12, "입상관개수"),
		DLG_EDIT( STARTX+400,STARTY+570 , 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1, 9,  ""),
	
		DLG_BUTTON(STARTX,      STARTY+670, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "닫기"),
		DLG_BUTTON(STARTX+700,  STARTY+670, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "저장"),
	
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
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "입상관 안전점검"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
	
		DLG_BUTTON(STARTX,      STARTY+640, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "닫기"),
		DLG_BUTTON(STARTX+675,  STARTY+640, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "저장"),
		
		//DLG_TEXT ( STARTX,	   STARTY+10, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "건물주소"),
		DLG_TEXT ( STARTX+400, STARTY+10, 600, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_TEXT ( STARTX,	   STARTY+80, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "건물번호"),
		DLG_TEXT ( STARTX+400, STARTY+80, 600, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_TEXT ( STARTX,	  STARTY+150, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4, "공동주택명"),
		DLG_TEXT ( STARTX+400, STARTY+150, 600, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		
		DLG_TEXT ( STARTX,	  STARTY+220, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5, "건물명"),
		DLG_TEXT ( STARTX+400, STARTY+220, 600, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT ( STARTX,	  STARTY+330, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA6, "가스누출"),
		DLG_COMBO (STARTX+400,  STARTY+330, 575, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		
		//DLG_TEXT ( STARTX,    STARTY+400, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA7, "배관부식"),
		//DLG_COMBO (STARTX+400,  STARTY+400, 575, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		
		DLG_TEXT ( STARTX,    STARTY+470, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA8, "입상관보호대"),
		DLG_COMBO (STARTX+400,  STARTY+470, 575, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		
		//DLG_TEXT ( STARTX,    STARTY+540, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "입상관개수"),
		DLG_EDIT( STARTX+400,STARTY+540 , 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1, 9,  ""),
	};

	//┌─────────────────────────────────────┐
	//│ 				   『	OnInit Function  』  				              │
	//└─────────────────────────────────────┘
	void	OnInit(char bFirst)
	{
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
				SetCombo();
				SetData();
				REDRAW();
				
				break;	
		}		
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
	함수명 : OnChar
	기  능 : Editer 체크
	Param  : nChar
	Return : 
	========================================================================================*/
	void	OnChar(long nChar)
	{
		char szMtr_Code[13];
		long nLen;

		if( m_bFirst == INIT_MAIN )
		{
			nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			if( nLen > 3 )
			{
				MessageBoxEx(CONFIRM_OK, "입상관개수가 초과했습니다.\n(최대 3자리)");
				// 넘어가면 마지막 char 삭제
				ON_KEY( 5 );
				return;
			}
		}
	}

	/*=======================================================================================
	함수명 : OnButton
	기  능 : BUTTON ACTIVE EVENT
	Param  : long ID
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_OK:	
				if( MessageBoxEx (CONFIRM_YESNO, "입상관점검결과를\n저장하시겠습니까?")  == MB_OK)
				{
					if( Save_Result() )
					{
						Card_Move("SC_CONFIRM");
					}
				}

				break;
			case BID_CLOSE:
				Card_Move("SC_CONFIRM");
				break;
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "도로명");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "지번");
				}
				
				Mem_Set((byte*)m_szAddr, 0x00, sizeof(m_szAddr));

				if( g_nAddrFlag == 0)
				{
					if(Str_Len(stSc.COUNTY) > 0)		//시군구
					{
						Str_Cpy(m_szAddr,  stSc.COUNTY );
					}			
					if(Str_Len(stSc.TOWN) > 0)			//읍면동
					{
						Str_Cat(m_szAddr,  " " );
						Str_Cat(m_szAddr,  stSc.TOWN );
					}
					if(Str_Len(stSc.VILLAGE) > 0)			//읍면동
					{
						Str_Cat(m_szAddr,  " " );
						Str_Cat(m_szAddr,  stSc.VILLAGE );
					}
					if(Str_Len(stSc.ADDR1_M) > 0)		//본번
					{
						Str_Cat(m_szAddr,  " " );
						Str_Cat(m_szAddr,  stSc.ADDR1_M);
					}
					
					if(Str_Len(stSc.ADDR1_S) > 0)		//부번
					{
						Str_Cat(m_szAddr,  "-" );
						Str_Cat(m_szAddr,  stSc.ADDR1_S);
					}
					
					if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "10") == 0 )
					{
						if(Str_Len(stSc.HOUSE_CNT) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
						}
						if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.LOT_NUM_SECOND_ADDR);
						}
					}
					else if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
					{
						if(Str_Len(stSc.CO_LIVE_NM) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.CO_LIVE_NM );	//공동주택명
						}
						if(Str_Len(stSc.BLD_NM) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.BLD_NM);
						}
						if(Str_Len(stSc.HOUSE_CNT) > 0)
						{
							Str_Cat(m_szAddr,  "-" );
							Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
						}
					}
		
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), m_szAddr);
				}
				else
				{
					if(Str_Len(stSc.COUNTY) > 0)		//시군구
					{
						Str_Cpy(m_szAddr,  stSc.COUNTY );
					}
					
					if(Str_Len(stSc.NEW_ROAD_NM) > 0)
					{
						Str_Cat(m_szAddr,  " " );
						Str_Cat(m_szAddr,  stSc.NEW_ROAD_NM );
					}
					if(Str_Len(stSc.NEW_ADDR_M) > 0)
					{
						Str_Cat(m_szAddr,  " " );
						Str_Cat(m_szAddr,  stSc.NEW_ADDR_M);
					}
					if(Str_Len(stSc.NEW_ADDR_S) > 0)
					{
						Str_Cat(m_szAddr,  "-" );
						Str_Cat(m_szAddr,  stSc.NEW_ADDR_S);
					}
		
					if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "10") == 0 )
					{
						if(Str_Len(stSc.HOUSE_CNT) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
						}
						if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.LOT_NUM_SECOND_ADDR);
						}
					}
					else if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
					{
						if(Str_Len(stSc.CO_LIVE_NM) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.CO_LIVE_NM );	//공동주택명
						}
						if(Str_Len(stSc.BLD_NM) > 0)
						{
							Str_Cat(m_szAddr,  " " );
							Str_Cat(m_szAddr,  stSc.BLD_NM);
						}
						if(Str_Len(stSc.HOUSE_CNT) > 0)
						{
							Str_Cat(m_szAddr,  "-" );
							Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
						}
					}
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), m_szAddr);
				}
				
				ON_DRAW();

				break;
		}
	}
	
	/*=======================================================================================
	함수명 : OnSelect
	기  능 : COMBO BOX ACTIVE EVENT
	Param  : long Index
	Return : 
	========================================================================================*/
	void	OnSelect(long Index)
	{
		char szSql[400];
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{	
			// 가스누출
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SC_GASCHK );
			if (i == -1)
			{
				Str_Cpy(stStandPipChk.GAS_LK, "");
			}
			else
			{
				Str_Cpy(stStandPipChk.GAS_LK, SC_GASCHK[i].Code);
			}
			//20171012 신기호 : 이성근차장님 요청
			// 배관 부식
			/*
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), SC_GASCHK );
			if (i == -1)
			{
				Str_Cpy(stStandPipChk.PIPE_RUST, "");
			}
			else
			{
				Str_Cpy(stStandPipChk.PIPE_RUST, SC_GASCHK[i].Code);
			}
			*/
			// 입상관 보호대
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), SCTIMER_COCK );
			if (i == -1)
			{
				Str_Cpy(stStandPipChk.STAND_PIPE_PROTE_INST, "");
			}
			else
			{
				Str_Cpy(stStandPipChk.STAND_PIPE_PROTE_INST, SCTIMER_COCK[i].Code);
			}
		}	
	}

	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER, COMBOBOX UI SETTING
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA2), TRUE, 2, EDITSEP_NONE );
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
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
			}
		}
	}

	/*=======================================================================================
	함수명 : SetCombo
	기  능 : 콤보박스 세팅
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;

		//가스누출
		for ( i = 0 ;  SC_GASCHK[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), SC_GASCHK[i].Str, 0, ICON_NONE);
		}
		/*
		//배관부식
		for ( i = 0 ;  SC_GASCHK[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), SC_GASCHK[i].Str, 0, ICON_NONE);
		}
		*/
		//입상관보호대
		for ( i = 0 ;  SCTIMER_COCK[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCTIMER_COCK[i].Str, 0, ICON_NONE);
		}
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
	
	/*=======================================================================================
	함수명 : REDRAW
	기  능 : 화면 새로 고침
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i;
		long lCount;
		char szSql[300];
	
		// 1. 지번 ,도로명
		Mem_Set((byte*)m_szAddr, 0x00, sizeof(m_szAddr));

		if( g_nAddrFlag == 0)
		{
			if(Str_Len(stSc.COUNTY) > 0)		//시군구
			{
				Str_Cpy(m_szAddr,  stSc.COUNTY );
			}			
			if(Str_Len(stSc.TOWN) > 0)			//읍면동
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.TOWN );
			}
			if(Str_Len(stSc.VILLAGE) > 0)			//읍면동
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.VILLAGE );
			}
			if(Str_Len(stSc.ADDR1_M) > 0)		//본번
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.ADDR1_M);
			}
			
			if(Str_Len(stSc.ADDR1_S) > 0)		//부번
			{
				Str_Cat(m_szAddr,  "-" );
				Str_Cat(m_szAddr,  stSc.ADDR1_S);
			}
			
			if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "10") == 0 )
			{
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
				if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.LOT_NUM_SECOND_ADDR);
				}
			}
			else if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
			{
				if(Str_Len(stSc.CO_LIVE_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.CO_LIVE_NM );	//공동주택명
				}
				if(Str_Len(stSc.BLD_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.BLD_NM);
				}
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  "-" );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
			}

			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), m_szAddr);
		}
		else
		{
			if(Str_Len(stSc.COUNTY) > 0)		//시군구
			{
				Str_Cpy(m_szAddr,  stSc.COUNTY );
			}
			
			if(Str_Len(stSc.NEW_ROAD_NM) > 0)
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.NEW_ROAD_NM );
			}
			if(Str_Len(stSc.NEW_ADDR_M) > 0)
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.NEW_ADDR_M);
			}
			if(Str_Len(stSc.NEW_ADDR_S) > 0)
			{
				Str_Cat(m_szAddr,  "-" );
				Str_Cat(m_szAddr,  stSc.NEW_ADDR_S);
			}

			if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "10") == 0 )
			{
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
				if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.LOT_NUM_SECOND_ADDR);
				}
			}
			else if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
			{
				if(Str_Len(stSc.CO_LIVE_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.CO_LIVE_NM );	//공동주택명
				}
				if(Str_Len(stSc.BLD_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.BLD_NM);
				}
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  "-" );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), m_szAddr);
		}
		
		// 2. 건물번호
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stSc.BLD_NUM);
		
		// 3. 공동건물 명
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), stSc.CO_LIVE_NM);
		
		// 4. 건물명 
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), stSc.BLD_NM);
		
		// 5. 화면 새로 고침 
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : Save_Result
	기  능 : 저장 이벤트
	Param  : 
	Return : 
	========================================================================================*/
	bool Save_Result(void)
	{
		char szSql[300];
		char szToday[15];
		long lCount;
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		// 1. Validate
		if( !Validate() )
			return FALSE;

		// 2. stStandPipChk.PIPE_CNT setting
		Mem_Set( (byte*)stStandPipChk.PIPE_CNT, 0x00, sizeof(stStandPipChk.PIPE_CNT) );
		Str_Cpy( stStandPipChk.PIPE_CNT, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		
		// 3. stStandPipChk.SEND_YN setting
		Str_Cpy( stStandPipChk.SEND_YN, "S" );
		
		// 4. stStandPipChk.CHK_YMD setting
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10);
		Str_Cpy(stStandPipChk.CHK_YMD, szToday);
		
		// 5. stStandPipChk.CHK_TIME setting
		g_Str_TimeType( stStandPipChk.CHK_TIME, Time_GetTime() );
		
		// 6. ComboBox data setting 
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SC_GASCHK );
		Str_Cpy(stStandPipChk.GAS_LK, SC_GASCHK[i].Code);
		
		//20171012 이성근차장님 요청
		/*
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), SC_GASCHK );
		Str_Cpy(stStandPipChk.PIPE_RUST, SC_GASCHK[i].Code);
		*/

		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), SCTIMER_COCK );
		Str_Cpy(stStandPipChk.STAND_PIPE_PROTE_INST, SCTIMER_COCK[i].Code);
		
		// 7. Transaction
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_STANDPIPE_CHK_RSLT WHERE BLD_NUM ='%s' "
						, stSc.BLD_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		if( lCount > 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Str_Cpy(szSql, "UPDATE NORMAL_STANDPIPE_CHK_RSLT SET \
			                       CHK_EMPID = ?, CHKER_NM = ?, CHK_YMD = ?, CHK_TIME = ? \
			                     , GAS_LK = ?, PIPE_RUST = ?, STAND_PIPE_PROTE_INST = ?, PIPE_CNT = ?, SEND_YN = ? \
			                 WHERE CHK_YEAR = ? AND CHK_ORDER = ? AND CHK_TYPE = ? AND BLD_NUM = ?"
			       );
		}
		else
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Str_Cpy(szSql, "INSERT INTO NORMAL_STANDPIPE_CHK_RSLT \
			                ( CHK_EMPID, CHKER_NM, CHK_YMD , CHK_TIME \
			                , GAS_LK, PIPE_RUST, STAND_PIPE_PROTE_INST, PIPE_CNT, SEND_YN \
			                , CHK_YEAR, CHK_ORDER, CHK_TYPE, BLD_NUM ) \
			                VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id         ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor              ,20 ,DECRYPT );
		sql->Bind(sql, idx++, 'U', (long *)stStandPipChk.CHK_YMD		    ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stStandPipChk.CHK_TIME		    ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stStandPipChk.GAS_LK		        ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stStandPipChk.PIPE_RUST		    ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stStandPipChk.STAND_PIPE_PROTE_INST		    ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stStandPipChk.PIPE_CNT		    ,3 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stStandPipChk.SEND_YN		    ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      	            ,4  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     	            ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      	            ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       	            ,9  ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "등록이 완료되었습니다.");
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Validate
	기  능 : Validate
	Param  : 
	Return : 
	========================================================================================*/
	bool Validate(void)
	{
		char szMsg[100];
		long nLen = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			// 1. COMBO CHECK
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "가스누출을 점검해주세요.");
				return FALSE;
			}
			/* 20171012 신기호 : 이성근차장님 임시삭제 요청
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "배관부식을 점검해주세요.");
				return FALSE;
			}
			*/
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "입상관보호대를 점검해주세요.");
				return FALSE;
			}
			
			// 2. EDITER CHECK
			nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			if( nLen == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "입상관개수를 입력해주세요.\n(최대 3자리)");
				return FALSE;
			}
		}
		return TRUE;
	}
	
	/*=======================================================================================
	함수명 : SetData
	기  능 : INIT Data Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetData(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		// 1. stStandPipChk 구조체 초기화
		Mem_Set((byte*)&stStandPipChk, 0x00, sizeof(stStandPipChk));
		
		// 2. Local Data setting
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT CHK_YEAR, CHK_ORDER, CHK_TYPE, BLD_NUM \
								                , CHK_EMPID, CHKER_NM, CHK_YMD, CHK_TIME \
								                , GAS_LK, PIPE_RUST, STAND_PIPE_PROTE_INST, PIPE_CNT \
								                , SEND_YN \
								             FROM NORMAL_STANDPIPE_CHK_RSLT \
								            WHERE BLD_NUM = ?"
								    );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stSc.BLD_NUM , 9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.CHK_YEAR      	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.CHK_ORDER     	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.CHK_TYPE      	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.BLD_NUM       	, 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.CHK_EMPID	    , 9 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.CHKER_NM     	, 12  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.CHK_YMD        	, 8 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.CHK_TIME      	, 6 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.GAS_LK      	, 1 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.PIPE_RUST  	    , 1 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.STAND_PIPE_PROTE_INST 	, 1 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.PIPE_CNT 	    , 3 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stStandPipChk.SEND_YN 	    , 1 + 1, DECRYPT );
		}
		
		// 2. ComboBox setting
		i = SearchCD( stStandPipChk.GAS_LK, SC_GASCHK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SC_GASCHK[0].Str);
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SC_GASCHK[i].Str);
		/* 20171012 이성근 차장님 요청
		i = SearchCD( stStandPipChk.PIPE_RUST, SC_GASCHK );
		
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), SC_GASCHK[0].Str);
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), SC_GASCHK[i].Str);
		*/
		i = SearchCD( stStandPipChk.STAND_PIPE_PROTE_INST, SCTIMER_COCK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), SCTIMER_COCK[0].Str);
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), SCTIMER_COCK[i].Str);

		// 3. Editer setting
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1) , stStandPipChk.PIPE_CNT );
		
Finally:
		DelSqLite(sql);
		return;
	}
	
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( m_bFirst == INIT_MAIN )
		{
			if( g_Dlgflag == 0 )
			{
				if( POINTING_UP == nAction )
				{
					if( theDevInfo.m_nType > FAMILY_PDA )
					{
						m_lActiveIndex = lActiveIndex;
						
						if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+570-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+640-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(400);
							}
						}
						else
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
						
						}
						
						ON_DRAW();
					}
				}
			}
			else
			{
				if( POINTING_UP == nAction )
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
			ON_DRAW();
		
		}
		
Finally:
		return;
	}

	
}
