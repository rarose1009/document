/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_DTLLIST_1
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
		DEF_BUTTON_ID ( BID_ADDR1 )		//���� �ּ�
		DEF_BUTTON_ID ( BID_ADDR2 )		//���θ� �ּ�
		DEF_BUTTON_ID ( BID_CALL )		//��ȭ �湮
		DEF_BUTTON_ID ( BID_SMS )		//SMS �߼�
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
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
		DEF_OBJECT_ID ( TXT_DAY )		//����
		DEF_OBJECT_ID ( TXT_TIME )		//�ð�
		DEF_OBJECT_ID ( TXT_ADDR )		//
		DEF_OBJECT_ID ( TXT_ADDR2 )		//
		DEF_OBJECT_ID ( TXT_ADDR3 )		//
		DEF_OBJECT_ID ( TXT_PAGE )		//������
		
		DEF_OBJECT_ID ( CMB_DAY )		//���� �޺��ڽ�
		DEF_OBJECT_ID ( CMB_TIME = CMB_DAY+3 )		//�ð� �޺��ڽ�
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    4					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+330  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�",	 CWD*18, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",     CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ð�",     CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ȭ��ȣ", CWD*9,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
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
		
		DLG_BUTTON(STARTX+555, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+775, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),		
		DLG_BUTTON(STARTX, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR1, "�����ּ�"),
		DLG_BUTTON(STARTX+235, STARTY+260, 270, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ��ּ�"),
		DLG_BUTTON(STARTX+510, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CALL, "��ȭ�湮"),
		DLG_BUTTON(STARTX+745, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS�߼�"),
		
		DLG_TEXT(STARTX, STARTY, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""), 		
		DLG_TEXT(STARTX+175, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DAY, "����"),		
		DLG_TEXT(STARTX+575, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TIME, "�ð�"),	
		DLG_TEXT(STARTX, STARTY+60, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		
		DLG_TEXT(STARTX, STARTY+120, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		DLG_TEXT(STARTX, STARTY+190, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, " 1/10 "),
		
		DLG_COMBO (STARTX+325, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DAY, 10),	//����
		DLG_COMBO (STARTX+725, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_TIME, 10),	//�ð�
		
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
		
		DLG_BUTTON(STARTX+555, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+775, STARTY+190, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),		
		DLG_BUTTON(STARTX, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR1, "�����ּ�"),
		DLG_BUTTON(STARTX+235, STARTY+260, 270, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "���θ��ּ�"),
		DLG_BUTTON(STARTX+510, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CALL, "��ȭ�湮"),
		DLG_BUTTON(STARTX+745, STARTY+260, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS�߼�"),
		
		DLG_TEXT(STARTX, STARTY, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""), 		
		DLG_TEXT(STARTX+175, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DAY, "����"),		
		DLG_TEXT(STARTX+575, STARTY, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_TIME, "�ð�"),	
		DLG_TEXT(STARTX, STARTY+60, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),		
		DLG_TEXT(STARTX, STARTY+120, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		DLG_TEXT(STARTX, STARTY+190, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, " 1/10 "),
		
		DLG_COMBO (STARTX+325, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DAY, 10),	//����
		DLG_COMBO (STARTX+725, STARTY, 250, 290, 70, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_TIME, 10),	//�ð�
		
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
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "ȭ����", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "������", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME+2), "17��", 0, ICON_NONE);
						SetStyle();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "ȭ����", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DAY+2), "������", 0, ICON_NONE);
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME+2), "17��", 0, ICON_NONE);
						SetStyle();
						break;		
				}
				break;
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}	

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_ADDR1:
//				g_nWorkFlag = ;
//				Card_Move("");				
				break;				
			case BID_ADDR2:
				break;			
			case BID_CALL:
				break;
			case BID_SMS:
				break;
			case BID_HOME:
//				g_nWorkFlag = ;
				Card_Move("MENU");			
				break;
			case BID_MENU:
//				g_nWorkFlag = ;
				Card_Move("SC_MENU");				
				break;
			case BID_KEYBOARD:
				Card_Move("SC_ENTRY");
				break;
			case BID_SCREEN:
				Card_Move("SC_APPOINTSC");
				break;
			case BID_CMMNWORK:
				break;
			case BID_PREV:
//				g_nWorkFlag = ;
				Card_Move("SC_GRPLIST");
				break;	
			case BID_EXIT:
				g_Exit();
				break;
		}
	}		
}


