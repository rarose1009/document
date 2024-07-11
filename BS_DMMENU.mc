/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_DMMENU
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
		DEF_BUTTON_ID ( BID_RECV )			//Ư������ ��ü�ڷ����
		DEF_BUTTON_ID ( BID_DAYRECV )		//Ư������ �����ڷ����
		DEF_BUTTON_ID ( BID_SFWORKRECV )	//�������� �����ڷ����
		DEF_BUTTON_ID ( BID_SEND )			//�ڷ�۽�
		DEF_BUTTON_ID ( BID_MLTUSERECV )	//�����̿�ü� �ڷ����
		DEF_BUTTON_ID ( BID_MLTUSESEND )	//�����̿�ü� �ڷ�۽�
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
		
		DEF_OBJECT_ID ( ICON_TITLE)		//Ÿ��Ʋ

		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
	END_OBJECT_ID()
	
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
	
	#define INIT_MAIN	1	
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�ڷ� ����"),
					
		//DLG_BUTTON(STARTX+240, STARTY+180, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RECV, "Ư������\n��ü�ڷ����"),
		//DLG_BUTTON(STARTX+240, STARTY+330, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DAYRECV, "Ư������\n�����ڷ����"),
		//DLG_BUTTON(STARTX+240, STARTY+480, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEND, "Ư������\n�ڷ�۽�"),
		//DLG_BUTTON(STARTX+240, STARTY+630, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SFWORKRECV, "��������\n�����ڷ����"),
//		DLG_BUTTON(STARTX+120, STARTY+550, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MLTUSERECV, "�����̿�ü� �ڷ����"),
//		DLG_BUTTON(STARTX+120, STARTY+650, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MLTUSESEND, "�����̿�ü� �ڷ�۽�"),
					
		DLG_BUTTON(STARTX, 		STARTY+65,           BTNWH, BTNHT, 25, 4, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RECV, ""), // Ư������\n��ü�ڷ����
		DLG_BUTTON(STARTX+495, 	STARTY+65,           BTNWH, BTNHT, 25, 4, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DAYRECV, ""), // Ư������\n�����ڷ����
		DLG_BUTTON(STARTX, 		STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEND, ""), // Ư������\n�ڷ�۽�
		DLG_BUTTON(STARTX+495, 	STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 4, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SFWORKRECV, ""), // ��������\n�����ڷ����
		
		DLG_LINE(500, STARTY+65,                 500, STARTY+65+(2*BTNHT), LINECTRLCOLOR, 2, LINE_DATA1),
		DLG_LINE(0,  STARTY+65+(1*BTNHT), STARTX+995, STARTY+65+(1*BTNHT), LINECTRLCOLOR, 2, LINE_DATA2),
		DLG_LINE(0,  STARTY+65+(2*BTNHT), STARTY+995, STARTY+65+(2*BTNHT), LINECTRLCOLOR, 2, LINE_DATA3)
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�ڷ� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
/*
		DLG_BUTTON(STARTX+150,  STARTY+50, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "Ư������ ��ü�ڷ����"),
		DLG_BUTTON(STARTX+150, STARTY+200, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DAYRECV, "Ư������ �����ڷ����"),
		DLG_BUTTON(STARTX+150, STARTY+500, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "Ư������ �ڷ�۽�"),
		DLG_BUTTON(STARTX+150, STARTY+350, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SFWORKRECV, "�������� �����ڷ����"),
//		DLG_BUTTON(STARTX+150, STARTY+550, P_BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MLTUSERECV, "�����̿�ü� �ڷ����"),
//		DLG_BUTTON(STARTX+150, STARTY+650, P_BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MLTUSESEND, "�����̿�ü� �ڷ�۽�"),
*/
		DLG_BUTTON(STARTX+240, STARTY+130, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "Ư������\n��ü�ڷ����"),
		DLG_BUTTON(STARTX+240, STARTY+280, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DAYRECV, "Ư������\n�����ڷ����"),
		DLG_BUTTON(STARTX+240, STARTY+430, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "Ư������\n�ڷ�۽�"),
		DLG_BUTTON(STARTX+240, STARTY+580, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SFWORKRECV, "��������\n�����ڷ����"),
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
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				
				SetBtnImg();
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
			
			//�����޴� ��ư
			h = Get_hDlgCtrlByID(BID_RECV);
			ButCtrl_SetImage( h,  g_pImgBs_TotDataRcv);
	
			h = Get_hDlgCtrlByID(BID_DAYRECV);
			ButCtrl_SetImage( h,  g_pImgBs_DayDataRcv);
			
			h = Get_hDlgCtrlByID(BID_SEND);
			ButCtrl_SetImage( h,  g_pImgBs_DataSnd);
			
			h = Get_hDlgCtrlByID(BID_SFWORKRECV);
			ButCtrl_SetImage( h,  g_pImgBs_SafeDataRcv);
			
	//		h = Get_hDlgCtrlByID(BID_MLTUSERECV);
	//		ButCtrl_SetImage( h,  g_pImgMnBot);
			
	//		h = Get_hDlgCtrlByID(BID_MLTUSESEND);
	//		ButCtrl_SetImage( h,  g_pImgMnBot);
		}
	}
	
//--------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_RECV:
				Card_Move("BS_RCV");
				break;				
			case BID_DAYRECV:
				Card_Move("BS_DAYRCV");
				break;			
			case BID_SFWORKRECV:
				Card_Move("BS_SFWRKRCV");
				break;
			case BID_SEND:
				Card_Move("BS_SND");
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "Ư������ �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("BS_MENU");
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
				Card_Move("BS_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		
}


