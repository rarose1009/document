/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_MLTUSERCV
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
		DEF_BUTTON_ID ( BID_RECV )		//�ڷ����
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
		DEF_OBJECT_ID ( TXT_BSYEAR )	//���˳�
		DEF_OBJECT_ID ( TXT_JISANM )	//�����
		DEF_OBJECT_ID ( TXT_NUMBER )	//����
		DEF_OBJECT_ID ( TXT_DATA1 )
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		
		DEF_OBJECT_ID ( ICON_TITLE )	//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_NUMBER ) 	//���� �޺��ڽ�
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	void SetStyle(void);
	void SetBtnImg(void);
	
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
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�����̿�ü� ����"),
		
		DLG_BUTTON(STARTX+200, STARTY+500, 600, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),
		
		DLG_TEXT(STARTX,     STARTY+180, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BSYEAR, "���˳�"),
		DLG_EDIT(STARTX+400, STARTY+180, 575, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA1, 10,  ""),
		DLG_TEXT(STARTX,     STARTY+250, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_JISANM, "�����"),
		DLG_TEXT(STARTX+400, STARTY+250, 575, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+320, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NUMBER, "����"),
		
		DLG_COMBO (STARTX+400, STARTY+320, 575, 290, 70, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NUMBER, 10),	//���� �޺��ڽ�
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�����̿�ü� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+200, STARTY+550, 600, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�ڷ����"),
		
		DLG_TEXT(STARTX, STARTY+180, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_BSYEAR, "���˳�"),
		DLG_EDIT(STARTX+400, STARTY+180, 575, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA1, 10,  ""),
		DLG_TEXT(STARTX, STARTY+250, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_JISANM, "�����"),
		DLG_TEXT(STARTX+400, STARTY+250, 575, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX, STARTY+320, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_NUMBER, "����"),
		
		DLG_COMBO (STARTX+400, STARTY+320, 575, 290, 70, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NUMBER, 10),	//���� �޺��ڽ�
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
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_NUMBER+2), "3��", 0, ICON_NONE);
						
						SetBtnImg();
						SetStyle();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_NUMBER+2), "3��", 0, ICON_NONE);
						SetBtnImg();
						SetStyle();
						break;		
				}
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
		}
	}

//-----------------------------------------------------------------
void	SetStyle(void)
{
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSYEAR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JISANM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NUMBER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_NUMBER), EDITALIGN_MIDDLE);
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_RECV:
				break;
			case GID_HOME:
				Card_Move("MENU");
				break;
			case GID_MENU:
				Card_Move("BS_MENU");
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
				Card_Move("BS_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;

		}
	}		
}


