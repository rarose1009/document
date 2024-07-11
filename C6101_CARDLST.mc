/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_CARDLST
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
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	#include "ArrayList.c"
	
	BEGIN_BUTTON_ID()
		// ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		// Ȩ
		DEF_BUTTON_ID ( BID_MENU )		// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	// �������
		DEF_BUTTON_ID ( BID_PREV )		// ����
		DEF_BUTTON_ID ( BID_EXIT )		// ����
		
		// ȭ�� ��ư ����
		DEF_BUTTON_ID ( BID_CARDCL )	// �������
		DEF_BUTTON_ID ( BID_ADDR )		// �ּ�
		DEF_BUTTON_ID ( BID_ADDR2 )		// �ּ�
		DEF_BUTTON_ID ( BID_UP )		// ����������
		DEF_BUTTON_ID ( BID_DOWN )		// ����������
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )	// Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )		// Ÿ��Ʋ

		DEF_OBJECT_ID ( TTL_GUBUN )		// ī������
		DEF_OBJECT_ID ( TXT_GUBUN )		// ī������
		DEF_OBJECT_ID ( TTL_NUM )		// ī���ȣ
		DEF_OBJECT_ID ( TXT_NUM )		// ī���ȣ
		DEF_OBJECT_ID ( TTL_MONTH )		// �Һΰ���
		DEF_OBJECT_ID ( TXT_MONTH )		// �Һΰ���		
		DEF_OBJECT_ID ( TTL_MONEY )		// ���αݾ�
		DEF_OBJECT_ID ( TXT_MONEY )		// ���αݾ�
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ	
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table�� �ళ��
	#define		COL 	    11					// table�� ������
	#define		GRID_H		(CHT+83)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		101 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+130  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    // table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW)*GRID_H+GRID_H/2) // table������ row�� Y��
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (GRID_ENDY+SYH*(x-1))
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"����"      		  , CWD*5    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�׸�"      		  , CWD*5    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�"      		  , CWD*21   , EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��/��ð�"  		  , CWD*9    , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ī���"    		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ī���ȣ"  		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�Һΰ���"  		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���αݾ�"  		  , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ι�ȣ"           , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"PROMISE_ASSIGN_SEQ" , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},	
		{"APPROVAL_TIME"      , 0        , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
	};
	
	#define INIT_MAIN	1

	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_nActIndex = -1;		// ���õ� row index
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_bFirst;				// INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	
	char m_szPromise_assign_seq[100];
	char m_szApproval_amt[100];
	char m_szApproval_time[100];
	
	CARRAYLIST m_pList = NULL;
	bool m_bPrintAgain = FALSE;
		
	void REDRAW(void);
	void SetStyle(void);
	void SetBtnImg(void);
	long TR68602(void);
	long Rev68602(void);
	void Rcv_Mcpay(void);
	long TR67061(void);
	long TR67062(void);
	
	bool Load_CardData(char* szPromise_assign_seq, char* szApproval_amt, char* szApproval_time );
	long Load_Assign(char* assign_seq, char* szApproval_amt);
	
	void Snd_ApproCancelCard(void);
	long Rcv_ApproCancelCard(void);
	long Chk_Json_68604(void);	
	long GetUtf8Size(char* str, long chklen);
	long SearchCD( char *CD, CodeTable *CT);
	long SearchStr( char *Str, CodeTable *CT);
	void Snd_CardHist(long flag);
	
	void Card_CancelPirnt(void);
	void* Card_GetPrintData(void);
	long Card_Print_Result(void* p);
	void Snd_Card_Appro_H(void);
	long TR68606(void);
	
	void Run_Mcpay(void);
	void Rcv_CardData(char* szCardData);
	
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
	
	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "ī����θ��"),
		
		DLG_BUTTON( STARTX,     STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON( STARTX+200, STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ�"),
		DLG_TEXT  ( STARTX+400, STARTY+65, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON( STARTX+600, STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON( STARTX+800, STARTY+65, 200, 65, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		DLG_TEXT( STARTX,     Line(1)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GUBUN, "ī������"),
		DLG_TEXT( STARTX+252, Line(1)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GUBUN, ""),
		DLG_TEXT( STARTX,     Line(2)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_NUM, "ī���ȣ"),
		DLG_TEXT( STARTX+252, Line(2)-3,  748, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NUM, ""),
		DLG_TEXT( STARTX,     Line(3)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MONTH, "�Һΰ���"),
		DLG_TEXT( STARTX+252, Line(3)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONTH, ""),
		DLG_TEXT( STARTX,     Line(4)-3,  252, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MONEY, "���αݾ�"),
		DLG_TEXT( STARTX+252, Line(4)-3,  521, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONEY, ""),
		
		DLG_BUTTON( STARTX+773, Line(3)-3, 227, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDCL, "����\n���"),

		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H/2, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "ī����θ��"),
		
		DLG_BUTTON( STARTX,     STARTY+80, 180, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON( STARTX+190, STARTY+80, 180, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ�"),
		DLG_TEXT(   STARTX+380, STARTY+80, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+660, STARTY+80, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+820, STARTY+80, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		DLG_TEXT( STARTX,     Line(1),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_GUBUN, "ī������"),
		DLG_TEXT( STARTX+350, Line(1),  620, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_GUBUN, ""),
		DLG_TEXT( STARTX,     Line(2),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_NUM, "ī���ȣ"),
		DLG_TEXT( STARTX+350, Line(2),  620, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NUM, ""),
		DLG_TEXT( STARTX,     Line(3),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_MONTH, "�Һΰ���"),
		DLG_TEXT( STARTX+350, Line(3),  330, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONTH, ""),
		DLG_TEXT( STARTX,     Line(4),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_MONEY, "���αݾ�"),
		DLG_TEXT( STARTX+350, Line(4),  330, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MONEY, ""),

		DLG_BUTTON( STARTX+670, Line(3), 300, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARDCL, "����\n���"),

		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H/2, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};
	
	//----------------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void OnInit(char bFirst)
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
				Rev68602();
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư ������ ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
			
			if( theDevInfo.m_nType != FAMILY_PDA )
			{	
				//��ܰ���޴�
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
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MONTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MONEY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MONTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MONEY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
				
				// ����, ���θ� �ּ� ����
				if( g_nAddrFlag == 0 )
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
				}
				else
				{
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR2), TRUE );
				}				
			}
		}
	}

	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : ���̺� ���� �� ������ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index;
		char szbuf[50];
		
		if( m_bFirst == INIT_MAIN )
		{
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_nActIndex = index-1;
				
				// ī������
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GUBUN), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));	
				
				//ī���ȣ
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NUM),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
				
				//�Һΰ���
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONTH), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
				
				// ���αݾ�
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				Str_Cpy(szbuf, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
				Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
				Str_Chg( szbuf, STRCHG_INS_COMMA );
				Str_Cat( szbuf,"��");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), szbuf);
				
				// m_szApproval_amt
				Mem_Set( (byte*)m_szApproval_amt, 0x00, sizeof(m_szApproval_amt) );
				Str_Cpy(m_szApproval_amt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
				
				// m_szPromise_assign_seq
				Mem_Set( (byte*)m_szPromise_assign_seq, 0x00, sizeof(m_szPromise_assign_seq) );
				Str_Cpy( m_szPromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9) );				

				// m_szApproval_time
				Mem_Set( (byte*)m_szApproval_time, 0x00, sizeof(m_szApproval_time) );
				Str_Cpy( m_szApproval_time, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10) );
				
				if( Load_CardData(m_szPromise_assign_seq, m_szApproval_amt, m_szApproval_time) == FALSE )
				{
					MessageBoxEx (CONFIRM_OK, "ī�������� �̻��� �ֽ��ϴ�.");
					return;
				}
				
				Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);
				
				ON_DRAW();
			}
		}
	}

	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
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
			
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
					m_lpage = 0;
				
				m_nActIndex = 0;
				REDRAW();
				break;
			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
					m_lpage = m_lTotpage-1;
					
				m_nActIndex = 0;
				REDRAW();
				break;
			
			case BID_CARDCL:
				if(m_nActIndex < 0 )
				{
					MessageBoxEx (ERROR_OK, "��������� �ڷḦ �����ϼ���.");
					break;
				}
				
				if( Str_Cmp( DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 0), "����" ) != 0)
				{
					MessageBoxEx (ERROR_OK, "���ε� ������ ��� �� �� �ֽ��ϴ�.");
					break;
				}
				
				if( MessageBoxEx (CONFIRM_YESNO, "������� �Ͻðڽ��ϱ�?")  == MB_OK)
				{
					//	Snd_ApproCancelCard();
					Snd_CardHist(4);
				}
				
				break;
				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
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
	
	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : �ܺ� �� ����
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
				//�ý�����
				szCardData = (char*)System_GetResult((char*)&nRet);
				
				//�Ʒ� �ּ��� Ǯ�� ��� �����͸� json ���Ϸ� ���� �� �� ����(������ġ : smart/SND.json)
				//g_Save_JsonFile(szCardData);
		
				//��� ����
				Rcv_CardData(szCardData);
			}
		}
	}
	
	//----------------------------------------------------------------------
	//�Լ��� : SearchStr
	//��  �� : ��Ʈ������ �ڵ��ε����� ã�´�.
	//Param  : 
	//Return : �ڵ��ε���, ������ -1
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
	
	/*=======================================================================================
	�Լ��� : SearchCD
	��  �� : �ڵ尪���� �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
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
	�Լ��� : GetUtf8Size
	��  �� : �ѱ� üũ
	Param  : 
	Return : 
	========================================================================================*/
	long GetUtf8Size(char* str, long chklen)
	{
		long nSize = 0;
		long nLen = 0;
		long i = 0;
		
		nSize = Str_Len(str);
		
		for(i=0 ; i < nSize ; )
		{
			if ( str[i] & 0x80 )	//�ѱ�
				i+=2;			//2����
			else
				i++;
				
			if( i >= chklen )
				break;
		}
		nLen = i;
		return nLen;
	}
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ�� ����
	Param  :  
	         PARAM1	 : PROMISE_ASSIGN_SEQ    
			 PARAM2	 : CIVIL_SERV_RECEIVE_NUM
			 PARAM3	 : TREAT_SEQ             
			 PARAM4	 : ITEM_FLAG
			 PARAM5	 : TERMINAL_NUM
			 PARAM6	 : CARD_COM
			 PARAM7	 : CARD_TYPE_NM
			 PARAM8	 : BUYING_COMP
			 PARAM9	 : BUYING_COMP_NM
			 PARAM10 : ALLOTMENT_MM
			 PARAM11 : CARD_NUM
			 PARAM12 : VALID_YM 
			 PARAM13 : APPROVAL_AMT
			 PARAM14 : APPROVAL_NUM
			 PARAM15 : APPROVAL_DATE
			 PARAM16 : CUST_NUM
			 PARAM17 : CUST_NM
			 PARAM18 : USE_CONT_NUM
			 PARAM19 : CURR_ADDR_UNION
			 PARAM20 : NEW_ADDR_UNION
			 PARAM21 : PRCSS_STATUS 
			 PARAM22 : APPROVAL_CANCEL_DATE 
	Return :
	========================================================================================*/
	void REDRAW(void)
	{
		long i, idx, n, tknlen;
		long k = ROW+1;
		long lTotPage;
		long lstartidx;
		char sztmp[301];
		char szbuf[50];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		g_Sql_RetInt("SELECT COUNT(1) FROM RCV_TMP A, C6101_PROMISE_ASSIGN B WHERE A.param1 = B.PROMISE_ASSIGN_SEQ  AND B.SEND_YN IN ('Y','S','N') ", &m_lTotpage);
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		sql = NewSqLite();
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, "SELECT A.PARAM21 \
													, A.PARAM4 \
													, A.PARAM19 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
														   ELSE A.PARAM15 \
													   END AS PARAM15 \
													, A.PARAM7 \
													, A.PARAM11 \
													, A.PARAM10 \
													, A.PARAM13 \
													, A.PARAM14 \
													, A.PARAM1 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
													   	   ELSE A.PARAM15 \
													   END AS PARAM15 \
												 FROM RCV_TMP A \
													, C6101_PROMISE_ASSIGN B \
												WHERE A.PARAM1 = B.PROMISE_ASSIGN_SEQ \
												  AND B.SEND_YN IN ('Y','S','N') LIMIT ?, ? ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql, "SELECT A.PARAM21 \
													, A.PARAM4 \
													, A.PARAM20 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
														   ELSE A.PARAM15 \
													   END AS PARAM15 \
													, A.PARAM7 \
													, A.PARAM11 \
													, A.PARAM10 \
													, A.PARAM13 \
													, A.PARAM14 \
													, A.PARAM1 \
													, CASE WHEN A.PARAM15 IS NULL THEN A.PARAM22 \
													   	   ELSE A.PARAM15 \
													   END AS PARAM15 \
												 FROM RCV_TMP A \
												    , C6101_PROMISE_ASSIGN B \
												WHERE A.PARAM1 = B.PROMISE_ASSIGN_SEQ \
												  AND B.SEND_YN IN ('Y','S','N') LIMIT ?, ? ");
		}

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

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for ( i = 0 ; i < ROW ; i++ )
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					continue;
				}
				
				idx = 0;

				// param21 ����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT); 
				
				if(sztmp[0] == '2')
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "����" );
				}
				else // 3
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "���" );
				}

				// param4 �׸�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);

				if( Str_Cmp(sztmp,"10") == 0 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "����" );
				}
				else // 20
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "��ȸ��" );
				} 

				// param19 �ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				// param15 ���νð�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				
				Mem_Cpy( (byte*)szbuf, (byte*)sztmp+8, 2 );
				szbuf[2] = ':';
				Mem_Cpy( (byte*)szbuf+3, (byte*)sztmp+10, 2 );
				szbuf[5] = ':';
				Mem_Cpy( (byte*)szbuf+6, (byte*)sztmp+12, 2 );
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, szbuf );

				// param7 ī���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
				// param11 ī���ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );

				// param6 �Һ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				n = 0;
				n = SearchCD( sztmp, CK_CARDMM );
				Str_Cpy(szbuf, CK_CARDMM[n].Str);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, szbuf );

				// param10 ���αݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );

				// param14 ���ι�ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );

				// param1 assign_seq
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
				
				// APPROVAL_TIME
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_nActIndex == -1 )
		{			
			m_nActIndex = 0;		
		}
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
				
			// ī������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_GUBUN), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));	
			
			// ī���ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NUM),   DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			
			// �Һΰ���
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONTH), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			
			// ���αݾ�
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Str_Cpy( szbuf, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
			Str_Chg( szbuf, STRCHG_DEL_NONDIGIT );
			Str_Chg( szbuf, STRCHG_INS_COMMA );
			Str_Cat( szbuf,"��" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MONEY), szbuf );
			
			// m_szApproval_amt
			Mem_Set( (byte*)m_szApproval_amt, 0x00, sizeof(m_szApproval_amt) );
			Str_Cpy(m_szApproval_amt, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7) );	
			
			// m_szPromise_assign_seq
			Mem_Set( (byte*)m_szPromise_assign_seq, 0x00, sizeof(m_szPromise_assign_seq) );
			Str_Cpy(m_szPromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9) );	
			
			// m_szApproval_time
			Mem_Set( (byte*)m_szApproval_time, 0x00, sizeof(m_szApproval_time) );
			Str_Cpy( m_szApproval_time, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10) );
			
			if( Load_CardData(m_szPromise_assign_seq, m_szApproval_amt, m_szApproval_time) == FALSE )
			{
				MessageBoxEx (CONFIRM_OK, "ī�������� �̻��� �ֽ��ϴ�.");
				return;
			}
			
			Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);
			
		}
		
		ON_DRAW();
		
	}
	
	/*=======================================================================================
	�Լ��� : Rev68602
	��  �� : ���� ī�� ���� ������ �޾ƿ�
	Param  : 
	Return : 
	========================================================================================*/
	long Rev68602(void)
	{
		char szUrl[200];
		char szFilepath[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm =  g_CreateJsonHead(g_pjcomm, szUrl, 68602, FALSE);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR68602;
		ret = HTTP_DownloadData(szUrl, "FR68602_IN",  "FR68602" , sndbuf, szbuf );
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR68602
	��  �� : Rev68602 callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR68602(void)
	{
		long ret = 0;

		g_Sock_Close();
		
		ret = g_Chk_Json(68602);
		
		if( ret > 0 )
		{
			REDRAW();
			return 1;
		}
		else if( ret == 0  )
		{
			MessageBoxEx (CONFIRM_OK, "ī����� ������ �����ϴ�.") ;
			return 0;
		}
		else if( ret < 0  )
		{
			OnButton(GID_PREV);
			return -1;
		}
		
		return -1;
	}

	void Snd_CardHist(long flag)
	{
		char szTmp[100];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		
		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66706, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"     , stMw.szPromise_assign_seq    	   );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num" , stMw.szCivil_serv_receive_num     );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"			   , stMw.szTreat_seq  		   		   );
		
		JSON_SetValue( g_pjcomm, 'C', "item_flag"			   , stCardinfo.szItem_flag			   	   );
		JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   , stCardinfo.szTerminal_num		   	   );
		JSON_SetValue( g_pjcomm, 'C', "approval_amt"		   , stCardinfo.szApproval_amt		  	   );
		JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "20"	 );	
		
		// ���� ��
		if( flag == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , "*"     			           	   );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "4"     );	
		}
		// ���� ��
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , stCardinfo.szCard_num			    );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "3"                                );	
			JSON_SetValue( g_pjcomm, 'C', "rslt_cd"			       , "O"			   				    );
			JSON_SetValue( g_pjcomm, 'C', "valid_ym"			   , stCardinfo.szValid_ym			    );
			JSON_SetValue( g_pjcomm, 'C', "allotment_mm"		   , stCardinfo.szAllotment_mm		    );
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_num"	   , stCardinfo.szApproval_cancel_num   );	
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_date"   , stCardinfo.szApproval_cancel_date  );	

			JSON_SetValue( g_pjcomm, 'C', "card_com"		       , stCardinfo.szCard_com 		   		);
			JSON_SetValue( g_pjcomm, 'C', "buying_comp"		       ,stCardinfo.szBuying_comp 		    );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szCard_type_nm );
			JSON_SetValue( g_pjcomm, 'C', "card_type_nm"		   , szTmp		   );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szBuying_comp_nm );
			JSON_SetValue( g_pjcomm, 'C', "buying_comp_nm"		   , szTmp		   );
		}
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		// ��� �Ϸ�
		if( flag == 3 )
		{
			callBackfunc = TR67061;
		}
		// ��� �õ�
		else
		{
			callBackfunc = TR67062;
		}

		HTTP_DownloadData( szUrl, "FR66706_IN",  "FR66706" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Load_CardData
	��  �� : ȭ�� ����
	Param  : szPromise_assign_seq, szApproval_amt, szApproval_time
	         PARAM1	 : PROMISE_ASSIGN_SEQ    
			 PARAM2	 : CIVIL_SERV_RECEIVE_NUM
			 PARAM3	 : TREAT_SEQ             
			 PARAM4	 : ITEM_FLAG
			 PARAM5	 : TERMINAL_NUM
			 PARAM6	 : CARD_COM
			 PARAM7	 : CARD_TYPE_NM
			 PARAM8	 : BUYING_COMP
			 PARAM9	 : BUYING_COMP_NM
			 PARAM10 : ALLOTMENT_MM
			 PARAM11 : CARD_NUM
			 PARAM12 : VALID_YM 
			 PARAM13 : APPROVAL_AMT
			 PARAM14 : APPROVAL_NUM
			 PARAM15 : APPROVAL_DATE
			 PARAM16 : CUST_NUM
			 PARAM17 : CUST_NM
			 PARAM18 : USE_CONT_NUM
			 PARAM19 : CURR_ADDR_UNION
			 PARAM20 : NEW_ADDR_UNION
			 PARAM21 : PRCSS_STATUS
			 PARAM22 : APPROVAL_CANCEL_DATE
	Return :
	========================================================================================*/
	bool Load_CardData( char* szPromise_assign_seq, char* szApproval_amt, char* szApproval_time )
	{
		long i;
		char sztmp[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		bool bret =FALSE;
		
		Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			bret =FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PARAM1, PARAM18, PARAM4, '1', 'O', PARAM5 \
											   , PARAM11, PARAM12, PARAM6, PARAM7, PARAM8 \
											   , PARAM9, PARAM13, PARAM14, PARAM10, PARAM15 \
											   , PARAM2, PARAM3 \
											FROM RCV_TMP \
										   WHERE PARAM1 = ? AND PARAM13 = ? AND ( PARAM15 = ? OR PARAM22 = ? )");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bret =FALSE;
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)szPromise_assign_seq, 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szApproval_amt, 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szApproval_time, 14, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szApproval_time, 14, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bret =FALSE;
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szItem_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRecev_seq             ,3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRslt_cd               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTerminal_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_num              ,128+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szValid_ym              ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_com              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_type_nm          ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp_nm        ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_amt          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_num          ,12 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szAllotment_mm          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_time         ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTreat_seq             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szReq_ymd               ,8  +1, DECRYPT );
			
			bret =TRUE;
		}
Finally:

		DelSqLite(sql);
		return bret;
	}
	
	/*=======================================================================================
	�Լ��� : TR67061
	��  �� : ī�� ���� �� hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67061(void)
	{
		if(g_Chk_Json(66706) >= 0)
		{
			g_Sock_Close();
			CloseMessageBox();
			Snd_Card_Appro_H();
			
			//Rcv_ApproCancelCard();
			//g_Sock_Close();
			//CloseMessageBox();
			//ON_DRAW();
			//REDRAW();
			
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
	
	/*=======================================================================================
	�Լ��� : TR67061
	��  �� : ī�� ���� �� hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67062(void)
	{
		char szSql[350];

		if(g_Chk_Json(66706) >= 0)
		{
			Rcv_Mcpay();
			
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			
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
	/*=======================================================================================
	�Լ��� : Rcv_Mcpay
	��  �� : Mcpay �۵� function
	Param  : 
	Return : 
	========================================================================================*/
	void Rcv_Mcpay(void)
	{
		/*
		if( MessageBoxEx (CONFIRM_YESNO, "[ MCPAY�� �������� ]\nī����� ��...\n \n��Ҽ���-> [��]\n��ҽ���-> [�ƴϿ�]") == MB_OK )
		{
			Snd_CardHist(3);
		}
		else
		{
			MessageBoxEx (ERROR_OK, "���� ��� ���� : err_code_9999");
		}
		*/
		Run_Mcpay();

		REDRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_ApproCancelCard
	��  �� : ���� ��� �� ���� db������Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_ApproCancelCard(void)
	{
		char sql[500];
		
		//Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);
		
		//�Ϸ�ó�� �Ǳ� ���� ��� �����ϵ��� ���� ������.
		if( Str_AtoI(stCardinfo.szApproval_amt) > 0 ) 
		{ 
			//Card_CancelPirnt();	
		}
		
		// ī����� �̷� ������Ʈ
		
		Mem_Set( (byte*)sql, 0x00, sizeof(sql) );	

		Str_Cpy(sql, " DELETE FROM C6101_PROMISE_CARD ");
		Str_Cat(sql, " WHERE PROMISE_ASSIGN_SEQ = ");
		Str_Cat(sql,  stCardinfo.szPromise_assign_seq );
		Str_Cat(sql, " AND APPROVAL_AMT = ");
		Str_Cat(sql,  m_szApproval_amt );
		Str_Cat(sql, " AND ITEM_FLAG = ");
		Str_Cat(sql,  stCardinfo.szItem_flag );

		if ( g_Sql_DirectExecute(sql) == 0 )
		{
			// �ο����� �����ݾ� ������Ʈ
			Mem_Set( (byte*)sql, 0x00, sizeof(sql) );	
			
			// ���� ī�� ����
			if( Str_Cmp(stCardinfo.szItem_flag, "10") == 0 )
			{
				Str_Cpy(sql, " UPDATE C6101_PROMISE_ASSIGN SET CARD_GASPAY='' ");
				Str_Cat(sql," ,UPD_EMPID = '");
				Str_Cat(sql,  stUserinfo.szemployee_id);
				Str_Cat(sql,"',PDA_IP = '");
				Str_Cat(sql,  stUserinfo.szpda_ip);
				Str_Cat(sql,"' WHERE PROMISE_ASSIGN_SEQ = ");
				Str_Cat(sql,  stCardinfo.szPromise_assign_seq );
				Str_Cat(sql," AND CARD_GASPAY = ");
				Str_Cat(sql,  m_szApproval_amt );
			}
			//��ȸ�� ī�� ����
			else
			{
				Str_Cpy(sql, " UPDATE C6101_PROMISE_ASSIGN SET CARD_ONEPAY ='' ");
				Str_Cat(sql," ,UPD_EMPID = '");
				Str_Cat(sql,  stUserinfo.szemployee_id);
				Str_Cat(sql,"',PDA_IP = '");
				Str_Cat(sql,  stUserinfo.szpda_ip);
				Str_Cat(sql,"' WHERE PROMISE_ASSIGN_SEQ = ");
				Str_Cat(sql,  stCardinfo.szPromise_assign_seq );
				Str_Cat(sql," AND CARD_ONEPAY = ");
				Str_Cat(sql,  m_szApproval_amt );
			}
			
			// ������ ���� �ҷ���
			if ( g_Sql_DirectExecute(sql) == 0 )
			{
				Rev68602();
				return 1;
			}
			else
			{
				MessageBoxEx (ERROR_OK, "ī����� ������ ���忡 �����Ͽ����ϴ�.");
				ON_DRAW();
				return -1;
			}
		}
		else
		{
			MessageBoxEx (ERROR_OK, "ī����� ������ ���忡 �����Ͽ����ϴ�.");
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Load_Assign
	��  �� : ���� db C6101_PROMISE_ASSIGN ������
	Param  : 
	Return : 
	========================================================================================*/
	long Load_Assign(char* assign_seq, char* szApproval_amt)
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

		hstmt = sql->CreateStatement(sql, "SELECT PROMISE_ASSIGN_SEQ, REG_FLAG, BRANCH_CD, CENTER_CD, ASSIGN_EMPID \
											    , CUST_NUM, USE_CONT_NUM, INST_PLACE_NUM, ZIP_SEQ, ETC_ADDR \
											    , CIVIL_SERV_CLASS_CD, PROMISE_YMD, PROMISE_TIME, END_EXPECT_TIME, JOB_STR_DTM \
											    , JOB_END_DTM,  PROMISE_ASSIGN_DESC, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, PROC_STS_CD \
											    , PDA_NUM, ONCE_PAY, SEND_YN, CIVIL_SERV_CLASS_NM, PDA_DUTY \
											    , REQ_TEL_DDD, REQ_TEL_EXN, REQ_TEL_NUM, REQ_CP_DDD, REQ_CP_EXN, REQ_CP_NUM \
											    , TRANS_IN_CUST_NM, TRANS_IN_SOC_NUM, REQ_NM, REQ_SOC_NUM, RECEIVE_DTM, CUST_TYPE_CD \
											    , CUST_NM, FIRM_NM, SOC_NUM, BIZ_REGI_NUM, CP_DDD, CP_EXN \
											    , CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, FIRM_TEL_DDD \
											    , FIRM_TEL_EXN, FIRM_TEL_NUM, SCG_RELAT_CD, EMAIL, FAMILY_CNT \
											    , CUST_TRND_CD, CHK, BUILT_IN_YN, SQUARE_METER, CURR_ADDR_UNION \
											    , BLD_FLOOR, HOUSE_CNT, PDA_DUTY_FLAG, PAY_CALU, PDA_TRANS_FLAG \
											    , REQ_INFO_NUM, TRANS_IN_CUST_NUM, CONT_STS_CD, PDA_READ_DTM, MEMO \
											    , AUTO_YN, CUST_YN, BUR_YN, PROD_YN, ONCE_YN \
											    , PRICE_YN, ZIP_NO1, ZIP_NO2, CITY, COUNTY \
											    , TOWN, VILLAGE_RI, VILLAGE, BUILDING, ADDR1_M \
											    , ADDR1_S, ACCOUNT, ONCE_ACCOUNT, CHK_TIME_FROM \
											    , CHK_TIME_END, MTR_CHG_YN, INFO_USE_AGREE_YN, PAS_USE_CONT_NUM_YN, ADJ_ALT_AMT \
											    , PAS_DEFRAY_ACCOUNT_NUM, PAS_CUST_NUM, PAS_REQ_INFO_NUM, APPRO_NUM, APPRO_TEL, ADJ_CAUSE \
											    , DEADLINE_FLAG, GMTR_BASE_DAY, CARD_GASPAY, CARD_ONEPAY, CASH_GASPAY \
											    , INFO_USE_YN, USE_CONT_DOC_YN, PAY_METHOD, DEFRAY_ACCOUNT_NUM, DEPOSITOR_NM \
											    , BANK_NM, DEBT_AMT, LAW_ETC_AMT, LAW_TOWN, NEW_ROAD_NM \
											    , NEW_ADDR_M, NEW_ADDR_S, NEW_ADDR_UNION, BILL_GUBUN, TRANS_CONN_YN \
											    , CONN_YN, BAR_YN, BAR_GBN, BAR_WHY, CHK_YN, CONN_GBN \
											 FROM C6101_PROMISE_ASSIGN \
											WHERE PROMISE_ASSIGN_SEQ = ? AND SEND_YN IN ('Y', 'S', 'N') ");
		
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
			ret = 1;
		}
Finally:
		DelSqLite(sql);
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Card_GetPrintData
	��  �� : ī�� ���� ��� ������ ����Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void Card_CancelPirnt(void)
	{
		if( g_IsCardReader() )
		{
			return;
		}

		if(m_bPrintAgain == FALSE)
		{
		  	callBackfunc = NULL;
		  
			m_pList = Card_GetPrintData();
		}
		
		g_Printer_Start(m_pList, (void*)Card_Print_Result);
	}
	
	/*=======================================================================================
	�Լ��� : Card_GetPrintData
	��  �� : ���� ī����� ��� ������ ����Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void* Card_GetPrintData(void)
	{
		CARRAYLIST list = NULL;
		long ret, idx;
		char LineSpace[]={0x1b,0x20,0x00};
		char szBuf[300];
		char szMsg[300];
		char sztmp[300];
		char szFirstNm[32];
		char szLastNm[32];

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}
		
		// �Ϸ�ó���� ������� �ϴ� ��쵵 ����
		if( ( Str_AtoI(stCardinfo.szApproval_amt) > 0 || Str_AtoI(stMw.szCard_gaspay) > 0 ) && stMw.szCard_onepay[0] != '2' ) 
		{
			list->append(list, "--------------------------------");
			list->append(list, "   ������� ������ (�� �� ��)   ");
			list->append(list, "--------------------------------");
			list->append(list, "       ���ﵵ�ð���(��)         ");
			list->append(list, "����� ������ ��â�� 281\n");
			list->append(list, "����� ��ȣ: 109-81-31605\n");
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp ,"��ǥ�̻� : " );
			Str_Cat(sztmp ,stUserinfo.szScg_repre_nm );
			g_Line_Print(list, sztmp,"","",LEFT,0);	
					
			list->append(list, "��ȭ��ȣ : 1588-5788            ");
			list->append(list, "--------------------------------");		
			
			Mem_Set( (byte*)szFirstNm, 0x00, sizeof(szFirstNm) );
			Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm));
				
			if( g_nWorkFlag == 610 )
			{
				if( Str_Len(stMw.szTrans_in_cust_nm) < 6 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 4 && Str_Len(stMw.szTrans_in_cust_nm) < 8)
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+4, 2);
					
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 6 && Str_Len(stMw.szTrans_in_cust_nm) < 10 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+6, 2);
		
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 8 && Str_Len(stMw.szTrans_in_cust_nm) < 12 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+8, 2);
		
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
			}
			else
			{
				if( Str_Len(stMw.szCust_nm) < 6 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "�����ּ� : ");
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
				Str_Cpy(sztmp, "���θ��ּ� : ");
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
			Str_Cpy(sztmp, "��ħ��/���� : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "��/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "����");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			
			if (Str_Cmp(stCardinfo.szApproval_amt, stMw.szCard_gaspay) == 0)
			{
				// �ٸ� �ݾ����� �� �� ���� �� ���� ���� �ݾ��� �˼� ��� ��� �������� ������� �ʱ�� ��
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "���� ���� : ");
				
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szCard_gaspay );
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat( szBuf, "��" );
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 18 );

				ret = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+18-ret, (byte*)szBuf, ret  );
				
				Str_Cat(sztmp, szMsg);

				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				list->append(list, "--------------------------------");
			}
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "[ ī  �� ]:  ");
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Str_Cat( szBuf, stMw.szCard_gaspay);
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			Str_Cat( szBuf, "��");
			ret = Str_Len(szBuf);
			
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 19 );
			Mem_Cpy((byte*)szMsg+19-ret, (byte*)szBuf, ret  );
			Str_Cat(sztmp, szMsg);
			
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " ī���ȣ :  ");
			Mem_Cpy((byte*)szBuf, (byte*)stCardinfo.szCard_num , 4);
			szBuf[4] = '-';
			Mem_Cpy( (byte*)szBuf+5, (byte*)stCardinfo.szCard_num+4,  4 );
			szBuf[9] = '-';
			Str_Cat( szBuf, "****-****");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " �ŷ����� :  ");
			idx = 0;
			idx = SearchCD( stCardinfo.szAllotment_mm, CK_CARDMM );
			Str_Cpy(szBuf, CK_CARDMM[idx].Str);
			Str_Cat(sztmp, szBuf );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " ���ι�ȣ :  ");
			Str_Cat(sztmp, stCardinfo.szApproval_num );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, " ������� :  ");
			Str_ItoA(Time_GetDate(), szBuf, 10);
			g_Str_DateType(szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
		}
		
		if( stMw.szCard_onepay[0] == '2' )
		{
			list->append(list, "--------------------------------");
			list->append(list, " �������  ����ö�ź�(�� �� ��) ");
			list->append(list, "--------------------------------");
			list->append(list, "        ���ﵵ�ð���(��)        ");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cat(sztmp, stUserinfo.szcenter_nm );	
			Str_Cat(sztmp, " ������");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "��  ȣ  ��  : ");
			Str_Cat(sztmp, stUserinfo.szcom_name );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "����ڹ�ȣ  : ");
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
			Str_Cpy(sztmp, "��  ǥ  ��  : ");
			Str_Cat(sztmp, stUserinfo.szrepre_nm );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "��  ��  ��  : ");
			Str_Cat(sztmp, stUserinfo.sznm_kor );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "�� ȭ �� ȣ : ");
			Str_Cat(sztmp, stUserinfo.sztel );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "��ħ��/���� : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "��/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "����");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
			
			if (Str_Cmp(stCardinfo.szApproval_amt, stMw.szOnce_account) == 0)
			{
				// �ٸ� �ݾ����� �� �� ���� �� ���� ���� �ݾ��� �˼� ��� ��� �������� ������� �ʱ�� ��
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "���� ö�ź� : ");
				
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cat( szBuf, stMw.szOnce_account);
				Str_Chg( szBuf, STRCHG_INS_COMMA );
				Str_Cat(szBuf, "��");
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 18 );
				
				ret = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+18-ret, (byte*)szBuf, ret  );
				Str_Cat(sztmp, szMsg);
				
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				list->append(list, "--------------------------------");
			}
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "[ ī  �� ]:  ");
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Str_Cat( szBuf, stMw.szOnce_account);
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			Str_Cat( szBuf, "��");
			ret = Str_Len(szBuf);
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 19 );
			Mem_Cpy((byte*)szMsg+19-ret, (byte*)szBuf, ret  );
			Str_Cat(sztmp, szMsg);
			
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " ī���ȣ :  ");
			Mem_Cpy((byte*)szBuf, (byte*)stCardinfo.szCard_num , 4);
			szBuf[4] = '-';
			Mem_Cpy( (byte*)szBuf+5, (byte*)stCardinfo.szCard_num+4,  4 );
			szBuf[9] = '-';
			Str_Cat( szBuf, "****-****");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " �ŷ����� :  ");
			idx = 0;
			idx = SearchCD( stCardinfo.szAllotment_mm, CK_CARDMM );
			Str_Cpy(szBuf, CK_CARDMM[idx].Str);
			Str_Cat(sztmp, szBuf );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Str_Cpy(sztmp, " ���ι�ȣ :  ");
			Str_Cat(sztmp, stCardinfo.szApproval_num );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "������� :  ");
			Str_ItoA(Time_GetDate(), szBuf, 10);
			g_Str_DateType(szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
		}
		
		list->append(list, "��õ�ϴ��������������Ǵ¾�����ȭ");
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		Str_Cat(sztmp, "�����Ͻ� : ");
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
		
		return list;
	}
	
	/*=======================================================================================
	�Լ��� : Card_Print_Result
	��  �� : ������ ����Ʈ Ȯ��
	Param  : 
	Return : 
	========================================================================================*/
	long Card_Print_Result(void* p)
	{
		long* pRet = (long*)p;
		long nRet = *pRet;
		
		if( MessageBoxEx (CONFIRM_YESNO, "��� ������ ������ �ߵǾ����ϱ�?") == MB_OK )
		{
			;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "����� �Ͻðڽ��ϱ�?") == MB_OK )
			{
				m_bPrintAgain = TRUE;
				
				//�����
				Card_CancelPirnt();
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
		
		Rev68602();
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Card_Appro_H
	��  �� : �Ⱓ�� ī�� H ���̺� ��� ������ update
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_Card_Appro_H(void)
	{
		char szTmp[100];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		Load_Assign(m_szPromise_assign_seq, m_szApproval_amt);

		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68606, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"     		, stMw.szUse_cont_num   	  );
		JSON_SetValue( g_pjcomm, 'C', "approval_num"			, stCardinfo.szApproval_cancel_num   );
		JSON_SetValue( g_pjcomm, 'C', "terminal_num"			, stCardinfo.szTerminal_num   );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		Mem_Cpy( (byte*)szTmp, (byte*)stCardinfo.szApproval_cancel_date + 8, 6 );
		JSON_SetValue( g_pjcomm, 'C', "approval_cancel_time"	, szTmp	  );

		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR68606;

		HTTP_DownloadData( szUrl, "FR68606_IN",  "FR68606" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : TR68606
	��  �� : callback FR68606
	Param  : 
	Return : 
	========================================================================================*/
	long TR68606(void)
	{
		if(g_Chk_Json(68606) >= 0)
		{
			Rcv_ApproCancelCard();
			
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			REDRAW();
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
	
	/*=======================================================================================
	�Լ��� : Run_Mcpay
	��  �� : Run_Mcpay Ȱ��ȭ
	Param  : 
	Return : 
	========================================================================================*/
	void Run_Mcpay(void)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;
	
		char szSql[100];
		char szTmp[100];
		
		char card_receipt_YN[2];

		Mem_Set( (byte*)card_receipt_YN, 0x00, sizeof(card_receipt_YN) );
		// ������ �߱޹���
		if( MessageBoxEx (CONFIRM_YESNO, "��� �������� �����Ͻðڽ��ϱ�?")  == MB_OK)
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
			JSON_SetValue	(hdata	, 'C', "call"				, "creditVoid");
			JSON_SetValue	(hdata	, 'C', "desc"				, "�ſ����");
			
			if( Str_Cmp(stCardinfo.szItem_flag, "10") == 0 )
			{
				JSON_SetValue	(hdata	, 'C', "bussno"				, "1098131605");
			}
			else
			{
				JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
			}

			JSON_SetValue	(hdata	, 'C', "type"				, "");
			JSON_SetValue	(hdata	, 'C', "totalprice"			, stCardinfo.szApproval_amt);
			JSON_SetValue	(hdata	, 'C', "tax"				, "0");
			JSON_SetValue	(hdata	, 'C', "svc"				, "0");
			JSON_SetValue	(hdata	, 'C', "inst"				, stCardinfo.szAllotment_mm);
			JSON_SetValue	(hdata	, 'C', "printdata"			, "");
	
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Cpy( (byte*)szTmp, (byte*)stCardinfo.szApproval_time+2, 6 );
			JSON_SetValue	(hdata	, 'C', "approvaldate"		, szTmp);
			
			JSON_SetValue	(hdata	, 'C', "approvalno"			, stCardinfo.szApproval_num);	
			JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
			JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
			JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
			JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
			JSON_SetValue	(hdata	, 'C', "vsno"				, stCardinfo.szTerminal_num);
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
	�Լ��� : Rcv_CardData
	��  �� : MCPAY RETRUN
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

			if( Str_Cmp(JSON_GetValue (hItem, "resultcode",  		szType), "null") == 0 )
			{
				Str_ItoA( Time_GetDate(),  stCardinfo.szReq_ymd  , 10);
				Str_Cpy( stCardinfo.szPromise_assign_seq     , stMw.szPromise_assign_seq     );
				Str_Cpy( stCardinfo.szCivil_serv_receive_num , stMw.szCivil_serv_receive_num );
				Str_Cpy( stCardinfo.szTreat_seq              , stMw.szTreat_seq              );
				Str_Cpy( stCardinfo.szUse_cont_num           , stMw.szUse_cont_num           );
				Str_Cpy( stCardinfo.szRecev_seq              , "001"                         );
				
				// ITEM_FLAG Ÿ��
				if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 1), "����" ) == 0 )
				{
					Str_Cpy( stCardinfo.szItem_flag     		 , "10"							 );
				}
				else
				{
					Str_Cpy( stCardinfo.szItem_flag     		 , "20"							 );
				}
				
				Str_Cpy( stCardinfo.szTerminal_num  		 , JSON_GetValue (hItem, "tid",   	szType) );
				Str_Cpy( stCardinfo.szApproval_amt 			 , JSON_GetValue (hItem, "totalamount",    		szType) );
				
				// �Һ�
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6) );
				i = SearchStr( szTmp, CK_CARDMM );
				if (i > -1)
				{
					Str_Cpy( stCardinfo.szAllotment_mm 			 , CK_CARDMM[i].Code );	
				}
				
				Str_Cpy( stCardinfo.szApproval_amt 			 , JSON_GetValue (hItem, "totalamount",    		szType) );
				Str_Cpy( stCardinfo.szCard_num				 , JSON_GetValue (hItem, "cardno",    		szType) );
				Str_Cpy( stCardinfo.szCard_type_nm			 , JSON_GetValue (hItem, "cardname",    	szType) );
				Str_Cpy( stCardinfo.szValid_ym				 , "0000" 						 );
				Str_Cpy( stCardinfo.szData_flag 			 , "20" );
				Str_Cpy( stCardinfo.szApproval_cancel_num	 ,  JSON_GetValue (hItem, "approvalno",    	szType) );
				Str_Cpy( stCardinfo.szApproval_cancel_date	 ,  JSON_GetValue (hItem, "approvaldate",    szType) );

				Str_Cpy( stCardinfo.szCard_com				 , JSON_GetValue (hItem, "code2",    	szType) );	
				Str_Cpy( stCardinfo.szBuying_comp			 , JSON_GetValue (hItem, "code1",    	szType) );
				Str_Cpy( stCardinfo.szBuying_comp_nm		 , JSON_GetValue (hItem, "purchasename",    	szType) );
				
				Snd_CardHist(3);
			}
			else
			{	
				if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "M016") == 0 )
				{
					Card_Move("C6101_MENU");
					return;	
				}
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				Str_Cpy( szTmp, "[ ���� ��� ���� ]" );
				Str_Cat( szTmp, "\nERR_CODE : ");
				Str_Cat( szTmp, JSON_GetValue (hItem, "resultcode",  		szType));
				Str_Cat( szTmp, "\nERR_MSG : ");
				Str_Cat( szTmp, JSON_GetValue (hItem, "resultmsg",  		szType));
				
				MessageBoxEx (ERROR_OK, szTmp);
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



