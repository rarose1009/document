/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_LIST_2
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
		DEF_BUTTON_ID ( BID_SEARCH )	//�˻� 
		DEF_BUTTON_ID ( BID_UP )		//�� ������
		DEF_BUTTON_ID ( BID_DOWN )		//�Ʒ� ������
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
		DEF_OBJECT_ID ( TXT_PAGE )		//������
		DEF_OBJECT_ID ( TXT_ADDR1 )		//�ּ�1
		DEF_OBJECT_ID ( TXT_ADDR2 )		//�ּ�2
		DEF_OBJECT_ID ( TXT_ADDR3 )		//�ּ�3
		DEF_OBJECT_ID ( TXT_CMPLT )		//�Ϸ�
		DEF_OBJECT_ID ( TXT_CMPLTRSLT ) //�Ϸ���
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+20)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX+20 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+210  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�",   CWD*18, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"D",      CWD*4 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"C",      CWD*4 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ",   CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��뷮", CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	
	void SetStyle(void);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		
		//ȭ�� ���� �޴�
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "�޴�"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "����"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "ȭ��"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"����"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "����"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "����"),
		
		DLG_TEXT(STARTX+20,  STARTY+155, 250, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, "1 / 100"), 	//����������/��������
		DLG_TEXT(STARTX+20,  STARTY, 250, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),		//�ּ�1
		DLG_TEXT(STARTX+20,  STARTY+50, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		//�ּ�2
		DLG_TEXT(STARTX+20,  STARTY+100, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),		//�ּ�3
		DLG_TEXT(STARTX+470, STARTY, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_CMPLT, "�� ��"),	//�Ϸ�
		DLG_TEXT(STARTX+670, STARTY, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CMPLTRSLT, ""),	//�Ϸ���
		
		DLG_BUTTON(STARTX+270, STARTY, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, " �� ��"),
		DLG_BUTTON(STARTX+650, STARTY+155, 150, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+820, STARTY+155, 150, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		
		//ȭ�� ���� �޴�
		DLG_BUTTON(STARTX,      5, 145, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "�޴�"),
		DLG_BUTTON(STARTX+290,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "����"),
		DLG_BUTTON(STARTX+430,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "ȭ��"),
		DLG_BUTTON(STARTX+570,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"����"),
		DLG_BUTTON(STARTX+710,  5, 135, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "����"),
		DLG_BUTTON(STARTX+850,  5, 130, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "����"),
		
		DLG_BUTTON(STARTX+270, STARTY, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH, " �� ��"),
		DLG_BUTTON(STARTX+650, STARTY+155, 150, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+820, STARTY+155, 150, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),		
		
		DLG_TEXT(STARTX+20,  STARTY+155, 250, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_PAGE, "1 / 100"), 	//����������/��������
		DLG_TEXT(STARTX+20,  STARTY, 250, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),		//�ּ�1
		DLG_TEXT(STARTX+20,  STARTY+50, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),	//�ּ�2
		DLG_TEXT(STARTX+20,  STARTY+100, 950, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),	//�ּ�3
		DLG_TEXT(STARTX+470, STARTY, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_CMPLT, "�� ��"),	//�Ϸ�
		DLG_TEXT(STARTX+670, STARTY, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CMPLTRSLT, ""),	//�Ϸ���		
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
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
						SetStyle();
						break;		
				}
				break;
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMPLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}	

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_SEARCH:
				g_nWorkFlag = 220;
				Card_Move("SC_ENTRY");				
				break;				
			case BID_UP:
				break;			
			case BID_DOWN:
				break;
			case BID_HOME:
				g_nWorkFlag = 220;
				Card_Move("MENU");			
				break;
			case BID_MENU:
				g_nWorkFlag = 220;
				Card_Move("SC_MENU");				
				break;
			case BID_KEYBOARD:
				break;
			case BID_SCREEN:
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
				g_nWorkFlag = 220;
				Card_Move("SC_GRPLIST");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}		
}


