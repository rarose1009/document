/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_USEDOC_SEND
	Card Desc : ����� ����༭ MMS �߼�
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_USEDOC_SEND
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
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		// ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		// Ȩ
		DEF_BUTTON_ID ( BID_MENU )		// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	// �������
		DEF_BUTTON_ID ( BID_PREV )		// ����
		DEF_BUTTON_ID ( BID_EXIT )		// ����
		
		// ȭ�� ��ü
		DEF_BUTTON_ID (BID_CLOSE)		// �ݱ�
		DEF_BUTTON_ID (BID_SEND)		// �߼�		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )	//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( TTL_PHONE_NUM )	// TTL ��ȭ��ȣ
		DEF_OBJECT_ID ( TXT_PHONE_EXN )	// TXT ��ȭ��ȣ EXN
		DEF_OBJECT_ID ( EDT_PHONE_EXN )	// EDT ��ȭ��ȣ EXN
		DEF_OBJECT_ID ( TXT_PHONE_NUM )	// TXT ��ȭ��ȣ NUM
		DEF_OBJECT_ID ( EDT_PHONE_NUM )	// EDT ��ȭ��ȣ NUM
		
		//������ ����
		DEF_OBJECT_ID ( TXT_KEY_ONE )
		DEF_OBJECT_ID ( TXT_KEY_TWO )
		DEF_OBJECT_ID ( TXT_KEY_THREE )
		DEF_OBJECT_ID ( TXT_KEY_FOUR )
		DEF_OBJECT_ID ( TXT_KEY_FIVE )
		DEF_OBJECT_ID ( TXT_KEY_SIX )
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )
		DEF_OBJECT_ID ( TXT_KEY_NINE )
		DEF_OBJECT_ID ( TXT_KEY_ZERO )
		DEF_OBJECT_ID ( TXT_KEY_DEL )
		
		DEF_OBJECT_ID ( CMB_PHONE_DDD )	// ��ȭ��ȣ COMBO_DDD	
	END_OBJECT_ID()
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN 1
	
	//---------------------------------------------------------------
	// Param
	//---------------------------------------------------------------
	long m_bFirst;
	
	char m_szUse_cont_num[20];
	char m_szCont_sts_cd[5];
	char m_szCust_num[20];
	char m_szCust_nm[20];
	char m_szCp_DDD[5];
	char m_szCp_EXN[5];
	char m_szCp_NUM[5];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void SetCombo(void);
	void ReDraw(void);
	void Snd_GetContDocInfo(void);
	long Rcv_GetContDocInfo(void);
	long Chk_Json_62603(void);
	void SetBack(void);
	long Rcv_62602(void);
	long TR62602(void);
	
	//---------------------------------------------------------------
	// ��� ��ư
	//---------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] =
	 {
		  SYS_BUT_IMG (  BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME    , 0),
		  SYS_BUT_IMG (  BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0),
		  SYS_BUT_IMG (  BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN  , 0),
		  SYS_BUT_IMG (  BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK  , 0),
		  SYS_BUT_IMG (  BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT  , 0),
		  SYS_BUT_IMG (  BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0),
		  SYS_BUT_IMG (  BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0),
	 };
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		// Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����� ����༭ �߼�"),
		
		DLG_TEXT ( STARTX,	   STARTY+65 , 320, 63, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK  , TTL_PHONE_NUM, "�ڵ�����ȣ"),
		DLG_TEXT ( STARTX+580, STARTY+65 ,  40, 63, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK, TXT_PHONE_EXN, "-"),
		DLG_EDIT ( STARTX+620, STARTY+65 , 170, 63, 0, 0,    EDITSTY_BOLD               , EDITSTY_BORDER, TXTFRCOLOR , PDAEDTCTRLBK , EDT_PHONE_EXN, 4, ""),
		DLG_TEXT ( STARTX+790, STARTY+65 ,  40, 63, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK, TXT_PHONE_NUM, "-"),
		DLG_EDIT ( STARTX+830, STARTY+65 , 170, 63, 0, 0,    EDITSTY_BOLD               , EDITSTY_BORDER, TXTFRCOLOR , PDAEDTCTRLBK , EDT_PHONE_NUM, 4, ""),
		
		DLG_BUTTON(STARTX,	   STARTY+200, 500, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�ݱ�"),
		DLG_BUTTON(STARTX+500, STARTY+200, 500, 65, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND , "�߼�"),	
		
		DLG_COMBO( STARTX+320, STARTY+65 , 260, 63, 100, 63, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_PHONE_DDD, 5), // ��ȭ��ȣ DDD �޺��ڽ�
		
		//���� ����
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "��"),
	};	
	
	//---------------------------------------------------------------
	// main
	//---------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// OnInit Function
	//---------------------------------------------------------------	
	void OnInit( char bFirst )
	{
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
								
				// ȭ�� ���� ���� �� ����ϻ���༭ ���� ������
				Snd_GetContDocInfo();
				
				break;
		}
	}

	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
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
	�Լ��� : SetStyle
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_PHONE_NUM), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PHONE_DDD), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
	
		// ������
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
			
	}
		
	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		// ��ȭ��ȣ
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_PHONE_DDD+2);
	}
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
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
			/********************************************/
			/* ���� ��ư                                */
			/********************************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
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
				SetBack();
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/********************************************/
			/* �Ϲ� ��ư                                */
			/********************************************/
			case BID_CLOSE:
				SetBack();
				break;
			
			case BID_SEND:
				if(MessageBoxEx (CONFIRM_YESNO, "���Բ� ����༭��\n�߼��Ͻðڽ��ϱ�?") == MB_OK)
				{
					PRINT("@ CMB_PHONE_DDD : %s",EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD)),0,0);
					PRINT("@ EDT_PHONE_EXN : %s",EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)),0,0);
					PRINT("@ EDT_PHONE_NUM : %s",EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)),0,0);
					
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Str_Cpy( sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD)) );
					Str_Cat( sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)) );
					Str_Cat( sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)) );
					
					// ��ȭ��ȣ Ȯ�� üũ ����
					if( g_CheckPhoneNumber("1", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)))
				     && Str_Len( sztmp ) > 0 )
					{
						Rcv_62602();
					}
					else
					{
						MessageBoxEx (ERROR_OK, "�������� ��ȣ�� �ƴմϴ�.");	
					}
				}
				
				break;
		}
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
		
		if( m_bFirst == INIT_MAIN )
		{	
			if( POINTING_UP == nAction )
			{	
				/****************************************/
				/* ���� Ű����                          */
				/****************************************/
				if( X > DMS_X(STARTX+620) && X < DMS_X(STARTX+790)  && Y > DMS_Y(STARTY+65) && Y < DMS_Y(STARTY+128) 
				 || X > DMS_X(STARTX+830) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+65) && Y < DMS_Y(STARTY+128) )
				{	
					if( Get_iDlgCtrlByID(EDT_PHONE_EXN) == lActiveIndex || Get_iDlgCtrlByID(EDT_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
					}
				}
				else
				{	
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{	
						g_Dlgflag = 1;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
					}
				}	
			}
		}
		
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : ReDraw
	��  �� : ȭ���� �ٽ� �׸���.
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{	
		// ��ȭ��ȣ
		if(Str_Len(m_szCp_DDD) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD),  m_szCp_DDD);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PHONE_DDD), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PHONE_DDD), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PHONE_DDD+1), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PHONE_DDD+1), TRUE );
		}
		
		if(Str_Len(m_szCp_EXN) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN),  m_szCp_EXN);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_PHONE_EXN), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_PHONE_EXN), TRUE );
		}
		
		if(Str_Len(m_szCp_NUM) == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM), "");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM),  m_szCp_NUM);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(EDT_PHONE_NUM), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_PHONE_NUM), TRUE );
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Snd_GetContDocInfo
	��  �� : FR62603 ��ġ ��� ��ȣ�� ����ϻ���༭ �����͸� �����´�.
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_GetContDocInfo(void)
	{
		char sztmp[128];
		char szUrl[200];
		char szbuf[128];
		char szMsg[50];
		char* sndbuf;
		
		long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62603, TRUE);
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  g_szInstPlaceNum );
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		Str_Cpy(szbuf, "FR62603.JSON");
		
		//��ſϷ� �Ŀ� ȣ�� �Լ�
		callBackfunc = Rcv_GetContDocInfo;
		HTTP_Url2File("POST", szUrl, sndbuf, szbuf);
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_GetContDocInfo
	��  �� : FR62603 Callback
	Param  :  
	Return : 1 = ����, -1 = ������
	========================================================================================*/
	long Rcv_GetContDocInfo(void)
	{
		long ret = 0;
		
		g_Sock_Close();
		
		ret = Chk_Json_62603();

		if( ret >= 0)
		{
			if( Str_Cmp( m_szCont_sts_cd, "30" ) == 0 )
			{
				MessageBoxEx( ERROR_OK, "������ ����� �߼� �� �� �����ϴ�." );
				SetBack();
			}
			else
			{
				/*
				PRINT("@ m_szUse_cont_num : %s",m_szUse_cont_num,0,0);
				PRINT("@ m_szCont_sts_cd : %s",m_szCont_sts_cd,0,0);
				PRINT("@ m_szCust_num : %s",m_szCust_num,0,0);
				PRINT("@ m_szCust_nm : %s",m_szCust_nm,0,0);
				PRINT("@ m_szCp_DDD : %s",m_szCp_DDD,0,0);
				PRINT("@ m_szCp_EXN : %s",m_szCp_EXN,0,0);
				PRINT("@ m_szCp_NUM : %s",m_szCp_NUM,0,0);
				*/
				
				ReDraw();		
			}
			
			return 1;
		}
		else
		{
			SetBack();
			ON_DRAW();
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Chk_Json_62603
	��  �� : ���� ��� ������ ���� �� ������ ����
	Param  :  
	Return : 1:�������� ��ſϷ�, 0: ��������or�������Ŀ���, -1: �˼����� ����
	========================================================================================*/
	long Chk_Json_62603(void)
	{
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		long nCnt = 0;
		long ret = 11;
		
		char szJsonpath[500];
		char szMsg[500];
		char *pStr = NULL;
		char *szcode = NULL;
		char *szmessage = NULL;
		char *szcnt = NULL;
		char szType[2] = {0,0};
		
		handle hitem = NULL;
		handle hcnt = NULL;

		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 62603, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 62603, 0 );
		}

		fsize = FFS_GetSize(szJsonpath);

		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		
		pStr = Mem_Alloc(fsize);
		
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
			{
				break;
			}
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
		
		/***********************************************/
		/* ��� LOAD                                   */
		/***********************************************/
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);
			
			if( Str_Cmp(szcode, "0000") != 0)
			{
			  	char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
				{
					SQL_ConvMbStr( szMsg, szmessage);
				}
				
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				EvtDraw();
				ret = -1;
			}
			else
			{	
				/***********************************************/
				/* ��� Str_Cpy                                */
				/***********************************************/
				// 1. ������ȣ
				Mem_Set((byte*)m_szUse_cont_num, 0x00, sizeof(m_szUse_cont_num));	
				Str_Cpy( m_szUse_cont_num, JSON_GetValue(g_pjcomm, "use_cont_num", szType) );
				
				// 2. ��������
				Mem_Set((byte*)m_szCont_sts_cd, 0x00, sizeof(m_szCont_sts_cd));	
				Str_Cpy( m_szCont_sts_cd, JSON_GetValue(g_pjcomm, "cont_sts_cd", szType) );	
				
				// 3. ����ȣ
				Mem_Set((byte*)m_szCust_num, 0x00, sizeof(m_szCust_num));	
				Str_Cpy( m_szCust_num, JSON_GetValue(g_pjcomm, "cust_num", szType) );	
				
				// 4. ����
				Mem_Set((byte*)m_szCust_nm, 0x00, sizeof(m_szCust_nm));	
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				SQL_ConvMbStr( szMsg, JSON_GetValue(g_pjcomm, "cust_nm", szType));
				Str_Cpy( m_szCust_nm, szMsg );	
				
				// 5. �޴���_�ĺ���ȣ 
				Mem_Set((byte*)m_szCp_DDD, 0x00, sizeof(m_szCp_DDD));
				if( Str_Cmp(JSON_GetValue(g_pjcomm, "cp_ddd", szType), "null") == 0 )
				{
					Str_Cpy( m_szCp_DDD, "" );
				}
				else
				{
					Str_Cpy( m_szCp_DDD, JSON_GetValue(g_pjcomm, "cp_ddd", szType) );
				}
				
				// 6. �޴���_���� 
				Mem_Set((byte*)m_szCp_EXN, 0x00, sizeof(m_szCp_EXN));
				if( Str_Cmp(JSON_GetValue(g_pjcomm, "cp_exn", szType), "null") == 0 )
				{
					Str_Cpy( m_szCp_EXN, "" );
				}
				else
				{
					Str_Cpy( m_szCp_EXN, JSON_GetValue(g_pjcomm, "cp_exn", szType) );
				}
				
				// 7. �޴���_��ȣ
				Mem_Set((byte*)m_szCp_NUM, 0x00, sizeof(m_szCp_NUM));
				if( Str_Cmp(JSON_GetValue(g_pjcomm, "cp_num", szType), "null") == 0 )
				{
					Str_Cpy( m_szCp_NUM, "" );
				}
				else
				{
					Str_Cpy( m_szCp_NUM, JSON_GetValue(g_pjcomm, "cp_num", szType) );
				}	
			}
		}
		else
		{
			ret = 0;
		}
		
Finally:
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_Close_SubDlg();
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_62602
	��  �� : ����༭ �߼�, FR62602
	Param  :  
	Return : 
	========================================================================================*/
	long Rcv_62602(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62602, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"  , m_szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "cust_num"      , m_szCust_num     );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd"        , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PHONE_DDD)) );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn"        , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_EXN)) );
		JSON_SetValue( g_pjcomm, 'C', "cp_num"        , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PHONE_NUM)) );
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SQL_ConvUcStr( szbuf, m_szCust_nm );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm"       , szbuf            );
		
		JSON_SetValue( g_pjcomm, 'C', "recommender_id", stUserinfo.szRecommender_id );
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR62602; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR62602_IN",  "FR62602" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	�Լ��� : TR62602
	��  �� : Rcv_62602 Callback
	Param  :  
	Return : 
	========================================================================================*/
	long TR62602(void)
	{
		if( g_Chk_Json(62602) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "����༭ MMS�߼۽�û�� �Ϸ��Ͽ����ϴ�.");
			SetBack();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetBack
	��  �� : ���� ��ο� ���� �ڷ� ���ư�
	Param  : 
	Return : 
	========================================================================================*/
	void SetBack(void)
	{
		/*********************************/
		/* g_lCmContDocMoveFlag          */
		/* 0 = �ο�                      */
		/* 1 = ��������                  */
		/* 2 = ��ħ                      */
		/* 3 = �跮�ⱳü                */
		/*********************************/
		
		if( g_lCmContDocMoveFlag == 0 ) 
		{
			Card_Move("C6101_WINFO");
		}
		else if ( g_lCmContDocMoveFlag == 1 )
		{
			Card_Move("SC_CONFIRM");
		}
		else if ( g_lCmContDocMoveFlag == 2 )
		{
			Card_Move("GM_CUSTINFO");
		}
		else if ( g_lCmContDocMoveFlag == 3 )
		{
			Card_Move("C6301_CUSTINFO");
		}
	}
}


