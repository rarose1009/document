/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_CUSTINFO
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		//����
		DEF_BUTTON_ID ( BID_USEDOC )	//����༭
		DEF_BUTTON_ID ( BID_USEDOC_SMS) //����༭ �߼�
		DEF_BUTTON_ID ( BID_BIZ )		//����ڵ����
		DEF_BUTTON_ID ( BID_OK )		//Ȯ��
		DEF_BUTTON_ID ( BID_HOUSETEL )	//������ȭ
		DEF_BUTTON_ID ( BID_PHONETEL )	//������ȭ
		DEF_BUTTON_ID ( BID_WRITE )		// ����ġ
		DEF_BUTTON_ID ( BID_SAVE )		// ����ġ ����
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
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		DEF_OBJECT_ID ( TXT_DATA22 )
		DEF_OBJECT_ID ( TXT_DATA23 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ

		DEF_OBJECT_ID ( EDT_DATA1 )			// ��ġ����_3
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	long m_lActiveIndex = -1;
	char m_szTmp[300];
	char m_szSql[1100];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void REDRAW(void);
	void Delete_Photo(void);
	void Snd_DetaLoc(void);

	long TR75111(void);
	long Rcv_62602(void);
	long TR62602(void);
	void SAVE_DetaLoc(void);   // ����ġ�� �����Ѵ�.
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 );
	void Call_Tel(char* num);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�� ����"),
		
		DLG_TEXT(STARTX, 	 STARTY+65 , 250, 75 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA1, "����ȣ"),
		DLG_TEXT(STARTX+250, STARTY+65 , 750, 75 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,	 STARTY+140, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA3, "����"),
		DLG_TEXT(STARTX+250, STARTY+140, 750, 70 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,	 STARTY+210, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA5, "��ȣ"),
		DLG_TEXT(STARTX+250, STARTY+210, 750, 70 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT(STARTX,	 STARTY+280, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA10, "�����"),
		DLG_TEXT(STARTX+250, STARTY+280, 750, 70 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA11, ""),
		
		DLG_BUTTON(STARTX,	 STARTY+350, 250, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_ADDR, "����\n�ּ�"),
		DLG_TEXT(STARTX+250, STARTY+350, 750, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA12, ""),
		
		DLG_TEXT(STARTX, 	 STARTY+450, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA13, "������ȭ"),
		DLG_TEXT(STARTX+250, STARTY+450, 500, 70 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA14, ""),
		DLG_BUTTON(STARTX+750, STARTY+450, 250, 70 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_HOUSETEL, "��ȭ�ɱ�"),
		
		DLG_TEXT(STARTX,	 STARTY+520, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA15, "������ȭ"),
		DLG_TEXT(STARTX+250, STARTY+520, 750, 70 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA16, ""),
		DLG_BUTTON(STARTX+750, STARTY+520, 250, 70 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_PHONETEL, "��ȭ�ɱ�"),
		
		
		DLG_TEXT(STARTX, 	 STARTY+590, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA17, "�����"),
		DLG_TEXT(STARTX+250, STARTY+590, 750, 70 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX,	 STARTY+660, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA19, "�����"),
		DLG_TEXT(STARTX+250, STARTY+660, 750, 70 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX,	 STARTY+730, 250, 70 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA22, "����ġ"),
		DLG_BUTTON(STARTX+250, STARTY+730, 600,  70,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT ( STARTX+250, STARTY+730, 600,  70,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1,  ""),
		DLG_BUTTON(STARTX+840, STARTY+730, 160,  70 ,  0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SAVE, "����"),
		
		DLG_BUTTON(STARTX,     STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_USEDOC    , "���\n��༭"),
		DLG_BUTTON(STARTX+250, STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_USEDOC_SMS, "��༭\n�߼�"),
		DLG_BUTTON(STARTX+500, STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_BIZ       , "�����\n�����"),
		DLG_BUTTON(STARTX+750, STARTY+819, 250, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_OK        , "Ȯ ��"),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,		STARTY+280, 250, 110, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		//DLG_BUTTON(STARTX,     STARTY+760, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_USEDOC, "����༭"),
		DLG_BUTTON(STARTX,		STARTY+799, 500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BIZ, "�����\n�����"),
		DLG_BUTTON(STARTX+500,	STARTY+799, 500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX, 	  STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "����ȣ"),
		DLG_TEXT(STARTX+250,  STARTY-40, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,	  STARTY+40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "����"),
		DLG_TEXT(STARTX+250,  STARTY+40, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,	 STARTY+120, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "��ȣ"),
		DLG_TEXT(STARTX+250, STARTY+120, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,	 STARTY+200, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "�����"),
		DLG_TEXT(STARTX+250, STARTY+200, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+250, STARTY+280, 750, 110, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX, 	 STARTY+390, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, "������ȭ"),
		DLG_TEXT(STARTX+250, STARTY+390, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX,	 STARTY+470, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, "������ȭ"),
		DLG_TEXT(STARTX+250, STARTY+470, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX, 	 STARTY+550, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, "�����"),
		DLG_TEXT(STARTX+250, STARTY+550, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX,	 STARTY+630, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "�����"),
		DLG_TEXT(STARTX+250, STARTY+630, 750, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
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
				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				REDRAW();
				break;
		}
	}

//-----------------------------------------------------------------
void	SetStyle(void)
{
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);

	EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA12), TRUE, 2, EDITSEP_NONE );
	EditCtrl_ModifyStyle( Get_hDlgCtrlByID(TXT_DATA9), 0, EDITSTY_HIDDEN);
	
	// 2018.05.24 CS�� ��̿� ����� SMS �߼� ��ư ���� ��û
	//DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_USEDOC_SMS), FALSE );
	// 2018.12.03 CS�� ��̿� ����� SMS �߼� ��ư �ٽ� �츲
	DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_USEDOC_SMS), TRUE );
	
	
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


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szTmp[20];
		char szMsg[100];
		switch(ID)
		{					
			case BID_ADDR:
				//g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�\n�ּ�");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����\n�ּ�");
				}
				REDRAW();
				break;
			case BID_USEDOC:
				//Card_Move("CM_USEDOC");
				g_lMobile_Inflow_Path = 4;
				Card_Move("CM_MOBILE_USE_DOC_MENU");
				break;
			case BID_USEDOC_SMS:
				/*
				if( MessageBoxEx (CONFIRM_YESNO, "���Բ� ����༭��\n�߼��Ͻðڽ��ϱ�?") == MB_OK)
				{
					Rcv_62602();
				}
				*/
				g_lCmContDocMoveFlag = 3;
				Mem_Set((byte*)g_szInstPlaceNum, 0x00, sizeof(g_szInstPlaceNum));
				Str_Cpy( g_szInstPlaceNum, stMtrChg.INST_PLACE_NUM );
				Card_Move("CM_USEDOC_SEND");
				break;
			case BID_BIZ:
				Card_Move("CM_BIZ");
				break;
			case BID_OK:
				//g_lChgMtr_WorkFlag > = 0 ������ �跮��, = 1 ��뷮 �跮��, = 2 ������
				if( g_lChgMtr_WorkFlag == 0 )
				{
					Card_Move("C6301_MTRCHG");
				}
				else if( g_lChgMtr_WorkFlag == 1 )
				{
					Card_Move("C6301_BIGCHG");
				}
				else if( g_lChgMtr_WorkFlag == 2 )
				{
					Card_Move("C6301_BOJUNGCHG");
				}
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_Del_GcPhoto();
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "�跮�ⱳü �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_Del_GcPhoto();
					Card_Move("C6301_MENU");
				}
				break;
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
			case GID_SCREEN:
				g_MOVE_DLG(300);
				break;
			case GID_CMMNWK:
				break;				
			case GID_PREV:
				//g_lChgMtr_WorkFlag > = 0 ������ �跮��, = 1 ��뷮 �跮��, = 2 ������
				if( g_lChgMtr_WorkFlag == 0 )
				{
					Card_Move("C6301_MTRCHG");
				}
				else if( g_lChgMtr_WorkFlag == 1 )
				{
					Card_Move("C6301_BIGCHG");
				}
				else if( g_lChgMtr_WorkFlag == 2 )
				{
					Card_Move("C6301_BOJUNGCHG");
				}
				break;	
			case GID_VMEXIT:
				g_Exit_DelGcData();
				break;
			
			case BID_HOUSETEL:
				
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, stMtrChg.OWNHOUSE_TEL_DDD);
				Str_Cat(szTmp, stMtrChg.OWNHOUSE_TEL_EXN);
				Str_Cat(szTmp, stMtrChg.OWNHOUSE_TEL_NUM);
				
				SPRINT(szMsg, "%s ���Բ�\n��ȭ�Ͻðڽ��ϱ�?\n(TEL : %s)", stMtrChg.CUST_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA14)), 0);	
				if( MessageBoxEx(CONFIRM_YESNO, szMsg) == MB_OK)
				{
					Call_Tel(szTmp);
				}
				
				break;
			case BID_PHONETEL:
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, stMtrChg.CP_DDD);
				Str_Cat(szTmp, stMtrChg.CP_EXN);
				Str_Cat(szTmp, stMtrChg.CP_NUM);
				
				SPRINT(szMsg, "%s ���Բ�\n��ȭ�Ͻðڽ��ϱ�?\n(HP : %s)", stMtrChg.CUST_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA16)), 0);	
				if( MessageBoxEx(CONFIRM_YESNO, szMsg) == MB_OK)
				{
					Call_Tel(szTmp);
				}
				
				break;

			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;			


			case BID_SAVE:

				Snd_DetaLoc();

			 	break;		
		}
	}
	
//--------------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i;
		long lAddr = 0;
		char szNum[13];
		char szTmp[100];
		char szBuf[100];
		
		//����ȣ
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Cpy((byte *)szTmp, (byte *)stMtrChg.CUST_NUM, 5);
		Str_Cat(szTmp, "-");
		Mem_Cpy((byte *)szBuf, (byte *)stMtrChg.CUST_NUM+5, 5);
		Str_Cat(szTmp, szBuf);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szTmp );
		
		//����
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stMtrChg.CUST_NM );
		
		//��ȣ
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), stMtrChg.FIRM_NM );
		
		//�����
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), stMtrChg.FIRM_NM );
		PRINT("55555555555555555 :%s",stMtrChg.MTR_DETA_LOC,0,0);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stMtrChg.MTR_DETA_LOC);	

		if( g_lChgMtr_WorkFlag == 1 || g_lChgMtr_WorkFlag == 2)
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), TRUE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), TRUE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
		}
		else
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_WRITE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );

		}
		
		//�ּ�
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		if( g_nAddrFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����\n�ּ�");
			
			if( (Str_Len(stMtrChg.CO_LIVE_NM) + Str_Len(stMtrChg.BLD_NM)) == 0 )
			{
				Str_Cpy( m_szTmp, stMtrChg.TOWN);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.VILLAGE);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_M);
				Str_Cat( m_szTmp, "-");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_S);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.HOUSE_CNT);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.LOT_NUM_SECOND_ADDR);
			}
			else
			{
				Str_Cpy( m_szTmp, stMtrChg.TOWN);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.VILLAGE);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_M);
				Str_Cat( m_szTmp, "-");
				Str_Cat( m_szTmp, stMtrChg.ADDR1_S);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.CO_LIVE_NM);
				Str_Cat( m_szTmp, " ");
				Str_Cat( m_szTmp, stMtrChg.BLD_NM);
				Str_Cat( m_szTmp, "-");
				Str_Cat( m_szTmp, stMtrChg.HOUSE_CNT);
			}
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�\n�ּ�");
			
			Str_Cpy( m_szTmp, stMtrChg.NEW_ROAD_NM);
			Str_Cat( m_szTmp, " ");
			Str_Cat( m_szTmp, stMtrChg.NEW_ADDR_M);
			Str_Cat( m_szTmp, "-");
			Str_Cat( m_szTmp, stMtrChg.NEW_ADDR_S);
			Str_Cat( m_szTmp, " ");
			Str_Cat( m_szTmp, stMtrChg.HOUSE_CNT);
			Str_Cat( m_szTmp, " ");
			Str_Cat( m_szTmp, stMtrChg.LOT_NUM_SECOND_ADDR);
		}
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), m_szTmp);

		//������ȭ
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		Str_Cat(m_szTmp, stMtrChg.OWNHOUSE_TEL_DDD);
		Str_Cat(m_szTmp, "-");
		Str_Cat(m_szTmp, stMtrChg.OWNHOUSE_TEL_EXN);
		Str_Cat(m_szTmp, "-");
		Str_Cat(m_szTmp, stMtrChg.OWNHOUSE_TEL_NUM);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), m_szTmp);
		
		//������ȭ
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		Str_Cat(m_szTmp, stMtrChg.CP_DDD);
		Str_Cat(m_szTmp, "-");
		Str_Cat(m_szTmp, stMtrChg.CP_EXN);
		Str_Cat(m_szTmp, "-");
		Str_Cat(m_szTmp, stMtrChg.CP_NUM);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), m_szTmp);
		
		//������ȣ
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Cpy((byte *)szTmp, (byte *)stMtrChg.USE_CONT_NUM, 5);
		Str_Cat(szTmp, "-");
		Mem_Cpy((byte *)szBuf, (byte *)stMtrChg.USE_CONT_NUM+5, 5);
		Str_Cat(szTmp, szBuf);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), szTmp);

		//�����
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		g_Str_DateType(m_szTmp, stMtrChg.CONT_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), m_szTmp);
		
		//������ȭ ��ư Ȱ��ȭ
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stMtrChg.OWNHOUSE_TEL_DDD);
		Str_Cat(szTmp, stMtrChg.OWNHOUSE_TEL_EXN);
		Str_Cat(szTmp, stMtrChg.OWNHOUSE_TEL_NUM);
		if( Str_Len( szTmp ) > 0 )
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HOUSETEL), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HOUSETEL), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HOUSETEL), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HOUSETEL), TRUE );
		}
		
		//������ȭ ��ư Ȱ��ȭ
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stMtrChg.CP_DDD);
		Str_Cat(szTmp, stMtrChg.CP_EXN);
		Str_Cat(szTmp, stMtrChg.CP_NUM);
		if( Str_Len( szTmp ) > 0 )
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHONETEL), TRUE );
		}
	}
	
//----------------------------------------------------------------------------------------------	
//�Կ��� ���� ����
	void Delete_Photo(void)
	{
		char *pCamera;
		char szFullpath[256];
		char szfilenm[100];
		long nRet;

		if( Str_Cmp(stMtrChg.SEND_YN, "S") != 0 && Str_Cmp(stMtrChg.SEND_YN, "Y") != 0 )
		{
			if( g_nPhotoFlag == 7 )
			{
				//ö���� �跮��
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "MBM");
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
				
				Sleep(50);
		
				//��ġ�� �跮��
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "MAM");				
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
			}
			else if( g_nPhotoFlag == 8 )
			{
				//ö���� ������
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "CBM");
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
				
				Sleep(50);
		
				//��ġ�� ������
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "CAM");				
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stMtrChg.MTR_NUM);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
			}
		}
		
		return;
	}
//-----------------------------------------------------------------------
	long Rcv_62602(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szbuf[128];
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char* sndbuf;
		long ret = 0;

		Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
		Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
		Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
		Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
		Str_Cpy(szPhoneNum, stMtrChg.CP_DDD);
		Str_Cat(szPhoneNum, stMtrChg.CP_EXN);
		Str_Cat(szPhoneNum, stMtrChg.CP_NUM);
		ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
		if( ret < 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ȭ��ȣ�� Ȯ�����ּ���.");
			return 0;
		}

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62602, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMtrChg.USE_CONT_NUM);
		JSON_SetValue( g_pjcomm, 'C', "cust_num", stMtrChg.CUST_NUM);
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd", stMtrChg.CP_DDD);
		JSON_SetValue( g_pjcomm, 'C', "cp_exn", stMtrChg.CP_EXN);
		JSON_SetValue( g_pjcomm, 'C', "cp_num", stMtrChg.CP_NUM);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SQL_ConvUcStr( szbuf, stMtrChg.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm", szbuf);
				
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR62602; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR62602_IN",  "FR62602" , sndbuf, sztmp );
		return 0 ;
	}
	
//-----------------------------------------------------------------------
	long TR62602(void)
	{
		if( g_Chk_Json(62602) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "����༭ MMS�߼۽�û�� �Ϸ��Ͽ����ϴ�.");
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

	//---------------------------------------------------------------------------------------------
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 )
	{
	long len;
	
		Str_Chg(phone, STRCHG_DEL_NONDIGIT );
		len = Str_Len(phone);
		
		if( len == 9 )
		{
			Mem_Cpy( (byte*)num1, (byte*)phone,  2);
			Mem_Cpy( (byte*)num2, (byte*)phone+2,  3);
			Mem_Cpy( (byte*)num3, (byte*)phone+5,  4);
		}
		else if( len == 10 )
		{
			if( Mem_Cmp((byte*)phone, (byte*)"01", 2) == 0  )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else if(  Mem_Cmp((byte*)phone, (byte*)"02", 2) == 0 )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  2);
				Mem_Cpy( (byte*)num2, (byte*)phone+2,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
		}
		else if( len == 11 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+7,  4);
		}
		else if( len == 12 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  4);
				Mem_Cpy( (byte*)num2, (byte*)phone+4,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+8,  4);
		}
		else
		{
			return -1;
		}
		
		return 1;
	}
	
	void Call_Tel(char* num)
	{
		char szNum[15];
		
		Mem_Set( (byte*)szNum, 0x00, sizeof(szNum) );
		Str_Cpy( szNum, num );
		
		if( Str_Len(szNum) > 8 )
		{
			Tapi_MakeCall((byte*)szNum);
		}
	}

	void Snd_DetaLoc(void)
	{
		char szUrl[200];
		char szbuf[128];
		char szDetaloc[301];
		char szUDetaloc[601];
		char* sndbuf;
		long ret = 0;
	
		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		Mem_Set((byte*)szDetaloc, 0x00, sizeof(szDetaloc));		
		Mem_Set((byte*)szUDetaloc, 0x00, sizeof(szUDetaloc));		
		Str_Cpy(szDetaloc ,EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}

		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75111, FALSE);
	
		// JSON_SetValue( g_pjcomm, 'C', "mtr_num",   g_szMTR_NUM );
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",   stMtrChg.MTR_NUM );
		
		SQL_ConvUcStr( szUDetaloc, szDetaloc );
		JSON_SetValue( g_pjcomm, 'C', "detaLoc", szUDetaloc );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR75111;
		ret = HTTP_DownloadData(szUrl, "FR75111_IN",  "FR75111" , sndbuf, szbuf );

		
		
		return;
	}
	/*=======================================================================================
	�Լ��� : TR75111
	��  �� : Callback FR75111
	Param  : 
	Return : 
	========================================================================================*/
	long TR75111(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(75111) >= 0)
		{
			CloseMessageBox();
			SAVE_DetaLoc();
			// g_nMemoFlag = 0;
			Card_Prev();
			return 1;
		}
		else
		{
			CloseMessageBox();
			return -1;
		}
	}

	void SAVE_DetaLoc(void)
	{
		char szSql[300];
		char szDetaloc[300];
		char szScout[200];
		char szTmp[500];
		long idx, ret;
		long nLen;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szDetaloc, 0x00, sizeof(szDetaloc)  );
		Str_Cpy(szDetaloc ,EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );

		hdb = sql->Open(sql);

		if( hdb == NULL )
		{
			goto Finally;
		}
		
		//�跮�ⱳü �޸�
		nLen = g_GetUtf8Size(szDetaloc);
		if( nLen > 60 )
		{
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT(szTmp, "�������!\n(�޸�� �ѱ� 20��,\n����.���� 100�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szTmp);
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE C6301_CHANGEDATA SET MTR_DETA_LOC =? WHERE MTR_NUM = '%s' "
		, g_szMTR_NUM, 0, 0);
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)szDetaloc		,200	,DECRYPT);
		
		
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			//�跮�ⱳü �޸�
			Str_Cpy(stMtrChg.MTR_DETA_LOC, szDetaloc);
			MessageBoxEx(CONFIRM_OK, "����ġ�� ����Ǿ����ϴ�.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		return;
	}

	/*=======================================================================================
	�Լ��� : OnPointing
	��  �� : ȭ�� ������ �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		m_lActiveIndex = lActiveIndex;
	
		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+600) && Y > DMS_Y(STARTY+291) && Y < DMS_Y(STARTY+371) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}				
				else
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
			}
		}
		
	}


}


