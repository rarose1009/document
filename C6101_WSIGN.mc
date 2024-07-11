/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_WSIGN
	Card Desc : 민원 서명
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_WSIGN
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
//	#define USE_ON_TASK
	
	#include "DefEvent.h"
	#include "ArrayList.c"
	
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
		
		// 서명
		DEF_BUTTON_ID ( BID_CLOSE )			// 닫기
		DEF_BUTTON_ID ( BID_SAVE )			// 저장
		DEF_BUTTON_ID ( BID_SIGN )			// 서명
		DEF_BUTTON_ID ( BID_CHK_CONFIRM )	// 정보활용동의
		DEF_BUTTON_ID ( BID_USE_AGREE )		// 유선방송동의
	
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		
		// 타이틀
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		
		// 서명
		DEF_OBJECT_ID ( TXT_GAS_ST )		// 가스
		DEF_OBJECT_ID ( TXT_ONE_ST )		// 일회성
		DEF_OBJECT_ID ( TTL_CARD )			// 카드
		DEF_OBJECT_ID ( TTL_CARDGASPAY )	// 카드가스금액
		DEF_OBJECT_ID ( TXT_CARDGASPAY )	// 카드가스금액
		DEF_OBJECT_ID ( TTL_CARDONEPAY )	// 카드일회성금액
		DEF_OBJECT_ID ( TXT_CARDONEPAY )	// 카드일회성금액
		DEF_OBJECT_ID ( TTL_CARD_TOTAL )	// 카드총금액
		DEF_OBJECT_ID ( TXT_CARD_TOTAL )	// 카드총급액
		DEF_OBJECT_ID ( TTL_CASH )			// 현금
		DEF_OBJECT_ID ( TTL_CASHGASPAY )	// 현금가스금액
		DEF_OBJECT_ID ( TXT_CASHGASPAY )	// 현금가스금액
		DEF_OBJECT_ID ( TTL_CASHONEPAY )	// 현금일회성금액
		DEF_OBJECT_ID ( TXT_CASHONEPAY )	// 현금일회성금액
		DEF_OBJECT_ID ( TTL_CASH_TOTAL )	// 현금총금액
		DEF_OBJECT_ID ( TXT_CASH_TOTAL )	// 현금총금액
		DEF_OBJECT_ID ( TTL_TOT_AMT )		// 총금액
		DEF_OBJECT_ID ( TXT_TOT_AMT )		// 총금액
		
		DEF_OBJECT_ID ( TTL_SERVADD1 )
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN		1	
	#define CHK_CONFIRM_Y1	"정보활동 동의□"
	#define CHK_CONFIRM_Y2	"정보활동 동의▣"
	#define USE_AGREE_Y1	"유선방송 신청동의□"
	#define USE_AGREE_Y2	"유선방송 신청동의▣"
	#define SYH				(CHT+25)
	#define Line(x)			(STARTY+SYH*(x-1))
	
	#define CARD_SIGN_BYTES_PER_LINE	16
	#define CARD_SIGN_WIDTH 			(CARD_SIGN_BYTES_PER_LINE * 8)
	#define CARD_SIGN_HEIGHT 			64
	#define CARD_WBMP_SIZE				1029
	#define CARD_BMP_SIZE				1086

	enum
	{
		PRINT_BILL = 1,
		PRINT_CARD_APRO,
		PRINT_CARD_CANCEL
		
	} PRINT_PAY_STAT;	
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------	
	long m_nPrintFlag = PRINT_BILL;
	long m_bFirst;
	
	long m_nUse_agree;
	bool m_bPrintAgain = FALSE;
	
	CARRAYLIST m_pList = NULL;
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	long Save_Assign(void);
	long Save_Sign(void);

	long Print_Result(void* p);
	void Bill_Pirnt(void);
	void* Bill_Pirnt_GetData(void);

	void Snd_RstMin(void);
	long Load_Assign(char* assign_seq);
	long Rcv_RstMIn(void);
	long Add_Bo(handle pj);
	long Add_Bur(handle pj);
	long Add_Once(handle pj);
	long Add_Mtr(handle pj);
	long Add_ChgMtr(handle pj);			// 서명+사진추가한다.
	long Add_Nonpay(handle pj);			// 정산데이터 추가한다.
	long Add_CardInfo(handle pj);		// 카드결재 결과를 추가한다.
	long Add_OneCardInfo(handle pj);	// 일회성카드결재 결과
	long Add_Chk(handle pj);

	long png_getbmp(long width, long height, byte* img );
	
	long GetUtf8Size(char* str, long chklen);

	long Rcv_62604(void);
	long TR62604(void);	
	long Chk_Json_62604(void);
	
	void Snd_Info_Trans(void);
	long Rcv_Info_Trans(void);
	
	long Move_card(void);
	
	//---------------------------------------------------------------------------------------
	// 서명 다이얼로그
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "서 명"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_TEXT( STARTX,     Line(1),  125, SYH*3, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, SKYBLUE, TTL_CARD, "카\n드"),

		DLG_TEXT( STARTX+125, Line(1),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LEMONCHIFFON, TTL_CARDGASPAY, "가스요금"),
		DLG_TEXT( STARTX+340, Line(1),  540, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARDGASPAY, ""),
		DLG_TEXT( STARTX+880, Line(1),  120, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GAS_ST, ""),
		
		DLG_TEXT( STARTX+125, Line(2),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LEMONCHIFFON, TTL_CARDONEPAY, "일회성"),
		DLG_TEXT( STARTX+340, Line(2),  540, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARDONEPAY, ""),
		DLG_TEXT( STARTX+880, Line(2),  120, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ONE_ST, ""),
		
		DLG_TEXT( STARTX+125, Line(3),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTCYAN, TTL_CARD_TOTAL, "합계"),
		DLG_TEXT( STARTX+340, Line(3),  660, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CARD_TOTAL, ""),

		DLG_TEXT( STARTX,     Line(4)+40,  125, SYH*3, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, SKYBLUE, TTL_CASH, "현\n금"),
		DLG_TEXT( STARTX+125, Line(4)+40,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LEMONCHIFFON, TTL_CASHGASPAY, "가스요금"),
		DLG_TEXT( STARTX+340, Line(4)+40,  660, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CASHGASPAY, ""),
		DLG_TEXT( STARTX+125, Line(5)+40,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LEMONCHIFFON, TTL_CASHONEPAY, "일회성"),
		DLG_TEXT( STARTX+340, Line(5)+40,  660, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CASHONEPAY, ""),
		DLG_TEXT( STARTX+125, Line(6)+40,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTCYAN, TTL_CASH_TOTAL, "합계"),
		DLG_TEXT( STARTX+340, Line(6)+40,  660, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CASH_TOTAL, ""),
		
		DLG_TEXT( STARTX+125, Line(7)+80,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTSALMON, TTL_TOT_AMT, "총 합 계"),
		DLG_TEXT( STARTX+340, Line(7)+80,  660, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_AMT, ""),
		
		DLG_BUTTON(STARTX,      Line(8)+120,  470, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHK_CONFIRM,  CHK_CONFIRM_Y1),
		DLG_BUTTON(STARTX+530,  Line(8)+120,  470, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_USE_AGREE,  USE_AGREE_Y1),

		DLG_BUTTON(STARTX,      Line(10)+193-29,  1000, SYH+10, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "서명"),
		DLG_BUTTON(STARTX,  Line(11)+203-29, 1000, SYH+10, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "저장"),
	};	
	
	//---------------------------------------------------------------------------------------
	//	main
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
	    long lCnt;	
	
		m_bFirst = bFirst;
		
		CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
		
		SetBtnImg();
		SetStyle();
		ReDraw();
	}
	
	/*=======================================================================================
	함수명 : OnButton
	기  능 : 버튼 이벤트 정의
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		char szSql[300];
		char sztmp[100];
		long ret;
		long gasAmt = 0;

		switch(ID)
		{
					
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "업무 메뉴로 나가시겠습니까?")  == MB_OK)
				{
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
								
			case GID_PREV:
				Card_Move("C6101_WPAY");
				break;
				
			case GID_VMEXIT:
				g_Exit();
				break;
				
			// 정보활용동의
			case BID_CHK_CONFIRM:
				if( stMw.szInfo_use_agree_yn[0] == 'Y' )
				{
					stMw.szInfo_use_agree_yn[0] = 'N';
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHK_CONFIRM), CHK_CONFIRM_Y1);
				}
				else
				{
					stMw.szInfo_use_agree_yn[0] = 'Y';
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHK_CONFIRM), CHK_CONFIRM_Y2);
				}
				
				ON_DRAW();
				
				break;
			
			// 유선방송 신청동의
			case BID_USE_AGREE:
				if( m_nUse_agree == 1 )
				{
					m_nUse_agree = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_USE_AGREE), USE_AGREE_Y1);
				}
				else
				{
					m_nUse_agree = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_USE_AGREE), USE_AGREE_Y2);
				}
				
				ON_DRAW();
				
				break;
			
			// 저장
			case BID_SAVE:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT length( CUST_CONF_SIGN ) FROM C6101_PROMISE_ASSIGN  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetInt( szSql, &ret );
				
				// 서명 체크
				if( ret < 100)
				{
					MessageBoxEx (ERROR_OK, "서명을 확인하세요!");
					break;
				}
				
				// 전출일때 복지시설 할인 종료 알림
				if( g_nWorkFlag == 620 )
				{
					if( Str_Cmp( stMw.szSocial_welf_disc_yn, "Y") == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "복지시설 할인이 종료됩니다.\n신규사용계약번호로 복지시설감면\n재신청 안내바랍니다.");
					}
				}
				
				if( Save_Assign() > 0 )
				{
					// 민원대상정보를 갖고온다.
					if( Load_Assign(g_szCHK_EXEC_NUM)  < 0) 
					{
						return;
					}
					
					Snd_RstMin();
				}
				
				break;

			case BID_SIGN:
				Save_Sign();
				
				break;
			
			case BID_CLOSE:
				
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				SPRINT(szSql, "SELECT SUM(AMT) AS AMT \
							     FROM ( SELECT ACCOUNT AS AMT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' \
									     UNION ALL \
									    SELECT SUM(UNPAY_AMT) AS AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1')", g_szCHK_EXEC_NUM, g_szCHK_EXEC_NUM, 0);
									    
				g_Sql_RetInt(szSql, &gasAmt);
				
				// 가스 + 일회성
				if(gasAmt > 0 && g_lOneCardPageFlag == 0)
				{
					Card_Move("C6101_ONECARD");
				}
				// 가스
				else if(gasAmt > 0 && g_lOneCardPageFlag == 1)
				{
					Card_Move("C6101_GASCARD");
				}
				// 일회성
				else if(gasAmt <= 0 && g_lOneCardPageFlag == 0)
				{
					Card_Move("C6101_ONECARD");
				}
				// 둘다 현금
				else if(gasAmt <= 0 && g_lOneCardPageFlag == 1)
				{
					Card_Move("C6101_WPAY");
				}
				else
				{
					PRINT("555555555555",0,0,0);
					Card_Move("C6101_WPAY");
				}
			
				break;
		}
	}
	
	/*=======================================================================================
	함수명 : Bill_Pirnt
	기  능 : 인쇄시작
	Param  : 
	Return : 
	========================================================================================*/
	void Bill_Pirnt(void)
	{
		/*
			if( g_IsCardReader() )
			{
				Snd_RstMin();
				return;
			}
		*/
		
		MessageBoxEx (MESSAGE, "영수증 출력 준비중입니다.");
		
		if (m_bPrintAgain == FALSE)
		{
			callBackfunc = NULL;		  
			m_pList = Bill_Pirnt_GetData();
		}
		
		g_Printer_Start(m_pList, (void*)Print_Result);
		
		m_nPrintFlag = PRINT_BILL;
	}
	
	/*=======================================================================================
	함수명 : Print_Result
	기  능 : 인쇄 결과
	Param  : 
	Return : 
	========================================================================================*/
	long Print_Result(void* p)
	{
		long* pRet = (long*)p;
		long nRet = *pRet;
		
		/*
			if( MessageBoxEx (CONFIRM_YESNO, "영수증 발행이 잘되었습니까?") == MB_OK )
			{
				switch(m_nPrintFlag)
				{
					case PRINT_BILL: 		Snd_RstMin(); 	break;
					case PRINT_CARD_APRO: 	break;
					case PRINT_CARD_CANCEL: break;
				}
			}
			else
			{
				if( MessageBoxEx (CONFIRM_YESNO, "재발행 하시겠습니까?") == MB_OK )
				{
					m_bPrintAgain = TRUE;
					
					switch(m_nPrintFlag)
					{
						case PRINT_BILL: 		Bill_Pirnt(); 		break;
						case PRINT_CARD_APRO: 	Card_ApproPirnt(); 	break;
						case PRINT_CARD_CANCEL: Card_CancelPirnt(); break;
					}
						
					return 0;
				}
			}	
		*/
		
		if( MessageBoxEx (CONFIRM_YESNO, "영수증 발행이 잘되었습니까?") == MB_OK )
		{
			switch(m_nPrintFlag)
			{
				case PRINT_BILL:        	Move_card(); break;
				case PRINT_CARD_APRO: 		break;
				case PRINT_CARD_CANCEL: 	break;
			}
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "재발행 하시겠습니까?") == MB_OK )
			{
				m_bPrintAgain = TRUE;
				
				switch(m_nPrintFlag)
				{
					case PRINT_BILL: 		Bill_Pirnt(); break;
					case PRINT_CARD_APRO: 	break;
					case PRINT_CARD_CANCEL: break;
				}
					
				return 0;
			}
		}
		
		m_bPrintAgain = FALSE;
		
		if (m_pList)
		{
			DelArrayList(m_pList);
			m_pList = NULL;
			g_printerCallBack = NULL;
		}
		
		return 0;
	}	
	
	/*=======================================================================================
	함수명 : GetUtf8Size
	기  능 : 한글 체크
	Param  : 
	Return : 
	========================================================================================*/
	long GetUtf8Size(char* str, long chklen)
	{
		long nSize = 0;
		long nLen = 0;
		long i = 0;
		
		nSize = Str_Len(str);
		
		for( i=0; i < nSize; )
		{
			if ( str[i] & 0x80 )
			{
				i+=2;			
			}
			else
			{
				i++;
			}
				
			if( i >= chklen )
			{
				break;
			}
		}
		
		nLen = i;
		
		return nLen;
	}
		
	//----------------------------------------------------------------------------------
	// 기  능 : g_png_getwbmp
	// 설  명 : 서명관련
	// 리턴값 : 
	//----------------------------------------------------------------------------------
	long png_getbmp(long width, long height, byte* img )
	{
		bool flag = FALSE;
		long fd, ret=-1;
		byte b;
		long color;
		long ncolor;
		byte pixel[2];
		int i=0, j=0, k = 5;
		int headlen = 0;
	    int size = 0;
	    
		byte *  Singimg =NULL;
	    byte * buf = NULL;
		byte* pucSignSrc= NULL;
		byte* pucSignDest= NULL;
		
		byte BmpHeader[] =
		{
			/* 
				typedef struct tagBITMAPFILEHEADER
				{
					WORD	bfType;	// 파일의 타입을 나타낸다.(비트맵의 경우에는 BM = 0x424d)
					DWORD	bfSize;	// 파일의 크기를 나타낸다.
					WORD	bfReserved1;	// 0으로 예약되어 있다.
					WORD	bfReserved2;	// 0으로 예약되어 있다.
					DWORD	bfOffbits;		// BITMAPFILEHEADER 로부터 실제 비트맵 데이터가 위치한 곳의 오프셋이 들어있다.
				} BITMAPFILEHEADER
			*/
			
			0x42,0x4D,
			0x3E,0x04,0x00,0x00,
			0x00,0x00,
			0x00,0x00,
			0x3E,0x00,0x00,0x00,
			
			/*
				typedef struct tagBITMAPINFOHEADER
				{
					DWORD	biSize;	// BITMAPINFOHEADER 의 크기
					LONG	biWidth;	// 비트맵의 폭
					LONG	biHeight;	// 비트맵의 높이
					WORD	biPlanes;	// 항상 1
					WORD	biBitCount;	// 1, 4, 8, 24 중의 하나
					DWORD	biCompression;	// BI_RGB, BI_RLE4, BI_RLE8
					DWORD	biSizeImage;	// 이미지 전체의 크기
					LONG	biXPelsPerMeter;	// 목표 디바이스의 가로 1m 당 픽셀수
					LONG	biYPelsPerMeter;	// 목표 디바이스의 세로 1m 당 픽셀수
					DWORD	biClrUsed;	// 팔레트에서 실제로 쓰이는 색상의 수, 0이면 모두 다 쓰임
					DWORD	biClrImportant;	// 이미지를 표시함에 있어서 중요한 색상의 수, 0이면 다 중요하다는 것을 의미한다.
				} BITMAPINFOHEADER
			*/
			
			0x28,0x00,0x00,0x00,
			0x80,0x00,0x00,0x00,
			0x40,0x00,0x00,0x00,
			0x01,0x00,
			0x01,0x00,
			0x00,0x00,0x00,0x00,
			0x00,0x04,0x00,0x00,
			0xC4,0x0E,0x00,0x00,
			0xC4,0x0E,0x00,0x00,
			0x00,0x00,0x00,0x00,
			0x00,0x00,0x00,0x00,
			
			/*
				typedef struct tagRGBQUAD
				{
					BYTE	 rgbBlue;
					BYTE	 rgbGreen;
					BYTE	 rgbRed;
					BYTE	 rgbReserved;
				}RGBQUAD
				// RGB 테이블의 크기는 biBitCount 필드에 의해 결정 - 이 필드의 값을 2의 지수승한 것이 바로 RGB 테이블의 크기
			*/
			
			0x00,
			0x00,
			0x00,
			0x00,
			0xFF,0xFF,0xFF,0x00,
		};
		
		/*
			// RGBQUAD 와 BITMAPINFOHEADER 를 합쳐 놓은 BITMAPINFO 라는 구조체 정의
			typedef struct tagBITMAPINFO
			{
				BITMAPFILEHEADER	 bmiHeader;
				RGBQUAD	 bmiColors[1];
			} BITMAPINFO
		*/	
	
		if( theDevInfo.m_nType != FAMILY_PDA )
		{
			Singimg = GrDev_LoadPngImage(PNG_COLOR_NORMAL, "sign.png" );
			if(Singimg == NULL)
				return ret;
			if(width > 160 )
				k = 6;
				
			headlen = k;
			size = k + width * height / 8;
			buf = Mem_Alloc(size);
			ncolor = WHITE;
			b = 0xFF;
	
			for(j=0; j < height; j++)
	        {
		        for(i=0; i < width; i++)
		        {
	                if (i % 8 == 0)
	                {
	                    //초기 조건을 제외하기 위함.
	                    if (flag == TRUE)
	                    {
	                        buf[k++] = b;
	                        b = 0xFF;
	                    }
	
	                    flag = TRUE;
	                }
	                else
	                {
	                        b<<=1;                      
	                }
					//16비트 단위로 컬러값을 읽어온다.
	                pixel[0] = (byte)Singimg[ headlen+i*2+j*width*2 ];
	                pixel[1] = (byte)Singimg[ headlen+i*2+j*width*2+1 ];
	                
	                color = BtoI ( pixel, 2 );              
	                if ( color == ncolor )
	                {
	                        //흰색으로 설정한다.
	                        b |= 0x01;
	                }
	                else
	                {
	                        //검은색으로 설정한다.
	                        b &= 0xFE;
	                }
		        }
	        }
	        FREE(Singimg);
	
			buf[k++] = b;
			
			if(width == 160)
			{
				buf[0] = 0x00;
		        buf[1] = 0x00;
		        buf[2] = 0x81;
		        buf[3] = 0x20;
		        buf[4] = 0x64;
				
			}
			else if(width > 160)
			{
				buf[0] = 0x00;
		        buf[1] = 0x00;
		        buf[2] = 0x81;
		        buf[3] = 0x58;
		        buf[4] = 0x81;
		        buf[5] = 0x02;
			}
			else
			{
		        //헤더 작성
		        buf[0] = 0x00;
		        buf[1] = 0x00;
		        buf[2] = 0x81;
		        buf[3] = (byte)width/8;
		        buf[4] = (byte)height;
	        }
	        Mem_Cpy(img, buf, size);
			
	        fd = FFS_Open( "sign.wbmp", FS_WRITE_MODE, FS_CREATE_FLAG);
	        if( fd == -1)
	        {
	        	free(buf);
	        	return ret;
	        }
	
	        FFS_Write(fd, (byte*)buf, size);
	    	FFS_Flush(fd);
			FFS_Close(fd);
			
			free(buf);
		}
		
		Mem_Set(g_ucSignDest, 0x00, sizeof(g_ucSignDest));
		Mem_Set(g_ucSignSrc, 0x00, sizeof(g_ucSignSrc));

		Mem_Cpy(g_ucSignDest, BmpHeader, sizeof(BmpHeader));
		pucSignDest = g_ucSignDest + sizeof(BmpHeader) + (SIGN_BYTES_PER_LINE) * CARD_SIGN_HEIGHT;
		Mem_Cpy(g_ucSignSrc, img + SIGN_HEADER, CARD_WBMP_SIZE - SIGN_HEADER);
		pucSignSrc = g_ucSignSrc;

		for(i = 1; i <= CARD_SIGN_HEIGHT; i++)
		{
			pucSignDest -= (CARD_SIGN_BYTES_PER_LINE);
			Mem_Cpy(pucSignDest, pucSignSrc, CARD_SIGN_BYTES_PER_LINE);
			pucSignSrc += CARD_SIGN_BYTES_PER_LINE;
		}
		
		Mem_Cpy(img, g_ucSignDest, CARD_BMP_SIZE);
		
	    ret = 1;       
	    return ret;
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
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}
	
	/*=======================================================================================
	함수명 : SetStyle
	기  능 : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARDGASPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARDGASPAY), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARDONEPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARDONEPAY), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CARD_TOTAL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CARD_TOTAL), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CASH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CASHGASPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CASHGASPAY), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CASHONEPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CASHONEPAY), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CASH_TOTAL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CASH_TOTAL), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TOT_AMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TOT_AMT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GAS_ST), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ONE_ST), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		}
	}
	
	/*=======================================================================================
	함수명 : ReDraw
	기  능 : 화면 새로고침
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{
		char sztmp[32];
		char szSql[200];
		long cardtot, cashtot, totamt;
		long ret = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if( g_nWorkFlag == 610 )
 			{
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_CHK_CONFIRM), TRUE);
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_USE_AGREE), TRUE);
			}
			else
			{
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_CHK_CONFIRM), FALSE);
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_USE_AGREE), FALSE);
 				stMw.szInfo_use_agree_yn[0] = 'N';
			}
			
			Str_ItoA( Time_GetDate(), stMw.szChk_time_end, 10);
			g_Str_TimeType(stMw.szChk_time_end+8, Time_GetTime());
			cardtot = 0;
			cashtot = 0; 
			totamt = 0;
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			cardtot = Str_AtoI(stMw.szCard_gaspay);
			Str_Cpy(sztmp, stMw.szCard_gaspay );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARDGASPAY), sztmp);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			cashtot = Str_AtoI(stMw.szCash_gaspay);
			Str_Cpy(sztmp, stMw.szCash_gaspay );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CASHGASPAY), sztmp);
			
			if( stMw.szCard_onepay[0] == '2'  )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CASHONEPAY), "0");
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, stMw.szOnce_account );
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARDONEPAY), sztmp);
				cardtot += Str_AtoI(stMw.szOnce_account);
			}
			else
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, stMw.szOnce_account );
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CASHONEPAY), sztmp);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARDONEPAY), "0");
				cashtot = Str_AtoI(stMw.szOnce_account) + Str_AtoI(stMw.szCash_gaspay);
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA( cashtot,sztmp,10);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CASH_TOTAL), sztmp);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA( cardtot,sztmp,10);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CARD_TOTAL), sztmp);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA( (cashtot+cardtot) ,sztmp,10);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TOT_AMT),    sztmp);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT length( CUST_CONF_SIGN ) FROM C6101_PROMISE_ASSIGN  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &ret );
			if( ret > 100)
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SIGN), RED);
			}
			
			if(Str_AtoI(stMw.szCard_gaspay) > 0 || stMw.szCard_onepay[0] == '2')
			{
				if( Str_Len(stCardinfo.szApproval_num)  == 0 )
				{
					if(Str_AtoI(stMw.szCard_gaspay) > 0)
					{
						if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_GAS_ST) ) >  0)
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GAS_ST), "취");
						else
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GAS_ST), "");
					}
					else
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GAS_ST), "");
					}
					
					if( stMw.szCard_onepay[0] == '2' )
					{
						if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_ONE_ST) ) >  0)
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ONE_ST), "취");
						else
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ONE_ST), "");
					}
					else
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ONE_ST), "");
					}
					
				}
				else
				{
					if(Str_AtoI(stMw.szCard_gaspay) > 0)
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GAS_ST), "승");
					}
					else
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GAS_ST), "");
					}
					
					if( stMw.szCard_onepay[0] == '2' )
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ONE_ST), "승");
					else
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ONE_ST), "");
				}
			}

			ON_DRAW();
		}
	}
	
	/*=======================================================================================
	함수명 : Load_Assign
	기  능 : 민원 정보 load
	Param  : 
	Return : 
	========================================================================================*/
	long Load_Assign(char* assign_seq)
	{
		long i;
		long ret = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stMw, 0x00, sizeof(stMw));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PROMISE_ASSIGN_SEQ, REG_FLAG,BRANCH_CD,CENTER_CD,ASSIGN_EMPID \
,CUST_NUM,USE_CONT_NUM,INST_PLACE_NUM,ZIP_SEQ,ETC_ADDR \
,CIVIL_SERV_CLASS_CD,PROMISE_YMD,PROMISE_TIME,END_EXPECT_TIME,JOB_STR_DTM \
,JOB_END_DTM,PROMISE_ASSIGN_DESC,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ,PROC_STS_CD \
,PDA_NUM,ONCE_PAY,SEND_YN,CIVIL_SERV_CLASS_NM,PDA_DUTY \
,REQ_TEL_DDD,REQ_TEL_EXN,REQ_TEL_NUM,REQ_CP_DDD,REQ_CP_EXN,REQ_CP_NUM \
,TRANS_IN_CUST_NM,TRANS_IN_SOC_NUM,REQ_NM,REQ_SOC_NUM,RECEIVE_DTM,CUST_TYPE_CD \
,CUST_NM,FIRM_NM,SOC_NUM,BIZ_REGI_NUM,CP_DDD,CP_EXN \
,CP_NUM,OWNHOUSE_TEL_DDD,OWNHOUSE_TEL_EXN,OWNHOUSE_TEL_NUM,FIRM_TEL_DDD \
,FIRM_TEL_EXN,FIRM_TEL_NUM,SCG_RELAT_CD,EMAIL,FAMILY_CNT \
,CUST_TRND_CD,CHK,BUILT_IN_YN,SQUARE_METER,CURR_ADDR_UNION \
,BLD_FLOOR,HOUSE_CNT,PDA_DUTY_FLAG,PAY_CALU,PDA_TRANS_FLAG \
,REQ_INFO_NUM,TRANS_IN_CUST_NUM,CONT_STS_CD,PDA_READ_DTM,MEMO \
,AUTO_YN,CUST_YN,BUR_YN,PROD_YN,ONCE_YN \
,PRICE_YN,ZIP_NO1,ZIP_NO2,CITY,COUNTY \
,TOWN,VILLAGE_RI,VILLAGE,TRIM(BUILDING) AS BUILDING,ADDR1_M \
,ADDR1_S,ACCOUNT,ONCE_ACCOUNT,CHK_TIME_FROM \
,CHK_TIME_END,MTR_CHG_YN,INFO_USE_AGREE_YN,PAS_USE_CONT_NUM_YN,ADJ_ALT_AMT \
,PAS_DEFRAY_ACCOUNT_NUM,PAS_CUST_NUM,PAS_REQ_INFO_NUM,APPRO_NUM,APPRO_TEL,ADJ_CAUSE \
,DEADLINE_FLAG,GMTR_BASE_DAY,CARD_GASPAY,CARD_ONEPAY,CASH_GASPAY \
,INFO_USE_YN,USE_CONT_DOC_YN,PAY_METHOD,DEFRAY_ACCOUNT_NUM,DEPOSITOR_NM \
,BANK_NM,DEBT_AMT,LAW_ETC_AMT,LAW_TOWN,NEW_ROAD_NM \
,NEW_ADDR_M,NEW_ADDR_S,NEW_ADDR_UNION,BILL_GUBUN,TRANS_CONN_YN \
,CONN_YN,BAR_YN,BAR_GBN,BAR_WHY,CHK_YN,CONN_GBN, APPRO_STATUS_FLAG, APPRO_GUBUN, INFO_TRANS_YN, SEND_INFO_TRANS_YN , PROD_CHG \
FROM C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = ? AND SEND_YN = 'S' ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail 2222 [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		i = 0;
		PRINT("assign_seq :%s ",assign_seq,0,0);
		sql->Bind(sql, i++, 'U', (long*)assign_seq , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail 1111 [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		while(sql->Next(sql) )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReg_flag              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBranch_cd             ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCenter_cd             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAssign_empid          ,9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_num              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInst_place_num        ,9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_seq               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEtc_addr              ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_class_cd   ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_ymd           ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_time          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEnd_expect_time       ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szJob_str_dtm           ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szJob_end_dtm           ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_assign_desc   ,500+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTreat_seq             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szProc_sts_cd           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_num               ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_pay              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSend_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_class_nm   ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_duty              ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_ddd           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_exn           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_num           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_ddd            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_exn            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_num            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_cust_nm      ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_soc_num      ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_nm                ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_soc_num           ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReceive_dtm           ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_type_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_nm               ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_nm               ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSoc_num               ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBiz_regi_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_ddd                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_exn                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_num                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_ddd      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_exn      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_num      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_ddd          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_exn          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_num          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szScg_relat_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEmail                 ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFamily_cnt            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_trnd_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk                   ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBuilt_in_yn           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSquare_meter          ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCurr_addr_union       ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBld_floor             ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szHouse_cnt             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_duty_flag         ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPay_calu              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_trans_flag        ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_info_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_cust_num     ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCont_sts_cd           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_read_dtm          ,15 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szMemo                  ,500+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAuto_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBur_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szProd_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPrice_yn              ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_no1               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_no2               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCity                  ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCounty                ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTown                  ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szVillage_ri            ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szVillage               ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBuilding              ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAddr1_m               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAddr1_s               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAccount               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_account          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_time_from         ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_time_end          ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szMtr_chg_yn            ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInfo_use_agree_yn     ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_use_cont_num_yn   ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAdj_alt_amt           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_defray_account_num,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_cust_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_req_info_num      ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_num             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_tel             ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAdj_cause             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDeadline_flag         ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szGmtr_base_day         ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCard_gaspay           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCard_onepay           ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCash_gaspay           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInfo_use_yn           ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szUse_cont_doc_yn       ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPay_method            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDefray_account_num    ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDepositor_nm          ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBank_nm               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDebt_amt              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szLaw_etc_amt           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szLaw_town              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_road_nm           ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_m            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_s            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_union        ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBill_gubun            ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_conn_yn         ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szConn_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_gbn               ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_why               ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szConn_gbn              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_status_flag     ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_gubun           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInfo_Trans_yn         ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSend_Info_Trans_yn    ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szProd_chg   			  ,2  +1, DECRYPT );
			
			ret = 1;
		}
		
	Finally:
	
		DelSqLite(sql);
		return ret;
	}

	/*=======================================================================================
	함수명 : Save_Assign
	기  능 : 민원 데이터 저장
	Param  : 
	Return : 
	========================================================================================*/
	long Save_Assign(void)
	{
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		long ret = 0, idx;
	
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_ASSIGN SET \
CHK_TIME_FROM=?,CHK_TIME_END=?,BUILT_IN_YN= ?,CONT_STS_CD= ? \
,AUTO_YN= ?,PRICE_YN= ?,BUR_YN = ?,PROD_YN= ?,ONCE_YN= ?,MTR_CHG_YN = ? \
,ACCOUNT= ?,ONCE_ACCOUNT = ?,ADJ_ALT_AMT= ? \
,APPRO_NUM = ?,ADJ_CAUSE = ?,CARD_GASPAY = ?,CARD_ONEPAY = ?,CASH_GASPAY = ? \
,TRANS_CONN_YN = ?,CONN_YN= ?,BAR_YN= ?,BAR_GBN= ?,BAR_WHY= ?,CHK_YN= ?,CONN_GBN= ? \
,Gmtr_base_day=?,Deadline_flag=?,Memo=?,Email=?\
,Ownhouse_tel_ddd=?,Ownhouse_tel_exn=?,Ownhouse_tel_num=?\
,Cust_nm=?,Soc_num=?,Cp_ddd=?,Cp_exn=?,Cp_num=?,Firm_nm=?\
,Cust_trnd_cd=?,Square_meter=?,Info_use_agree_yn=?,Appro_num=?,BIZ_REGI_NUM=? \
,SEND_YN='S' \
WHERE PROMISE_ASSIGN_SEQ = ? " );

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stMw.szChk_time_from         ,16 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szChk_time_end          ,16 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBuilt_in_yn           ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCont_sts_cd           ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAuto_yn               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szPrice_yn              ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBur_yn                ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szProd_yn               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOnce_yn               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szMtr_chg_yn            ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAccount               ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOnce_account          ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAdj_alt_amt           ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAppro_num             ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAdj_cause             ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCard_gaspay           ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCard_onepay           ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCash_gaspay           ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szTrans_conn_yn     ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szConn_yn           ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBar_yn            ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBar_gbn           ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBar_why           ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szChk_yn            ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szConn_gbn          ,2  +1 ,DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)stMw.szGmtr_base_day      ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szDeadline_flag      ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szMemo               ,500+1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szEmail              ,50 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOwnhouse_tel_ddd   ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOwnhouse_tel_exn   ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOwnhouse_tel_num   ,4  +1 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCust_nm            ,50 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szSoc_num            ,13 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCp_ddd             ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCp_exn             ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCp_num             ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szFirm_nm            ,50 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCust_trnd_cd       ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szSquare_meter       ,5  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szInfo_use_agree_yn  ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAppro_num          ,10 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBiz_regi_num       ,10 +1 ,DECRYPT);
				
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM             ,10 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}
		ret = 1;
		
	Finally	:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Save_Sign
	기  능 : 서명 저장
	Param  : 
	Return : 
	========================================================================================*/
	long Save_Sign(void)
	{
		long lSign, lSign_Len;
		long idx;
		bool bRet = TRUE;
		char* pRst;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		// 서명
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		lSign = GetSignImgTitleWithOpt( CARD_SIGN_WIDTH, CARD_SIGN_HEIGHT, (char*)g_SignBuf, "고 객 서 명", SIGN_OPT_NONE );
		
		if( lSign == SIGN_RET_CANCEL || lSign == SIGN_RET_FAIL )
		{
			bRet = FALSE;
			goto Finally;
		}
		else
		{
			png_getbmp(CARD_SIGN_WIDTH, CARD_SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, CARD_BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			bRet = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_ASSIGN SET CUST_CONF_SIGN = ? WHERE PROMISE_ASSIGN_SEQ =  ? ");
        
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}

		idx = 0;
		
		sql->Bind(sql, idx++, 'U', (long *)pRst,  Str_Len(pRst) ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM	,10 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}
		
		ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SIGN), RED);
		
	Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		DelSqLite(sql);
		ON_DRAW();
		
		return TRUE;
	}

	/*=======================================================================================
	함수명 : Snd_RstMin
	기  능 : 민원 저장 전 setting
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_RstMin(void)
	{
		char szUrl[200];
		char szbuf[128];
		char sztmp[128];
		char szScrPht[128];
		char szUcovert[1000];
		char* sndbuf;
		long ret = 0;
		long i, idx, fd;
		byte* signimg = NULL;
		char* szfile =  NULL;
		long filesize = 0;
		handle file;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68302, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd"             , stUserinfo.szcenter_cd     );		
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"    , stMw.szPromise_assign_seq     );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"             , stMw.szTreat_seq              );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd"             , stMw.szBranch_cd              );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_class_cd"   , stMw.szCivil_serv_class_cd    );
		JSON_SetValue( g_pjcomm, 'C', "pda_duty_flag"         , stMw.szPda_duty_flag          );
		JSON_SetValue( g_pjcomm, 'C', "req_info_num"          , stMw.szReq_info_num           );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"          , stMw.szUse_cont_num           );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num"        , stMw.szInst_place_num         );
		JSON_SetValue( g_pjcomm, 'C', "account"               , stMw.szAccount                );
		JSON_SetValue( g_pjcomm, 'C', "adj_alt_amt"           , stMw.szAdj_alt_amt            );
		JSON_SetValue( g_pjcomm, 'C', "chk_time_from"         , stMw.szChk_time_from          );
		JSON_SetValue( g_pjcomm, 'C', "chk_time_end"          , stMw.szChk_time_end           );
		JSON_SetValue( g_pjcomm, 'C', "once_account"          , stMw.szOnce_account           );
		JSON_SetValue( g_pjcomm, 'C', "auto_yn"               , stMw.szAuto_yn                );
		JSON_SetValue( g_pjcomm, 'C', "price_yn"              , stMw.szPrice_yn               );
		JSON_SetValue( g_pjcomm, 'C', "card_gaspay"           , stMw.szCard_gaspay            );
		JSON_SetValue( g_pjcomm, 'C', "cash_gaspay"           , stMw.szCash_gaspay            );
		JSON_SetValue( g_pjcomm, 'C', "card_onepay"           , stMw.szCard_onepay            );
		JSON_SetValue( g_pjcomm, 'C', "trans_conn_yn"         , stMw.szTrans_conn_yn          );
		JSON_SetValue( g_pjcomm, 'C', "bur_yn"                , stMw.szBur_yn                 );
		JSON_SetValue( g_pjcomm, 'C', "conn_yn"               , stMw.szConn_yn                );
		JSON_SetValue( g_pjcomm, 'C', "bar_gbn"               , stMw.szBar_gbn                );
		JSON_SetValue( g_pjcomm, 'C', "bar_yn"                , stMw.szBar_yn                 );
		JSON_SetValue( g_pjcomm, 'C', "bar_why"               , stMw.szBar_why                );
		JSON_SetValue( g_pjcomm, 'C', "chk_yn"                , stMw.szChk_yn                 );
		JSON_SetValue( g_pjcomm, 'C', "conn_gbn"              , stMw.szConn_gbn               );
		
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szMemo );
		JSON_SetValue( g_pjcomm, 'C', "memo"                  , szUcovert                     );
		
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szCurr_addr_union );
		JSON_SetValue( g_pjcomm, 'C', "curr_addr_union"       , szUcovert                     );
		
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szNew_addr_union );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_union"        , szUcovert                     );
		
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szEmail );
		JSON_SetValue( g_pjcomm, 'C', "email"                 , szUcovert                     );
		
		JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_num"     , stMw.szTrans_in_cust_num      );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_ddd"      , stMw.szOwnhouse_tel_ddd       );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_exn"      , stMw.szOwnhouse_tel_exn       );		
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_num"      , stMw.szOwnhouse_tel_num       );
		
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szCust_nm );
		
		JSON_SetValue( g_pjcomm, 'C', "cust_nm"               , szUcovert                     );
		JSON_SetValue( g_pjcomm, 'C', "soc_num"               , stMw.szSoc_num                );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd"                , stMw.szCp_ddd                 );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn"                , stMw.szCp_exn                 );
		JSON_SetValue( g_pjcomm, 'C', "cp_num"                , stMw.szCp_num                 );
		
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szFirm_nm );
		
		JSON_SetValue( g_pjcomm, 'C', "firm_nm"               , szUcovert                     );
		JSON_SetValue( g_pjcomm, 'C', "family_cnt"            , stMw.szFamily_cnt             );
		JSON_SetValue( g_pjcomm, 'C', "cust_trnd_cd"          , stMw.szCust_trnd_cd           );
		JSON_SetValue( g_pjcomm, 'C', "built_in_yn"           , stMw.szBuilt_in_yn            );
		JSON_SetValue( g_pjcomm, 'C', "square_meter"          , stMw.szSquare_meter           );
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn"     , stMw.szInfo_use_agree_yn      );
		JSON_SetValue( g_pjcomm, 'C', "cont_sts_cd"           , stMw.szCont_sts_cd            );
		JSON_SetValue( g_pjcomm, 'C', "pas_use_cont_num_yn"   , stMw.szPas_use_cont_num_yn    );
		JSON_SetValue( g_pjcomm, 'C', "pas_defray_account_num", stMw.szPas_defray_account_num );
		JSON_SetValue( g_pjcomm, 'C', "pas_cust_num"          , stMw.szPas_cust_num           );
		JSON_SetValue( g_pjcomm, 'C', "pas_req_info_num"      , stMw.szPas_req_info_num       );
		
		if( m_nUse_agree == 1)
		{		
			JSON_SetValue( g_pjcomm, 'C', "chk_cable"             , "Y"       );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "chk_cable"             , "N"       );
		}
		
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szTrans_in_cust_nm );
		JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_nm"      , szUcovert                     );
		
 		JSON_SetValue( g_pjcomm, 'C', "req_tel_ddd"           , stMw.szReq_tel_ddd            );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_exn"           , stMw.szReq_tel_exn            );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_num"           , stMw.szReq_tel_num            );
		JSON_SetValue( g_pjcomm, 'C', "req_cp_ddd"            , stMw.szReq_cp_ddd             );
		JSON_SetValue( g_pjcomm, 'C', "req_cp_exn"            , stMw.szReq_cp_exn             );
		JSON_SetValue( g_pjcomm, 'C', "req_cp_num"            , stMw.szReq_cp_num             );
		JSON_SetValue( g_pjcomm, 'C', "apro_num"              , stMw.szAppro_num              );
		JSON_SetValue( g_pjcomm, 'C', "bill_gubun"            , stMw.szBill_gubun             );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag"         , stMw.szDeadline_flag          );
		JSON_SetValue( g_pjcomm, 'C', "adj_cause"             , stMw.szAdj_cause              );
		JSON_SetValue( g_pjcomm, 'C', "biz_regi_num"          , stMw.szBiz_regi_num           );
		JSON_SetValue( g_pjcomm, 'C', "prod_chg"              , stMw.szProd_chg               );
		
		Mem_Set( (byte*)szUcovert, 0x00, sizeof(szUcovert) );
		SPRINT(szUcovert, "SELECT length( CUST_CONF_SIGN ) FROM C6101_PROMISE_ASSIGN  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szUcovert, &ret );
		signimg = Mem_Alloc( ret + 5 );
		Mem_Set( signimg, 0x00, ret+5 );
		Mem_Set( (byte*)szUcovert, 0x00, sizeof(szUcovert) );
		SPRINT(szUcovert, "SELECT CUST_CONF_SIGN FROM C6101_PROMISE_ASSIGN  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szUcovert, ret ,(char*)signimg );		
		JSON_SetValue( g_pjcomm, 'C', "cust_conf_sign_b"   ,signimg );
		
		Mem_Free(signimg);
		
		// 바코드스캔 or 사진정보
		Add_Bo(g_pjcomm); 			// 보일러수정정보
		Add_Bur(g_pjcomm); 			// 연소기수정정보
		Add_Once(g_pjcomm);			// 일회성비용
		Add_Mtr(g_pjcomm);  		// 지침, 중지, 해지정보
		Add_ChgMtr(g_pjcomm);		// 계량기교체 서명+사진추가한다.
		Add_Nonpay(g_pjcomm);		// 미납, 정산 데이터 추가한다.
		Add_CardInfo(g_pjcomm);		// 카드결재 결과를 추가한다.
		// Add_OneCardInfo(g_pjcomm);	// 일회성 카드 결제 결과를 추가한다.
		Add_Chk(g_pjcomm);		    //가스누설점검 데이터를 추가한다.
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		g_SeverConnection();
		
		callBackfunc = Rcv_RstMIn;
		ret = HTTP_DownloadData(szUrl, "FR68302_IN",  "FR68302" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Rcv_RstMIn
	기  능 : FR68302 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_RstMIn(void)
	{
		char szSql[200];
	
		g_Sock_Close();
		
		g_nWorkChkFlag = 1;
		
		if( g_Chk_Json(68302) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE C6101_PROMISE_ASSIGN SET SEND_YN = 'Y' WHERE Promise_assign_seq = '%s' ", g_szCHK_EXEC_NUM, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			// 202021015 영수증을 먼저 출력한다. ( CS팀 박세동 차장님 요청 )
			if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0 
		    || ( Str_AtoI(stMw.szCash_gaspay ) == 0 && Str_AtoI(stMw.szCard_gaspay ) == 0 && Str_AtoI(stMw.szAdj_alt_amt) > 0 )
			|| ( Str_AtoI(stMw.szOnce_account) > 0 && stMw.szAuto_yn[0] != 'Y'  &&  Str_Cmp (stMw.szPda_duty_flag, "20") != 0 ) 
			|| ( Str_Cmp (stMw.szPda_duty_flag, "20") == 0 ) )
			{
				if( MessageBoxEx (CONFIRM_YESNO, "민원완료 영수증을\n발행하시겠습니까?")  == MB_OK)
				{
					if( Str_Cmp (stMw.szPda_duty_flag, "10") == 0 )
					{
						// 전입일때 영수증에 들어가는 계량기 번호를 가져옴
						Rcv_62604();
					}
					else
					{
						Bill_Pirnt();
					}
				}
				else
				{
					if( g_nWorkFlag == 610 && Str_Cmp( stMw.szInfo_Trans_yn, "Y") == 0 )
					{
						Snd_Info_Trans();
						return 0;
					}
					else
					{
						if( g_nWorkFlag != 620 )
						{
							if( g_nWorkFlag == 610 )
							{
								g_lMobile_Inflow_Path = 0;	
							}
							else
							{
								g_lMobile_Inflow_Path = 5;
							}
						
							Card_Move("CM_MOBILE_USE_DOC_MENU");
							return 0;
						}
						
						Card_Move("C6101_LST");
					}
				}
			}
			else
			{
				if( g_nWorkFlag == 610 && Str_Cmp( stMw.szInfo_Trans_yn, "Y") == 0 )
				{
					Snd_Info_Trans();
					return 0;
				}
				else
				{
					if( g_nWorkFlag != 620 )
					{
						if( g_nWorkFlag == 610 )
						{
							g_lMobile_Inflow_Path = 0;	
						}
						else
						{
							g_lMobile_Inflow_Path = 5;
						}
					
						Card_Move("CM_MOBILE_USE_DOC_MENU");
						return 0;
					}
					Card_Move("C6101_LST");
				}
			}
		}
		else
		{
			if( MessageBoxEx (ERROR_YESNO, "작업송신 미완료\n추후 전송 하시겠습니까?")  != MB_OK)
			{
				Snd_RstMin();
				return 0;
			}
			else
			{
				Card_Move("C6101_LST");
			}
		}
		
		return 0;
	}
	
	/*=======================================================================================
	함수명 : Snd_Info_Trans
	기  능 : 전출지연계
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_Info_Trans(void)
	{
		char szUrl[300];
		char szbuf[300];
		char sztmp[2000];
		char* sndbuf;
		long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68303, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd" , stUserinfo.szcenter_cd );		
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq", stMw.szTreat_seq );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num", stMw.szInst_place_num );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd", stMw.szBranch_cd );
		
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stMw.szCurr_addr_union );
		JSON_SetValue( g_pjcomm, 'C', "curr_addr_union", sztmp );
		
		JSON_SetValue( g_pjcomm, 'C', "zip_seq", stMw.szZip_seq );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stMw.szEtc_addr );
		JSON_SetValue( g_pjcomm, 'C', "etc_addr", sztmp );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stMw.szTrans_in_cust_nm );
		JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_nm", sztmp );
		
		JSON_SetValue( g_pjcomm, 'C', "trans_in_soc_num", stMw.szTrans_in_soc_num );
		JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_num", stMw.szTrans_in_cust_num );
		JSON_SetValue( g_pjcomm, 'C', "assign_req_tel_ddd", stMw.szReq_tel_ddd );
		JSON_SetValue( g_pjcomm, 'C', "assign_req_tel_exn", stMw.szReq_tel_exn );
		JSON_SetValue( g_pjcomm, 'C', "assign_req_tel_num", stMw.szReq_tel_num );
		JSON_SetValue( g_pjcomm, 'C', "assign_req_cp_ddd", stMw.szReq_cp_ddd );
		JSON_SetValue( g_pjcomm, 'C', "assign_req_cp_exn", stMw.szReq_cp_exn );
		JSON_SetValue( g_pjcomm, 'C', "assign_req_cp_num", stMw.szReq_cp_num );
		
		JSON_SetValue( g_pjcomm, 'C', "send_info_trans_yn", stMw.szSend_Info_Trans_yn );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_Info_Trans;
		ret = HTTP_DownloadData(szUrl, "FR68303_IN",  "FR68303" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	함수명 : Rcv_Info_Trans
	기  능 : 전출지연계 완료
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Info_Trans(void)
	{
		char szSql[200];
	
		g_Sock_Close();
		
		g_nWorkChkFlag = 1;
		
		if( g_nWorkFlag != 620 )
		{
			
			if( g_nWorkFlag == 610 )
			{
				g_lMobile_Inflow_Path = 0;	
			}
			else
			{
				g_lMobile_Inflow_Path = 5;
			}
		
			Card_Move("CM_MOBILE_USE_DOC_MENU");

			ON_DRAW();
			return 0;
		}
		
		ON_DRAW();
		Card_Move("C6101_LST");
	
		return 0;
	}
	
	/*=======================================================================================
	함수명 : Add_Bo
	기  능 : 보일러 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_Bo(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[100];
		SQLITE sql = NewSqLite();
		handle js = NULL;
		MWBURINFO stBur;
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT  mtr_num,burner_num,burner_class_cd,burner_kind_num, trim(burner_model_cd) \
,burner_capa,burner_capa_unit,burner_inst_ymd,burner_remov_ymd,burner_model_nm \
,maker_nm,boiler_form,maker_num,make_num,make_ymd,inst_flag \
,inst_loc,boiler_inst_firm_cd \
 FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ= ? AND SUBSTR(BURNER_NUM,1,1) = '1' AND SEND_YN = 'S' ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
					
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)&stBur, 0x00, sizeof(stBur) );
			idx = 0;
      		sql->GetValue(sql, idx++, 'U', (long*)stBur.szMtr_num             ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_num          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_class_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_kind_num     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa         ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa_unit    ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_inst_ymd     ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_remov_ymd    ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_nm     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_nm            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_form         ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_num            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_num            ,30+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_ymd            ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_flag           ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_loc            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_inst_firm_cd ,20+1, DECRYPT);
			
			
			
			
				
			JSON_AddArrayItem(js);
				
			JSON_SetArrayItem(js, 'C',  "mtr_num"            , stBur.szMtr_num             );
			JSON_SetArrayItem(js, 'C',  "burner_num"         , stBur.szBurner_num          );
			JSON_SetArrayItem(js, 'C',  "burner_class_cd"    , stBur.szBurner_class_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_kind_num"    , stBur.szBurner_kind_num     );
			JSON_SetArrayItem(js, 'C',  "burner_model_cd"    , stBur.szBurner_model_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_capa"        , stBur.szBurner_capa         );
			JSON_SetArrayItem(js, 'C',  "burner_capa_unit"   , stBur.szBurner_capa_unit    );
			JSON_SetArrayItem(js, 'C',  "burner_inst_ymd"    , stBur.szBurner_inst_ymd     );
			JSON_SetArrayItem(js, 'C',  "burner_remov_ymd"   , stBur.szBurner_remov_ymd    );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szBurner_model_nm );
			JSON_SetArrayItem(js, 'C',  "burner_model_nm"    , szUcovert                   );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_nm );
			JSON_SetArrayItem(js, 'C',  "maker_nm"           , szUcovert                   );
			JSON_SetArrayItem(js, 'C',  "boiler_form"        , stBur.szBoiler_form         );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_num );
			JSON_SetArrayItem(js, 'C',  "maker_num"           , szUcovert                   );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMake_num );
			JSON_SetArrayItem(js, 'C',  "make_num"           , szUcovert                   );
			
			JSON_SetArrayItem(js, 'C',  "make_ymd"           , stBur.szMake_ymd            );
			JSON_SetArrayItem(js, 'C',  "inst_flag"          , stBur.szInst_flag           );
			JSON_SetArrayItem(js, 'C',  "inst_loc"           , stBur.szInst_loc            );
			JSON_SetArrayItem(js, 'C',  "boiler_inst_firm_cd", stBur.szBoiler_inst_firm_cd );
			
			ret =1;
		}
		
		if( ret == 1 )
			JSON_Attach(pj, "bo", js);
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		DelSqLite(sql);
		return ret;
	}

	/*=======================================================================================
	함수명 : Add_Bur
	기  능 : 연소기 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_Bur(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[100];
		SQLITE sql = NewSqLite();
		handle js = NULL;
		MWBURINFO stBur;
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, " SELECT mtr_num,burner_num,burner_class_cd,burner_kind_num,trim(burner_model_cd) \
,burner_capa,burner_capa_unit,burner_inst_ymd,burner_remov_ymd,burner_model_nm \
,maker_nm,boiler_form,maker_num,make_num,make_ymd,inst_flag \
,inst_loc,boiler_inst_firm_cd,INDUCTION_INST_YN,INST_PLACE_NUM \
 FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ=? AND SUBSTR(BURNER_NUM,1,1) <> '1' AND SEND_YN = 'S' ");
 
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)&stBur, 0x00, sizeof(stBur) );
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMtr_num             ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_num          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_class_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_kind_num     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa         ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa_unit    ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_inst_ymd     ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_remov_ymd    ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_nm     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_nm            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_form         ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_num            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_num            ,30+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_ymd            ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_flag           ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_loc            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_inst_firm_cd ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInduc_inst_yn       ,2+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_place_num      ,20+1, DECRYPT);

			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C',  "mtr_num"            , stBur.szMtr_num             );
			JSON_SetArrayItem(js, 'C',  "burner_num"         , stBur.szBurner_num          );
			JSON_SetArrayItem(js, 'C',  "burner_class_cd"    , stBur.szBurner_class_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_kind_num"    , stBur.szBurner_kind_num     );
			JSON_SetArrayItem(js, 'C',  "burner_model_cd"    , stBur.szBurner_model_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_capa"        , stBur.szBurner_capa         );
			JSON_SetArrayItem(js, 'C',  "burner_capa_unit"   , stBur.szBurner_capa_unit    );
			JSON_SetArrayItem(js, 'C',  "burner_inst_ymd"    , stBur.szBurner_inst_ymd     );
			JSON_SetArrayItem(js, 'C',  "burner_remov_ymd"   , stBur.szBurner_remov_ymd    );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szBurner_model_nm );
			JSON_SetArrayItem(js, 'C',  "burner_model_nm"    , szUcovert                   );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_nm );
			JSON_SetArrayItem(js, 'C',  "maker_nm"           , szUcovert                   );
			JSON_SetArrayItem(js, 'C',  "boiler_form"        , stBur.szBoiler_form         );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_num );
			JSON_SetArrayItem(js, 'C',  "maker_num"           , szUcovert            );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMake_num );
			JSON_SetArrayItem(js, 'C',  "make_num"           , szUcovert            );
			
			JSON_SetArrayItem(js, 'C',  "make_ymd"           , stBur.szMake_ymd            );
			JSON_SetArrayItem(js, 'C',  "inst_flag"          , stBur.szInst_flag           );
			JSON_SetArrayItem(js, 'C',  "inst_loc"           , stBur.szInst_loc            );
			JSON_SetArrayItem(js, 'C',  "boiler_inst_firm_cd", stBur.szBoiler_inst_firm_cd );
			JSON_SetArrayItem(js, 'C',  "induction_inst_yn"  , stBur.szInduc_inst_yn );
			JSON_SetArrayItem(js, 'C',  "inst_place_num"     , stBur.szInst_place_num );
			
			ret = 1;
		}
		
		if(ret == 1)
			JSON_Attach(pj, "bur", js);
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);

		return ret;
	}

	/*=======================================================================================
	함수명 : Add_Once
	기  능 : 일회성 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_Once(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		handle js = NULL;
		char szcivil_serv_receive_num[14+1];
		char sztreat_seq             [2 +1];
		char szuse_cont_num          [10+1];
		char szonce_item_cd          [6 +1];
		char szcenter_cd             [2 +1];
		char szstr_apply_ymd         [8 +1];
		char szonce_unit_prc         [12+1];
		char szonce_qty              [5 +1];
		char szonce_amt              [12+1];
		char szexcept_yn             [1 +1];
		char szpay_promise_yn        [1 +1];
		char szbuilt_in_yn           [1 +1];
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ,USE_CONT_NUM,ONCE_ITEM_CD,CENTER_CD \
                                                , STR_APPLY_YMD,ONCE_UNIT_PRC,ONCE_QTY,ONCE_AMT,EXCEPT_YN,PAY_PROMISE_YN,BUILT_IN_YN \
                                             FROM C6101_ONCE_INFO WHERE PROMISE_ASSIGN_SEQ = ?  AND SEND_YN = 'S' AND once_qty > 0 ");
 
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
					
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szcivil_serv_receive_num, 0x00, sizeof(szcivil_serv_receive_num) );
			Mem_Set( (byte*)sztreat_seq             , 0x00, sizeof(sztreat_seq             ) );
			Mem_Set( (byte*)szuse_cont_num          , 0x00, sizeof(szuse_cont_num          ) );
			Mem_Set( (byte*)szonce_item_cd          , 0x00, sizeof(szonce_item_cd          ) );
			Mem_Set( (byte*)szcenter_cd             , 0x00, sizeof(szcenter_cd             ) );
			Mem_Set( (byte*)szstr_apply_ymd         , 0x00, sizeof(szstr_apply_ymd         ) );
			Mem_Set( (byte*)szonce_unit_prc         , 0x00, sizeof(szonce_unit_prc         ) );
			Mem_Set( (byte*)szonce_qty              , 0x00, sizeof(szonce_qty              ) );
			Mem_Set( (byte*)szonce_amt              , 0x00, sizeof(szonce_amt              ) );
			Mem_Set( (byte*)szexcept_yn             , 0x00, sizeof(szexcept_yn             ) );
			Mem_Set( (byte*)szpay_promise_yn        , 0x00, sizeof(szpay_promise_yn        ) );
			Mem_Set( (byte*)szbuilt_in_yn           , 0x00, sizeof(szbuilt_in_yn           ) );
			
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)szcivil_serv_receive_num, 14+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)sztreat_seq             , 2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szuse_cont_num          , 10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_item_cd          , 6 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szcenter_cd             , 2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szstr_apply_ymd         , 8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_unit_prc         , 12+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_qty              , 5 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_amt              , 12+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szexcept_yn             , 1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szpay_promise_yn        , 1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szbuilt_in_yn           , 1 +1, DECRYPT);
				
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "civil_serv_receive_num" , szcivil_serv_receive_num );
			JSON_SetArrayItem(js, 'C', "treat_seq"              , sztreat_seq              );
			JSON_SetArrayItem(js, 'C', "use_cont_num"           , szuse_cont_num           );
			JSON_SetArrayItem(js, 'C', "once_item_cd"           , szonce_item_cd           );
			JSON_SetArrayItem(js, 'C', "center_cd"              , szcenter_cd              );
			JSON_SetArrayItem(js, 'C', "str_apply_ymd"          , szstr_apply_ymd          );
			JSON_SetArrayItem(js, 'C', "once_unit_prc"          , szonce_unit_prc          );
			JSON_SetArrayItem(js, 'C', "once_qty"               , szonce_qty               );
			JSON_SetArrayItem(js, 'C', "once_amt"               , szonce_amt               );
			JSON_SetArrayItem(js, 'C', "built_in_yn"            , stMw.szBuilt_in_yn       );
			
			if(stMw.szAuto_yn[0] == 'Y')
			{
				JSON_SetArrayItem(js, 'C', "pay_promise_yn"         , "Y"          );
			}
			else
			{
				JSON_SetArrayItem(js, 'C', "pay_promise_yn"         , szpay_promise_yn );
			}
			
			if( Str_AtoI(szonce_qty ) > 0 && Str_Cmp(szonce_item_cd, "F00001") == 0 && stMw.szAuto_yn[0] == 'Y' )
			{
				JSON_SetArrayItem(js, 'C', "except_yn"              , "Y"              );
			}
			else
			{
				JSON_SetArrayItem(js, 'C', "except_yn"              , szexcept_yn              );
			}
			
			ret =1;
		}
		
		if(ret == 1)
		{
			JSON_Attach(pj, "one", js);
		}
		
	Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		DelSqLite(sql);

		return ret;
	}

	/*=======================================================================================
	함수명 : Add_Mtr
	기  능 : 계량기 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_Mtr(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		handle js = NULL;
		char szcivil_serv_receive_num[16];
		char sztreat_seq[10];
		char szmtr_num[11];
		char szuse_cont_num[11];
		char szprod_cont_seq[11];
		char szadj_ymd[9];
		char szindi_vc_after[11];
		char szindi_va_after[11];
		char szindi_vm_after[11];
		char szkeeper_yn[3];
		char szsealed_sts[3];
		char szcont_revis_para[11];
		char szbiz_type_cd[7];
		char szprod_cd[5];
		char szbill_gubun[3];
		char szaccount[15];
		char szInst_place_num[10];
		char szProd_sts_cd[3];
		char szCont_flag_cd[3];

		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ,MTR_NUM,USE_CONT_NUM, PROD_CONT_SEQ,INDI_VC,\
INDI_VA,INDI_VM, KEEPER_YN, SEALED_STS, CONT_REVIS_PARA, BIZ_TYPE_CD, PROD_CD,BILL_GUBUN, ACCOUNT,INST_PLACE_NUM, PROD_STS_CD , CONT_FLAG_CD \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szcivil_serv_receive_num, 0x00, sizeof(szcivil_serv_receive_num) );
			Mem_Set( (byte*)sztreat_seq, 0x00, sizeof(sztreat_seq) );
			Mem_Set( (byte*)szmtr_num, 0x00, sizeof(szmtr_num) );
			Mem_Set( (byte*)szuse_cont_num, 0x00, sizeof(szuse_cont_num) );
			Mem_Set( (byte*)szprod_cont_seq,0x00, sizeof(szprod_cont_seq) );
			Mem_Set( (byte*)szindi_vc_after,0x00, sizeof(szindi_vc_after) );
			Mem_Set( (byte*)szindi_va_after,0x00, sizeof(szindi_va_after) );
			Mem_Set( (byte*)szindi_vm_after,0x00, sizeof(szindi_vm_after) );
			Mem_Set( (byte*)szkeeper_yn,0x00, sizeof(szkeeper_yn) );
			Mem_Set( (byte*)szsealed_sts,0x00, sizeof(szsealed_sts) );
			Mem_Set( (byte*)szcont_revis_para,0x00, sizeof(szcont_revis_para) );
			Mem_Set( (byte*)szbiz_type_cd,0x00, sizeof(szbiz_type_cd) );
			Mem_Set( (byte*)szprod_cd,0x00, sizeof(szprod_cd) );
			Mem_Set( (byte*)szbill_gubun,0x00, sizeof(szbill_gubun) );
			Mem_Set( (byte*)szaccount,0x00, sizeof(szaccount) );
			Mem_Set( (byte*)szInst_place_num,0x00, sizeof(szInst_place_num) );
			Mem_Set( (byte*)szProd_sts_cd,0x00, sizeof(szProd_sts_cd));
			Mem_Set( (byte*)szCont_flag_cd,0x00, sizeof(szCont_flag_cd));

			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)szcivil_serv_receive_num,  15, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)sztreat_seq,  10, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szmtr_num,  11, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szuse_cont_num,  11, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szprod_cont_seq, 4, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szindi_vc_after, 10, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szindi_va_after, 10, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szindi_vm_after, 10, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szkeeper_yn, 2, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szsealed_sts, 2, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szcont_revis_para, 11, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szbiz_type_cd, 7, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szprod_cd, 5, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szbill_gubun, 3, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szaccount, 14, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szInst_place_num, 10, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szProd_sts_cd, 3, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szCont_flag_cd, 3, DECRYPT);
			
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "civil_serv_receive_num" , szcivil_serv_receive_num  );
			JSON_SetArrayItem(js, 'C', "treat_seq" , sztreat_seq  );
			JSON_SetArrayItem(js, 'C', "mtr_num" , szmtr_num  );
			
			if( g_nWorkFlag == 620 )
			{
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "10" ); //전출
			}
			else if( g_nWorkFlag == 630 )
			{
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "20" ); //중지
			}
			else
			{
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "" ); //기타
			}
				
			if(stMw.szZip_no1[0] == '4' )
			{
				JSON_SetArrayItem(js, 'C', "prod_area_flag" , "20"  );
			}
			else
			{
				JSON_SetArrayItem(js, 'C', "prod_area_flag" , "10"  );
			}
			
			JSON_SetArrayItem(js, 'C', "use_cont_num" , szuse_cont_num  );
			JSON_SetArrayItem(js, 'C', "prod_cont_seq", szprod_cont_seq );
			JSON_SetArrayItem(js, 'C', "indi_vc", szindi_vc_after );
			JSON_SetArrayItem(js, 'C', "indi_va", szindi_va_after );
			JSON_SetArrayItem(js, 'C', "indi_vm", szindi_vm_after );			
			JSON_SetArrayItem(js, 'C', "keeper_yn", szkeeper_yn );
			JSON_SetArrayItem(js, 'C', "sealed_sts", szsealed_sts );
			JSON_SetArrayItem(js, 'C', "cont_revis_para", szcont_revis_para );
			JSON_SetArrayItem(js, 'C', "biz_type_cd", szbiz_type_cd );
			JSON_SetArrayItem(js, 'C', "prod_cd", szprod_cd );
			JSON_SetArrayItem(js, 'C', "bill_gubun", szbill_gubun );
			JSON_SetArrayItem(js, 'C', "account", szaccount );
			JSON_SetArrayItem(js, 'C', "inst_place_num", szInst_place_num );
			JSON_SetArrayItem(js, 'C', "prod_sts_cd", szProd_sts_cd );
			JSON_SetArrayItem(js, 'C', "cont_flag_cd",szCont_flag_cd);
			
			ret =1;
		};
		
		if( ret == 1)
		{
			JSON_Attach(pj, "mtr", js);
		}
		
	Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		DelSqLite(sql);

		return ret;
	}

	/*=======================================================================================
	함수명 : Add_ChgMtr
	기  능 : 계량기 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_ChgMtr(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		byte* signimg = NULL;
		char* szfile =  NULL;
		char szScrPht[128];
		long filesize = 0, fd;
		handle file;
		SQLITE sql = NewSqLite();
		handle js = NULL;
		
		js = JSON_Create(JSON_Array);
		
		if( js == NULL  )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT MTR_NUM,REPL_TREAT_YMD,MTR_FEE_FREE_FLAG,MTR_BAR,MTR_REPL_WHY,AFTER_MTR_ID_NUM \
,AFTER_MTR_MODEL_CD,AFTER_MTR_GRD,AFTER_MTR_TYPE,AFTER_MTR_REMOTE_FLAG,AFTER_MTR_KIND \
,AFTER_MTR_DIGIT_CNT,AFTER_MTR_NEW_FIX_FLAG,AFTER_FIX_FIRM_NM_CD,AFTER_MTR_VALID_YM,AFTER_FORM_APPRO_YN \
,BEFO_MTR_ID_NUM,BEFO_MTR_MODEL_CD,BEFO_MTR_GRD,BEFO_MTR_TYPE \
,BEFO_MTR_REMOTE_FLAG,BEFO_MTR_KIND,BEFO_MTR_DIGIT_CNT,BEFO_MTR_NEW_FIX_FLAG,BEFO_FIX_FIRM_NM_CD \
,BEFO_MTR_VALID_YM,BEFO_MTR_APPRO_YN,REMOVE_INDI_VM,REMOVE_INDI_VA,REMOVE_INDI_VC \
,INST_INDI_VM,INST_INDI_VA,INST_INDI_VC,JOB_DTM,CENTER_CD ,INST_PLACE_NUM \
,IFNULL(BATTERY_YN,'') , IFNULL(OTHER_PRICE,'') , IFNULL(MTRDISPLAY_YN,'') , IFNULL(REMOTE_SYSTEM,'') , OLD_MTR_ID_NUM \
 FROM C6101_CHG_MTR_INFO WHERE PROMISE_ASSIGN_SEQ = ? ");
 
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while( sql->Next(sql) )
		{

			Mem_Set( (byte*)&stChgMtr, 0x00, sizeof(stChgMtr) );
		
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szMtr_num               ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szRepl_treat_ymd        ,8 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szMtr_fee_free_flag     ,1 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szMtr_bar               ,20+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szMtr_repl_why          ,3 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_id_num      ,20+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_model_cd    ,5 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_grd         ,8 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_type        ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_remote_flag ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_kind        ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_digit_cnt   ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_new_fix_flag,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_fix_firm_nm_cd  ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_mtr_valid_ym    ,6 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szAfter_form_appro_yn   ,1 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_id_num       ,20+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_model_cd     ,5 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_grd          ,8 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_type         ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_remote_flag  ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_kind         ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_digit_cnt    ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_new_fix_flag ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_fix_firm_nm_cd   ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_valid_ym     ,6 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szBefo_mtr_appro_yn     ,1 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szRemove_indi_vm        ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szRemove_indi_va        ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szRemove_indi_vc        ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szInst_indi_vm          ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szInst_indi_va          ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szInst_indi_vc          ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szJob_dtm               ,15+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szCenter_cd             ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.szInst_place_num        ,9 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.battery_yn              ,2 +1 ,DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.other_price             ,10+1 ,DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.mtrdisplay_yn           ,2 +1 ,DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.remote_system           ,2 +1,DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChgMtr.old_mtr_id_num          ,25+1 ,DECRYPT);
				
			JSON_AddArrayItem(js);

			JSON_SetArrayItem(js, 'C', "mtr_num"                , stChgMtr.szMtr_num                 );
			JSON_SetArrayItem(js, 'C', "repl_treat_ymd"         , stChgMtr.szRepl_treat_ymd          );
			JSON_SetArrayItem(js, 'C', "mtr_fee_free_flag"      , stChgMtr.szMtr_fee_free_flag       );
			JSON_SetArrayItem(js, 'C', "mtr_bar"                , stChgMtr.szMtr_bar                 );
			JSON_SetArrayItem(js, 'C', "mtr_repl_why"           , stChgMtr.szMtr_repl_why            );
			JSON_SetArrayItem(js, 'C', "after_mtr_id_num"       , stChgMtr.szAfter_mtr_id_num        );
			JSON_SetArrayItem(js, 'C', "after_mtr_model_cd"     , stChgMtr.szAfter_mtr_model_cd      );
			JSON_SetArrayItem(js, 'C', "after_mtr_grd"          , stChgMtr.szAfter_mtr_grd           );
			JSON_SetArrayItem(js, 'C', "after_mtr_type"         , stChgMtr.szAfter_mtr_type          );
			JSON_SetArrayItem(js, 'C', "after_mtr_remote_flag"  , stChgMtr.szAfter_mtr_remote_flag   );
			JSON_SetArrayItem(js, 'C', "after_mtr_kind"         , stChgMtr.szAfter_mtr_kind          );
			JSON_SetArrayItem(js, 'C', "after_mtr_digit_cnt"    , stChgMtr.szAfter_mtr_digit_cnt     );
			JSON_SetArrayItem(js, 'C', "after_mtr_new_fix_flag" , stChgMtr.szAfter_mtr_new_fix_flag  );
			JSON_SetArrayItem(js, 'C', "after_fix_firm_nm_cd"   , stChgMtr.szAfter_fix_firm_nm_cd    );
			JSON_SetArrayItem(js, 'C', "after_mtr_valid_ym"     , stChgMtr.szAfter_mtr_valid_ym      );
			JSON_SetArrayItem(js, 'C', "after_form_appro_yn"    , stChgMtr.szAfter_form_appro_yn     );
			JSON_SetArrayItem(js, 'C', "befo_mtr_id_num"        , stChgMtr.szBefo_mtr_id_num         );
			JSON_SetArrayItem(js, 'C', "befo_mtr_model_cd"      , stChgMtr.szBefo_mtr_model_cd       );
			JSON_SetArrayItem(js, 'C', "befo_mtr_grd"           , stChgMtr.szBefo_mtr_grd            );
			JSON_SetArrayItem(js, 'C', "befo_mtr_type"          , stChgMtr.szBefo_mtr_type           );
			JSON_SetArrayItem(js, 'C', "befo_mtr_remote_flag"   , stChgMtr.szBefo_mtr_remote_flag    );
			JSON_SetArrayItem(js, 'C', "befo_mtr_kind"          , stChgMtr.szBefo_mtr_kind           );
			JSON_SetArrayItem(js, 'C', "befo_mtr_digit_cnt"     , stChgMtr.szBefo_mtr_digit_cnt      );
			JSON_SetArrayItem(js, 'C', "befo_mtr_new_fix_flag"  , stChgMtr.szBefo_mtr_new_fix_flag   );
			JSON_SetArrayItem(js, 'C', "befo_fix_firm_nm_cd"    , stChgMtr.szBefo_fix_firm_nm_cd     );
			JSON_SetArrayItem(js, 'C', "befo_mtr_valid_ym"      , stChgMtr.szBefo_mtr_valid_ym       );
			JSON_SetArrayItem(js, 'C', "befo_mtr_appro_yn"      , stChgMtr.szBefo_mtr_appro_yn       );
			JSON_SetArrayItem(js, 'C', "remove_indi_vm"         , stChgMtr.szRemove_indi_vm          );
			JSON_SetArrayItem(js, 'C', "remove_indi_va"         , stChgMtr.szRemove_indi_va          );
			JSON_SetArrayItem(js, 'C', "remove_indi_vc"         , stChgMtr.szRemove_indi_vc          );
			JSON_SetArrayItem(js, 'C', "inst_indi_vm"           , stChgMtr.szInst_indi_vm            );
			JSON_SetArrayItem(js, 'C', "inst_indi_va"           , stChgMtr.szInst_indi_va            );
			JSON_SetArrayItem(js, 'C', "inst_indi_vc"           , stChgMtr.szInst_indi_vc            );
			JSON_SetArrayItem(js, 'C', "job_dtm"                , stChgMtr.szJob_dtm                 );
			JSON_SetArrayItem(js, 'C', "center_cd"              , stChgMtr.szCenter_cd               );
			JSON_SetArrayItem(js, 'C', "inst_place_num"         , stChgMtr.szInst_place_num          );
			JSON_SetArrayItem(js, 'C', "battery_yn"         	, stChgMtr.battery_yn          		 );
			JSON_SetArrayItem(js, 'C', "other_price"         	, stChgMtr.other_price          	 );
			JSON_SetArrayItem(js, 'C', "mtrdisplay_yn"          , stChgMtr.mtrdisplay_yn          	 );
			JSON_SetArrayItem(js, 'C', "remote_system"         	, stChgMtr.remote_system          	 );
			JSON_SetArrayItem(js, 'C', "old_mtr_id_num"         , stChgMtr.old_mtr_id_num          	 );

			Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
			SPRINT (szScrPht, "%s/MBM%s.jjp", PHOTO_MW,  stChgMtr.szMtr_num, 0);
			filesize = FFS_GetSize( szScrPht );
			if(filesize > 0)
			{
				signimg = Mem_Alloc(filesize);
				
				fd = FFS_Open(szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
				FFS_Read ( fd, (byte*)signimg, filesize );
				FFS_Close(fd);
		
				file = BASE64_Create();
				BASE64_Encode(file, signimg, filesize );
				szfile = BASE64_GetResult(file);	
				JSON_SetArrayItem( js, 'C', "photo_b"   ,szfile );
				free((byte*)signimg);
				BASE64_Finalize(file);
				file = NULL;
			}
			
			Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
			SPRINT (szScrPht, "%s/MAM%s.jjp", PHOTO_MW,  stChgMtr.szMtr_num, 0);
			filesize = FFS_GetSize( szScrPht );
			if(filesize > 0)
			{
				signimg = Mem_Alloc(filesize);
				
				fd = FFS_Open(szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
				FFS_Read ( fd, (byte*)signimg, filesize );
				FFS_Close(fd);
		
				file = BASE64_Create();
				BASE64_Encode(file, signimg, filesize );
				szfile = BASE64_GetResult(file);	
				JSON_SetArrayItem( js, 'C', "photo_a"   ,szfile );
				free((byte*)signimg);
				BASE64_Finalize(file);
				file = NULL;
			}
			
			ret =1;
		};
		
		if( ret == 1)
		{
			JSON_Attach(pj, "chgmtr", js);
		}
		
	Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}

		DelSqLite(sql);

		return ret;
	}

	/*=======================================================================================
	함수명 : Add_Nonpay
	기  능 : 정산데이터 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_Nonpay(handle pj)
	{
		long ret = -1;
		long idx = 0;
		long amtChkYn;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		handle js = NULL;
		char szUse_cont_num [10+1];
		char szProd_cont_seq[3 +1];
		char szReq_ym       [6 +1];
		char szDeadline_flag[2 +1];
		char szChk          [1 +1];
		char szCard_yn      [1 +1];
		char szUnpay_amt    [10+1];
		char szMtr_num      [10+1];
		char szSql[300];
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		amtChkYn = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_YN = '1' AND AMT_CHK_YN ='Y'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &amtChkYn );

		if(amtChkYn > 0)
		{
			hstmt = sql->CreateStatement(sql, "select USE_CONT_NUM, PROD_CONT_SEQ, REQ_YM, \
			DEADLINE_FLAG, CHK, CARD_YN, SUB_UNPAY_AMT AS UNPAY_AMT, MTR_NUM \
			from C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? \
			UNION \
			select USE_CONT_NUM, PROD_CONT_SEQ, REQ_YM, \
			DEADLINE_FLAG, CHK_YN AS CHK, CARD_YN, CASE WHEN AMT_CHK_YN ='Y' THEN SUB_ACCOUNT WHEN AMT_CHK_YN ='N' THEN ACCOUNT END AS UNPAY_AMT, MTR_NUM \
			from C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ? AND ACCOUNT > 0  ");

		}
		else
		{
			hstmt = sql->CreateStatement(sql, "select USE_CONT_NUM, PROD_CONT_SEQ, REQ_YM, \
			DEADLINE_FLAG, CHK, CARD_YN, UNPAY_AMT, MTR_NUM \
			from C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? \
			UNION \
			select USE_CONT_NUM, PROD_CONT_SEQ, REQ_YM, \
			DEADLINE_FLAG, CHK_YN AS CHK, CARD_YN, CASE WHEN AMT_CHK_YN ='Y' THEN SUB_ACCOUNT WHEN AMT_CHK_YN ='N' THEN ACCOUNT END AS UNPAY_AMT, MTR_NUM \
			from C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ? AND ACCOUNT > 0  ");

		}
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szUse_cont_num , 0x00, sizeof(szUse_cont_num ) );
			Mem_Set( (byte*)szProd_cont_seq, 0x00, sizeof(szProd_cont_seq) );
			Mem_Set( (byte*)szReq_ym       , 0x00, sizeof(szReq_ym       ) );
			Mem_Set( (byte*)szDeadline_flag, 0x00, sizeof(szDeadline_flag) );
			Mem_Set( (byte*)szChk          , 0x00, sizeof(szChk          ) );
			Mem_Set( (byte*)szCard_yn      , 0x00, sizeof(szCard_yn      ) );
			Mem_Set( (byte*)szUnpay_amt    , 0x00, sizeof(szUnpay_amt    ) );
			Mem_Set( (byte*)szMtr_num      , 0x00, sizeof(szMtr_num      ) );
			
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)szUse_cont_num ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szProd_cont_seq,3 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szReq_ym       ,6 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szDeadline_flag,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szChk          ,1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szCard_yn      ,1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szUnpay_amt    ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szMtr_num      ,10+1, DECRYPT);
			
			JSON_AddArrayItem(js);
				
			JSON_SetArrayItem(js, 'C',  "use_cont_num" ,szUse_cont_num    );
			JSON_SetArrayItem(js, 'C',  "prod_cont_seq",szProd_cont_seq   );
		    JSON_SetArrayItem(js, 'C',  "req_ym"       ,szReq_ym          );
			JSON_SetArrayItem(js, 'C',  "deadline_flag",szDeadline_flag   );
			JSON_SetArrayItem(js, 'C',  "chk"          ,szChk             );
			JSON_SetArrayItem(js, 'C',  "card_yn"      ,szCard_yn         );
			JSON_SetArrayItem(js, 'C',  "unpay_amt"    ,szUnpay_amt       );
			JSON_SetArrayItem(js, 'C',  "mtr_num"      ,szMtr_num         );
			
			if(szChk[0] != '1' || szCard_yn[0] == '1' )
			{
				JSON_SetArrayItem(js, 'C',  "adj_type_cd"  ,"20"     );
			}
			else
			{
				JSON_SetArrayItem(js, 'C',  "adj_type_cd"  ,""     );
			}
				
			ret =1;
		};
		
		if( ret ==1)
		{
			JSON_Attach(pj, "nonpay", js);
		}
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		DelSqLite(sql);
		MessageBoxEx (CONFIRM_OK, szUnpay_amt);

		return ret;
	}

	/*=======================================================================================
	함수명 : Add_CardInfo
	기  능 : 카드 결제 결과 추가
	Param  : 
	Return : 
	========================================================================================*/
	long Add_CardInfo(handle pj)
	{
		long ret = -1;
		long idx = 0;
		long len = 0, i = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[102];
		SQLITE sql = NewSqLite();
		handle js = NULL;
			
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT ITEM_FLAG, REQ_YMD, RECEV_SEQ, DATA_FLAG, RSLT_CD \
												, TERMINAL_NUM, CARD_NUM, VALID_YM, CARD_COM, CARD_TYPE_NM \
												, BUYING_COMP, BUYING_COMP_NM, APPROVAL_AMT, APPROVAL_NUM, ALLOTMENT_MM \
												, APPROVAL_TIME, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, PROMISE_ASSIGN_SEQ \
											 FROM C6101_PROMISE_CARD \
											WHERE PROMISE_ASSIGN_SEQ = ? AND length(APPROVAL_NUM) > 0 AND ITEM_FLAG = '10'");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)&stCardinfo, 0x00, sizeof(stCardinfo) );
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szItem_flag             ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szReq_ymd               ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szRecev_seq             ,3 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szData_flag             ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szRslt_cd               ,1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szTerminal_num          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szCard_num              ,16+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szValid_ym              ,4 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szCard_com              ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szCard_type_nm          ,50+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szBuying_comp           ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szBuying_comp_nm        ,50+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szApproval_amt          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szApproval_num          ,12+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szAllotment_mm          ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szApproval_time         ,14+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szCivil_serv_receive_num,14+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szTreat_seq             ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stCardinfo.szPromise_assign_seq    ,10+1, DECRYPT);

			JSON_AddArrayItem(js);

			JSON_SetArrayItem(js, 'C', "item_flag"             ,stCardinfo.szItem_flag             );
			JSON_SetArrayItem(js, 'C', "req_ymd"               ,stCardinfo.szReq_ymd               );
			JSON_SetArrayItem(js, 'C', "recev_seq"             ,stCardinfo.szRecev_seq             );
			JSON_SetArrayItem(js, 'C', "data_flag"             ,stCardinfo.szData_flag             );
			JSON_SetArrayItem(js, 'C', "rslt_cd"               ,stCardinfo.szRslt_cd               );
			JSON_SetArrayItem(js, 'C', "terminal_num"          ,stCardinfo.szTerminal_num          );
			/*
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			for( i = 0; i < Str_Len( stCardinfo.szCard_num ) ; i++)
			{
				if( stCardinfo.szCard_num[i] == '=' )
				{
					len = i;
					break;
				}
			}
			Mem_Cpy( (byte*)szUcovert, (byte*)stCardinfo.szCard_num, len );
			*/
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stCardinfo.szCard_num );
			JSON_SetArrayItem(js, 'C', "card_num"              ,szUcovert              );
			JSON_SetArrayItem(js, 'C', "valid_ym"              ,stCardinfo.szValid_ym              );
			JSON_SetArrayItem(js, 'C', "card_com"              ,stCardinfo.szCard_com              );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stCardinfo.szCard_type_nm );
			JSON_SetArrayItem(js, 'C', "card_type_nm"          ,szUcovert                          );
			JSON_SetArrayItem(js, 'C', "buying_comp"           ,stCardinfo.szBuying_comp           );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stCardinfo.szBuying_comp_nm );
			JSON_SetArrayItem(js, 'C', "buying_comp_nm"        ,szUcovert                          );
			JSON_SetArrayItem(js, 'C', "approval_amt"          ,stCardinfo.szApproval_amt          );
			JSON_SetArrayItem(js, 'C', "approval_num"          ,stCardinfo.szApproval_num          );
			JSON_SetArrayItem(js, 'C', "allotment_mm"          ,stCardinfo.szAllotment_mm          );

			//2017-07-05 Sanghyun Lee
			//approval_time 형태 -> yymmddhhmmss 를 모두 서버로 송신해야함.
			//서버에서 yymmdd / hhmmss 로 나눠서 각각 필요한 컬럼에 사용하도록 수정.
			//Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			//Mem_Cpy( (byte*)szUcovert, (byte*)stCardinfo.szApproval_time, 6 );
			//JSON_SetArrayItem(js, 'C', "approval_time"         ,szUcovert                          );
			JSON_SetArrayItem(js, 'C', "approval_time"         ,stCardinfo.szApproval_time         );
			JSON_SetArrayItem(js, 'C', "civil_serv_receive_num",stCardinfo.szCivil_serv_receive_num);
			JSON_SetArrayItem(js, 'C', "treat_seq"             ,stCardinfo.szTreat_seq             );
			JSON_SetArrayItem(js, 'C', "promise_assign_seq"    ,stCardinfo.szPromise_assign_seq    );
			JSON_SetArrayItem(js, 'C', "use_cont_num"          ,stMw.szUse_cont_num                );
			
			ret =1;
		};
		
		if( ret == 1)
			JSON_Attach(pj, "cardinfo", js);
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Add_OneCardInfo
	기  능 : 일회성 카드 결제 내역 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_OneCardInfo(handle pj)
	{
		long ret = -1;
		long idx = 0;
		long len = 0, i = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[102];
		SQLITE sql = NewSqLite();
		handle js = NULL;
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT ITEM_FLAG, REQ_YMD, RECEV_SEQ, DATA_FLAG, RSLT_CD \
												, TERMINAL_NUM, CARD_NUM, VALID_YM, CARD_COM, CARD_TYPE_NM \
												, BUYING_COMP, BUYING_COMP_NM, APPROVAL_AMT, APPROVAL_NUM, ALLOTMENT_MM \
												, APPROVAL_TIME, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, PROMISE_ASSIGN_SEQ \
											 FROM C6101_PROMISE_CARD \
											WHERE PROMISE_ASSIGN_SEQ = ? AND length(APPROVAL_NUM) > 0 AND ITEM_FLAG = '20'");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)&stOneCardinfo, 0x00, sizeof(stOneCardinfo) );
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szItem_flag             ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szReq_ymd               ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szRecev_seq             ,3 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szData_flag             ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szRslt_cd               ,1 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szTerminal_num          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szCard_num              ,16+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szValid_ym              ,4 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szCard_com              ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szCard_type_nm          ,50+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szBuying_comp           ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szBuying_comp_nm        ,50+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szApproval_amt          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szApproval_num          ,12+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szAllotment_mm          ,2 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szApproval_time         ,14+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szCivil_serv_receive_num,14+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szTreat_seq             ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stOneCardinfo.szPromise_assign_seq    ,10+1, DECRYPT);

			JSON_AddArrayItem(js);

			JSON_SetArrayItem(js, 'C', "item_flag"             ,stOneCardinfo.szItem_flag             );
			JSON_SetArrayItem(js, 'C', "req_ymd"               ,stOneCardinfo.szReq_ymd               );
			JSON_SetArrayItem(js, 'C', "recev_seq"             ,stOneCardinfo.szRecev_seq             );
			JSON_SetArrayItem(js, 'C', "data_flag"             ,stOneCardinfo.szData_flag             );
			JSON_SetArrayItem(js, 'C', "rslt_cd"               ,stOneCardinfo.szRslt_cd               );
			JSON_SetArrayItem(js, 'C', "terminal_num"          ,stOneCardinfo.szTerminal_num          );

			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			
			/*
			for( i = 0; i < Str_Len( stOneCardinfo.szCard_num ) ; i++)
			{
				if( stOneCardinfo.szCard_num[i] == '=' )
				{
					len = i;
					break;
				}
			}
			Mem_Cpy( (byte*)szUcovert, (byte*)stOneCardinfo.szCard_num, len );
			*/
			
			SQL_ConvUcStr( szUcovert, stOneCardinfo.szCard_num );
			JSON_SetArrayItem(js, 'C', "card_num"              ,szUcovert                             );
			JSON_SetArrayItem(js, 'C', "valid_ym"              ,stOneCardinfo.szValid_ym              );
			JSON_SetArrayItem(js, 'C', "card_com"              ,stOneCardinfo.szCard_com              );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stOneCardinfo.szCard_type_nm );
			JSON_SetArrayItem(js, 'C', "card_type_nm"          ,szUcovert                             );
			
			JSON_SetArrayItem(js, 'C', "buying_comp"           ,stOneCardinfo.szBuying_comp           );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stOneCardinfo.szBuying_comp_nm );
			JSON_SetArrayItem(js, 'C', "buying_comp_nm"        ,szUcovert                             );
			
			JSON_SetArrayItem(js, 'C', "approval_amt"          ,stOneCardinfo.szApproval_amt          );
			JSON_SetArrayItem(js, 'C', "approval_num"          ,stOneCardinfo.szApproval_num          );
			JSON_SetArrayItem(js, 'C', "allotment_mm"          ,stOneCardinfo.szAllotment_mm          );
			JSON_SetArrayItem(js, 'C', "approval_time"         ,stOneCardinfo.szApproval_time         );
			JSON_SetArrayItem(js, 'C', "civil_serv_receive_num",stOneCardinfo.szCivil_serv_receive_num);
			JSON_SetArrayItem(js, 'C', "treat_seq"             ,stOneCardinfo.szTreat_seq             );
			JSON_SetArrayItem(js, 'C', "promise_assign_seq"    ,stOneCardinfo.szPromise_assign_seq    );
			JSON_SetArrayItem(js, 'C', "use_cont_num"          ,stMw.szUse_cont_num                   );
			
			ret =1;
		};
		
		if( ret == 1)
			JSON_Attach(pj, "onecardinfo", js);
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		} 
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Add_Chk
	기  능 : 점검 데이터 Setting
	Param  : 
	Return : 
	========================================================================================*/
	long Add_Chk(handle pj)
	{
		long ret = -1;
		long idx = 0;
		long len = 0, i = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[102];
		SQLITE sql = NewSqLite();
		handle js = NULL;
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT PROMISE_ASSIGN_SEQ, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, ACC_TAKE_ACT, ACC_CAUSE \
											    , ACC_CAUSE_RMK, ACC_LOC1, ACC_LOC2, ACC_LOC_RMK \
											 FROM C6101_PROMISE_CHK \
											WHERE PROMISE_ASSIGN_SEQ = ? AND SEND_YN = 'S'");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)&stChk, 0x00, sizeof(stChk) );
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szPromise_assign_seq      ,2  +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szCivil_serv_receive_num  ,2  +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szTreat_seq               ,2  +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szAcc_take_act            ,2  +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szAcc_cause               ,2  +1, DECRYPT);
			
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szAcc_cause_rmk           ,50 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szAcc_loc1                ,2  +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szAcc_loc2                ,2  +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stChk.szAcc_loc_rmk             ,50 +1, DECRYPT);

			JSON_AddArrayItem(js);
			
			JSON_SetArrayItem(js, 'C', "civil_serv_receive_num"   , stChk.szCivil_serv_receive_num);
			JSON_SetArrayItem(js, 'C', "treat_seq"                , stChk.szTreat_seq             );
			JSON_SetArrayItem(js, 'C', "acc_take_act"             , stChk.szAcc_take_act          );
			JSON_SetArrayItem(js, 'C', "acc_cause"                , stChk.szAcc_cause             );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stChk.szAcc_cause_rmk );
			JSON_SetArrayItem(js, 'C', "acc_cause_rmk"            , szUcovert                     );
			
			JSON_SetArrayItem(js, 'C', "acc_loc1"                 , stChk.szAcc_loc1              );
			JSON_SetArrayItem(js, 'C', "acc_loc2"                 , stChk.szAcc_loc2              );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stChk.szAcc_loc_rmk );
			JSON_SetArrayItem(js, 'C', "acc_loc_rmk"              , szUcovert                     );
			
			ret =1;
		};
		
		if( ret == 1)
			JSON_Attach(pj, "chk", js);
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Bill_Pirnt_GetData
	기  능 : 영수증
	Param  : 
	Return : 
	========================================================================================*/
	void* Bill_Pirnt_GetData(void)
	{
		long ret, idx, row;
		long lChk = 0;
		char LineSpace[]={0x1b,0x20,0x00};
		char szBuf[300];
		char szMsg[300];
		char sztmp[300];
		char szBillPreiod[300];
		char szFirstNm[32];
		char szLastNm[32];
		char szMtrNum[32];
		char sztmp1[300];
		char sztmp2[300];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		long mtrcnt;
		long i, tot, len;
		long onceamt, payamt, nonpayamt;
		CARRAYLIST list = NULL;

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}
		
		if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0  ||  Str_AtoI(stMw.szAdj_alt_amt) > 0 ) 
		{
			list->append(list, "--------------------------------");
			list->append(list, "       영 수 증 (고 객 용)      ");
			list->append(list, "--------------------------------");
			list->append(list, "       서울도시가스(주)         ");
			list->append(list, "서울시 강서구 염창동 281\n");
			list->append(list, "사업자 번호: 109-81-31605\n");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp ,"대표이사 : " );
			Str_Cat(sztmp ,stUserinfo.szScg_repre_nm );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "전화번호 : 1588-5788            ");
			list->append(list, "--------------------------------");

			Mem_Set( (byte*)szFirstNm, 0x00, sizeof(szFirstNm) );
			Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm));

			if(Str_Cmp (stMw.szPda_duty_flag, "10") == 0)
			{
				if( Str_Len(stMw.szTrans_in_cust_nm) < 6 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 4 && Str_Len(stMw.szTrans_in_cust_nm) < 8)
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+4, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					Str_Cat(szBuf, szLastNm);

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 6 && Str_Len(stMw.szTrans_in_cust_nm) < 10 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+6, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 8 && Str_Len(stMw.szTrans_in_cust_nm) < 12 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+8, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
				Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
				Str_Cpy(sztmp, "고객번호 : ");
				Str_Cat(sztmp, szBuf);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szBuf, (byte*)g_szUSE_CONT_NUM , 5);
				Mem_Cpy( (byte*)szMsg, (byte*)g_szUSE_CONT_NUM +5, 5);
				Str_Cpy(sztmp, "계약번호 : ");
				Str_Cat(sztmp, szBuf);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
			}
			else
			{
				if(Str_Cmp(stMw.szCont_sts_cd, "30") != 0)
				{
					if( Str_Len(stMw.szCust_nm) < 6 )
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "***");
						g_Line_Print(list, szBuf,"","",LEFT,0);
					}
					else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "***");
						Str_Cat(szBuf, szLastNm);

						g_Line_Print(list, szBuf,"","",LEFT,0);
					}
					else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "******");
						Str_Cat(szBuf, szLastNm);
						g_Line_Print(list, szBuf,"","",LEFT,0);
					}
					else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "******");
						Str_Cat(szBuf, szLastNm);
						g_Line_Print(list, szBuf,"","",LEFT,0);
					}

					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
					Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
					Str_Cpy(sztmp, "고객번호 : ");
					Str_Cat(sztmp, szBuf);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, szMsg);
					g_Line_Print(list, sztmp,"","",LEFT,0);

					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
					Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
					Str_Cpy(sztmp, "계약번호 : ");
					Str_Cat(sztmp, szBuf);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, szMsg);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}

			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
			}

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "지번주소 : ");
			Str_Cat(sztmp, stMw.szCity);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szCounty);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szTown);
			if( Str_Len(stMw.szVillage_ri) > 0)
			{
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szVillage_ri);
			}

			if( Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}

			if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szVillage);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szBuilding);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szHouse_cnt);
				if( Str_Len(sztmp) > 32 )
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg,"           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szAddr1_m);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szAddr1_s);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szHouse_cnt);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szEtc_addr);
				if(Str_Len(sztmp) > 32)
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}

			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "도로명주소 : ");
				Str_Cat(sztmp, stMw.szCity);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szCounty );
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_road_nm);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_addr_m );
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szNew_addr_s);
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
						
			list->append(list, "--------------------------------");

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "검침일/납기 : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "일/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "납기");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			//계량기 중간정산 내역을 출력후 월미납액출력
			mtrcnt = 0;

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(sztmp, "SELECT COUNT(*) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( sztmp, &mtrcnt );

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			nonpayamt = 0;
			for( i = 0 ; i < mtrcnt ; i++)
			{
				sql = NewSqLite();

				hdb = sql->Open(sql);
				if( hdb == NULL )
				{
					goto Finally2;
				}

				hstmt = sql->CreateStatement(sql, "select MTR_NUM, MTR_ID_NUM, CHK_YN, \
INDI_VC, TOT_USE_QTY, TOT_REVIS_QTY, SUPPLY_UNIT_ENER,  \
ACCOUNT, USE_PERIOD_STR, USE_PERIOD_END  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");
				if( hstmt == NULL )
				{
					PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally2;
				}

				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
				sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
				row = 1;
				sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);

				if(sql->Execute(sql) == FALSE)
				{
					PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally2;
				}

				Mem_Set((byte*)szBillPreiod, 0x00, sizeof(szBillPreiod));
				while( sql->Next(sql) )
				{
					idx = 0;
					
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					
					Str_Cpy( sztmp, "계량기번호  : " );
					Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
					sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);
					Mem_Cpy( (byte*)szMsg, (byte*)szMtrNum, 5 );
					Mem_Cpy( (byte*)szBuf, (byte*)szMtrNum+5, 4 );
					Str_Cat(sztmp, szMsg );
					Str_Cat(sztmp, "-" );
					Str_Cat(sztmp, szBuf );
					g_Line_Print(list,  sztmp, "", "", LEFT, 0);
					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "기물번호    : ");
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,26+1, DECRYPT);
					Str_Cat(sztmp, szBuf );
					g_Line_Print(list, sztmp,"","",LEFT,0);

					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
					if(szBuf[0] == '1' )//수납으로 표시
					{
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "지      침  : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,10+1, DECRYPT);
						Str_Cat(sztmp,  szBuf);
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);

						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "사  용  량  : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						Str_Cat(sztmp, szBuf );
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "보  정  량  : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						Str_Cat(sztmp, szBuf );
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Str_Cpy(sztmp, "단 위 열 량 : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						Str_Cat(sztmp, szBuf );
						Str_Cat(sztmp, "㎥ " );
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						//Str_Cpy(szBillPreiod, "이사 정산액 : ");
						Str_Cpy(szBillPreiod, "   이사 정산액   : ");
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						nonpayamt += Str_AtoI( szBuf );
						Str_Chg( szBuf, STRCHG_INS_COMMA);
						Str_Cat(szBuf, "원");
						len = Str_Len(szBuf);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)szMsg, 0x20, 13 );
						Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
						Str_Cat(szBillPreiod, szMsg );
						Str_Cat(szBillPreiod, "\n" );

						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
						g_Str_DateType(szMsg, szBuf);
						//Str_Cat(szBillPreiod, "사 용 기 간 : " );
						Str_Cat(szBillPreiod, "   사 용 기 간   : " );
						Str_Cat(szBillPreiod, szMsg );
						Str_Cat(szBillPreiod, " \n" );

						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
						g_Str_DateType(szMsg, szBuf);
						Str_Cat(szBillPreiod, "                  ∼ " );
						Str_Cat(szBillPreiod, szMsg );
						Str_Cat(szBillPreiod, " \n" );
					}
				};

		Finally2:
				//sql->Commit(sql);
				DelSqLite(sql);
				
				list->append(list, "--------------------------------");
				
				sql = NewSqLite();

				hdb = sql->Open(sql);
				if( hdb == NULL )
				{
					goto Finally3;
				}

				hstmt = sql->CreateStatement(sql, "select CHK, CASE WHEN REQ_YM ='20' THEN '법적비용 외' ELSE REQ_YM END as REQ_YM, UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
				if( hstmt == NULL )
				{
					PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally3;
				}

				idx = 0;
				sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
				sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);

				if(sql->Execute(sql) == FALSE)
				{
					PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally3;
				}

				while( sql->Next(sql) == TRUE )
				{
					idx = 0;

					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
					if(szBuf[0] == '1' )//월별미납 수납으로 표시
					{
						Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp));
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						Mem_Set( (byte*) sztmp1, 0x00, sizeof( sztmp1) );
						Mem_Set( (byte*) sztmp2, 0x00, sizeof( sztmp2) );
						
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);

						Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );

						if(Str_Len(szBuf) == 4)
						{
							Str_Cpy(sztmp, "   ");
						
							Mem_Cpy((byte*)sztmp1, (byte*)szBuf, 4);
							
							Str_Cat(sztmp1, "년 ");
							Mem_Cpy((byte*)sztmp2, (byte*)szBuf+4, 2);
							Str_Cat(sztmp2, "월   : ");
							
							Str_Cat(sztmp1, sztmp2);
							Str_Cat(sztmp, sztmp1);

						}
						else
						{
							Str_Cat(sztmp, szBuf);
						}

						// Str_Cpy(sztmp, "   ");
						
						// Mem_Cpy((byte*)sztmp1, (byte*)szBuf, 4);
						
						// Str_Cat(sztmp1, "년 ");
						// Mem_Cpy((byte*)sztmp2, (byte*)szBuf+4, 2);
						// Str_Cat(sztmp2, "월   : ");
						
						// Str_Cat(sztmp1, sztmp2);
						// Str_Cat(sztmp, sztmp1);
						
						Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
						sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
						nonpayamt +=  Str_AtoI( szBuf );
						Str_Chg( szBuf, STRCHG_INS_COMMA); 
						Str_Cat(szBuf, "원");
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Set( (byte*)szMsg, 0x20, 13 );
						len = Str_Len(szBuf);
						Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );

						Str_Cat(sztmp, szMsg );
						
						g_Line_Print(list, sztmp,"","",LEFT,0);
					}
				};
		Finally3:
				//sql->Commit(sql);
				DelSqLite(sql);

				if(Str_Len( szBillPreiod) > 0 )
					list->append(list, szBillPreiod);
			}

			if( Str_AtoI(stMw.szAdj_alt_amt) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "   소         계 : ");
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_ItoA( nonpayamt,szBuf ,10);
				Str_Chg(szBuf, STRCHG_INS_COMMA);
				Str_Cat(szBuf, "원");
				len = Str_Len(szBuf);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 13 );
				Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				list->append(list, "--------------------------------");
				/*
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "예수금대체 :     - ");
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_Cpy( szBuf, stMw.szAdj_alt_amt);
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(sztmp, szBuf );
				Str_Cat(sztmp, "원" );
				*/
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "예수금대체 : ");
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_Cpy( szBuf, "- ");
				Str_Cpy( szBuf, stMw.szAdj_alt_amt);
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat( szBuf, "원");
				len = Str_Len(szBuf);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 15 );
				Mem_Cpy((byte*)szMsg+15-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				list->append(list, "--------------------------------");
			}
			
			if( (Str_AtoI(stMw.szCard_gaspay) + Str_AtoI(stMw.szCash_gaspay) ) > 0  ||  Str_AtoI(stMw.szAdj_alt_amt) > 0)
			{
				list->append(list, "                                ");
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "① 가스 사용료계 : ");

				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_ItoA( Str_AtoI(stMw.szCard_gaspay) + Str_AtoI(stMw.szCash_gaspay) , szBuf ,10);
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(szBuf, "원" );
								
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 13 );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
				
				Str_Cat(sztmp, szMsg );
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
				list->append(list, "--------------------------------");
				
				if( Str_AtoI(stMw.szCash_gaspay)  > 0   )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "[ 현  금 ]:  ");
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_Cpy(szBuf, stMw.szCash_gaspay);
					Str_Chg(szBuf, STRCHG_INS_COMMA);
					Str_Cat(szBuf, "원");
					len = Str_Len(szBuf);

					Mem_Set( (byte*)szMsg, 0x00, sizeof( szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 19 );
					Mem_Cpy((byte*)szMsg+19-len, (byte*)szBuf, len  );
					Str_Cat(sztmp, szMsg );
					
					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					if(Str_Cmp (stMw.szPda_duty_flag, "30") == 0)
					{
						list->append(list, "--------------------------------");
						list->append(list, "※ 중지 후 요금청구 금액이      ");
						list->append(list, "   발생될 수 있으니 참고        ");
						list->append(list, "   하시길 바랍니다.             ");
						list->append(list, "--------------------------------");
					}
					else
					{
						list->append(list, "--------------------------------");
					}
				}

				if(  Str_AtoI(stMw.szCard_gaspay) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "[ 카  드 ]:  ");
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Str_Cat( szBuf, stMw.szCard_gaspay);
					Str_Chg( szBuf, STRCHG_INS_COMMA );
					Str_Cat( szBuf, "원");
					ret = Str_Len(szBuf);
					
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 19 );
					Mem_Cpy((byte*)szMsg+19-ret, (byte*)szBuf, ret  );
					Str_Cat(sztmp, szMsg);
					
					g_Line_Print(list, sztmp,"","",LEFT,0);

					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_Cpy(sztmp, " 카드번호 :  ");
					Mem_Cpy((byte*)szBuf, (byte*)stCardinfo.szCard_num , 4);
					szBuf[4] = '-';
					Mem_Cpy( (byte*)szBuf+5, (byte*)stCardinfo.szCard_num+4,  4 );
					szBuf[9] = '-';
					Str_Cat( szBuf, "****-****");
					Str_Cat(sztmp, szBuf);
					g_Line_Print(list, sztmp,"","",LEFT,0);

					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_Cpy(sztmp, " 거래구분 :  ");
					idx = 0;
					idx = g_SearchCD( stCardinfo.szAllotment_mm, CK_CARDMM );
					Str_Cpy(szBuf, CK_CARDMM[idx].Str);
					Str_Cat(sztmp, szBuf );
					g_Line_Print(list, sztmp,"","",LEFT,0);

					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_Cpy(sztmp, " 승인번호 :  ");
					Str_Cat(sztmp, stCardinfo.szApproval_num );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					if(Str_Cmp (stMw.szPda_duty_flag, "30") == 0)
					{
						list->append(list, "--------------------------------");
						list->append(list, "※ 중지 후 요금청구 금액이      ");
						list->append(list, "   발생될 수 있으니 참고        ");
						list->append(list, "   하시길 바랍니다.             ");
						list->append(list, "--------------------------------");
					}
					else
					{
						list->append(list, "--------------------------------");
					}
				}

				if( Str_AtoI(stMw.szOnce_account) == 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_Cpy(sztmp, "총계(①) :  ");
					
					Str_ItoA( Str_AtoI(stMw.szCard_gaspay) + Str_AtoI(stMw.szCash_gaspay) , szBuf ,10);
					Str_Chg( szBuf, STRCHG_INS_COMMA);
					Str_Cat( szBuf, "원" );
					ret = Str_Len(szBuf);

					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 20 );
					
					Mem_Cpy((byte*)szMsg+20-ret, (byte*)szBuf, ret  );
					Str_Cat(sztmp, szMsg);

					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "수납금액 :  ");
					
					Str_Cat(sztmp, szMsg );

					g_Line_Print(list, sztmp,"","",LEFT,0);

					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "수납일자 :  ");
					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Str_ItoA(Time_GetDate(), szBuf, 10);
					g_Str_DateType( szMsg, szBuf);
					Str_Cat(sztmp, szMsg );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					list->append(list, "--------------------------------");
				}
			}
			BT_Print_Spool(TRUE);
			VmSleep(400);
			BT_Clear_Spool();
			
			lChk++;
			
		}

		//연결철거비 일회성 요금이 있으며, 후불이 아닌경우에만 출력
		if( Str_AtoI(stMw.szOnce_account) > 0  && stMw.szAuto_yn[0] != 'Y' )
		{
			list->append(list, "                                ");
			list->append(list, "      연결철거비(고 객 용)      ");
			list->append(list, "--------------------------------");
			list->append(list, "        서울도시가스(주)        ");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			//Str_Cpy(sztmp, "  ");
			Str_Cat(sztmp, stUserinfo.szcenter_nm );
			Str_Cat(sztmp, " 고객센터");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Str_Cpy( sztmp, "상  호  명  : " );
			Str_Cpy( szBuf, stUserinfo.szcom_name );
			
			len = Str_Len(szBuf);
			
			if( len > 18 )
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 32 );
				Mem_Cpy((byte*)szMsg+32-len, (byte*)szBuf, len  );
				Str_Cpy(sztmp, szMsg);
			}
			else
			{	
				// 향후 사용필요 -> 오른쪽 정렬
				//Str_Cpy( sztmp, "상  호  명  : " );
				//Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				//Mem_Set( (byte*)szMsg, 0x20, 18 );
				//Mem_Cpy((byte*)szMsg+18-len, (byte*)szBuf, len  );
				//Str_Cat(sztmp, szMsg);
				
				Str_Cat(sztmp, szBuf );
			}
			
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "사업자번호  : ");
			Mem_Cpy( (byte*)szMsg, (byte*)stUserinfo.szbiz_regi_num, 3 );
			Mem_Cpy( (byte*)szBuf, (byte*)stUserinfo.szbiz_regi_num+3, 2 );
			Str_Cat(sztmp, szMsg );
			Str_Cat(sztmp, "-" );
			Str_Cat(sztmp, szBuf );
			Str_Cat(sztmp, "-" );
			Mem_Cpy( (byte*)szBuf, (byte*)stUserinfo.szbiz_regi_num+5, 5 );
			Str_Cat(sztmp, szBuf );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "대  표  자  : ");
			Str_Cat(sztmp, stUserinfo.szrepre_nm );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "담  당  자  : ");
			Str_Cat(sztmp, stUserinfo.sznm_kor );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "전 화 번 호 : ");
			Str_Cat(sztmp, stUserinfo.sztel );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			if( Str_Len(stMw.szAppro_num) > 0)
			{	
				list->append(list, "--------------------------------");
				
				if( stMw.szOnce_yn[0] == '2' )
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Str_Cpy(sztmp, "현금승인번호: ");
					Str_Cat(sztmp, stMw.szAppro_num );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Str_Cpy(sztmp,"              지출증빙");
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
				else
				{	
					if(Str_Cmp( stMw.szAppro_gubun, "1" ) == 0)
					{
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Str_Cpy( sztmp, "[ 현금 자진발급 ]" );
						g_Line_Print(list, sztmp,"","",LEFT,0);		
					}
					else
					{
						if(Str_Cmp( stMw.szAppro_status_flag, "0" ) == 0)
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							Str_Cpy( sztmp, "[ 현금 소득공제 ]" );
							g_Line_Print(list, sztmp,"","",LEFT,0);		
						}
						else
						{
							Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
							Str_Cpy( sztmp, "[ 현금 지출증빙 ]" );
							g_Line_Print(list, sztmp,"","",LEFT,0);
						}
					}
					
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Str_Cpy(sztmp, "현금승인번호: ");
					Str_Cat(sztmp, stMw.szAppro_num );
					g_Line_Print(list, sztmp,"","",LEFT,0);
					
					
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Str_Cpy(sztmp, "현금확인번호: ");
					
					if( Str_Cmp(stMw.szAppro_status_flag, "0") == 0 )
					{
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Cpy( (byte*)szBuf, (byte*)stMw.szAppro_tel, 3);
						Str_Cat(sztmp, szBuf);
						
						len = Str_Len(stMw.szAppro_tel);
						
						if( len < 11 )
						{
							Str_Cat(sztmp, "-***-");
							
							Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
							Mem_Cpy( (byte*)szBuf, (byte*)stMw.szAppro_tel+6, len-6 );
							Str_Cat(sztmp, szBuf);
							
						}
						else
						{
							Str_Cat(sztmp, "-****-");
							
							Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
							Mem_Cpy( (byte*)szBuf, (byte*)stMw.szAppro_tel+7, len-7 );
							Str_Cat(sztmp, szBuf);
							
						}
					}
					else
					{
					
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Cpy( (byte*)szBuf, (byte*)stMw.szAppro_tel, 3);
						Str_Cat(sztmp, szBuf);
						
						Str_Cat(sztmp, "-**-");
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Cpy( (byte*)szBuf, (byte*)stMw.szAppro_tel+5, len-6 );
						Str_Cat(sztmp, szBuf);
					}
					
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}	
			}

			list->append(list, "--------------------------------");
			Mem_Set( (byte*)szFirstNm, 0x00, sizeof(szFirstNm) );
			Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm));
			
			if(Str_Cmp (stMw.szPda_duty_flag, "10") == 0)
			{
				if( Str_Len(stMw.szTrans_in_cust_nm) < 6 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 4 && Str_Len(stMw.szTrans_in_cust_nm) < 8)
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+4, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					Str_Cat(szBuf, szLastNm);

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 6 && Str_Len(stMw.szTrans_in_cust_nm) < 10 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+6, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 8 && Str_Len(stMw.szTrans_in_cust_nm) < 12 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+8, 2);

					Str_Cpy(szBuf, "고 객 명 : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);

					g_Line_Print(list, szBuf,"","",LEFT,0);
				}

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
				Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
				Str_Cpy(sztmp, "고객번호 : ");
				Str_Cat(sztmp, szBuf);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szBuf, (byte*)g_szUSE_CONT_NUM , 5);
				Mem_Cpy( (byte*)szMsg, (byte*)g_szUSE_CONT_NUM +5, 5);
				Str_Cpy(sztmp, "계약번호 : ");
				Str_Cat(sztmp, szBuf);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
			}
			else
			{
				if(Str_Cmp(stMw.szCont_sts_cd, "30") != 0)
				{
					if( Str_Len(stMw.szCust_nm) < 6 )
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "***");
						g_Line_Print(list, szBuf,"","",LEFT,0);
					}
					else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "***");
						Str_Cat(szBuf, szLastNm);

						g_Line_Print(list, szBuf,"","",LEFT,0);
					}
					else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "******");
						Str_Cat(szBuf, szLastNm);
						g_Line_Print(list, szBuf,"","",LEFT,0);
					}
					else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
					{
						Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
						Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);
						Str_Cpy(szBuf, "고 객 명 : ");
						Str_Cat(szBuf, szFirstNm);
						Str_Cat(szBuf, "******");
						Str_Cat(szBuf, szLastNm);
						g_Line_Print(list, szBuf,"","",LEFT,0);
					}

					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
					Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
					Str_Cpy(sztmp, "고객번호 : ");
					Str_Cat(sztmp, szBuf);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, szMsg);
					g_Line_Print(list, sztmp,"","",LEFT,0);

					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
					Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
					Str_Cpy(sztmp, "계약번호 : ");
					Str_Cat(sztmp, szBuf);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, szMsg);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}

			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
			}

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "지번주소 : ");
			Str_Cat(sztmp, stMw.szCity);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szCounty);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szTown);
			if( Str_Len(stMw.szVillage_ri) > 0)
			{
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szVillage_ri);
			}

			if( Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}

			if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szVillage);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szBuilding);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szHouse_cnt);
				if( Str_Len(sztmp) > 32 )
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg,"           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szAddr1_m);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szAddr1_s);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szHouse_cnt);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szEtc_addr);
				if(Str_Len(sztmp) > 32)
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}

			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "도로명주소 : ");
				Str_Cat(sztmp, stMw.szCity);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szCounty );
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_road_nm);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_addr_m );
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szNew_addr_s);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				list->append(list, "--------------------------------");
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "검침일/납기 : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "일/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "납기");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			//일회성항목 출력

			sql = NewSqLite();

			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally4;
			}

			hstmt = sql->CreateStatement(sql, "select B.ONCE_ITEM_NM, A.ONCE_AMT \
FROM C6101_ONCE_INFO A , C6101_ONCE_ITEM B WHERE A.PROMISE_ASSIGN_SEQ = ? AND A.ONCE_ITEM_CD = B.ONCE_ITEM_CD AND A.ONCE_QTY > 0 ");

			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);

			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}
			onceamt = 0;
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,50+1, DECRYPT);
				Str_Cpy(sztmp, "   ");
				Mem_Set( (byte*)szMsg, 0x20, 14 );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg );
				Str_Cat(sztmp, ": ");
				
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
				onceamt +=  Str_AtoI( szBuf );
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(szBuf, "원" );
				len = Str_Len(szBuf);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 13 );
				Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg );
				g_Line_Print(list, sztmp,"","",LEFT,0);
			};

	Finally4:
			//sql->Commit(sql);
			DelSqLite(sql);
			
			list->append(list, "                                ");
			
			tot = Str_AtoI(stMw.szOnce_account);
			i = tot*10/110;
			tot = tot-i;
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "   공 급   가 액 : ");
			Str_ItoA( tot, szBuf ,10 );
			
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			Str_Cat( szBuf, "원");
			len = Str_Len(szBuf);
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 13 );
			Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
			Str_Cat(sztmp, szMsg);
			
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "   부    가   세 : ");
			Str_ItoA( i, szBuf ,10 );
			
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			Str_Cat(szBuf, "원");
			len = Str_Len(szBuf);
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 13 );
			Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
			Str_Cat(sztmp, szMsg);
			
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0 ||  Str_AtoI(stMw.szAdj_alt_amt) > 0  )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "② 연결 철거비계 : ");
				
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat(szBuf, "원");
				len = Str_Len(szBuf);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 13 );
				Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);

			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "① 연결 철거비계 : ");
				
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat(szBuf, "원");
				len = Str_Len(szBuf);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 13 );
				Mem_Cpy((byte*)szMsg+13-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}

			list->append(list, "--------------------------------");
			
			if( stMw.szCard_onepay[0] == '1' )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "[ 현  금 ]:  ");
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat( szBuf, "원");
				ret = Str_Len(szBuf);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 19 );
				Mem_Cpy((byte*)szMsg+19-ret, (byte*)szBuf, ret  );
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			else if( stMw.szCard_onepay[0] == '2' )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "[ 카  드 ]:  ");
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat( szBuf, "원");
				ret = Str_Len(szBuf);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 19 );
				Mem_Cpy((byte*)szMsg+19-ret, (byte*)szBuf, ret  );
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_Cpy(sztmp, " 카드번호 :  ");
				Mem_Cpy((byte*)szBuf, (byte*)stOneCardinfo.szCard_num , 4);
				szBuf[4] = '-';
				Mem_Cpy( (byte*)szBuf+5, (byte*)stOneCardinfo.szCard_num+4,  4 );
				szBuf[9] = '-';
				Str_Cat( szBuf, "****-****");
				Str_Cat(sztmp, szBuf);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_Cpy(sztmp, " 거래구분 :  ");
				idx = 0;
				idx = g_SearchCD( stOneCardinfo.szAllotment_mm, CK_CARDMM );
				Str_Cpy(szBuf, CK_CARDMM[idx].Str);
				Str_Cat(sztmp, szBuf );
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
				Str_Cpy(sztmp, " 승인번호 :  ");
				Str_Cat(sztmp, stOneCardinfo.szApproval_num );
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}

			list->append(list, "--------------------------------");
			
			if( Str_AtoI(stMw.szCash_gaspay ) > 0 || Str_AtoI(stMw.szCard_gaspay ) > 0  ||  Str_AtoI(stMw.szAdj_alt_amt) > 0 )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cpy(sztmp, "총계(①+②) :  ");
				Str_ItoA( Str_AtoI(stMw.szOnce_account) + Str_AtoI(stMw.szCash_gaspay ) +Str_AtoI(stMw.szCard_gaspay ), szBuf ,10 );
				Str_Chg(szBuf, STRCHG_INS_COMMA);
				Str_Cat(szBuf, "원");
				len = Str_Len(szBuf);
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 17 );
				Mem_Cpy((byte*)szMsg+17-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, "수납금액    :  ");
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				Str_Cat(sztmp, "수납일자    :  ");
				Str_ItoA(Time_GetDate(), szBuf, 10);
				g_Str_DateType( szMsg, szBuf);
				Str_Cat(sztmp, szMsg);
				Str_Cat(sztmp, " ");
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			else
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cpy(sztmp, "총계(①) :  ");
				Str_ItoA( Str_AtoI(stMw.szOnce_account), szBuf ,10 );
				Str_Chg(szBuf, STRCHG_INS_COMMA);
				Str_Cat(szBuf, "원");
				len = Str_Len(szBuf);
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 20 );
				Mem_Cpy((byte*)szMsg+20-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, "수납금액 :  ");
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				Str_Cat(sztmp, "수납일자 :  ");
				Str_ItoA(Time_GetDate(), szBuf, 10);
				g_Str_DateType( szMsg, szBuf);
				Str_Cat(sztmp, szMsg);
				Str_Cat(sztmp, " ");
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			
			list->append(list, "--------------------------------");
			list->append(list, "[서비스 품질 보증기간]          ");
			list->append(list, "1. 연소기 연결 시공 후 2년 이내 ");
			list->append(list, "   제품이상 발생 시 (기존 사용  ");
			list->append(list, "   제품은 해당 없음) 무상으로 재");
			list->append(list, "   시공해 드립니다.             ");
			list->append(list, "2. 소비자 부주의에 의한 품질 훼 ");
			list->append(list, "   손 및 관리 잘못에 의한 변형, ");
			list->append(list, "   제품 보증기간(2년)이 경과한  ");
			list->append(list, "   신규제품은 보상의 책임을 지지");
			list->append(list, "   않으며, 재 시공시 서비스 비용");
			list->append(list, "   을 부담하셔야 합니다.        ");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "소비자상담실 : ");
			Str_Cat(sztmp, stUserinfo.sztel );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			
			lChk++;
		}
		
		if( lChk > 0 )
		{
			list->append(list, "실천하는자율점검정착되는안전문화");
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_Cat(sztmp, "발행일시 : ");
			Str_ItoA(Time_GetDate(), szBuf, 10);
			g_Str_DateType( szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, " ");
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			g_Str_TimeType( szBuf , Time_GetTime());
			Str_Chg(szBuf, STRCHG_DEL_NONDIGIT);
			g_Str_TimeForm(szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "                                ");
			list->append(list, "                                ");
		}
		
		return list;
	}
	
	/*=======================================================================================
	함수명 : Rcv_62604
	기  능 : FR62604 / 사용계약번호, 고객번호 가져옴
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_62604(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
				
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62604, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num", stMw.szInst_place_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR62604;
		ret = HTTP_DownloadData(szUrl, "FR62604_IN",  "FR62604" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	함수명 : TR62604
	기  능 : Rcv_62604 Callback 
	Param  : 
	Return : 
	========================================================================================*/
	long TR62604(void)
	{
		if( Chk_Json_62604() >= 0)
		{
			Bill_Pirnt();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	함수명 : Chk_Json_62604
	기  능 : 사용계약번호 세팅
	Param  : 
	Return : 
	========================================================================================*/
	long Chk_Json_62604(void)
	{		
		char szJsonpath[500];
		char szMsg[500];
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		char *pStr = NULL;
		char *szcode = NULL;
		char *szmessage = NULL;
		char *szuse_cont_num = NULL;
		long *nCol = NULL;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 11;
		handle hitem = NULL;
		handle hcnt = NULL;
			
		MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 62604, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 62604, 0 );
		}

		fsize = FFS_GetSize(szJsonpath);

		if(fsize <= 15)
		{

			ret = -1;
			goto Finally;
		}
		
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);
			szuse_cont_num = JSON_GetValue (g_pjcomm, "use_cont_num", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				
				if(Str_Len(szmessage) < 500 )
				{
					SQL_ConvMbStr( szMsg, szmessage);
				}
				
				g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, szJsonpath);
				EvtDraw();
				ret = -1;
			}
			else
			{
				if( Str_Len(szuse_cont_num) == 10)
				{
					Mem_Set((byte*) g_szUSE_CONT_NUM, 0x00, sizeof( g_szUSE_CONT_NUM) );
					Str_Cpy( g_szUSE_CONT_NUM, szuse_cont_num );
				}
				else
				{
					MessageBoxEx (WARNING_OK, "사용계약번호 생성오류로 작업진행이 불가합니다.");
					EvtDraw();
					ret = -1;
				}
			}
		}
		else
		{
			ret = 0;
		}
		
	Finally:		
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_Close_SubDlg();
		ON_DRAW();
		return ret;
	}
	
	/*=======================================================================================
	함수명 : Move_card
	기  능 : 화면 이동
	Param  : 
	Return : 
	========================================================================================*/	
	long Move_card(void)
	{
		if( g_nWorkFlag == 610 && Str_Cmp( stMw.szInfo_Trans_yn, "Y") == 0 )
		{
			Snd_Info_Trans();
			return 0;
		}
		else
		{
			if( g_nWorkFlag != 620 )
			{
				if( g_nWorkFlag == 610 )
				{
					g_lMobile_Inflow_Path = 0;	
				}
				else
				{
					g_lMobile_Inflow_Path = 5;
				}
			
				Card_Move("CM_MOBILE_USE_DOC_MENU");
				return 0;
			}
			
			Card_Move("C6101_LST");
		}
		
		return 0;
	}
}

