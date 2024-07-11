/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_DAYRCV
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "SQLdb.h"
	
	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_DAYRCV )	//민원수신
		DEF_BUTTON_ID ( BID_CODERCV)	//기초코드수신
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
		DEF_OBJECT_ID ( TXT_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_BACK )
		DEF_OBJECT_ID ( TXT_BORDER )
		DEF_OBJECT_ID ( TXT_SHOW )
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
	END_OBJECT_ID()
	
	
	#define INIT_MAIN	1
	
	
	#define RcvAssignseq	"RcvAssignseq.txt"
	#define RcvAssignseq_Len	10
	
	
	long m_mincnt = -1;
	long m_nTotal = 5;
	long m_nCurr = 0;
	
	void RCV_DAYMIN(void);
	void Update_sort(void);
	
	long Rev68402(long flag);
	long TR68402(void);
	
	long RCV75108(void);

	long SND68404(void);
	long TR68404(void);
	long Add_Item(handle pj);
	
	bool DeleteOldData(void);
	long Save_Min(void);
	bool SetJsonToDB( DBInfo* info, SQLITE sql, handle json, long nCnt );
	bool Save_assignseq( handle json, long nCnt );
	
	void RCV_CODE(void);
	long TR685021(void);
	long TR685022(void);
	long Rev685022(void);
	long TR685023(void);
	long Rev685023(void);
	long TR685024(void);
	long Rev685024(void);
	long TR685025(void);
	long Rev685025(void);
	long TR685026(void);
	long Rev685026(void);
	long TR685027(void);
	long Rev685027(void);
	long TR685028(void);
	long Rev685028(void);
	long TR685029(void);
	long Rev685029(void);
	
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
	
	void SetBtnImg(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "자 료 관 리"),

		//DLG_BUTTON(STARTX+250,     STARTY+100, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DAYRCV    , ""),
		//DLG_BUTTON(STARTX+250,     STARTY+250, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CODERCV  , ""),
		
		DLG_BUTTON(STARTX+240,     STARTY+100,         BTNMNWD, BTNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DAYRCV    , ""),
		DLG_BUTTON(STARTX+240,     STARTY+100+(1*BTNHT), BTNMNWD, BTNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CODERCV  , ""),

		//DLG_BUTTON(STARTX+240, STARTY+150, BTNMNWD, 208, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RECV, ""), // 자 료 수 신
		//DLG_BUTTON(STARTX+240, STARTY+150+(1*208), BTNMNWD, 208, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SNDDEL, ""), // 자 료 송 신
		//DLG_BUTTON(STARTX+240, STARTY+150+(2*208), BTNMNWD, 208, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DEL, ""), // 자 료 삭 제

		DLG_TEXT( STARTX+90, STARTY+540,  800, 350, 0, 0, EDITSTY_BORDER, 0, RED, TXTINCTRLBK, TXT_SHOW, "전체자료수신시 자료가 \n초기화됩니다. \n \n초기화를 원치않을 경우 \n작업리스트화면에서 \n추가받기로 자료수신 \n해주시기 바랍니다."),
	};	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "자 료 관 리"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+250,     STARTY+200, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DAYRCV    , "전체자료수신"),    
		DLG_BUTTON(STARTX+250,     STARTY+350, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CODERCV  , "공통자료수신"),
		
		DLG_TEXT( STARTX+90, STARTY+430,  800, 400, 0, 0, EDITSTY_BORDER, 0, RED, TXTINCTRLBK, TXT_SHOW, "전체자료수신시 자료가 \n초기화됩니다. \n \n초기화를 원치않을 경우 \n작업리스트화면에서 \n추가받기로 자료수신 \n해주시기 바랍니다."),  
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
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				
				EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_SHOW), TRUE, DMS_X(10) , EDITSEP_NONE );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SHOW), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				g_FlagClear();
				SetBtnImg();
				
				break;
		}
	}

	//----------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_DAYRCV:
				RCV_DAYMIN();
				break;	
			case BID_CODERCV:
				RCV_CODE();
				break;
			
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
				Card_Move("C6101_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
	void OnExit(void)
	{
		Update_sort();
	}
	
	void Update_sort(void)
	{
		g_Sql_DirectExecute( "UPDATE C6101_PROMISE_ASSIGN SET PAY_CALU = '000' " );
		
		g_Sql_DirectExecute( "UPDATE C6101_PROMISE_BUR SET PDA_IP = '000' " );
		
	}
	
	//----------------------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
					
		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			//상단공통메뉴
			h = GetSysButHandle(GID_HOME);
			ButCtrl_SetImage( h,  g_pImgHomeI);
			ButCtrl_SetActiveImage( h,  g_pImgHomeA);
			
			h = GetSysButHandle(GID_KEYBOARD);
			ButCtrl_SetImage( h,  g_pImgKeybrdI);
			ButCtrl_SetActiveImage( h,  g_pImgKeybrdA);
			
			h = GetSysButHandle(GID_SCREEN);
			ButCtrl_SetImage( h,  g_pImgScreenI);
			ButCtrl_SetActiveImage( h,  g_pImgScreenA);
			
			h = GetSysButHandle(GID_CMMNWK);
			ButCtrl_SetImage( h,  g_pImgCmmnwrkI);
			ButCtrl_SetActiveImage( h,  g_pImgCmmnwrkA);
			
			h = GetSysButHandle(GID_VMEXIT);
			ButCtrl_SetImage( h,  g_pImgExitI);
			ButCtrl_SetActiveImage( h,  g_pImgExitA);
					
			//메뉴버튼
			h = Get_hDlgCtrlByID(BID_DAYRCV);
			ButCtrl_SetImage( h,  g_pImgMw_DayDataRcv);
			
			h = Get_hDlgCtrlByID(BID_CODERCV);
			ButCtrl_SetImage( h,  g_pImgMw_CmmDataRcv);
		}
	}
	
	//----------------------------------------------------------------------------------
	void RCV_DAYMIN(void)
	{
	char sztmp[10]; 
	char szSql[200];
	long nCnt = 0;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT count(*) FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' ",0,0,0   );
		g_Sql_RetInt(szSql, &nCnt);
		if (nCnt > 0) 
		{
			MessageBoxEx (CONFIRM_OK, "미처리송신 자료가 있습니다. 처리후 수신하세요.");
			return;
		}
		
		if( MessageBoxEx (CONFIRM_YESNO, "일일자료를 수신하시겠습니까?") != MB_OK )
		{
			return;
		}
		
		CloseMessageBox();
		ON_DRAW();
		
		nCnt = 0;
		g_Sql_RetInt("SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN WHERE PROMISE_YMD = strftime('%Y%m%d','now','localtime') ", &nCnt );
		if(nCnt == 0) // 금일자료 최초 수신시에 사진 폴더내 사진 모두 삭제
		{
			g_DirFS_Clear(PHOTO_MW, "*.jjp");
		}
		
		CloseMessageBox();
		ON_DRAW();

		Rev68402(1);//전체받기
	}
	
	//----------------------------------------------------------------------------------
	long Rev68402(long flag)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 68402, TRUE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Str_ItoA( Time_GetDate(),szbuf ,10);
		JSON_SetValue( g_pjcomm, 'C', "promise_ymd",   szbuf );
		if(flag == 1)
			JSON_SetValue( g_pjcomm, 'C', "gubun",   "1" );
		else
			JSON_SetValue( g_pjcomm, 'C', "gubun",   "2" );
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Str_Cpy(szbuf, "FR68402.JSON");

		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		g_SeverConnection();

		//PROGRESS_DUMP("1111111");

		callBackfunc = TR68402;
		//ret = HTTP_DownloadData(szUrl, "FR68402_IN",  "FR68402", sndbuf, szbuf );
		
		//PRINT("Rev68402 HTTP_Url2File szUrl:[%s]", szUrl, 0, 0);
		HTTP_Url2File("POST", szUrl, sndbuf, szbuf);
		
		//PRINT("Rev68402 return", 0, 0, 0);
		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR68402(void)
	{	
		//PRINT("callback Rev68402 start", 0, 0, 0);
		g_Sock_Close();
		
		//PRINT("callback Rev68402 Save_Min start", 0, 0, 0);
		if( Save_Min() == 0 )
		{
			//PRINT("callback Rev68402 Save_DeleteOldDataMin start", 0, 0, 0);
			if (DeleteOldData()) {
				if ( m_mincnt > 0 )
					SND68404();
				//PRINT("callback TR68402 success", 0, 0, 0);
				return 1;
			} else {
				//PRINT("callback TR68402 DeleteOldData error", 0, 0, 0);
				MessageBoxEx(ERROR_OK, "이전 데이터 삭제에 실패하였습니다. ");
				ON_DRAW();
				return -1;
			}
		} 
		else 
		{
			// DB 가 최신이 아닌 경우 등등..
			//PRINT("callback TR68402 Save_Min error", 0, 0, 0);
			MessageBoxEx(ERROR_OK, "데이터 저장에 실패하였습니다. [68402]");			
			ON_DRAW();	
			
			return -1;
		}

		
	}

	long RCV75108(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75108, FALSE);
		
		// JSON_SetValue( g_pjcomm, 'C', "obj_ym",    m_szobjym);
		// JSON_SetValue( g_pjcomm, 'C', "chk_type",    m_szchktype);
		// JSON_SetValue( g_pjcomm, 'C', "chk_order",    m_szchkorder);
		// JSON_SetValue( g_pjcomm, 'C', "chk_year",    m_szchkyear);
		// JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
		// JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    m_szzone_manage_num);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		// callBackfunc = TR75108; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR75108_IN",  "FR75108" , sndbuf, sztmp );
		return 0 ;
	}
	
	//----------------------------------------------------------------------------------
	// 기  능 : 전송 결과 파일을 검토한다.
	// 설  명 : 
	// 리턴값 : 0:정상적인 통신완료, -1: 에러응답or응답형식오류, 알수없는 에러
	//----------------------------------------------------------------------------------
	long Save_Min(void)
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
	char *szitem = NULL;
	char szType[2] = {0,0};
	long ret = 0;
	handle hitem = NULL;
	handle hcnt = NULL;
	DBInfo assign;
	DBInfo mtr;
	DBInfo bur;
	DBInfo custinfo;
	DBInfo nonpay;
	handle hdb = NULL;
	SQLITE sql = NewSqLite();
			
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			DelSqLite(sql);
			MessageBoxEx(ERROR_OK, "데이터베이스 연결 오류.. \n리셋후 초기버젼을 재설치 해 주세요.");
			ret = -3;
			goto Finally;
		}
		assign.szTblnm=  "C6101_PROMISE_ASSIGN";
		assign.nKeyCnt=  AssignKeyCnt;
		assign.nUTotCnt=  AssignUCnt;
		assign.nITotCnt=  AssignICnt;
		assign.keyinfo=  m_stMwAssignKey;
		assign.Ufldinfo=  m_stMwAssignU;
		assign.Ifldinfo=  m_stMwAssignI;


		mtr.szTblnm=     "C6101_PROMISE_mtr";
		mtr.nKeyCnt=  MtrKeyCnt;
		mtr.nUTotCnt=  MtrUCnt;
		mtr.nITotCnt=  MtrICnt;
		mtr.keyinfo=  m_stMwMtrKey;
		mtr.Ufldinfo=  m_stMwMtrU;
		mtr.Ifldinfo=  m_stMwMtrI;

		bur.szTblnm=     "C6101_PROMISE_bur";
		bur.nKeyCnt=  BurKeyCnt;
		bur.nUTotCnt=  BurUCnt;
		bur.nITotCnt=  BurICnt;
		bur.keyinfo=  m_stMwBurKey;
		bur.Ufldinfo=  m_stMwBurU;
		bur.Ifldinfo=  m_stMwBurI;

		custinfo.szTblnm="C6101_Pre_cust_info";
		custinfo.nKeyCnt=  CustKeyCnt;
		custinfo.nUTotCnt=  CustUCnt;
		custinfo.nITotCnt=  CustICnt;
		custinfo.keyinfo=  m_stMwCustKey;
		custinfo.Ufldinfo=  m_stMwCustU;
		custinfo.Ifldinfo=  m_stMwCustI;

		nonpay.szTblnm=  "C6101_nonpay";
		nonpay.nKeyCnt=  NonpayKeyCnt;
		nonpay.nUTotCnt=  NonpayUCnt;
		nonpay.nITotCnt=  NonpayICnt;
		nonpay.keyinfo=  m_stMwNospayKey;
		nonpay.Ufldinfo=  m_stMwNospayU;
		nonpay.Ifldinfo=  m_stMwNospayI;

		MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR68402_Res.JSON",  SYSTEM_COMM, 0, 0 );
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR68402.JSON",  SYSTEM_COMM, 0, 0 );
		}

		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			MessageBoxEx (WARNING_OK, "수신데이터 오류[0]");
			PRINT("수신데이터 오류[0]", 0, 0, 0);
			ret = -1;
			goto Finally;
		}

		pStr = Mem_Alloc(fsize);
		
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			MessageBoxEx (WARNING_OK, "수신데이터 오류[1]");
			PRINT("수신데이터 오류[1]", 0, 0, 0);
			ret = -1;
			Mem_Free((byte*)pStr);
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
			MessageBoxEx (WARNING_OK, "수신데이터 오류[2]");
			PRINT("수신데이터 오류[2]", 0, 0, 0);
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
			MessageBoxEx (WARNING_OK, "수신데이터 오류[3]");
			PRINT("수신데이터 오류[3]", 0, 0, 0);
			ret = -1;
			goto Finally;
		}

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
			  char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				EvtDraw();
				PRINT("save_min szcode != 0000 ", 0, 0, 0);
				ret = -1;
				goto Finally;
			}
			else
			{
				
				if(ret > -1 )
				{
					szitem =JSON_GetValue(g_pjcomm, "assign", szType);
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							m_mincnt = JSON_GetArrayCount( hitem );
						}
					}
					
					if(m_mincnt > 0 )// DB 입력
					{
						if ( SetJsonToDB( &assign, sql, hitem, m_mincnt ) == TRUE ) {
						
							//수신업데이터용 민원접수번호 저장
							Save_assignseq(hitem, m_mincnt);
						} 
						else
						{
							ret = -1;
							PRINT("SetJsonToDB assign error", 0, 0 , 0);
							goto Finally;
						}
					}
				}
				
				if(ret > -1 )
				{
					szitem =JSON_GetValue(g_pjcomm, "nonpay", szType);
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
						}
					}
								
					if(ret > 0 )// DB 입력
					{				
						if ( SetJsonToDB( &nonpay, sql, hitem, ret ) == FALSE )
						{
							ret = -1;
							PRINT("SetJsonToDB nonpay error", 0, 0 , 0);
							goto Finally;
						}
					}
					
				}
				
				if (ret > -1)
				{
					szitem =JSON_GetValue(g_pjcomm, "custinfo", szType);				
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
						}
					}
					
					if(ret > 0 )// DB 입력//json필드, 디비필드, 변수, 키필드, 순서, 테이블명,
					{
						if( hitem != NULL)
						{
							if ( SetJsonToDB( &custinfo, sql, hitem, ret ) == FALSE )
							{
								ret = -1;
								PRINT("SetJsonToDB custinfo error", 0, 0 , 0);
								goto Finally;
							}
						}
					}
				}
				
				if (ret > -1)
				{	
					szitem =JSON_GetValue(g_pjcomm, "mtr", szType);
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
						}
					}
					
					if(ret > 0 )// DB 입력
					{
						if ( SetJsonToDB( &mtr, sql, hitem, ret ) == FALSE )
						{
							ret = -1;
							PRINT("SetJsonToDB mtr error", 0, 0 , 0);
							goto Finally;
						}
					}
							
				}
				
				if (ret > -1)
				{
					szitem =JSON_GetValue(g_pjcomm, "bur", szType);
					
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
						}
					}
					
					if(ret > 0 )// DB 입력
					{
						if ( SetJsonToDB( &bur, sql, hitem, ret ) == FALSE )
						{
							ret = -1;
							PRINT("SetJsonToDB bur error", 0, 0 , 0);
							goto Finally;
						}
					}
				}
				
				if(hitem != NULL )
				{
					JSON_Finalize(hitem);
					hitem = NULL;
				}
			
				ret = 0;
			}
		}
		else // if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			ret = -2;
		}

Finally:		

		m_nCurr = 0;

		//sql->Commit(sql);
		//sql->Close(sql);
		DelSqLite(sql);
		
		//PRINT("DelSqLite END",0,0,0);
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		PRINT("save_min error ret:[%d], m_mincnt:[%d]", ret, m_mincnt, 0);
		
		if(ret < 0)
		{
			MessageBoxEx (WARNING_OK, "금일 자료수신을 실패했습니다.[0]");
		}
		else if(m_mincnt == 0)
		{
			MessageBoxEx (WARNING_OK, "금일 자료가 없습니다.");
		}
		else if(m_mincnt < 0)
		{
			MessageBoxEx (WARNING_OK, "금일 자료수신을 실패했습니다.[1]");
		}

//2017-08-10 Sanghyun Lee
//무슨의미 메세지??????? 불필요해보임.
//		else
//		{
//			if(Str_Len(szcode) == 0)
//				MessageBoxEx (WARNING_OK, "오류: 서버응답이 없습니다.");
//		}
		
		ON_DRAW();
		//PRINT("Save_Min ret:[%d]", ret, 0 , 0);
		return ret;
	}
	
	bool  Save_assignseq(handle hitem, long nTCnt)
	{
	long fd, i;
	char sztmp[32];
	long *Col;
	void *Sts_Cd = NULL;
	long nCol= 0;
	char szType[2] = {0,0};
	
		fd = FFS_Open (  RcvAssignseq, FS_WRITE_MODE , FS_CREATE_FLAG );
		
		for( i = 0 ; i < nTCnt ; i++ )
		{
			Sts_Cd = JSON_GetArrayItem ( hitem, i,"PROC_STS_CD",  szType);
			
			if( Str_Cmp(Sts_Cd , "10" ) == 0 )
			{			
				Col = JSON_GetArrayItem ( hitem, i,"promise_assign_seq",  szType);
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp )  );
				nCol = *Col;
				Str_ItoA(nCol,  sztmp, 10  );
				FFS_Write(fd, (byte*)sztmp, RcvAssignseq_Len   );
			}
		}
		
		FFS_Close(fd);
		return TRUE;
	}
	
	bool DeleteOldData(void)
	{	
		bool	ret = FALSE;		
		handle hdb = NULL;
		long sret = -1;
		
		SQLITE sql = NewSqLite();
				
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			//DelSqLite(sql);
			MessageBoxEx(ERROR_OK, "데이터베이스 연결 오류.. \n리셋후 재시도 해 보시기 바랍니다.");
			goto Finally;
		}
		
		sql->Begin(sql);
		
		//g_Sql_DirectExecute2(sql, " DELETE FROM C6101_CARD_INFO "); // IC칩 사용카드 결재를 반영할 때 사용할 예정임
		
		//Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		//Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		//Str_ItoA( Time_GetDate(), szDate, 10);	
		//SPRINT( szSql ," DELETE FROM C6101_PROMISE_ASSIGN WHERE PROMISE_YMD <> '%s' OR ASSIGN_EMPID <> '%s' ", szDate, stUserinfo.szemployee_id, 0   );	
		//g_Sql_DirectExecute( szSql );
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_PROMISE_ASSIGN WHERE LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_PROMISE_ASSIGN", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_PROMISE_ASSIGN", 0, 0 , 0);
		}
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_NONPAY WHERE LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_NONPAY", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_NONPAY", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_PRE_CUST_INFO WHERE LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_PRE_CUST_INFO", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_PRE_CUST_INFO", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_PROMISE_MTR WHERE LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_PROMISE_MTR", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_PROMISE_MTR", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_PROMISE_BUR WHERE LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_PROMISE_BUR", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_PROMISE_BUR", 0, 0 , 0);
		}		
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_AUTO_TRANS WHERE PROMISE_ASSIGN_SEQ NOT IN (SELECT PROMISE_ASSIGN_SEQ FROM C6101_PROMISE_ASSIGN) " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_AUTO_TRANS", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_AUTO_TRANS", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_CARDASSIGN_INFO WHERE PROMISE_ASSIGN_SEQ NOT IN (SELECT PROMISE_ASSIGN_SEQ FROM C6101_PROMISE_ASSIGN) " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_CARDASSIGN_INFO", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_CARDASSIGN_INFO", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_ONCE_INFO WHERE PROMISE_ASSIGN_SEQ NOT IN (SELECT PROMISE_ASSIGN_SEQ FROM C6101_PROMISE_ASSIGN) " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_ONCE_INFO", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_ONCE_INFO", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_CHG_MTR_INFO WHERE PROMISE_ASSIGN_SEQ NOT IN (SELECT PROMISE_ASSIGN_SEQ FROM C6101_PROMISE_ASSIGN) " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_CHG_MTR_INFO", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_CHG_MTR_INFO", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ NOT IN (SELECT PROMISE_ASSIGN_SEQ FROM C6101_PROMISE_ASSIGN) " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_PROMISE_CARD", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_PROMISE_CARD", 0, 0 , 0);
		}
		
		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_PROMISE_CHK WHERE PROMISE_ASSIGN_SEQ NOT IN (SELECT PROMISE_ASSIGN_SEQ FROM C6101_PROMISE_ASSIGN) " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6101_PROMISE_CARD", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_PROMISE_CARD", 0, 0 , 0);
		}

		sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6301_OLDMTRIDNUM " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData C6301_OLDMTRIDNUM", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData C6101_PROMISE_CARD", 0, 0 , 0);
		}

		 sret = g_Sql_DirectExecute2(sql, " DELETE FROM C6101_CHK_BULD_CENTER_CD " );
		 if (sret < 0) {
		 	PRINT("ERROR : DeleteOldData C6101_CHK_BULD_CENTER_CD", 0, 0 , 0);
		 	goto Finally;
		 } else {
		 	//PRINT("DeleteOldData C6101_PROMISE_CARD", 0, 0 , 0);
		 }

		// 특이사항 : 기기에서 오류(sql logic error or missing database)발생하는 현상이 있음(에뮬에서는 발생하지 않음)
		// DB 를 한 번 닫았다가 열어서 실행하면 오류가 발생하지 않음
		DelSqLite(sql);
		//PRINT("DelSqLite", 0, 0 , 0);
		
		sql = NewSqLite();
				
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			//DelSqLite(sql);
			MessageBoxEx(ERROR_OK, "데이터베이스 연결 오류.. \n리셋후 재시도 해 보시기 바랍니다.");
			goto Finally;
		}
		//PRINT("sql->Open", 0, 0 , 0);

		sret = g_Sql_DirectExecute2(sql, " UPDATE C6101_PROMISE_ASSIGN SET LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData UPDATE LAST_STATUS='' C6101_PROMISE_ASSIGN", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData UPDATE LAST_STATUS='' C6101_PROMISE_ASSIGN", 0, 0 , 0);
		}
		sret = g_Sql_DirectExecute2(sql, " UPDATE C6101_NONPAY SET LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData UPDATE LAST_STATUS='' C6101_NONPAY", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData UPDATE LAST_STATUS='' C6101_NONPAY", 0, 0 , 0);
		}
		sret = g_Sql_DirectExecute2(sql, " UPDATE C6101_PRE_CUST_INFO SET LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData UPDATE LAST_STATUS='' C6101_PRE_CUST_INFO", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData UPDATE LAST_STATUS='' C6101_PRE_CUST_INFO", 0, 0 , 0);
		}
		sret = g_Sql_DirectExecute2(sql, " UPDATE C6101_PROMISE_MTR SET LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData UPDATE LAST_STATUS='' C6101_PROMISE_MTR", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData UPDATE LAST_STATUS='' C6101_PROMISE_MTR", 0, 0 , 0);
		}
		sret = g_Sql_DirectExecute2(sql, " UPDATE C6101_PROMISE_BUR SET LAST_STATUS = '' " );
		if (sret < 0) {
			PRINT("ERROR : DeleteOldData UPDATE LAST_STATUS='' C6101_PROMISE_BUR", 0, 0 , 0);
			goto Finally;
		} else {
			//PRINT("DeleteOldData UPDATE LAST_STATUS='' C6101_PROMISE_BUR", 0, 0 , 0);
		}
		
		ret = TRUE;
		
Finally:		

		DelSqLite(sql);
		
		return ret;
	}
	
	//----------------------------------------------------------------------
	//함수명: SetJsonToDB
	//기  능: 파일정보와 테이블정보를 읽어서 파일에서 DB로 데이터를 넣는다.
	//Param : TBL 정보
	//Return: TRUE:성공, FALSE:실패
	//----------------------------------------------------------------------
	bool SetJsonToDB( DBInfo* info, SQLITE sql, handle hitem, long nTCnt )
	{
	bool	ret = FALSE, idx = 0;
	bool	bret = FALSE;
	long 	i;
	char	sztmp[100];
	char	szSql[4000];
	char	szWhere[3000];
	char 	szType[2] = {0,0};
	char    *szLog;
	void    *Col = NULL;
	long	nCnt = 0;
	char	szNull[2];
	long tmpTotCnt = 0;
	long tmpUpdateCnt = 0;
	
		MessageBoxEx(MESSAGE, "데이터를 확인중 입니다.");
		if (sql == NULL)
		{			
			//PRINT("sql == NULL", 0, 0 , 0);
			goto Finally;
		}
		
		// SELECT 쿼리문 생성
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql )  );
		Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		
		for( idx = 0 ; idx < info->nKeyCnt ; idx++ )
		{
			if(idx != 0)
				Str_Cat( szWhere, " AND ");
			Str_Cat( szWhere, info->keyinfo[idx].colnm );
			Str_Cat( szWhere, " = ? ");
		}
		
		SPRINT(szSql, " SELECT COUNT(*) FROM %s WHERE %s", info->szTblnm,  szWhere, 0 );
		
		//PRINT("C6101_DAYRCV SetJsonToDB count szSql:[%s]", szSql, 0, 0);
		
		sql->CreateStatement(sql, szSql);
		if( sql->m_hStmt == NULL )
		{
			PRINT("::SQL_CreateStatement for SELECT fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		//PRINT("nITotCnt:[%d], tmpUpdateCnt:[%d]", info->nITotCnt, tmpUpdateCnt , 0);
		
		// UPDATE 쿼리문 생성
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql )  );
		//Mem_Set((byte*)szWhere, 0x00, sizeof(szWhere) );
		
		Str_Cpy( szSql, " UPDATE " );
		Str_Cat( szSql, info->szTblnm );
		Str_Cat( szSql, " SET LAST_STATUS='U' " );
		
		tmpUpdateCnt = info->nUTotCnt - info->nKeyCnt;
		for( idx = 0 ; idx < tmpUpdateCnt ; idx++ )
		{
			//if(idx != 0)
			//{
				Str_Cat( szSql, ",");
			//}
			Str_Cat( szSql, info->Ufldinfo[idx].colnm );
			//PRINT("colnm for UPDATE:[%s], idx:[%d]", info->Ufldinfo[idx].colnm, idx , 0);
			Str_Cat( szSql, "=?" );
		}
		
		Str_Cat( szSql, " WHERE ");
		Str_Cat( szSql, szWhere );
		//PRINT("szSql for UPDATE:[%s]", szSql, 0 , 0);
		//PRINT("WHERE for UPDATE:[%s]", szWhere, 0 , 0);
		
		sql->CreateStatementU(sql, szSql);
		//PRINT("szTblnm:[%s] CreateStatementU for UPDATE", info->szTblnm, 0 , 0);
		if( sql->m_hUStmt == NULL )
		{
			PRINT("::SQL_CreateStatementU fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		// INSERT 쿼리문 생성
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql )  );
		Mem_Set((byte*)szWhere, 0x00, sizeof(szWhere) );
		
		Str_Cpy( szSql, " INSERT INTO " );
		Str_Cat( szSql, info->szTblnm );
		Str_Cat( szSql, "(" );
		
		for( idx = 0 ; idx < info->nITotCnt ; idx++ )
		{
			if(idx != 0)
			{
				Str_Cat( szSql, ",");
				Str_Cat( szWhere, ",");
			}
			Str_Cat( szSql, info->Ifldinfo[idx].colnm );
			Str_Cat( szWhere, "?" );
		}
		
		Str_Cat( szSql, ", LAST_STATUS");
		Str_Cat( szWhere, ", 'I'");
		
		Str_Cat( szSql, ") VALUES (" );
		Str_Cat( szSql, szWhere );
		Str_Cat( szSql, ")" );
		
		//PRINT(" INSERT [%d]", Str_Len(szSql), 0 , 0);
		
		sql->CreateStatementI(sql, szSql);
		if( sql->m_hIStmt == NULL )
		{
			PRINT("::SQL_CreateStatementI fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		//szLog = JSON_toString(hitem);
		//g_Save_JsonFile(szLog);

		m_nCurr++;
		//PRINT("::data save start, recordCnt:[%d], fieldCnt:[%d]", nTCnt, info->nITotCnt, 0);
		for( i = 0 ; i < nTCnt ; i++ )
		{
			long percent = (i * 100) / nTCnt;
			SPRINT(sztmp, "%d %% (%d/%d) 저장 중...", percent, m_nCurr, m_nTotal);
			SetMessageBoxText(sztmp);
		
			for(idx = 0; idx < info->nKeyCnt ; idx++)
			{
				Col = JSON_GetArrayItem ( hitem, i, info->keyinfo[idx].jsonnm, szType);		

				if(szType[0] == 'C')
				{
					sql->Bind(sql, idx, 'C', (long*)Col, Str_Len(Col), info->keyinfo[idx].encrypt );
					//PRINT("::bind for SELECT jsonnm:[%s], Col:[%s], szType:[%s]", info->keyinfo[idx].jsonnm, Col, szType);
				}
				else if(szType[0] == 'X')
				{
					sql->Bind(sql, idx, 'X', Col, 4, info->keyinfo[idx].encrypt );
					//PRINT("::bind for SELECT jsonnm:[%s], Col:[%d], szType:[%s]", info->keyinfo[idx].jsonnm, Col, szType);
				}
			}
			//sql->Begin(sql);
			bret = sql->Execute(sql);
			if(bret == FALSE)
			{
				PRINT("::sql->Execut [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			while( sql->Next(sql) == TRUE )
			{
				nCnt = 0;
				sql->GetValue( sql, 0, 'X', &nCnt, sizeof(nCnt), DECRYPT );
				//PRINT("count(*) [%d]", nCnt, 0, 0);
	
			}
			//PRINT("nCnt:[%d]", nCnt, 0 , 0);
			//자료의 존재여부 확인해서 인서트만 한다.
			//if( nCnt == 0 )
			{	
				if( nCnt == 0 )
					tmpTotCnt = info->nITotCnt;
				else
					tmpTotCnt = info->nUTotCnt;
					
				//PRINT("bind col count:[%d]", tmpTotCnt, 0 , 0);
				for(idx = 0; idx < tmpTotCnt ; idx++)
				{
				
					if( nCnt == 0 )
						Col = JSON_GetArrayItem ( hitem, i, info->Ifldinfo[idx].jsonnm, szType);
					else
						Col = JSON_GetArrayItem ( hitem, i, info->Ufldinfo[idx].jsonnm, szType);
					
//PRINT("szType=%s, %s",szType,info->Ifldinfo[idx].jsonnm,0);
					if(szType[0] == 'C')
					{
						if( nCnt == 0 ) {
							sql->IBind(sql, idx, 'C', (long*)Col, Str_Len(Col), info->Ifldinfo[idx].encrypt );
						}
						else {
							sql->UBind(sql, idx, 'C', (long*)Col, Str_Len(Col), info->Ufldinfo[idx].encrypt );
							//PRINT("::bind for UPDATE jsonnm:[%s], Col:[%s], szType:[%s]", info->Ufldinfo[idx].jsonnm, Col, szType);
							//PRINT("::bind for UPDATE idx:[%d], jsonnm:[%s], Col:[%s]", idx, info->Ufldinfo[idx].jsonnm, Col);
						}
						
					}
					else if(szType[0] == 'X')
					{
						if( nCnt == 0 ) {
							sql->IBind(sql, idx, 'X', Col, 4, info->Ifldinfo[idx].encrypt );
						}
						else
						{
							sql->UBind(sql, idx, 'X', Col, 4, info->Ufldinfo[idx].encrypt );
							//if ( Str_Cmp(info->Ufldinfo[idx].jsonnm,"promise_assign_seq") == 0 )
								//PRINT("::bind for UPDATE jsonnm:[%s], Col:[%d], szType:[%s]", info->Ufldinfo[idx].jsonnm, Col, szType);
							//PRINT("::bind for UPDATE idx:[%d], jsonnm:[%s], szType:[%s]", idx, info->Ufldinfo[idx].jsonnm, szType);
						}
					}
					else if(szType[0] == 'N') // null
					{
						Mem_Set( (byte*)szNull, 0x00, sizeof(szNull) );
						Str_Cpy(szNull, "");
						
						// N 인 경우 자리수가 4 --> ???
						//PRINT("::col jsonnm:[%s], Col:[%s], szType:[%s]", info->Ifldinfo[idx].jsonnm, (long*)Col, szType);
						if( nCnt == 0 )
							sql->IBind(sql, idx, 'C', (long*)&szNull, sizeof(szNull), info->Ifldinfo[idx].encrypt );
						else
						{
							sql->UBind(sql, idx, 'C', (long*)&szNull, sizeof(szNull), info->Ufldinfo[idx].encrypt );
							//PRINT("::bind for UPDATE idx:[%d], jsonnm:[%s], szType:[%s]", idx, info->Ufldinfo[idx].jsonnm, szType);
						}
					}
					else
					{
						//에러처리
						if( nCnt == 0 )
							PRINT("::데이터 오류 jsonnm:[%s], Col:[%s], szType:[%s]", info->Ifldinfo[idx].jsonnm, Col, szType);
						else
							PRINT("::데이터 오류 jsonnm:[%s], Col:[%s], szType:[%s]", info->Ufldinfo[idx].jsonnm, Col, szType);
						goto Finally;
					}
				} // end for(idx = 0; idx < info->nITotCnt ; idx++)
				//sql->Begin(sql);
				if( nCnt == 0 ) 
				{
					bret = sql->ExecuteI(sql);
					//PRINT("ExecuteI", 0, 0 , 0);
				}
				else
				{					
					bret = sql->ExecuteU(sql);
					//PRINT("ExecuteU", 0, 0 , 0);
				}
				
				if(bret == FALSE)
				{
					if( nCnt == 0 )
						PRINT("::sql->ExecuteI [%s]", sql->GetLastError(sql), 0, 0);
					else
						PRINT("::sql->ExecuteU [%s]", sql->GetLastError(sql), 0, 0);
					goto Finally;
				}
			}
			
		}		
		//PRINT("::data save end Count:[%d]", i, 0, 0);			
		ret = TRUE;
		
Finally:
		sql->DeleteStatement(sql);
		//PRINT("::Finally DeleteStatement end", 0, 0, 0);

		ON_DRAW();
		GrDev_Refresh();
		
		//PRINT("::Finally ret", 0, 0, 0);
		return ret;
	}
	
	//----------------------------------------------------------------------------------
	long SND68404(void)
	{
	long ret = 0;
	char sztmp[100];
	char szUrl[200];
	char szbuf[200];
	char szDbpath[128];
	char* sndbuf;
	
		//송신
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68404, TRUE);
		
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Str_Cpy(szbuf, "FR68404.JSON");
		
		callBackfunc = TR68404;
		HTTP_Url2File("POST", szUrl, sndbuf, szbuf);
		return ret;
	}
	
	//----------------------------------------------------------------------------------
	long Add_Item(handle pj)
	{
	char sztmp[20];
	long ret = -1;
	long fd, i, tot = 0;	
	handle js = NULL;
	char szPromise_assign_seq[11];		
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		tot = FFS_GetSize( RcvAssignseq );
		tot = tot /RcvAssignseq_Len;
				
		fd = FFS_Open (  RcvAssignseq, FS_READ_MODE , FS_NORMAL_FLAG );
		
		for( i = 0 ; i < tot ; i++ )
		{	
			Mem_Set( (byte*)szPromise_assign_seq, 0x00, sizeof(szPromise_assign_seq )  );
			FFS_Read(fd, (byte*)szPromise_assign_seq, RcvAssignseq_Len   );
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "promise_assign_seq", szPromise_assign_seq );
			ret =1;
		}
		
		FFS_Close(fd);
		
		JSON_Attach(pj, "item", js);
		
Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return ret;
	}
	
	//----------------------------------------------------------------------------------
	long TR68404(void)
	{
		
	char szMsg[200];
	
		//PRINT("callback TR68404 success", 0, 0, 0);
		g_Sock_Close();
		// RCV75108();
		
		if(g_Chk_Json(68404) >= 0)
		{
			if(  m_mincnt > 0  )
			{
				Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
				SPRINT(szMsg, "전체자료 %d건을 수신받았습니다.",  m_mincnt, 0, 0 );
				MessageBoxEx (CONFIRM_OK, szMsg);
				
			}
			CloseMessageBox();

			ON_DRAW();
			
				//PRINT("callback TR68404 success", 0, 0, 0);
			return 1;
		}
		
		ON_DRAW();
		PRINT("callback TR68404 fail", 0, 0, 0);
		return -1;
	}
	
	//----------------------------------------------------------------------------------
	void RCV_CODE(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	
		if( MessageBoxEx (CONFIRM_YESNO, "민원 기초 코드를\n수신 받으시겠습니까?") != MB_OK )
		{
			return;
		}
		
		g_Sql_DirectExecute(" DELETE FROM C6101_CIVIL_CLASS ");
		g_Sql_DirectExecute(" DELETE FROM C6101_EMPLOYEE ");
		g_Sql_DirectExecute(" DELETE FROM C6101_BNK ");
		g_Sql_DirectExecute(" DELETE FROM C6101_ONCE_ITEM ");
		g_Sql_DirectExecute(" DELETE FROM C6101_BIZ_TYPE ");
		g_Sql_DirectExecute(" DELETE FROM C6101_PROD ");
		g_Sql_DirectExecute(" DELETE FROM C6101_BIZ_PROD ");
		g_Sql_DirectExecute(" DELETE FROM C6101_BIZ_BURN ");
		g_Sql_DirectExecute(" DELETE FROM C6101_WARR_OCCU_BASE ");
			
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685021, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);

		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		callBackfunc = TR685021;
		ret = HTTP_DownloadData(szUrl, "FR685021_IN",  "FR685021" , sndbuf, szbuf );
		
	}
	
	//----------------------------------------------------------------------------------
	long TR685021(void)
	{
	
		if(g_Chk_Json(685021) >= 0)
		{
			Rev685022();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685022(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685022, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685022;
		ret = HTTP_DownloadData(szUrl, "FR685022_IN",  "FR685022" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685022(void)
	{
		if(g_Chk_Json(685022) >= 0)
		{
			Rev685023();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685023(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685023, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685023;
		ret = HTTP_DownloadData(szUrl, "FR685023_IN",  "FR685023" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685023(void)
	{
		if(g_Chk_Json(685023) >= 0)
		{
			Rev685024();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685024(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685024, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685024;
		ret = HTTP_DownloadData(szUrl, "FR685024_IN",  "FR685024" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685024(void)
	{
		if(g_Chk_Json(685024) >= 0)
		{
			Rev685025();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685025(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685025, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685025;
		ret = HTTP_DownloadData(szUrl, "FR685025_IN",  "FR685025" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685025(void)
	{
		if(g_Chk_Json(685025) >= 0)
		{
			Rev685026();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685026(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685026, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685026;
		ret = HTTP_DownloadData(szUrl, "FR685026_IN",  "FR685026" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685026(void)
	{
		if(g_Chk_Json(685026) >= 0)
		{
			Rev685027();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685027(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685027, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685027;
		ret = HTTP_DownloadData(szUrl, "FR685027_IN",  "FR685027" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685027(void)
	{
		if(g_Chk_Json(685027) >= 0)
		{
			Rev685028();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685028(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685028, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685028;
		ret = HTTP_DownloadData(szUrl, "FR685028_IN",  "FR685028" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685028(void)
	{
		if(g_Chk_Json(685028) >= 0)
		{
			Rev685029();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	long Rev685029(void)
	{
	char szUrl[200];
	char szFilepath[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 685029, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR685029;
		ret = HTTP_DownloadData(szUrl, "FR685029_IN",  "FR685029" , sndbuf, szbuf );

		return 0;
	}
	
	//----------------------------------------------------------------------------------
	long TR685029(void)
	{
		g_Sock_Close();
		if(g_Chk_Json(685029) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "수신이 완료되었습니다.");
			ON_DRAW();
			return 1;
		}
		
		CloseMessageBox();
		return 1;
	}
}


