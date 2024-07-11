/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MENU
	Card Desc : ����޴�
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MENU
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

	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		
		// ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )			// Ȩ
		DEF_BUTTON_ID ( BID_MENU )			// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )		// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )		// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )		// �������
		DEF_BUTTON_ID ( BID_PREV )			// ����
		DEF_BUTTON_ID ( BID_EXIT )			// ����
			
		// �ϴ� ��ư ����
		DEF_BUTTON_ID ( BID_CLOSE )			// ���
		
		// ���� �޴�
		DEF_BUTTON_ID ( BID_CMCDRECV )		// ���� �ڵ� ����
		DEF_BUTTON_ID ( BID_PAYMENU )		// ��Ÿ ����
		DEF_BUTTON_ID ( BID_CHG_FONT )		// ��Ʈ ����
		DEF_BUTTON_ID ( BID_CHG_BARCODE )	// ���ڵ� ����
		DEF_BUTTON_ID ( BID_CHG_CENTER )	// ������ ����
		
		// ��Ʈ ����
		DEF_BUTTON_ID ( BID_FONT_1 )		// ��Ʈ����_1
		DEF_BUTTON_ID ( BID_FONT_2 )		// ��Ʈ����_2
		DEF_BUTTON_ID ( BID_FONT_3 )		// ��Ʈ����_3
		DEF_BUTTON_ID ( BID_FONT_4 )		// ��Ʈ����_4
		DEF_BUTTON_ID ( BID_FONT_CLOSE )	// ��Ʈ���� ���
		DEF_BUTTON_ID ( BID_FONT_CHANGE )	// ��Ʈ���� ����
		
		// ���ڵ� ���� ����
		DEF_BUTTON_ID ( BID_BAR_CLOSE )		// ���ڵ� ���� ���� ���
		DEF_BUTTON_ID ( BID_BAR_CHANGE )	// ���ڵ� ���� ���� ����
		
		// ������ ����
		DEF_BUTTON_ID ( BID_CENTER_CHANGE )	// ������ ����
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		
		// ����
		DEF_OBJECT_ID ( ICON_TITLE )		// Ÿ��Ʋ ������
		DEF_OBJECT_ID ( TXT_TITLE )			// Ÿ��Ʋ	
		
		// ��Ʈ ����
		DEF_OBJECT_ID ( TXT_FONT_1 )		// ��Ʈ����_1
		DEF_OBJECT_ID ( TXT_FONT_2 )		// ��Ʈ����_2
		DEF_OBJECT_ID ( TXT_FONT_3 )		// ��Ʈ����_3
		DEF_OBJECT_ID ( TXT_FONT_4 )		// ��Ʈ����_4
		DEF_OBJECT_ID ( TXT_FONT_NOTICE )	// ��Ʈ���� ����
		
		// ���ڵ� ���� ����
		DEF_OBJECT_ID ( TXT_DATA1 )			// ���ڵ� ���� Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_BAR_NOTICE )	// ���ڵ� ���� ����
		
		// ������ ����
		DEF_OBJECT_ID ( TXT_DATA2 )			// ������ ���� TXT
		
		// ����
		DEF_OBJECT_ID ( LINE_DATA1 )		// ����1
		
		// �޺��ڽ�
		DEF_OBJECT_ID ( CMB_DATA1 )					// ���ڵ� ���� �޺��ڽ�
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )	// ������ �޺��ڽ�
	
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	// ���̾�α� Define
	#define INIT_MAIN	  	1
	#define INIT_CHGFONT  	2
	#define INIT_CHGBAR   	3
	#define INIT_CHGCENTER	4
	
	// ��Ʈ ���� RadioBox Define
	#define FONT_CHK_Y "�� �����ٶ󸶹�"
	#define FONT_CHK_N "�� �����ٶ󸶹�"
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lFontSize = -1;
	long m_bFirst;					// ȭ�� Index
	long m_lActiveIndex;			// ���� ��ġ�� Index
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void Set_Menu(void);
	void RCV_CODE(void);
	
	long TR13131(void);
	long TR13132(void);
	long Rev13132(void);
	long TR13133(void);
	long Rev13133(void);
	long TR13134(void);
	long Rev13134(void);
	long TR13135(void);
	long Rev13135(void);
	long TR13136(void);
	long Rev13136(void);
	long TR13137(void);
	long Rev13137(void);
	long TR13138(void);
	long Rev13138(void);
	long TR13139(void);
	long Rev13139(void);
	long TR13140(void);
	long Rev13140(void);
	long TR685025(void);
	long Rev685025(void);	
	long TR685026(void);
	long Rev685026(void);
	long TR685027(void);
	long Rev685027(void);
	long TR685028(void);
	long Rev685028(void);
	
	void Font_Draw(void);
	void Chg_Font(void);
	
	void Barcode_Draw(void);
	void Chg_Bar(void);
	
	void Center_Chg_Draw(void);
	void Chg_Center(void);
	
	//---------------------------------------------------------------------------------------
	//	Global Button Style
	//---------------------------------------------------------------------------------------
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
	
	//---------------------------------------------------------------------------------------
	// Main ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������� �޴�"),
		
		DLG_BUTTON(0,		     STARTY+65, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CMCDRECV, "���� �ڵ�\n�ڷ� ����"),
		DLG_BUTTON(STARTX+500,	 STARTY+65, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PAYMENU, "��Ÿ ����"), 	  
		DLG_BUTTON(0,		    STARTY+345, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG_FONT, "���� ũ��\n����"),
		DLG_BUTTON(STARTX+500,	STARTY+345, 500, 280, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG_BARCODE, "���ڵ� ����\n����"),	
		DLG_BUTTON(0,		    STARTY+625, 500, 274, 75, 60, BUTSTY_BOLD, BUTSTY_BORDER|BUTSTY_BOLD, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG_CENTER, "������\n����"),
	};	
	
	//---------------------------------------------------------------------------------------
	// ��Ʈ ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CHGFONT[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����ũ�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
			
		DLG_BUTTON(STARTX,     STARTY+450, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),
		DLG_BUTTON(STARTX+500, STARTY+450, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FONT_CHANGE, "�� ��"),

		DLG_BUTTON(STARTX,     STARTY, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_1, ""),
		DLG_TEXT(STARTX,     STARTY, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_1, FONT_CHK_N),

		DLG_BUTTON(STARTX, STARTY+100, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_2, ""),
		DLG_TEXT(STARTX, STARTY+100, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_2, FONT_CHK_N),

		DLG_BUTTON(STARTX, STARTY+200, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_3, ""),
		DLG_TEXT(STARTX, STARTY+200, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_3, FONT_CHK_N),

		DLG_BUTTON(STARTX, STARTY+300, 1000, 70, 0, 0, BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_FUNC , "", BID_FONT_4, ""),
		DLG_TEXT(STARTX, STARTY+300, 1000, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FONT_4, FONT_CHK_N),

		DLG_TEXT(STARTX, STARTY+600, 1000, 299, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_FONT_NOTICE, "**�� ��**\n \n����ũ�� ���� �� ���α׷��� ����˴ϴ�."),
	};	

	//---------------------------------------------------------------------------------------
	// ���ڵ� ���� ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CHGBAR[] = 
	{
		NORM_DLG( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ڵ� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON( STARTX, 	STARTY+80, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR_CLOSE,  "�� ��"),	
		DLG_BUTTON( STARTX+500, STARTY+80, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR_CHANGE,  "�� ��"),	
		
		DLG_TEXT(STARTX,     	STARTY-20, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "���ڵ� ����"),
		DLG_COMBO (STARTX+300,  STARTY-20, 700, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),

		DLG_TEXT(STARTX, STARTY+600, 1000, 299, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_BAR_NOTICE, "**�� ��**\n \n���ڵ� ���� �� ���α׷��� ����˴ϴ�."),
	};
	
	//---------------------------------------------------------------------------------------
	// ������ ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_CHGCENTER[] = 
	{
		NORM_DLG( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		
		DLG_TEXT ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     	STARTY -29,  300,  80,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "������"),
		DLG_COMBO( STARTX +300, STARTY -29,  700, 80, 150, 80,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),
		
		DLG_LINE ( STARTX,      STARTY +55, 1000, STARTY +55, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_BUTTON(STARTX, 	    STARTY +60,  500,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "�� ��"),	
		DLG_BUTTON(STARTX +500, STARTY +60,  500,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CENTER_CHANGE,  "�� ��"),	
		
	};
	
	//---------------------------------------------------------------------------------------
	//	main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		return TRUE;
	}

	//---------------------------------------------------------------------------------------
	// SYSTEM FUNCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : OnInit
	��  �� : ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit( char bFirst )
	{
		m_bFirst = bFirst;
		
		switch( bFirst )
		{
			long i;
			
			// ����
			case INIT_MAIN:
			
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				g_FlagClear();
				SetBtnImg();
				
				Set_Menu();
				
				break;
			
			// ��Ʈ ����
			case INIT_CHGFONT:
			
				CREATE_DIALOG_OBJECT (DlgRes_CHGFONT, SIZEOF(DlgRes_CHGFONT));
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				Font_Draw();
				
				break;
			
			// ���ڵ� ���� ����
			case INIT_CHGBAR:
			
				CREATE_DIALOG_OBJECT (DlgRes_CHGBAR, SIZEOF(DlgRes_CHGBAR));
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				Barcode_Draw();
				
				break;
			
			// ������ ����
			case INIT_CHGCENTER:
				
				CREATE_DIALOG_OBJECT (DlgRes_CHGCENTER, SIZEOF(DlgRes_CHGCENTER));
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				Center_Chg_Draw();
				
				break;
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
		char sztmp[100];
		char szPath[100];
		char szbuf[100];
		char szBack[100];
		long i;
		long fd;
		long nRet;
	
		switch(ID)
		{
			/********************************/
			/*  ��� ���� ��ư              */
			/********************************/
			// ���� ���� �޴� �̵� ��ư
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				
				break;
			
			// ���� �� �޴� �̵� ��ư
			case GID_MENU:
				break;
			
			// ���� Ű���� ��ư
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
				
			// ���� ȭ�� ��ȯ ��ư
			case GID_SCREEN:
				g_MOVE_DLG(400);
				break;
			
			// ���� SOS��ư
			case GID_CMMNWK:
				break;
			
			// ���� �̹�ȭ�� ��ư	
			case GID_PREV:
				Card_Move("MENU");
				break;
			
			// ���� ���� ��ư
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/********************************/
			/*  ���� ��ư                   */
			/********************************/
			// ��� ��ư
			case BID_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			/********************************/
			/*  ���θ޴� ��ư               */
			/********************************/
			// ���� �ڵ� ���� ��ư
			case BID_CMCDRECV:
				RCV_CODE();
				break;
							
			// ��Ÿ ����
			case BID_PAYMENU:
				Card_Move("C6101_PayMenu");
				break;
				
			// ��Ʈ ���� ��ư
			case BID_CHG_FONT:
				ON_EXIT();
				OnInit(INIT_CHGFONT);
				break;
				
			// ���ڵ� ���� ��ư
			case BID_CHG_BARCODE:
				ON_EXIT();
				OnInit(INIT_CHGBAR);
				break;
			
			// ������ ����
			case BID_CHG_CENTER:
				ON_EXIT();
				OnInit(INIT_CHGCENTER);
				break;
			
			/********************************/
			/*  ��Ʈ ���� ��ư              */
			/********************************/
			// ��Ʈ ����_1 ��ư
			case BID_FONT_1:
				m_lFontSize = 1;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			
			// ��Ʈ ����_2 ��ư
			case BID_FONT_2:
				m_lFontSize = 2;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
				
			// ��Ʈ ����_3 ��ư
			case BID_FONT_3:
				m_lFontSize = 3;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
				
			// ��Ʈ ����_4 ��ư
			case BID_FONT_4:
				m_lFontSize = 4;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_Y );
				break;
			
			// ��Ʈ ���� ���
			case BID_FONT_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			// ��Ʈ ���� ����
			case BID_FONT_CHANGE:
				Chg_Font();
				break;
			
			/********************************/
			/*  ���ڵ� ���� ���� ��ư       */
			/********************************/
			// ���ڵ� ���� ���
			case BID_BAR_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			// ���ڵ� ���� ����
			case BID_BAR_CHANGE:
				Chg_Bar();
				break;
			
			/********************************/
			/*  ������ ���� ��ư          */
			/********************************/
			// ������ ����
			case BID_CENTER_CHANGE:
				Chg_Center();
				break;
		}
	}
	
	//---------------------------------------------------------------------------------------
	// �Ϲ� FUNCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư ������ ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
		
		// Ÿ��Ʋ
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
		// ��ܰ���޴�
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

	/*=======================================================================================
	�Լ��� : RCV_CODE
	��  �� : �����ڷ� ����, FR13131
	Param  : 
	Return : 
	========================================================================================*/
	void RCV_CODE(void)
	{
		char szUrl[200];
		char szFilepath[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
	
		if( MessageBoxEx (CONFIRM_YESNO, "���� �ڵ带 ���� �����ðڽ��ϱ�?") != MB_OK )
		{
			return;
		}
		
		MessageBoxEx(MESSAGE, "���� �ڷ� ������ �Դϴ�.");
		
		g_Sql_DirectExecute("DELETE FROM commoncode");
		g_Sql_DirectExecute("DELETE FROM BATTERY_KIND");
		g_Sql_DirectExecute("DELETE FROM BO_INST");
		g_Sql_DirectExecute("DELETE FROM BURNER_KIND");
		g_Sql_DirectExecute("DELETE FROM MTR_MODEL");
		g_Sql_DirectExecute("DELETE FROM COMPENS_MODEL");
		g_Sql_DirectExecute("DELETE FROM GOV_MODEL");
		g_Sql_DirectExecute("DELETE FROM REGTR_MODEL");
		g_Sql_DirectExecute("DELETE FROM USE_MAKER");
		g_Sql_DirectExecute("DELETE FROM C6101_BIZ_TYPE");
		g_Sql_DirectExecute("DELETE FROM C6101_PROD");
		g_Sql_DirectExecute("DELETE FROM C6101_BIZ_PROD");
		g_Sql_DirectExecute("DELETE FROM C6101_BIZ_BURN");
			
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13131, FALSE);
				
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);

		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		HTTP_DownloadTR(ret, szUrl, 13131, sndbuf, szbuf);
	}
	
	/*=======================================================================================
	�Լ��� : TR13131
	��  �� : FR13131 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13131(void)
	{
		if( g_Chk_Json(13131) >= 0 )
		{
			Rev13132();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13132
	��  �� : FR13132
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13132(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13132, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13132, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13132
	��  �� : FR13132 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13132(void)
	{
		if( g_Chk_Json(13132) >= 0 )
		{
			Rev13133();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13133
	��  �� : FR13133
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13133(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13133, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13133, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13133
	��  �� : FR13133 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13133(void)
	{
		if( g_Chk_Json(13133) >= 0 )
		{
			Rev13134();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13134
	��  �� : FR13134
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13134(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13134, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13134, sndbuf, szbuf);

		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13134
	��  �� : FR13134 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13134(void)
	{
		if( g_Chk_Json(13134) >= 0 )
		{
			Rev13135();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13135
	��  �� : FR13135
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13135(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13135, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13135, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13135
	��  �� : FR13135 Callbak
	Param  : 
	Return : 
	========================================================================================*/
	long TR13135(void)
	{
		if( g_Chk_Json(13135) >= 0 )
		{
			Rev13136();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13136
	��  �� : FR13136
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13136(void)
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

		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13136, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13136, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13136
	��  �� : FR13136 Callbak
	Param  : 
	Return : 
	========================================================================================*/
	long TR13136(void)
	{
		if( g_Chk_Json(13136) >= 0 )
		{
			Rev13137();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13137
	��  �� : FR13137
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13137(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13137, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13137, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13137
	��  �� : FR13137 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13137(void)
	{
		if( g_Chk_Json(13137) >= 0 )
		{
			Rev13138();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}

	/*=======================================================================================
	�Լ��� : Rev13138
	��  �� : FR13138
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13138(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13138, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13138, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13138
	��  �� : FR13138 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13138(void)
	{
		if( g_Chk_Json(13138) >= 0 )
		{
			Rev13139();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13139
	��  �� : FR13139
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13139(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13139, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13139, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13139
	��  �� : FR13139 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13139(void)
	{
		if( g_Chk_Json(13139) >= 0 )
		{
			Rev13140();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rev13140
	��  �� : FR13140
	Param  : 
	Return : 
	========================================================================================*/
	long Rev13140(void)
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 13140, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 13140, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR13140
	��  �� : FR13140 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR13140(void)
	{
		if( g_Chk_Json(13140) >= 0 )
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
	
	/*=======================================================================================
	�Լ��� : Rev685025
	��  �� : FR685025
	Param  : 
	Return : 
	========================================================================================*/
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685025, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685025, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR685025
	��  �� : FR685025 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685025(void)
	{
		if( g_Chk_Json(685025) >= 0 )
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
	
	/*=======================================================================================
	�Լ��� : Rev685026
	��  �� : FR685026
	Param  : 
	Return : 
	========================================================================================*/
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685026, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685026, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR685026
	��  �� : FR685026 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685026(void)
	{
		if( g_Chk_Json(685026) >= 0 )
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
	
	/*=======================================================================================
	�Լ��� : Rev685027
	��  �� : FR685027
	Param  : 
	Return : 
	========================================================================================*/
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685027, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685027, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR685027
	��  �� : FR685027 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685027(void)
	{
		if( g_Chk_Json(685027) >= 0 )
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
	
	/*=======================================================================================
	�Լ��� : Rev685028
	��  �� : FR685028
	Param  : 
	Return : 
	========================================================================================*/
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685028, FALSE);
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM(szbuf, SQLITE_DB);
		
		HTTP_DownloadTR(ret, szUrl, 685028, sndbuf, szbuf);
		
		return 0;
	}
	
	/*=======================================================================================
	�Լ��� : TR685028
	��  �� : FR685028 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR685028(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(685028) >= 0 )
		{
			MessageBoxEx (CONFIRM_OK, "������ �Ϸ�Ǿ����ϴ�.");
			ON_DRAW();
			return 1;
		}
		
		CloseMessageBox();
		
		return 1;
	}

	/*=======================================================================================
	�Լ��� : Font_Draw
	��  �� : ��Ʈ ���� ȭ�� Draw
	         theDevInfo.m_nFontSmallType = FONT_28; >> 1
			 theDevInfo.m_nFontType      = FONT_36; >> 2
			 theDevInfo.m_nFontLageType2 = FONT_52; >> 3
			 theDevInfo.m_nFontLageType  = FONT_64; >> 4
	Param  : 
	Return : 
	========================================================================================*/
	void Font_Draw(void)
	{
		long i = 0;
		char szFont[10];
	
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_FONT_NOTICE), TRUE, 2, EDITSEP_NONE );
	
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_1  ), FONT_32 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_2  ), FONT_36 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_3  ), FONT_38 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_4  ), FONT_40 );
		}
		else
		{
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_1  ), FONT_10 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_2  ), FONT_12 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_3  ), FONT_14 );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FONT_4  ), FONT_16 );
		}
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_1 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_2 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_3 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_4 )     , EDITALIGN_LEFT|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FONT_NOTICE ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		Mem_Set( (byte*)szFont, 0x00, sizeof(szFont) );
		g_Sql_RetStr("SELECT FONT_SIZE FROM USER_INFO", 4, szFont);
		i = Str_AtoI(szFont);
		
		switch( i )
		{
			case 1:
				m_lFontSize = 1;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			case 2:
				m_lFontSize = 2;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			case 3:
				m_lFontSize = 3;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_Y );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_N );
				break;
			case 4:
				m_lFontSize = 4;
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_1), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_2), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_3), FONT_CHK_N );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FONT_4), FONT_CHK_Y );
				break;
		}

		return;
	}
	
	/*=======================================================================================
	�Լ��� : Chg_Font
	��  �� : ��Ʈ ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void Chg_Font(void)
	{
		char szSql[128];
		char szFont[10];
		
		if( MessageBoxEx (CONFIRM_YESNO, "����ũ�⸦ �����Ͻðڽ��ϱ�?")  != MB_OK )
		{
			return;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szFont, 0x00, sizeof(szFont) );
		Str_ItoA(m_lFontSize, szFont, 10);
		SPRINT(szSql, "UPDATE USER_INFO SET FONT_SIZE = '%s'",szFont,0,0);
		g_Sql_DirectExecute(szSql);
		
		//����ũ�� ���� �� ���α׷� ����
		//g_nWorkFlag = 698:�ο� ��������, ���̺� Ŭ����.
		if( g_nWorkFlag == 698 )
		{
			g_Sql_DirectExecute("DELETE FROM C6101_WORK_REPORT");
			g_DirFS_Clear(PHOTO_WORK, "*");
		}
		
		//Ǫ�� �α׾ƿ� ����.
		g_SetPushLogout();
		
		g_Db_Backup();
		
		//����̹���
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Barcode_Draw
	��  �� : ���ڵ� ���� ȭ�� Draw
	Param  : 
	Return : 
	========================================================================================*/
	void Barcode_Draw(void)
	{
		char szBarFlag[10];
		
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_DATA1+2));
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "�� ���ڵ�", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "ī�޶� ���ڵ�", 0, ICON_NONE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BAR_NOTICE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_BAR_NOTICE), TRUE, 2, EDITSEP_NONE );
		
		Mem_Set( (byte*)szBarFlag, 0x00, sizeof(szBarFlag) );
		g_Sql_RetStr("SELECT BARCODE_FLAG FROM USER_INFO", 5, szBarFlag);
		
		if( Str_Cmp(szBarFlag, "P") == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), "ī�޶� ���ڵ�" );
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), "�� ���ڵ�" );
		}
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Chg_Bar
	��  �� : ���ڵ� ���� ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void Chg_Bar(void)
	{
		char szSql[128];
		char szBarFlag[10];
	
		if( MessageBoxEx (CONFIRM_YESNO, "���ڵ带 �����Ͻðڽ��ϱ�?")  != MB_OK )
		{
			return;
		}
		
		Mem_Set( (byte*)szBarFlag, 0x00, sizeof(szBarFlag) );
		if( Str_Cmp(EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1) ), "ī�޶� ���ڵ�") == 0 )
		{
			Str_Cpy(szBarFlag, "P");
		}
		else
		{
			Str_Cpy(szBarFlag, "B");
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE USER_INFO SET BARCODE_FLAG = '%s'",szBarFlag,0,0);
		g_Sql_DirectExecute(szSql);

		//���ڵ� ���� �� ���α׷� ����
		//g_nWorkFlag = 698:�ο� ��������, ���̺� Ŭ����.
		if( g_nWorkFlag == 698 )
		{
			g_Sql_DirectExecute("DELETE FROM C6101_WORK_REPORT");
			g_DirFS_Clear(PHOTO_WORK, "*");
		}
		
		//Ǫ�� �α׾ƿ� ����.
		g_SetPushLogout();
		
		g_Db_Backup();
		
		//����̹���
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Center_Chg_Draw
	��  �� : �ﰴ���� ���� ȭ�� Draw
	Param  : 
	Return : 
	========================================================================================*/
	void Center_Chg_Draw(void)
	{
		long i;
		char szBarFlag[10];
		char sztmp[100];
		
		// style setting
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		// �޺��ڽ� ����
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_DATA2+2));
		
		for ( i = 0 ;  CODE_CENTER[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), CODE_CENTER[i].Str, 0, ICON_NONE);
		}
		
		// �޺��ڽ� ���� �� ����
		i = g_SearchCD( stUserinfo.szcenter_cd, CODE_CENTER );
		
		PRINT("@@@@@@ 1 @@@@@@@@ : %s",stUserinfo.szcenter_cd,0,0);
		PRINT("@@@@@@ 2 @@@@@@@@ : %d",i,0,0);
		PRINT("@@@@@@ 3 @@@@@@@@ : %s",CODE_CENTER[i].Str,0,0);
		
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), CODE_CENTER[i].Str);
		}
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Chg_Center
	��  �� : ������ ����
	Param  : 
	Return : 
	========================================================================================*/
	void Chg_Center(void)
	{
		char sztmp[200];
		long i;
		
		if( MessageBoxEx (CONFIRM_YESNO, "�����͸� �����Ͻðڽ��ϱ�?") == MB_OK )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)stUserinfo.szcenter_cd, 0x00, sizeof(stUserinfo.szcenter_cd) );
			Mem_Set( (byte*)stUserinfo.szcenter_nm, 0x00, sizeof(stUserinfo.szcenter_nm) );
			
			Str_Cpy( stUserinfo.szcenter_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );
			
			Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2) ) );
			
			i = g_SearchStr( sztmp, CODE_CENTER );
				
			if (i == -1)
			{
				Str_Cpy(stUserinfo.szcenter_cd, "");
			}
			else
			{
				Str_Cpy(stUserinfo.szcenter_cd, CODE_CENTER[i].Code);
			}
			
			Card_Move("MENU");
		}
		else
		{
			return;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Set_Menu
	��  �� : �޴� Setting
	Param  : 
	Return : 
	========================================================================================*/
	void Set_Menu(void)
	{
		char sztmp[200];
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		g_Sql_RetStr("SELECT CENTER_CD FROM USER_INFO", 10, sztmp);
		
		if( Str_Cmp( sztmp, "91" ) == 0 || 
		 	Str_Cmp( sztmp, "92" ) == 0 ||
		 	Str_Cmp( sztmp, "93" ) == 0 ||
		 	Str_Cmp( sztmp, "94" ) == 0 ||
		 	Str_Cmp( sztmp, "95" ) == 0 )
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHG_CENTER), TRUE );
		}
		else
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHG_CENTER), FALSE );		
		}
	}
}


