/*----------------------------------------------------------------------------------
	Project Name: Smart 
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.10.01	이상훈		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/

sharecard Calendar
{
	#include "include.h"

#define VER_RELEASE

	/*---------------------------------------------------------------------------*/
	// Description
	//	 캐런더 다이얼로그 띄우고 날짜를 선택한 것을 넘겨준다.
	// prameter
	// 	 dayOfWeek : 요일을 넘겨준다. 0-일, 1-월
	// return 
	//	 0           : 선택인 안 되었다.
	//	 0이 아닌 값 : yy * 10000 + mm * 100 + dd 형식으로 선택된 날짜를 넘겨준다.
	/*---------------------------------------------------------------------------*/
	long CalendarDialog(long *dayOfWeek);

#define CWD			25
#define CHT			40
#define	SPRINT(buf,fmt,a,b,c) Str_Printf((buf),fmt,(quad)(a),(quad)(b),(quad)(c))

#ifdef VER_RELEASE
	#define PNG_EXIT		"pngi"
#else
	#define PNG_EXIT		"png"
#endif

#define FREE(x) \
{\
	if(x)\
	{\
		MEM_DEL((void*)x);\
		x = NULL;\
	}\
}
		
		// 디바이스 화면 크기 분류
enum
{
	FAMILY_PDA,
	FAMILY_SMALL,
	FAMILY_MIDDLE,
	FAMILY_LARGE,
	FAMILY_SUPER
} DisplayType;

#define SIZE_PDA		240*320		// PDA  (PDA 계열)
#define SIZE_SMALL		720*1280	// small (galaxy phone계열)
#define SIZE_MIDDLE		1080*1920	// middle  (galaxy note 계열)
#define SIZE_LARGE		1440*2560	// large  (galaxy pad  계열)
#define SIZE_SUPER		1440*2560	// super  (galaxy pad  계열)


#define	MAKE_RGB(r, g, b) ( ( ( (unsigned long)r << 8 ) & 0x0000f800) | \
							( ( (unsigned long)g << 3 ) & 0x000007e0) | \
							( ( (unsigned long)b >> 3 ) & 0x0000001f)  )
							
#define MAKE_8_16(B) 	( ((((long)B << 8) & 0xc000 ) | ( B & 0x20 ?  0x3800 : 0x0000) ) | \
						( ( ((long)B << 6) & 0x0600 ) | ( B & 0x04 ?  0x01e0 : 0x0000) ) | \
						( ( ((long)B << 3) & 0x0010 ) | ( B & 0x01 ?  0x000f : 0x0000) ) )							

#define		THEBLACK     		MAKE_RGB(0, 0, 0)
#define		THEBLUE     		MAKE_RGB(0, 0, 255)
#define		THERED	     		MAKE_RGB(255, 0, 0)
#define		THEWHITE	    	MAKE_RGB(255, 255, 255)
#define 	TRANSPARENT			MAKE_RGB(255, 0, 255)
#define		BTNCTRLSIDECOLOR	MAKE_RGB(80, 80, 80)
#define		TXTFRCOLOR			BTNCTRLSIDECOLOR
#define		ROYALBLUE			MAKE_8_16(115)

#define	TEXTTITLEBACKCOLOR	THEWHITE
#define	TITLE_BKCOLOR		THEWHITE
#define	DLG_BKCOLOR			THEWHITE
#define	TITLE_FGCOLOR		THEBLACK
#define		BTNCTRLFRCOLOR		THEBLACK  //일반버튼글자색
#define		BTNCTRLBKCOLOR		MAKE_RGB(54, 107, 190) //MAKE_RGB(144, 217, 255) //MAKE_RGB(224, 244, 255) //일반버튼 배경색
/*
#define WQHD_DIR 		"WQHD\\"
#define FHD_DIR 		"FHD\\"
#define HD720_DIR 		"HD720\\"
#define ETC_DIR			"ETC\\"			// 글로벌 이미지
*/

VM_PROFILE 	stProfile;//VM 프로파일정보
long	m_nFontType;
long	m_nType = 0;
/*
void *  m_ImgBg;
void *  m_ImgLeftA;
void *  m_ImgRightA;
void *  m_ImgExitA;
void *  m_ImgLeftI;
void *  m_ImgRightI;
void *  m_ImgExitI;
*/


long DMS_X( long x );
long DMS_Y( long y );
//char* Get_ImgPath(char* trgpath, char* imggb, char* fsnm);
handle MAIN_DLG(char* text, quad del, quad add, quad bkClr, quad TfrClr, quad TbkClr, long T_height );
handle DLG_TXT(handle h_dlg, long id, long x, long y, long width, long height, quad bkClr, quad style, long align, char* text);
handle DLG_BUT(handle hDlg, long index, long x, long y, long width, long height, quad bkClr, quad frClr, quad add, long id, char* text);
handle DLG_IBUT(handle hDlg, long index, long x, long y, long width, long height, long dx, long dy, 
								quad bkClr,quad frClr, quad add, long id, byte* img, byte* actimg, char* text);


/*
	char* Get_ImgPath(char* trgpath, char* imggb, char* fsnm)
	{
	char imgpath[256];
		
		Mem_Set( (byte*)imgpath, 0x00, sizeof(imgpath) );
		
		switch (m_nType)
		{
			case FAMILY_SMALL:
				SPRINT (imgpath, "IMG\\%s%s%s", HD720_DIR, imggb, fsnm);
				break;
			case FAMILY_MIDDLE:
				SPRINT (imgpath, "IMG\\%s%s%s", FHD_DIR, imggb, fsnm);
				break;
			case FAMILY_LARGE:
				SPRINT (imgpath, "IMG\\%s%s%s", WQHD_DIR, imggb, fsnm);
				break;
			case FAMILY_SUPER:
				SPRINT (imgpath, "IMG\\%s%s%s", WQHD_DIR, imggb, fsnm);
				break;
			default:
				Str_Cpy( trgpath, "");
				break;
		}
		
		SPRINT (trgpath, "%s.%s", imgpath, PNG_EXIT, 0);
	
		return trgpath;
	}
*/
	
	
	#define ONEYEAR 			365
	#define ONELEAPYEAR 		366
	#define ONEWEEK 			7
	
	#define CALENDARSIZE 		42	//	달력에 표시할 일자의 개수(가로 7 줄 * 세로 6 줄)

//┌─────────────────────────────────────┐
//│					◈ Card Variables and Functions  					  │
//└─────────────────────────────────────┘
	// STATIC VARIABLES
	handle	m_hDlg;
	handle	m_hCurDateBC;			//	현재 년월일 리셋팅 버튼
	handle 	m_hTC;
	handle	m_hBC[CALENDARSIZE];	//	달력의 각 Cell 버튼
	handle	m_hMonthLeftBC;			//	월 한달 감소 버튼
	handle	m_hMonthRightBC;		//	월 한달 증가 버튼
	handle	m_hBExit;				//	닫기 버튼

	long m_CurrentWeek; //	현재 요일 (0: 일, 1: 월, 2: 화, 3: 수, 4: 목, 5: 금, 6: 토)
	long m_CurrentDate; //	현재 날짜 YYYYMMDD
	long m_CurrentDay;	//	현재 일
	
	long m_InputDate; //	표시 날짜 YYYYMMDD
	
	long m_ChangeYear; 	//	달력을 만들 년도
	long m_ChangeMonth;	//	달력을 만들 월
	long l_monthTemp;
	long m_ChangeDay;	//	달력을 만들 일
	
	long m_CtrlIndex = 0;	//	컨트롤 인덱스(0 ~ 6: 요일 Text, 7 ~ 49: 달력의 각 Cell 버튼
							//				  50: 현재년월일 리셋팅 버튼, 51: 굵은선 Text)
	long m_Cell_ID = 0;
	long m_PrevMonthIndex;
	long m_NextMonthIndex;
//br
//long ChangeWeekDay;			//  바뀔 주의 일		
	long m_Cell[CALENDARSIZE];
	long m_DaysInMonth[2][12] = 
		{
			{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
		 	{31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
		};

	char m_pStrTitle[30];		//	타이틀에 선택한 년도, 월 출력을 위한 버퍼
	char * WEEKDAY[] = {"일", "월", "화", "수", "목", "금",	"토"};
	char m_pStrCell[CALENDARSIZE][3];	//	일자 출력을 위한 버퍼
	
	byte m_CurrentDateStr[20];	//	화면 하단에 현재일자 버튼에 출력하기 위한 버퍼
//┌─────────────────────────────────────┐
//│ 					    ▣  Event Handler  ▣							  │
//└─────────────────────────────────────┘
	// STATIC FUNCTIONS
	void OnInit(char bFirst);
	void OnExit(void);
	void OnChar(long nChar);
	void OnKey( long nKey );
	void OnDraw(void);
	void OnTimer(long nTimerID);
	void OnPointing(long nAction,long X, long Y);
	//return
	//	0 : 닫기 버턴이 눌려
	//	-1: 날짜 조정
	//  >0 : 날짜가 선택된거다.
	long OnButton(long ID);
	void OnSelect(long Index);

	//	USER DEFINE STATIC FUNCTIONS
	long mf_GetDayOfYear(long year, long month, long day);
	long mf_GetNumberOfLeapYear(long CurrentYear, long ChangeYear);
	long mf_IsLeapYear(long year); //윤년인지 아닌지 체크
	void mf_CreateCalendar(void);
	void GetDeviceInfo (void);
	
	//선택된 요일을 저장
	long m_dayOfWeek;
	

	
	long DMS_X( long x )
	{
	long dms_x = 0;
		dms_x = (x*stProfile.LCD_WIDTH)/1000;
		return dms_x;
	}
		
	long DMS_Y( long y )
	{
	long dms_y = 0;
		dms_y = (y*stProfile.LCD_HEIGHT)/1000;
		return dms_y;		
	}
	
	
	void GetDeviceInfo (void)
	{
		long 	nSize = 0;

		Mem_Set ((byte*)&stProfile, 0, sizeof(stProfile));
		
		// 디바이스에 대한 profile을 가져온다.
		VM_GetProfile(&stProfile);
	
		nSize = stProfile.LCD_WIDTH*stProfile.LCD_HEIGHT;
		
		
		if ( nSize <= SIZE_PDA )
		{
			m_nType = FAMILY_PDA;
		}
		else if ( nSize <= SIZE_SMALL )
		{
			m_nType = FAMILY_SMALL;
		}
		else if ( nSize > SIZE_SMALL && nSize < SIZE_MIDDLE )
		{
			m_nType = FAMILY_SMALL;
		}
		else if ( nSize >= SIZE_MIDDLE && nSize < SIZE_LARGE )
		{
			m_nType = FAMILY_MIDDLE;
		}
		else if ( nSize >= SIZE_LARGE && nSize < SIZE_SUPER )
		{
			m_nType = FAMILY_LARGE;
		}
		else if ( nSize >= SIZE_SUPER )
		{
			m_nType = FAMILY_LARGE;
		}
		
		switch (m_nType)
		{
			case FAMILY_PDA:
				m_nFontType = FONT_12;
				break;
			case FAMILY_SMALL:
				m_nFontType = FONT_36;
				break;
			case FAMILY_MIDDLE:
				m_nFontType = FONT_56;
				break;
			case FAMILY_LARGE:
				m_nFontType = FONT_72;
				break;
			case FAMILY_SUPER:
				m_nFontType = FONT_72;
				break;
			default:
				m_nFontType = FONT_24;
				break;
		}
	}
	
//┌─────────────────────────────────────┐
//│ 						『	Main Function 』	   				          │
//└─────────────────────────────────────┘
	//sharecard에서 main함수는 로드된 후에 함수 이름 넘겨 받아서
	//함수 포인터 넘겨주는 역할을 한다.
	int	main (quad MsgType, quad wParam, quad lParam)
	{
		if ( Str_Cmp("CalendarDialog", (char*)MsgType) == 0 )
			return (int)CalendarDialog;
		return 0;
	}
	
	long	CalendarDialog(long *dayOfWeek)
	{
	HandlerMsg msg;

		//넘겨온 일자로 달력셋팅용
		m_InputDate = *dayOfWeek;
		
		OnInit(1);
		OnDraw();
		GrDev_Refresh();
		
		//2017-04-18 SanghyunLee
		//2차 개발 진행 중 > VM 업그레이드 진행 중 다른곳과 충돌?오류? 나는 듯
		//while ( Handler_PeekMessage(&msg) == 0 )
		while ( 1 )
		{
			long nRet = Handler_PeekMessage(&msg);
			//if (nRet == 0)
			//{
			//	break;
			//}

			if ( msg.MsgType == MSG_EXIT )
			{
				HandlerMsg exitMsg;
				OnExit();
				return 0;		
			}
			Handler_GetMessage(&msg);
			switch ( msg.MsgType)
			{
				case MSG_CHAR:			
					OnChar (msg.wParam);	
					break;
				case MSG_KEY:
					OnKey (msg.wParam);		
					break;
				case MSG_POINTING:
					OnPointing (msg.wParam, 
						(long)(msg.lParam & 0xFFFF), (long)(msg.lParam >> 16));
					break;			
				case MSG_BUTTON:
				{
					long ret;
					ret = OnButton (msg.wParam);	
					if ( ret < 0 ) 
						break;
					else if ( ret == 0 )
					{
						//다이얼로그 닫기
						OnExit();
						return 0;
					}
					else 
					{
						//다이어로그 닫고
						OnExit();
						//선택된 날짜 리턴
						*dayOfWeek = m_dayOfWeek;
						return ret;
					}
					break;
				}
			}//end of switch
			OnDraw();
			GrDev_Refresh();
		}// end of while
		return 0;
	}
	
//┌─────────────────────────────────────┐
//│ 				   『	OnInit Function  』  				              │
//└─────────────────────────────────────┘
	void OnInit(char bFirst)
	{
		long TempL;
		long TempL1;
		long TempL2;
		handle hdate;
		char szImg[256];
		Mem_Set( (byte*)szImg, 0x00, sizeof(szImg) );
		
		GetDeviceInfo();
		
		if (bFirst)
		{
			// First init code here
			m_CtrlIndex = 0;

			// Resource creation code here	
			
			m_CurrentDate = Time_GetDate();
			m_CurrentWeek = Time_GetWeek();
			//m_CurrentDay = Time_GetDay();
			if( m_InputDate > 19000101 && m_InputDate < 20501231  && Time_ValidateDate(m_InputDate) == TRUE)
			{			
				m_CurrentDay = m_InputDate % 100;
				
				m_ChangeYear = m_InputDate/10000;		//	현재 년도
				m_ChangeMonth = m_InputDate/100 - (m_InputDate/10000)*100;	//	현재 월
			}
			else
			{
				m_CurrentDay = Time_GetDay();
				m_ChangeYear =Time_GetYear();		//	현재 년도
				m_ChangeMonth = Time_GetMonth();	//	현재 월				
			}
			l_monthTemp = m_ChangeMonth;
			
			m_ChangeDay = 1; 					//	처음에는 1
		
			// Title
			m_hDlg = MAIN_DLG(m_pStrTitle, DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0,  DLG_BKCOLOR, TITLE_FGCOLOR,  TITLE_BKCOLOR , 15);		
			Dialog_SetRange(m_hDlg, DMS_X(30), DMS_Y(180), DMS_X(970), DMS_Y(700));
			
			//전체적으로 배경을 10픽셀만큼 살렸다
			//m_hTC = Dialog_CreateTextCtrl (m_hDlg, m_CtrlIndex++,0, 0, 186, 220, "");
			//EditCtrl_SetBkColor(m_hTC, 234);
			
			//	닫기 버튼 생성
			hdate= DLG_IBUT(m_hDlg, m_CtrlIndex++, 800, 20, 90, 48, 0, 0, BTNCTRLBKCOLOR, BTNCTRLFRCOLOR, 0, 2000, 0, 0, "X");
			EditCtrl_SetFont( hdate, m_nFontType);
			//	월 한달 감소 버튼
			hdate= DLG_IBUT(m_hDlg, m_CtrlIndex++, 40, 20, 90, 48, 0, 0, BTNCTRLBKCOLOR, BTNCTRLFRCOLOR, 0, 1002, 0, 0, "<<");
			EditCtrl_SetFont( hdate, m_nFontType);
			//	월 한달 감소 버튼
			hdate= DLG_IBUT(m_hDlg, m_CtrlIndex++, 135, 20, 90, 48, 0, 0, BTNCTRLBKCOLOR, BTNCTRLFRCOLOR, 0, 1003, 0, 0, "<");
			EditCtrl_SetFont( hdate, m_nFontType);
			//	월 한달 증가 버튼
			hdate= DLG_IBUT(m_hDlg, m_CtrlIndex++, 585, 20, 90, 48, 0, 0, BTNCTRLBKCOLOR, BTNCTRLFRCOLOR,  0, 1004, 0, 0, ">");
			EditCtrl_SetFont( hdate, m_nFontType);
			//	월 한달 증가 버튼
			hdate= DLG_IBUT(m_hDlg, m_CtrlIndex++, 680, 20, 90, 48, 0, 0, BTNCTRLBKCOLOR, BTNCTRLFRCOLOR,  0, 1001, 0, 0, ">>");
			EditCtrl_SetFont( hdate, m_nFontType);
			
			//해당월표시
			hdate = DLG_TXT(m_hDlg, m_CtrlIndex++, 230, 20, 330, 50, TRANSPARENT, EDITSTY_BORDER, EDITALIGN_CENTER, m_pStrTitle);
			EditCtrl_SetBkColorEx( hdate, THEWHITE);
			EditCtrl_SetForeColorEx( hdate, THEBLACK);
			EditCtrl_SetAlign( hdate, EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetFont( hdate, m_nFontType);
			
				
			for (TempL = 0; TempL < 7; TempL++)
			{
				m_hTC = Dialog_CreateTextCtrl(m_hDlg, m_CtrlIndex++, DMS_X(25+TempL * 125 ),   DMS_Y(80), 
																	 DMS_X(25+(TempL+1) * 125),DMS_Y(140), WEEKDAY[TempL]);
	
				if (TempL == 0) //일요일
					EditCtrl_SetForeColorEx(m_hTC, THERED);
				else if (TempL == 6) //토요일
					EditCtrl_SetForeColorEx(m_hTC, THEBLUE);
				else
					EditCtrl_SetForeColorEx(m_hTC, THEBLACK);
					
				
				EditCtrl_SetBkColorEx(m_hTC, TEXTTITLEBACKCOLOR);
				EditCtrl_SetAlign(m_hTC, EDITALIGN_CENTER | EDITALIGN_MIDDLE);
				EditCtrl_SetFont( m_hTC, m_nFontType);
				
				if( m_nType > FAMILY_PDA)
				{
					EditCtrl_ModifyStyle(m_hTC, 0, EDITSTY_BORDER|EDITSTY_THICKBORDER);
					EditCtrl_SetRoundRadius(m_hTC, DMS_X(10));
					EditCtrl_SetRoundThickness(m_hTC, DMS_X(3));
					EditCtrl_SetRoundBoarderColor(m_hTC, ROYALBLUE, ROYALBLUE );
				}
				else
				{
					EditCtrl_ModifyStyle(m_hTC, 0, EDITSTY_BORDER);
				}
				
			}
			
			m_Cell_ID = 0;

			for (TempL = 0, TempL1 = 1, TempL2 = 0; TempL2 < CALENDARSIZE; TempL2++)
			{
				Str_ItoA(m_Cell[TempL2], m_pStrCell[TempL2], 10);
	
				m_hBC[TempL2] = Dialog_CreateButCtrl(m_hDlg, m_CtrlIndex++, DMS_X(25+TempL*125),     DMS_Y(80+ TempL1*60+TempL1/2), 
																			DMS_X(25+(TempL+1)*125), DMS_Y(80+(TempL1+1)*60+TempL1/2), m_Cell_ID++, m_pStrCell[TempL2]);
				
				
				ButCtrl_SetFont( m_hBC[TempL2], m_nFontType);
				ButCtrl_SetBkColorEx(m_hBC[TempL2], TEXTTITLEBACKCOLOR);
				
				
				if( m_nType > FAMILY_PDA)
				{
					ButCtrl_ModifyStyle(m_hBC[TempL2], BUTSTY_BOLD, BUTSTY_THICKBORDER);
					ButCtrl_SetRoundRadius(m_hBC[TempL2], DMS_X(10));
					ButCtrl_SetRoundThickness(m_hBC[TempL2], DMS_X(3));
					ButCtrl_SetRoundBoarderColor(m_hBC[TempL2], ROYALBLUE, ROYALBLUE);
				}
				else
				{
					ButCtrl_ModifyStyle(m_hBC[TempL2], BUTSTY_BOLD, 0);
				}
				
				TempL++;
				
				if ((TempL2 + 1) % 7 == 0)
				{
					TempL1++;
					TempL=0;
				}
			}

			//	현재 년월일
			Str_Printf((char*)m_CurrentDateStr, "%d 년 %d 월 %d 일", (quad)Time_GetYear(), (quad)Time_GetMonth(), (quad)Time_GetDay());
			mf_CreateCalendar();
		}
	}
	
//┌─────────────────────────────────────┐
//│ 					『	OnExit Function  』   				              │
//└─────────────────────────────────────┘
	void OnExit(void)
	{
		Dialog_DeleteObject(m_hDlg);
		/*
		FREE(m_ImgBg);
		FREE(m_ImgLeftA);
		FREE(m_ImgRightA);
		FREE(m_ImgExitA);
		FREE(m_ImgLeftI);
		FREE(m_ImgRightI);
		FREE(m_ImgExitI);	
		*/	
	}
	
//┌─────────────────────────────────────┐
//│ 					『	OnKey Function  』   				              │
//└─────────────────────────────────────┘
	void OnKey(long Key)
	{
		Dialog_KeyProcess(m_hDlg, Key);		
	}
	
//┌─────────────────────────────────────┐
//│ 					『	OnChar Function  』   				              │
//└─────────────────────────────────────┘
	void OnChar(long Code)
	{
		Dialog_CharProcess(m_hDlg, Code);
	}
	
//┌─────────────────────────────────────┐
//│ 					『	OnDraw Function  』   				              │
//└─────────────────────────────────────┘
	void OnDraw(void)
	{
		Dialog_Draw(m_hDlg, TRUE);
	}
	
//┌─────────────────────────────────────┐
//│ 					『	OnTimer Function  』   				              │
//└─────────────────────────────────────┘
	void OnTimer(long nTimerID)
	{
		Dialog_Timer(m_hDlg);
	}
	
//┌─────────────────────────────────────┐
//│ 					『	OnPointing Function  』  			              │
//└─────────────────────────────────────┘
	void OnPointing(long nAction, long X, long Y)
	{		
		Dialog_PointingProcess(m_hDlg, nAction, X, Y);
	}
	
//┌─────────────────────────────────────┐
//│ 				   『	OnButton Function  』  				              │
//└─────────────────────────────────────┘
	long OnButton(long ID)
	{
		long SelectedYear;
		long SelectedMonth;
		long aCnt,bCnt,cCnt;
		long Temp;
	
		switch(ID)
		{		
		
			case 2000:
				return 0;						
		
			case 1001:			//	년도를 1년 증가시킨다.
				m_ChangeYear += 1;
				
				if (m_ChangeYear > 9999)
					return -1;
				
				mf_CreateCalendar();
				OnDraw();
				return -1;
				
			case 1002:			//	년도를 1년 감소시킨다.
				m_ChangeYear -= 1;
				
				if (m_ChangeYear < 0)
					return -1;			
				
				mf_CreateCalendar();
				OnDraw();		
				return -1;
	
			case 1003:			//	월을 한달 감소시킨다.
				m_ChangeMonth -= 1;			
			
				if (m_ChangeMonth == 0)
				{
					m_ChangeYear -= 1;
					m_ChangeMonth = 12;
				}
	
				mf_CreateCalendar();
				
				OnDraw();		
				return -1;
				
			case 1004:			//	월을 한달 증가시킨다.
				m_ChangeMonth += 1;
				
				if (m_ChangeMonth == 13)
				{
					m_ChangeYear += 1;
					m_ChangeMonth = 1;
				}
				
				mf_CreateCalendar();
				OnDraw();		
				return -1;
	
			case 1005:			//	달력을 현재 년월일로 리셋팅한다.
				m_ChangeYear = Time_GetYear();
				m_ChangeMonth = Time_GetMonth();
			
				m_ChangeDay = 1;
				
				mf_CreateCalendar ();
				OnDraw();		
				return -1;
	
			default:			//	일자를 선택한 경우
				SelectedYear = m_ChangeYear;
				SelectedMonth = m_ChangeMonth;
				//br-----------------------
				//br---------------------
				if (ID < m_PrevMonthIndex)
				{
					SelectedMonth -= 1;
					
					if (SelectedMonth == 0)
					{
						SelectedYear -= 1;
						SelectedMonth = 12;
					}
				}
				else if (ID >= m_NextMonthIndex)
				{
					SelectedMonth += 1;
					
					if (SelectedMonth == 13)
					{
						SelectedYear += 1;
						SelectedMonth = 1;
					}
				}			 
				m_dayOfWeek = ID % 7;
				return (SelectedYear*10000 + SelectedMonth * 100 + m_Cell[ID]);
		} //end of switch
	//	return -1;
	}// end of OnButton
//┌─────────────────────────────────────┐
//│ 				   『	OnSelect Function  』  				              │
//└─────────────────────────────────────┘	
	void OnSelect(long Index)
	{
	}

	
	long mf_GetDayOfYear(long Year, long Month, long Day)
	{
		long TempL;
		long LeapYear;

		//	윤년이면 leap = 1, 윤년이 아니면 leap = 0
		LeapYear = mf_IsLeapYear(Year);
		
		for (TempL=1; TempL<Month; TempL++)
		{
			Day = Day + m_DaysInMonth[LeapYear][TempL - 1];
		}
		
		return Day;
	}

	long mf_GetNumberOfLeapYear(long CurrentYear, long ChangeYear)
	{
		//	CurrentYear 과 ChangeYear 사이에 윤년이 몆개나 있는가?
		long Year;
		long LeapYearCount = 0;

		for (Year = CurrentYear; Year < ChangeYear; Year++)
		{
			if (mf_IsLeapYear(Year))
				LeapYearCount++;
		}

		return LeapYearCount;
	}

	long mf_IsLeapYear(long year)	 //	윤년인지 아닌지 체크
	{
		return ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);
	}

	///////////////////////////////////////////////////////////////////////////
	// 달력은 년과 월을 명시해 주면, 그릴 수 있다.
	// m_ChangeYear(yyyy)와 m_ChangeMonth(mm)의 달력을 그리려면,
	// 그달 1일의 요일을 알면 그릴 수 있다.
	// 그래서 yyyymm01(변경 년월일)과 YYYYMMDD(기준일-현재년월일)의 날짜차이를
	// 계산하여 % 7을 하고 현재 요일을 더한다.
	//
	// |yyyymm01 - YYYYMMDD| = (|YYYY - yyyy|사이에서 윤년아닌 것의 갯수) * 365 
	//                       + (|YYYY - yyyy|사이에서 윤년의 갯수) * 366
	//                       + (yyyymm01 - yyyy0101) + (YYYYMMDD - YYYY0101)
	///////////////////////////////////////////////////////////////////////////
	void mf_CreateCalendar(void)
	{
		long CurrentYear; 			//	현재 년;
		long CurrentMonth; 			//	현재 월;
		long CurrentDay; 			//	현재 일;
		
		long ChangeDate;			//	변경하고자 하는 년월일
		long ChangeYear; 			//	만들고자 하는 달의 년;
		long ChangeMonth; 			//	만들고자 하는 달의 월;
		long ChangeDay; 			//	만들고자 하는 달의 일;
		
		long DaysInCurrentYear;		//	현재 년도의 날 개수
		long DaysInChangeYear;		//	변경할 년도의 날 개수
		long YearDifference;		//	현재 년도와 변경할 년도 사이의 년도 개수
		long DayDifference;			//	현재 년도와 변경할 년도 사이의 날 개수
		long NumberOfLeapYear;		//	현재 년도와 변경할 년도 사이의 윤년 개수
		
		long IsLeapYear;			//	윤년이면 1, 윤년이 아니면 0
		long StartDay;				//  시작일
		long PrevMonth; 			//  전 월
		long PrevMonthDay;			//  전 월의 일
		long ChangeMonthDay;		//	바뀔 월의 일
		long ChangeWeekDay;			//  바뀔 주의 일	

		long TempL;
		// 현재 년.월.일
		CurrentYear  = m_CurrentDate / 10000;
		CurrentMonth = (m_CurrentDate - CurrentYear * 10000) / 100;
		CurrentDay   = m_CurrentDate % 100;
		// 바뀔 년.월.일
		ChangeYear  = m_ChangeYear;
		ChangeMonth = m_ChangeMonth;
		ChangeDay   = m_ChangeDay;	    //'1' 로 변동없음
		// 바뀔 날짜(년월일)
		ChangeDate = ChangeYear * 10000 + ChangeMonth * 100 + ChangeDay;

		for (TempL=0; TempL<CALENDARSIZE; TempL++)
		{	
			ButCtrl_ModifyStyle(m_hBC[TempL], BUTSTY_BOLD, 0);
			ButCtrl_SetForeColorEx(m_hBC[TempL], THEBLACK);	//	버튼 숫자는 기본 검정색
			ButCtrl_SetBkColorEx(m_hBC[TempL], TEXTTITLEBACKCOLOR);	//	버튼 바탕은 기본 흰색
			
			//	일요일은 빨간색으로 그린다
			if (TempL % 7 == 0)
				ButCtrl_SetForeColorEx(m_hBC[TempL], THERED);
			//	토요일은 파란색으로 그린다				
			if (TempL % 7 == 6)
				ButCtrl_SetForeColorEx(m_hBC[TempL], THEBLUE);			
		}
		
		DaysInCurrentYear = mf_GetDayOfYear(CurrentYear, CurrentMonth, CurrentDay);
		DaysInChangeYear  = mf_GetDayOfYear(ChangeYear,  ChangeMonth,  ChangeDay);

		if (ChangeDate >= m_CurrentDate)
		{		
			YearDifference   = ChangeYear - CurrentYear;
			NumberOfLeapYear = mf_GetNumberOfLeapYear(CurrentYear, ChangeYear);
			DayDifference = (YearDifference - NumberOfLeapYear) * ONEYEAR + NumberOfLeapYear * ONELEAPYEAR + (DaysInChangeYear - DaysInCurrentYear);
			ChangeWeekDay = ((DayDifference % ONEWEEK + m_CurrentWeek) % ONEWEEK) ;
		}
		//예) 20031001 < 20031010
		else //	if (ChangeDate < m_CurrentDate)
		{
			YearDifference = CurrentYear - ChangeYear;
			NumberOfLeapYear = mf_GetNumberOfLeapYear(ChangeYear, CurrentYear);		
			//9=(0-0)*365+0*365+(283-274)
			DayDifference = (YearDifference - NumberOfLeapYear) * ONEYEAR + NumberOfLeapYear * ONELEAPYEAR + (DaysInCurrentYear - DaysInChangeYear);
			// 3=(7-(9%7)+5)%7
			ChangeWeekDay = (ONEWEEK - (DayDifference % ONEWEEK) + m_CurrentWeek) % ONEWEEK ;
		}
    //-------------------------------------------------
	// ① 변경할 월의 【이전 월의 일자】의 내용을 구한다
	//		┌────────────┐
	// 예)  │   M[0]=28 ∼ M[2]=30	  │
	//		└────────────┘
	//
		IsLeapYear = mf_IsLeapYear(ChangeYear);    // 예) 0 = L(2003)
		PrevMonth  = ChangeMonth - 1;			   //     9 = 10-1
		
		if (PrevMonth == 0)			PrevMonth = 12;	
					
		PrevMonthDay   = m_DaysInMonth[IsLeapYear][PrevMonth - 1];  //30=M[0][9-1];		
		ChangeMonthDay = m_DaysInMonth[IsLeapYear][ChangeMonth - 1];//31=M[0][10-1];		
	
		StartDay = PrevMonthDay - ChangeWeekDay + 1; //28=30-3+1
		 
		for(TempL=0; TempL<ChangeWeekDay; TempL++)
		{			
			m_Cell[TempL] = StartDay;
			StartDay++;
			// 현재 표시하는 달에 해당하지 않는 Cell의 숫자는 회색으로
			ButCtrl_SetForeColor(m_hBC[TempL], 218);
			
		}
	//---------------------------------------------------------------------
	// ② 변경할 【월의 일자】의 내용을 구한다
	// 					┌─┐
	// 예)	 M[12]=10   │10│ : 현재 월의 일 
	//					└─┘
	//
		m_PrevMonthIndex = ChangeWeekDay;
		
		StartDay = 1;
		//  3=3; 3< 31+3;3++
		for (TempL = ChangeWeekDay ; TempL < ChangeMonthDay + ChangeWeekDay ; TempL++)
		{
			m_Cell[TempL] = StartDay;
			
			if (StartDay == m_CurrentDay && l_monthTemp == m_ChangeMonth)
				ButCtrl_SetBkColor(m_hBC[TempL], 221);
			// 현재 일에 해당하는 Cell의 바탕은 연두색으로
			StartDay++;
		}
	//---------------------------------------------------------------------
	// ③ 변경할 월의 【다음 월의 일자】의 내용을 구한다
	//		┌────────────┐
	// 예)  │   M[34]=1 ∼ M[41]=8	  │
	//		└────────────┘
	//
		m_NextMonthIndex = ChangeMonthDay + ChangeWeekDay;
		
		StartDay = 1;
		// 34= 31+3 ; 34<42 ; 34++
		for (TempL = ChangeMonthDay + ChangeWeekDay; TempL < CALENDARSIZE; TempL++)
		{
			m_Cell[TempL] = StartDay;
			StartDay++;
			
			ButCtrl_SetForeColor(m_hBC[TempL], 218);
			//	현재 표시하는 달에 해당하지 않는 Cell의 숫자는 회색으로
		}
	//---------------------------------------------------------------------			
		Str_Printf(m_pStrTitle, "%d년 %d월 ", ChangeYear, ChangeMonth, 0);
		
		for (TempL = 0; TempL < CALENDARSIZE; TempL++)
		{
			Str_ItoA( m_Cell[TempL], m_pStrCell[TempL], 10 );
			ButCtrl_SetText(m_hBC[CALENDARSIZE], m_pStrCell[TempL]);
		}	
	}	
	
	
//┌─────────────────────────────────────┐
//│ ◈ Dialog Control Create												  │
//└─────────────────────────────────────┘
	handle MAIN_DLG(char* text, quad del, quad add, quad bkClr, quad TfrClr, quad TbkClr, long T_height )
	{
			// 타이틀 , 제거타입, 추가타입, 배경색, 타이틀전경색, 타이틀배경색, 타이틀높이
			handle m_hDLGMain;
			m_hDLGMain = Dialog_CreateObject();
			Dialog_SetTitle (m_hDLGMain, text);
			Dialog_SetBkColorEx(m_hDLGMain,bkClr);
			Dialog_SetTitleBkColorEx (m_hDLGMain, TbkClr);
			Dialog_SetTitleForeColorEx(m_hDLGMain, TfrClr);
			
			//Dialog_ModifyStyle(m_hDLGMain, del, add);
			
			if( m_nType > FAMILY_PDA)
			{
				Dialog_ModifyStyle(m_hDLGMain, DLGSTY_VSCROLLBAR|DLGSTY_HSCROLLBAR|DLGSTY_TITLE, DLGSTY_THICKBORDER|DLGSTY_ROUNDBORDER|DLGSTY_BORDER);
				Dialog_SetRoundRadius(m_hDLGMain, DMS_X(50));
				Dialog_SetRoundThickness(m_hDLGMain, DMS_X(10));
				Dialog_SetRoundBoarderColor(m_hDLGMain, BTNCTRLSIDECOLOR, BTNCTRLSIDECOLOR);
			}
			else
			{
				Dialog_ModifyStyle(m_hDLGMain, del, add);
				Dialog_SetTitleHeight (m_hDLGMain, T_height);
			}
			
			
			
			return m_hDLGMain;
	}
//┌─────────────────────────────────────┐
//│ ◈ Dialog [Text] Control Create										  │
//└─────────────────────────────────────┘
	handle DLG_TXT(handle h_dlg, long id, long x, long y, long width, long height, quad bkClr, quad style, long align, char* text)
	{
		handle h;
		h = Dialog_CreateTextCtrl(h_dlg,id, DMS_X(x), DMS_Y(y), DMS_X(x+width), DMS_Y(y+height),text);
		EditCtrl_ModifyStyle( h, 0, style );
		EditCtrl_SetAlign ( h, align );
		EditCtrl_SetBkColorEx ( h, bkClr );
		return h;
	}
//┌─────────────────────────────────────┐
//│ ◈ Dialog [Button] Control Create										  │
//└─────────────────────────────────────┘
	handle DLG_BUT(handle hDlg, long index, long x, long y, long width, long height, quad bkClr, quad frClr, quad add, long id, char* text)
	{
		handle h;
		h = Dialog_CreateButCtrl(hDlg, index, DMS_X(x), DMS_Y(y), DMS_X(x+width), DMS_Y(y+height), id, text);
		ButCtrl_ModifyStyle( h, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, add );
		//ButCtrl_ModifyStyle( h, del, add );
		ButCtrl_SetBkColorEx ( h, bkClr );
		ButCtrl_SetForeColorEx(h,frClr);
	//	ButCtrl_SetDelta(h,dx,dy);
		return h;//리턴.성공.실패0 메모리때문에..
	}

//┌─────────────────────────────────────┐
//│ ◈ Dialog [Image Button] Control Create								  │
//└─────────────────────────────────────┘
	handle DLG_IBUT(handle hDlg, long index, long x, long y, long width, long height, long dx, long dy, 
								quad bkClr,quad frClr, quad add, long id, byte* img, byte* actimg, char* text)
	{
		handle h;
		h = Dialog_CreateButCtrl(hDlg, index, DMS_X(x), DMS_Y(y), DMS_X(x+width), DMS_Y(y+height), id, text);
		//ButCtrl_ModifyStyle( h, BUTSTY_BORDER|BUTSTY_BOLD, add );
		//ButCtrl_ModifyStyle( h, del, add );
		ButCtrl_SetBkColorEx ( h, bkClr );
		ButCtrl_SetForeColorEx(h, frClr);
		ButCtrl_SetDelta(h, dx, dy);

		if( m_nType > FAMILY_PDA)
		{
			ButCtrl_ModifyStyle(h, BUTSTY_BOLD, BUTSTY_THICKBORDER);
			ButCtrl_SetRoundRadius(h, DMS_X(10));
			ButCtrl_SetRoundThickness(h, DMS_X(3));
			ButCtrl_SetRoundBoarderColor(h, BTNCTRLSIDECOLOR, BTNCTRLSIDECOLOR);
		}
		else
		{
			ButCtrl_ModifyStyle(h, BUTSTY_BORDER|BUTSTY_BOLD, add);
		}


		return h;
	}

	
	
	
} // End of Card Calendar

