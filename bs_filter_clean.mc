/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : BS_FILTER_CLEAN
	Card Desc : 특정 분해점검
	Card Hist :
----------------------------------------------------------------------------------*/
card BS_FILTER_CLEAN
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
		
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	// #define USE_ON_UART
	// #define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CHG )			// 수정
		DEF_BUTTON_ID ( BID_CLOSE )			// 닫기
		DEF_BUTTON_ID ( BID_SCHDL )			// 분해점검일 달력
		DEF_BUTTON_ID ( BID_DETA_LOC_2 )	// 상세위치
		DEF_BUTTON_ID ( BID_DATE)			// 이전시행일자적용

		
	

//정산재고
		// DEF_BUTTON_ID ( BID_BALANCEOK )
		
		
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( ST_DIV_1 )				// 분리바_1
		DEF_OBJECT_ID ( ST_MAKER_1 )			// 제작사_1
		DEF_OBJECT_ID ( TXT_MAKER_1 )			// 제작사_1
		
		DEF_OBJECT_ID ( ST_MODEL_1 )			// 모델_1
		DEF_OBJECT_ID ( TXT_MODEL_1 )			// 모델_1
		
		DEF_OBJECT_ID ( ST_DJ_CHK_FIRM_1 )		// 분해점검사_1
		DEF_OBJECT_ID ( TXT_DJ_CHK_FIRM_1 )		// 분해점검사_1

		DEF_OBJECT_ID ( ST_INST_YMD_1 )			// 설치일자_1
		DEF_OBJECT_ID ( TXT_INST_YMD_1 )		// 설치일자_1

		DEF_OBJECT_ID ( ST_DJ_CHK_YMD_1 )		// 분해점검일_1
		DEF_OBJECT_ID ( TXT_DJ_CHK_YMD_1 )		// 분해점검일_1
				
		DEF_OBJECT_ID ( ST_DJ_REG_DATE_1 )		// 분해점검일 등록일자_1
		DEF_OBJECT_ID ( TXT_DJ_REG_DATE_1 )		// 분해점검일 등록일자_1

		DEF_OBJECT_ID ( TXT_FILTER_CLEAN_DATE_1 )	// 이전필터청소일
		DEF_OBJECT_ID ( TXT_FILTER_CLEAN_1 )		// 이전필터청소업체
		DEF_OBJECT_ID ( TXT_NEW_FILTER_CLEAN_DATE_1 )	// 이전필터청소일

		
		// 분해점검 입력
		DEF_OBJECT_ID ( ST_DIV_2 )				// 분리바_2

		DEF_OBJECT_ID ( ST_DJ_CHK_FIRM_2 )		// 분해점검사_2

		DEF_OBJECT_ID ( ST_DJ_NEW_CHK_FIRM_1 )		// 시행업체
		DEF_OBJECT_ID ( ST_DJ_NEW_CHK_DATE_1 )		// 시행일자
		
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD1_2 )		// 분해점검일1_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD2_2 )		// 분해점검일2_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD3_2 )		// 분해점검일3_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD4_2 )		// 분해점검일4_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD5_2 )		// 분해점검일5_2
		
		DEF_OBJECT_ID ( EDT_DJ_CHK_YMD_YEAR_2 )	// 분해점검일_년도_2
		DEF_OBJECT_ID ( EDT_DJ_CHK_YMD_MONTH_2 )// 분해점검일_월_2
		DEF_OBJECT_ID ( EDT_DJ_CHK_YMD_DATE_2 )	// 분해점검일_일_2

		DEF_OBJECT_ID ( ST_DETA_LOC_2 )			// 상세위치_2
		DEF_OBJECT_ID ( EDT_DETA_LOC_2 )		// 상세위치_2
		
		// 라인
		DEF_OBJECT_ID ( LINE_DATA1 )			// 라인1
		DEF_OBJECT_ID ( LINE_DATA2 )			// 라인2

		DEF_OBJECT_ID(ST_LOC_FLAG_1)  // 위치구분_1
		DEF_OBJECT_ID(ST_REGTR_STD_1)  // 규격
		
		


		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_BORDER )
		DEF_OBJECT_ID ( TXT_PAGE )
		

//포인팅 자판
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA11 )
//지침입력
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )
		DEF_OBJECT_ID ( EDT_DATA8 )
		DEF_OBJECT_ID ( EDT_DATA9 )
		DEF_OBJECT_ID ( EDT_DATA10 )
		DEF_OBJECT_ID ( EDT_DATA12 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3)
		// 콤보박스
		DEF_OBJECT_ID ( CMB_DJ_CHK_FIRM  = CMB_DATA2+3 )		// 분해점검사
		
	END_OBJECT_ID()
	
	#define INIT_MAIN		1
	

	typedef struct _PRESSINFO
	{
		char NEW_FILTER_CLEAN_FIRM_NM   [30 +1]; 
		char NEW_FILTER_CLEAN_YMD    	[15 +1]; 
		char DETA_LOC              		[30 +1];
	} PRESSINFO;
	
	PRESSINFO m_stBsPress;

	
	char m_szGOV_REGTR_FLAG[10];
	char m_szTitle[50];
	char m_szSql[1100];
	char m_szRemote[1100];
	char m_szTmp[400];
	char m_szBartmp[128];
	char m_szCnt_index[10];
	char m_szfilenm[100];
	char m_szMtrBarnum[20];		//MTR_MODEL에 BARCODE_NUM 저장
	char m_szMakernum[20];		//MTR_MODEL에 MAKER_NUM 저장
	char m_lCheckAMI[20]; 
	char m_lCheckPAY[20]; 
	char m_lCheckPAY_2[20]; 

	char m_lCheckCMB1[20]; 
	char m_lCheckCMB2[20]; 
	
	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	long m_lPrev;
	long m_lTotCnt;
	long m_lSaveFlag = 0;	//0 : default, 1 : 불가사유 저장. , 
	long m_lLastFlag = 0;	//0 : default, 1 : 마지막대상 저장 시 화면 리프레시
	long m_lBarLen = 0;
	long m_lCancelFlag = 0;  // 0 : default, 1 : 교체 완료 취소
	long m_lSpecialMtrFlag = 0; // 0 이면 일반 계량기 , 1 이면 특수형 계량기
	
	
	void SetStruct(void);
	void SetChkMtr(void);
	void SetBtnImg(void);
	void SetStyle(void);
	void SetCombo(void);
	void SetCombo_Valid(void);		//유효 콤보 셋팅

	void ReDraw(void);
	void Move_Card(void);
	void AddrDraw(void);
	
	void Prev_Mtr(void);
	void Next_Mtr(void);
	long FS_GetSrchTotCnt(void);
	
	
	long Chk_Grd(char* szAfterGrd);
	long Chk_MakerCd(char* szMakerCd);

	bool Save_PRESSCHG(void);
	bool Compare_Data(void);
	bool isValid(void);
	

	//---------------------------
	void move_back(void);
	void move_save(void);

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_PRESSCHG[] = 
	{
			NORM_DLG  ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
			DLG_ICON  ( POPTX, POPTY, ICON_TITLE, ""),
			DLG_TEXT  ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "조정기 정보수정 및 필터청소 입력"),
			DLG_BUTTON( BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

			DLG_TEXT(STARTX, STARTY - 29, 1000, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DIV_1, "기존 정보"),

			DLG_TEXT(STARTX, STARTY + 31, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_MAKER_1, "제작사"),
			DLG_TEXT(STARTX + 300, STARTY + 31, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MAKER_1, ""),

			DLG_TEXT(STARTX, STARTY + 91, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_MODEL_1, "모델"),
			DLG_TEXT(STARTX + 300, STARTY + 91, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MODEL_1, ""),

			DLG_TEXT(STARTX, STARTY + 151, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_INST_YMD_1, "설치일자"),
			DLG_TEXT(STARTX + 300, STARTY + 151, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INST_YMD_1, ""),

			DLG_TEXT(STARTX, STARTY + 211, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_LOC_FLAG_1, "위치구분"),
			//DLG_TEXT(STARTX + 300, STARTY + 211, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, CMB_LOC_FLAG_1, ""),
			DLG_COMBO( STARTX +300, STARTY +211, 700, 200, 180, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),

			DLG_TEXT(STARTX, STARTY + 271, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_REGTR_STD_1, "규격"),
			//DLG_TEXT(STARTX + 300, STARTY + 271, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, CMB_REGTR_STD_1, ""),
			DLG_COMBO ( STARTX +300, STARTY +270, 700,  200, 180, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),

			DLG_TEXT(STARTX, STARTY + 331, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DETA_LOC_2, "상세위치"),
			DLG_TEXT(STARTX + 300, STARTY + 331, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, EDT_DETA_LOC_2, ""),

			DLG_LINE(STARTX, STARTY + 395, 1000, STARTY + 395, DARKSLATEBLUE, 10, LINE_DATA1),

			DLG_TEXT(STARTX, STARTY + 400, 1000, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DIV_2, "필터청소 이력 및 실적 입력"),

			DLG_TEXT(STARTX, STARTY +460, 350,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_CHK_FIRM_2, "이전시행업체"),
			DLG_TEXT(STARTX + 350, STARTY +460, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FILTER_CLEAN_1, ""),
		
			DLG_TEXT(STARTX, STARTY +520, 350,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_CHK_YMD1_2, "이전시행일자"),
			DLG_TEXT(STARTX + 350, STARTY +520, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FILTER_CLEAN_DATE_1, ""),
			
			DLG_BUTTON(STARTX,STARTY +580,1000, 60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATE, "이전시행 적용"),
			
			DLG_TEXT(STARTX, STARTY +640, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_NEW_CHK_FIRM_1, "시행업체"),
			DLG_COMBO ( STARTX +300, STARTY +640, 700,  200, 180, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DJ_CHK_FIRM, 10),

			DLG_TEXT(STARTX, STARTY +700, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_NEW_CHK_DATE_1, "시행일자"),
			DLG_EDIT  ( STARTX +300, STARTY +700, 200,  60,  0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DJ_CHK_YMD_YEAR_2, 4,  ""),
			DLG_TEXT  ( STARTX +500, STARTY +700, 18,   40,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD2_2, ""),
			DLG_TEXT  ( STARTX +500, STARTY +700, 18,   60,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD3_2, "."),
			DLG_EDIT  ( STARTX +518, STARTY +700, 145,  60,  0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DJ_CHK_YMD_MONTH_2, 2,  ""), 
			DLG_TEXT  ( STARTX +663, STARTY +700, 17,   40,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD4_2, ""),
			DLG_TEXT  ( STARTX +663, STARTY +700, 17,   60,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD5_2, "."),
			DLG_EDIT  ( STARTX +680, STARTY +700, 140,  60,  0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DJ_CHK_YMD_DATE_2, 2,  ""),
			DLG_BUTTON( STARTX +820, STARTY +700, 180,  60,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "▼"),

			
			DLG_LINE(STARTX, STARTY + 824, 1000, STARTY + 824, DARKSLATEBLUE, 10, LINE_DATA2),

			DLG_BUTTON(STARTX, STARTY + 829, 1000, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHG, "수정/확인"),
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
		long lCnt;
		char szDate[15];
		
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:
				CREATE_DIALOG_OBJECT (DlgRes_PRESSCHG, SIZEOF(DlgRes_PRESSCHG));
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
				
				ON_DRAW();

				break;
					
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d,k;
		char szDate[20];
		char szToday[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szMsg[150];
		long cnt;
		char szSql[300];
		char sztmp2[100];
		char sztmp[100];

		switch(ID)
		{
			case BID_CLOSE:
				move_back();
				break;
			
			case BID_DETA_LOC_2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DETA_LOC_2), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC_2)) );
				break;
			
			case BID_SCHDL:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
				k = Str_AtoI(szDate);

				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();

				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Str_ItoA(Time_GetDate(), szToday, 10);
					Str_ItoA(d, szDate, 10);
					
					if( Str_Cmp(szDate, szToday) > 0 )
					{
						MessageBoxEx (CONFIRM_OK, "필터청소 점검일이 오늘보다 큽니다.");
						break;
					}
					else
					{
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte*)szYear, (byte *)szDate, 4);
						Mem_Cpy((byte*)szMonth, (byte *)szDate+4, 2);
						Mem_Cpy((byte*)szDay, (byte *)szDate+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), szDay );
					}
				}
				
				break;

			case BID_DATE:

				Str_Cpy(stGovinfo2.FILTER_CLEAN_FIRM_NM, stGovinfo2.FILTER_CLEAN_FIRM_NM);

				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)   , stGovinfo2.FILTER_CLEAN_FIRM_NM);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.FILTER_CLEAN_YMD, 4);
				
				

				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), sztmp );
		
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.FILTER_CLEAN_YMD+4, 2);

				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), sztmp );
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.FILTER_CLEAN_YMD+6, 2);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), sztmp );
				

				

				break;

			case BID_CHG:

				if( Save_PRESSCHG() )
				{
					move_save();
				}
				break;


			
		}
	
		
	}		

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];

		if( (Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2) == m_lEditCtrlIndex || Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2) == m_lEditCtrlIndex || Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2) == m_lEditCtrlIndex )
		 && (nChar < 48 ||  nChar > 57) )
		{
			MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
			ON_KEY( 5 );
			return;
		}
		
		if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2) == m_lEditCtrlIndex )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)) == 4 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)), 1);
			if( Str_AtoI(szTmp) > 1 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
			{
				ON_KEY( 5 );
				return;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)) == 2 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)), 1);
			if( Str_AtoI(szTmp) > 3 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
			{
				ON_KEY( 5 );
				return;
			}
		}

		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
		
		if( Str_Len(szTmp) == 8 )
		{
			Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
			nDate = Str_AtoI(szTmp);
			nRet = Time_ValidateDate(nDate);
			
			if( nRet == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "유효한 날짜가 아닙니다.\n날짜를 확인해주세요.");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), "");
				
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}

		ON_DRAW();
		return;
	}


	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			m_lEditCtrlIndex = lActiveIndex;

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+500) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+280) )
				{
					if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+518) && X < DMS_X(STARTX+663) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+280) )
				{
					if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+680) && X < DMS_X(STARTX+820) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+280) )
				{
					if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
			}
		}
	}

	void OnSelect(long Index)
	{
		char szFrimCd[20];
		char sztmp[100];
		long lActiveIndex;

		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);


		if( lActiveIndex == Get_iDlgCtrlByID(CMB_DJ_CHK_FIRM + 1) )
		{
			
			Mem_Set( (byte*)szFrimCd, 0x00, sizeof(szFrimCd));
			Str_Cpy(szFrimCd, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)));

			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)), "확인불가") == 0 )
			// if(szFrimCd == "확인불가")			
			{
				PRINT("stGovinfo2.FILTER_CLEAN_FIRM_NM : %s ",stGovinfo2.FILTER_CLEAN_FIRM_NM,0,0);
				if( Str_Cmp(stGovinfo2.FILTER_CLEAN_FIRM_NM, "") != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "이전시행 정보가 존재합니다.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM), "");
					
				}
				else
				{
					if( Str_Cmp(stGovinfo2.INST_YMD, "") != 0 )					
					{
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD, 4);
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), sztmp);
						
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD+4, 2);
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), sztmp);
						
						Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
						Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD+6, 2);
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), sztmp);
					}
					else
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), "1111");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), "11");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), "11");
					}
					

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );

				}
				

			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), "");

				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE );

			}

		}


	}


//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
			

	}
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DIV_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_MAKER_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKER_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_MODEL_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODEL_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_FIRM_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FILTER_CLEAN_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign(Get_hDlgCtrlByID(ST_LOC_FLAG_1), EDITALIGN_MIDDLE | EDITALIGN_CENTER);
		EditCtrl_SetAlign(Get_hDlgCtrlByID(ST_REGTR_STD_1), EDITALIGN_MIDDLE | EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_YMD_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FILTER_CLEAN_DATE_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NEW_FILTER_CLEAN_DATE_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_INST_YMD_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INST_YMD_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DIV_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER); 

		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_FIRM_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_YMD1_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_NEW_CHK_FIRM_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_NEW_CHK_DATE_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DETA_LOC_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		
	        
		


	}

//------------------------------------------------------------------
	void SetCombo(void)
	{
		long i;
		long lRet, lDate, lYear, lMonth;
		char szDate[30];
		char szYear[20];
		char szYear2[20];
		char szMonth[20];
		char szRet[30];
	
		if( m_bFirst == INIT_MAIN )
		{
			
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30169'", CMB_DATA1+2);
			
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			g_Sql_SetCombo("SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30111'", CMB_DATA2+2);
			
		}
		
		return;
	}
	


	
//------------------------------------------------------------------
	void ReDraw(void)	
	{
		char szSql[200];
		char sztmp[100];
		char sztmp2[100];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szDate[15];
		long lToDate , lDisDate;
		long setDate;
		
		Mem_Set((byte*)m_szGOV_REGTR_FLAG, 0x00, sizeof(m_szGOV_REGTR_FLAG));
		Str_Cpy(m_szGOV_REGTR_FLAG, stGovinfo2.GOV_REGTR_FLAG);
		
		// EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_FILTER_CLEAN_DATE_1), RED);

		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte*)szYear, (byte*)stGovinfo2.NEW_FILTER_CLEAN_YMD, 4);
		Mem_Cpy((byte*)szMonth, (byte*)stGovinfo2.NEW_FILTER_CLEAN_YMD+4, 2);
		Mem_Cpy((byte*)szDay, (byte*)stGovinfo2.NEW_FILTER_CLEAN_YMD+6, 2);
			
		// 분해점검일자
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), szDay );
		
		/**** 기존 정보 ****/
		// 제작사
		// Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		// Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		
		// SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '%s' AND MAKER_NUM = '%s' ", m_szGOV_REGTR_FLAG, stGovinfo2.MAKER_NUM, 0   );
		// g_Sql_RetStr( szSql, 30, sztmp );

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_MAKER_1), stGovinfo2.MAKER_NM);
		
		// 모델
		// Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		// Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));

		// SPRINT(szSql, "SELECT REGTR_MODEL_NM FROM REGTR_MODEL WHERE MAKER_NUM = '%s' AND REGTR_MODEL_CD = '%s' ", stGovinfo2.MAKER_NUM, stGovinfo2.MODEL_CD, 0   );
		
		// g_Sql_RetStr( szSql, 30, sztmp );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_MODEL_1), stGovinfo2.MODEL_NM);

		//위치
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30169' AND CODE_ITEM = '%s'",stGovinfo2.REGTR_LOC_FLAG, 0, 0   );
		g_Sql_RetStr( m_szSql, 20, m_szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1)   , m_szTmp);

		//규격
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30111' AND CODE_ITEM = '%s'",stGovinfo2.REGTR_STD, 0, 0   );
		g_Sql_RetStr( m_szSql, 20, m_szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2)   , m_szTmp);
		
		// 설치일자
		Mem_Set((byte*)sztmp2, 0x00, sizeof(sztmp2));
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD, 4);
		Str_Cpy(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD+4, 2);
		Str_Cat(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD+6, 2);
		Str_Cat(sztmp2, sztmp);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_INST_YMD_1), sztmp2);
		
		//필터점검사 
		Mem_Set((byte*)sztmp2, 0x00, sizeof(sztmp2));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.FILTER_CLEAN_FIRM_NM, 30);
		Str_Cat(sztmp2, sztmp);

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_FILTER_CLEAN_1), sztmp2);

		// 필터청소일자
		Mem_Set((byte*)sztmp2, 0x00, sizeof(sztmp2));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.FILTER_CLEAN_YMD, 30);
		Str_Cat(sztmp2, sztmp);

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_FILTER_CLEAN_DATE_1), sztmp2);

		ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM+2 ) );
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID ='C30066' AND CODE_ITEM NOT IN ('100','320','330','360','370','380','400','430','999') ORDER BY CAST( SORT_ORDER AS INTEGER), ITEM_KNAME ASC", CMB_DJ_CHK_FIRM+2);
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM), stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM);
		
		// 상세위치
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DETA_LOC_2), stGovinfo2.DETA_LOC);
		
		// 스트럭쳐에 데이터 셋팅
		SetStruct();

		return;
	}
	
//-----------------------------------------------------------------
	void SetStruct(void)
	{
		Mem_Set((byte*)&m_stBsPress, 0x00, sizeof(m_stBsPress));
	
		// 분해점검사
		Str_Cpy(m_stBsPress.NEW_FILTER_CLEAN_FIRM_NM, stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM);
		
		// 분해점검일
		Str_Cpy(m_stBsPress.NEW_FILTER_CLEAN_YMD, stGovinfo2.NEW_FILTER_CLEAN_YMD);
		
	}

	bool Save_PRESSCHG(void) 
	{
		char szSql[400];
		char szTmp[30];
		char szToday[30];
		long idx;
		long nLen;
		bool ret = TRUE;		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		// Validation
		if( !isValid() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		// 수정한 데이터가 있으면 Update 실행
		if( Compare_Data() )
		{
			ret = FALSE;
			goto Finally;
		}

		// 필터점검일
		Mem_Set( (byte*)stGovinfo2.NEW_FILTER_CLEAN_YMD, 0x00, sizeof(stGovinfo2.NEW_FILTER_CLEAN_YMD) );
		Str_Cpy(stGovinfo2.NEW_FILTER_CLEAN_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
		Str_Cat(stGovinfo2.NEW_FILTER_CLEAN_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
		Str_Cat(stGovinfo2.NEW_FILTER_CLEAN_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));

		PRINT("stGovinfo2.NEW_FILTER_CLEAN_YMD : %s",stGovinfo2.NEW_FILTER_CLEAN_YMD,0,0);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30169' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), 0, 0 );
		g_Sql_RetStr( szSql, 3, stGovinfo2.REGTR_LOC_FLAG );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30111' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), 0, 0 );
		g_Sql_RetStr( szSql, 3, stGovinfo2.REGTR_STD );
		

		// 필터점검사
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID ='C30066' AND ITEM_KNAME = '%s' ",stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM, 0, 0   );
		g_Sql_RetStr( szSql, 3, stGovinfo2.NEW_FILTER_CLEAN_FIRM_CD );

		if( Str_Cmp(stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM, "확인불가") == 0 )
		{
			Str_Cpy(stGovinfo2.NEW_FILTER_CLEAN_FIRM_CD, "000");
		}
		
		
		// SEND_YN
		Str_Cpy(stGovinfo2.SEND_YN, "S");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		//AND GOV_REGTR_NUM = ? 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_GOV_REG \
					      SET NEW_FILTER_CLEAN_FIRM_NM = ?, NEW_FILTER_CLEAN_FIRM_CD = ?, NEW_FILTER_CLEAN_YMD = ? \
					        , UPD_EMPID = ?, PDA_IP = ?, REGTR_LOC_FLAG = ?, REGTR_STD = ? , SEND_YN = 'S' \
				   	    WHERE CHK_EXEC_NUM = ? AND GOV_REGTR_FLAG = ? AND IFNULL(REGTR_STD,'') <> '10'"
					, 0, 0, 0);
					
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
	
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.NEW_FILTER_CLEAN_FIRM_NM , 30 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.NEW_FILTER_CLEAN_FIRM_CD, 10 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.NEW_FILTER_CLEAN_YMD	  , 8  +1, DECRYPT);
		
		
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	          , 9  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip		          , 15 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.REGTR_LOC_FLAG	      , 2  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.REGTR_STD	  			  , 2  +1, DECRYPT);


		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM		              , 12 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.GOV_REGTR_FLAG	      , 2  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.GOV_REGTR_NUM	          , 9  +1, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
	Finally:
		g_lGovFlag = 1;
		DelSqLite(sql);

		return ret;
	}

	/*=======================================================================================
	함수명 : isValid
	기  능 : Validation
	Param  : 
	Return : 
	========================================================================================*/	
	bool isValid(void)
	{
		bool ret = TRUE;
		long nLen;
		long pLen ,qlen;
		char szTmp[10];
		char szToday[20];

		char strMsg[100];
		char strLen[100];
		char strNlen[100];
		
		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)), "") == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "조정기 필터청소 업체를 선택해 주세요.");
				ret = FALSE;
				goto Finally;
			}
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
		
			if( Str_Len(szTmp) < 8 )
			{
				MessageBoxEx(CONFIRM_OK, "필터청소일을 입력해 주세요.");
				ret = FALSE;
				goto Finally;
			}
			
			Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
			Str_ItoA(Time_GetDate(), szToday, 10);
			
			if( Str_Cmp(szTmp, szToday) > 0 )
			{
				MessageBoxEx (CONFIRM_OK, "필터 청소일이 오늘보다 큽니다.");
				ret = FALSE;
				goto Finally;
			}
		}	

		
	Finally:
		return ret;
	}

	bool Compare_Data(void)
	{
		bool ret = TRUE;
		long lChk = 0;
		char szTmp[20];
		
		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 )
		{
			// 필터청소업체
			if( Str_Cmp(m_stBsPress.NEW_FILTER_CLEAN_FIRM_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM))) != 0 )
			{
				lChk++;
			}

			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
			
			// 필터청소일
			if( Str_Cmp(m_stBsPress.NEW_FILTER_CLEAN_YMD, szTmp) != 0 )
			{
				lChk++;
			}
		}

		// 상세위치
		if( Str_Cmp(m_stBsPress.DETA_LOC, szTmp) != 0 )
		{
			lChk++;
		}
		
		if( lChk > 0 )
		{
			ret = FALSE;
		}
		else
		{
			ret = TRUE;
		}
	
		return ret;
	}

	
	

	/*=======================================================================================
	함수명 : move_back
	기  능 : 뒤로가기
	Param  : 
	Return : 
	========================================================================================*/	
	void move_back(void)
	{
		if( g_lGovInflowPath == 1 )
		{
			g_nWorkChkFlag = 40;
			g_lSCMoveFlag = 1;
			Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
			Str_Cpy(stBsNogood.CHK_SEC_CD, "23");
			Str_Cpy(stBsNogood.MTR_NUM, "");
			Str_Cpy(stBsNogood.BURNER_NUM, "");
			Str_Cpy(stBsNogood.CHK_SEC_NM, "조정기");
			Card_Move("CHK_BSDTL");
		}
		else
		{
			Card_Move("BS_CONFIRM");
		}
	}

	/*=======================================================================================
	함수명 : move_save
	기  능 : 저장 후 이동
	Param  : 
	Return : 
	========================================================================================*/	
	void move_save(void)
	{
		if( g_lGovInflowPath == 1 )
		{
			g_nWorkChkFlag = 40;
			g_lSCMoveFlag = 1;
			Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
			Str_Cpy(stBsNogood.CHK_SEC_CD, "23");
			Str_Cpy(stBsNogood.MTR_NUM, "");
			Str_Cpy(stBsNogood.BURNER_NUM, "");
			Str_Cpy(stBsNogood.CHK_SEC_NM, "조정기");
			Card_Move("CHK_BSDTL");
		}
		else
		{
			Card_Move("BS_START");
		}
	}
}


