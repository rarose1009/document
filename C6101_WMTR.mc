/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WMTR
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
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
		DEF_BUTTON_ID ( BID_WCUST )			//
		DEF_BUTTON_ID ( BID_WMTR )			//
		DEF_BUTTON_ID ( BID_WBUR )			//
		DEF_BUTTON_ID ( BID_WCHK )			//
		DEF_BUTTON_ID ( BID_WONE )			//
		DEF_BUTTON_ID ( BID_WSTOP )			//
		DEF_BUTTON_ID ( BID_WRELE )			//
		DEF_BUTTON_ID ( BID_WPAY )			//
		DEF_BUTTON_ID ( BID_CLOSE )			//
		
		DEF_BUTTON_ID ( BID_UP )	//
		DEF_BUTTON_ID ( BID_DOWN )	//
		
		DEF_BUTTON_ID ( BID_UP2 )	//
		DEF_BUTTON_ID ( BID_DOWN2 )	//
		
		DEF_BUTTON_ID ( BID_UP3 )	//
		DEF_BUTTON_ID ( BID_DOWN3 )	//	
			
		DEF_BUTTON_ID ( BID_UP4 )	//
		DEF_BUTTON_ID ( BID_DOWN4 )	//		
		
		DEF_BUTTON_ID ( BID_SAVEPROD )	//		
		
		DEF_BUTTON_ID ( BID_LAST )			//
		DEF_BUTTON_ID ( BID_PRDT )			//
		DEF_BUTTON_ID ( BID_CHGMTR )		//
		DEF_BUTTON_ID ( BID_BILL )			//
		DEF_BUTTON_ID ( BID_NOPAY )			//
		DEF_BUTTON_ID ( BID_PAY )			//
		
		DEF_BUTTON_ID ( BID_MTRCHGDATE )	//
		DEF_BUTTON_ID ( BID_SNDCHGINDI )	//
		
		DEF_BUTTON_ID ( BID_SUBCLOSE )		//
		
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
		DEF_OBJECT_ID ( TXT_TITLE )		//
		DEF_OBJECT_ID ( ICON_TITLE )	//
		// 2017.07.28 exception DEF_OBJECT_ID ( TAB_COVER )		//
		DEF_OBJECT_ID ( TAB_LINE )		//
		DEF_OBJECT_ID ( TXT_PAGE )		//
		DEF_OBJECT_ID ( TXT_PAGE2 )		//
		
		DEF_OBJECT_ID ( TTL_MTR_DETA_LOC      )		//
		DEF_OBJECT_ID ( TXT_MTR_DETA_LOC      )		//
		DEF_OBJECT_ID ( TTL_MTR_MODEL_NM      )		//
		DEF_OBJECT_ID ( TXT_MTR_MODEL_NM      )		//
		DEF_OBJECT_ID ( TTL_MTR_GRD           )		//
		DEF_OBJECT_ID ( TXT_MTR_GRD           )		//
		DEF_OBJECT_ID ( TTL_MTR_SUPPLY_STS_NM )		//
		DEF_OBJECT_ID ( TXT_MTR_SUPPLY_STS_NM )		//
		DEF_OBJECT_ID ( TTL_KEEPER_YN         )		//
		DEF_OBJECT_ID ( TXT_KEEPER_YN         )		//
		DEF_OBJECT_ID ( TTL_MTR_FORM_NM       )		//
		DEF_OBJECT_ID ( TXT_MTR_FORM_NM       )		//
		DEF_OBJECT_ID ( TTL_SEALED_STS        )		//
		DEF_OBJECT_ID ( TXT_SEALED_STS        )		//
		DEF_OBJECT_ID ( TTL_MTR_VALID_YM      )		//
		DEF_OBJECT_ID ( TXT_MTR_VALID_YM      )		//
		DEF_OBJECT_ID ( TTL_COMPENS_MODEL_NM  )		//
		DEF_OBJECT_ID ( TXT_COMPENS_MODEL_NM  )		//
		DEF_OBJECT_ID ( TTL_INDI_VC_AFTER     )		//
		DEF_OBJECT_ID ( TXT_INDI_VC_AFTER     )		//
		DEF_OBJECT_ID ( TTL_INDI_VC           )		//
		DEF_OBJECT_ID ( TXT_INDI_VC           )		//
		DEF_OBJECT_ID ( TTL_INDI_VA_AFTER     )		//
		DEF_OBJECT_ID ( TXT_INDI_VA_AFTER     )		//
		DEF_OBJECT_ID ( TTL_INDI_VA           )		//
		DEF_OBJECT_ID ( TXT_INDI_VA           )		//
		DEF_OBJECT_ID ( TTL_INDI_VM_AFTER     )		//
		DEF_OBJECT_ID ( TXT_INDI_VM_AFTER     )		//
		DEF_OBJECT_ID ( TTL_INDI_VM           )		//
		DEF_OBJECT_ID ( TXT_INDI_VM           )		//
		
		DEF_OBJECT_ID ( TTL_MTR_ID_NUM        )// 기물번호
		DEF_OBJECT_ID ( TXT_MTR_ID_NUM        )//            
		DEF_OBJECT_ID ( TTL_INDI_YMD          )//교체일자 
		DEF_OBJECT_ID ( TXT_INDI_YMD          )//         
		DEF_OBJECT_ID ( TTL_GUBUN             )//구분     
		DEF_OBJECT_ID ( TTL_BEFO              )//철거지침 
		DEF_OBJECT_ID ( TTL_CUT_AFTER         )//교체지침 
		DEF_OBJECT_ID ( TTL_VC                )//Vc       
		DEF_OBJECT_ID ( TXT_INDI_VC_BEFO      )           
		DEF_OBJECT_ID ( TXT_INDI_CUT_VC_AFTER )           
		DEF_OBJECT_ID ( TTL_VA                )//Va       
		DEF_OBJECT_ID ( TXT_INDI_VA_BEFO      )           
		DEF_OBJECT_ID ( TXT_INDI_CUT_VA_AFTER )           
		DEF_OBJECT_ID ( TTL_VM                )//Vm       
		DEF_OBJECT_ID ( TXT_INDI_VM_BEFO      )
		DEF_OBJECT_ID ( TXT_INDI_CUT_VM_AFTER )

		DEF_OBJECT_ID ( TTL_PERIOD_DAY         )//사용일수
		DEF_OBJECT_ID ( TXT_PERIOD_DAY         )//        
		DEF_OBJECT_ID ( TTL_USE_DAY            )//사용량  
		DEF_OBJECT_ID ( TXT_USE_DAY            )//        
		DEF_OBJECT_ID ( TTL_TOT_USE_QTY        )//기본료  
		DEF_OBJECT_ID ( TXT_TOT_USE_QTY        )//        
		DEF_OBJECT_ID ( TTL_TOT_BASE_CHARG     )//해제료  
		DEF_OBJECT_ID ( TXT_TOT_BASE_CHARG     )//        
		DEF_OBJECT_ID ( TTL_TOT_CNL_CHARG      )//단위열량
		DEF_OBJECT_ID ( TXT_TOT_CNL_CHARG      )//        
		DEF_OBJECT_ID ( TTL_SUPPLY_UNIT_ENER   )//보정량  
		DEF_OBJECT_ID ( TXT_SUPPLY_UNIT_ENER   )//        
		DEF_OBJECT_ID ( TTL_TOT_REVIS_QTY      )//사용료  
		DEF_OBJECT_ID ( TXT_TOT_REVIS_QTY      )//        
		DEF_OBJECT_ID ( TTL_TOT_DISC_AMT       )//정산액  
		DEF_OBJECT_ID ( TXT_TOT_DISC_AMT       )//        
		DEF_OBJECT_ID ( TTL_TOT_ADJ_CHARG      )//감면액  
		DEF_OBJECT_ID ( TXT_TOT_ADJ_CHARG      )//        
		DEF_OBJECT_ID ( TTL_USE_CHARG_DISC_AMT )//연체료  
		DEF_OBJECT_ID ( TXT_USE_CHARG_DISC_AMT )//        
		DEF_OBJECT_ID ( TTL_OVERDUE_AMT        )//교체비  
		DEF_OBJECT_ID ( TXT_OVERDUE_AMT        )//        
		DEF_OBJECT_ID ( TTL_TOT_REPL_COST      )//합계액  
		DEF_OBJECT_ID ( TXT_TOT_REPL_COST      )//        
		DEF_OBJECT_ID ( TTL_THIS_MM_CALCU_AMT  )//보정료  
		DEF_OBJECT_ID ( TXT_THIS_MM_CALCU_AMT  )//        
		DEF_OBJECT_ID ( TTL_TOT_REVIS_CHARG    )//예수금  
		DEF_OBJECT_ID ( TXT_TOT_REVIS_CHARG    )//        
		DEF_OBJECT_ID ( TTL_ADJ_ALT_AMT        )//청구금액
		DEF_OBJECT_ID ( TXT_ADJ_ALT_AMT        )//        
		DEF_OBJECT_ID ( TTL_REQ_AMT            )//        
		DEF_OBJECT_ID ( TXT_REQ_AMT            )//        

		DEF_OBJECT_ID ( TTL_DATA01 )
		DEF_OBJECT_ID ( TTL_DATA02 )
		DEF_OBJECT_ID ( TTL_DATA03 )
		DEF_OBJECT_ID ( TTL_DATA04 )
		DEF_OBJECT_ID ( TTL_DATA05 )
		DEF_OBJECT_ID ( TTL_DATA06 )
		
		DEF_OBJECT_ID ( TXT_DATA01 )
		DEF_OBJECT_ID ( TXT_DATA02 )
		DEF_OBJECT_ID ( TXT_DATA03 )
		DEF_OBJECT_ID ( TXT_DATA04 )
		DEF_OBJECT_ID ( TXT_DATA05 )
		DEF_OBJECT_ID ( TXT_DATA06 )
		DEF_OBJECT_ID ( TXT_DATA07 )
		DEF_OBJECT_ID ( TXT_DATA08 )
		
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
	
		DEF_OBJECT_ID ( ID_TBLLIST )
		DEF_OBJECT_ID ( ID_TBLLIST2 )
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1
	#define INIT_PROD	  2
	#define INIT_CHGINDI  3
	#define INIT_NOPAY	  4
	#define INIT_BILLDTL  5
	#define INIT_LASTINDI  6

	#define		W_MAIN		CWD*39+10
	#define		H_MAIN		CHT*21+20
	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table정의에 관련된 내용들
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    2					// table의 행개수
	#define		COL 	    4					// table의 열개수
	#define		GRID_H		(CHT+25)			// table 행 높이
	#define		GRID_CLR	TRANSPARENT   		// table 클리어 color
	#define		GRID_X		STARTX 			    // table 시작x좌표
	#define		MAXCHAR		101 			    // table에 들어갈수 있는 최대  char 길이
	#define		GRID_Y		STARTY+60  	    //table 시작y좌표
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table마지막 row의 Y값

	#define		ROWP 	    13					// table의 행개수
	#define		COLP 	    4					// table의 열개수
	#define		GRID_H_P	(CHT+10)			// table 행 높이 PDA
	#define		GRID_Y_P	STARTY+70  	    //table 시작y좌표 PDA
	#define		GRID_ENDYP	(GRID_Y_P+(ROWP+1)*GRID_H_P) //table마지막 row의 Y값
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (GRID_ENDY+15+SYH*x)
	#define 	LineS(x)	(STARTY+15+SYH*(x-1))
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	char	m_szTableBufNp [COLP*(ROWP+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
		
	Column m_stGridTitle[] = 
	{
		{"기물번호", CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"설치위치", CWD*10+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상태"    , CWD*11, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"MTR_NUM" , CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	Column m_stGridTitleNp[] = 
	{
		{"청구년월", CWD*11, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"납기"    , CWD*5, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"청구구액", CWD*11+23, EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"미납액"  , CWD*12,  EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	#define		ROW_B 	    5					// table의 행개수
	#define		COL_B 	    4					// table의 열개수
	#define		GRID_H_B		(CHT+20)		// table 행 높이	
	#define		GRID_X_B		STARTX 			// table 시작x좌표
	#define		GRID_Y_B		STARTY-29  	    //table 시작y좌표
	#define		GRID_ENDY_B   	(GRID_Y_B+(ROW_B+1)*GRID_H_B) //table마지막 row의 Y값
	
	#define		ROW_P 	    5					// table의 행개수
	#define		COL_P 	    3					// table의 열개수
	
	#define		GRID_ENDY_P   	(GRID_ENDY_B+SYH+55+(ROW_P+1)*GRID_H_B)
	
	char	m_szTableBufbiz [COL_B*(ROW_B+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼
	char	m_szTableBufprod [COL_P*(ROW_P+1)*MAXCHAR]; // 각 CELL에 들어가 텍스트 내용을 담은 버퍼

	
	
	Column m_stGridTitlebiz[] = 
	{
		{"업종분류", CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"업종명칭", CWD*21+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code"    , 0, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code"    , 0, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};
	
	Column m_stGridTitleprod[] = 
	{
		{"코드", CWD*11, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"상품", CWD*28+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"code", 0, EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	long m_bFirst;
	char m_szCnt_index[11];     //인덱스 문자열(현재 페이지)
	char m_szCnt_index2[11]; 
	long m_lpage;
	long m_lTotpage;
	long m_lpage2;
	long m_lTotpage2;
	long m_lpage3;
	long m_lTotpage3;
	long m_lActIndex;
	long m_lActRow = 0;
	long m_lActRow2 = 0;
	long m_chkVC = 0;
	char m_szIndi_ymd[9];
	
	char m_szBiz_type_cd[7];
	char m_szBiz_type_class_cd[3];
	char m_szProd_cd[3];
	char m_szProd_nm[51];
	char m_szTrans_info_rslt[300];
	char m_originProd_cd[3];
	char m_originProd_nm[51];
	char m_originBiz_type_cd[7];
		
	void SetBtnImg(void);
	void SetStyle(void);
	void Draw_Tb(void);
	void Draw_NpTb(void);
	void ReDraw(void);
	void Save_Mtr(void);
	void Get_Burclasscd(char* key1, char* key2,  char* burclscd);
	
	void Draw_Biz(void);
	void Draw_Prod(void);
	void Chk_Prod(void);
	
	bool Save_Prod(void);
	
	void Snd_LastIndi(void);
	long Rcv_LastIndi(void);
	long Chk_Json_64202(void);
	long Chk_Json_64602(void);
	long Chk_Json_64702(void);
	
	void Snd_AdjBill(void);
	long Rcv_AdjBill(void);
	long Add_Item(handle pj);
	
	void Snd_ChgIndi(void);
	long Rcv_ChgIndi(void);
	void Snd_NoPay(void);
	long Rcv_NoPay(void);
	void Snd_Bill(void);
	long Rcv_Bill(void);
	long Rcv_ProdChk(void);
	
	long m_Re_Adj_Cnt;
	char m_After_Vc[10];

	// 메인 다이얼로그
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WCUST, "고객"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "연소기"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_WMTR, "정산"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WONE, "일회성"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WPAY, "요금"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WSTOP, "중지"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WRELE, "해제"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WCHK, "점검"),
		//DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		// 리스트
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_BUTTON(STARTX,  		  GRID_ENDY+7, 200,   SYH+15, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ▲"),
		DLG_BUTTON(STARTX+200,  	  GRID_ENDY+7, 200,   SYH+15, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ▼"),
		DLG_TEXT(  STARTX+999-CWD*9,  GRID_ENDY+7, CWD*9, SYH+15, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),
		
		DLG_TEXT( STARTX,     Line(1)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_DETA_LOC, "상세위치"),
		DLG_TEXT( STARTX+215, Line(1)+15,  785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_DETA_LOC, ""),
		DLG_TEXT( STARTX,     Line(2)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_MODEL_NM, "모델"),
		DLG_TEXT( STARTX+215, Line(2)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_MODEL_NM, ""),
		DLG_TEXT( STARTX+500, Line(2)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_GRD, "등급"),
		DLG_TEXT( STARTX+715, Line(2)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_GRD, ""),
		DLG_TEXT( STARTX,     Line(3)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_SUPPLY_STS_NM, "공급상태"),
		DLG_TEXT( STARTX+215, Line(3)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_SUPPLY_STS_NM, ""),
		DLG_TEXT( STARTX+500, Line(3)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_KEEPER_YN, "키퍼"),
		DLG_TEXT( STARTX+715, Line(3)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_KEEPER_YN, ""),
		DLG_TEXT( STARTX,     Line(4)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_FORM_NM, "형식"),
		DLG_TEXT( STARTX+215, Line(4)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_FORM_NM, ""),
		DLG_TEXT( STARTX+500, Line(4)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SEALED_STS, "봉인여부"),
		DLG_TEXT( STARTX+715, Line(4)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SEALED_STS, ""),
		DLG_TEXT( STARTX,     Line(5)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_VALID_YM, "유효기간"),
		DLG_TEXT( STARTX+215, Line(5)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_VALID_YM, ""),
		DLG_TEXT( STARTX+500, Line(5)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_COMPENS_MODEL_NM, "보정기"),
		DLG_TEXT( STARTX+715, Line(5)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_COMPENS_MODEL_NM, ""),
		DLG_TEXT( STARTX,     Line(6)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VC_AFTER, "최종VC"),
		DLG_TEXT( STARTX+215, Line(6)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_VC_AFTER, ""),
		DLG_TEXT( STARTX+500, Line(6)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VC, "지침VC"),
		DLG_EDIT( STARTX+715, Line(6)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VC,10, ""),
		DLG_TEXT( STARTX,     Line(7)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VA_AFTER, "최종VA"),
		DLG_TEXT( STARTX+215, Line(7)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_VA_AFTER, ""),
		DLG_TEXT( STARTX+500, Line(7)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VA, "지침VA"),
		DLG_EDIT( STARTX+715, Line(7)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VA,10, ""),
		DLG_TEXT( STARTX,     Line(8)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VM_AFTER, "최종VM"),
		DLG_TEXT( STARTX+215, Line(8)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_VM_AFTER, ""),
		DLG_TEXT( STARTX+500, Line(8)+15,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VM, "지침VM"),
		DLG_EDIT( STARTX+715, Line(8)+15,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VM,10, ""),

		DLG_BUTTON( STARTX,     Line(10)-15, 350, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_LAST,   "최종지침조회"),
		DLG_BUTTON( STARTX+650, Line(10)-15, 350, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRDT,   "상품선택"),
		
		DLG_BUTTON( STARTX,     Line(10)-15, 250, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGMTR, "교체지침"),
		DLG_BUTTON( STARTX+250, Line(10)-15, 250, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BILL,   "중간정산"),
		DLG_BUTTON( STARTX+500, Line(10)-15, 250, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOPAY,  "미납내역"),
		DLG_BUTTON( STARTX+750, Line(10)-15, 250, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PAY,    "정산내역"),

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
	
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "납부정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
	};
	
	
	// 상품선택
	//---------------------------------------------------------------
	DlgObject	DlgRes_PROD[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "상품선택"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TABLE (GRID_X_B, GRID_Y_B,            ROW_B, COL_B, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitlebiz, ID_TBLLIST, m_szTableBufbiz),
		
		DLG_BUTTON(STARTX,   	GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP2, " ▲"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN2, " ▼"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_B+10, 250, SYH+30, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),

		DLG_TABLE (GRID_X_B, GRID_ENDY_B+SYH+55, ROW_P, COL_P, 0, GRID_H_B, 1, GRID_H_B, SEL_ROW, MAXCHAR, m_stGridTitleprod, ID_TBLLIST2, m_szTableBufprod),

		DLG_BUTTON(STARTX,   	GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP3, " ▲"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN3, " ▼"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_P+12, 250, SYH+31, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE2, m_szCnt_index2),
		DLG_BUTTON( STARTX+750, GRID_ENDY_P+12, 250, SYH+31, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVEPROD, "확 인"),
	};
	
	// 최종지침정보
	//---------------------------------------------------------------
	DlgObject	DlgRes_LASTINDI[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "최종지침정보"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,     STARTY-29,        240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DATA01, "지침유형"),
		DLG_TEXT( STARTX+240, STARTY-29,        760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA01, ""),
		DLG_TEXT( STARTX,     STARTY+SYH-29,    240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DATA02, "VC"),
		DLG_TEXT( STARTX+240, STARTY+SYH-29,    760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA02, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*2-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DATA03, "VA"),
		DLG_TEXT( STARTX+240, STARTY+SYH*2-29,  760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA03, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*3-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DATA04, "VM"),
		DLG_TEXT( STARTX+240, STARTY+SYH*3-29,  760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA04, ""),

		DLG_BUTTON( STARTX+730, STARTY+SYH*5-29, 270, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, "확 인"),
	};
	
	// 교체지침등록
	//---------------------------------------------------------------
	DlgObject	DlgRes_CHGINDI[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "교체지침등록"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,     LineS(1)-45, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_ID_NUM, "기물번호"),
		DLG_TEXT( STARTX+215, LineS(1)-45, 784, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_ID_NUM, ""),
		DLG_TEXT( STARTX,     LineS(2)-45, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_MODEL_NM, "모    델"),
		DLG_TEXT( STARTX+215, LineS(2)-45, 784, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_MODEL_NM, ""),
		DLG_TEXT( STARTX,     LineS(3)-45, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_GRD, "등급"),
		DLG_TEXT( STARTX+215, LineS(3)-45, 785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_GRD, ""),
		
		DLG_TEXT( STARTX,      LineS(4)-15, 215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_YMD, "교체일자"),
		DLG_TEXT( STARTX+215,  LineS(4)-15, 600, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_YMD, ""),
		DLG_BUTTON( STARTX+815,LineS(4)-15, 185, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRCHGDATE, "▼"),
		
		DLG_TEXT( STARTX,     LineS(6)-45,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GUBUN,   "구분"),
		DLG_TEXT( STARTX+215, LineS(6)-45,  390, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BEFO,     "철거지침"),
		DLG_TEXT( STARTX+605, LineS(6)-45,  395, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUT_AFTER, "교체지침"),
		DLG_TEXT( STARTX,     LineS(7)-45,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VC, "Vc"),
		DLG_EDIT( STARTX+215, LineS(7)-45,  390, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VC_BEFO,10, ""),
		DLG_EDIT( STARTX+605, LineS(7)-45,  395, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_CUT_VC_AFTER,10, ""),
		DLG_TEXT( STARTX,     LineS(8)-45,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VA, "Va"),
		DLG_EDIT( STARTX+215, LineS(8)-45,  390, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VA_BEFO,10, ""),
		DLG_EDIT( STARTX+605, LineS(8)-45,  395, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_CUT_VA_AFTER,10, ""),
		DLG_TEXT( STARTX,     LineS(9)-45,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VM, "Vm"),
		DLG_EDIT( STARTX+215, LineS(9)-45,  390, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_VM_BEFO,10, ""),
		DLG_EDIT( STARTX+605, LineS(9)-45,  395, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_INDI_CUT_VM_AFTER,10, ""),
				
		DLG_BUTTON( STARTX+730, LineS(11), 270, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SNDCHGINDI, "교체등록"),
	};		
	
	// 미납내역
	//---------------------------------------------------------------
	DlgObject	DlgRes_NOPAY[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "미납내역"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,     STARTY-10,  270, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DATA01, "미납총액"),
		DLG_TEXT( STARTX+270, STARTY-10,  730, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA01, ""),
		
		DLG_TABLE (GRID_X, GRID_Y_P, ROWP, COLP, 0, GRID_H_P, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitleNp, ID_TBLLIST, m_szTableBufNp),
		
		DLG_BUTTON(STARTX,      GRID_ENDY_P+22, 250, SYH+21, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP4, " ▲"),
		DLG_BUTTON(STARTX+250,  GRID_ENDY_P+22, 250, SYH+21, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN4, " ▼"),
		DLG_TEXT(  STARTX+500,  GRID_ENDY_P+22, 250, SYH+21, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),
		DLG_BUTTON( STARTX+750, GRID_ENDY_P+22, 250, SYH+21, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, "확 인"),
	};
	
	// 중간정산고지내역
	//---------------------------------------------------------------
	DlgObject	DlgRes_BILLDTL[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "중간정산 고지내역"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,     STARTY-29,        215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_PERIOD_DAY, "사용기간"),
		DLG_TEXT( STARTX+215, STARTY-29,        785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PERIOD_DAY, ""),
		DLG_TEXT( STARTX,     STARTY+SYH-29,    215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_USE_DAY, "사용일수"),
		DLG_TEXT( STARTX+215, STARTY+SYH-29,    285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_USE_DAY, ""),
		DLG_TEXT( STARTX+500, STARTY+SYH-29,    200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_USE_QTY, "사용량"),
		DLG_TEXT( STARTX+700, STARTY+SYH-29,    300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_USE_QTY, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*2-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_BASE_CHARG, "기본료"),
		DLG_TEXT( STARTX+215, STARTY+SYH*2-29,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_BASE_CHARG, ""),
		DLG_TEXT( STARTX+500, STARTY+SYH*2-29,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_CNL_CHARG, "해제료"),
		DLG_TEXT( STARTX+700, STARTY+SYH*2-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_CNL_CHARG, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*3-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SUPPLY_UNIT_ENER, "단위열량"),
		DLG_TEXT( STARTX+215, STARTY+SYH*3-29,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SUPPLY_UNIT_ENER, ""),
		DLG_TEXT( STARTX+500, STARTY+SYH*3-29,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_REVIS_QTY, "보정량"),
		DLG_TEXT( STARTX+700, STARTY+SYH*3-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_REVIS_QTY, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*4-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_DISC_AMT, "사용료"),
		DLG_TEXT( STARTX+215, STARTY+SYH*4-29,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_DISC_AMT, ""),
		DLG_TEXT( STARTX+500, STARTY+SYH*4-29,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_ADJ_CHARG, "정산액"),
		DLG_TEXT( STARTX+700, STARTY+SYH*4-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_ADJ_CHARG, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*5-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_USE_CHARG_DISC_AMT, "감면액"),
		DLG_TEXT( STARTX+215, STARTY+SYH*5-29,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_USE_CHARG_DISC_AMT, ""),
		DLG_TEXT( STARTX+500, STARTY+SYH*5-29,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_OVERDUE_AMT, "연체료"),
		DLG_TEXT( STARTX+700, STARTY+SYH*5-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_OVERDUE_AMT, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*6-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_REPL_COST, "교체비"),
		DLG_TEXT( STARTX+215, STARTY+SYH*6-29,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_REPL_COST, ""),
		DLG_TEXT( STARTX+500, STARTY+SYH*6-29,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_THIS_MM_CALCU_AMT, "합계액"),
		DLG_TEXT( STARTX+700, STARTY+SYH*6-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_THIS_MM_CALCU_AMT, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*7-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOT_REVIS_CHARG, "보정료"),
		DLG_TEXT( STARTX+215, STARTY+SYH*7-29,  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOT_REVIS_CHARG, ""),
		DLG_TEXT( STARTX+500, STARTY+SYH*7-29,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_ADJ_ALT_AMT, "예수금"),
		DLG_TEXT( STARTX+700, STARTY+SYH*7-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADJ_ALT_AMT, ""),
		DLG_TEXT( STARTX,     STARTY+SYH*8-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_REQ_AMT, "청구금액"),
		DLG_TEXT( STARTX+215, STARTY+SYH*8-29,  785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_REQ_AMT, ""),

		DLG_BUTTON( STARTX+730, STARTY+SYH*9, 270, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, "확 인"),
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
		
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						m_lActRow = 0;
						m_lpage =0;
						Draw_Tb();
						Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
						Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						m_lActRow = 0;
						m_lpage =0;
						Draw_Tb();
						Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
						Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
						
						if( g_lWmtrMoveFlag == 1)
						{
							ON_EXIT();
							OnInit(INIT_PROD);
						}
						if(g_nWorkFlag == 650 || g_nWorkFlag == 660 )
						{
							if(m_chkVC == 1)
							{
								DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), FALSE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), TRUE );
								
							}else
							{
								DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), FALSE );
							}
							// PRINT("m_originProd_cd 44444: %s",stMtr.szProd_cd,0,0);
							// PRINT("m_originProd_nm 44444: %s",stMtr.szProd_nm,0,0);
							// PRINT("m_originBiz_type_cd 44444: %s",stMtr.szBiz_type_cd,0,0);
							
							
							if(Str_Len(m_originProd_cd) == 0)
							{
								Str_Cpy( m_originProd_cd , stMtr.szProd_cd  );
								Str_Cpy( m_originProd_nm , stMtr.szProd_nm  );
								Str_Cpy( m_originBiz_type_cd , stMtr.szBiz_type_cd  );
							}
							
							// PRINT("m_originProd_cd 555555: %s",m_originProd_cd,0,0);
							// PRINT("m_originProd_nm 555555: %s",m_originProd_nm,0,0);
							// PRINT("m_originBiz_type_cd 555555: %s",m_originBiz_type_cd,0,0);
							// Chk_Prod();
						}
						
						
						break;		
				}
				
				break;
			case INIT_PROD:
				CREATE_DIALOG_OBJECT (DlgRes_PROD, SIZEOF(DlgRes_PROD));
				m_lActRow = 0;
				m_lActRow2 = 0;
				m_lpage2 = 0;
				m_lpage3 = 0;
				Draw_Biz();
				break;
			case INIT_CHGINDI:
				CREATE_DIALOG_OBJECT (DlgRes_CHGINDI, SIZEOF(DlgRes_CHGINDI));
				break;
			case INIT_NOPAY:
				CREATE_DIALOG_OBJECT (DlgRes_NOPAY, SIZEOF(DlgRes_NOPAY));
				m_lpage = 0;
				Draw_NpTb();
				break;
			case INIT_BILLDTL:
				CREATE_DIALOG_OBJECT (DlgRes_BILLDTL, SIZEOF(DlgRes_BILLDTL));
				break;
				
			case INIT_LASTINDI:
				CREATE_DIALOG_OBJECT (DlgRes_LASTINDI, SIZEOF(DlgRes_LASTINDI));
				break;
		
		}
		SetBtnImg();
		SetStyle();
		ReDraw();
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char szDate[11];
		char sztmp[100];
		
		switch(ID)
		{
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
				}
				Draw_Tb();
				m_lActRow = 0;
				ReDraw();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
				}
				Draw_Tb();
				m_lActRow = 0;
				ReDraw();
				break;
				
			case BID_UP4:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
				}
				Draw_NpTb();
				break;			
			case BID_DOWN4:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
				}
				Draw_NpTb();
				break;


			case BID_UP2:
				m_lpage2--;
				if(m_lpage2 < 0)
				{
					m_lpage2 = 0;
				}
				m_lActRow = 0;
				Draw_Biz();
				break;			
			case BID_DOWN2:
				m_lpage2++;
				if( m_lpage2 > m_lTotpage2-1 )
				{
					m_lpage2 = m_lTotpage2-1;
				}
				m_lActRow = 0;
				Draw_Biz();
				break;

			case BID_UP3:
				m_lpage3--;
				if(m_lpage3 < 0)
				{
					m_lpage3 = 0;
				}
				m_lActRow = 0;
				Draw_Prod();
				break;			
			case BID_DOWN3:
				m_lpage3++;
				if( m_lpage3 > m_lTotpage3-1 )
				{
					m_lpage3 = m_lTotpage3-1;
				}
				m_lActRow = 0;
				Draw_Prod();
				break;			
			
			case BID_SAVEPROD:
				if( !Save_Prod() )
				{
					break;
				}
				g_lWmtrMoveFlag = 0;
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
			
			case BID_SUBCLOSE:
				g_lWmtrMoveFlag = 0;
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_LAST:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
				if( MessageBoxEx (CONFIRM_YESNO, "최종지침조회를 하시겠습니까?") != MB_OK)
					break;
				Snd_LastIndi();
				break;
			case BID_PRDT:
				if(g_nWorkFlag == 650 || g_nWorkFlag == 660)
				{
					Chk_Prod();
					Save_Mtr();
					ON_EXIT();
					// if(ret == -1)
					// {
					// 	OnInit(INIT_MAIN);
					// }
					
					
				}
				if( g_nWorkFlag == 610)
				{	
					Save_Mtr();
					ON_EXIT();
					OnInit(INIT_PROD);
				}
				break;
				
			case BID_CHGMTR:
				if(g_lRfrmFlag == 1)
					break;	
				ON_EXIT();
				OnInit(INIT_CHGINDI);
				break;
				
			case BID_SNDCHGINDI:
				Snd_ChgIndi();
				break;
				
			case BID_MTRCHGDATE:	
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)m_szIndi_ymd, 0x00, sizeof(m_szIndi_ymd));
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Str_ItoA ( d, m_szIndi_ymd, 10);
					g_Str_DateType(szDate, m_szIndi_ymd);
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_YMD), szDate );
				}
				break;	
				
				//중간정상호출후 미납내역과 정산내역을 수신받는다.
			case BID_BILL:
				Save_Mtr();		//지침값 저장.
				Snd_AdjBill();
				break;
				
			case BID_NOPAY:
				ON_EXIT();
				OnInit(INIT_NOPAY);
				break;
				
			case BID_PAY:
				ON_EXIT();
				OnInit(INIT_BILLDTL);
				break;
			case BID_WCUST:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
				Card_Move("C6101_WCUST");
				break;
			case BID_WMTR:
				//Card_Move("C6101_WMTR");
				break;
			case BID_WBUR:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
				Card_Move("C6101_WBUR");
				break;
			case BID_WCHK:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
				Card_Move("C6101_WCHK");
				break;
			case BID_WONE:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
				Card_Move("C6101_WONE");
				break;
			case BID_WSTOP:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
				Card_Move("C6101_WSTOP");
				break;
			case BID_WRELE:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
				Card_Move("C6101_WRELE");
				break;
			case BID_WPAY:
				if( g_nWorkFlag == 610 || g_nWorkFlag == 650 || g_nWorkFlag == 660 )
				{
					Save_Mtr();
				}
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
		else if( INIT_PROD == m_bFirst )
		{
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// 현재 선택된 인덱스
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// 선택 인덱스와 기존 인덱스가 동일 할 경우
				Mem_Set((byte*)m_szBiz_type_cd , 0x00, sizeof(m_szBiz_type_cd));
				Mem_Set((byte*)m_szBiz_type_class_cd , 0x00, sizeof(m_szBiz_type_class_cd));
				Str_Cpy( m_szBiz_type_cd ,       DlgTbl_GetStr( ID_TBLLIST, index-1, 2)  );
				Str_Cpy( m_szBiz_type_class_cd , DlgTbl_GetStr( ID_TBLLIST, index-1, 3)  );
				
				m_lActRow = index-1;
				m_lActRow2 = 0;
				Draw_Prod();
				ON_DRAW();
			}
			else if(DlgTbl_IsSelect(ID_TBLLIST2))
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST2);
				Mem_Set((byte*)m_szProd_cd , 0x00, sizeof(m_szProd_cd));
				Mem_Set((byte*)m_szProd_nm , 0x00, sizeof(m_szProd_nm));				
				Str_Cpy( m_szProd_cd , DlgTbl_GetStr( ID_TBLLIST2, index-1, 0)  );
				Str_Cpy( m_szProd_nm , DlgTbl_GetStr( ID_TBLLIST2, index-1, 1)  );
				
				m_lActRow2 = index-1;
								
			}
		}
	}
	
	void	OnChar(long nChar)
	{
		long nLen = 0;
		char strMsg[100];
		
		if( m_bFirst == INIT_MAIN )
		{
			if( Get_iDlgCtrlByID(TXT_INDI_VC) == m_lActIndex 
			||  Get_iDlgCtrlByID(TXT_INDI_VA) == m_lActIndex  
			||  Get_iDlgCtrlByID(TXT_INDI_VM) == m_lActIndex  )
			{
				//숫자만 입력 가능
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (ERROR_OK, "숫자만 입력가능합니다.");
					ON_KEY(5);
					return;
				}
				
				//2017.01.22 황영자 과장님 요청, 계량기 지침VC 자릿수 체크, szMtr_digit_cnt
				nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_INDI_VC)));

				if( nLen > Str_AtoI(stMtr.szMtr_digit_cnt) )
				{
					Mem_Set((byte *)strMsg      , 0x00, sizeof(strMsg));

					Str_Cat(strMsg, "계량기 지침 자릿수를 초과하였습니다.\n ");
					Str_Cat(strMsg, "\n계량기번호 : ");
					Str_Cat(strMsg, stMtr.szMtr_num);
					Str_Cat(strMsg, "\n지침 최대 자릿수 : ");
					Str_Cat(strMsg, stMtr.szMtr_digit_cnt);
					
					MessageBoxEx(ERROR_OK, strMsg);
					// 넘어가면 마지막 char 삭제
					ON_KEY( 5 );
					return;
				}
			}
		}
		else if ( m_bFirst == INIT_CHGINDI )
		{
			if( Get_iDlgCtrlByID(TXT_INDI_VC_BEFO) == m_lActIndex 
			||  Get_iDlgCtrlByID(TXT_INDI_CUT_VC_AFTER) == m_lActIndex  
			||  Get_iDlgCtrlByID(TXT_INDI_VA_BEFO) == m_lActIndex  
			||  Get_iDlgCtrlByID(TXT_INDI_CUT_VA_AFTER) == m_lActIndex  
			||  Get_iDlgCtrlByID(TXT_INDI_VM_BEFO) == m_lActIndex  
			||  Get_iDlgCtrlByID(TXT_INDI_CUT_VM_AFTER) == m_lActIndex  )
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
			//2017-07-19 Sanghyun Lee
			//포이팅 할때마다 저장..???? -> 중간정산 버튼 선택 할 때 저장하도록 변경
			//Save_Mtr();
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+715) && X < DMS_X(STARTX+1000) && Y > DMS_Y(Line(6)+15-(g_Dlgflag*400)) && Y < DMS_Y(Line(7)+15-(g_Dlgflag*400))
					||  X > DMS_X(STARTX+715) && X < DMS_X(STARTX+1000) && Y > DMS_Y(Line(7)+15-(g_Dlgflag*400)) && Y < DMS_Y(Line(9)+15-(g_Dlgflag*400)) &&  Str_Cmp(stMtr.szRevis_flag, "10") != 0 )
					{
						if( Get_iDlgCtrlByID(TXT_INDI_VC) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_INDI_VA) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_INDI_VM) == lActiveIndex  )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);		
							//ShowSip(TRUE);
							//g_Sipflag = 1;
						}
						else
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							//ShowSip(FALSE);
							//g_Sipflag = 0;
						}
						
						ON_DRAW();
					}
					else
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
						
						ON_DRAW();
					}
				}
			}
		}
		else if ( m_bFirst == INIT_CHGINDI )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{					
					if(  (X > DMS_X(STARTX+215) && X < DMS_X(STARTX+1000) && Y > DMS_Y(LineS(7)-45) && Y < DMS_Y(LineS(8)-45) ) 
					||   (X > DMS_X(STARTX+215) && X < DMS_X(STARTX+1000) && Y > DMS_Y(LineS(8)-45) && Y < DMS_Y(LineS(10)-45) && Str_Cmp(stMtr.szRevis_flag, "10") != 0 )
					)
					{
						if( Get_iDlgCtrlByID(TXT_INDI_VC_BEFO) == m_lActIndex 
						||  Get_iDlgCtrlByID(TXT_INDI_CUT_VC_AFTER) == m_lActIndex  
						||  Get_iDlgCtrlByID(TXT_INDI_VA_BEFO) == m_lActIndex  
						||  Get_iDlgCtrlByID(TXT_INDI_CUT_VA_AFTER) == m_lActIndex  
						||  Get_iDlgCtrlByID(TXT_INDI_VM_BEFO) == m_lActIndex  
						||  Get_iDlgCtrlByID(TXT_INDI_CUT_VM_AFTER) == m_lActIndex  
						)	
						{
							g_Dlgflag = 0;
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
			
			if(   g_nWorkFlag == 640 )
			{
				TABCNT = 4;
				//lenX = CWD*9+20;
				lenX = CWD*10;
				
				sX[0] = 0;
			}
			else if(g_nWorkFlag == 660)
			{
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
					TABCNT = 6;
					lenX = 166;
				}
				else{
					TABCNT = 5;
					lenX = 200;
				}
				
				sX[0] = 0;
			}
			else if(g_nWorkFlag == 650)
			{	//연소기 업무 중 배관/계량기 또는 해제인애들은 상품탭 제외
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) == 0 || Str_Cmp (stMw.szCont_sts_cd, "30") == 0 || Str_Cmp (stMw.szCont_sts_cd, "20") == 0) 
				{
					TABCNT = 4;
					lenX = CWD*10;
				}
				else {
					TABCNT = 5;
					lenX = CWD*8;
				}
				
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
			if( g_nWorkFlag == 610 ) // 전입
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
				//선택된 탭을 활성화된것처럼 보이게 함.
				// 2017.07.28 exception EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[2]+4, highty-5, eX[2]-4, highty+5 );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_LAST),   TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT),   TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHGMTR), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NOPAY),  FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY),    FALSE );						
				//EditCtrl_SetStr(DlgTbl_GetHandle ( ID_TBLLIST, 0, 2 ), "상품");
				Str_Cpy(m_szTableBuf+2*MAXCHAR, "상품");

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
				//선택된 탭을 활성화된것처럼 보이게 함.
				// 2017.07.28 exception EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[2]+4, highty-5, eX[2]-4, highty+5 );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_LAST),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHGMTR), TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL),   TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NOPAY),  TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY),    TRUE );
				//Str_Cpy(m_stGridTitle[2].title, "상태");
				Str_Cpy(m_szTableBuf+2*MAXCHAR, "정산");
				//EditCtrl_SetStr(DlgTbl_GetHandle ( ID_TBLLIST, 0, 2 ), "상태");

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
				//선택된 탭을 활성화된것처럼 보이게 함.
				// 2017.07.28 exception EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[1]+4, highty-5, eX[1]-4, highty+5 );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_LAST),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHGMTR), TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL),   TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NOPAY),  TRUE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY),    TRUE );
				//Str_Cpy(m_stGridTitle[2].title, "상태");
				//EditCtrl_SetStr(DlgTbl_GetHandle ( ID_TBLLIST, 0, 2 ), "상태");
				Str_Cpy(m_szTableBuf+2*MAXCHAR, "상태");
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
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_LAST),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHGMTR), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NOPAY),  FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY),    FALSE );
			}
			else if( g_nWorkFlag == 650 )
			{
				//650:교체[고객, 연소기, 일회성, 요금 ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // 점검
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE); // 점검
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) != 0)
				{
					if(Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
						BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
						i++;
					}
				}
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );

				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_LAST),   FALSE );
				//DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHGMTR), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NOPAY),  FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY),    FALSE );
			}
			else if( g_nWorkFlag == 660 )
			{
				//660:점검[고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// 계량기
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// 중지
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// 해지
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0){
					BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
					i++;
				}
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCHK), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "상품" );

				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_LAST),   FALSE );
				//DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHGMTR), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL),   FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NOPAY),  FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY),    FALSE );
			}
			
		}
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//타이틀
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}

//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE             ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_DETA_LOC     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_DETA_LOC     ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_MODEL_NM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_MODEL_NM     ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_GRD          ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_GRD          ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_SUPPLY_STS_NM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_SUPPLY_STS_NM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_KEEPER_YN        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEEPER_YN        ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_FORM_NM      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_FORM_NM      ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SEALED_STS       ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEALED_STS       ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_VALID_YM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_VALID_YM     ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_COMPENS_MODEL_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMPENS_MODEL_NM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VC_AFTER    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VC_AFTER    ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VC          ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VC          ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VA_AFTER    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VA_AFTER    ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VA          ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VA          ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VM_AFTER    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VM_AFTER    ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VM          ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VM          ), EDITALIGN_MIDDLE);	

			//숫자판
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
		else if( m_bFirst == INIT_PROD )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE             ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE2             ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_CHGINDI )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_ID_NUM        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_ID_NUM        ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_MODEL_NM      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_MODEL_NM      ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_GRD           ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_GRD           ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_YMD          ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_YMD          ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN             ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BEFO              ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUT_AFTER         ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VC                ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VC_BEFO      ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_CUT_VC_AFTER ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VA                ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VA_BEFO      ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_CUT_VA_AFTER ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VM                ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VM_BEFO      ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_CUT_VM_AFTER ), EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_NOPAY )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA01 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA01 ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
		}
		else if( m_bFirst == INIT_BILLDTL )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_PERIOD_DAY         ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_PERIOD_DAY         ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_USE_DAY            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_USE_DAY            ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_USE_QTY        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_USE_QTY        ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_BASE_CHARG     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_BASE_CHARG     ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_CNL_CHARG      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_CNL_CHARG      ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_SUPPLY_UNIT_ENER   ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_SUPPLY_UNIT_ENER   ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_REVIS_QTY      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_REVIS_QTY      ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_DISC_AMT       ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_DISC_AMT       ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_ADJ_CHARG      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_ADJ_CHARG      ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_USE_CHARG_DISC_AMT ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_USE_CHARG_DISC_AMT ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_OVERDUE_AMT        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_OVERDUE_AMT        ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_REPL_COST      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_REPL_COST      ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_THIS_MM_CALCU_AMT  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_THIS_MM_CALCU_AMT  ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_TOT_REVIS_CHARG    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TOT_REVIS_CHARG    ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_ADJ_ALT_AMT        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_ADJ_ALT_AMT        ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TTL_REQ_AMT            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_REQ_AMT            ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_LASTINDI )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA01 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA01 ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA02 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA02 ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA03 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA03 ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DATA04 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA04 ), EDITALIGN_RIGHT|EDITALIGN_MIDDLE);
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
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, " SELECT MTR_ID_NUM, MTR_LOC_FLAG_NM, ADJ_CHK, PROD_NM, MTR_NUM   FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = ? ORDER BY MTR_ID_NUM LIMIT ?, ? " );
		
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
				
				if( g_nWorkFlag == 610 )
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				}
				else
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 1, DECRYPT);
					if(sztmp[0] == 'Y')
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "정산" );
					else
						DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lActRow < 0 )
		{
			m_lActRow = 0;
		}
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActRow+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActRow+1, TABLEACTIVE_COLOR);
			
			Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
			Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );	
		}
		ON_DRAW();
				
	}
	
	void Draw_NpTb(void)
	{
	long i, idx;
	long k = ROWP+1;
	long lTotPage;
	long lstartidx;
	char sztmp[51];
	char szbuf[51];
	char szSql[200];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);
		
		if( m_lTotpage % ROWP > 0 )
		{
			m_lTotpage = (m_lTotpage / ROWP) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROWP;
		}		
		
		
		SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, "SELECT REQ_YM, CASE WHEN REQ_MANAGE_STS ='대손' THEN '대손' ELSE DEADLINE_FLAG END as DEADLINE_FLAG, SUBTR_REQ_AMT, UNPAY_AMT FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = ? ORDER BY REQ_YM DESC LIMIT ?, ? " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);
		lstartidx = m_lpage*ROWP;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage*ROWP+ROWP;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROWP ; i++)
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
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 8, DECRYPT);
				// PRINT("11sztmpsztmpsztmpsztmpsztmp:%s",sztmp,0,0);
				if(Str_Cmp(sztmp,"20") != 0)
				{
					g_Str_DateType(szbuf, sztmp);
				}
				else
				{
					Str_Cpy(szbuf,"법적및기타");
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 8, DECRYPT);
				// g_Str_DateType(szbuf, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, szbuf );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 14, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 14, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		
		ON_DRAW();
	}
	
	
	void Draw_Biz(void)
	{
	long i, idx;
	long k = ROWP+1;
	long lTotPage;
	long lstartidx;
	char sztmp[51];
	char szbuf[51];
	char szSql[200];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_BIZ_TYPE ", 0, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage2);
		if( m_lTotpage2 % ROW_B > 0 )
		{
			m_lTotpage2 = (m_lTotpage2 / ROW_B) + 1;
		}
		else
		{
			m_lTotpage2 = m_lTotpage2 / ROW_B;
		}
		
		SPRINT(m_szCnt_index, "%d/%d", m_lpage2+1, m_lTotpage2,0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, " SELECT BIZ_TYPE_CLASS_NM, BIZ_TYPE_NM, BIZ_TYPE_CD, BIZ_TYPE_CLASS_CD FROM C6101_BIZ_TYPE  ORDER BY BIZ_TYPE_CLASS_CD, BIZ_TYPE_CD LIMIT ?, ? " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		lstartidx = m_lpage2*ROW_B;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage2*ROW_B+ROW_B;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_B ; i++)
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
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage2 > 0 )
		{
			m_lActRow = 0;
			
			DlgTbl_SetActive(ID_TBLLIST , m_lActRow+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActRow+1, TABLEACTIVE_COLOR);
			
			Mem_Set((byte*)m_szBiz_type_cd , 0x00, sizeof(m_szBiz_type_cd));
			Mem_Set((byte*)m_szBiz_type_class_cd , 0x00, sizeof(m_szBiz_type_class_cd));
			Str_Cpy( m_szBiz_type_cd ,       DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 2)  );
			Str_Cpy( m_szBiz_type_class_cd , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
			
			m_lActRow2 = 0;
			Draw_Prod();
		}
		else
		{
			m_lActRow = -1;
			m_lActRow2 = -1;
			Mem_Set((byte*)m_szBiz_type_cd , 0x00, sizeof(m_szBiz_type_cd));
			Mem_Set((byte*)m_szBiz_type_class_cd , 0x00, sizeof(m_szBiz_type_class_cd));	
		}
		
		ON_DRAW();
	}


	void Chk_Prod(void)
	{
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 64702, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMtr.szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",      stMtr.szMtr_num );

		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_ProdChk; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR64702_IN",  "FR64702" , sndbuf, szbuf );

	}

	long Rcv_ProdChk(void)
	{
		long ret = 0;
		char szSql[300];

		ret = Chk_Json_64702();
		
		g_Sock_Close();
		
		if( ret >= 0)
		{	
			OnInit(INIT_PROD);
			ON_DRAW();
			return 1;
		}
		else
		{	
			OnInit(INIT_MAIN);
			ON_DRAW();	
			
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PRDT), RED); 
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PRDT), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), TRUE );
			
			return -1;

		}

	}

	long Chk_Json_64702(void)
	{
		char szJsonpath[500];
		char szMsg[500];
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		char *pStr = NULL;
		char *szCode = NULL;
		char *szMessage = NULL;
		long *nCol = NULL;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 11;
		
		char szTmp[100];
		handle hitem = NULL;
		handle hcnt = NULL;
		
		
		char *szRslt= NULL;
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 64702, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 64702, 0 );
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
		
		for(i = 0; i < fsize - 9; i++ )
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
			{
				break;
			}
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
		
		/********************************/
		/* 정상 Callback                */
		/********************************/
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szCode = JSON_GetValue (g_pjcomm, "code", szType);
			szMessage = JSON_GetValue (g_pjcomm, "message", szType);
			
			
			szRslt		= JSON_GetValue (g_pjcomm, "rslt", szType);
			
			/********************************/
			/* 비정상 Callback              */
			/********************************/
			if( Str_Cmp(szCode, "0000") != 0)
			{
			  	char* pMsg = NULL;
				
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szMessage) < 500 )
				{
					SQL_ConvMbStr( szMsg, szMessage);
				}
				
				//SPRINT(szJsonpath, "[%s] %s", szCode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szCode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				
				EvtDraw();
				
				ret = -1;
			}
			/********************************/
			/* 정상 Callback                */
			/********************************/
			else
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szRslt);
				
				Mem_Set((byte*) m_szTrans_info_rslt, 0x00, sizeof( m_szTrans_info_rslt) );
				Str_Cpy( m_szTrans_info_rslt, szTmp );
			}
		}
		/********************************/
		/* 비정상 Callback              */
		/********************************/
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
	
	
	void Get_Burclasscd(char* key1, char* key2,  char* burclscd)
	{
	long i;
	char sztmp[10];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql,"SELECT BURNER_CLASS_CD FROM C6101_PROMISE_BUR  WHERE  \
(INST_FLAG <> '30' OR  INST_FLAG  IS NULL) AND PROMISE_ASSIGN_SEQ= ? AND MTR_NUM = ?  GROUP BY BURNER_CLASS_CD ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)key1 , 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)key2 , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    ,10 +1, DECRYPT );
			Str_Cat(burclscd, sztmp);
		}
//PRINT("burclscd[%s]",burclscd,0,0);
Finally:
		DelSqLite(sql);
		return;
	}
	
	
	
	
	
	void Draw_Prod(void)
	{
	long i, idx;
	long k = ROWP+1;
	long lTotPage;
	long lstartidx;
	char sztmp[51];
	char szbuf[51];
	char szSql[600];
	
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
	char szBiz_class_cd2[3];
	char szBurner_class_cd[10 ];

		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBiz_class_cd2, 0x00, sizeof(szBiz_class_cd2) );
		
		//SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);
		if(Str_Cmp(m_szBiz_type_cd, "090003" ) == 0 || Str_Cmp(m_szBiz_type_cd, "040006" ) == 0 
		|| Str_Cmp(m_szBiz_type_cd, "040008" ) == 0)
			Str_Cpy(szBiz_class_cd2, "01");
		else
			Str_Cpy(szBiz_class_cd2, "");

		
		Mem_Set( (byte*)szBurner_class_cd, 0x00, sizeof(szBurner_class_cd) );
		Get_Burclasscd(g_szCHK_EXEC_NUM, stMtr.szMtr_num, szBurner_class_cd );
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, " SELECT count(*) \
FROM C6101_BIZ_PROD A \
WHERE A.BIZ_TYPE_CLASS_CD IN ( '%s', '%s' ) \
AND A.PROD_CD IN (SELECT PROD_CD \
FROM C6101_BIZ_BURN  WHERE BURNER_CLASS_CD ='%s' ) ", m_szBiz_type_class_cd, szBiz_class_cd2, szBurner_class_cd );
		
		
//PRINT("%s",szSql,0,0);

		g_Sql_RetInt(szSql, &m_lTotpage3);
		
		if( m_lTotpage3 % ROW_P > 0 )
		{
			m_lTotpage3 = (m_lTotpage3 / ROW_P) + 1;
		}
		else
		{
			m_lTotpage3 = m_lTotpage3 / ROW_P;
		}
		
		SPRINT(m_szCnt_index2, "%d/%d", m_lpage3+1, m_lTotpage3,0);
		
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		
		hstmt = sql->CreateStatement(sql, "SELECT A.PROD_CD PROD_CD, \
(SELECT PROD_NM FROM C6101_PROD X WHERE X.PROD_CD = A.PROD_CD) PROD_NM \
FROM C6101_BIZ_PROD A \
WHERE A.BIZ_TYPE_CLASS_CD IN ( ?, ? ) \
	AND A.PROD_CD IN ( SELECT PROD_CD \
       FROM C6101_BIZ_BURN  WHERE BURNER_CLASS_CD = ? \
) \
GROUP BY A.PROD_CD LIMIT ?, ? " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
			
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)m_szBiz_type_class_cd , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)szBiz_class_cd2 , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)szBurner_class_cd , 10, DECRYPT);
		
		lstartidx = m_lpage3*ROW_P;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage3*ROW_P+ROW_P;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// 등록된 코드 리스트를 페이지에 맞게 보여준다.
		for (i=0 ; i<ROW_P ; i++)
		{
			//자료가 없을때 화면을 클리어 시킨다.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST2, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 1, "" );
				k = i + 1;
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST2, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 1, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 8, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 1, sztmp );				
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage3 > 0 )
		{
			m_lActRow2 = 0;
			DlgTbl_SetActive(ID_TBLLIST2 , m_lActRow2+1 );
			DlgTbl_SetRowColor(ID_TBLLIST2, m_lActRow2+1, TABLEACTIVE_COLOR);
			Mem_Set((byte*)m_szProd_cd , 0x00, sizeof(m_szProd_cd));
			Mem_Set((byte*)m_szProd_nm , 0x00, sizeof(m_szProd_nm));			
			Str_Cpy( m_szProd_cd , DlgTbl_GetStr( ID_TBLLIST2, m_lActRow2, 0)  );
			Str_Cpy( m_szProd_nm , DlgTbl_GetStr( ID_TBLLIST2, m_lActRow2, 1)  );
		}
		else
		{
			m_lActRow2 = -1;
			Mem_Set((byte*)m_szProd_cd , 0x00, sizeof(m_szProd_cd));
			Mem_Set((byte*)m_szProd_nm , 0x00, sizeof(m_szProd_nm));
		}
		ON_DRAW();
	}
	
	
	bool Save_Prod(void)
	{
		handle* sql;
		char * sqlstr = "";	
		char szMsg[150];
		
		if (Str_Cmp(m_originProd_cd, m_szProd_cd) == 0 )
		{
			
			// if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) != 0)
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "처음 설정된 상품코드와 같은 상품코드를 선택하셨습니다.\n[%s] 상품코드로 진행합니다.", m_originProd_cd, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);

			m_chkVC = 1;

			// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), FALSE );
			// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_INDI_VC), TRUE );

			sql = STRING_Create(sqlstr);
			STRING_Empty(sql);
			STRING_Append(sql," UPDATE C6101_PROMISE_ASSIGN SET ");
			STRING_Append(sql," PROD_CHG = '");
			STRING_Append(sql,  "N");
			STRING_Append(sql,"' WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql,  g_szCHK_EXEC_NUM);
			STRING_Append(sql,"' ");		
			sqlstr = STRING_toString(sql);
			PRINT("sqlstr : %s",sqlstr,0,0);
			g_Sql_DirectExecute(sqlstr);
			STRING_Finalize(sql);

			sql = STRING_Create(sqlstr);
			STRING_Empty(sql);
			STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
			STRING_Append(sql," PROD_CD =  '");
			STRING_Append(sql,  m_originProd_cd );
			STRING_Append(sql,"' ,PROD_NM ='");
			STRING_Append(sql,  m_szProd_nm);
			STRING_Append(sql,"' ,PROD_CHG = '");
			STRING_Append(sql,  "N");
			STRING_Append(sql,"' ,BIZ_TYPE_CD = '");
			STRING_Append(sql,  m_szBiz_type_cd);
			STRING_Append(sql,"' ,SEND_YN = 'S' WHERE MTR_NUM = '");
			STRING_Append(sql,  stMtr.szMtr_num );
			STRING_Append(sql,"' AND PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql,  g_szCHK_EXEC_NUM);
			STRING_Append(sql,"' ");		
			sqlstr = STRING_toString(sql);
			g_Sql_DirectExecute(sqlstr);
			STRING_Finalize(sql);

			return TRUE;

		}
		else{

			if( Str_Len(m_szProd_cd) == 0  )
			{
				MessageBoxEx (ERROR_OK, "연소기를 등록하고 상품을 선택하세요.");
				return FALSE;
			}

			if(m_lActRow2 == -1)
			{
				MessageBoxEx (ERROR_OK, "상품을 선택하세요.");
				return FALSE;
			}

			// 20170915, 20180202추가개발,  정진혁 차장님 요청, 신기호 개발 : 상품코드 14,16,24,26,34,37,41,45,47,51,52,53,54,55,56,58,59,79,88은 납기일 26인 경우에만 변경(선택) 가능
			if( Str_Cmp(stMw.szDeadline_flag,"26") != 0 )
			{
				if( Str_Cmp(m_szProd_cd,"14") == 0 || Str_Cmp(m_szProd_cd,"16") == 0 || Str_Cmp(m_szProd_cd,"24") == 0 
				|| Str_Cmp(m_szProd_cd,"26") == 0 || Str_Cmp(m_szProd_cd,"34") == 0 || Str_Cmp(m_szProd_cd,"37") == 0 
				|| Str_Cmp(m_szProd_cd,"41") == 0 || Str_Cmp(m_szProd_cd,"45") == 0 || Str_Cmp(m_szProd_cd,"47") == 0 
				|| Str_Cmp(m_szProd_cd,"51") == 0 || Str_Cmp(m_szProd_cd,"52") == 0 || Str_Cmp(m_szProd_cd,"53") == 0
				|| Str_Cmp(m_szProd_cd,"54") == 0 || Str_Cmp(m_szProd_cd,"55") == 0 || Str_Cmp(m_szProd_cd,"56") == 0 
				|| Str_Cmp(m_szProd_cd,"58") == 0 || Str_Cmp(m_szProd_cd,"59") == 0 || Str_Cmp(m_szProd_cd,"79") == 0 
				|| Str_Cmp(m_szProd_cd,"88") == 0 )
				{
					MessageBoxEx (ERROR_OK, "해당상품은 26납기만\n변경(선택)가능합니다.");
					return FALSE;
				}
			}

			// 20171123 정진혁 차장님 추가요청, 신기호 개발 : 계량기등급 100등급 미만 중앙난방상품 선택불가
			if( Str_AtoI(stMtr.szMtr_grd) < 100 && Str_Cmp(m_szProd_cd,"16") == 0 )
			{
				MessageBoxEx (ERROR_OK, "계량기등급 100등급 미만인 경우\n<중앙난방>상품선택 불가합니다.");
				return FALSE;
			}

			//0128 연소기일 경우에만 해야하는지 
			//20220103 상품변경시 같은상품으로 변경하면 안되도록 설정
			
			if(g_nWorkFlag == 650)
			{
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) != 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0 )
				{
					if (Str_Cmp(stMtr.szProd_cd, m_szProd_cd) == 0 )
					{
					MessageBoxEx (ERROR_OK, "같은 상품으로 변경 불가능 합니다.");
					return TRUE;
					}	
				}				
			}
	
			if( g_nWorkFlag == 660 )
			{
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0)
				{
					if (Str_Cmp(stMtr.szProd_cd, m_szProd_cd) == 0 )
					{
					MessageBoxEx (ERROR_OK, "같은 상품으로 변경 불가능 합니다.");
					return TRUE;
					}	
				}
			}

			/* 20180202 정진혁 차장님 제외요청 -> 아래 로직으로 대체함
			// 20171123 정진혁 차장님 추가요청, 신기호 개발 : 군부대 특소세감면상품 일반과세 전환 후 상품변경가능 여부 -> 20180222 정진혁 차장님 요청
			if(( Str_Cmp(stMtr.szProd_cd, "36") == 0 || Str_Cmp(stMtr.szProd_cd,"37") == 0 || Str_Cmp(stMtr.szProd_cd,"39") == 0 ) && ( Str_Cmp(m_szProd_cd,"36") != 0 && Str_Cmp(m_szProd_cd,"37") != 0 && Str_Cmp(m_szProd_cd, "39") != 0 ))
			{
				if( Str_Cmp(stMw.szZero_tax_rt_apply_yn,"2") == 0 && Str_Cmp(stMw.szSpecial_tax_exemp_yn,"Y") == 0 ) 
				{
					MessageBoxEx (ERROR_OK, "군부대(특소세감면)상품 입니다.\n일반과세 전환 후 상품변경 가능합니다.");
					return FALSE;
				}
			}
			*/
			
			// 20180202 정진혁 차장님 추가요청, 신기호 개발 : 군부대 상품에서 일반상품 전환시 알림 추가
			// 이전상품이 36 37 39 인데 바꿀 상품이 36 37 39 가 아닐때
			if(( Str_Cmp(stMtr.szProd_cd, "36") == 0 || Str_Cmp(stMtr.szProd_cd,"37") == 0 || Str_Cmp(stMtr.szProd_cd,"39") == 0 || Str_Cmp(stMtr.szProd_cd,"81") == 0 || Str_Cmp(stMtr.szProd_cd,"82") == 0 || Str_Cmp(stMtr.szProd_cd,"83") == 0 || Str_Cmp(stMtr.szProd_cd,"84") == 0 || Str_Cmp(stMtr.szProd_cd,"86") == 0 ) 
			    && ( Str_Cmp(m_szProd_cd,"36") != 0 && Str_Cmp(m_szProd_cd,"37") != 0 && Str_Cmp(m_szProd_cd, "39") != 0 || Str_Cmp(stMtr.szProd_cd,"81") != 0 || Str_Cmp(stMtr.szProd_cd,"82") != 0 || Str_Cmp(stMtr.szProd_cd,"83") != 0 || Str_Cmp(stMtr.szProd_cd,"84") != 0 || Str_Cmp(stMtr.szProd_cd,"86") != 0))
			{
				if( MessageBoxEx(CONFIRM_YESNO, "종전상품이 군부대 상품입니다.\n일반상품으로 계약하시겠습니까?") != MB_OK)
				{
					return FALSE;
				}
			}
			
			// 20180116 정진혁 차장님 추가요청, 신기호 개발 : 군부대 상품은 군부대사업자만 가능하도록 코드 추가
			if( Str_Cmp(m_szProd_cd, "36") == 0 || Str_Cmp(m_szProd_cd, "37") == 0 || Str_Cmp(m_szProd_cd, "39") == 0 || Str_Cmp(m_szProd_cd, "81") == 0 || Str_Cmp(m_szProd_cd, "82") == 0 
			    || Str_Cmp(m_szProd_cd, "83") == 0 || Str_Cmp(m_szProd_cd, "84") == 0 || Str_Cmp(m_szProd_cd, "86") == 0 )
			{
				if( Str_Cmp(stMw.szGet_spc_tax_chk,"F") == 0 ) 
				{
					MessageBoxEx (ERROR_OK, "군부대 상품은 \n군부대 사업자만 \n선택가능합니다.");
					return FALSE;
				}
			}
			
			// 20190607 정진혁 차장님 추가요청, 신기호 개발 : 일반 상품코드에서 산업용 상품코드 41, 47로 변경 불가
			if( ( Str_Cmp(stMtr.szProd_cd, "41") != 0 && Str_Cmp(stMtr.szProd_cd, "47") != 0 ) && ( Str_Cmp(m_szProd_cd, "41") == 0 || Str_Cmp(m_szProd_cd, "47") == 0 ) )
			{
				MessageBoxEx (ERROR_OK, "산업용 상품으로\n변경(선택) 불가합니다.");
				return FALSE;
			}

			m_chkVC = 0;
			
			Str_Cpy(stMw.szProd_yn,"Y");
			
			sql = STRING_Create(sqlstr);
			STRING_Empty(sql);
			STRING_Append(sql," UPDATE C6101_PROMISE_ASSIGN SET ");
			STRING_Append(sql," PROD_CHG = '");
			STRING_Append(sql,  "Y");
			STRING_Append(sql,"' WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql,  g_szCHK_EXEC_NUM);
			STRING_Append(sql,"' ");		
			sqlstr = STRING_toString(sql);
			PRINT("sqlstr : %s",sqlstr,0,0);
			g_Sql_DirectExecute(sqlstr);
			STRING_Finalize(sql);

			sql = STRING_Create(sqlstr);
			STRING_Empty(sql);
			STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
			STRING_Append(sql," PROD_CD =  '");
			STRING_Append(sql,  m_szProd_cd );
			STRING_Append(sql,"' ,PROD_NM ='");
			STRING_Append(sql,  m_szProd_nm);
			STRING_Append(sql,"' ,BIZ_TYPE_CD = '");
			STRING_Append(sql,  m_szBiz_type_cd);
			STRING_Append(sql,"' ,PROD_CHG = '");
			STRING_Append(sql,  "Y");
			STRING_Append(sql,"' ,SEND_YN = 'S' WHERE MTR_NUM = '");
			STRING_Append(sql,  stMtr.szMtr_num );
			STRING_Append(sql,"' AND PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql,  g_szCHK_EXEC_NUM);
			STRING_Append(sql,"' ");		
			sqlstr = STRING_toString(sql);
			g_Sql_DirectExecute(sqlstr);
			STRING_Finalize(sql);
		
			

			return TRUE;

		}
		
		
	}
	
	
	void ReDraw(void)
	{
	char sztmp[51];
	char szSql[301];
	handle hdb = NULL;
	handle hstmt = NULL;
	long i;
		
		if( m_bFirst == INIT_MAIN )
		{
			SQLITE sql = NewSqLite();
				
			Mem_Set( (byte*)stMtr.szIndi_vc, 0x00, sizeof(stMtr.szIndi_vc) );
			Mem_Set( (byte*)stMtr.szIndi_va, 0x00, sizeof(stMtr.szIndi_va) );
			Mem_Set( (byte*)stMtr.szIndi_vm, 0x00, sizeof(stMtr.szIndi_vm) );
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally;
			}
	
			hstmt = sql->CreateStatement(sql," select MTR_DETA_LOC,MTR_MODEL_NM,MTR_GRD,MTR_SUPPLY_STS_NM,KEEPER_YN, MTR_FORM_NM,\
SEALED_STS,MTR_VALID_YM, COMPENS_MODEL_NM,INDI_VC_AFTER, INDI_VA_AFTER, INDI_VM_AFTER,INDI_VC,INDI_VA,INDI_VM, REVIS_FLAG,\
MTR_ID_NUM, USE_CONT_NUM, INDI_TYPE_CD, INDI_TYPE_NM,PROD_CONT_SEQ, PROD_CD, INST_PLACE_NUM, MTR_DIGIT_CNT,BIZ_TYPE_CD, PROD_NM \
from C6101_PROMISE_MTR where PROMISE_ASSIGN_SEQ = ? and MTR_NUM = ? ");
	
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
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_deta_loc     ,30 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_model_nm     ,50 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_grd          ,7  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_supply_sts_nm,50 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szKeeper_yn        ,2  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_form_nm      ,50 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szSealed_sts       ,2  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_valid_ym     ,6  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szCompens_model_nm ,50 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vc_after    ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_va_after    ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vm_after    ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vc          ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_va          ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vm          ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szRevis_flag       ,2  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_id_num       ,26 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szUse_cont_num     ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_type_cd     ,2  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_type_nm     ,50 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szProd_cont_seq    ,3  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szProd_cd          ,5  +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szInst_place_num   ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szMtr_digit_cnt    ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szBiz_type_cd    ,10 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*)stMtr.szProd_nm    ,10 +1, DECRYPT );
			};
			
	Finally:
	
	//		sql->Commit(sql);
			DelSqLite(sql);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_DETA_LOC ), stMtr.szMtr_deta_loc);	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_MODEL_NM ), stMtr.szMtr_model_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_GRD ), stMtr.szMtr_grd);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_SUPPLY_STS_NM ), stMtr.szMtr_supply_sts_nm);	
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );//키퍼
			SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID= 'C30107' AND  CODE_ITEM ='%s' ",stMtr.szKeeper_yn, 0, 0   );
			g_Sql_RetStr( szSql, 50, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_KEEPER_YN ), sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_FORM_NM ), stMtr.szMtr_form_nm);	
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID= 'C30089' AND  CODE_ITEM ='%s' ", stMtr.szSealed_sts, 0, 0   );
			g_Sql_RetStr( szSql, 50, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_SEALED_STS ), sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			g_Str_DateType( sztmp, stMtr.szMtr_valid_ym );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_VALID_YM ), sztmp);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_COMPENS_MODEL_NM ), stMtr.szCompens_model_nm);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VC_AFTER ), stMtr.szIndi_vc_after );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VC ), stMtr.szIndi_vc);
			
			if( stMw.szProd_yn[0] == 'Y')
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PRDT), RED); 
			else
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PRDT), BTNMENUFRCOLOR);
			
			if( g_lRfrmFlag == 1)
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHGMTR), RED); 
			else
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CHGMTR), BTNMENUFRCOLOR);
			
			if( g_lPAYFlag == 1)
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BILL), RED); 
			else
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BILL), BTNMENUFRCOLOR);
			
			if(Str_Cmp(stMtr.szRevis_flag, "10") == 0)
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VA_AFTER), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA_AFTER), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VA), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VM_AFTER), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM_AFTER), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VM), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM), FALSE);
				
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VA_AFTER ), stMtr.szIndi_va_after);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VM_AFTER ), stMtr.szIndi_vm_after);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VA ), stMtr.szIndi_va);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VM ), stMtr.szIndi_vm);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VA_AFTER), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA_AFTER), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VA), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VM_AFTER), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM_AFTER), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VM), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM), TRUE);
			}
		}
		else if( m_bFirst == INIT_CHGINDI )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_ID_NUM ),    stMtr.szMtr_id_num    );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_MODEL_NM ), stMtr.szMtr_model_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_GRD ),      stMtr.szMtr_grd          );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VC_AFTER ), "0"         );
			
			if(Str_Cmp(stMtr.szRevis_flag, "10") == 0)
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VA), FALSE);			
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA_BEFO), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VA_AFTER), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VM), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM_BEFO), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VM_AFTER), FALSE);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VA_AFTER ), "0"         );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VM_AFTER ), "0"         );
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VA), TRUE);			
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA_BEFO), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VA_AFTER), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_VM), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM_BEFO), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_CUT_VM_AFTER), TRUE);
			}
		}
		else if( m_bFirst == INIT_NOPAY )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ= '%s' ", stMtr.szPromise_assign_seq, 0, 0   );
			g_Sql_RetStr( szSql, 50, sztmp );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA01 ), sztmp );
		}
		else if( m_bFirst == INIT_BILLDTL )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_PERIOD_DAY         ), stBill.szPERIOD_DAY         );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_USE_DAY            ), stBill.szUSE_DAY            );
			
			Str_Cpy( sztmp, stBill.szTOT_USE_QTY );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_USE_QTY        ), sztmp );
			Str_Cpy( sztmp, stBill.szTOT_BASE_CHARG );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_BASE_CHARG     ), sztmp );
			Str_Cpy( sztmp, stBill.szTOT_CNL_CHARG );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_CNL_CHARG      ), sztmp );
			Str_Cpy( sztmp, stBill.szSUPPLY_UNIT_ENER );
			//Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_SUPPLY_UNIT_ENER   ), sztmp );
			Str_Cpy( sztmp, stBill.szTOT_REVIS_QTY );
			//Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_REVIS_QTY      ), sztmp );
			
			Str_Cpy( sztmp, stBill.szTOT_DISC_AMT );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_DISC_AMT       ), sztmp );
			
			Str_Cpy( sztmp, stBill.szTOT_ADJ_CHARG );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_ADJ_CHARG      ), sztmp );
			Str_Cpy( sztmp, stBill.szUSE_CHARG_DISC_AMT );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_USE_CHARG_DISC_AMT ), sztmp );
			Str_Cpy( sztmp, stBill.szOVERDUE_AMT );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_OVERDUE_AMT        ), sztmp );
			Str_Cpy( sztmp, stBill.szTOT_REPL_COST );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_REPL_COST      ), sztmp );
			Str_Cpy( sztmp, stBill.szTHIS_MM_CALCU_AMT );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_THIS_MM_CALCU_AMT  ), sztmp );
			Str_Cpy( sztmp, stBill.szTOT_REVIS_CHARG );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TOT_REVIS_CHARG    ), sztmp );
			Str_Cpy( sztmp, stBill.szADJ_ALT_AMT );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_ADJ_ALT_AMT        ), sztmp );
			Str_Cpy( sztmp, stBill.szREQ_AMT );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_REQ_AMT            ), sztmp );
		}
		else if( m_bFirst == INIT_LASTINDI    )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_DATA01  ), stMtr.szIndi_type_nm );
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_DATA02  ), stMtr.szIndi_vc_after );
			
			if(Str_Cmp(stMtr.szRevis_flag, "10") == 0)
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_DATA03), FALSE);			
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_DATA04), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_DATA03), FALSE);			
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_DATA04), FALSE);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_DATA03  ), stMtr.szIndi_va_after );
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_DATA04  ), stMtr.szIndi_vm_after );
			}
		}
		else
		{
			m_lActRow = 0;
			Draw_Biz();
		}
	}
	
	void Save_Mtr(void)
	{
	char szSql[300];
	char sztmp[50];
	handle* sql;
	char * sqlstr = "";	
	
		if ( IsMessageBox() )
			return;

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
		STRING_Append(sql,"',INDI_VA ='");
		STRING_Append(sql,stMtr.szIndi_va);
		STRING_Append(sql,"',INDI_VM ='");
		STRING_Append(sql,stMtr.szIndi_vm);
		STRING_Append(sql,"' ,UPD_EMPID = '");
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
	}
	
	void Snd_LastIndi(void)
	{
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 64202, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMtr.szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",      stMtr.szMtr_num );

		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_LastIndi; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR64202_IN",  "FR64202" , sndbuf, szbuf );
	}
	
	long Rcv_LastIndi(void)
	{
	long ret;
	handle* sql;
	char * sqlstr = "";

		g_Sock_Close();
		ret = Chk_Json_64202();
		if( ret > 0)
		{
			sql = STRING_Create(sqlstr);
			STRING_Empty(sql);
			STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
			STRING_Append(sql," INDI_TYPE_CD =  '");
			STRING_Append(sql,stMtr.szIndi_type_cd);
			STRING_Append(sql,"' ,INDI_TYPE_NM ='");
			STRING_Append(sql,stMtr.szIndi_type_nm);
			STRING_Append(sql,"' ,INDI_VC_AFTER = '");
			STRING_Append(sql,  stMtr.szIndi_vc_after);
			STRING_Append(sql,"' ,INDI_VA_AFTER = '");
			STRING_Append(sql,  stMtr.szIndi_va_after);
			STRING_Append(sql,"' ,INDI_VM_AFTER = '");
			STRING_Append(sql,  stMtr.szIndi_vm_after);
			STRING_Append(sql,"'  WHERE USE_CONT_NUM = '");
			STRING_Append(sql,  stMtr.szUse_cont_num );
			STRING_Append(sql,"' AND MTR_NUM = '");
			STRING_Append(sql,  stMtr.szMtr_num);
			STRING_Append(sql,"' ");			
			sqlstr = STRING_toString(sql);
			g_Sql_DirectExecute(sqlstr);
			STRING_Finalize(sql);
			
			ON_EXIT();
			OnInit(INIT_LASTINDI);
			ON_DRAW();		

			return 1;
		}
		else if( ret == 0)
		{
			MessageBoxEx (ERROR_OK, "자료가 없습니다.");
			return 1;
		}
		
		else
		{
			MessageBoxEx (ERROR_OK, "저장 실패.");
			ON_DRAW();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	// 기  능 : 전송 결과 파일을 검토한다.
	// 설  명 : 
	// 리턴값 : 1:정상적인 통신완료, 0: 에러응답or응답형식오류, -1: 알수없는 에러
	//----------------------------------------------------------------------------------
	long Chk_Json_64202(void)
	{
	char szJsonpath[500];
	char szMsg[500];
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	char szIndi_type_nm[100];
	long    *nCol;
	long	nCnt = 0;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 64202, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 64202, 0 );
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
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							if( ret > 0)
							{
								
								Mem_Set((byte*) stMtr.szIndi_type_cd, 0x00, sizeof( stMtr.szIndi_type_cd) );
								Mem_Set((byte*) stMtr.szIndi_type_nm, 0x00, sizeof( stMtr.szIndi_type_nm) );
								Mem_Set((byte*) stMtr.szIndi_vc_after, 0x00, sizeof( stMtr.szIndi_vc_after) );
								Mem_Set((byte*) stMtr.szIndi_va_after, 0x00, sizeof( stMtr.szIndi_va_after) );
								Mem_Set((byte*) stMtr.szIndi_vm_after, 0x00, sizeof( stMtr.szIndi_vm_after) );
								
								
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "indi_type_cd", szType);
								Str_Cpy( stMtr.szIndi_type_cd, szcode );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "indi_type_nm", szType);
								Str_Cpy( szIndi_type_nm, szcode );
								SQL_ConvMbStr( stMtr.szIndi_type_nm, szIndi_type_nm );
								
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "indi_vc_after", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, stMtr.szIndi_vc_after, 10 );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "indi_va_after", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, stMtr.szIndi_va_after, 10 );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "indi_vm_after", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, stMtr.szIndi_vm_after, 10);
							}
							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
				else
				{
					ret = 0;
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
	
	
	
	
	void Snd_ChgIndi(void)
	{
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	char szIndi_vc_after[10];
	char szIndi_va_after[10];
	char szIndi_vm_after[10];
	char szIndi_vc_befo[10];
	char szIndi_va_befo[10];
	char szIndi_vm_befo[10];
	long ret = 0;
	
		if( MessageBoxEx (CONFIRM_YESNO, "교체지침 등록 하시겠습니까?") != MB_OK)
		{
			return;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VC_BEFO )) == 0 )
		{
			MessageBoxEx (ERROR_OK, "철거지침 VC를 입력하세요.");
			return;
		}

		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_CUT_VC_AFTER )) == 0 )
		{
			MessageBoxEx (ERROR_OK, "교체지침 VC를 입력하세요.");
			return;
		}
		
		if(Str_Cmp(stMtr.szRevis_flag, "10") != 0)
		{
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VA_BEFO )) == 0 )
			{
				MessageBoxEx (ERROR_OK, "철거지침 VA를 입력하세요.");
				return;
			}
	
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_CUT_VA_AFTER )) == 0 )
			{
				MessageBoxEx (ERROR_OK, "교체지침 VA를 입력하세요.");
				return;
			}
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VM_BEFO )) == 0 )
			{
				MessageBoxEx (ERROR_OK, "철거지침 VM를 입력하세요.");
				return;
			}
	
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_CUT_VM_AFTER )) == 0 )
			{
				MessageBoxEx (ERROR_OK, "교체지침 VM를 입력하세요.");
				return;
			}
		}
		
		if(Str_Len(m_szIndi_ymd) != 8)
		{
			MessageBoxEx (ERROR_OK, "교체일자를 입력하세요.");
			return;
		}
			
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szIndi_vc_after, 0x00, sizeof(szIndi_vc_after) );
		Mem_Set( (byte*)szIndi_va_after, 0x00, sizeof(szIndi_va_after) );
		Mem_Set( (byte*)szIndi_vm_after, 0x00, sizeof(szIndi_vm_after) );
		Mem_Set( (byte*)szIndi_vc_befo, 0x00, sizeof(szIndi_vc_befo) );
		Mem_Set( (byte*)szIndi_va_befo, 0x00, sizeof(szIndi_va_befo) );
		Mem_Set( (byte*)szIndi_vm_befo, 0x00, sizeof(szIndi_vm_befo) );
		
		Str_Cpy( szIndi_vc_after,EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VC_AFTER )) );
		Str_Cpy( szIndi_va_after,EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VA_AFTER )) );
		Str_Cpy( szIndi_vm_after,EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_CUT_VM_AFTER )) );
		Str_Cpy( szIndi_vc_befo,EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VC_BEFO      )) );
		Str_Cpy( szIndi_va_befo,EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VA_BEFO      )) );
		Str_Cpy( szIndi_vm_befo,EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VM_BEFO      )) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 64402, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "mtr_num",       stMtr.szMtr_num        );
		JSON_SetValue( g_pjcomm, 'C', "indi_ymd",      m_szIndi_ymd       );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",stMtr.szInst_place_num );
		JSON_SetValue( g_pjcomm, 'C', "indi_vc_after", szIndi_vc_after  );
		JSON_SetValue( g_pjcomm, 'C', "indi_va_after", szIndi_va_after  );
		JSON_SetValue( g_pjcomm, 'C', "indi_vm_after", szIndi_vm_after  );
		JSON_SetValue( g_pjcomm, 'C', "indi_vc_befo",  szIndi_vc_befo   );
		JSON_SetValue( g_pjcomm, 'C', "indi_va_befo",  szIndi_va_befo   );
		JSON_SetValue( g_pjcomm, 'C', "indi_vm_befo",  szIndi_vm_befo   );
		JSON_SetValue( g_pjcomm, 'C', "prod_cd",       stMtr.szProd_cd        );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stMtr.szUse_cont_num   );
		JSON_SetValue( g_pjcomm, 'C', "prod_cont_seq", stMtr.szProd_cont_seq  );

		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_ChgIndi; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR64402_IN",  "FR64402" , sndbuf, szbuf );
	}
	
	long Rcv_ChgIndi(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(64402) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "교체지침이 등록 되었습니다..");
			
			g_lRfrmFlag = 1;
			ON_EXIT();
			OnInit(INIT_MAIN);
			ON_DRAW();
			return 1;
		}
		else
		{
			MessageBoxEx (ERROR_OK, "교체지침 등록 실패.");
			ON_DRAW();
			return -1;
		}
	}

	void Snd_NoPay(void)
	{
	char sztmp[128];
	char szUrl[200];
	char szSql[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"DELETE FROM C6101_NONPAY  WHERE Promise_assign_seq = '%s'",stMw.szPromise_assign_seq,0,0   );
		g_Sql_DirectExecute(szSql);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 64502, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",stMw.szPromise_assign_seq );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",      stMw.szUse_cont_num       );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",   stUserinfo.szcenter_cd );

		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_NoPay; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR64502_IN",  "FR64502" , sndbuf, szbuf );
	}
	
	long Rcv_NoPay(void)
	{
	char szSql[200];
	
		if(g_Chk_Json(64502) >= 0)
		{
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql ,"UPDATE C6101_NONPAY SET CHK='1', CARD_YN='0' WHERE Promise_assign_seq = '%s'",stMw.szPromise_assign_seq,0,0   );
			g_Sql_DirectExecute(szSql);
			
			Snd_Bill();
			return 1;
		}
		else
		{
			g_Sock_Close();
			MessageBoxEx (ERROR_OK, "서버 적용실패.");
			ON_DRAW();
			return -1;
		}
	}
	
	
	void Snd_Bill(void)
	{
	char sztmp[128];
	char szUrl[200];
	char szbuf[128];
	char szMsg[351];
	char szUMsg[701];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szUMsg, 0x00, sizeof(szUMsg) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 64602, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMw.szUse_cont_num );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		
		//g_Save_JsonFile(sndbuf);
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_Bill; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR64602_IN",  "FR64602" , sndbuf, szbuf );
	}
	
	long Rcv_Bill(void)
	{
		long ret = 0;
		char szSql[300];

		ret = Chk_Json_64602();
		
		g_Sock_Close();
		
		if( ret >= 0)
		{
			g_lPAYFlag = 1;
			MessageBoxEx (CONFIRM_OK, "중간정산이 완료 되었습니다.");
			ON_EXIT();
			OnInit(INIT_MAIN);
			ON_DRAW();
			return 1;
		}
		else
		{
			g_lPAYFlag = 0;
			
			if( ret == -2 )
			{
				// 중간정산 초기화
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				
				SPRINT( szSql ,"UPDATE C6101_NONPAY SET CHK='1' WHERE Promise_assign_seq = '%s'",stMw.szPromise_assign_seq,0,0   );
				g_Sql_DirectExecute(szSql);

				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				
				SPRINT( szSql ,"UPDATE C6101_PROMISE_MTR SET CHK_YN='1', INDI_VC='',INDI_VA='', INDI_VM='', ACCOUNT=0, ADJ_CHK='' WHERE Promise_assign_seq = '%s'",stMw.szPromise_assign_seq,0,0   );
				g_Sql_DirectExecute(szSql);

				MessageBoxEx (ERROR_OK, "사용량초과, 지침 재 입력 요망!");
			}
			else if( ret == -3)
			{
				// 중간정산 초기화
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				
				SPRINT( szSql ,"UPDATE C6101_NONPAY SET CHK='1' WHERE Promise_assign_seq = '%s'",stMw.szPromise_assign_seq,0,0   );
				g_Sql_DirectExecute(szSql);

				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				
				SPRINT( szSql ,"UPDATE C6101_PROMISE_MTR SET CHK_YN='1', INDI_VC='',INDI_VA='', INDI_VM='', ACCOUNT=0, ADJ_CHK='' WHERE Promise_assign_seq = '%s'",stMw.szPromise_assign_seq,0,0   );
				g_Sql_DirectExecute(szSql);
				
				MessageBoxEx (ERROR_OK, "중간정산 지침 재 입력 요청!");
			}
			else
			{
				MessageBoxEx (ERROR_OK, "서버 적용실패.");
			}
			
			ON_EXIT();
			OnInit(INIT_MAIN);
			ON_DRAW();
			
			return -1;
		}
	}

	//----------------------------------------------------------------------------------
	// 기  능 : 전송 결과 파일을 검토한다.
	// 설  명 : 
	// 리턴값 : 1:정상적인 통신완료, 0: 에러응답or응답형식오류, -1: 알수없는 에러, -2: 사용량 초기화( 가정용 : 2000 이상, 비가정용 : 5000이상)
	//----------------------------------------------------------------------------------
	long Chk_Json_64602(void)
	{
	char szJsonpath[500];
	char szMsg[500];
	long fd, i, tot;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	long* ncol;
	long nCnt;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
	handle* sql;
	char * sqlstr = "";
	char strMsg[100];
    char strTmp[50];
    
		MessageBox(MESSAGE, "자료 확인중 입니다.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 64602, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 64602, 0 );
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
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, szJsonpath);
				EvtDraw();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							tot = JSON_GetArrayCount( hitem );

							if( tot > 0)
							{
								for( i = 0; i < tot ; i++)
								{
									ncol = (long*)JSON_GetArrayItem ( hitem, i, "use_day", szType);
									nCnt = *ncol;
									Str_ItoA( nCnt,stBill.szUSE_DAY ,10 );
									//Str_Cpy( stBill.szUSE_DAY, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "period_day", szType);
									Str_Cpy( stBill.szPERIOD_DAY, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_use_qty", szType);
									Str_Cpy( stBill.szTOT_USE_QTY, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_disc_amt", szType);
									Str_Cpy( stBill.szTOT_DISC_AMT, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "use_charg_disc_amt", szType);
									Str_Cpy( stBill.szUSE_CHARG_DISC_AMT, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_base_charg", szType);
									Str_Cpy( stBill.szTOT_BASE_CHARG, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_repl_cost", szType);
									Str_Cpy( stBill.szTOT_REPL_COST, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_cnl_charg", szType);
									Str_Cpy( stBill.szTOT_CNL_CHARG, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_adj_charg", szType);
									Str_Cpy( stBill.szTOT_ADJ_CHARG, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "this_mm_calcu_amt", szType);
									Str_Cpy( stBill.szTHIS_MM_CALCU_AMT, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "overdue_amt", szType);
									Str_Cpy( stBill.szOVERDUE_AMT, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "req_amt", szType);
									Str_Cpy( stBill.szREQ_AMT, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "adj_alt_amt", szType);
									// Str_Cpy( stBill.szADJ_ALT_AMT, "10000" );
									Str_Cpy( stBill.szADJ_ALT_AMT, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_revis_qty", szType);
									Str_Cpy( stBill.szTOT_REVIS_QTY, szcode );
									
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_revis_charg", szType);
									Str_Cpy( stBill.szTOT_REVIS_CHARG, szcode );
									
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "supply_unit_ener", szType);
									Str_Cpy( stBill.szSUPPLY_UNIT_ENER, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "tot_ener_qty", szType);
									Str_Cpy( stBill.szTOT_ENER_QTY, szcode );
									
									if( g_nWorkFlag == 630 )
									{
										Str_Cpy( stBill.szREQ_YM, "10" );
									}
									else
									{
										szcode = (char*)JSON_GetArrayItem ( hitem, i, "req_ym", szType);
										Str_Cpy( stBill.szREQ_YM, szcode );
									}
									
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "deadline_flag", szType);
									Str_Cpy( stBill.szDEADLINE_FLAG, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "use_cont_num", szType);
									Str_Cpy( stBill.szUSE_CONT_NUM, szcode );

									szcode = (char*)JSON_GetArrayItem ( hitem, i, "mtr_num", szType);
									Str_Cpy( stBill.szMTR_NUM, szcode );
									
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "use_period_str", szType);
									Str_Cpy( stBill.szUSE_PERIOD_STR, szcode );
									szcode = (char*)JSON_GetArrayItem ( hitem, i, "use_period_end", szType);
									Str_Cpy( stBill.szUSE_PERIOD_END, szcode );
									
									
									sql = STRING_Create(sqlstr);
									STRING_Empty(sql);
									STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
									STRING_Append(sql," ACCOUNT = " );
									STRING_Append(sql, stBill.szREQ_AMT );
									STRING_Append(sql," ,TOT_USE_QTY = " );
									STRING_Append(sql,stBill.szTOT_USE_QTY );

									// 2018.01.17 요금팀 황영자 과장님 요청 : 가정용 사용량 2000 이상, 비가정용 5000 이상 일 경우 지침 재입력 요청
									if( m_Re_Adj_Cnt > 0 )
									{
										if( Str_Cmp(m_After_Vc, stMtr.szIndi_vc) == 0 )
										{
											m_Re_Adj_Cnt = 0;
											STRING_Append(sql," ,ADJ_CHK = 'Y' ,ADJ_YMD = '");	
										}
										else
										{
											Mem_Set((byte *)strMsg      , 0x00, sizeof(strMsg));
											Mem_Set((byte *)strTmp      , 0x00, sizeof(strTmp));
											
											Str_Cpy( strTmp, stBill.szREQ_AMT );
											Str_Chg( strTmp, STRCHG_INS_COMMA );
			
											Str_Cat(strMsg, "중간정산 반영 하시겠습니까?\n ");
											Str_Cat(strMsg, "\n사용량 : ");
											Str_Cat(strMsg, stBill.szTOT_USE_QTY);
											Str_Cat(strMsg, "\n청구금액 : ");
											Str_Cat(strMsg, strTmp);
											Str_Cat(strMsg, "원");
											
											if(MessageBoxEx(CONFIRM_YESNO, strMsg) != MB_OK)
											{
												STRING_Append(sql," ,ADJ_CHK = '' ,ADJ_YMD = '");
												ret = -3;
											}
											else
											{
												m_Re_Adj_Cnt = 0;
												STRING_Append(sql," ,ADJ_CHK = 'Y' ,ADJ_YMD = '");
											}
										}
									}
									else
									{	
										if( Str_Cmp(stMtr.szProd_cd, "11") == 0 || Str_Cmp(stMtr.szProd_cd, "12") == 0 || Str_Cmp(stMtr.szProd_cd, "13") == 0 || Str_Cmp(stMtr.szProd_cd, "14") == 0 
										   || Str_Cmp(stMtr.szProd_cd, "81") == 0 || Str_Cmp(stMtr.szProd_cd, "82") == 0 || Str_Cmp(stMtr.szProd_cd, "83") == 0 || Str_Cmp(stMtr.szProd_cd, "84") == 0)
										{
											if( Str_AtoI( stBill.szTOT_USE_QTY ) >= 2000)
											{
												STRING_Append(sql," ,ADJ_CHK = '' ,ADJ_YMD = '");
												
												Mem_Set( (byte*)m_After_Vc, 0x00, sizeof(m_After_Vc) );
												Str_Cpy( m_After_Vc, stMtr.szIndi_vc );
												
												m_Re_Adj_Cnt++;
												
												ret = -2;
											}
											else
											{
												STRING_Append(sql," ,ADJ_CHK = 'Y' ,ADJ_YMD = '");
											}
										}
										else
										{
											if( Str_AtoI( stBill.szTOT_USE_QTY ) >= 5000)
											{
												STRING_Append(sql," ,ADJ_CHK = '' ,ADJ_YMD = '");
												
												Mem_Set( (byte*)m_After_Vc, 0x00, sizeof(m_After_Vc) );
												Str_Cpy( m_After_Vc, stMtr.szIndi_vc );
												
												m_Re_Adj_Cnt++;
												ret = -2;
											}
											else
											{
												STRING_Append(sql," ,ADJ_CHK = 'Y' ,ADJ_YMD = '");
											}
										}
									}

									//STRING_Append(sql," ,ADJ_CHK = 'Y' ,ADJ_YMD = '");
									STRING_Append(sql,  stBill.szADJ_YMD );
									STRING_Append(sql,"' ,REQ_YM = '");
									STRING_Append(sql,  stBill.szREQ_YM );
									STRING_Append(sql,"' ,ADJ_ALT_AMT = '");
									STRING_Append(sql,  stBill.szADJ_ALT_AMT );
	 								STRING_Append(sql,"'  ,DEADLINE_FLAG = '");
									STRING_Append(sql,  stBill.szDEADLINE_FLAG  );
	 								STRING_Append(sql,"'  ,TOT_ENER_QTY = '");
									STRING_Append(sql,  stBill.szTOT_ENER_QTY  );
	 								STRING_Append(sql,"'  ,TOT_REVIS_QTY = '");
									STRING_Append(sql,  stBill.szTOT_REVIS_QTY  );
	 								STRING_Append(sql,"'  ,USE_PERIOD_STR = '");
									STRING_Append(sql,  stBill.szUSE_PERIOD_STR  );
	 								STRING_Append(sql,"'  ,USE_PERIOD_END = '");
									STRING_Append(sql,  stBill.szUSE_PERIOD_END  );
	 								STRING_Append(sql,"'  ,SUPPLY_UNIT_ENER = '");
									STRING_Append(sql,  stBill.szSUPPLY_UNIT_ENER  );
									STRING_Append(sql,"'  WHERE USE_CONT_NUM = '");
									STRING_Append(sql,  stBill.szUSE_CONT_NUM );
									STRING_Append(sql,"' AND MTR_NUM = '");
									STRING_Append(sql,  stBill.szMTR_NUM);
									STRING_Append(sql,"' AND PROMISE_ASSIGN_SEQ = '");
									STRING_Append(sql,  g_szCHK_EXEC_NUM);
									STRING_Append(sql,"' ");			
									sqlstr = STRING_toString(sql);
									g_Sql_DirectExecute(sqlstr);
									STRING_Finalize(sql);
								}
							}
							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
				else
				{
					ret = 0;
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
	
	
	void Snd_AdjBill(void)
	{
	char szUrl[200];
	char szbuf[128];
	char sztmp[128];
	char* sndbuf;
	long ret = 0;
	long i, idx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -100;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		hstmt = sql->CreateStatement(sql, " SELECT INDI_VC, REVIS_FLAG, INDI_VA, INDI_VM, (INDI_VC-INDI_VC_AFTER)  FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = ?  " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -100;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -100;
			goto Finally;
		}		
		
		idx = 0;
		
		while(sql->Next(sql) == TRUE)
		{
			idx++;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 0, 'U', (long*)sztmp, 10, DECRYPT);
			if( Str_Len(sztmp) == 0)
			{
				ret = -1;
				goto Finally;
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 1, 'U', (long*)sztmp, 3, DECRYPT);
			
			if( Str_Cmp( sztmp, "10") != 0 )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				if( Str_Len(sztmp) == 0)
				{
					ret = -2;
					goto Finally;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
				if( Str_Len(sztmp) == 0)
				{
					ret = -3;
					goto Finally;
				}
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 4, 'U', (long*)sztmp, 10, DECRYPT);
			if( Str_AtoI(sztmp) < 0)
			{
				ret = -4;
			}
			
		};
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( Str_Len(stMw.szAdj_cause ) > 0  )
		{
			MessageBoxEx (ERROR_OK, "납부확인서 발행후에 중간정산 할수 없습니다.");
			ON_DRAW();
			return;
		}
		
		if( MessageBoxEx (CONFIRM_YESNO, "중간정산계산을 하시겠습니까?\n(상호정산인 경우 중간정산 금지)") != MB_OK)
		{
			ON_DRAW();
			return;
		}
		
		if( ret == -1)
		{
			MessageBoxEx (ERROR_OK, "지침VC를 입력하세요!");
			ON_DRAW();
			return;
		}
		else if (ret == -2)
		{
			MessageBoxEx (ERROR_OK, "지침VA를 입력하세요!");
			ON_DRAW();
			return;
		}
		else if (ret == -3)
		{
			MessageBoxEx (ERROR_OK, "지침VM를 입력하세요!");
			ON_DRAW();
			return;
		}
		else if (ret == -4)//역지침 체크
		{
			if( MessageBoxEx (ERROR_YESNO, "역지침 입니다.\n중간정산을 계속 진행 하시겠습니까?") != MB_OK)
			{
				ON_DRAW();
				return;
			}
		}
		
		if(idx == 0)
		{
			MessageBoxEx (ERROR_OK, "계량기가 존재하지 않습니다!");
			ON_DRAW();
			return;
		}
		
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 64302, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq", stMtr.szPromise_assign_seq );
		
		Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_AdjBill; //통신완료 후에 호출 함수
		ret = HTTP_DownloadData(szUrl, "FR64302_IN",  "FR64302" , sndbuf, szbuf );
	}
	
	long Add_Item(handle pj)
	{
	long ret = -1;
	long idx = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	handle js = NULL;
	char szuse_cont_num[11];
	char szprod_cont_seq[11];
	char szadj_ymd[9];
	char szindi_vc_after[11];
	char szindi_va_after[11];
	char szindi_vm_after[11];
		
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
	
		hstmt = sql->CreateStatement(sql, "SELECT USE_CONT_NUM, PROD_CONT_SEQ,INDI_VC,INDI_VA,INDI_VM \
 FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		Mem_Set( (byte*)szadj_ymd,0x00, sizeof(szadj_ymd) );
		Str_ItoA( Time_GetDate(), szadj_ymd, 10);
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szuse_cont_num, 0x00, sizeof(szuse_cont_num) );
			Mem_Set( (byte*)szprod_cont_seq,0x00, sizeof(szprod_cont_seq) );
			Mem_Set( (byte*)szindi_vc_after,0x00, sizeof(szindi_vc_after) );
			Mem_Set( (byte*)szindi_va_after,0x00, sizeof(szindi_va_after) );
			Mem_Set( (byte*)szindi_vm_after,0x00, sizeof(szindi_vm_after) );
			
			sql->GetValue(sql, 0, 'U', (long*)szuse_cont_num,  11, DECRYPT);
			sql->GetValue(sql, 1, 'U', (long*)szprod_cont_seq, 4, DECRYPT);
			sql->GetValue(sql, 2, 'U', (long*)szindi_vc_after, 10, DECRYPT);
			sql->GetValue(sql, 3, 'U', (long*)szindi_va_after, 10, DECRYPT);
			sql->GetValue(sql, 4, 'U', (long*)szindi_vm_after, 10, DECRYPT);
				
			JSON_AddArrayItem(js);
			if( g_nWorkFlag == 620 )
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "10" ); //전출
			else
				JSON_SetArrayItem(js, 'C', "adj_type_cd",  "20" ); //중지
				
			JSON_SetArrayItem(js, 'C', "use_cont_num" , szuse_cont_num  );
			
			JSON_SetArrayItem(js, 'C', "prod_cont_seq", szprod_cont_seq );
			JSON_SetArrayItem(js, 'C', "adj_ymd",       szadj_ymd );
			JSON_SetArrayItem(js, 'C', "indi_vc_after", szindi_vc_after );
			JSON_SetArrayItem(js, 'C', "indi_va_after", szindi_va_after );
			JSON_SetArrayItem(js, 'C', "indi_vm_after", szindi_vm_after );
			
			ret =1;
		}
		
		JSON_Attach(pj, "item", js);
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
	
	long Rcv_AdjBill(void)
	{
		
		if( g_Chk_Json(64302) >= 0)
		{
			Snd_NoPay();
			return 1;
		}
		else
		{
			g_Sock_Close();
			MessageBoxEx (ERROR_OK, "서버 적용실패.");
			ON_DRAW();
			return -1;
		}
	}	
}



