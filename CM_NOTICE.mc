/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card CM_NOTICE
{
	#include <include.h>
	#include "globalcard.h"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_OK )		//Ȯ��
	//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_TITLE2 )		//����
		DEF_OBJECT_ID ( TXT_NTCLIST )	//�������� ���
		DEF_OBJECT_ID ( TXT_NOTICE )	//�������� ����
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	void SetStyle(void);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_TITLE, "�� �� �� ��"),
		
		//ȭ�� ���� �޴�
		DLG_BUTTON(STARTX,      5, 145, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "�޴�"),
		DLG_BUTTON(STARTX+290,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "����"),
		DLG_BUTTON(STARTX+430,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "ȭ��"),
		DLG_BUTTON(STARTX+570,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"����"),
		DLG_BUTTON(STARTX+710,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "����"),
		DLG_BUTTON(STARTX+850,  5, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "����"),
			
		DLG_BUTTON(STARTX+305, STARTY+800, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX, STARTY+60, 975, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TITLE2, "�� ��"),
		DLG_TEXT(STARTX, STARTY+140, 975, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NTCLIST, ""),
		DLG_TEXT(STARTX, STARTY+350, 975, 400, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NOTICE, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		

//		DLG_BUTTON(STARTX+305, STARTY+740, 400, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		DLG_BUTTON(STARTX+305, STARTY+690, 400, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX, STARTY, 975, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TITLE2, "�� ��"),
		DLG_TEXT(STARTX, STARTY+110, 975, 200, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NTCLIST, ""),
//		DLG_TEXT(STARTX, STARTY+320, 975, 400, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NOTICE, ""),
		DLG_TEXT(STARTX, STARTY+320, 975, 350, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NOTICE, ""),
		
	};		
	
	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void	OnInit(char bFirst)
	{
		switch (bFirst)
		{
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:	
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						SetStyle();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
						
						SetStyle();
						break;		
				}
				break;
		}
	}

//------------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_OK:
				Card_Move("CM_MENU");
				break;
			case BID_HOME:
				Card_Move("MENU");			
				break;
			case BID_MENU:
				break;
			case BID_KEYBOARD:
				break;
			case BID_SCREEN:
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
				Card_Move("CM_MENU");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}		
}

