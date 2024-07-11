/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_PAYCAL
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
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		//����	
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
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_GMDATE )		//��ħ��
		DEF_OBJECT_ID ( TXT_OBJECT )		//��ǰ
		DEF_OBJECT_ID ( TXT_CLNAME )		//����
		DEF_OBJECT_ID ( TXT_NCABLEHP )		//�޴���
		DEF_OBJECT_ID ( TXT_CABLEHP )		//��ȭ
		DEF_OBJECT_ID ( TXT_GOOBOON )		//����
		DEF_OBJECT_ID ( TXT_THSMONTH )		//���
		DEF_OBJECT_ID ( TXT_PREMONTH )		//����
		DEF_OBJECT_ID ( TXT_VC )			//VC
		DEF_OBJECT_ID ( TXT_USE )			//��뷮
		DEF_OBJECT_ID ( TXT_USECAL )		//��뿭��
		DEF_OBJECT_ID ( TXT_FEE )			//���
		DEF_OBJECT_ID ( TXT_CNTRCTDT )		//�������
		DEF_OBJECT_ID ( TXT_NOTIFY )		//���� ����
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	void SetStyle(void);
	void REDRAW(void);
	void SetBtnImg(void);
	void Rcv_paymant(void);
	long TR24233(void);
	void Rcv24234(void);
	long TR24234(void);	
	void Set_Paymant(void);
	
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��� ���"),

		DLG_BUTTON(STARTX,	   STARTY+125, 300, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+650, STARTY+819, 350, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,	  STARTY+65, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GMDATE, "��ħ��"),
		DLG_TEXT(STARTX+300,  STARTY+65, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+500,  STARTY+65, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "��ǰ"),
		DLG_TEXT(STARTX+700,  STARTY+65, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+300, STARTY+125, 700, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),		
		DLG_TEXT(STARTX,	 STARTY+215, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLNAME, "����"),
		DLG_TEXT(STARTX+300, STARTY+215, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,	 STARTY+275, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NCABLEHP, "�޴���"),
		DLG_TEXT(STARTX+300, STARTY+275, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,	 STARTY+335, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CABLEHP, "��ȭ"),
		DLG_TEXT(STARTX+300, STARTY+335, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,	 STARTY+395, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "����"),
		DLG_TEXT(STARTX+300, STARTY+395, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_THSMONTH, "���"),
		DLG_TEXT(STARTX+640, STARTY+395, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PREMONTH, "����"),
		DLG_TEXT(STARTX,	 STARTY+455, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VC, "VC"),
		DLG_TEXT(STARTX+300, STARTY+455, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+640, STARTY+455, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,	 STARTY+515, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_USE, "��뷮"),
		DLG_TEXT(STARTX+300, STARTY+515, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX+640, STARTY+515, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX,	 STARTY+575, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_USECAL, "��뿭��"),
		DLG_TEXT(STARTX+300, STARTY+575, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+640, STARTY+575, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,	 STARTY+635, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FEE, "���"),
		DLG_TEXT(STARTX+300, STARTY+635, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,	 STARTY+695, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTDT, "�������"),
		DLG_TEXT(STARTX+300, STARTY+695, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX,	 STARTY+755, 600, 145, 0, 0, EDITSTY_BORDER, 0, RED, TXTINCTRLBK, TXT_NOTIFY, "��ȸ�� ����� \n ����û���ݾװ� ���̰� \n ���� �� �ֽ��ϴ�."),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "��� ���"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY+20, 300, 120, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+650, STARTY+799, 350, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY-40, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GMDATE, "��ħ��"),
		DLG_TEXT(STARTX+300, STARTY-40, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY-40, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "��ǰ"),
		DLG_TEXT(STARTX+750, STARTY-40, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+300, STARTY+20, 700, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),	
		DLG_TEXT(STARTX,     STARTY+140, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLNAME, "����"),
		DLG_TEXT(STARTX+300, STARTY+140, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+200, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NCABLEHP, "�޴���"),
		DLG_TEXT(STARTX+300, STARTY+200, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+260, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CABLEHP, "��ȭ"),
		DLG_TEXT(STARTX+300, STARTY+260, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+320, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOOBOON, "����"),
		DLG_TEXT(STARTX+300, STARTY+320, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_THSMONTH, "���"),
		DLG_TEXT(STARTX+640, STARTY+320, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PREMONTH, "����"),
		DLG_TEXT(STARTX,     STARTY+380, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VC, "VC"),
		DLG_TEXT(STARTX+300, STARTY+380, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+640, STARTY+380, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,     STARTY+440, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_USE, "��뷮"),
		DLG_TEXT(STARTX+300, STARTY+440, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX+640, STARTY+440, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX,     STARTY+500, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_USECAL, "��뿭��"),
		DLG_TEXT(STARTX+300, STARTY+500, 340, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+640, STARTY+500, 360, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,     STARTY+560, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FEE, "���"),
		DLG_TEXT(STARTX+300, STARTY+560, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,     STARTY+620, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTDT, "�������"),
		DLG_TEXT(STARTX+300, STARTY+620, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		
		DLG_TEXT(STARTX, STARTY+690, 600, 200, 0, 0, EDITSTY_BORDER, 0, RED, TXTINCTRLBK, TXT_NOTIFY, "��ȸ�� ����� \n ����û���ݾװ� ���̰� \n ���� �� �ֽ��ϴ�."),
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
				SetStyle();
				REDRAW();
				Rcv_paymant();
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
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMDATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLNAME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NCABLEHP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CABLEHP), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOOBOON), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_THSMONTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PREMONTH), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USECAL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FEE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CNTRCTDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOTIFY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
	EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_NOTIFY), TRUE, 2, EDITSEP_NONE );		//������
	EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA3), TRUE, 2, EDITSEP_NONE );		//������
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_ADDR:
				//g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�
				if( g_nAddrFlag == 0)
					g_nAddrFlag = 1;
				else
					g_nAddrFlag = 0;
				REDRAW();
				ON_DRAW();
				break;
			case BID_OK:
				if( g_nGmType == 1 )
				{
					Card_Move("GM_REENTRY");
				}
				else
				{
					Card_Move("GM_ENTRY");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					g_lDataflag = 0;
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "��ħ �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lMoveFlag = 0;
					g_lDataflag = 0;
					Card_Move("GM_MENU");
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
				if( g_nGmType == 1 )
				{
					Card_Move("GM_REENTRY");
				}
				else
				{
					Card_Move("GM_ENTRY");
				}
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
				break;
		}
	}
	
//--------------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szAddr[200];
		char szPhone[50];
		char szTel[50];
		char sztmp[20];
		
		Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
		Mem_Set((byte*)szPhone, 0x00, sizeof(szPhone));
		Mem_Set((byte*)szTel, 0x00, sizeof(szTel));
	
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), stGm.BASE_YMD);		//��ħ��
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stGm.PROD_CD);		//��ǰ  

		if( g_nAddrFlag == 0)
		{
			Str_Cpy(szAddr,  stGm.AREA );		//�ñ���
			
			if(Str_Len(stGm.TOWN) != 0)			//���鵿
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.TOWN );
			}
			if(Str_Len(stGm.ADDR1_M) == 0)		//����
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.ADDR1_M);
			}			
			if(Str_Len(stGm.ADDR1_S) == 0)		//�ι�
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.ADDR1_S);
			}
			
			//��ȸȭ�鿡���� �ּ�
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.CO_LIVE_NM );	//�������ø�
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.BLD_NM );		//�ǹ���
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DONG_NUM );	//����ȣ
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.HOSU );		//ȣ��
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DETA_FLOOR );		//������
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szAddr);
		}
		else
		{
			Str_Cpy(szAddr,  stGm.AREA );		//�ñ���
			
			if(Str_Len(stGm.NEW_ROAD_NM) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.NEW_ROAD_NM );
			}
			if(Str_Len(stGm.NEW_ADDR_M) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.NEW_ADDR_M);
			}
			if(Str_Len(stGm.NEW_ADDR_S) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.NEW_ADDR_S);
			}
			
			//��ȸȭ�鿡���� �ּ�
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.CO_LIVE_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.BLD_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DONG_NUM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.HOSU );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stGm.DETA_FLOOR );		//������
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szAddr);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stGm.CUST_NM);		//����
		
		//�޴���ȭ
		Str_Cpy(szPhone,  stGm.CP_DDD );
		Str_Cat(szPhone,  "-" );
		if(Str_Len(stGm.CP_EXN) == 0)
		{
			Str_Cat(szPhone,  " " );	
		}
		else
		{
			Str_Cat(szPhone,  stGm.CP_EXN);
		}
		Str_Cat(szPhone,  "-" );
		if(Str_Len(stGm.CP_NUM) == 0)
		{
			Str_Cat(szPhone,  " " );	
		}
		else
		{
			Str_Cat(szPhone,  stGm.CP_NUM);

		}
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), szPhone);
		
		//������ȭ
		Str_Cpy(szTel,  stGm.OWNHOUSE_TEL_DDD );
		Str_Cat(szTel,  "-" );
		if(Str_Len(stGm.OWNHOUSE_TEL_EXN) == 0)
		{
			Str_Cat(szTel,  " " );	
		}
		else
		{
			Str_Cat(szTel,  stGm.OWNHOUSE_TEL_EXN);
		}
		Str_Cat(szTel,  "-" );
		if(Str_Len(stGm.OWNHOUSE_TEL_NUM) == 0)
		{
			Str_Cat(szTel,  " " );	
		}
		else
		{
			Str_Cat(szTel,  stGm.OWNHOUSE_TEL_NUM);
		}
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), szTel);
		
		
		if(Str_Cmp(stGm.GMTR_OBJ_FLAG, "10") == 0)
		{		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), g_szIndi_Vc);					//��� VC  
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), g_szIndi_Qty);					//��� ��뷮
	
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), stGm.BEFO_MM_INDI_COMPENS_VC_1);	//���� VC  
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), stGm.BEFO_MM_USE_QTY_1);			//���� ��뷮
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), g_szIndi_Vc);					//��� VC  
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USE), "VA");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USECAL), "VM");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), g_szIndi_Va);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), g_szIndi_Vm);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), stGm.BEFO_MM_INDI_COMPENS_VA_1);					//��� VC  
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), stGm.BEFO_MM_INDI_MTR_1);					//��� ��뷮
	
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), stGm.BEFO_MM_INDI_COMPENS_VC_1);	//���� VC  
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), stGm.BEFO_MM_USE_QTY_1);			//���� ��뷮
			
		}
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		g_Str_DateType(sztmp , stGm.CONT_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), sztmp);					//���� �������
	}
	
	
	void Rcv_paymant(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
	char szSql[300];
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24233, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "req_ym",         stGm.REQ_YM );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",  stGm.DEADLINE_FLAG );
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",        stGm.MTR_NUM );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",   stGm.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_apply_ymd", stGm.GMTR_APPLY_YMD );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_ItoA( Time_GetDate() ,sztmp , 10);
		JSON_SetValue( g_pjcomm, 'C', "today",        sztmp   );
		JSON_SetValue( g_pjcomm, 'C', "vc", g_szIndi_Vc );


		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR24233; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR24233_IN",  "FR24233" , sndbuf, sztmp );
	}
	
	long TR24233(void)
	{
		if(g_Chk_Json(24233) >= 0)
		{	
			Rcv24234();
			return 1;
		}
		else
		{
			CloseMessageBox();
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rcv24234(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24234, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",      g_szMTR_NUM);

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR24234; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR24234_IN",  "FR24234" , sndbuf, sztmp );
	}
	
	long TR24234(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(24234) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "��ݰ���� �Ϸ��Ͽ����ϴ�.");
			ON_DRAW();
			Set_Paymant();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	void Set_Paymant(void)
	{
	char szJsonpath[128];
	char *szcode;
	char sztmp[50];
	char sztmp2[50];
	long i, len;
	char szType[2];
	
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			return;
		}
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 24233, 0 );

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode = JSON_GetValue (g_pjcomm, "pay_amt", szType);
		
			Mem_Set((byte*) sztmp2, 0x00, sizeof( sztmp2) );
			Str_Cpy( sztmp2,szcode );
			len = Str_Len(sztmp2);
			for(i = 0 ; i < len ; i++ )
			{
				if( sztmp2[i] =='|' )
				{
					Mem_Set((byte*) sztmp, 0x00, sizeof( sztmp) );
					Mem_Cpy( (byte*)sztmp, (byte*)sztmp2, i );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), sztmp);
					
					Mem_Set((byte*) sztmp, 0x00, sizeof( sztmp) );
					Mem_Cpy( (byte*)sztmp, (byte*)sztmp2+i+1, len-(i+1) );
					//Str_Chg( sztmp, STRCHG_INS_COMMA);
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), sztmp);
					
				}
			}
		}
		
		JSON_Finalize(g_pjcomm);
		g_pjcomm = NULL;
		
		if(Str_Cmp(stGm.GMTR_OBJ_FLAG, "10") == 0)
		{
			g_pjcomm = JSON_Create( JSON_Object );
			if(g_pjcomm == NULL)
			{
				return;
			}
			
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 24234, 0 );
	
			if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
			{
				szcode = JSON_GetValue (g_pjcomm, "tot_ener_qty", szType);
	
				Mem_Set((byte*) sztmp, 0x00, sizeof( sztmp) );
				Str_Cpy( sztmp,szcode );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), sztmp);
			}
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		ON_DRAW();
	}
	
}


