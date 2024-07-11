/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_SND
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
//화면 상단 공통 메뉴 모음
		DEF_BUTTON_ID ( BID_HOME )		//홈
		DEF_BUTTON_ID ( BID_MENU )		//메뉴
		DEF_BUTTON_ID ( BID_KEYBOARD )	//키보드
		DEF_BUTTON_ID ( BID_SCREEN )	//화면 상하
		DEF_BUTTON_ID ( BID_CMMNWORK )	//공통업무
		DEF_BUTTON_ID ( BID_PREV )		//이전
		DEF_BUTTON_ID ( BID_EXIT )		//종료

		DEF_BUTTON_ID ( BID_SND )			//승인취소 내역 송신
		DEF_BUTTON_ID ( BID_DEL )		//승인취소
		DEF_BUTTON_ID ( BID_ADDR )			//주소
		DEF_BUTTON_ID ( BID_ADDR2 )			//주소
		DEF_BUTTON_ID ( BID_UP )			//다음페이지
		DEF_BUTTON_ID ( BID_DOWN )			//이전페이지

	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//타이틀
		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		DEF_OBJECT_ID ( TXT_PAGE )			//타이틀

		
		DEF_OBJECT_ID ( ID_TBLLIST )	// 테이블 리스트
		
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table의 행개수
	#define		COL 	    5					// table의 열개수
	#define		GRID_H		(CHT+54)			// table 행 높이
	#define		GRID_H_P	(CHT+48)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+130  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    //table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	#define 	SYH			(CHT+25)
	#define 	Line(x)	    (STARTY+780+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = 
	{
		{"구분"         , CWD*6    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"주소"         , CWD*25+23, EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"시간"         , CWD*8    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"민원번호"     , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"PDA_DUTY_FLAG", 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	
	
	#define INIT_MAIN	1

	long m_lpage = 0;			// 현재 페이지
	long m_lTotpage = 0;		// 총 페이지
	long m_nActIndex = -1;		//선택된 row index
	char m_szCnt_page[20];		// 페이지 표시 변수
	char m_bFirst;				//INIT_MAIN 과 INIT_SRCH 에 따른 동작 구분 flag


	bool REDRAW(void);
	void SetStyle(void);
	void SetBtnImg(void);
	void Del_Data(void);
		
	void Snd_RstMin(void);
	long Load_Assign(char* assign_seq);
	long Rcv_RstMIn(void);
	long Add_Bo(handle pj);
	long Add_Bur(handle pj);
	long Add_Once(handle pj);
	long Add_Mtr(handle pj);
	long Add_ChgMtr(handle pj);//서명+사진추가한다.
	long Add_Nonpay(handle pj);//정산데이터 추가한다.
	long Add_CardInfo(handle pj);//카드결재 결과를 추가한다.
	long Add_OneCardInfo(handle pj);//일회성카드결재 결과
	long Add_Chk(handle pj);
	
	void Snd_Info_Trans(void);
	long Rcv_Info_Trans(void);
	
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
	
	// 메인 다이얼로그(리스트)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//타이틀
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "미송신리스트"),
		
		DLG_BUTTON(STARTX,      STARTY+65, 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON(STARTX+250,  STARTY+65, 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+750,  STARTY+65, 250, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),

		DLG_BUTTON( STARTX    , Line(1)-11, 333, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "자료삭제"),
		DLG_TEXT(   STARTX+333, Line(1)-11, 334, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		DLG_BUTTON( STARTX+667, Line(1)-11, 333, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SND, "자료송신"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H/2, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};	
	
	
	// PDA 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//타이틀
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "미송신리스트"),
		

		DLG_BUTTON( STARTX,     STARTY+80, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "지 번"),
		DLG_BUTTON( STARTX+220, STARTY+80, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "도로명"),

		DLG_TEXT(   STARTX+350, Line(1), 300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//현재페이지/총페이지 , BTNMENUFRCOLOR, BTNCTRLBKCOLOR

		DLG_BUTTON( STARTX    , Line(1), 300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "자료삭제"),
		DLG_BUTTON( STARTX+680, Line(1), 300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SND, "자료송신"),

		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}
				SetBtnImg();
				REDRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);		
		if( m_bFirst == INIT_MAIN )
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//타이틀
		
		if( theDevInfo.m_nType != FAMILY_PDA )
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
		}
		
		
		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), FALSE );
		}
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
	}

//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
	long index = -1;
	
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			Str_Cpy( g_szCHK_EXEC_NUM , DlgTbl_GetStr( ID_TBLLIST, index-1, 3)  );
			
			m_nActIndex = index-1;
			
		}		
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_ADDR:
				g_nAddrFlag = 0;
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
				REDRAW();
				break;
			
			case BID_ADDR2:
				g_nAddrFlag = 1;
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), FALSE );
				REDRAW();
				break;
				
			case BID_DEL:
				if(Str_Len(g_szCHK_EXEC_NUM) == 0 || m_nActIndex == -1 )
				{
					MessageBoxEx (CONFIRM_OK, "선택된 자료가 없습니다.");
					break;
				}
				Del_Data();
				REDRAW();
				break;


			case BID_SND:
				if(Str_Len(g_szCHK_EXEC_NUM) == 0 || m_nActIndex == -1 )
				{
					MessageBoxEx (CONFIRM_OK, "선택된 자료가 없습니다.");
					break;
				}

				if( Str_Cmp( DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4), "90") == 0 )
				{
					g_Snd_RstMin_690(0);
				}
				else
				{
					Snd_RstMin();
				}
				
				REDRAW();
				break;
				
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
					m_lpage = 0;
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
					m_lpage = m_lTotpage-1;
				REDRAW();
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
	
	
	
			
	
	
//------------------------------------------------------------------------------------------
	bool REDRAW(void)
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	char sztmp[1000];
	char szbuf[100];
	char szSql[200];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		g_Sql_RetInt("SELECT COUNT(*) FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S'  ", &m_lTotpage);
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage,0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, "SELECT PDA_DUTY, CHK_TIME_END, COUNTY,TOWN, VILLAGE_RI,ADDR1_M, ADDR1_S \
											    , Length( ifnull(Trim(VILLAGE),'') ) + Length( ifnull(Trim(BUILDING),'') ), Trim(VILLAGE), Trim(BUILDING) \
											    , HOUSE_CNT, ETC_ADDR, ADDR1_M, ADDR1_S, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S, PROMISE_ASSIGN_SEQ, PDA_DUTY_FLAG \
											 FROM C6101_PROMISE_ASSIGN WHERE SEND_YN = 'S' LIMIT ?, ? " );
		//WHERE SEND_YN = 'S'
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				k = i + 1;
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				//idx = 0;
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				Mem_Cpy( (byte*)szbuf, (byte*)sztmp+8 , 2);
				szbuf[2] = ':';
				Mem_Cpy( (byte*)szbuf+3, (byte*)sztmp+10 , 2);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, szbuf );
				
							
				if( g_nAddrFlag == 0)
				{		
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 2, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 3, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 4, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 5, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 6, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					if(Str_Len(sztmp) < 25 )
						Str_Cat( sztmp, "\n");
					else
						Str_Cat( sztmp, " ");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 7, 'U', (long*)szbuf, 4, DECRYPT);
					if( Str_AtoI(szbuf) > 0 )
					{
						
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 8, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 9, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, "-");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 10, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 11, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					else
					{
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 12, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, "-");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 13, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 10, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
						Str_Cat( sztmp, " ");
						Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
						sql->GetValue(sql, 11, 'U', (long*)szbuf, 100, DECRYPT);
						Str_Cat( sztmp, szbuf);
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				}
				else
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 2, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");

					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 14, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, " ");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 15, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);
					Str_Cat( sztmp, "-");
					Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
					sql->GetValue(sql, 16, 'U', (long*)szbuf, 100, DECRYPT);
					Str_Cat( sztmp, szbuf);

					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				}
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, 17, 'U', (long*)szbuf, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, szbuf );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 18, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );	
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		
		if(m_lTotpage > 0 )
		{
			m_nActIndex = 0;
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
				
			Str_Cpy( g_szCHK_EXEC_NUM , DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3)  );
		}
		else
		{
			m_nActIndex = -1;
			Mem_Set( (byte*)g_szCHK_EXEC_NUM, 0x00, sizeof(g_szCHK_EXEC_NUM) );
		}
		
		ON_DRAW();
		return TRUE;
	}
	
	
	void Del_Data(void)
	{
	char szSql[300];
		
		if( MessageBoxEx (CONFIRM_YESNO, "선택된 자료를 삭제 하시겠습니까?") != MB_OK )
		{
			return;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE C6101_PROMISE_ASSIGN SET SEND_YN = 'D' WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);
		
		/*
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM  C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM  C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM  C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM  C6101_ONCE_INFO WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM  C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM  C6101_CHG_MTR_INFO WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM  C6101_PRE_CUST_INFO WHERE PROMISE_ASSIGN_SEQ = '%s' ",  g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_DirectExecute(szSql);
		*/
	}
	
	
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
		
		if( Load_Assign(g_szCHK_EXEC_NUM)  < 0) // 민원대상정보를 갖고온다.
			return;

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
		//실제운영 없음.
		JSON_SetValue( g_pjcomm, 'C', "req_info_num"          , stMw.szReq_info_num         );
		//JSON_SetValue( g_pjcomm, 'C', "req_info_num"          , ""           );
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
		JSON_SetValue( g_pjcomm, 'C', "prod_chg"              , stMw.szProd_chg               );
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
		JSON_SetValue( g_pjcomm, 'C', "chk_cable"             , "N"       );
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

		Mem_Set( (byte*)szUcovert, 0x00, sizeof(szUcovert) );
		SPRINT(szUcovert, "SELECT length( CUST_CONF_SIGN ) FROM C6101_PROMISE_ASSIGN  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szUcovert, &ret );
		signimg = Mem_Alloc( ret +5);
		Mem_Set( signimg, 0x00, ret+5 );
		Mem_Set( (byte*)szUcovert, 0x00, sizeof(szUcovert) );
		SPRINT(szUcovert, "SELECT CUST_CONF_SIGN FROM C6101_PROMISE_ASSIGN  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szUcovert, ret ,(char*)signimg );		
		JSON_SetValue( g_pjcomm, 'C', "cust_conf_sign_b"   ,signimg );
		Mem_Free(signimg);
			
		/*
		if(Str_Len(stMw.szBar_why) > 1 )
		{
			Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
			SPRINT (szScrPht, "%s/%sM.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
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
				JSON_SetValue( g_pjcomm, 'C', "mtr_photo"   ,szfile );
				free((byte*)signimg);
				BASE64_Finalize(file);
				file = NULL;
			}
			Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
			SPRINT (szScrPht, "%s/%sP.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
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
				JSON_SetValue( g_pjcomm, 'C', "inst_photo"   ,szfile );
				free((byte*)signimg);
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		*/
		
		//바코드스캔 or 사진정보
		Add_Bo(g_pjcomm); 			//보일러수정정보
		Add_Bur(g_pjcomm); 			//연소기수정정보
		Add_Once(g_pjcomm);			//일회성비용
		Add_Mtr(g_pjcomm);  		//지침, 중지, 해지정보
		Add_ChgMtr(g_pjcomm);		//계량기교체 서명+사진추가한다.
		Add_Nonpay(g_pjcomm);		//미납, 정산 데이터 추가한다.
		Add_CardInfo(g_pjcomm);		//카드결재 결과를 추가한다.
		//Add_OneCardInfo(g_pjcomm);	//일회성 카드 결제 결과를 추가한다.
		Add_Chk(g_pjcomm);		    //가스누설점검 데이터를 추가한다.
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		g_SeverConnection();
		PRINT("stMw.szProd_chg : %s",stMw.szProd_chg,0,0);
		callBackfunc = Rcv_RstMIn; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR68302_IN",  "FR68302" , sndbuf, szbuf );
	}
	
	long Rcv_RstMIn(void)
	{
		char szSql[200];
	
		g_Sock_Close();
		
		if( g_Chk_Json(68302) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE C6101_PROMISE_ASSIGN SET SEND_YN = 'Y' WHERE Promise_assign_seq = '%s' ", g_szCHK_EXEC_NUM, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			if( Str_Cmp( stMw.szInfo_Trans_yn, "Y") == 0 )
			{
			    Snd_Info_Trans();
			    ON_DRAW();
			    return 1;
			}
			else
			{
				REDRAW();
				ON_DRAW();
				return 1;
			}			
		}
		else
		{
			MessageBoxEx (ERROR_OK, "서버 적용실패.");
			ON_DRAW();
			return -1;
		}
	}
	
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
	    
	    callBackfunc = Rcv_Info_Trans; //통신완료 후에 호출 함수
	    ret = HTTP_DownloadData(szUrl, "FR68303_IN",  "FR68303" , sndbuf, szbuf );
	}
	
	//------------------------------------------------------------------
	long Rcv_Info_Trans(void)
	{
	    char szSql[200];
	
	    g_Sock_Close();
	    
	    REDRAW();
	    ON_DRAW();
		
	    return 0;
	}
	
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
,TOWN,VILLAGE_RI,VILLAGE,BUILDING,ADDR1_M \
,ADDR1_S,ACCOUNT,ONCE_ACCOUNT,CHK_TIME_FROM \
,CHK_TIME_END,MTR_CHG_YN,INFO_USE_AGREE_YN,PAS_USE_CONT_NUM_YN,ADJ_ALT_AMT \
,PAS_DEFRAY_ACCOUNT_NUM,PAS_CUST_NUM,PAS_REQ_INFO_NUM,APPRO_NUM,APPRO_TEL,ADJ_CAUSE \
,DEADLINE_FLAG,GMTR_BASE_DAY,CARD_GASPAY,CARD_ONEPAY,CASH_GASPAY \
,INFO_USE_YN,USE_CONT_DOC_YN,PAY_METHOD,DEFRAY_ACCOUNT_NUM,DEPOSITOR_NM \
,BANK_NM,DEBT_AMT,LAW_ETC_AMT,LAW_TOWN,NEW_ROAD_NM \
,NEW_ADDR_M,NEW_ADDR_S,NEW_ADDR_UNION,BILL_GUBUN,TRANS_CONN_YN \
,CONN_YN,BAR_YN,BAR_GBN,BAR_WHY,CHK_YN,CONN_GBN, APPRO_STATUS_FLAG, APPRO_GUBUN, INFO_TRANS_YN, SEND_INFO_TRANS_YN, PROD_CHG \
FROM C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = ? AND SEND_YN = 'S' ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)assign_seq , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
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
//		sql->Commit(sql);
		DelSqLite(sql);
		
		return ret;
	}
	
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
		//sql->Commit(sql);
		DelSqLite(sql);

		return ret;
	}
	
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
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInduc_inst_yn       ,2+1 , DECRYPT);
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
			
			ret =1;
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
	
	
	long Add_Once(handle pj)
	{
	long ret = -1;
	long idx = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	handle js = NULL;
	char szcivil_serv_receive_num[14+1]; //
	char sztreat_seq             [2 +1]; //
	char szuse_cont_num          [10+1]; //
	char szonce_item_cd          [6 +1]; //
	char szcenter_cd             [2 +1]; //
	char szstr_apply_ymd         [8 +1]; //
	char szonce_unit_prc         [12+1]; //
	char szonce_qty              [5 +1]; //
	char szonce_amt              [12+1]; //
	char szexcept_yn             [1 +1]; //
	char szpay_promise_yn        [1 +1]; //
	char szbuilt_in_yn           [1 +1]; //
		
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

		//업무별 항목 구분은 어떻게 ?	
		hstmt = sql->CreateStatement(sql, "SELECT CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ,USE_CONT_NUM,ONCE_ITEM_CD,CENTER_CD \
,STR_APPLY_YMD,ONCE_UNIT_PRC,ONCE_QTY,ONCE_AMT,EXCEPT_YN,PAY_PROMISE_YN,BUILT_IN_YN \
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
			sql->GetValue(sql, idx++, 'U', (long*)szcivil_serv_receive_num,14+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)sztreat_seq             ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szuse_cont_num          ,10+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_item_cd          ,6 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szcenter_cd             ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szstr_apply_ymd         ,8 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_unit_prc         ,12+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_qty              ,5 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_amt              ,12+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szexcept_yn             ,1 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szpay_promise_yn        ,1 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szbuilt_in_yn           ,1 +1 , DECRYPT);
				
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
				JSON_SetArrayItem(js, 'C', "pay_promise_yn"         , "Y"          );
			else
				JSON_SetArrayItem(js, 'C', "pay_promise_yn"         , szpay_promise_yn );
			
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
			JSON_Attach(pj, "one", js);
		
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
	
	PRINT("333333333333333",0,0,0);
		
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
INDI_VA,INDI_VM, KEEPER_YN, SEALED_STS, CONT_REVIS_PARA, BIZ_TYPE_CD, PROD_CD, BILL_GUBUN, ACCOUNT,INST_PLACE_NUM , PROD_STS_CD , CONT_FLAG_CD \
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
			Mem_Set( (byte*)szInst_place_num,0x00, sizeof(szInst_place_num));
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
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "10" ); //전출
			else if( g_nWorkFlag == 630 )
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "20" ); //중지
			else
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "" ); //기타
				
			if(stMw.szZip_no1[0] == '4' )
				JSON_SetArrayItem(js, 'C', "prod_area_flag" , "20"  );
			else
				JSON_SetArrayItem(js, 'C', "prod_area_flag" , "10"  );
			
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

			PRINT("szProd_sts_cd : %s",szProd_sts_cd,0,0);
			PRINT("szCont_flag_cd : %s",szCont_flag_cd,0,0);
		};
		
		if( ret == 1)
			PRINT("civil_serv_receive_num : %s",szcivil_serv_receive_num,0,0);
			JSON_Attach(pj, "mtr", js);
		
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
	
	long Add_ChgMtr(handle pj)//서명+사진추가한다.
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
,INST_INDI_VM,INST_INDI_VA,INST_INDI_VC,JOB_DTM,CENTER_CD ,INST_PLACE_NUM ,IFNULL(BATTERY_YN,'') , IFNULL(OTHER_PRICE,'') , IFNULL(MTRDISPLAY_YN,'') , IFNULL(REMOTE_SYSTEM,'') , OLD_MTR_ID_NUM\
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
			
			PRINT("stChgMtr.remote_system : %s",stChgMtr.remote_system,0,0);
			
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
			JSON_Attach(pj, "chgmtr", js);
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
	
	long Add_Nonpay(handle pj)//정산데이터 추가한다.
	{
	long ret = -1;
	long idx = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	handle js = NULL;
	char szUse_cont_num [10+1];//
	char szProd_cont_seq[3 +1];//
	char szReq_ym       [6 +1];//
	char szDeadline_flag[2 +1];//
	char szChk          [1 +1];//
	char szCard_yn      [1 +1];//
	char szUnpay_amt    [10+1];//
	char szMtr_num      [10+1];//
	
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
	
		hstmt = sql->CreateStatement(sql, "select USE_CONT_NUM, PROD_CONT_SEQ, REQ_YM, \
DEADLINE_FLAG, CHK, CARD_YN, UNPAY_AMT, MTR_NUM \
from C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? \
UNION \
select USE_CONT_NUM, PROD_CONT_SEQ, REQ_YM, \
DEADLINE_FLAG, CHK_YN AS CHK, CARD_YN, ACCOUNT AS UNPAY_AMT, MTR_NUM \
from C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ? AND ACCOUNT > 0  ");
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
				JSON_SetArrayItem(js, 'C',  "adj_type_cd"  ,"20"     );
			else
				JSON_SetArrayItem(js, 'C',  "adj_type_cd"  ,""     );
				
			ret =1;
		};
		
		if( ret ==1)
			JSON_Attach(pj, "nonpay", js);
		
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
	
	
	long Add_CardInfo(handle pj)//카드결재결과를 추가한다.
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
			
			//Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			//Mem_Cpy( (byte*)szUcovert, (byte*)stCardinfo.szApproval_time, 6 );
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
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
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
			for( i = 0; i < Str_Len( stOneCardinfo.szCard_num ) ; i++)
			{
				if( stOneCardinfo.szCard_num[i] == '=' )
				{
					len = i;
					break;
				}
			}
			Mem_Cpy( (byte*)szUcovert, (byte*)stOneCardinfo.szCard_num, len );
			
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
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	//------------------------------------------------------------------
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
	
}



