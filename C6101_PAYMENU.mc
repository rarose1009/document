/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_PAYMENU
	Card Desc : �ο� �����޴�
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_PAYMENU
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
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
	
		/********************************/
		/*  ����                        */
		/********************************/
		DEF_BUTTON_ID ( BID_HOME )		// Ȩ
		DEF_BUTTON_ID ( BID_MENU )		// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	// �������
		DEF_BUTTON_ID ( BID_PREV )		// ����
		DEF_BUTTON_ID ( BID_EXIT )		// ����
		
		/********************************/
		/* �Ϲ�                         */
		/********************************/
		DEF_BUTTON_ID ( BID_CARD )			// ī��
		DEF_BUTTON_ID ( BID_CARD_CANCEL )	// ī�� ���
		DEF_BUTTON_ID ( BID_CASH )			// ���ݿ�����
		DEF_BUTTON_ID ( BID_CASH_CANCEL )	// ���ݿ����� ���
				
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
	
		/********************************/
		/* Ÿ��Ʋ                       */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )		// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )	// ������
			
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	1
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	
	//---------------------------------------------------------------------------------------
	// Global Btn
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
	// ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON( 0, BTNY_2, ICON_TITLE, ""),
		DLG_TEXT( TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��Ÿ ī��, ���ݿ�����" ),
			
		DLG_BUTTON( STARTX+260, STARTY+140, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CARD, "ī��" ),
		DLG_BUTTON( STARTX+260, STARTY+290, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CARD_CANCEL, "ī�� ���" ),
		
		DLG_BUTTON( STARTX+260, STARTY+520, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CASH, "���ݿ�����" ),
		DLG_BUTTON( STARTX+260, STARTY+670, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CASH_CANCEL, "���ݿ����� ���" ),
	};	
	
	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : OnInit
	��  �� : ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit(char bFirst)
	{
		switch( bFirst )
		{
			case INIT_MAIN:
				CREATE_GLOBAL_BUTTON( SysButRes_MAIN );
				CREATE_DIALOG_OBJECT( DlgRes, SIZEOF(DlgRes) );
				SetBtnImg();
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton( long ID )
	{	
		switch(ID)
		{

			case GID_HOME:
				if( MessageBoxEx( CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?" )  == MB_OK )
				{
					Card_Move("MENU");
				}
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
				// Card_Move("C6101_MENU");
				Card_Move("CM_MENU");
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				break;
				
			case BID_CARD:
				Card_Move("C6101_ETCCARD");
				break;
				
			case BID_CARD_CANCEL:
				Card_Move("C6101_ETCCARDLST");
				break;
				
			case BID_CASH:
				Card_Move("C6101_ETCCASH");
				break;
			
			case BID_CASH_CANCEL:
				Card_Move("C6101_ETCCASHLST");
				break;
		}
	}
	
	//---------------------------------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư �̹���
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage( Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE );
		
		if( theDevInfo.m_nType != FAMILY_PDA )
		{	
			// ��ܰ���޴�
			h = GetSysButHandle( GID_HOME );
			ButCtrl_SetImage( h,  g_pImgHomeI );
			ButCtrl_SetActiveImage( h,  g_pImgHomeA );
			
			h = GetSysButHandle( GID_KEYBOARD );
			ButCtrl_SetImage( h,  g_pImgKeybrdI );
			ButCtrl_SetActiveImage( h,  g_pImgKeybrdA );
			
			h = GetSysButHandle( GID_SCREEN );
			ButCtrl_SetImage( h,  g_pImgScreenI );
			ButCtrl_SetActiveImage( h,  g_pImgScreenA );
			
			h = GetSysButHandle( GID_CMMNWK );
			ButCtrl_SetImage( h,  g_pImgCmmnwrkI );
			ButCtrl_SetActiveImage( h,  g_pImgCmmnwrkA );
			
			h = GetSysButHandle( GID_VMEXIT );
			ButCtrl_SetImage( h,  g_pImgExitI );
			ButCtrl_SetActiveImage( h,  g_pImgExitA );
			
			// �޴���ư
			h = Get_hDlgCtrlByID( BID_CARD );
			ButCtrl_SetImage( h,  g_pImgMnTop );
			
			h = Get_hDlgCtrlByID( BID_CARD_CANCEL );
			ButCtrl_SetImage( h,  g_pImgMnTop );
			
			h = Get_hDlgCtrlByID( BID_CASH );
			ButCtrl_SetImage( h,  g_pImgMnTop );
			
			h = Get_hDlgCtrlByID( BID_CASH_CANCEL );
			ButCtrl_SetImage( h,  g_pImgMnTop );
		}
	}	
}
