/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_NPMANAGE
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIME
	#define USE_ON_POINTING
	#define USE_ON_SELECT
//	#define USE_ON_UART
	#define USE_ON_TASK
	
	#include "DefEvent.h"

	#include "ArrayList.c"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_MTRCHK )	//계량기 체크
		DEF_BUTTON_ID ( BID_NPCHK )		//체납 체크
		DEF_BUTTON_ID ( BID_PRINT )		//체납발행
		DEF_BUTTON_ID ( BID_RELEASE )	//수납실시간
		DEF_BUTTON_ID ( BID_HISTORY )	//입금내역조회
		DEF_BUTTON_ID ( BID_STOP )		//중지
		DEF_BUTTON_ID ( BID_SUBMIT )	//납부
		DEF_BUTTON_ID ( BID_MTRPREV )	//계량기정보 이전
		DEF_BUTTON_ID ( BID_MTRNEXT )	//계량기정보 다음
		DEF_BUTTON_ID ( BID_NPPREV )	//체납정보 이전
		DEF_BUTTON_ID ( BID_NPNEXT )	//체납정보 다음
		DEF_BUTTON_ID ( BID_CLOSE )		//닫기
//검침내역조회
		DEF_BUTTON_ID ( BID_GMPREV )
		DEF_BUTTON_ID ( BID_GMNEXT )
		DEF_BUTTON_ID ( BID_OK )		//확인(닫기)
//체납발행
		DEF_BUTTON_ID ( BID_WRITE1 )	//납부확약서 작성
		DEF_BUTTON_ID ( BID_WRITE2 )	//기타양식 작성(OZ폼)
		DEF_BUTTON_ID ( BID_OK2 )		//확인(닫기)
//수납실시간
		DEF_BUTTON_ID ( BID_RELPREV )
		DEF_BUTTON_ID ( BID_RELNEXT )
		DEF_BUTTON_ID ( BID_OK3 )		//확인(닫기)
//입금내역
		DEF_BUTTON_ID ( BID_HISPREV )
		DEF_BUTTON_ID ( BID_HISNEXT )
		DEF_BUTTON_ID ( BID_HISOK )		//확인(닫기)
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
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( TXT_MTRPAGE )
		DEF_OBJECT_ID ( TXT_NPPAGE )
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
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		DEF_OBJECT_ID ( TXT_DATA22 )
		DEF_OBJECT_ID ( TXT_DATA23 )
		DEF_OBJECT_ID ( TXT_DATA24 )
		DEF_OBJECT_ID ( TXT_DATA25 )
		
//검침내역조회
		DEF_OBJECT_ID ( TXT_GMPAGE )

//수납실시간
		DEF_OBJECT_ID ( TXT_RELPAGE )
//입금내역
		DEF_OBJECT_ID ( TXT_HISPAGE )

//메인
		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
				
//메인
		DEF_OBJECT_ID ( ID_MTRLIST )
		DEF_OBJECT_ID ( ID_NPLIST )

//검침내역조회
		DEF_OBJECT_ID ( ID_GMLIST )
//수납실시간
		DEF_OBJECT_ID ( ID_RELLIST)
//입금내역
		DEF_OBJECT_ID ( ID_HISLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(계량기정보, 상품정보)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_M	    2					// table의 행개수
	#define		COL_M	    9					// table의 열개수
	#define		GRID_H_M	(CHT+10)			// table 행 높이
	#define		GRID_CLR_M	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_M	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_M	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_M	STARTY-29	  	    // table 시작y좌표
	#define		GRID_Y_M_P  STARTY-40	  	    // table 시작y좌표 PDA
	#define		GRID_ENDY_M	(GRID_Y_M+(ROW_M+1)*GRID_H_M) //table마지막 row의 Y값
	
	char	m_szTableBuf_M [COL_M*(ROW_M+1)*MAXCHAR_M]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_M[] = {
		{""            , CWD*3    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"기물번호"    , CWD*15+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"체납액"      , CWD*15   , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상태"        , CWD*6    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"계기종류"    , CWD*0    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"계기위치"    , CWD*0    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상품명"      , CWD*0    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"등급"        , CWD*0    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"MTR_NUM"     , CWD*0    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(체납내역)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_N 	    4					// table의 행개수
	#define		COL_N 	    5					// table의 열개수
	#define		GRID_H_N	(CHT+10)			// table 행 높이
	#define		GRID_CLR_N	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_N	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_N	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_N	STARTY+275  	    // table 시작y좌표
	#define		GRID_Y_N_P  STARTY+260  	    // table 시작y좌표
	#define		GRID_ENDY_N	(GRID_Y_N+(ROW_N+1)*GRID_H_N) //table마지막 row의 Y값
	
	char	m_szTableBuf_N [COL_N*(ROW_N+1)*MAXCHAR_N]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_N[] = {
		{""              , CWD*3 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"청구년월"      , CWD*9,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"제외"          , CWD*5 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"상태"          , CWD*10 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"체납금액"      , CWD*12+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(검침내역)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_G 	    15					// table의 행개수
	#define		COL_G 	    4					// table의 열개수
	#define		GRID_H_G	(CHT+10)			// table 행 높이
	#define		GRID_H_G_P	(CHT+15)			// table 행 높이 PDA
	#define		GRID_CLR_G	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_G	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_G	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_G	STARTY-29	  	    // table 시작y좌표
	#define		GRID_Y_G_P  STARTY-40	  	    // table 시작y좌표 PDA
	#define		GRID_ENDY_G	(GRID_Y_G+(ROW_G+1)*GRID_H_G) //table마지막 row의 Y값
	
	char	m_szTableBuf_G [COL_G*(ROW_G+1)*MAXCHAR_G]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_G[] = {
		{"청구년월"      , CWD*9  ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"청구금액"      , CWD*12+23 ,  EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"시작지침"      , CWD*9 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"마감지침"      , CWD*9 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(실시간납부내역)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_R 	    15					// table의 행개수
	#define		COL_R 	    3					// table의 열개수
	#define		GRID_H_R	(CHT+10)			// table 행 높이
	#define		GRID_H_R_P	(CHT+15)			// table 행 높이 PDA
	#define		GRID_CLR_R	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_R	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_R	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_R	STARTY-29  	    	// table 시작y좌표
	#define		GRID_Y_R_P  STARTY-40	  	    // table 시작y좌표 PDA
	#define		GRID_ENDY_R	(GRID_Y_R+(ROW_R+1)*GRID_H_R) //table마지막 row의 Y값
	
	char	m_szTableBuf_R [COL_R*(ROW_R+1)*MAXCHAR_R]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_R[] = {
		{"납부일자"      , CWD*12 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"납부시간"      , CWD*10 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"납부금액"      , CWD*17+23,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(입금내역)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_H 	    10					// table의 행개수
	#define		COL_H 	    4					// table의 열개수
	#define		GRID_H_H	(CHT+35)			// table 행 높이
	#define		GRID_H_H_P	(CHT+41)			// table 행 높이
	#define		GRID_CLR_H	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_H	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_H	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_H	STARTY-29  	    	// table 시작y좌표
	#define		GRID_Y_H_P  STARTY-40	  	    // table 시작y좌표
	#define		GRID_ENDY_H	(GRID_Y_H+(ROW_H+1)*GRID_H_H) //table마지막 row의 Y값
	
	char	m_szTableBuf_H [COL_H*(ROW_H+1)*MAXCHAR_H]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_H[] = {
		{"소인일자"      , CWD*10+19 ,   EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"입금유형"      , CWD*8+10,        EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"수납액"        , CWD*10 ,    EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"납부일자"      , CWD*10+19 ,   EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};

	#define INIT_MAIN	 1
	#define INIT_GM      2
	#define INIT_PRINT   3
	#define INIT_RELEASE 4
	#define INIT_HISTORY 5
	
	//-------------------------------------------------------------------------------------------------	
	//	버튼 시간 설정
	//-------------------------------------------------------------------------------------------------
	#define	BTN_START_TIME "090000"
	#define	BTN_END_TIME   "190000"
	
	typedef struct _PAYINFO
	{
		char USE_CONT_NUM        [20];
		char PROMISE_ASSIGN_SEQ  [10];
		char SEQ                 [10];
		char USE_CUST_NM         [50];
		char USE_FIRM_NM         [50];
		char USE_BIZ_REGI_NUM    [30];
		char USE_CP_DDD          [5];
		char USE_CP_EXN          [5];
		char USE_CP_NUM          [5];
		char USE_OWNHOUSE_TEL_DDD[5];
		char USE_OWNHOUSE_TEL_EXN[5];
		char USE_OWNHOUSE_TEL_NUM[5];
		char USE_CURR_ADDR_UNION [300];
		char USE_NEW_ADDR_UNION  [300];
		char ADJ_BASE_YMD        [20];
		char CUST_NM             [50];
		char SOC_NUM             [20];
		char CP_DDD              [5];
		char CP_EXN              [5];
		char CP_NUM              [5];
		char OWNHOUSE_TEL_DDD    [5];
		char OWNHOUSE_TEL_EXN    [5];
		char OWNHOUSE_TEL_NUM    [5];
		char RELATION            [20];
		char CAUSE_CD            [10];
		char PAY_PLAN_YMD        [20];
		char RMK                 [300];
		char NEW_ADDR_UNION      [300];
		char PROMISE_USE_CONT_NUM[20];
		char FIRM_NM             [50];
		char BIZ_REGI_NUM        [30];
		char ADDR_GB             [10];
		char ADDR_TYPE           [10];
		char ADDR                [300];
		char SECOND_ADDR         [200];
		char ADDR_UNION          [500];
		char ZIP_SEQ             [20];
		char NEW_ADDR_BLD_SEQ    [20];
		char HILL                [50];
		char ADDR1_M             [50];
		char ADDR1_S             [50];
		char DONG                [50];
		char HOSU                [50];
		char LOT_NUM_UNION       [300];
		char NEW_HOSU            [50];
		char UNGRNOUND_YN        [10];
		char PROMISE_TYPE_GB     [100];
		char PROMISE_EMPID       [20];
		char PROMISE_YMD         [20];
		char PROMISE_TOT_AMT     [20];
		char ID_REC_YN           [2];
	}	PAYINFO;
	
	//확약서에 넘겨주는 기본 데이터 struct2
	typedef struct _PAYPLAN
	{
		char USE_CONT_NUM    [20];
		char SEQ             [10];
		char PROMISE_PLAN_SEQ[10];
		char PROMISE_PLAN_REQ[50];
		char PROMISE_PLAN_AMT[50];
		char PROMISE_PLAN_YMD[20];
	}	PAYPLAN;

	PAYINFO m_stPayInfo;
	PAYPLAN m_stPayPlan[20];
	
	//확약서에서 넘어오는 저장 struct
	typedef struct _OZDATA
	{
		char PROMISE_TYPE_GB     [10];
		char USE_CONT_NUM        [20];
		char PROMISE_ASSIGN_SEQ  [20];
		char SEQ                 [10];
		char ADDR_GB             [10];
		char ADDR_TYPE           [10];
		char ZIP_SEQ             [20];
		char ADDR_UNION          [300];
		char NEW_ADDR_BLD_SEQ    [20];
		char NEW_ADDR_UNION      [300];
		char LOT_NUM_UNION       [300];
		char SECOND_ADDR         [200];
		char FIRM_NM             [100];
		char BIZ_REGI_NUM        [30];
		char SOC_NUM             [20];
		char CP_DDD              [10];
		char CP_EXN              [10];
		char CP_NUM              [10];
		char CUST_NM             [50];
		char INFO_USE_AGREE_YN   [5];
		char INFO_USE_AGREE_YN2  [5];
		char INFO_USE_AGREE_YN3  [5];
		char INFO_USE_AGREE_YN4  [5];
		char INFO_USE_AGREE_YN5  [5];
		char PROMISE_TOT_AMT     [20];
		char PDFPATH			 [256];
	}	OZDATA;

	OZDATA m_stOzData;
	
	//ozview body 핸들
	handle m_hBody = NULL;

	
//메인
	long m_bFirst;
	long m_lMtrChkFlag = 0;
	long m_lNpChkFlag = 0;
	long m_lTblAct = -1;
	long m_lMtrAct = -1;
	long m_lNpAct = -1;
	long m_lMtrPage = 0;
	long m_lMtrTotpage = 0;
	long m_lNpPage = 0;
	long m_lNpTotpage = 0;
	long m_lActiveIndex = 0;
	long m_lNpRow = -1;
	char m_szMtrInfo_page[20];
	char m_szNp_page[20];
//검침내역조회
	long m_lGmAct = -1;
	long m_lGmPage = 0;
	long m_lGmTotpage = 0;
	char m_szGm_page[20];
//수납실시간
	long m_lRelPage = 0;
	long m_lRelTotpage = 0;
	char m_szRel_page[20];
//입금내역
	long m_lHisPage = 0;
	long m_lHisTotpage = 0;
	char m_szHis_page[20];

	CARRAYLIST m_pList = NULL;
	bool m_bPrintAgain = FALSE;
	
//납부확약서
	long m_lPlanCnt = 0;

enum
{

	PRINT_PAY_PLAN = 1,
	PRINT_PAY_NP = 2,
	PRINT_PAY_BACK,
	PRINT_PAY_OK

} PRINT_PAY_STAT;	

	long m_nPayFlag = PRINT_PAY_PLAN;

//메인
	void SetStyle(void);
	void SetBtnImg(void);
	void MtrDraw(void);
	void NonpayDraw(void);
	void ReqymDraw(void);
	void SelAmtDraw(void);
	void ChkClear(void);
	void Save_Row(long row, long col);
	
	long Rcv_MtrInfo(void);
	long Rcv_MtrReqym(void);
	long Rcv_Reqym(void);
	long Rcv_Account(void);
	long Rcv_Release(void);
	long TR822020(void);
	long TR822021(void);
	long TR822022(void);
	long TR822023(void);
	long TR82205(void);	
	long Snd_Submit(void);
	long TR82233(void);
	bool Save_Submit(void);
	
	long Print_Result(void* p);
	bool BillPrint(void);
	void* BillPrint_GetData(void);
	
//검침내역조회
	void GmDraw(void);
	
//수납실시간
	void RelDraw(void);

//입금내역
	long Rcv_History(void);
	long TR82252(void);
	void HisDraw(void);

//체납발행 - 납부확약서
	long Rcv_Info(void);
	long TR66402(void);
	void SetInfo(void);
	void OzView(void);
	void SetJsonBody(SQLITE sql);
	void Rcv_OzData(char* OzData);
	long Snd_OzView(void);
	long TR822558(void);
	long Snd_Promiseplan(void);
	long TR66804(void);
//체납발행 - 납부확약서 영수증 출력
	long Rcv_BackVirtAccount(void);
	long TR82211_1(void);
	long GetUtf8Size(char* str, long chklen);
	
	void Print_PlanPay(void);
	
	void* Print_PlanPay_GetData(void);

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
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납관리"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_BUTTON(STARTX+500, STARTY+121, 250, 54, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRPREV, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+121, 250, 54, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRNEXT, "▼"),
		DLG_BUTTON(STARTX+500, STARTY+525, 250, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NPPREV, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+525, 250, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NPNEXT, "▼"),
		DLG_BUTTON(STARTX,     STARTY+819, 230, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "체납발행"),
		DLG_BUTTON(STARTX+230, STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RELEASE, "수납\n실시간"),
		DLG_BUTTON(STARTX+480, STARTY+819, 230, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISTORY, "입금내역\n조회"),
		DLG_BUTTON(STARTX+710, STARTY+819, 140, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "중지"),
		DLG_BUTTON(STARTX+850, STARTY+819, 150, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBMIT, "납부"),
		
		DLG_TEXT(STARTX,     STARTY+121, 350, 54, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTRPAGE, m_szMtrInfo_page),
		DLG_TEXT(STARTX,     STARTY+175, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "계기종류"),
		DLG_TEXT(STARTX+230, STARTY+175, 340, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+570, STARTY+175, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "계기위치"),
		DLG_TEXT(STARTX+800, STARTY+175, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+225, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "상품명"),
		DLG_TEXT(STARTX+230, STARTY+225, 450, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+680, STARTY+225, 120, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "등급"),
		DLG_TEXT(STARTX+800, STARTY+225, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),

		DLG_TEXT(STARTX,     STARTY+525, 350, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NPPAGE, m_szNp_page),
		DLG_TEXT(STARTX,     STARTY+580, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "총미납액"),
		DLG_TEXT(STARTX+230, STARTY+580, 330, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+560, STARTY+580, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "개월"),
		DLG_TEXT(STARTX+690, STARTY+580, 310, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+630, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "대손금"),
		DLG_TEXT(STARTX+230, STARTY+630, 330, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+560, STARTY+630, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "기타"),
		DLG_TEXT(STARTX+690, STARTY+630, 310, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,     STARTY+680, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "선택금액"),
		DLG_TEXT(STARTX+230, STARTY+680, 330, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+560, STARTY+680, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "선택"),
		DLG_TEXT(STARTX+690, STARTY+680, 310, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX,     STARTY+730, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "수납금액"),
		DLG_TEXT(STARTX+230, STARTY+730, 330, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+560, STARTY+730, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, "차액"),
		DLG_TEXT(STARTX+690, STARTY+730, 310, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		
		DLG_LINE(STARTX, STARTY+580, 1000, STARTY+580, LIGHTSKYBLUE, 8, LINE_DATA1),
		DLG_LINE(STARTX, STARTY+630, 1000, STARTY+630, LIGHTSKYBLUE, 8, LINE_DATA2),
		
		// 리스트
		DLG_TABLE (GRID_X_M, GRID_Y_M, ROW_M, COL_M, 0, GRID_H_M, 1, GRID_H_M, SEL_ROW, MAXCHAR_M, m_stGridTitle_M, ID_MTRLIST, m_szTableBuf_M),
		DLG_TABLE (GRID_X_N, GRID_Y_N, ROW_N, COL_N, 0, GRID_H_N, 1, GRID_H_N, SEL_COL, MAXCHAR_N, m_stGridTitle_N, ID_NPLIST, m_szTableBuf_N),
		
		DLG_BUTTON(STARTX,       STARTY-29,  75, 50, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TXTCTRLFRCOLOR, TABLETITLE_COLOR, CALL_FUNC , "", BID_MTRCHK, CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+275,  75, 50, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TXTCTRLFRCOLOR, TABLETITLE_COLOR, CALL_FUNC , "", BID_NPCHK, CHKOFF),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "체납관리"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+500, STARTY+105, 250, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRPREV, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+105, 250, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRNEXT, "▼"),
		DLG_BUTTON(STARTX+500, STARTY+505, 250, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NPPREV, "▲"),
		DLG_BUTTON(STARTX+750, STARTY+505, 250, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NPNEXT, "▼"),
		DLG_BUTTON(STARTX,     STARTY+800, 220, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "체납발행"),
		DLG_BUTTON(STARTX+220, STARTY+800, 250, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RELEASE, "수납\n실시간"),
		DLG_BUTTON(STARTX+470, STARTY+800, 230, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISTORY, "입금내역\n조회"),
		DLG_BUTTON(STARTX+700, STARTY+800, 150, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "중지"),
		DLG_BUTTON(STARTX+850, STARTY+800, 150, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBMIT, "납부"),
		
		DLG_TEXT(STARTX,     STARTY+105, 350, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTRPAGE, m_szMtrInfo_page),
		DLG_TEXT(STARTX,     STARTY+160, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "계기종류"),
		DLG_TEXT(STARTX+230, STARTY+160, 340, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+570, STARTY+160, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "계기위치"),
		DLG_TEXT(STARTX+800, STARTY+160, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+210, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "상품명"),
		DLG_TEXT(STARTX+230, STARTY+210, 450, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+680, STARTY+210, 120, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "등급"),
		DLG_TEXT(STARTX+800, STARTY+210, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),

		DLG_TEXT(STARTX,     STARTY+505, 350, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NPPAGE, m_szNp_page),
		DLG_TEXT(STARTX,     STARTY+560, 230, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "총미납액"),
		DLG_TEXT(STARTX+230, STARTY+560, 330, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+560, STARTY+560, 130, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "개월"),
		DLG_TEXT(STARTX+690, STARTY+560, 310, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+615, 230, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "대손금"),
		DLG_TEXT(STARTX+230, STARTY+615, 330, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+560, STARTY+615, 130, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "기타"),
		DLG_TEXT(STARTX+690, STARTY+615, 310, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,     STARTY+670, 230, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "선택금액"),
		DLG_TEXT(STARTX+230, STARTY+670, 330, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+560, STARTY+670, 130, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "선택"),
		DLG_TEXT(STARTX+690, STARTY+670, 310, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX,     STARTY+725, 230, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA21, "수납금액"),
		DLG_TEXT(STARTX+230, STARTY+725, 330, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+560, STARTY+725, 130, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, "차액"),
		DLG_TEXT(STARTX+690, STARTY+725, 310, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		
		DLG_LINE(STARTX, STARTY+560, 1000, STARTY+560, LIGHTSKYBLUE, 2, LINE_DATA1),
		DLG_LINE(STARTX, STARTY+615, 1000, STARTY+615, LIGHTSKYBLUE, 2, LINE_DATA2),
		
		// 리스트
		DLG_TABLE (GRID_X_M, GRID_Y_M_P, ROW_M, COL_M, 0, GRID_H_M, 1, GRID_H_M, SEL_ROW, MAXCHAR_M, m_stGridTitle_M, ID_MTRLIST, m_szTableBuf_M),
		DLG_TABLE (GRID_X_N, GRID_Y_N_P, ROW_N, COL_N, 0, GRID_H_N, 1, GRID_H_N, SEL_COL, MAXCHAR_N, m_stGridTitle_N, ID_NPLIST, m_szTableBuf_N),
		
		DLG_BUTTON(STARTX,       STARTY-40,  75, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTCTRLFRCOLOR, TABLETITLE_COLOR, CALL_FUNC , "", BID_MTRCHK, CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+260,  75, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTCTRLFRCOLOR, TABLETITLE_COLOR, CALL_FUNC , "", BID_NPCHK, CHKOFF),
	};

	// 검침내역조회
	//---------------------------------------------------------------
	DlgObject	DlgRes_Gm[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "검침내역조회"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
		
		DLG_BUTTON(STARTX+250,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMNEXT, "▼"),
		DLG_BUTTON(STARTX+750,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),

		DLG_TEXT(STARTX,		 STARTY+819, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GMPAGE, m_szGm_page),
		
		// 리스트
		DLG_TABLE (GRID_X_G, GRID_Y_G, ROW_G, COL_G, 0, GRID_H_G, 1, GRID_H_G, SEL_ROW, MAXCHAR_G, m_stGridTitle_G, ID_GMLIST, m_szTableBuf_G),
	};	
	
	// 검침내역조회 PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_Gm_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "검침내역조회"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX+300,   STARTY+820, 200, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+820, 200, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMNEXT, "▼"),
		DLG_BUTTON(STARTX+700,   STARTY+820, 300, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),

		DLG_TEXT(STARTX,     STARTY+820, 300, 79, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GMPAGE, m_szGm_page),
		
		// 리스트
		DLG_TABLE (GRID_X_G, GRID_Y_G_P, ROW_G, COL_G, 0, GRID_H_G_P, 1, GRID_H_G_P-10, SEL_ROW, MAXCHAR_G, m_stGridTitle_G, ID_GMLIST, m_szTableBuf_G),
	};	
	
	// 체납발행
	//---------------------------------------------------------------
	DlgObject	DlgRes_Print[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "체납발행"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK2, ""),
		
		DLG_BUTTON(STARTX,        STARTY-29, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WRITE1, "납부확약서 작성"),
		DLG_BUTTON(STARTX+500,    STARTY-29, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WRITE2, "기타양식 작성"),
		DLG_BUTTON(STARTX+500,   STARTY+100, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2, "닫기"),
	};	
	
	// 체납발행 PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_Print_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "체납발행"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK2, ""),

		DLG_BUTTON(STARTX,           STARTY, 450, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WRITE1, "납부확약서 작성"),
		DLG_BUTTON(STARTX+535,       STARTY, 450, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WRITE2, "기타양식 작성"),
		DLG_BUTTON(STARTX+685,   STARTY+120, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2, "닫기"),
	};	
	
	// 실시간 납부내역
	//---------------------------------------------------------------
	DlgObject	DlgRes_Rel[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "실시간 납부내역조회"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK3, ""),
		
		DLG_BUTTON(STARTX+250,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RELPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RELNEXT, "▼"),
		DLG_BUTTON(STARTX+750,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK3, "확인"),

		DLG_TEXT(STARTX,		 STARTY+819, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_RELPAGE, m_szRel_page),
		
		// 리스트
		DLG_TABLE (GRID_X_R, GRID_Y_R, ROW_R, COL_R, 0, GRID_H_R, 1, GRID_H_R, SEL_ROW, MAXCHAR_R, m_stGridTitle_R, ID_RELLIST, m_szTableBuf_R),
	};	
	
	// 실시간 납부내역 PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_Rel_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "실시간 납부내역조회"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK3, ""),

		DLG_BUTTON(STARTX+300,   STARTY+820, 200, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RELPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+820, 200, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RELNEXT, "▼"),
		DLG_BUTTON(STARTX+700,   STARTY+820, 300, 79, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK3, "확인"),

		DLG_TEXT(STARTX,     STARTY+820, 300, 79, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_RELPAGE, m_szRel_page),
		
		// 리스트
		DLG_TABLE (GRID_X_R, GRID_Y_R_P, ROW_R, COL_R, 0, GRID_H_R_P, 1, GRID_H_R_P-10, SEL_ROW, MAXCHAR_R, m_stGridTitle_R, ID_RELLIST, m_szTableBuf_R),
	};	


	// 입금내역
	//---------------------------------------------------------------
	DlgObject	DlgRes_History[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "입금 내역"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HISOK, ""),
		
		DLG_BUTTON(STARTX+250,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISNEXT, "▼"),
		DLG_BUTTON(STARTX+750,   STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISOK, "확인"),		

		DLG_TEXT(STARTX,		 STARTY+819, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_HISPAGE, m_szHis_page),

		// 리스트
		DLG_TABLE (GRID_X_H, GRID_Y_H, ROW_H, COL_H, 0, GRID_H_H, 1, GRID_H_H, SEL_ROW, MAXCHAR_H, m_stGridTitle_H, ID_HISLIST, m_szTableBuf_H),
	};	
	
	// 입금내역 PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_History_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "입금 내역"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HISOK, ""),

		DLG_BUTTON(STARTX+300,   STARTY+830, 200, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+830, 200, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISNEXT, "▼"),
		DLG_BUTTON(STARTX+700,   STARTY+830, 300, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISOK, "확인"),		

		DLG_TEXT(STARTX,     STARTY+830, 300, 69, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_HISPAGE, m_szHis_page),

		// 리스트
		DLG_TABLE (GRID_X_H, GRID_Y_H_P, ROW_H, COL_H, 0, GRID_H_H_P, 1, GRID_H_H_P-20, SEL_ROW, MAXCHAR_H, m_stGridTitle_H, ID_HISLIST, m_szTableBuf_H),
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
		PRINT("AAAAAAAAAAAAAAAAAAAAAAAA",0,0,0);
		PRINT("g_nWorkFlag : %d",g_nWorkFlag,0,0);
		m_bFirst = bFirst;
	
		switch (bFirst)
		{
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
				
				if( g_lConfrimFlag == 0  )
				{
					//g_lConfrimFlag, 체납정보 수신 관련 flag로 사용중.
					g_lConfrimFlag = 1;
					Rcv_MtrInfo();
				}
				else
				{
					MtrDraw();
					NonpayDraw();
					ReqymDraw();
				}
				g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_RELEASE", &lCnt );
				if( lCnt > 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), FALSE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), TRUE );
				}
				ON_DRAW();
				break;
			case INIT_GM:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Gm_P, SIZEOF(DlgRes_Gm_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Gm, SIZEOF(DlgRes_Gm));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				GmDraw();
				ON_DRAW();
				break;
			case INIT_PRINT:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Print_P, SIZEOF(DlgRes_Print_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Print, SIZEOF(DlgRes_Print));
						break;		
				}
				
				SetBtnImg();
				ON_DRAW();
				break;
			case INIT_RELEASE:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Rel_P, SIZEOF(DlgRes_Rel_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Rel, SIZEOF(DlgRes_Rel));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				RelDraw();
				ON_DRAW();
				break;
			case INIT_HISTORY:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_History_P, SIZEOF(DlgRes_History_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_History, SIZEOF(DlgRes_History));
						break;		
				}
				
				SetBtnImg();
				SetStyle();
				Rcv_History();
				ON_DRAW();
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//-----------------------------------------------------------------
void	SetStyle(void)
{
	if( m_bFirst == INIT_MAIN )
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTRPAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NPPAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		
		// 2018.02.13 CS팀 황영자 과장님 요청, 신기호 개발 : 솔루션즈 납부 버튼 막음
		if( Str_Cmp(stUserinfo.szcenter_cd, "98") == 0 )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SUBMIT), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SUBMIT), FALSE );
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SUBMIT), FALSE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SUBMIT), TRUE );
		}
	}
	else if( m_bFirst == INIT_RELEASE )
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_RELPAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	else if( m_bFirst == INIT_GM )
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMPAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	else if( m_bFirst == INIT_HISTORY )
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HISPAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
}

//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

/*		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+730) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+700-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+750-(g_Dlgflag*400)) )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);

							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);

							ShowSip(TRUE);
							g_Sipflag = 1;
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
		else if( m_bFirst == INIT_BIGMTR )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+380) && Y < DMS_Y(STARTY+440) ||
					    X > DMS_X(STARTX+350) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+440) && Y < DMS_Y(STARTY+500) ||
					    X > DMS_X(STARTX+350) && X < DMS_X(STARTX+975) && Y > DMS_Y(STARTY+500) && Y < DMS_Y(STARTY+560) )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_DATA5) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
					
					ON_DRAW();
				}
			}
		}
*/
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{			
			case BID_MTRCHK:
			/*
				if( m_lMtrChkFlag == 0 )
				{
					m_lMtrChkFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_MTRCHK), CHKON);
					g_Sql_DirectExecute( "UPDATE RCV_NONPAY_MTRINFO SET PARAM13 = '1'" );
				}
				else
				{
					m_lMtrChkFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_MTRCHK), CHKOFF);
					g_Sql_DirectExecute( "UPDATE RCV_NONPAY_MTRINFO SET PARAM13 = '0'" );
				}
			*/
				break;
			case BID_NPCHK:
				if( m_lNpChkFlag == 0 )
				{
					m_lNpChkFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKON);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), RED);
					g_Sql_DirectExecute( "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '1'" );
				}
				else
				{
					m_lNpChkFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
					g_Sql_DirectExecute( "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '0'" );
				}
				NonpayDraw();
				SelAmtDraw();
				break;
			case BID_MTRPREV:
				m_lMtrPage--;
				if(m_lMtrPage < 0)
				{
					m_lMtrPage = 0;
					break;
				}
				MtrDraw();
				break;
			case BID_MTRNEXT:
				m_lMtrPage++ ;
				if( m_lMtrPage > m_lMtrTotpage-1 )
				{
					m_lMtrPage = m_lMtrTotpage-1;
					if(m_lMtrPage < 0)
					{
						m_lMtrPage = 0;
					}
					break;
				}
				MtrDraw();
				break;
			case BID_NPPREV:
				m_lNpPage--;
				if(m_lNpPage < 0)
				{
					m_lNpPage = 0;
					break;
				}
				NonpayDraw();
				break;
			case BID_NPNEXT:
				m_lNpPage++ ;
				if( m_lNpPage > m_lNpTotpage-1 )
				{
					m_lNpPage = m_lNpTotpage-1;
					if(m_lNpPage < 0)
					{
						m_lNpPage = 0;
					}
					break;
				}
				NonpayDraw();
				break;
			case BID_PRINT:
				ChkClear();
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					ON_EXIT();
					OnInit(INIT_PRINT);
				}
				else
				{
					g_lNpChkFlag = m_lNpChkFlag;
					Card_Move("C6202_NPPRINT");
				}
				break;
			case BID_RELEASE:
				ChkClear();
				ON_EXIT();
				OnInit(INIT_RELEASE);
				break;
			case BID_HISTORY:
				ChkClear();
				ON_EXIT();
				OnInit(INIT_HISTORY);
				break;
			case BID_STOP:
				if( g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
				{
					ChkClear();
					if( Str_Cmp( DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 3), "중지") == 0 )
					{
						//체납활동 -> 해제, MTR_SUPPLY_STS == 중지
						Card_Move("C6202_CLEAR");
					}
					else
					{
						//체납활동 -> 중지, MTR_SUPPLY_STS == 해제
						Card_Move("C6202_NPSTOP");
					}
				}
				break;
			case BID_SUBMIT:
				Snd_Submit();
				break;
			case BID_CLOSE:
				Card_Move("C6202_NPACTIVE");
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "메인 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "체납 메뉴로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6202_MENU");
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
				Card_Move("C6202_NPACTIVE");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;

				g_Exit();
				return;
//검침내역조회
			case BID_GMPREV:
				m_lGmPage--;
				if(m_lGmPage < 0)
				{
					m_lGmPage = 0;
					break;
				}
				GmDraw();
				break;
			case BID_GMNEXT:
				m_lGmPage++ ;
				if( m_lGmPage > m_lGmTotpage-1 )
				{
					m_lGmPage = m_lGmTotpage-1;
					if(m_lGmPage < 0)
					{
						m_lGmPage = 0;
					}
					break;
				}
				GmDraw();
				break;
			case BID_OK:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
//체납발행
			case BID_WRITE1:
				Rcv_Info();
				break;
			case BID_WRITE2:
				g_lNpChkFlag = m_lNpChkFlag;
				Card_Move("C6202_NPPRINT");
				break;
			case BID_OK2:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
//수납실시간
			case BID_RELPREV:
				m_lRelPage--;
				if(m_lRelPage < 0)
				{
					m_lRelPage = 0;
					break;
				}
				RelDraw();
				break;
			case BID_RELNEXT:
				m_lRelPage++ ;
				if( m_lRelPage > m_lRelTotpage-1 )
				{
					m_lRelPage = m_lRelTotpage-1;
					if(m_lRelPage < 0)
					{
						m_lRelPage = 0;
					}
					break;
				}
				RelDraw();
				break;
			case BID_OK3:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
//입금내역
			case BID_HISPREV:
				m_lHisPage--;
				if(m_lHisPage < 0)
				{
					m_lHisPage = 0;
					break;
				}
				HisDraw();
				break;
			case BID_HISNEXT:
				m_lHisPage++ ;
				if( m_lHisPage > m_lHisTotpage-1 )
				{
					m_lHisPage = m_lHisTotpage-1;
					if(m_lHisPage < 0)
					{
						m_lHisPage = 0;
					}
					break;
				}
				HisDraw();
				break;
			case BID_HISOK:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;

		}
	}
	
//----------------------------------------------------------------------------	
	void	OnSelect(long Index)
	{
		long lCnt, lMaxCnt;
		long index = -1;
		long lpage = 0;
		long lrow, lcol;
		char sztmp[20];

		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_MTRLIST))
				m_lTblAct = 1;
			else if(DlgTbl_IsSelect(ID_NPLIST))
				m_lTblAct = 2;
	
			//계량기점검
			if( m_lTblAct == 1 )
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_MTRLIST);
				m_lMtrAct = index - 1;
			
				if( Str_Cmp(DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 4), "다기능") == 0 )
				{
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA2), RED);
				}
				else
				{
					EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA2), TXTFRCOLOR);
				}
			
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 4) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 5) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 6) );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 7) );
				
				Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
				Str_Cpy( g_szMTR_NUM, DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 8) );
			}
			else
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_NPLIST);

				m_lActiveIndex = index;
				m_lNpAct = index;
				
				lrow = m_lNpAct/COL_N;
				lcol = m_lNpAct%COL_N;
				lrow--;
//PRINT("m_lNpRow : %d , lrow : %d ,, lcol : %d  ",m_lNpRow, lrow,lcol);
				if( m_lNpRow == lrow && lcol != 0 )
				{
					ChkClear();
					ON_EXIT();
					OnInit(INIT_GM);
					return;
				}
				else
				{
					if( lcol == 0 )
					{
						m_lNpRow = -1;
					}
					else
					{
						m_lNpRow = lrow;
					}
				}

				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_NPLIST, lrow, lcol) );
				if( lcol == 0 )
				{
					if( Str_Cmp( sztmp, CHKON) == 0 )
					{
						DlgTbl_SetStr ( ID_NPLIST, lrow, lcol, CHKOFF );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol ), BLACK);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol+4 ), BLACK);
					}
					else
					{
						DlgTbl_SetStr ( ID_NPLIST, lrow, lcol, CHKON );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol ), RED );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, lrow, lcol+4 ), RED );
					}
					
					Save_Row(lrow, lcol);
					
					g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1' ", &lCnt );
					if( lCnt == 0 )
					{
						m_lNpChkFlag = 0;
						ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
					}
					else
					{
						g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &lMaxCnt );
						if( lMaxCnt == lCnt )
						{
							m_lNpChkFlag = 1;
							ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKON);
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), RED);
						}
						else if( lMaxCnt > lCnt )
						{
							m_lNpChkFlag = 0;
							ButCtrl_SetText(Get_hDlgCtrlByID(BID_NPCHK), CHKOFF);
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NPCHK), BLACK);
						}
					}
				}
			}
			
			ON_DRAW();
		}
	}

	//------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char* szOzData;
		long nRet = 0;

		if( nEvent == 1 )
		{
			//시스템콜
			szOzData = (char*)System_GetResult((char*)&nRet);
			
			//g_Save_JsonFile(szOzData);
			
			Rcv_OzData(szOzData);
		}
	}

//------------------------------------------------------------------------------------------	
	long Rcv_MtrInfo(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_NONPAY_MTRINFO");
		
		//PROGRESS_DUMP("");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822020, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822020; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR822020_IN",  "FR822020" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR822020(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(822020) >= 0)
		{
			Rcv_MtrReqym();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

//------------------------------------------------------------------------------------------	
	long Rcv_MtrReqym(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_NONPAY_MTRREQYM");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822021, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822021; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR822021_IN",  "FR822021" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR822021(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(822021) >= 0)
		{
			Rcv_Reqym();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

//------------------------------------------------------------------------------------------	
	long Rcv_Reqym(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_NONPAY_REQYM");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822022, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822022; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR822022_IN",  "FR822022" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR822022(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(822022) >= 0)
		{
			Rcv_Account();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

//------------------------------------------------------------------------------------------	
	long Rcv_Account(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_NONPAY_ACCOUNT");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822023, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822023; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR822023_IN",  "FR822023" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR822023(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(822023) >= 0)
		{
			Rcv_Release();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}


//------------------------------------------------------------------------------------------	
	long Rcv_Release(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_RELEASE");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82205, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82205; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR82205_IN",  "FR82205" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR82205(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		long lCnt = 0;
		
		g_Sock_Close();
		
		if(g_Chk_Json(82205) >= 0)
		{
			MtrDraw();
			NonpayDraw();
			ReqymDraw();
			
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_RELEASE", &lCnt );

			if( lCnt > 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), FALSE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RELEASE), TRUE );
			}
			
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}


//------------------------------------------------------------------
	void MtrDraw(void)
	{
		long i, idx;
		long k = ROW_M + 1;
		char sztmp[256];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRINFO", &m_lMtrTotpage );
		
		if( m_lMtrTotpage % ROW_M > 0 )
		{
			m_lMtrTotpage = (m_lMtrTotpage / ROW_M) + 1;
		}
		else
		{
			m_lMtrTotpage = m_lMtrTotpage / ROW_M;
		}
		//페이지
		SPRINT(m_szMtrInfo_page, "%d/%d", m_lMtrPage+1, m_lMtrTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT PARAM4, PARAM2, PARAM1, PARAM5, PARAM6, PARAM10, PARAM12, PARAM3  FROM RCV_NONPAY_MTRINFO LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lMtrPage*ROW_M;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lMtrPage*ROW_M+ROW_M;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_M ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_MTRLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_MTRLIST, i, 8, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_MTRLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 7, "" );
					DlgTbl_SetStr ( ID_MTRLIST, i, 8, "" );
					continue;
				}
				
				idx = 0;
				//ㅁ
				//Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				//sql->GetValue(sql, idx++, 'U', (long*)sztmp, 4, DECRYPT);
				//DlgTbl_SetStr ( ID_MTRLIST, i, 0, sztmp );
				//기물번호
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_MTRLIST, i, 1, sztmp );
				//체납액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_MTRLIST, i, 2, sztmp );
				//상태
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_MTRLIST, i, 3, sztmp );
				//계기종류
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_MTRLIST, i, 4, sztmp );
				//계기위치
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_MTRLIST, i, 5, sztmp );
				//상품명
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_MTRLIST, i, 6, sztmp );
				//등급
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_MTRLIST, i, 7, sztmp );
				//MTR_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_MTRLIST, i, 8, sztmp );
			}
		}		
Finally:

		if( m_lMtrAct == -1 )
		{
			m_lMtrAct = 0;
		}

		if(m_lMtrTotpage > 0)
		{
			DlgTbl_SetActive(ID_MTRLIST , m_lMtrAct+1 );
			DlgTbl_SetRowColor(ID_MTRLIST, m_lMtrAct+1, TABLEACTIVE_COLOR);

			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 4) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 5) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 6) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 7) );
		}

		
		if( Str_Cmp(DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 4), "다기능") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA2), RED);
		}
		else
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA2), TXTFRCOLOR);
		}

		if( Str_Cmp(stNoPayObj.CONT_STS_CD, "30") != 0 )
		{
			if( Str_Cmp( DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 3), "정상") == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), FALSE );
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_STOP), "중지");
			}
			else if( Str_Cmp( DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 3), "중지") == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), FALSE );
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_STOP), "해제");
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), TRUE );
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_STOP), "중지");
			}
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_STOP), TRUE );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_STOP), "중지");
		}
		
		Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
		Str_Cpy( g_szMTR_NUM, DlgTbl_GetStr( ID_MTRLIST, m_lMtrAct, 8) );

		//sql->Commit(sql);
		DelSqLite(sql);

		return;
	}
		
//------------------------------------------------------------------
	void NonpayDraw(void)
	{
		long i, idx;
		long k = ROW_N + 1;
		char sztmp[201];
		char szDate[50];
		char szSql[500];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &m_lNpTotpage );
		
		if( m_lNpTotpage % ROW_N > 0 )
		{
			m_lNpTotpage = (m_lNpTotpage / ROW_N) + 1;
		}
		else
		{
			m_lNpTotpage = m_lNpTotpage / ROW_N;
		}
		//페이지
		SPRINT(m_szNp_page, "%d/%d", m_lNpPage+1, m_lNpTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT PARAM9, PARAM1, PARAM3, PARAM2, PARAM4 FROM RCV_NONPAY_MTRREQYM WHERE PARAM6 = '%s' LIMIT ?, ? ", g_szMTR_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lNpPage*ROW_N;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lNpPage*ROW_N+ROW_N;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_N ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_NPLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_NPLIST, i, 4, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_NPLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_NPLIST, i, 4, "" );
					continue;
				}
				
				idx = 0;
				//ㅁ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5, DECRYPT);
				if( Str_Cmp(sztmp, "1") == 0 )
				{
					DlgTbl_SetStr ( ID_NPLIST, i, 0, CHKON );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 0 ), RED);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 4 ), RED);
				}
				else
				{
					DlgTbl_SetStr ( ID_NPLIST, i, 0, CHKOFF );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 0 ), BLACK);
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_NPLIST, i, 4 ), BLACK);
				}
				//청구년월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_NPLIST, i, 1, sztmp );
				//제외
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_NPLIST, i, 2, sztmp );
				//상태
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_NPLIST, i, 3, sztmp );
				//체납금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_NPLIST, i, 4, sztmp );
			}
		}		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		return;	
	}
	
//------------------------------------------------------------------
	void ReqymDraw(void)
	{
		long lAllAmt, lDebtAmt, lLawEtcAmt;
		char szSql[500];
		char szTmp[50];
		char szAmt[30];
	
		//대손금
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		g_Sql_RetStr("SELECT PARAM14 FROM RCV_NONPAY_REQYM", 50, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			lDebtAmt = 0;
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), "0");
		}
		else
		{
			lDebtAmt = Str_AtoI(szTmp);
			Str_Chg(szTmp, STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), szTmp);
		}
		
		
		//법적및기타
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		//SPRINT( szSql, "SELECT PARAM12 FROM RCV_NONPAY_REQYM", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
		g_Sql_RetStr("SELECT PARAM12 FROM RCV_NONPAY_REQYM", 50, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			lLawEtcAmt = 0;
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), "0");
		}
		else
		{
			lLawEtcAmt = Str_AtoI(szTmp);
			Str_Chg(szTmp, STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), szTmp);
		}
		
		//체납금액
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set( (byte*) szAmt, 0x00, sizeof( szAmt) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_REQYM", 50, szTmp);
		lAllAmt = Str_AtoI(szTmp);
		lAllAmt = lAllAmt + lDebtAmt + lLawEtcAmt;
		Str_ItoA(lAllAmt, szAmt, 10);
		if( Str_Len(szAmt) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14), "0");
		}
		else
		{
			Str_Chg(szAmt, STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14), szAmt);
		}
		
		//개월
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		g_Sql_RetStr("SELECT COUNT(PARAM1) FROM RCV_NONPAY_REQYM", 10, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), "0");
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), szTmp);
		}
		
		//선택금액
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), "0");
		
		//선택
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), "0");
		
		//수납금액
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), "0");
		
		//차액
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA24), "0");
	}
	

//------------------------------------------------------------------
	void Save_Row(long row, long col)
	{
		char szReqym[10];
		char sztmp[20];
		char szSql[300];
	
		Mem_Set((byte*)szReqym ,0x00, sizeof(szReqym) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );

		Str_Cpy( sztmp, DlgTbl_GetStr( ID_NPLIST, row, col) );
		Str_Cpy( szReqym, DlgTbl_GetStr( ID_NPLIST, row, 1) );		//청구년월
		//적합일 경우 항목 삭제
		if(Str_Cmp( sztmp, CHKON) == 0)
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '1' WHERE PARAM1 = '%s'", szReqym, 0, 0);
			g_Sql_DirectExecute( szSql );
			
		}
		else // 부적합일 경우 항목 추가
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '0' WHERE PARAM1 = '%s'", szReqym, 0, 0);
			g_Sql_DirectExecute( szSql );
		}
		
		SelAmtDraw();
	}
	
	
//------------------------------------------------------------------
	void SelAmtDraw(void)
	{
		long lAllamt, lSelamt, lGapamt;
		char szSql[300];
		char szTmp[50];
		char szAllamt[20];
		char szSelamt[20];
		char szGapamt[20];
	
		//선택금액
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 50, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), "0");
		}
		else
		{
			Str_Chg(szTmp, STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), szTmp);
		}
		
		//선택
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		g_Sql_RetStr("SELECT COUNT(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 10, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), "0");
		}
		else
		{
			Str_Chg(szTmp, STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), szTmp);
		}
		
		//수납금액
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", 50, szTmp);
		if( Str_Len(szTmp) == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), "0");
		}
		else
		{
			Str_Chg(szTmp, STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), szTmp);
		}
		
		//차액
		Mem_Set( (byte*) szAllamt, 0x00, sizeof( szAllamt) );
		Mem_Set( (byte*) szSelamt, 0x00, sizeof( szSelamt) );
		Mem_Set( (byte*) szGapamt, 0x00, sizeof( szGapamt) );
		Str_Cpy(szAllamt, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA14)));
		Str_Cpy(szSelamt, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA18)));
		Str_Chg(szAllamt, STRCHG_DEL_NONDIGIT);
		Str_Chg(szSelamt, STRCHG_DEL_NONDIGIT);
		
		lAllamt = Str_AtoI(szAllamt);
		lSelamt = Str_AtoI(szSelamt);
		lGapamt = lAllamt - lSelamt;
		Str_ItoA(lGapamt, szGapamt, 10);
		Str_Chg(szGapamt, STRCHG_INS_COMMA);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA24), szGapamt);
		
		ON_DRAW();
		return;
	}
	
	
//------------------------------------------------------------------
//검침내역조회
	void GmDraw(void)
	{
		long i, idx;
		long k = ROW_G + 1;
		char sztmp[201];
		char szDate[50];
		char szSql[500];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &m_lGmTotpage );
		
		if( m_lGmTotpage % ROW_G > 0 )
		{
			m_lGmTotpage = (m_lGmTotpage / ROW_G) + 1;
		}
		else
		{
			m_lGmTotpage = m_lGmTotpage / ROW_G;
		}
		//페이지
		SPRINT(m_szGm_page, "%d/%d", m_lGmPage+1, m_lGmTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM4, PARAM12, PARAM13 FROM RCV_NONPAY_MTRREQYM LIMIT ?, ? ");
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lGmPage*ROW_G;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lGmPage*ROW_G+ROW_G;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_G ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_GMLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_GMLIST, i, 3, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_GMLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_GMLIST, i, 3, "" );
					continue;
				}
				
				idx = 0;
				//청구년월
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 0, sztmp );
				//청구금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_GMLIST, i, 1, sztmp );
				//시작지침
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 2, sztmp );
				//마감지침
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_GMLIST, i, 3, sztmp );
			}
		}		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		return;	
	}
	
//------------------------------------------------------------------
//수납실시간
	void RelDraw(void)
	{
		long i, idx;
		long k = ROW_R + 1;
		char sztmp[201];
		char szDate[50];
		char szSql[500];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_RELEASE", &m_lRelTotpage );
		
		if( m_lRelTotpage % ROW_R > 0 )
		{
			m_lRelTotpage = (m_lRelTotpage / ROW_R) + 1;
		}
		else
		{
			m_lRelTotpage = m_lRelTotpage / ROW_R;
		}
		//페이지
		SPRINT(m_szRel_page, "%d/%d", m_lRelPage+1, m_lRelTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3 FROM RCV_RELEASE LIMIT ?, ? ");
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lRelPage*ROW_R;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lRelPage*ROW_R+ROW_R;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_R ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_RELLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_RELLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_RELLIST, i, 2, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_RELLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_RELLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_RELLIST, i, 2, "" );
					continue;
				}
				
				idx = 0;
				//납부일자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_RELLIST, i, 0, szDate );
				//납부시간
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				g_Str_TimeForm(szDate, sztmp);
				DlgTbl_SetStr ( ID_RELLIST, i, 1, szDate );
				//납부금액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_RELLIST, i, 2, sztmp );
			}
		}		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		return;	
	}


//------------------------------------------------------------------
	long Snd_Submit(void)
	{
		char szSql[500];
		char szTmp[300];
		char szSelAmt[50];
		char szDate[20];
		char szUnpayamt[50];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		long lCnt = 0;

/*
		Mem_Set((byte*)szSelAmt, 0x00, sizeof(szSelAmt));
		Str_Cpy(szSelAmt, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)));
		Str_Chg(szSelAmt, STRCHG_DEL_NONDIGIT);
		if( Str_Len(szSelAmt) < 1 )
		{
			MessageBoxEx(CONFIRM_OK, "수납할 금액을 선택해 주세요.");
			return -1;
		}
*/
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1' ", &lCnt );
		if( lCnt == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "수납할 금액을 선택해 주세요.");
			return -1;
		}

		Str_Cpy(szSelAmt, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)));
		Str_Chg(szSelAmt, STRCHG_DEL_NONDIGIT);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SPRINT(szTmp, "수납금액 %s원을 수납하시겠습니까?", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)), 0, 0);
		if( MessageBoxEx (CONFIRM_YESNO, szTmp)  != MB_OK)
		{
			return -1;
		}
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szUnpayamt, 0x00, sizeof(szUnpayamt));
		SPRINT(szTmp, "SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM WHERE PARAM6 = '%s' AND PARAM9 = '1'", g_szMTR_NUM, 0, 0);		
		g_Sql_RetStr(szTmp, 50, szUnpayamt);

		if( Str_Cmp(szUnpayamt, szSelAmt) != 0 )
		{
			MessageBoxEx(CONFIRM_OK, "계산오류. 다시 해보세요.");
			return -1;
		}
		
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Str_ItoA(Time_GetDate(), szDate, 10);
		Str_Chg(szDate, STRCHG_DEL_NONDIGIT);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82233, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "center_cd",       stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "pay_ymd",         szDate );

		sndbuf = JSON_toString(g_pjcomm);

		//전송데이터 확인
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT \
 PARAM1 AS REQ_YM, PARAM7 AS DEADLINE_FLAG, PARAM4 AS UNPAY_AMT, PARAM8 AS USE_CONT_NUM, PARAM6 AS MTR_NUM \
 FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1' AND PARAM6 = '%s' ORDER BY PARAM6, PARAM1"
, g_szMTR_NUM, 0, 0 );
		
		callBackfunc = TR82233; //통신완료 후에 호출 함수
		HTTP_UploadData  ( szUrl, "FR82233_IN",  "FR82233" , sndbuf, szbuf, szSql);
		
		return 1;
	}
	
//------------------------------------------------------------------
	long TR82233(void)
	{
		//long i;
		//char szSql[350];
	
		if(g_Chk_Json(82233) >= 0)
		{
			if( Save_Submit() )
			{
				MessageBoxEx (CONFIRM_OK, "수납처리가 완료 됐습니다.");
			
				BillPrint();
				
				//g_nWorkFlag = 830 중지리스트
				//if( g_nWorkFlag == 830 )
				//{
				//	SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				//	g_Sql_DirectExecute(szSql);
				//}
				//else
				//{
				//	SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				//	g_Sql_DirectExecute(szSql);
				//}
				//Str_Cpy(stNoPayObj.VISIT_FLAG, "Y");
				//Card_Move("C6202_NPACTIVE");
	
			}
			
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
//------------------------------------------------------------------
	bool Save_Submit(void)
	{
		long idx;
		long lAcceptAmt, SelMCnt;
		char szAmt[30];
		bool bRet = FALSE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szAmt, 0x00, sizeof(szAmt));	
		Str_Cpy(szAmt, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)));
		Str_Chg(szAmt, STRCHG_DEL_NONDIGIT);
		lAcceptAmt = Str_AtoI(stNoPayObj.ACCEPT_AMT) + Str_AtoI(szAmt);

		Mem_Set((byte*)szAmt, 0x00, sizeof(szAmt));	
		Str_Cpy(szAmt, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA18)));
		Str_Chg(szAmt, STRCHG_DEL_NONDIGIT);
		SelMCnt = Str_AtoI(stNoPayObj.SEL_M_CNT) + Str_AtoI(szAmt);
		
		Mem_Set((byte*)stNoPayObj.ACCEPT_AMT, 0x00, sizeof(stNoPayObj.ACCEPT_AMT));	
		Mem_Set((byte*)stNoPayObj.SEL_M_CNT, 0x00, sizeof(stNoPayObj.SEL_M_CNT));
		Str_ItoA(lAcceptAmt, stNoPayObj.ACCEPT_AMT, 10);
		Str_ItoA(SelMCnt, stNoPayObj.SEL_M_CNT, 10);
		
		Str_Cpy(stNoPayObj.RCEI_FLAG, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "UPDATE C6202_NOPAY_OBJ SET \
ACCEPT_AMT = ?, SEL_M_CNT = ?, RCEI_FLAG = 'Y'\
WHERE USE_CONT_NUM = ? "
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.ACCEPT_AMT		  ,20  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.SEL_M_CNT		      ,20  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stNoPayObj.USE_CONT_NUM		  ,11  ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		bRet = TRUE;
		
Finally:

		DelSqLite(sql);
		return bRet;
	}

	//------------------------------------------------------------------
	long Print_Result(void* p)
	{
		long* pRet = (long*)p;
		long nRet = *pRet;
	
		PRINT("%s", g_Printer_GetLastError(nRet),0,0);
	
		if( MessageBoxEx (CONFIRM_YESNO, "영수증 발행이 잘되었습니까?") == MB_OK )
		{
			switch(m_nPayFlag)
			{
				case PRINT_PAY_PLAN:	break;
				case PRINT_PAY_NP:		break;
			}	
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "재발행 하시겠습니까?") == MB_OK )
			{
				m_bPrintAgain = TRUE;

				switch(m_nPayFlag)
				{
					case PRINT_PAY_PLAN: 	Print_PlanPay(); 	break;
					case PRINT_PAY_NP: 		BillPrint(); 		break;
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
		
		if( PRINT_PAY_NP == m_nPayFlag )
		{
			char szSql[350];
		
			//g_nWorkFlag = 830 중지리스트
			if( g_nWorkFlag == 830 )
			{
				SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else if( g_nWorkFlag == 810 )
			{
				//개별활동 대상
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else
			{
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			Str_Cpy(stNoPayObj.VISIT_FLAG, "Y");
			Card_Move("C6202_NPACTIVE");
		}
		
		return 0;
	}	
	
	//------------------------------------------------------------------
	bool BillPrint(void)
	{
		bool bRet = TRUE;
		
		if (m_bPrintAgain == FALSE)
		{
		  callBackfunc = NULL;
			m_pList = BillPrint_GetData();
		}
		
		g_Printer_Start(m_pList, (void*)Print_Result);

		//2017-10-27 Sanghyun Lee
		//납부 진행 후 화면 이동 안되는 버그 수정.
		m_nPayFlag = PRINT_PAY_NP; 
		
		return bRet;
	}
	
	//------------------------------------------------------------------
	void* BillPrint_GetData(void)
	{
		long i, j, ret, lCnt;
		long lUnpayAmt = 0;
		long lLoopCnt = 0;
		long lAddrFlag = 0; //lAddrFlag = 0 신주소 정보 없음, lAddrFlag = 1 신주소 정보 존재.
		char LineSpace[]={0x1b,0x20,0x00};
		char sztmp[300];
		char szBuf[300];
		char szMsg[300];
		char szMoney[30];
		char szFirstNm[20];
		char szLastNm[20];
		char BillPrint[40][33];
		CARRAYLIST list = NULL;

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}

		list->append(list, "--------------------------------");
		list->append(list, "       영 수 증 (고 객 용)      ");
		list->append(list, "--------------------------------");
		list->append(list, "       서울도시가스(주)         ");
		list->append(list, "서울시 강서구 염창동 281\n");
		list->append(list, "사업자 번호: 109-81-31605\n");
		//list->append(list, "대표이사 : 유승배 외\n");
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp ,"대표이사 : " );
		Str_Cat(sztmp ,stUserinfo.szScg_repre_nm );
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "전화번호 : 02)810-8000          ");
		list->append(list, "           1588-5788            ");
		list->append(list, "--------------------------------");

		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Mem_Set((byte*)szFirstNm, 0x00, sizeof(szFirstNm));
		Mem_Set((byte*)szLastNm, 0x00, sizeof(szLastNm));
		if( Str_Len(stNoPayObj.CUST_NM) < 6 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);

			Str_Cpy(szBuf, "고 객 명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stNoPayObj.CUST_NM) > 4 && Str_Len(stNoPayObj.CUST_NM) < 8)
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+4, 2);

			Str_Cpy(szBuf, "고 객 명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stNoPayObj.CUST_NM) > 6 && Str_Len(stNoPayObj.CUST_NM) < 10 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+6, 2);

			Str_Cpy(szBuf, "고 객 명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stNoPayObj.CUST_NM) > 8 && Str_Len(stNoPayObj.CUST_NM) < 12 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+8, 2);

			Str_Cpy(szBuf, "고 객 명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, "상 호 명 : ");
		Str_Cat(sztmp, stNoPayObj.FIRM_NM);
		g_Line_Print(list, sztmp,"","",LEFT,0);

		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));

		Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.CUST_NUM, 5);
		Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.CUST_NUM+5, 5);
		Str_Cpy(sztmp, "고객번호 : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "-");
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);

		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));

		Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM, 5);
		Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.USE_CONT_NUM+5, 5);
		Str_Cpy(sztmp, "계약번호 : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "-");
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);

		if( Str_Len(stNoPayObj.CO_LIVE_NM) > 0 )
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "지번주소 : ");
			Str_Cat(sztmp, stNoPayObj.CITY);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.AREA);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.TOWN);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.ADDR1_M);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.ADDR1_S);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.CO_LIVE_NM);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.BLD_NM);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.HOSU);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "도로명주소 : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
		}
		else
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "지번주소 : ");
			Str_Cat(sztmp, stNoPayObj.CITY);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.AREA);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.TOWN);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.ADDR1_M);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.ADDR1_S);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "도로명주소 : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
		}

		list->append(list, "--------------------------------");
		g_Line_Print(list, "납기","","납부금액",RIGHT,0);
		list->append(list, "--------------------------------");

		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1'", &lCnt );
		for( j = 0 ; j < lCnt ; j++ )
		{
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			SPRINT( szBuf, "SELECT PARAM1 FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1' ORDER BY PARAM1 LIMIT %d, 1", j, 0, 0 );
			g_Sql_RetStr(szBuf, 20, szMsg);
			Str_Cat(sztmp, szMsg);

			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
			SPRINT( szBuf, "SELECT PARAM4 FROM RCV_NONPAY_MTRREQYM WHERE PARAM9 = '1' ORDER BY PARAM1 LIMIT %d, 1", j, 0, 0 );
			g_Sql_RetStr(szBuf, 30, szMsg);
			Str_Chg(szMsg, STRCHG_INS_COMMA);
			Str_Cat(szMoney, szMsg);
			Str_Cat(szMoney, "원");

			g_Line_Print(list, sztmp,"",szMoney,RIGHT,0);

			Str_Chg(szMsg, STRCHG_DEL_NONDIGIT);
			lUnpayAmt = lUnpayAmt + Str_AtoI(szMsg);
		}

		list->append(list, "--------------------------------");

		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Str_ItoA(lUnpayAmt, szBuf, 10);
		Str_Chg(szBuf, STRCHG_INS_COMMA);
		Str_Cpy(sztmp, "납부금액 : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "원");
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "--------------------------------");
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
		//Str_ItoA(Time_GetTime(), szBuf, 10);
		g_Str_TimeType( szBuf , Time_GetTime());
		Str_Chg(szBuf, STRCHG_DEL_NONDIGIT);
		g_Str_TimeForm(szMsg, szBuf);
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "                                ");
		list->append(list, "                                ");

		return list;
	}

	//------------------------------------------------------------------------------------------	
	long Rcv_History(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82252, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82252; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR82252_IN",  "FR82252" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR82252(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82252) >= 0)
		{
			HisDraw();
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
//------------------------------------------------------------------
	void HisDraw(void)
	{
		long i, idx;
		long k = ROW_H+1;
		char sztmp[201];
		char szDate[50];
		char szSql[500];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	

		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lHisTotpage );
		
		if( m_lHisTotpage % ROW_H > 0 )
		{
			m_lHisTotpage = (m_lHisTotpage / ROW_H) + 1;
		}
		else
		{
			m_lHisTotpage = m_lHisTotpage / ROW_H;
		}
		//페이지
		SPRINT(m_szHis_page, "%d/%d", m_lHisPage+1, m_lHisTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, TRIM(PARAM2), PARAM3, PARAM4 FROM RCV_TMP LIMIT ?, ? ");
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lHisPage*ROW_H;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lHisPage*ROW_H+ROW_H;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_H ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_HISLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_HISLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_HISLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_HISLIST, i, 3, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_HISLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_HISLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_HISLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_HISLIST, i, 3, "" );
					continue;
				}
				
				idx = 0;
				//소인일자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_HISLIST, i, 0, szDate );
				//입금유형
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_HISLIST, i, 1, sztmp );
				//수납액
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_HISLIST, i, 2, sztmp );
				//납부일자
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_HISLIST, i, 3, szDate );
			}
		}		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		return;	
	}


//------------------------------------------------------------------
//체납금액 체크 해제
	void ChkClear(void)
	{
		m_lNpChkFlag = 0;
		g_Sql_DirectExecute("UPDATE RCV_NONPAY_MTRREQYM SET PARAM9 = '0'");
		
		return;
	}
	
	//------------------------------------------------------------------
	long Rcv_Info(void)
	{
		char sztmp[300];
		char szUrl[256];
		char* sndbuf;
		long ret;
		char szSql[300];
		long gasnonpay = 0, gasacconut = 0;
		
		//if( g_lNpChkFlag == 1)
		if( Str_Cmp(stNoPayObj.PAYCONFIRM_FLAG, "Y") == 0 )
		{
			MessageBoxEx (ERROR_OK, "납부확약서 발행은 일회만 가능합니다.");
			ON_DRAW();
			return -1;
		}
	
		//민원자료 입력자료 업데이트
//		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
//		SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN='0' ", g_szCHK_EXEC_NUM, 0, 0   );
//		g_Sql_RetInt( szSql, &gasnonpay );
		
//		gasacconut = 0;
//		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
//		SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '0' ", g_szCHK_EXEC_NUM, 0, 0   );
//		g_Sql_RetInt( szSql, &gasacconut );
		
		//전출은 미납요금이 발생 납부확약서 발생 필수
//		if( (gasnonpay +gasacconut) == 0 )
//		{
//			MessageBoxEx (ERROR_OK, "제외한 미납급액이 없습니다.");//
//			return FALSE;
//		}
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66402, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "center_cd",              stUserinfo.szcenter_cd );		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",           stNoPayObj.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",     "0" );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stNoPayObj.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",               sztmp );
		JSON_SetValue( g_pjcomm, 'C', "soc_num",               stNoPayObj.SOC_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",                stNoPayObj.CP_DDD );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",                stNoPayObj.CP_EXN );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",                stNoPayObj.CP_NUM );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_ddd",      stNoPayObj.OWNHOUSE_TEL_DDD );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_exn",      stNoPayObj.OWNHOUSE_TEL_EXN );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_num",      stNoPayObj.OWNHOUSE_TEL_NUM );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stNoPayObj.CURR_ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "addr_union",            sztmp );
		
		JSON_SetValue( g_pjcomm, 'C', "treat_seq",              "0" );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", " " );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stNoPayObj.NEW_ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_union",        sztmp );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stNoPayObj.FIRM_NM );		
		JSON_SetValue( g_pjcomm, 'C', "firm_nm",               sztmp );
		
		JSON_SetValue( g_pjcomm, 'C', "biz_regi_num",          stNoPayObj.BIZ_REGI_NUM );
		
		//JSON_SetValue( g_pjcomm, 'C', "zip_seq",               stNoPayObj.ZIP_SEQ );
		//JSON_SetValue( g_pjcomm, 'C', "new_addr_bld_seq",      stNoPayObj.NEW_ADDR_BLD_SEQ );
		
		if(Str_Len(stNoPayObj.NEW_ADDR_UNION) > 5 )
			JSON_SetValue( g_pjcomm, 'C', "addr_type",             "R" );
		else
			JSON_SetValue( g_pjcomm, 'C', "addr_type",             "Z" );
			
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		//체납 납부확약서 수신과 분리됨.
		//FR822552 리턴만 동일함.
		callBackfunc = TR66402; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR66402_IN",  "FR66402" , sndbuf, sztmp );
		return 0 ;
	}
	
	//------------------------------------------------------------------
	long TR66402(void)	
	{
		g_Sock_Close();
		
		if( g_Chk_Json(66402) > 0)
		{	
			//고객정보
			SetInfo();
			//월별금액 셋팅
			OzView();
			
			ON_DRAW();
			return 1;	
		}
		else
		{
			MessageBoxEx (ERROR_OK, "조회된 자료가 없습니다.");
			ON_DRAW();
			return -1;
		}
	}

	//------------------------------------------------------------------
	//납부확약대상 정보
	void SetInfo(void)
	{
		long i;
		char szindex[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&m_stPayInfo, 0x00, sizeof(m_stPayInfo));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT \
  PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7, PARAM8 \
  , PARAM9, PARAM10, PARAM11, PARAM12, PARAM13, PARAM14, PARAM15 \
  , PARAM16, PARAM17, PARAM18, PARAM19, PARAM20, PARAM21 \
  , PARAM22, PARAM23, PARAM24, PARAM25, PARAM26, PARAM27 \
  , PARAM28, PARAM29, PARAM30, PARAM31, PARAM32, PARAM33, PARAM34, PARAM35, PARAM36, PARAM37, PARAM38, PARAM39, PARAM40, PARAM41 FROM RCV_TMP" );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while( sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CONT_NUM         , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_ASSIGN_SEQ   , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.SEQ                  , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CUST_NM          , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_FIRM_NM          , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_BIZ_REGI_NUM     , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CP_DDD           , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CP_EXN           , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CP_NUM           , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_OWNHOUSE_TEL_DDD , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_OWNHOUSE_TEL_EXN , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_OWNHOUSE_TEL_NUM , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CURR_ADDR_UNION  , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_NEW_ADDR_UNION   , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADJ_BASE_YMD         , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CUST_NM              , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.SOC_NUM              , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CP_DDD               , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CP_EXN               , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CP_NUM               , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.OWNHOUSE_TEL_DDD     , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.OWNHOUSE_TEL_EXN     , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.OWNHOUSE_TEL_NUM     , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.RELATION             , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CAUSE_CD             , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PAY_PLAN_YMD         , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.RMK                  , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_USE_CONT_NUM , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.FIRM_NM              , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.BIZ_REGI_NUM         , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADDR                 , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.SECOND_ADDR          , 200, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADDR_GB              , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADDR_TYPE            , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ZIP_SEQ              , 20,  DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.NEW_ADDR_BLD_SEQ     , 20,  DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_TYPE_GB      , 100, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_EMPID        , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_YMD          , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_TOT_AMT      , 20 , DECRYPT );
		}
Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	//------------------------------------------------------------------
	void OzView(void)
	{
		handle hHeader = NULL;
		handle h = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		PRINT("OzView start", 0, 0, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hHeader = JSON_Create( JSON_Object );
			if(hHeader == NULL)
			{
				goto Finally;
			}
			
			m_hBody = JSON_Create( JSON_Object );
			if(m_hBody == NULL)
			{
				goto Finally;
			}		

			//문서 별 Body 값 셋팅
			SetJsonBody(sql);
			
			//납부이행확약서 및 연대납부확약서 약관동의서 내용
			JSON_SetValue( m_hBody, 'C', "detail1",     "개인정보 수집 및 이용 동의 [필수]<br> <br><br> 1.개인정보의 수집·이용 목적<br> - 도시가스 요금안내, 실명확인 및 본인인증, 요금결제 및 추심관리, 법적조치<br> 2.수집·이용하려는 개인정보의 항목<br> - 성명, 주소, 전화번호, 휴대전화번호<br> 3.보유 및 이용기간<br> - 이용목적기간내" );
			JSON_SetValue( m_hBody, 'C', "detail2",     "고유식별정보 수집 및 이용 동의 [필수]<br><br> 1.고유식별정보의 수집·이용 목적<br> - 실명확인 및 본인인증, 채권추심, 법적조치<br> 2.수집·이용하려는 개인정보의 항목<br> - 주민등록번호, 외국인등록번호, 운전면허번호, 여권번호<br> 3.보유 및 이용기간<br> - 이용목적기간내" );
			JSON_SetValue( m_hBody, 'C', "detail3",     "개인(신용)정보 조회 동의 [필수]<br><br> 1.신용조회회사<br> - NICE평가정보㈜<br> 2.조회 대상 정보<br> - 개인정보, 신용도판단정보(연체, 부도, 금융질서문란), 공공정보, 신용등급, 경매관련<br> 3.조회 목적<br> - 확약서 체결 및 유지판단여부, 연체관리, 여신심사<br> 4.보유 및 이용기간<br> - 이용목적기간내" );
			JSON_SetValue( m_hBody, 'C', "detail4",     "개인(신용)정보 제3자 제공 동의 [필수]<br><br> 1.개인정보를 제공받는 자<br> - NICE평가정보(주)<br> 2.개인정보를 제공받는 자의 개인정보 이용 목적<br> - 신용정보조회, 채무불이행등록, 채권추심, 고객관리번호 발급<br> 3.제공하는 개인정보 항목<br> - 성명, 생년월일, 성별, 주소, 전화번호, 휴대전화번호, 미납정보<br> 4.보유 및 이용기간<br> - 이용목적기간내" );
			JSON_SetValue( m_hBody, 'C', "detail5",     "고유식별정보 제3자 제공 동의 [필수]<br><br> 1.고유식별정보를 제공받는 자<br> - NICE평가정보(주)<br> 2.고유식별정보를 제공받는 자의 고유식별정보 이용 목적<br> - 신용정보조회, 채무불이행등록, 채권추심<br> 3.제공하는 고유식별정보 항목<br> - 주민번호, 외국인등록번호, 운전면허번호, 여권번호<br> 4.보유 및 이용기간<br> - 이용목적기간내" );
			
			//주소 입력 화면 기본 데이터
			JSON_SetValue( m_hBody, 'C', "url",          GET_URL(WAS_BASE_URL) );
			JSON_SetValue( m_hBody, 'C', "clientid",     stUserinfo.szpda_ip );
			JSON_SetValue( m_hBody, 'C', "userid",       stUserinfo.szemployee_id );
			JSON_SetValue( m_hBody, 'C', "workcd",       stUserinfo.szworkcd );
			JSON_SetValue( m_hBody, 'C', "vmversion",    stUserinfo.szver_num );
			JSON_SetValue( m_hBody, 'C', "appversion",   stUserinfo.szappversion );
				
			//헤더 입력
			// PROMISE_TYPE_GB 확약서 종류 ( 납부이행 : 10, 연대납부 : 20 , 사용계약서는 아예 다름)
			if( Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "10") == 0 )
			{
				JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00003");
			}
			else if(Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "20") == 0 )
			{
				JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00002");
			}
			JSON_SetValue	(hHeader	, 'C', "Ozserver"			, GET_URL(OZ_BASE_URL));
			JSON_Attach 	(hHeader		 , "Paramdata"			, m_hBody);
			
			//시스템콜 요청
			// { "method" : "시스템콜 매쏘드명", "data" : "json object 스트링" }
			JSON_SetValue	(h, 'C', "method", "OzViewActivity");
			JSON_Attach 	(h, "data", hHeader);
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		DelSqLite(sql);
		PRINT("OzView DelSqLite", 0, 0, 0);
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hHeader)
		{
			JSON_Finalize(hHeader);
		}
			
		if (m_hBody)
		{
			JSON_Finalize(m_hBody);
		}
	}
	
	//------------------------------------------------------------------
	void SetJsonBody(SQLITE sql)
	{
		long i = 0, j = 0;
		long lAllAmt = 0;
		long lComboCnt = 0;
		char szUseHpNum[20];
		char szUseTelNum[20];
		char szTemlNum[20];
		char szNumber[5];
		char szAllAmt[30];
		char szpmChargedate[50];
		char szpmCost[50];
		char szpmPaybackdate[50];
		char szRet[256];
		char szTmp[256];
		char szComboData[700];
		long lDeptAmt = 0;
		long nonpay = 0;
		long nAmt = 0;
		char szPLAN_REQ1[20];
		char szPLAN_REQ2[20];
		char szSql[300];
		
		// PROMISE_TYPE_GB 확약서 종류 ( 납부이행 : 10, 연대납부 : 20 , 사용계약서는 아예 다름)
		if(Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "10") == 0 )
		{
			//계약서 작성형태 > 1(요금이행확약서) > 민원 외 , 2(요금이행확약서+이사정산) > 민원
			//1 >> 납부일자 수정 불가 / 사진 촬영 가능
			//2 >> 납부일자 수정 가능 / 사진 촬영 불가
			//3 >> 납부일자 수정 가능 / 사진 촬영 가능
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "3");
			
			//바디 - 사용고객정보
			JSON_SetValue	(m_hBody	, 'C', "pmUsecontnum"		, m_stPayInfo.USE_CONT_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmCorpname"			, m_stPayInfo.USE_FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmVatno"			, m_stPayInfo.USE_BIZ_REGI_NUM);

			if( Str_Len(m_stPayInfo.NEW_ADDR_UNION) > 5 )
			{
				//기본 도로명주소 입력
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			    , m_stPayInfo.USE_NEW_ADDR_UNION);
			}
			else
			{
				//도로명주소 없을 시 지번주소 입력
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			    , m_stPayInfo.USE_CURR_ADDR_UNION);
			}
			
			JSON_SetValue	(m_hBody	, 'C', "pmName"			    , m_stPayInfo.USE_CUST_NM);
			
			
			Mem_Set((byte*)szUseHpNum, 0x00, sizeof(szUseHpNum));	
			//SPRINT(szUseHpNum, "%s-%s-%s", m_stPayInfo.USE_CP_DDD, m_stPayInfo.USE_CP_EXN, m_stPayInfo.USE_CP_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stPayInfo.USE_CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stPayInfo.USE_CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stPayInfo.USE_CP_NUM);
			
			Mem_Set((byte*)szUseTelNum, 0x00, sizeof(szUseTelNum));	
			//SPRINT(szUseTelNum, "%s-%s-%s", m_stPayInfo.USE_OWNHOUSE_TEL_DDD, m_stPayInfo.USE_OWNHOUSE_TEL_EXN, m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stPayInfo.USE_OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stPayInfo.USE_OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			
			
			//바디 - 도시가스 미납내역 및 상환(납부이행) 계획 , m_lPlanCnt
			//법적및기타
			g_Sql_RetStr2(sql, "SELECT PARAM12 FROM RCV_NONPAY_REQYM", 50, szTmp);
			lAllAmt = 0;
			if( Str_AtoI( szTmp ) > 0 )
			{
				m_lPlanCnt = 2;
			}
			else
			{
				m_lPlanCnt = 1;
			}
			
			nonpay = 0;
			lDeptAmt = 0;
			//총 월별미납금액
			g_Sql_RetInt2(sql, "SELECT SUM(PARAM4) FROM RCV_NONPAY_REQYM", &nonpay );
			//대손미납금
			g_Sql_RetInt2(sql, "SELECT PARAM14 FROM RCV_NONPAY_REQYM", &lDeptAmt );
			
			i = 0;
			nAmt = 0;
			nAmt = nonpay+lDeptAmt;   //총 월별미납금액+대손미납금
			Str_ItoA( nAmt, m_stPayPlan[i].PROMISE_PLAN_AMT,10   );
			
			Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
			g_Sql_RetStr2(sql, "SELECT MIN(PARAM1) FROM RCV_NONPAY_REQYM", 7, szPLAN_REQ2 );
			if( Str_Len(szPLAN_REQ2) == 0 )
			{
				Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
				g_Sql_RetStr2(sql, "SELECT MAX(PARAM1) FROM RCV_NONPAY_REQYM", 7, szPLAN_REQ2 );
			}
			
			Mem_Set( (byte*)szPLAN_REQ1, 0x00, sizeof(szPLAN_REQ1) );
			g_Sql_RetStr2(sql, "SELECT MIN(PARAM1) FROM RCV_NONPAY_REQYM", 7, szPLAN_REQ1 );
			
			if( Str_Len(szPLAN_REQ1) == 0 )
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ2+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );
				
			}
			else
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ1+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ1+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );				
			}
			
			Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , m_stPayInfo.USE_CONT_NUM );
			Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "1");
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
			JSON_SetValue	(m_hBody	, 'C', "pmChargedate1"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
			JSON_SetValue	(m_hBody	, 'C', "pmCost1"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
			JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate1"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
			lAllAmt = Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			i++;
			if(m_lPlanCnt == 2)
			{
				Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , m_stPayInfo.USE_CONT_NUM );
				Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "2");
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_REQ, " " );
				Str_ItoA(lDeptAmt, m_stPayPlan[i].PROMISE_PLAN_AMT, 10); //법적기타금액
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
				JSON_SetValue	(m_hBody	, 'C', "pmChargedate2"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
				JSON_SetValue	(m_hBody	, 'C', "pmCost2"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
				JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate2"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
				lAllAmt += Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			}
		
			Mem_Set((byte*)szAllAmt, 0x00, sizeof(szAllAmt));
			Str_ItoA(lAllAmt, szAllAmt, 10);
			JSON_SetValue	(m_hBody	, 'C', "pmTotal"			, szAllAmt);//총금액
			Str_Cpy(m_stPayInfo.PROMISE_TOT_AMT, szAllAmt);
			//바디 - 본인은 귀사로부터 도시가스를 공급받아 ~ 확약서를 작성 제출합니다.
			JSON_SetValue	(m_hBody	, 'C', "pmGascost"			, m_stPayInfo.PROMISE_TOT_AMT);

			//바디 - 납부확약고객
			//납부확약고객 주소조합 화면 설계 필요.
        	Str_Cpy(m_stPayInfo.ADDR_UNION, m_stPayInfo.ADDR);
        	Str_Cat(m_stPayInfo.ADDR_UNION, " ");
        	Str_Cat(m_stPayInfo.ADDR_UNION, m_stPayInfo.SECOND_ADDR);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyaddr"		, m_stPayInfo.ADDR_UNION);
			
			JSON_SetValue	(m_hBody	, 'C', "pmSuretycorpname"	, m_stPayInfo.FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyvatno"		, m_stPayInfo.BIZ_REGI_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyjumin"		, m_stPayInfo.SOC_NUM);

			//전화번호 콤보박스
			//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			//SPRINT(szTmp," CODE_ID = 'A10110' ORDER BY SORT_ORDER ",0,0,0);
			//JSON_SetValue	(m_hBody	, 'C', "pmSuretytelcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));
			
			if( Str_Len(m_stPayInfo.CP_EXN) > 2)
			{
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.CP_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.CP_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.CP_NUM);
			}
			else
			{
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.OWNHOUSE_TEL_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.OWNHOUSE_TEL_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.OWNHOUSE_TEL_NUM);
			}
			JSON_SetValue	(m_hBody	, 'C', "pmUsename"		, m_stPayInfo.USE_CUST_NM);
		}
		else if( Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "20") == 0 )
		{
			//계약서 작성형태 > 1(연대납부확약서), 2(연대납부확약서+이사정산)
			//1 >> 납부일자 수정 불가 / 사진 촬영 가능
			//2 >> 납부일자 수정 가능 / 사진 촬영 불가
			//3 >> 납부일자 수정 가능 / 사진 촬영 가능
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "3");
			
			//바디 - 사용고객정보
			JSON_SetValue	(m_hBody	, 'C', "pmUsecontnum"		, m_stPayInfo.USE_CONT_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmCorpname"			, m_stPayInfo.USE_FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmVatno"			, m_stPayInfo.USE_BIZ_REGI_NUM);

			if( Str_Len(m_stPayInfo.NEW_ADDR_UNION) > 5 )
			{
				//기본 도로명주소 입력
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			, m_stPayInfo.USE_NEW_ADDR_UNION);
			}
			else
			{
				//도로명주소 없을 시 지번주소 입력
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			, m_stPayInfo.USE_CURR_ADDR_UNION);
			}
			JSON_SetValue	(m_hBody	, 'C', "pmName"			    , m_stPayInfo.USE_CUST_NM);
			
			Mem_Set((byte*)szUseHpNum, 0x00, sizeof(szUseHpNum));	
			//SPRINT(szUseHpNum, "%s-%s-%s", m_stPayInfo.USE_CP_DDD, m_stPayInfo.USE_CP_EXN, m_stPayInfo.USE_CP_NUM);			
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stPayInfo.USE_CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stPayInfo.USE_CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stPayInfo.USE_CP_NUM);
			
			Mem_Set((byte*)szUseTelNum, 0x00, sizeof(szUseTelNum));	
			//SPRINT(szUseTelNum, "%s-%s-%s", m_stPayInfo.USE_OWNHOUSE_TEL_DDD, m_stPayInfo.USE_OWNHOUSE_TEL_EXN, m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stPayInfo.USE_OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stPayInfo.USE_OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			
			//바디 - 도시가스 미납내역 및 상환(납부이행) 계획 , m_lPlanCnt
			//법적 및 기타
			g_Sql_RetStr2(sql, "SELECT PARAM12 FROM RCV_NONPAY_REQYM", 50, szTmp);
			lAllAmt = 0;
			if( Str_AtoI( szTmp ) > 0 )
			{
				m_lPlanCnt = 2;
			}
			else
			{
				m_lPlanCnt = 1;
			}
			
			nonpay = 0;
			lDeptAmt = 0;
			//총 월별미납금액
			g_Sql_RetInt2(sql, "SELECT SUM(PARAM4) FROM RCV_NONPAY_REQYM", &nonpay );
			//대손미납금
			g_Sql_RetInt2(sql, "SELECT PARAM14 FROM RCV_NONPAY_REQYM", &lDeptAmt );
			
			i = 0;
			nAmt = 0;
			nAmt = nonpay+lDeptAmt;   //총 월별미납금액+대손미납금
			Str_ItoA( nAmt, m_stPayPlan[i].PROMISE_PLAN_AMT,10   );
			
			Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
			g_Sql_RetStr2(sql, "SELECT MIN(PARAM1) FROM RCV_NONPAY_REQYM", 7, szPLAN_REQ2 );
			if( Str_Len(szPLAN_REQ2) == 0 )
			{
				Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
				g_Sql_RetStr2(sql, "SELECT MAX(PARAM1) FROM RCV_NONPAY_REQYM", 7, szPLAN_REQ2 );
			}
			
			Mem_Set( (byte*)szPLAN_REQ1, 0x00, sizeof(szPLAN_REQ1) );
			g_Sql_RetStr2(sql, "SELECT MIN(PARAM1) FROM RCV_NONPAY_REQYM", 7, szPLAN_REQ1 );
			
			if( Str_Len(szPLAN_REQ1) == 0 )
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ2+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );
				
			}
			else
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ1+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ1+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );				
			}
			
			Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , m_stPayInfo.USE_CONT_NUM );
			Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "1");
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
			JSON_SetValue	(m_hBody	, 'C', "pmChargedate1"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
			JSON_SetValue	(m_hBody	, 'C', "pmCost1"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
			JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate1"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
			lAllAmt = Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			i++;
			if(m_lPlanCnt == 2)
			{
				Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , m_stPayInfo.USE_CONT_NUM );
				Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "2");
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_REQ, " " );
				Str_ItoA(lDeptAmt, m_stPayPlan[i].PROMISE_PLAN_AMT, 10); //법적기타금액
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
				JSON_SetValue	(m_hBody	, 'C', "pmChargedate2"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
				JSON_SetValue	(m_hBody	, 'C', "pmCost2"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
				JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate2"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
				lAllAmt += Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			}
		
			Mem_Set((byte*)szAllAmt, 0x00, sizeof(szAllAmt));
			Str_ItoA(lAllAmt, szAllAmt, 10);
			JSON_SetValue	(m_hBody	, 'C', "pmTotal"			, szAllAmt);//총금액
			Str_Cpy(m_stPayInfo.PROMISE_TOT_AMT, szAllAmt);
			//바디 - 본인은 귀사로부터 도시가스를 공급받아 ~ 확약서를 작성 제출합니다.
			JSON_SetValue	(m_hBody	, 'C', "pmGascost"			, m_stPayInfo.PROMISE_TOT_AMT);
			//바디 - 납부확약고객
			//납부확약고객 주소조합 화면 설계 필요.
        	Str_Cpy(m_stPayInfo.ADDR_UNION, m_stPayInfo.ADDR);
        	Str_Cat(m_stPayInfo.ADDR_UNION, " ");
        	Str_Cat(m_stPayInfo.ADDR_UNION, m_stPayInfo.SECOND_ADDR);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyaddr"		, m_stPayInfo.ADDR_UNION);
			
			JSON_SetValue	(m_hBody	, 'C', "pmSuretycorpname"	, m_stPayInfo.FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyvatno"		, m_stPayInfo.BIZ_REGI_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyjumin"		, m_stPayInfo.SOC_NUM);

			//전화번호 콤보박스
			//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			//SPRINT(szTmp," CODE_ID = 'A10110' ORDER BY SORT_ORDER ",0,0,0);
			//JSON_SetValue	(m_hBody	, 'C', "pmSuretytelcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));

			if( Str_Len(m_stPayInfo.CP_EXN) > 2)
			{
				//SPRINT(szTemlNum, "%s-%s-%s", m_stPayInfo.CP_DDD, m_stPayInfo.CP_EXN, m_stPayInfo.CP_NUM);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.CP_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.CP_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.CP_NUM);
			}
			else
			{
				//SPRINT(szTemlNum, "%s-%s-%s", m_stPayInfo.OWNHOUSE_TEL_DDD, m_stPayInfo.OWNHOUSE_TEL_EXN, m_stPayInfo.OWNHOUSE_TEL_NUM);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.OWNHOUSE_TEL_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.OWNHOUSE_TEL_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.OWNHOUSE_TEL_NUM);
			}
			
			JSON_SetValue	(m_hBody	, 'C', "pmUsename"		, m_stPayInfo.USE_CUST_NM);
		}
	}

	//------------------------------------------------------------------
	//오즈 데이터 저장
	void Rcv_OzData(char* szOzData)
	{
	char szTmp[500];
	char szBuf[256];
	char szFolderNm[128];
	char szFileNm[256];
	char szCopyNm[256];
	char szCopyPath[256];
	long fd, i = 0, j = 0, k = 0;
	long lFileLen = 0;
	long lAddrLen = 0;
	long lRet = 0;
	char *szitem;
	char *szPath;
	char *szData;
	char *szAddrMode;
	char *szAddrSeq;
	long *nCol;
	long nCnt = 0;
	char szType[2] = {0,0};
	long ret = 0;
	handle hItem = NULL;
	handle hPath = NULL;
	handle hData = NULL;
	handle hAddrMode = NULL;
	handle hAddrSeq = NULL;

		Mem_Set((byte*)&m_stOzData, 0x00, sizeof(m_stOzData));
		
		hItem = JSON_Create( JSON_Object );
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szOzData ) ;
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, JSON_GetValue (hItem, "ret_action",    szType));

			if( Str_Cmp(szTmp, "btnSave") == 0 )
			{
				//작성내용 저장 버튼 선택 , btnSave
			
				//입력 정보
				szData = JSON_GetValue (hItem, "ret_data",    szType);

				hData = JSON_Create( JSON_Object );
				if( hData != NULL )
				{
					JSON_toJson( hData, szData ) ;
	
					Str_Cpy(m_stOzData.PROMISE_TYPE_GB   , m_stPayInfo.PROMISE_TYPE_GB);
					Str_Cpy(m_stOzData.USE_CONT_NUM      , JSON_GetValue (hData, "pmUsecontnum",    szType));
					Str_Chg(m_stOzData.USE_CONT_NUM, STRCHG_DEL_NONDIGIT );
					Str_Cpy(m_stOzData.PROMISE_ASSIGN_SEQ, m_stPayInfo.PROMISE_ASSIGN_SEQ);
					Str_Cpy(m_stOzData.SEQ               , m_stPayInfo.SEQ);

					//입력 주소 형태(지번,도로명,수기)
					//ADDR_GB = 'N ' 수기 X | 'Y' 수기 O
					//ADDR_TYPE = 'Z' 지번 | 'R' 도로명
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy(szTmp           , JSON_GetValue (hData, "pmSuretyaddr", szType));
					if( Str_Cmp(szTmp, m_stPayInfo.ADDR_UNION) == 0 )
					{

						if( Str_Cmp(m_stPayInfo.ADDR_GB, "N") == 0 )
						{
							Str_Cpy(m_stOzData.ADDR_GB, "N");

							if( Str_Cmp(m_stPayInfo.ADDR_TYPE, "Z") == 0 )
							{
								Str_Cpy(m_stOzData.ADDR_TYPE, m_stPayInfo.ADDR_TYPE);
								Str_Cpy(m_stOzData.ZIP_SEQ           , m_stPayInfo.ZIP_SEQ);
								Str_Cpy(m_stOzData.ADDR_UNION        , m_stPayInfo.ADDR);
								Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
								Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
								Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
								Str_Cpy(m_stOzData.SECOND_ADDR       , m_stPayInfo.SECOND_ADDR);
							}
							else
							{
								Str_Cpy(m_stOzData.ADDR_TYPE, m_stPayInfo.ADDR_TYPE);
								Str_Cpy(m_stOzData.ZIP_SEQ           , "");
								Str_Cpy(m_stOzData.ADDR_UNION        , "");
								Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , m_stPayInfo.NEW_ADDR_BLD_SEQ);
								Str_Cpy(m_stOzData.NEW_ADDR_UNION    , m_stPayInfo.ADDR);
								Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
								Str_Cpy(m_stOzData.SECOND_ADDR       , m_stPayInfo.SECOND_ADDR);
							}
						}
						else
						{
							Str_Cpy(m_stOzData.ADDR_GB, "Y");
							Str_Cpy(m_stOzData.ADDR_TYPE, "R");

							Str_Cpy(m_stOzData.ZIP_SEQ           , "");
							Str_Cpy(m_stOzData.ADDR_UNION        , "");
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
							Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , m_stPayInfo.ADDR);
							Str_Cpy(m_stOzData.SECOND_ADDR       , m_stPayInfo.SECOND_ADDR);
						}

					}
					else
					{

						szAddrMode = JSON_GetValue (hItem, "ret_addr_mode",    szType);
						szAddrSeq = JSON_GetValue (hItem, "ret_zip_seq",    szType);				
						if( Str_Cmp(szAddrMode, "Z") == 0 )
						{
							Str_Cpy(m_stOzData.ADDR_GB, "N");
							Str_Cpy(m_stOzData.ADDR_TYPE, "Z");
							
							Str_Cpy(m_stOzData.ZIP_SEQ           , szAddrSeq);
							
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
							Str_Cpy(szTmp, JSON_GetValue (hItem, "ret_addr_1",    szType));
							if(Str_Len(szTmp) > 7)
							{
								Mem_Cpy((byte *)m_stOzData.ADDR_UNION, (byte *)szTmp+7, Str_Len(szTmp)-7);
							}
							else
							{
								Str_Cpy(m_stOzData.ADDR_UNION, szTmp);
							}
							
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
							Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
							Str_Cpy(m_stOzData.SECOND_ADDR       , JSON_GetValue (hItem, "ret_addr_2",    szType));

						}
						else if( Str_Cmp(szAddrMode, "R") == 0 )
						{

							Str_Cpy(m_stOzData.ADDR_GB, "N");
							Str_Cpy(m_stOzData.ADDR_TYPE, "R");
		
							Str_Cpy(m_stOzData.ZIP_SEQ           , "");
							Str_Cpy(m_stOzData.ADDR_UNION        , "");
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , szAddrSeq);
							
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
							Str_Cpy(szTmp, JSON_GetValue (hItem, "ret_addr_1",    szType));
							if(Str_Len(szTmp) > 6)
							{
								Mem_Cpy((byte *)m_stOzData.NEW_ADDR_UNION, (byte *)szTmp+6, Str_Len(szTmp)-6);
							}
							else
							{
								Str_Cpy(m_stOzData.ADDR_UNION, szTmp);
							}
							
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
							Str_Cpy(m_stOzData.SECOND_ADDR       , JSON_GetValue (hItem, "ret_addr_2",    szType));

						}
						else
						{
							Str_Cpy(m_stOzData.ADDR_GB, "Y");
							Str_Cpy(m_stOzData.ADDR_TYPE, "R");
		
							Str_Cpy(m_stOzData.ZIP_SEQ           , "");
							Str_Cpy(m_stOzData.ADDR_UNION        , "");
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
							Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , JSON_GetValue (hItem, "ret_addr_1",    szType));
							Str_Cpy(m_stOzData.SECOND_ADDR       , JSON_GetValue (hItem, "ret_addr_2",    szType));
							
						}
					}

					Str_Cpy(m_stOzData.FIRM_NM           , JSON_GetValue (hData, "pmSuretycorpname", szType));
					
					Str_Cpy(m_stOzData.BIZ_REGI_NUM      , JSON_GetValue (hData, "pmSuretyvatno",    szType));
					Str_Chg(m_stOzData.BIZ_REGI_NUM, STRCHG_DEL_NONDIGIT);

					Str_Cpy(m_stOzData.SOC_NUM           , JSON_GetValue (hData, "pmSuretyjumin",    szType));
					Str_Chg(m_stOzData.SOC_NUM, STRCHG_DEL_NONDIGIT);
					
					Str_Cpy(m_stOzData.CP_DDD            , JSON_GetValue (hData, "pmSuretytel1",     szType));
					Str_Cpy(m_stOzData.CP_EXN            , JSON_GetValue (hData, "pmSuretytel2",     szType));
					Str_Cpy(m_stOzData.CP_NUM            , JSON_GetValue (hData, "pmSuretytel3",     szType));
					Str_Cpy(m_stOzData.CUST_NM           , JSON_GetValue (hData, "pmSuretyname",     szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN , JSON_GetValue (hData, "pmAgreetitle1",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN2, JSON_GetValue (hData, "pmAgreetitle2",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN3, JSON_GetValue (hData, "pmAgreetitle3",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN4, JSON_GetValue (hData, "pmAgreetitle4",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN5, JSON_GetValue (hData, "pmAgreetitle5",   szType));

					Str_Cpy(m_stOzData.PROMISE_TOT_AMT   , JSON_GetValue (hData, "pmTotal",   szType));
					Str_Chg(m_stOzData.PROMISE_TOT_AMT,  STRCHG_DEL_NONDIGIT );
					
					Str_Cpy(m_stPayPlan[0].PROMISE_PLAN_YMD, JSON_GetValue (hData, "pmPaybackdate1",   szType));
					Str_Chg(m_stPayPlan[0].PROMISE_PLAN_YMD,  STRCHG_DEL_NONDIGIT );

					if(m_lPlanCnt == 2)
					{
						Str_Cpy(m_stPayPlan[1].PROMISE_PLAN_YMD, JSON_GetValue (hData, "pmPaybackdate2",   szType));
						Str_Chg(m_stPayPlan[1].PROMISE_PLAN_YMD,  STRCHG_DEL_NONDIGIT );
					}
				}
				
				//PDF 경로
				szPath = JSON_GetValue (hItem, "pdf_path",    szType);
				hPath = JSON_Create( JSON_Object );
				if( hPath != NULL )
				{
					//OZ 파일(PDF) 을 Smart폴더 안의 폴더에 복사
					JSON_toJson( hPath, szPath ) ;
		
					j = 0;
					k = 0;
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Mem_Set((byte*)szFolderNm, 0x00, sizeof(szFolderNm));
					Mem_Set((byte*)szCopyNm, 0x00, sizeof(szCopyNm));
					
					Str_Cpy(szTmp, JSON_GetValue (hPath, "Path",    szType));
					lFileLen = Str_Len(szTmp);
					if( lFileLen > 0 )
					{
						for( i=0 ; lFileLen ; i++)
						{
							if(szTmp[i] == '0')
							{
								j = i;
								break;
							}
							else
							{
								k++;
							}
						}
						
						//Mem_Cpy((byte *)m_stOzData.ZIP_SEQ, (byte *)szTmp, j);
						Mem_Cpy((byte *)szFolderNm, (byte *)szTmp+(j+9), 17);
						Mem_Cpy((byte *)szCopyNm, (byte *)szTmp+(j+9), 14);
					}

					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
					Str_Cpy(szBuf, "../LCTECH/");
					Str_Cat(szBuf, szFolderNm);
					if( FFS_Exist(szBuf) )
					{
						lRet = g_FindFiles( szBuf, "*.Enc" , szFileNm);
						if( lRet > 0 )
						{
							SPRINT (m_stOzData.PDFPATH, "OZ_FILE/%s_%s_.pdf.Enc",  szCopyNm, m_stOzData.USE_CONT_NUM, 0);
							FFS_Copy(szFileNm, m_stOzData.PDFPATH);

							//데이터 옮긴 후 LCTECH 폴더 클리어(남은 oz파일 삭제)
							FFS_Delete(szFileNm);
						}

						Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
						lRet = g_FindFiles( szBuf, "*.pdf" , szFileNm);
						if( lRet > 0 )
						{
							//데이터 옮긴 후 LCTECH 폴더 클리어(남은 oz파일 삭제)
							FFS_Delete(szFileNm);
						}
					}
				}
			}
			else
			{
				//작성취소 버튼 선택
				
				if(hItem != NULL)
				{
					JSON_Finalize(hItem);
					hItem = NULL;
				}
				
				if(hPath != NULL)
				{
					JSON_Finalize(hPath);
					hPath = NULL;
				}
				
				if(hData != NULL)
				{
					JSON_Finalize(hData);
					hData = NULL;
				}
		
				g_Close_SubDlg();
				
				return;
			}
		}


		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
		
		if(hPath != NULL)
		{
			JSON_Finalize(hPath);
			hPath = NULL;
		}
		
		if(hData != NULL)
		{
			JSON_Finalize(hData);
			hData = NULL;
		}

		g_Close_SubDlg();

		//오즈 데이터 송신
		Snd_OzView();
		
		ON_DRAW();
		return;
	}

	//------------------------------------------------------------------
	long Snd_OzView(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		char* szfile;
		char* filedata;
		long nRet, filesize, fd;
		handle file;		
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}

		g_SeverConnection();
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822558, FALSE);

        JSON_SetValue( g_pjcomm, 'C', "promise_type_gb",        m_stOzData.PROMISE_TYPE_GB   );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",           m_stOzData.USE_CONT_NUM      );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",     m_stOzData.PROMISE_ASSIGN_SEQ);
		JSON_SetValue( g_pjcomm, 'C', "seq",                    m_stOzData.SEQ               );
		JSON_SetValue( g_pjcomm, 'C', "addr_gb",                m_stOzData.ADDR_GB           );
		JSON_SetValue( g_pjcomm, 'C', "addr_type",              m_stOzData.ADDR_TYPE         );
		JSON_SetValue( g_pjcomm, 'C', "zip_seq",                m_stOzData.ZIP_SEQ           );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "addr_union",             szTmp                        );
		
		JSON_SetValue( g_pjcomm, 'C', "new_addr_bld_seq",       m_stOzData.NEW_ADDR_BLD_SEQ  );

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.NEW_ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_union",         szTmp                        );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.LOT_NUM_UNION );
		JSON_SetValue( g_pjcomm, 'C', "lot_num_union",          szTmp                        );

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.SECOND_ADDR );
		JSON_SetValue( g_pjcomm, 'C', "second_addr",            szTmp                        );

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.FIRM_NM );
		JSON_SetValue( g_pjcomm, 'C', "firm_nm",                szTmp                        );

		JSON_SetValue( g_pjcomm, 'C', "biz_regi_num",           m_stOzData.BIZ_REGI_NUM      );
		JSON_SetValue( g_pjcomm, 'C', "soc_num",                m_stOzData.SOC_NUM           );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",                 m_stOzData.CP_DDD            );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",                 m_stOzData.CP_EXN            );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",                 m_stOzData.CP_NUM            );
		
		//업데이트 여부 미정
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",                szTmp                        );		
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn",      m_stOzData.INFO_USE_AGREE_YN );
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn2",     m_stOzData.INFO_USE_AGREE_YN2);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn3",     m_stOzData.INFO_USE_AGREE_YN3);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn4",     m_stOzData.INFO_USE_AGREE_YN4);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn5",     m_stOzData.INFO_USE_AGREE_YN5);
		//체납과 다름.
		JSON_SetValue( g_pjcomm, 'C', "promise_tot_amt",        m_stOzData.PROMISE_TOT_AMT   );
		
		filesize = FFS_GetSize( m_stOzData.PDFPATH );
		filedata = Mem_Alloc(filesize);
		
		fd = FFS_Open(m_stOzData.PDFPATH, FS_READ_MODE, FS_NORMAL_FLAG );
		FFS_Read ( fd, (byte*)filedata, filesize );
		FFS_Close(fd);

		file = BASE64_Create();
		BASE64_Encode(file, filedata, filesize );
		szfile = BASE64_GetResult(file);	
		
		JSON_SetValue( g_pjcomm, 'C', "oz_file",  szfile );

		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR822558; //통신완료 후에 호출 함수
		HTTP_DownloadData( szUrl, "FR822558_IN",  "FR822558" , sndbuf, szbuf );
		return 1;
	}
	
	//------------------------------------------------------------------
	long TR822558(void)
	{
	long ret = -1;
	
		if(g_Chk_Json(822558) >= 0)
		{
			Snd_Promiseplan();
			ret = 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
		}
		return ret;
	}
	
	//------------------------------------------------------------------
	long Snd_Promiseplan(void)
	{
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	handle js = NULL;
	long i;
	long ret;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66804, FALSE);
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		i = 0;
		JSON_AddArrayItem(js);
		JSON_SetArrayItem(js, 'C',  "use_cont_num",     m_stPayPlan[i].USE_CONT_NUM );
		JSON_SetArrayItem(js, 'C',  "seq",              m_stPayPlan[i].SEQ );
		JSON_SetArrayItem(js, 'C',  "promise_plan_seq", m_stPayPlan[i].PROMISE_PLAN_SEQ );
		JSON_SetArrayItem(js, 'C',  "promise_plan_req", m_stPayPlan[i].PROMISE_PLAN_REQ );
		JSON_SetArrayItem(js, 'C',  "promise_plan_amt", m_stPayPlan[i].PROMISE_PLAN_AMT );
		JSON_SetArrayItem(js, 'C',  "promise_plan_ymd", m_stPayPlan[i].PROMISE_PLAN_YMD );
		JSON_SetArrayItem(js, 'C',  "promise_plan_amt_type", "U" );
		
		if( m_lPlanCnt == 2 )
		{
			i++;
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C',  "use_cont_num",     m_stPayPlan[i].USE_CONT_NUM );
			JSON_SetArrayItem(js, 'C',  "seq",              m_stPayPlan[i].SEQ );
			JSON_SetArrayItem(js, 'C',  "promise_plan_seq", m_stPayPlan[i].PROMISE_PLAN_SEQ );
			JSON_SetArrayItem(js, 'C',  "promise_plan_req", m_stPayPlan[i].PROMISE_PLAN_REQ );
			JSON_SetArrayItem(js, 'C',  "promise_plan_amt", m_stPayPlan[i].PROMISE_PLAN_AMT );
			JSON_SetArrayItem(js, 'C',  "promise_plan_ymd", m_stPayPlan[i].PROMISE_PLAN_YMD );
			JSON_SetArrayItem(js, 'C',  "promise_plan_amt_type", "L" );
		}	
		
		JSON_Attach(g_pjcomm, "item", js);	
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		g_SeverConnection();
		
		callBackfunc = TR66804; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR66804_IN",  "FR66804" , sndbuf, szbuf );
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return ret;
			
	}
	
	//------------------------------------------------------------------
	long TR66804(void)
	{
	long ret = -1;
	char szSql[256];
	
		g_Sock_Close();
		
		if(g_Chk_Json(66804) >= 0)
		{
			//암호화 pdf 삭제
			if( FFS_Exist(m_stOzData.PDFPATH) )
			{
				FFS_Delete(m_stOzData.PDFPATH);
			}
			
			//g_lNpChkFlag = 1;
			
			//g_nWorkFlag = 830 > 중지활동
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			if( g_nWorkFlag == 830 )
			{
				SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET VISIT_FLAG = 'Y', PAYCONFIRM_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else if( g_nWorkFlag == 810 )
			{
				//개별활동 대상
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET VISIT_FLAG = 'Y', PAYCONFIRM_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else
			{
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET VISIT_FLAG = 'Y', PAYCONFIRM_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			
			Str_Cpy(stNoPayObj.VISIT_FLAG, "Y");
			Str_Cpy(stNoPayObj.PAYCONFIRM_FLAG, "Y");		//납부확약서 발행 여부 플래그
			
			MessageBoxEx (CONFIRM_OK, "납부확약서 저장에 성공하였습니다.");
			
			//Rcv_BackVirtAccount();
			
			ON_DRAW();
			return 1;
		}
		else
		{
		}
		
		CloseMessageBox();
		
		ON_DRAW();
		return ret;
	}

	//------------------------------------------------------------------
	long Rcv_BackVirtAccount(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82211, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82211_1; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR82211_IN",  "FR82211" , sndbuf, sztmp );		
		return 0 ;
	}
	
	//------------------------------------------------------------------
	long TR82211_1(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82211) >= 0)
		{
			Print_PlanPay();
			
			CloseMessageBox();
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	//------------------------------------------------------------------
	void Print_PlanPay(void)
	{
		if( g_IsCardReader() )
		{
			return;
		}
		
		if (m_bPrintAgain == FALSE)
		{
			callBackfunc = NULL;
			
			m_pList = Print_PlanPay_GetData();
		}
		
		g_Printer_Start(m_pList, (void*)Print_Result);
		
		m_nPayFlag = PRINT_PAY_PLAN;
	}

	//------------------------------------------------------------------
	void* Print_PlanPay_GetData(void)
	{
		long ret, idx, row;
		char LineSpace[]={0x1b,0x20,0x00};
		char szBuf[300];
		char szMsg[300];
		char sztmp[300];
		char szBillPreiod[300];
		char szFirstNm[32];
		char szLastNm[32];
		char szMtrNum[32];
		char szLeft[50];
		char szCenter[50];
		char szRight[50];
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

		list->append(list, "--------------------------------");
		list->append(list, "        미납요금  확약서        ");
		list->append(list, "--------------------------------");
		
		if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
		{
			list->append(list, "--------------------------------");
		}
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, "지번주소 : ");
		Str_Cat(sztmp, stNoPayObj.CITY);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stNoPayObj.AREA);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stNoPayObj.TOWN);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stNoPayObj.VILLAGE);
		
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
		
		if( Str_Len(stNoPayObj.VILLAGE) > 0 || Str_Len(stNoPayObj.BLD_NM) > 0 )
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stNoPayObj.VILLAGE);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.BLD_NM);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.HOSU);
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
			Str_Cat(sztmp, stNoPayObj.ADDR1_M);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.ADDR1_S);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.HOSU);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
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
		
		if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
		{
			list->append(list, "--------------------------------");
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "도로명주소 : ");
			Str_Cat(sztmp, stNoPayObj.CITY);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stNoPayObj.AREA );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M );
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
		}
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy( sztmp, "상    호 : ");
		Str_Cat( sztmp, stNoPayObj.FIRM_NM );
		g_Line_Print(list, sztmp,"","",LEFT,0);
			
		if( Str_Len(stNoPayObj.CUST_NM) < 6 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
			Str_Cpy(szBuf, "성    명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");
			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stNoPayObj.CUST_NM) > 4 && Str_Len(stNoPayObj.CUST_NM) < 8)
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+4, 2);
			Str_Cpy(szBuf, "성    명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stNoPayObj.CUST_NM) > 6 && Str_Len(stNoPayObj.CUST_NM) < 10 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+6, 2);
			Str_Cpy(szBuf, "성    명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);
			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stNoPayObj.CUST_NM) > 8 && Str_Len(stNoPayObj.CUST_NM) < 12 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+8, 2);
			Str_Cpy(szBuf, "성    명 : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);
			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Str_Cpy(sztmp, "핸 드 폰 : ");
		if( Str_Len(stNoPayObj.CP_DDD)+Str_Len(stNoPayObj.CP_EXN)+Str_Len(stNoPayObj.CP_NUM) < 11  )
		{
			Str_Cpy( szBuf, stNoPayObj.CP_DDD );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.CP_EXN );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.CP_NUM );
			szBuf[5] = '*';
			szBuf[6] = '*';
			szBuf[9] = '*';
			szBuf[10] = '*';
			//123-4**-78**
		}
		else if( Str_Len(stNoPayObj.CP_DDD)+Str_Len(stNoPayObj.CP_EXN)+Str_Len(stNoPayObj.CP_NUM) > 10  )
		{
			Str_Cpy( szBuf, stNoPayObj.CP_DDD );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.CP_EXN );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.CP_NUM );
			szBuf[6] = '*';
			szBuf[7] = '*';
			szBuf[11] = '*';
			szBuf[12] = '*';
			//123-45**-89**
		}
		else if( Str_Len(stNoPayObj.CP_DDD)+Str_Len(stNoPayObj.CP_EXN)+Str_Len(stNoPayObj.CP_NUM) < 10  )
		{
			Str_Cpy( szBuf, "-" );
		}
		Str_Cat(sztmp, szBuf);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "자택전화 : ");
		if( Str_Len(stNoPayObj.OWNHOUSE_TEL_DDD)+Str_Len(stNoPayObj.OWNHOUSE_TEL_EXN)+Str_Len(stNoPayObj.OWNHOUSE_TEL_NUM) < 10  )
		{
			Str_Cpy( szBuf, stNoPayObj.OWNHOUSE_TEL_DDD );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.OWNHOUSE_TEL_EXN );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.OWNHOUSE_TEL_NUM );
			szBuf[5] = '*';
			szBuf[6] = '*';
			szBuf[9] = '*';
			szBuf[10] = '*';
			//123-4**-78**
		}
		else if( Str_Len(stNoPayObj.OWNHOUSE_TEL_DDD)+Str_Len(stNoPayObj.OWNHOUSE_TEL_EXN)+Str_Len(stNoPayObj.OWNHOUSE_TEL_NUM) > 10  )
		{
			Str_Cpy( szBuf, stNoPayObj.OWNHOUSE_TEL_DDD );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.OWNHOUSE_TEL_EXN );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stNoPayObj.OWNHOUSE_TEL_NUM );
			szBuf[6] = '*';
			szBuf[7] = '*';
			szBuf[11] = '*';
			szBuf[12] = '*';
			//123-45**-89**
		}
		else if( Str_Len(stNoPayObj.OWNHOUSE_TEL_DDD)+Str_Len(stNoPayObj.OWNHOUSE_TEL_EXN)+Str_Len(stNoPayObj.OWNHOUSE_TEL_NUM) < 10  )
		{
			Str_Cpy( szBuf, "-" );
		}
		Str_Cat(sztmp, szBuf);
		g_Line_Print(list, sztmp,"","",LEFT,0);	
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.CUST_NUM , 5);
		Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.CUST_NUM +5, 5);
		Str_Cpy(sztmp, "고객번호 : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "-");
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM , 5);
		Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.USE_CONT_NUM +5, 5);
		Str_Cpy(sztmp, "계약번호 : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "-");
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy(sztmp, "사용계약해지일자 : ");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		g_Str_DateType( szMsg, szBuf);
		Str_Cat(sztmp, szMsg );
		g_Line_Print(list, sztmp,"","",LEFT,0);			

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "철거지침 : ");
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		SPRINT(szBuf, "SELECT INDI_COMPENS_THIS_MM_VC FROM RCV_NONPAY_MTRREQYM  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szBuf, 9 , szMsg );			
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "검침일/납기 : ");
		Str_Cat(sztmp, stMw.szGmtr_base_day);
		Str_Cat(sztmp, "일/");
		Str_Cat(sztmp, stMw.szDeadline_flag);
		Str_Cat(sztmp, "납기");
		g_Line_Print(list, sztmp,"","",LEFT,0);	
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Str_Cpy(sztmp, "1. 본인은 귀사로부터 도시가스를 공급받아 사용중 ");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		Mem_Cpy( (byte*)szMsg, (byte*)szBuf, 4 );
		Str_Cat(szMsg, "년 " );
		Mem_Cpy( (byte*)szMsg+7, (byte*)szBuf+4, 2 );
		Str_Cat(szMsg, "월 " );
		Mem_Cpy( (byte*)szMsg+12, (byte*)szBuf+6, 2 );
		Str_Cat(szMsg, "일 현재 " );
		Str_Cat(sztmp, szMsg);
		Str_Cat(sztmp, "상기 주소지에서 전출함에 있어 미납 도시가스 요금 ");
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy(szMsg, m_stOzData.PROMISE_TOT_AMT );
		Str_Chg(szMsg, STRCHG_INS_COMMA);
		Str_Cat(szMsg, "원을 " );
		Str_Cat(sztmp, szMsg);
		list->append(list, sztmp);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Cpy( (byte*)szMsg, (byte*)m_stPayPlan[0].PROMISE_PLAN_YMD, 4 );
		Str_Cat(szMsg, "년 " );
		Mem_Cpy( (byte*)szMsg+7, (byte*)m_stPayPlan[0].PROMISE_PLAN_YMD+4, 2 );
		Str_Cat(szMsg, "월 " );
		Mem_Cpy( (byte*)szMsg+12, (byte*)m_stPayPlan[0].PROMISE_PLAN_YMD+6, 2 );
		Str_Cat(szMsg, "일 까지 납부 할 것을 확약합니다.\n" );
		Str_Cat(sztmp, szMsg);
		list->append(list, sztmp);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cat(sztmp, "2. 만약 본 납부이행확약을 미이행 할 경우 신용조회 및 채무불이행등록, ");
		Str_Cat(sztmp, "채권추심기관을 통한 채권추심에 동의하며, 아울러 어떠한 법적조치를 취하여도 ");
		Str_Cat(sztmp, "민,형사상 이의를 제기하지 않을 것을 확약합니다. \n");
		list->append(list, sztmp);	
		
		list->append(list, "--------------------------------");
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy(sztmp, "▶미납내역(");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		g_Str_DateType( szMsg, szBuf);
		Str_Cat(sztmp, szMsg );
		Str_Cat(sztmp, " 기준)" );
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "--------------------------------");
		list->append(list, "납  기    사용기간      미납금액");
			
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
				goto Finally;
			}
		
			hstmt = sql->CreateStatement(sql, "select MTR_NUM, CHK_YN, REQ_YM, USE_PERIOD_STR, USE_PERIOD_END, ACCOUNT  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
			row = 1;
			sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
				sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				sql->GetValue(sql, idx++, 'U', (long*)sztmp ,1+1, DECRYPT);
				if(sztmp[0] == '0')
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 8 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5 );
					Str_Cat(szBillPreiod, "∼" );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5 );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					nonpayamt +=  Str_AtoI( szBuf );
					Str_Chg( szBuf, STRCHG_INS_COMMA);
					Str_Cat(szBuf, "원" );

					g_Line_Print(list, szBillPreiod, "", szBuf, RIGHT, 0);
				}
			};
			
	Finally:
			DelSqLite(sql);
			
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally2;
			}
		
			hstmt = sql->CreateStatement(sql, "select CHK, REQ_YM, USE_PERIOD_STR, USE_PERIOD_END, UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally2;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally2;
			}

			while( sql->Next(sql) == TRUE )
			{
				idx = 0;
				
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
				if(szBuf[0] == '0' )//월별미납 수납으로 표시
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 8 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5 );
					Str_Cat(szBillPreiod, "∼" );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5);
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					nonpayamt +=  Str_AtoI( szBuf );
					Str_Chg( szBuf, STRCHG_INS_COMMA);
					Str_Cat( szBuf, "원" );
					
					//g_Line_Print(list, szBillPreiod,"",szBuf,LEFT,0);
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally2:

			DelSqLite(sql);
		}
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		//Str_Cpy(sztmp, "         미납금액 계 : ");
		Str_Cpy(sztmp, "미납금액 계 : ");
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Str_ItoA( nonpayamt,szBuf ,10);
		Str_Chg(szBuf, STRCHG_INS_COMMA);
		Str_Cat(szBuf,  "원");
		//g_Line_Print(list, sztmp,"",szBuf,LEFT,0);
		g_Line_Print(list, sztmp,"",szBuf,RIGHT,0);
		
		list->append(list, "--------------------------------");
		g_Line_Print(list, "▶지침 및 사용량","","",LEFT,0);
		list->append(list, "--------------------------------");
		list->append(list, "납  기      지  침        사용량");
		
		for( i = 0 ; i < mtrcnt ; i++)
		{
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally3;
			}
		
			hstmt = sql->CreateStatement(sql, "select MTR_NUM, CHK_YN, REQ_YM, INDI_VC, TOT_USE_QTY  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally3;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
			row = 1;
			sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally3;
			}
			
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
				sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				sql->GetValue(sql, idx++, 'U', (long*)sztmp ,1+1, DECRYPT);
				if(sztmp[0] == '0')
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 13 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally3:

			DelSqLite(sql);
						
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally4;
			}
		
			hstmt = sql->CreateStatement(sql, "select CHK, REQ_YM, INDI_COMPENS_VC, USE_QTY FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}

			while( sql->Next(sql) == TRUE )
			{
				idx = 0;
				
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
				if(szBuf[0] == '0' )
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 13 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally4:
			DelSqLite(sql);				
		}
		
		list->append(list, "--------------------------------");
		g_Line_Print(list, "▶보정량 및 단위열량","","",LEFT,0);
		list->append(list, "--------------------------------");
		list->append(list, "납  기     보정량       단위열량");
		
		for( i = 0 ; i < mtrcnt ; i++)
		{
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally5;
			}
		
			hstmt = sql->CreateStatement(sql, "select MTR_NUM, CHK_YN, REQ_YM, TOT_REVIS_QTY, SUPPLY_UNIT_ENER  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally5;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
			row = 1;
			sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally5;
			}
			
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
				sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				sql->GetValue(sql, idx++, 'U', (long*)sztmp ,1+1, DECRYPT);
				if(sztmp[0] == '0')
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 11 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally5:
	
			DelSqLite(sql);
				
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally6;
			}
		
			hstmt = sql->CreateStatement(sql, "select CHK, REQ_YM, INDI_COMPENS_VC, USE_QTY FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally6;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally6;
			}

			while( sql->Next(sql) == TRUE )
			{
				idx = 0;
				
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
				if(szBuf[0] == '0' )//월별미납 수납으로 표시
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 11 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally6:
	
			DelSqLite(sql);				
		}
					
		list->append(list, "--------------------------------");
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Str_Cat(szBuf, "[입금전용계좌안내]" );
		g_Line_Print(list, szBuf,"","",LEFT,0);

		sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally7;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT   PARAM2, PARAM1, PARAM3, '1' as srt \
FROM RCV_TMP \
where PARAM3 = '003'  \
union \
SELECT PARAM2, PARAM1, PARAM3, '2' as srt \
FROM RCV_TMP \
where PARAM3 = '027' \
union \
SELECT PARAM2, PARAM1, PARAM3, '3' as srt \
FROM RCV_TMP \
where PARAM3 <> '027' and PARAM3 <> '003' \
order by srt, PARAM3 " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally7;
		}
		
		idx = 0;

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while( sql->Next(sql) )
		{
			idx = 0;
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue(sql, idx++, 'U', (long*)szBuf, 30, DECRYPT);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, ".은 행 명 : ");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue(sql, idx++, 'U', (long*)szBuf, 30, DECRYPT);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "  계좌번호 : ");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);
		}
				
Finally7:
		DelSqLite(sql);

//		list->append(list, "KT 전화이체 : 060-7088-114      ");
//		list->append(list, "   (수수료 발생시 본인부담)     ");
		list->append(list, "☞서울도시가스 콜센터           ");
		list->append(list, "  ☎ 1588-5788                  ");
		list->append(list, "--------------------------------");
		list->append(list, "※미납요금 입금 후 즉시         ");
		list->append(list, "  고객센터로 연락 주셔야 합니다.");
		list->append(list, "※미납요금 입금 후 고객센터로   ");
		list->append(list, "  연락주셔야 사용계약해지 처리가");
		list->append(list, "  되며, 연락이 없는 경우 요금이 ");
		list->append(list, "  (기본료) 계속 발생될 수 있으니");
		list->append(list, "  이점 꼭 확인하시길 바랍니다.  ");			
		list->append(list, "--------------------------------");
		g_Line_Print(list, "※고객센터정보" ,"" ,"",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "센 터 명 : ");
		Str_Cat(sztmp, stUserinfo.szcenter_nm);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "전화번호 : ");
		Str_Cat(sztmp, stUserinfo.sztel);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		
		list->append(list, "--------------------------------");
		list->append(list, "      서울도시가스(주)          ");
		list->append(list, "                                ");
		
		return list;
	}

	//------------------------------------------------------------------
	//edit 한글체크
	long GetUtf8Size(char* str, long chklen)
	{
		long nSize = 0;
		long nLen = 0;
		long i = 0;
		
		nSize = Str_Len(str);
		
		for(i=0 ; i < nSize ; )
		{
			if ( str[i] & 0x80 )	//한글
				i+=2;			//2글자
			else
				i++;
				
			if( i >= chklen )
				break;
		}
		nLen = i;
		return nLen;
	}	

}


