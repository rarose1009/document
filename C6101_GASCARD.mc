/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_GASCARD
	Card Desc : 민원 가스 카드 결제
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_GASCARD
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
	#define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CARD_APPRO )		// 카드승인
		DEF_BUTTON_ID ( BID_RECEIVE )  			// 직수납
		DEF_BUTTON_ID ( BID_UP )				// 그리드 UP
		DEF_BUTTON_ID ( BID_DOWN )				// 그리드 DOWN
		DEF_BUTTON_ID ( BID_BEFO )				// 이전
		DEF_BUTTON_ID ( BID_NEXT )				// 다음
		DEF_BUTTON_ID ( BID_CLOSE )				// 닫기
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// 카드내에서 사용될 콘트롤 아이디 정의
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )				// 타이틀
		DEF_OBJECT_ID ( ICON_TITLE )			// 타이틀
		DEF_OBJECT_ID ( ST_ADJ )				// ST 정산금액
		DEF_OBJECT_ID ( TXT_ADJ )				// TXT 정산금액
		DEF_OBJECT_ID ( TXT_PAGE )				// TXT 미납금액테이블PAGE
		DEF_OBJECT_ID ( ST_AMT )				// ST 결제금액
		DEF_OBJECT_ID ( TXT_AMT )				// TXT 결제금액
		DEF_OBJECT_ID ( ST_APPRO_RSLT )			// ST 승인결과
		DEF_OBJECT_ID ( TXT_APPRO_RSLT )		// TXT 승인결과
		DEF_OBJECT_ID ( ST_ALLOTMENT_MM  )      // 할부
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( CMB_ALLOTMENT_MM  )     // 할부콤보
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// 기본정의 DLG화면 정의
	//---------------------------------------------------------------
	
	#define INIT_MAIN		1
	
	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;
	long m_lHist_Flag = 0;
	char m_sAllotment_mm[3];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void GaspayDraw(void);
	void setCardRslt(void);
	void setReceiveRslt(void);
	long Save_ApproCard(void);
	void Save_ApproCancelCard(void);
	
	void Snd_CardHist(long flag);
	void Rcv_Mcpay(void);
	long TR67061(void);
	long TR67062(void);
	
	void Run_Mcpay(long i);
	void Rcv_CardData(char* szCardData);
	
	long SearchStr( char *Str, CodeTable *CT);
	long SearchCD( char *CD, CodeTable *CT);
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5						// table의 행개수
	#define		COL 	    2						// table의 열개수
	#define		GRID_H		(CHT+23)				// table 행 높이
	#define		GRID_CLR	TRANSPARENT   			// table 클리어 color
	#define		GRID_X		STARTX 					// table 시작x좌표
	#define		MAXCHAR		31 			    		// table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+CHT*2-40	        // table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table마지막 row의 Y값
	
	#define 	SYH			(CHT+10)
	#define 	Line(x)	    (GRID_ENDY2+5+SYH*(x-1))
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	
	Column m_stGridTitle[] = {
		{"청구년월", CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"미납금액", CWD*28, EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
	};
	
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
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "가스요금 카드 결제"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_TEXT ( STARTX,     STARTY-29 , 300 , 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , ST_ADJ , "정산금액"),
		DLG_TEXT ( STARTX+300, STARTY-29 , 700 , 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADJ, ""),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_TEXT ( STARTX    , STARTY+415, 300,  71, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, ""),
		
		DLG_BUTTON(STARTX+300, STARTY+417, 350 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP,  "▲"),
		DLG_BUTTON(STARTX+650, STARTY+417, 350 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN,  "▼"),
		
		DLG_TEXT ( STARTX,	   STARTY+488, 300 , 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_AMT, "결제금액"),
		DLG_TEXT ( STARTX+300, STARTY+488, 700 , 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AMT, ""),
		
		DLG_TEXT ( STARTX,	   STARTY+553, 300 , 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_APPRO_RSLT, "승인결과"),
		DLG_TEXT ( STARTX+300, STARTY+553, 700 , 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPRO_RSLT, ""),
		
		DLG_TEXT ( STARTX,     STARTY+618, 300 , 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_ALLOTMENT_MM , "할부개월"),
		DLG_COMBO( STARTX+300, STARTY+618, 700 , 70, 189, 68, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_ALLOTMENT_MM, 3),
		
		DLG_BUTTON(STARTX,     STARTY+688, 1000, 72, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARD_APPRO,  ""),
		DLG_BUTTON(STARTX,     STARTY+760, 1000, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECEIVE,  ""),
		
		DLG_BUTTON(STARTX,     STARTY+830, 500 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BEFO,  "이전"),	
		DLG_BUTTON(STARTX+500, STARTY+830, 500 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXT,  "다음"),	
	};

	//┌─────────────────────────────────────┐
	//│ 				   『	OnInit Function  』  				              │
	//└─────────────────────────────────────┘
	void OnInit(char bFirst)
	{
		CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
		SetBtnImg();
		SetStyle();
		ReDraw();
		GaspayDraw();
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
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		long i;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_ADJ)		   , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADJ)       , EDITALIGN_MIDDLE|EDITALIGN_RIGHT  );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE)      , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AMT)        , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AMT)       , EDITALIGN_MIDDLE|EDITALIGN_RIGHT  );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_APPRO_RSLT) , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPRO_RSLT), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_ALLOTMENT_MM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), g_szGas_ApproRslt);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_APPRO_RSLT), TRUE, 3, EDITSEP_NONE );
		
		// 할부콤보 세팅
		for ( i = 0 ;  CK_CARDMM[i].Str[0] != 0 ; i++)
		{	
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ALLOTMENT_MM+2), CK_CARDMM[i].Str, 0, ICON_NONE);
		}
	}
	
	/*=======================================================================================
	함수명 : ReDraw
	기  능 : 화면을 다시 그린다.
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{
		long i = 0;
		char szSql[200];
		char szTmp[100];
		
		//가스카드승인 flag, = 0 카드승인, = 1 승인취소
		if(g_lGasCardFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CARD_APPRO), "카드승인");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_RECEIVE), TRUE);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CARD_APPRO), "승인취소");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_RECEIVE), FALSE);
		}
		
		//가스직수납 flag, = 0 직수납, = 1 직수납 취소
		if(g_lGasRecevieFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RECEIVE), "직수납");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_CARD_APPRO), TRUE);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RECEIVE), "직수납 취소");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_CARD_APPRO), FALSE);
		}
		
		// 할부콤보 세팅
		if( Str_Len(m_sAllotment_mm) == 0 )
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)m_sAllotment_mm, 0x00, sizeof(m_sAllotment_mm));
			
			SPRINT(szSql, "SELECT ALLOTMENT_MM FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetStr( szSql, 10, szTmp );
		
			if( Str_Len(szTmp) == 0 )
			{	
				Str_Cpy(m_sAllotment_mm, "00");
			}
			else
			{
				Str_Cpy(m_sAllotment_mm, szTmp);
			}
		}
		
		i = SearchCD( m_sAllotment_mm, CK_CARDMM );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), CK_CARDMM[i].Str);
				
		// 금액이 5만원 이상인 경우 할부 가능/카드 결제, 직수납 안한경우만 사용가능
		if( Str_AtoI( stMw.szCard_gaspay ) >= 50000 && g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0)
		{

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	함수명 : OnTask
	기  능 : 외부 앱 연동
	Param  : 
	Return : 
	========================================================================================*/ 
	void OnTask(long nEvent, long nData)
	{
		char* szCardData;
		long nRet = 0;
	
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_IC_CARD )
			{
				//시스템콜
				szCardData = (char*)System_GetResult((char*)&nRet);
				
				//아래 주석을 풀면 결과 데이터를 json 파일로 저장 할 수 있음(저장위치 : smart/SND.json)
				//g_Save_JsonFile(szCardData);
		
				//결과 저장
				Rcv_CardData(szCardData);
			}
		}
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{
		switch(ID)
		{
			case BID_CLOSE:
				/* 가스 + 일회성 */
				if(Str_AtoI(stMw.szCard_gaspay) > 0 || g_lOneCardPageFlag == 0 )
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 && g_lOneCardFlag == 0 && g_lOneRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 카드승인을 취소하세요");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 직수납을 취소하세요");
						}
						else if (g_lOneCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "일회성요금 카드승인을 취소하세요");
						}
						else if (g_lOneRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "일회성요금 직수납을 취소하세요");
						}
					}
				}
				/* 가스 */
				else
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 카드승인을 취소하세요");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 직수납을 취소하세요");
						}
					}
				}
				break;
				
			case BID_CARD_APPRO:
				setCardRslt();
				break;
				
			case BID_RECEIVE:
				setReceiveRslt();
				break;
				
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					break;
				}
				GaspayDraw();
				break;
						
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					break;
				}
				GaspayDraw();
				break;
			
			case BID_BEFO:
				/* 가스 + 일회성 */
				if(Str_AtoI(stMw.szCard_gaspay) > 0 || g_lOneCardPageFlag == 0)
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 && g_lOneCardFlag == 0 && g_lOneRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 카드승인을 취소하세요");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 직수납을 취소하세요");
						}
						else if (g_lOneCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "일회성요금 카드승인을 취소하세요");
						}
						else if (g_lOneRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "일회성요금 직수납을 취소하세요");
						}
					}
				}
				/* 가스 */
				else
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 카드승인을 취소하세요");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "가스요금 직수납을 취소하세요");
						}
					}
				}
				break;

			case BID_NEXT:
				// 일회성 카드요금이 있는 경우
				if(g_lOneCardPageFlag == 0)
				{
					Card_Move("C6101_ONECARD");
				}
				// 가스요금만 있는 경우
				else
				{	
					if( g_lGasCardFlag == 1 || g_lGasRecevieFlag == 1 )
					{
						Card_Move("C6101_WSIGN");
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "카드결제 혹은 직수납을 해주세요.");
					}
				}
				break;
		}
	}
	
	//----------------------------------------------------------------------
	//함수명 : SearchStr
	//기  능 : 스트링으로 코드인덱스를 찾는다.
	//Param  : 
	//Return : 코드인덱스, 없으면 -1
	//----------------------------------------------------------------------
	long SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	//----------------------------------------------------------------------
	//함수명 : SearchCD
	//기  능 : 코드값으로 코드인덱스를 찾는다.
	//Param  : 
	//Return : 코드인덱스, 없으면 -1
	//----------------------------------------------------------------------
	long SearchCD( char *CD, CodeTable *CT)
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
	함수명 : GaspayDraw
	기  능 : 정산금액 && 가스요금 테이블 Setting && 결제금액
	Param  : 
	Return : 
	========================================================================================*/
	void GaspayDraw(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		long lstartidx;
		long account = 0;
		long amt = 0;
		long mtrCnt , nonPayCnt , amtChkYn;
		char sztmp[100];
		char szSql[300];
		char szbuf[51];
		char szCardChk[20];
		char * sqlstr1 = "";		
		bool ret = TRUE;	
		handle* sql1 = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		/* 정산금액 */
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(szSql, "SELECT ACCOUNT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1'", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &account);
		Str_ItoA( account, sztmp, 10 );
		Str_Chg( sztmp, STRCHG_INS_COMMA );
		Str_Cat(sztmp, "원");
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_ADJ ), sztmp );

		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// Mem_Set( (byte*)szCardChk, 0x00, sizeof(szCardChk) );
		// SPRINT(szSql, "SELECT ADJ_AMT_YN C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0   );
		// g_Sql_RetStr( szSql, 9 , szCardChk );

		// if( Str_Cmp( szCardChk, "Y") == 0 )
		// {
		mtrCnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN ='1' AND CARD_YN = '1'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &mtrCnt );

		nonPayCnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_YN = '1'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &nonPayCnt );
		
		amtChkYn = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_YN = '1' AND AMT_CHK_YN ='Y'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &amtChkYn );
		// }

		/* 결제금액 */
		PRINT("amtChkYnamtChkYnamtChkYnamtChkYnamtChkYn :%d",amtChkYn,0,0);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if(amtChkYn > 0)
		{
			PRINT("AAAAAAAAAAAAAAAAAA",0,0,0);
			SPRINT(szSql, "SELECT SUM(AMT) AS AMT \
					     FROM ( SELECT CASE WHEN AMT_CHK_YN ='Y' THEN SUB_ACCOUNT WHEN AMT_CHK_YN ='N' THEN ACCOUNT END AS AMT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' \
							     UNION ALL \
							    SELECT SUM(SUB_UNPAY_AMT) AS AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' AND AMT_CHK_YN ='Y')", g_szCHK_EXEC_NUM, g_szCHK_EXEC_NUM, 0);
		}
		else
		{
			PRINT("BBBBBBBBBBBBBBBBB",0,0,0);
			SPRINT(szSql, "SELECT SUM(AMT) AS AMT \
					     FROM ( SELECT CASE WHEN AMT_CHK_YN ='Y' THEN SUB_ACCOUNT WHEN AMT_CHK_YN ='N' THEN ACCOUNT END AS AMT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' \
							     UNION ALL \
							    SELECT SUM(UNPAY_AMT) AS AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' AND IFNULL(AMT_CHK_YN,'N')  ='N')", g_szCHK_EXEC_NUM, g_szCHK_EXEC_NUM, 0);

		}
		
		g_Sql_RetInt(szSql, &amt);
		PRINT("szSqlszSqlszSqlszSql : %s",szSql,0,0);
		Str_ItoA( amt, sztmp, 10 );
		PRINT("amtamtamtamtamtamt : %d",amt,0,0);
		Str_Chg( sztmp, STRCHG_INS_COMMA );
		Str_Cat(sztmp, "원");
		PRINT("sztmpsztmpsztmpsztmp : %s",sztmp,0,0);
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_AMT ), sztmp );

		/* 미납금액 PAGE */
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1'", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(sztmp, "%d/%d", m_lpage+1, m_lTotpage,0);
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_PAGE ), sztmp );

		/* 미납금액 */
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		amtChkYn = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_YN = '1' AND AMT_CHK_YN ='Y'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &amtChkYn );

		PRINT("00000000000000000000 : %d",amtChkYn,0,0);

		if(amtChkYn > 0)
		{
			PRINT("여기들어옴 111",0,0,0);
			hstmt = sql->CreateStatement(sql, "SELECT REQ_YM, SUB_UNPAY_AMT AS UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND CARD_LIST_YN = '1' ORDER BY REQ_YM DESC LIMIT ?, ?");
		}
		else
		{
			PRINT("여기들어옴 222",0,0,0);
			hstmt = sql->CreateStatement(sql, "SELECT REQ_YM, UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND CARD_LIST_YN = '1' ORDER BY REQ_YM DESC LIMIT ?, ?");
		}
		
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);
		lstartidx = m_lpage*ROW;
		
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				k = i + 1;
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 8, DECRYPT);
				g_Str_DateType(szbuf, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, szbuf );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				Str_Cat( sztmp, "원" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			}
		}
Finally:

		DelSqLite(sql);
		ON_DRAW();	
	}
	
	/*=======================================================================================
	함수명 : setCardRslt
	기  능 : 승인버튼 클릭시 카드결제 결과 가져옴
	Param  : 
	Return : 
	========================================================================================*/
	void setCardRslt(void)
	{
		// g_lGasCardFlag 가스카드승인 flag, = 0 카드승인, = 1 승인취소
		// Snd_CardHist, = 1 : 카드승인 시도, = 2 : 카드승인 완료, = 3 : 카드취소완료, = 4 : 카드취소 시도
		if(g_lGasCardFlag == 0)
		{
			// 사전 HIST 등록
			Snd_CardHist(1);
		}
		else
		{
			// 사전 HIST 등록
			Snd_CardHist(4);
		}
	}
	
	/*=======================================================================================
	함수명 : setReceiveRslt
	기  능 : 직수납 결제 결과 가져옴
	Param  : 
	Return : 
	========================================================================================*/
	void setReceiveRslt(void)
	{
		handle* sql1 = NULL;
		handle* sql2 = NULL;
		char * sqlstr1 = "";
		char * sqlstr2 = "";
		char szSql[300];
		char szMtrnum[10];

		long gasnonpay = 0;
		long gasacconut = 0;
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT MTR_NUM FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr( szSql, 10, szMtrnum );

		//가스직수납 flag, = 0 직수납, = 1 직수납 취소
		if(g_lGasRecevieFlag == 0)
		{
			// 1.정산금액
			sql1 = STRING_Create(sqlstr1);
			STRING_Empty(sql1);
			STRING_Append(sql1,"UPDATE C6101_PROMISE_MTR");
			STRING_Append(sql1,"   SET CHK_YN = '1'");
			STRING_Append(sql1,"     , CARD_YN = '0'");
			STRING_Append(sql1," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql1, g_szCHK_EXEC_NUM );
			STRING_Append(sql1,"'  AND MTR_NUM = '");
			STRING_Append(sql1, szMtrnum );
			STRING_Append(sql1,"'  AND CARD_YN = '1'");
			sqlstr1 = STRING_toString(sql1);
			g_Sql_DirectExecute(sqlstr1);
			STRING_Finalize(sql1);
			
			// 2.미납금액
			sql2 = STRING_Create(sqlstr2);
			STRING_Empty(sql2);
			STRING_Append(sql2,"UPDATE C6101_NONPAY");
			STRING_Append(sql2,"   SET CHK = '1'");
			STRING_Append(sql2,"     , CARD_YN = '0'");
			STRING_Append(sql2," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql2, g_szCHK_EXEC_NUM );
			STRING_Append(sql2,"'  AND MTR_NUM = '");
			STRING_Append(sql2, szMtrnum );
			STRING_Append(sql2,"'  AND CARD_YN = '1'");
			sqlstr2 = STRING_toString(sql2);
			g_Sql_DirectExecute(sqlstr2);
			STRING_Finalize(sql2);
						
			Mem_Set( (byte*)stMw.szCash_gaspay, 0x00, sizeof(stMw.szCash_gaspay) );
			Str_Cpy(stMw.szCash_gaspay, stMw.szCard_gaspay);
			
			Mem_Set( (byte*)stMw.szCard_gaspay, 0x00, sizeof(stMw.szCard_gaspay) );
			Str_Cpy(stMw.szCard_gaspay, "0");

			MessageBoxEx (CONFIRM_OK, "가스요금이 직수납 처리되었습니다.");
			g_lGasRecevieFlag = 1;
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "직수납 완료");
			Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
			Str_Cpy(g_szGas_ApproRslt,"직수납 완료");
		}
		else
		{	
			// 1.정산금액
			sql1 = STRING_Create(sqlstr1);
			STRING_Empty(sql1);
			STRING_Append(sql1,"UPDATE C6101_PROMISE_MTR ");
			STRING_Append(sql1,"   SET CARD_YN = '1' ");
			STRING_Append(sql1," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql1, g_szCHK_EXEC_NUM );
			STRING_Append(sql1,"'  AND MTR_NUM = '");
			STRING_Append(sql1, szMtrnum );
			STRING_Append(sql1,"'  AND CHK_YN = '1'");
			STRING_Append(sql1,"   AND CARD_YN = '0'");
			sqlstr1 = STRING_toString(sql1);
			g_Sql_DirectExecute(sqlstr1);
			STRING_Finalize(sql1);

			// 2.미납금액
			sql2 = STRING_Create(sqlstr2);
			STRING_Empty(sql2);
			STRING_Append(sql2,"UPDATE C6101_NONPAY ");
			STRING_Append(sql2,"   SET CARD_YN = '1' ");
			STRING_Append(sql2," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql2, g_szCHK_EXEC_NUM );
			STRING_Append(sql2,"'  AND MTR_NUM = '");
			STRING_Append(sql2, szMtrnum );
			STRING_Append(sql2,"'  AND CHK = '1'");
			STRING_Append(sql2,"   AND CARD_YN = '0'");
			sqlstr2 = STRING_toString(sql2);
			g_Sql_DirectExecute(sqlstr2);
			STRING_Finalize(sql2);
			
			Mem_Set( (byte*)stMw.szCard_gaspay, 0x00, sizeof(stMw.szCard_gaspay) );
			Str_Cpy(stMw.szCard_gaspay, stMw.szCash_gaspay);
			
			Mem_Set( (byte*)stMw.szCash_gaspay, 0x00, sizeof(stMw.szCash_gaspay) );
			Str_Cpy(stMw.szCash_gaspay, "0");

			MessageBoxEx (CONFIRM_OK, "가스요금이 직수납 취소 처리되었습니다.");
			g_lGasRecevieFlag = 0;
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "");
			Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
			Str_Cpy(g_szGas_ApproRslt,"");
		}
		
		ReDraw();
	}

	/*=======================================================================================
	함수명 : Save_ApproCard
	기  능 : C6101_PROMISE_CARD DB에 데이터를 담는다. [ 카드 승인 ]
	Param  : 
	Return : 
	========================================================================================*/
	long Save_ApproCard(void)
	{
		long Cnt, idx;
		bool rtn = FALSE;
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;

		Cnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &Cnt );

		sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( Cnt > 0 )
		{

			hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_CARD \
											      SET REQ_YMD = ?, RECEV_SEQ = ?, TERMINAL_NUM = ?, CARD_NUM = ?, VALID_YM = ? \
													, ALLOTMENT_MM = ?, DATA_FLAG = ?, ITEM_FLAG = ?, APPROVAL_AMT = ?, RSLT_CD = 'O' \
													, APPROVAL_NUM = ?, APPROVAL_TIME = ?, CARD_COM = ?, CARD_TYPE_NM = ?, BUYING_COMP = ? \
													, BUYING_COMP_NM = ?, UPD_EMPID = ?, UPD_IP = ? \
											    WHERE PROMISE_ASSIGN_SEQ = ? AND ITEM_FLAG = '10'");
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szReq_ymd       ,8  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szRecev_seq     ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTerminal_num  ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_num      ,128,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szValid_ym      ,4  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szAllotment_mm  ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szData_flag     ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szItem_flag     ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_amt  ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_num  ,12 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_time ,14 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_com      ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_type_nm  ,50 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp   ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp_nm,50 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,20 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,15 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM           ,10 ,DECRYPT);
		}
		else
		{

			hstmt = sql->CreateStatement(sql, "INSERT INTO C6101_PROMISE_CARD \
											   ( PROMISE_ASSIGN_SEQ, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, USE_CONT_NUM, ITEM_FLAG \
											   , REQ_YMD, RECEV_SEQ, TERMINAL_NUM, CARD_NUM, VALID_YM \
											   , ALLOTMENT_MM, APPROVAL_AMT, DATA_FLAG, APPROVAL_NUM, APPROVAL_TIME \
											   , CARD_COM, CARD_TYPE_NM, BUYING_COMP, BUYING_COMP_NM, UPD_EMPID \
											   , UPD_IP, RSLT_CD \
											   ) \
											   VALUES \
											   ( ?, ?, ?, ?, ? \
											   , ?, ?, ?, ?, ? \
											   , ?, ?, ?, ?, ? \
											   , ?, ?, ?, ?, ? \
											   , ?, 'O' ) ");

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM                     ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCivil_serv_receive_num  ,14 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTreat_seq               ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szUse_cont_num            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szItem_flag               ,2  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szReq_ymd                 ,8  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szRecev_seq               ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTerminal_num            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_num                ,128,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szValid_ym                ,4  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szAllotment_mm            ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_amt            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szData_flag               ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_num            ,12 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_time           ,14 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_com                ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_type_nm            ,50 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp             ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp_nm          ,50 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id             ,20 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip                  ,15 ,DECRYPT);

		}

		if(hstmt == NULL)
		{
			MessageBoxEx (ERROR_OK, "카드결제정보 저장에 실패했습니다.");
			goto Finally;
		}
		else
		{
			if(sql->Execute(sql) == FALSE)
			{
				MessageBoxEx (ERROR_OK, "카드결제정보 저장에 실패했습니다.");
				goto Finally;
			}
		}
		rtn = TRUE;

Finally	:
		//sql->Commit(sql);
		DelSqLite(sql);
		return rtn;
	}
	
	/*=======================================================================================
	함수명 : Save_ApproCancelCard
	기  능 : C6101_PROMISE_CARD DB에 데이터를 담는다. [ 카드 취소 ]
	Param  : 
	Return : 
	========================================================================================*/
	void Save_ApproCancelCard(void)
	{
		handle* sql;
		char * sqlstr = "";
		char szSql[300];

		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," DELETE FROM C6101_PROMISE_CARD  ");
		STRING_Append(sql,"  WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stCardinfo.szPromise_assign_seq );
		STRING_Append(sql,"'   AND ITEM_FLAG = '10' ");
		sqlstr = STRING_toString(sql);
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
	}
	
	/*=======================================================================================
	함수명 : Snd_CardHist
	기  능 : Snd_CardHist, = 1 : 카드승인 시도, = 2 : 카드승인 완료, = 3 : 카드취소완료, = 4 : 카드취소 시도
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_CardHist(long flag)
	{
		char szTmp[100];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		char szUcovert[100];
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		m_lHist_Flag = flag;
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		
		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66706, FALSE);
		
		// 카드 승인 시도, 카드취소 시도
		if(flag == 1 || flag == 4)
		{
			JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"     , stMw.szPromise_assign_seq    	   );
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num" , stMw.szCivil_serv_receive_num     );
			JSON_SetValue( g_pjcomm, 'C', "treat_seq"			   , stMw.szTreat_seq  		   		   );
			JSON_SetValue( g_pjcomm, 'C', "item_flag"			   , "10"			   				   );
			JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   , stUserinfo.szcard_term_id1		   );
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , "*"     			           	   );
		}
		// 카드 승인 완료, 카드 취소 완료
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"     , stMw.szPromise_assign_seq         );
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num" , stMw.szCivil_serv_receive_num     );
			JSON_SetValue( g_pjcomm, 'C', "treat_seq"			   , stMw.szTreat_seq  		           );
			JSON_SetValue( g_pjcomm, 'C', "item_flag"			   , "10"			                   );
			JSON_SetValue( g_pjcomm, 'C', "rslt_cd"			       , "O"			   				   );
			JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   , stCardinfo.szTerminal_num 		   );
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , stCardinfo.szCard_num			   );
			JSON_SetValue( g_pjcomm, 'C', "valid_ym"			   , stCardinfo.szValid_ym			   );
			JSON_SetValue( g_pjcomm, 'C', "allotment_mm"		   , stCardinfo.szAllotment_mm		   );
			
			JSON_SetValue( g_pjcomm, 'C', "card_com"		       , stCardinfo.szCard_com		       );
			JSON_SetValue( g_pjcomm, 'C', "buying_comp"		       , stCardinfo.szBuying_comp		   );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szCard_type_nm );
			JSON_SetValue( g_pjcomm, 'C', "card_type_nm"		   , szTmp		   );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szBuying_comp_nm );
			JSON_SetValue( g_pjcomm, 'C', "buying_comp_nm"		   , szTmp		   );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "approval_amt"		   , stMw.szCard_gaspay 		  		   );
		
		// 카드승인 시도
		if( flag == 1 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "10"	 );	
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "1"     );	
		}
		// 카드승인 완료
		else if( flag == 2 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "10"	 );	
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "2"     );	
			JSON_SetValue( g_pjcomm, 'C', "approval_num"		   , stCardinfo.szApproval_num		   );
			JSON_SetValue( g_pjcomm, 'C', "approval_time"		   , stCardinfo.szApproval_time		   );
		}		
		// 카드취소 완료
		else if( flag == 3 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "20"	 );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "3"     );	
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_num"	   , stCardinfo.szApproval_cancel_num     );	
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_date"   , stCardinfo.szApproval_cancel_date    );	
			
		}
		// 카드취소 시도
		else if( flag == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "20"	 );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "4"     );	
		}

		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		if(flag == 2 || flag == 3)
		{
			callBackfunc = TR67061;
		}
		else
		{
			callBackfunc = TR67062;
		}

		HTTP_DownloadData( szUrl, "FR66706_IN",  "FR66706" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : TR67061
	기  능 : 카드 승인 후 hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67061(void)
	{
		g_Sock_Close();
		CloseMessageBox();
			
		if(g_Chk_Json(66706) >= 0)
		{
			if ( m_lHist_Flag == 3)
			{
				g_lGasCardFlag = 0;
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "승인취소");
				Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
				Str_Cpy(g_szGas_ApproRslt,"승인취소");
			}
			else
			{
				if( Save_ApproCard() ) 
				{
					g_lGasCardFlag = 1;
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "승인완료");
					Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
					Str_Cpy(g_szGas_ApproRslt,"승인완료");	
				}
				else
				{
					g_lGasCardFlag = 0;
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "승인실패 : DB ERROR");
					Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
					Str_Cpy(g_szGas_ApproRslt,"승인실패 : DB ERROR");
				}
			}
			
			ReDraw();
			
			return 1;
		}
		else
		{	
			ON_DRAW();
			
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : TR67061
	기  능 : 카드 승인 전 hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67062(void)
	{
		char szSql[350];
		
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(66706) >= 0)
		{
			Rcv_Mcpay();
			
			return 1;
		}
		else
		{
			ON_DRAW();
			
			return -1;
		}	
		
	}
	/*=======================================================================================
	함수명 : Rcv_Mcpay
	기  능 : Mcpay 작동 function
	Param  : 
	Return : 
	========================================================================================*/
	void Rcv_Mcpay(void)
	{
		// 가스카드승인 flag, = 0 카드승인, = 1 승인취소
		// Snd_CardHist, = 1 : 카드승인 시도, = 2 : 카드승인 완료, = 3 : 카드취소완료, = 4 : 카드취소 시도
		if(g_lGasCardFlag == 0)
		{
			Run_Mcpay(0);
		}
		else
		{
			Run_Mcpay(1);
		}

		ReDraw();
	}

	/*=======================================================================================
	함수명 : Run_Mcpay
	기  능 : Run_Mcpay 활성화
	Param  : 0 = 승인, 1 = 취소
	Return : 
	========================================================================================*/
	void Run_Mcpay(long i)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;
	
		char szSql[100];
		char szTmp[100];
		
		char card_receipt_YN[2];

		Mem_Set( (byte*)card_receipt_YN, 0x00, sizeof(card_receipt_YN) );
		// 영수증 발급문의
		if( MessageBoxEx (CONFIRM_YESNO, "카드 결제 간이영수증을\n발행하시겠습니까?")  == MB_OK)
		{						
			Str_Cpy(card_receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(card_receipt_YN, "N");		
		}
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hdata	, 'C', "receiptyn"			, card_receipt_YN);
			
			// 승인
			if( i == 0)
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "creditAppr");
				JSON_SetValue	(hdata	, 'C', "desc"				, "신용결제");
				JSON_SetValue	(hdata	, 'C', "bussno"				, "1098131605");
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stMw.szCard_gaspay);
				JSON_SetValue	(hdata	, 'C', "tax"				, "0");
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");

				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) );
				i = SearchStr( szTmp, CK_CARDMM );
				
				if (i > -1)
				{
					JSON_SetValue	(hdata	, 'C', "inst"		    , CK_CARDMM[i].Code);
					
					Mem_Set((byte*)m_sAllotment_mm, 0x00, sizeof(m_sAllotment_mm));
					Str_Cpy(m_sAllotment_mm, CK_CARDMM[i].Code);
				}
				
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, "");
				JSON_SetValue	(hdata	, 'C', "approvalno"			, "");
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id1);
				
			}
			// 취소
			else if( i == 1 )
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "creditVoid");
				JSON_SetValue	(hdata	, 'C', "desc"				, "신용취소");
				JSON_SetValue	(hdata	, 'C', "bussno"				, "1098131605");
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stMw.szCard_gaspay);
				JSON_SetValue	(hdata	, 'C', "tax"				, "0");
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");
				
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SPRINT(szSql, "SELECT ALLOTMENT_MM FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr( szSql, 10, szTmp );
				JSON_SetValue	(hdata	, 'C', "inst"				, szTmp);
				
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");

				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SPRINT(szSql, "SELECT SUBSTR(APPROVAL_TIME,3,6) FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr( szSql, 10, szTmp );
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, szTmp);
				
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SPRINT(szSql, "SELECT APPROVAL_NUM FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr( szSql, 10, szTmp );
				JSON_SetValue	(hdata	, 'C', "approvalno"			, szTmp);
				
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id1);
			}
			
			JSON_SetValue	(h		, 'C', "method"				, "IC_CardPay");
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
		return;
	
	}
	
	/*=======================================================================================
	함수명 : Rcv_CardData
	기  능 : MCPAY RETRUN
	Param  : 
	Return : 
	========================================================================================*/ 
	void Rcv_CardData(char* szCardData)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lRet = 0;
		long lCnt = 0;
		char *szitem;
		char *szData;
		long *nCol;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 0;
		handle hItem = NULL;
		handle hData = NULL;
	
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCardData ) ;

			Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));

			if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "null") == 0 )
			{
				Str_ItoA( Time_GetDate(),  stCardinfo.szReq_ymd  , 10);
				Str_Cpy( stCardinfo.szPromise_assign_seq     , stMw.szPromise_assign_seq     				);
				Str_Cpy( stCardinfo.szCivil_serv_receive_num , stMw.szCivil_serv_receive_num 				);
				Str_Cpy( stCardinfo.szTreat_seq              , stMw.szTreat_seq              				);
				Str_Cpy( stCardinfo.szUse_cont_num           , stMw.szUse_cont_num           	   			);
				Str_Cpy( stCardinfo.szRecev_seq              , "001"                                    	);
				Str_Cpy( stCardinfo.szItem_flag     		 , "10"							                );
				Str_Cpy( stCardinfo.szTerminal_num  		 , JSON_GetValue(hItem, "tid",   	    szType) );
				Str_Cpy( stCardinfo.szApproval_amt 			 , JSON_GetValue(hItem, "totalamount", szType) );
				
				// 할부
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM) ) );
				i = SearchStr( szTmp, CK_CARDMM );
				if ( i > -1 )
				{
					Str_Cpy( stCardinfo.szAllotment_mm, CK_CARDMM[i].Code );
				}

				Str_Cpy( stCardinfo.szCard_num		, JSON_GetValue (hItem, "cardno",   szType) );
				Str_Cpy( stCardinfo.szCard_type_nm	, JSON_GetValue (hItem, "cardname", szType) );
				Str_Cpy( stCardinfo.szValid_ym		, "0000" 						 			);
				
				if( g_lGasCardFlag == 0 )
				{
					Str_Cpy( stCardinfo.szData_flag 			 , "10" ); 	
					Str_Cpy( stCardinfo.szApproval_num			 , JSON_GetValue (hItem, "approvalno",	szType) );
					Str_Cpy( stCardinfo.szApproval_time			 , JSON_GetValue (hItem, "approvaldate",szType) );
				}
				else
				{
					Str_Cpy( stCardinfo.szData_flag 			 , "20" 	);
					Str_Cpy( stCardinfo.szApproval_cancel_num			 ,  JSON_GetValue (hItem, "approvalno",    	szType) );
					Str_Cpy( stCardinfo.szApproval_cancel_date			 ,  JSON_GetValue (hItem, "approvaldate",   szType) );
				}	

				Str_Cpy( stCardinfo.szCard_com				 , JSON_GetValue (hItem, "code2",    	szType) 						 );	
				Str_Cpy( stCardinfo.szBuying_comp			 , JSON_GetValue (hItem, "code1",    	szType)							 );
				Str_Cpy( stCardinfo.szBuying_comp_nm		 ,  JSON_GetValue (hItem, "purchasename",    	szType) );

				if( g_lGasCardFlag == 0 )
				{	
					Snd_CardHist(2);
				}
				else
				{
					Save_ApproCancelCard();
					Snd_CardHist(3);	
				}
			}
			else
			{
				if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "M016") == 0 )
				{
					Card_Move("C6101_WPAY");
					return;	
				}
				
				if( g_lGasCardFlag == 0 )
				{
					g_lGasCardFlag = 0;
					
					Str_Cpy( szTmp, "승인실패 : ");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultcode",  		szType));
					Str_Cat( szTmp, "\n");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultmsg",  		szType));
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), szTmp);
					Mem_Set( (byte*)g_szOne_ApproRslt, 0x00, sizeof(g_szOne_ApproRslt) );
					Str_Cpy(g_szOne_ApproRslt, szTmp);
					
					
				}
				else
				{
					g_lGasCardFlag = 1;
					
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy( szTmp, "취소실패 : ");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultcode",  		szType));
					Str_Cat( szTmp, "\n");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultmsg",  		szType));
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), szTmp);
					Mem_Set( (byte*)g_szOne_ApproRslt, 0x00, sizeof(g_szOne_ApproRslt) );
					Str_Cpy(g_szOne_ApproRslt, szTmp);
				}	
			}
		}
	
		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
	
		g_Close_SubDlg();
	
		ON_DRAW();
		return;
	}
}
