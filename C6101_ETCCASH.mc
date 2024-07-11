/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_ETCCARD
	Card Desc : �ο� ��Ÿ ī�� ����
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_ETCCASH
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

	#define USE_ON_TASK
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
	
		DEF_BUTTON_ID ( BID_APPRO )				// ī�����/���
		DEF_BUTTON_ID ( BID_CLOSE )				// �ݱ�
		
		DEF_BUTTON_ID ( BID_RAD_GUBUN_Y )
		DEF_BUTTON_ID ( BID_RAD_GUBUN_N )
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// ī�峻���� ���� ��Ʈ�� ���̵� ����
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
	
		/********************************/
		/* Ÿ��Ʋ        			    */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )				// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )			// Ÿ��Ʋ
		
		/********************************/
		/* ȭ��          			    */
		/********************************/
		DEF_OBJECT_ID ( TTL_RAD_GUBUN )			// TTL_�����߱޿���
		DEF_OBJECT_ID ( TXT_RAD_GUBUN  )      	// TXT_�����߱޿���
		
		DEF_OBJECT_ID ( TTL_CUSTINFO )			// TTL_�źе�Ϲ�ȣ
		
		DEF_OBJECT_ID ( TTL_GUBUN )				// TTL_�ŷ��ڱ���
		
		DEF_OBJECT_ID ( TTL_AMT )				// TTL_�ݾ�
		
		/********************************/
		/* ����                         */
		/********************************/
		// ������ ����
		DEF_OBJECT_ID ( TXT_KEY_ONE )			// 1
		DEF_OBJECT_ID ( TXT_KEY_TWO )			// 2
		DEF_OBJECT_ID ( TXT_KEY_THREE )			// 3 
		DEF_OBJECT_ID ( TXT_KEY_FOUR )			// 4
		DEF_OBJECT_ID ( TXT_KEY_FIVE )			// 5
		DEF_OBJECT_ID ( TXT_KEY_SIX )			// 6
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )			// 7
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )			// 8
		DEF_OBJECT_ID ( TXT_KEY_NINE )			// 9
		DEF_OBJECT_ID ( TXT_KEY_ZERO )			// 0
		DEF_OBJECT_ID ( TXT_KEY_DEL )			// <-
		DEF_OBJECT_ID ( TXT_KEY_EMPTY )			// ��ĭ
		
		/********************************/
		/* LINE                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA1 )			// ����1
		DEF_OBJECT_ID ( LINE_DATA2 )			// ����2
		DEF_OBJECT_ID ( LINE_DATA3 )			// ����3
		
		/********************************/
		/* EDIT                         */
		/********************************/
		DEF_OBJECT_ID ( EDT_AMT )				// EDT_�����ݾ�
		DEF_OBJECT_ID ( EDT_CUSTINFO )			// EDT_�źе�Ϲ�ȣ
		
		/********************************/
		/* COMBO                        */
		/********************************/
		DEF_OBJECT_ID ( CMB_GUBUN  )     		// CMB_�ŷ��ڱ���
		
	END_OBJECT_ID()

	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN		1
	#define CHK_Y1	   "�࿹"
	#define CHK_Y2	   "�ÿ�"
	#define CHK_N1	   "��ƴϿ�"
	#define CHK_N2	   "�þƴϿ�"
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lradgbn_flag;
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void SetCombo(void);
	void SetStyle(void);
	void Redraw(void);
	
	void Snd_CardHist_Pre(void);
	void Snd_CardHist_Rslt(void);
	
	void Snd_Cash_Mcpay(void);
	void Snd_Cash_Hist(long flag);
	
	long TR66806_0(void);
	long TR66806_1(void);
	long TR66806_2(void);
	
	void Run_Mcpay(long flag);
	void Rcv_CashData(char* szCashData);
	void Set_CashData(void);
	void Rcv_CashData_test(void);
	
	void Snd_CardHist_Pre(void);
	void Snd_CardHist_Rslt(void);
	
	long TR66707(void);
	long TR66708(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��Ÿ ���ݿ�����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE,  ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29, 400, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TTL_RAD_GUBUN, "�����߱޿���"),
		DLG_BUTTON(STARTX +400, STARTY  -29, 300, 70,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RAD_GUBUN_Y,  CHK_Y1),
		DLG_BUTTON(STARTX +700, STARTY  -29, 300, 70,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RAD_GUBUN_N,  CHK_N1),
		
		DLG_TEXT ( STARTX,      STARTY  +41, 400, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GUBUN, "�ŷ��ڱ���"),
		DLG_COMBO( STARTX +400, STARTY  +41, 600, 70, 140, 70,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GUBUN, 10),
		
		DLG_TEXT ( STARTX,      STARTY +111, 400, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUSTINFO, "�źе�Ϲ�ȣ"),
		DLG_EDIT ( STARTX +400, STARTY +111, 600, 70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CUSTINFO, 20, ""),
		
		DLG_LINE ( STARTX,      STARTY +185, 1000, STARTY+185,    DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT ( STARTX,      STARTY +190, 400, 70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TTL_AMT, "�ŷ��ݾ�"),
		DLG_EDIT ( STARTX +400, STARTY +190, 600, 70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_AMT, 20, ""),
		
		DLG_LINE ( STARTX,      STARTY +264, 1000, STARTY+264,    DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_BUTTON(STARTX,      STARTY +269, 500, 75,   0,  0, 0, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_APPRO, "�� ��"),
		DLG_BUTTON(STARTX +500, STARTY +269, 500, 75,   0,  0, 0, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�ڷΰ���"),
		
		//���� ����
		DLG_LINE(STARTX, STARTY +535, 1000, STARTY+535, DARKSLATEBLUE, 10, LINE_DATA3),
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY, ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "��"),
	};

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
		CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
		SetBtnImg();
		SetStyle();
		SetCombo();
		Redraw();
	}
	
	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : �ܺ� �� ����
	Param  : 
	Return : 
	========================================================================================*/ 
	void OnTask(long nEvent, long nData)
	{
		char* szCashData;
		long nRet = 0;
	
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_IC_CARD )
			{
				//�ý�����
				szCashData = (char*)System_GetResult((char*)&nRet);
				
				//��� ����
				Rcv_CashData(szCashData);
			}
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
		
		if( POINTING_UP == nAction )
		{	
			if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+111) && Y < DMS_Y(STARTY+181)
			 || X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+181) && Y < DMS_Y(STARTY+251) )
			{	
				if( Get_iDlgCtrlByID(EDT_CUSTINFO) == lActiveIndex 
				 || Get_iDlgCtrlByID(EDT_AMT) == lActiveIndex )
				{
					g_Dlgflag = 0;
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA3), TRUE );
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
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
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
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA3), FALSE );
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
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
				}
			}
		}	
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{
		switch(ID)
		{
			// �ڷΰ���
			case BID_CLOSE:
				
				Card_Move("C6101_PayMenu");
				break;
			
			// ����
			case BID_APPRO:
				
				Snd_Cash_Mcpay();
				
				break;
			
			case BID_RAD_GUBUN_Y:
				
				m_lradgbn_flag = 1;
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N1);
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CUSTINFO ), "0100001234"); 
				
				break;
			
			case BID_RAD_GUBUN_N:
			
				m_lradgbn_flag = 2;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N2);
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CUSTINFO ), "");
				
				break;
		}
	}
	
	//---------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i = 0;
		
		for ( i = 0 ;  CASH_GBN[i].Str[0] != 0 ; i++)
		{
		    ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GUBUN+2), CASH_GBN[i].Str, 0, ICON_NONE);
		}	
	}

	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : TEXTBOX, EDITER, COMBOBOX UI SETTING
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		long i;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_RAD_GUBUN)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN)  	, EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUSTINFO)  	, EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_AMT)  		, EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GUBUN)  	, EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(LINE_DATA3)   , FALSE );
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
		DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
	}
	
	void Redraw(void)
	{
		char sztmp[300];
		long n = 0;
		
		// 0 = �ҵ����, 1 = ������������
		Str_Cpy(stCashinfo.szStatus_flag, "0");
						
		// �ŷ��� ����
		n = g_SearchCD( stCashinfo.szStatus_flag, CASH_GBN );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_GUBUN), CASH_GBN[n].Str);	
		
		// �����߱ݿ���
		if(m_lradgbn_flag == 0 || m_lradgbn_flag == 2 )
		{
			m_lradgbn_flag = 2;
			
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y1);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N2);
		}
		else
		{
			m_lradgbn_flag = 1;

			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y2);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N1);
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CUSTINFO ), "0100001234"); 					
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Cash_Mcpay
	��  �� : ���ݿ����� mcpay ����
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_Cash_Mcpay(void)
	{
		char sztmp[300];
		char szUrl[300];
		char szbuf[300];
		char* sndbuf;
		long ret = 0;
		long amt = 0;
		long vat = 0;
		long i;
		
		if(EditCtrl_GetStrLen( Get_hDlgCtrlByID( CMB_GUBUN )) == 0 )
		{
			MessageBoxEx (ERROR_OK, "�ŷ��� ������ Ȯ���ϼ���.");
			return;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_CUSTINFO)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "�ź� ��Ϲ�ȣ�� �Է����ּ���.");
			return;
		}
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		
		Str_Cpy(sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AMT)) );
		i = Str_AtoI(sztmp);

		if( i == 0 )
		{
			MessageBoxEx (ERROR_OK, "�ݾ��� Ȯ���ϼ���.");
			return;
		}
		
		if(MessageBoxEx (CONFIRM_YESNO, "���ݿ������� ��� �Ͻðڽ��ϱ�?") != MB_OK)
		{
			return;
		}
		
		Mem_Set((byte*)&stCashinfo, 0x00, sizeof(stCashinfo));
		
		// 3-1. Amt
		Mem_Set( (byte*) stCashinfo.szAmt, 0x00, sizeof(stCashinfo.szAmt)  );
		Str_Cpy( stCashinfo.szAmt, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AMT)) );
		
		// 3-2. Vat
		Mem_Set( (byte*) stCashinfo.szVat, 0x00, sizeof(stCashinfo.szVat)  );
		amt = Str_AtoI( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AMT)) );
		vat = amt*10/110;
		Str_ItoA(vat , stCashinfo.szVat, 10);
		
		// 3-5. Status_flag(�ŷ��ڱ���) : 0 = ����,1 = �����
		Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp)  );
		Mem_Set( (byte*) stCashinfo.szStatus_flag, 0x00, sizeof(stCashinfo.szStatus_flag)  );
		Str_Cpy(sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GUBUN )) );
		i = g_SearchStr(sztmp, CASH_GBN );
		if (i > -1)
		{
			Str_Cpy(stCashinfo.szStatus_flag, CASH_GBN[i].Code);
		}
		
		// 3-6. Cust_info
		Mem_Set( (byte*) stCashinfo.szCust_info, 0x00, sizeof(stCashinfo.szCust_info)  );
		Str_Cpy( stCashinfo.szCust_info, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_CUSTINFO )) );			
		
		// 3-7. Appro_sts
		Mem_Set( (byte*) stCashinfo.szAppro_sts, 0x00, sizeof(stCashinfo.szAppro_sts)  );
		Str_Cpy( stCashinfo.szAppro_sts, "1");
		
		// 3-8. Appro_ymd
		Mem_Set( (byte*) stCashinfo.szApproymd, 0x00, sizeof(stCashinfo.szApproymd)  );
		Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp)  );
		Str_ItoA( Time_GetDate(), sztmp, 10 );
		Str_Cpy(stCashinfo.szApproymd, sztmp+2);
		
		// 3-9. Treat_pda1, Treat_pda2, Treat_pda3
		fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda1, 1, Str_Len(stUserinfo.szpda_ip) );
		fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda2, 2, Str_Len(stUserinfo.szpda_ip) );
		fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda3, 3, Str_Len(stUserinfo.szpda_ip) );
			
		Snd_Cash_Hist(0);
	}
	
	
	/*=======================================================================================
	�Լ��� : Snd_Cash_Hist
	��  �� : ���ݿ����� mcpay �̷�����
	Param  : flag  0 = ���νõ�, 1 = ���οϷ�, 2 = ��ҽõ�, 3 = ��ҿϷ�
	Return : 
	========================================================================================*/
	void Snd_Cash_Hist(long flag)
	{
		char sztmp[128];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long amt = 0;
		long vat = 0;
		long i;
				
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66806, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd"         , stUserinfo.szcenter_cd          );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq", "999999999" );
		
		if(flag == 0)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "1" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , ""   );
		}
		else if(flag == 1)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "2" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , stCashinfo.szAppronum );
			JSON_SetValue( g_pjcomm, 'C', "resp_cd"            , stCashinfo.szResp_cd );
		}
		else if(flag == 2)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "3" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , ""   );
		}
		else if(flag == 3)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "4" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , stCashinfo.szAppronum );
			JSON_SetValue( g_pjcomm, 'C', "resp_cd"            , stCashinfo.szResp_cd );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stCashinfo.szApprodate );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num"        , "" );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"             , "" );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda1"        	  , stCashinfo.szTreat_pda1 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda2"        	  , stCashinfo.szTreat_pda2 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda3"        	  , stCashinfo.szTreat_pda3 );
		JSON_SetValue( g_pjcomm, 'C', "status_flag"       	  , stCashinfo.szStatus_flag);
		JSON_SetValue( g_pjcomm, 'C', "cust_info"         	  , stCashinfo.szCust_info  );
		JSON_SetValue( g_pjcomm, 'C', "amt"               	  , stCashinfo.szAmt        );
		JSON_SetValue( g_pjcomm, 'C', "appro_sts"         	  , stCashinfo.szAppro_sts  );
		JSON_SetValue( g_pjcomm, 'C', "cert_cd"           	  , stUserinfo.szcard_term_id2 );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		// ���� ��
		if(flag == 0 )
		{
			callBackfunc = TR66806_0;
		}
		// ��� ��
		else if(flag == 2)
		{
			callBackfunc = TR66806_1;
		}
		// ���
		else
		{
			callBackfunc = TR66806_2;
		}
		
		ret = HTTP_DownloadData(szUrl, "FR66806_IN",  "FR66806" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : TR66806_0
	��  �� : ���� �� �̷� ���� �� callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_0(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(66806) >= 0)
		{
			CloseMessageBox();
			Run_Mcpay(0);
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			Run_Mcpay(0);
			
			return -1;
		}
	}
	/*=======================================================================================
	�Լ��� : TR66806_1
	��  �� : ��� �� �̷� ���� �� callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_1(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(66806) >= 0)
		{
			CloseMessageBox();
			Run_Mcpay(1);
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			Run_Mcpay(1);
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : TR66806_2
	��  �� : ���� ��, ��� �� �̷� ���� �� callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_2(void)
	{
		g_Sock_Close();
		CloseMessageBox();	
		
		if( g_Chk_Json(66806) >= 0)
		{
			Card_Move("C6101_PayMenu");
			return 1;
		}
		else
		{
			Card_Move("C6101_PayMenu");
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_CashData
	��  �� : Rcv Mcpay Result Data 
	Param  : szCashData : OnTask �Լ��� ���� ���� ��� ������
	Return : 
	========================================================================================*/
	void Rcv_CashData(char* szCashData)
	{
		char szTmp[300];
		char szType[2] = {0,0};
		handle hItem = NULL;
		handle hData = NULL;
		long hist_rslt = 0;
		
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCashData );
			
			if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "null") == 0 )
			{
				Mem_Set( (byte*)stCashinfo.szResp_cd, 0x00, sizeof(stCashinfo.szResp_cd) );
				Str_Cpy( stCashinfo.szResp_cd, "0000" );
				
			    Mem_Set( (byte*)stCashinfo.szAppronum, 0x00, sizeof(stCashinfo.szAppronum) );
				Str_Cpy( stCashinfo.szAppronum, JSON_GetValue(hItem, "approvalno", szType) );
				 
				Mem_Set( (byte*)stCashinfo.szApprodate, 0x00, sizeof(stCashinfo.szApprodate) );
				Str_Cpy( stCashinfo.szApprodate, JSON_GetValue (hItem, "approvaldate", szType) );
				
				hist_rslt = 1;
			}
			else
			{	
				hist_rslt = 0;
				Card_Move("C6101_PayMenu");
			}
		}
		
		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
		
		g_Close_SubDlg();
		
		if( hist_rslt == 1 )
		{
			Snd_Cash_Hist(1);
		}
		else
		{
			Card_Move("C6101_PayMenu");
		}
		
		return;
	}
	
	void Rcv_CashData_test(void)
	{
		char szTmp[300];
		// ����ΰ��
		Mem_Set( (byte*)stCashinfo.szResp_cd, 0x00, sizeof(stCashinfo.szResp_cd) );
		Str_Cpy( stCashinfo.szResp_cd, "0000" );
		
		Mem_Set( (byte*)stCashinfo.szAppronum, 0x00, sizeof(stCashinfo.szAppronum) );
		Str_Cpy( stCashinfo.szAppronum, "99999" );
		
	    Snd_Cash_Hist(1);
		
	}
	
	/*=======================================================================================
	�Լ��� : Run_Mcpay
	��  �� : Mcpay Run
	Param  : flag : 0 = ����, 1 = ���
	Return : 
	========================================================================================*/
	void Run_Mcpay(long flag)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;
		char sztmp[50];
		char szDate[50];
		char receipt_YN[2];
		
		Mem_Set( (byte*)receipt_YN, 0x00, sizeof(receipt_YN) );
		// ������ �߱޹���
		if( MessageBoxEx (CONFIRM_YESNO, "���̿�������\n�����Ͻðڽ��ϱ�?")  == MB_OK)
		{						
			Str_Cpy(receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(receipt_YN, "N");		
		}
		
		PRINT("#### bussno #### : %s",stUserinfo.szbiz_regi_num,0,0);
		PRINT("#### totalprice #### : %s",stCashinfo.szAmt,0,0);
		PRINT("#### tax #### : %s",stCashinfo.szVat,0,0);
		PRINT("#### cashtradetype #### : %s",stCashinfo.szStatus_flag,0,0);
		PRINT("#### cashtradeinfo #### : %s",stCashinfo.szCust_info,0,0);
		PRINT("#### approvaldate #### : %s",stCashinfo.szApproymd,0,0);
		PRINT("#### approvalno #### : %s",stCashinfo.szAppronum,0,0);
		PRINT("#### vsno #### : %s",stUserinfo.szcard_term_id2,0,0);
		
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			if(flag == 0)
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "cashAppr");
				JSON_SetValue	(hdata	, 'C', "desc"				, "���ݰ���");
				JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "receiptyn"			, receipt_YN);
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stCashinfo.szAmt);
				JSON_SetValue	(hdata	, 'C', "tax"				, stCashinfo.szVat);
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");
				JSON_SetValue	(hdata	, 'C', "inst"				, "0");
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, "");
				JSON_SetValue	(hdata	, 'C', "approvalno"			, "");
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, stCashinfo.szStatus_flag);
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, stCashinfo.szCust_info);
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id2);
			}
			// ���ݿ����� ���
			else if(flag == 1)
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "cashVoid");
				JSON_SetValue	(hdata	, 'C', "desc"				, "�������");
				JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "receiptyn"			, receipt_YN);
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stCashinfo.szAmt);
				JSON_SetValue	(hdata	, 'C', "tax"				, stCashinfo.szVat);
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");
				JSON_SetValue	(hdata	, 'C', "inst"				, "0");
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, stCashinfo.szApproymd);	
				JSON_SetValue	(hdata	, 'C', "approvalno"			, stCashinfo.szAppronum);
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, stCashinfo.szStatus_flag);
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, stCashinfo.szCust_info);
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "1");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id2);
			}

			JSON_SetValue	(h		, 'C', "method"				, "IC_CardPay");
			
			JSON_Attach 	(h		, "data"					, hdata);
			
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hdata)
		{
			JSON_Finalize(hdata);
		}	
		
		//Rcv_CashData_test();
		
		return;
	}
	
	void fsgetitem(char* szSource, char* szTarget, int id, int len )
	{
	int i;
	int idx;
	int ids;
	
		idx =0;
		ids =1;
		for(i=0; i<len; i++)
		{
			if(szSource[i] == '-')
			{
				if(ids == id )
				{
					szTarget[idx] = 0x00;
					break;
				}
				idx = 0;
				ids++;
				continue;
			}
			if(ids == id )
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}

}

