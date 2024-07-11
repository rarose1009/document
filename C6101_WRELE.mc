/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WRELE
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
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_WCUST )	//
		DEF_BUTTON_ID ( BID_WMTR )	//
		DEF_BUTTON_ID ( BID_WBUR )	//
		DEF_BUTTON_ID ( BID_WCHK )	//
		DEF_BUTTON_ID ( BID_WONE )	//
		DEF_BUTTON_ID ( BID_WSTOP )	//
		DEF_BUTTON_ID ( BID_WRELE )	//
		DEF_BUTTON_ID ( BID_WPAY )	//
		DEF_BUTTON_ID ( BID_CLOSE )	//
		
		DEF_BUTTON_ID ( BID_RELE )	//
		DEF_BUTTON_ID ( BID_UP )	//
		DEF_BUTTON_ID ( BID_DOWN )	//
		
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
		DEF_OBJECT_ID ( TXT_TITLE )	//
		DEF_OBJECT_ID ( ICON_TITLE )//
		DEF_OBJECT_ID ( TAB_COVER )	//
		DEF_OBJECT_ID ( TAB_LINE )	//
		DEF_OBJECT_ID ( TXT_PAGE )	//
	
		DEF_OBJECT_ID ( TTL_CUT_YMD )	//
		DEF_OBJECT_ID ( TXT_CUT_YMD )	//
		DEF_OBJECT_ID ( TTL_KEEPER_YN )	//
		DEF_OBJECT_ID ( TXT_KEEPER_YN )	//
		DEF_OBJECT_ID ( TTL_CUT_CNL_YMD )//
		DEF_OBJECT_ID ( TXT_CUT_CNL_YMD )//
		DEF_OBJECT_ID ( TTL_GUBUN )	//
		DEF_OBJECT_ID ( TTL_CUT )	//
		DEF_OBJECT_ID ( TTL_CUT_CNL )//
		DEF_OBJECT_ID ( TTL_VC )	//
		DEF_OBJECT_ID ( TTL_VA )	//
		DEF_OBJECT_ID ( TTL_VM )	//

		DEF_OBJECT_ID ( TXT_INDI_CUT_VC_AFTER )	//
		DEF_OBJECT_ID ( TXT_INDI_CUT_VA_AFTER )	//
		DEF_OBJECT_ID ( TXT_INDI_CUT_VM_AFTER )	//
		DEF_OBJECT_ID ( TXT_INDI_VC )	//
		DEF_OBJECT_ID ( TXT_INDI_VA )	//
		DEF_OBJECT_ID ( TXT_INDI_VM )	//
		DEF_OBJECT_ID ( ID_TBLLIST )
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1

	#define		W_MAIN		CWD*39+10
	#define		H_MAIN		CHT*21
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    2					// table의 행개수
	#define		COL 	    4					// table의 열개수
	#define		GRID_H		(CHT+15)			// table 행 높이
	#define		GRID_H_P	(CHT+48)			// table 행 높이 PDA
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+70  	    //table 시작y좌표
	#define		GRID_Y_P	STARTY+200  	    //table 시작y좌표 PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (GRID_ENDY+15+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = {
		{"기물번호", CWD*18+23,  EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"설치위치", CWD*11, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상태"    , CWD*10,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"MTR_NUM" , CWD*0,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	 	 
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	long m_bFirst;
	char m_szCnt_index[11];     //인덱스 문자열(현재 페이지)
	long m_lpage;
	long m_lTotpage;
	long m_lActIndex;
	long m_lActRow;
		
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void Draw_Tb(void);
	void Save_Mtr(void);
	void Save_MtrRele(void);
	
	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCUST, "고객"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "연소기"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "정산"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WONE, "일회성"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WPAY, "요금"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "중지"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_WRELE, "해제"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "점검"),
		//DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	

		DLG_BUTTON( STARTX,     	  GRID_ENDY+25, 200,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+200,  	  GRID_ENDY+25, 200,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_TEXT(  STARTX+1000-CWD*9,  GRID_ENDY+25, CWD*9, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),
		
		DLG_TEXT( STARTX,     Line(1)+35,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CUT_YMD, "중지일자"),
		DLG_TEXT( STARTX+240, Line(1)+35,  759, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CUT_YMD, ""),
		DLG_TEXT( STARTX,     Line(2)+35,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_KEEPER_YN, "키퍼도구"),
		DLG_TEXT( STARTX+240, Line(2)+35,  759, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_KEEPER_YN, ""),
		DLG_TEXT( STARTX,     Line(3)+35,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CUT_CNL_YMD, "해지일자"),
		DLG_TEXT( STARTX+240, Line(3)+35,  759, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CUT_CNL_YMD, ""),

		DLG_TEXT( STARTX,     Line(4)+65,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_GUBUN,   "구분"),
		DLG_TEXT( STARTX+240, Line(4)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CUT,     "중지지침"),
		DLG_TEXT( STARTX+620, Line(4)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_CUT_CNL, "해제지침"),
		DLG_TEXT( STARTX,     Line(5)+65,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_VC, "Vc"),
		DLG_TEXT( STARTX+240, Line(5)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_CUT_VC_AFTER, ""),
		DLG_EDIT( STARTX+620, Line(5)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VC,10, ""),
		DLG_TEXT( STARTX,     Line(6)+65,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_VA, "Va"),
		DLG_TEXT( STARTX+240, Line(6)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_CUT_VA_AFTER, ""),
		DLG_EDIT( STARTX+620, Line(6)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VA,10, ""),
		DLG_TEXT( STARTX,     Line(7)+65,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_VM, "Vm"),
		DLG_TEXT( STARTX+240, Line(7)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_CUT_VM_AFTER, ""),
		DLG_EDIT( STARTX+620, Line(7)+65,  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VM,10, ""),
		
		DLG_BUTTON( STARTX+700, Line(9)+40, 300, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RELE,"해제등록"),
	};	


	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
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
	
		m_bFirst = bFirst;
		
		g_nWorkFlag = 640;
		
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						Draw_Tb();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						Draw_Tb();
						break;
				}
				break;
		
		}
		
		SetBtnImg();
		SetStyle();
		ReDraw();
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
				}
				m_lActRow = 0;
				Draw_Tb();
				ReDraw();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
				}
				m_lActRow = 0;
				Draw_Tb();
				ReDraw();
				break;
				
			case BID_RELE:
				Save_MtrRele();
				break;
			case BID_WCUST:
				Card_Move("C6101_WCUST");
				break;
			case BID_WMTR:
				Card_Move("C6101_WMTR");
				break;
			case BID_WBUR:
				Card_Move("C6101_WBUR");
				break;
			case BID_WCHK:
				Card_Move("C6101_WCHK");
				break;
			case BID_WONE:
				Card_Move("C6101_WONE");
				break;
			case BID_WSTOP:
				Card_Move("C6101_WSTOP");
				break;
			case BID_WRELE:
				//Card_Move("C6101_WRELE");
				break;
			case BID_WPAY:
				Card_Move("C6101_WPAY");
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
				Card_Move("C6101_LST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
				
			case BID_CLOSE:
				if( MessageBoxEx (CONFIRM_YESNO, "작업리스트 화면으로 나가시겠습니까?")  == MB_OK)
				{
					Card_Move("C6101_LST");
				}
				break;
		}
	}
	
	void	OnSelect(long Index)
	{
		long index = -1;
		char szcmb[20];
		char szAddr[200];
		
		if( INIT_MAIN == m_bFirst )
		{
			//현재 TBL이 선택되었는지를 확인
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
				Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, index-1, 3)  );
				ReDraw();
				
				m_lActRow = index-1;
			}
		}
	}
	
	void	OnChar(long nChar)
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( Get_iDlgCtrlByID(TXT_INDI_VC) == m_lActIndex )
			{
				//숫자만 입력 가능
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY(5);
					return;
				}
			}
			else if( Get_iDlgCtrlByID(TXT_INDI_VA) == m_lActIndex )
			{
				//숫자만 입력 가능
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY(5);
					return;
				}
			}
			else if( Get_iDlgCtrlByID(TXT_INDI_VM) == m_lActIndex )
			{
				//숫자만 입력 가능
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "숫자만 입력가능합니다.");
					ON_KEY(5);
					return;
				}
			}
		}
	}
	
	
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		m_lActIndex = lActiveIndex;
		
		if( m_bFirst == INIT_MAIN )
		{
			Save_Mtr();
			
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+620) && X < DMS_X(STARTX+1000) && Y > DMS_Y(Line(5)+65-(g_Dlgflag*400)) && Y < DMS_Y(Line(8)+65-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(TXT_INDI_VC) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_INDI_VA) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_INDI_VM) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);		
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
	}

	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
	long sX[8], eX[8];
	long lenX;
	long i;
	long TABCNT;
	long starty, highty;
	
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
			Mem_Set((byte*)&sX , 0x00, sizeof(sX));
			Mem_Set((byte*)&eX , 0x00, sizeof(eX));
			//610:전입[고객, 연소기, 상품, 일회성, 요금 ]
			//620:전출[고객, 연소기, 정산,  일회성, 요금 ]
			//630:중지[고객, 정산, 중지, 일회성, 요금 ]
			//640:해제[고객, 해제, 일회성, 요금 ]
			//650:교체[고객, 연소기, 일회성, 요금 ]
			//660:점검[고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
			
			if(   g_nWorkFlag == 640 || g_nWorkFlag == 650 )
			{
				TABCNT = 4;
				//lenX = CWD*9+20;
				lenX = CWD*10;
				
				sX[0] = 0;
			}
			else
			{
				TABCNT = 5;
				//lenX = CWD*7+19;
				lenX = CWD*8;
				
				sX[0] = 0;
			}
			
			//sX[0] = 20;
			for(i = 0 ; i < TABCNT ; i++)
			{
				//eX[i] = sX[i] + lenX+5;
				eX[i] = sX[i] + lenX;
				sX[i+1] = eX[i];
			}
			starty = STARTY-29;
			highty = STARTY+40;
			
			i = 0;
			//업무별공통 업무[고객, 계량기, 연소기]
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  stMw.szPda_duty );
			
			//각 업무에 따라 탭을 없앰.
			if( g_nWorkFlag == 610 )
			{
				//610:전입[고객, 연소기, 상품, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );
				
			}
			else if( g_nWorkFlag == 620 )
			{
				//620:전출[고객, 연소기, 정산,  일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST),sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "정산" );
			}
			else if( g_nWorkFlag == 630 )
			{
				//630:중지[고객, 정산, 중지, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// 연소기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WSTOP), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "정산" );
			}
			else if( g_nWorkFlag == 640 )
			{
				//640:해제[고객, 해제, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// 연소기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // 중지
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WRELE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				//선택된 탭을 활성화된것처럼 보이게 함.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[1]+4, highty-5, eX[1]-4, highty+5 );
				
			}
			else if( g_nWorkFlag == 650 )
			{
				//650:교체[고객, 연소기, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			}
			else if( g_nWorkFlag == 660 )
			{
				//660:점검[고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCHK), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			}
		}
	}

//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUT_YMD ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUT_YMD ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_KEEPER_YN ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEEPER_YN ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUT_CNL_YMD ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUT_CNL_YMD ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUT ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUT_CNL ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VC ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VA ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_CUT_VC_AFTER ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_CUT_VA_AFTER ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_CUT_VM_AFTER ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VC ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VA ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VM ), EDITALIGN_MIDDLE);
		}
	}
	
	
	void Draw_Tb(void)
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	char sztmp[100];
	char szSql[100];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);
		
		SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, "SELECT MTR_ID_NUM, MTR_LOC_FLAG_NM, PROD_STS_CD, MTR_NUM FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = ? ORDER BY MTR_ID_NUM LIMIT ?, ? " );
		
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
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
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 26, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);

				if(Str_Cmp(sztmp, "10") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "정상" );
				else if(Str_Cmp(sztmp, "20") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "중지" );
				else if(Str_Cmp(sztmp, "30") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "해지" );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lActRow < 0 )
			m_lActRow = 0;
		
		if( m_lTotpage > 0)
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActRow+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActRow+1, TABLEACTIVE_COLOR);
				
			Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
			Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
		}
		
		ON_DRAW();
	}
	
	
	void ReDraw(void)
	{
	char sztmp[51];
	char szSql[201];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	long i;


		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		

		hstmt = sql->CreateStatement(sql," select CUT_YMD, KEEPER_YN, INDI_CUT_VC_AFTER, INDI_CUT_VA_AFTER, INDI_CUT_VM_AFTER, INDI_VC,INDI_VA,INDI_VM, REVIS_FLAG from C6101_PROMISE_MTR where PROMISE_ASSIGN_SEQ = ? and MTR_NUM = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)stMtr.szPromise_assign_seq, 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stMtr.szMtr_num, 10, DECRYPT);


		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szCut_ymd            ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szKeeper_yn          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_cut_vc_after  ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_cut_va_after  ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_cut_vm_after  ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vc            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_va            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vm            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szRevis_flag         ,2  +1, DECRYPT );
			
		}

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Str_DateType( sztmp, stMtr.szCut_ymd );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CUT_YMD ), sztmp );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );//키퍼
		SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID= 'C30107' AND  CODE_ITEM ='%s' ",stMtr.szKeeper_yn, 0, 0   );
		g_Sql_RetStr( szSql, 50, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_KEEPER_YN ), sztmp );

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)stMtr.szCut_cnl_ymd, 0x00, sizeof(stMtr.szCut_cnl_ymd) );
		Str_ItoA( Time_GetDate(), stMtr.szCut_cnl_ymd, 10 );
		g_Str_DateType( sztmp, stMtr.szCut_cnl_ymd );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CUT_CNL_YMD ), sztmp );

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VC_AFTER ), stMtr.szIndi_cut_vc_after );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VC ), stMtr.szIndi_vc);
		
		
		if( g_nStopReleFlag == 1)
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_RELE), RED); 
		else
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_RELE), BTNMENUFRCOLOR);

		
		if(Str_Cmp(stMtr.szRevis_flag, "10") == 0)
		{
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VA), FALSE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VM), FALSE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA), FALSE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM), FALSE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VA_AFTER), FALSE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VM_AFTER), FALSE); // 중지
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VA_AFTER ), stMtr.szIndi_cut_va_after);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VM_AFTER ), stMtr.szIndi_cut_vm_after);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VA ), stMtr.szIndi_va);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VM ), stMtr.szIndi_vm);
			
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VA), TRUE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VM), TRUE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA), TRUE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM), TRUE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VA_AFTER), TRUE); // 중지
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VM_AFTER), TRUE); // 중지
		}
	}
	
	void Save_Mtr(void)
	{
	char szSql[300];
	char sztmp[50];
	handle* sql;
	char * sqlstr = "";	
	
		Mem_Set( (byte*)stMtr.szIndi_vc, 0x00, sizeof(stMtr.szIndi_vc) );
		Mem_Set( (byte*)stMtr.szIndi_va, 0x00, sizeof(stMtr.szIndi_va) );
		Mem_Set( (byte*)stMtr.szIndi_vm, 0x00, sizeof(stMtr.szIndi_vm) );
		Str_Cpy( stMtr.szIndi_vc, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VC ) ) );
		if(Str_Cmp(stMtr.szRevis_flag, "10") != 0)
		{
			Str_Cpy( stMtr.szIndi_va, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VA ) ) );
			Str_Cpy( stMtr.szIndi_vm, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VM ) ) );
		}
		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
		STRING_Append(sql," INDI_VC ='");
		STRING_Append(sql,stMtr.szIndi_vc);
		STRING_Append(sql,"' ,INDI_VA ='");
		STRING_Append(sql,stMtr.szIndi_va);
		STRING_Append(sql,"' ,INDI_VM ='");
		STRING_Append(sql,stMtr.szIndi_vm);
		STRING_Append(sql,"'  WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stMtr.szPromise_assign_seq );
		STRING_Append(sql,"' AND MTR_NUM = '");
		STRING_Append(sql,  stMtr.szMtr_num );
		STRING_Append(sql,"' ");
		
		sqlstr = STRING_toString(sql);		
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
	}
	
	void Save_MtrRele(void)
	{
	char szSql[300];
	char sztmp[50];
	handle* sql;
	char * sqlstr = "";
	
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VC ) ) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "지침VC를 입력하세요!");
			return;
		}
		
		if(Str_Cmp(stMtr.szRevis_flag, "10") != 0)
		{
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VA ) ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "지침VA를 입력하세요!");
				return;
			}

			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VM ) ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "지침VM를 입력하세요!");
				return;
			}
		}
		
		Mem_Set( (byte*)stMtr.szIndi_vc, 0x00, sizeof(stMtr.szIndi_vc) );
		Mem_Set( (byte*)stMtr.szIndi_va, 0x00, sizeof(stMtr.szIndi_va) );
		Mem_Set( (byte*)stMtr.szIndi_vm, 0x00, sizeof(stMtr.szIndi_vm) );
		Str_Cpy( stMtr.szIndi_vc, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VC ) ) );
		if(Str_Cmp(stMtr.szRevis_flag, "10") != 0)
		{
			Str_Cpy( stMtr.szIndi_va, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VA ) ) );
			Str_Cpy( stMtr.szIndi_vm, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VM ) ) );
		}
		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
		STRING_Append(sql," CUT_CNL_YMD =  '");
		STRING_Append(sql,stMtr.szCut_cnl_ymd);
		STRING_Append(sql,"',INDI_VC ='");
		STRING_Append(sql,stMtr.szIndi_vc);
		STRING_Append(sql,"',INDI_VA ='");
		STRING_Append(sql,stMtr.szIndi_va);
		STRING_Append(sql,"',INDI_VM ='");
		STRING_Append(sql,stMtr.szIndi_vm);
		STRING_Append(sql,"',PROD_STS_CD = '10' ");
		STRING_Append(sql," ,UPD_EMPID = '");
		STRING_Append(sql,  stUserinfo.szemployee_id);
		STRING_Append(sql,"',PDA_IP = '");
		STRING_Append(sql,  stUserinfo.szpda_ip);
		STRING_Append(sql,"' WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stMtr.szPromise_assign_seq );
		STRING_Append(sql,"' AND MTR_NUM = '");
		STRING_Append(sql,  stMtr.szMtr_num );
		STRING_Append(sql,"' ");
		
		sqlstr = STRING_toString(sql);		
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
		
		g_nStopReleFlag = 1;
		
		MessageBoxEx (CONFIRM_OK, "해제 등록 되었습니다.");
		
		Draw_Tb();
		ReDraw();
	}
}



