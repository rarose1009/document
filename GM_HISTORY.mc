/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_HISTORY
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
//고객이력
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_HISPREV )
		DEF_BUTTON_ID ( BID_HISNEXT )
		DEF_BUTTON_ID ( BID_MEMOPREV )
		DEF_BUTTON_ID ( BID_MEMONEXT )
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
		DEF_OBJECT_ID ( TXT_BORDER )
//고객이력
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )

		DEF_OBJECT_ID ( ICON_TITLE )		//타이틀
		
//고객이력
		DEF_OBJECT_ID ( ID_HISLIST )	// 테이블 리스트
		DEF_OBJECT_ID ( ID_MEMOLIST )	// 테이블 리스트
				
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
		
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
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(고객이력)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_H 	    10					// table의 행개수
	#define		COL_H 	    2					// table의 열개수
	#define		GRID_H_H	(CHT+38)			// table 행 높이
	#define		GRID_CLR_H	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_H	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_H	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_H	STARTY-29  	    	// table 시작y좌표
	#define		GRID_Y_H_P  STARTY-40  	   	 // table 시작y좌표
	#define		GRID_ENDY_H	(GRID_Y_H+(ROW_H+1)*GRID_H_H) //table마지막 row의 Y값
	
	char	m_szTableBuf_H [COL_H*(ROW_H+1)*MAXCHAR_H]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_H[] = {
		{"일자"      , CWD*12 ,     EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"민원분류"  , CWD*27+23 ,  EDITALIGN_LEFT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};

	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들(메모)
	//-------------------------------------------------------------------------------------------------
	#define		ROW_M	    4					// table의 행개수
	#define		COL_M	    2					// table의 열개수
	#define		GRID_H_M	(CHT+10)			// table 행 높이
	#define		GRID_CLR_M	TRANSPARENT   		// table 클리어 color
	#define		GRID_X_M	STARTX 			    // table 시작x좌표
	#define		MAXCHAR_M	201 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y_M	STARTY+470	 	    // table 시작y좌표
	#define		GRID_Y_M_P  STARTY+40  		    // table 시작y좌표
	#define		GRID_ENDY_M	(GRID_Y_M+(ROW_M+1)*GRID_H_M) //table마지막 row의 Y값
	
	char	m_szTableBuf_M [COL_M*(ROW_M+1)*MAXCHAR_M]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle_M[] = {
		{"일자"        , CWD*11    , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"특이사항"    , CWD*28+23 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};

	long m_lpage_H = 0;			// 현재 페이지
	long m_lpage_M = 0;			// 현재 페이지
	long m_lTotpage_H = 0;		// 총 페이지
	long m_lTotpage_M = 0;		// 총 페이지
	long m_nActIndex_H = -1;		//선택된 row index
	long m_nActIndex_M = -1;		//선택된 row index
	char m_szCnt_page_H[20];		// 페이지 표시 변수
	char m_szCnt_page_M[20];		// 페이지 표시 변수

	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);

	long Rcv_History(void);
	long TR24265(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "고객이력"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
		
		DLG_BUTTON(STARTX+250,   STARTY+823, 250, 76, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+823, 250, 76, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISNEXT, "▼"),
		DLG_BUTTON(STARTX+750,   STARTY+823, 249, 76, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),

		//DLG_TEXT(STARTX,       STARTY+515, 993, 310, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,       STARTY+823, 250, 76, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, m_szCnt_page_H),
		
		// 리스트
		DLG_TABLE (GRID_X_H, GRID_Y_H, ROW_H, COL_H, 0, GRID_H_H, 1, GRID_H_H, SEL_ROW, MAXCHAR_H, m_stGridTitle_H, ID_HISLIST, m_szTableBuf_H),
		//DLG_TABLE (GRID_X_M, GRID_Y_M, ROW_M, COL_M, 0, GRID_H_M, 1, GRID_H_M, SEL_ROW, MAXCHAR_M, m_stGridTitle_M, ID_MEMOLIST, m_szTableBuf_M),
	};	
	
	// 고객이력 PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "고객이력"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX+250,   STARTY+823, 250, 76, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISPREV, "▲"),
		DLG_BUTTON(STARTX+500,   STARTY+823, 250, 76, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HISNEXT, "▼"),
		DLG_BUTTON(STARTX+750,   STARTY+823, 249, 76, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "확인"),

		//DLG_TEXT(STARTX,       STARTY+515, 993, 310, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,       STARTY+823, 250, 76, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, m_szCnt_page_H),
		
		// 리스트
		DLG_TABLE (GRID_X_H, GRID_Y_H_P, ROW_H, COL_H, 0, GRID_H_H, 1, GRID_H_H, SEL_ROW, MAXCHAR_H, m_stGridTitle_H, ID_HISLIST, m_szTableBuf_H),
		//DLG_TABLE (GRID_X_M, GRID_Y_M, ROW_M, COL_M, 0, GRID_H_M, 1, GRID_H_M, SEL_ROW, MAXCHAR_M, m_stGridTitle_M, ID_MEMOLIST, m_szTableBuf_M),
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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				if (g_nWorkFlag / 100 == 6) // 민원에서 호출한 경우
				{
					TR24265();
				} 
				else 
				{
					Rcv_History();
				}
				
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_OK:
				if( g_nWorkFlag == 100 || g_nWorkFlag == 101 || g_nWorkFlag == 102 )
				{
					Card_Move("GM_LST");
				}
				else if( g_nWorkFlag == 103 )
				{
					Card_Move("GM_NOGMLST");
				}
				else if( g_nWorkFlag == 104 )
				{
					Card_Move("GM_ABSNCLST");
				}
				else
				{
					Card_Prev();
				}
				break;
			case BID_HISPREV:
				m_lpage_H--;
				if(m_lpage_H < 0)
				{
					m_lpage_H = 0;
					if(m_lTotpage_H > 0)
					{
						if( m_nActIndex_H < 0)
						{
							m_nActIndex_H = 0;
						}
					
						DlgTbl_SetActive(ID_HISLIST , m_nActIndex_H+1 );
						DlgTbl_SetRowColor(ID_HISLIST, m_nActIndex_H+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex_H = 0;
				ReDraw();
				break;
			case BID_HISNEXT:
				m_lpage_H++ ;
				if( m_lpage_H > m_lTotpage_H-1 )
				{
					m_lpage_H = m_lTotpage_H-1;
					if(m_lpage_H < 0)
					{
						m_lpage_H = 0;
					}
					if(m_lTotpage_H > 0)
					{
						if( m_nActIndex_H < 0 )
						{
							m_nActIndex_H = 0;
						}
					
						DlgTbl_SetActive(ID_HISLIST , m_nActIndex_H+1 );
						DlgTbl_SetRowColor(ID_HISLIST, m_nActIndex_H+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex_H = 0;
				ReDraw();
				break;
			case GID_HOME:
				break;
			case GID_MENU:
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
				if( g_nWorkFlag == 100 || g_nWorkFlag == 101 || g_nWorkFlag == 102 )
				{
					Card_Move("GM_LST");
				}
				else if( g_nWorkFlag == 103 )
				{
					Card_Move("GM_NOGMLST");
				}
				else if( g_nWorkFlag == 104 )
				{
					Card_Move("GM_ABSNCLST");
				}
				else
				{
					Card_Prev();
				}
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		
	
//──────────────────────────────────────────────
	void	OnSelect(long Index)
	{
		long index = -1;
		
		//현재 TBL이 선택되었는지를 확인
		if (DlgTbl_IsSelect(ID_HISLIST))
		{
			// 현재 선택된 인덱스
			index = DlgTbl_GetActiveRow(ID_HISLIST);
			// 선택 인덱스와 기존 인덱스가 동일 할 경우
			if ( index-1 == m_nActIndex_H )
			{
				return;
			}
			else
			{
				m_nActIndex_H = index - 1;//선택된 INDEX 저장
			
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_HISLIST, m_nActIndex_H, 1));
			}
		}
	}

	
	//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		//EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA1), TRUE, 2, EDITSEP_NONE );
	}	
	
	//------------------------------------------------------------------
	void ReDraw(void)
	{
	long i, idx;
	long k = ROW_H + 1;
	char sztmp[500];
	char szDate[50];
	long ret = -1;	
	long lstartidx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();


		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lTotpage_H );
		
		if( m_lTotpage_H % ROW_H > 0 )
		{
			m_lTotpage_H = (m_lTotpage_H / ROW_H) + 1;
		}
		else
		{
			m_lTotpage_H = m_lTotpage_H / ROW_H;
		}
		//페이지
		SPRINT(m_szCnt_page_H, "%d/%d", m_lpage_H+1, m_lTotpage_H, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2 FROM RCV_TMP LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage_H*ROW_H;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage_H*ROW_H+ROW_H;
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
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_HISLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_HISLIST, i, 1, "" );
					continue;
				}
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				//g_Str_DateType( szDate, sztmp);
				DlgTbl_SetStr ( ID_HISLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 450, DECRYPT);
				DlgTbl_SetStr ( ID_HISLIST, i, 1, sztmp );
			}
		}		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage_H > 0)
		{
			if( m_nActIndex_H < 0 )
			{
				m_nActIndex_H = 0;
			}
		
			DlgTbl_SetActive(ID_HISLIST , m_nActIndex_H+1 );
			DlgTbl_SetRowColor(ID_HISLIST, m_nActIndex_H+1, TABLEACTIVE_COLOR);

			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_HISLIST, m_nActIndex_H, 1));
		}


		ON_DRAW();
		return;
	}
	
	
	//------------------------------------------------------------------
	long Rcv_History(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
	
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24265, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",        	g_szINST_PLACE_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR24265; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR24265_IN",  "FR24265" , sndbuf, sztmp );
		return 0 ;
	}
	
	//------------------------------------------------------------------
	long TR24265(void)
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(24265) >= 0)
		{
			ReDraw();
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

}



