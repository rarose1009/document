/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_IMGPOPUP
	Card Desc : �̹��� �˾�
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_IMGPOPUP
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
		DEF_BUTTON_ID ( BID_OK )
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// ī�峻���� ���� ��Ʈ�� ���̵� ����
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( PNG_LOGO1 )	
		DEF_OBJECT_ID ( ICON_LOGO1 )
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// �⺻���� DLGȭ�� ����
	//---------------------------------------------------------------
	#define INIT_MAIN		1
	long m_bFirst;
	long m_lActiveIndex;

	void SetStyle(void);
	
	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, 0, ICON_LOGO1, ""),
		CTR_PNG(PNG_LOGO1,  PNG_COLOR_NORMAL, "Cm_ImgPopup"),
		
		DLG_BUTTON(STARTX+700,  STARTY+830, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "Ȯ��"),
	};
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, 0, ICON_LOGO1, ""),
		CTR_PNG(PNG_LOGO1,  PNG_COLOR_NORMAL, "Cm_ImgPopup"),
		
		DLG_BUTTON(STARTX+700,  STARTY+670, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "Ȯ��"),
	};

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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				SetStyle();
				ON_DRAW();
				break;	
		}		
	}

	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : BUTTON ACTIVE EVENT
	Param  : long ID
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_OK:	

				if(g_nWorkFlag == 600)
				{
					Card_Move("C6101_MENU");
				}
				else if(g_nWorkFlag == 200)
				{
					Card_Move("SC_MENU");
				}
				else
				{
					Card_Move("MENU");
				}
				
				break;
		}
	}

	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : 
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_LOGO1), 0, Get_hSlfCtrlFromID(PNG_LOGO1));
	}	
}
